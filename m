Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8A6FC45E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjEIK6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEIK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:58:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20EA76BF;
        Tue,  9 May 2023 03:58:20 -0700 (PDT)
Date:   Tue, 09 May 2023 10:58:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbOLo9bnGMk27JhmsnwuQODkQepljVGTk1doCsr1Ahs=;
        b=PTDKxFdkVdAYqBPmPNxDuqiveUCA29+ZAYuUIgHEdiQVMS+bNO2ywK4sTyY4lF4B0KNX4X
        P6aayFY818LJDTX/uBPtIKV+9ptp7NVVwA0ew1GpYHePbXvLyHRXqvcqoXjr4r508EZgu9
        uHHYkbiOzjAPeSSooX+/Hl17y8C8vfwmhr0ZnZmlreOn6TB/CW3XdXMnsy1mrd3ybgGT15
        MY+SFKtOgbVr5OqLOc726WUaaAi5vZqp4UjNkRVfChEZrvT/xf4bc4jiNrnWvo0gRhGEjh
        FRCKtnrotyAjkCr668VRtcqn4sNFeYb0U4mBqu1MyFHApvJQl7ztVM2fLOwvpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbOLo9bnGMk27JhmsnwuQODkQepljVGTk1doCsr1Ahs=;
        b=DHTSVNHoIh16T8LBYlW6gNOpV9cMElHV3PDZbTakl8/SoMerAAkV3+gWnqNtAnSTpm5xsx
        6AIJpHqlKegQ0uAA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/coco: Mark cc_platform_has() and descendants noinstr
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328201712.25852-2-bp@alien8.de>
References: <20230328201712.25852-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168362989883.404.10957011001565059160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1eaf282e2c7d062a946980758df013f09f934a54
Gitweb:        https://git.kernel.org/tip/1eaf282e2c7d062a946980758df013f09f934a54
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 28 Mar 2023 22:17:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 11:39:35 +02:00

x86/coco: Mark cc_platform_has() and descendants noinstr

Those will be used in code regions where instrumentation is not allowed
so mark them as such.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230328201712.25852-2-bp@alien8.de
---
 arch/x86/coco/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 73f8323..df10e75 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -16,7 +16,7 @@
 enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
-static bool intel_cc_platform_has(enum cc_attr attr)
+static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
@@ -34,7 +34,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
  * the other levels of SME/SEV functionality, including C-bit
  * based SEV-SNP, are not enabled.
  */
-static __maybe_unused bool amd_cc_platform_vtom(enum cc_attr attr)
+static __maybe_unused __always_inline bool amd_cc_platform_vtom(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
@@ -58,7 +58,7 @@ static __maybe_unused bool amd_cc_platform_vtom(enum cc_attr attr)
  * the trampoline area must be encrypted.
  */
 
-static bool amd_cc_platform_has(enum cc_attr attr)
+static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
@@ -97,7 +97,7 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
-bool cc_platform_has(enum cc_attr attr)
+bool noinstr cc_platform_has(enum cc_attr attr)
 {
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
