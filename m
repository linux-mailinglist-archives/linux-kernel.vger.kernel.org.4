Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB06B58CB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCKFzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCKFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:55:17 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943D124EA1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:55:14 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536af432ee5so140248657b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678514113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7NLyPxD29cFWzZa8mxU1X2SUKkr2XXw+0tUvnoauO8=;
        b=UC2nFzJwgu/MNMxM33KOG7ZabfG0hQUpKt1jAYhgfUoTBEZbj0QqtKD1WtAUyZD/j2
         7nJXiZEeH+6Zgv0/yhb05GPQyd98sbvomeqcWsAJy3zSXV5N87BAXdEi7kD5edeTiWuS
         NkTyTj/GPGQYYsI6AfPrYxav+qkrh/n7fTNIbFGmtzh3x7uTskI4dVbk1MsZ1vkohIMF
         /q9iv4Q6XhAB8l8fhHZ2qq1Ly2DJgU5rCJ8waGd0r1OvtNmdUIxL1eScj5J9Ubr0de98
         n9tgIaKYHioxXlwRVWfOTS+iCai4rzwT9UGS/g5r5QG2UQels6GUT5CPK4y+Bch6Z914
         +Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678514113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7NLyPxD29cFWzZa8mxU1X2SUKkr2XXw+0tUvnoauO8=;
        b=HVw5gioNRUenO9TkgFBFhoEiNs/LKN73xcQ12Lx17zLsW/UChGgad+tUxs8v/3aHou
         S0GlJac/QPPmbMifA/ANqMrxHEpBSPe73TEomrqvkchTBF6WOYk2D6/vfQmRTnwGBywP
         hql6fb9XobJQnJx3Q/IvSFTTvfvro2O2fL8Wt+pzeYRfGph/gFkMnXYYalP42bTRFgVK
         89P6aF15WwXiogVziC8hs+xlCjyDep02qSAoASHyqfUNqp2LyEH6oYEtcrva8dmwP5bJ
         fIM4NDrk9Yp9u5W9YZ2BJtBf+hMn84OC+G+OZfy+9HRsHfU1ZElRjygk7uu1+GOYFC57
         Dk1g==
X-Gm-Message-State: AO0yUKV5jjXL2H6i2VjhQxfcwmH9xClVlp1KU9QAHFdvu4upp12SWs27
        Rs4Y+lUfNkEQonWD2Bevv2jiZnoiHBLBxVT6Y9ADiSvmbMKwTwbrj0p+
X-Google-Smtp-Source: AK7set87QxFUGF7177Yibau48lChpyF2F669/aYuhNcAbn3fZ3GBEUkJcnVMWg1ETSvdG/PTjAiL7dQmmWnpGzmeYL4=
X-Received: by 2002:a81:b604:0:b0:52f:2695:5d05 with SMTP id
 u4-20020a81b604000000b0052f26955d05mr17017920ywh.3.1678514113526; Fri, 10 Mar
 2023 21:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com> <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
 <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com> <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
 <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com> <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
 <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com>
In-Reply-To: <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 10 Mar 2023 21:55:03 -0800
Message-ID: <CANDhNCq7a7DBhb83veKtVOOkGpHLssgd4JpQ552B40YK51cLsg@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 8:56=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
> On 2023-03-08 8:17 p.m., John Stultz wrote:
> > So I spent a little bit of time today adding some trace_printks to the
> > timekeeping code so I could record the actual TSC and timestamps being
> > calculated from CLOCK_MONOTONIC_RAW.
> >
> > I did catch one error in the test code, which unfortunately I'm to blam=
e for:
> >   mid =3D start + (delta +(delta/2))/2; //round-closest
> >
> > That should be
> >   mid =3D start + (delta +(2/2))/2  //round-closest
> > or more simply
> >   mid =3D start + (delta +1)/2; //round-closest
> >
> > Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
> > guessing with two as the divisor, my brain mixed it up and typed
> > "delta". My apologies!
> >
> > With that fix, I'm seeing closer to ~500ns of error in the
> > interpolation, just using the userland sampling.   Now, I've also
> > disabled vsyscalls for this (otherwise I wouldn't be able to
> > trace_printk), so the error likely would be higher than with
> > vsyscalls.
> >
> > Now, part of the error is that:
> >   start=3D rdtsc();
> >   clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
> >   end =3D rdtsc();
> >
> > Ends up looking like
> >   start=3D rdtsc();
> >   clock_gettime() {
> >      now =3D rdtsc();
> >      delta =3D now - last;
> >      ns =3D (delta * mult) >> shift
> > [~midpoint~]
> >      ts->nsec =3D base_ns + ns;
> >      ts->sec =3D base_sec;
> >      normalize_ts(ts)
> >   }
> >   end =3D rdtsc();
> >
> > And so by taking the mid-point we're always a little skewed from where
> > the tsc was actually read.  Looking at the data for my case the tsc
> > read seems to be ~12% in, so you could instead try:
> >
> > delta =3D end - start;
> > p12 =3D start + ((delta * 12) + (100/2))/100;
> >
> > With that adjustment, I'm seeing error around ~40ns.
> >
> > Mind giving that a try?
>
> I tried both the new mid and p12. The error becomes even larger.
>
> With new mid (start + (delta +1)/2), the error is now ~3800ns
> With p12 adjustment, the error is ~6700ns.
>
>
> Here is how I run the test.
> $./time
> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
> $./time
>
> Here are some raw data.
>
> For the first ./time,
> start: 961886196018
> end: 961886215603
> MONO_RAW: 341485848531
>
> For the second ./time,
> start: 986870117783
> end: 986870136152
> MONO_RAW: 351495432044
>
> Here is the time generated from one PEBS record.
> TSC: 968210217271
> PEBS_MONO_RAW (calculated via kernel conversion information): 34401950307=
2
>
> Using new mid (start + (delta +1)/2), the guessed PEBS_MONO_RAW is
> 344019506897. The error is 3825ns.
> Using p12 adjustment, the guessed PEBS_MONO_RAW is 344019509831.
> The error is 6759ns

Huh. I dunno. That seems wild that the error increased.

Just in case something is going astray with the PEBS_MONO_RAW logic,
can you apply the hack patch I was using to display the MONOTONIC_RAW
values the kernel calculates?
  https://github.com/johnstultz-work/linux-dev/commit/8d7896b078965b059ea5e=
8cc21841580557f6df6

It uses trace_printk, so you'll have to cat /sys/kernel/tracing/trace
to get the output.

thanks
-john
