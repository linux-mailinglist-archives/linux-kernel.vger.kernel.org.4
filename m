Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC76B18A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCIBSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCIBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:18:10 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377B2A993
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:18:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e82so459931ybh.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678324688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfkfuVux5MI3FqeC+R5qOji3LmX+Ym2lI1Lut0jVNik=;
        b=iHxzuMJ17ojY8SbpEpe0rLv/JVQDCIQL+6+gqJ/us4Qxc3osCUFH7cEox27YnaPopn
         EuYMrdTVyXgpv7IXTf388GRia0vsuVho+q4BxfUj2knV7NZDKGjI9TAQgoIh/zXW8YOV
         nLXqp2oLlTsoSprWD/As6Y1I1H3NdTeOWVvXOgOItXMaNseXR6vkE73eRvLDgjuwhH6u
         H8cORd/9xdqtW4sqg3EG31Bu/a8WgLqtLanOZuyOgdvZRI9IMith3Gu44qjj5qoOqrX0
         mIItNdL3NSsxbUpxqE4T5RYb45AXWGtsGWbu3eIriRia+xz7mXQr2e9hhp5Rmmvhzbjn
         fsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678324688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfkfuVux5MI3FqeC+R5qOji3LmX+Ym2lI1Lut0jVNik=;
        b=Jzm6tx2B43ltP6c4WdYITeA89GyeteaathQe7S+KLgN8qDy6KGIdYdo/6c9LpaHr1T
         zK5uHtdVpUj96RLQzkoLF8mBKx0oyKsCESo92hcY7v4lRIqg+PR2ApdTAJk1WFR0zg/y
         t51jIu1rfXhsyelXBR43BG0ndIFJdxBdpBS/X4FrfPLGmncRoxA3gdTVtXpCzCWyfeYB
         lyFpgnFH6Ao6BYUP0Y9kQ6zuxLF9jMCWTVM/MXio+l4UZNlKS5zB5/6BXgiIkfOeCOXE
         TQYhxI2J+WE2WAjqNDmxtXQTI/TvnDIomvz+ygByteyMQ6XmX5ilwC67uxG3IpinPvvI
         kxlQ==
X-Gm-Message-State: AO0yUKXCwTKjWqMZeRm+8N0UaotqZyn9hKpahCJ70xit73Msxt742oYV
        BaMtUhEpfjwds6ZtA4NptIuQ2E/jJXZpxqmxTWzj
X-Google-Smtp-Source: AK7set8o9o7BN58xxFKCgEH/aJKw6WsWpysgxq3yKyVmUWbF6kQt+rrViU/BEgAbSoslLaqw/tfLU0esu7ryKUEWEes=
X-Received: by 2002:a5b:40e:0:b0:ac2:ffe:9cc9 with SMTP id m14-20020a5b040e000000b00ac20ffe9cc9mr12374822ybp.3.1678324687713;
 Wed, 08 Mar 2023 17:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com> <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
 <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com> <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
 <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com>
In-Reply-To: <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 8 Mar 2023 17:17:57 -0800
Message-ID: <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 10:44=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
> On 2023-02-17 6:11 p.m., John Stultz wrote:
> > On Tue, Feb 14, 2023 at 12:38 PM Liang, Kan <kan.liang@linux.intel.com>=
 wrote:
