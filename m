Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5C4683572
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAaSgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjAaSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:35:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F506589A3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:35:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me3so44341078ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDZNm68+DW/7pAZG7jeGIqRco2qgZ0ITF84Ol7Jrl8E=;
        b=DrvvaAVfOE04PLUM6A4bv+3R6HxAcAr5OFRselyMP94iAKD+SpjTDTdr2Fb8k8YL3v
         JUMlQhlmJ4igGuwMFx92qAHMGk5CUVEShy3BUdVEJFjL7VCQ5ybAz/EeSARYYlriIS6e
         QYftzFWMz422Iu7U+STZQAG290hm2TGTx3ABDkrGqjSfO6swJgiHiM2ODtsTVE2oiyzD
         WewtVRb35VjSKrppPrAootRF2Aw637IuqSkWnHCuLlvr2U2/nqHs8OEJ9YBfk6nO2el2
         NW9SnwGQiIFqOiyN03hHn1Nv+rE333ajAu+z5D9rSV6XIgwVbEU0ADitCMy5QgBMXbhI
         X1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDZNm68+DW/7pAZG7jeGIqRco2qgZ0ITF84Ol7Jrl8E=;
        b=3eeYjIH57hA0Eyc431JhBMQuATai95nAec1r3v4evIaKqjJDgYLzJYqPiVHETfq7JK
         umM4H1CdDR5TFv+sjID1BSLuM6I9Y344+8ZuM81CoPBRNKQBJn0JUlKwxLnomrMASDvD
         N24ax7ZJjAZL6X/Q+TTdBW+HufyFcWOJWdIuv2d1nwVI1xg+KIhEs7O3a3IWPUE3quZX
         GL21ylBHciK8h3lut21ltOChaloPCIujR/urDJ4k6bVTT1dFfr8jq8tPSGaQEOF008s4
         Z+HMcBb5nAWMFwzbPX5I3MX1Cll+fFPZIY835/1krlqeUyv1QjPI2PoBf6xqxlnrK4s8
         Rc/A==
X-Gm-Message-State: AO0yUKUdEgaIt2WL0DOEZvqR2oHWR+ZSJbwMz792RQeQM5y8Z8aU/zmz
        sG/1++P9hiy7QRxnNYaGTvhMwWjz/A==
X-Google-Smtp-Source: AK7set+mjz3gD6zwXYqQ1d6gKCNsglLpjNHFPf6jBP9/tjCXVhHe49j4Qe/PWrrwyK/Ue5b1SwKUiA==
X-Received: by 2002:a17:907:97d4:b0:886:703a:4dee with SMTP id js20-20020a17090797d400b00886703a4deemr13594361ejc.57.1675190142414;
        Tue, 31 Jan 2023 10:35:42 -0800 (PST)
Received: from p183 ([46.53.253.15])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906708800b0088550a1ce6esm4981554ejk.222.2023.01.31.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:35:41 -0800 (PST)
Date:   Tue, 31 Jan 2023 21:35:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9lfe54aoCWlmyqy@p183>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87357q228f.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:44:00PM +0100, Thomas Gleixner wrote:
> On Sat, Jan 28 2023 at 10:00, Yu Liao wrote:
> > selftest/proc/proc-uptime-001 complains:
> >   Euler:/mnt # while true; do ./proc-uptime-001; done
> >   proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
> >   proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
> >
> > /proc/uptime should be monotonically increasing. This occurs because
> > the data races between get_cpu_idle_time_us and
> > tick_nohz_stop_idle/tick_nohz_start_idle, for example:
> >
> > CPU0                        CPU1
> > get_cpu_idle_time_us
> >
> >                             tick_nohz_idle_exit
> >                               now = ktime_get();
> >                               tick_nohz_stop_idle
> >                                 update_ts_time_stats
> >                                   delta = ktime_sub(now, ts->idle_entrytime);
> >                                   ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta)
> >                                   ts->idle_entrytime = now
> >
> > now = ktime_get();
> > if (ts->idle_active && !nr_iowait_cpu(cpu)) {
> >     ktime_t delta = ktime_sub(now, ts->idle_entrytime);
> >     idle = ktime_add(ts->idle_sleeptime, delta);
> >     //idle is slightly greater than the actual value
> > } else {
> >     idle = ts->idle_sleeptime;
> > }
> >                             ts->idle_active = 0
> >
> > After this, idle = idle_sleeptime(actual idle value) + now(CPU0) - now(CPU1).
> > If get_cpu_idle_time_us() is called immediately after ts->idle_active = 0,
> > only ts->idle_sleeptime is returned, which is smaller than the previously
> > read one, resulting in a non-monotonically increasing idle time. In
> > addition, there are other data race scenarios not listed here.
> 
> Seriously this procfs accuracy is the least of the problems and if this
> would be the only issue then we could trivially fix it by declaring that
> the procfs output might go backwards.

Declarations on l-k are meaningless.

> If there would be a real reason to ensure monotonicity there then we could
> easily do that in the readout code.

People expect it to be monotonic. I wrote this test fully expecting
that /proc/uptime is monotonic. It didn't ever occured to me that
idletime can go backwards (nor uptime, but uptime is not buggy).

> But the real issue is that both get_cpu_idle_time_us() and
> get_cpu_iowait_time_us() can invoke update_ts_time_stats() which is way
> worse than the above procfs idle time going backwards.
> 
> If update_ts_time_stats() is invoked concurrently for the same CPU then
> ts->idle_sleeptime and ts->iowait_sleeptime are turning into random
> numbers.
> 
> This has been broken 12 years ago in commit 595aac488b54 ("sched:
> Introduce a function to update the idle statistics").
