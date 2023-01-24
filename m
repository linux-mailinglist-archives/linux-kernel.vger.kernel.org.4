Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B7679182
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjAXHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAXHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:01:32 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3971BD2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:01:30 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4fda31c3351so176022887b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzM6vEW+UUNGeXHsBx9Uk35F2HVUtpWgTH6HWSfLMsU=;
        b=qqaXhfh5adxRRbz59FbHbVwPXiwXAtC86ZvR6rN7vKzJQXaE/I+hgdw1cH5M2/Z6wi
         aAeNVGZsT6l0lUgZkRX51I7+eUXEVU5duzGdtlh4iHWw4o7V5L6Nseey+mPwR2o/OVjN
         cYlHAmXmhy4i4Fj6UHz+DbFPASeFmobuLFhRtBeUxcERSVVmWE+212yZ5Fzjf3K+Iq3z
         5Nno0mo/ncvB9EqDHCgQNPm3f+6hk8RyDEoJAIhzEJ9QtMD0jt21vWlCeV98nb3hj4oK
         r3uUHaY7kP7u3mX0axK1KtVUZsyCjc+4BRRL8/MR+elt0+Lx7RuE76Vc/1qhbDlhpymi
         7qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzM6vEW+UUNGeXHsBx9Uk35F2HVUtpWgTH6HWSfLMsU=;
        b=M1jXJZcPAW+Lpy9LgXo1GD0kI2FR+E5U1wb6Tk/ZVdLOvRFAALo+vJNPSNX64ChBxN
         KFI2oCYc7obvEOjJWtonk9sTslpggI35gQROx/a63Khh+BJM4zMo8TzAw3EJqd+1vh+l
         iphUzLaKfSUFRlRhxcZDxf6sWwEpSqHgaimeU378I1uPHCuWz+lfOVTYQnYk6PtaF7FI
         /5zb0hVF53tBwBoDeL7mKv+uOfMU4189GTrYRjnxJ8ZiYMAa5y9DIk+Sb/Lqw9eoXbnn
         wL3nsLEE5VEMbbPCZP1cJvlVV9cnqA4oDIwJ1MVdk6TREZhlYdgftQtZaSiB2v/ydrO7
         C0yQ==
X-Gm-Message-State: AFqh2kpOzxpsBNfPUF0zd8Jh/3AmMgOynV8QNlK8RGTmaWJy0hW4EPhg
        G+XSNNssEs1AC3lqzyayE9TT7yP9lrxkOQdth8i4
X-Google-Smtp-Source: AMrXdXvPkxrOPbA9E/UmuuuAqfCktWmr0MfeONXwSj6V82niGeMyaZxaAvbeQVkOXrsAb7r/ZTc5lDzLEA5lDMG5b1o=
X-Received: by 2002:a0d:dd06:0:b0:4ff:774b:80dd with SMTP id
 g6-20020a0ddd06000000b004ff774b80ddmr1439008ywe.14.1674543689858; Mon, 23 Jan
 2023 23:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com> <20230123182728.825519-2-kan.liang@linux.intel.com>
In-Reply-To: <20230123182728.825519-2-kan.liang@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 23 Jan 2023 23:01:18 -0800
Message-ID: <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
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

On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
> +int notrace get_mono_fast_from_given_time(int (*get_time_fn)
> +                                               (struct system_counterval_t *sys_counterval,
> +                                               void *ctx),
> +                                         void *ctx,
> +                                         u64 *mono_ns)
> +{
> +       struct system_counterval_t system_counterval;
> +       struct tk_fast *tkf = &tk_fast_mono;
> +       u64 cycles, now, interval_start;
> +       struct tk_read_base *tkr;
> +       unsigned int seq;
> +       int ret;
> +
> +       do {
> +               seq = raw_read_seqcount_latch(&tkf->seq);
> +               tkr = tkf->base + (seq & 0x01);
> +
> +               ret = get_time_fn(&system_counterval, ctx);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * Verify that the clocksource associated with the given
> +                * timestamp is the same as the currently installed
> +                * timekeeper clocksource
> +                */
> +               if (tkr->clock != system_counterval.cs)
> +                       return -EOPNOTSUPP;
> +               cycles = system_counterval.cycles;
> +
> +               /*
> +                * Check whether the given timestamp is on the current
> +                * timekeeping interval.
> +                */
> +               now = tk_clock_read(tkr);
> +               interval_start = tkr->cycle_last;
> +               if (!cycle_between(interval_start, cycles, now))
> +                       return -EOPNOTSUPP;

So. I've not fully thought this out, but it seems like it would be
quite likely that you'd run into the case where the cycle_last value
is updated and your earlier TSC timestamp isn't valid for the current
interval. The get_device_system_crosststamp() logic has a big chunk of
complex code to try to handle this case by interpolating the cycle
value back in time. How well does just failing in this case work out?

thanks
-john
