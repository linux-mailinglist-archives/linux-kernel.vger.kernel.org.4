Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63E69B56B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBQWVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBQWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:21:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234B65366
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:21:28 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0BF21EC01E0;
        Fri, 17 Feb 2023 23:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676672487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PDKW+yv5UtEcvHsw1DjYbPe0YNkfaGA2W97iQ832c4I=;
        b=hRe4s0D8gU4mv/490ItqM2zo/jAqexaIlw7It5rb5DPfXsLyXi02Js6R6xxr47HUPcWUzG
        j7HTOPW++N0kBJK0zUEO6y+rqUi/LoRbOXz6CW9r7P1poaNwtylgYUgj7efuZdrtwE9UNA
        bU/L+8gEdePkQTExYFHigAO6l1J3GcY=
Date:   Fri, 17 Feb 2023 23:21:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, Andrew.Cooper3@citrix.com,
        jpoimboe@redhat.com
Subject: Re: [PATCH v3 2/4] x86/alternative: Support relocations in
 alternatives
Message-ID: <Y+/94eo4xq9TofOs@zn.tnic>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.313857925@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208171431.313857925@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:10:52PM +0100, Peter Zijlstra wrote:
> +			if (insn.opcode.bytes[0] == JMP32_INSN_OPCODE) {
> +				s32 imm = insn.immediate.value;
> +				imm += src - dest;
> +				imm += JMP32_INSN_SIZE - JMP8_INSN_SIZE;
> +				if ((imm >> 31) == (imm >> 7)) {
> +					buf[i+0] = JMP8_INSN_OPCODE;
> +					buf[i+1] = (s8)imm;
> +					for (int j = 2; j < insn.length; j++)
> +						buf[i+j] = INT3_INSN_OPCODE;

Let's get rid of that third nested loop:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e14bc15bf646..28eb1d0bc4a0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -308,8 +308,8 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 				if ((imm >> 31) == (imm >> 7)) {
 					buf[i+0] = JMP8_INSN_OPCODE;
 					buf[i+1] = (s8)imm;
-					for (int j = 2; j < insn.length; j++)
-						buf[i+j] = INT3_INSN_OPCODE;
+
+					memset(&buf[i+2], INT3_INSN_OPCODE, insn.length - 2);
 				}
 			}
 			break;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
