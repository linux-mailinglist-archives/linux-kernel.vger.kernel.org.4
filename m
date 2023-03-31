Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9639B6D1462
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCaAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCaAvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:51:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B53AB4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:51:43 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230331005141epoutp04fa9170ba69a24fc134692b54ce91c553~RWrxypsSV2778827788epoutp04t
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:51:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230331005141epoutp04fa9170ba69a24fc134692b54ce91c553~RWrxypsSV2778827788epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680223901;
        bh=++9h+hux5dj0mvUjn9H5RCZIuCzOaxaV1K4NBQKN4QU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uLljRyCwuLgfMLR1xt/GYJuZWK/LAeZLJB0X/gFOz+nmuvcTru1f7kVQBYh0yKgFc
         vb+iFvj15a0I6fs7tLwRnsCqCATTv644QCrBzm3JQm2Em0/WvJ89tRcousGvops4sa
         VhYT0N0U2fJda/tJY/L5+FZglZGzFjvxLMStW41c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230331005140epcas1p16878f71a3152362c735b70791637e14e~RWrxRKPGL1129111291epcas1p1h;
        Fri, 31 Mar 2023 00:51:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PnhZ432xGz4x9Pw; Fri, 31 Mar
        2023 00:51:40 +0000 (GMT)
X-AuditID: b6c32a38-bbd3aa8000029402-28-64262e9c13b5
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.78.37890.C9E26246; Fri, 31 Mar 2023 09:51:40 +0900 (KST)
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
In-Reply-To: <CABdmKX1urNvWihM=9WVAwxMsR_Tp_HU1RkX66WJ+iry_LB8yHg@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230331005140epcms1p1ac5241f02f645e9dbc29626309a53b24@epcms1p1>
Date:   Fri, 31 Mar 2023 09:51:40 +0900
X-CMS-MailID: 20230331005140epcms1p1ac5241f02f645e9dbc29626309a53b24
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmnu4cPbUUg/3PhS3mrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wWr78tY7Y4dfczu8W79V/YHHg8
        Dr95z+yx99sCFo+ds+6yeyzYVOqxaVUnm8emT5PYPe5c28PmcWLGbxaPvi2rGD0+b5IL4IrK
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulpJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ1x
        smE1U8Fzk4r5DSfZGxg3anUxcnJICJhIfPjVztjFyMUhJLCDUeLe4Ub2LkYODl4BQYm/O4RB
        TGGBbImFrSkg5UICShJnf1xhB7GFBXQlmrpXs4DYbALaEu8XTGIFsUUENCWuPd/MAjKSWeAs
        s8TqpT+YIHbxSsxof8oCYUtLbF++lRHE5hQIlJh49gIjRFxU4ubqt+ww9vtj86HiIhKt984y
        Q9iCEg9+7maEmfPn+HM2CLtYYlnnA6hdNRIrzq2CiptLNLxdCWbzCvhKTGyfCXYoi4CqxLSt
        y6HucZFYePUg2HxmAXmJ7W/nMIP8zgz0zPpd+hAlihI7f89lhHmlYeNvdnQ2swCfxLuvPaww
        8R3znkCdoybR8uwrVFxG4u+/Z6wTGJVmIQJ6FpLFsxAWL2BkXsUollpQnJueWmxYYAKP2+T8
        3E2M4PSrZbGDce7bD3qHGJk4GA8xSnAwK4nwFhqrpgjxpiRWVqUW5ccXleakFh9iNAV6eSKz
        lGhyPjAD5JXEG5pYGpiYGZlYGFsamymJ84rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYPJP3sTQ
        OrunZaaD2u2FewQkogtZTvwIyj3DY8kdsd+yo9FSeMUno7x77xV6dl5YyMHxbNKXh8c3vy1b
        z3Lr9lphBy+L46r+LCUCv4/eY9o7w9v3+z3bHLOLsiXcbw4Ee66YpXiqmol3Uc4MRff7AfrT
        N1zrb5K/P//QRasz+a83WndyzU7KTmbasWJpXJom122ncx3dyXmz+/2LOaX2vLU78EZE9AX/
        AcUdv9tNOIX26rh1LOqsZbm6MWSJTuySgKb53CpaHd8nbr00re/3uRlMcVunCbxan3dj6p6q
        vavnPF8090TSn3jp1e45O9VU3j/9wMmhFtwftvz1FEcm/W51jV2TpykHZTne2SGySVyJpTgj
        0VCLuag4EQDuTByWSAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2
References: <CABdmKX1urNvWihM=9WVAwxMsR_Tp_HU1RkX66WJ+iry_LB8yHg@mail.gmail.com>
        <20230328125818.5574-1-jaewon31.kim@samsung.com>
        <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
        <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
        <CABdmKX3c+qK6ekhujkH9fo8bNagmd-M=a=ZWF3HOq1C0EzHs8g@mail.gmail.com>
        <20230330004117epcms1p7cab95489135a39bf511f6b2cf958e41e@epcms1p7>
        <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p1>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Mar 29, 2023 at 5:41?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>
