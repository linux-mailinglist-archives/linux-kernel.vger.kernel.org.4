Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F25736D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjFTNhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjFTNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:37:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902C10F9;
        Tue, 20 Jun 2023 06:37:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FEA71F88C;
        Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687268241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjqQt4D7bz3ycKlBkDP6byX+9ncqyQX2u0PfjF3kOqU=;
        b=bZPMqWQ/ZKEK1kFvUpeCocMqDCRGCEMfHUdlXWEljoX0XBPPiQTfZHTu7rI0SC1/EBEwj2
        gN9CVEVtyIRqEoyUl4nGMsJqksYol1ZWE3vIuYLKVruYDL7x6TIH1+H5/aB0LHvGU/e9g+
        8vvMP9014ek2uQBX14/TzdsvHJzNJdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687268241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjqQt4D7bz3ycKlBkDP6byX+9ncqyQX2u0PfjF3kOqU=;
        b=ZdB051TkUH69jvTTCVTUawhCT/PK5HHoGCsBhqqe/FbwrYRR/hnE9PslGO38owzEBC8IYF
        NDHs8foTLRHjZ3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 308AB133A9;
        Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fnPKC5GrkWTGPQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:37:21 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Date:   Tue, 20 Jun 2023 15:37:10 +0200
Message-ID: <20230620133711.22840-5-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620133711.22840-1-dwagner@suse.de>
References: <20230620133711.22840-1-dwagner@suse.de>
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

Commit 4c984154efa1 ("nvme-fc: change controllers first connect to use
reconnect path") made the connection attempt asynchronous in order to
make the connection attempt from autoconnect/boot via udev/systemd up
case a bit more reliable.

Unfortunately, one side effect of this is that any wrong parameters
provided from userspace will not be directly reported as invalid, e.g.
auth keys.

So instead having the policy code inside the kernel it's better to
address this in userspace, for example in nvme-cli or nvme-stas.

This aligns the fc transport with tcp and rdma.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 472ed285fd45..aa2911f07c6c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	/* force put free routine to ignore io queues */
 	ctrl->ctrl.tagset = NULL;
 
+	if (ret > 0)
+		ret = -EIO;
 	return ret;
 }
 
@@ -3545,21 +3547,15 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
 	}
 
-	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
-		dev_err(ctrl->ctrl.device,
-			"NVME-FC{%d}: failed to schedule initial connect\n",
-			ctrl->cnum);
+	ret = nvme_fc_create_association(ctrl);
+	if (ret)
 		goto fail_ctrl;
-	}
-
-	flush_delayed_work(&ctrl->connect_work);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
@@ -3568,7 +3564,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return &ctrl->ctrl;
 
 fail_ctrl:
-	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
@@ -3590,7 +3585,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	 */
 	nvme_fc_rport_get(rport);
 
-	return ERR_PTR(-EIO);
+	if (ret > 0)
+		ret = -EIO;
+	return ERR_PTR(ret);
 
 out_free_queues:
 	kfree(ctrl->queues);
-- 
2.41.0

