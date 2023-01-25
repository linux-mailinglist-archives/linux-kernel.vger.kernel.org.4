Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895C667ABE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjAYIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjAYIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:37:15 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D71BDA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:37:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so12946384pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Nec76Oi0E+mrHL8wSYgF34A1/FIvu+NGyByFAKcaY=;
        b=Aa+UpWul0pfvnY1IDnj12S/PyC1uh+eOIlvAp+l2dcwh6xjmt6IPjfhuq/TEQTxEsh
         c7aIvJ8QkwEssT69lVo3cVNo5YLseNB2Nap7LxWl3FreYgJz8YYJ4lT+4sIui/ZR1TMZ
         UfxrdLdrucFqrTuo3CHKo4NIo8kwzLKaP73DmfiRaZ8m5+MQuoRLZ5zdCvHH81IG5+/b
         gAWCO4MXXjCdbrRNalRv9yicG9tJ1Y331eUdiwj0acp0ymj/Vc6JJ8c7BpmPRMI+eaba
         lb4B1NLMKE4T+JxnvTMqM6tbAjCZk864rdLVIX1LVYwbGcNCbwTsqAdKN4HG68SZISnG
         F7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Nec76Oi0E+mrHL8wSYgF34A1/FIvu+NGyByFAKcaY=;
        b=B7pJs9/EICH7YYN0SXwtODEMEZh6XE8gW1Qnn6DkuZ4oMJoT0DitnpRPfE9FpdoOQP
         i4voI45VvyhdztAQyHEDSLYQTfnRJXzeDoNfpPfiGORZchLTezIG9tfj4fuL7o1DwsR9
         SxaT2yCZqqXpoC+uAYzReE7dJ2QXqPGRN5X0drOaJvmisoxNHgLhqzhCsIQyPFAoy4nu
         Q7htIABD6OByYbAm06b71XoYT6ekcmz88cQQCpkAZl4hTwShL2cEfvowZEQfbrOvOV5F
         7ZRpOpKlCbmq5KrgqIlzm5p2r9EI9UKT5FPcEDzq+CTW8cm+FBr8tImDKM/IHopNDbFP
         E7KA==
X-Gm-Message-State: AFqh2kqxoU4HvDYwwbgGQVngvOhvTCXXCetjHIXS2D9rJOWFKBVkaeJV
        3C1Y6+QcfOYct6bYs5qzA1Y5yVntA2J3jUB9yuCFgg==
X-Google-Smtp-Source: AMrXdXv0NmesZGztdzXUh/Zk/swdQdcARb22fUY+pOh/ib/o2jBP2fEXJYTqAswc/REwktUn9vVRzBViDt1jsdL/AaA=
X-Received: by 2002:a63:946:0:b0:4cf:7ba0:dd5a with SMTP id
 67-20020a630946000000b004cf7ba0dd5amr2971793pgj.119.1674635833651; Wed, 25
 Jan 2023 00:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20230119174244.2059628-1-vincent.guittot@linaro.org> <Y9CJ3w4q/NCw5RcK@e126311.manchester.arm.com>
In-Reply-To: <Y9CJ3w4q/NCw5RcK@e126311.manchester.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Jan 2023 09:37:02 +0100
Message-ID: <CAKfTPtAm39hJk_=M08ceFUFwac2jj92-z=r2cev3K9JZ1xHDxg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 at 02:46, Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi,
>
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg may
> > not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
> >
>
> Just wanted to include some more test data here to flag potential issues
> with how all these changes use thermal pressure in the scheduler.
>
> For the tables below, 'baseline' is pre the already merged "uclamp fits
> capacity" patchset.
> 'baseline_ufc' is the current mainline with said patchset applied.
> The 'no_thermal' variants are variants with thermal handling taken out
> of util_fits_cpu akin to the v1 variant of the patchset.
> The 'patched' variants are the above but with the v4 of the 'unlink misfit
> task' patch applied as well.
>
> Geekbench 5:
>
> +-----------------+-------------------------+--------+-----------+
> |     metric      |         kernel          | value  | perc_diff |
> +-----------------+-------------------------+--------+-----------+
> | multicore_score |        baseline         | 2765.4 |   0.0%    |
> | multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   | <-- mainline score regression
> | multicore_score | baseline_ufc_no_thermal | 2870.8 |   3.81%   | <-- ~170 pts better without thermal
> | multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   | <-- no more regression but worse than above
> | multicore_score | ufc_patched_no_thermal  | 2891.0 |   4.54%   | <-- best score
> +-----------------+-------------------------+--------+-----------+
>
> +--------------+--------+-------------------------+--------+-----------+
> |  chan_name   | metric |         kernel          | value  | perc_diff |
> +--------------+--------+-------------------------+--------+-----------+
> | total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
> | total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
> | total_power  | gmean  | baseline_ufc_no_thermal | 2710.0 |   1.73%   |
> | total_power  | gmean  |     ufc_patched_v4      | 2729.0 |   2.44%   |
> | total_power  | gmean  | ufc_patched_no_thermal  | 2778.1 |   4.28%   |
> +--------------+--------+-------------------------+--------+-----------+
>
> (Jankbench scores show more or less no change, Jankbench power below)
>
> +--------------+--------+------------------------------+-------+-----------+
> |  chan_name   | metric |            kernel            | value | perc_diff |
> +--------------+--------+------------------------------+-------+-----------+
> | total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
> | total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   | <-- mainline power usage regression
> | total_power  | gmean  | baseline_ufc_no_thermal_60hz | 134.5 |  -1.01%   | <-- no more regression without the thermal bit
> | total_power  | gmean  |     ufc_patched_v4_60hz      | 131.4 |  -3.26%   | <-- no more regression with the patch either
> | total_power  | gmean  | ufc_patched_no_thermal_60hz  | 140.4 |   3.37%   | <-- both combined increase power usage
> +--------------+--------+------------------------------+-------+-----------+
>
> Specifically the swing of +15% power to -1% power by taking out thermal
> handling from util_fits_cpu on the original patchset is noteworthy. It
> shows that there's some subtle thermal-related interaction there taking
> place that can have adverse effects on power usage.
>
> Even more interestingly, the 'unlink misfit task' patch appears to be
> preventing said interaction from happening down the line as it has a
> similar effect to that of just taking out the thermal bits.
>
> My only concern here is that without taking a closer look at the thermal
> parts this power issue shown above could easily accidentally be
> reintroduced at some point in the future.

Yes, the handling of thermal pressure needs some closer look. It has
been agreed to keep the current behavior for now and have a closer
look on thermal pressure as a next step. And your results for
ufc_patched_v4_* provide some reasonably good perf and power figures.

Thanks

>
> > --
> > 2.34.1
> >
