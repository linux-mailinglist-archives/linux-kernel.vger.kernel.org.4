Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EB6A155A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBXD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:28:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D414FAA2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:28:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkE5pk8BpMO1ifWX6PZqinRaKrS4K7HW445+4nfYr+HlAr7Wv9e5KMcta77+ISmZtWSebZsu+WwJbv1z0zcb7RhBW1QjUqMPfElxgG0ZkIP34zAiEVIqAS+wkD/kNlQjUJL62V9RE+yImx/dsQNwqAimff0it80wZWbtQkymGIZiqi9ULZY4dtWIkmgkSAVrDnf0byYEeTfTuTtQ+nW+b0WvUcOdvKJwohzENS3Ise7eaZzeiF4CzbBQuNtpx7OK7tCSvTezibPTQqZQKniCBnNvgQ3KxQjmKZr7W/2Emq47Xne9zYhV77gE0SCxxI4bE8g1V5OJzi9u6egl36kvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peF8dUJcC+xux9PRYUwAJOgvzRt9WVN7YN0UzeK8G7Q=;
 b=WpFSo3zjhhXpF4KkB5RFqChzM9l4XDS5CCi6bvdarzl2ektJ29bl+Ki4qJMa5FsO0oe4rL5kFkrrMp4H7A2Eatw3HWFp4ATzaQbfH0fBGuE6ysJink2RWfKM6kNOrtjkKrHFXklqlLcJswXyJP0njqz+Bpn8U+22NryiZ/hEl5fXUmyVUzDXMXnL0PrnJ6s8jSfU/KHI4c0LcPsyCryj1D4lHE3h0ruJq4zeNEe06IY0YSMCg4O1l2hbyx2G+QuE1WC+MhRrfIoKpXcnLzXGokMLwZT/FRfGzptd6dHWj+M/XI41IbfEPPv3yGGdLV9+hdgKfS4CMGyj6LLgQnxnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peF8dUJcC+xux9PRYUwAJOgvzRt9WVN7YN0UzeK8G7Q=;
 b=nRaUTfgDDCDtRK0rk9h8ONPyFrMOcjY1kej44mFb8ED48Lwpzge938QmBxHb4mHnUFEVO1ecLC+kiOC0DGCVRJgTiOpAYWI48zxuMNi6ojfr0fhZCygnyq6tqzodPonl8hW4yYMgtDLq9QcATnjbiDhA7UUmmqriwsvHjo4wuTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 03:28:51 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 03:28:51 +0000
