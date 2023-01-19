Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC6673A18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjASN0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 08:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjASN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:26:47 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3D5B5A3;
        Thu, 19 Jan 2023 05:26:44 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id hw16so5588970ejc.10;
        Thu, 19 Jan 2023 05:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyp5De4cHcBXvdULOul9tCa4NQvA2Rq/+KqdIOnZ/0M=;
        b=Mydn/C9NQLc+IB7ugKREUgF65SfUsDS4nB9EDZfJbQ2HDc553vhj63Fs0g98Cms18n
         5rT9f31CJXeBozuYaMP0n81Pr4nUAn8V34UG/rCKuPBifzdMkbNw8OXl4pygN/ZwX80J
         5VSmUyv1SbmoAEQtO2QL/nsujQzq2EiKWBlyNCeMKzyqovrh0fivdXHGWcfis3Q7rpTr
         6FR32syQmgOt74nYDzmhvaCHsMbzGOg4qDHN+iK+ppoRehvUfOtiAubozIVssieC0jx8
         pFb1nsosoS0cgnkbptmtcVw0f7UlY3RuJo5W+S6suj2w6Dlvpw70/G+ZqkrzBVOgzttK
         yV3A==
X-Gm-Message-State: AFqh2koWb5VENSJv3pjYc1uVaCHqtyscTZK02zoBtEU9l/O7CBxpxx+s
        24EB+8ubEw8yxyRy97etdLRbnTId7VTF69pw3sY=
X-Google-Smtp-Source: AMrXdXv0ZL29O/r6eyFCjpDmlAnuazdLpedDJJpIuEiGZZeHmuab+0AYv9GsT3hZeVScA9/Sj0TKLphAY8DuB/uKLxQ=
X-Received: by 2002:a17:906:d971:b0:84d:381c:bdaa with SMTP id
 rp17-20020a170906d97100b0084d381cbdaamr1180828ejb.79.1674134803323; Thu, 19
 Jan 2023 05:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119070205.90047-1-noltari@gmail.com>
In-Reply-To: <20230119070205.90047-1-noltari@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:26:32 +0100
Message-ID: <CAJZ5v0jSbR9VPK1Srht2aDB+zphjjFC_=pb_Y3nc++5v9tr2-w@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc:     jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 8:02 AM Álvaro Fernández Rojas
<noltari@gmail.com> wrote:
>
> This patch adds RaptorLake support to the intel_idle driver.
>
> Since RaptorLake and AlderLake C-state are characteristics the same, we use
> AlderLake C-states tables for RaptorLake as well.
>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Rui, Artem, what do you think?

> ---
>  drivers/idle/intel_idle.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cfeb24d40d37..1a35b98d9bae 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1429,6 +1429,9 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &idle_cpu_adl),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &idle_cpu_adl_l),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &idle_cpu_adl_n),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &idle_cpu_adl),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &idle_cpu_adl_n),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &idle_cpu_adl),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &idle_cpu_spr),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> @@ -1867,6 +1870,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>         case INTEL_FAM6_ALDERLAKE:
>         case INTEL_FAM6_ALDERLAKE_L:
>         case INTEL_FAM6_ALDERLAKE_N:
> +       case INTEL_FAM6_RAPTORLAKE:
> +       case INTEL_FAM6_RAPTORLAKE_P:
> +       case INTEL_FAM6_RAPTORLAKE_S:
>                 adl_idle_state_table_update();
>                 break;
>         }
> --
> 2.34.1
>
