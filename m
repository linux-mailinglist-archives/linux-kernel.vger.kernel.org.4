Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA226E51F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDQUlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:41:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34733C3F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:41:17 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oVf0plYozzvWyoVf0pNzt5; Mon, 17 Apr 2023 22:41:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681764076;
        bh=uY8LBeth5vJNi2Lzp3GMfyHfSkopsbeWtmhmmgyT3GM=;
        h=From:To:Cc:Subject:Date;
        b=bgyBqcn/j2enXfq0We5FO0LJwl3YbpRpB8UKfmiOxo89kCIl5sFQm+wFEZWYILNL/
         WgtA20N8NCK7UXc6DFOug/ah6STLYj/UyNbSBtmF4Yokc+9LFBvGnpJRmdtIsQR2iT
         I79Sf7tyOJFUFFeru2VRetn1o1dBzwBSYfjU1Q6Lbnnb9MWZhKTgPhVuWnEAEPs/tM
         4QkVX7bJdKpow3y9Rz5iv8P1mJoR8bYNl5jjsB73GxO1ojLCm+TuEjRTw8YrkBTlPk
         QKvES/I5i+kRUTYbIMCFFKX+x+zUlfFyS1YOhxHAzuq6pq1btq094g5YnaEPrqyNZo
         O3LljMigC2TjQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 22:41:16 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: remove some dead code
Date:   Mon, 17 Apr 2023 22:41:13 +0200
Message-Id: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'status' is known to be 0 at the point.
And nvmet_auth_challenge() return a -E<ERROR_CODE> or 0.
So these lines of code should just be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The dead code became obvious after commit be2ada6d0ed0 ("nvmet-auth: fix
return value check in auth receive")
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 7970a7640e58..038032e46145 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -483,15 +483,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 			status = NVME_SC_INTERNAL;
 			break;
 		}
-		if (status) {
-			req->sq->dhchap_status = status;
-			nvmet_auth_failure1(req, d, al);
-			pr_warn("ctrl %d qid %d: challenge status (%x)\n",
-				ctrl->cntlid, req->sq->qid,
-				req->sq->dhchap_status);
-			status = 0;
-			break;
-		}
 		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
-- 
2.34.1

