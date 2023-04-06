Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330D6D8CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjDFBo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjDFBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:44:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB883CE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:44:22 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230406014420epoutp01955e8de19fcd3b6a0348997b335046ac~TNRdhkWLY0914509145epoutp01R
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:44:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230406014420epoutp01955e8de19fcd3b6a0348997b335046ac~TNRdhkWLY0914509145epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680745460;
        bh=qZFeenoZbfGPR/OPIHqYvDFEdzYQ1bBGy2vJuSOpMn8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=N9q4WXFCHRnDfAB6CZ+dafR/+ogFIqDG97WzCDQRSygL1oZdQaOvTlFvqDp2wHns3
         SBwc8VKYBDfcFMQzFjignlajBZJn9ux/ZQJ6g3hg33YRv4cnB3gt43FT25MECYa6Ks
         sAwanJg9+FYvb9YxF7YHn+V4DsJykDUEOC+3qy8Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230406014419epcas1p39e0e8ae9a1093cfffd9825551ea3b1e8~TNRc5RY_t1876618766epcas1p3v;
        Thu,  6 Apr 2023 01:44:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PsPS330tGz4x9Q6; Thu,  6 Apr
        2023 01:44:19 +0000 (GMT)
X-AuditID: b6c32a35-00ffd7000000d8eb-b0-642e23f3aa84
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.FD.55531.3F32E246; Thu,  6 Apr 2023 10:44:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
Date:   Thu, 06 Apr 2023 10:44:19 +0900
X-CMS-MailID: 20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmru5nZb0Ug5e7xCzmrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wWr78tY7Y4dfczu8W79V/YHHg8
        Dr95z+yx99sCFo+ds+6yeyzYVOqxaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IrK
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulpJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ2x
        ZNpS1oLTshVzv01lbGC8J97FyMkhIWAicXLpC+YuRi4OIYEdjBLXz21n62Lk4OAVEJT4u0MY
        xBQWKJGYvFsBpFxIQEni7I8r7CC2sICuRFP3ahYQm01AW+L9gkmsILYIUHzV811gI5kFDjJL
        nLw2mQliF6/EjPanLBC2tMT25VsZQWxOAW+Jz7Oms0HERSVurn7LDmO/PzafEcIWkWi9d5YZ
        whaUePBzNyPMnD/Hn0P1Fkss63wAtatGYsW5VVBxc4mGtyvBbF4BX4m2ZWvADmURUJXYvHkS
        1BwXiYmz1oH1MgvIS2x/O4cZ5HdmAU2J9bv0IUoUJXb+nssI80rDxt/s6GxmAT6Jd197WGHi
        O+Y9gTpHTaLl2VeouIzE33/PWCcwKs1CBPQsJItnISxewMi8ilEstaA4Nz212LDAEB63yfm5
        mxjB6VfLdAfjxLcf9A4xMnEwHmKU4GBWEuFV7dJKEeJNSaysSi3Kjy8qzUktPsRoCvTyRGYp
        0eR8YAbIK4k3NLE0MDEzMrEwtjQ2UxLn/fJUO0VIID2xJDU7NbUgtQimj4mDU6qB6VjPTYbz
        wQmi9ovrjmyu3d/1oKFCb6JZ06fQjTcP93Vd35jzz/bjorcdp/ad1POcViLNuuhQ0f1/Sbea
        BATvX9nUvlbslOPMb/M2PPe5mTxHZ9anc1abT69RYZQ48HOtz9x8/jwN5WNxOst4xI52nVK+
        af31yXTn3lt7Uy7a2M/e4flxMsuuXWHsr1nqDHpZOfdM2ilfzF8TdKrU6a6J2vosY3MFnqaF
        PzpnF22UjP9gbfFIpOtHxY3sW4+kT/hFWLw/I/+Yfyuj51utWf7sc56rv9N/3pV428HsqUFH
        5J5lm28d1OVImmpcMWnDtpvHFhxduWfVIucLa3/v/K9wl8N8FUf5waPtz/7euKY0c8dEJZbi
        jERDLeai4kQAmxZkXEgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230406000841epcas1p3630010a770682be0f1d540a448f3e00e
References: <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu,  6 Apr 2023 09:08:54 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>>   free_cma:200844kB
>> Out of memory and no killable processes...
>> Kernel panic - not syncing: System is deadlocked on memory
>> 
>> An OoM panic was reported, there were only native processes which are
>> non-killable as OOM_SCORE_ADJ_MIN.
>> 
>> After looking into the dump, I've found the dma-buf system heap was
>> trying to allocate a huge size. It seems to be a signed negative value.
>> 
>> dma_heap_ioctl_allocate(inline)
>>     |  heap_allocation = 0xFFFFFFC02247BD38 -> (
>>     |    len = 0xFFFFFFFFE7225100,
>> 
>> Actually the old ion system heap had policy which does not allow that
>> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
>> bugs in system heap"). We need this change again. Single allocation
>> should not be bigger than half of all memory.
>> 
>> ...
>>
>> --- a/drivers/dma-buf/heaps/system_heap.c
>> +++ b/drivers/dma-buf/heaps/system_heap.c
>> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>>  	struct page *page, *tmp_page;
>>  	int i, ret = -ENOMEM;
>>  
>> +	if (len / PAGE_SIZE > totalram_pages() / 2)
>> +		return ERR_PTR(-ENOMEM);
>> +
>
>This seems so random.  Why ram/2 rather than ram/3 or 17*ram/35?

Hello

Thank you for your comment.

I just took the change from the old ion driver code, and actually I thought the
half of all memory is unrealistic. It could be unwanted size like negative,
or too big size which incurs slowness or OoM panic.

>
>Better behavior would be to try to allocate what the caller asked
>for and if that doesn't work out, fail gracefully after freeing the
>partial allocations which have been performed thus far.  If dma_buf
>is changed to do this then that change is useful in many scenarios other
>than this crazy corner case.

I think you would like __GFP_RETRY_MAYFAIL. Actually T.J. Mercier recommended
earlier, here's what we discussed.
https://lore.kernel.org/linux-mm/20230331005140epcms1p1ac5241f02f645e9dbc29626309a53b24@epcms1p1/

I just worried about a case in which we need oom kill to get more memory but
let me change my mind. That case seems to be rare. I think now it's time when
we need to make a decision and not to allow oom kill for dma-buf system heap
allocations.

But I still want to block that huge size over ram. For an unavailabe size,
I think, we don't have to do memory reclaim or killing processes, and we can
avoid freezing screen in user perspecitve.

This is eventually what I want. Can we check totalram_pages and and apply
__GFP_RETRY_MAYFAIL?

--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -41,7 +41,7 @@ struct dma_heap_attachment {
        bool mapped;
 };
 
-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_RETRY_MAYFAIL)
 #define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
                                | __GFP_NORETRY) & ~__GFP_RECLAIM) \
@@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
        struct page *page, *tmp_page;
        int i, ret = -ENOMEM;
 
+       if (len / PAGE_SIZE > totalram_pages())
+               return ERR_PTR(-ENOMEM);
+

BR
Jaewon Kim
