Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666446A7203
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCARZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCARZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:25:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A239CC2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:25:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso8319221wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNndX+4H6chLO8I+hh1AmWGxekdA39u70kqNHMkfGjY=;
        b=x4ljvNS3rbM3v+lGgoSmYbwXMU6AkIyfLscDpIWH9hVDIjNG+MFfEikJGKS+J5q1/H
         2/FaxFtc3HridEfmxTRg1eUW+lU6a2fH/K4Xew8lXwSMFolWKiLuRvG10Olfn7zZshCy
         TAzomCLt2PL6tVE2vHBUSKC9qWf3GY4pzjYQ0AzvOcZsfNO5B4zp10nNrr0WtVvSNYia
         0B/8PvkndWHx75VrEOwpbdIilDgHgFsepDTLNVj1vR9qdBNjNFl2/LcgHvQ8Zxvpog26
         p4Ug9BPi3Xu0l+si1MDfFKLXSOtiU/LhBGLOmIpqdMtk2fjGIwaimzot7a0UUJbxJHCC
         YhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNndX+4H6chLO8I+hh1AmWGxekdA39u70kqNHMkfGjY=;
        b=glfW39/w8A/Q0d3zfdA0eXJeIQnUO0ywt+tHRqrPRKqqAG/qyggbqw79rn2GyU9Os3
         F2bvwomhHKc98Vutnco8jZNU/FmY1VPj6UGST4D757LpkpE+A7xfKf8XGIaIL2peHWm1
         NlTphndOrHlq6Zhuw8CksHQm8BRf/ZFnZ7MtT0/zQYJBiqo8AMQ1cgCNxVsuBuXgFa4I
         QUyy7Ek+7e6izv+F7JOTNFgurF48+dNEcXWMcV3i9JwoazVbpIvjD1RBC/MYTdoGNKSU
         7VASTg17qDYiV43Q0PSDgpG7TFRPv7MPr9YpZ5vHAwfI07AU6/OoqG7yqeTASTU4ySzv
         GSkg==
X-Gm-Message-State: AO0yUKXGRE9pQVjCJrP5Ie7xSLZGbbVASXgRD5D+vKH+FzTheu1CMaC6
        k+ZHHPqHmB98+u4hHSDK9TxRWQ==
X-Google-Smtp-Source: AK7set9Hn0i50GSL/UVSOJbZ6KQPVu0yp4zHQDiZPoRGJGUCBrpQplmmnMzEEoHHnvy0XjnxLxOlKA==
X-Received: by 2002:a05:600c:3b26:b0:3ea:f05b:50cc with SMTP id m38-20020a05600c3b2600b003eaf05b50ccmr6391473wms.8.1677691501123;
        Wed, 01 Mar 2023 09:25:01 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id hn4-20020a05600ca38400b003dc5b59ed7asm211450wmb.11.2023.03.01.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:24:59 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:24:58 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20230301172458.intrgsirjauzqmo3@airbuntu>
References: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/23 11:39, Vincent Guittot wrote:
> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/09/23 17:16, Vincent Guittot wrote:
> >
> > > I don't see how util_est_faster can help this 1ms task here ? It's
> > > most probably never be preempted during this 1ms. For such an Android
> > > Graphics Pipeline short task, hasn't uclamp_min been designed for and
> > > a better solution ?
> >
> > uclamp_min is being used in UI and helping there. But your mileage might vary
> > with adoption still.
> >
> > The major motivation behind this is to help things like gaming as the original
> > thread started. It can help UI and other use cases too. Android framework has
> > a lot of context on the type of workload that can help it make a decision when
> > this helps. And OEMs can have the chance to tune and apply based on the
> > characteristics of their device.
> >
> > > IIUC how util_est_faster works, it removes the waiting time when
> > > sharing cpu time with other tasks. So as long as there is no (runnable
> > > but not running time), the result is the same as current util_est.
> > > util_est_faster makes a difference only when the task alternates
> > > between runnable and running slices.
> > > Have you considered using runnable_avg metrics in the increase of cpu
> > > freq ? This takes into the runnable slice and not only the running
> > > time and increase faster than util_avg when tasks compete for the same
> > > CPU
> >
> > Just to understand why we're heading into this direction now.
> >
> > AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> > migration) which both are tied to utilization signal.
> >
> > Wouldn't make the util response time faster help not just for rampup, but
> > rampdown too?
> >
> > If we improve util response time, couldn't this mean we can remove util_est or
> > am I missing something?
> 
> not sure because you still have a ramping step whereas util_est
> directly gives you the final tager

I didn't get you. tager?

> 
> >
> > Currently we have util response which is tweaked by util_est and then that is
> > tweaked further by schedutil with that 25% margin when maping util to
> > frequency.
> 
> the 25% is not related to the ramping time but to the fact that you
> always need some margin to cover unexpected events and estimation
> error

At the moment we have

	util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection

I think we have too many transformations before deciding the current
frequencies. Which makes it hard to tweak the system response.

> 
> >
> > I think if we can allow improving general util response time by tweaking PELT
> > HALFLIFE we can potentially remove util_est and potentially that magic 25%
> > margin too.
> >
> > Why the approach of further tweaking util_est is better?
> 
> note that in this case it doesn't really tweak util_est but Dietmar
> has taken into account runnable_avg to increase the freq in case of
> contention
> 
> Also IIUC Dietmar's results, the problem seems more linked to the
> selection of a higher freq than increasing the utilization;
> runnable_avg tests give similar perf results than shorter half life
> and better power consumption.

Does it ramp down faster too?


Thanks

--
Qais Yousef

> 
> >
> > Recently phoronix reported that schedutil behavior is suboptimal and I wonder
> > if the response time is contributing to that
> >
> >         https://www.phoronix.com/review/schedutil-quirky-2023
> >
> >
> > Cheers
> >
> > --
> > Qais Yousef
