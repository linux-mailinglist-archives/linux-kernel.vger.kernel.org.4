Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8155BDA31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiITCfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiITCfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:35:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79174CA28
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:35:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so1009551plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=9nWIM17mTcgh9Q37repwwcTWWA9WuOiLQelaUHtuLb8=;
        b=b0d8tmHVaHoOczhw9MAln9SeiQ8Us9Hor9lYX8lRIuFf0BQePbZNyvlr048wbXVqiZ
         xP4uD2qe1xKKXdVld/npiAgVb7IxiR7L7sRnrtGPIgz/niWCAOm0e0UjZro1Xse4mEN3
         dxbGT1of2bBYHbELbzQwS0HNzTSHtOXee2jQW3ChXIihhbv5tvOhihhUH93lTFoJgmUl
         htaYLW5crhjh1/v55zW0cXtwOhPH0EfwbStgqxl8QnamPCm2LHQLIf37gB9NlGeZ/uuE
         s5M9clmlAavQ89MCeVGqvTsdlMN69h7HSAuF5LFslfpwvfMq2Dz68lIrBGMiQaOwHLHu
         UKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9nWIM17mTcgh9Q37repwwcTWWA9WuOiLQelaUHtuLb8=;
        b=OV4zQZhYNzoNEjkMqNGeZntejX0Qbxc9X0uPyrhWLTU4bnxu0qK5jEDI+XjxWYTPvU
         bF8K3gIiIJgJ/bDlWjJw7FuTuX6HWH9/awzXZzGrTCKbrbUWOzfcuO0HM6h7p96GdHwB
         K+ATch59wI2jzQBqLgUErzuJsaI5B9kodjos4wJVGYVvjFC9LQEqAF98w1UWWrrhl2fg
         qHubAM8TCKA7HzsRdSbHgK3tS41oyb3Yy3CoWa0Ar5MpvpZm9bXb+FgFauxQiHiFN494
         G5+Xgz3xV4pVyZ5XXsaRwpJYoFS2A6l2pRAIZbsSQ4LYHBG3vui7PkKm8nmF2JwKcMhZ
         R+Fw==
X-Gm-Message-State: ACrzQf2wqBFIR1ED3Ct4OEbOz+iymjQRmgwdtKXYzcq3nyFBiVfi8eL2
        tm7BsZXBPoV+4N1kr5c5ElQ=
X-Google-Smtp-Source: AMsMyM6JdC8aobc1KmBEZhw1SfRimGPFEFmOmjloIZTgwYPUbIE2nNmMieqp4b2Xr067W7qP9H0iQg==
X-Received: by 2002:a17:90b:4f84:b0:202:dd39:c03d with SMTP id qe4-20020a17090b4f8400b00202dd39c03dmr1359457pjb.63.1663641345778;
        Mon, 19 Sep 2022 19:35:45 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7988d000000b0052dfe83e19csm139502pfl.16.2022.09.19.19.35.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:35:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220913135213.720368-1-namit@vmware.com>
Date:   Mon, 19 Sep 2022 19:35:42 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
References: <20220913135213.720368-1-namit@vmware.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2022, at 6:52 AM, Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
>=20
> Tracing - through ftrace function tracer and kprobes - of certain =
common
> syscall functions is currently disabled. Setting kprobes on these
> functions is specifically useful for debugging of syscall failures.
>=20
> Such tracing is disabled since __do_sys_[syscall] functions are =
declared
> as "inline".  "inline" in the kernel is actually defined as a macro =
that
> in addition to using the inline keyword also disables tracing =
(notrace).
> According to the comments in the code, tracing inline functions can
> wreck havoc, which is probably true in some cases.
>=20
> In practice, however, this might be too extensive. The compiler =
regards
> the "inline" keyword only as a hint, which it is free to ignore. In
> fact, in my builds gcc ignores the "inline" hint for many
> __do_sys_[syscall] since some of these functions are quite big and
> called from multiple locations (for compat). As a result, these
> functions cannot be traced.
>=20
> There are 3 possible solutions for enabling the tracing of
> __do_sys_[syscall]:
>=20
> 1. Mark __do_sys_[syscall] as __always_inline instead of inline. This
>   would increase the executable size, which might not be desired.
>=20
> 2. Remove the inline hint from __do_sys_[syscall]. Again, it might
>   affect the generated code, inducing function call overhead for some
>   syscalls.
>=20
> 3. Remove "notrace" from the "inline" macro definition, and require
>   functions that cannot be traced to be marked explicitly as =
"notrace".
>   This might be the most correct solution, which would also enable =
tracing
>   of additional useful functions. But finding the functions that =
cannot
>   be traced is not easy without some automation.
>=20
> 4. Avoid the use of "notrace" specifically for __do_sys_[syscall].

Steven, Peter, assistance would be helpful now that you are hopefully =
less
busy.

Using kprobes, I repeatedly get various crashes such as the one below =
that
happen in functions that are called from do_idle(). I am not sure that I =
get
exactly the reason (although it seems to be related to the RCU). The =
traces
for some reason show that when I patch a 2 byte JCC instruction and the =
RIP
always points to the second byte of the instructions, which I would not
expect to ever happen.

