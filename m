Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C630736EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjFTOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjFTOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAE1A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68459612A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D9C433C0;
        Tue, 20 Jun 2023 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272277;
        bh=i6meXYqzLbS/T0+2ewiMbX093Oqmfn9KIdm7F7gK6M4=;
        h=From:To:Cc:Subject:Date:From;
        b=JQXTek8zGep3caKrdUoaW7M5Enue8KiHrWKsE1hsNc7D4oF1wUTkmaV/VF1XjB+Ej
         d87yR7YNNRsSxgbZMVxDlL0KFvNGts5jS8SB19helGvZx6cr0EXyax7orzNPu8rjOc
         mnpZ8X+mNS48DNt8kV0hd+dGzxFB6AwdDOQyfifw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] x86/cpuid: make cpuid_class a static const structure
Date:   Tue, 20 Jun 2023 16:44:32 +0200
Message-ID: <20230620144431.583290-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139; i=gregkh@linuxfoundation.org; h=from:subject; bh=aBTFKVZ8OOd4/o/cKdaCS1NflsAv/K3saJjhqsnO3t0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd/tHzZh33qhUYeZvlee2Zd+Dc846ic7lEHlmlXlX8 cc2o+kyHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR6p0MCzY2m9V67toaf3b1 XyXBXzJhwkJPqhjm6e6z+vDg/p3p35dEvvr3eZHjfz5dPQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the cpuid_class structure to be declared at build time
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
 arch/x86/kernel/cpuid.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index bdc0d5539b57..dae436253de4 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -40,7 +40,6 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 
-static struct class *cpuid_class;
 static enum cpuhp_state cpuhp_cpuid_state;
 
 struct cpuid_regs_done {
@@ -124,26 +123,31 @@ static const struct file_operations cpuid_fops = {
 	.open = cpuid_open,
 };
 
+static char *cpuid_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "cpu/%u/cpuid", MINOR(dev->devt));
+}
+
+static const struct class cpuid_class = {
+	.name		= "cpuid",
+	.devnode	= cpuid_devnode,
+};
+
 static int cpuid_device_create(unsigned int cpu)
 {
 	struct device *dev;
 
-	dev = device_create(cpuid_class, NULL, MKDEV(CPUID_MAJOR, cpu), NULL,
+	dev = device_create(&cpuid_class, NULL, MKDEV(CPUID_MAJOR, cpu), NULL,
 			    "cpu%d", cpu);
 	return PTR_ERR_OR_ZERO(dev);
 }
 
 static int cpuid_device_destroy(unsigned int cpu)
 {
-	device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+	device_destroy(&cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 	return 0;
 }
 
-static char *cpuid_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "cpu/%u/cpuid", MINOR(dev->devt));
-}
-
 static int __init cpuid_init(void)
 {
 	int err;
@@ -154,12 +158,9 @@ static int __init cpuid_init(void)
 		       CPUID_MAJOR);
 		return -EBUSY;
 	}
-	cpuid_class = class_create("cpuid");
-	if (IS_ERR(cpuid_class)) {
-		err = PTR_ERR(cpuid_class);
+	err = class_register(&cpuid_class);
+	if (err)
 		goto out_chrdev;
-	}
-	cpuid_class->devnode = cpuid_devnode;
 
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/cpuid:online",
 				cpuid_device_create, cpuid_device_destroy);
@@ -170,7 +171,7 @@ static int __init cpuid_init(void)
 	return 0;
 
 out_class:
-	class_destroy(cpuid_class);
+	class_unregister(&cpuid_class);
 out_chrdev:
 	__unregister_chrdev(CPUID_MAJOR, 0, NR_CPUS, "cpu/cpuid");
 	return err;
@@ -180,7 +181,7 @@ module_init(cpuid_init);
 static void __exit cpuid_exit(void)
 {
 	cpuhp_remove_state(cpuhp_cpuid_state);
-	class_destroy(cpuid_class);
+	class_unregister(&cpuid_class);
 	__unregister_chrdev(CPUID_MAJOR, 0, NR_CPUS, "cpu/cpuid");
 }
 module_exit(cpuid_exit);
-- 
2.41.0

