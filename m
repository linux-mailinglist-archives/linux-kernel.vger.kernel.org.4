Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78C6D76E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbjDEI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjDEI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:29:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724981FF6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:29:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-93db98f7b33so22254966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680683364; x=1683275364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sV9vVS27Sp3NURS8vTqur665xkAJMR0epBqqultGfGg=;
        b=qi33BRFVqz1V3zQfc6Oq9T0mEBS7PrTZh44+2okXt3ZCKe1U+bKL8T4+Zqxjrss+HS
         EOQe7wtVI6HF7NwjdfyH1C6flf00HBZfnpPfulIYiMNPsRW0wGndB7he+GGDrWCKZFMi
         2VLN9pUoL1rc0MUcqq9aMl+sLrBYkgYvvEzp79Jx/3ZIdyFTFqftHwlZNaL+GkEWl918
         YpX4MSgRHQZEnutgrd7d1w5WzbiWqnhGV+xNCRZZdM8JSyoDmKdUnHdj4x4beJqXyMsp
         4JFbMLTERl3XOUhEPWeHyjVtrDsGk/BsbOI0Nq7+lXHj1yxdxfXMYBxRd0NDnLn50Y54
         bUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680683364; x=1683275364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV9vVS27Sp3NURS8vTqur665xkAJMR0epBqqultGfGg=;
        b=B00pgBCR9iN+5ATzSQOZtIPfcraAU+gJB07s/3xPWlnNRspQRgGsq8Q5QninNRmb+q
         B+AMSW3upGMYruv1SWnuiXGjztpRoOyHCbwakgvqug4feFhYEsYslHsceK1wwFoJbtTQ
         4zEVv+Rxlntf0fIdcWq7nwmP5LBAjLOFAQWfPWgkYeFThJQngSXXQQ092kEbX64aRfWy
         Fz4R/VllR1lSHMoPFx57g4Z12rVVxeWcbRndQi/nuD8nXdasq7fymW/kBrMbuE5MoypN
         dwK/vRkmgOQVBvB3s5DCuAoWicimdAo1YWw/yXw92kuJpYYMHfA+eM9NCULwjlLFrxhl
         i67A==
X-Gm-Message-State: AAQBX9euy+gF0W47Vdv0j6n+ivY2RUpkOmJLXu7IusrOlFiE2nXJznA1
        1/5gCCIQPrvfPv+q9Z9TETNECg==
X-Google-Smtp-Source: AKy350ZdjNFKr/cFq1WemzVh73JzjF5McnL2jahHztWkhSQrr0ddVrttuAui4cT99R86TnXPOohS/w==
X-Received: by 2002:a05:6402:1b1e:b0:502:246e:6739 with SMTP id by30-20020a0564021b1e00b00502246e6739mr972047edb.27.1680683363782;
        Wed, 05 Apr 2023 01:29:23 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008f767c69421sm7080278ejc.44.2023.04.05.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:29:23 -0700 (PDT)
Date:   Wed, 5 Apr 2023 08:29:20 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Dai <davidai@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
Message-ID: <ZC0xYKAmkA7ojhyt@google.com>
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-2-davidai@google.com>
 <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com>
 <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 Apr 2023 at 18:11:37 (-0700), David Dai wrote:
> On Mon, Apr 3, 2023 at 4:40 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> > I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't be
> > used here instead p->se.avg.util_guest.
> Using p->uclamp_req[UCLAMP_MIN].value would result in folding in
> uclamp values into task_util and task_util_est for all tasks that have
> uclamp values set. The intent of these patches isn’t to modify
> existing uclamp behaviour. Users would also override util values from
> the guest when they set uclamp values.

That shouldn't be a problem if host userspace is responsible for driving
the uclamp values in response to guest frequency requests in the first
place ...

> > I do understand the issue of inheriting uclamp values at fork but don't
> > get the not being `additive` thing. We are at task level here.
> Uclamp values are max aggregated with other tasks at the runqueue
> level when deciding CPU frequency. For example, a vCPU runqueue may
> have an util of 512 that results in setting 512 to uclamp_min on the
> vCPU task. This is insufficient to drive a frequency response if it
> shares the runqueue with another host task running with util of 512 as
> it would result in a clamped util value of 512 at the runqueue(Ex. If
> a guest thread had just migrated onto this vCPU).

Maybe it's a feature rather than bug?

It's not obvious giving extra powers to vCPU threads that other host
threads don't have is a good idea. The fact that vCPU threads are
limited to what the VMM would be allowed to request for its other
threads is more than desirable. I'd even say it's a requirement.

Thanks,
Quentin
