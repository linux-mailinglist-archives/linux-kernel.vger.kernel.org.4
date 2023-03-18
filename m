Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CB6BF838
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 07:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCRGDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 02:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCRGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:03:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0604D408
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 23:03:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e71so7848782ybc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679119382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wDUMthQ6l3BQ57KAyFT6dJbioFNIhKz4dPPNgbs71k=;
        b=hmbn9kZynJ7wWCvaFKgcWtSIS/IqjJ0RlFqfGvusn7u2OI9W3O4wryK9UYbnFFRdJu
         +X8oL/9WxXEADgNU7zXdQ8rEhMNQ4xAKuRHCV7HE3d7Ilt9j2az8CMPJwXLMA7Y1i3Vk
         aiQKaFBcIvL2CdChcsjdwzic2n8plmf+WRgV2hmclSgaemmXNYiDK9mqXexcgmahYCLK
         13r2DWH0CqS2uAGjHSKNVEeqrWPEOZu9Xkl2Vd2zIvVbmzum7LXEc/shb98FK3GK8kvz
         uAyNO5Loytvt3fMM5GYiqsZAx4xP4xJUweIqJNhncQ/SGUTln70H4QD6ga6nv7wCxsVA
         L+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wDUMthQ6l3BQ57KAyFT6dJbioFNIhKz4dPPNgbs71k=;
        b=aDR2asoHK29WPSd64VWh4dpk/BlXNxo68gz5tAUdNuak9L68/RTPqysQzCPMsPeD8U
         axlB3RTrKinnu7ncCgd4ePEAE4wtAxZD7FRu5WG1ED2/NqW/s2L30ncMclzVGO+qlds+
         htkYF76SAI0rkFBzYDcRhaUbQyuZxxfJeRql4m5PT8et4bJS+6qncW2YLsJeGePxW4wD
         RmCjLWQPpHell3P8TZGpmnr7t3shU/jRWSpHciNU87qeftIVjTeq96JmUaJowX4ZJtng
         bKtmqzfTo0f6M53XE1c9v4YARcR2jdhHwuOfix//nptMnslAlgZ1YbtJ7zl491HuT8GR
         gn5A==
X-Gm-Message-State: AO0yUKVIQ6P7c/VC7HPRyIojHCBYIAvaWks/hMnpnt++mjFE9k3LI2Mw
        3ED2+1cxo/F4SilmuSCxiynLQEr5r5X2UO5JUZ+Q
X-Google-Smtp-Source: AK7set8ORN8xJX9jFTVsUfzG8imm0dkFu5gM6DQzl5I8f7lrIzOgSd4LRrImVGPEGR3k/Q56fDkkXO6rG5/cRYtkaZI=
X-Received: by 2002:a5b:152:0:b0:b3d:c59:4d26 with SMTP id c18-20020a5b0152000000b00b3d0c594d26mr700475ybp.5.1679119381666;
 Fri, 17 Mar 2023 23:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com> <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
 <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com> <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
 <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com> <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
 <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com> <CANDhNCq7a7DBhb83veKtVOOkGpHLssgd4JpQ552B40YK51cLsg@mail.gmail.com>
 <76362685-0250-ef03-e6b9-e905a1bfd942@linux.intel.com>
In-Reply-To: <76362685-0250-ef03-e6b9-e905a1bfd942@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 17 Mar 2023 23:02:50 -0700
Message-ID: <CANDhNComKRDdZJ8SJECNdoAzQhmR3vu9yKAtp7NKDmECxff=fg@mail.gmail.com>
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

