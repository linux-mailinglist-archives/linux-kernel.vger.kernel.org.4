Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066E65BE4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjACKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjACKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:39:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33DE58
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:39:55 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230103103951epoutp01cff7b86bcad922c0b2f6fc184bfa97f6~2xlfBJMwd3220532205epoutp01m
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:39:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230103103951epoutp01cff7b86bcad922c0b2f6fc184bfa97f6~2xlfBJMwd3220532205epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672742391;
        bh=0TJaPWMtey8kBZptPJkIvvP316f+QOmtcQ1ZopckNj4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=nT2Ctl6yoO4emiZLrVSR1Ch4SXiFGx+H5IgX+KbBamUaUCdTuPIjVmtdCYGn2ofa0
         GpOT7GAmWrQFAOoEbVyVFQHjlHweNSlTOTrEA+A9mrYKGNvi5XvH23SxVTR7a2UfCY
         +wQuly5UD8rOPt596gt6pA1dnTb3AfY9MAwP7yMQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230103103951epcas1p46e4b207f50c7823402645d0b51566d41~2xleyuy-Q1633416334epcas1p4j;
        Tue,  3 Jan 2023 10:39:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NmTkv1cfwz4x9Pw; Tue,  3 Jan
        2023 10:39:51 +0000 (GMT)
X-AuditID: b6c32a35-21ffd70000014e05-3c-63b405f7dc99
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.F1.19973.7F504B36; Tue,  3 Jan 2023 19:39:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: (2) [PATCH] page_alloc: avoid the negative free for meminfo
 available
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Y7QBUx0Ds9SrzK9g@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230103103950epcms1p5fc40605dd0f3165f86d7fbaff78ff87b@epcms1p5>
Date:   Tue, 03 Jan 2023 19:39:50 +0900
X-CMS-MailID: 20230103103950epcms1p5fc40605dd0f3165f86d7fbaff78ff87b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTT/c765ZkgyM/WS3mrF/DZrF6k69F
        9+aZjBa9718xWVzeNYfN4t6a/6wW9/scHNg9Dr95z+yxc9Zddo9Nnyaxe5yY8ZvFo2/LKkaP
        9Vuusnh83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj+oGbLAX9MhV3X61jbGBcKNrFyMkhIWAiMev/A5YuRi4OIYEdjBJT191i
        6mLk4OAVEJT4u0MYpEZYIETi58mzzCC2kICSxNkfV9gh4tYS+xfNYAKx2QQsJbbfnMgIYosA
        1XRt3skGYjMLdDNJPJ7nArGLV2JG+1MWCFtaYvvyrWD1nAJ6EucWzGWEiItK3Fz9lh3Gfn9s
        PlRcRKL1HsQNEkCnPfi5GyouJXGu+zjYyRICERIv9qhDhHMk3u+cwwphm0s829ACNpJXwFdi
        7f01YK0sAqoS/7unMEK0ukj0XYyCuFheYvvbOcwgYWYBTYn1u/QhpihK7PwNcSSzAJ/Eu689
        rDBP7Zj3hAnCVpNoefYVKi4j8fffMyjbQ2Ly+SnQQP7OJLFy7m62CYwKsxDhPAvJ5lkImxcw
        Mq9iFEstKM5NTy02LDCER21yfu4mRnC61DLdwTjx7Qe9Q4xMHIyHGCU4mJVEeCe92JQsxJuS
        WFmVWpQfX1Sak1p8iNEU6OWJzFKiyfnAhJ1XEm9oYmlgYmZkYmFsaWymJM5rE7EuWUggPbEk
        NTs1tSC1CKaPiYNTqoHJzGz54/N9H9OKm1tWNpdsUnP9dm7hKtn5Fx/M3/qVcZ3kO5ENU5ew
        RqxldM2Um3IgIT56R4vHwe1LQi0i3SycO9Yyxa/b5Ki91/pFhN/K+ORNTJ/ClqZZH77xa9fk
        E2GNdnbzeS4yq/ysm8A3v+5Jecj+MK2VkpnhCnHiYqekNopdcY5jE/AyeH/tn7xDrn6Qvlbn
        j7CVE+3t3sQa36rb+67no0Pq45spp7jW37OviVv66ngB98KEpcEbXHuVvrakfj8We9bYRkQj
        wUp/oXOT19+DP2q3P1ylILco1vH2PMbX95WDJ4uef3boe3nUnPzHjoeeeUpvz1bnt7pQZLj6
        eVjdRi45cW8FxQN88XOVWIozEg21mIuKEwHZxjSOIAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
