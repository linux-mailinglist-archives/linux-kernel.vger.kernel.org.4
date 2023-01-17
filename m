Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD04B66D81E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjAQIZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjAQIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:25:25 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D030028877
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:25:23 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230117082522epoutp04e3b430851980023181a96a4d79debc70~7CyDe7yy91131511315epoutp04c
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:25:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230117082522epoutp04e3b430851980023181a96a4d79debc70~7CyDe7yy91131511315epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673943922;
        bh=8NAQJBZpr5N/v+b0k3lefIIF8pKLozgny3VDnBKSN3E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WLWLceJJne/xaDrIO6VRxWUYp2k0BY7+Y7QaMkOlIrFPhyhy2AJU49avimv5FWdCc
         08WKltCuIsnmVwxByUMQZ2nmB14dt1IeQor5cfwO6GzH6kYwmQOuumny0rXCEO0kRi
         deYgPfo3t2cPFfPBtOY0uLoyZchS0evRwwR4DfN4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230117082521epcas1p4b6ed10bf4e8b211c80f512fc2dfce74e~7CyDBzAc00969309693epcas1p49;
        Tue, 17 Jan 2023 08:25:21 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nx25F57N3z4x9Py; Tue, 17 Jan
        2023 08:25:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.E4.19973.17B56C36; Tue, 17 Jan 2023 17:25:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117082521epcas1p22a709521a9e6d2346d06ac220786560d~7CyCnJgtd1754817548epcas1p2F;
        Tue, 17 Jan 2023 08:25:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230117082521epsmtrp1fdb2f962ef9dbf01c6c4b84c45052f13~7CyCmV1v62182621826epsmtrp1h;
        Tue, 17 Jan 2023 08:25:21 +0000 (GMT)
X-AuditID: b6c32a35-21ffd70000014e05-cc-63c65b7186fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.90.02211.17B56C36; Tue, 17 Jan 2023 17:25:21 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230117082521epsmtip170e7972f03d43bb85bc10272625ef386~7CyCaUakw1543715437epsmtip1G;
        Tue, 17 Jan 2023 08:25:21 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     john.stultz@linaro.org, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Date:   Tue, 17 Jan 2023 17:25:08 +0900
Message-Id: <20230117082508.8953-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvm5h9LFkg+83NSzmrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4sxvXYvLu+awWdxb85/V4vW3ZcwWp+5+Znfg8jj85j2zx95vC1g8
        ds66y+6xaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IzKtslITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulNJoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ2xausmloKJ3BUPvnxhbmBc
        wdnFyMkhIWAicWBhA2sXIxeHkMAORom7b49AOZ8YJT7e+8sE4XxjlPgy+zAjTMvC/9+hqvYy
        SrxZ/wqq6gejxPQ/u1lAqtgEtCXeL5gEViUi0M8o8eLLNiaQBLNAqcTbNyeYQWxhAQeJKZ9P
        AxVxcLAIqEp0PigFCfMK2Ehc2rOAFWKbvMTqDQeYQeZICNxjl+javZoNIuEisXLlBWYIW1ji
        1fEt7BC2lMTL/jYou1yi8fI0qJoKid4th6CGGkv09oD0cgDdoymxfpc+RFhRYufvuYwQZ/JJ
        vPvaA3aahACvREebEESJmkTLs69QU2Qk/v57BmV7SDSvaQJ7XUggVmL/43NsExhlZyEsWMDI
        uIpRLLWgODc9tdiwwBAeS8n5uZsYwWlPy3QH48S3H/QOMTJxMB5ilOBgVhLh9dt1OFmINyWx
        siq1KD++qDQntfgQoykwuCYyS4km5wMTb15JvKGJpYGJmZGJhbGlsZmSOK9NxLpkIYH0xJLU
        7NTUgtQimD4mDk6pBqbCTxu/1zs8f3u6ycj28568n7cb5po4XxDemB7R46m/Yb4Cr7Ta2t7p
        2irZD2b4OOsujyq9t/uli1ugUI3vyu3GvpJ5Ma8/7/9bEfW2lfPjP88F7mf6D8nK1e2/Gb/Z
        ptL906N3RYYX8y5NmGF59WRcisauV39lds20/honNOvCRsFtCX9MQjv9Lr2YfqDk9ZZJkoVl
        Zjmr1U9oOC94by6h3bhDs7/uw78gyyOszqdLFsi5d71k3Zn2+YdZhQwL69TlySaiOzKWLgqX
        DvXWMz/1a4ZUEsMewZl+3OyuRp0WetdvlN3WPlX97e6HpX9CVQ9M3Xb8WVhOhQa35Ozb9sFX
        GVZvTE65sX//d2E+nq9KLMUZiYZazEXFiQDrJPt+BAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnG5h9LFkg43zhC3mrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4sxvXYvLu+awWdxb85/V4vW3ZcwWp+5+Znfg8jj85j2zx95vC1g8
        ds66y+6xaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IzisklJzcksSy3St0vgyli1
        dRNLwUTuigdfvjA3MK7g7GLk5JAQMJFY+P87axcjF4eQwG5GiY4/LSwQCRmJN+efAtkcQLaw
        xOHDxRA13xgl3j74yAhSwyagLfF+wSSwZhGB6YwSf2atYgVJMAtUSvy7fQvMFhZwkJjy+TQr
        yCAWAVWJzgelIGFeARuJS3sWsELskpdYveEA8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNz
        i0vz0vWS83M3MYLDUEtzB+P2VR/0DjEycTAeYpTgYFYS4fXbdThZiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiavhbn/5i5QvM73LkfN233y2lQhvpTX
        2XFOFxXKpwbf1wqa7sb49t6jhomfDgn7q65Icv7y9W217HHHQg3dFpvEOa228yJ3/Yu7Kmx+
        gWOTzYknbKWrewW+irzZFbfu8dvzTOl/6oI3u1av8crcJSxXZCP8UJNpketjV6NzQauc7jIY
        rFs5LWvW1SyDnXU+fCxZ/0IS/ba42BiEK6foS0lO+d5SpL1JOExv++3ieWx19i9ePpvplPJo
        rr4C58YFX6Y2sB2TO7dxqqLoXRVTuT8a+RrHbpUVRtZ/mf8x+VjL9jkBiyzsVNPCBAw2+Fqo
        Cgi+ONmv5TePKy/A4eGJh4+Odwo8/3R51ib5JQX6UkosxRmJhlrMRcWJAANtHBeyAgAA
X-CMS-MailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using order 4 pages would be helpful for many IOMMUs, but it could spend
quite much time in page allocation perspective.

The order 4 allocation with __GFP_RECLAIM may spend much time in
reclaim and compation logic. __GFP_NORETRY also may affect. These cause
unpredictable delay.

To get reasonable allocation speed from dma-buf system heap, use
HIGH_ORDER_GFP for order 4 to avoid reclaim.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index e8bd10e60998..5a405e99ef1e 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -42,11 +42,10 @@ struct dma_heap_attachment {
 };
 
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
-#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
 /*
  * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
  * to match with the sizes often found in IOMMUs. Using order 4 pages instead
-- 
2.17.1

