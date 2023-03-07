Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B66AE00A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjCGNKi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 08:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCGNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:10:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16293BDB1;
        Tue,  7 Mar 2023 05:08:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a25so52183560edb.0;
        Tue, 07 Mar 2023 05:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1f7ClQ084fvZPUTez1OLGUFLY9xreFNlpUR04n4znpo=;
        b=4dO6NSrd2NEMvvBJd9E4Y11kSxUnfRGfPXHx0hcwLrzgQmw7uQGw+Meorfma4UYHCX
         RMCcjAPIMN6oCorlvofnU0XqXVmHiO57xG5lE/QQYlSpAOcDt6gbMgEmvSnaOOEgZRei
         7ojtBiLkjL6MLKLZtaIeeWXHgZ3REWCd9YmUW3ufW5yPQdLH+Vd395B7RkGtxWhoI4yH
         AyU7dcQg1tr3AB2jQbtcBM/g/uxsbyNAehhnof4HporuGfsCFLSXXNsBa1Wdb+8gsZLq
         nEgIaXrcGSbC6I7HWfnRPXU1eUfWjTNFtzFvtGrOStMyDazgeZUGHroyuTTZGSQXuaMF
         ujkg==
X-Gm-Message-State: AO0yUKVLUDjweqW5cVosxzAsf7ZTbd1/AGKkQSW/6aQBUUKH6yt0LozJ
        fW2XoRP02Akkpb6OV6fysu/6ILqXlZoKYVa89rM=
X-Google-Smtp-Source: AK7set/6UtZuMIhw4X4hNyGs7b7oDhwrVNtfIeRgKApGBdGrAm2TuHb/nT8hMSOb99IZT95kml+9lST8vgfhgAZe0Lo=
X-Received: by 2002:a50:9b56:0:b0:4ae:e5db:abfb with SMTP id
 a22-20020a509b56000000b004aee5dbabfbmr7984861edj.3.1678194402638; Tue, 07 Mar
 2023 05:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20230304074107.59083-1-shawn.guo@linaro.org>
In-Reply-To: <20230304074107.59083-1-shawn.guo@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 14:06:31 +0100
Message-ID: <CAJZ5v0h9=vZwENELK+w7HnTTsayaNb1D7wnBgjsXvgopc_t-cA@mail.gmail.com>
Subject: Re: [PATCH RESEND] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 8:41 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> In case that psci_pd_init_topology() fails for some reason,
> psci_pd_remove() will be responsible for deleting provider and removing
> genpd from psci_pd_providers list.  There will be a failure when removing
> the cluster PD, because the cpu (child) PDs haven't been removed.
>
> [    0.050232] CPUidle PSCI: init PM domain cpu0
> [    0.050278] CPUidle PSCI: init PM domain cpu1
> [    0.050329] CPUidle PSCI: init PM domain cpu2
> [    0.050370] CPUidle PSCI: init PM domain cpu3
> [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> [    0.051412] PM: genpd_remove: removed cpu3
> [    0.051449] PM: genpd_remove: removed cpu2
> [    0.051499] PM: genpd_remove: removed cpu1
> [    0.051546] PM: genpd_remove: removed cpu0
>
> Fix the problem by iterating the provider list reversely, so that parent
> PD gets removed after child's PDs like below.
>
> [    0.029052] CPUidle PSCI: init PM domain cpu0
> [    0.029076] CPUidle PSCI: init PM domain cpu1
> [    0.029103] CPUidle PSCI: init PM domain cpu2
> [    0.029124] CPUidle PSCI: init PM domain cpu3
> [    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.029647] PM: genpd_remove: removed cpu0
> [    0.029666] PM: genpd_remove: removed cpu1
> [    0.029690] PM: genpd_remove: removed cpu2
> [    0.029714] PM: genpd_remove: removed cpu3
> [    0.029738] PM: genpd_remove: removed cpu-cluster0
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")

So I guess there should be Cc: stable for 5.10 and later?

> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Hi Rafael,
>
> This is a resend of the patch [1].  Could you help pick it up or let me
> know if there is anything need to be improved, thanks!

Is this regarded as 6.3-rc material, or can it wait for 6.4?
