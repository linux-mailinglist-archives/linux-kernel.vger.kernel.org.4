Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6A627CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiKNLpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiKNLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581CA20F6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B1261088
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EC1C433D7;
        Mon, 14 Nov 2022 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426268;
        bh=HZIastRykGq/xA5rtpb1Bg85h070mlpSsyGBDMBXEYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euCEXuDs57Jkz5ICAd7/3gZCT/G6I99Z03/IWwv//Gs5dT1Q7RhHBZKC40XVCMoro
         S0GZfmJuacnIqqifElnRHBZ9CKJ6WBZbuxtrXV7Fe7JWFm/r+azYpU5QsFeZrd50x3
         0Fs9sf9UBFMv6nU68ownp6Zd/CWEKRKp0FoNrO+UP9PIsP9coM+LGVrLFjWwoGfER6
         bRQxYHnLBed9kAHfQ4XIxZ4rVSxHohsLn+Soy+WoYhluTx8NlGegiiYacAdk3Kbm8G
         Q+b9jE3WWQ/dxjeryS/Ry63V0RBudfusZiZoU4djSocIn90a48aRk98o/7vxQCn3S/
         N69aEfUo7K0PQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Liska <mliska@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/46] x86/sev, lto: Mark cpuid_table_copy as __visible_on_lto
Date:   Mon, 14 Nov 2022 12:43:12 +0100
Message-Id: <20221114114344.18650-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liska <mliska@suse.cz>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark cpuid_table_copy as __visible_on_lto.

[js] use __visible_on_lto

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/kernel/sev-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..554da8aabfc7 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -64,7 +64,7 @@ struct snp_cpuid_table {
 static u16 ghcb_version __ro_after_init;
 
 /* Copy of the SNP firmware's CPUID page. */
-static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
+__visible_on_lto struct snp_cpuid_table cpuid_table_copy __ro_after_init;
 
 /*
  * These will be initialized based on CPUID table so that non-present
-- 
2.38.1