Message-ID: <d4c0e8c0-877e-8278-acb1-2fcd43ed9325@amd.com>
Date:   Fri, 24 Feb 2023 08:58:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
 <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
 <87lekz8nrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87lekz8nrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: c9701349-73fd-4812-e5d2-08db16173f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grGFMHJBHzkAMai0CZheH23fsX4Lh/HhoyEOljv7/IAKff1ud9FPtBK7tL+YUMYLl1YvGrPjfkym27kFW0hcTFDAUtHSQY3onImSC+dwd88t3bFh6Rd0rvlDnCAcabkEjxsYuExogOHz3dUQEKXyspcJaHzoR+Oj64a4WFk50EgNwENJXPlrPUzVkXRFmcTxvkJyUqF46neaBtHwrUetcP1by0Q9Iz1xV1gE7dZIldGifj4T3VphZn3JBCZObi3j6ZVlr/hD55ibFmQud7I7kBXvXwtjt9sgFF3I3UVmhdU5NEdqKMbcs7WzldYm48HpOrvM9UUI5pvR6zWw7HVJL+NIw1qDPB17Vv/OK9nGd2NuLeJXhyTbMdN1MAMAo6AWTM7MOWBBjLDcIxs5+rlpQLWgY9RQj1k2mImRe8DNMmAJkbNotCp0QT1+9N9SHhRv1Gs8NLuLzY1hmQlfDCQ4vSQWa1bRNZAyOisBjny9+gR4VdyObpBWBFWi+CJSk5sIX8/HlzVv5Q4nZHUmgoFdNyg1EY8/6r8AzECMN316c5gYppZpPhDY+X3nJIxsHOZR/aMjlFmp7G1ecINH/xM2ndGS0uciofq4D8yg/oQNS7bafgSUr1bHADFaEV/5eOLXURkw/jJfrpYR87Ekn8GnvL2ucushVk2SSb6E+9e27F2mOPL+qrMN6upANw/5jo3JAKNGX6TmZ50xSHbGzsTTfxwt8hbHIs9XzSlg8K92pNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(31686004)(36756003)(31696002)(86362001)(8936002)(7416002)(41300700001)(2906002)(38100700002)(83380400001)(5660300002)(478600001)(316002)(6916009)(4326008)(66556008)(66946007)(66476007)(6486002)(8676002)(2616005)(26005)(186003)(6506007)(6666004)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVTb1dxWTYzYXozSnFtVFZ0UGpmQ1lhS1I5eUczV040WmNmTFl4UzhZWDFR?=
 =?utf-8?B?eXJqWmZYeml1aVRHbjBKVU5VenNmSXFtNk5UKzdxVGxwUU9SMXMyVTB2Nlhz?=
 =?utf-8?B?RVRja21kWVhJZVg3bmthTWQ0d21DM3JiV3VseXdLUHJUbDVuZ0JYL040c1Zw?=
 =?utf-8?B?clhaUlQyQlhvUTZiYURyV3RrYWlSZWpLN2p5TDlEdDMxTU1RU1RlbHlLWklG?=
 =?utf-8?B?UmFLTW5lYllRU3pYOE1nUVBady85TndHOWQ4eXRTdU5EaC8xSjhXdnNUV0RU?=
 =?utf-8?B?aGh6bDRPczF4Y1I0N05jTm5kZldid0lIS2FoM1dRcVA4TlZIQzRGRExJVlkr?=
 =?utf-8?B?MklickhTblpaYVJSNzVpeWF2bitSVEFMK0p5ZGtERHJaR3dKMVlBck82MERz?=
 =?utf-8?B?aVJqL04zZktMRlV3VlBMM0E2RnFFRVJ3dWtnT0cwc0FidEFxajNlRVNnSFpM?=
 =?utf-8?B?UHRuQVFoczdldXdtQjBDY0FxY3dHMGZ5aWcyVUZmVXJnUGpMVXhVVktGaEgz?=
 =?utf-8?B?a3Y4NzRlNE9OZmxkNThaS0ZEMThHR3NDN3R5NGNpL0hqNHZ1cG1ISHdqRzlC?=
 =?utf-8?B?cGIza3hnZnRzUEViU0dQeThnVnV2cUxWRmdvczluM2tWUUV6dzlBdXMrc2hm?=
 =?utf-8?B?KzZ5bmMwOUxVcVdMc1pmVk1PSHNtYUFsMjcrNlprL0ZRMjg0bVJ5OHNJTHNN?=
 =?utf-8?B?VkgrYnk1YTZBTUJrNUoxdGtPcm1SdCsxMVhLVnZEUHFkWndtM3BONmV6bHB4?=
 =?utf-8?B?OGltd1kvV3M4SGFxN2NQcnlGa2lpcWphQjI4VHpZVWp4dlBFK3huYisyeUt3?=
 =?utf-8?B?R2dsSmJkNTVic2FHUTBjZmY3VldoblZkellKdXE2S1pBTlp3QjZlTWhkb21D?=
 =?utf-8?B?Sk9nSzRKVWNqeTB3V2JDQmprbHdNK2xsREhJeTloWi92enVIaFQzdEhEbDRz?=
 =?utf-8?B?Zm91WmpKWGNtTHdLeWdOS2VrZmZTRHlJVmxBQ0hnNVFQQmRqdjNIbDg5Qzll?=
 =?utf-8?B?MVVKdm1Cd2djZmFmRmxwSTcxejBaV1JVWVoreTE3eE1LTitYRWk1aGpSNVFO?=
 =?utf-8?B?T1MzR2VKUndudXRHSHg5OUthQ3RtSGxpS0M4TmxPNkNCQmJJcTFZZDJpSkJV?=
 =?utf-8?B?ZFI5Umtma0dzajltNHVpTVppZUtvbGFzK09RcmRKZ0VBS0QxMW5KVnFNVjJG?=
 =?utf-8?B?NWpMb09KTzkrcnNBT1JHRTFxTXZtRWlDZHFnVmRZSW9NTEdHQnQ2em1MSmVJ?=
 =?utf-8?B?RTRyT2wyc3phSWlMU3JSeEpNRTEvVkVoaTBLVGV3aC9ERjdXbjQveTZMb1VU?=
 =?utf-8?B?SThxQ2poYzEvbzlzT29oR05wcGlyZU5tNkJsSkcrakZkNnhIWFJwd09ieUxE?=
 =?utf-8?B?TE0zdWhHUTFkRjRvMklLTGIxdjlUampLaWlmM0Q0aWtCODliVHhHN1FKeUt2?=
 =?utf-8?B?UGV2R3ByZ0tiVkZEMFNBWWx4WFVNc3RnS2NSSTlsK1EyK3ZSY1BXY0hNbTJ1?=
 =?utf-8?B?Y1h3NWZLZko5SC9lSDJWRkdqalpLVnFnNU5HM2lZY1g0RnNxb2UrYWpMRlhC?=
 =?utf-8?B?elBFSnJsTzVSaXFpOCtRQ24rOFNWZU55Nm5MaVM1NmUwZ21aSjFSK0ZtOFJF?=
 =?utf-8?B?YUVBWTB5OURGdG1jTllFZk5sRWpmYXB0eTg5bjJKOWN2eW9WckZGWHpUdnlR?=
 =?utf-8?B?S0tMZFExN0Ercy9TOVpaLzcrMTJucEdMa0plY0dtMEs5QTVNQ1cyTjNBQUx5?=
 =?utf-8?B?SUV0NlZ1WXJTYStFMmp1ZXg1Rk50U1gzMXZwb3ZqZFBPZmkwMDRlZ0IwNG04?=
 =?utf-8?B?c3I0WWdaWm9objEvbm1NTW1UckVxQXVXNm5QV2xYVUlOeVg2WGpCSWdiZnBa?=
 =?utf-8?B?cHI0cUNnbmo0STNOdjVrU2g5ZmtMbFByVDNJZlJHeGkrdmdWMDZaR1VrenNH?=
 =?utf-8?B?bzNvbGkrcXhHTHI5ajRjaTd2c0NOTFlFNGhCVnFjcVZKVGpMNFVibk12RjlX?=
 =?utf-8?B?MG5nbE5PcUIxOWZmcTNZM3ZQWVQ0S0swUkd0NHVKK1NhaDJTdEY1YjdCa05x?=
 =?utf-8?B?Q0xIeVkycW9XLzVZcXcrRGNaSEhvL3hBdW9ZVnRIS1hoTkJZN0dXdUNuTlBK?=
 =?utf-8?Q?mVFjxw7bgo151QbfFMHs+3aKR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9701349-73fd-4812-e5d2-08db16173f46
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 03:28:50.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cvoS19yh8sBIbfBI8HUdi77GsS0ATqog6NeJg9S879G8Rvww70/BPKy+lxvvHx6PClLziliGaceQfxndEyxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Feb-23 11:37 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>>> I have a microbenchmark where two sets of threads bound to two 
>>>> NUMA nodes access the two different halves of memory which is
>>>> initially allocated on the 1st node.
>>>>
>>>> On a two node Zen4 system, with 64 threads in each set accessing
>>>> 8G of memory each from the initial allocation of 16G, I see that
>>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>>> to complete a fixed number of memory accesses. This could well
>>>> be the best case and real workloads/benchmarks may not get this much
>>>> uplift, but it does show the potential gain to be had.
>>>
>>> Can you find a way to show the overhead of the original implementation
>>> and your method?  Then we can compare between them?  Because you think
>>> the improvement comes from the reduced overhead.
>>
>> Sure, will measure the overhead.
>>
>>>
>>> I also have interest in the pages migration throughput per second during
>>> the test, because I suspect your method can migrate pages faster.
>>
>> I have some data on pages migrated over time for the benchmark I mentioned
>> above.
>>
>>                                                                                 
>>                                 Pages migrated vs Time(s)                       
>>     2500000 +---------------------------------------------------------------+   
>>             |       +       +       +       +       +       +       +       |   
>>             |                                               Default ******* |   
>>             |                                                   IBS ####### |   
>>             |                                                               |   
>>             |                                   ****************************|   
>>             |                                  *                            |   
>>     2000000 |-+                               *                           +-|   
>>             |                                *                              |   
>>             |                              **                               |   
>>  P          |                             *  ##                             |   
>>  a          |                            *###                               |   
>>  g          |                          **#                                  |   
>>  e  1500000 |-+                       *##                                 +-|   
>>  s          |                        ##                                     |   
>>             |                       #                                       |   
>>  m          |                      #                                        |   
>>  i          |                    *#                                         |   
>>  g          |                   *#                                          |   
>>  r          |                  ##                                           |   
>>  a  1000000 |-+               #                                           +-|   
>>  t          |                #                                              |   
>>  e          |               #*                                              |   
>>  d          |              #*                                               |   
>>             |             # *                                               |   
>>             |            # *                                                |   
>>      500000 |-+         #  *                                              +-|   
>>             |          #  *                                                 |   
>>             |         #   *                                                 |   
>>             |        #   *                                                  |   
>>             |      ##    *                                                  |   
>>             |     #     *                                                   |   
>>             |    #  +  *    +       +       +       +       +       +       |   
>>           0 +---------------------------------------------------------------+   
>>             0       20      40      60      80     100     120     140     160  
>>                                         Time (s)                                
>>
>> So acting upon the relevant accesses early enough seem to result in
>> pages migrating faster in the beginning.
> 
> One way to prove this is to output the benchmark performance
> periodically.  So we can find how the benchmark score change over time.

