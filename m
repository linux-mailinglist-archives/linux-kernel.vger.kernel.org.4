Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B64B6776F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjAWJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjAWJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:02:31 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC221C33D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:02:30 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id DDEBE81845;
        Mon, 23 Jan 2023 09:02:25 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674464549;
        bh=wZOMSDg+jl87+2LzvkXD4c/jHXkK/mccaqoYTgmhBqE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=g2hQg9QCJ8cqZmHPPAhW8H+qH0P+JONEuTIXJKEycOOg+4C4+Ivkn0oZM74MBNR2W
         qIHmDIjqGWFnODMFTFckr6YJ2S8i/JmXOzW0ExZNI8/hs/etfJxwSGGnlTnNcHppu+
         Igr3T6n2xRfQBqsoDq4MxfpF1IlksRY+/00pGSeZOmJLlvFtuGcgOGy9Cmt2pZNdj2
         u0odfkqvm85I6zxIyFca/+7H5XOO5NCTsK1/08+QS+kdEq0v3ZrM9qpOVg6rejkV94
         YKGhrzodMx27poQaDnFFj8uRBKHktz4alG/9BUW52Pe/wp3713Je3JChyiDGMa4goA
         32s8sAm4Whm1w==
Message-ID: <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
Date:   Mon, 23 Jan 2023 16:02:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
In-Reply-To: <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 6:45 AM, H. Peter Anvin wrote:
> static enum regs_ok check_regs_syscall(int syscall,
>      unsigned long arg1, unsigned long arg2)
> {
> 
>      register unsigned long r11 asm("%r11");
>      unsigned long rcx, rbx, tmp;

tmp is unused.

>      r11 = r11_sentinel;
>      rcx = rcx_sentinel;
> 
>      asm volatile("push %3; popf; "
>               "lea 1f(%%rip),%2; "
>               "syscall; "
>               "1:"
>               : "+r" (r11), "+c" (rcx), "=b" (rbx)
>               : "g" (rflags_sentinel),
>                 "a" (syscall), "D" (arg1), "S" (arg2));

BTW, I just realized this "push" is unsafe for userspace code if the
compiler decides to inline this inside a leaf function that uses the
redzone.

Reason: Because this "push;" clobbers redzone.

It doesn't always happen, but when that happens it can be confusing to
debug.

A simple workaround is: just compile it with "-mno-red-zone" flag.

Alternative, without using that flag, maybe preserve the value like:

     movq    -8(%rsp), %r12
     pushq   %[rflags_sentinel]
     popf
     movq    %r12, -8(%rsp)
     syscall

with "r12" and "memory" added to the clobber list.

What do you think?

-- 
Ammar Faizi
