Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1DC636292
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiKWO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiKWO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C485DF17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CBE61D56
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B993C43470;
        Wed, 23 Nov 2022 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215492;
        bh=riz4FuhsBhjUoUmsJfNCnyk/9pFendJtQjvdaN2u9Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bekf9bIUKmdi7KZ1BCWC2+7BGc4FJ7zP0ammSH49Dbv1YdqgwU0/v17wQ+rSJK2iR
         O83DlXdOD5F3AF0G3smb26BtEpA7DO0ugMfNdtqRNHtpGuHHNbP5qQaF7vP2josDGJ
         fjJovHi77FoC02mDY2REFyXBN5iI7X+nF3AXron7jmtDpcE1Ah53hfViybKvoebwt0
         jiFAQn5whPRyMKEQAxKcoApgGAfxYoGRH5figsv7F0NEv8rY52Zbw5HjgsJz33N71K
         EXpub/wpeq3pkxAk7LM++pYoQ0j925eI0MyNj3LVveTCZDAOIfZHlBQsyw9nenFKmh
         q9oHsqW8LY6wA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 5/8] habanalabs: clear non-released encapsulated signals
Date:   Wed, 23 Nov 2022 16:57:58 +0200
Message-Id: <20221123145801.542029-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123145801.542029-1-ogabbay@kernel.org>
References: <20221123145801.542029-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Reserved encapsulated signals which were not released hold the context
refcount, leading to a failure when killing the user process on device
reset or device fini.
Add the release of these left signals in the CS roll-back process.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 46 ++++++++++++----
 drivers/misc/habanalabs/common/context.c      | 53 +++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h   |  3 +-
 3 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f1c69c8ed74a..ea0e5101c10e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -742,13 +742,11 @@ static void cs_do_release(struct kref *ref)
 		 */
 		if (hl_cs_cmpl->encaps_signals)
 			kref_put(&hl_cs_cmpl->encaps_sig_hdl->refcount,
-						hl_encaps_handle_do_release);
+					hl_encaps_release_handle_and_put_ctx);
 	}
 
-	if ((cs->type == CS_TYPE_WAIT || cs->type == CS_TYPE_COLLECTIVE_WAIT)
-			&& cs->encaps_signals)
-		kref_put(&cs->encaps_sig_hdl->refcount,
-					hl_encaps_handle_do_release);
+	if ((cs->type == CS_TYPE_WAIT || cs->type == CS_TYPE_COLLECTIVE_WAIT) && cs->encaps_signals)
+		kref_put(&cs->encaps_sig_hdl->refcount, hl_encaps_release_handle_and_put_ctx);
 
 out:
 	/* Must be called before hl_ctx_put because inside we use ctx to get
@@ -1011,6 +1009,34 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 		hl_complete_job(hdev, job);
 }
 
+/*
+ * release_reserved_encaps_signals() - release reserved encapsulated signals.
+ * @hdev: pointer to habanalabs device structure
+ *
+ * Release reserved encapsulated signals which weren't un-reserved, or for which a CS with
+ * encapsulated signals wasn't submitted and thus weren't released as part of CS roll-back.
+ * For these signals need also to put the refcount of the H/W SOB which was taken at the
+ * reservation.
+ */
+static void release_reserved_encaps_signals(struct hl_device *hdev)
+{
+	struct hl_ctx *ctx = hl_get_compute_ctx(hdev);
+	struct hl_cs_encaps_sig_handle *handle;
+	struct hl_encaps_signals_mgr *mgr;
+	u32 id;
+
+	if (!ctx)
+		return;
+
+	mgr = &ctx->sig_mgr;
+
+	idr_for_each_entry(&mgr->handles, handle, id)
+		if (handle->cs_seq == ULLONG_MAX)
+			kref_put(&handle->refcount, hl_encaps_release_handle_and_put_sob_ctx);
+
+	hl_ctx_put(ctx);
+}
+
 void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
 {
 	int i;
@@ -1039,6 +1065,8 @@ void hl_cs_rollback_all(struct hl_device *hdev, bool skip_wq_flush)
 	}
 
 	force_complete_multi_cs(hdev);
+
+	release_reserved_encaps_signals(hdev);
 }
 
 static void
@@ -2001,6 +2029,8 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	 */
 	handle->pre_sob_val = prop->next_sob_val - handle->count;
 
+	handle->cs_seq = ULLONG_MAX;
+
 	*signals_count = prop->next_sob_val;
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
@@ -2350,10 +2380,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	/* We finished with the CS in this function, so put the ref */
 	cs_put(cs);
 free_cs_chunk_array:
