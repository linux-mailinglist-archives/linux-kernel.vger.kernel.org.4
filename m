Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B275F99FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiJJHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiJJHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:30:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60138.outbound.protection.outlook.com [40.107.6.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E41237C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo4o3Zog8VNktZpQLKyNZ+Os6306bS156fkBnaH72xiCE0AzP0qJIERnbUnuW7UCNF310kcAqheFgie88+CY+eM38x3PLWl03Sa/jgeNDDWBiBY/0iGw5B1uOl582XvE0ZRvfdYIcSRZuEJa7++A5ORYVBgTudjKDZxKZIOMaROUw8wTI+/SUPoc2J5d7EOzwLmNH31kRGDb5Y3F7aqAqiDj3/sMRIAbMF7mgjbY8I3QXFr1UqahWjZREhltKmfmvvhjt68H9s0nI6nAd4/D/tEo5+IqAMe2i9MmYtgDa6c++17M/PQNqP46kKkvU3IQsn4tidYqNGCtz0nFwSkwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKjJji0+/op0imqQJS+PVrxZuj2RxtDTk51/ihObqzs=;
 b=mFMLq3S8C1VksMdXKLL+neuxosdmg+fF+xHt605IJ9Mml9NDKl/AFT3udsmN/PQX7Vh6esGskQQOqQd6q7hJKo7fN1biAoHus5R22HERHGnqcMuitesYmH/SwoZFIM1McMBqrP2fODa6QvY1veeuqRzCrIGJSxrwjxNhMBON023wGkdiOCqVzqFSLyvDmLD9vAq7c1iHK/6hju2z0fm2zpxTEhIQr3LjNX+VqpLR/+QpKr249Jb/ipxfx8ckcFnW3KUalOxhXNqlAARWWEn/6xmyOhwIEF3FyXaaVHMjZsMAZofr6VG+tyQ6nzeN/jCXLa1pUjlVroIphv84NiysgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKjJji0+/op0imqQJS+PVrxZuj2RxtDTk51/ihObqzs=;
 b=bw3ahxBKm4PDK9M1qlYhvNK9/JQkE5+6phE3FAZNP+hTg6nSRg3C3N/V03Tg4CqBkni32aXiRe8ZSY12nc8OI3syhFR+om8X5kQwJ44DYJv30/jbns4Ihfy54la5LdDUWUou6ObtneX+/IJObq8/qMenIp+YQG9iIGyQo2rkvSPLvasBw+dN1sj4zELyumcviwJiWsTJ+sOddo2XtEq6NHQ++KZamU3/R1SogBkG7tZh0JD92TGWxfjjVuWGYpoDj7nGbUl8rcNdX9H2zRvQJ7NcU04HiPVvaGLcoBcgEOSshiKEmHSgh9zoRXQvx4w1WGcJL67gFWqRd9PAqye1Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DBBPR08MB6267.eurprd08.prod.outlook.com (2603:10a6:10:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 07:24:17 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 07:24:17 +0000
Message-ID: <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
Date:   Mon, 10 Oct 2022 10:24:15 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0901CA0103.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::29) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DBBPR08MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: e7198e3f-327b-4bb6-ca65-08daaa9070c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRO6iThtusAMvD3VO3ykEd2xj3LiKP2dNxQWtki5HOyx5uWV2WmI/rn75vPLFMADb/xuo9SNTg7xmZL/OYB+3lG0WGHOlMAHZ5wvPtpVxGGpB23oxtHQnNPQtV+qta58J0sDvKm7dTEirXD8q/8k8e4Wui0a15usnGwhBtceLJ2ixGhAT1xcMiYWFduHtg3QzXenLGWwh2mJVAwqLZObpHN8br4iRUFnxs384gySThULRZbBPaqEO2D8wpP1A8NP5RHp27e9CncJGkoqFvDGCiM2P2eayaW7wqtc7/McKnFO+ReMQJjDxDdma7oLiucC+IWtFRxLGpRti6ZhX+tJVOyr30CnYgZe7h/eRYqFNhUTLLXlOk48QlFW33daca3pZWMwHunNKpBXPVBzCG3pdOsZZEJ4McAXi5ihCIyPmoHnUPBAvayNzYibHFbjhG+09pMLnE/aPuivt57YleEDuLsakxL7jWm8KWIThjjTyAcs7uiLuWN7SxxfTj0z2GRKBqaCweMqJ+T5hamuNRNh1T8GxaGMw88PvEleCdTtXlABZ1duG9GCuTwoHYCE0NR1GMqYxE6xwcdRAhKA5KBhMGcIILrBnQ47+3uFPKht5Qmiy3+kZDLDXlK+koHj1H0SoK1Us8MZTGBDVKhgzO7y5DQBmhNgWqqsgxhdyBiaE7PQhPugSfzs8RMHvC86YpA5Jbn5yi5BAYAYCK0BRp70ij/dcjbo5rJEBASP0QlECgSHxy513CP+VZDvidXHCDw3347NV78q0rnmCwE6fXCnq8/h5jooMxLIWpO30F9QOWZYcimyRZe/Le0rF77f+vDfjoRyYxQFG3Z4a8rdIoiWflrR0gnALgfXcjg662Duv2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(376002)(396003)(366004)(451199015)(966005)(31696002)(66476007)(36756003)(8676002)(38100700002)(38350700002)(66946007)(4326008)(66556008)(316002)(86362001)(6916009)(54906003)(2906002)(41300700001)(8936002)(44832011)(6512007)(5660300002)(83380400001)(186003)(6486002)(2616005)(478600001)(6506007)(26005)(53546011)(52116002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTB6dmJyZHowTkxISVBVNkJzNXQ2MTBla2lHK21haFN4bFUxNWhKd2JmZXRl?=
 =?utf-8?B?dDNLRTJwVTdnYVlqaDFhTkhZQ0NFTVlyRDBRaGZ1dkpDZVBVdzhkQTdRcEhm?=
 =?utf-8?B?WFR1QklEeDVsTWJuaWhtbTNCUUs1T0UvSWE3RTFuRUF4RGtlVnZGWlFFN3RC?=
 =?utf-8?B?WmJzZHFRSFVzajlHOUVkY25yLy9TdGZYRHA0aUpMQkJ5Umc0MWdnbllsaGJy?=
 =?utf-8?B?Uy9hWmt6NEtnRGtaMTBZNEZRMzd3Y3RoN0Q2TnNCN2IzTGNuSGJ2RmlFOUVy?=
 =?utf-8?B?S2ZyQkczRmVYRCswMStKOWVvajhOeEpLZjBQVHdWRjd0K3FNNEptMVkvZjdK?=
 =?utf-8?B?aDVUbGtqV0luMExaTU5KcXI4UGFRbzAzR2YyTGpwRmllcEVjU29nbXBsalNM?=
 =?utf-8?B?WTNPQWJ5bVE4WCtRc0hUSXpkeU9NYmhmeWlHL3Q5UzBUbmdrR2ZKY1UyUkJv?=
 =?utf-8?B?Y2ZxOWNVZS9BR2JOL0lmZWtIVkZUUUg0Qjk3d1BzRU1zaFVtem9HYnV3YUlm?=
 =?utf-8?B?VW9LMEc2ZVg3Und4WTZFSEFCU2x1Tk5oZlkyS0hyWWk4c3AwUThIYi9JbGtT?=
 =?utf-8?B?eGJyQWEzak1TbXUzb3l1S1daelhsMVVFbXFkYi9PVS9mK2xmUkk2S21EejZo?=
 =?utf-8?B?NmRRSmJINVkrNUwwTUFCVUJBek1lYTdYTkpjTlkranpoeFFYbHRhVkJWNWVW?=
 =?utf-8?B?N2MzLy9WdFByS3drL3Fqam9Oc1JmTUg3RDlCcEFGditNM2hnOFh6YkFHc2Fl?=
 =?utf-8?B?Y040dDhvTlZEekxVeFVDR2ZKRllHTjBVVEtYNGplcTRzY3l0RnNsZFBPOEVC?=
 =?utf-8?B?MHRxWlNoUW10REl3aDdwMlM2ZWdmRUxHZWVzYi9VZ0FBVFRMdVlVZW1tbDJP?=
 =?utf-8?B?bzJPRDk1QVFsU212ckVyMzV0dDRVUTk3Yzh3a3l5SkhBWFRnMW8wZjdkOVQv?=
 =?utf-8?B?Mzh3YjZXWWpTejBKWHZwc1NlYW5YMklDcUlFY01vSEpvTDdqSHozM2JRRmV3?=
 =?utf-8?B?d0QyWjNvTURXajl4VDhnWnZKaUN6WnJOSHRSeHl4TkNjb0U0OCtwOTZUWmk4?=
 =?utf-8?B?Ukp6NjJlaDdlM1hBb0sybTVablA5WTFXYVRSMkpSMGw2RXFZbG40WU1RTUcw?=
 =?utf-8?B?OGZ4SlRJQVVYTWcrenJoQWloYk9tZzhLUHRqenJJUlFxdFpNZGpYVUYza0RI?=
 =?utf-8?B?ZkUxaTBIcmh6cGMvblVyY2JYSkU1TjluNkplc29xc3U0Q0VTNXd1UFo5WS90?=
 =?utf-8?B?MGJHOGpiTUFzdGRQakMyazIrVFBYajI4eG1jMGx5dFZNNkVRY1ZZY2UwNWUv?=
 =?utf-8?B?WDNIY1pnWlhZdWxMOERQbzFmTGlJWTR4SU9nMEpwY2lQbkNFQUd0UGdVUjBv?=
 =?utf-8?B?UTB1K2tzQkVLTHovZE1PWmZ4YTNaVDYxVURpRmZtK2w4R1BwME1JaFB6c2J1?=
 =?utf-8?B?Vlpab3pueWN5aXQ1bTV0Zk5zUkxDQkI1N2hvcGhxUXhXclF1alU2dWd2Tlpn?=
 =?utf-8?B?aUJkbU1OQjB0QmpMNnN6RnRrTFFyalhjcmR0aExXYms3TS9uOTFLOE9sYTMy?=
 =?utf-8?B?alZvcno4RG1BelN3aTl2TE9JeXVmUFBtL3BNeVNOMFNjeGQ5Qk9GdVlPbEhk?=
 =?utf-8?B?R1IvdlFiT2hCM3VUVmVuMHk5YlBDSWMyMDEwd29nWHhHZTliQmpIZ2xwUGNW?=
 =?utf-8?B?aE55UEtTWFFsckRPbG41TjcxWU9qSzZBb0gyMHFJcjZFdC9xeU5TOUhJcHhV?=
 =?utf-8?B?TU91SVhuWlFOWlNzYWRudTZBcyt0UU1vSnhDRDFYc09RYlJ3T2c5WndmRVRL?=
 =?utf-8?B?Qll2a0xCajN4V1Z6aVRURTROM3cvL1QyaHZ4Z1FldmhIcTFqSjRDUE9KTXZO?=
 =?utf-8?B?NGRJNDBJNTV5TXFFUWVxSS90SEJJSEhlWDNDMlV0Q0lJSlNzSjg3emJPVTdZ?=
 =?utf-8?B?dmFnZWQ3VllLSklWekNpZjZ2ZzE2L2Rjd1JvSHZLV0hoOVY5MVVtTnFqQVNn?=
 =?utf-8?B?cWxiWmdYOFFBOGpXcGZTazV4R3VoaEhXZ0VITTR4T0krZWlzekZrcVpCL1Z6?=
 =?utf-8?B?aXlqQ1BudjY1SUVQZnkxVGVETmRIeVNKeEduenpxVkg0VGlVZ0tqT21USlBW?=
 =?utf-8?B?cEY0NnFvOFBUeGovcS9COWF0ZjhFSTlTSFBjbGU0bGJ5ejU5VnBDWC9uVlFW?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7198e3f-327b-4bb6-ca65-08daaa9070c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:24:17.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXfUFvS2hQ+eM2qv2OUN6KGOX0JBFitTKZadF+0rwoUDr8kbOwv9Ewd9lX4uo64LLgnK3U+Taz4cPsRHSQazErm3mB1H0sFKcI5afDdHlSperDwiw0bk9JQ9hYsgeZhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6267
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10.10.22 9:18, Nadav Amit wrote:
> On Oct 7, 2022, at 3:58 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> On 7.10.22 0:07, Nadav Amit wrote:
>>>>>
>>>>> I was looking through the series and I did not see actual users of the
>>>>> notifier. Usually, it is not great to build an API without users.
>>>>
>>>>
>>>> You are right. I hope to get some feedback/interest from potential users that i mentioned in the cover letter. I will probably split the notifier
>>>> in separate series. To make it usefull it will require more changes.
>>>> See bellow more about them.
>>> Fair, but this is something that is more suitable for RFC. Otherwise, more
>>> likely than not - your patches would go in as is.
>>
>> Yes, i will remove the notifier and resend both as RFC. I think that every patch is an RFC and RFC tag is used for more general changes that could affect unexpected areas, change functionality, change design and in general can lead to bigger impact. In the case with this it adds functionality that is missing and it could hardly affect anything else.
>> In essence it provides information that you can not get without it.
>> But i will take your advice and push everything thru RFC from now on.
> 
> Jus keep the version numbers as you had before. That’s fine and better to
> prevent confusion.

Sure, i will.

>>>>> [snip]
>>>>>> +
>>>>>> +static int balloon_notify(unsigned long val)
>>>>>> +{
>>>>>> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
>>>>> Since you know the inflated_kb value here, why not to use it as an argument
>>>>> to the callback? I think casting to (void *) and back is best. But you can
>>>>> also provide pointer to the value. Doesn’t it sound better than having
>>>>> potentially different notifiers reading different values?
>>>>
>>>> My current idea is to have a struct with current and previous value,
>>>> may be change in percents. The actual value does not matter to anyone
>>>> but the size of change does. When a user gets notified it can act upon
>>>> the change - if it is small it can ignore it , if it is above some threshold it can act - if it makes sense for some receiver  is can accumulate changes from several notification. Other option/addition is to have si_meminfo_current(..) and totalram_pages_current(..) that return values adjusted with the balloon values.
>>>>
>>>> Going further - there are few places that calculate something based on available memory that do not have sysfs/proc interface for setting limits. Most of them work in percents so they can be converted to do calculations when they get notification.
>>>>
>>>> The one that have interface for configuration but use memory values can be handled in two ways - convert to use percents of what is available or extend the notifier to notify userspace which in turn to do calculations and update configuration.
>>> I really need to see code to fully understand what you have in mind.
>>
>> Sure - you can check some of the users with git grep totalram_pages - shows self explanatory results of usage like:
>> fs/f2fs/node.c:bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type) - calculations in percents - one good example
>> fs/ceph/super.h:        congestion_kb = (16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
>> fs/fuse/inode.c:                *limit = ((totalram_pages() << PAGE_SHIFT) >> 13) / 392;
>> fs/nfs/write.c: nfs_congestion_kb = (16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
>> fs/nfsd/nfscache.c:     unsigned long low_pages = totalram_pages() - totalhigh_pages()
>> mm/oom_kill.c:  oc->totalpages = totalram_pages() + total_swap_pages;
>>
>>
>> So all balloon drivers give large amount of RAM on boot , then inflate the balloon. But this places have already been initiallized and they know that the system have given amount of totalram which is not true the moment they start to operate. the result is that too much space gets used and it degrades the userspace performance.
>> example - fs/eventpoll.c:static int __init eventpoll_init(void) - 4% of ram for eventpool - when you inflate half of the ram it becomes 8% of the ram - do you really need 8% of your ram to be used for eventpool?
>>
>> To solve this you need to register and when notified update - cache size, limits and for whatever is the calculated amount of memory used.
> 
> Hmm.. Not sure about all of that. Most balloon drivers are manually managed,
> and call adjust_managed_page_count(), and tas a result might want to redo
> all the calculations that are based on totalram_pages().

Yes, i will say that it looks like mixed manual - for large changes and 
automatic for small changes. VMWare and HyperV have automatic and 
manual/not sure exactly what you can change on a running VM but i guess 
you can/ - Virtio is only manual. I do not know about dlpar / xen.

Scenario is like this start a VM with 4GB ram, reduce to 2GB with 
balloon - vm can be upgraded.

All we are talking about relates to memory hotplug/unplug /where unplug 
is  close to nonexistant hence the balloons are used./

All values should be recalculated on memory hotplug too, so you can use 
the newly available RAM.

RAM is the most valuable resource of all so i consider using it 
optimally to be of a great importance.

> Side-note: That’s not the case for VMware balloon. I actually considered
> calling adjust_managed_page_count() just to conform with other balloon
> drivers. But since we use totalram_pages() to communicate to the hypervisor
> the total-ram, this would create endless (and wrong) feedback loop. I am not
> claiming it is not possible to VMware balloon driver to call
> adjust_managed_page_count(), but the chances are that it would create more
> harm than good.

Virtio does both - depending on the deflate on OOM option. I suggested 
already to unify all drivers to inflate the used memory as it seems more 
logical to me since  no body expects the totalram_pages() to change but 
the current state is that both ways are accepted and if changed can 
break existing users.
See  discussion here 
https://lore.kernel.org/lkml/20220809095358.2203355-1-alexander.atanasov@virtuozzo.com/.


> Back to the matter at hand. It seems that you wish that the notifiers would
> be called following any changes that would be reflected in totalram_pages().
> So, doesn't it make more sense to call it from adjust_managed_page_count() ?

It will hurt performance - all drivers work page by page , i.e. they 
update by +1/-1 and they do so under locks which as you already noted 
can lead to bad things. The notifier will accumulate the change and let 
its user know how much changed, so the can decide if they have to 
recalculate - it even can do so async in order to not disturb the drivers.

>> The difference is here:
>>
>> mm/zswap.c:     return totalram_pages() * zswap_max_pool_percent / 100 <
>> mm/zswap.c:     return totalram_pages() * zswap_accept_thr_percent / 100
>> uses percents and you can recalculate easy with
>>
>> +static inline unsigned long totalram_pages_current(void)
>> +{
>> +       unsigned long inflated = 0;
>> +#ifdef CONFIG_MEMORY_BALLOON
>> +       extern atomic_long_t mem_balloon_inflated_free_kb;
>> +       inflated = atomic_long_read(&mem_balloon_inflated_free_kb);
>> +       inflated >>= (PAGE_SHIFT - 10);
>> +#endif
>> +       return (unsigned long)atomic_long_read(&_totalram_pages) - inflated;
>> +}
>>
>> And you are good when you switch to _current version - si_meminfo_current is alike .
>>
>> On init (probably) all use some kind of fractions to calculate but when there is a set value via /proc/sys/net/ipv4/tcp_wmem for example it is just a value and you can not recalculate it. And here, please, share your ideas how to solve this.
> 
> I don’t get all of that. Now that you provided some more explanations, it
> sounds that what you want is adjust_managed_page_count(), which we already
> have and affects the output of totalram_pages(). Therefore, totalram_pages()
> anyhow accounts for the balloon memory (excluding VMware’s). So why do we
> need to take mem_balloon_inflated_free_kb into account?
Ok, you have this:
                                    / totalram
|----used----|b1|----free------|b2|

drivers can inflate both b1 and b2 - b1 free gets smaller, b2 totalram 
pages get smaller. so when you need totalram_pages() to do a calculation 
you need to adjust it with the pages that are inflated in free/used 
(b1). VMWare is not exception , Virtio does the same.
And according to to mst and davidh it is okay like this.
So i am proposing a way to handle both cases.

> Sounds to me that all you want is some notifier to be called from
> adjust_managed_page_count(). What am I missing?

Notifier will act as an accumulator to report size of change and it will 
make things easier for the drivers and users wrt locking.
Notifier is similar to the memory hotplug notifier.

-- 
Regards,
Alexander Atanasov

