Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1065D77D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbjADPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbjADPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:46:27 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10926395
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:46:24 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a184so12328331pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77fIouPB3CBo9hdk97EBnQZpnfI803efx1airl6rq5E=;
        b=enIH8aaZueLgX1MGtHL7ltJPuMsimaTiFPZLqexb/VlKTutGZXchcAGzfdKr8olD9S
         SZ7CV37QHQVHGEHNV/uLAQO44Zjmheixc5pd1r2v9AMtW/FmT9k29f3wVIhzsIvp7POR
         qo4MNY5TPmuFlAnXMNo2E6zThwrUXOn4ZOmbE0OLNGTQudfcDpZc/oSHy0gOu287qaX6
         XWGhXLXdo66hZGwMzehaFf2k7pEZwPshmuBGWxORmosyMSvqSv3JdO87nGjocLhXq/lJ
         lXP7E4E9l+BzQ+Mb5BbhuRi+FauHOyFhkknP/3dJ06wJdpVJTchipPMy0MtyE2pQU+gJ
         YctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77fIouPB3CBo9hdk97EBnQZpnfI803efx1airl6rq5E=;
        b=RpSJEJUaU5E8MyhDNEYAfnH7zoKHa5tJFGFUx+udfAQzGPa5L9XwVTiQAG/cDbn50H
         OUG4rdRm7uHQPKP47ow3k4PMWFztb/RcZjqP1Q/Wx7PCtqpNT7Q7/hkIlOaZB5PYg/es
         HJyzoROSbxRMNJEsniwAlqc/lluEi4+V4Lp8fThNSkArkBi/+WSB6vg8Ne6dWr8AKVTJ
         t4qo2szPfBJywwA5XDdrNkcWh0R8CZMptVBi8P7rrOPMKAWOA/EOjgeIVX0v6f8xMLuU
         uAcU7adnqjd+mG0zpcvcBlvT1rbldGgyOo44Wg60T7D05kvb/DhKWMpIc/jUR2aKEIpy
         EZlw==
X-Gm-Message-State: AFqh2koRnuSYeapVOCThlBmaBrnHmHj8NvRLe7NC3GlHH+jGaiSqF1YL
        jhVuGaIHYDU5dR6x1TTJHr0pA+zpYN7soOYEY4cP3g==
X-Google-Smtp-Source: AMrXdXvCb6udar7PNArrd6qU/zxQY3pjAsYcJ8Psr3n5jsAIiclTlRIqmXn1z0KYUKEvBKNApw0/HUxNliZkrrwTnjc=
X-Received: by 2002:a63:ba09:0:b0:479:2227:3aa1 with SMTP id
 k9-20020a63ba09000000b0047922273aa1mr2133298pgf.595.1672847184356; Wed, 04
 Jan 2023 07:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org> <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jan 2023 16:45:48 +0100
Message-ID: <CAPDyKFrVjenwv0Fe36LBqML-R_w2TjoCwmbnqqOohV_1zH8vJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Realtime kernels with PREEMPT_RT must use raw_spinlock_t for domains
> which are invoked from CPU idle (thus from atomic section).  Example is
> cpuidle PSCI domain driver which itself is PREEMPT_RT safe, but is being
> called as part of cpuidle.

Just so I don't get this wrong, since the cpuidle-psci also calls
pm_runtime_* functions so it isn't PREEMPT_RT safe, at least not yet?

>
> Add a flag allowing a power domain provider to indicate it is RT safe.
> The flag is supposed to be used with existing GENPD_FLAG_IRQ_SAFE.
>
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For genpd, overall, I think this looks like an okay approach to me.
Although, let me check the whole series (I need some more time to do
that) before I give this my blessing.

Kind regards
Uffe

