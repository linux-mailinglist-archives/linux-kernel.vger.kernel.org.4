Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5786E074B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDMHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:02:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331E7280
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:01:58 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230413070152epoutp0217256bd9a65e9ff3067caf141d89b9b8~VbHss9cHV2470224702epoutp02n
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:01:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230413070152epoutp0217256bd9a65e9ff3067caf141d89b9b8~VbHss9cHV2470224702epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681369312;
        bh=ytD3gC+o6uQdMb9JsRQtUPDHm660IdMiQVFyF8sQSt0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=kSGWldT+nrPPH1Hxll2gu1kMnjxxThhF/rVfgnHUfgKNbAyODh1d09oc6Ct5Hm9Vv
         ui8SYBOIJYXq9y4agK/iHyyQRGsKuNeyPJWk9caW/qRYy8zthgmrXxXpYE63kAwjL3
         TbSgAxYHX8XM/dchIxD/QVQIZjAztIAxyyEyFpiE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230413070151epcas1p2fa916d723ecf9115689c531bf29e057a~VbHsL5Mla2745127451epcas1p23;
        Thu, 13 Apr 2023 07:01:51 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.243]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pxr9C1nw5z4x9QG; Thu, 13 Apr
        2023 07:01:51 +0000 (GMT)
X-AuditID: b6c32a36-b27fa700000025c4-e6-6437a8df6f08
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.AE.09668.FD8A7346; Thu, 13 Apr 2023 16:01:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] dma-buf/heaps: system_heap: avoid too much
 allocation
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@suse.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "T.J. Mercier" <tjmercier@google.com>,
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
In-Reply-To: <ZDenU98chAfH9jSj@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230413070150epcms1p1f5cce7b0009d0b8e6466c4be74ed2b41@epcms1p1>
Date:   Thu, 13 Apr 2023 16:01:50 +0900
X-CMS-MailID: 20230413070150epcms1p1f5cce7b0009d0b8e6466c4be74ed2b41
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmru79FeYpBmd7eCzmrF/DZvHykKbF
        wod3mS1Wb/K16N48k9Gi9/0rJos/JzayWVzeNYfN4t6a/6wW9/scLE7d/cxu8W79FzYHHo/D
        b94ze+z9toDFY+esu+weCzaVemz6NInd4861PWweJ2b8ZvHo27KK0WP9lqssHp83yQVwRWXb
        ZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdraRQlphT
        ChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrjw
        8DpTwUO+iov3vBsY73F3MXJySAiYSNxbtZGpi5GLQ0hgB6PEry83mbsYOTh4BQQl/u4QBqkR
        FvCX2PdiDiOILSSgJHH2xxV2iLiuRFP3ahYQm01AW+L9gkmsILaIgKfEvQ0NLCAzmQVOM0s0
        HHnNArGMV2JG+1MoW1pi+/KtjCC7OAX0JK48yocIi0rcXP2WHcZ+f2w+I4QtItF67ywzhC0o
        8eDnbkaYMX+OP2eDsIsllnU+YIKwayRWnFsFFTeXaHi7EszmFfCVeNh2AWw+i4CqRO/FBVDn
        uEg8OfMe7H5mAXmJ7W/ngIOBWUBTYv0ufYgSRYmdv+cyQpTwSbz72sMK81XDxt/s2Ng75j2B
        OkdNouXZV6h6GYm//56xTmBUmoUI6FlIFs9CWLyAkXkVo1hqQXFuemqxYYERPGqT83M3MYJT
        r5bZDsZJbz/oHWJk4mA8xCjBwawkwvvDxTRFiDclsbIqtSg/vqg0J7X4EKMp0MsTmaVEk/OB
        yT+vJN7QxNLAxMzIxMLY0thMSZz3y1PtFCGB9MSS1OzU1ILUIpg+Jg5OqQam+qVsr9XfBFx2
        0LmVIPFovkjH7gK9lYsnHVTdKRCgkaPb/DtL/e1y6fCZYhXKsY5L5urf3S+7IP9M7Pz37xU3
        HNmcusPLoOUMx7y92klyt7f3x2wMDLWJKBUtPn49603jz1L7Cu2CDzPa/+sXVG2rMwxmkg07
        cMdka/rnX1VfJFXDXY/+lAx8Yb/3YursNzs/Jxf90ufjm2sponU5No7nefQrzpJVN/b9bc94
        s2Za2KI7p1eHzGVsm+cuzqC3TnGhxTc+0SKntxY7nZZYL+SNv6tjL756Bo9vzJU9By/+vM6r
        W3bCe1P3y5NnV8fNXbSqLPnMyiMrTsydqd5Tt23DRVv5K5bT5zc4nQjofHv5ihJLcUaioRZz
        UXEiAGaHy6BGBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <ZDenU98chAfH9jSj@dhcp22.suse.cz>
        <CABdmKX2fA2nXaSb8k+LE1yeso=ZnboDtxhzmjzrS35GSKv73hQ@mail.gmail.com>
        <ZDZ4j7UdBt32j28J@dhcp22.suse.cz> <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
        <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
        <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
        <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
        <20230413001658epcms1p611d149fcbbbd06fc17387724f4f16359@epcms1p6>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu 13-04-23 09:16:58, Jaewon Kim wrote:
>> >On Wed, Apr 12, 2023 at 4:38?AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>> >
>> >> Yes I think you're right. As a allocator, dma-buf system heap looks to be loose
>> >> in memory allocation. Limiting dmabuf memory may be required. But I think there
>> >> is no nice and reasonable way so far. And the dma-buf system heap is being
>> >> widely used in Android mobile system. AFAIK the camera consumes huge memory
>> >> through this dma-buf system heap. I actually even looked a huge size request
>> >> over 2GB in one dma-buf request.
>> >>
>> >Hey can you point me to where you saw a request that big? That's a
>> >non-buggy request?!
>> 
>> (let me resend as plain text)
>> It was one of camera scenarios. I internally asked and heard that was not a bug
>> but normal. I think 2GB looks too big for one graphics buffer but it could be
>> for other purposes like camera. I think the system heap should support that.
>
>Is that any of the upstream drivers or something sitting out of the
>tree.

I don't think so. I guess that is userspace library rather than kernel driver.
The user library directly might request the size through dma-buf ioctl. Even
though that is kernel driver, I think the driver may not be upstreamed.

>
>> Regarding __GFP_RETRY_MAYFAIL, we may need to say dma-buf system heap was
>> designed to gather many pages up to a requested size. If mm returns NULL due to
>> __GFP_RETRY_MAYFAIL, dma-buf system heap will release other already allocated
>> pages, so that it may help to avoid oom.
>
>This really depends on the other activity on the system. If you have a
>more concurrent memory demand at the time then you might be just out of
>the luck. Really, claiming huge portion of the memory shouldn't be done
>nilly willy.

I agree on that.

>-- 
>Michal Hocko
>SUSE Labs
