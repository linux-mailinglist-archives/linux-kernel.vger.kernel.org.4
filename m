Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F183A6DF0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDLJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDLJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:45:55 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B3170F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:45:13 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230412094442epoutp0297bed44e18494e0827b495e2a3ae09c4~VJslVlYxJ0041600416epoutp02k
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230412094442epoutp0297bed44e18494e0827b495e2a3ae09c4~VJslVlYxJ0041600416epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681292682;
        bh=GKdEwxZooKxsS+1teM/4vmQew0kof+r9nocu56V8y14=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=QsZrAlO8SytiXKH2OkFUieVoWZHXaVKb//n6TSJce97V/md9uuzH/wxJ75oHv9utJ
         JBY3yojbmIgfMwbygfADL1Y89oe5FU1Iz34VdQANizJqEfREOxPB9hlUNmbjd5kJX6
         ZmQUI1Xo90ylONJgXTLYH+0K1fzZLCy0Cd9yWoJc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230412094441epcas1p10967532508fb0544e5700874b619a669~VJskr9bBN3275032750epcas1p1G;
        Wed, 12 Apr 2023 09:44:41 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.226]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PxHqX6kdbz4x9Q2; Wed, 12 Apr
        2023 09:44:40 +0000 (GMT)
X-AuditID: b6c32a37-c35ff7000000243f-b8-64367d888d55
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.29.09279.88D76346; Wed, 12 Apr 2023 18:44:40 +0900 (KST)
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
In-Reply-To: <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
Date:   Wed, 12 Apr 2023 18:44:40 +0900
X-CMS-MailID: 20230412094440epcms1p445319579ead0d0576bb616ebb07501b4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmrm5HrVmKwYUJBhZz1q9hs3h5SNNi
        4cO7zBarN/ladG+eyWjR+/4Vk8WfExvZLC7vmsNmcW/Nf1aL+30OFqfufma3eLf+C5sDj8fh
        N++ZPfZ+W8DisXPWXXaPBZtKPTZ9msTucefaHjaPEzN+s3j0bVnF6LF+y1UWj8+b5AK4orJt
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVlIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0xr
        XMpYcFKk4tjy02wNjLsFuhg5OSQETCRWL9rP0sXIxSEksINRomX2PrYuRg4OXgFBib87hEFq
        hAX8Jfa9mMMIYgsJKEmc/XGFHSKuK9HUvZoFxGYT0JZ4v2ASK4gtAlTTtXknG8hMZoHLzBKt
        V0FmgizjlZjR/pQFwpaW2L58K9hQTgE9iWXTdkPFRSVurn7LDmO/PzafEcIWkWi9d5YZwhaU
        ePBzNyPMnD/Hn0PNL5ZY1vmACcKukVhxbhVU3Fyi4e1KMJtXwFfiz63bTCA/sgioShzprYco
        cZG4fXEBWAmzgLzE9rdzmEFKmAU0Jdbv0ocoUZTY+XsuI0QJn8S7rz2sMF81bPzNjo29Y94T
        qGvUJFqefYWql5H4++8Z6wRGpVmIgJ6FZPEshMULGJlXMYqlFhTnpqcWGxYYw+M2OT93EyM4
        +WqZ72Cc9vaD3iFGJg7GQ4wSHMxKIrw/XExThHhTEiurUovy44tKc1KLDzGaAn08kVlKNDkf
        mP7zSuINTSwNTMyMTCyMLY3NlMR5vzzVThESSE8sSc1OTS1ILYLpY+LglGpgmn/iYVnPgxtc
        t6Ke2OqFpby/nJaU0vykY61P5e1XLX4digGycvesN+tc7N5UyMrmZ77esUxr2Vk1odNqFb++
        VyxaZvl1ztbTv6KcOJ4pXpcQb5hedS+5VrBX0nStSoVoc+TUL5/tbxQJJR1wSOd9WXiMOZs/
        R2OZiYyopafOhAmPHz9/apN/VDP9dbBYb/X0PZwfPGcErJOUaPsgODdy39XNfrc3/tp4u297
        f8k0ba842T3OhXcLzpwRrPgZtX8P0zY2LmHH1hWyjxVd5yTz/+Z69LW973h/arX9RIZn929o
        7VmW8K1dfPO8H92MOz+EfutYrpmpmbvrKZvjAaE971Qyvez7A//rz1VcHbZDiaU4I9FQi7mo
        OBEAVq3HGkcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
        <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed 12-04-23 17:57:26, Jaewon Kim wrote:
>> >Sorry for being late. I know there was some pre-existing discussion
>> >around that but I didn't have time to participate.
>> >
>> >On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
>> >> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>> >>  	struct page *page, *tmp_page;
>> >>  	int i, ret = -ENOMEM;
>> >>  
>> >> +	if (len / PAGE_SIZE > totalram_pages())
>> >> +		return ERR_PTR(-ENOMEM);
>> >> +
>> >
>> >This is an antipattern imho. Check 7661809d493b ("mm: don't allow
>> >oversized kvmalloc() calls") how kvmalloc has dealt with a similar
>> 
>> Hello Thank you for the information.
>> 
>> I tried to search the macro of INT_MAX.
>> 
>> include/vdso/limits.h
>> #define INT_MAX         ((int)(~0U >> 1))
>> 
>> AFAIK the dma-buf system heap user can request that huge size more than 2GB.
>
>Do you have any pointers? This all is unreclaimable memory, right? How
>are those users constrained to not go overboard?

Correct dma-buf system heap memory is unreclaimable. To avoid that huge request,
this patch includes __GFP_RETRY_MAYFAIL.

 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_RETRY_MAYFAIL)

>
>> So
>> I think totalram_pages() is better than INT_MAX in this case.
>> 
>> >issue. totalram_pages doesn't really tell you anything about incorrect
>> >users. You might be on a low memory system where the request size is
>> >sane normally, it just doesn't fit into memory on that particular
>> >machine.
>> 
>> Sorry maybe I'm not fully understand what you meant. User may requested
>> a huge size like 3GB on 2GB ram device. But I think that should be rejected
>> because it is bigger than the device ram size.
>
>Even totalram_pages/10 can be just unfeasible amount of data to be
>allocated without a major disruption. totalram_pages is no measure of
>the memory availability.
>If you want to have a ballpark estimation then si_mem_available might be
>something you are looking for. But I thought the sole purpose of this
>patch is to catch obviously buggy callers (like sign overflow lenght
>etc) rather than any memory consumption sanity check.

Yes if we want to avoid some big size, si_mem_available could be one option.
Actually I tried to do totalram_pages() / 2 like the old ion system heap in
the previous patch version. Anyway totalram_pages in this patch is used to
avoid the buggy size.

And as we discussed in v2 patch, __GFP_RETRY_MAYFAIL was added. And I think
the gfp makes us feel better in memory perspective.

>
>-- 
>Michal Hocko
>SUSE Labs
