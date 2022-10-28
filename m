Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBB6113A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ1NyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJ1Nxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:53:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3585467D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em2uDop9mrH9pDUiTIfo+Oh5gKqzc96Lgk01praa0gKGLXFL/tz39I9ExcmB6NrIJ6Ls2IPWWK1BHTnyWBcX7E0yC7UavIpWr/+Z6H3dckWXUk9VGK0P9sRZ78cg5oszVpAEHkLXM6kQr33waCApYqKjzHR4+bf9K0UapCu3bMQ4HGJzvzlPg2DewYBy4plYhzQCNDE6y/LRqduXpcGaCdecaGEnSBuGqwLjXP7ra9vI8303SlJzYLrQIWqwWp1aFRBBJu7y5/+CP6q2NRpn8ePYy5geASVX9V44Hvb8AOOZRjTeDFC40Zt1cw/g0RBhhQEDs5GTW+AsUiCLa4uP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihXszW7LI0rF7/EyDwO24II4MRNc08n9oVUQrNMVgU8=;
 b=kU/hC9jCMx8002C/99buPxh6o8DE+TlCFgkyo99qJxbk7bHng6bNT7JrtxMVx9ZPkW0pvSfnLdFVnxZseOH2qay8oYD7hdJVw7WA/QsGgOQ6H0imhdG4rkNPRLYlv1B1ydEPk4hbQLOhe1Po5UEtLn1Ms+QkJCgvwrisOGs7kDUkaYR0Ckz1Hw3DtT5ltF67DRy3ru92q7eQd5L4kWNfm/jG2p3/j782msqCdwPbQYTl9DCtYKdbdMbOzjIsWqYCZSSzMIWtebQjYuF5HlOQnpByspJ8t+vZKYzEYCn5C3lCd+Vv9TtLfNy2IwHfbny+EvJLOH/RkMpkr/htNZ/zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihXszW7LI0rF7/EyDwO24II4MRNc08n9oVUQrNMVgU8=;
 b=x5pFXdlGsD+lfYg/mg2gCG3Cdg6uXZMxUd98HxtMO15xB46FdIZoyo3de0aEju0C9dKzl5QXn+YC6hQBBG8OwennXqnPyWwCgjSjeGUw2ViMsn8IbFV3rLf/cxIkvS7rsQ6ti7xevALtQn037Cj5SRQnetdPvH9MbKvaFbl40Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 13:53:47 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bf6b:5ddd:be09:a1e0]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::bf6b:5ddd:be09:a1e0%5]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 13:53:46 +0000
