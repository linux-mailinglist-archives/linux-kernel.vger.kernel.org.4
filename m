Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45468C9A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBFWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:38:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8E2FCF4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675723097; x=1707259097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i0D5q2SJMTLe5KLS27k2uqNok6rHU+HY2+f5TXOXAX4=;
  b=efyLHHndgKfONyMGxJhGV6j0L57D4rvSLlPRtAdRfyzv6GtAdF9iayvE
   LL6RgeJkZ6+GXDSE7F3H+OksDDUQ4cJDSq1NBqhK11fTyPqANJn1dTBcA
   Snkho8v/QRoegkJ200mumtxYP6zZ0tqssgd1yJO/kOSssWgXdztmmgmQn
   VZ2X42B7XUsGcaukmWCn/p3x2SbbJs0WARm51GCjAMg/HBzXR9HveOQX2
   kFOtXOzsjGFyd5tHIbzFtqlJ7F49Fu1PQ8sKXYNBymqSTGguH6nEZcbjx
   Hcd/L0OXDGqtuN2b/7CZvpZGFBifSRfzzDoAV3gi+xQLAA7oYTa1xDob1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393932163"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393932163"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:38:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995495742"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995495742"
Received: from ninhngo-mobl.amr.corp.intel.com (HELO [10.212.134.105]) ([10.212.134.105])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:38:16 -0800
Message-ID: <dc964552-dca7-dd83-52a2-283be7f51555@intel.com>
Date:   Mon, 6 Feb 2023 14:38:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230204210807.3930-1-namit@vmware.com>
 <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
 <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 11:05, Nadav Amit wrote:
>> On 2/4/23 13:08, Nadav Amit wrote:
>>> --- a/arch/x86/kernel/kprobes/core.c
>>> +++ b/arch/x86/kernel/kprobes/core.c
>>> @@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>>>              /* 1 byte conditional jump */
>>>              p->ainsn.emulate_op = kprobe_emulate_jcc;
>>>              p->ainsn.jcc.type = opcode & 0xf;
>>> -             p->ainsn.rel32 = *(char *)insn->immediate.bytes;
>>> +             p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
>>>              break;
>>
>> This new code is at least consistent with what the other code in that
>> function does with 1-byte immediates.  But, I'm curious what the point
>> is about going through the 's8' type.
>>
>> What's wrong with:
>>
>>        p->ainsn.rel32 = insn->immediate.value;
>>
>> ?  Am I missing something subtle?
> 
> I am not sure why this is considered safe, insn->immediate.value has a
> type of insn_value_t, which is signed int, so such casting seems wrong
> to me. Do you imply that during decoding the sign-extension should have
> been done correctly? Or am I missing something else?

OK, so we've got an assignment which on the left hand side is
p->ainsn.rel32 which is a 32-bit signed integer:

struct arch_specific_insn {
	...
        s32 rel32;      /* relative offset must be s32, s16, or s8 */

The right hand side is insn->immediate.value.  Its real type is a couple
of layers deep, but it boils down to a 'signed int', also 32-bit:

Struct #1:
struct insn {
	...
        union {
                struct insn_field immediate;
		...
        };

Struct #2
struct insn_field {
        union {
                insn_value_t value;
                insn_byte_t bytes[4];
        };
	...

And a typedef:
typedef signed int insn_value_t;

So, the proposed code above is effectively this:

	s32 foo;
	signed int bar;

	foo = *(s8 *)&bar;

That works just fine as long as the value being represented fits in a
single byte.  But, it *certainly* wouldn't work for:

	s32 foo;
	signed int bar = 128;

	foo = *(s8 *)&bar;

In this specific case, I think the conditional jump offsets are all from
the (entire) second byte of the instruction, so this is _somewhat_ academic.

> Anyhow, after spending too much time on debugging kprobes failures,
> I prefer to be more defensive, and not require the code to be “aware”
> or rely on member types or the order of implicit casting in C.

Well, the code in the fix requires some awareness of the range of the
data type.  The simpler direct assignment:

	p->ainsn.rel32 = insn->immediate.value;

doesn't require much and works for a wider range of values -- *ALL*
32-bit signed integer values on x86.

I figured I must be missing something.  It would not be the first time
that C's type system rules tripped me up.  Why this:

	foo = *(s8 *)&bar;

Instead of this:

	foo = bar;

?  I'm having a hard time of seeing what the advantage is of the 's8'
version.
