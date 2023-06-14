Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3D73075A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjFNSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:31:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99022125
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:31:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 9VGsqBvw5uHEf9VGtqP6SV; Wed, 14 Jun 2023 20:31:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686767468;
        bh=reNbQlvt6iwnJUAjcJkxGRJU4vzmBikzkd2pe0kBB0M=;
        h=From:To:Cc:Subject:Date;
        b=mQgaw/wMo3xhmP22Js9wU/i1RrWxxozS6T6PLcb3um4wW0aVihOiiRViAdIjQkeK2
         GC5PYs8tcrQdD5kbmW0JlRUKSMi11pr59L3/C4dbfIhz0YYCvb1IX7pRvoA2XhTEFJ
         jhkIyDEVD8749HDeD3z1r9BlOF3zrPmoE30TA7JtQG3bH7/+QxGQurB1Ys/gjZIDhG
         diF2/2Jj+nlkGLNpkqjdty+bTWd8+53LKlrQlyoDMbJExn67WyXanFf1Vhxto9V/Ae
         R8w9Fq9diwxUW1ilUH684bOBvmT8xLtIrW4Hpy1CaLYfZyQrrTz+LCNwBF78b/wLgq
         IJENaW26ufWRA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Jun 2023 20:31:08 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH v2] media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
Date:   Wed, 14 Jun 2023 20:31:05 +0200
Message-Id: <773118ad2c2b56f136e10466997eaaa911e6a422.1686767431.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fwnode_graph_get_remote_endpoint() fails, 'fwnode' is known to be NULL,
so fwnode_handle_put() is a no-op.

Release the reference taken from a previous fwnode_graph_get_port_parent()
call instead.

Also handle fwnode_graph_get_port_parent() failures.

In order to fix these issues, add an error handling path to the function
and the needed gotos.

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: - Handle fwnode_graph_get_port_parent() errors   [Sakari Ailus <sakari.ailus@linux.intel.com>]
    - Rephrase the commit log

v1: https://lore.kernel.org/all/2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr/
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 049c2f2001ea..4fa9225aa3d9 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -568,19 +568,29 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 	link->local_id = fwep.id;
 	link->local_port = fwep.port;
 	link->local_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->local_node)
+		return -ENOLINK;
 
 	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
-	if (!fwnode) {
-		fwnode_handle_put(fwnode);
-		return -ENOLINK;
-	}
+	if (!fwnode)
+		goto err_put_local_node;
 
 	fwnode_graph_parse_endpoint(fwnode, &fwep);
 	link->remote_id = fwep.id;
 	link->remote_port = fwep.port;
 	link->remote_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->remote_node)
+		goto err_put_remote_endpoint;
 
 	return 0;
+
+err_put_remote_endpoint:
+	fwnode_handle_put(fwnode);
+
+err_put_local_node:
+	fwnode_handle_put(link->local_node);
+
+	return -ENOLINK;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);
 
-- 
2.34.1

