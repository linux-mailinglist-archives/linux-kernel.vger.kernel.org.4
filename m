Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AA742AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF2Qpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjF2Qpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:45:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC79430E4;
        Thu, 29 Jun 2023 09:45:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso615631b3a.2;
        Thu, 29 Jun 2023 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688057128; x=1690649128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yd3prj50qZ/KXnCa8qhFKXz7uId1ym/Cpfqr4ubT/HA=;
        b=N5xoyrp5avc3HurYxvthHNLsVQm/uZXxqZllpagQ27jIT51RcR3cDeJw8MCQbz4HAJ
         ux4uSctLUrtajYlEbPw4TAn6Qzi1a8rJtN66nWBfrhKST0pCyaj6hhXuniXbeM8e0bFT
         0q+BgwaVEA52OgJYbAwrukd4E8dRjkPfIBVVhSIljbUoVdFMP925VodAT1ZAQMrs84vp
         11xBWTbZL6twldaS5zmeDY0TWDZ2c7TOFtbkC2LuO2xRgXJOOjzPd0qByga2izTxrYx/
         sefErWYRKPw9vLtNxl4zaMOYgkNO/wQFT6frx57gSqSHfsyVmw2FKI3Km2U+zp0qcAnf
         qPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057128; x=1690649128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yd3prj50qZ/KXnCa8qhFKXz7uId1ym/Cpfqr4ubT/HA=;
        b=gX2s++/bYDOTOHdNwZYTleL06sQ/so3UNME8o815NzxIX3RdKoOnAJXq5tQLoyTRnI
         ptmEOMLwnCQvu+XyyCJ1rpS9kqE8fZz8krDri7+N55UtMih5RfROTZOEduOhrSkNljlz
         SKo2S2bc9RsUfupttlLNyDlrDNpdCGYDf8tmUWQ3WonvF58p4I3cE1Xwa8hqyGax1mth
         d5pnaiMBIhvh+6v+IDCukYn8b4tHfKnZN6O3uvsnBAHptph4tqVrc6NVgx3i6uiSdrDW
         zTXo25NW6lXAFrnxnMzP09pJbmGXqZi6Z4FklejHvGWSCMZMnrkZhIKcRug0iHyzaoK/
         JOtQ==
X-Gm-Message-State: ABy/qLY78gW9XIiwpU6Sk0a1j5H6ezlkKjekATWDuQ2Fc5dw1niN7Ps1
        JQXGDGzcPXxWWM+E9diJGo4=
X-Google-Smtp-Source: APBJJlHm8gXrhUfVyIiRiRVp7jCrMzNCrriCXnUx/mhM9josnKId++QykLG9IipART+7qFUgDlfakw==
X-Received: by 2002:a05:6a00:188c:b0:681:89eb:9c9b with SMTP id x12-20020a056a00188c00b0068189eb9c9bmr542386pfh.11.1688057128107;
        Thu, 29 Jun 2023 09:45:28 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id a25-20020aa78659000000b0067738f65039sm6593188pfo.83.2023.06.29.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:45:27 -0700 (PDT)
Message-ID: <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 09:45:26 -0700
In-Reply-To: <20230629152305.905962-3-aleksander.lobakin@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
         <20230629152305.905962-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
> even when on DMA-coherent platforms (like x86) with no active IOMMU or
> swiotlb, just for the call ladder.
> Indeed, it's
>=20
> page_pool_put_page()
>   page_pool_put_defragged_page()                  <- external
>     __page_pool_put_page()
>       page_pool_dma_sync_for_device()             <- non-inline
>         dma_sync_single_range_for_device()
>           dma_sync_single_for_device()            <- external
>             dma_direct_sync_single_for_device()
>               dev_is_dma_coherent()               <- exit
>=20
> For the inline functions, no guarantees the compiler won't uninline them
> (they're clearly not one-liners and sometimes compilers uninline even
> 2 + 2). The first external call is necessary, but the rest 2+ are done
> for nothing each time, plus a bunch of checks here and there.
> Since Page Pool mappings are long-term and for one "device + addr" pair
> dma_need_sync() will always return the same value (basically, whether it
> belongs to an swiotlb pool), addresses can be tested once right after
> they're obtained and the result can be reused until the page is unmapped.
> Define new PP flag, which will mean "do DMA syncs for device, but only
> when needed" and turn it on by default when the driver asks to sync
> pages. When a page is mapped, check whether it needs syncs and if so,
> replace that "sync when needed" back to "always do syncs" globally for
> the whole pool (better safe than sorry). As long as a pool has no pages
> requiring DMA syncs, this cuts off a good piece of calls and checks.
> On my x86_64, this gives from 2% to 5% performance benefit with no
> negative impact for cases when IOMMU is on and the shortcut can't be
> used.
>=20
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool.h |  3 +++
>  net/core/page_pool.c    | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 829dc1f8ba6b..ff3772fab707 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -23,6 +23,9 @@
>  					* Please note DMA-sync-for-CPU is still
>  					* device driver responsibility
>  					*/
> +#define PP_FLAG_DMA_MAYBE_SYNC	BIT(2) /* Internal, should not be used in
> +					* drivers
> +					*/
>  #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
>  				 PP_FLAG_DMA_SYNC_DEV)
> =20
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index dff0b4fa2316..498e058140b3 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -197,6 +197,10 @@ static int page_pool_init(struct page_pool *pool,
>  		/* pool->p.offset has to be set according to the address
>  		 * offset used by the DMA engine to start copying rx data
>  		 */
> +
> +		/* Try to avoid calling no-op syncs */
> +		pool->p.flags |=3D PP_FLAG_DMA_MAYBE_SYNC;
> +		pool->p.flags &=3D ~PP_FLAG_DMA_SYNC_DEV;
>  	}
> =20
>  #ifdef CONFIG_PAGE_POOL_STATS
> @@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool *pool=
, struct page *page)
> =20
>  	page_pool_set_dma_addr(page, dma);
> =20
> +	if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
> +	    dma_need_sync(pool->p.dev, dma)) {
> +		pool->p.flags |=3D PP_FLAG_DMA_SYNC_DEV;
> +		pool->p.flags &=3D ~PP_FLAG_DMA_MAYBE_SYNC;
> +	}
> +
>  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> =20

I am pretty sure the logic is flawed here. The problem is
dma_needs_sync depends on the DMA address being used. In the worst case
scenario we could have a device that has something like a 32b DMA
address space on a system with over 4GB of memory. In such a case the
higher addresses would need to be synced because they will go off to a
swiotlb bounce buffer while the lower addresses wouldn't.

If you were to store a flag like this it would have to be generated per
page.
