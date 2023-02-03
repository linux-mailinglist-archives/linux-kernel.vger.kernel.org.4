Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50721689F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjBCQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjBCQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:46:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFE9A81A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:46:52 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C9AE1EC056D;
        Fri,  3 Feb 2023 17:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675442811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k1uIPMQw5mWOnLV/Yinyc5VhEErmyZCyR4r9pl/Se5w=;
        b=lWbHOeKw8ruD+CipcIw1Zy2Dp1JcDZYxj+SyKwAO/1rrX/2wWON71Xgkda63QAyFXt4+bH
        nPnl2CQqM9qCBK5AwQiHfZumECrWb65B57rXBfqypnpPUxZF5/sber5JGSHq2GeCu7/8bR
        7IPHmpqaL6kWvG0BhOvbGXnIV1m3dg4=
Date:   Fri, 3 Feb 2023 17:46:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y906d8b6xhC17AAV@zn.tnic>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
 <Y90IaYHDbCN9P0OX@zn.tnic>
 <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
 <Y90wk4FVBtmFJZ4s@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y90wk4FVBtmFJZ4s@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:04:35PM +0100, Borislav Petkov wrote:
> Rest on IRC. :)

Here's what I'm thinking. It still fails somewhere while booting so it
is not good yet but the idea is to show what I mean:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0eff4033eea4..2ede814de089 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -208,14 +208,23 @@ apply_reloc(int n, void *ptr, uintptr_t diff)
 	}
 }
 
+static void __always_inline apply_new_offset(int immed_size, void *ptr, s32 new_offset)
+{
+	switch (immed_size) {
+	case 1:	*(s8 *)ptr  = (s8) new_offset; break;
+	case 2: *(s16 *)ptr = (s16)new_offset; break;
+	case 4: *(s32 *)ptr =      new_offset; break;
+	default: BUG();
+	}
+}
 static void __init_or_module noinline
-apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
+apply_relocation(u8 *insn_buff, size_t len, u8 *instr, u8 *repl, size_t repl_len)
 {
 	struct insn insn;
 	int i = 0;
 
 	for (;;) {
-		if (insn_decode_kernel(&insn, &instr[i]))
+		if (insn_decode_kernel(&insn, &insn_buff[i]))
 			return;
 
 		switch (insn.opcode.bytes[0]) {
@@ -229,20 +238,27 @@ apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
 		case JMP8_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 		case CALL_INSN_OPCODE:
-			u8 *target = src + i + insn.length + insn.immediate.value;
-			if (target < src || target > src + src_len) {
-				apply_reloc(insn.immediate.nbytes,
-					    instr + i + insn_offset_immediate(&insn),
-					    src - dest);
-			}
+			u8 *target = repl + i + insn.length + insn.immediate.value;
+			u8 *next_rip = instr + insn.length;
+			s32 new_offset;
+
+			if (instr < target)
+				new_offset = target - next_rip;
+			else
+				new_offset = next_rip - target;
+
+			apply_new_offset(insn.immediate.nbytes,
+					 insn_buff + i + insn_offset_immediate(&insn),
+					 new_offset);
+
 		}
 
 		if (insn_rip_relative(&insn)) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
