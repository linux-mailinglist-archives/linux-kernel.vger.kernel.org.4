Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F06C016D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCSMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCSMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:08:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235722C9C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:07:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so36699281edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679227667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23VPAup5yLjI/9do121HjMU7OWFbvJtP6xCL1xBAHA0=;
        b=odDNsKigCA5xnnfue9ndJstTBppyRIWeCpYfGNZ68Gzpk1yvBkuTOMyn9+O8/+PHOz
         VAc4V84vUPCNf4b0d3yQoiZMGC0xUQIuGW4TudauejzRJnptOgNRAxykTxLo9m30K1pS
         WDPmDnWl+cXPk6UzKYrwoTWUbavntOFXnsGeOeHQy/jYTCvwcfEItKXXY3YTcJQnUrtH
         11kefEj4C3+C/L5oPAgV1GmqxsZkhq92ox6IBqKH8Nyer7ydVNLeLIWEHA0GGIuAUnYP
         QVncHkYliK45AwhZgoKnwWCvx5Nx3K8mThc7lp6Le92ZCGtTgpOwhdF7kHNVVIxKAmC/
         e7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679227667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23VPAup5yLjI/9do121HjMU7OWFbvJtP6xCL1xBAHA0=;
        b=lpPMaoamZ3D8wmwMJn2TU/qFxoqlz33o6BpDDCIJzB2nDYICkaETxSilr8SxVoQ91F
         U7ikpBFtCx24qPhrh8H9xbBlLiQfAap7EpnZOngOn91Kx673bsJO29n0uxW0UbjtCK3F
         ezNjrzLbJgDBzTCv89pPgIu0qfAnf41asWjtkJVv0WoAx11jZ331KWYmD+6RPqPGAF2y
         V9xAmQrVIDlVmjuRgq85S73MIKSZELMivTk5tB8WR0Jj0EXxLMNMicUvnsQynoDJ0vBH
         rFo9uKIELIUtPE9BHo9JX4US+bTLleDG6qt0jXYyHWtHcx+M1DsmS1MnWLAzz5sSSvJn
         5apw==
X-Gm-Message-State: AO0yUKWl++RYfb0ShVyoUiOl64x5REyY/fmBxIiqD1yHtHEAtwmNXpBf
        Cq0NuJdrwLSVHbdoF3+mP9SjwmbsEWM=
X-Google-Smtp-Source: AK7set87vZgAzbm1Sp9wrmGlgUY+aL4G2jxaEbb04ckGqdMY01nDoDXlZMT8w37ZsN4MQ8+1MsQpgw==
X-Received: by 2002:a17:906:ecf8:b0:931:4f2c:4e83 with SMTP id qt24-20020a170906ecf800b009314f2c4e83mr5573234ejb.63.1679227666740;
        Sun, 19 Mar 2023 05:07:46 -0700 (PDT)
Received: from localhost ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b008d1dc5f5692sm3161172eje.76.2023.03.19.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 05:07:45 -0700 (PDT)
Date:   Sun, 19 Mar 2023 12:07:43 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move get_page_from_free_area() to mm/page_alloc.c
Message-ID: <0020b728-724d-4206-8768-ec94d5628b34@lucifer.local>
References: <20230319114214.2133332-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319114214.2133332-1-rppt@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:42:14PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The get_page_from_free_area() helper is only used in mm/page_alloc.c so
> move it there to reduce noise in include/linux/mmzone.h
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  include/linux/mmzone.h | 7 -------
>  mm/page_alloc.c        | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 96599cb9eb62..8f5a9e2c722a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -108,13 +108,6 @@ struct free_area {
>  	unsigned long		nr_free;
>  };
>
> -static inline struct page *get_page_from_free_area(struct free_area *area,
> -					    int migratetype)
> -{
> -	return list_first_entry_or_null(&area->free_list[migratetype],
> -					struct page, lru);
> -}
> -
>  static inline bool free_area_empty(struct free_area *area, int migratetype)
>  {
>  	return list_empty(&area->free_list[migratetype]);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 87d760236dba..2e72fdbdd8db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1048,6 +1048,13 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
>  	zone->free_area[order].nr_free--;
>  }
>
> +static inline struct page *get_page_from_free_area(struct free_area *area,
> +					    int migratetype)
> +{
> +	return list_first_entry_or_null(&area->free_list[migratetype],
> +					struct page, lru);
> +}
> +
>  /*
>   * If this is not the largest possible page, check if the buddy
>   * of the next-highest order is free. If it is, it's possible
>
> base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
> --
> 2.35.1
>

Good catch, I wonder if there are more functions like this that can be dropped
from headers?

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
