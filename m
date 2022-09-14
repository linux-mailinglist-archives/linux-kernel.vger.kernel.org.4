Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0A5B8052
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINEgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:36:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29343603
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:36:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so23314613lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rbQPO/ZpUx83BVqTcUPRWq9WRGiF0/a3kr8stv4AT0Y=;
        b=AzPktmJc0ZWX4Ni3a3C/lXwuHKpiPaI+HekMQ8GCkUoVcbjWCUJ2TCFyLwZ6qPmFpw
         ZCfNh+2EvGokEkXHRTWMfg+gnabu40a0DT1mmPN2xGRaKOBb+NUu0xvZTF14KpG4Lssk
         QQXVIzRrKQW1w5HhfFR74NKPApGorGSCFsNZuYnTIHvpzplrWERLos32S+rXfBIU/XaT
         nJuZIHd0cLW1c1SAuW8z+dTuwxUtSAllK3WXkHan7RKlixZvddaLg6qkjT4fxyX4FqDW
         /2VKg0s+J0+YU2/SYqnstVJ7fZeJmF2f4pKU3sfPb8CtjkMjK8Fv0QjvgDUo5sgxTzAw
         tGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rbQPO/ZpUx83BVqTcUPRWq9WRGiF0/a3kr8stv4AT0Y=;
        b=xipN0NwVSurJwoT8pbZFNxL9jmWaBFVLoRdbPdkcq/v9J4I8HnzeN8c6ksLjmGdKqz
         Gj8oi2dzOhOKFHpfnYcccJWQXz7xoytEvOBV5awKP6kh+8Qb9YiF1GwR01tu5hFZfjDe
         1DvN1mxNxuX/yRcxSF+RGrSairVaMBhocDYVrzTyohv6QwrTck4tFEWXsYAM+tzOkbma
         OByuLgqvPnyeChs0c6mBJLGEZ/G56QAPF3yjvGsKq5PUkjLSzI4tnMY/VnEmyC5OS0G/
         EZwKm3e+K6WOnLcosVrcSlH3OH5ZIDpt7UJ6k4sHCb6enbBdGIMa6hW1x7AMc+GfBMfl
         CnGA==
X-Gm-Message-State: ACgBeo3EPKGK5mW82QzwaURb/meNjAaylERWDMCfER7xRGi6MvzVK/NC
        h5Rk/0UuxlSK/vL7TaO8uGmKik4kptqXo1ieGeRSo+Se
X-Google-Smtp-Source: AA6agR6ma+qcE13y21n0LVozu7pgM/Ek6PTgLkOVLaxz9CE6W4rFCufLahRW9O1FJQWRGGm4RgnEhInFgIQWVRe5w8A=
X-Received: by 2002:a05:6512:c18:b0:49a:d44b:435 with SMTP id
 z24-20020a0565120c1800b0049ad44b0435mr3792619lfu.468.1663130159435; Tue, 13
 Sep 2022 21:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 14 Sep 2022 12:35:31 +0800
Message-ID: <CAGWkznFYa26GeAPU+FNxrX1EJ3bLz+q8drtpuO4mNYFGtLG_Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: fix logic error of page_expected_state
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:37 AM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> The page with special page type will be deemed as bad page wrongly since
> type share the same address with mapcount.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/page-flags.h | 4 ++--
>  mm/page_alloc.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa..5d3274b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -946,9 +946,9 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PageType(page, flag)                                           \
>         ((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>
> -static inline int page_has_type(struct page *page)
> +static inline bool page_has_type(struct page *page)
>  {
> -       return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
> +       return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
amend the type conversion
>  }
>
>  #define PAGE_TYPE_OPS(uname, lname)                                    \
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3d..3714680 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1164,7 +1164,7 @@ int split_free_page(struct page *free_page,
>  static inline bool page_expected_state(struct page *page,
>                                         unsigned long check_flags)
>  {
> -       if (unlikely(atomic_read(&page->_mapcount) != -1))
> +       if (unlikely(!page_has_type(page) && atomic_read(&page->_mapcount) != -1))
>                 return false;
>
>         if (unlikely((unsigned long)page->mapping |
> --
> 1.9.1
>
