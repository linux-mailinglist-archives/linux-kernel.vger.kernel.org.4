Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E16953D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBMWXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBMWXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:23:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB56CA09
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:22:53 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i137so7276658ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aEhZU2tjgxgx4gUNpwE1dTHD6gZf4GTEmF74G7k/PYQ=;
        b=F9TW3ieWJfw7obfnndlumToKLbiFKDkJANQF4eWUPbLO97hCHUzf9kdL1nCPfXIK1m
         p+xb2LkHH/mgSqbKURZ1oMK7uJoGXMg61/4hRm58kajo9h5apmdDLJddnDPgHyOG/SvM
         fmHc94CYvRq5JeHP1A3glrltDo1MwXFT51TCUHRbyNHyHXZStLXITqgnOHWEMdw7H1mY
         ZS+ObVIlaVsbP+TGr9gYwtdprsPknXJbkMYv0gUJgsF4V5VZLqkiu7P+BguyZo/17NWW
         UlmhKTUa614Qn4vQxVqJDo0hATFsuQpqZVrfHC/Q2tEd6RFwsijyXKybf8mSImcw4bCt
         jdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEhZU2tjgxgx4gUNpwE1dTHD6gZf4GTEmF74G7k/PYQ=;
        b=EJmoDUDQWYvDOegnqH7MddFQ8+mtVpAE2pl968HJanNReAf7HjNN1S0RHIV4SDLYx4
         6gowbgUoO5mMg37dpCMh9e3ZYw5lPsv4594V7PQfTEeu/lIdV5d/i5kg5GrUFmI1nJc8
         wcSGnHNvKU4RwcgvV1a6z0fA7FS9yei+CaSXbtd3aEMghC+5oe+OZYAujsUEPF0V5G6X
         RtNXqzytYIdMI2ZjdypyyA2LX0B1W3QPz5auLjWcWlq7CH5sNC4gfMdVUu51mTHZrAZr
         1rZRwwd4vKcqlg9gF3/N8dbWaTBkkZ8T6hzCHu1OvA+SQfT3RUMbH9TI+zxBK2ORVlmw
         YXQw==
X-Gm-Message-State: AO0yUKWsVvpHczJktVWtjZVvN80VYeYofbSmbn/YlZvNaaqNHT169Sme
        TyrI4tfq4AHYMNtZV6g5KVfnFiigSB0bymsLTo6z
X-Google-Smtp-Source: AK7set/VD2XbjGCWMn720W1KjUKN1TbAjHIjAnb416DrptoFwCM5jxLa46vXciW0MA6ShQYHKrDICYV7eDxgebj7oT4=
X-Received: by 2002:a25:8a09:0:b0:80b:83b0:c87e with SMTP id
 g9-20020a258a09000000b0080b83b0c87emr45320ybl.360.1676326971470; Mon, 13 Feb
 2023 14:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
In-Reply-To: <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Feb 2023 14:22:39 -0800
Message-ID: <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
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

On Mon, Feb 13, 2023 at 1:40 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-13 2:37 p.m., John Stultz wrote:
> > On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The monotonic raw clock is not affected by NTP/PTP correction. The
> >> calculation of the monotonic raw clock can be done in the
> >> post-processing, which can reduce the kernel overhead.
> >>
> >> Add hw_time in the struct perf_event_attr to tell the kernel dump the
> >> raw HW time to user space. The perf tool will calculate the HW time
> >> in post-processing.
> >> Currently, only supports the monotonic raw conversion.
> >> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
> >> HW time can only be provided in a sample by HW. For other type of
> >> records, the user requested clock should be returned as usual. Nothing
> >> is changed.
> >>
> >> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
> >> conversion information. The cap_user_time_mono_raw also indicates
> >> whether the monotonic raw conversion information is available.
> >> If yes, the clock monotonic raw can be calculated as
> >> mono_raw = base + ((cyc - last) * mult + nsec) >> shift
> >
> > Again, I appreciate you reworking and resending this series out, I
> > know it took some effort.
> >
> > But oof, I'd really like to make sure we're not exporting timekeeping
> > internals to userland.
> >
> > I think Thomas' suggestion of doing the timestamp conversion in
> > post-processing was more about interpolating collected system times
> > with the counter (tsc) values captured.
> >
>
> Thomas, could you please clarify your suggestion regarding "the relevant
> conversion information" provided by the kernel?
> https://lore.kernel.org/lkml/87ilgsgl5f.ffs@tglx/
>
> Is it only the interpolation information or the entire conversion
> information (Mult, shift etc.)?
>
> If it's only the interpolation information, the user space will be lack
> of information to handle all the cases. If I understand John's comments
> correctly, it could also bring some interpolation error which can only
> be addressed by the mult/shift conversion.

"Only" is maybe too strong a word. I think having the driver use
kernel timekeeping accessors to CLOCK_MONONOTONIC_RAW time with
counter values will minimize the error.

But again, it's not yet established that any interpolation error using
existing interfaces is great enough to be problematic here.

The interpoloation is pretty easy to do:

do {
    start= readtsc();
    clock_gett(CLOCK_MONOTONIC_RAW, &ts);
    end = readtsc();
    delta = end-start;
} while (delta  > THRESHOLD)   // make sure the reads were not preempted
mid = start + (delta +(delta/2))/2; //round-closest

and be able to get you a fairly close matching of TSC to
CLOCK_MONOTONIC_RAW value.

Once you have that mapping you can take a few samples and establish
the linear function.

But that will have some error, so quantifying that error helps
establish why being able to get an atomic mapping of TSC ->
CLOCK_MONOTONIC_RAW would help.

So I really don't think we need to expose the kernel internal values
to userland, but I'm willing to guess the atomic mapping (which the
driver will have access to, not userland) may be helpful for the fine
granularity you want in the trace.

thanks
-john
