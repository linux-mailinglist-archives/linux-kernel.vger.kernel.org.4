Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D36917CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBJE5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjBJE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:57:02 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BB1B556
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:56:55 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230210045652epoutp01181caa4ff5b3e8b94c3b3f578f2871c6~CXa3mDdMy0220902209epoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:56:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230210045652epoutp01181caa4ff5b3e8b94c3b3f578f2871c6~CXa3mDdMy0220902209epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676005012;
        bh=Cn1KuYc/mahYf9SbC/oia3n2YKJAJcamRSiHkL5dW2o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rf5/KHfiG7a3Facxj47GgvCyAjeBLzM8ZzRfwROq2nGX+jNBV7W8tHB1KZ5s+qoo5
         5DH2UeBD38ATwvdQ7EhbD7AwyTuUlwNz/ks9LK5gC0KUgDi2G3vxK650zxQcx3ZLOd
         YXPaJd1rULeKjtA4YNACCpslPkhnWhWVQyY8ZxJw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230210045651epcas1p2469593e100856b8a770911ba862b96e7~CXa21NQ2A1103911039epcas1p28;
        Fri, 10 Feb 2023 04:56:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PChKb6Nkhz4x9Pr; Fri, 10 Feb
        2023 04:56:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.19.52037.39EC5E36; Fri, 10 Feb 2023 13:56:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742~CXa2FbIoo1938319383epcas1p1v;
        Fri, 10 Feb 2023 04:56:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230210045651epsmtrp29de923bce4b2a647162de8d9bf11ebfd~CXa2EgFaT3117131171epsmtrp2Q;
        Fri, 10 Feb 2023 04:56:51 +0000 (GMT)
X-AuditID: b6c32a37-55fff7000001cb45-65-63e5ce93fbca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.83.17995.39EC5E36; Fri, 10 Feb 2023 13:56:51 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230210045651epsmtip2437b3564d0f4a1195cc19c0e35980726~CXa17OKrr2907929079epsmtip2H;
        Fri, 10 Feb 2023 04:56:51 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     john.stultz@linaro.org, tjmercier@google.com,
        sumit.semwal@linaro.org, daniel.vetter@ffwll.ch,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] dma-buf: system_heap: avoid reclaim for order 4
Date:   Fri, 10 Feb 2023 13:56:08 +0900
Message-Id: <20230210045608.23274-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvu7kc0+TDQ40GVnMWb+GzWLhw7vM
        Fqs3+Vp0b57JaNH7/hWTxZnfuhaXd81hs7i35j+rxetvy5gtTt39zG7xbv0XNgduj8Nv3jN7
        7P22gMVj56y77B4LNpV6bFrVyeax6dMkdo871/aweZyY8ZvFo2/LKkaPz5vkAriism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnPLh4gaXg
        vWjFnJaLzA2MDwW6GDk5JARMJHY/m8YGYgsJ7GCU+N4Y18XIBWR/YpSY8/EbK4TzmVGi+9Qk
        ZpiO3k3vmSESuxglDrfOg3K+M0pcnfGSHaSKTUBb4v2CSWDtIgLLGSU+Pl0I1s4sUCrx9s0J
        MFtYwFniy70vYMtZBFQlJjc/YwWxeQVsJY4c+MUCsU5eYvWGA2AbJAS+skvcXnOFFSLhIjF7
        yT42CFtY4tXxLewQtpTE53d7oeLlEo2Xp0HdXSHRu+UQVK+xRG/PBaA4B9BBmhLrd+lDhBUl
        dv6eywhxJ5/Eu689rCAlEgK8Eh1tQhAlahItz75CTZGR+PvvGVSJh8Ss55mQYIyVmH/mAdsE
        RtlZCPMXMDKuYhRLLSjOTU8tNiwwhkdScn7uJkZwGtQy38E47e0HvUOMTByMhxglOJiVRHi/
        T3ycLMSbklhZlVqUH19UmpNafIjRFBhcE5mlRJPzgYk4ryTe0MTSwMTMyMTC2NLYTEmcV9z2
        ZLKQQHpiSWp2ampBahFMHxMHp1QDk6vM5TNHux9a9NbGcu95VXBp2u6e741szjb3bkg9Ypq3
        qE20JXnblIt/exj/Lnj7+v4/g9SJPFIB6kenn+wSmrr+zsJjt2+KHn0+ebrgO57fNs0zW6ML
        JVavnmUdMrNYrV1Y5Gt2Q47bYZXcRNX5sSLThOSyNjM6GWwIuP1CSidmrVTU4rzZHGx5ExSt
        IrikPc+rb3aL6XM80NQcpO/746M7U+nrQEGL5xarSxddaJmxyt2V4fbUp0oif5de0RNXmaP5
        R2brzkkPjRjfHguf83XOs27FTO5zFRHbX+SfsU+ymFquoLPpIu/tzqK6BRuWB168m76Bzaqq
        wHbSrBm/e1azaS8tO633xe1pZdzuICWW4oxEQy3mouJEAC/hl6QMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO7kc0+TDT59Y7WYs34Nm8XCh3eZ
        LVZv8rXo3jyT0aL3/SsmizO/dS0u75rDZnFvzX9Wi9ffljFbnLr7md3i3fovbA7cHoffvGf2
        2PttAYvHzll32T0WbCr12LSqk81j06dJ7B53ru1h8zgx4zeLR9+WVYwenzfJBXBFcdmkpOZk
        lqUW6dslcGU8uHiBpeC9aMWclovMDYwPBboYOTkkBEwkeje9Z+5i5OIQEtjBKHFnz2kmiISM
        xJvzT1m6GDmAbGGJw4eLIWq+Mkp0HrnGAlLDJqAt8X7BJFaQhIjAekaJvvfbwBLMApUS/27f
        YgWxhQWcJb7c+8IGYrMIqEpMbn4GFucVsJU4cuAXC8QyeYnVGw4wT2DkWcDIsIpRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzg0tbR2MO5Z9UHvECMTB+MhRgkOZiUR3u8THycL8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwCRnUeBrFi0ktKrp
        b9rzuMtp5ae/e9qasNsn2V5ZMvNnUYTNomU1tS2rY3bMviXwfEXyNP9Gn6jyn5YbHi746zeB
        d+bvbR8fvvxR9Er4k9ZsIbbjVqmTC4/f+b7454TQ20YsXud4HPit4lcfDWCffPHc2+R9Ulde
        cJ7pm7byz54N+/75nuhjkfv82ipGdm/jbBnX8FDj6jPBlhpnGp39a0/5zA67NafobNVm1U33
        etpSrol+3m1TsWMa200dluO3fx3gPK6VUMrVtjDn+y61xfkTDp5ma5MTZu978ZDDXEbaQJph
        j9Udo6NzBPRcVLSnqbwPvLe4aNVa++9KF57tjMx5+9nw0WzlnyVvRC5qPzZRYinOSDTUYi4q
        TgQAHrcN+7wCAAA=
