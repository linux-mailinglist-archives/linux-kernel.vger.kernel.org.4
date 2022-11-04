Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6579619EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDRg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKDRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4141999
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667583341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMGu1CgJT925wXBUUlWYcc+KXwwV37zFFO6DOpLiCh8=;
        b=CKQWDcd1Ik5AXHOVdFdgJDzAlF0B5uVEXZqOXHQr2irWQDOOP5b/mr7zS3lmmrlr9WswXd
        khnQGPCZa58XqbcShaKg0hlCKmWacO9lesITILtpjGf+Kx/z/P8aghI/z8sI1yxrUChwZQ
        wFADWUQmzsg+9yeJ4odkIB5/VkD49sk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-Z3M3cedfNAydVBwCIe4ByA-1; Fri, 04 Nov 2022 13:35:40 -0400
X-MC-Unique: Z3M3cedfNAydVBwCIe4ByA-1
Received: by mail-wr1-f69.google.com with SMTP id g4-20020adfbc84000000b0022fc417f87cso1462097wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMGu1CgJT925wXBUUlWYcc+KXwwV37zFFO6DOpLiCh8=;
        b=ZE0aGE0vYn/55tdmKalLDy+OUjzM8FqakWyC8i3czlGsSgM/lLFwpWNz6s06xBHGUM
         bDwdXIYgVBK90eJbB+9kZTqkpBeDTcaUb9+mw0X378OX2Af21+SY71QnXhb4H9wzFa+V
         WpoPQmssMRqSZezttY7mmMq6zkXeVjOVI+DZb8wX4KvRCyfJdXfnrCY938owp9Oh5QXa
         UxeyVITsmaXOvvNKbnuPcvxkGcx7gXJ2fXxT8gxHSVBPNR84yfGrnJsgb2iOrjO0ymhV
         on+SxkT/Bixqx2+cod09hMrwfSaAlqr4qIOeyglIoGrefLpW2kEUT5njIeEuHW/6gX93
         D1Wg==
X-Gm-Message-State: ACrzQf33Z+G5mKgvka8ujzNmrwCARWMXoA1jenbSXOAMLc6FXTerfBh+
        Da7EWP9O0qeqEqD0felZ3mZun9QniECjtEzXaGSr73neVz5GfEsVM/qX1FcYHTnzV4zmFZHjRX3
        wi4MdYTQrvvZxKHeyr89JYtE3
X-Received: by 2002:adf:e40e:0:b0:236:b896:8f55 with SMTP id g14-20020adfe40e000000b00236b8968f55mr21747934wrm.281.1667583339206;
        Fri, 04 Nov 2022 10:35:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Dp3fcSOBiln0S0PW+TVg/5Q/RpH55U6aLTJtOadgGLfeqVuVS14ngn+cte1dd5bYsq3h43g==
X-Received: by 2002:adf:e40e:0:b0:236:b896:8f55 with SMTP id g14-20020adfe40e000000b00236b8968f55mr21747925wrm.281.1667583339027;
        Fri, 04 Nov 2022 10:35:39 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b00228daaa84aesm3963886wrs.25.2022.11.04.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:35:38 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2 9/9] sched/fair: Consider capacity inversion in
 util_fits_cpu()
In-Reply-To: <20220804143609.515789-10-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-10-qais.yousef@arm.com>
Date:   Fri, 04 Nov 2022 17:35:36 +0000
Message-ID: <xhsmhwn8avd07.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/22 15:36, Qais Yousef wrote:
> We do consider thermal pressure in util_fits_cpu() for uclamp_min only.
> With the exception of the biggest cores which by definition are the max
> performance point of the system and all tasks by definition should fit.
>
> Even under thermal pressure, the capacity of the biggest CPU is the
> highest in the system and should still fit every task. Except when it
> reaches capacity inversion point, then this is no longer true.
>
> We can handle this by using the inverted capacity as capacity_orig in
> util_fits_cpu(). Which not only addresses the problem above, but also
> ensure uclamp_max now considers the inverted capacity. Force fitting
> a task when a CPU is in this adverse state will contribute to making the
> thermal throttling last longer.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb32dc9a057f..77ae343e32a3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4293,12 +4293,16 @@ static inline int util_fits_cpu(unsigned long util,
>        * For uclamp_max, we can tolerate a drop in performance level as the
>        * goal is to cap the task. So it's okay if it's getting less.
>        *
> -	 * In case of capacity inversion, which is not handled yet, we should
> -	 * honour the inverted capacity for both uclamp_min and uclamp_max all
> -	 * the time.
> +	 * In case of capacity inversion we should honour the inverted capacity
> +	 * for both uclamp_min and uclamp_max all the time.
>        */
> -	capacity_orig = capacity_orig_of(cpu);
> -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> +	capacity_orig = cpu_in_capacity_inversion(cpu);
> +	if (capacity_orig) {
> +		capacity_orig_thermal = capacity_orig;
> +	} else {
> +		capacity_orig = capacity_orig_of(cpu);
> +		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> +	}
>

IIUC the rq->cpu_capacity_inverted computation in update_cpu_capacity() can be
summarised as:

- If there is a PD with equal cap_orig, but higher effective (orig - thermal)
  capacity
  OR
  there is a PD with pd_cap_orig > cpu_effective_cap:
  rq->cpu_capacity_inverted = capacity_orig - thermal_load_avg(rq)

- Else:
  rq->cpu_capacity_inverted = 0

Then, the code above uses either rq->cpu_capacity_inverted if it is
non-zero, otherwise:

  capacity_orig - arch_scale_thermal_pressure(cpu);

Why use average thermal pressure in one case, and use instantaneous
thermal pressure in the other?

Can't we get rid of rq->cpu_capacity_inverted and replace this whole thing
with an unconditional

  capacity_orig_thermal = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));

?

>       /*
>        * We want to force a task to fit a cpu as implied by uclamp_max.
> --
> 2.25.1

