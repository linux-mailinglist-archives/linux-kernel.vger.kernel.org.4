Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E16CF857
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjC3Ald (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjC3Alc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:41:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B346B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:41:25 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230330004119epoutp041f0271f2b42bd3b5094a7e858e600f61~RC5cs6e7S2648026480epoutp04A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230330004119epoutp041f0271f2b42bd3b5094a7e858e600f61~RC5cs6e7S2648026480epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680136879;
        bh=RUtkicc67FJwep28grxVHmhl15inVynfAE6+BQmnbGI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ihGuBvciKlzjWX6rAVsxhSEWR/2AMkxw5tlslBciIfRrrKX2jdAnmA5aw6oli2mdc
         Q25wsZ6v6StPU1ADOOxJO239n/uHytfps+/PUk2Eegk98EMqfjE1aK3jDx+7PFJmuU
         rmIhbrHaRqFvUZKDtuj3An3fna5FoJssCdjbO43I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230330004119epcas1p116a6478484e3dd7d429ce9b034ff56ec~RC5cGCOSo1053510535epcas1p1T;
        Thu, 30 Mar 2023 00:41:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pn4NZ5prxz4x9QP; Thu, 30 Mar
        2023 00:41:18 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-7c-6424daadaaf3
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.17.55531.DAAD4246; Thu, 30 Mar 2023 09:41:17 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
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
In-Reply-To: <CABdmKX3c+qK6ekhujkH9fo8bNagmd-M=a=ZWF3HOq1C0EzHs8g@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230330004117epcms1p7cab95489135a39bf511f6b2cf958e41e@epcms1p7>
Date:   Thu, 30 Mar 2023 09:41:17 +0900
X-CMS-MailID: 20230330004117epcms1p7cab95489135a39bf511f6b2cf958e41e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnu7aWyopBps26lvMWb+GzeLlIU2L
        hQ/vMlus3uRr0b15JqNF7/tXTBZ/Tmxks7i8aw6bxb01/1ktXn9bxmxx6u5ndot367+wOfB4
        HH7zntlj77cFLB47Z91l91iwqdRj06pONo9Nnyaxe9y5tofN48SM3ywefVtWMXp83iQXwBWV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLWSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
        wOFe5oJulYpdR5MbGGfIdjFyckgImEh8WXKLCcQWEtjBKLH0s2YXIwcHr4CgxN8dwiCmsEC2
        xMLWFIgKJYmzP66wg9jCAroSTd2rWUBsNgFtifcLJrGC2CICmhLXnm8GinNxMAucZZZYvfQH
        E8QqXokZ7U9ZIGxpie3LtzKCzOcUCJTo3uAPERaVuLn6LTuM/f7YfEYIW0Si9d5ZZghbUOLB
        z92MMGP+HH/OBmEXSyzrfAC1qkZixblVUHFziYa3K9kgvvKVWL+7HiTMIqAqMWHRdqhrXCT2
        /D0N1sosIC+x/e0cZpByZqBX1u/ShyhRlNj5ey4jzCMNG3+zo7OZBfgk3n3tYYWJ75j3BOoa
        NYmWZ1+h4jISf/89Y53AqDQLEcyzkCyehbB4ASPzKkax1ILi3PTUYsMCQ3i8JufnbmIEp10t
        0x2ME99+0DvEyMTBeIhRgoNZSYTX4pRKihBvSmJlVWpRfnxRaU5q8SFGU6CXJzJLiSbnAxN/
        Xkm8oYmlgYmZkYmFsaWxmZI4r7jtyWQhgfTEktTs1NSC1CKYPiYOTqkGpgNln/wiuffzHEvr
        vL3/x8olXktE3YqXPhd/eLhEseH73dAZzYuEez+/fLTLzYX1mPzLf1OtPjr6V03f5ep7vmz+
        se1v/0YaJJ2fyu37fX/Ut9qm+Z3Sq1WOLL6Svd2qfLet7afkOVO3Bbww3jrPV2v5hINzM/Rn
        8H1+mv3uXZzjzQlvLon++llhv1Lw1rdblgbzJH9sSX1nvjVI8XicmxTXFMNzpR9FykNsOZZl
        s01dvjQ47F30zM6Lf+e+O/29P7j/y40t9y6qzHvr1FWqtH9Jrv0VERGTkz51R3YLKPqx2qaJ
        lkb5zPz1LsfN50p9cOrTs2dcbZ/0bjp17/Gzh3P3eNzZuC2WV1XvfeOj+8tylViKMxINtZiL
        ihMBxbbPJ0QEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
References: <CABdmKX3c+qK6ekhujkH9fo8bNagmd-M=a=ZWF3HOq1C0EzHs8g@mail.gmail.com>
        <20230328125818.5574-1-jaewon31.kim@samsung.com>
        <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
        <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
        <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p7>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Mar 28, 2023 at 8:13?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>
>> >On Tue, Mar 28, 2023 at 5:58?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>> >>
>> >> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>> >>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>> >>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>> >>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>> >>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>> >>   free_cma:200844kB
>> >> Out of memory and no killable processes...
>> >> Kernel panic - not syncing: System is deadlocked on memory
>> >>
>> >> An OoM panic was reported, there were only native processes which are
>> >> non-killable as OOM_SCORE_ADJ_MIN.
>> >>
>> >> After looking into the dump, I've found the dma-buf system heap was
>> >> trying to allocate a huge size. It seems to be a signed negative value.
>> >>
>> >> dma_heap_ioctl_allocate(inline)
>> >>     |  heap_allocation = 0xFFFFFFC02247BD38 -> (
>> >>     |    len = 0xFFFFFFFFE7225100,
>> >>
>> >> Actually the old ion system heap had policy which does not allow that
>> >> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
>> >> bugs in system heap"). We need this change again. Single allocation
>> >> should not be bigger than half of all memory.
>> >>
>> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> >> ---
>> >>  drivers/dma-buf/heaps/system_heap.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>> >> index e8bd10e60998..4c1ef2ecfb0f 100644
>> >> --- a/drivers/dma-buf/heaps/system_heap.c
>> >> +++ b/drivers/dma-buf/heaps/system_heap.c
>> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>> >>         struct page *page, *tmp_page;
>> >>         int i, ret = -ENOMEM;
>> >>
>> >> +       if (len / PAGE_SIZE > totalram_pages() / 2)
>> >> +               return ERR_PTR(-ENOMEM);
>> >> +
>> >
>> >Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
>> >heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
>> >the allocation request?
>>
>> Hello T.J.
>>
>> Thank you for your opinion.
>> The __GFP_RETRY_MAYFAIL on LOW_ORDER_GFP seems to work.
>>
>> page allocation failure: order:0, mode:0x144dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO)
>> Node 0 active_anon:120kB inactive_anon:43012kB active_file:36kB inactive_file:788kB
>>
>> I tried to test it, and the allocation stopped at very low file cache situation without OoM panic
>> as we expected. The phone device was freezing for few seconds though.
>>
>> We can avoid OoM panic through either totalram_pages() / 2 check or __GFP_RETRY_MAYFAIL.
>>
>> But I think we still need the totalram_pages() / 2 check so that we don't have to suffer
>> the freezing in UX perspective. We may kill some critical processes or users' recent apps.
>>
>> Regarding __GFP_RETRY_MAYFAIL, I think it will help us avoid OoM panic. But I'm worried
>> about low memory devices which still need OoM kill to get memory like in camera scenarios.
>>
>> So what do you think?
>>
>Hey Jaewon, thanks for checking! The totalram_pages() / 2 just feels
>somewhat arbitrary. On the lowest memory devices I'm aware of that use
>the system heap it would take a single buffer on the order of several
>hundred megabytes to exceed that, so I guess the simple check is fine
>here until someone says they just can't live without a buffer that
>big!
>
>Reviewed-by: T.J. Mercier <tjmercier@google.com>

Hello T.J.

Thank you for your Reviewed-by.

I also think the totalram_pages() / 2 doesn't look perfect, but I think
we need it.

By the way I'm a little confused on a single buffer. Please help me to be clear.
Do you mean we may need to reconsider the totalram_pages() / 2 some day, 
if camera may request a huge memory for a single camera buffer? Then I hope
the device has also huge total memory to support that high quality camera.

And if possible, could you give your idea about __GFP_RETRY_MAYFAIL regarding
what I said? I think OoM kill doesn't seem to occur that often thanks to LMKD kill. 
And I also want to avoid OoM panic, so I'd like to apply it.
But what if there is a situation which still need OoM kill to get memory. I just
thought policy of __GFP_RETRY_MAYFAIL could be changed to allow OoM kill but return
NULL when there was a victim process.

Thank you
Jaewon Kim
