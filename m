Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED01714424
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjE2GST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjE2GSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:18:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FFF3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:17:48 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3WC0q1f0vZvWO3WC0qfklE; Mon, 29 May 2023 08:17:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685341042;
        bh=LMsxEc3jzv9WRfxtgBWJr+2up3zRX/dSTarm2zC7inQ=;
        h=From:To:Cc:Subject:Date;
        b=gi6/9Y3BHoprXzB1QmpY0l7JSneYVDhaJtKS42KT08OOYih3CNQZe2o+xGWLGGQ2P
         IPizhyvuUSVqgUfgccbqmgypYzMDED6uDiO+Fjk4/bwv86QtekVzH62640Gzqf4Wjb
         sTqcTCXDneuOqmYJYJJy2hKGfV5w6Y+xHJBetUzkN4Jp0mVLH8HuQQvSioZdQ1X9hA
         k+cyRePBjlmwiobd5KDUWdqgdOGZ6ItqpNdoFvtEiRP+C8aOIdTek0LoL81tdjB/Dh
         ssOZLKRDkpfqIndPScmjh67ONpCxVdqNP1C0WwmXqq5X9DhRrGthC+eB+BbDuAWPYt
         n+04tTi8+jGsQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 08:17:22 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
Date:   Mon, 29 May 2023 08:17:18 +0200
Message-Id: <2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fwnode is known to be NULL, at this point, so fwnode_handle_put() is a
no-op.

Release the reference taken from a previous fwnode_graph_get_port_parent()
call instead.

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\  THIS PATCH IS SPECULATIVE  /!\
         review with care
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 049c2f2001ea..b7dd467c53fd 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -571,7 +571,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 
 	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
 	if (!fwnode) {
-		fwnode_handle_put(fwnode);
+		fwnode_handle_put(link->local_node);
 		return -ENOLINK;
 	}
 
-- 
2.34.1

