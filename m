Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63267AF81
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjAYKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:20:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6F37577
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:03 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230125102000epoutp048c878b5c7094244c0b42d0a6f01e1f60~9hgbMc4Q10406504065epoutp04H
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230125102000epoutp048c878b5c7094244c0b42d0a6f01e1f60~9hgbMc4Q10406504065epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674642000;
        bh=WLyvk7xfIy1NGSE2/+1igF9xicVdBwKkbaJPN/VmyIA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=E8hDWt3AmNrVqCNHGcjetwGSYMK4tXYezTKIHXAnDBlxfmsPK6iGMqYKHilnc5cgl
         PfT99bt8Pv1wPRhv2b8rXGhPic3FZSwSH38wGXTlsb4uByE3ldUeOjSJILO4sJEyNs
         +/O/TxP1cvwONAaT1LznrNlmqJDrcIUM0j9PEdms=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230125101958epcas1p46ee13ad618d65f425b0c0956e21e786b~9hgZyA6Hq1718117181epcas1p4g;
        Wed, 25 Jan 2023 10:19:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.224]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P20Fp2Nnmz4x9Pp; Wed, 25 Jan
        2023 10:19:58 +0000 (GMT)
X-AuditID: b6c32a39-d01fc7000000d627-09-63d1024e7fa8
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.A0.54823.E4201D36; Wed, 25 Jan 2023 19:19:58 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>
CC:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
Date:   Wed, 25 Jan 2023 19:19:57 +0900
X-CMS-MailID: 20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmga4f08Vkg99PeS3mrF/DZrHw4V1m
        i9WbfC26N89ktOh9/4rJ4s+JjWwWl3fNYbO4t+Y/q8Xrb8uYLU7d/cxu8W79FzYHbo/Db94z
        e+z9toDFY+esu+weCzaVemxa1cnmsenTJHaPO9f2sHmcmPGbxaNvyypGj8+b5AK4orJtMlIT
        U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVlIoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZzw5vp6p
        YJZUxfG3qg2M14S7GDk5JARMJDpnbmLqYuTiEBLYwSjR9no/YxcjBwevgKDE3x1gNcICLhK3
        V/cxg9hCAkoSZ39cYYeI60o0da9mAbHZBLQl3i+YxApiiwiUSDw4+YkNZCazwAJmiTMf2pkg
        lvFKzGh/ygJhS0tsX76VEcTmFPCTmNT8mxUiLipxc/Vbdhj7/bH5jBC2iETrvbPMELagxIOf
        u6HiUhLnuo9DzS+X2DFnPxuEXSHxu38Z1Bx9iSv9M8FqeAV8Jb7tfwd2A4uAqsTWq3+g7nGR
        ePt0H9hMZgF5ie1v5zCDwoFZQFNi/S59iBJFiZ2/50KV8Em8+9rDCvPWjnlPoE5Qk2h59hUq
        LiPx998zKNtDonlNEwsknGcxS7y61c48gVFhFiKoZyHZPAth8wJG5lWMYqkFxbnpqcWGBabw
        yE3Oz93ECE68WpY7GKe//aB3iJGJg/EQowQHs5IIb8/s88lCvCmJlVWpRfnxRaU5qcWHGE2B
        fp7ILCWanA9M/Xkl8YYmlgYmZkYmFsaWxmZK4rzitieThQTSE0tSs1NTC1KLYPqYODilGphs
        49S3anJMNo6dXPGEMelCZFyJsvKPvXfCnB3TyqOUrzBaH3NR2jy7v6WsUj1qP/e3nsXpbIpp
        u1bd95zwYnv/Wp8e2VNOCxZPLJBWO7w2+MS+zhLdm0Jm9Q8yRDg6PJ7yqz93WtFSdlL4beGm
        kH6bVtMc/r4d2y69uhea6OGZ1nAyaXL/yke8E26q9DhyOPvoRE6+l3fw8b65TZksP/NiJzfw
        p759MbeYgeumqo02u8XzuCOfrmVLdX9Td/JrzxWttlvrn3njebvKR5dIfz6zx18mW9WlX+It
        +Mx0d0K+19YJAg27xNkS1nZeuriPZV7oHZGbn8wXnb20WeJklXq7xg61OdPVOGKXbL3HocRS
        nJFoqMVcVJwIANsgssZFBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
        <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > > > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > > > > quite much time in page allocation perspective.
> > > > >
> > > > > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > > > > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > > > > unpredictable delay.
> > > > >
> > > > > To get reasonable allocation speed from dma-buf system heap, use
> > > > > HIGH_ORDER_GFP for order 4 to avoid reclaim.
> > >
> > > Thanks for sharing this!
> > > The case where the allocation gets stuck behind reclaim under pressure
> > > does sound undesirable, but I'd be a bit hesitant to tweak numbers
> > > that have been used for a long while (going back to ion) without a bit
> > > more data.
> > >
> > > It might be good to also better understand the tradeoff of potential
> > > on-going impact to performance from using low order pages when the
> > > buffer is used.  Do you have any details like or tests that you could
> > > share to help ensure this won't impact other users?
> > >
> > > TJ: Do you have any additional thoughts on this?
> > >
> > I don't have any data on how often we hit reclaim for mid order
> > allocations. That would be interesting to know. However the 70th
> > percentile of system-wide buffer sizes while running the camera on my
> > phone is still only 1 page, so it looks like this change would affect
> > a subset of use-cases.
> > 
> > Wouldn't this change make it less likely to get an order 4 allocation
> > (under memory pressure)? The commit message makes me think the goal of
> > the change is to get more of them.
> 
> Hello John Stultz
> 
> I've been waiting for your next reply.
> 
> With my commit, we may gather less number of order 4 pages and fill the 
> requested size with more number of order 0 pages. I think, howerver, stable
> allocation speed is quite important so that corresponding user space
> context can move on within a specific time.
> 
> Not only compaction but reclaim also, I think, would be invoked more if the 
> __GFP_RECLAIM is added on order 4. I expect the reclaim could be decreased
> if we move to order 0.
> 

Additionally I'd like to say the old legacy ion system heap also used the
__GFP_RECLAIM only for order 8, not for order 4.

drivers/staging/android/ion/ion_system_heap.c

static gfp_t high_order_gfp_flags = (GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN |
                                    __GFP_NORETRY) & ~__GFP_RECLAIM;
static gfp_t low_order_gfp_flags  = GFP_HIGHUSER | __GFP_ZERO;
static const unsigned int orders[] = {8, 4, 0};

static int ion_system_heap_create_pools(struct ion_page_pool **pools)
{
       int i;

       for (i = 0; i < NUM_ORDERS; i++) {
               struct ion_page_pool *pool;
               gfp_t gfp_flags = low_order_gfp_flags;

               if (orders[i] > 4)
                       gfp_flags = high_order_gfp_flags;


> Thank you
> Jaewon Kim
> 
> > 
> > Actually with the low order being 0, I don't think __GFP_COMP makes
> > sense in LOW_ORDER_GFP. But I guess that flag isn't harmful there.
> > 
> > > thanks
> > > -john
