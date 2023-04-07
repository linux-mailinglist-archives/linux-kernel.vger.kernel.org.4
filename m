Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CF6DAC76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDGMBb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDGMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:01:27 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07983CD;
        Fri,  7 Apr 2023 05:01:25 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id sg7so7910830ejc.9;
        Fri, 07 Apr 2023 05:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSq+JRKGUnC+XKkeQyBG4G2ng/kjlZpLD0OGhNAvXrQ=;
        b=KZFMea+jM1vXStSRg0rs6bRqEnxnzP9axBsxM8JugxC9zWrhZcJpBzTG6+91HJLGZf
         vBdSWVlnvm8M9cagga+wnHJHpBiKj//woz/8Tow9kHdCwgm5KbxpbOq+rAkkPAXh5A6P
         Q9DG0LupmTR6xLHWSnVCpgUKfO3VexBDPV/AMHqBU/BgMdubfrcZTfkLy1GhL8dmaFJp
         PCvbhFayIeoeSoQ5aHAyTToH5eLm1LP2y7fjP/C5Rsi+4tU3bboZnhhZugWJx9hjEnqz
         gGzCocxZ/1/Hkobc2M8wUibybyVlpnvXt8wi3oIHSVJyUlo+kzT/5bpY9UwjDgntXLlT
         LyLg==
X-Gm-Message-State: AAQBX9cdPCKJ6Cuq+KcdJmb/Po8zDq6uINF3+5BUwDqKUHcU4uW3vKcF
        413hAsVHvbbqSIoZcShnsjgFdPeJCcct97A08NCWovsCTUs=
X-Google-Smtp-Source: AKy350YqpGgACbqjt1YhQZDXjfyiHa2YFXvHZ/FXU2+6gedx1Ipj3vIjJNkGFMAuoyCBdXR9ES149iTccMgm3ZmUoxg=
X-Received: by 2002:a17:907:20b4:b0:947:c623:2c84 with SMTP id
 pw20-20020a17090720b400b00947c6232c84mr1094074ejb.2.1680868884220; Fri, 07
 Apr 2023 05:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230316153841.3666-1-rui.zhang@intel.com> <20230316153841.3666-11-rui.zhang@intel.com>
In-Reply-To: <20230316153841.3666-11-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Apr 2023 14:01:13 +0200
Message-ID: <CAJZ5v0gaJzhnF4Kpi+b1iP=Xb5yCeLQsD4idT8T1DKLn7DCU=w@mail.gmail.com>
Subject: Re: [PATCH 10/15] powercap/intel_rapl: Introduce per Power Limit lock
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 4:43 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> With RAPL MSR/MMIO Interface, each RAPL domain has one Power Limit
> register. Each Power Limit register has one or two Power Limits and one
> lock bit.

Which tells the OS that the power limit register cannot be used IIUC.

So the subject should be something like "Add support for lock bit per
Power Limit" and the changelog should explain the role of the lock
bits.

Otherwise it is easily confused with more traditional meaning of "locking".

