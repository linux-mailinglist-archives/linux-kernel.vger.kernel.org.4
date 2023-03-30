Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930B6D0D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjC3Ry7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3Ryv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:54:51 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF11B776;
        Thu, 30 Mar 2023 10:54:49 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id r11so79754733edd.5;
        Thu, 30 Mar 2023 10:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680198888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su1hRGTWilFn2sStZ7BeNonsYkTlGAp4hSoCgD6Xc1k=;
        b=7Vtq0OUbgC5pNrWq06Ylx0Cno7R5LFVQgc0Iii0e0hNLoLPMy/lll45IY7OOgVqrg/
         DBf1yVQ/Q2XewhfV70m0OEStQE9mQLCJW+YgmZ5sBK/izi63K7ov5QvVZU+fG1kWRjdJ
         /mMjyq/g7E9VettYM2vhV89sjZPAL5YkzHL84a/PZPL3NgsUlrzYL1rD6qd6F912nw6a
         fEQ4LeATCEazW9h3GzQbqYvDuyynQG+t20L357o2gz/Ro9Ee9Tu+73Kiwxr+jLkBG2t8
         mUEJstQmCXaBtK2ozGFGN3tZLHGssx9g33065CcVjRB7O05tYnHVGjV9dBaM8Blo+VlK
         x1kQ==
X-Gm-Message-State: AAQBX9fR/5imWJK6sZ1bcmYhKWMIMgyt7YWIDJDeNmKUNw4iJLd3v079
        p1iXrOMYg+kqTBcdvgJX6CFMTkv82h329aEYMqY=
X-Google-Smtp-Source: AKy350YrxpqnsB+vehYgj8yGQkqqQCS74PeypGkISpyzxm7zBYBMBDx+71AXUOBnqa2IPFCjtwaWi3OxO98CZX8uZuU=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr6005149ejc.2.1680198888396; Thu, 30
 Mar 2023 10:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230316153841.3666-1-rui.zhang@intel.com> <20230316153841.3666-4-rui.zhang@intel.com>
In-Reply-To: <20230316153841.3666-4-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 19:54:37 +0200
Message-ID: <CAJZ5v0iFP1A+yZfjgx-yXfV2c0+o1t9DAYsj-3YzzaqNfP9LVw@mail.gmail.com>
Subject: Re: [PATCH 03/15] powercap/intel_rapl: Support per Interface rapl_defaults
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

On Thu, Mar 16, 2023 at 4:41 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> rapl_defaults is Interface specific.
>
> Although current MSR and MMIO Interface share the same rapl_defaults,
> new Interface like TPMI need its own rapl_defaults callbacks.
>
> Save the rapl_defaults information in the Interface private structure.
>
> No functional change.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 46 ++++++++++++++++++++--------
>  include/linux/intel_rapl.h           |  2 ++
>  2 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 2d2c15eea8eb..56e8af2a1e6f 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -115,6 +115,11 @@ struct rapl_defaults {
>  };
>  static struct rapl_defaults *rapl_defaults;
>
> +static struct rapl_defaults *get_rpd(struct rapl_package *rp)

I would replace "rpd" with "defaults" here and everywhere below in this patch.

