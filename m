Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D046DF3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDLLjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDLLiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:38:52 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C642D67
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:38:28 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230412113801epoutp01f724d913657053abcd31927f4c0c4c6b~VLPhjW9jl2718827188epoutp01C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:38:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230412113801epoutp01f724d913657053abcd31927f4c0c4c6b~VLPhjW9jl2718827188epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681299481;
        bh=PCRyiCdo9buNSVxIlVwF0a59tYap8pCla0PxLClsOhY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ETn2rUFy1Ub3gcUDd91EwRpYobL2nDvHifKXG5TbfZW0l7jGp0wXALXt0oZ//7ail
         UQXYH9himAhhweC/vO03XKCrHw4m7pkHMud290MnXJCbO7GO4Z6HxPSun4D+332Bqw
         AFCc5RKigJe5gsEj23rdmIgHR/ntZeGKz+wlWAm4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230412113800epcas1p3fb76ac32ffb9cb6631f65160c6e36c1b~VLPgvL3RJ0352403524epcas1p3o;
        Wed, 12 Apr 2023 11:38:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PxLLH6y74z4x9Pv; Wed, 12 Apr
        2023 11:37:59 +0000 (GMT)
X-AuditID: b6c32a37-c1fff7000000243f-24-64369817ca3d
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.16.09279.71896346; Wed, 12 Apr 2023 20:37:59 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] dma-buf/heaps: system_heap: avoid too much
 allocation
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
Date:   Wed, 12 Apr 2023 20:37:59 +0900
X-CMS-MailID: 20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmrq74DLMUg+7N5hZz1q9hs3h5SNNi
        4cO7zBarN/ladG+eyWjR+/4Vk8WfExvZLC7vmsNmcW/Nf1aL+30OFqfufma3eLf+C5sDj8fh
        N++ZPfZ+W8DisXPWXXaPBZtKPTZ9msTucefaHjaPEzN+s3j0bVnF6LF+y1UWj8+b5AK4orJt
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVlIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ+zp
        7Gcr6FGqOPVzG1MD40LpLkZODgkBE4lzs+aydTFycQgJ7GCUeDdxMZDDwcErICjxd4cwSI2w
        gL/EvhdzGEFsIQElibM/rrBDxHUlmrpXs4DYbALaEu8XTGIFsUWAaro27wSbySxwmVmi9eo+
        NohlvBIz2p+yQNjSEtuXbwUbyimgJ7H24BlWiLioxM3Vb9lh7PfH5jNC2CISrffOMkPYghIP
        fu5mhJnz5/hzqPnFEss6HzBB2DUSK86tgoqbSzS8XQlm8wr4Stz5uRhsF4uAqsSGjS+g5rhI
        vGv/CjafWUBeYvvbOcygcGAW0JRYv0sfokRRYufvuYwQJXwS7772sMK81bDxNzs29o55T6DO
        UZNoefYVql5G4u+/Z6wTGJVmIUJ6FpLFsxAWL2BkXsUollpQnJueWmxYYAyP3OT83E2M4PSr
        Zb6DcdrbD3qHGJk4GA8xSnAwK4nw/nAxTRHiTUmsrEotyo8vKs1JLT7EaAr08kRmKdHkfGAG
        yCuJNzSxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIpo+Jg1OqgWn1i2Wv1So2H6m+
        FfR/5ieFA5M1DSZKqJjfXj9frPeS1jebK3y333o9nsAtqlpzWObetv9NrLsmPN/gzMpQMU1D
        4xHz7+8XLL5Gf303q3GdvMx2vVNb0iLblzZut7nha+g8ccMGBUNt7n99XBceVNTy/ut8OH+T
        sP+npl1bbh3Z8SWjuvRnTOl3h7NvG2YuLVfP+9Je1Hz62cWzVb//HVyspZvCVP5y/SOVHfvm
        HjsrdoTxG2fO0+Mcj166PV76a9lBBV2GhVLzQlifM9hfn8K9o7Tr+72m2clBj5sv/T6v5hS9
        V2f+wl+TjZk+zbmoubA/NqTO6cfTZxOnx9upcxcnf5hv+2fh+7y8czP3WP8P+qzEUpyRaKjF
        XFScCABalK9zSAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
        <ZDZ4j7UdBt32j28J@dhcp22.suse.cz> <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
        <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed 12-04-23 18:44:40, Jaewon Kim wrote:
