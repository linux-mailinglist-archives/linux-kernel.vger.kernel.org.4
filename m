Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CF6A4A62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB0S5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:57:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B823119;
        Mon, 27 Feb 2023 10:57:43 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y14so7563206ljq.4;
        Mon, 27 Feb 2023 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VHJoIINQUP1fNRMMen/8cCs/WWXM/hffYmgoPKFxjY=;
        b=bIPDKBrbA7KJ71AyXzg/zN98Cg9NyrQSlxG7aaFNR4rNwJIPRtfbjv7Xmc4gP8KbL7
         ECYUcdg4KgVjp8OMUcthgQCtc1ulEkbF/29kk4WsijNVhX5JzFXzSJtglmacvd6GOVMf
         +VO3WFAQicF2cyKcQSKhFTYfSxDVQLEV9mwrELLZfbk9DLNg32rs8sWZlgEjYOXRV2n5
         SqsYkmVOqEj0AxAZXwgp9pTvf4Kbnv3wR36TArptR4Dn6QkXcSs92vL2EMoqbrquE5WO
         9yumT1haQdvdG/swD7l7wqXfp2ahuO6/Z6Lz+HRRZco5onsRO/DuipNUtT1dT6eVeRLq
         cpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VHJoIINQUP1fNRMMen/8cCs/WWXM/hffYmgoPKFxjY=;
        b=f6poBOGQGABQBX8PbthdRKLELV7joTdyxA61F45L61mEIHWFBPfinmEg8UhhdN+pRQ
         S84g74kGzZE3mdjkgc+DF5PrGfC9hvvS14Fk8vpNM7ojbFx/4ZHKsc3aWg7cUvmB9SRO
         g74gyMS+XfnEspJQooCWHTinm968GeSrvvLpa2WMw9+pgOMZZca/zo8IDZZCXH5UnpAI
         l8gR0/H/leT79h9KXfCqnwI/bXK3bTbUHGL5mU5e74cAoWi88xsX8OFgtzRSXj4zoD4r
         wB8n1saX8CUw72iuGG0OMBwHGmtmYxr3gt8ZEJNQWCobiEMDngQjv/TuRnIuEX6JKOi7
         O1Ag==
X-Gm-Message-State: AO0yUKWVHrkrK13L/J3ZGPNbfcaEgiCbc9ERrRRf/XeiovoXUScObSs/
        BcJb5vRBuKYrTugsFWBEtms=
X-Google-Smtp-Source: AK7set/MsnhboCC3vx1YZH/ndRWRLeD0Uh575sHoLwzk61Q/uZDagvb75/xmvNLkEsBWAVyf5GaEIQ==
X-Received: by 2002:a05:651c:3de:b0:295:bd6d:90e5 with SMTP id f30-20020a05651c03de00b00295bd6d90e5mr956229ljp.9.1677524261378;
        Mon, 27 Feb 2023 10:57:41 -0800 (PST)
Received: from pc636 (host-90-235-25-56.mobileonline.telia.com. [90.235.25.56])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm840402lja.74.2023.02.27.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:57:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Feb 2023 19:57:38 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/z9Its1RKetIr8V@pc636>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:27:20PM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 27, 2023, at 1:20 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> ﻿On Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
> >>>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>> 
> >>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> >>>>>> 
> >>>>>> 
> >>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> >>>>>>> 
> >>>>>>> ﻿
> >>>>>>>> 
> >>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> >>>>>>>> To: linux-kernel@vger.kernel.org
> >>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> >>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> >>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> >>>>>>>> rcu@vger.kernel.org
> >>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> >>>>>>>> completed
> >>>>>>>> 
> >>>>>>>> On many systems, a great deal of boot happens after the kernel thinks the
> >>>>>>>> boot has completed. It is difficult to determine if the system has really
> >>>>>>>> booted from the kernel side. Some features like lazy-RCU can risk slowing
> >>>>>>>> down boot time if, say, a callback has been added that the boot
> >>>>>>>> synchronously depends on.
> >>>>>>>> 
> >>>>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> >>>>>>>> stay expedited for as long as the system is still booting.
> >>>>>>>> 
> >>>>>>>> For these reasons, this commit adds a config option
> >>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> >>>>>>>> rcupdate.boot_end_delay.
> >>>>>>>> 
> >>>>>>>> By default, this value is 20s. A system designer can choose to specify a value
> >>>>>>>> here to keep RCU from marking boot completion.  The boot sequence will not
> >>>>>>>> be marked ended until at least boot_end_delay milliseconds have passed.
> >>>>>>> 
> >>>>>>> Hi Joel,
> >>>>>>> 
> >>>>>>> Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> >>>>>>> 
> >>>>>>> Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the
> >>>>>>> real-time latency than the overall OS boot time?
> >>>>>> 
> >>>>>> But every system has to boot, even an RT system.
> >>>>>> 
> >>>>>>> 
> >>>>>>> If so, we might make rcupdate.boot_end_delay = 0 as the default value
> >>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels?
> >>>>>> 
> >>>>>> Could you measure how much time your RT system takes to boot before the application runs?
> >>>>>> 
> >>>>>> I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.
> >>>>> 
> >>>>> Provide a /sys location that the userspace code writes to when it
> >>>>> is ready?  Different systems with different hardware and software
> >>>>> configurations are going to take different amounts of time to boot,
> >>>>> correct?
> >>>> 
> >>>> I could add a sysfs node, but I still wanted this patch as well
> >>>> because I am wary of systems where yet more userspace changes are
> >>>> required. I feel the kernel should itself be able to do this. Yes, it
> >>>> is possible the system completes "booting" at a different time than
> >>>> what the kernel thinks. But it does that anyway (even without this
> >>>> patch), so I am not seeing a good reason to not do this in the kernel.
> >>>> It is also only a minimum cap, so if the in-kernel boot takes too
> >>>> long, then the patch will have no effect.
> >>>> 
> >>>> Thoughts?
> >>>> 
> >>> Why "rcu_boot_ended" is not enough? As i see right after that an "init"
> >>> process or shell or panic is going to be invoked by the kernel. It basically
> >>> indicates that a kernel is fully functional.
> >>> 
> >>> Or an idea to wait even further? Until all kernel modules are loaded by
> >>> user space.
> >> 
> >> I mentioned in commit message it is daemons, userspace initialization etc. There is a lot of userspace booting up as well and using the kernel while doing so.
> >> 
> >> So, It does not make sense to me to mark kernel as booted too early. And no harm in adding some builtin kernel hysteresis. What am I missing?
> >> 
> > Than it is up to user space to decide when it is ready in terms of "boot completed".
> 
> I dont know if you caught up with the other threads. See replies from Paul and my reply to that.
> 
> Also what you are proposing can be more harmful. If user space has a bug and does not notify the kernel that boot completed, then the boot can stay incomplete forever. The idea with this patch is to make things better, not worse.
> 
I saw that Paul proposed to have a sysfs attribute using which you can
send a notification.

IMHO, to me this patch does not provide a clear correlation between what
is a boot complete and when it occurs. A boot complete is a synchronous
event whereas the patch thinks that after some interval a "boot" is completed.

We can imply that after, say 100 seconds an initialization of user space
is done. Maybe 100 seconds then? :)

--
Uladzislau Rezki
