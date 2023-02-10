Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727B6917D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBJFDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBJFDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:03:40 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369F55E43
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:03:37 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230210050334epoutp0366a8a7f852765bf9258cbdaaf19e55fa~CXgt96GO-0695706957epoutp039
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:03:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230210050334epoutp0366a8a7f852765bf9258cbdaaf19e55fa~CXgt96GO-0695706957epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676005414;
        bh=PzSTVr50vR+unyyHU8ecPzVzBA20pYL5vCXBlpK8cbo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IAkHjZT3ufugOzfPoy2g+l6N5sXMep+AcfVzm04LVpAwDNS5jang5ht8dxw+HEGCw
         hQWSshorqEEQzhkQICZ+iwcyoNPlHbm81Xlq9dpWVwYqi+82vot01m1eyfpkuefAlH
         JctS6JMeC4j6B68vZUG/a5Wz5kT9vnnXW+kicbeE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230210050334epcas1p232485b64a5599e0ced0e901a15aec190~CXgtZ9sil2937529375epcas1p2B;
        Fri, 10 Feb 2023 05:03:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.224]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PChTL0bHlz4x9Px; Fri, 10 Feb
        2023 05:03:34 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-fb-63e5d02520ad
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.A9.55531.520D5E36; Fri, 10 Feb 2023 14:03:33 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230210045608.23274-1-jaewon31.kim@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230210050333epcms1p7c0bd93b385828aeed9689d1d17ff6789@epcms1p7>
Date:   Fri, 10 Feb 2023 14:03:33 +0900
X-CMS-MailID: 20230210050333epcms1p7c0bd93b385828aeed9689d1d17ff6789
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmga7ahafJBitNLOasX8NmsfDhXWaL
        1Zt8Lbo3z2S06H3/isniz4mNbBaXd81hs7i35j+rxetvy5gtTt39zG7xbv0XNgduj8Nv3jN7
        7P22gMVj56y77B4LNpV6bFrVyeax6dMkdo871/aweZyY8ZvFo2/LKkaPz5vkAriism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRn3Hj2mqng
        nljF848z2RsYLwh2MXJySAiYSMyd9pOli5GLQ0hgB6PE+e7FQA4HB6+AoMTfHcIgNcIC7hI7
        py9mB7GFBJQkzv64wg4R15Vo6l7NAmKzCWhLvF8wiRVkjohAC7PE7AuTwIYyCyxmlGhbeZQJ
        YhuvxIz2pywQtrTE9uVbGUFsTgE7iR1z3rJDxEUlbq5GsN8fm88IYYtItN47ywxhC0o8+Lmb
        EWbOn+PP2SDscqA5+6HsConf/cug5uhLXOmfyQTxmK/EtG57kDCLgKrEztdfoUpcJFb9gTiH
        WUBeYvvbOcwg5cwCmhLrd+lDlChK7Pw9F6qET+Ld1x5WmK92zHsC9aGaRMuzr1BxGYm//56x
        goyREPCQmPU8ExLMrYwSZx5NYJnAqDALEdKzkCyehbB4ASPzKkax1ILi3PTUYsMCQ3jkJufn
        bmIEp10t0x2ME99+0DvEyMTBeIhRgoNZSYT3+8THyUK8KYmVValF+fFFpTmpxYcYTYFensgs
        JZqcD0z8eSXxhiaWBiZmRiYWxpbGZkrivOK2J5OFBNITS1KzU1MLUotg+pg4OKUamHTesont
        bf2mw+ew486ebYt4Ba9Gyht7/Sv/ucbw+q3F02V7z4W7SX74+SrgmqHw9otJKnGrBUv9EhKO
        XPy4foewwb5Ln6fsDJwg5dAharDl4GwZscLNN5zKV3s9mdEgvG6vw62SWFc+hW8y77rnLcrx
        rgtWiVtfdcbm2Q6hpC9Fn6Rq5sdP6bD0C7ibzfIyTbA+oOyTi2W9jMNFTc6M1apZhe7iot/O
        6e/ySLp49kfYpqfRntqPlkgUOtiqnE75d/T8nFWrf7WKV2TWHQhesHmHX3ay1uUtk7kOyy1Z
        bXXbL/FWE29lQdmpp3/Or+aKm51i3/r/N8M2vT2Xagv7+leE1VssSFkl7s1z5aPzHiWW4oxE
        Qy3mouJEAFI7DFlEBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742
References: <20230210045608.23274-1-jaewon31.kim@samsung.com>
        <CGME20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Using order 4 pages would be helpful for IOMMUs mapping, but trying to get order 4 pages could spend quite much time in the page allocation.
>From the perspective of responsiveness, the deterministic memory allocation speed, I think, is quite important.
>
>The order 4 allocation with __GFP_RECLAIM may spend much time in reclaim and compation logic. __GFP_NORETRY also may affect. These cause unpredictable delay.
>
>To get reasonable allocation speed from dma-buf system heap, use HIGH_ORDER_GFP for order 4 to avoid reclaim. And let me remove meaningless __GFP_COMP for order 0.
>
>According to my tests, order 4 with MID_ORDER_GFP could get more number of order 4 pages but the elapsed times could be very slow.
>
>         time	order 8	order 4	order 0
>     584 usec	0	160	0
>  28,428 usec	0	160	0
> 100,701 usec	0	160	0
>  76,645 usec	0	160	0
>  25,522 usec	0	160	0
>  38,798 usec	0	160	0
>  89,012 usec	0	160	0
>  23,015 usec	0	160	0
>  73,360 usec	0	160	0
>  76,953 usec	0	160	0
>  31,492 usec	0	160	0
>  75,889 usec	0	160	0
>  84,551 usec	0	160	0
>  84,352 usec	0	160	0
>  57,103 usec	0	160	0
>  93,452 usec	0	160	0
>
>If HIGH_ORDER_GFP is used for order 4, the number of order 4 could be decreased but the elapsed time results were quite stable and fast enough.
>
>         time	order 8	order 4	order 0
>   1,356 usec	0	155	80
>   1,901 usec	0	11	2384
>   1,912 usec	0	0	2560
>   1,911 usec	0	0	2560
>   1,884 usec	0	0	2560
>   1,577 usec	0	0	2560
>   1,366 usec	0	0	2560
>   1,711 usec	0	0	2560
>   1,635 usec	0	28	2112
>     544 usec	10	0	0
>     633 usec	2	128	0
>     848 usec	0	160	0
>     729 usec	0	160	0
>   1,000 usec	0	160	0
>   1,358 usec	0	160	0
>   2,638 usec	0	31	2064
>
>Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>---
> drivers/dma-buf/heaps/system_heap.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>index e8bd10e60998..920db302a273 100644
>--- a/drivers/dma-buf/heaps/system_heap.c
>+++ b/drivers/dma-buf/heaps/system_heap.c
>@@ -41,12 +41,11 @@ struct dma_heap_attachment {
> 	bool mapped;
> };
> 
>-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP) -#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
>+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
> #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
> 				| __GFP_COMP)
>-static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
>+static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, 
>+LOW_ORDER_GFP};
> /*
>  * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
>  * to match with the sizes often found in IOMMUs. Using order 4 pages instead
>--
>2.17.1
>
>

added John Stultz <jstultz@google.com>
