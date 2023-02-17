Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D469B653
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBQXNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBQXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:13:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D759726
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:13:00 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id h3so2690637ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwwj1bF3gwXWIenxKT0bdfIOktYXG/UwGuLof/OlNNU=;
        b=WE2FKK6V9oIJaQ9lReqLrjWArqEJZcFx1vIwA1KQ8nlF8OTWIPcSrf3bcEn72ZjWfl
         /hBldIMaCHcoqpL6h4cP8LkqVJHSGJlWko21fGpEjaIEKJ0CmQgVlnkwRAxpx7YtJTJ2
         Ogv++7qqGH0B5VjUzIY0EIzFLKUzN5qspMsPWcuIvg6wcHEfqSa9IzQa3aN6glBQREd7
         AR7vQvvF1W1AWfBcs3p/zJLkyzW3mdKgZT8khYIFtFqhNboZkx1/9NMppIUBYMZiXs5l
         DJq5tsh+hDxBvdogYDBenrwP/ShFW5O6R72Q2QJFErclszwwpWKKwlkedBCMth/fDHi8
         LX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwwj1bF3gwXWIenxKT0bdfIOktYXG/UwGuLof/OlNNU=;
        b=tcEck8QS5bQ3YWC5yKBorEIOpvoGJ2ouGHXfNYLw61cEHJrAw3cCQjvwi3VddUhGgX
         +xPI0TTmWpELt4cJn5j8+LseIzzFGt/uWAv4sCPX/hsjirdKAp/yuWxtP2RYqpFWwz3K
         EoaCWgE+6Kd2ZAUHETTtp4FS81IaBYMsMPJrQFy8Dbxdygas1+rkRc51ivGudSELapSR
         J9gx+XqnL1RFq++xbbPA1HHrjQd0+xex8oGL3DVC9i5B6snzkat1RNWpODHl8GOiDlFs
         yd5458BytbfbWIPU4gfHgi8ZlWcRuU+7S0W74cB5G92rjxKLhf2ixToIPE0gsK8iaVdl
         VGSw==
X-Gm-Message-State: AO0yUKV7yCarLuNji4+Rpcz/qppApDli5PolkAHuCrH5jAU6GTW6Gcr0
        Q3uCLFKAWnKP9xPE2hU95dr6yxfMPOmxzakuqM6h
X-Google-Smtp-Source: AK7set8RjKogH7WXBDvBJZd6sp0xcr4+HOszKalXQDjkyWay2WkQFXIxr9DYbNAA66HY70HXMIkCYb8ja3QwN2YD6Oo=
X-Received: by 2002:a5b:18e:0:b0:96c:c73d:5f73 with SMTP id
 r14-20020a5b018e000000b0096cc73d5f73mr545911ybl.49.1676675518686; Fri, 17 Feb
 2023 15:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com> <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com> <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com>
In-Reply-To: <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 17 Feb 2023 15:11:47 -0800
Message-ID: <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 14, 2023 at 12:38 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-14 3:11 p.m., John Stultz wrote:
> > On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
> >>> If I understand correctly, the idea is to let the user space tool run
> >>> the above interpoloation algorithm several times to 'guess' the atomic
> >>> mapping. Using the mapping information to covert the TSC from the PEBS
> >>> record. Is my understanding correct?
> >>>
> >>> If so, to be honest, I doubt we can get the accuracy we want.
> >>>
> >>
> >> I implemented a simple test to evaluate the error.
> >
> > Very cool!
> >
> >> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
> >> at the start and end of perf cmd.
> >>         MONO_RAW        TSC
> >> start   89553516545645  223619715214239
> >> end     89562251233830  223641517000376
> >>
> >> Here is what I get via mult/shift conversion from this patch.
> >>         MONO_RAW        TSC
> >> PEBS    89555942691466  223625770878571
> >>
> >> Then I use the time information from start and end to create a linear
> >> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
> >> 89555942692721.
> >> There is a 1255 ns difference.
> >> I tried several different PEBS records. The error is ~1000ns.
> >> I think it should be an observable error.
> >
> > Interesting. That's a good bit higher than I'd expect as I'd expect a
> > clock_gettime() call to take ~ double digit nanoseconds range on
> > average, so the error should be within that.
> >
> > Can you share your logic?
> >
>
> I run the algorithm right before and after the perf command as below.
> (The source code of time is attached.)
>
> $./time
> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
> $./time
>
> The time will dump both MONO_RAW and TSC. That's where "start" and "end"
> from.
> The perf command print out both TSC and converted MONO_RAW (using the
> mul/shift from this patch series). That's where "PEBS" value from.
>
> Than I use the below formula to calculate the guessed MONO_RAW of PEBS TSC.
> Guessed_MONO_RAW = (PEBS_TSC - start_TSC) / (end_TSC - start_TSC) *
> (end_MONO_RAW - start_MONO_RAW) + start_MONO_RAW.
>
> The guessed_MONO_RAW is 89555942692721.
> The PEBS_MONO_RAW is 89555942691466.
> The difference is 1255.
>
> Is the calculation correct?

Thanks for sharing it. The equation you have there looks ok at a high
level for the values you captured (there's small tweaks like doing the
mult before the div to make sure you don't hit integer precision
issues, but I didn't see that with your results).

I've got a todo to try to see how the calculation changes if we do
provide atomic TSC/RAW stamps, here but I got a little busy with other
work and haven't gotten to it.
So my apologies, but I'll try to get back to this soon.

thanks
-john
