Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F085FE517
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJMWNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMWNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:13:01 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023FE18BE28
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:13:00 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id a6so1468133vkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xLlp+L6UoYHOMNwsqCOlw+S3zS7vqmcy26ijo646RY8=;
        b=O8AEMcxiWJI/qRNaoqxoTmxniQ9mIt/D1O8aw6Xrsja8xvG3vcNZxYIRhpQbVri1F8
         ZqvYt/RpHfeFWiK+32uburTgHLokD29VaTTMabo52h7yqi5/0HoMV3eSvhdA8Q17ndwD
         rA1hRVvKw6wdjCKa5eMKFnfvv8ssXfsRhQvI/t/aHeU71MDMuGcSQQJZCzHv1LQxncDw
         6qZUQUc8unyuy1LuDR8aVyztxamFjvjkT7Jg1MECrfLYRPGO9Gwib6XeOe3AYJjzqrHN
         2ZhhLISav5qVUvTLWp+c0uPxHcsWW2H1fC5dQtGLpN7YAD+6ZThAmPStIjQ6DaUndtHg
         ZQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLlp+L6UoYHOMNwsqCOlw+S3zS7vqmcy26ijo646RY8=;
        b=3DazfaRmy/OJQl5OjZSfCts5j6uOdkVCe0UMsuEkOBBJzCyrQy7pGDxqqOOvLucuCS
         ooluGZSLtxb6Rh/APosxG3cW42Mx0HKwEwT2TEzXOJyF48XP5ldeb8nwVGWPkujx3C2z
         cG0lPZbV0QU3Ddam7u+iA1kQ58dMVeACcaqZ7kbwrLgix6ojt9UKRGfx730WsNp0uSch
         nMfNFFv9PGKZc8/JuiEbjZR45Nl2DHG7dFVq9Md9wx5BXrmk7wT8QfNYMFA+XsZp691d
         R6UlK7mQwSH0GxMrsvtWe69QdUZR2cDNLYUVsx6ppZFFB5u/OYS7nJAzGyrDEZieNwnE
         OQgA==
X-Gm-Message-State: ACrzQf2O3jiu+nK3sZLyEya061trhZ+3kF3IG/HY7iDpkc4txqHEsGos
        GwhZIBYqcVMiQH77vdvfTS2kDazzYQ7sdaEO8I1Omg==
X-Google-Smtp-Source: AMsMyM7V2B+2B0PzcJiVhCmvnZwWQdza7W21iJqVsoyjKadFoMTFXHj2u9GdL4XzCSwWzqoI3oLfk8kXvmdBrzobwOU=
X-Received: by 2002:a1f:5981:0:b0:3a6:6655:831f with SMTP id
 n123-20020a1f5981000000b003a66655831fmr1350689vkb.12.1665699179056; Thu, 13
 Oct 2022 15:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com> <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
In-Reply-To: <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 13 Oct 2022 15:12:53 -0700
Message-ID: <CAAYoRsW+5xbW_Zd7Mtbo4VMi4RZFXRr7mf4NAU=Le7GhQzNJvg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Dietmar.Eggemann@arm.com,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Thu, Oct 13, 2022 at 4:12 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
> On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
> > <kajetan.puchalski@arm.com> wrote:
...

> On the Intel & power usage angle you might have seen in the discussion,
> Doug sent me some interesting data privately. As far as I can tell the
> main issue there is that C0 on Intel doesn't actually do power saving so
> moving the state selection down to it is a pretty bad idea because C1
> could be very close in terms of latency and save much more power.
>
> A potential solution could be altering the v2 to only decrease the state
> selection by 1 if it's above 1, ie 2->1 but not 1->0. It's fine for us
> because arm systems with 2 states use the early exit path anyway. It'd
> just amount to changing this hunk:
>
> +       if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
> +               idx--;
>
> to:
>
> +       if (cpu_data->utilized && idx > 1 && !dev->states_usage[idx-1].disable)
> +               idx--;
>
> What would you think about that? Should make it much less intense for
> Intel systems.

I tested the above, which you sent me as patch version v2-2.

By default, my Intel i5-10600K has 4 idle states:

$ grep . /sys/devices/system/cpu/cpu7/cpuidle/state*/name
/sys/devices/system/cpu/cpu7/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu7/cpuidle/state1/name:C1_ACPI
/sys/devices/system/cpu/cpu7/cpuidle/state2/name:C2_ACPI
/sys/devices/system/cpu/cpu7/cpuidle/state3/name:C3_ACPI

Idle driver governor legend:
teo: the normal teo idle governor
menu: the normal menu idle governor
util or v1: the original patch
util-v2 or v2: V2 of the patch
util-v2-2 or v2-2: the suggestion further up in this thread.

Test 1: Timer based periodic:

A load sweep from 0 to 100%, then 100% to 0, first 73 hertz, then 113,
211,347 and finally 401 hertz work/sleep frequency. Single thread.

http://smythies.com/~doug/linux/idle/teo-util/consume/idle-1/

Summary, average processor package powers (watts):

teo              menu          v1               v2             v2-2
10.19399    10.74804    22.12791    21.0431    11.27865
                     5.44%      117.07%     106.43%     10.64%

There is no performance measurement for this test, it just has to
finish the work packet before the next period starts. Note that
overruns do occur as the workload approaches 100%, but I do not record
that data, as typically the lower workload percentages are the area of
interest.

Test 2: Ping-pong test rotating through 6 different cores, with a
variable packet of work to do at each stop. This test goes gradually
through different idle states and is not timer based. A different 2
core test (which I have not done) is used to better explore the idle
state 0 to idle state 1 transition. This test has a performance
measurement. The CPU scaling governor was set to performance. HWP was
disabled.

http://smythies.com/~doug/linux/idle/teo-util/ping-sweep/6-1/loop-times.png
http://smythies.com/~doug/linux/idle/teo-util/ping-sweep/6-1/loop-times-detail-a.png
http://smythies.com/~doug/linux/idle/teo-util/ping-sweep/6-1/

Summary:

Average processor package power (watts):
teo            v2-2            menu
27.3881    29.98293    28.04096
                 9.47%        2.38%

Execution time for the entire test (minutes):
teo   v2-2        menu
56    54.667    55.333
        -2.38%    -1.19%

However, notice that in the idle-state 0 and 1 region, V2-2 uses more
power and its loop time is longer (less is better), but also in the
deeper idle states regions V2-2 uses more power and also runs faster.

teo: 36.4 watts and 10.3533 usecs/loop.
menu: 36.8 watts and 10.1604 usecs/loop.
util-v2-2: 38.8 watts and 11.2358 usecs/loop.

and

teo: 15.2 watts and 1,777.6 usecs/loop.
menu: 15.6 watts and 1767.4 usecs/loop.
util-v2-2: 17.4 watts and 1618.7 usecs/loop.

... Doug
