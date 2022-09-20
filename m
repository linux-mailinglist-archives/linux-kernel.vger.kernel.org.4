Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC185BEB52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiITQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiITQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:48:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F402CE17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:48:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v1so2960773plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=zKuBrrdfJL0TfYpOu0o4K8L560wLQ9dD1pUNEdIH8AM=;
        b=ioC8vEi+7eDN3d8CDmdWlFKldMS5Jc155idm4Vt62iGvWWOO+P/+s8iVGN8I1viMh/
         AUMrPub4g3m+MSDwikczNNcnztSNfwlds1ubbByLSEKsGUW4Kx4vlVAYpRFaqF+DSKU/
         EY/HkvxXXIm6ffEHDomU3aKzoj3KpUlRV2lReldiuPeGPS3qq+zwPlMC/EX+qYkezGU3
         xcr6c0AX7RqBpOKysfQxG527nILMCgVkZXnOYyYEOm3m7y7w945qW+lAbWBBMR52NqEX
         ZHYQtF1kmVIbrThV3g239J5uFYmQ+isnrOPlglvGMjghHVgtiG+XXLAbfPsb0z+HFJB8
         YsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zKuBrrdfJL0TfYpOu0o4K8L560wLQ9dD1pUNEdIH8AM=;
        b=Me1xPmqBMkSPobBD7Sv1f9ZdhVrdKAxfYLkvA70nUIsR2FjqOFEnOctyC0YInw3Oed
         YUwg0AhHV/Ig6MFRtAwvJ0JQtFr3ysQeLPIvD5IaBUFE8ge2JFJo96dnEiTLszOLO/lA
         4y5qkkjnELK4iPkXM0UH9/pHCK1bIWiSlUdQzsOvaYEa5WPMzVCNrM8Gxq1TnU1Bm+gk
         4VrPod4icBtauAjk+sLoxtQtzPWXD62P3E4sYouEmJft6Bx2caaqRd1+UjYNHkZHx/1B
         mEeA/Tj/7cJfqaWWwoPKWEM0pF0mrGBJoQIcMvK+EOzPB3ffOy/vvqSkw3MUHWOxVgb3
         2JAQ==
X-Gm-Message-State: ACrzQf1Ik7bjnMGKubdEeZCcvZycrGN4xlDaeuIlohWTkaTVTo7xYQI2
        LWRDwFpqXmKRBYr3sDvbGpU=
X-Google-Smtp-Source: AMsMyM5Z3Ukqku8Aq2W8pn7GS70UMJQsWF+y5XOtfvP3qPX/OGFpFnzuPNCJtmB/Wk9yy+POt6plzA==
X-Received: by 2002:a17:90b:1918:b0:200:ab1a:f47 with SMTP id mp24-20020a17090b191800b00200ab1a0f47mr4767237pjb.33.1663692494164;
        Tue, 20 Sep 2022 09:48:14 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id d185-20020a621dc2000000b00540b979c493sm130268pfd.55.2022.09.20.09.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:48:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Yymds595qthVSnt0@hirez.programming.kicks-ass.net>
Date:   Tue, 20 Sep 2022 09:48:10 -0700
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0F82355-EB17-46A3-82AA-CC0B26344A08@gmail.com>
References: <20220913135213.720368-1-namit@vmware.com>
 <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
 <Yymds595qthVSnt0@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
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

On Sep 20, 2022, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:

> On Mon, Sep 19, 2022 at 07:35:42PM -0700, Nadav Amit wrote:
>=20
>> 1. What is the reason that inline functions are marked with notrace?
>=20
> IIRC the concern is that a notrace function using an inline function;
> GCC deciding to not inline and then still hitting tracing.
>=20
> For noinstr we've mandated __always_inline to avoid this problem. The
> direct advantage is that those inlined into instrumented code get, =
well,
> instrumented.

I fully understand the __always_inline. I do not understand the inline,
which is a hint. Anyhow, I just thought that you would probably know, =
but
I=E2=80=99ll do the digging and look at the tables to see how they look =
with and
without inline implying notrace.

>=20
>> 2. Is probing function that is called from do_idle() supposed to =
work, or
>>   should the kernel prevent it?
>=20
> Should work for some :-) Specifically it doesn't work for those that
> disable RCU, and that's (largely) being fixed here:
>=20
>  =
https://lore.kernel.org/all/20220919095939.761690562@infradead.org/T/#u
>=20
> Although looking at it just now, I think I missed a spot.. lemme go =
fix
> ;-)
>=20

Thank you. I=E2=80=99ll give it a spin as soon as I finish some stuff =
(which can
be days).


> I'm failing to find this callchain; where is
> tick_nohz_get_sleep_length() calling to elfcorehdr_read() ?!?

Very strange. According to DWARF and disassembly, the call in the code =
is
actually to hrtimer_next_event_without() and nothing more, and
elfcorehdr_read+0x40/0x40 is actually after the ret.

The strangest part is that I actually collected additional similar =
crashes,
and I only now notice that all of them have elfcorehdr_read(). Good =
catch!
(which makes no sense)=E2=80=A6

I=E2=80=99ll move to a newer kernel, apply your patches and dig into it =
too.

Thanks again,
Nadav



>> [ 2381.892478]  elfcorehdr_read+0x40/0x40
>> [ 2381.896681]  tick_nohz_get_sleep_length+0x9d/0xc0
>> [ 2381.901955]  menu_select+0x4bb/0x630
>> [ 2381.905965]  cpuidle_select+0x16/0x20
>> [ 2381.910069]  do_idle+0x1d2/0x270
>> [ 2381.913689]  cpu_startup_entry+0x20/0x30
>> [ 2381.918086]  start_secondary+0x118/0x150
>> [ 2381.922484]  secondary_startup_64_no_verify+0xc3/0xcb
>> [ 2381.928147]  </TASK>
>> [ 2381.931535] Modules linked in: zram
>> [ 2381.936365] CR2: ffffc90077cb6e4b
>> [ 2381.940998] ---[ end trace 0000000000000000 ]=E2=80=94


