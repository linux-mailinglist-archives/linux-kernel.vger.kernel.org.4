Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990C70181D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjEMQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjEMQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:02:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071741737
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:02:00 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 655261EC0506;
        Sat, 13 May 2023 18:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683993719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSyTX/s9Jr5V9s4h9XPfSKjkj7PuJf1fUrxghd91drE=;
        b=JwVExmHu+FJvy+wbZnOqhAC+0ifK81B24Uc5C7cEJEdXBdahK3xP9eJvAda+3HL7VWWoWE
        MRW3FAIL2TYWtGWjNZyBxgDy5atmrk+GMUXSDcul9VSGQocQZVekQBdnBXoK8Trc+nUvCS
        dNOImTGUPM7FaHv6eWI1UYJdVQVN/vU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/alternatives: Fix section mismatch warnings
Date:   Sat, 13 May 2023 18:01:46 +0200
Message-Id: <20230513160146.16039-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <168398302732.404.4356413406268674545.tip-bot2@tip-bot2>
References: <168398302732.404.4356413406268674545.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Fix stuff like:

  WARNING: modpost: vmlinux.o: section mismatch in reference: \
  __optimize_nops (section: .text) -> debug_alternative (section: .init.data)

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3bb0a5f61e8c..93aa95afd005 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -193,8 +193,8 @@ static int skip_nops(u8 *instr, int offset, int len)
  * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
  * to the end of the NOP sequence into a single NOP.
  */
-static bool __optimize_nops(u8 *instr, size_t len, struct insn *insn,
-			    int *next, int *prev, int *target)
+static bool __init_or_module
+__optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, int *target)
 {
 	int i = *next - insn->length;
 
@@ -765,7 +765,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-static void poison_endbr(void *addr, bool warn)
+static void __init_or_module poison_endbr(void *addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
 
-- 
2.35.1

