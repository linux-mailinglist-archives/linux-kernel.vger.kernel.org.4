Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D366B02A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjAOJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjAOJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:40:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D92C169
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:40:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD3460C6E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 09:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D87C433EF;
        Sun, 15 Jan 2023 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673775634;
        bh=Nvjr6ht73d9UvznjCsAwrLTV/0bf5Qk0URBK/c+wNt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBTb7mcDDkDYs4Erse5D/IKros8M/Fa298PX+kr81PIeBFWxzTiHUiNo2enKFslVu
         k4suMzyukYz0PG6H5xw3C/nO6+YQ8BvVKo5cWt0d5mquvrO5LIgnFJrC0RIyza3qdf
         NjzFMpYbsFdvQTMweQ0+Ua1vo3FdRGLG7tE/g/fws0vw7AOgAp2vju1jaLfZmk+Qds
         tteRQ99TsqwT3GM9QzvWpJUpnUZ3n2ce1z5TPzcrj3a/XCeo+fkdf4/FuLwHqDHYvv
         j7ABf31+rxBotNAurEuwgPuSZETjdSE0CI4K38zfqAIRNCW86/psJRqgZE4XGnlheV
         W2xbZuFb6Z9YQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/5] habanalabs: fix bug in timestamps registration code
Date:   Sun, 15 Jan 2023 11:40:24 +0200
Message-Id: <20230115094026.289766-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115094026.289766-1-ogabbay@kernel.org>
References: <20230115094026.289766-1-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

Protect re-using the same timestamp buffer record before actually
adding it to the to interrupt wait list.
Mark ts buff offset as in use in the spinlock protection area of the
interrupt wait list to avoid getting in the re-use section in
ts_buff_get_kernel_ts_record before adding the node to the list.
this scenario might happen when multiple threads are racing on
same offset and one thread could set data in the ts buff in
ts_buff_get_kernel_ts_record then the other thread takes over
and get to ts_buff_get_kernel_ts_record and we will try
to re-use the same ts buff offset then we will try to
delete a non existing node from the list.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index c54f504383ac..00fedf2d8654 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -3180,19 +3180,18 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 			goto start_over;
 		}
 	} else {
+		/* Fill up the new registration node info */
+		requested_offset_record->ts_reg_info.buf = buf;
+		requested_offset_record->ts_reg_info.cq_cb = cq_cb;
+		requested_offset_record->ts_reg_info.timestamp_kernel_addr =
+				(u64 *) ts_buff->user_buff_address + ts_offset;
+		requested_offset_record->cq_kernel_addr =
+				(u64 *) cq_cb->kernel_address + cq_offset;
+		requested_offset_record->cq_target_value = target_value;
+
 		spin_unlock_irqrestore(wait_list_lock, flags);
 	}
 
-	/* Fill up the new registration node info */
-	requested_offset_record->ts_reg_info.in_use = 1;
-	requested_offset_record->ts_reg_info.buf = buf;
-	requested_offset_record->ts_reg_info.cq_cb = cq_cb;
-	requested_offset_record->ts_reg_info.timestamp_kernel_addr =
-			(u64 *) ts_buff->user_buff_address + ts_offset;
-	requested_offset_record->cq_kernel_addr =
-			(u64 *) cq_cb->kernel_address + cq_offset;
-	requested_offset_record->cq_target_value = target_value;
-
 	*pend = requested_offset_record;
 
 	dev_dbg(buf->mmg->dev, "Found available node in TS kernel CB %p\n",
@@ -3240,7 +3239,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 			goto put_cq_cb;
 		}
 
-		/* Find first available record */
+		/* get ts buffer record */
 		rc = ts_buff_get_kernel_ts_record(buf, cq_cb, ts_offset,
 						cq_counters_offset, target_value,
 						&interrupt->wait_list_lock, &pend);
@@ -3288,7 +3287,19 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * Note that we cannot have sorted list by target value,
 	 * in order to shorten the list pass loop, since
 	 * same list could have nodes for different cq counter handle.
+	 * Note:
+	 * Mark ts buff offset as in use here in the spinlock protection area
+	 * to avoid getting in the re-use section in ts_buff_get_kernel_ts_record
+	 * before adding the node to the list. this scenario might happen when
+	 * multiple threads are racing on same offset and one thread could
+	 * set the ts buff in ts_buff_get_kernel_ts_record then the other thread
+	 * takes over and get to ts_buff_get_kernel_ts_record and then we will try
+	 * to re-use the same ts buff offset, and will try to delete a non existing
+	 * node from the list.
 	 */
+	if (register_ts_record)
+		pend->ts_reg_info.in_use = 1;
+
 	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
-- 
2.25.1

