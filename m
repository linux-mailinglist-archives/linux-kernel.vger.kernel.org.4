Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C686DC389
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDJG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDJG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:26:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BA40D9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 23:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXRKoSJlhPcCJnwrL5zD4LydBoyKy2FJhTX9zA+d7Zp87yGzU4S6DS4m7QZ83PU1Vd8zpnzhcYOLlnP2kRnogJaSYuYLk/s+ZT4Gv8FWYlwHWRLw25wpFEViv5Dh2ZgQBYSTAkIgvZpEnc93pTN1+PxH/l6C+3do0F6qrlSHEZt3/GCq6rhbK2Wcx54uhnocVj86caXj4LBFSBTGtDRQHDzu8tnxbM6YX7vq4+nERozpp6czfH9FSJpuuMvLLJHljJ6npVoTcfiAaHhJLhfJJF0LqjsWr5xtVQVKl8oqH/8Ag6E9SbWUKrNV7OVJ9TneYjyCidPotpZH+29K4jjMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXp0Px/uWbWfFiefd8hBSykG826O1wUWPk8shbA9Wzw=;
 b=i9swGsElEy6Jt7/monSJGCqywKN1c1LWHLBuV7pgBNAdCYtYO6gwrCQjMM1AmevaXhYtWiWTSYt68a3JlkIlQMPmY/65rcTn2ygr/KDM4RzxX8lzNURCcd5eUqzzh8yDfu9HHCTR/YWYPEWLpu2+tJbdgZ/Rmb4xmsIQJSDbArbxIOaM86anKIHx+C2YWy8l7ycii0i3TXX+AyM9IW5sUPpxgC06e4iRQwXj1hFf/iPpw/UamLBOMLJgUCAvljPOuoWELNEfPNLN7T0GbcK0yIwB+rBjr2/uiZIu6kanv4tyvpTBMCRCa+Ppmb7I0/DF93p6KAN1/jVb5SoSNN412g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXp0Px/uWbWfFiefd8hBSykG826O1wUWPk8shbA9Wzw=;
 b=HJQx3G5jwKyCeAFwwzIK4FmR3Eu1wQ2c/dlV0jQkDD9+fc/TWboWUor0iosl8SVTjjgaILBumwaPvJQELNC6xgG6SjMJDL/kpo7x3PR0d8aDHNUBabRdr0kDJ4hF1NwYBjx1dOyIe9gfg95MG6OfeAZMCsm6lRYpA2BDHt+bytU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 06:26:40 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::2323:bb78:a565:7bd4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::2323:bb78:a565:7bd4%5]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 06:26:40 +0000
