Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E65FAF12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJKJHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJKJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:07:35 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2092.outbound.protection.outlook.com [40.107.103.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8D220E1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dip6R2dxODmYn+bZdmVl35QRNbjwYHL7/oH6cslTH2+UplLCgjgWzrqOeGTUz8d3QRJBpqhBjHvEI2BQT/WGg6b4nVIXPmvxkDZwHrzpSERixsLaKkXZHkaRGGBxpF0HB/A64lH8zauWmC2gJ212A3FdqrccvWQJiIqyGKegMl6Eth/MD79tfqXRTBkCeHFDVNlfQim0kmwJ7zdg+/h6WULp5eECcLPvRkHQddf9203F55la/J11/ypUvMJrn+BYJoBu8/dL9Of1et3W4pNS3Rl0kGQWTlgHT842nScmasTUcbdVgclboqi3j7OzYd6KMU915d5L/6TtcbHv3bKcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aveS7Oc2DgajbrPwXJIs0BkKfhw8UP8x8pZe/pkwvuU=;
 b=Ltr8jIbMlx9zRzbk4RroGf847fa4iEBu2qQV7AtZy+9An6xEgF43jVTM5bqEFY6O7Wus0qfzFcjrNztNrl+zEfrkhEJFtW2LppWE0Mrv+nwXMR0T+QuCkGykmspKTxfbGatZQIiW/0mxv5bBSck+9U+CArowM6HuRM2FyELlNePn40hmgMotgQ0fvsXXGyhxjhxU/SvhnMHYfCqidk5IX0nuNp+QCEttaeFqgwzJ5R2meWM0omvqsAyFDsrtMYwj513MdY0IdVQMD7nUfheCie4Se9E62dr9bSF9Y+FcKyJmvSKYQlyznGbXY01Gdikqvcbmiv34x43SfmJZyQ4L2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aveS7Oc2DgajbrPwXJIs0BkKfhw8UP8x8pZe/pkwvuU=;
 b=fijy0y+Qc2CJ1Y1Nt7PSy6NxCvMn4WYaSewWyxqwq0h362nAMXjBzokBL4Dn8id/JyQozc/ucg3qyr+UwPq3lhomzlQa+SSdMpkYIMB9OtyeZ+n0xzSel8T2a1v8xj/EMioOzlEGeloNvs/cIOIQPFGQkyEpE0FD5erOb8VO//jO6fzwqNM7b5KFjfMYxmCqDSaqXdveuF9WsQ8EgDrqP1fRW+y6Iz0nTwDVc473tc0pMg2U+fsMZqdYzqGuirn7Rtb3xjFcxW8Lh7CQrm+QaFGDtEXx957BQaK4NgzYCcyLLet42EiI3YkSoqpVrUgwLiFK+n8QOmLcR1rlTQZWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB9PR08MB9729.eurprd08.prod.outlook.com (2603:10a6:10:45c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 09:07:30 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 09:07:30 +0000
Message-ID: <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
Date:   Tue, 11 Oct 2022 12:07:28 +0300
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
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DB9PR08MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: d6598222-2a25-443e-79a9-08daab68069a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0+0ZhAdcEqt81LoF70VNcU2GkTMzP2RMgARfHPIh2mx7KFellMDjmCkVEAe2v8SVLJ8UzTwOqlT0FZ64pw+dbpMjBDPnHGnavlhxCiYPDdtAaZWDkZ/p3jibCjdRK/en72svzSwvA+soipGPlRSDCgBvYZ9zmnwnapIxA9Ugs8bonVk9mkfuaicEtaK0Lg7TGHdZ3wglRT90hJrOiwDySqHZqkyfZ7h2qGvGF4GjLENIJQg9g5vz7fqxJ7ATY4RCbKGiugrIip7xlFhYClNhn2VZAXZM643e1UoSLHiQu0k5toIEsHIHEyfotVW6hLcXUFJDgxIOe+/2Sb62E2NIHF7yvi97mnVkFSiPPaNdOXtSIjIXLbdBOcoMDBPdIBRCMLL5fUHjY9pPOaLSEQEjKba4i/tDIaKKmnkjGW4TiLNeMohkMChLOj2L6d391xwe8/qR+giJbvMvezT3EzJNbSREzvDVR0+FlQETdT9CZPvNHgxgEEe50/OyyewnSxH7JzknW9jGqTVFOCf/l2DiM4nw75j9X3njxOMapceFGQPYZPJcCwv9CPfb754b2nscEcSQikhp/bEqAioctnFlT3Vt+0oSr/uGq5wBRaUB+yAYb+ZTnawwKm61jkMtEoLUZhl8vlnITe9u2Mhx1YWfvwiOOY4w+b7v1Axko5uoVJQwo9mDS+QZGthlKlIZUAEib46adpwcwM/KQHJa/NXsMrmxrK6GHwaiuTP2de/qnh3ujI+5Vd2oUFS/DcZy73V+y3CI+KnytauiQDyASa0C9FKXD3X8jVsX3wzUrq7KACbyzjRpBe1iFeW+bDZlaTZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39850400004)(346002)(376002)(136003)(451199015)(31696002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66476007)(316002)(66946007)(6916009)(2906002)(36756003)(8936002)(44832011)(54906003)(966005)(5660300002)(41300700001)(186003)(2616005)(6486002)(6512007)(83380400001)(478600001)(6506007)(26005)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmd0ajZoN1U3Wm5EUWxKZEZUdjM5NUxYWjBBcFVIZnJCMTNRcUJLaElXaW1s?=
 =?utf-8?B?VkFkQVU3bUxKNFRmQjBJbml3SElwQkl1d1kwOGFzQXJXNWxUZmJkTDI2QkNj?=
 =?utf-8?B?VjVlcmlxM0pXZEsycHNOSDAwbUprZmJtVWRLbGlJcTlXSmtmMktpTVRNT20x?=
 =?utf-8?B?RWk1V0YxY0pnSmUvNnIzZk5VSlJ3QU1wbGdnVTBtVGVtNU5NOWNzakNwdHoz?=
 =?utf-8?B?UWN1enpPaHZ6QWZuWk4yMXhUdm54dmFUdU5sT2hWNHJGeno0bEwydFdHeHNP?=
 =?utf-8?B?WjVDdVpXVUlYQkI4ZUYxS1RPV3k4QkdBRmNOUGY1QzFFSnNrTEhQNll1am56?=
 =?utf-8?B?eVdFTVlWRzVIaDhkSTJ1STBReElKVW5ZNnhhS0dvd0JMejMvRU00QVVka09M?=
 =?utf-8?B?cE5VcXdtVXFXMCt2QUgwbWppUHlwVm5xcmxQWlk3ZU5vQ2xjRDJ0bkh2djBZ?=
 =?utf-8?B?U2l2WEg0M3NuZXBFVWgwenhyK1N3cXdBQ0I2RjBoMEw1Qm1NT3JRUTg5SUta?=
 =?utf-8?B?eVNoMlQzdWhnVGVuOVlVOW8vcnBrL1E0Tmg3d2hpcThYbGhua1R5NEowdG1N?=
 =?utf-8?B?SUxiOHNHclZLdGdwRW9QdVNidUU0ejB6MC93Vy82RzIvaEJ6TmVwdXFMWDJy?=
 =?utf-8?B?QnpPcHlIdUxmdVJydENoeVoxTGRyUjdkdDFHRnp3RXFldkkydkwxTUxHMWxn?=
 =?utf-8?B?VXF0a3AzUzJpZSs0eFdNNU5lRW5nclVyR2k4QSsxVWF5ZXZCNktMYjM4ZEFh?=
 =?utf-8?B?c2lXTlphaXNabmUwNHFWZmFSdTRVTFh2R0FIZ0JEZkRzS1dmZDFzK3VqOTBu?=
 =?utf-8?B?anNDVW9PZDY5eGhvc2ZLVUhiNDQzcHJJdHlwUHNyRmhZM3VaQy9HT1pFWENW?=
 =?utf-8?B?ZUNNNEVxTEN0aVlmclRtUlZoUW4xbkE5aUdmNm9BTHYrTFd2MVk5clY3V1Ns?=
 =?utf-8?B?K25GMkNFNlg1cTBlZWx6cXlOTmhLQi92RzlkMytjOFJrRHlpRVJRZWowOUhX?=
 =?utf-8?B?d2t1bU9ybFM1ZjE3Z0hZUElSSlRuMGlqTG4xRzRKQzlFU2pHaHhqQ2xoOFJz?=
 =?utf-8?B?b09ZT1ZyR1MxQkx2QWxPUndSK3hwOUJOcEV4R0ZSNUpMTVY0VVJaeEhTcE9S?=
 =?utf-8?B?bmFhRGNEZ29iMVZVcXpiN1VzakZIekxwMzJJbTRmaVBmc09Oc3BRRnMvVzBJ?=
 =?utf-8?B?a2QyRWhNMDE0blRkWVNISE0veGdTZU85K0YrTm0xdlVBZ1k1dlIyZUFZNmtK?=
 =?utf-8?B?RGYrbzlyNmdtU2UzSXlibm9VL3daVkxYSzEwOE1OUnhNRVFicmxQL3Y5d0M2?=
 =?utf-8?B?MXlHUS9GNS92NExCRStjM3d5eGxWd3NsRXZCQ1ZWVlVXU0FKSTl6NmpRR2JC?=
 =?utf-8?B?Z0hYZCtTNjN3MjIrSTBYYmFMMThIaUlwVjlxL1ZteHZ1RjhhWCs1MDByWE5H?=
 =?utf-8?B?R3UzWWV2UEpwQURnQXpUVDVkZVlKbURLWnR1T3RkeFNQZkhKdTc2V0grWXNB?=
 =?utf-8?B?dktsUWM2bnlLZXdHcldpdlNIT29Od3JoNHlRbkRoVTN4TWlsTXBQMGw5MFQ1?=
 =?utf-8?B?Q01OUjI3TzhnWnJJK0lBQ0xVbzRnOE5FbXNyU3Nyb0NNVG8weHZEWHdhWEJF?=
 =?utf-8?B?RE9EdnpCZFAyTytaMzdQeGtTVFhuMjhsMm5kVmZRT25ncmNaVTBIOWxDTThF?=
 =?utf-8?B?VEFnWm9mL3drSkhnKzFWeFlzeXVSdnluMC9PaEhOcTQzbEtzODJ4NXFpR2xn?=
 =?utf-8?B?WXNBNSt6QlVZY1VueHo2UGdyYXE3c2VrSmt5c0RJa2paM2xDNlNwbC9uSXZ3?=
 =?utf-8?B?YlRTY1ZIcEc3bERyUzJvWm9QS2NRdy9MeURSd3I2bU9peFpPMkZTMWw2akRv?=
 =?utf-8?B?VXZGT21KOFlKeWFKaTIrNFRUcWQ4aGVsaTIvR1h6cXpYSklsUDFmOWc4dFhK?=
 =?utf-8?B?NGFPc2RDYUFQQzVRUUlldVEzZnBvY3RhNlE3NWFHR29tdzRZbDZ6YVZpc1dy?=
 =?utf-8?B?cTNnNHNDOVcxa2Yxby9SbEd3VTU2aW5vU2QzYlRiZHNFQ3VOWGZmMVNQNkRm?=
 =?utf-8?B?NjdZSDVIYVVVdm0xOVBrcnNxc2ErSzZRQXFkVkNvaTJxWUhxcUJvYjBJbzhE?=
 =?utf-8?B?QkgrR3VNdzZlRnRrbXJMOTBYTmZSK2NOK3dOVEFVL2lqaHZLRi9GUnZJTzZi?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6598222-2a25-443e-79a9-08daab68069a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:07:30.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cIe5l1x9XcO1jsb0NnLDLe1YVTQkhNsAFZcMbaOsWitM8ROOCHS95XyUimfHyQOTwJnHAjrLlnmWy6UfECI5Ver5UiT4Q5XOIWuVLaSXFFeUq3qG8xXTQBEOhHQCCUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9729
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10.10.22 17:47, Nadav Amit wrote:
> On Oct 10, 2022, at 12:24 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> Hello,
>>
>> On 10.10.22 9:18, Nadav Amit wrote:
>>> On Oct 7, 2022, at 3:58 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:>

