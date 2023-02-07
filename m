Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDE68D37A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjBGKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:04:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F42A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:04:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso6821487pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ATGKPrbMoj2Us2RrFAuQyzUAMxXAoCxSES/6mtMGbY=;
        b=nBlk71ZDXtc2CpFxmUh1OMZF+QU1yu+GKJm/YL0KyTYBDEyR8+kK1brZLKqN88WkSE
         KUJENQp1ycAAj+0ptVrkFroD14D9wZFCZHreXfhxMQmC4fFXnxCT4Mfob5VqF9E5XUaQ
         nQXTXJdwiWavwk+/CaDqBqZMf6PhpRKkwC+2+vDSS/ZtKRG5RTZE01UZECwJs7tvIEvg
         I1VteZw6w1D/8ZXvFr3mx9q89e/mfmJXGQTTWOMjywlSCW/VXQgrg3YNclZwFkSoVBi8
         60VKF4etpbx+7sMC0FiVcXMrCNwvkIIdu4IEtu8lnPrI/HO2em8eHios50iDjKBQWa4H
         ZyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ATGKPrbMoj2Us2RrFAuQyzUAMxXAoCxSES/6mtMGbY=;
        b=XmZjvq1WO31EpnfILRsRCeH9fExcE4Gfso3tGpRf/me9GcDBMzx9iLoS+Ap2lkBTum
         KkSK5vDm0ixsBeoixjiozDh3+50LEk4bT1LsLEY5S4lTzW5L+7oxtsz48mSrczInbR/+
         sucy4FfPz1OHljBaB2lErZtIxMc8eam++S72SMgflhH65hx58s0ACBcDn61P9/hojD4A
         HqJdAFvkxYSHXiCFeUx/JqA9Oqd/WTRVnoaQHeh2mqaNJ7V1F93p6wDKSeu+B8sYgR97
         TIEHWqCrQ3rR8k1cwGmcNiSHQCSvXd+CuGKjFZMUjiTiJvHiLr2+rQ8Q00ht+2UgBMU6
         2qJg==
X-Gm-Message-State: AO0yUKViepvPvQjbUJ8Z1sbZvliYF7CjnfkObjWiexXlGFF88eUdGCSs
        8HeaWlyF3htyoOBooVQElSp48di12i/kKZFM8HrTOS+LhBo0n2nn
X-Google-Smtp-Source: AK7set/hcRl+XGA4UDFsADqDw9OCj/sukW5R9o3NVgrY62K5hW/3ogywRCV2cnLB8JSxsD/4NX2lL3zT79iTeZ6KVjI=
X-Received: by 2002:a17:90a:c7cf:b0:230:a5d7:a479 with SMTP id
 gf15-20020a17090ac7cf00b00230a5d7a479mr1922849pjb.62.1675764253540; Tue, 07
 Feb 2023 02:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20230205224318.2035646-1-qyousef@layalina.io> <20230205224318.2035646-3-qyousef@layalina.io>
In-Reply-To: <20230205224318.2035646-3-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Feb 2023 11:04:02 +0100
Message-ID: <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
>
> find_energy_efficient_cpu() bails out early if effective util of the
> task is 0. When uclamp is being used, this could lead to wrong decisions
> when uclamp_max is set to 0. Cater for that.
>
> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a21ee74139f..a8c3d92ff3f6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         target = prev_cpu;
>
>         sync_entity_load_avg(&p->se);
> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)

The below should do the same without testing twice p_util_max:
uclamp_task_util(p, p_util_min, ULONG_MAX)


>                 goto unlock;
>
>         eenv_task_busy_time(&eenv, p, prev_cpu);
> --
> 2.25.1
>