>> >On Tue, Mar 28, 2023 at 8:13?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>> >>
>> >> >On Tue, Mar 28, 2023 at 5:58?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>> >> >>
>> >> >> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>> >> >>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>> >> >>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>> >> >>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>> >> >>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>> >> >>   free_cma:200844kB
>> >> >> Out of memory and no killable processes...
>> >> >> Kernel panic - not syncing: System is deadlocked on memory
>> >> >>
>> >> >> An OoM panic was reported, there were only native processes which are
>> >> >> non-killable as OOM_SCORE_ADJ_MIN.
>> >> >>
>> >> >> After looking into the dump, I've found the dma-buf system heap was
>> >> >> trying to allocate a huge size. It seems to be a signed negative value.
>> >> >>
>> >> >> dma_heap_ioctl_allocate(inline)
>> >> >>     |  heap_allocation = 0xFFFFFFC02247BD38 -> (
>> >> >>     |    len = 0xFFFFFFFFE7225100,
>> >> >>
>> >> >> Actually the old ion system heap had policy which does not allow that
>> >> >> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
>> >> >> bugs in system heap"). We need this change again. Single allocation
>> >> >> should not be bigger than half of all memory.
>> >> >>
>> >> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> >> >> ---
>> >> >>  drivers/dma-buf/heaps/system_heap.c | 3 +++
>> >> >>  1 file changed, 3 insertions(+)
>> >> >>
>> >> >> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>> >> >> index e8bd10e60998..4c1ef2ecfb0f 100644
>> >> >> --- a/drivers/dma-buf/heaps/system_heap.c
>> >> >> +++ b/drivers/dma-buf/heaps/system_heap.c
>> >> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>> >> >>         struct page *page, *tmp_page;
>> >> >>         int i, ret = -ENOMEM;
>> >> >>
>> >> >> +       if (len / PAGE_SIZE > totalram_pages() / 2)
>> >> >> +               return ERR_PTR(-ENOMEM);
>> >> >> +
>> >> >
>> >> >Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
>> >> >heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
>> >> >the allocation request?
>> >>
>> >> Hello T.J.
>> >>
>> >> Thank you for your opinion.
>> >> The __GFP_RETRY_MAYFAIL on LOW_ORDER_GFP seems to work.
>> >>
>> >> page allocation failure: order:0, mode:0x144dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO)
>> >> Node 0 active_anon:120kB inactive_anon:43012kB active_file:36kB inactive_file:788kB
>> >>
>> >> I tried to test it, and the allocation stopped at very low file cache situation without OoM panic
>> >> as we expected. The phone device was freezing for few seconds though.
>> >>
>> >> We can avoid OoM panic through either totalram_pages() / 2 check or __GFP_RETRY_MAYFAIL.
>> >>
>> >> But I think we still need the totalram_pages() / 2 check so that we don't have to suffer
>> >> the freezing in UX perspective. We may kill some critical processes or users' recent apps.
>> >>
>> >> Regarding __GFP_RETRY_MAYFAIL, I think it will help us avoid OoM panic. But I'm worried
>> >> about low memory devices which still need OoM kill to get memory like in camera scenarios.
>> >>
>> >> So what do you think?
>> >>
>> >Hey Jaewon, thanks for checking! The totalram_pages() / 2 just feels
>> >somewhat arbitrary. On the lowest memory devices I'm aware of that use
>> >the system heap it would take a single buffer on the order of several
>> >hundred megabytes to exceed that, so I guess the simple check is fine
>> >here until someone says they just can't live without a buffer that
>> >big!
>> >
>> >Reviewed-by: T.J. Mercier <tjmercier@google.com>
>>
>> Hello T.J.
>>
>> Thank you for your Reviewed-by.
>>
>> I also think the totalram_pages() / 2 doesn't look perfect, but I think
>> we need it.
>>
>> By the way I'm a little confused on a single buffer. Please help me to be clear.
>> Do you mean we may need to reconsider the totalram_pages() / 2 some day,
>> if camera may request a huge memory for a single camera buffer? Then I hope
>> the device has also huge total memory to support that high quality camera.
>>
>Right, it's only a problem if a very low memory device wants a very
>large buffer. IDK why anyone would want to do that.
>
>> And if possible, could you give your idea about __GFP_RETRY_MAYFAIL regarding
>> what I said? I think OoM kill doesn't seem to occur that often thanks to LMKD kill.
>> And I also want to avoid OoM panic, so I'd like to apply it.
>
>Yeah even with the totalram_pages() / 2 check, a process could trigger
>the panic by consuming all available memory by allocating multiple
>buffers. (As long as that allocating process doesn't get oom killed
>first, and it allocates faster than LMKD can kill it.) So to prevent
>users of the system heap from crashing the system, I think it's still
>worth adding __GFP_RETRY_MAYFAIL.
>

Correct, I exactly think like you. I'd love to apply __GFP_RETRY_MAYFAIL
to this system heap in memory management perspective. But I think we are
not ready to apply because of that oom-kill-needed situations. Let me just
apply totalram_pages() / 2 this time. And I hope we have chance to discuss
this __GFP_RETRY_MAYFAIL some day later. I'm going to keep thinking about
it with monitoring this situations.

>> But what if there is a situation which still need OoM kill to get memory. I just
>> thought policy of __GFP_RETRY_MAYFAIL could be changed to allow OoM kill but return
>> NULL when there was a victim process.
>
>I'm not sure exactly what you mean here, but it might be nice to have
>a way to allow oom kills but not panics if a victim can't be found
>(and then fail the allocation request). Looks like that'd be possible
>by changing alloc_pages to conditionally set oom_control->order = -1
>for some new GFP flag, but not sure if that's worth it. As you
>mentioned, that'd be a super slow allocation. So I don't think that's
>a state we'd really want to be operating in.
>

Oh sorry I missed 'not', let me correct like 'when there was NOT a victim
process.' Anyway you already got what I meant. And I found the code
is_sysrq_oom regarding oom_control->order = -1. Yes it could be possible,
but as you said, I think we don't really want that so far. We need to think
more.

It was great discussion, I've apprecited it.

>> Thank you
>> Jaewon Kim