[snip]

>>> Side-note: That’s not the case for VMware balloon. I actually considered
>>> calling adjust_managed_page_count() just to conform with other balloon
>>> drivers. But since we use totalram_pages() to communicate to the hypervisor
>>> the total-ram, this would create endless (and wrong) feedback loop. I am not
>>> claiming it is not possible to VMware balloon driver to call
>>> adjust_managed_page_count(), but the chances are that it would create more
>>> harm than good.
>>
>> Virtio does both - depending on the deflate on OOM option. I suggested already to unify all drivers to inflate the used memory as it seems more logical to me since  no body expects the totalram_pages() to change but the current state is that both ways are accepted and if changed can break existing users.
>> See  discussion here https://lore.kernel.org/lkml/20220809095358.2203355-1-alexander.atanasov@virtuozzo.com/.
> 
> Thanks for the reminder. I wish you can somehow summarize all of that into the
> cover-letter and/or the commit messages for these patches.


I will put excerpts in the next versions and relevant links in the next 
versions. I see that the more i dig into it the deeper it becomes so it 
needs more explanations.


>>
>>
>>> Back to the matter at hand. It seems that you wish that the notifiers would
>>> be called following any changes that would be reflected in totalram_pages().
>>> So, doesn't it make more sense to call it from adjust_managed_page_count() ?
>>
>> It will hurt performance - all drivers work page by page , i.e. they update by +1/-1 and they do so under locks which as you already noted can lead to bad things. The notifier will accumulate the change and let its user know how much changed, so the can decide if they have to recalculate - it even can do so async in order to not disturb the drivers.
> 
> So updating the counters by 1 is ok (using atomic operation, which is not
> free)? And the reason it is (relatively) cheap is because nobody actually
> looks at the value (i.e., nobody actually acts on the value)?
> 
> If nobody considers the value, then doesn’t it make sense just to update it
> less frequently, and then call the notifiers?

