Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE26DAC47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjDGLke convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGLkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:40:32 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840959EA;
        Fri,  7 Apr 2023 04:40:31 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id jw24so7813076ejc.3;
        Fri, 07 Apr 2023 04:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owpG5rT95/qTePvvHQtyxBU+QgYYNRhwqWGHnVy5pPc=;
        b=17Q8T0LO/H5LNBLh2tliB5try5iJiVLC4rG/IxVj48Y7mNz+3fdL73lcvJJVb0r58B
         qhKNRyo6ji1QwI4Z+Cxt5p7/qNdAdvFdXGqViwtyi/M64GdLjONPtLjpk0dRUM9WqiCJ
         0DBuWb3DvrDtCRVaWSa0fFM7US1Yx4emvMuwCics8ePaaiRLr8w2Tmjtr/uzUQ1oL6g/
         EIYM0cdmrMxuE1+ntEbkqvJGei7qTFg8g/B+48C+7B9QX23s5LORaGhAOy8+wtmwcVSv
         8xNOo1+NCQEjn4OYjnce/O6qmrRE3khOdrivMsgcPHCod6zOZC/2oFR6YZrUFQ1KxH0d
         Zy5g==
X-Gm-Message-State: AAQBX9eNVUv6bLfHEm6v8TCu9t0k+732HBhRq5jZqU9/jyaHGf9iYl4d
        ttHn3DwwLFugeZNrfwzR88o0Dd2jAoHXwUnDKDs=
X-Google-Smtp-Source: AKy350ZjGzOw5+xf8+nFnZEZMnPPhgWN7ACdSS23qJ51hDW1ZPT2ScX8LYt0s1+e43xfImS2ZlnqrkVY8N+Bsfd7ffY=
X-Received: by 2002:a17:906:802:b0:8b1:3298:c587 with SMTP id
 e2-20020a170906080200b008b13298c587mr1005588ejd.2.1680867629669; Fri, 07 Apr
 2023 04:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230316153841.3666-1-rui.zhang@intel.com> <20230316153841.3666-8-rui.zhang@intel.com>
In-Reply-To: <20230316153841.3666-8-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Apr 2023 13:40:18 +0200
Message-ID: <CAJZ5v0igEHBKkYU3eDfET1giR6xoNsYVxBycuxD_+QZiGW68nA@mail.gmail.com>
Subject: Re: [PATCH 07/15] powercap/intel_rapl: Change primitive order
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
> Move POWER_LIMIT1/POWER_LIMIT2/POWER_LIMIT4 to the beginning of enum
> rapl_primitives so that they can be reused to represent different Power
> Limits.

The meaning of the above is a bit unclear without reverse engineering
the rest of the series.

> No functional change.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 4 ++--
>  include/linux/intel_rapl.h           | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 9e29e56f4900..3a8940d3bec8 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -631,14 +631,14 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>
>  static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
>         /* name, mask, shift, msr index, unit divisor */
> -       [ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
> -                           RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
>         [POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
>         [POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
>                             RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
>         [POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
>                                 RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
> +       [ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
> +                           RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
>         [FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
>                             RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
>         [PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 1648923f694d..856b739fd194 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -37,10 +37,10 @@ enum rapl_domain_reg_id {
>  struct rapl_domain;
>
>  enum rapl_primitives {
> -       ENERGY_COUNTER,
>         POWER_LIMIT1,
>         POWER_LIMIT2,
>         POWER_LIMIT4,
> +       ENERGY_COUNTER,
>         FW_LOCK,
>
>         PL1_ENABLE,             /* power limit 1, aka long term */
> @@ -75,7 +75,8 @@ struct rapl_domain_data {
>         unsigned long timestamp;
>  };
>
> -#define NR_POWER_LIMITS (3)
> +#define NR_POWER_LIMITS        (POWER_LIMIT4 + 1)
> +
>  struct rapl_power_limit {
>         struct powercap_zone_constraint *constraint;
>         int prim_id;            /* primitive ID used to enable */
> --
> 2.25.1
>
