Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90E67AB39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjAYHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:50:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587740BDD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:50:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DA7D1EC0683;
        Wed, 25 Jan 2023 08:50:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674633026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=NTB8XrLrarbLngzGqxNfeXRWCH7fY+q1RJDrPsMhVqo=;
        b=S7meWRK0GdrXY+LYoLQJpxZo3CCsgf5DLo2ZgKxzwbMosq+7X1h6UpCJgpO/ZhQ2TLNt1a
        NpnRpPGbdPNXKe7z/r+e83ObCm4IGNKvwa48HTCRNzGlWN9IeGnaxpW0i0DTGAw+IOV7Ar
        buqAt9yaeMRtVC3yGCjRatp7OUkaJD4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: Use cpu_feature_enabled() when checking global pages support
Date:   Wed, 25 Jan 2023 08:50:13 +0100
Message-Id: <20230125075013.9292-1-bp@alien8.de>
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

X86_FEATURE_PGE determines whether the CPU has enabled global page
translations support. Use the faster cpu_feature_enabled() check to
shave off some more cycles when flushing all TLB entries, including the
global ones.

What this practically saves is:

   mov    0x82eb308(%rip),%rax        # 0xffffffff8935bec8 <boot_cpu_data+40>
   test   $0x20,%ah

which test the bit. Not a lot but TLB flushing is a timing-sensitive
path so anything to make it even faster.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9a85d7..92d73ccede70 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1205,7 +1205,7 @@ void __flush_tlb_all(void)
 	 */
 	VM_WARN_ON_ONCE(preemptible());
 
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
+	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
 		/*
-- 
2.35.1