> The number of Power Limits the lock bit applies to depends on
> the number of Power Limits supported by the Power Limit register.
>
> With RAPL TPMI Interface, each RAPL domain supports multiple Power
> Limits. And each Power Limit has a register with a lock bit.
>
> To handle this, introduce per Power Limit lock support. For existing
> RAPL MSR/MMIO Interfaces, the lock bit in the Power Limit register
> applies to all the Power Limits controlled by this register.
>
> Remove the per domain DOMAIN_STATE_BIOS_LOCKED flag at the same time
> because it can be replaced by the per Power Limit lock.
>
> No functional change intended.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 40 ++++++++++++++--------------
>  include/linux/intel_rapl.h           |  2 ++
>  2 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 3e9141dedc1d..636e05aa711b 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -94,7 +94,6 @@ enum unit_type {
>
>  #define        DOMAIN_STATE_INACTIVE           BIT(0)
>  #define        DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
> -#define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
>
>  static const char *pl_names[NR_POWER_LIMITS] = {
>         [POWER_LIMIT1] = "long_term",
> @@ -108,6 +107,7 @@ enum pl_prims {
>         PL_LIMIT,
>         PL_TIME_WINDOW,
>         PL_MAX_POWER,
> +       PL_LOCK,
>  };
>
>  static bool is_pl_valid(struct rapl_domain *rd, int pl)
> @@ -117,7 +117,7 @@ static bool is_pl_valid(struct rapl_domain *rd, int pl)
>         return rd->rpl[pl].name ? true : false;
>  }
>
> -static int get_pl_prim(int pl, enum pl_prims prim)
> +static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
>  {
>         switch (pl) {
>         case POWER_LIMIT1:
> @@ -131,6 +131,9 @@ static int get_pl_prim(int pl, enum pl_prims prim)
>                         return TIME_WINDOW1;
>                 if (prim == PL_MAX_POWER)
>                         return THERMAL_SPEC_POWER;
> +               if (prim == PL_LOCK)
> +                       return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
> +                              FW_HIGH_LOCK : FW_LOCK;

IMO it would be cleaner to write this as

if (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))
        return FW_HIGH_LOCK;

return FW_LOCK;

And because it is duplicated verbatim below, it would be better to add
a helper function doing this and add a comment explaining what is
going on to that function.

>                 return -EINVAL;
>         case POWER_LIMIT2:
>                 if (prim == PL_ENABLE)
> @@ -143,6 +146,9 @@ static int get_pl_prim(int pl, enum pl_prims prim)
>                         return TIME_WINDOW2;
>                 if (prim == PL_MAX_POWER)
>                         return MAX_POWER;
> +               if (prim == PL_LOCK)
> +                       return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
> +                              FW_HIGH_LOCK : FW_LOCK;
>                 return -EINVAL;
>         case POWER_LIMIT4:
>                 if (prim == PL_LIMIT)
> @@ -314,7 +320,7 @@ static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
>         u64 val;
>         int ret;
>
> -       if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
> +       if (rd->rpl[POWER_LIMIT1].locked) {
>                 *mode = false;
>                 return 0;
>         }
> @@ -599,6 +605,8 @@ static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
>                             RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
>         [FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
> +       [FW_HIGH_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
> +                           RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         [PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         [PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
> @@ -719,11 +727,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>
>         cpu = rd->rp->lead_cpu;
>
> -       /* domain with 2 limits has different bit */
> -       if (prim == FW_LOCK && (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))) {
> -               rpi->mask = POWER_HIGH_LOCK;
> -               rpi->shift = 63;
> -       }
>         /* non-hardware data are collected by the polling thread */
>         if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
>                 *data = rd->rdd.primitives[prim];
> @@ -781,7 +784,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
>                               enum pl_prims pl_prim, bool xlate, u64 *data)
>  {
> -       enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
> +       enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
>
>         if (!is_pl_valid(rd, pl))
>                 return -EINVAL;
> @@ -793,12 +796,12 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
>                                enum pl_prims pl_prim,
>                                unsigned long long value)
>  {
> -       enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
> +       enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
>
>         if (!is_pl_valid(rd, pl))
>                 return -EINVAL;
>
> -       if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
> +       if (rd->rpl[pl].locked) {
>                 pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
>                 return -EACCES;
>         }
> @@ -1305,17 +1308,14 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
>         u64 val64;
>         int i;
>
> -       /* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
> -       if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
> -               if (val64) {
> -                       pr_info("RAPL %s domain %s locked by BIOS\n",
> -                               rd->rp->name, rd->name);
> -                       rd->state |= DOMAIN_STATE_BIOS_LOCKED;
> +       for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
> +               if (!rapl_read_pl_data(rd, i, PL_LOCK, false, &val64)) {
> +                       rd->rpl[i].locked = val64;

Using !!val64 here would be cleaner.

Or even explicitly assign true to in in the block following the if ()
statement below.

> +                       if (val64)
> +                               pr_info("%s:%s:%s locked by BIOS\n",
> +                                       rd->rp->name, rd->name, pl_names[i]);
>                 }
> -       }
>
> -       /* check if power limit exists, otherwise domain is monitoring only */
> -       for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
>                 if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
>                         rd->rpl[i].name = NULL;
>         }
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 86cd06bbea0c..325ec00be7a7 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -42,6 +42,7 @@ enum rapl_primitives {
>         POWER_LIMIT4,
>         ENERGY_COUNTER,
>         FW_LOCK,
> +       FW_HIGH_LOCK,
>
>         PL1_ENABLE,             /* power limit 1, aka long term */
>         PL1_CLAMP,              /* allow frequency to go below OS request */
> @@ -81,6 +82,7 @@ struct rapl_power_limit {
>         struct powercap_zone_constraint *constraint;
>         struct rapl_domain *domain;
>         const char *name;
> +       bool locked;
>         u64 last_power_limit;
>  };
>
> --
> 2.25.1
>
