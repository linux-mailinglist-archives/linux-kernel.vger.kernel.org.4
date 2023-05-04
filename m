Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D66F6813
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjEDJNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjEDJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328483ABB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9125E209AC;
        Thu,  4 May 2023 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouaTATkWNixyD5d3su+1xUw5y9Ym8ke7nX0uHaKZbUg=;
        b=lfPbEvfUwuVA73OXON1Y3/CaMNOfQEYaN5z9Ofcg0pBr2tCcLTpl5MzIxGuhU12MNFpYzh
        xL4eudbc8J5zY8e7wm93dJLtdojTazAKTyDf1siXPyf2r2OEYAbIA3uCIVfUvd482/Ys0x
        r82wRFeaSiaXFwh2agTkJ5RkeaH3df0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouaTATkWNixyD5d3su+1xUw5y9Ym8ke7nX0uHaKZbUg=;
        b=Bf3gHwkKJIj1Xi3QkNnUxG7kM+ITdAVO2udEz1R/u5EMBeVCRc0kPXhOyElYn3CHARbBdO
        O+1XjbxY0cK6qXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82CAE13444;
        Thu,  4 May 2023 09:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AlzpHyB3U2TaTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:04 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 2/9] nvme-rdma: factor rdma specific queue init code out
Date:   Thu,  4 May 2023 11:12:52 +0200
Message-Id: <20230504091259.29100-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504091259.29100-1-dwagner@suse.de>
References: <20230504091259.29100-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to move common code from the fabrics driver to fabrics.c,
move the rmda queue specific initialization code into a separate
function.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 65 ++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92e5d0ccf3a9..a78c66278b19 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -826,15 +826,16 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool new)
+static int nvme_rdma_init_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
-	if (error)
-		return error;
+	if (qid != 0)
+		/* only admin queue needs additional work. */
+		return 0;
+
 
 	ctrl->device = ctrl->queues[0].device;
 	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
@@ -854,6 +855,43 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	 */
 	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
+	if (error)
+		return error;
+
+	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
+	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
+	if (pi_capable)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
+	else
+		ctrl->ctrl.max_integrity_segments = 0;
+
+	return 0;
+}
+
+static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	if (qid != 0)
+		return;
+
+	if (ctrl->async_event_sqe.data) {
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
+}
+
+static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
+		bool new)
+{
+	int error;
+
+	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
+	if (error)
+		return error;
+
+	error = nvme_rdma_init_queue(&ctrl->ctrl, 0);
 	if (error)
 		goto out_free_queue;
 
@@ -863,7 +901,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 				sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE);
 		if (error)
-			goto out_free_async_qe;
+			goto out_deinit_admin_queue;
 
 	}
 
@@ -875,13 +913,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_stop_queue;
 
-	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
-	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
-	if (pi_capable)
-		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
-	else
-		ctrl->ctrl.max_integrity_segments = 0;
-
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
@@ -899,12 +930,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_remove_admin_tag_set:
 	if (new)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
-out_free_async_qe:
-	if (ctrl->async_event_sqe.data) {
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
-		ctrl->async_event_sqe.data = NULL;
-	}
+out_deinit_admin_queue:
+	nvme_rdma_deinit_queue(&ctrl->ctrl, 0);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 	return error;
-- 
2.40.0

