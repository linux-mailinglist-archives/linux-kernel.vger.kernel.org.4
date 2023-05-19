Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6B70A2D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjESWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:35:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A572E43
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:35:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25372604818so1340517a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684535728; x=1687127728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHCKFr6f+LZMrurz1uw2tkflY43AEvXG6kJYVc5RlKk=;
        b=ZTaj7Xzb8Lr81gcjj93/DsC83OXMkv7GWOibZycLcwa7PuyxZVbeeCbGUsEwnflrUi
         l/nJn1CyO+r86w8ekA/gijEh5xCLUhzd5a7Jw5jCvjF+8tien4ZhfDV/Dlqe7/vfpWUz
         sPu4+UrcIo1fqg/spvZQ4RzGg9gjo9RHcKrZ5ca5Ukfi4VcyuTD+0wiqUIdTg++foQXJ
         NbZrc+uFHej/Z8oIR0mnrtyktFoqrL9li+yH7xH3oG3nEn0wv+VqA3J7jLPmlg9RWjMw
         uVAC/2v1a+Ew1XqD3t729BD2/MrhDuRbBwfCcoiDjjYGPk+vWTP7g4GXCJBDWOK8V3/2
         NC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684535728; x=1687127728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHCKFr6f+LZMrurz1uw2tkflY43AEvXG6kJYVc5RlKk=;
        b=LHk0tG9rkrFdlX23wKi1I/DpBPpl5xYa7Njwv60NrtRXTM2C6GSI/gtCFI6sBSQLmO
         msxURAYZ+kFPCBjpCHSI1WPw++3zutNk626rCOFZgC6X02pLZaSPI5CRBOxZ+qW/74NL
         Vpdad7P2ne8dLA3ymKNIjocVcxIRrFgQPIExJMqUmq/sWqnJDd5KlFg747YNM6nsV2Bh
         vyQrnr0Ma1C1/jlvGm8qE7ed1gJxpzFHq0fvqQCRl86p0iMOqxI+dhnQkYT+mZGfOjsf
         xLJf1LmGTlKMQdRbjz0y4H5OGZBi0rjdDJNhxxVxAH6kOcTtDb3sNgjRGdpDDQ16g8bY
         glFw==
X-Gm-Message-State: AC+VfDzZi52JB2vSpvaGmiAupYoHV8rftueNvc7YSsYq7yPDy/Ocw+TZ
        1M+QZP4f0iU4Q9+jUixjk28=
X-Google-Smtp-Source: ACHHUZ5OqNHDufMpATdKpQiBGa/7crW94K9fjAO1vJFM+QC5orGb1L9cueVZ14KkMdGcGIdDKmJUig==
X-Received: by 2002:a17:90a:f68a:b0:253:70b7:18d1 with SMTP id cl10-20020a17090af68a00b0025370b718d1mr3477303pjb.34.1684535727568;
        Fri, 19 May 2023 15:35:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a430600b0024e268985b1sm131115pjg.9.2023.05.19.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:35:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 May 2023 12:35:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZGf5rfESYhKYzPSY@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

On Thu, May 18, 2023 at 05:41:29PM -0700, Linus Torvalds wrote:
...
> That commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from fsverity
> read workqueue") really talks about startup costs. They are about
> things like "page in the executable", which is all almost 100%
> serialized with no parallelism at all. Even read-ahead ends up being
> serial, in that it's likely one single contiguous IO.

I should have explained my thought process better here. I don't think the
fsverity and other similar recent reports on heterogeneous ARM CPUs are
caused directly by workqueue. Please take a look at the following message
from Brian Norris.

 https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/T/#u

While it's difficult to tell anything definitive from the message, the
reported performance ordering is

 4.19 > pinning worker to a CPU >> fixating CPU freq > kthread_worker

where the difference between 4.19 and pinning to one CPU is pretty small.
So, it does line up with other reports in that the source of higher
latencies and lower performance are from work items getting sprayed across
CPUs.

However, the two kernel versions tested are 4.19 and 5.15. I audited the
commits in-between and didn't spot anything which would materially change
unbound workers' affinities or how unbound work items would be assigned to
them.

Also, f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from fsverity read
workqueue") is reporting 30 fold increase in scheduler latency, which I take
to be the time from work item being queued to start of exectuion. That's
unlikely to be just from crossing a cache boundary. There must be other
interactions (e.g. with some powersaving state transitions).

That said, workqueue, by spraying work items across cache boundaries, does
provide a condition in which this sort of problems can be significantly
amplified. workqueue isn't and can't fix the root cause of these problems;
however,

* The current workqueue behavior is silly on machines with multiple L3
  caches such as recent AMD CPUs w/ chiplets and heterogeneous ARM ones.
  Improving workqueue locality is likely to lessen the severity of the
  recently reported latency problems, possibly to the extent that it won't
  matter anymore.

* The fact that the remedy people are going for is switching to percpu
  workqueue is bad. That is going to hurt other use cases, often severely,
  and their only solution would be reverting back to unbound workqueues.

