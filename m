Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950B676BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAVIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:55:05 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D71284F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:55:04 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id CF8F382051;
        Sun, 22 Jan 2023 08:54:59 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674377703;
        bh=o0g9l6yH+SEb5Ixg0oOgGfCDD5DUXhW5WsSzssjcTks=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Z2YBuWkEhtR33/Euace9ubrjpCRZ/xbZJjMYqvtJMZ7sqISv24U8jXMSP6CRQCwCr
         mOWONzgbAkmNjPpbe9nGEfN1fuRmiKgQbkDE5yoNZzeq2qwLiZ57lLRKN5ZQNjKRp2
         imjusysFrnfAN4nqrvEosB1GDWklr+wLsD+DXhiyxZf66cgCtODN9i/d2UYUYLBy7S
         kIFHSTKHYlhlpic5bGq/RK0ZK9KHqO1OwO6NjVJXgn7HWSPjMsEuUQeH64TAuZzQQw
         /Rm5d1+AMBagEIiHBaBbDKYVDeHH1yMQzDs1T1WxNSUpmpCODn94HgvNoPAhP+atxv
         lr5EDQrC+6qhA==
Message-ID: <b764c6d8-2a84-27f2-31e2-936c357f8111@gnuweeb.org>
Date:   Sun, 22 Jan 2023 15:54:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <65D9F1DE-96D4-4CC7-A21C-A740B7DDE0C8@zytor.com>
 <SA1PR11MB67344F0957245A2BC8CA57B7A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: RE: the x86 sysret_rip test fails on the Intel FRED architecture
In-Reply-To: <SA1PR11MB67344F0957245A2BC8CA57B7A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 3:22 PM, Li, Xin3 wrote:
> The problem is where/how to set %r11 = %rflags in the test code.
> 
> The check happens in the USER1 signal handler, and we could set %r11
> just before calling raise(SIGUSR1).  However, the C library implementation
> of raise() modifies %r11, thus we can't preserve %r11 until the SYSCALL
> instruction. And the test still fails.

 From "man 3 raise":

"""
The raise() function sends a signal to the calling process or thread.
In a single-threaded program it is equivalent to

         kill(getpid(), sig);
"""

Implementing kill syscall with %r11 modified before entering the kernel
may look like this?

static void __raise(int sig)
{
         __asm__ volatile (
                 "pushf\n\t"
                 "popq %%r11\n\t"
                 "syscall"
                 :
                 : "D"(getpid()),        /* %rdi */
                   "S"(sig),             /* %rsi */
                   "a"(__NR_kill)        /* %rax */
                 : "rcx", "r11", "memory"
         );
}

-- 
Ammar Faizi