Message-ID: <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
Date:   Fri, 28 Oct 2022 19:23:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20221027065925.476955-1-ying.huang@intel.com>
 <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
 <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
 <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
 <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::8) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 158eee12-faf5-4cd6-97c9-08dab8ebd592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYeT0XUyFJh9XMBxnmiLgZGx83XT9ts8RlmmDSPNWT6pdcYti/FKxY1u3+cJrRXUBYGb32twxIm0X71vV1n4qReJCQHrxJqDqWPLN6VERfpNVX/y78c2YXUfWv0DWYz6l6SOEaRlynWqJfGD9l/ULxnoW7vVmZv8FBn8rXhS0/uSb8Cn7WWgAlYkOnc7WDSwLrK7EuNbKN59kiXId56ZO4R/pNS51Mg+pFTzq8IDQZYHGS1fuE3PgYSA2zyf0GAk9s5lfBn3De+a7pRjiVgzIrtyB5VhVQ+DwePRMT4H376nLqkl4Lm3Ls9uHryN9ia0A2DdB9eHvNpBPGMowJ9a3yxLLltug5yF2HJBddecYMBdCFwDP86KGSKwDbDbMFTKnE8okXHgajPJxotgQH6mpdSI4brewC9zRZuuyV8u6YaGdQN6ofrUq/mBQYczHck/UbDfByamYof5g25oQf6hb+YeQ4mNZdbtnG+YrzW61GAAR1ixuwPg6NOp4GP5rZEHWs0IWkl11s2+5cfN5YdDUYpFOHd1WkFC/8cAaCemLx9YS8MMw8znZeH1ybrgWxAfArdtW2TuCw1dAGl96VqDTiBzfTT1ec6R5StAeYE0gQgNcCQAF3vg1J6lGr+cH3rFDMGJK655ZifR4aMYy7Q0aWhcPIKwtxni7RiJzuA4KOd8QLlWx/7/EBHQxIfXr9GYi7TR1/LwwNQl4FQ0hSPijE+evJwXAmcPubcLZEps5ZUho6NaCVS3g2AUKCirWT0yfe0LkI42yiahzhMlnhj/derpFLhnzjpKDUb5u19K1S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(66899015)(6486002)(478600001)(6916009)(31686004)(31696002)(6666004)(316002)(54906003)(2616005)(5660300002)(7416002)(66476007)(53546011)(6506007)(4326008)(66556008)(8676002)(66946007)(26005)(8936002)(6512007)(38100700002)(86362001)(83380400001)(2906002)(186003)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTYwT1BHWnJ6aTNmREJ6VjJnK2k2NlpncnF6YmRnYlY2NTh2QzFFbHd3em9h?=
 =?utf-8?B?bFpJbjVPTEFCeWNUdHpYQkwyWUxIYVFUbWU2Wm5MN2liUUtLZFJxZlkzOUZQ?=
 =?utf-8?B?aFFDUDZiL2hadmJ2NllhelBXYnVpdVdLZ0lJRFA0djdZUWJBRkh3cldCTVVp?=
 =?utf-8?B?em9BV3pEc1lndXNVRGlmcWNrVWx5cTYvK2tLckFod2pTMVl5blhWN0tBNEpa?=
 =?utf-8?B?d0FsNzdOSkpCSXh0VjRaTlZVVjA1WGhicXFtbFdsbjFrOTdIY3YrZ1NvRkh0?=
 =?utf-8?B?RzhIRDZGMnIvWUFRNlpDRXROUUVzOG5JSStGMVE1VU1xMHgxdGd6L0FDY2xs?=
 =?utf-8?B?T0RxQUxFbmdHSU1wU2JMUEZ1Tmg3QzZoUmZ2cVBIeW9oZnF6c1FockhMcXcz?=
 =?utf-8?B?a0VkQXlNdDBpZnJMaXdCeW9hOEtHakxwRTNPbEhVeTd1TTE5NEtuUGZaUTM2?=
 =?utf-8?B?VEdGNDhyRUM1V2t3dGI0U1k2OW1WQWJMSlNDUDFjbFRVNXltamdSZlB2TWpx?=
 =?utf-8?B?cGVtSkp5NmlOK1oyVWZvaDJlYXRQbnJ3WDU5QTduMkl1Vlk4WlVVYkVUQW43?=
 =?utf-8?B?Vk1raVB0ay9CeklzRlYrYUdPSytveHRockt6SUhlbXN4TzJHRk50VmFvZ3Jz?=
 =?utf-8?B?RHVCb2VCMU5tV2RWY3RNRDgrV1JDdG1TN1BiVzdjNDlKaC9xSEw4NmJodUdG?=
 =?utf-8?B?Qlowd1dkY1BJTzV3bEh6OUVvTjJ0OHlyWXlmWGFwZEwrcjNjQUxtRzBWL1hp?=
 =?utf-8?B?cW9KbnNTSGUrbWNpSVBldlhLWm56YnF3UldUT290Y0UrcUVJS0wzVTVuUmhu?=
 =?utf-8?B?Wml1M1o0QlAybThmN1l4ZE9hRGtGdlNyNnhZNE03UmRaRnp4cnExMXlhVmJU?=
 =?utf-8?B?SjY5MkhLdWMyeUI3SDd6SU41dTBaYVNOVVk0VSsvUHpQKzNqYW5BWTlGZ0JF?=
 =?utf-8?B?clg3QytBbm40VkE4a01rU2lIRlpGRnJTa2JFZW5mb0lLeUk0V0hjdXJWTm1F?=
 =?utf-8?B?ZVZRUDVJQVY5Z0FIUTJjbU9qQzRXSHB5bGFPUzB6WDdTZHB5ZWNWYkl2VWVD?=
 =?utf-8?B?eGZ6c08xYkFiR21sU0NFbTFHVFlmK3p2dVNBTnhFODFyMStFWWFtRkQ5ZHpq?=
 =?utf-8?B?RFNFRnBXQmNDSk5FbHUra0lVYzFndndSdjdKN1owdy9ZY2dQZEVGb08vWWc1?=
 =?utf-8?B?ZnJCLy9NeFhtNEV5RXh0WlFIM0hJMkVFMjl6TnpoWHFaVTIyUHdpaExocFRC?=
 =?utf-8?B?V1BIZjFYK2hxWWt2YVlvbFBvRDI0VkhDSjk5d1V4MDhJcHFlNHVHUlcyOEdq?=
 =?utf-8?B?VHk3TUtUTXJ3WUhjbFlHdWZIa0dmcEU5ZmpraUErVDBHWDNHdVRhdytTcGlU?=
 =?utf-8?B?ZGsvNi9uT2xxeWd6MnZoYW5Ca1JRaFBUelVDN2pIZzRKRlo3aHB1NFljL2VN?=
 =?utf-8?B?RHpjU25zK0R6Y0lyMEZlWG9EcmN2ODJvMUhJcjRnbjFxcWRhejlhUC9XaWYy?=
 =?utf-8?B?OVF4ZGJzQ3JETTEwSWRmSzc5WXR1R3dkakplU0w2a1FVN1VjRFJZd1ZaSkdq?=
 =?utf-8?B?SnFyZ0lXNHluSmlNdGlSSnhLZjNZVXIycFpRaFhkUTMrd2FLckNES0RVa1Zp?=
 =?utf-8?B?M291eXl0V1MyeTIzRC9oMlhnK3NrVXFxd1VDSmxqaUY5cFdvS2Y0OHJiN1Zj?=
 =?utf-8?B?K0xhQzMyZU5wcithL3VLbnJLRGlZcGNuUWpFdmhXSDd2aEFpanArdG1PMCsx?=
 =?utf-8?B?Qmc3a1l0b01ucUFOWmF0N2pWMWRhYitBUmgrMEM1clh3YjUvM2dEc1BBWmVN?=
 =?utf-8?B?Qzd4WTFsQndXelRxNzRiSkVWYVA3MmhodVNOVHZEenQwWittMCtlZXZHd0R4?=
 =?utf-8?B?d1VVeXk2VFdIVlBnMjB2TVR0SFNWNmJYVjlyWVFQV2Q0RkJSVTRnNnl5ck9C?=
 =?utf-8?B?R01PZVBwaUZQOHZSNFJ2RkI0dkg2ZWZGUncxM2I5Q2lFY3VvYlJ2dE5qb1hL?=
 =?utf-8?B?ck5idEZJV3E1WFErcXhqZlRtbi94THErZjJwaEdIUUUzKzNuR1E0RzdnZGc4?=
 =?utf-8?B?OXZESlRCV09HYm4xNFBMZWNRVlJUVVFKaXJlSHN5WHhHdWptQkQrQmlSZjNk?=
 =?utf-8?Q?d24tT+Bz7aoct9Hj32dLrnjK0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158eee12-faf5-4cd6-97c9-08dab8ebd592
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:53:46.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN3z2uuag52FqeVkq2ZIZHUlRm4gYcknz/TICTfycIWlP9m09cLXFVUj4surZ6vJgrQvRLxxPIi2Sspf3KAsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2022 2:03 PM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 10/28/2022 11:16 AM, Huang, Ying wrote:
>>> If my understanding were correct, you think the latency / bandwidth of
>>> these NUMA nodes will near each other, but may be different.
>>>
>>> Even if the latency / bandwidth of these NUMA nodes isn't exactly same,
>>> we should deal with that in memory types instead of memory tiers.
>>> There's only one abstract distance for each memory type.
>>>
>>> So, I still believe we will not have many memory tiers with my proposal.
>>>
>>> I don't care too much about the exact number, but want to discuss some
>>> general design choice,
>>>
>>> a) Avoid to group multiple memory types into one memory tier by default
>>>    at most times.
>>
>> Do you expect the abstract distances of two different types to be
>> close enough in real life (like you showed in your example with
>> CXL - 5000 and PMEM - 5100) that they will get assigned into same tier
>> most times?
>>
>> Are you foreseeing that abstract distance that get mapped by sources
>> like HMAT would run into this issue?
> 
> Only if we set abstract distance chunk size large.  So, I think that
> it's better to set chunk size as small as possible to avoid potential
> issue.  What is the downside to set the chunk size small?

I don't see anything in particular. However

- With just two memory types (default_dram_type and dax_slowmem_type
with adistance values of 576 and 576*5 respectively) defined currently,
- With no interface yet to set/change adistance value of a memory type,
- With no defined way to convert the performance characteristics info
(bw and latency) from sources like HMAT into a adistance value,

I find it a bit difficult to see how a chunk size of 10 against the
existing 128 could be more useful.

Regards,
Bharata.
