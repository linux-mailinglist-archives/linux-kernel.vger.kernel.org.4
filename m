Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA35686C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBARCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBARCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:02:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D049014
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675270962; x=1706806962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pnVVRZNdKxmWscgVv/lvHgzdsbiJLMgVZgxw1VzPTbU=;
  b=OIuBAIMLMhsZN7nrOxlllAaNd/m4KKoeFk22b05PGSZp4/SvKddbZYzO
   q5tNnt5c+nUWbua8wyaOM1CbcinqlCX4XGZeEfQIFDGAkqRETwG+Y0gVL
   6MufsTrwhxIQv8AWE75oyWf9YQJEidpHZNRl61VrbAdzHQBunWLviqWaL
   AEwAuAwaS7pLqPQhDdJj02WRfAXCXs6ZsIbzwuKrjsTs2lq0yKFwOPRB7
   rPviZBfzB4PcJcP4M3BdFuY6Bjg7WkHdjNp/83ukPNcalxLoSmr4iH/vN
   WJgguWBFzckPhCkYKsosx011kY7eGs86rHKTpJLguiJuISm0GsIM6vcGF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355536951"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="355536951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:02:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="614919301"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="614919301"
Received: from wlwpo-3.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.34.185])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:02:34 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A11BC10E380; Wed,  1 Feb 2023 20:02:31 +0300 (+03)
Date:   Wed, 1 Feb 2023 20:02:31 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <20230201170231.ra3tiiarlg35xl33@box.shutemov.name>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:10:33PM +0100, Peter Zijlstra wrote:
> +static void __init_or_module noinline
> +apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
> +{
> +	struct insn insn;
> +	int i = 0;
> +
> +	for (;;) {
> +		if (insn_decode_kernel(&insn, &instr[i]))
> +			return;
> +
> +		switch (insn.opcode.bytes[0]) {
> +		case 0x0f:
> +			if (insn.opcode.bytes[1] < 0x80 ||
> +			    insn.opcode.bytes[1] > 0x8f)
> +				break;
> +
> +			fallthrough;	/* Jcc.d32 */
> +		case 0x70 ... 0x7f:	/* Jcc.d8 */
> +		case JMP8_INSN_OPCODE:
> +		case JMP32_INSN_OPCODE:
> +		case CALL_INSN_OPCODE:
> +			u8 *target = src + i + insn.length + insn.immediate.value;

LLVM doesn't like this declaration of 'target'. I've moved to the top of
the function.

I've tested the patch with both GCC and LLVM (after 'target' fix) with my
LAM case. See the patch below.

Works fine. Thanks.

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 6450a2723bcd..ec7613141db6 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -35,17 +35,12 @@ static inline unsigned long __untagged_addr(unsigned long addr)
 {
 	long sign;
 
-	/*
-	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
-	 * in alternative instructions. The relocation gets wrong when gets
-	 * copied to the target place.
-	 */
 	asm (ALTERNATIVE("",
 			 "sar $63, %[sign]\n\t" /* user_ptr ? 0 : -1UL */
-			 "or %%gs:tlbstate_untag_mask, %[sign]\n\t"
+			 "or " __percpu_arg([mask]) ", %[sign]\n\t"
 			 "and %[sign], %[addr]\n\t", X86_FEATURE_LAM)
 	     : [addr] "+r" (addr), [sign] "=r" (sign)
-	     : "m" (tlbstate_untag_mask), "[sign]" (addr));
+	     : [mask] "m" (tlbstate_untag_mask), "[sign]" (addr));
 
 	return addr;
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 50b88aa3ebee..bb1437ac2f5a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -212,6 +212,7 @@ static void __init_or_module noinline
 apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
 	struct insn insn;
+	u8 *target;
 	int i = 0;
 
 	for (;;) {
@@ -229,7 +230,7 @@ apply_relocation(u8 *instr, size_t len, u8 *dest, u8 *src, size_t src_len)
 		case JMP8_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 		case CALL_INSN_OPCODE:
-			u8 *target = src + i + insn.length + insn.immediate.value;
+			target = src + i + insn.length + insn.immediate.value;
 			if (target < src || target > src + src_len) {
 				apply_reloc(insn.immediate.nbytes,
 					    instr + i + insn_offset_immediate(&insn),
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
