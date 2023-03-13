Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA66B80BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCMScy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCMScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4126785349
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E85461486
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB9C4339B;
        Mon, 13 Mar 2023 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732212;
        bh=29/VsP7QLy9amuWzKxZWbyxjbLYD3mVtVi2dWWJd14U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6WvZTgnyjdnIciW+XJpqREAg/Sv8CNZ5h7L49crFuJX9JpZK557g+J2i6Rcj0+lH
         HB0ldD4o4+vDS7opAYeEgo4MehXRRg9H5eQlp8Ul+Ifl+nZhUHaZMVl9PtOPNmV6Pn
         xR4klK47fvEJw/UgeP5px6cwCi1Q8Qw7JTWTGJq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 08/36] workqueue: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:50 +0100
Message-Id: <20230313182918.1312597-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=gregkh@linuxfoundation.org; h=from:subject; bh=29/VsP7QLy9amuWzKxZWbyxjbLYD3mVtVi2dWWJd14U=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82WXzlwgI/9nCY/WtQDCZfW/SI+PPK5Rjuld+2JLiX tG9hTO1I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZybDLDfLc1Wydbs4mrXxSf EVkRH3udN37SbYYFa+4uceEWOGdeOs2gNlZ15Yq6d3vuAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 kernel/workqueue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..209917792fa4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5826,13 +5826,19 @@ static struct device_attribute wq_sysfs_cpumask_attr =
 
 static int __init wq_sysfs_init(void)
 {
+	struct device *dev_root;
 	int err;
 
 	err = subsys_virtual_register(&wq_subsys, NULL);
 	if (err)
 		return err;
 
-	return device_create_file(wq_subsys.dev_root, &wq_sysfs_cpumask_attr);
+	dev_root = bus_get_dev_root(&wq_subsys);
+	if (dev_root) {
+		err = device_create_file(dev_root, &wq_sysfs_cpumask_attr);
+		put_device(dev_root);
+	}
+	return err;
 }
 core_initcall(wq_sysfs_init);
 
-- 
2.39.2

