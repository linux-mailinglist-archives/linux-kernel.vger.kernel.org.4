Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3F6A587A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjB1Lmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjB1Lm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:42:27 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B612CC77;
        Tue, 28 Feb 2023 03:42:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b10so9926849ljr.0;
        Tue, 28 Feb 2023 03:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pS8VevWEyEi9+pzj9ij58e3HnR5mEiBkpbeDWvHShmU=;
        b=o3Nej/SxawuNjo0xsMRAw7KZf7517ox6YA+dq1R47D5WYU8mOF4eWjg665cFdtOUR+
         8Y80SBXUXiENTQ3OxEu/TvyQgkEVIFFX2bRClD3zMS3AMzoFsJbWl80hixxdaudqgxko
         81bvAutJf+6j+AxGc2A+01Z02pMp8xsz5NIGLgMs25DqaThGtZv2wNQMwPA9E2LmKid1
         CfH4KQZPsjbwsBbYTNzgp7C124VbcPV0EfPg+1+SP21nwM6I1dr1FLgAlPcz8gtwwdM4
         t4wPujMoXWbhvTwE/DKXqygIboBImFVkNnC5GBJbSXIbi1KGrcH1f8w0zICwl6G3HqoC
         xWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pS8VevWEyEi9+pzj9ij58e3HnR5mEiBkpbeDWvHShmU=;
        b=J+HlMDYkjx0jxwvvvREwa3emV4TekmTcMNonGD2RbJJsqvec9CZSYHOZ/x3HgerGXa
         h1MS9bQg5C7w4M0M97Z9sCEonb0lxruKK4/uJ9hrciJ0Vibwqc5WHlgxLS1AHd/qWPPk
         fD7ATj2Odrqehc1T2Nokq0k0P12MU+scocWxDLkj1kDmz6zcAwMdCsrKS2lNdXbvfuel
         m6pGR9h9hc773uOBVFRE7Dn0UVtlumGgVsW6BWa4r8HraDzyTyaBHH8dK6z07BWyIyOs
         iIXBf4T2KYBxYSA3MA55F82WmpFtZ/abzpvC6o7vq8XuNTJI5Q4/DbqsfinpjAk1d6XV
         e7Dw==
X-Gm-Message-State: AO0yUKWWi3TYXbzQikDLChgwZURnir6+ucaQPJCYNNEDFvOYKdSI5ANo
        JRG0UN5klAQXMQZHnCAU5pP1wSQFXpQ=
X-Google-Smtp-Source: AK7set8Q2S3SzpNiDSaBXemUMcCFUJlNQAMWh7eYE9nj8QzOMHbm2FbBNPwgo0EvtZqH0mZ0uMJFmg==
X-Received: by 2002:a2e:780a:0:b0:295:b0a5:f66d with SMTP id t10-20020a2e780a000000b00295b0a5f66dmr873212ljc.23.1677584543765;
        Tue, 28 Feb 2023 03:42:23 -0800 (PST)
Received: from pc636 (host-90-235-25-56.mobileonline.telia.com. [90.235.25.56])
        by smtp.gmail.com with ESMTPSA id e6-20020a05651c038600b002934ebf2f6asm1156851ljp.73.2023.02.28.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:42:23 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Feb 2023 12:42:21 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/3onX5XyyYdrgZE@pc636>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 27, 2023 at 1:57 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 01:27:20PM -0500, Joel Fernandes wrote:
