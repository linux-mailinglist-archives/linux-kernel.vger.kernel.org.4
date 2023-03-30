Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531AC6D0D41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjC3R5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjC3R52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:57:28 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ADBC66B;
        Thu, 30 Mar 2023 10:57:10 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id ek18so79799045edb.6;
        Thu, 30 Mar 2023 10:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680199026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQe/lpVf0SOo2zBRyr8VScyK+dIk9xfYGkz+0p9goM8=;
        b=cxX73WycIxQMSpXqgGJxG3ScAqJxj7zhOT/CQHha/PON9MTLGCg1sPkIaDUJv+/jO8
         JAKPOYijjMQZ5hPWc67/0futVVYtOo7GJGXYCrO1wfPohNm/BzYDfrwzRSXNV8obbbzB
         xcs6V0fcKkt4BeYh5flp28nHK1sNpWDp9rQL65F0JBM+o2ITR2iUCWwl0qH6lGro5WZB
         oBJ9Dq+dkxQ/1tr4BMdbEnbzxhzwnj0g7PmKKEASuw4tPTwMJiePS36Bujl3HM47Piza
         kU5BMoFydH7W3Woi72hZMdSt90hCsutmKy9Qs73JtE+SBDJxBzd0YBm/kLfeZydvKK8l
         wm/A==
X-Gm-Message-State: AAQBX9ehdJ1VP9m9Q8Dasl9X/efg0zMeXYpLNFUOQny/yy0SpwTTb9O0
        iDMCW7XtbUaHCnsAGBnXuZsY0sSqYaoGywMXvTcYeTHW
X-Google-Smtp-Source: AKy350brKTK+aEoq9AE1uWffAYpGHOtd8+B5ccXTsrk6tsXpcWHXR+1j6H68beFwrCf6SX36byy1+hb/35L/7Ntlne8=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr13488846ejc.2.1680199026468; Thu, 30
 Mar 2023 10:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230316153841.3666-1-rui.zhang@intel.com> <20230316153841.3666-5-rui.zhang@intel.com>
In-Reply-To: <20230316153841.3666-5-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 19:56:55 +0200
Message-ID: <CAJZ5v0hG9mC0DAWeGfgcrripi8dpANSwBgBQxjDSzzLGQcC0iQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] powercap/intel_rapl: Support per Interface
 primitive information
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

