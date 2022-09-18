Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD75BBC48
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIRHRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIRHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 03:17:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F673140E1;
        Sun, 18 Sep 2022 00:17:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so25231418plr.8;
        Sun, 18 Sep 2022 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jVQdtAnk7yeJHbTtejI0ZuEOn/jdYQQvgJtPBR0mF4o=;
        b=p6poeio+Jc0YExU77vFceRBnBt0KPk+soMTWiWQCBlkHrOXVldH3pbHXQskiNqIkGW
         3zMFdytQiCiUC3j1Cz9Odj+bL6uvRKbRXFvx6Z2MZZCEcgV77pXOa56909OHASBwoBKl
         nmlZ0+SprnRqhxjpI+4WStiEcK06QtHv7Y420lN4tjypnfXJ4RSfHLw4Q+pX1zHTWaSs
         x07h13thIIL3VQ92Y0/DIoHy9mafdfG07KVTa9oWiSvThskc/7xyVEDd8p84gcb9Xk+p
         Kn+lsQ0feSAS8MFugm3Bvd4bm6uqDdwDRllkXncnuSBQ4xDloiY/THnApdDJSgW255F0
         egvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jVQdtAnk7yeJHbTtejI0ZuEOn/jdYQQvgJtPBR0mF4o=;
        b=AqXYaIxoJYPHvPCcMo2jaNnOivx2BGzuauXgL0P/Wy340a16/U7piOUf3bU6g5Eb0S
         SBI6t7H6ERrm5uQW2vMxArslJ9Ik63Y6ftGzsidQeDGfSUTsCxr7IJVafN4NNVk1SK5h
         rAOI2w740Ht1uy/1hI2eDPc8kjmx2MCzSDhfxsdyCgE9gCfZ4KUlIj8nFTPbzvo5IWhD
         1w8GUZFt3TMCZpJgbyuhu7GC2xPxdwPhWk6waMOtDK8Ua3bFYp1St1aXURXtiHFSwHld
         DjTUT/y62pkIa2F1rUO/uQug7YgGjUJ6GsekqYWGQ8H2Omsp7QArSL6/gl9BYGtYZ9wI
         VwTg==
X-Gm-Message-State: ACrzQf3e/dLe5zhWLIH21oMiDaIORn4pnrwLZBYXaRT/zRADSaEzkExK
        SjEUgsajtid6gtUI9qqj7S+jrFI9VOMCWyw4fSA=
X-Google-Smtp-Source: AMsMyM5vlTD82XMSuq2QR7dkA2wBsq1lvjUaxTGvhI8+ZPmSqDGXiSIQS1LmJ1Iq9JJEbT+mv2g9yO7V/WOJ+xzmZ3A=
X-Received: by 2002:a17:90b:4b43:b0:202:e09c:664d with SMTP id
 mi3-20020a17090b4b4300b00202e09c664dmr24304420pjb.120.1663485434019; Sun, 18
 Sep 2022 00:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com> <20220915164411.2496380-2-kajetan.puchalski@arm.com>
In-Reply-To: <20220915164411.2496380-2-kajetan.puchalski@arm.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sun, 18 Sep 2022 15:17:02 +0800
Message-ID: <CADjb_WR9=p=9nX9oJLv5ZCrrSaHt58Yh22K2=S9E71fSdr0+KA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] cpuidle: teo: Add optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:49 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Modern interactive systems, such as recent Android phones, tend to have
> power efficient shallow idle states. Selecting deeper idle states on a
> device while a latency-sensitive workload is running can adversely impact
> performance due to increased latency. Additionally, if the CPU wakes up
> from a deeper sleep before its target residency as is often the case, it
> results in a waste of energy on top of that.
>
> This patch extends the TEO governor with an optional mechanism adding
> util-awareness, effectively providing a way for the governor to switch
> between only selecting the shallowest idle state when the cpu is being
> utilized over a certain threshold and trying to select the deepest possible
> state using TEO's metrics when the cpu is not being utilized.
Not sure if we can use util_avg as schedutil, but it looks interesting.
The last time I was trying to propose an idea to leverage util_avg to
optimize some
codes in the kernel, it was suggested that it would be better to make
the stategy
gradual rather than 0,1 state. So I was thinking if we could make it
something like:

next_idx = cpuidle_select();
next_idx = next_idx * (cpu_cap - util_avg) / cpu_cap;

The lower the util_avg is, the more we honor the choice of the governor,
vice versa.
> This is now possible since the CPU utilization is exported from the scheduler with the
> sched_cpu_util function and already used e.g. in the thermal governor IPA.
>
> This can provide drastically decreased latency and performance benefits in
> certain types of mobile workloads that are sensitive to latency,
> such as Geekbench 5.
As Doug mentioned in another thread, the impact data to energy consumption would
also be interesting.

thanks,
Chenyu