>> >On Wed 12-04-23 17:57:26, Jaewon Kim wrote:
>> >> >Sorry for being late. I know there was some pre-existing discussion
>> >> >around that but I didn't have time to participate.
>> >> >
>> >> >On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
>> >> >> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>> >> >>  	struct page *page, *tmp_page;
>> >> >>  	int i, ret = -ENOMEM;
>> >> >>  
>> >> >> +	if (len / PAGE_SIZE > totalram_pages())
>> >> >> +		return ERR_PTR(-ENOMEM);
>> >> >> +
>> >> >
>> >> >This is an antipattern imho. Check 7661809d493b ("mm: don't allow
>> >> >oversized kvmalloc() calls") how kvmalloc has dealt with a similar
>> >> 
>> >> Hello Thank you for the information.
>> >> 
>> >> I tried to search the macro of INT_MAX.
>> >> 
>> >> include/vdso/limits.h
>> >> #define INT_MAX         ((int)(~0U >> 1))
>> >> 
>> >> AFAIK the dma-buf system heap user can request that huge size more than 2GB.
>> >
>> >Do you have any pointers? This all is unreclaimable memory, right? How
>> >are those users constrained to not go overboard?
>> 
>> Correct dma-buf system heap memory is unreclaimable. To avoid that huge request,
>> this patch includes __GFP_RETRY_MAYFAIL.
>
>__GFP_RETRY_MAYFAIL doesn't avoud huge requests. It will drain the free
>available memory to the edge of OOM (especially for low order requests)
>so effectively anybody else requesting any memory (GFP_KERNEL like req.)
>will hit the oom killer very likely).
>
>>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_RETRY_MAYFAIL)
>> 
>> >
>> >> So
>> >> I think totalram_pages() is better than INT_MAX in this case.
>> >> 
>> >> >issue. totalram_pages doesn't really tell you anything about incorrect
>> >> >users. You might be on a low memory system where the request size is
>> >> >sane normally, it just doesn't fit into memory on that particular
>> >> >machine.
>> >> 
>> >> Sorry maybe I'm not fully understand what you meant. User may requested
>> >> a huge size like 3GB on 2GB ram device. But I think that should be rejected
>> >> because it is bigger than the device ram size.
>> >
>> >Even totalram_pages/10 can be just unfeasible amount of data to be
>> >allocated without a major disruption. totalram_pages is no measure of
>> >the memory availability.
>> >If you want to have a ballpark estimation then si_mem_available might be
>> >something you are looking for. But I thought the sole purpose of this
>> >patch is to catch obviously buggy callers (like sign overflow lenght
>> >etc) rather than any memory consumption sanity check.
>> 
>> Yes if we want to avoid some big size, si_mem_available could be one option.
>> Actually I tried to do totalram_pages() / 2 like the old ion system heap in
>> the previous patch version. Anyway totalram_pages in this patch is used to
>> avoid the buggy size.
>
>So let me repeat that totalram_pages is a wrong thing to do(tm).
>
>This is not a subsystem I would feel like nacking a patch, but consider
>this feedback as strong of a rejection as somebody external can give
>you. A mm internal allocator would get an outright nack.
>
>What you are doing is just wrong and an antipattern to what other
>allocators do. Either use something like INT_MAX to catch overflows or
>do not try to catch buggy code but pretend a better memory consumer
>citizen by using something like si_mem_available (ideally think of
>other potential memory users so do not allow any request to use all
>of it). The later might require much more involved interface and I do
>rememeber some attempts to account and limit dmabuf memory better.
>
>> And as we discussed in v2 patch, __GFP_RETRY_MAYFAIL was added. And I think
>> the gfp makes us feel better in memory perspective.
>
>wishful thinking that is.
>-- 
>Michal Hocko
>SUSE Labs

Yes I think you're right. As a allocator, dma-buf system heap looks to be loose
in memory allocation. Limiting dmabuf memory may be required. But I think there
is no nice and reasonable way so far. And the dma-buf system heap is being
widely used in Android mobile system. AFAIK the camera consumes huge memory
through this dma-buf system heap. I actually even looked a huge size request
over 2GB in one dma-buf request.

Jaewon Kim
