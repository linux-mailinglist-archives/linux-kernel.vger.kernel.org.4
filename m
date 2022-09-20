Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171E5BE233
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiITJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiITJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:38:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B38A6BD74;
        Tue, 20 Sep 2022 02:38:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52247139F;
        Tue, 20 Sep 2022 02:38:42 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C8423F73B;
        Tue, 20 Sep 2022 02:38:32 -0700 (PDT)
Date:   Tue, 20 Sep 2022 10:38:17 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, kajetan.puchalski@arm.com
Subject: Re: [RFC PATCH 1/1] cpuidle: teo: Add optional util-awareness
Message-ID: <YymJz1pk5l2oKeAN@e126311.manchester.arm.com>
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
 <20220915164411.2496380-2-kajetan.puchalski@arm.com>
 <CADjb_WR9=p=9nX9oJLv5ZCrrSaHt58Yh22K2=S9E71fSdr0+KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjb_WR9=p=9nX9oJLv5ZCrrSaHt58Yh22K2=S9E71fSdr0+KA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure if we can use util_avg as schedutil, but it looks interesting.
> The last time I was trying to propose an idea to leverage util_avg to
> optimize some
> codes in the kernel, it was suggested that it would be better to make
> the stategy
> gradual rather than 0,1 state. So I was thinking if we could make it
> something like:
> 
> next_idx = cpuidle_select();
> next_idx = next_idx * (cpu_cap - util_avg) / cpu_cap;
> 
> The lower the util_avg is, the more we honor the choice of the governor,
> vice versa.

Would that be in order to still make use of intermediate idle states (ie
the ones between first and last) or to change how the util threshold
works? It seems similar to the issue Doug pointed out.

I think there's two scenarios here, the idle landscape on Arm just looks
really different from the one on x86/Intel and we should probably
account for that. In our use case "gradual" and 0-1 are the same thing,
it's just all about how you set the threshold. On x86 on the other hand
you have the threshold and the approach to state selection to worry about.

This just further makes me think that separating this out into a
separate governor is preferable as this can work really nicely on
certain systems like ours and really badly on others like Doug's. We
probably shouldn't be bundling this with generic solutions like TEO that
work well across the board.

It might also make sense to have slightly different implementations for
x86 and arm to account for the hardware differences but that'd also be
up to Rafael to express a view on.

> > This is now possible since the CPU utilization is exported from the scheduler with the
> > sched_cpu_util function and already used e.g. in the thermal governor IPA.
> >
> > This can provide drastically decreased latency and performance benefits in
> > certain types of mobile workloads that are sensitive to latency,
> > such as Geekbench 5.
> As Doug mentioned in another thread, the impact data to energy consumption would
> also be interesting.

I included energy consumption plots in the pdf I linked in the cover
letter, here's the link:

https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc676b942c8e6498fb9bd03/idle_util_aware.pdf

The unit on the plots is gmean mW measurement so they reflect average
power usage over the course of the benchmark. They also include a column
with 'shallow' which shows power consumption with only C0 and visualises
why this works on arm and how different this is compared to x86
behaviour described by Doug.

> thanks,
> Chenyu