That's my point too.
The drivers update managed page count by 1.
My goal is  when they are done to fire the notifier.

All drivers are similiar and work like this:
HV sends request inflate up/down
   driver up/down
     lock
       get_page()/put_page()
       optionally - adjust_managed_page_count(... +-1);
     unlock
    update_core and notify_balloon_changed

>>>> The difference is here:
>>>>
>>>> mm/zswap.c:     return totalram_pages() * zswap_max_pool_percent / 100 <
>>>> mm/zswap.c:     return totalram_pages() * zswap_accept_thr_percent / 100
>>>> uses percents and you can recalculate easy with
>>>>
>>>> +static inline unsigned long totalram_pages_current(void)
>>>> +{
>>>> +       unsigned long inflated = 0;
>>>> +#ifdef CONFIG_MEMORY_BALLOON
>>>> +       extern atomic_long_t mem_balloon_inflated_free_kb;
>>>> +       inflated = atomic_long_read(&mem_balloon_inflated_free_kb);
>>>> +       inflated >>= (PAGE_SHIFT - 10);
>>>> +#endif
>>>> +       return (unsigned long)atomic_long_read(&_totalram_pages) - inflated;
>>>> +}
> 
> So we have here two values and it appears there is a hidden assumption that
> they are both updated atomically. Otherwise, it appears, inflated
> theoretically might be greater that _totalram_pages dn we get negative value
> and all hell breaks loose.
> 
> But _totalram_pages and mem_balloon_inflated_free_kb are not updated
> atomically together (each one is, but not together).
> 

