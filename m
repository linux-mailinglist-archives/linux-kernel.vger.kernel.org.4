Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12416950AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBMT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjBMT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:28:28 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BD10E4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:28:27 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-52bed2ce9bdso176912807b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiC3ULqXX8cO6R+XcTEyifNGmzSfzPzamHLxwxaEXII=;
        b=BjvlkveF0bQPhQ8RyvdHfborNYN2Wt3s6+KrhvpWOFYsfi3O1yCCT/NPfPWwe1LZWo
         /jNNSe8lVs36FURxn9Sgfxgn9OAbVQwkkDyYxHGyEfk8CUkMSnaTwh1ulkJVW0isSauw
         mElUtgKk/Le2WWy2wSFvSb+pK4tuuZSezKMqAQ5eaelJYB84QIQ35pHdauuKteZGrm/r
         T6XSiqxCTqUzruSJvc90kOWGKHks7khi3283pOkjx/LpHD5wuwFPZhExpR70oWJygola
         /11+DF2O9FxonKaDic9Je5+sQFdkli4Ie5/5V794h//427HYhSBqHxD1B2gWgMo0uvJV
         URXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiC3ULqXX8cO6R+XcTEyifNGmzSfzPzamHLxwxaEXII=;
        b=IA28r9agPGeA0akXHDZSv6kuPCfA8G2TjwTt4QJJ0tE/dhtjiidCOxFmx6A1OSvlFA
         F7ky+qbWGVF6wOk/MqK9mrjGof3+OJk4T85xEWfx0MmNaWT3kMUfcyhGFu1GiBSDlq2X
         TG6VVyb00TR9lZLOvMk+W5svuZE7WgYETW3USK7HASNMIY0Z+k3BF/JPwz0ZDzi6cs1f
         hcHIps/FPBxbwnUdM50CT2DCabjwNPAKbShuj6IBFtscFId/xkHsLMth1UrosZd2F0dm
         tWNj9MTSOmNIB/e0ixCnQKpua7YqwVEx64Ns4kB5CupP+VPyftmf/k/JoKtZWb4014Up
         UUHg==
X-Gm-Message-State: AO0yUKUdsvRUMOIJc4rOhrlJUggon4xJopxD4+W15JMVRxWpLw80/itv
        cdUrJy1gO9FpwGxf1bfHy8t6ONWnM6oDTabODU7r
X-Google-Smtp-Source: AK7set/PJjiz4KvZe2Co45e+2mFfpQrUMHCwbjYbxXayHYdUpsWIagheJ+1/PWsYd1ZTn71aqfVPQrcqqhW5edqh7tI=
X-Received: by 2002:a0d:cb54:0:b0:52e:fb6b:fd61 with SMTP id
 n81-20020a0dcb54000000b0052efb6bfd61mr1060391ywd.271.1676316506243; Mon, 13
 Feb 2023 11:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com> <20230213190754.1836051-2-kan.liang@linux.intel.com>
In-Reply-To: <20230213190754.1836051-2-kan.liang@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Feb 2023 11:28:14 -0800
Message-ID: <CANDhNCoC9qry7pohkfqn8zT07-+FycRS7SH51Z0wYBv5gw_hzQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/9] timekeeping: Expose the conversion information
 of monotonic raw
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
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

On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The conversion information of monotonic raw is not affected by NTP/PTP
> correction. The perf tool can utilize the information to correctly
> calculate the monotonic raw via a TSC in each PEBS record in the
> post-processing stage.
>
> The current conversion information is hidden in the internal
> struct tk_read_base. Add a new external struct ktime_conv to store and
> share the conversion information with other subsystems.
>
> Add a new interface ktime_get_fast_mono_raw_conv() to expose the
> conversion information of monotonic raw.  The function probably be
> invoked in a NMI. Use NMI safe tk_fast_raw to retrieve the conversion
> information.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/timekeeping.h | 18 ++++++++++++++++++
>  kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index fe1e467ba046..94ba02e7eb13 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -253,6 +253,21 @@ struct system_time_snapshot {
>         u8                      cs_was_changed_seq;
>  };
>
> +/**
> + * struct ktime_conv - Timestamp conversion information
> + * @mult:      Multiplier for scaled math conversion
> + * @shift:     Shift value for scaled math conversion
> + * @xtime_nsec: Shifted (fractional) nano seconds offset for readout
> + * @base:      (nanoseconds) base time for readout
> + */
> +struct ktime_conv {
> +       u64                     cycle_last;
> +       u32                     mult;
> +       u32                     shift;
> +       u64                     xtime_nsec;
> +       u64                     base;
> +};
> +
>  /**
>   * struct system_device_crosststamp - system/device cross-timestamp
>   *                                   (synchronized capture)
> @@ -297,6 +312,9 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
>  /* NMI safe mono/boot/realtime timestamps */
>  extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
>
> +/* NMI safe mono raw conv information */
> +extern void ktime_get_fast_mono_raw_conv(struct ktime_conv *conv);
> +
>  /*
>   * Persistent clock related interfaces
>   */
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 5579ead449f2..a202b7a0a249 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -505,6 +505,30 @@ u64 notrace ktime_get_raw_fast_ns(void)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
>
> +/**
> + * ktime_get_fast_mono_raw_conv - NMI safe access to get the conversion
> + *                               information of clock monotonic raw
> + *
> + * The conversion information is not affected by NTP/PTP correction.
> + */
> +void ktime_get_fast_mono_raw_conv(struct ktime_conv *conv)
> +{
> +       struct tk_fast *tkf = &tk_fast_raw;
> +       struct tk_read_base *tkr;
> +       unsigned int seq;
> +
> +       do {
> +               seq = raw_read_seqcount_latch(&tkf->seq);
> +               tkr = tkf->base + (seq & 0x01);
> +               conv->cycle_last = tkr->cycle_last;
> +               conv->mult = tkr->mult;
> +               conv->shift = tkr->shift;
> +               conv->xtime_nsec = tkr->xtime_nsec;
> +               conv->base = tkr->base;
> +       } while (read_seqcount_latch_retry(&tkf->seq, seq));
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_fast_mono_raw_conv);

Thanks for taking another pass at this!  Using CLOCK_MONOTONIC_RAW
removes a lot of the issues around time inconsistencies.

Though, I'm not super excited about exporting a lot of timekeeping
state out to drivers to have drivers then duplicate timekeeping logic.

Would it make more sense to have the timekeeping core export an
interface like: ktime_get_mono_raw_from_timestamp(struct clocksource
*cs, cycle_t  timestamp)?

The complexity is that the timestamp may be pretty far in the past, so
special handling will be needed to do the mult/shift conversion for a
large negative delta.

Also we need some way of checking that the current clocksource
(because it can change) matches the timestamp source?

Maybe some get_mono_raw_timestamp(&cs) accessor that captures both the
current clocksource and the timestamp?

I've not thought this out fully, but curious if something like that
might work for you and also encapsulate the timekeeping logic better
so we don't have to have that logic leak out to various driver
implementations.

thanks
-john