X-CMS-MailID: 20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742
References: <CGME20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using order 4 pages would be helpful for IOMMUs mapping, but trying to
get order 4 pages could spend quite much time in the page allocation.
From the perspective of responsiveness, the deterministic memory
allocation speed, I think, is quite important.

The order 4 allocation with __GFP_RECLAIM may spend much time in
reclaim and compation logic. __GFP_NORETRY also may affect. These cause
unpredictable delay.

To get reasonable allocation speed from dma-buf system heap, use
HIGH_ORDER_GFP for order 4 to avoid reclaim. And let me remove
meaningless __GFP_COMP for order 0.

According to my tests, order 4 with MID_ORDER_GFP could get more number
of order 4 pages but the elapsed times could be very slow.

         time	order 8	order 4	order 0
     584 usec	0	160	0
  28,428 usec	0	160	0
 100,701 usec	0	160	0
  76,645 usec	0	160	0
  25,522 usec	0	160	0
  38,798 usec	0	160	0
  89,012 usec	0	160	0
  23,015 usec	0	160	0
  73,360 usec	0	160	0
  76,953 usec	0	160	0
  31,492 usec	0	160	0
  75,889 usec	0	160	0
  84,551 usec	0	160	0
  84,352 usec	0	160	0
  57,103 usec	0	160	0
  93,452 usec	0	160	0

If HIGH_ORDER_GFP is used for order 4, the number of order 4 could be
decreased but the elapsed time results were quite stable and fast
enough.

         time	order 8	order 4	order 0
   1,356 usec	0	155	80
   1,901 usec	0	11	2384
   1,912 usec	0	0	2560
   1,911 usec	0	0	2560
   1,884 usec	0	0	2560
   1,577 usec	0	0	2560
   1,366 usec	0	0	2560
   1,711 usec	0	0	2560
   1,635 usec	0	28	2112
     544 usec	10	0	0
     633 usec	2	128	0
     848 usec	0	160	0
     729 usec	0	160	0
   1,000 usec	0	160	0
   1,358 usec	0	160	0
   2,638 usec	0	31	2064

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/dma-buf/heaps/system_heap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index e8bd10e60998..920db302a273 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -41,12 +41,11 @@ struct dma_heap_attachment {
 	bool mapped;
 };
 
-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
-#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
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

