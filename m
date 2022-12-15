Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEE64DEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiLOQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLOQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:43:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11CB33C3D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89713B81AAC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53611C433EF;
        Thu, 15 Dec 2022 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122619;
        bh=TxCuOHUdPv/ZjT1o8pDBjUpfoJT0BDExlgCRyV+RKbk=;
        h=From:To:Cc:Subject:Date:From;
        b=NAWV6Z8gS7Ck5a7+95VJ4ZB+uuC+BSD0++Pf3Rir7sHOmfxX0HaT5M5zmOA7W2apR
         C1M+j96VB9y1Voqn6/wDmcVGQ5PGwAKT2sTGB1GSifkJ1rMqfXeToKv8DFbdubh7uU
         6tqyNj4tLhdSPu4Vcfps4zN4MGd05TgpztXioLDk4Xv2DY5OhP1dBSAJNHEdR2whSR
         2hhM6XES7JIdlGTvPpcsbIx6rWKlArDV7yF3y2J0SikmV/vwYj3R0YGtBNlp8X1emY
         qYimC4+Y0WjFAtWxI79sY9l5TNotXhkvyesm4PYGqGsEbAfDYN6RBWJdw4UaeHvA6w
         /AXlgP6tiVvbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: callthunks: fix incorrect init section references
Date:   Thu, 15 Dec 2022 17:43:23 +0100
Message-Id: <20221215164334.968863-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Arnd Bergmann <arnd@arndb.de>

The addition of callthunks_translate_call_dest means that
skip_addr() and patch_dest() can no longer be discarded
as part of the __init section freeing:

WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> patch_dest (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: is_callthunk.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/callthunks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 7d2c75ec9a8c..ffea98f9064b 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -119,7 +119,7 @@ static bool is_coretext(const struct core_text *ct, void *addr)
 	return within_module_coretext(addr);
 }
 
-static __init_or_module bool skip_addr(void *dest)
+static bool skip_addr(void *dest)
 {
 	if (dest == error_entry)
 		return true;
@@ -181,7 +181,7 @@ static const u8 nops[] = {
 	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
 };
 
-static __init_or_module void *patch_dest(void *dest, bool direct)
+static void *patch_dest(void *dest, bool direct)
 {
 	unsigned int tsize = SKL_TMPL_SIZE;
 	u8 *pad = dest - tsize;
-- 
2.35.1

