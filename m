Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B26D8B72
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjDFAIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjDFAIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:08:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D091FEF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:08:44 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230406000842epoutp028a65ddf621b5236709d5f5594df8a928~TL994qCON0491404914epoutp02B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230406000842epoutp028a65ddf621b5236709d5f5594df8a928~TL994qCON0491404914epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680739722;
        bh=8k7PlH4IJrjrbrCt4UQXS/m0OguQm5n+Kiw9jP/iwcw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hFuYJg+rOJz3w1aB+DfSwVQcjDAaeHd58EHoWTWgaqcS6BXFnpSfvzx2gcXRRZxQG
         vdNO1vGOpYySHkPywhc3HnuXae2Lc07mIw+wEec2j1imNI77KKO7OLc0kQdIouSsOx
         yTS6mKfFveFTf/hP9+1xb1MNTnZObNU40idjvBpY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230406000842epcas1p4ffc02f2d004c8d1125f86728228a5782~TL99b6TT80884508845epcas1p4C;
        Thu,  6 Apr 2023 00:08:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.240]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PsMKj6Sgmz4x9Q9; Thu,  6 Apr
        2023 00:08:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.A1.12562.98D0E246; Thu,  6 Apr 2023 09:08:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230406000841epcas1p3630010a770682be0f1d540a448f3e00e~TL98hodn-2574525745epcas1p3Y;
        Thu,  6 Apr 2023 00:08:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230406000841epsmtrp28cd6566f5b7f9b67c32d6b0f72a42d2b~TL98gIMsW3272832728epsmtrp21;
        Thu,  6 Apr 2023 00:08:41 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-64-642e0d8993da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.70.18071.98D0E246; Thu,  6 Apr 2023 09:08:41 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230406000841epsmtip1d77c7a359e79d0505277dec2bd3079b4~TL98S6B_s0994509945epsmtip1G;
        Thu,  6 Apr 2023 00:08:41 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting single
 allocations to half of all memory
Date:   Thu,  6 Apr 2023 09:08:54 +0900
Message-Id: <20230406000854.25764-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmvm4nr16KwdnZxhZz1q9hs1j48C6z
        xepNvhbdm2cyWvS+f8Vk8efERjaLy7vmsFncW/Of1eL1t2XMFqfufma3eLf+C5sDt8fhN++Z
        PfZ+W8DisXPWXXaPBZtKPTat6mTz2PRpErvHnWt72DxOzPjN4tG3ZRWjx+dNcgFcUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMzZ/OstU
        cJavomHdB+YGxvk8XYycHBICJhLHPx9j72Lk4hAS2MEocfzkXVYI5xOjxL0TFxghnG+MElMu
        bmWEablw/h0LRGIvo8SWQ31sEM53RolD8xuZQKrYBLQl3i+YBDZLRGAxo8SbG1+YQRLMAqUS
        b9+cALOFBQokGtZMBRvLIqAq8bn9NpDNwcErYCsx9bURxDZ5idUbDjCDzJEQ+MouseziCagz
        XCQ+Ll8NZQtLvDq+hR3ClpL4/G4vG4SdL3Hh4ismkJkSAjUSCycaQoTtJXZ9ncEKEmYW0JRY
        v0sfIqwosfP3XEaIK/kk3n3tYYXo5JXoaBOCKFGTaHn2lRXClpH4++8ZlO0h8enkXrDPhQRi
        JXqmvWKdwCg7C2HBAkbGVYxiqQXFuempxYYFRvBISs7P3cQIToRaZjsYJ739oHeIkYmD8RCj
        BAezkgivapdWihBvSmJlVWpRfnxRaU5q8SFGU2BoTWSWEk3OB6bivJJ4QxNLAxMzIxMLY0tj
        MyVx3i9PtVOEBNITS1KzU1MLUotg+pg4OKUamLL0flzW+bZv6o55Rrmr3S8WsKzZJXXj4JS5
        PwSyVEsD8qR+yz+RFqh/NEfBwuvJ/zNdxTOE3k2KrRS03zvz6AwBXd9z147FGK87v/hI7z6O
        BdIvHmszL2SyzE76tuN04oMDd13lvrt5New8q7/+S7+K27Fp4m4T3RX7JW1U+iKdXvnwfv61
        M4jrq0hUm7FUn/kNngRO2X72HRIbc7kOLFJ9F/q2k0lJ9fqWqt0RsiuvVMyLmzPbyIXlMRPz
        1TsPpMwmBGRdC10sMyFi8eKYqvoWr3lfO0uvsdRZHOF1v2HE1NH/bfqaPlbjnNYPX9Nqf4ow
        tZj+ii6I0Tm0j1Gn8qDakfXcbwTbLLTe2szYpsRSnJFoqMVcVJwIALMkzGINBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnG4nr16KwfcJPBZz1q9hs1j48C6z
        xepNvhbdm2cyWvS+f8Vk8efERjaLy7vmsFncW/Of1eL1t2XMFqfufma3eLf+C5sDt8fhN++Z
        PfZ+W8DisXPWXXaPBZtKPTat6mTz2PRpErvHnWt72DxOzPjN4tG3ZRWjx+dNcgFcUVw2Kak5
        mWWpRfp2CVwZmz+dZSo4y1fRsO4DcwPjfJ4uRk4OCQETiQvn37F0MXJxCAnsZpRYd385G0RC
        RuLN+adACQ4gW1ji8OFiiJqvjBI7pu9gBKlhE9CWeL9gEitIQkRgNaPEh+d7wBLMApUS/27f
        YgWxhQXyJJb+m8kOYrMIqEp8br/NCDKUV8BWYuprI4hd8hKrNxxgnsDIs4CRYRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnBoamnuYNy+6oPeIUYmDsZDjBIczEoivKpdWilCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MBUd+Rh0tFTAXEX/
        yo63fYKZB5JmvDCxu7incPHyLx9dN31YczGD5b6W+PqXx45HbpkdKFOq0H7QucDH6PzBUFnv
        rktpYZe1/9c9LHq85VHifvfKgOrTytpLWKZ/5zLe+erFfM3KYrH03qlbXznNyva52OC0pu62
        o8FUHq+/fG1B/M9shG7e97nGuvvKzyOHIxjW3NMVbnsZ1XTIybaVl0tg+rmGC2qBT58u3eho
        XflKz/BKbKTU78diVddU7SOLHi+rZVk45WHvqtLAeeWPdF6+amJyuKr+xq3r1a7Xq3PbPiix
        +OV0H7l9f/vP7jfOGh31HRyXbW59uj79k/GCF9fn263fttOM7dXch8mzmayVWIozEg21mIuK
        EwHfxar0vAIAAA==
X-CMS-MailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcas1p3.samsung.com>
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

An OoM panic was reported, there were only native processes which are
non-killable as OOM_SCORE_ADJ_MIN.

After looking into the dump, I've found the dma-buf system heap was
trying to allocate a huge size. It seems to be a signed negative value.

dma_heap_ioctl_allocate(inline)
    |  heap_allocation = 0xFFFFFFC02247BD38 -> (
    |    len = 0xFFFFFFFFE7225100,

Actually the old ion system heap had policy which does not allow that
huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
bugs in system heap"). We need this change again. Single allocation
should not be bigger than half of all memory.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index e8bd10e60998..4c1ef2ecfb0f 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
+	if (len / PAGE_SIZE > totalram_pages() / 2)
+		return ERR_PTR(-ENOMEM);
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
-- 
2.17.1

