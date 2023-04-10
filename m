Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8526DC3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDJHdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDJHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:33:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A74681
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 00:33:09 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230410073305epoutp0265331e9a3402d8b00ccaca6e3b4461be~UgnG6yaXK0452104521epoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230410073305epoutp0265331e9a3402d8b00ccaca6e3b4461be~UgnG6yaXK0452104521epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681111985;
        bh=rsovILUPhHbLtudYoqSFmxIi68SG8tpj2BrJCHGqcIo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X4K6lcN/ThscWXzHQHEgA9rR1MaSlyLT8OPbyCX0+oSnDqftrsRN3QI+5zScQKgQ5
         Mn07rzGNqDkMqjVEr1l4uYjKylZnPWiTKJNCOTG+BwOxPTDjJRnbDU7eoWrwY4jvNb
         Ja45GZeHTcXWrqMlrv7bK8oxJTLDyFQ2nE1LqQ8E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230410073305epcas1p1dbe8fad5b60877dd55eec55de5fe16b7~UgnGT_QVk1604316043epcas1p1B;
        Mon, 10 Apr 2023 07:33:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pw10c66DJz4x9Q1; Mon, 10 Apr
        2023 07:33:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.89.09668.0BBB3346; Mon, 10 Apr 2023 16:33:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7~UgnFoBuv30391403914epcas1p4K;
        Mon, 10 Apr 2023 07:33:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230410073304epsmtrp22cd48a4a910597eaa22087d210333409~UgnFm9uQK2134621346epsmtrp2I;
        Mon, 10 Apr 2023 07:33:04 +0000 (GMT)
X-AuditID: b6c32a36-b27fa700000025c4-04-6433bbb04d35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.2F.08279.0BBB3346; Mon, 10 Apr 2023 16:33:04 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230410073304epsmtip299d48e8026f4ea3095fdf54964a1c621~UgnFX_4kM1803118031epsmtip23;
        Mon, 10 Apr 2023 07:33:04 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Date:   Mon, 10 Apr 2023 16:32:28 +0900