> +{
> +       return rp->priv->rpd;
> +}
> +
>  /* Sideband MBI registers */
>  #define IOSF_CPU_POWER_BUDGET_CTL_BYT (0x2)
>  #define IOSF_CPU_POWER_BUDGET_CTL_TNG (0xdf)
> @@ -227,14 +232,15 @@ static int find_nr_power_limit(struct rapl_domain *rd)
>  static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
>  {
>         struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
> +       struct rapl_defaults *rpd = get_rpd(rd->rp);
>
>         if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
>                 return -EACCES;
>
>         cpus_read_lock();
>         rapl_write_data_raw(rd, PL1_ENABLE, mode);
> -       if (rapl_defaults->set_floor_freq)
> -               rapl_defaults->set_floor_freq(rd, mode);
> +       if (rpd->set_floor_freq)
> +               rpd->set_floor_freq(rd, mode);
>         cpus_read_unlock();
>
>         return 0;
> @@ -551,6 +557,7 @@ static void rapl_init_domains(struct rapl_package *rp)
>         enum rapl_domain_type i;
>         enum rapl_domain_reg_id j;
>         struct rapl_domain *rd = rp->domains;
> +       struct rapl_defaults *rpd = get_rpd(rp);
>
>         for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
>                 unsigned int mask = rp->domain_map & (1 << i);
> @@ -592,14 +599,14 @@ static void rapl_init_domains(struct rapl_package *rp)
>                 switch (i) {
>                 case RAPL_DOMAIN_DRAM:
>                         rd->domain_energy_unit =
> -                           rapl_defaults->dram_domain_energy_unit;
> +                           rpd->dram_domain_energy_unit;
>                         if (rd->domain_energy_unit)
>                                 pr_info("DRAM domain energy unit %dpj\n",
>                                         rd->domain_energy_unit);
>                         break;
>                 case RAPL_DOMAIN_PLATFORM:
>                         rd->domain_energy_unit =
> -                           rapl_defaults->psys_domain_energy_unit;
> +                           rpd->psys_domain_energy_unit;
>                         if (rd->domain_energy_unit)
>                                 pr_info("Platform domain energy unit %dpj\n",
>                                         rd->domain_energy_unit);
> @@ -616,6 +623,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>  {
>         u64 units = 1;
>         struct rapl_package *rp = rd->rp;
> +       struct rapl_defaults *rpd = get_rpd(rp);
>         u64 scale = 1;
>
>         switch (type) {
> @@ -631,7 +639,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>                         units = rp->energy_unit;
>                 break;
>         case TIME_UNIT:
> -               return rapl_defaults->compute_time_window(rp, value, to_raw);
> +               return rpd->compute_time_window(rp, value, to_raw);
>         case ARBITRARY_UNIT:
>         default:
>                 return value;
> @@ -702,10 +710,18 @@ static struct rapl_primitive_info rpi[] = {
>         {NULL, 0, 0, 0},
>  };
>
> +static int rapl_config(struct rapl_package *rp)
> +{
> +       rp->priv->rpd = (void *)rapl_defaults;
> +       return 0;
> +}
> +
>  static enum rapl_primitives
>  prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
>  {
> -       if (!rapl_defaults->spr_psys_bits)
> +       struct rapl_defaults *rpd = get_rpd(rd->rp);
> +
> +       if (!rpd->spr_psys_bits)
>                 return prim;
>
>         if (rd->id != RAPL_DOMAIN_PLATFORM)
> @@ -960,16 +976,17 @@ static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
>  static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
>  {
>         static u32 power_ctrl_orig_val;
> +       struct rapl_defaults *rpd = get_rpd(rd->rp);
>         u32 mdata;
>
> -       if (!rapl_defaults->floor_freq_reg_addr) {
> +       if (!rpd->floor_freq_reg_addr) {
>                 pr_err("Invalid floor frequency config register\n");
>                 return;
>         }
>
>         if (!power_ctrl_orig_val)
>                 iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
> -                             rapl_defaults->floor_freq_reg_addr,
> +                             rpd->floor_freq_reg_addr,
>                               &power_ctrl_orig_val);
>         mdata = power_ctrl_orig_val;
>         if (enable) {
> @@ -977,7 +994,7 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
>                 mdata |= 1 << 8;
>         }
>         iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
> -                      rapl_defaults->floor_freq_reg_addr, mdata);
> +                      rpd->floor_freq_reg_addr, mdata);
>  }
>
>  static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
> @@ -1385,11 +1402,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
>  {
>         int id = topology_logical_die_id(cpu);
>         struct rapl_package *rp;
> +       struct rapl_defaults *rpd;
>         int ret;
>
> -       if (!rapl_defaults)
> -               return ERR_PTR(-ENODEV);
> -
>         rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
>         if (!rp)
>                 return ERR_PTR(-ENOMEM);
> @@ -1399,6 +1414,10 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
>         rp->lead_cpu = cpu;
>         rp->priv = priv;
>
> +       ret = rapl_config(rp);
> +       if (ret)
> +               goto err_free_package;
> +
>         if (topology_max_die_per_package() > 1)
>                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
>                          "package-%d-die-%d",
> @@ -1407,8 +1426,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
>                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
>                          topology_physical_package_id(cpu));
>
> +       rpd = get_rpd(rp);
>         /* check if the package contains valid domains */
> -       if (rapl_detect_domains(rp, cpu) || rapl_defaults->check_unit(rp, cpu)) {
> +       if (rapl_detect_domains(rp, cpu) || rpd->check_unit(rp, cpu)) {
>                 ret = -ENODEV;
>                 goto err_free_package;
>         }
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 828557645770..76d480733b0f 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -121,6 +121,7 @@ struct reg_action {
>   *                             registers.
>   * @write_raw:                 Callback for writing RAPL interface specific
>   *                             registers.
> + * @rpd:                       internal pointer to interface default settings
>   */
>  struct rapl_if_priv {
>         struct powercap_control_type *control_type;
> @@ -130,6 +131,7 @@ struct rapl_if_priv {
>         int limits[RAPL_DOMAIN_MAX];
>         int (*read_raw)(int cpu, struct reg_action *ra);
>         int (*write_raw)(int cpu, struct reg_action *ra);
> +       void *rpd;
>  };
>
>  /* maximum rapl package domain name: package-%d-die-%d */
> --
> 2.25.1
>
