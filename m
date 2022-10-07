Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1575F771E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:58:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435D7F10B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfc3ir92iPyDaVt0t8apr+6GU9sVzSKNuH9PGc5uwH9VmrWAH2DHK4QMIvYjiHUuZnTAx5tdSqIizG1XYRuhkbvlvNU1ePMIHxJ7ByxmQTjZ4YI1xRb9K8e4jCfWkhv3VSmz/jgytaxRea0FG/3gfjTreoRxEN74EaieYN9DP3pZt6+n41mbkqdWGBWj5TgmAYIAZmuBxDtTbxbhZIcVaBep5cbVRJqkfPQkU4SO0Ys/5mpB3H4pxsdQInw3o2I1x5/Zs5YMYmnE0NmpeLaP5XLgbyEiilLt8h0vb80KeALHcMJZXPxLe3nPdJ7zuZ/scMH/5jxEv+bRwgCGJBFDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p08amR1JgMOTmdZx5cxS/m29rLs7JbKNrBTQWjmJN0=;
 b=Bafbx/agCCyr2SiCKNGc7Mp12uggHuwrnUEUNINSbl0tx9vsx6yzawrGAEYoWqHm1D0Z0xNGKIPpB7rMVxUWE27b37dSi6p3leDWFbqC8ahbWWi7q9yRLpcCkN0ZMH8YUMNBaMYH5b+NSsjymswXWon/sRACydFm31c+QG5uLJ/7bklqbIH/c0sMnnlS1kzqILXv2rpUu91Hf2DlM3rcohAoMjSFc6vEg/YucAPW2zHWeMZuTk90ZuC46cvzofDso+I4DbK7pqbz8/XpPn7TRAcXqgzDadM86rsCWanHPz4pJ3v9WsRU83x7wn+LCLAffUa7fxNJkzOpgpsz/FSSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p08amR1JgMOTmdZx5cxS/m29rLs7JbKNrBTQWjmJN0=;
 b=F76qOr5jjWGfFSly+OlrOgDFhl+3z36H6399eq+H9cDbqbT5GzE61gp5PwXKgJLGJmcmwpaO7u0yNXMiLtRWv8VkkuYMmteQ7VIUlUuTpKygHHmd3RRPIh5OKil/ipgJVxytBlZ1ppROp20ML4/hALVvkCnvuh4PdNJXLqD39tJprMFVXOnLma++TLAiHoQYkKI8v64anFFq2IleBbITNnR1QpS7YEADyj5dcsOAR/+tiS7Q1RPZCTBBznMFwPga1GjnOPPNEmsOf4dmt8I6Aa4KkEMjt5b5N3HNcx7eN8xH+uK0zXbCIjehG39WE+6oqd1mYiilHyphUI7G8AJUWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB9PR08MB7676.eurprd08.prod.outlook.com (2603:10a6:10:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 10:58:50 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 10:58:50 +0000
Message-ID: <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
Date:   Fri, 7 Oct 2022 13:58:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DB9PR08MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f9c133-2b9e-4bfb-ec89-08daa852eaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3XYmzuhN/a254ckFqyusGT00gKWKzr8avlfTIKLLziu1X9x04E0vjsS0BFBJGU9MEC7G18YnzF3nkzIbYGShqHcAi+5/1zHktgGAgVzGuxhT2FbfyYl2m+pdf8zoNNYKuP2b1LF7tqdOhZ9T2RW/JRvxFVIDRarX/txyjyuWzhg1GhhMVD1rxc5FR4mAd9H2rde6b7CScNnXgIXMT/Lvw6BZiaI+pdVsKgVxqG107ofT3idwyN9l+V0aCJz3DWvrABjT42DB4rBDK8c2lzWBTDc9Bpu2LzPXWtwAQ3GnAuqepCpvl8FUHyWgifiE/oYxiu2DZ2/pZBKZWPovPXEtj3OMzspLZsvnxR5Jo3m565oan4P19TdiXHhqodSm4vxB1orpTGDePOIBOx7MQUPOn3pdSGzmi3KevgQY1toLpIYTXXEYIT6/efAcds6egTBHBFabdmleh0t2S+mMEN7tGhGeNTq7PUHmBtGUqbPxBlPq4bwaLbkWFV7n9NOzaWFKrHXqQEmcVEBXLXFOuB9A3ulHhQZvkBoVeGFX1u7VRtvB7TdWYbSRIBCR9bgQYZUhTvopL5JASVXlTYIil+R56lqW/IcFA9Da/i3YRrn8doBHcZDEdmotW+2lbHn/9IFn1gNaLBUJXJ3tBoQND3FiymhW8N6sz6n7MTvWQ/Go/Vom4UU+hYAOCvhWpxzZz1yBC9Ug8k4QlRb2FuinEJlEAbBa7Z5BppSB5yGYZ75MFNQn/0lO/5ddQd0KtxDmjje+7bxgK7J8Y1x/edDy3lEW5S2+t3CLqPQ6tYnhFhjAtwlmQ5wy39pHIp5ZCs3qQrUy7+Py5fD8/l0+R+/XFAN3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(451199015)(66899015)(31686004)(41300700001)(5660300002)(2906002)(44832011)(6506007)(8936002)(8676002)(2616005)(36756003)(38350700002)(66946007)(6486002)(38100700002)(86362001)(478600001)(52116002)(66556008)(6512007)(6916009)(31696002)(66476007)(4326008)(26005)(316002)(53546011)(54906003)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk00dm8weUNEQW1zclJxNDZoK1FuS2dKSDFldjlla09kSnZBUEIvZG9LMjBj?=
 =?utf-8?B?N3NtaW5aT0N4NG84dTZFUzh2aDhiWUo4azBsallmVjRLMzdYQ2I1RTFXVUVw?=
 =?utf-8?B?VFI1QTJ5MmJjSnRvejN1Y3M4WktuTG5kWTVGZWFDUTEzZ3RjRE5xbUZOQ081?=
 =?utf-8?B?Qis0VldKQkl2U2ordDBFUDVSaHpkazBmZ1RpbXNBWGw0c0QycUhIWkpMc0FQ?=
 =?utf-8?B?MjBkZ3pOa3BCM3VLdWwrbEhxS1Fnb3pBU2txK1B3MWwyT3NCQUVpVUoxZWVU?=
 =?utf-8?B?SDJ6NHNjQlB5Y1QvNFN6R29TeTYrRzQwZ3VFSHIwRHJ0NEpOMzE4NTNzeUFB?=
 =?utf-8?B?VXJvajVyM1JsSkEwM1BWNko4TXhPYnQwc1MxOExLTmpObS9CNjJCMk5MOGt0?=
 =?utf-8?B?eVFva0hGd1BBc3dKVS9hY3RoUm5MZm5pMTlNL3FrNGR2WEtNTTR2OTNGdUhW?=
 =?utf-8?B?Sy93aDRRT2dNOGZqRUs3dllCK0cwbTIvM3BBTE9ibkwyUnJId1hMS3grb1BM?=
 =?utf-8?B?dXhDZlF4Z09xRXhKeis4N2lkYXNLZGtKdkIzTElWV2JuR0lnN2ZvT1RxbkJq?=
 =?utf-8?B?OUMwdHg5MjhmUzVVemdKTWQya1lTNCtQVlV2WHRnbjBYQmV3L2crOFozaGpJ?=
 =?utf-8?B?TU1oZG5aMzl2b0o1OFllR3BmWlRKcnJlUXh6cEFTOFBoelNzTW9TVlBjRVk4?=
 =?utf-8?B?TDVxVXlrS0RtOE1JQ2oyelpqcjZZa0ovSFNkMEdvanhZYkFMR1VFSlptTTdY?=
 =?utf-8?B?T2pDZ29IZWs4THB5Ulc3UUxYaVVMSGRaYkhKdWZxeDNQUEJjdlJRaVRkQkpB?=
 =?utf-8?B?bEd6S2loSXRIVkk0U3c5S2VMKzBBbis1WnFrb08zcVRuM2NaU2xzWFkwZnQv?=
 =?utf-8?B?OU5DTTlDaUJ4K3RmZENoQkR0OGVzM3NTdVJBR25lUXRZQWwyOXpSRHkxckNj?=
 =?utf-8?B?RnJmbWFYOW5DTy9NVnVFRGM4bThuVWlFclBOWS9hVmNBaXA1Q21XL1pnbS94?=
 =?utf-8?B?c01ITUpMQXM3RnZoeUFNTENKamk1amR0eEJKdm5ZM2cwbmNmY1IrbXA0VUFz?=
 =?utf-8?B?eldQNm0yRHBBNFVxSWNsWGcvRU9hZU91Z3NJV1Y0cWFIdHNBQllSOGF6VmxZ?=
 =?utf-8?B?azNEc2twU1JROW4yOFFpdEtkcjhRZUIvMkV5ckwxN28rSnVqbFdPWUxyZHhC?=
 =?utf-8?B?U1JJcWQrU1RVRklGMUkzb2tNU29nbEtwMFZLRU1uc29tQ0VoOXRnZDNCK3lG?=
 =?utf-8?B?MCtpMGhIYkVYQ1pYdkVJUldvNFFDd1F2OTFOZ1B1Q3A5UHlZNUdQN2hzNVFF?=
 =?utf-8?B?YnZuemZBZnd1QlpsenFJTjhaNzNlQjlGTjZKQnBSdUdRTzV4K3IvYU5SNG14?=
 =?utf-8?B?bWVGTWE5cXg3NWlzdlU1cHlTcHRaZjM3WEcxeThTbDllQndxWmgvOTJJajhH?=
 =?utf-8?B?dS9QcE9KSkc2SE1UL3VyaWwvVWZ4SHlpVXRsdFdzYWFadDRNaGw0a1gxQ0Nx?=
 =?utf-8?B?THB4UEFUeFRVMGU3Q29EdGF0SzBIbEpRSUh5aWpUWVZSd3BnNFZUcE9pUzlj?=
 =?utf-8?B?SWdMdzQ0TGtMc2hwbHhHZVptVVd6Wk9TMFVjQ1YxaGlSb2ZWTUZ4Rm1uTXo3?=
 =?utf-8?B?dEI1c3diYnUzZHNaODFiWmJUZzloamlMQnduU0hONy9lRm81TGNQWGU5YkZJ?=
 =?utf-8?B?MS9lNjRvUjdNSU53aEs5OTJHSlFzYTA5OWdJbDFid1NqbFgyNlBCbk5vdUFm?=
 =?utf-8?B?bjNWZGlqV2x0Zmp3eHcxMTl5YmYrcWkvM0UwVXA0VU1FTzdRODR4MGF6VUxE?=
 =?utf-8?B?K2t2dnF4VEFaKzdZZWVvZG1BYktPRmthYlg1MFlrOFRBWVF5c1BaRkVOQ014?=
 =?utf-8?B?Z3gzVWhxQVBBbEJOVGE5Y2FVbWRRLzBESWpWOGIyWjBORlVxZHhLVVJ3Skla?=
 =?utf-8?B?dHBIR25VUytPK1BCMERrUkUzSHp3SldSOWJLdTZDSm91OUVHQzFjeWRNYWxO?=
 =?utf-8?B?L3pVb0NWV2xwL2NyeXU5cmIrNmlJSTJPcjh5eVN6dG9Ya2ovZ0JVcEpBYWJT?=
 =?utf-8?B?ZVRpNDhicDRJWHI5REVjSUIrYzNyMFlibjdiNVI1K2c1Z0EwNUs5UEt4WkNB?=
 =?utf-8?B?UUhKT0VYZ0VleW1SSFlVdVBhNjRTdUJvZGxXRnpUREN1TWJPM3RFdmlKSDZK?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f9c133-2b9e-4bfb-ec89-08daa852eaac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:58:50.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jry+9978ypsBV8p0oeR4bpRcZ3fZBTphVMjRI+OMvPOvSVVsAW2xdMW9w8PIt5QIUC7tAC2poUDp5spf/zAd3YdvzBJfkyzqV+vpCs9WtAr5wr1uWOJMXG+zxW7k4oDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7676
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.10.22 0:07, Nadav Amit wrote:
> On Oct 6, 2022, at 12:34 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> Hello,
>>
>>
>> On 5.10.22 20:25, Nadav Amit wrote:
>>> On Oct 5, 2022, at 2:01 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
>>>> Add counters to be updated by the balloon drivers.
>>>> Create balloon notifier to propagate changes.
>>> I missed the other patches before (including this one). Sorry, but next
>>> time, please cc me.
>>
>> You are CCed in the cover letter since the version. I will add CC to you
>> in the individual patches if you want so.
> 
> Thanks.
> 
> Just to clarify - I am not attacking you. It’s more of me making an excuse
> for not addressing some issues in earlier versions.

ok, i am glad that you did it now but i do not think you need to excuse.

>>> I was looking through the series and I did not see actual users of the
>>> notifier. Usually, it is not great to build an API without users.
>>
>>
>> You are right. I hope to get some feedback/interest from potential users that i mentioned in the cover letter. I will probably split the notifier
>> in separate series. To make it usefull it will require more changes.
>> See bellow more about them.
> 
> Fair, but this is something that is more suitable for RFC. Otherwise, more
> likely than not - your patches would go in as is.

Yes, i will remove the notifier and resend both as RFC. I think that 
every patch is an RFC and RFC tag is used for more general changes that 
could affect unexpected areas, change functionality, change design and 
in general can lead to bigger impact. In the case with this it adds 
functionality that is missing and it could hardly affect anything else.
In essence it provides information that you can not get without it.
But i will take your advice and push everything thru RFC from now on.

>>> [snip]
>>>> +
>>>> +static int balloon_notify(unsigned long val)
>>>> +{
>>>> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
>>> Since you know the inflated_kb value here, why not to use it as an argument
>>> to the callback? I think casting to (void *) and back is best. But you can
>>> also provide pointer to the value. Doesn’t it sound better than having
>>> potentially different notifiers reading different values?
>>
>> My current idea is to have a struct with current and previous value,
>> may be change in percents. The actual value does not matter to anyone
>> but the size of change does. When a user gets notified it can act upon
>> the change - if it is small it can ignore it , if it is above some threshold it can act - if it makes sense for some receiver  is can accumulate changes from several notification. Other option/addition is to have si_meminfo_current(..) and totalram_pages_current(..) that return values adjusted with the balloon values.
>>
>> Going further - there are few places that calculate something based on available memory that do not have sysfs/proc interface for setting limits. Most of them work in percents so they can be converted to do calculations when they get notification.
>>
>> The one that have interface for configuration but use memory values can be handled in two ways - convert to use percents of what is available or extend the notifier to notify userspace which in turn to do calculations and update configuration.
> 
> I really need to see code to fully understand what you have in mind.

Sure - you can check some of the users with git grep totalram_pages - 
shows self explanatory results of usage like:
fs/f2fs/node.c:bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, 
int type) - calculations in percents - one good example
fs/ceph/super.h:        congestion_kb = (16*int_sqrt(totalram_pages())) 
<< (PAGE_SHIFT-10);
fs/fuse/inode.c:                *limit = ((totalram_pages() << 
PAGE_SHIFT) >> 13) / 392;
fs/nfs/write.c: nfs_congestion_kb = (16*int_sqrt(totalram_pages())) << 
(PAGE_SHIFT-10);
fs/nfsd/nfscache.c:     unsigned long low_pages = totalram_pages() - 
totalhigh_pages()
mm/oom_kill.c:  oc->totalpages = totalram_pages() + total_swap_pages;


So all balloon drivers give large amount of RAM on boot , then inflate 
the balloon. But this places have already been initiallized and they 
know that the system have given amount of totalram which is not true the 
moment they start to operate. the result is that too much space gets 
used and it degrades the userspace performance.
example - fs/eventpoll.c:static int __init eventpoll_init(void) - 4% of 
ram for eventpool - when you inflate half of the ram it becomes 8% of 
the ram - do you really need 8% of your ram to be used for eventpool?

To solve this you need to register and when notified update - cache 
size, limits and for whatever is the calculated amount of memory used.

The difference is here:

mm/zswap.c:     return totalram_pages() * zswap_max_pool_percent / 100 <
mm/zswap.c:     return totalram_pages() * zswap_accept_thr_percent / 100
uses percents and you can recalculate easy with

+static inline unsigned long totalram_pages_current(void)
+{
+       unsigned long inflated = 0;
+#ifdef CONFIG_MEMORY_BALLOON
+       extern atomic_long_t mem_balloon_inflated_free_kb;
+       inflated = atomic_long_read(&mem_balloon_inflated_free_kb);
+       inflated >>= (PAGE_SHIFT - 10);
+#endif
+       return (unsigned long)atomic_long_read(&_totalram_pages) - inflated;
+}

And you are good when you switch to _current version - 
si_meminfo_current is alike .

On init (probably) all use some kind of fractions to calculate but when 
there is a set value via /proc/sys/net/ipv4/tcp_wmem for example it is 
just a value and you can not recalculate it. And here, please, share 
your ideas how to solve this.


> Division, as you know, is not something that we really want to do very
> frequently.

Yes, thats true but in the actual implementation there are a lot of ways 
to avoid it. But it is easier to explain with division.

Even if you do have to do a division you can limit the recalculations
struct balloon_notify {
    unsigned long last_inflated_free_kb;
    unsigned long last_inflated_free_kb;
    unsigned long inflated_free_kb;
    unsigned long inflated_used_kb;
}

So you can do it only if change is more then 1GB and you do nothing if 
change is 1MB.

> 
>>> Anyhow, without users (actual notifiers) it’s kind of hard to know how
>>> reasonable it all is. For instance, is it balloon_notify() supposed to
>>> prevent further balloon inflating/deflating until the notifier completes?
>>
>> No, we must avoid that at any cost.
>>
>>> Accordingly, are callers to balloon_notify() expected to relinquish locks
>>> before calling balloon_notify() to prevent deadlocks and high latency?
>>
>> My goal is to avoid any possible impact on performance. Drivers are free to delay notifications if they get in the way. (I see that i need to move the notification after the semaphore in the vmw driver - i missed that - will fix in the next iterration.)
>> Deadlocks - depends on the users but a few to none will possibly have to deal with common locks.
> 
> I will need to see the next version to give better feedback. One more thing
> that comes to mind though is whether saving the balloon size in multiple
> places (both mem_balloon_inflated_total_kb and each balloon’s accounting) is
> the right way. It does not sounds very clean.
> 
> Two other options is to move *all* the accounting to your new
> mem_balloon_inflated_total_kb-like interface or expose some per-balloon
> function to get the balloon size (indirect-function-call would likely have
> some overhead though).
> 
> Anyhow, I am not crazy about having the same data replicated. Even from
> reading the code stand-of-view it is not intuitive.

If such interface existed before the drivers it would ideally be like 
that all in one place. But keeping the internal (for the driver) 
representation which may differ from the system and the external 
(system) representation separate is a a good option. if a driver can 
convert and use only the system counters they can do so.

-- 
Regards,
Alexander Atanasov

