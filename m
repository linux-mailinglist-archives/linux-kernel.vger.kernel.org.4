Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672FC736EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjFTOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFTOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B671A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C63612A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A9CC433C8;
        Tue, 20 Jun 2023 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272275;
        bh=ZS4Ma8KGECNAShkM8JDnUCoN4X024GBO7+VXioAiQOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqKJzl5Oy8nDvHjVWIMXDTtE+FvqXAThnODgirzp2HvH6ohctvQE1zC9eMjoCQXle
         9zA7Rp7CajM/wpjpU7pA6ECuNniyvDNwKXYioBDm+OYpnmwpoqCD5hpFOUq0+Xi8de
         o2gIiZJjS3E8wxpIeBR8OT3lR8CCb6qsFs6zKVBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] x86/MSR: make msr_class a static const structure
Date:   Tue, 20 Jun 2023 16:44:33 +0200
Message-ID: <20230620144431.583290-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620144431.583290-4-gregkh@linuxfoundation.org>
References: <20230620144431.583290-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079; i=gregkh@linuxfoundation.org; h=from:subject; bh=QDmKO6VsyrTokC1ZOS4qNRgZzQOeNd6yP/KZZtalGwM=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd/u3q2mW+Py3/J5//cR115zNiysLZqmnH962ztma/ c46dpNjHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRWfcY5hd9/D9FPn8x17qM iMAzYW5v1HY2ODPMlZX5vPWcyl430ap1XRxF4rn2JS1HAA==
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
memory, move the msr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/msr.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 7bb17d37db01..e17c16c54a37 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -39,7 +39,6 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 
-static struct class *msr_class;
 static enum cpuhp_state cpuhp_msr_state;
 
 enum allow_write_msrs {
@@ -235,26 +234,31 @@ static const struct file_operations msr_fops = {
 	.compat_ioctl = msr_ioctl,
 };
 
+static char *msr_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "cpu/%u/msr", MINOR(dev->devt));
+}
+
+static const struct class msr_class = {
+	.name		= "msr",
+	.devnode	= msr_devnode,
+};
+
 static int msr_device_create(unsigned int cpu)
 {
 	struct device *dev;
 
-	dev = device_create(msr_class, NULL, MKDEV(MSR_MAJOR, cpu), NULL,
+	dev = device_create(&msr_class, NULL, MKDEV(MSR_MAJOR, cpu), NULL,
 			    "msr%d", cpu);
 	return PTR_ERR_OR_ZERO(dev);
 }
 
 static int msr_device_destroy(unsigned int cpu)
 {
-	device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
+	device_destroy(&msr_class, MKDEV(MSR_MAJOR, cpu));
 	return 0;
 }
 
-static char *msr_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "cpu/%u/msr", MINOR(dev->devt));
-}
-
 static int __init msr_init(void)
 {
 	int err;
@@ -263,12 +267,9 @@ static int __init msr_init(void)
 		pr_err("unable to get major %d for msr\n", MSR_MAJOR);
 		return -EBUSY;
 	}
-	msr_class = class_create("msr");
-	if (IS_ERR(msr_class)) {
-		err = PTR_ERR(msr_class);
+	err = class_register(&msr_class);
+	if (err)
 		goto out_chrdev;
-	}
-	msr_class->devnode = msr_devnode;
 
 	err  = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/msr:online",
 				 msr_device_create, msr_device_destroy);
@@ -278,7 +279,7 @@ static int __init msr_init(void)
 	return 0;
 
 out_class:
-	class_destroy(msr_class);
+	class_unregister(&msr_class);
 out_chrdev:
 	__unregister_chrdev(MSR_MAJOR, 0, NR_CPUS, "cpu/msr");
 	return err;
@@ -288,7 +289,7 @@ module_init(msr_init);
 static void __exit msr_exit(void)
 {
 	cpuhp_remove_state(cpuhp_msr_state);
-	class_destroy(msr_class);
+	class_unregister(&msr_class);
 	__unregister_chrdev(MSR_MAJOR, 0, NR_CPUS, "cpu/msr");
 }
 module_exit(msr_exit)
-- 
2.41.0

