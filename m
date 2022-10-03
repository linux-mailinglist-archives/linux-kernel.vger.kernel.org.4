Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233C5F396F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJCW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJCW5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:57:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E35AC52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:57:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd10so25289589ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=00Rf5fRftjknIXdOQAcFuI6czUHqoq+bsrmhi8RPZXY=;
        b=Lqpy5ljyk1JgQL1QTY4l2Nf0gAEIcBTXSAEQNCTLucd8Jp/l9wnzF+4tXkpTlpmsHR
         YX0sVWrLyUvvHPwsZR958/xfPcFid6Ll1+Gj7P3KfjQCtUdxnOgfrwv9H5nwWmW+OQwY
         OdW/IXFyKJaA/c/ohrP9w0EkOhHIAgxXyYXlrKFwq167JpDFPM9UZMD9hC7eXX5sxtBU
         irgbPPQDKT/qE59E5nrGnUt98Kx5TPQkyjarbKizgV1SrCiHVy+hXjiaFhVz6nd4jcOK
         h6yTxGAVjBvPKSe0RsNx5HFmSNbtkX9XsCNZKg7cSHxv3jJE01YHiiyWVTrDKDFjKuk0
         pLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=00Rf5fRftjknIXdOQAcFuI6czUHqoq+bsrmhi8RPZXY=;
        b=EBYQYWDHsEvh+YQ4HJ4Spye04EZw5CrCYCch0X7lwXGO6qw9p/2QYwYwajZQx6lAlB
         am/j7hs+drwsi7qiiIWLqQ8PVIfeOlnbnC/uVEmRav2Q3L1VB/5nuqbHydaQUv1dt6rK
         wa0VIAMDZwpkxdtu5zkzB9B0ePs/XpP5JV4ZcobWG65lmjqpnDzxxC/jytyIizXqbFoa
         0ZIWdF+3YFNilO65Ttpr6IyO+65q7S+VG8wv2hJTZ2WJ33XOg0aRZXAkvgfsxQdKakMr
         M1Ti2hGqDZa2ETxo44P6LugTttBr2D/1R8/wgvdXFyfjJrGI3MpHQlT/vitcRKCfhAgk
         mPeA==
X-Gm-Message-State: ACrzQf0vAsuc+8MH/w7uhP36mTtDxQLb5tea9UqXh3ZO6duzOmU0oyly
        pPp+GeghLVJt6MCY0vhYRF8kE1tzGiCjP1mScq+/bQ==
X-Google-Smtp-Source: AMsMyM5ea31QkaBYSO6K6jLsZcNvOjGy8N9TvOEhrOmsIHAhXtkZHtVMc98RpvV/dmH8PqXDqqjpdNQo/jlk4o+14jY=
X-Received: by 2002:a17:907:a0c7:b0:787:f13b:5533 with SMTP id
 hw7-20020a170907a0c700b00787f13b5533mr13744460ejc.50.1664837835816; Mon, 03
 Oct 2022 15:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
In-Reply-To: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 3 Oct 2022 15:57:02 -0700
Message-ID: <CAGXk5yoC+whmLQn-KvUE3_rGGj4jodsKushr5LmtPK0mi6DFEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>,
        "Chung-Kai (Michael) Mei" <chungkai@google.com>
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

We have some data on an earlier build of Pixel 6a, which also runs a
slightly modified "sched" governor. The tuning definitely has both
performance and power impact on UX. With some additional user space
hints such as ADPF (Android Dynamic Performance Framework) and/or the
old-fashioned INTERACTION power hint, different trade-offs can be
archived with this sort of tuning.


+---------------------------------------------------------+----------+----------+
|                         Metrics                         |   32ms   |
  8ms    |
+---------------------------------------------------------+----------+----------+
| Sum of gfxinfo_com.android.test.uibench_deadline_missed |   185.00 |
  112.00 |
| Sum of SFSTATS_GLOBAL_MISSEDFRAMES                      |    62.00 |
   49.00 |
| CPU Power                                               | 6,204.00 |
7,040.00 |
| Sum of Gfxinfo.frame.95th                               |   582.00 |
  506.00 |
| Avg of Gfxinfo.frame.95th                               |    18.19 |
   15.81 |
+---------------------------------------------------------+----------+----------+





On Thu, Sep 29, 2022 at 11:59 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> On Thu, Sep 29, 2022 at 01:21:45PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 29, 2022 at 12:10:17PM +0100, Kajetan Puchalski wrote:
> >
> > > Overall, the problem being solved here is that based on our testing the
> > > PELT half life can occasionally be too slow to keep up in scenarios
> > > where many frames need to be rendered quickly, especially on high-refresh
> > > rate phones and similar devices.
> >
> > But it is a problem of DVFS not ramping up quick enough; or of the
> > load-balancer not reacting to the increase in load, or what aspect
> > controlled by PELT is responsible for the improvement seen?
>
> Based on all the tests we've seen, jankbench or otherwise, the
> improvement can mainly be attributed to the faster ramp up of frequency
> caused by the shorter PELT window while using schedutil. Alongside that
> the signals rising faster also mean that the task would get migrated
> faster to bigger CPUs on big.LITTLE systems which improves things too
> but it's mostly the frequency aspect of it.
>
> To establish that this benchmark is sensitive to frequency I ran some
> tests using the 'performance' cpufreq governor.
>
> Max frame duration (ms)
>
> +------------------+-------------+----------+
> | kernel           |   iteration |    value |
> |------------------+-------------+----------|
> | pelt_1           |          10 | 157.426  |
> | pelt_4           |          10 |  85.2713 |
> | performance      |          10 |  40.9308 |
> +------------------+-------------+----------+
>
> Mean frame duration (ms)
>
> +---------------+------------------+---------+-------------+
> | variable      | kernel           |   value | perc_diff   |
> |---------------+------------------+---------+-------------|
> | mean_duration | pelt_1           |    14.6 | 0.0%        |
> | mean_duration | pelt_4           |    14.5 | -0.58%      |
> | mean_duration | performance      |     4.4 | -69.75%     |
> +---------------+------------------+---------+-------------+
>
> Jank percentage
>
> +------------+------------------+---------+-------------+
> | variable   | kernel           |   value | perc_diff   |
> |------------+------------------+---------+-------------|
> | jank_perc  | pelt_1           |     2.1 | 0.0%        |
> | jank_perc  | pelt_4           |     2   | -3.46%      |
> | jank_perc  | performance      |     0.1 | -97.25%     |
> +------------+------------------+---------+-------------+
>
> As you can see, bumping up frequency can hugely improve the results
> here. This is what's happening when we decrease the PELT window, just on
> a much smaller and not as drastic scale. It also explains specifically
> where the increased power usage is coming from.
