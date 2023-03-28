Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842C46CCB61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjC1USL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1USK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:18:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC44222
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:17:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06D431EC067C;
        Tue, 28 Mar 2023 22:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680034634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj9ZMXdOiC4j+qhb1y+6eCUnrAvvjZYAJh8azvysCpQ=;
        b=ZzLFJ/E5RZZt1ohUTLM3czf8JkkIzDOoX4i5eRu+X7Faaeg6V0VCb0+jQcdQtoIl/uCasM
        qGlf3qVqO540sZpo8O5pSXIH1XpjIEEH97EuzYA/7VJlotoBFhRkFC6m3VYc2KGiNdBo5X
        8CBXduL4/rAchWkbdYZwMAp3JbqLk3E=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] x86/coco: Mark cc_platform_has() and descendants noinstr
Date:   Tue, 28 Mar 2023 22:17:11 +0200
Message-Id: <20230328201712.25852-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230328201712.25852-1-bp@alien8.de>
References: <20230328201712.25852-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Those will be used in code regions where instrumentation is not allowed
so mark them as such.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 73f83233d25d..df10e75be085 100644
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
-- 
2.35.1

