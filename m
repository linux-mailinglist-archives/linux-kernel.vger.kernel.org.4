Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9D868D0A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBGHdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBGHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:33:44 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7395144B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:33:40 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230207073337epoutp03293604aba138637d6f6078c7809d5889~Ben3IIRM80326303263epoutp032
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:33:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230207073337epoutp03293604aba138637d6f6078c7809d5889~Ben3IIRM80326303263epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675755217;
        bh=xZb1v10+hGcQ8VtxPnebcTT8l6wHo+v7TXUob9js49o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=CS2+5W6RAGhbQoWr/JVqqyBIqMsBi89HkTv6IOezyndvjnLt4xVMPSs0dn6DQBjhp
         jd6B/hBNldSUTJnpS3NgeUuTBTh8D3Raq4C5kHHnH1gzV8R3z457Sd95a0kZK2kcS3
         0x2BKeH6gQ18exJ3z+i42ZWgj+MlJl67p6i7H0Ts=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230207073336epcas1p444f31586b9d1004f22230d861ccfb401~Ben2eeXxg1726817268epcas1p4J;
        Tue,  7 Feb 2023 07:33:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.226]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4P9vxq66gtz4x9Q2; Tue,  7 Feb
        2023 07:33:35 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-8a-63e1fecfb32d
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.0E.55531.FCEF1E36; Tue,  7 Feb 2023 16:33:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE: (2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     John Stultz <jstultz@google.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANDhNCrAMVT3rg0GPJhYKD75EAUn8bsivrp3yMJcsd6bouj1rQ@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230207073335epcms1p15df191db83bec0cb791e6f79dcecb31f@epcms1p1>
Date:   Tue, 07 Feb 2023 16:33:35 +0900
X-CMS-MailID: 20230207073335epcms1p15df191db83bec0cb791e6f79dcecb31f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmnu75fw+TDR6c07WYs34Nm8XCh3eZ
        LVZv8rXo3jyT0aL3/Ssmiz8nNrJZXN41h83i3pr/rBavvy1jtjh19zO7xbv1X9gcuD0Ov3nP
        7LH32wIWj52z7rJ7LNhU6rFpVSebx6ZPk9g97lzbw+ZxYsZvFo++LasYPT5vkgvgisq2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6WEmhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnfFz/SmW
        grWeFRO2TWVsYJyj3cXIySEhYCKxZ14zSxcjF4eQwA5GiRfLPwI5HBy8AoISf3cIg9QIC3hI
        HPiygBXEFhJQkjj74wo7RFxXoql7NQuIzSagLfF+wSSwGhEBb4mF/x4wgcxkFjjJLHHlxQtm
        iGW8EjPan7JA2NIS25dvZQSxOQUCJc7/ncsIEReVuLn6LTuM/f7YfKi4iETrvbNQcwQlHvzc
        zQgz58/x52wQdrnEjjn7oewKid/9y6Dm6Etc6Z/JBGLzCvhKdDTfA7NZBFQl/v/dA3WPi8Sd
        iefB4swC8hLb385hBoUDs4CmxPpd+hAlihI7f0OcySzAJ/Huaw8rzFs75j1hgrDVJFqefYWK
        y0j8/fcMyvaQaF7TxAIJw91sEhc3SExgVJiFCOlZSBbPQli8gJF5FaNYakFxbnpqsWGBITxy
        k/NzNzGCE6+W6Q7GiW8/6B1iZOJgPMQowcGsJMJreuBBshBvSmJlVWpRfnxRaU5q8SFGU6CX
        JzJLiSbnA1N/Xkm8oYmlgYmZkYmFsaWxmZI4r7jtyWQhgfTEktTs1NSC1CKYPiYOTqkGpiBr
        pqnKrX/2ckY3CyQu9fwmLBxeqZr8l3/LtpSOfX8SVTXdEhIu2JfwCn17xWL95+Q/n25v6ePN
        Gk9a5VNOP2kPcZuv0C5vvTW5paXxlMxWtc2mcuLrN3Bu8tzwOqRRQMVLRKM/52jRL5lP356z
        Lv7s+sPh3cw/N1u95ye8cRVM0toXyfe10lX194EKLYU11XMEeTMLTNc9veqbl7JjTUhB/LV1
        q09cPtH/af6y+Zx+ClkMyg2+PeeaZtjt2z2beamdN0NX19ek2Yb2Z9tXXdlic+vSI9lTG1kO
        xZ8WerHYnSet+9H9NnlmFqcr3xXW6jeLvtnxXe4E40eJzlJlmZYku7mzDTL7FN6LRSopsRRn
        JBpqMRcVJwIAK8a7Z0UEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CANDhNCrAMVT3rg0GPJhYKD75EAUn8bsivrp3yMJcsd6bouj1rQ@mail.gmail.com>
        <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
        <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
        <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
        <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
        <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com>
        <20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa@epcms1p8>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>
> 
>
>--------- Original Message ---------
>
>Sender : John Stultz <jstultz@google.com>
>
>Date : 2023-02-07 13:37 (GMT+9)
>
>Title : Re: (2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
>
> 
>
>On Sat, Feb 4, 2023 at 7:02 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> Hello John Stultz, sorry for late reply.
>
>> I had to manage other urgent things and this test also took some time to finish.
>
>> Any I hope you to be happy with following my test results.
>
>>
>
>>
>
>> 1. system heap modification
>
>>
>
>> To avoid effect of allocation from the pool, all the freed dma
>
>> buffer were passed to buddy without keeping them in the pool.
>
>> Some trace_printk and order counting logic were added.
>
>>
>
>> 2. the test tool
>
>>
>
>> To test the dma-buf system heap allocation speed, I prepared
>
>> a userspace test program which requests a specified size to a heap.
>
>> With the program, I tried to request 16 times of 10 MB size and
>
>> added 1 sleep between each request. Each memory was not freed
>
>> until the total 16 times total memory was allocated.
>
>
>
>Oof. I really appreciate all your effort that I'm sure went in to
>
>generate these numbers, but  this wasn't quite what I was asking for.
>
>I know you've been focused on allocation performance under memory
>
>pressure, but I was hoping to see the impact of __using__ order 0
>
>pages over order 4 pages in real world conditions (for camera or video
>
>recording or other use cases that use large allocations). These
>
>results seem to be still just focused on the difference in allocation
>
>performance between order 0 and order 4 with and without contention.
>
>
>
>That said, re-reading my email, I probably could have been more clear
>
>on this aspect.
>
>
>
>
>
>> 3. the test device
>
>>
>
>> The test device has arm64 CPU cores and v5.15 based kernel.
>
>> To get stable results, the CPU clock was fixed not to be changed
>
>> in run time, and the test tool was set to some specific CPU cores
>
>> running in the same CPU clock.
>
>>
>
>> 4. test results
>
>>
>
>> As we expected if order 4 exist in the buddy, the order 8, 4, 0
>
>> allocation was 1 to 4 times faster than the order 8, 0, 0. But
>
>> the order 8, 0, 0 also looks fast enough.
>
>>
>
>> Here's time diff, and number of each order.
>
>>
>
>> order 8, 4, 0 in the enough order 4 case
>
>>
>
>>          diff   8       4       0
>
>>      665 usec   0       160     0
>
>>    1,148 usec   0       160     0
>
>>    1,089 usec   0       160     0
>
>>    1,154 usec   0       160     0
>
>>    1,264 usec   0       160     0
>
>>    1,414 usec   0       160     0
>
>>      873 usec   0       160     0
>
>>    1,148 usec   0       160     0
>
>>    1,158 usec   0       160     0
>
>>    1,139 usec   0       160     0
>
>>    1,169 usec   0       160     0
>
>>    1,174 usec   0       160     0
>
>>    1,210 usec   0       160     0
>
>>      995 usec   0       160     0
>
>>    1,151 usec   0       160     0
>
>>      977 usec   0       160     0
>
>>
>
>> order 8, 0, 0 in the enough order 4 case
>
>>
>
>>          diff   8       4       0
>
>>      441 usec   10      0       0
>
>>      747 usec   10      0       0
>
>>    2,330 usec   2       0       2048
>
>>    2,469 usec   0       0       2560
>
>>    2,518 usec   0       0       2560
>
>>    1,176 usec   0       0       2560
>
>>    1,487 usec   0       0       2560
>
>>    1,402 usec   0       0       2560
>
>>    1,449 usec   0       0       2560
>
>>    1,330 usec   0       0       2560
>
>>    1,089 usec   0       0       2560
>
>>    1,481 usec   0       0       2560
>
>>    1,326 usec   0       0       2560
>
>>    3,057 usec   0       0       2560
>
>>    2,758 usec   0       0       2560
>
>>    3,271 usec   0       0       2560
>
>>
>
>> From the perspective of responsiveness, the deterministic
>
>> memory allocation speed, I think, is quite important. So I
>
>> tested other case where the free memory are not enough.
>
>>
>
>> On this test, I ran the 16 times allocation sets twice
>
>> consecutively. Then it showed the first set order 8, 4, 0
>
>> became very slow and varied, but the second set became
>
>> faster because of the already created the high order.
>
>>
>
>> order 8, 4, 0 in low memory
>
>>
>
>>          diff   8       4       0
>
>>      584 usec   0       160     0
>
>>   28,428 usec   0       160     0
>
>>  100,701 usec   0       160     0
>
>>   76,645 usec   0       160     0
>
>>   25,522 usec   0       160     0
>
>>   38,798 usec   0       160     0
>
>>   89,012 usec   0       160     0
>
>>   23,015 usec   0       160     0
>
>>   73,360 usec   0       160     0
>
>>   76,953 usec   0       160     0
>
>>   31,492 usec   0       160     0
>
>>   75,889 usec   0       160     0
>
>>   84,551 usec   0       160     0
>
>>   84,352 usec   0       160     0
>
>>   57,103 usec   0       160     0
>
>>   93,452 usec   0       160     0
>
>>
>
>>          diff   8       4       0
>
>>      808 usec   10      0       0
>
>>      778 usec   4       96      0
>
>>      829 usec   0       160     0
>
>>      700 usec   0       160     0
>
>>      937 usec   0       160     0
>
>>      651 usec   0       160     0
>
>>      636 usec   0       160     0
>
>>      811 usec   0       160     0
>
>>      622 usec   0       160     0
>
>>      674 usec   0       160     0
>
>>      677 usec   0       160     0
>
>>      738 usec   0       160     0
>
>>    1,130 usec   0       160     0
>
>>      677 usec   0       160     0
>
>>      553 usec   0       160     0
>
>>    1,048 usec   0       160     0
>
>>
>
>>
>
>> order 8, 0, 0 in low memory
>
>>
>
>>         diff    8       4       0
>
>>   1,699 usec    2       0       2048
>
>>   2,082 usec    0       0       2560
>
>>     840 usec    0       0       2560
>
>>     875 usec    0       0       2560
>
>>     845 usec    0       0       2560
>
>>   1,706 usec    0       0       2560
>
>>     967 usec    0       0       2560
>
>>   1,000 usec    0       0       2560
>
>>   1,905 usec    0       0       2560
>
>>   2,451 usec    0       0       2560
>
>>   3,384 usec    0       0       2560
>
>>   2,397 usec    0       0       2560
>
>>   3,171 usec    0       0       2560
>
>>   2,376 usec    0       0       2560
>
>>   3,347 usec    0       0       2560
>
>>   2,554 usec    0       0       2560
>
>>
>
>>        diff     8       4       0
>
>>  1,409 usec     2       0       2048
>
>>  1,438 usec     0       0       2560
>
>>  1,035 usec     0       0       2560
>
>>  1,108 usec     0       0       2560
>
>>    825 usec     0       0       2560
>
>>    927 usec     0       0       2560
>
>>  1,931 usec     0       0       2560
>
>>  2,024 usec     0       0       2560
>
>>  1,884 usec     0       0       2560
>
>>  1,769 usec     0       0       2560
>
>>  2,136 usec     0       0       2560
>
>>  1,738 usec     0       0       2560
>
>>  1,328 usec     0       0       2560
>
>>  1,438 usec     0       0       2560
>
>>  1,972 usec     0       0       2560
>
>>  2,963 usec     0       0       2560
>
>
>
>So, thank you for generating all of this. I think this all looks as
>
>expected, showing the benefit of your change to allocation under
>
>contention and showing the potential downside in the non-contention
>
>case.
>
>
>
>I still worry about the performance impact outside of allocation time
>
>of using the smaller order pages (via map and unmap through iommu to
>
>devices, etc), so it would still be nice to have some confidence this
>
>won't introduce other regressions, but I do agree the worse case
>
>impact is very bad.
>
>
>
>> Finally if we change order 4 to use HIGH_ORDER_GFP,
>
>> I expect that we could avoid the very slow cases.
>
>>
>
>
>
>Yeah. Again, this all aligns with the upside of your changes, which
>
>I'm eager for.
>
>I just want to have a strong sense of any regressions it might also cause.
>
>
>
>I don't mean to discourage you, especially after all the effort here.
>
>Do you think evaluating the before and after impact to buffer usage
>
>(not just allocation) would be doable in the near term?
>

Hello sorry but I don't have expertise on iommu. Actually I'm also wondering
all IOMMU can use order 4 free pages, if they are allocated. I am not sure
but I remember I heard order 9 (2MB) could be used, but I don't know about order 8 4.

I guess IOMMU mmap also be same patern like we expect. I mean if order 4 is
prepared it could be faster like 1 to 4 times. But it, I think, should NOT be
that much slow even though the entire free memory is prepared as order 0 pages.

>
>
>If you don't think so, given the benefit to allocation under pressure
>
>is large (and I don't mean to give you hurdles to jump), I'm willing
>
>to ack your change to get it merged, but if we later see performance
>
>trouble, I'll be quick to advocate for reverting it.  Is that ok?
>

Yes sure. I also want to know if it is.
Thank you

>
>
>thanks
>
>-john
>
>
