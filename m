Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711D96F6814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjEDJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEDJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E740C6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2998B33932;
        Thu,  4 May 2023 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJg6fOVMJfQiPdvfQeCkj1a2vcDOvIJAvZO16+3IyrU=;
        b=Pr9hQVSZbxMqN2Kj/HQTRlKJ3TopK+kfGC9pt5fNTVIM+yUvM7ZlLRVz78SUbE8QnKM6Oi
        N5cLwrhWIPR0Bs2XxgIwZheqHiBld+msx3KjgLs2HrGOGvrYq7AIoA6cJ6sVZNlwLDETiO
        2vpmAylR/hBQ0BmZCnuWIqt/CoAqfDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJg6fOVMJfQiPdvfQeCkj1a2vcDOvIJAvZO16+3IyrU=;
        b=QkTpdXmjR+kILeHfcRC22Wutk/+VTUuDQ0PmFc/leZgtuO7IOqIXuW8E9yEzq1ZayC/zHA
        WpjCqKNrljDvCHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B4C013444;
        Thu,  4 May 2023 09:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1UuoBiF3U2TcTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:05 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 3/9] nvme-tcp: move error and connect work to nvme_ctrl
Date:   Thu,  4 May 2023 11:12:53 +0200
Message-Id: <20230504091259.29100-4-dwagner@suse.de>
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

Move common data structures for fabrics to nvme_ctrl so that we are able
to use them in fabrcis.c later.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/tcp.c  | 24 ++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..5aa30b00dd17 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,9 @@ struct nvme_ctrl {
 	struct work_struct ana_work;
 #endif
 
+	struct work_struct	err_work;
+	struct delayed_work	connect_work;
+
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
 	struct mutex dhchap_auth_mutex;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 273c1f2760a4..74ccc84d244a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -166,8 +166,6 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
-	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -527,7 +525,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -2025,7 +2023,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 	if (nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
@@ -2107,9 +2105,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
-			struct nvme_tcp_ctrl, connect_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
 
 	++ctrl->nr_reconnects;
 
@@ -2131,9 +2128,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
-				struct nvme_tcp_ctrl, err_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
@@ -2194,8 +2190,8 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	flush_work(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+	flush_work(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
@@ -2581,9 +2577,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->connect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.40.0

