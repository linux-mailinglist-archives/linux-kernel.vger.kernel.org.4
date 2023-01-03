Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75265C4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjACRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbjACRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:11:32 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3613F72;
        Tue,  3 Jan 2023 09:08:58 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id m18so75358057eji.5;
        Tue, 03 Jan 2023 09:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCeNXkeIIS+L0VcS+kfcmiGxNLxFEc/bLfFVeu53wUM=;
        b=RDGsjEHh96V3h//7ftm+DwvQ/ukeAjtS3IE7XkzID3GEaG3iD0suUUNuFHEmBxNIDn
         L/XFXmc95eR72EVmcVqDdY2dkFUD+mM/Y/u9gI+dT4Ullg0UkCHK5/imAmT0mX72E9pK
         2Hf+iMxqkC8RQs5pzX3Bj/vlOf+DjZ4e+bS9jFGBaAH+ppnS7/AKFEqWMNc4diR+SMju
         FbKilFMYpLWKRkMHH6lNCjZAeypZEoEQa0VxDJX9z/EkG3yvteyyaDbLG1Ncv18ypoGm
         6UXiC165PdY0CLi1HGtHsJgPzRBWHnRirJaAYv0pOGobQvGKS9tqAyJvJDkRYNDFYLfP
         4S7Q==
X-Gm-Message-State: AFqh2kpqQuDBUxCuakuLXcJDlnw+E3cB+xVMjnQbdceLWswmYR3adxU7
        ssQ3zltn/MMhf3fMVhScjzkCLXB7qFKehN6J/Og=
X-Google-Smtp-Source: AMrXdXsZBdq84Sdbd0uzp6o/nvS3DwY9gT8TiNiiT39nwlTsgyKTi/OAEjjzeT1He53v2xn5OcTC+7XUC/ssdJzH0b4=
X-Received: by 2002:a17:907:7665:b0:843:770e:7787 with SMTP id
 kk5-20020a170907766500b00843770e7787mr3611075ejc.79.1672765736732; Tue, 03
 Jan 2023 09:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20221130153204.2085591-1-kajetan.puchalski@arm.com> <Y7Q6GnjKKhCVp1Zf@e126311.manchester.arm.com>
In-Reply-To: <Y7Q6GnjKKhCVp1Zf@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Jan 2023 18:08:45 +0100
Message-ID: <CAJZ5v0jUPDM9_VYOz2V2NEjT0zke-vbP5Du8bj+PaaoXPq5WxA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 3:22 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> On Wed, Nov 30, 2022 at 03:32:02PM +0000, Kajetan Puchalski wrote:
>
> Hi Rafael,
>
> As it's been a while since the last email I wanted to bump this thread
> and ask what you think about the last changes.

Right, I'll send my comments on the last version of the patch separately.

> Additionally, I got some emails from the kernel test robot and noticed
> that sched_cpu_util is contingent on CONFIG_SMP so in the current form
> there's build errors on !SMP machines.
>
> The following change should fix the problem, do you think it's all right to add?
>
> @@ -207,10 +207,17 @@ static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>   * @dev: Target CPU
>   * @cpu_data: Governor CPU data for the target CPU
>   */
> +#ifdef CONFIG_SMP
>  static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
>  {
>         cpu_data->utilized = sched_cpu_util(dev->cpu) > cpu_data->util_threshold;
>  }
> +#else
> +static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
> +{
> +       cpu_data->utilized = false;
> +}
> +#endif
>

IMV it would be better to use teo_cpu_is_utilized() that would be
called to update cpu_data->utilized this way

cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data->util_threshold);

and define it as an empty stab in the !SMP case.
