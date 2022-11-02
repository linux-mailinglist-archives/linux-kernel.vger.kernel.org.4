Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5371061567C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKBATO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBATL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:19:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E835BF76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 17:19:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so298943wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bfl6o6RfxD03F2eDHrxPWGb1ROJvqje3WzjBD1rMOg=;
        b=g/ghPa5ePKJP88sHNRh1bxU/0sYqkZkaQgHDxmM3OyMCzgMe7LM0SI9fRo+ras9XLm
         z+wiWsOTE83GonI95H/pmFZ61ouqSECLlOVDsbcgkouSKQdmPF4pLbsEdzxXGNgHolhE
         83GG1L8nHPR3x/aZ65F1FGneXRYHGUungUjh06N6I1Z56ud0iFLzMNCcdPU4C9Nk9YH1
         4XDNclWDDOG6BtcfocvT25qOVk6t+dl5SiJ3lKEVyrRmmQWxkCnSJQdzTdcU1/+3Ar6z
         bvsVVafH0KuK0dgf6nf5+V5Bt6zPmyzYwYyHAHhql1oqc1NnxAac5TB5UFwBHjA8KP2x
         vBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bfl6o6RfxD03F2eDHrxPWGb1ROJvqje3WzjBD1rMOg=;
        b=7NOvpSCG9bsf5hbp2UkHl/guXhcLcOnOvtMDKDWVZJHy1t+zKkCgEHZ/+gs0737gdx
         wI7jK4Yo/MCAoIzpYSYDWVNohwItbrRVzag8Oo2jrcWJi13mdXyx1R/fiLEKBsxAlebv
         cigcytFqu6O31jde1idA8RJhzISCuwRy8byYv3XMtOGKNFsYITPgh27YHUl9ZDSp3538
         EKV8m/aZ/8AInJt/pcpMQXAMiLWYCBHstFPWcX8Cn4QJ73/ajy8smZQflQkgsiwi/pKG
         mzDKSa3cLKzZjDTnJHTuUkKTZXIyCoMKjY/avIr+sXdj3Udfh6nsmBXJNAvYhso87IEZ
         U9Mg==
X-Gm-Message-State: ACrzQf1OthIkJJFHeMq+6p1vZKhwP06R7muvNAGXmmQBSTI8WcaY04Fe
        M9NVIvmnYUBKNhKcGrm1PEcpDNLbRDNyIMW8kiqQ8A==
X-Google-Smtp-Source: AMsMyM7cx6tRJWpMeqDkHzFKX0m43UtBPpplNKoIGRJ1d1g81oHK8gth0doG1fsqxH4XVhHwgKxSIj6Czpj93G2cSYs=
X-Received: by 2002:a05:600c:4588:b0:3c6:f645:dad0 with SMTP id
 r8-20020a05600c458800b003c6f645dad0mr14138971wmo.114.1667348348404; Tue, 01
 Nov 2022 17:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221027202603.670616-1-avagin@google.com> <20221101094157.a3gh2ko6otaa6cyw@suse.de>
In-Reply-To: <20221101094157.a3gh2ko6otaa6cyw@suse.de>
From:   Andrei Vagin <avagin@google.com>
Date:   Tue, 1 Nov 2022 17:18:57 -0700
Message-ID: <CAEWA0a5hRPLwxxQHLx58C9v5QXqFiN=1e7gfM9hojhS-VNu-OQ@mail.gmail.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 2:42 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Oct 27, 2022 at 01:26:03PM -0700, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> >
> > WF_SYNC means that the waker goes to sleep after wakeup, so the current
> > cpu can be considered idle if the waker is the only process that is
> > running on it.
> >
> > The perf pipe benchmark shows that this change reduces the average time
> > per operation from 8.8 usecs/op to 3.7 usecs/op.
> >
> > Before:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 8.813 [sec]
> >
> >        8.813985 usecs/op
> >          113456 ops/sec
> >
> > After:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 3.743 [sec]
> >
> >        3.743971 usecs/op
> >          267096 ops/sec
> >
>
> The WF_SYNC hint in unreliable as the waking process does not always
> go to sleep immediately. While it's great for a benchmark like a pipe
> benchmark as the relationship is strictly synchronous, it does not work
> out as well for networking which can use WF_SYNC for wakeups but either
> multiple tasks are being woken up or the waker does not go to sleep as
> there is sufficient inbound traffic to keep it awake.

This change should work fine when we wake up multiple tasks. If the waker
doesn't go to sleep, it sounds like a misuse of WF_SYNC. For example,
wake_affine_idle contains the same check like introduced in this
patch. At the first
glance, wake_affine_weight handles WF_SYNC incorrectly in this case too.

As for benchmarks, tbench shows much better numbers with this change:

$ tbench_srv &  "tbench" "-t" "15" "4" "127.0.0.1"
Before: Throughput 733.44 MB/sec  4 clients  4 procs  max_latency=0.935 ms
After:  Throughput 1778.94 MB/sec  4 clients  4 procs  max_latency=0.882 ms

I know it is just another synchronous benchmark...

I am working on the synchronous mode of seccom user notifies[1]. In the
first two versions, I used the WF_CURRENT_CPU [2] flag that has been borrowed
from the umcg patchset [3].  But when I was preparing the third version of the
patchset, I wondered why WF_SYNC didn't work in this case and ended up with this
patch. For the seccom patchset, fast synchronous context switches are the most
critical part, so any advice on how to do that properly are welcome.

[1] https://lore.kernel.org/lkml/20221020011048.156415-1-avagin@gmail.com/T/
[2] https://lore.kernel.org/lkml/20221020011048.156415-1-avagin@gmail.com/T/#m8a597d43764aa8ded2788ea7ce4276f9045668d1
[3] https://lkml.iu.edu/hypermail/linux/kernel/2111.0/04473.html

Thanks,
Andrei
> There used to be
> an attempt to track how accurate WF_SYNC was, using avg_overlap I think,
> but it was ultimately removed.
>
> --
> Mel Gorman
> SUSE Labs
