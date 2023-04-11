Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A896DE5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDKUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDKUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:41:15 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DE3C11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:41:14 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id a9so8959751vsh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681245674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4gMQcqO2DbgSXcTyVncrRLFbOppq69F+PFdQeqpv4E=;
        b=O9BBaZoSETZXTE57vPSC5X/VJANGWR7nGvGSrXrdGaMEmExwb30GUdHxFNBPHNb7lY
         QyM1Uinb9bzJsRtOn97vQMRY7W5v4EdOUOi6A+IRbMTqORjAIOycGq0ZyGgSdT9lyY98
         F11nnKbhG5C3vvqhIpjMEvizeYgGs9C/DfBFxvQ6C+50FArrnVakzVyjRT2c0AioX8mY
         8si8fjGh3C/OA6csHt7ILvEnKoLq7n8uCLkRZGAElqPW50F0U3MKUAlOLtt7HuJh+bKI
         gaIBMMEDk7L1Uma5nsIxGSehBnM57awxFXWr54JZNfOzPEv/lwH51sBq2ktM4Ndz55jj
         SGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681245674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4gMQcqO2DbgSXcTyVncrRLFbOppq69F+PFdQeqpv4E=;
        b=P8cosUWBRsnWzM147JxPQRcmc58Bdq+snHBvIDqrVWMUqR/MjwUZvzgQDxrRPpNR5V
         5mfpNv0iFveB1/KaUD4Gbr6BvsoQ6YdAk3yqmXbpZAOXTOOP/wJoCWG1do+Vf2EMfXF2
         ZIhYfIDwXAfYy26Plsk/eJNtHzWmB7HKqbNfw5aSXumRqFBTP+oxf2hqhU6aeZkYgNv4
         kQi6z+7HvcskeikGwIj2dAJvGc/y7huU7CTA3NCaoLse62vvSrDHRrbwNHb7fK6m5X3K
         aUQAucrNbHhoEQ3TsgCmpiVQh9uAWiiez+PIM5CEuIte38WbmwvThmE9TNSuu8t40cQg
         YScQ==
X-Gm-Message-State: AAQBX9cFa2MaUYQkdXGgDtr11Q3FeBXi+Q4KIKBAX3ggEvTcoI5EdFm8
        14vfS549Ie25vUmRGUkgMeC0Qqu4rs9Ay2nH3EH8VdFwG37sNVuI
X-Google-Smtp-Source: AKy350ZnMmJmxCRdJmD9QkQB8GoIRw3REnexxa8YIf/S37T/ObnWxtxNY61I4cuetxh9BWXCMLDcdyzc+gl8yflQ50A=
X-Received: by 2002:a05:6102:50a5:b0:42c:6f4b:dfec with SMTP id
 bl37-20020a05610250a500b0042c6f4bdfecmr525914vsb.0.1681245673990; Tue, 11 Apr
 2023 13:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230411090611.627225-1-vincent.guittot@linaro.org>
In-Reply-To: <20230411090611.627225-1-vincent.guittot@linaro.org>
From:   Tingjia Cao <tjcao980311@gmail.com>
Date:   Tue, 11 Apr 2023 16:41:02 -0400
Message-ID: <CABcWv9_zhQT4ppdVVcx-TQQtqi8W1rx713CYQ_oEXjS0=WwZJg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix imbalance overflow
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

Thanks for the reply. The patch also fixes the issue on my side!

Cheers,
Tingjia


On Tue, Apr 11, 2023 at 5:06=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> When local group is fully busy but its average load is above system load,
> computing the imbalance will overflow and local group is not the best
> target for pulling this load.
>
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reported-by: Tingjia Cao <tjcao980311@gmail.com>
> Link: https://lore.kernel.org/lkml/CABcWv9_DAhVBOq2=3DW=3D2ypKE9dKM5s2Dvo=
V8-U0+GDwwuKZ89jQ@mail.gmail.com/T/
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Hi Tingjia,
>
> Thanks for the detailed bug report. I have been able to reproduce the pro=
blem and this
> patch fixes it on my setup. Could you try it ?
>
> Thanks,
> Vincent
>
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f5da01a6b35a..184b0dbb2a69 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10209,6 +10209,16 @@ static inline void calculate_imbalance(struct lb=
_env *env, struct sd_lb_stats *s
>
>                 sds->avg_load =3D (sds->total_load * SCHED_CAPACITY_SCALE=
) /
>                                 sds->total_capacity;
> +
> +               /*
> +                * If the local group is more loaded than the average sys=
tem
> +                * load, don't try to pull any tasks.
> +                */
> +               if (local->avg_load >=3D sds->avg_load) {
> +                       env->imbalance =3D 0;
> +                       return;
> +               }
> +
>         }
>
>         /*
> --
> 2.34.1
>