> >> On 2023-02-14 3:11 p.m., John Stultz wrote:
> >>> On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com=
> wrote:
> >>>> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
> >>>>> If I understand correctly, the idea is to let the user space tool r=
un
> >>>>> the above interpoloation algorithm several times to 'guess' the ato=
mic
> >>>>> mapping. Using the mapping information to covert the TSC from the P=
EBS
> >>>>> record. Is my understanding correct?
> >>>>>
> >>>>> If so, to be honest, I doubt we can get the accuracy we want.
> >>>>>
> >>>>
> >>>> I implemented a simple test to evaluate the error.
> >>>
> >>> Very cool!
> >>>
> >>>> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algor=
ithm
> >>>> at the start and end of perf cmd.
> >>>>         MONO_RAW        TSC
> >>>> start   89553516545645  223619715214239
> >>>> end     89562251233830  223641517000376
> >>>>
> >>>> Here is what I get via mult/shift conversion from this patch.
> >>>>         MONO_RAW        TSC
> >>>> PEBS    89555942691466  223625770878571
> >>>>
> >>>> Then I use the time information from start and end to create a linea=
r
> >>>> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
> >>>> 89555942692721.
> >>>> There is a 1255 ns difference.
> >>>> I tried several different PEBS records. The error is ~1000ns.
> >>>> I think it should be an observable error.
> >>>
> >>> Interesting. That's a good bit higher than I'd expect as I'd expect a
> >>> clock_gettime() call to take ~ double digit nanoseconds range on
> >>> average, so the error should be within that.
> >>>
> >>> Can you share your logic?
> >>>
> >>
> >> I run the algorithm right before and after the perf command as below.
> >> (The source code of time is attached.)
> >>
> >> $./time
> >> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
> >> $./time
> >>
> >> The time will dump both MONO_RAW and TSC. That's where "start" and "en=
d"
> >> from.
> >> The perf command print out both TSC and converted MONO_RAW (using the
> >> mul/shift from this patch series). That's where "PEBS" value from.
> >>
> >> Than I use the below formula to calculate the guessed MONO_RAW of PEBS=
 TSC.
> >> Guessed_MONO_RAW =3D (PEBS_TSC - start_TSC) / (end_TSC - start_TSC) *
> >> (end_MONO_RAW - start_MONO_RAW) + start_MONO_RAW.
> >>
> >> The guessed_MONO_RAW is 89555942692721.
> >> The PEBS_MONO_RAW is 89555942691466.
> >> The difference is 1255.
> >>
> >> Is the calculation correct?
> >
> > Thanks for sharing it. The equation you have there looks ok at a high
> > level for the values you captured (there's small tweaks like doing the
> > mult before the div to make sure you don't hit integer precision
> > issues, but I didn't see that with your results).
> >
> > I've got a todo to try to see how the calculation changes if we do
> > provide atomic TSC/RAW stamps, here but I got a little busy with other
> > work and haven't gotten to it.
> > So my apologies, but I'll try to get back to this soon.
> >
>
> Have you got a chance to try the idea?
>
> I just want to check whether the userspace interpolation approach works.
> Should I prepare V3 and go back to the kernel solution?

Oh, my apologies. I had some other work come up and this fell off my plate.

So I spent a little bit of time today adding some trace_printks to the
timekeeping code so I could record the actual TSC and timestamps being
calculated from CLOCK_MONOTONIC_RAW.

I did catch one error in the test code, which unfortunately I'm to blame fo=
r:
  mid =3D start + (delta +(delta/2))/2; //round-closest

That should be
  mid =3D start + (delta +(2/2))/2  //round-closest
or more simply
  mid =3D start + (delta +1)/2; //round-closest

Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
guessing with two as the divisor, my brain mixed it up and typed
"delta". My apologies!

With that fix, I'm seeing closer to ~500ns of error in the
interpolation, just using the userland sampling.   Now, I've also
disabled vsyscalls for this (otherwise I wouldn't be able to
trace_printk), so the error likely would be higher than with
vsyscalls.

Now, part of the error is that:
  start=3D rdtsc();
  clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
  end =3D rdtsc();

Ends up looking like
  start=3D rdtsc();
  clock_gettime() {
     now =3D rdtsc();
     delta =3D now - last;
     ns =3D (delta * mult) >> shift
[~midpoint~]
     ts->nsec =3D base_ns + ns;
     ts->sec =3D base_sec;
     normalize_ts(ts)
  }
  end =3D rdtsc();

And so by taking the mid-point we're always a little skewed from where
the tsc was actually read.  Looking at the data for my case the tsc
read seems to be ~12% in, so you could instead try:

delta =3D end - start;
p12 =3D start + ((delta * 12) + (100/2))/100;

With that adjustment, I'm seeing error around ~40ns.

Mind giving that a try?

Now, if you had two snapshots of MONOTONIC_RAW + the TSC value used to
calculate it(maybe the driver access this via a special internal
timekeeping interface), in my testing interpolating will give you
sub-ns error. So I think this is workable without exposing quite so
much to userland.

thanks
-john