So, my expectation with the posted patchset is that most of the severe
chrome problems will go away, hopefully. Even in the case that that's not
sufficient, unbound workqueues now provide enough flexibility to work around
these problems without resorting to switching to per-cpu workqueues thus
avoiding affecting other use cases negatively.

The performance benchmarks are not directed towards the reported latency
problems. The reported magnitude seems very hardware specific to me and I
have no way of reproducing. The benchmarks are more to justify switching the
default boundaries from NUMA to cache.

> Yes, latency tends to be harder to benchmark than throughput, but I
> really think latency trumps throughput 95% of the time. And all your
> benchmark loads looked like throughput loads to me: they just weren't
> using *all* the CPU capacity you had.
> 
> Yes, writeback can have lovely throughput behavior and saturate the IO
> because you have lots of parallelism. But reads are often 100% serial
> for one thread, and often you don't *have* more than one thread.
> 
> So I think your "not enough work to saturate" is still ludicrously
> over-the-top. You should not aim for "not enough work to saturate 24
> threads". You should aim for "basically completely single-threaded".
> Judging by your "CPU utilization of 60-70%", I think your "LOW" is off
> by at least an order of magnitude.


More Experiments
================

I ran several more test sets. An extra workqueue configuration CPU+STRICT is
added which is very similar to using CPU_INTENSIVE per-cpu workqueues. Also,
CPU util is now per-single-CPU, ie. 100% indicates using one full CPU rather
than all CPUs because otherwise the numbers were too small. The tests are
run against dm-crypt on a tmpfs backed loop device.


4. LLOW

Similar benchmark as before but --bs is now 512 bytes and --iodepth and
--numjobs are dialed down to 4 and 1, respectively. Compared to LOW, both IO
size and concurrency are 64 times lower.

  taskset 0x8 fio --filename=/dev/dm-1 --direct=1 --rw=randrw --bs=512 \
	--ioengine=libaio --iodepth=4 --runtime=60 --numjobs=1 \
	--time_based --group_reporting --name=iops-test-job --verify=sha512

Note that fio is pinned to one CPU because otherwise I was getting random
bi-modal behaviors depending on what the scheduler was doing making
comparisons difficult.

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM               55.08  ±0.29    290.80 ±0.64                 0.00
  CACHE                64.42  ±0.47    291.51 ±0.30               +16.96
  CACHE+STRICT         65.18  ±1.14    303.74 ±1.79               +18.34
  CPU+STRICT           32.86  ±0.34    159.05 ±0.37               -48.99
  SYSTEM+LOCAL         56.76  ±0.30    286.78 ±0.50                +3.05
  CACHE+LOCAL          57.74  ±0.11    291.65 ±0.80                +4.83 

The polarities of +LOCAL's relative BWs flipped showing gains over SYSTEM.
However, the fact that they're significantly worse than CACHE didn't change.

This is 4 in-flight 512 byte IOs, entirely plausible in any size systems.
Even at this low level of concurrency, the downside of using per-cpu
workqueue (CPU+STRICT) is clear.


5. SYNC

Let's push it further. It's now single threaded synchronous read/write(2)'s
w/ 512 byte blocks. If we're going to be able to extract meaningful gains
from localizing to the issuing CPU, this should show it.

  taskset 0x8 fio --filename=/dev/dm-1 --direct=1 --rw=randrw --bs=512 \
	--ioengine=io_uring --iodepth=1 --runtime=60 --numjobs=1 \
	--time_based --group_reporting --name=iops-test-job --verify=sha512

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM               18.64  ±0.19     88.41 ±0.47                 0.00
  CACHE                21.46  ±0.11     91.39 ±0.26               +15.13
  CACHE+STRICT         20.80  ±0.23     90.68 ±0.15               +11.59
  CPU+STRICT           21.12  ±0.61     95.29 ±0.51                -1.58
  SYSTEM+LOCAL         20.80  ±0.20     90.12 ±0.34               +11.59
  CACHE+LOCAL          21.46  ±0.09     93.18 ±0.04               +15.13

Now +LOCAL's are doing quite a bit better than SYSTEM but still can't beat
CACHE. Interestingly, CPU+STRICT performs noticeably worse than others while
occupying CPU for longer. I haven't thought too much why this would be,
maybe because the benefits of using resources on other CPUs beat the
overhead of doing so?


Summary
=======

The overall conclusion doesn't change much. +LOCAL's fare better with lower
concurrency but still can't beat CACHE. I tried other combinations and
against SSD too. Nothing significantly deviates from the overall pattern.

I'm sure we can concoct a workload which uses significantly less than one
full CPU (so that utilizing other CPU's resources don't bring enough gain)
and can stay within L1/2 to maximize the benefit of not having to go through
L3, but it looks like that's going to take some stretching. At least on the
CPU I'm testing, it looks like letting loose in each L3 domain is the right
thing to do.

And, ARM folks, AFAICS, workqueue is unlikely to be the root cause of the
significant regressions observed after switching to recent kernel. However,
this patchset should hopefully alleviate the symptoms significantly, or,
failing that, at least make working around a lot easier. So, please test and
please don't switch CPU-heavy unbound workqueues to per-cpu. That's
guaranteed to hurt other heavier-weight usages.

Thanks.

-- 
tejun
