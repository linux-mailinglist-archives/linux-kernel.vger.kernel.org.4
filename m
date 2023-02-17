Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBC69A601
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBQHVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQHVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:21:12 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8544D60A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:21:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p8so463024plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rXVwNplCcLm5rUFK+S1hkGHd+teMSvP6lTidP/qhpM=;
        b=fHBXF+YsKrkaw1pEby4rg4Z7YWlUYj1FY+tzRGgLqWY9qYa8mcSkUdWiC3ViheyDYx
         3JqqhV+lbhtsnu5S7chOGie+swgVOsx0D75Zz3OTU2cFDDns7M8IP1BB/zXSeQoK4dDt
         dbC/DLK+yxCtDlKWlfnX2BnCj0m5rWdCe+DgbSoSsX0n5iJ4wGMkvQK1toX/ciSJlk86
         0CP7ITDQ2dbyacRpGLPmxq+bWsIAui3kz12C7zvTl02UZw1iQXQkU+8lpVUI6iGPdH9D
         2prPXr/G2Xrp9ioDlfeQAvD6QgDbSxOWTC+WV173z8qpO45I5Mc49GXUTX5Yl7Kfbxne
         KP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rXVwNplCcLm5rUFK+S1hkGHd+teMSvP6lTidP/qhpM=;
        b=QH3rlejkGNudBEhFgOC5rUw95p/PS5UzwjbIu+mrfaD/20khWlIpYWj4iLDcydFs0U
         T3L0E/9A/dKod7NtVOJLmDLOFSr8nrdw30CnFwGn9G/tG7VtigyhHoz70n1qG+aGtsvK
         CPltakMqBe750g3LLmAqdDCP7IXnG5Lcu+ANWaePkk7ZhM2OWGEekbQVLd/y5y7ydJxk
         BGWRe8KUvE+NpAZLBeshKT63CnX+DCxqo+58DJ0QhnmS5k5aAdCE2gHvQXr7qzI8tJTH
         d7bkx/9x7WSESJONRD0iGzC+SPnEPJN6UN7NpLmE/EZE7A0cGCmJYZU4J6BicJgo0rXd
         47aQ==
X-Gm-Message-State: AO0yUKViFPVCxu/GUkzozNQ/UAWxr4PRaMezswpFnBbk5bvY+HLZbHog
        Y9jD4SZ0ZfHR8di+ntTBzOL1y2plX4sEkdyFvi1gsA==
X-Google-Smtp-Source: AK7set+oTu/USoT/eilY6i7pfNlEF6yLy2ul8SDGMvF0Pbh+/omy+xTG6X7YRS8FPEa12u5Jur3ZjjDS+PZell9/vhQ=
X-Received: by 2002:a17:90b:2648:b0:236:76cb:99d7 with SMTP id
 pa8-20020a17090b264800b0023676cb99d7mr120401pjb.44.1676618470428; Thu, 16 Feb
 2023 23:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214035445.1250139-1-talumbau@google.com>
In-Reply-To: <20230214035445.1250139-1-talumbau@google.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 16 Feb 2023 23:20:58 -0800
Message-ID: <CAAPL-u_p64P+uupj-P-piRo=6d_ogadJMT5=waS0BtZ6ATFx7w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/2] mm: multi-gen LRU: clean up sysfs code
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Wei Xu <weixugc@google.com>

On Mon, Feb 13, 2023 at 7:54 PM T.J. Alumbaugh <talumbau@google.com> wrote:
>
> This patch cleans up the sysfs code. Specifically,

Nit: Remove "This patch" per the "submitting patches" guide.

>   1. use sysfs_emit(),
>   2. use __ATTR_RW(), and
>   3. constify multi-gen LRU struct attribute_group.
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  include/linux/mmzone.h |  2 +-
>  mm/vmscan.c            | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9fb1b03b83b2..bf8786d45b31 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1369,7 +1369,7 @@ typedef struct pglist_data {
>
>  #ifdef CONFIG_LRU_GEN
>         /* kswap mm walk data */
> -       struct lru_gen_mm_walk  mm_walk;
> +       struct lru_gen_mm_walk mm_walk;
>         /* lru_gen_folio list */
>         struct lru_gen_memcg memcg_lru;
>  #endif
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d4b9fd1ae0ed..09c064accdb1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5658,14 +5658,14 @@ static void lru_gen_change_state(bool enabled)
>   *                          sysfs interface
>   ******************************************************************************/
>
> -static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +static ssize_t min_ttl_ms_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>  {
> -       return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
> +       return sysfs_emit(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
>  }
>
>  /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
> -static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
> -                            const char *buf, size_t len)
> +static ssize_t min_ttl_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
> +                               const char *buf, size_t len)
>  {
>         unsigned int msecs;
>
> @@ -5677,11 +5677,9 @@ static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
>         return len;
>  }
>
> -static struct kobj_attribute lru_gen_min_ttl_attr = __ATTR(
> -       min_ttl_ms, 0644, show_min_ttl, store_min_ttl
> -);
> +static struct kobj_attribute lru_gen_min_ttl_attr = __ATTR_RW(min_ttl_ms);
>
> -static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>  {
>         unsigned int caps = 0;
>
> @@ -5698,7 +5696,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>  }
>
>  /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
> -static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
> +static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>                              const char *buf, size_t len)
>  {
>         int i;
> @@ -5725,9 +5723,7 @@ static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
>         return len;
>  }
>
> -static struct kobj_attribute lru_gen_enabled_attr = __ATTR(
> -       enabled, 0644, show_enabled, store_enabled
> -);
> +static struct kobj_attribute lru_gen_enabled_attr = __ATTR_RW(enabled);
>
>  static struct attribute *lru_gen_attrs[] = {
>         &lru_gen_min_ttl_attr.attr,
> @@ -5735,7 +5731,7 @@ static struct attribute *lru_gen_attrs[] = {
>         NULL
>  };
>
> -static struct attribute_group lru_gen_attr_group = {
> +static const struct attribute_group lru_gen_attr_group = {
>         .name = "lru_gen",
>         .attrs = lru_gen_attrs,
>  };
> --
> 2.39.1.581.gbfd45094c4-goog
>
>