Here is the data from a different run that captures the benchmark scores
periodically. The benchmark touches a fixed amount of memory a fixed number
of times iteratively. I am capturing the iteration number for one of the
threads that starts touching memory which is completely remote at the
beginning. The higher iteration number suggests that the thread is making
progress quickly which eventually reflects as the benchmark score.

                                                                                
                                                                                
                              Access iterations vs Time                         
    500 +-------------------------------------------------------------------+   
        |       +      +       +      +       +      +       +      +     * |   
        |                                                   Default ******* |   
    450 |-+                #                                    IBS #######-|   
        |                  #                                             *  |   
        |                 #                                             *   |   
        |                 #                                             *   |   
    400 |-+              #                                             *  +-|   
        |                #                                             *    |   
 A      |            ****#*********************************************     |   
 c  350 |-+          *  #                                                 +-|   
 c      |           *   #                                                   |   
 e      |           *  #                                                    |   
 s  300 |-+        *  #                                                   +-|   
 s      |          *  #                                                     |   
        |         *  #                                                      |   
 i  250 |-+       * #                                                     +-|   
 t      |        *  #                                                       |   
 e      |        * #                                                        |   
 r      |       * #                                                         |   
 a  200 |-+     * #                                                       +-|   
 t      |       *#                                                          |   
 i      |      * #                                                          |   
 o  150 |-+    *#                                                         +-|   
 n      |     *#                                                            |   
 s      |     *#                                                            |   
    100 |-+  *#                                                           +-|   
        |    #                                                              |   
        |   #                                                               |   
        |  #                                                                |   
     50 |-#                                                               +-|   
        |#                                                                  |   
        |#      +      +       +      +       +      +       +      +       |   
      0 +-------------------------------------------------------------------+   
        0       20     40      60     80     100    120     140    160     180  
                                      Time (s)                                  
                                                                                
