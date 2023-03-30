Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3D6D046A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjC3MMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjC3MMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:12:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84D420B;
        Thu, 30 Mar 2023 05:12:07 -0700 (PDT)
Date:   Thu, 30 Mar 2023 12:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680178324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+JuhT5uJ9g2/YYYFJ/EjWALSEY8vu20u5ts54xdaiI=;
        b=CU9TlKqTDYTbfJU10SlCEiIBUyzCePgw2KVZ3QTc5BZlnARLXWgCkf9jZ2nNANsrfVESlW
        VSJ79lSTxDpSMUJJHBG3Ms4rIvqxjjtCjLzHYG2S5EJr/GPTf61+VFtHhe689xypK5XPRl
        O6YFBIP38XN/DaVkvfl9kuQxfYOMIuOWDimIfiEIiheFTCDqsRDp5qY1cQn0FIyBklkyuN
        zIh7FzWQkKzje5a+QS9gItoZYwFsbpnZamFryC/WC3vuGpdIWObhkW2N+n7FJtZc4qdE2g
        6zurRcJCvATVe27xA3bw+NQdafjd7vGbGbxqi16tydXIoq49hW/yYuYtBHKjkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680178324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+JuhT5uJ9g2/YYYFJ/EjWALSEY8vu20u5ts54xdaiI=;
        b=LSUdl0ot0d8bVhAU6XVyu4AVrIk+u4PgZRIsiTRgXOD+HEWS377OImx7zc903YpbuiJx++
        XYcAi61vQpx4CQDg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/coco: Export cc_vendor
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230318115634.9392-2-bp@alien8.de>
References: <20230318115634.9392-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168017832388.404.10347137104098194414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     3d91c537296794d5d0773f61abbe7b63f2f132d8
Gitweb:        https://git.kernel.org/tip/3d91c537296794d5d0773f61abbe7b63f2f132d8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 18 Mar 2023 12:56:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 30 Mar 2023 14:06:28 +02:00

x86/coco: Export cc_vendor

It will be used in different checks in future changes. Export it directly
and provide accessor functions and stubs so this can be used in general
code when CONFIG_ARCH_HAS_CC_PLATFORM is not set.

No functional changes.

[ tglx: Add accessor functions ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de

---
 arch/x86/coco/core.c        | 13 ++++---------
 arch/x86/include/asm/coco.h | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f8..684f0a9 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -83,7 +83,7 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
@@ -105,7 +105,7 @@ u64 cc_mkenc(u64 val)
 	 * - for AMD, bit *set* means the page is encrypted
 	 * - for Intel *clear* means encrypted.
 	 */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
 	case CC_VENDOR_INTEL:
@@ -118,7 +118,7 @@ u64 cc_mkenc(u64 val)
 u64 cc_mkdec(u64 val)
 {
 	/* See comment in cc_mkenc() */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
 	case CC_VENDOR_INTEL:
@@ -129,11 +129,6 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
 
-__init void cc_set_vendor(enum cc_vendor v)
-{
-	vendor = v;
-}
-
 __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a..91b9448 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,13 +11,30 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_set_vendor(enum cc_vendor v);
-void cc_set_mask(u64 mask);
-
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern enum cc_vendor cc_vendor;
+
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return cc_vendor;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor)
+{
+	cc_vendor = vendor;
+}
+
+void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return CC_VENDOR_NONE;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor) { }
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