> > >
> > >
> > > > On Feb 27, 2023, at 1:20 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > ﻿On Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wrote:
> > > >>
> > > >>
> > > >>>> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >>>
> > > >>> ﻿On Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
> > > >>>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>>>>
> > > >>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> > > >>>>>>>
> > > >>>>>>> ﻿
> > > >>>>>>>>
> > > >>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> > > >>>>>>>> To: linux-kernel@vger.kernel.org
> > > >>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> > > >>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> > > >>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> > > >>>>>>>> rcu@vger.kernel.org
> > > >>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> > > >>>>>>>> completed
> > > >>>>>>>>
> > > >>>>>>>> On many systems, a great deal of boot happens after the kernel thinks the
> > > >>>>>>>> boot has completed. It is difficult to determine if the system has really
> > > >>>>>>>> booted from the kernel side. Some features like lazy-RCU can risk slowing
> > > >>>>>>>> down boot time if, say, a callback has been added that the boot
> > > >>>>>>>> synchronously depends on.
> > > >>>>>>>>
> > > >>>>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> > > >>>>>>>> stay expedited for as long as the system is still booting.
> > > >>>>>>>>
> > > >>>>>>>> For these reasons, this commit adds a config option
> > > >>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> > > >>>>>>>> rcupdate.boot_end_delay.
> > > >>>>>>>>
> > > >>>>>>>> By default, this value is 20s. A system designer can choose to specify a value
> > > >>>>>>>> here to keep RCU from marking boot completion.  The boot sequence will not
> > > >>>>>>>> be marked ended until at least boot_end_delay milliseconds have passed.
> > > >>>>>>>
> > > >>>>>>> Hi Joel,
> > > >>>>>>>
> > > >>>>>>> Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> > > >>>>>>>
> > > >>>>>>> Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the
> > > >>>>>>> real-time latency than the overall OS boot time?
> > > >>>>>>
> > > >>>>>> But every system has to boot, even an RT system.
> > > >>>>>>
> > > >>>>>>>
> > > >>>>>>> If so, we might make rcupdate.boot_end_delay = 0 as the default value
> > > >>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels?
> > > >>>>>>
> > > >>>>>> Could you measure how much time your RT system takes to boot before the application runs?
> > > >>>>>>
> > > >>>>>> I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.
> > > >>>>>
> > > >>>>> Provide a /sys location that the userspace code writes to when it
> > > >>>>> is ready?  Different systems with different hardware and software
> > > >>>>> configurations are going to take different amounts of time to boot,
> > > >>>>> correct?
> > > >>>>
> > > >>>> I could add a sysfs node, but I still wanted this patch as well
> > > >>>> because I am wary of systems where yet more userspace changes are
> > > >>>> required. I feel the kernel should itself be able to do this. Yes, it
> > > >>>> is possible the system completes "booting" at a different time than
> > > >>>> what the kernel thinks. But it does that anyway (even without this
> > > >>>> patch), so I am not seeing a good reason to not do this in the kernel.
> > > >>>> It is also only a minimum cap, so if the in-kernel boot takes too
> > > >>>> long, then the patch will have no effect.
> > > >>>>
> > > >>>> Thoughts?
> > > >>>>
> > > >>> Why "rcu_boot_ended" is not enough? As i see right after that an "init"
> > > >>> process or shell or panic is going to be invoked by the kernel. It basically
> > > >>> indicates that a kernel is fully functional.
> > > >>>
> > > >>> Or an idea to wait even further? Until all kernel modules are loaded by
> > > >>> user space.
> > > >>
> > > >> I mentioned in commit message it is daemons, userspace initialization etc. There is a lot of userspace booting up as well and using the kernel while doing so.
> > > >>
> > > >> So, It does not make sense to me to mark kernel as booted too early. And no harm in adding some builtin kernel hysteresis. What am I missing?
> > > >>
> > > > Than it is up to user space to decide when it is ready in terms of "boot completed".
> > >
> > > I dont know if you caught up with the other threads. See replies from Paul and my reply to that.
> > >
> > > Also what you are proposing can be more harmful. If user space has a bug and does not notify the kernel that boot completed, then the boot can stay incomplete forever. The idea with this patch is to make things better, not worse.
> > >
> > I saw that Paul proposed to have a sysfs attribute using which you can
> > send a notification.
> 
> Maybe I am missing something but how will a sysfs node on its own work really?
> 
> 1. delete kernel marking itself boot completed  -- and then sysfs
> marks it completed?
> 
> 2. delete kernel marking itself boot completed  -- and then sysfs
> marks it completed, if sysfs does not come in in N seconds, then
> kernel marks as completed?
> 
> #1 is a no go, that just means a bug waiting to happen if userspace
> forgets to write to sysfs.
> 
> #2 is just an extension of this patch. So I can add a sysfs node on
> top of this. And we can make the minimum time as a long period of
> time, as you noted below:
> 
> > IMHO, to me this patch does not provide a clear correlation between what
> > is a boot complete and when it occurs. A boot complete is a synchronous
> > event whereas the patch thinks that after some interval a "boot" is completed.
> 
> But that is exactly how the kernel code is now without this patch, so
> it is already broken in that sense, I am not really breaking it more
> ;-)
> 
> > We can imply that after, say 100 seconds an initialization of user space
> > is done. Maybe 100 seconds then? :)
> 
> Yes I am Ok with that. So are you suggesting we change the default to
> 100 seconds and then add a sysfs node to mark as boot done whenever
> userspace notifies?
> 
As i see it correctly the patch tries to address at least two issues. Fist
one is about lazy callbacks. If it stucks the boot-time is degraded so you
want it to be disabled during the boot.

I wonder why not keeping lazy stuff to be disabled by __default__. User decides
if it is needed or not? No matter if user space hangs or whatever. Or is it hard
to add such runtime switcher?

Second you want to have an expidited gp during a boot. I guess same here
it is about boot performance. Should not it be as a separate patch with
different commit message and with some data if you see a speedup?

Thanks!

--
Uladzislau Rezki
