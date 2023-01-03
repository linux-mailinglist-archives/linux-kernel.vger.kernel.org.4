Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917865BD14
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbjACJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjACJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:22:36 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D9E086
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:22:35 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230103092233epoutp014fdadf1d53f400273d3cd202071b4334~2wh__Rxzq2865828658epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:22:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230103092233epoutp014fdadf1d53f400273d3cd202071b4334~2wh__Rxzq2865828658epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672737753;
        bh=9hsVUuF18FxAp31aIuTTebw/KbnjjewGzPtYyZ+9y2s=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hwlv4WZuGfuN4X7Xg4iN7eMITYGKCe4tRLxBOPnXa4v12drq1Jz0qgHbURTC+GdA4
         Xe7ZbhqCrD3vG01ub818u0CN4wHIpz3Bnwj0y4W92eC46pIsIllMqKRrIzCkMIJVmh
         SjApWs2Ak30dx3lwm8mbsQzVT+iyS9ez2Q9VcnlA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230103092232epcas1p142a5e8293a446d2cc365ddc99324630d~2wh_kV5791282112821epcas1p1H;
        Tue,  3 Jan 2023 09:22:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.222]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NmS1h3302z4x9Q0; Tue,  3 Jan
        2023 09:22:32 +0000 (GMT)
X-AuditID: b6c32a36-1fdff700000095a1-4c-63b3f3d80e90
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.39.38305.8D3F3B36; Tue,  3 Jan 2023 18:22:32 +0900 (KST)
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
In-Reply-To: <Y7PoBkLyCaH1KHbB@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230103092232epcms1p7f2df94d75fc1b6f11ee986a3a1aa1900@epcms1p7>
Date:   Tue, 03 Jan 2023 18:22:32 +0900
X-CMS-MailID: 20230103092232epcms1p7f2df94d75fc1b6f11ee986a3a1aa1900
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTT/fG583JBu27RS3mrF/DZrF6k69F
        9+aZjBa9718xWVzeNYfN4t6a/6wW9/scHNg9Dr95z+yxc9Zddo9Nnyaxe5yY8ZvFo2/LKkaP
        9Vuusnh83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj7O457AX7lSom/l3E1sB4RbKLkYNDQsBE4s8Nty5GLg4hgR2MEv2rrrKD
        xHkFBCX+7hDuYuTkEBYIkfh58iwziC0koCRx9scVdoi4tcT+RTOYQGw2AUuJ7TcnMoLYIkA1
        XZt3soHYzALdTBKP57mA2BICvBIz2p+yQNjSEtuXbwWr5xTQk/i8bz0rRFxU4ubqt+ww9vtj
        8xkhbBGJ1nsQN0gAnfbg526ouJTEue7jTBCvREi82KMOEc6ReL9zDtRIc4lnG1rARvIK+Ers
        3dQKdhqLgKrEu74lUOe4SJztOssCcbK8xPa3c5hBRjILaEqs36UPUaIosfP3XEaIEj6Jd197
        WGG+2jHvCROErSbR8uwrVFxG4u+/Z1C2h8Tk81NYIKE8kUmiZcFz9gmMCrMQAT0LyeZZCJsX
        MDKvYhRLLSjOTU8tNiwwgkdtcn7uJkZwutQy28E46e0HvUOMTByMhxglOJiVRHgnvdiULMSb
        klhZlVqUH19UmpNafIjRFOjnicxSosn5wISdVxJvaGJpYGJmZGJhbGlspiTOaxOxLllIID2x
        JDU7NbUgtQimj4mDU6qBaYHOwmjrU4eEVYyaNaYpL1Uy+Dlvxe8/5m+M/vzVPziv40vKpW8n
        +ytN5/7aoOP743gf7+lL6kF/Iq0SPOK2dP7S+61+kWPeb4Wdlxrtp7ys8Fi3LTT06p9P0yqM
        Wj42yBi9da+2DFLYlLn7rOINOZ9HxfnLXdJ3CfF/+7UqMFIoUubewXC1T6KTuqsbjxSf01V9
        8XhV8ncXhm+TGbzm3A++6OPaebL1c8qia8GHSmvzzsXKris9u++5N/Oe9YcixXJ1eKv9Tgi8
        b6t/1Lnqyc3+uRy9ztPtT00TWczcv1Cq9c+BaVOfl/hlqe/4E7tFequglHymh8vnhx4LNGXW
        dfS7ZDREl21rvdk6M9XfU4mlOCPRUIu5qDgRACE7bisgBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
