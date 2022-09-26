Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678EE5E97B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiIZB0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiIZB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:26:45 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EFA28701
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:26:42 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id UAA00139;
        Mon, 26 Sep 2022 09:26:39 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.12; Mon, 26 Sep 2022 09:26:38 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] dax: Remove usage of the deprecated ida_simple_xxx API
Date:   Sun, 25 Sep 2022 21:26:35 -0400
Message-ID: <20220926012635.3205-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20229260926398113c515f49a2a58b7974007982becac
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc_xxx()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/dax/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 9b5e2a5eb0ae..da4438f3188c 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -363,7 +363,7 @@ static void dax_free_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
 	if (inode->i_rdev)
-		ida_simple_remove(&dax_minor_ida, iminor(inode));
+		ida_free(&dax_minor_ida, iminor(inode));
 	kmem_cache_free(dax_cache, dax_dev);
 }
 
@@ -445,7 +445,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
 		return ERR_PTR(-EINVAL);
 
-	minor = ida_simple_get(&dax_minor_ida, 0, MINORMASK+1, GFP_KERNEL);
+	minor = ida_alloc_max(&dax_minor_ida, MINORMASK, GFP_KERNEL);
 	if (minor < 0)
 		return ERR_PTR(-ENOMEM);
 
@@ -459,7 +459,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 	return dax_dev;
 
  err_dev:
-	ida_simple_remove(&dax_minor_ida, minor);
+	ida_free(&dax_minor_ida, minor);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_GPL(alloc_dax);
-- 
2.27.0

