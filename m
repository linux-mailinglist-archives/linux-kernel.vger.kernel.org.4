Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04666D836
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjAQIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjAQIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:31:12 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264F12F1D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:31:06 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230117083104epoutp021bda4fae55a554af34d6ffb94f1ae6aa~7C3CSqiig2860528605epoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:31:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230117083104epoutp021bda4fae55a554af34d6ffb94f1ae6aa~7C3CSqiig2860528605epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673944264;
        bh=zAL9EyvjDCWe5aM2r4Y0dbsGA1oBkj/9Ar8ZcAjcpOY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=adzARGvrJWzD0/1HXnFZAC/GBPlWvcvDvBXkQtXBDBRiMgEKHffpGYGv+1zt4wdYg
         CRJo2AmNXI8IOjbwX0gPOnLh0YLq8auT2Jb5ektWr/F44hNpN5vSkrDqz0yqWIFfKt
         MvQN7O+y5Crq2rJT0BBGmlzRkPjrkL3bjMsYhGP0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230117083104epcas1p1ad9478078a59db6a2fa61dc0cb24e560~7C3B8JPfl0759907599epcas1p1n;
        Tue, 17 Jan 2023 08:31:04 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nx2Cr124Rz4x9Pv; Tue, 17 Jan
        2023 08:31:04 +0000 (GMT)
X-AuditID: b6c32a39-24bfd7000001a220-25-63c65cc7fc6d
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.AB.41504.7CC56C36; Tue, 17 Jan 2023 17:31:03 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "jstultz@google.com" <jstultz@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230117082508.8953-1-jaewon31.kim@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
Date:   Tue, 17 Jan 2023 17:31:03 +0900
X-CMS-MailID: 20230117083103epcms1p63382eee1cce1077248a4b634681b0aca
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmnu7xmGPJBqf/2VjMWb+GzWLhw7vM
        Fqs3+Vp0b57JaNH7/hWTxZ8TG9ksLu+aw2Zxb81/VovX35YxW5y6+5ndgcvj8Jv3zB57vy1g
        8dg56y67x4JNpR6bVnWyeWz6NInd4861PWweJ2b8ZvHo27KK0ePzJrkArqhsm4zUxJTUIoXU
        vOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygY5UUyhJzSoFCAYnFxUr6
        djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ2RnHFr9hKfjLXdF3
        5ThLA+Nbzi5GTg4JAROJDzfus3cxcnEICexglLhzYAuQw8HBKyAo8XeHMEiNsICLxO3Vfcwg
        tpCAksTZH1fYIeK6Ek3dq1lAbDYBbYn3CyaxgtgiApeZJE4s8gWZySywmFGibeVRJohlvBIz
        2p+yQNjSEtuXb2UEsTkFbCXmTprADhEXlbi5+i2c/f7YfEYIW0Si9d5ZZghbUOLBz91QcSmJ
        c93HoeaXS+yYs58Nwq6Q+N2/DGqOvsSV/plgNbwCvhLzz20Hq2ERUJVYeqYdqsZF4vn8T2Az
        mQXkJba/ncMMCgdmAU2J9bv0IUoUJXb+ngtVwifx7msPK8xbO+Y9gTpBTaLl2VeouIzE33/P
        oGwPieY1TSyQMGxhlLj933ECo8IsREjPQrJ4FsLiBYzMqxjFUguKc9NTiw0LTOGRm5yfu4kR
        nG61LHcwTn/7Qe8QIxMH4yFGCQ5mJRFev12Hk4V4UxIrq1KL8uOLSnNSiw8xmgK9PJFZSjQ5
        H5jw80riDU0sDUzMjEwsjC2NzZTEeW0i1iULCaQnlqRmp6YWpBbB9DFxcEo1MLkd2pLv9Wql
        j+l2E6mEPQmrvt/6bKXN9mPv3dgvbS8Ccu9O0o96nzijZL76E49vgh/yt/e6P92kOpkl+avI
        ff5LqbvUTnwxeHmlyuxvn80WjbvTL5k1Taq8u65wkaM75/3ZanuftsgapVnqixrd+dSSnOri
        fSTI9G960JlHQk+6K44IPMh++JD1rbIO8z4JvZffZu76qyT1VCrE4VLlBtl/AYJvbKT3Guqk
        3iheXcImPSVV/Kr0ne7Qo4I69V1bpnfnSy2/Ln9WMiUiK+z0C/a1W6YazS5uCIn7mb4xRO/B
        lC3rGzX2b2G8YCZrfnzV1ow1h2Y+qxFxUcioFTr2O6E0SJyh2avqK/N2/18t25RYijMSDbWY
        i4oTAbS84OJABAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Using order 4 pages would be helpful for many IOMMUs, but it could spend
> quite much time in page allocation perspective.
> 
> The order 4 allocation with __GFP_RECLAIM may spend much time in
> reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> unpredictable delay.
> 
> To get reasonable allocation speed from dma-buf system heap, use
> HIGH_ORDER_GFP for order 4 to avoid reclaim.
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index e8bd10e60998..5a405e99ef1e 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -42,11 +42,10 @@ struct dma_heap_attachment {
>  };
>  
>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> -#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>  				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
>  				| __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
>  /*
>   * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
>   * to match with the sizes often found in IOMMUs. Using order 4 pages instead
> -- 
> 2.17.1

added John Stultz <jstultz@google.com>
