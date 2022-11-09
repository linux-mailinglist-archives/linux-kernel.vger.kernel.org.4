Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141306229D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiKILMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKILMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:12:17 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D722B3C;
        Wed,  9 Nov 2022 03:12:16 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id 8so10712107qka.1;
        Wed, 09 Nov 2022 03:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRbEPLJDZs00e0naDlA/9gKuzLlGHl7wDAqA6Ym3dJc=;
        b=eSE5PitczGGXN10zAj1NFg/AWoup7K38NcHNTSkaklzTGsBF5u/XPMWyYwtheXAIGy
         GJIX/2VPXMhhGRe1YrEjFa+EFUju1V2T4aAxHFoAfvCHEkSJoWnwJIvtAfhdZghRu77U
         R1EctkHNs6G+k3QbJTcJik0nSza4WOtbov+jgRAR0qu8MRqiTJMsfaQ9MjrwKcayQen9
         8xyyoFn/8DMIqZNIYKFq+9A97wsnhpGcHklr1dTXp4yJxz1WBm9fs9bHiOvCyYAuw8I2
         /5MxfwbwR6fw6LQH4MfBIIu4u75IRPufGVKopMJqzJFvYOOpKpLdD/IOIx0qegEJwVSv
         nZRg==
X-Gm-Message-State: ACrzQf2WxxW58qxjJBfJbxz6dq4SpOFpsryVbyIEE4QHKZlobLlIM6HP
        Rhj/eATei/hEUm7sso9x5WSpQ+t3HgsVIyZuidCZkdEY
X-Google-Smtp-Source: AMsMyM6akL5ZYpwLHjQtcFwxu8an9ECUD+COd60a2CfbtiGIUC1/jYR8pwCptfIsLRqMhrNOVsaRCnlQXAXyGpC8NQ4=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr30970439qkl.23.1667992335697; Wed, 09
 Nov 2022 03:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 12:12:03 +0100
Message-ID: <CAJZ5v0gxM80EKiiMJKkN6t1CVgf1=6yYA3D4=TfOHVh1chaJuw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] resource: Replace printk(KERN_WARNING) by pr_warn()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Nov 9, 2022 at 11:51 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace printk(KERN_WARNING) by pr_warn().
>
> While at it, use %pa for the resource_size_t variables.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is Greg's stuff I think.

> ---
>  kernel/resource.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 4c5e80b92f2f..ab32b015bd50 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -888,7 +888,7 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>                 if (conflict->end > new->end)
>                         new->end = conflict->end;
>
> -               printk("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
> +               pr_info("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
>         }
>         write_unlock(&resource_lock);
>  }
> @@ -1283,9 +1283,7 @@ void __release_region(struct resource *parent, resource_size_t start,
>
>         write_unlock(&resource_lock);
>
> -       printk(KERN_WARNING "Trying to free nonexistent resource "
> -               "<%016llx-%016llx>\n", (unsigned long long)start,
> -               (unsigned long long)end);
> +       pr_warn("Trying to free nonexistent resource <%pa-%pa>\n", &start, &end);
>  }
>  EXPORT_SYMBOL(__release_region);
>
> @@ -1658,6 +1656,7 @@ __setup("reserve=", reserve_setup);
>  int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
>  {
>         struct resource *p = &iomem_resource;
> +       resource_size_t end = addr + size - 1;

And this change could be mentioned in the changelog too.

>         int err = 0;
>         loff_t l;
>
> @@ -1667,12 +1666,12 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
>                  * We can probably skip the resources without
>                  * IORESOURCE_IO attribute?
>                  */
> -               if (p->start >= addr + size)
> +               if (p->start > end)
>                         continue;
>                 if (p->end < addr)
>                         continue;
>                 if (PFN_DOWN(p->start) <= PFN_DOWN(addr) &&
> -                   PFN_DOWN(p->end) >= PFN_DOWN(addr + size - 1))
> +                   PFN_DOWN(p->end) >= PFN_DOWN(end))
>                         continue;
>                 /*
>                  * if a resource is "BUSY", it's not a hardware resource
> @@ -1683,10 +1682,8 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
>                 if (p->flags & IORESOURCE_BUSY)
>                         continue;
>
> -               printk(KERN_WARNING "resource sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
> -                      (unsigned long long)addr,
> -                      (unsigned long long)(addr + size - 1),
> -                      p->name, p);
> +               pr_warn("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
> +                       &addr, &end, p->name, p);
>                 err = -1;
>                 break;
>         }
> --
> 2.35.1
>
