Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEE6F71FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjEDSbt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 May 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEDSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:31:47 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1018872A7;
        Thu,  4 May 2023 11:31:46 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5084977a399so208254a12.1;
        Thu, 04 May 2023 11:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225104; x=1685817104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvUYPAuMuQ15G2R3MFy0ieUYgbDkvCHG93wbq2EogD8=;
        b=HhKBFGjdcO2TCwHkzncM/YGdvoT1PHu6G/Xay1BEAHiZWY0jdxV4V0wsMj7+Gcebg0
         u1jCH2ABirIZYxOX6LLc3kEcwGlAQx9QCHw7QDmgyUVcud5UUYKO/xGPoX5T8IcHrKRc
         ost77qNTtUl4sDe+xsUbo8a6VkCu3VW4QoDA016DiobRy9sdf79IJSnHq81GXVJ4svCc
         1SdZCHkLUt95Fpsa3Fycv3NtbOa+HHcXUaPbqIhRnsj4eWFQzaeJpy9XxxeV7f7dDKS1
         8Bqx1GRfqBQudpFu2vJi/JKQlIXA+dDT1w1SA39wth5UQUj0vdnaQItzSvJShZTrScxp
         asZQ==
X-Gm-Message-State: AC+VfDwptEcGyUaY4iHgEW7aP94LoVCllD49lk/CaW72TJcH1+YRQWA6
        VoVpdi8HC09XTY4BUfaijN/Q8KG8ALmTm59r3AXvdMMh
X-Google-Smtp-Source: ACHHUZ4nkgRuxPWfnJkqVKFQ6vc53D4Q3hdrVuJO5u3tpwrJlpmIfflP7u8H4tkKevWaYITkurRrilVZhIwq8gD47fU=
X-Received: by 2002:a17:906:7285:b0:965:9db5:3824 with SMTP id
 b5-20020a170906728500b009659db53824mr3376570ejl.6.1683225104278; Thu, 04 May
 2023 11:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230503233850.1918041-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230503233850.1918041-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 May 2023 20:31:33 +0200
Message-ID: <CAJZ5v0hKTih9jYD_E7HaryOEZ9Enjq9tHh3YgTyZtLm=nt_92A@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Fix NULL pointer access issue
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Risto A . Paju" <teknohog@iki.fi>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 1:38 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> If the cur_state for the powerclamp cooling device is set to the default
> minimum state of 0, without setting first to cur_state > 0, this results
> in NULL pointer access.
>
> This NULL pointer access happens in the powercap core idle-inject function
> idle_inject_set_duration() as there is no NULL check for idle_inject_device
> pointer. This pointer must be allocated by calling idle_inject_register()
> or idle_inject_register_full().
>
> In the function powerclamp_set_cur_state(), idle_inject_device pointer is
> allocated only when the cur_state > 0. But setting 0 without changing to
> any other state, idle_inject_set_duration() will be called with a NULL
> idle_inject_device pointer.
>
> To address this just return from powerclamp_set_cur_state(), if the
> current cooling device state is same as the last one. Since the powerup
> default cooling device state is 0, changing the state to 0 again here
> will return without calling idle_inject_set_duration().
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 8526eb7fc75a ("thermal: intel: powerclamp: Use powercap idle-inject feature")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217386
> Tested-by: Risto A. Paju <teknohog@iki.fi>
> Cc: stable@kernel.org
> ---
> This issue is can be reproduced from 6.3-rc1 kernel.
>
>  drivers/thermal/intel/intel_powerclamp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 91fc7e239497..36243a3972fd 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -703,6 +703,10 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
>
>         new_target_ratio = clamp(new_target_ratio, 0UL,
>                                 (unsigned long) (max_idle - 1));
> +
> +       if (powerclamp_data.target_ratio == new_target_ratio)
> +               goto exit_set;
> +
>         if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
>                 pr_info("Start idle injection to reduce power\n");
>                 powerclamp_data.target_ratio = new_target_ratio;
> --

Applied as 6.4-rc material, thanks!
