Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B16736D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjFTNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjFTNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:37:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A81BB;
        Tue, 20 Jun 2023 06:37:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E005C1F88F;
        Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687268241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W2dcMlco4IaX1eYG+QaSwRA5SCo5zMhvqpPQKpXYteE=;
        b=G3zNI7xIRS4BGhdLruB4zto97XoVHG4t1yJ94Ic72x1llG3iXjlJNYS1Cl4P64FTeOnkP1
        ba5PtHYsZL+o2My5IJ0xUsCq06E81go5qx4vB+HiRl3KDWxi/aCBIejWBHTgMX8l/y/z/N
        kj1SzfeYkb5jqFLobujjdCNlQbr5DIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687268241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W2dcMlco4IaX1eYG+QaSwRA5SCo5zMhvqpPQKpXYteE=;
        b=QPyaU8DDuLSEf3IezpMohcmGhrB/Vqfa3ck8yQeA3TXeuhIkkmZazyA9Gu3LGLPS6nhgEj
        PQq9qfg1vqVl2dDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1FC8133A9;
        Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GA0+M5GrkWTKPQAAMHmgww
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
Subject: [PATCH v2 5/5] nvme-fc: do no free ctrl opts
Date:   Tue, 20 Jun 2023 15:37:11 +0200
Message-ID: <20230620133711.22840-6-dwagner@suse.de>
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

Since the initial additional of the FC transport
e399441de911 ("nvme-fabrics: Add host support for FC transport"), the
transport also freed the options. Since nvme_free_ctrl() is freeing the
options too commit de41447aac03 ("nvme-fc: avoid memory corruption
caused by calling nvmf_free_options() twice") was added to avoid double
frees.

With the change to make the initial connection attempt synchronous
again, the life time of all object is known also in the error case. All
resources will be freed in the same context.

The FC transport should not free the options as the generic auth code is
relying to be able to read the options even in the shutdown path (see
nvme_auth_free is calling ctrl_max_dhchaps which relies on opts being a
valid pointer).

TCP and RDMA also avoid freeing the options, so make the FC transport
behave the same.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa2911f07c6c..6f5cfa47fee5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2413,8 +2413,6 @@ nvme_fc_ctrl_free(struct kref *ref)
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	if (ctrl->ctrl.opts)
-		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
 
@@ -3568,8 +3566,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
-- 
2.41.0