Message-Id: <20230410073228.23043-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmge6G3cYpBjN36lvMWb+GzWLhw7vM
        Fqs3+Vp0b57JaNH7/hWTxZ8TG9ksLu+aw2Zxb81/VovX35YxW5y6+5nd4t36L2wO3B6H37xn
        9tj7bQGLx85Zd9k9Fmwq9di0qpPNY9OnSewed67tYfM4MeM3i0ffllWMHp83yQVwRWXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdrKRQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzni98Bh7
        wUThigOXZ7E2MP7h72Lk5JAQMJGYtfM7excjF4eQwA5GiUsT57BAOJ8YJY5dfsUM4XxjlFh7
        4z+QwwHWcvWENUR8L6PEjemvoYq+M0q8vtfFCjKXTUBb4v2CSawgCRGBxYwSb258YQZJMAuU
        Srx9cwLMFhbwlFi0pJMRxGYRUJXY93QDE4jNK2ArcWDPSUaIA+UlVm84ALZBQuAru8TuORPY
        IRIuEhd2HWaCsIUlXh3fAhWXkvj8bi8bhJ0vceHiKyaIs2skFk40hAjbS+z6OoMVJMwsoCmx
        fpc+RFhRYufvuYwQZ/JJvPvawwrRySvR0SYEUaIm0fLsKyuELSPx998zKNtD4v7TA2DHCAnE
        Sty89oJlAqPsLIQFCxgZVzGKpRYU56anFhsWGMEjKTk/dxMjOBFqme1gnPT2g94hRiYOxkOM
        EhzMSiK8NtwGKUK8KYmVValF+fFFpTmpxYcYTYHBNZFZSjQ5H5iK80riDU0sDUzMjEwsjC2N
        zZTEeb881U4REkhPLEnNTk0tSC2C6WPi4JRqYLLbzWr8L3elM7NTDrfE6T3tfkELwm1P39Fl
        y1Nlkb1Xo7e78tBC6fhiJ7Eu/xXL4wK8f1yay+NbJqmlWZLB3fFmxiItybZjGcvC9ijvEmLa
        qR31N9/54KrfR0pb4jM26u3s1F/FrNnBGbfX8MnXRc3Htf/8NitLn/jvIdOeon2cy3zMEzWF
        Z/qaP+/qFPBPqHmWvivronPWv1usTRV7WFfc/1W+/3vu3g/dYi0Tqg8+nLX0wImZWbGzpQ+G
        3G3fqPq8PumShsxO9Yt3fj07PufirbMlO1/z8kx1jvrhqFZYcnbzqRTZ+icX9h7/cuKcluM8
        pYioM9/vq15df2d/dvte098v3rf+9Fnz5UVqxnclluKMREMt5qLiRADpzcMgDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO6G3cYpBl8WiFnMWb+GzWLhw7vM
        Fqs3+Vp0b57JaNH7/hWTxZ8TG9ksLu+aw2Zxb81/VovX35YxW5y6+5nd4t36L2wO3B6H37xn
        9tj7bQGLx85Zd9k9Fmwq9di0qpPNY9OnSewed67tYfM4MeM3i0ffllWMHp83yQVwRXHZpKTm
        ZJalFunbJXBlvF54jL1gonDFgcuzWBsY//B3MXJwSAiYSFw9Yd3FyMkhJLCbUeLU6jgQW0JA
        RuLN+acsECXCEocPF3cxcgGVfGWU2Nt8kwWkhk1AW+L9gkmsIAkRgdWMEh+e72EESTALVEr8
        u32LFcQWFvCUWLSkEyzOIqAqse/pBiYQm1fAVuLAnpOMEMvkJVZvOMA8gZFnASPDKkbJ1ILi
        3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MDU0tzBuH3VB71DjEwcjIcYJTiYlUR4bbgNUoR4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgms3av7DKIvLW
        R3M3ha23Qy8pPg3hXr346w2PX+KbBFXUvSRXvkgUzHK6Z2Iit/xikuGJzvbj9g7q07gDF7F4
        OCnXT/l+7K7i8yaWxA27ovc1fZfZUD4pnr/ui+rZqckeqxiiZZqPv36ydG6cVszKHysYv72V
        vFFpXzrZTEFm5YWnzyOuFTe9uuNuwGl0xfH3YsnpxcUuWn9+3o3zUXhjIZN5WGZlAN/8Qr4H
        jF1P1895/lGuQVVL4cQTf4cZ7nzlkRxCYZ/kD8erx96a8rreIP6w8PrH8yeqrk05//bKk+iC
        lV+kDqmqb114wtC/8nkKt7/5InutL/K2Lfc7fjw79Gf/011MbqyX0pS27772WYmlOCPRUIu5
        qDgRAE6zmym7AgAA
X-CMS-MailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normal free:212600kB min:7664kB low:57100kB high:106536kB
  reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
  active_file:1200kB inactive_file:0kB unevictable:2932kB
  writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
  pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
  free_cma:200844kB
Out of memory and no killable processes...
Kernel panic - not syncing: System is deadlocked on memory

An OoM panic was reported. The log shows there were only native
processes which are non-killable as OOM_SCORE_ADJ_MIN. After looking
into the dump, I've found the dma-buf system heap was trying to allocate
a huge size. It seems to be a signed negative value.

dma_heap_ioctl_allocate(inline)
    |  heap_allocation = 0xFFFFFFC02247BD38 -> (
    |    len = 0xFFFFFFFFE7225100,

To avoid this invalid request, check if the requested size is bigger
than system total memory. Actually the old ion system heap had similar
policy with commit c9e8440eca61 ("staging: ion: Fix overflow and list
bugs in system heap").

Even with this sanity check, there is still risk of too much allocations
from the system_heap. Allocating multiple big size buffers may cause
oom. Add __GFP_RETRY_MAYFAIL. With this gfp, the allocation may fail,
but we can avoid oom panic.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 920db302a273..583da8948679 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -41,7 +41,7 @@ struct dma_heap_attachment {
 	bool mapped;
 };
 
-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_RETRY_MAYFAIL)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
@@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
+	if (len / PAGE_SIZE > totalram_pages())
+		return ERR_PTR(-ENOMEM);
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
-- 
2.17.1