I do not think that can happen - in that case totalram_pages() is not 
adjusted and you can never inflate more than total ram.

Yes, they are not set atomic but see the use cases:

- a driver that does calculations on init.
   It will use notifier to redo the calculations.
   The notifier will bring the values and the size of change to help the 
driver decide if it needs to recalculate.

- a user of totalram_pages() that does calculations at run time -
   i have to research are there any users that could be affected by not 
setting the two values atomicaly - assuming there can be a slight 
difference. I.e. do we need precise calculations or they are calculating 
fractions.


>>>> And you are good when you switch to _current version - si_meminfo_current is alike .
>>>>
>>>> On init (probably) all use some kind of fractions to calculate but when there is a set value via /proc/sys/net/ipv4/tcp_wmem for example it is just a value and you can not recalculate it. And here, please, share your ideas how to solve this.
>>> I don’t get all of that. Now that you provided some more explanations, it
>>> sounds that what you want is adjust_managed_page_count(), which we already
>>> have and affects the output of totalram_pages(). Therefore, totalram_pages()
>>> anyhow accounts for the balloon memory (excluding VMware’s). So why do we
>>> need to take mem_balloon_inflated_free_kb into account?
>> Ok, you have this:
>>                                    / totalram
>> |----used----|b1|----free------|b2|
>>
>> drivers can inflate both b1 and b2 - b1 free gets smaller, b2 totalram pages get smaller. so when you need totalram_pages() to do a calculation you need to adjust it with the pages that are inflated in free/used (b1). VMWare is not exception , Virtio does the same.
>> And according to to mst and davidh it is okay like this.
>> So i am proposing a way to handle both cases.
> 
> Ugh. What about BALLOON_INFLATE and BALLOON_DEFLATE vm-events? Can’t this
> information be used instead of yet another counter? Unless, of course, you
> get the atomicity that I mentioned before.

What do you mean by vm-events ?


>>> Sounds to me that all you want is some notifier to be called from
>>> adjust_managed_page_count(). What am I missing?
>>
>> Notifier will act as an accumulator to report size of change and it will make things easier for the drivers and users wrt locking.
>> Notifier is similar to the memory hotplug notifier.
> 
> Overall, I am not convinced that there is any value of separating the value
> and the notifier. You can batch both or not batch both. In addition, as I
> mentioned, having two values seems racy.

I have identified two users so far above - may be more to come.
One type needs the value to adjust. Also having the value is necessary 
to report it to users and oom. There are options with callbacks and so 
on but it will complicate things with no real gain. You are right about 
the atomicity but i guess if that's a problem for some user it could 
find a way to ensure it. i am yet to find such place.

-- 
Regards,
Alexander Atanasov

