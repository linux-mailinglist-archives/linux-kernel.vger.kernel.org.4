Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB15F61B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJFHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJFHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:35:00 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130098.outbound.protection.outlook.com [40.107.13.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ABA17896
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owu7to9mLALiWQClHCceLRGMha7Bm74Ve0GXz7GRWsf6rg8s3lnJIhobJeDbcC50csDM0v6xpQo1vrzNh+bylwfvuNhdcqusAgEM3Oer5BPKnBpR7jVGfJdYMGUDrvoP094rTvBv6F/NJU1KRJ4JK2lqwIhmDiFglTKLBA8BZse0oa2O4MkF803PEdKvkEeTb4z8cgKAFEsOoUP5BA16L7//ggyWd47pTCGyBxquFCvnbbYfd78FE/J8k2WfB7/x42zwaU1ogs8Se9rwDC2Zzko479eCD6eRuEldd3PbdGmmieZiAbBqgJZ5A652zDwrEOPLPXWjPY4MrakYvoH+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tvo35KgIb+wAXS/1/b7yE54J4h3k9Ug8eGsy/M1YAc=;
 b=CVruUpu94PuwdnVAfbQ7FE0GS1rHhhw8UnBm18VFRWK+yJ70VzFilLl32mDs/UXNBeklsXrSjf44lgy2QzJEwt9xIE18uqVui6evNIjKAtrXaRDqb0vfqK1HEIDfqwR+qbge16sn7cZTXgpP8WT9Qr29Lx0gOIL90eds9a33L6ktqes7GQZuamC+YAQtcUljjKeoEbRN+CaufVXc95UfYE9z4RmwjoHPQ7xffJpEbhf7d4SGpfzh14ZaGlFqNmEHbWtyDxL8jS7qdE6pPiBuoeWGQ452Z3dyhULXy7ufkoAbBhBKrC9sCrkAJxJt4R2Ws42vpjvmtlexef0aedTkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tvo35KgIb+wAXS/1/b7yE54J4h3k9Ug8eGsy/M1YAc=;
 b=yrMhqC/CfO3HjdUeyscjqbRQrg/ZU5UI6WbVnoWe74TN0zsgTeUIbrg9H9iI8TueGoxegFXGIxBpdg0pASIld71r0SXTDuUX3s1HddaLtLHbjlv4eU+q5tmapS3SlbeKlqqvJa2YXkvHYNJn6x4+tg6PWnMD0L4a65Yp25w6Y9YpgKmVgKAzUmBerSqNqrka24IuIU+ordXoml4mPZL/8xYx69OWJuIDJhtUL75yRrdFRxqwlJfVwYMlOZbVHQFwhuXpAb/6ykFSyz/9dIP/t5xqmae+brHC8V6mijGfuH9g5A4mAm/BJGCHjiqYZ0+NXLlR/g867V87x6Dn4uCi+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS4PR08MB7531.eurprd08.prod.outlook.com (2603:10a6:20b:4fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 07:34:54 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 07:34:54 +0000
Message-ID: <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
Date:   Thu, 6 Oct 2022 10:34:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH v4 2/7] Enable balloon drivers to report inflated memory
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0142.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::26) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|AS4PR08MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: ace9cf16-1180-481d-642a-08daa76d42e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux3LTfkAsJcPL6Y+VZnz//BamOlChhZLDAj0bpCNnQqRFG3KsertSiO49f28yQWQh0vawg62xTL61wQlrb1gDcmCKdReXNXqwOoZGCjq3dUqmcVNJie2s4f9jQCEwj68RzA1fTfcipkQTocnMw5EIlRk4e2RzTaOHgegO3MYA11TkYfkPS9KLrFDn16HfuFlp5JeRVXEIsp2JZGjHAAYQwsvfoEOY8ykr0mYStgr0UId5TY2Z17Vo9jOr7BDWB2l5AIIKhNdK7cZL3W6r19qg1ZuWLs5cM3hG9LCFIA0CewlKE5NxajO8VWF2Hs69l3Xqw3UEjXJ5ySLkrJVC3OkhpBqdQs8GY7mh/s4CLY8vInp8ehcGgSZ8bU7lSz71LXjzSU3jBEzr4Ybwpgbj82c232sK9wpS6T8a2zbXazEUv4F2vSYC9v5Y8k0VlIKHjW+0/v5wcXAugUAu4JOQgjHBjhyFa2DvQOfe74j7MjJMqCOwLk3z4ViYthX3n8Ah8ZhBMb1AXg3IF2+udcNZQDDYPN6DvUPnYrQvvIXYPOYDxChgPEjkXcyIpyUTO3OH5d8QPUAssJAZhqCMjv41lBZjT32PqhiJ1x3Sd5+G9sN5a0hTLPEG2VlykkNdoAqvj64Af+Ui85rep4rONx/VtnORcz3RHGbG3EY1qoBUJ/Cfo3lmz6VRqZHh6eMHmbOXVH9Fa6Z4zoyQ0I3/KpCvCzB6OmMjBA1mkO05UAzGnRjVUTbAZMTiXIBKvLidbvh8kW/Rf2P9AONipyp7bsQboo2ZxzxzHX/T4NJpQE3a8BiKMalhB0clYA040+JfenMBPFd7vvl/tZPry/pLwm0tbjeMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39850400004)(136003)(346002)(396003)(451199015)(6512007)(53546011)(316002)(2906002)(38100700002)(26005)(52116002)(8676002)(8936002)(5660300002)(4326008)(2616005)(31696002)(36756003)(86362001)(41300700001)(186003)(38350700002)(66556008)(66476007)(66946007)(31686004)(44832011)(6486002)(6506007)(66899015)(83380400001)(478600001)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eURLbzIxUWpDYXNZZWRmbWpKTjNSdTJoakJ1eGczK2JrVnNiOUVsb0lqQ0Qr?=
 =?utf-8?B?bXVia3VLNTFyVHV6QnhMRDBBTllhQXNIc0J2ZmFxbFV1b0hjMThRZVlXU1k2?=
 =?utf-8?B?T3pzN1Joa0t6MnlQaXArT1N6OG5kaytteXBaNEtOc0FENnkzU2M3ZkNuM1hP?=
 =?utf-8?B?TndodXJQUkhtVytpaDNyalJNQVMzYllSaWxvUkZiK2FEemEzbzJHOTdaUi8r?=
 =?utf-8?B?NGZRUCt5RDY2MEFza29BNVlHVWpZeGtzVUkxZGpEQlFXQVJwaE1sMU1uTjg1?=
 =?utf-8?B?WVZoNGJNTFV6bFhTQ2pvZi8rYy9YRTA1VUk3MXE4NmZUSHhFUkwwY0x5ejBk?=
 =?utf-8?B?MGc5QmdWQWp6ck5UWU8ydENBdUZqU01ORkdkY294djlhRThBUUJHVXUwTmR3?=
 =?utf-8?B?ZEhvSXUzTzl4V0ZTL3dLV0tiMDl5elpFVmJjTkwvOGY2dXl3b2N2OWtFOThw?=
 =?utf-8?B?T0lvTEZJNDliL1FOYU5LMDdyQnlJZkFzcXVWdFZmelNhVm5tVkZReDZ6cWR3?=
 =?utf-8?B?VXlXMk51QW9UR3dJTzJIb3VnOFQ1b01TeWlhdnUzVStXY0VpS3Q0Z1ZmODhG?=
 =?utf-8?B?OU5STzh5dmNuOGY1bWxUODNhWWpEUGxZQmR2d0pUQ1pJTm01MWF1RkZFdzEr?=
 =?utf-8?B?V2l5YmZvUHdKd3RQemFkdkkyY3hVOTlib3RBbTdYWUx4OWZMWkthRWpFS25n?=
 =?utf-8?B?bkFXMzJsbHNqUnVaSEhJalllT0NCZm5HY2NpNVM4ZWYvRGdMSzJBM3ZiYi94?=
 =?utf-8?B?MFowcGJJeDdtRE5aWUMyVm5wQmFPcjVpSGFUUVZqejdlSzU4MEx2aURGRkRa?=
 =?utf-8?B?OS8vQ0RGQmo0cnRNOFM4bnNraW5ldG9ZdjE2WExhZnRnRWtEMFROUnZiSG9z?=
 =?utf-8?B?dnFzS0UrcSt6N1h4SldldURJWk1iT2JNZDJXUGp4OUdzQjNENEpPdHdZdWsy?=
 =?utf-8?B?VUxiUzR2WEdFbnN5NVpIVGZYS080L0ZSMGVNUk5hSTJRR0d0MUNPL0NFNVRG?=
 =?utf-8?B?Z1pmZzhMVEE1Y2FlK1J2azA4ZHIrUFFWb0cxZWJyZEVCK2NKYlFQMzZ2QzBz?=
 =?utf-8?B?Nkp3UDlvRTR2dGplb29oalpQSzI1ME9KMythQWJtdzY4NW9DVXJnbUlqeHI5?=
 =?utf-8?B?MThFQUFUTVZmZlVCWkUySnptRG9Za202WUFUNU5jdUVWa1I2aEVYd3kvR1V6?=
 =?utf-8?B?bHZVK05NS2RnVEQrOTdiWUZmem53azRVazdXV1gzS1pQUEVsaEpzbkVWRnF5?=
 =?utf-8?B?L0dINktGL0liZGhLZjRWNkVqd0tBcGhhMndlWCtuQW43RVE1MzhUQlpyQWtV?=
 =?utf-8?B?aFZBZFI2dnZTZHl0WkN0WnJBa1RsbTNxZllFZVFiaXRxYmZ1OTYwQzRnQmhl?=
 =?utf-8?B?YlQxcXpHUlZRWURWajhZNkNzMjVOdEYzZFZ6b1pMV2xvL3NzWmpTUjliWWZO?=
 =?utf-8?B?YVovL2ltYjJCOGZKWlNpMXN2bWNpM3UrbXREeTlENitlQnVrbnViRkNqODZJ?=
 =?utf-8?B?b3NYZ0xUbFE4TXRWYy9YSHN3UGMvcXQ4MGtiV3Zabk8wZHNweXc0MFVPSFNu?=
 =?utf-8?B?OUt0MVdZbGRRQ1dsc1cvemN6Q0IzaFpHV3VFWUpadXAvOVU4NHpSSGh0VHBR?=
 =?utf-8?B?ZCtPM0FHZ0RuaWxxNEROZ1ZjRVRvV2JDeTFqV3ZBNVJrK3k2MWtSaDVBZW9u?=
 =?utf-8?B?U3EveGZ1SUlON1RNNnJtY2g4eG8rWDFvREJvOWFQUjkwWk5CTnZpSVhtOFp0?=
 =?utf-8?B?YjFCcGphSkM5dGpnVDM5bWVPc0ZYSjZlM0JUa2lQZ0ErbFlWRFJGVjRXemM4?=
 =?utf-8?B?NG8wajBHUFk4VGkreEd2UVBIRlZlV3A4TEthL1F2S05VSzM1Z0NPclp1MktL?=
 =?utf-8?B?MzVCVHRlQ004RFh4T1FXbFV4cm1qN0FlQUtTOU5pUkJBNHlmd3pXYW9Bekor?=
 =?utf-8?B?b3AyOEtRQ093NnQ0d3RSTi9PSkF3UEM2N29HZTQwSUREdVNrYUd4UFNDT0Z6?=
 =?utf-8?B?dHlqRUJtRkdjWnVwbWREajZ3c3lEOGhNNXpBaUpWM1BnUFZrTXI0eE9ZNlZF?=
 =?utf-8?B?QzJkYTMxQ0ZnelVLeERzVHExVjVuTEtZbGFLWlI1SFdsZFZvUEpMdEVvMTJ6?=
 =?utf-8?B?ZVRERWFFTkRKa01CY3pIZ0JDYWRNUE1mNXRJZ0d1QkxYd1ZzZmFXWWJMdjh0?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace9cf16-1180-481d-642a-08daa76d42e3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:34:54.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wozNDqm6046vwisxxpm1gHNV+enNi6Tqf0Vi9b/RfGALEPcd/Tenr4vdy82spL717MR/joDlcNeM9cwhq/JA8zgGSGYugkbmi2jLZhp1o5JH7o+h1+977ArGpXWjlADL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7531
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On 5.10.22 20:25, Nadav Amit wrote:
> On Oct 5, 2022, at 2:01 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> Add counters to be updated by the balloon drivers.
>> Create balloon notifier to propagate changes.
> 
> I missed the other patches before (including this one). Sorry, but next
> time, please cc me.

