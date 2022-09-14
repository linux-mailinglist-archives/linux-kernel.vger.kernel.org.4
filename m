Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835245B86B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiINKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiINKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:52:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C677EB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a8so24460709lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Tzg0UqcWkRO7Ez0LCVJhhSJSUEIHdVeKXG31/UCwhag=;
        b=P6tReRDP3eRaLV/9uibQ/73lbSW9BM1VfDUIETF0de9TTlE6DgAXsYkDiRlO+Ozlu8
         YJ7plGgD3ax9uxCY5LIxYNfaiE+bHAkifNUHC/VuxRNyECI6we9DStZEvXCP4pwiGR38
         26fpvrRASMtHO9K3Qp5dFxsiS77nZb2Cy7unJZnrHEBXriEz/e4kNFwm9p4Lkri2fH9/
         +PHdoqK0K5azuRorTki35Be4OZacDY5R9QgXwAxUSd8tNGdgGfn5GX1mtHJ0VWiLPTmr
         0xcl/Z3rNP9eDgtfdBB6RswB+KG/qhDrW1lcQIsqfcfCpvXUO8ZbMppYYrel4qj1Ud3t
         51ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Tzg0UqcWkRO7Ez0LCVJhhSJSUEIHdVeKXG31/UCwhag=;
        b=OAkJyJeqt2jq3sKSWnk//dDng6Kqz9Ywu0ClI0Y0Db5adMOYUlhN6NfL6uDJvBkasM
         Y0VUpZYntc3o9ZyjOffTTdn30OXOU3C5t5chROrRXPthVJ2N2AVCZGYp3yPCn9nwBpnp
         D9FIpkMB22p4HN4kMJlMrgvzgI2xUm3AwKzi+uvQtLC4w1iYdp+ZaY/YvrrQVlarZ6WG
         nE6vdQxjbBY6zcZv7o7JlLrqx9wvhc9Ak4k4oGSKR7swBnvXlAvPilZh96DHMLb1V4G5
         WpNcgkMLoAf1sMGdvYmql2TlWeSG3G+PAFD2KU0iRJA4aWDlkaS6WJQZs8q+z4PCRJWM
         FQow==
X-Gm-Message-State: ACgBeo379o3QkJ6U0bRni7fhHU31khSkCYkANWtX7106AC2enndQfGBC
        nRnFVgH6nr2n/6VeQIaksdoSteGdxbZnRbvlslo=
X-Google-Smtp-Source: AA6agR4/jJlL7UH6zxhhEoxV4Kw//WPkYLPvcLwxbA1TDgbVDsWXfksCqPfXKvnLFcVDLeLZHnz6uk33oJwtULEZzl4=
X-Received: by 2002:a05:6512:151a:b0:49c:2f02:4e22 with SMTP id
 bq26-20020a056512151a00b0049c2f024e22mr2537908lfb.130.1663152693839; Wed, 14
 Sep 2022 03:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 14 Sep 2022 18:51:05 +0800
Message-ID: <CAGWkznFvv=XeZeLyPk_W_2R46DsyD4hytVQ=iqnc24NEjv1Qxg@mail.gmail.com>
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

Nack here and will be updated with trackleak if necessary.

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
> +       return page->page_type < PAGE_MAPCOUNT_RESERVE;
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
