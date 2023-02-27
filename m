Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAA6A46AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjB0QED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjB0QEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:04:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5B6211DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:03:59 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 585B81EC0445;
        Mon, 27 Feb 2023 17:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677513838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=xb92flm1mV65M/epWOlUCTlYcJPYupP7yUsQn3lXFys=;
        b=FmFpvGOxijWN46kpo9qSF+Mg1YcnP02RT6us2kwo8duEAC34WP/qGV3A3t+svFtKqwTIhX
        iAzcpHv7bxvdspc8w2b+MmfHVcxBebpsPeAzkBmku2P3KirGDS1tvJEsyI9ZuTlYmX3PZ+
        iq3f4PHdoxRVF95CYfMOMpNl2AAqiv4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode/AMD: Get rid of __find_equiv_id()
Date:   Mon, 27 Feb 2023 17:03:52 +0100
Message-Id: <20230227160352.7260-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Merge it into its only call site.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9eb457b10341..394a9e16d5ee 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -596,11 +596,6 @@ void reload_ucode_amd(unsigned int cpu)
 		}
 	}
 }
-static u16 __find_equiv_id(unsigned int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
-}
 
 /*
  * a small, trivial cache of per-family ucode patches
@@ -651,9 +646,11 @@ static void free_cache(void)
 
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u16 equiv_id;
 
-	equiv_id = __find_equiv_id(cpu);
+
+	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 	if (!equiv_id)
 		return NULL;
 
-- 
2.35.1