On Thu, Mar 16, 2023 at 4:42 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> RAPL primitive information is Interface specific.
>
> Although current MSR and MMIO Interface share the same RAPL primitives,
> new Interface like TPMI has its own RAPL primitive information.
>
> Save the primitive information in the Interface private structure.
>
> Plus, using variant name "rp" for struct rapl_primitive_info is
> confusing because "rp" is also used for struct rapl_package.
> Use "rpi" as the variant name for struct rapl_primitive_info, and rename
> the previous rpi[] array to avoid conflict.
>
> No functional change.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++++++----------
>  include/linux/intel_rapl.h           |  2 ++
>  2 files changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 56e8af2a1e6f..898238285188 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -654,7 +654,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>  }
>
>  /* in the order of enum rapl_primitives */
> -static struct rapl_primitive_info rpi[] = {
> +static struct rapl_primitive_info rpis_default[] = {

What does the 's' in the name stand for?

>         /* name, mask, shift, msr index, unit divisor */
>         PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
>                             RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
> @@ -710,9 +710,20 @@ static struct rapl_primitive_info rpi[] = {
>         {NULL, 0, 0, 0},
>  };
>
> +static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
> +{
> +       struct rapl_primitive_info *rpi = rp->priv->rpi;
> +
> +       if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
> +               return NULL;
> +
> +       return &rpi[prim];
> +}
> +
>  static int rapl_config(struct rapl_package *rp)
>  {
>         rp->priv->rpd = (void *)rapl_defaults;
> +       rp->priv->rpi = (void *)rpis_default;
>         return 0;
>  }
>
> @@ -763,14 +774,14 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>  {
>         u64 value;
>         enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
> -       struct rapl_primitive_info *rp = &rpi[prim_fixed];
> +       struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
>         struct reg_action ra;
>         int cpu;
>
> -       if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
> +       if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
>                 return -EINVAL;
>
> -       ra.reg = rd->regs[rp->id];
> +       ra.reg = rd->regs[rpi->id];
>         if (!ra.reg)
>                 return -EINVAL;
>
> @@ -778,26 +789,26 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>
>         /* domain with 2 limits has different bit */
>         if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
> -               rp->mask = POWER_HIGH_LOCK;
> -               rp->shift = 63;
> +               rpi->mask = POWER_HIGH_LOCK;
> +               rpi->shift = 63;
>         }
>         /* non-hardware data are collected by the polling thread */
> -       if (rp->flag & RAPL_PRIMITIVE_DERIVED) {
> +       if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
>                 *data = rd->rdd.primitives[prim];
>                 return 0;
>         }
>
> -       ra.mask = rp->mask;
> +       ra.mask = rpi->mask;
>
>         if (rd->rp->priv->read_raw(cpu, &ra)) {
>                 pr_debug("failed to read reg 0x%llx on cpu %d\n", ra.reg, cpu);
>                 return -EIO;
>         }
>
> -       value = ra.value >> rp->shift;
> +       value = ra.value >> rpi->shift;
>
>         if (xlate)
> -               *data = rapl_unit_xlate(rd, rp->unit, value, 0);
> +               *data = rapl_unit_xlate(rd, rpi->unit, value, 0);
>         else
>                 *data = value;
>
> @@ -810,21 +821,24 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>                                unsigned long long value)
>  {
>         enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
> -       struct rapl_primitive_info *rp = &rpi[prim_fixed];
> +       struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
>         int cpu;
>         u64 bits;
>         struct reg_action ra;
>         int ret;
>
> +       if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
> +               return -EINVAL;
> +
>         cpu = rd->rp->lead_cpu;
> -       bits = rapl_unit_xlate(rd, rp->unit, value, 1);
> -       bits <<= rp->shift;
> -       bits &= rp->mask;
> +       bits = rapl_unit_xlate(rd, rpi->unit, value, 1);
> +       bits <<= rpi->shift;
> +       bits &= rpi->mask;
>
>         memset(&ra, 0, sizeof(ra));
>
> -       ra.reg = rd->regs[rp->id];
> -       ra.mask = rp->mask;
> +       ra.reg = rd->regs[rpi->id];
> +       ra.mask = rpi->mask;
>         ra.value = bits;
>
>         ret = rd->rp->priv->write_raw(cpu, &ra);
> @@ -1176,8 +1190,10 @@ static void rapl_update_domain_data(struct rapl_package *rp)
>                          rp->domains[dmn].name);
>                 /* exclude non-raw primitives */
>                 for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
> +                       struct rapl_primitive_info *rpi = get_rpi(rp, prim);
> +
>                         if (!rapl_read_data_raw(&rp->domains[dmn], prim,
> -                                               rpi[prim].unit, &val))
> +                                               rpi->unit, &val))
>                                 rp->domains[dmn].rdd.primitives[prim] = val;
>                 }
>         }
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 76d480733b0f..b935484dde3a 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -122,6 +122,7 @@ struct reg_action {
>   * @write_raw:                 Callback for writing RAPL interface specific
>   *                             registers.
>   * @rpd:                       internal pointer to interface default settings
> + * @rpi:                       internal pointer to interface primitive info
>   */
>  struct rapl_if_priv {
>         struct powercap_control_type *control_type;
> @@ -132,6 +133,7 @@ struct rapl_if_priv {
>         int (*read_raw)(int cpu, struct reg_action *ra);
>         int (*write_raw)(int cpu, struct reg_action *ra);
>         void *rpd;
> +       void *rpi;
>  };
>
>  /* maximum rapl package domain name: package-%d-die-%d */
> --
> 2.25.1
>
