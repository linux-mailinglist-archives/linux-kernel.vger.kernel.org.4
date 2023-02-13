Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479106950CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBMThy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjBMThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:37:52 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F464206
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:37:50 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 136so2591466ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WttiV7vr+vLWkFD8/bwmeNZKS24LdnrzRL1kqHcnx1s=;
        b=E07cNWVoXAr/JWS45tyZ68tCZzMZ7f0EzpmKWoQWjTkqZC1ymjkSjd2XT103Ht1iN1
         r6O3c3i353u6ntYs6TB57o9laCKBqdd+gdWJWrN5K+v14TumWE+a1CaI3yzwdUdexWoS
         VqTAQv5NHSlkVA9/BiqEdDKW0D9cu4ZKsRVWg/l6eKo+rRxPisRQEV10UyUXsvC7tS/m
         zcXsVc7kEll8OskDvLV3MvHxXtLlKcKF52jxXGdCwecrTq+bSpskjPxxEU6hcaYOI/0N
         LBW3Cet0sCxBtCJVhYB/8NJ8lJaYcM38pYzvi96ukFuGMHXzPJfzE6pBsm176mizxlmR
         HPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WttiV7vr+vLWkFD8/bwmeNZKS24LdnrzRL1kqHcnx1s=;
        b=WCZxS+7DsM/YfxsvPDQapkubxkW9KbCiZJp80TGnHcnAVlu/ocM0jMJPqsWoXXUIs4
         WlItmu9tDSDD1pHUq+CDEuQx+tys2v4gELo/yG9mMmFyz8tOS/nDl5/8tSbWQY14O4rI
         yA9XE4PHAP6ROrHl9PP4YtL7KWyQfOZ758hDGS++eaM6BoNYp+J7STNtMhZp03kKpAqJ
         i8BarSTtuF35pqvhtrFxNnJswR5a4tyT4pTr6fe3MFJuEPaWM8uXNnQS157FsKxVQNiu
         jIMqfFXERF5mRKJzPY+qjPgvIitIH+ou7hNZtNNfQCHcx/rWsVLkC2xcY5fU9sm2au93
         N5xw==
X-Gm-Message-State: AO0yUKVYsvrUZbxvNtVPnIW7Ql/rAY5ff0SbSp+pZtx4hvTMQ/V5WFcg
        GEVAdm1TDWiyvrHLPgwzw5+cKSJ6lNMDkJnKVxan
X-Google-Smtp-Source: AK7set+/oYLTFOEZFKZrkLvtV6BbBnE4tb4CgI2Gr/ENNRscCThbeRgUIZ0WXLVt8V7q7vuRS3wwqzkZztJyzKicuV0=
X-Received: by 2002:a25:8a09:0:b0:80b:83b0:c87e with SMTP id
 g9-20020a258a09000000b0080b83b0c87emr791ybl.360.1676317069140; Mon, 13 Feb
 2023 11:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com> <20230213190754.1836051-3-kan.liang@linux.intel.com>
In-Reply-To: <20230213190754.1836051-3-kan.liang@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Feb 2023 11:37:37 -0800
Message-ID: <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
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
> The monotonic raw clock is not affected by NTP/PTP correction. The
> calculation of the monotonic raw clock can be done in the
> post-processing, which can reduce the kernel overhead.
>
> Add hw_time in the struct perf_event_attr to tell the kernel dump the
> raw HW time to user space. The perf tool will calculate the HW time
> in post-processing.
> Currently, only supports the monotonic raw conversion.
> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
> HW time can only be provided in a sample by HW. For other type of
> records, the user requested clock should be returned as usual. Nothing
> is changed.
>
> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
> conversion information. The cap_user_time_mono_raw also indicates
> whether the monotonic raw conversion information is available.
> If yes, the clock monotonic raw can be calculated as
> mono_raw = base + ((cyc - last) * mult + nsec) >> shift

Again, I appreciate you reworking and resending this series out, I
know it took some effort.

But oof, I'd really like to make sure we're not exporting timekeeping
internals to userland.

I think Thomas' suggestion of doing the timestamp conversion in
post-processing was more about interpolating collected system times
with the counter (tsc) values captured.

I get the interpolation can be difficult as the counter value and
system time can't currently atomically collected, so potentially there
may be a need for a way to tie two together (see my previous email's
thought of ktime_get_raw_monotonic_from_timestamp()), but we'd
probably want a clear understanding of the benefit (quantitative
reduction in interpolation error, and what real benefit that brings),
and would also want the driver to generate and share those pairs
rather than having userland have access.

thanks
-john