References: <Y7QBUx0Ds9SrzK9g@dhcp22.suse.cz>
        <Y7PoBkLyCaH1KHbB@dhcp22.suse.cz> <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
        <20230103072807.19578-1-jaewon31.kim@samsung.com>
        <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
        <20230103092232epcms1p7f2df94d75fc1b6f11ee986a3a1aa1900@epcms1p7>
        <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> >On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
>> >> >> The totalreserve_pages could be higher than the free because of
>> >> >> watermark high or watermark boost. Handle this situation and fix it to 0
>> >> >> free size.
>> >> >
>> >> >What is the actual problem you are trying to address by this change?
>> >> 
>> >> Hello
>> >> 
>> >> As described on the original commit,
>> >>   34e431b0ae39 /proc/meminfo: provide estimated available memory
>> >> mm is tring to provide the avaiable memory to user space.
>> >> 
>> >> But if free is negative, the available memory shown to userspace
>> >> would be shown smaller thatn the actual available size. The userspace
>> >> may do unwanted memory shrinking actions like process kills.
>> >
>> >Do you have any specific example? Have you seen this happening in
>> >practice or is this based on the code inspection?
>> 
>> I found this from a device using v5.10 based kernel.
>> Actually the log was printed by user space in its format after reading /proc/meminfo.
>> 
>> MemFree          38220 KB
>> MemAvailable     90008 KB
>> Active(file)    137116 KB
>> Inactive(file)  124128 KB
>> SReclaimable    100960 KB
>> 
>> Here's /proc/zoneinfo for wmark info.
>> 
>> ------ ZONEINFO (/proc/zoneinfo) ------
>> Node 0, zone    DMA32
>>   pages free     17059
>>         min      862
>>         low      9790
>>         high     18718
>>         spanned  524288
>>         present  497920
>>         managed  413348
>> Node 0, zone   Normal
>>   pages free     12795
>>         min      1044
>>         low      11855
>>         high     22666
>>         spanned  8388608
>>         present  524288
>>         managed  500548
>> 
>> The pagecache at this time, seems to be 174,664 KB.
>>   pagecache -= min(pagecache / 2, wmark_low)
>> We also need to add the reclaimable and the actual free on it to be MemAvaiable.
>> 
>> The MemAvailable should be bigger at leat this 174,664 KB, but it was 90,008 KB only
>> because the big wmark high 165,536 seems to be used.
>
>How have you concluded that? Are you saying that a userspace would be
>behaving more sanely when considering more memory to be available?
>Please see more on the semantics below.
>
>> >Also does this patch actually fix anything? Say the system is really
>> >struggling and we are under min watermark. Shouldn't that lead to
>> >Available to be reported as 0 without even looking at other counters?
>> >
>> 
>> Sorry but I did not understand,
>
>What I meant here is that the core of the high level definition says:
>"An estimate of how much memory is available for starting new
>applications, without swapping." If the system is close enough to watermarks 
>that NR_FREE_PAGES < reserves then it is likely that further memory
>allocations will not do without reclaim and potentially swapout.

Yes reclaim would be needed in that case.

I think it is just a matter of perspective.
If I follow you, I think, the totalreserve_pages should be considered
as must-have free size.

>
>So the question really is whether just clamping the value to 0 is
>actually making MemAvailable more "correct"? See my point?
>
>The actual value is never going to be lazer cut precise. Close to
>watermark behavior will vary wildly depending on the memory
>reclaimability. Kswapd might easily keep up with memory demand but it
>also could get stuck. MemAvailable should be considered a hint rather
>than an exact value IMHO.

Yeah correct, it is not perfect.
I will drop my patch.
It was nice discussion.
Thank you
