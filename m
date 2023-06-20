Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411A736D75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjFTNhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFTNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:37:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD161BB;
        Tue, 20 Jun 2023 06:37:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BADD1F86B;
        Tue, 20 Jun 2023 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687268239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpmAWsOWkVyLjoeN9ZUYCoZ3apyl+Ncz6xO/8B0ViJc=;
        b=Y3wMKyZ+3CXx5qZJo6c2f2fefVkG8IiP6Cnj0amWnLcyYlY8mZMHXfdb/Hv69YDIfat+8W
        bbt+byqEZprBPDo+NHRbGDxKBNEcmg+7EX89plbz7JBra1vTHqeKNEjNYk2ytbNERFWcIQ
        Ag4TnJy+Bj8Hi1aKNKVKoehr/0cSItY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687268239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpmAWsOWkVyLjoeN9ZUYCoZ3apyl+Ncz6xO/8B0ViJc=;
        b=8Kb8nOBPLR9HatRgwT6hlZ51FhKcOO26NJrRN8EHhBsJKKBrrscZFKPrtN2BiQ1k8k/D1E
        TE3mc70zWN+mlmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D27A133A9;
        Tue, 20 Jun 2023 13:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HarbDo+rkWS9PQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:37:19 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/5] nvme-fc: Do not wait in vain when unloading module
Date:   Tue, 20 Jun 2023 15:37:07 +0200
Message-ID: <20230620133711.22840-2-dwagner@suse.de>
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

The module unload code will wait for a controller to be delete even when
there is no controller and we wait for completion forever to happen.
Thus only wait for the completion when there is a controller which
needs to be removed.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2ed75923507d..472ed285fd45 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3932,10 +3932,11 @@ static int __init nvme_fc_init_module(void)
 	return ret;
 }
 
-static void
+static bool
 nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 {
 	struct nvme_fc_ctrl *ctrl;
+	bool cleanup = false;
 
 	spin_lock(&rport->lock);
 	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
@@ -3943,21 +3944,28 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
 		nvme_delete_ctrl(&ctrl->ctrl);
+		cleanup = true;
 	}
 	spin_unlock(&rport->lock);
+
+	return cleanup;
 }
 
-static void
+static bool
 nvme_fc_cleanup_for_unload(void)
 {
 	struct nvme_fc_lport *lport;
 	struct nvme_fc_rport *rport;
+	bool cleanup = false;
 
 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
-			nvme_fc_delete_controllers(rport);
+			if (nvme_fc_delete_controllers(rport))
+				cleanup = true;
 		}
 	}
+
+	return cleanup;
 }
 
 static void __exit nvme_fc_exit_module(void)
@@ -3967,10 +3975,8 @@ static void __exit nvme_fc_exit_module(void)
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	nvme_fc_waiting_to_unload = true;
-	if (!list_empty(&nvme_fc_lport_list)) {
-		need_cleanup = true;
-		nvme_fc_cleanup_for_unload();
-	}
+	if (!list_empty(&nvme_fc_lport_list))
+		need_cleanup = nvme_fc_cleanup_for_unload();
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 	if (need_cleanup) {
 		pr_info("%s: waiting for ctlr deletes\n", __func__);
-- 
2.41.0