References: <Y7PoBkLyCaH1KHbB@dhcp22.suse.cz>
        <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
        <20230103072807.19578-1-jaewon31.kim@samsung.com>
        <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
        <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
>> >> The totalreserve_pages could be higher than the free because of
>> >> watermark high or watermark boost. Handle this situation and fix it to 0
>> >> free size.
>> >
>> >What is the actual problem you are trying to address by this change?
>> 
>> Hello
>> 
>> As described on the original commit,
>>   34e431b0ae39 /proc/meminfo: provide estimated available memory
>> mm is tring to provide the avaiable memory to user space.
>> 
>> But if free is negative, the available memory shown to userspace
>> would be shown smaller thatn the actual available size. The userspace
>> may do unwanted memory shrinking actions like process kills.
>
>Do you have any specific example? Have you seen this happening in
>practice or is this based on the code inspection?

I found this from a device using v5.10 based kernel.
Actually the log was printed by user space in its format after reading /proc/meminfo.

MemFree          38220 KB
MemAvailable     90008 KB
Active(file)    137116 KB
Inactive(file)  124128 KB
SReclaimable    100960 KB

Here's /proc/zoneinfo for wmark info.

------ ZONEINFO (/proc/zoneinfo) ------
Node 0, zone    DMA32
  pages free     17059
        min      862
        low      9790
        high     18718
        spanned  524288
        present  497920
        managed  413348
Node 0, zone   Normal
  pages free     12795
        min      1044
        low      11855
        high     22666
        spanned  8388608
        present  524288
        managed  500548

The pagecache at this time, seems to be 174,664 KB.
  pagecache -= min(pagecache / 2, wmark_low)
We also need to add the reclaimable and the actual free on it to be MemAvaiable.

The MemAvailable should be bigger at leat this 174,664 KB, but it was 90,008 KB only
because the big wmark high 165,536 seems to be used.

>
>Also does this patch actually fix anything? Say the system is really
>struggling and we are under min watermark. Shouldn't that lead to
>Available to be reported as 0 without even looking at other counters?
>

Sorry but I did not understand, this mis-calculation can be happened
above the min watermark. Do you think the wmark high should be extracted
all the time even if the free is negative?


>> I think the logic sholud account the positive size only.
>> 
>> BR
>> 
>> >
>> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> >> ---
>> >>  mm/page_alloc.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >> 
>> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> >> index 218b28ee49ed..e510ae83d5f3 100644
>> >> --- a/mm/page_alloc.c
>> >> +++ b/mm/page_alloc.c
>> >> @@ -5948,6 +5948,8 @@ long si_mem_available(void)
>> >>  	 * without causing swapping or OOM.
>> >>  	 */
>> >>  	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
>> >> +	if (available < 0)
>> >> +		available = 0;
>> >>  
>> >>  	/*
>> >>  	 * Not all the page cache can be freed, otherwise the system will
>> >> -- 
>> >> 2.17.1
>> >
>> >-- 
>> >Michal Hocko
>> >SUSE Labs
>> 
>> 
>> 
>>  
>> --------- Original Message ---------
>> Sender : Michal Hocko <mhocko@suse.com>
>> Date : 2023-01-03 17:03 (GMT+9)
>> Title : Re: [PATCH] page_alloc: avoid the negative free for meminfo available
>>  
>> On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
>> > The totalreserve_pages could be higher than the free because of
>> > watermark high or watermark boost. Handle this situation and fix it to 0
>> > free size.
>> 
>> What is the actual problem you are trying to address by this change?
>> 
>> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> > ---
>> >  mm/page_alloc.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> > 
>> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> > index 218b28ee49ed..e510ae83d5f3 100644
>> > --- a/mm/page_alloc.c
>> > +++ b/mm/page_alloc.c
>> > @@ -5948,6 +5948,8 @@ long si_mem_available(void)
>> >           * without causing swapping or OOM.
>> >           */
>> >          available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
>> > +        if (available < 0)
>> > +                available = 0;
>> >  
>> >          /*
>> >           * Not all the page cache can be freed, otherwise the system will
>> > -- 
>> > 2.17.1
>> 
>> -- 
>> Michal Hocko
>> SUSE Labs
>> 
