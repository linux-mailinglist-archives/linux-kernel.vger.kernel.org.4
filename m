Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7501676BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAVJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAVJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:43:26 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237716AE7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:43:24 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30M9epow1888407
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 22 Jan 2023 01:40:52 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30M9epow1888407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674380454;
        bh=BUz7GySCcyAaeNBP7q6NLLHUXrPwckpAejmAkm7+des=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AQ3ABt0lp2SQB8E82SgyW3dnjU/a1OQ23VLLo0jLS0XCjhSlyGwf9EUly0ZUCzITV
         KByl50AQW51N4Daa3z/fEUVu3fVelLNIwyxeylIuDFnKMLoguce8HS5HDbXAwY5StM
         WyrRWWd5I1h8SNmXmlqzRB7ifMpYgpONTqMKcjW8Ht9Wfcq87Yj+NK7O8x00gMPDCE
         PXg0PAnDYlnowO9kO4A0nAFBAGHqy8LPlY6+46ZZlz0TdBQRE6lMlRonPycflH5tzH
         0Ftq6TSKm+dxyzVhlUs4lFFVtUcWQttBCHEhAjdMyD/GNCqPnaLTYi5x0N1280bd89
         473RAiS09YAKA==
Date:   Sun, 22 Jan 2023 01:40:49 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Li, Xin3" <xin3.li@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RE: the x86 sysret_rip test fails on the Intel FRED architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <b764c6d8-2a84-27f2-31e2-936c357f8111@gnuweeb.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <65D9F1DE-96D4-4CC7-A21C-A740B7DDE0C8@zytor.com> <SA1PR11MB67344F0957245A2BC8CA57B7A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b764c6d8-2a84-27f2-31e2-936c357f8111@gnuweeb.org>
Message-ID: <9300A0A3-B5DD-438A-911B-EEB6C1697B03@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 22, 2023 12:54:56 AM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg=
> wrote:
>On 1/22/23 3:22 PM, Li, Xin3 wrote:
>> The problem is where/how to set %r11 =3D %rflags in the test code=2E
>>=20
>> The check happens in the USER1 signal handler, and we could set %r11
>> just before calling raise(SIGUSR1)=2E  However, the C library implement=
ation
>> of raise() modifies %r11, thus we can't preserve %r11 until the SYSCALL
>> instruction=2E And the test still fails=2E
>
>From "man 3 raise":
>
>"""
>The raise() function sends a signal to the calling process or thread=2E
>In a single-threaded program it is equivalent to
>
>        kill(getpid(), sig);
>"""
>
>Implementing kill syscall with %r11 modified before entering the kernel
>may look like this?
>
>static void __raise(int sig)
>{
>        __asm__ volatile (
>                "pushf\n\t"
>                "popq %%r11\n\t"
>                "syscall"
>                :
>                : "D"(getpid()),        /* %rdi */
>                  "S"(sig),             /* %rsi */
>                  "a"(__NR_kill)        /* %rax */
>                : "rcx", "r11", "memory"
>        );
>}
>

Exactly=2E