Message-ID: <7c5cf446-86ba-a240-de08-63a1a9eb5105@amd.com>
Date:   Mon, 10 Apr 2023 11:56:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/9] x86/clear_huge_page: multi-page clearing
Content-Language: en-US
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <271b85ec-281e-d33b-5495-59eb2bc9fde4@amd.com> <87ttxqf0v3.fsf@oracle.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <87ttxqf0v3.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4341b0-f3e2-4f0c-15d5-08db398c8af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsIt2HGiOwMLWzbG7+Gh2nE5MxcJeQn2bYWAvHAnVemFq58In9gh5V5Cbj1/nPjA3KpD22M8YG030jVuSXrCarrZeBs2TE9uGDQlZ7GMH6fHc3Y+P3oX/eZyZHB8pFEoERqMnX4Jt4+RLN0/E9NuSjdiZfXhte4WfZibWih/3G16tNC9SCv0N3IvnijXoDdFYycLpYhvHVhGvvDcMWM7tte7Lo1W2zKuq3S1YO0tYkSDG9tyXQk+IR+c9lAg1sfOhF2oMR0FmQtTdwqWTjLBGA6hyTEHVGebwalNPjzaQ7bgJXPBWGHb973VDk7XmzmhJgG62mQs9/spUyWwYRcg8kYWQly6057PGPfMyMF1p43E4Psw5vyf1SVf5oHtFsUtmCb746lpTaXpgWEFD2oItrh3cVRDLtawyiYVSN9QwLw6IwnrdKTHwB3X+Az00mRt+mXzmkGfC153k8gWN6nHK0IZIfJ8a2o+/N+ml4QrgAfW8VMrH1EJVlOQJ1qa8fPjw9y1DOxjbxLnKYj/YRZL9inFpV2wlqvF55UEFwtUW9wWrjIaKiTVjrLp4dQ6TAGI57vM1TC07JL8oPpC7ghK+1blCK7yADdulUsrJ6l05BoYsFwZl24XDNCs1WcsSTOGy00qHE4pjKiZ2Tpd/SnZNp+ULWxkZ0xJFMEhkNvgzcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(478600001)(316002)(6512007)(53546011)(6506007)(26005)(186003)(6666004)(6486002)(2906002)(5660300002)(4326008)(66946007)(6916009)(41300700001)(8936002)(8676002)(7416002)(66476007)(66556008)(38100700002)(31696002)(36756003)(83380400001)(2616005)(31686004)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V28rMlJxbDlyWmp2alNWcWwwZGZxUURjNHl0RllqWlB1UTdnN1BHN09qeHJ4?=
 =?utf-8?B?a2VGcitMRysyK3ZZNHpvcjBPYzhBV3dkaUF0Y0w1ZlpwamZBY1FVMW9kQzhj?=
 =?utf-8?B?R2ZGQlhMQ1dhMUhnVGxNR1Y2Y1d3STZqakRRaHlaTi9KZUN6NWpEbDFFZVA2?=
 =?utf-8?B?ZDdyZE9Mckg5YlRwOG5kYzIzY2NxbmJhNFE3TElGQlpmcVZ5dE1JbW4zNXpm?=
 =?utf-8?B?TDU0NDV4bnVVbTRLNU8vaFRXZUNKdlYvaGN0Vlo3SlZjcndiT0NVaE02T2JM?=
 =?utf-8?B?c0I0YWk3M2dZQ2dFVTBBQ3FaTEpSTXlnQWlXaDRrUmc1cGV1UmtmK2VTRndF?=
 =?utf-8?B?S1dyVFBQNGsySlArZytqc3VKS0wrb3BWUzZ0NEYxcll4Q0NkcmlXUm1QbWRT?=
 =?utf-8?B?c3NSekc0TzFtSDlqSUNiekgvS1BtK3Q2ajRFOW5VTUZGRG5iNE9JYmRHWjdH?=
 =?utf-8?B?bndHd3dRVDdQTlFSVkF4aWRyVkY4bXdERG5WNFlpLzNqSGxVdjg2cW5hUlNj?=
 =?utf-8?B?bFNZUkZGeTdNdm9WZHpJaWF0TS8vbVJBelRkY0xGMlNNSUxiQU5IQ1lrVEN4?=
 =?utf-8?B?YytOM2ovc1RiM256aWtvVDI2Wk1nQkk1WVcveGhhTGpuVW84TEJOanNWQUNB?=
 =?utf-8?B?ZHVLSnlPYlBSMjY5bFB5cUVNME5sUmNsWG1tZi9PeXFHSkVCemE5d2Jqcklh?=
 =?utf-8?B?UzJlQzFRTmQ3alNqWnQwd0tDd29mOGU4Z2QzaU83emJTMXlxdzVWejlkbmtX?=
 =?utf-8?B?ajRUT05wejJMcTcyY2dreXJ1T2hNaFBMTHMrR0J6aGh1M3JMajhhQXhKSVVF?=
 =?utf-8?B?Zms2MVlBc01NOElHUytvbmEwZVgySTY5SVRGMlk2eC9uYTQrZUg4cFZOOHg1?=
 =?utf-8?B?RkFaSkdmcktpS2NhMEZtVnhOcFh5NlJYekNqakl3SmN6ZW1wb1RKM1FEUHpQ?=
 =?utf-8?B?N1FyU1JwMlZvL0ZpLzd2bG5YbHY4NmVBSG9sREM0ejRiNWlGNVo5L3BqRjRv?=
 =?utf-8?B?QldaVDJBYUZwQ0FON2FOUEtGNE03VjVjRXRXRHdTbDZpUG9STmhZUG5MUGQr?=
 =?utf-8?B?RG9OQXh3RVV5ZVRieThwbzRZUml6ZGhGV3doRS9xY2dPL3cwdkhycnc4MURz?=
 =?utf-8?B?STBtbi9XcGNsb1c0eDZKanI2Qy9acVhjcDVqMzJGVWFjUVplaFkrL2t0Tzlz?=
 =?utf-8?B?a2RxQTZydU40ZGRTZWJKa2dFR29NOXdvdTU5YVFNMGFvTDB6MU9rQWREeFJQ?=
 =?utf-8?B?TUZVVVAxQmN0SVh4QWlmSzNnZHp1UGVIM2JHYndPRDJ6RXNBWG5SY0pXa1Ur?=
 =?utf-8?B?U3FJS28vUVhvYmQ3Z0hBazEyblpLMFFENVNGQVVwVDhwVURYN2hJRGVDT0lu?=
 =?utf-8?B?cEc4Z3lhdnNHamVEdEpGZ0hmR2NyQmdYYXozWXNUQjRoMHQ5UVIxZW1MU1Ba?=
 =?utf-8?B?TDg4S25hTEF2MWUxaEVTS2FUeWRkWVhoU3RYL0hNSm5Wa0JScUJKbGpVSmti?=
 =?utf-8?B?SXBnbnRCdmhQMjF5RkdBYWt2eVFnUXpBL2NNNnYzQmQwdHkrNUdXZFppeG85?=
 =?utf-8?B?WStkV2p1NmhCbHhONU1KZmFvS3dUV3RSN0IyMjhJblJsamljOHJVNUE4NC9s?=
 =?utf-8?B?Umg2d1ZnTDA4MVNUKzI4ZGc0VjBGUEFSdE9TaHlkbExUbnJid1BWRExwc1Vz?=
 =?utf-8?B?MWgxVkVZS0w0R1hVRUE2clBXdm9QYjZrWDZZajRRZmlYeURzcTErVTNkcGZa?=
 =?utf-8?B?S0phMkx4RVVtQWNDN0lZdVFuK2JWR2M0d0tWdGZuWFhYQ09LOXRTWURCdEFF?=
 =?utf-8?B?RS81M3FONU9ZZmNtTDJMYUllY1YyQjdNaS9KTTQwRGZDQmxuQXB0Qy9qR2ZB?=
 =?utf-8?B?V1p1cEFxRDZya1JVam14c0tlZ2ZOSm1STDlXQSt0RGt5TkhOUmY0NVAvWFlV?=
 =?utf-8?B?ZXFvYmVLK3JqblM0VzZjMm5JTXFTd3M3akJ5QXJtdWpyRkZZaVluUXV1YzZu?=
 =?utf-8?B?N3Q1VzZML0xCYmx6d0xybHJmMHVSUnpzajd6L1o0RnRsZEYwVjM0VlBidXl2?=
 =?utf-8?B?eU1TalZOZ3B6L1EzcVdJMXRpMlpsWUVXZ3pDcmpFQTRmUHF5QlFCK2xHWkpC?=
 =?utf-8?Q?9aCxZMmTIMBDL08QYxsYnMU9/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4341b0-f3e2-4f0c-15d5-08db398c8af7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 06:26:39.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSQd4EOg/mD2RoQDwwuzdXWEXHL0qO5piWB2rL+o1t4ajdcix1snkDWsg2plJsTPmtEd3gB0e9Rf6e0fKLzRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2023 4:16 AM, Ankur Arora wrote:
