Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB263985B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKZV5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKZV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:57:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFE17E30
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:56:59 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x66so7076627pfx.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXvSXsnVgidv7Ztx1d8hz00A7C0Ptolg8ldQ6PqQ4Ic=;
        b=aevaMChFxRmIohxW8lj24GrZNXqH8YZqBnEmiHnNpDGrrTr+WyQ86sAh4G9f9cI374
         n2dXSq2lRqt+VlQcbN/pzGWNk5CDCl68IFouBS1oXaytzaVrPquFqJOG2pI/+m2aCUZJ
         /+rjPUA1lS+oMdsUELOBi8igW8cnmWdYSh1nIi39ngl04dWNsqQTNxThkx8RXA3uNT1S
         unuIRTdqJ/FcgdDh+iTpHs5jftiJRkb/Y9q2i9m+QBgXCqP0OzxYOGaipR+8tjhJeKoB
         e5bJAUxVCR3VikgtryKF3KBaOmDx711oFx6UNG/YJ4rBRYbVz2vK5LmHOevvhDdhWPUg
         ZD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXvSXsnVgidv7Ztx1d8hz00A7C0Ptolg8ldQ6PqQ4Ic=;
        b=xelKyVYsw2rEcAQJGB4Z1gvz0lQICtcOeIWvul4rWLB5QjWYRyDleQT7q7YO2fxv0I
         MzhHc1TqtdgXAiKazxXnhTgVWdZk3EweBNDZxSrr4vkupcc8dSATY9SIAVxXHikjfiUL
         7BhQDAgJY4wUDj4LZQWMtZL6Tz61HLfXWh36P4uiAcXS5AvRnqtsua0l3O2FTr2VdQ1y
         GeskcMkA656PGfqX1hS0RUi2x8Zs+CSEdgJcaIrjFFzPKxy0Y9HVXcziUrkZ+iHIOrkk
         3dWDj/os9bJ6TtsCk88lg/PraOL1k8ltIvlGUUk7SB3QP7kUPGuk7Eq1DOFcQSY9bj3V
         QKOA==
X-Gm-Message-State: ANoB5pkju5gOU573LhX1O3d/iTxLvpHslv0t7+nNxSkojzZB11WbCxPh
        TrCwv85OPLBxtE5mIdpnNO/8vw==
X-Google-Smtp-Source: AA0mqf4GiKo4QqdYoLjhknMMRXbR/RmTXtcRR4X+0mPvJiEvUkD4vt54Kn+nNJsZUmK+JdOgd5nIfw==
X-Received: by 2002:a63:180a:0:b0:470:63e5:5c59 with SMTP id y10-20020a63180a000000b0047063e55c59mr20934227pgl.172.1669499819121;
        Sat, 26 Nov 2022 13:56:59 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id g199-20020a6252d0000000b005742ee445fdsm5135909pfb.70.2022.11.26.13.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Nov 2022 13:56:58 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Zhang Rui'" <rui.zhang@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <lukasz.luba@arm.com>,
        <Dietmar.Eggemann@arm.com>, <yu.chen.surf@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Kajetan Puchalski'" <kajetan.puchalski@arm.com>,
        <rafael@kernel.org>, "Doug Smythies" <dsmythies@telus.net>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>         <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>   <00a801d8ffba$6cd72a70$46857f50$@telus.net> <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
In-Reply-To: <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
Subject: RE: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
Date:   Sat, 26 Nov 2022 13:56:58 -0800
Message-ID: <003d01d901e2$025853c0$0708fb40$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHHOljlUm50YLRjgI6z6kjqb0X0CQFCgUFLAeYd9UEBNQeK365SV9hQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022.11.26 08:26 Rui wrote:
> On Wed, 2022-11-23 at 20:08 -0800, Doug Smythies wrote:
>> On 2022.11.21 04:23 Kajetan Puchalski wrote:
>>> On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:
>>> 
>>> [...]
>>> 
>>>> v3 -> v4:
>>>> - remove the chunk of code skipping metrics updates when the CPU
>>>> was utilized
>>>> - include new test results and more benchmarks in the cover
>>>> letter
>>> 
>>> [...]
>>> 
>>> It's been some time so I just wanted to bump this, what do you
>>> think
>>> about this v4? Doug has already tested it, resuls for his machine
>>> are
>>> attached to the v3 thread.
>> 
>> Hi All,
>> 
>> I continued to test this and included the proposed ladder idle
>> governor in my continued testing.
>> (Which is why I added Rui as an addressee)
>
> Hi, Doug,

Hi Rui,

> Really appreciated your testing data on this.
> I have some dumb questions and I need your help so that I can better
> understand some of the graphs. :)
>
>> However, I ran out of time. Here is what I have:
>> 
>> Kernel: 6.1-rc3 and with patch sets
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>> CPU scaling driver: intel_cpufreq
>> HWP disabled.
>> Unless otherwsie stated, performance CPU scaling govenor.
>> 
>> Legend:
>> teo: the current teo idle governor
>> util-v4: the RFC utilization teo patch set version 4.
>> menu: the menu idle governor
>> ladder-old: the current ladder idle governor
>> ladder: the RFC ladder patchset.
>> 
>> Workflow: shell-intensive serialized workloads.
>> Variable: PIDs per second.
>> Note: Single threaded.
>> Master reference: forced CPU affinity to 1 CPU.

This is the 1cpu on the graph.

>> Performance Results:
>> http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-perf.png
>> Schedutil Results:
>> http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-su.png
>
> what does 1cpu mean?

For shell-intensive serialized workflow or:

Dountil the list of tasks is finished:
    Start the next task in the list of stuff to do (with a new PID).
    Wait for it to finish
Enduntil

We know it represents a challenge for CPU frequency scaling drivers,
schedulers, and therefore idle drivers.

We also know that the best performance is achieved by overriding
the scheduler and forcing CPU affinity. I use this "best" case as the
master reference, using the label 1cpu on the graph.
 
>> Workflow: sleeping ebizzy 128 threads.
>> Variable: interval (uSecs).
>> Performance Results:
>> http://smythies.com/~doug/linux/idle/teo-util/graphs/ebizzy-128-perf.png
>> Performance power and idle data:
>> http://smythies.com/~doug/linux/idle/teo-util/ebizzy/perf/
>
> for the "Idle state 0/1/2/3 was too deep" graphs, may I know how you
> assert that an idle state is too deep/shallow?

I get those stats directly from the kernel driver statistics. For example:

$ grep . /sys/devices/system/cpu/cpu4/cpuidle/state*/above
/sys/devices/system/cpu/cpu4/cpuidle/state0/above:0
/sys/devices/system/cpu/cpu4/cpuidle/state1/above:38085
/sys/devices/system/cpu/cpu4/cpuidle/state2/above:7668
/sys/devices/system/cpu/cpu4/cpuidle/state3/above:6823

$ grep . /sys/devices/system/cpu/cpu4/cpuidle/state*/below
/sys/devices/system/cpu/cpu4/cpuidle/state0/below:72059
/sys/devices/system/cpu/cpu4/cpuidle/state1/below:246573
/sys/devices/system/cpu/cpu4/cpuidle/state2/below:7817
/sys/devices/system/cpu/cpu4/cpuidle/state3/below:0

I keep track of the changes per sample interval and graph
the sum for all CPUs as a percentage of the usage of
that idle state.

Because I can never remember what "above" and "below"
actually mean, I use the terms "was too shallow"
and "was too deep".

... Doug