You are CCed in the cover letter since the version. I will add CC to you
in the individual patches if you want so.

> 
> I was looking through the series and I did not see actual users of the
> notifier. Usually, it is not great to build an API without users.


You are right. I hope to get some feedback/interest from potential users 
that i mentioned in the cover letter. I will probably split the notifier
in separate series. To make it usefull it will require more changes.
See bellow more about them.


> [snip]
> 
>> +
>> +static int balloon_notify(unsigned long val)
>> +{
>> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
> 
> Since you know the inflated_kb value here, why not to use it as an argument
> to the callback? I think casting to (void *) and back is best. But you can
> also provide pointer to the value. Doesn’t it sound better than having
> potentially different notifiers reading different values?

My current idea is to have a struct with current and previous value,
may be change in percents. The actual value does not matter to anyone
but the size of change does. When a user gets notified it can act upon
the change - if it is small it can ignore it , if it is above some 
threshold it can act - if it makes sense for some receiver  is can 
accumulate changes from several notification. Other option/addition is 
to have si_meminfo_current(..) and totalram_pages_current(..) that 
return values adjusted with the balloon values.

Going further - there are few places that calculate something based on 
available memory that do not have sysfs/proc interface for setting 
limits. Most of them work in percents so they can be converted to do 
calculations when they get notification.

The one that have interface for configuration but use memory values can 
be handled in two ways - convert to use percents of what is available or 
extend the notifier to notify userspace which in turn to do calculations 
and update configuration.

> Anyhow, without users (actual notifiers) it’s kind of hard to know how
> reasonable it all is. For instance, is it balloon_notify() supposed to
> prevent further balloon inflating/deflating until the notifier completes?

No, we must avoid that at any cost.

> Accordingly, are callers to balloon_notify() expected to relinquish locks
> before calling balloon_notify() to prevent deadlocks and high latency?

My goal is to avoid any possible impact on performance. Drivers are free 
to delay notifications if they get in the way. (I see that i need to 
move the notification after the semaphore in the vmw driver - i missed 
that - will fix in the next iterration.)
Deadlocks - depends on the users but a few to none will possibly have to 
deal with common locks.


-- 
Regards,
Alexander Atanasov