-	if (!wait_cs_submitted && cs_encaps_signals && handle_found &&
-							is_wait_cs)
-		kref_put(&encaps_sig_hdl->refcount,
-				hl_encaps_handle_do_release);
+	if (!wait_cs_submitted && cs_encaps_signals && handle_found && is_wait_cs)
+		kref_put(&encaps_sig_hdl->refcount, hl_encaps_release_handle_and_put_ctx);
 	kfree(cs_chunk_array);
 out:
 	return rc;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index ba6675960203..9c8b1b37b510 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -9,37 +9,46 @@
 
 #include <linux/slab.h>
 
-void hl_encaps_handle_do_release(struct kref *ref)
+static void encaps_handle_do_release(struct hl_cs_encaps_sig_handle *handle, bool put_hw_sob,
+					bool put_ctx)
 {
-	struct hl_cs_encaps_sig_handle *handle =
-		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
 	struct hl_encaps_signals_mgr *mgr = &handle->ctx->sig_mgr;
 
+	if (put_hw_sob)
+		hw_sob_put(handle->hw_sob);
+
 	spin_lock(&mgr->lock);
 	idr_remove(&mgr->handles, handle->id);
 	spin_unlock(&mgr->lock);
 
-	hl_ctx_put(handle->ctx);
+	if (put_ctx)
+		hl_ctx_put(handle->ctx);
+
 	kfree(handle);
 }
 
-static void hl_encaps_handle_do_release_sob(struct kref *ref)
+void hl_encaps_release_handle_and_put_ctx(struct kref *ref)
 {
 	struct hl_cs_encaps_sig_handle *handle =
-		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
-	struct hl_encaps_signals_mgr *mgr = &handle->ctx->sig_mgr;
+			container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
 
-	/* if we're here, then there was a signals reservation but cs with
-	 * encaps signals wasn't submitted, so need to put refcount
-	 * to hw_sob taken at the reservation.
-	 */
-	hw_sob_put(handle->hw_sob);
+	encaps_handle_do_release(handle, false, true);
+}
 
-	spin_lock(&mgr->lock);
-	idr_remove(&mgr->handles, handle->id);
-	spin_unlock(&mgr->lock);
+static void hl_encaps_release_handle_and_put_sob(struct kref *ref)
+{
+	struct hl_cs_encaps_sig_handle *handle =
+			container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
 
-	kfree(handle);
+	encaps_handle_do_release(handle, true, false);
+}
+
+void hl_encaps_release_handle_and_put_sob_ctx(struct kref *ref)
+{
+	struct hl_cs_encaps_sig_handle *handle =
+			container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
+
+	encaps_handle_do_release(handle, true, true);
 }
 
 static void hl_encaps_sig_mgr_init(struct hl_encaps_signals_mgr *mgr)
@@ -48,8 +57,7 @@ static void hl_encaps_sig_mgr_init(struct hl_encaps_signals_mgr *mgr)
 	idr_init(&mgr->handles);
 }
 
-static void hl_encaps_sig_mgr_fini(struct hl_device *hdev,
-			struct hl_encaps_signals_mgr *mgr)
+static void hl_encaps_sig_mgr_fini(struct hl_device *hdev, struct hl_encaps_signals_mgr *mgr)
 {
 	struct hl_cs_encaps_sig_handle *handle;
 	struct idr *idp;
@@ -57,11 +65,14 @@ static void hl_encaps_sig_mgr_fini(struct hl_device *hdev,
 
 	idp = &mgr->handles;
 
+	/* The IDR is expected to be empty at this stage, because any left signal should have been
+	 * released as part of CS roll-back.
+	 */
 	if (!idr_is_empty(idp)) {
-		dev_warn(hdev->dev, "device released while some encaps signals handles are still allocated\n");
+		dev_warn(hdev->dev,
+			"device released while some encaps signals handles are still allocated\n");
 		idr_for_each_entry(idp, handle, id)
-			kref_put(&handle->refcount,
-					hl_encaps_handle_do_release_sob);
+			kref_put(&handle->refcount, hl_encaps_release_handle_and_put_sob);
 	}
 
 	idr_destroy(&mgr->handles);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0329a0980bb7..e2527d976ee0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3775,7 +3775,8 @@ void hl_sysfs_add_dev_vrm_attr(struct hl_device *hdev, struct attribute_group *d
 
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
-void hl_encaps_handle_do_release(struct kref *ref);
+void hl_encaps_release_handle_and_put_ctx(struct kref *ref);
+void hl_encaps_release_handle_and_put_sob_ctx(struct kref *ref);
 void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
 			struct hl_cs *cs, struct hl_cs_job *job,
 			struct hl_cs_compl *cs_cmpl);
-- 
2.25.1