The way the number of migrated pages varies for the above runs is shown in
the below graph:

                                                                                
                                                                                
                                 Pages migrated vs Time                         
    2500000 +---------------------------------------------------------------+   
            |     +      +     +      +     +     +      +     +      +     |   
            |                                               Default ******* |   
            |                                                   IBS ####### |   
            |                                                               |   
            |                                                   ********    |   
            |                                                  *            |   
    2000000 |-+                                              **           +-|   
            |                                             ***               |   
            |                                           **                  |   
 p          |                                          *                    |   
 a          |                                        **                     |   
 g          |                                      **                       |   
 e  1500000 |-+                                   *                       +-|   
 s          |                                  ***                          |   
            |                                **                             |   
 m          |                              **                               |   
 i          |                             *                                 |   
 g          |                           **                                  |   
 r          |                          *                                    |   
 a  1000000 |-+                        *                                  +-|   
 t          |                         *                                     |   
 e          |                        *                                      |   
 d          |                       *                                       |   
            |                      *                                        |   
            |                   ##*                                         |   
     500000 |-+                #  *                                       +-|   
            |                ##  *                                          |   
            |              ##   *                                           |   
            |           ###    *                                            |   
            |          #       *                                            |   
            |      ####       *                                             |   
            |     #      +   * +      +     +     +      +     +      +     |   
          0 +---------------------------------------------------------------+   
            0     20     40    60     80   100   120    140   160    180   200  
                                        Time (s)                                
                                                                                
The final benchmark scores for the above runs compare like this:

		Default		IBS
Time (us)	174459192.0	54710778.0

Regards,
Bharata. 
