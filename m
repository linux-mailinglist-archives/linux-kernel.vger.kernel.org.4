Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF76A9066
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCCFEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCFD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:03:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B309265BA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:03:55 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230303050351epoutp016f24613048bce25c14d286099e057fae~I0D9VV0no1362513625epoutp01b
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:03:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230303050351epoutp016f24613048bce25c14d286099e057fae~I0D9VV0no1362513625epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677819831;
        bh=PG+FVUDX3161x8uXoq6zC61Na4POwRccQbBdfYze8IM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WEZEAoTm2YwuoWPmOwWcYSnSotIFsDXANVkMsgmpVltAq9NVYOYZadQ7DPRfsGhWf
         6I0GySlJWeExePbW5VBI7EV3LU2A12zQx4k8ztgarLeoKjD++SU4U/IJNEt26iRCWq
         5IiueTwNpIr2xxMxk87WnDts3Te7IkFk91Hwwv/E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230303050350epcas1p4e61f63bd8fed30c9633213e6fe2f96da~I0D8rImcR0225602256epcas1p4W;
        Fri,  3 Mar 2023 05:03:50 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.248]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PSbTy5ypjz4x9Q8; Fri,  3 Mar
        2023 05:03:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.36.37890.6BF71046; Fri,  3 Mar 2023 14:03:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230303050350epcas1p1e2dc42f8ac677af9653ca7017a4b9225~I0D8ObJXi1154711547epcas1p1F;
        Fri,  3 Mar 2023 05:03:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230303050350epsmtrp1c713e37505a476b04be01b189392fb09~I0D8NDmOI2620326203epsmtrp1E;
        Fri,  3 Mar 2023 05:03:50 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-fd-64017fb650d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.9B.31821.6BF71046; Fri,  3 Mar 2023 14:03:50 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230303050350epsmtip13199ed373bbb6e825f2ae13cf16dc2c5~I0D8DOVXU3190631906epsmtip1c;
        Fri,  3 Mar 2023 05:03:50 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH v2] dma-buf: system_heap: avoid reclaim for order 4
Date:   Fri,  3 Mar 2023 14:03:32 +0900
Message-Id: <20230303050332.10138-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmge62esYUg43H9CzmrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orJtMlIT
        U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVlIoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0x495yx
        YJ5YxdePT9gaGLsFuxg5OSQETCQmn9/G2sXIxSEksINR4vWj1ywQzidGie5Hq9ggnM+MEn+O
        f2SHaWm9P5cJIrGLUeLOpcdQ/d+BWjbcZQGpYhPQlni/YBJYQkRgMaPEmxtfmEESzAKlEm/f
        nACzhQW8JHp2toLZLAKqEj9vXgNbwStgK7Hz7V5miHXyEqs3HGAGGSQh8JVd4tPu9ywQCReJ
        4w/nQd0kLPHq+BYoW0riZX8blF0u0Xh5GtSgConeLYdYIWxjid6eC0BxDqCDNCXW79KHCCtK
        7Pw9lxHiTj6Jd197WEFKJAR4JTrahCBK1CRann2FmiIj8fffMyjbQ+Lxy2awTUICsRJvl25j
        msAoOwthwQJGxlWMYqkFxbnpqcWGBSbwaErOz93ECE6GWhY7GOe+/aB3iJGJg/EQowQHs5II
        b3UDQ4oQb0piZVVqUX58UWlOavEhRlNgeE1klhJNzgem47ySeEMTSwMTMyMTC2NLYzMlcV5x
        25PJQgLpiSWp2ampBalFMH1MHJxSDUxaGv8mVKTucJ+XpdSxIELqwWKht3eWP264olp2J2be
        SQene8ez7ku3yu96fWj1ii6pO8t0Z874/z4tIfSkwhGbicu3LtA63CP+bcZDMbcz2QEyNsfT
        Zhza+Up1Df/D8909cVV/Dh2ZNfkA3w7XhmdGO+eczf2aMe/y9oeqcsya+19/bP5WG84ZanDo
        //rdPkb5ohU31m11rjrPGhrfqWDi7X614OADi+on/1R6vP7PulEec9/u/+4/1+s+OrSlBWf8
        /hh66tWqwm1uK6wakvvCHHt1f/9affjlPAu2A2WmQQqX4x2EO1WaGCYbCL24wvazxWDC3pmu
        L/g5pz/Yt/fNlp3vyzj/CL1U6pnUWFu/RYmlOCPRUIu5qDgRAONz78EPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnO62esYUg2XnRC3mrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orhsUlJz
        MstSi/TtErgyJrx7zlgwT6zi68cnbA2M3YJdjJwcEgImEq335zJ1MXJxCAnsYJSY2tbIApGQ
        kXhz/imQzQFkC0scPlwMUfOVUWLpwt3MIDVsAtoS7xdMYgVJiAisZpT48HwPI0iCWaBS4t/t
        W6wgtrCAl0TPzlawBhYBVYmfN6+xg9i8ArYSO9/uZYZYJi+xesMB5gmMPAsYGVYxSqYWFOem
        5xYbFhjlpZbrFSfmFpfmpesl5+duYgQHp5bWDsY9qz7oHWJk4mA8xCjBwawkwlvdwJAixJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5N/JDfPYo+Z+tav
        nx5scp7I9HOvUozQ8Qtihb/3ndnf1HclrGLZykPa5cntp9P3qPsrpOYeKr5VkHbgx79M36vP
        XoSWvoy8Jf7imEjZc3u1s3+Opsjti5jeM6vi379H0ybJz1r5dLvTLf2fMv8Uj6e0M2b/U7L6
        GnT12AwPRp9g9275XTd78jbtn3vSMDXObl2YSuUE9wmhRhtq2l/nrzls/2h1/eK/qcI7X59x
        u9f08nSIiPKZOdwWF3+8X7Hi5tQszrlMVSbL2JV9mbO+TJDyN1QSrFK7/vqNkfNyXV7JdVuX
        M75VrX1ycduLzsspd35y/ZHeIXRis+yxo3Z53Mn68xW//j3yY3nutp9JWUHxSizFGYmGWsxF
        xYkAiorPoL0CAAA=
X-CMS-MailID: 20230303050350epcas1p1e2dc42f8ac677af9653ca7017a4b9225
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230303050350epcas1p1e2dc42f8ac677af9653ca7017a4b9225
References: <CGME20230303050350epcas1p1e2dc42f8ac677af9653ca7017a4b9225@epcas1p1.samsung.com>
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
Reviewed-by: John Stultz <jstultz@google.com>
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