On Mon, Mar 13, 2023 at 2:19=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-03-11 12:55 a.m., John Stultz wrote:
> > On Thu, Mar 9, 2023 at 8:56=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >> On 2023-03-08 8:17 p.m., John Stultz wrote:
> >>> So I spent a little bit of time today adding some trace_printks to th=
e
> >>> timekeeping code so I could record the actual TSC and timestamps bein=
g
> >>> calculated from CLOCK_MONOTONIC_RAW.
> >>>
> >>> I did catch one error in the test code, which unfortunately I'm to bl=
ame for:
> >>>   mid =3D start + (delta +(delta/2))/2; //round-closest
> >>>
> >>> That should be
> >>>   mid =3D start + (delta +(2/2))/2  //round-closest
> >>> or more simply
> >>>   mid =3D start + (delta +1)/2; //round-closest
> >>>
> >>> Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
> >>> guessing with two as the divisor, my brain mixed it up and typed
> >>> "delta". My apologies!
> >>>
> >>> With that fix, I'm seeing closer to ~500ns of error in the
> >>> interpolation, just using the userland sampling.   Now, I've also
> >>> disabled vsyscalls for this (otherwise I wouldn't be able to
> >>> trace_printk), so the error likely would be higher than with
> >>> vsyscalls.
> >>>
> >>> Now, part of the error is that:
> >>>   start=3D rdtsc();
> >>>   clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
> >>>   end =3D rdtsc();
> >>>
> >>> Ends up looking like
> >>>   start=3D rdtsc();
> >>>   clock_gettime() {
> >>>      now =3D rdtsc();
> >>>      delta =3D now - last;
> >>>      ns =3D (delta * mult) >> shift
> >>> [~midpoint~]
> >>>      ts->nsec =3D base_ns + ns;
> >>>      ts->sec =3D base_sec;
> >>>      normalize_ts(ts)
> >>>   }
> >>>   end =3D rdtsc();
> >>>
> >>> And so by taking the mid-point we're always a little skewed from wher=
e
> >>> the tsc was actually read.  Looking at the data for my case the tsc
> >>> read seems to be ~12% in, so you could instead try:
> >>>
> >>> delta =3D end - start;
> >>> p12 =3D start + ((delta * 12) + (100/2))/100;
> >>>
> >>> With that adjustment, I'm seeing error around ~40ns.
> >>>
> >>> Mind giving that a try?
> >>
> >> I tried both the new mid and p12. The error becomes even larger.
> >>
> >> With new mid (start + (delta +1)/2), the error is now ~3800ns
> >> With p12 adjustment, the error is ~6700ns.
> >>
> >>
> >> Here is how I run the test.
> >> $./time
> >> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
> >> $./time
> >>
> >> Here are some raw data.
> >>
> >> For the first ./time,
> >> start: 961886196018
> >> end: 961886215603
> >> MONO_RAW: 341485848531
> >>
> >> For the second ./time,
> >> start: 986870117783
> >> end: 986870136152
> >> MONO_RAW: 351495432044
> >>
> >> Here is the time generated from one PEBS record.
> >> TSC: 968210217271
> >> PEBS_MONO_RAW (calculated via kernel conversion information): 34401950=
3072
> >>
> >> Using new mid (start + (delta +1)/2), the guessed PEBS_MONO_RAW is
> >> 344019506897. The error is 3825ns.
> >> Using p12 adjustment, the guessed PEBS_MONO_RAW is 344019509831.
> >> The error is 6759ns
> >
> > Huh. I dunno. That seems wild that the error increased.
> >
> > Just in case something is going astray with the PEBS_MONO_RAW logic,
> > can you apply the hack patch I was using to display the MONOTONIC_RAW
> > values the kernel calculates?
> >   https://github.com/johnstultz-work/linux-dev/commit/8d7896b078965b059=
ea5e8cc21841580557f6df6
> >
> > It uses trace_printk, so you'll have to cat /sys/kernel/tracing/trace
> > to get the output.
> >
>
>
> $ ./time_3
> start: 7358368893806 end: 7358368902944 delta: 9138
> MONO_RAW: 2899739790738
> MID: 7358368898375
> P12: 7358368894903
> $ sudo cat /sys/kernel/tracing/trace | grep time_3
>           time_3-1443    [002] .....  2899.858936: ktime_get_raw_ts64:
> JDB: timekeeping_get_delta cycle_now: 7358368897679
>           time_3-1443    [002] .....  2899.858937: ktime_get_raw_ts64:
> JDB: ktime_get_raw_ts64: 2899739790738
>
> The error between MID and cycle_now is -696ns
> The error between P12 and cycle_now is 2776ns

Hey Kan,
  So I'm terribly sorry, I'm a bit underwater right now and haven't
had time to look deeper at this. The MID case you have above looks
closer to what I was seeing but I can't explain why the 12% case is
worse.

Since I feel it's not really fair to object to your patch but not have
the time to work through an alternative with you, I'm going to
withdraw my objection (though others may persist!).
I'd still really prefer if we avoided exposing internal timekeeping
state directly to userland, and it would be good to see some further
exploration in other directions, but there is the existing perf mmap
precedence (even if I dislike it).   Sorry I can't be of more help to
find a better approach here. :(

thanks
-john
