Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30C2672E92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjASCBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjASCBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:01:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DD45895
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:01:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b7so449364wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu1tq3n/LdB6P4+KI23iUwlSXgHNKcoPMfDjTSYiEt0=;
        b=YligMrxe4E/orUgqR8VvI6pwrEwgaXISw8haCFjF/uJle48taVQYMygU3blqy0PhYu
         5NjJq/dS99GAw4Bf9u4qfjx+7h2j/6YUYENx8CmpBsMsmzY0Ubp1IOb4t15z9hL/TACI
         n6YPwlPWgVpXdvdchff0menWL2ZG7BV7Of+WuVBoVVff/SbAcYsKI1VEOfj3L6qqvqy4
         zB4iQORX8DvkN7pL8vTJrt3m+WnTLb+RaHzaBME95RTp5exIDlRCPbjs2zZfsUDp4LpB
         oVxDLqk5M3f3a4hQRnMASQilI3rMojvmnvvV8miygPf0EviOGFAL3xPm+ugtkEWltgdQ
         7p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu1tq3n/LdB6P4+KI23iUwlSXgHNKcoPMfDjTSYiEt0=;
        b=wZiMi2IMG8jaUA+keFFVcMX/KzpP+MQ79vU1AVxudTad4xSKn/wE7psannWrOzDYRy
         ZkUjI4RjZHrtIYweLNYHiNKMKiR/e6si6uSKXa2KqYDyUKiSA+OBqR3hcoyctYRPJPq6
         d7DFfjpRZMshY7Zd0NzXYOGEh+scr5GV4LqcaMB2WCfMx7+Bh3MwXBo7Io37Q3x+ENW9
         PTcPMVbjmmRVzaS1wiWYrBGHR/4f8TEQmzKsiSCiVpFUmWq6xNrc/du1/0Vzi4gEtzAz
         86F3AyZNTA54+ORgETUFA6DkcqQo8MYcOgLtEx1DYLzp6P+ZtMxQlmQfYecgVYZOMR1S
         AOEQ==
X-Gm-Message-State: AFqh2kqr/NRi3zQR27oevl1d/uzujgBoQdp2Vh+CQgNyVBzU/jEOwle6
        HmAYp3MOoztqyFo43UxfCAo9xC1B4s+attx9hJS97g==
X-Google-Smtp-Source: AMrXdXvGBk5yLN/gW9lWvReD+EGsDcrto7RDqABj5uRF8qWeaRh0yOMij495GRMURAhXONtQlFD3pCS9LGGRDh2eRfA=
X-Received: by 2002:adf:ec88:0:b0:2bd:c1c9:131c with SMTP id
 z8-20020adfec88000000b002bdc1c9131cmr221748wrn.402.1674093676160; Wed, 18 Jan
 2023 18:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20230113210703.62107-1-nhuck@google.com> <Y8HI+42TxxlJxT6D@slm.duckdns.org>
In-Reply-To: <Y8HI+42TxxlJxT6D@slm.duckdns.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 18 Jan 2023 18:01:04 -0800
Message-ID: <CAJkfWY4Az45dNkPu5JpDsiMV-gRLe2VjVuixQd9xNG7zdLb4jA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
To:     Tejun Heo <tj@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jan 13, 2023 at 1:11 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Jan 13, 2023 at 01:07:02PM -0800, Nathan Huckleberry wrote:
> > Add a WQ flag that allows workqueues to use SCHED_FIFO with the least
> > imporant RT priority.  This can reduce scheduler latency for IO
> > post-processing when the CPU is under load without impacting other RT
> > workloads.  This has been shown to improve app startup time on Android
> > [1].
> >
> > Scheduler latency affects several drivers as evidenced by [1], [2], [3],
> > [4].  Some of these drivers have moved post-processing into IRQ context.
> > However, this can cause latency spikes for real-time threads and jitter
> > related jank on Android.  Using a workqueue with SCHED_FIFO improves
> > scheduler latency without causing latency problems for RT threads.
> >
> > [1]:
> > https://lore.kernel.org/linux-erofs/20230106073502.4017276-1-dhavale@google.com/
> > [2]:
> > https://lore.kernel.org/linux-f2fs-devel/20220802192437.1895492-1-daeho43@gmail.com/
> > [3]:
> > https://lore.kernel.org/dm-devel/20220722093823.4158756-4-nhuck@google.com/
> > [4]:
> > https://lore.kernel.org/dm-crypt/20200706173731.3734-1-ignat@cloudflare.com/
> >
> > This change has been tested on dm-verity with the following fio config:
> >
> > [global]
> > time_based
> > runtime=120
> >
> > [do-verify]
> > ioengine=sync
> > filename=/dev/testing
> > rw=randread
> > direct=1
> >
> > [burn_8x90%_qsort]
> > ioengine=cpuio
> > cpuload=90
> > numjobs=8
> > cpumode=qsort
> >
> > Before:
> > clat (usec): min=13, max=23882, avg=29.56, stdev=113.29 READ:
> > bw=122MiB/s (128MB/s), 122MiB/s-122MiB/s (128MB/s-128MB/s), io=14.3GiB
> > (15.3GB), run=120001-120001msec
> >
> > After:
> > clat (usec): min=13, max=23137, avg=19.96, stdev=105.71 READ:
> > bw=180MiB/s (189MB/s), 180MiB/s-180MiB/s (189MB/s-189MB/s), io=21.1GiB
> > (22.7GB), run=120012-120012msec
>

Hi Tejun,

> Given that its use case mostly intersects with WQ_HIGHPRI, would it make
> more sense to add a switch to alter its behavior instead? I don't really
> like the idea of pushing the decision between WQ_HIGHPRI and WQ_SCHED_FIFO
> to each user.

Do you think something similar should be done for WQ_UNBOUND? In most
places where WQ_HIGHPRI is used, WQ_UNBOUND is also used because it
boosts performance. However, I suspect that most of these benchmarks
were done on x86-64. I've found that WQ_UNBOUND significantly reduces
performance on arm64/Android.

From the documentation, using WQ_UNBOUND for performance doesn't seem
correct. It's only supposed to be used for long-running work. It might
make more sense to get rid of WQ_UNBOUND altogether and only move work
to unbound worker pools once it has stuck around for long enough.

Android will probably need to remove WQ_UNBOUND from all of these
performance critical users.

If there are performance benefits to using unbinding workqueues from
CPUs on x86-64, that should probably be a config flag, not controlled
by every user.

Thanks,
Huck

>
> Thanks.
>
> --
> tejun
