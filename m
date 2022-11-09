Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA8622F90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKIQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKIQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:01:58 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B351741C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:01:56 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id a27so10573802qtw.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnYVWtJikOEMfDJtWiHw0jPS1ENRmpA7W4UGhQECTYQ=;
        b=GwrujQPf/u5RxS78Rxu+bDu7b13J5mkQdyB+e/hvH4/OhWpXQm4g2rcxbuPvzMmnM0
         k8HjJRZFcM44iqnic9ilo0VpFdW+Njr/ls0Llv9OaJbJeGRCe2JAsh06MXehCaJ+fJhZ
         sQefqTvYSqOdkBv1EMHB3x/jheLQEEE59OzRBDDnmLy0WI9YM1K7F6H2OiPZEmpeJkVF
         d5ll8Kw7ce/Kx+Sw6NFNE+0rj52p6g/vnWLFwQWzsaGIwm7FuFxJySNtW1F9OIP6COMw
         DTNWxkclba50ulgMq+u9+cM1qrOSBlvc88Bo+i5kPWIjo6Mx5ewDu6sOTZ48CXlfnW9r
         akHQ==
X-Gm-Message-State: ACrzQf04PZSPEG8Ntbo2AVIET71Oj7jjFXY4j9PyBefaT8Sk/0E1ksNI
        4IqnH2ieaT1INqMEdUNHvIVaq6sXKxamJMgrHs8=
X-Google-Smtp-Source: AMsMyM7ce3VL7QLjiLwXyxJ1hr9cQxPsLRfEC6/PPgJU1KRSnbfSqPujiz5Aj8SYOVzGPOzCQX7efrgIkvYO8BBPQOw=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr40323749qtb.411.1668009715620; Wed, 09
 Nov 2022 08:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20221109155618.42276-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221109155618.42276-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 17:01:44 +0100
Message-ID: <CAJZ5v0hfuVcUxUj5OqPUY+yBnB0_QOt=k1cw8sH=Hz1SdZhpmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] resource: Replace printk(KERN_WARNING) by
 pr_warn(), printk() by pr_info()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Nov 9, 2022 at 4:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace printk(KERN_WARNING) by pr_warn() and printk() by pr_info().
>
> While at it, use %pa for the resource_size_t variables. With that,
> for the sake of consistency, introduce a temporary variable for
> the end address in iomem_map_sanity_check() like it's done in another
> function in the same module.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: updated changelog (Rafael), Cc'ed to Greg (Rafael)
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