So basically, I have two questions for you:

1. What is the reason that inline functions are marked with notrace?

2. Is probing function that is called from do_idle() supposed to work, =
or
   should the kernel prevent it?

Thanks,
Nadav


[ 2381.637652] BUG: unable to handle page fault for address: =
ffffc90077cb6e4b
[ 2381.645568] #PF: supervisor read access in kernel mode
[ 2381.651367] #PF: error_code(0x0000) - not-present page
[ 2381.657155] PGD 100000067 P4D 100000067 PUD 0=20
[ 2381.662154] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 2381.667040] CPU: 19 PID: 0 Comm: swapper/19 Not tainted 5.17.0-rc4 #6
[ 2381.674749] Hardware name: Cisco Systems Inc =
UCSC-C220-M5SX/UCSC-C220-M5SX, BIOS C220M5.4.0.1i.0.0522190226 =
05/22/2019
[ 2381.686733] RIP: 0010:poke_int3_handler+0x6d/0x140
[ 2381.692108] Code: 32 31 c0 48 81 c6 00 00 00 81 48 39 f1 74 39 f0 41 =
ff 08 c3 31 c0 c3 49 89 d3 49 89 c2 49 d1 ea 4c 89 d2 48 c1 e2 04 4c 01 =
da <48> 63 32 48 81 c6 00 00 00 81 48 39 f1 0f 82 b7 00 00 00 0f 87 98
[ 2381.713139] RSP: 0000:ffffc9000c6a7c90 EFLAGS: 00010086
[ 2381.718994] RAX: 000000000d4f7e0a RBX: 0000000000000000 RCX: =
ffffffff81226ffb
[ 2381.726990] RDX: ffffc90077cb6e4b RSI: ffffffff82400a99 RDI: =
ffffc9000c6a7cb8
[ 2381.734986] RBP: ffffc9000c6a7ca8 R08: ffffc9000d4f7d84 R09: =
ffffffff81226ffc
[ 2381.742979] R10: 0000000006a7bf05 R11: ffffc9000d4f7dfb R12: =
ffffc9000c6a7cb8
[ 2381.750974] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[ 2381.758966] FS:  0000000000000000(0000) GS:ffff88afe3740000(0000) =
knlGS:0000000000000000
[ 2381.768031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2381.774469] CR2: ffffc90077cb6e4b CR3: 000000000680a001 CR4: =
00000000007706e0
[ 2381.782462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 2381.790455] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 2381.798447] PKRU: 55555554
[ 2381.801481] Call Trace:
[ 2381.804224]  <TASK>
[ 2381.806575]  ? exc_int3+0x10/0xd0
[ 2381.810292]  asm_exc_int3+0x31/0x40
[ 2381.814205] RIP: 0010:__hrtimer_next_event_base+0x6c/0xe0
[ 2381.820260] Code: 01 00 00 00 48 8b 41 28 49 39 c6 74 67 48 c1 e6 06 =
48 8b 50 18 4a 2b 54 26 78 4c 39 ea 7d 08 49 89 d5 4d 85 f6 74 40 85 db =
cc <21> 44 89 f8 89 d9 f3 48 0f bc c9 d3 e0 89 ce 89 c9 48 83 c1 01 f7
[ 2381.841292] RSP: 0000:ffffc9000c6a7d98 EFLAGS: 00000046
[ 2381.847148] RAX: ffff88afe3763960 RBX: 0000000000000000 RCX: =
ffff88afe3763200
[ 2381.855141] RDX: 0000022a7fa0e539 RSI: 0000000000000000 RDI: =
ffff88afe37631c0
[ 2381.863133] RBP: ffffc9000c6a7dc8 R08: 00000066a1725854 R09: =
000002490d303b39
[ 2381.871117] R10: ffff88afe376fba4 R11: ffff88afe376fb84 R12: =
ffff88afe37631c0
[ 2381.879109] R13: 0000022a7fa0e539 R14: ffff88afe3763700 R15: =
0000000000000001
[ 2381.887107]  ? __hrtimer_next_event_base+0x6c/0xe0
[ 2381.892478]  elfcorehdr_read+0x40/0x40
[ 2381.896681]  tick_nohz_get_sleep_length+0x9d/0xc0
[ 2381.901955]  menu_select+0x4bb/0x630
[ 2381.905965]  cpuidle_select+0x16/0x20
[ 2381.910069]  do_idle+0x1d2/0x270
[ 2381.913689]  cpu_startup_entry+0x20/0x30
[ 2381.918086]  start_secondary+0x118/0x150
[ 2381.922484]  secondary_startup_64_no_verify+0xc3/0xcb
[ 2381.928147]  </TASK>
[ 2381.931535] Modules linked in: zram
[ 2381.936365] CR2: ffffc90077cb6e4b
[ 2381.940998] ---[ end trace 0000000000000000 ]---

