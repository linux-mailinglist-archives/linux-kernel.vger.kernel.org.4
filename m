Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5C6CBFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjC1M7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjC1M7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:59:02 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55F83D9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:58:31 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230328125809epoutp020166817da598b9a2d74140ddf9627b2f~QlqNcYF5n1849518495epoutp02i
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:58:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230328125809epoutp020166817da598b9a2d74140ddf9627b2f~QlqNcYF5n1849518495epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680008289;
        bh=HkVnsEsit8vSqDASCKERyun6JcpeV7Jnd+sztwLt5Nw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=V4r/FLao0bnp+m2iIRv+rIwUzBAYF2uy6xF4NrlzwuVD2k7rmnAWPd9YUBauAxRSo
         qk5m/BfcfKglNtI2H9Vr/UDnTyKxAtI2FNg8L1d5rbdTMReAaW0rwAKIMiS0zi032c
         vIGCqzCakCden6edIj1cp7TW0tV4TdFppDLtX6yQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230328125808epcas1p360bc6e1548ef73d84c39de77691a7eee~QlqMoABju2570825708epcas1p3X;
        Tue, 28 Mar 2023 12:58:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pm8qh11tWz4x9Pr; Tue, 28 Mar
        2023 12:58:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.3F.55531.F54E2246; Tue, 28 Mar 2023 21:58:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2~QlqLR0RpG1527015270epcas1p19;
        Tue, 28 Mar 2023 12:58:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230328125807epsmtrp1e744afd182741b0873f0e91e05a39ae6~QlqLQ7I3x0441504415epsmtrp1j;
        Tue, 28 Mar 2023 12:58:07 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-3c-6422e45fab58
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.84.31821.E54E2246; Tue, 28 Mar 2023 21:58:06 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230328125806epsmtip26d7100341c2fb50ee98ac5f6a8f263d0~QlqLF2HcF0775707757epsmtip2D;
        Tue, 28 Mar 2023 12:58:06 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow and
 list bugs in system heap:
Date:   Tue, 28 Mar 2023 21:58:18 +0900
Message-Id: <20230328125818.5574-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmrm78E6UUg9kPbSzmrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orJtMlIT
        U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVlIoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/ScOcVa
        8J63YsvJK8wNjKe5uxg5OSQETCRWLVrN1MXIxSEksINRYsaGc2wQzidGic8H/kE5nxklTt1/
        wQjT8mfCThaIxC5GiebNrVDOd0aJ1llnwarYBLQl3i+YxAqSEBFYzCjx5sYXZpAEs0CpxNs3
        J8BsYYF0iVPNF9hBbBYBVYmuoxeAJnFw8ArYSPx8GwOxTV5i9YYDzCBzJAS+skvsmrSfDSLh
        InGvYS0rhC0s8er4FnYIW0riZX8blJ0vceHiKyaQmRICNRILJxpChO0ldn2dwQoSZhbQlFi/
        Sx8irCix8/dcRogr+STefe1hhejklehoE4IoUZNoefYVaqmMxN9/z6BsD4nZ186DlQsJxEo0
        PxSawCg7C2H+AkbGVYxiqQXFuempxYYFhvA4Ss7P3cQIToNapjsYJ779oHeIkYmD8RCjBAez
        kgjv72tKKUK8KYmVValF+fFFpTmpxYcYTYGBNZFZSjQ5H5iI80riDU0sDUzMjEwsjC2NzZTE
        ecVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MFUfeLX8Wnpg5aM4rsdTUxZf/OS9flrtijPF2t+4
        rkZcEH3o5PFx64QT34rt6p1TWgMXuJUl975ft0rl0R0BY73wTqN91+efmfl45b0WBaa5EXIe
        nhef8pv9fKxxxjtrx/5/RQa/39toiDK+e6ecd0anyq5+xZ/2WQrXWmKPdZ+1EBJbbnsnokmB
        I/3/xjbbrIJ3vxPWNXyxNtCYuazMWDjvTBJHxO4ln58fuh/fON178rYvB48HH0/QuNarJCSn
        s26qY+aWdQsyJA08lq49n2bQfdj3uFfPBrY3KVV3iy9um5gQHpa3pCNhXb66e2b7Tc465VmK
        iq3+C7RvzDPu9qxZ92t/8qFgoUPLIxl6lyqxFGckGmoxFxUnAgClbfYfDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvG7cE6UUg67V1hZz1q9hs1j48C6z
        xepNvhbdm2cyWvS+f8Vk8efERjaLy7vmsFncW/Of1eL1t2XMFqfufma3eLf+C5sDt8fhN++Z
        PfZ+W8DisXPWXXaPBZtKPTat6mTz2PRpErvHnWt72DxOzPjN4tG3ZRWjx+dNcgFcUVw2Kak5
        mWWpRfp2CVwZPWdOsRa8563YcvIKcwPjae4uRk4OCQETiT8TdrKA2EICOxgldiwVhYjLSLw5
        /xQozgFkC0scPlzcxcgFVPKVUeLnrVtg9WwC2hLvF0xiBUmICKxmlPjwfA8jSIJZoFLi3+1b
        rCC2sECqxOVXs5hAbBYBVYmuoxfAhvIK2Ej8fBsDsUteYvWGA8wTGHkWMDKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIDkwtrR2Me1Z90DvEyMTBeIhRgoNZSYT39zWlFCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYtFnr0ru2Ln27NeGZ
        RM+7V40fdy9sZTk+6+3pbwymwrsnTCjVObXWbdOKWZ9+fNRa+reo7v+7OQZPbAWu9vbMmqq4
        kXdd6tOk1/VJf5y+M39bsb5afE211L1st/lxJ+xO7jy3ucvjN/83vSnzS+++lbZa4jS5Yf6s
        U7Mc7Phl3bv3h69T9lsdnS14j1Wvj0nzxwILFvGvdt3/r3o+eer1PLLPprWMZbXZFLETvzra
        khuvfXi3P3hB6GkHe5V1mbJOd7f0nKyfoDDtSPDdaTVBeiZFstcb+WNNLr43WTvJR2bhwiL5
        d37daVZ/OzMOV+t/81k6/zNL0G2HOXW/j2zewpR0qfDAhatRIQaad4SO6yqxFGckGmoxFxUn
        AgDeHSEWuwIAAA==
X-CMS-MailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
References: <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcas1p1.samsung.com>
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

