Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0008B5F6411
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiJFKA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiJFKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C510FDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665050377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76Af30Oo+4EbUuRXFJZsLZiX8uZw+Ed4yK67CL0gU1U=;
        b=h3+Defd66+sYx6KLKFA/871P5Gtp4IAVPfmvVWuCnebEPtggOhHqqrDbO6sujS+Y9/S7VX
        48ACSdMeClfFs/3bmw5O1+LDmVT9dc+2Nou/BSBP5VGJUE9pzfLZ24GPBIdkj03WmSc+aj
        Q1xOPAfxCs6VLP9jV02BgL/nPQ14wR8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-FGqZjHsION-QzxdFfTfmuQ-1; Thu, 06 Oct 2022 05:59:36 -0400
X-MC-Unique: FGqZjHsION-QzxdFfTfmuQ-1
Received: by mail-wm1-f71.google.com with SMTP id k21-20020a7bc415000000b003b4fac53006so413096wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76Af30Oo+4EbUuRXFJZsLZiX8uZw+Ed4yK67CL0gU1U=;
        b=mPw00/cMAQ3cXd5Mxh/uHqznk1jovr8MDr5Hcr8TQ5etdmLEb92bkCWk0L4n/Jc/G5
         VqdxYSVuKuHNGS5Pjvopfa0UwAhBEVZ3Tp5CXR79PT+lS6IbOPtvC4U/hnzIkCK2Ymb1
         Qn6guksQi55TBDWEuXQdGhoVD98JdcumI3QJoYjqeqrXKT0N5UkqTShmvoS/4tW53gZx
         XI3Fk84kMBsB59FHEFTnjWl9iUsLspn+bw2LwNPQYH38LOTO/QNs9/FAPGzCSpQXuAKF
         0xVw4TjE7QORpHoeVc0Dh6ouDuaFoxy9+47uY8KyasWhMbjSLAcD5YewlHrd+kxiKPVI
         v1aw==
X-Gm-Message-State: ACrzQf1txMJjUwIGMwRVlxIsiiXmv8acxTYtt1SjxGtAH00EfYywK7nv
        DT/lzIpfls/vS/KymxphKPGGN+m6InrSG1B8HoU2koU5ZnSupxIQQYO3MLZDkQ0lQTwbX/xFf6U
        rzWqeroaFdDQiWXoYzEJh4AgB
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id ay24-20020a05600c1e1800b003b3b9f82186mr2641163wmb.151.1665050375309;
        Thu, 06 Oct 2022 02:59:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ziSUgOI6nYrjwNsWSyS3GZIKwP66/1WNhpo2FiBHtpoVN0miz2wtiIlhOwQbnab4rU6gl3A==
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id ay24-20020a05600c1e1800b003b3b9f82186mr2641136wmb.151.1665050375000;
        Thu, 06 Oct 2022 02:59:35 -0700 (PDT)
Received: from localhost.localdomain ([151.29.60.69])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d530d000000b0022aeba020casm17387168wrv.83.2022.10.06.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:59:34 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:59:31 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Yz6nA4rY39dB4Wke@localhost.localdomain>
References: <20221003214501.2050087-1-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Connor,

Thanks a lot for reviving this!

On 03/10/22 21:44, Connor O'Brien wrote:

...

> Past discussions of proxy execution have often focused on the benefits
> for deadline scheduling. Current interest for Android is based more on
> desire for a broad solution to priority inversion on kernel mutexes,
> including among CFS tasks. One notable scenario arises when cpu cgroups
> are used to throttle less important background tasks. Priority inversion
> can occur when an "important" unthrottled task blocks on a mutex held by
> an "unimportant" task whose CPU time is constrained using cpu
> shares. The result is higher worst case latencies for the unthrottled
> task.[0] Testing by John Stultz with a simple reproducer [1] showed
> promising results for this case, with proxy execution appearing to
> eliminate the large latency spikes associated with priority
> inversion.[2]

Uh, interesting. :)

...

> Testing so far has focused on stability, mostly via mutex locktorture
> with some tweaks to more quickly trigger proxy execution bugs. These
> locktorture changes are included at the end of the series for
> reference. The current series survives runs of >72 hours on QEMU without
> crashes, deadlocks, etc. Testing on Pixel 6 with the android-mainline
> kernel [9] yields similar results. In both cases, testing used >2 CPUs
> and CONFIG_FAIR_GROUP_SCHED=y, a configuration Valentin Schneider
> reported[10] showed stability problems with earlier versions of the
> series.

Cool. I started playing with it again and don't have much to report yet
(guess it's a good sign). I'll continue testing.

> That said, these are definitely still a work in progress, with some
> known remaining issues (e.g. warnings while booting on Pixel 6,
> suspicious looking min/max vruntime numbers) and likely others I haven't
> found yet. I've done my best to eliminate checks and code paths made
> redundant by new fixes but some probably remain. There's no attempt yet
> to handle core scheduling. Performance testing so far has been limited
> to the aforementioned priority inversion reproducer. The hope in sharing
> now is to revive the discussion on proxy execution and get some early
> input for continuing to revise & refine the patches.

I think another fundamental question I'm not sure we spent much time on
yet is how to deal with rtmutexes. I understand you are not particularly
interested in them for your usecase, but we'll need to come up with a
story/implementation that considers rtmutexes as well (possibly
replacing the current PI implementation?). The need for thinking about
this "from the start" is quite important as soon as PREEMPT_RT is
enabled (I tried to port this series on latest RT) and in general for
usecases relying on rtmutexes running mainline. Not sure if you already
thought about it and/or if we first want to address open questions of
the current implementation. Just wondering if we might be missing
important details if we don't look at the full picture right away.

Thanks!
Juri

