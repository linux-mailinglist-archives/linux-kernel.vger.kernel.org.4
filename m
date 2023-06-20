Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE8736EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjFTOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFTOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52646E9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9F0612A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E8AC433C0;
        Tue, 20 Jun 2023 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271827;
        bh=xbu9l18ogaQhPDGquwWb+KtRsIUkpWzgRakje7PITDA=;
        h=From:To:Cc:Subject:Date:From;
        b=d81hcfU4edxoMkcKUo4T4gUKAZ37YRIEdyQXZtjtOxWWfMh0/ajMJDGpHmvd+wPZ+
         FPyqWkvA9JsCsT3vNGxOYPHFj8ALIuCUQPyOhvr5a8x85uh62juI7w7F/zrIJ3P3y4
         3At4GqF3M27SsZ6IeF2U1pbZT4XkaQ3ZHEBTPBf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        openipmi-developer@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ipmi: make ipmi_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:02 +0200
Message-ID: <20230620143701.577657-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=gregkh@linuxfoundation.org; h=from:subject; bh=a4xcYV0fvsjCWQlXBXjb8iizMDRF8ihdB423Fz28XNo=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd/ZeeRLhcGODp/SKOKvmG2Kx6e5GdvNqbrvOnDddw J+xdQJHRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExEo5lhwbEjepPsXk4Nfals r3vQde+DwN28kxnmaW0vzogTW1V7/pjp++/zL/VuP9HLCgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the ipmi_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_devintf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index 73e5a9e28f85..332082e02ea5 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -807,7 +807,9 @@ struct ipmi_reg_list {
 static LIST_HEAD(reg_list);
 static DEFINE_MUTEX(reg_list_mutex);
 
-static struct class *ipmi_class;
+static const struct class ipmi_class = {
+	.name = "ipmi",
+};
 
 static void ipmi_new_smi(int if_num, struct device *device)
 {
@@ -822,7 +824,7 @@ static void ipmi_new_smi(int if_num, struct device *device)
 	entry->dev = dev;
 
 	mutex_lock(&reg_list_mutex);
-	device_create(ipmi_class, device, dev, NULL, "ipmi%d", if_num);
+	device_create(&ipmi_class, device, dev, NULL, "ipmi%d", if_num);
 	list_add(&entry->link, &reg_list);
 	mutex_unlock(&reg_list_mutex);
 }
@@ -840,7 +842,7 @@ static void ipmi_smi_gone(int if_num)
 			break;
 		}
 	}
-	device_destroy(ipmi_class, dev);
+	device_destroy(&ipmi_class, dev);
 	mutex_unlock(&reg_list_mutex);
 }
 
@@ -860,15 +862,13 @@ static int __init init_ipmi_devintf(void)
 
 	pr_info("ipmi device interface\n");
 
-	ipmi_class = class_create("ipmi");
-	if (IS_ERR(ipmi_class)) {
-		pr_err("ipmi: can't register device class\n");
-		return PTR_ERR(ipmi_class);
-	}
+	rv = class_register(&ipmi_class);
+	if (rv)
+		return rv;
 
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
-		class_destroy(ipmi_class);
+		class_unregister(&ipmi_class);
 		pr_err("ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -880,7 +880,7 @@ static int __init init_ipmi_devintf(void)
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
-		class_destroy(ipmi_class);
+		class_unregister(&ipmi_class);
 		pr_warn("ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -895,11 +895,11 @@ static void __exit cleanup_ipmi(void)
 	mutex_lock(&reg_list_mutex);
 	list_for_each_entry_safe(entry, entry2, &reg_list, link) {
 		list_del(&entry->link);
-		device_destroy(ipmi_class, entry->dev);
+		device_destroy(&ipmi_class, entry->dev);
 		kfree(entry);
 	}
 	mutex_unlock(&reg_list_mutex);
-	class_destroy(ipmi_class);
+	class_unregister(&ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);
 }
-- 
2.41.0

