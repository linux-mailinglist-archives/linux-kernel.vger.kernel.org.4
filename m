Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F086E0315
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMAR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDMARZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:17:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF185FC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:17:09 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230413001700epoutp01809b2f7a1b23cd4434a38bf8ca5578ee~VVmNAG0BQ2447824478epoutp01f
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:17:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230413001700epoutp01809b2f7a1b23cd4434a38bf8ca5578ee~VVmNAG0BQ2447824478epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681345020;
        bh=k+Pg1Bzyv9BcpHloPgqL+/gsU6us6p6A3nKbyzyMGw4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=QuqURqSRXJfqgiPvUpGj8WX1U30ze6IHhRsC2Pp2K46FJzM+MFxigimJISYqgOGkg
         kP6w4+oDrGq0t+WM+zDR+2fe+FvV2RhnygNe3Kfrl1wmCKjvX45yknUIXsUsRz2pQa
         eTdmRTe0wfxg8jtnmyRZ09apAjki7cFi4zqAbW7k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230413001659epcas1p4b2d23c72038fa25851593c6d0fba38a1~VVmMZjzDJ2783227832epcas1p4M;
        Thu, 13 Apr 2023 00:16:59 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.222]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PxgB310Jqz4x9Q3; Thu, 13 Apr
        2023 00:16:59 +0000 (GMT)
X-AuditID: b6c32a39-5f1ff7000000247b-1d-643749fafc30
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.14.09339.AF947346; Thu, 13 Apr 2023 09:16:59 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] dma-buf/heaps: system_heap: avoid too much
 allocation
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     "T.J. Mercier" <tjmercier@google.com>
CC:     Michal Hocko <mhocko@suse.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CABdmKX2fA2nXaSb8k+LE1yeso=ZnboDtxhzmjzrS35GSKv73hQ@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230413001658epcms1p611d149fcbbbd06fc17387724f4f16359@epcms1p6>
Date:   Thu, 13 Apr 2023 09:16:58 +0900
X-CMS-MailID: 20230413001658epcms1p611d149fcbbbd06fc17387724f4f16359
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmge5vT/MUg83TmC3mrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wW9/scLE7d/cxu8W79FzYHHo/D
        b94ze+z9toDFY+esu+weCzaVemz6NInd4861PWweJ2b8ZvHo27KK0WP9lqssHp83yQVwRWXb
        ZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdraRQlphT
        ChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrhw
        fhlLwRTOivZH15kaGNezdzFyckgImEj8XHwbzBYS2MEo8XNJbRcjBwevgKDE3x3CIGFhAX+J
        fS/mMEKUKEmc/XGFHSKuK9HUvZoFxGYT0JZ4v2ASK4gtIqApce35ZqA4FwezwBFmieZJtxgh
        dvFKzGh/ygJhS0tsX74VLM4pEChx/lQnE0RcVOLm6rfsMPb7Y/OhekUkWu+dZYawBSUe/NzN
        CDPnz/HnbBB2scSyzgdQc2okVpxbBRU3l2h4uxLM5hXwleg/sx/sBhYBVYnTR9ZC7XKRmPFk
        IpjNLCAvsf3tHGZQODADPbN+lz5EiaLEzt9zGSFK+CTefe1hhXmrYeNvdmzsHfOeQJ2jJtHy
        7CtUvYzE33/PWCcwKs1ChPQsJItnISxewMi8ilEstaA4Nz212LDAFB63yfm5mxjByVfLcgfj
        9Lcf9A4xMnEwHmKU4GBWEuH94WKaIsSbklhZlVqUH19UmpNafIjRFOjlicxSosn5wPSfVxJv
        aGJpYGJmZGJhbGlspiTO++WpdoqQQHpiSWp2ampBahFMHxMHp1QDk8fysOLZm284Nbgwr9oa
        dnRT29HtCX/KLnt/K7Hzzbpv8pvR42P8QnGLN3aRf7t/y87OL7u/8LKdnMPu3zKtddufTtnF
        wHPJPvq024fd5Y+Dwh8yTDbicVnEmR3xIn+/ZIXGhAtymXcPhPjsFV8nlvo8Ic+YycRz9WFV
        9a41Ysm/C12uawpf/Rn/QWGL57uMiQf6DnsJ30pw+mOZtyVHutH1pUXfq023bTmF1+gLCVgk
        LL18lzvkUBvn1/UB19/oxtwocjl55hDzOtNDme9urGW0LDA323pg6eZ6VzaBiUWbdpwMdShb
        /Lj9wV6r249SmjmXy4o/z33sltxxapVarmz5eRVGvZ5ts5b8+3HAW4mlOCPRUIu5qDgRAN6i
        mppHBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <CABdmKX2fA2nXaSb8k+LE1yeso=ZnboDtxhzmjzrS35GSKv73hQ@mail.gmail.com>
        <ZDZ4j7UdBt32j28J@dhcp22.suse.cz> <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
        <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
        <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
        <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Apr 12, 2023 at 4:38?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> Yes I think you're right. As a allocator, dma-buf system heap looks to be loose
>> in memory allocation. Limiting dmabuf memory may be required. But I think there
>> is no nice and reasonable way so far. And the dma-buf system heap is being
>> widely used in Android mobile system. AFAIK the camera consumes huge memory
>> through this dma-buf system heap. I actually even looked a huge size request
>> over 2GB in one dma-buf request.
>>
>Hey can you point me to where you saw a request that big? That's a
>non-buggy request?!

(let me resend as plain text)
It was one of camera scenarios. I internally asked and heard that was not a bug
but normal. I think 2GB looks too big for one graphics buffer but it could be
for other purposes like camera. I think the system heap should support that.

Regarding __GFP_RETRY_MAYFAIL, we may need to say dma-buf system heap was
designed to gather many pages up to a requested size. If mm returns NULL due to
__GFP_RETRY_MAYFAIL, dma-buf system heap will release other already allocated
pages, so that it may help to avoid oom.