>
> ---
>
> Independently from Adrien, I encountered the same problem around genpd
> when using PREEMPT_RT kernel.
>
> Previous patch by Adrien:
> https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
> ---
>  drivers/base/power/domain.c | 59 +++++++++++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   | 13 ++++++++
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 967bcf9d415e..4dfce1d476f4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -119,6 +119,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>         .unlock = genpd_unlock_spin,
>  };
>
> +static void genpd_lock_rawspin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->rslock)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&genpd->rslock, flags);
> +       genpd->rlock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_rawspin(struct generic_pm_domain *genpd,
> +                                       int depth)
> +       __acquires(&genpd->rslock)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave_nested(&genpd->rslock, flags, depth);
> +       genpd->rlock_flags = flags;
> +}
> +
> +static int genpd_lock_interruptible_rawspin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->rslock)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&genpd->rslock, flags);
> +       genpd->rlock_flags = flags;
> +       return 0;
> +}
> +
> +static void genpd_unlock_rawspin(struct generic_pm_domain *genpd)
> +       __releases(&genpd->rslock)
> +{
> +       raw_spin_unlock_irqrestore(&genpd->rslock, genpd->rlock_flags);
> +}
> +
> +static const struct genpd_lock_ops genpd_rawspin_ops = {
> +       .lock = genpd_lock_rawspin,
> +       .lock_nested = genpd_lock_nested_rawspin,
> +       .lock_interruptible = genpd_lock_interruptible_rawspin,
> +       .unlock = genpd_unlock_rawspin,
> +};
> +
>  #define genpd_lock(p)                  p->lock_ops->lock(p)
>  #define genpd_lock_nested(p, d)                p->lock_ops->lock_nested(p, d)
>  #define genpd_lock_interruptible(p)    p->lock_ops->lock_interruptible(p)
> @@ -126,6 +168,8 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>
>  #define genpd_status_on(genpd)         (genpd->status == GENPD_STATE_ON)
>  #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> +#define genpd_is_rt_safe(genpd)                (genpd_is_irq_safe(genpd) && \
> +                                        (genpd->flags & GENPD_FLAG_RT_SAFE))
>  #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> @@ -1838,6 +1882,12 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>                 return -EINVAL;
>         }
>
> +       if (!genpd_is_rt_safe(genpd) && genpd_is_rt_safe(subdomain)) {
> +               WARN(1, "Parent %s of subdomain %s must be RT safe\n",
> +                    genpd->name, subdomain->name);
> +               return -EINVAL;
> +       }
> +
>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>         if (!link)
>                 return -ENOMEM;
> @@ -2008,8 +2058,13 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>  {
>         if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> -               spin_lock_init(&genpd->slock);
> -               genpd->lock_ops = &genpd_spin_ops;
> +               if (genpd->flags & GENPD_FLAG_RT_SAFE) {
> +                       raw_spin_lock_init(&genpd->rslock);
> +                       genpd->lock_ops = &genpd_rawspin_ops;
> +               } else {
> +                       spin_lock_init(&genpd->slock);
> +                       genpd->lock_ops = &genpd_spin_ops;
> +               }
>         } else {
>                 mutex_init(&genpd->mlock);
>                 genpd->lock_ops = &genpd_mtx_ops;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1cd41bdf73cf..0a1600244963 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -61,6 +61,14 @@
>   * GENPD_FLAG_MIN_RESIDENCY:   Enable the genpd governor to consider its
>   *                             components' next wakeup when determining the
>   *                             optimal idle state.
> + *
> + * GENPD_FLAG_RT_SAFE:         When used with GENPD_FLAG_IRQ_SAFE, this informs
> + *                             genpd that its backend callbacks, ->power_on|off(),
> + *                             do not use other spinlocks. They might use
> + *                             raw_spinlocks or other pre-emption-disable
> + *                             methods, all of which are PREEMPT_RT safe. Note
> + *                             that, a genpd having this flag set, requires its
> + *                             masterdomains to also have it set.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> @@ -69,6 +77,7 @@
>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
>  #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
> +#define GENPD_FLAG_RT_SAFE      (1U << 7)
>
>  enum gpd_status {
>         GENPD_STATE_ON = 0,     /* PM domain is on */
> @@ -164,6 +173,10 @@ struct generic_pm_domain {
>                         spinlock_t slock;
>                         unsigned long lock_flags;
>                 };
> +               struct {
> +                       raw_spinlock_t rslock;
> +                       unsigned long rlock_flags;
> +               };
>         };
>
>  };
> --
> 2.34.1
>
