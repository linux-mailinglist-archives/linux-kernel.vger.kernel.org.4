Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9C737D90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFUIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFUIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:30:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED410DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:30:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ff29d0dd1eso18658721cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687336225; x=1689928225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+UWPSWITmiKDuCRaIwKK0MPFGYW1yMA6/uSK95qKKU=;
        b=KiKKDOxCCy2KZvd94IFLCLpS6FWbGlC1QxSDxl+JzUj/ZwzvvBdgLC7sIy8nyxcoOs
         zuNmBMVPhw2ivx+rUQcitJdTWgyUWcjBayF2kJP6B6RXYDqq2Rc3XKlL4Vr+IXuK71Dr
         ZmnrfMmI+vQ12EDXUgBC3865vcqrkVWQfrX6ltZn0REwWmK5ke+WT42Xf6Ev78XF/J7X
         SEDYD6BaprYjM2F3tOor8Ia7kpahIquhdPrbQ8gHm3Eqzq4mU6m3U1CdRncmDO2aght4
         amtheNijxqWg1CkIg+9LjczP8dE2V5zq0MDnLlKEnrWtCdsYdPid4i510LGIzmEVsctp
         QGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336225; x=1689928225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+UWPSWITmiKDuCRaIwKK0MPFGYW1yMA6/uSK95qKKU=;
        b=jFqAdNWYHjsMFliFJOJTDNTk/T2W6NmGE9sIVpC+7NKAEyfTvsfnrEcCk2KI5N/9yv
         LR9oEZooP51duLl8MCEiRFexLqGRka3jRUMthzTG87qVl+nJARXD3ts0p8SogLO84y3p
         WhrmUmBK9v8xwDg92LPlw+HbDHF0ilNLnOYGG5CLq0IvSrNBkhiBexZ9g/G5JL+sFCUI
         C+LTWTRsE4EfcNSJOUgzfZpUjkXfhZ72I3K4o3uFZsPqHaQcldC4eO7mXVu6x5cdvmvs
         tkgJmEKi+3BFb124FHvxV9fRwzOGxNATfEO3s8NPbCso4Zo3LJTFouXMACWM7Cc+8q+X
         r7nQ==
X-Gm-Message-State: AC+VfDx85xHOP/auP3XBBsUYC2mRb61AJa9eInjSN6HY8K0tnMwxeGRW
        S+SmSMQSMY32Cs75ZTCvQmv4T5C11xwPWibIR6dO9bnalVKuJXa1Is8=
X-Google-Smtp-Source: ACHHUZ7fmwSgBX7k6SgOZefuRlBuBj96PPfT9fWbSNYqx5Mm9jaCZyT5aps8njSfBHSqxqRi1XiWxKbODtjR3qQNly8=
X-Received: by 2002:a05:622a:1106:b0:3ff:405e:90d7 with SMTP id
 e6-20020a05622a110600b003ff405e90d7mr575701qty.21.1687336225553; Wed, 21 Jun
 2023 01:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230621071605.3853119-1-linmiaohe@huawei.com>
In-Reply-To: <20230621071605.3853119-1-linmiaohe@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Jun 2023 10:30:14 +0200
Message-ID: <CAKfTPtCVVnhb7S=iC3vmfJbPj9Ug+W33pw6VuFO6De0FcTuNQA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix returning possible non-optimal candidate
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 09:16, Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> In best_fits < 0 case, best_thermal_cap > prev_thermal_cap is checked to
> determine whether best_energy_cpu should be returned. But prev_fits can
> be > 0 in this case and it should be preferred.

IIRC, (best_thermal_cap > prev_thermal_cap) makes the condition
(prev_fits < 0) useless

Do you have a use case where
(best_fits < 0)
&& (prev_fits > 0)
&& (best_thermal_cap > prev_thermal_cap)
?

>
> Fixes: e5ed0550c04c ("sched/fair: unlink misfit task from cpu overutilized")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 28ff831ee847..a4e300fc44be 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7684,7 +7684,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         if ((best_fits > prev_fits) ||
>             ((best_fits > 0) && (best_delta < prev_delta)) ||
> -           ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> +           ((best_fits < 0) && (prev_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
>                 target = best_energy_cpu;
>
>         return target;
> --
> 2.27.0
>