> 
> Raghavendra K T <raghavendra.kt@amd.com> writes:
> 
>> On 4/3/2023 10:52 AM, Ankur Arora wrote:
>>> This series introduces multi-page clearing for hugepages.
> 
>>     *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>>                             (GB/s)           (GB/s)
>>    pg-sz=2MB                 12.24            17.54    +43.30%
>>     pg-sz=1GB                17.98            37.24   +107.11%
>>
>>
>> Hello Ankur,
>>
>> Was able to test your patches. To summarize, am seeing 2x-3x perf
>> improvement for 2M, 1GB base hugepage sizes.
> 
> Great. Thanks Raghavendra.
> 
>> SUT: Genoa AMD EPYC
>>     Thread(s) per core:  2
>>     Core(s) per socket:  128
>>     Socket(s):           2
>>
>> NUMA:
>>    NUMA node(s):          2
>>    NUMA node0 CPU(s):     0-127,256-383
>>    NUMA node1 CPU(s):     128-255,384-511
>>
>> Test:  Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA node0), for
>> both base-hugepage-size=2M and 1GB
>>
>> perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>
>>
>> time in seconds elapsed (average of 10 runs) (lower = better)
>>
>> Result:
>> page-size  mm/clear_huge_page   x86/clear_huge_page
>> 2M              5.4567          2.6774
>> 1G              2.64452         1.011281
> 
> So translating into BW, for Genoa we have:
> 
> page-size  mm/clear_huge_page   x86/clear_huge_page
>   2M              11.74              23.97
>   1G              24.24              63.36
> 
> That's a pretty good bump over Milan:
> 
>>     *Milan*     mm/clear_huge_page   x86/clear_huge_page
>>                             (GB/s)           (GB/s)
>>    pg-sz=2MB                12.24            17.54
>>    pg-sz=1GB                17.98            37.24
> 
> Btw, are these numbers with boost=1?
> 

Yes it is. Also a note about config. I had not enabled
GCOV/LOCKSTAT related config because I faced some issues.

