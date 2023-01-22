Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E521B67738C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjAVXqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjAVXqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:46:19 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FA1207A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 15:46:17 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30MNjnNG2107520
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 22 Jan 2023 15:45:50 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30MNjnNG2107520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674431154;
        bh=Hx31l10Tn1gyxYATdZwdRteTD2Eb2dvRep72nyd3u+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AMlC9J+sE/zP9qpAc8xnvSoXP39PXLgLIgukeZl/p4ABmFwFiiOn5Kt0e0qOBKwXc
         6g1egH54n/W9+hqQmE0A8Xt0/H2mzzV6ox3zNJVRQlJtTzc1Cwvd+AA5l7Zmj5heNJ
         8KtfVz0Cszxf/i29y7FQNiSHaD5+A0wd3+r86xabQAgo/Iw9obEksz/aQI6dCcbd7b
         VD2a9KAE555srzktwzWhffY0NZbyMAC/wdrxgxjNaEbu+uYqGnegyuh1oHDMpqu0gy
         XgF12EP33xwte7IWwxRyWNRCx8V4PHtvvg9DvPxinUN18exRo/MSJlA+RxdifCBJbO
         bD632RgBOc+ag==
Message-ID: <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
Date:   Sun, 22 Jan 2023 15:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 20:34, Dave Hansen wrote:
> On 1/21/23 19:38, Li, Xin3 wrote:
>>> However, it doesn't seem to make sense to do so to me. The current behavior is
>>> much more of an artifact than desired behavior.
>> We kind of have an agreement that %r11 = %flags after returning from the kernel.
>>
>> And the question is, is it what we want?
> 
> Can the selftest just set r11=rflags before the syscall?  The old
> syscall entry path will set r11=rflags.  The FRED path won't touch it.
> Either case will pass an r11==rflags check.

Thinking about this some more, the whole point here is to make sure that 
all syscalls work consistently, so that we don't leak a kernel 
implementation detail.

Either r11 and rcx should both be clobbered (set to %rcx and the return 
%rip respectively), or none should be.

As such, I think we want to do something like:



/* Arbitrary values */
const unsigned long r11_sentinel = 0xfeedfacedeadbeef;
const unsigned long rcx_sentinel = 0x5ca1ab1e0b57ac1e;

/* An arbitrary *valid* RFLAGS value */
const unsigned long rflags_sentinel = 0x200893;

enum regs_ok {
	REGS_ERROR  = -1,	/* Invalid register contents */
	REGS_SAVED  =  0,	/* Registers properly preserved */
	REGS_SYSRET =  1	/* Registers match syscall/sysret */
};

/*
  * Returns:
  *  0 = %rcx and %r11 preserved
  *  1 = %rcx and %r11 set to %rflags and %rip
  * -1 = %rcx and/or %r11 set to any other values
  *
  * Note that check_regs_syscall() set %rbx to the syscall return %rip.
  */
static enum regs_ok check_regs_result(unsigned long r11,
	unsigned long rcx, unsigned long rbx)
{
	if (r11 == r11_sentinel && rcx == rcx_sentinel)
		return REGS_SAVED;
	else if (r11 == rflags_sentinel && rcx == rbx)
		return REGS_SYSRET;
	else
		return REGS_ERROR;
}

static enum regs_ok check_regs_syscall(int syscall,
	unsigned long arg1, unsigned long arg2)
{

	register unsigned long r11 asm("%r11");
	unsigned long rcx, rbx, tmp;

	r11 = r11_sentinel;
	rcx = rcx_sentinel;

	asm volatile("push %3; popf; "
		     "lea 1f(%%rip),%2; "
		     "syscall; "
		     "1:"
		     : "+r" (r11), "+c" (rcx), "=b" (rbx)
		     : "g" (rflags_sentinel),
		       "a" (syscall), "D" (arg1), "S" (arg2));

	return check_regs_result(r11, rcx, rbx);
}

enum regs_ok
check_regs_getppid(void)
{
     return check_regs_syscall(__NR_getppid, 0, 0);
}



Test it out with a trivial system call like __NR_getppid which is 
extremely likely to return with SYSRET on an IDT system; check that it 
returns a nonnegative value and then save the result.

All tests from that point on should return the *same* value, including 
the signal handler etc.

I make the result-checking function separate so that it can be fed data 
from e.g. the signal stack or ptrace.

	-hpa
