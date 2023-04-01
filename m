Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A236D33A2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDATul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDATuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 15:50:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB626580;
        Sat,  1 Apr 2023 12:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQmzJ8ceP4Yik497GPm2n9MWMu2PMMF31EZvhik/3EbuePWinXUmy6Ni2bRBjAbysbx6dLhSpar/I1f8w7faF1d4rV/ivcAg3025zJ4/tS7a+p7pNHWdtHmUD6PRorO0mzsI/PAs+JTDysu8wbKglCzIpgtpg8FSPO2nQnwoJsiibKuB/M1MzO9ZHQKAWBI6dK+2p/O5Hx6NTdn9QdcJptwBm4DPHnugWS9+QQXyLzxJXUY8QSmIdAPJ6pfX6tdvFaFeFE5YfVk97i+S92qPrJmAHlCTQEmqV5LZVa9poIutQGW38wj1Lmhd6/iXxiry8QvSvqAmboxN+P1djmhq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTjymSt0VfSc0fXRap84FqhH5s2yNtzwrSTE0Xmew70=;
 b=oY5JOc/jBlZb/ArLfnVBZ2dhSjKJ/ebJ4t4pCatPCx53AbV/b/rfsGxbeEU4ONH6HCMdfMNddYdOT/S+nk675QTkaoFh3E7UJ7JTn6vpChtE3dfrqALDO5/SNgMgy+ZMCan6wOH8pDz3zHxmnbSmdbU/QXiE7CE5QPAlVO2JodoonRSG03Pmew7o5I/yHxkp7E77v0+Kl+Zt8rtmyXNvkEX213Sm1DzgtZWl6KdbtK3SXzetX/b3fghyVAEDnIy4/RbbIPeSkNk8GsMUYubcXYi0YQ42CgdOw4ULYQiEsdIAacCMv0o6Id65o7PLdXWKo3dEEsqeaxUKZNvyRW/Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTjymSt0VfSc0fXRap84FqhH5s2yNtzwrSTE0Xmew70=;
 b=QYqXJZDFca/n5fAEmaEGH8hbsl85JFn5Lvt0oTdf9uWHDBKpPV3dDW4iX6E5UZhSlriXMDqVy/pNupY7FPPNZQUIqjIHu4B4LE8FU8z5Ng5VGR24g5UUd0WHyKSYnyCDzBcEtt/ZxOT4pOhwUs6kBbWkd4II94jr11HeXVaQSQAVWUQ1mSakI8j9pO1ZoeswER4o4R+bauRsNmksERNYwnonNvEQv2rp5Qo+4+ZtklMEPfNE5kJy5feRCCSf0BmiXxgCC2RGRtwWx3pZy+Z/d+kpT05FOzzSy5bmWL++81RQP+9ExyLwMdyDJ9YH10ppkTgc0w8RH8YcrOHDv2iTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Sat, 1 Apr
 2023 19:50:32 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6254.023; Sat, 1 Apr 2023
 19:50:32 +0000
Message-ID: <05cac339-5585-b82b-ae5a-4258c62ad8a9@nvidia.com>
Date:   Sat, 1 Apr 2023 14:50:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: mm: Increase MODULES_VSIZE to 2GB
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230330140437.984211-1-sdonthineni@nvidia.com>
 <d0f20427-256d-d88c-5a40-5e4aa5c0618f@nvidia.com>
In-Reply-To: <d0f20427-256d-d88c-5a40-5e4aa5c0618f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 878887c4-c0aa-4e3c-7c8d-08db32ea5a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOOYCn1Nya5zaaXqXV6XBtZa7cJjiqYY3OS/wYShdRAH8NyywaniNbNXfx/+YF0sxjwvYUd6vx8ByqQygH2e7jFliRvgfCecrpzXtAA16TXmAL1jv/j96lJKP114Aa+cF8aZ4lHzVPs09WxKJap061wjJvTZUS1okIISmjhDsQBMdXB1x25qWIw4f5m4VYx7+JTCt0EAGb7BTZcEzwOf+Ji9NOhp7yvjnxBbOyuitFtAQm47bz/ckg2vQ88LUIx20siPuJeTh9es+N3fUIiLzmFSVz9sQff32aFafcVrxarUGJMm742at/o0LzwC/u4LquzwtlAJ08JxYGz9S7ZcSfWLJghr1QP5WcaZti3sgVpKrnL/pMSNNU/xMrj78W/zAIhWx37mCrEF5REjNGbkuczOYNGLWzfw0mcLQXj7Jd40olugQPE2WZ/CtQtfjOpY+fN0iQsMMHOlGjRKteBM+oFuyhJQCNehM09VeCikUIA9k7bOslcv8GGsnq5vgw+jYUSkDJCMlMV1PGsYuXHVVtPcANZNmOzFp9k7I9y+Tp8jrHY3hThi+QLr4BGD3caeA5urxmEI6JprIMch/DufmruMH+eSCKDrvqFcKznuX1PTFw/aGCE4d+9zVlQlWKIWLdpb22LuIBidM/7S20OcLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(2906002)(66476007)(186003)(53546011)(41300700001)(6512007)(83380400001)(4326008)(6506007)(6486002)(5660300002)(26005)(66946007)(316002)(7416002)(38100700002)(31696002)(54906003)(6666004)(2616005)(31686004)(8676002)(110136005)(478600001)(8936002)(66556008)(36756003)(86362001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FodTRqd1A2MW1pazkvZ29OVFdiWWNwbSszY2hQNFdLNFpHSW9mQ2JseGtj?=
 =?utf-8?B?L2EvbHNOUHZVSDZrWTNLdUM5VVFpcm9mcGU1TURxb1hIWlFFSEpWSFFzRXVp?=
 =?utf-8?B?VU1Ed2J5K1BzeDBoSzZPbXdRU1o1UFR5cnpiSGh4dFlMOFhPcWx6UUR2QU54?=
 =?utf-8?B?Tm9DZ2FkTm9UVjhTUXIybGw1RXU2enZFUzRlZUxVRTdleTZwcm5YeVRJQmNm?=
 =?utf-8?B?MlpHRitvM29CcWRMRytmWlFmOVJVeUFFYkNqUEpSRGc4UkozUUxmTDJycDVz?=
 =?utf-8?B?SHRncVVrRUtlMzBMY1FLWHVWcUZWTEVmRkpIUVI0YzdKMnJ4MzFJVE5tQVZv?=
 =?utf-8?B?enNRUVlqZ0p2T1JwRHpyOW1PdFpzZ2FHZ2tUd1hROGxTT2xKRUxnbGtEdkli?=
 =?utf-8?B?QXJmemRpaTk1WFp5UlZ5QzdSVUlsaVBuQ282eERNRGpjYVpoREhvVG9vSm5Y?=
 =?utf-8?B?VUgyQkw3Ujdhb2VKc1BndTVBRy9aVS9uRGtSQ0tUVysrKy9YSllRMkIwcEh6?=
 =?utf-8?B?Qk5kNWkvQW8wcUtNUituSXFzZ1pzWDBCUzVIMDRzRUhmYjhKYUZibXRzNFFp?=
 =?utf-8?B?aXlCdUpMcXpZQjI1bGtSUnRRQlVxeHl1VVFiTnp4UzJ2cTkrR1FVb2ZubThK?=
 =?utf-8?B?QVpiVjZiWEdhanRhRGIwNU5EU21nWkFacHhVV094UEU4NS9hKzVUVUI5cURH?=
 =?utf-8?B?OVlnTWNBdVZ1dlYzRTZ0Y3FvMGFsQkJQZWU2T2FOQllBaXpBRndCekNseC9n?=
 =?utf-8?B?WWF5N1lOVjVQWk9NS2o1NzFzR3hZZ21MZ2x2L0sydWdpeXBVV0NScVcwL2xp?=
 =?utf-8?B?WldPSk1iT2pHY3dESmRlQ1JpV21qRkNyVzhZSlAwWjRQcUkzUlczdHczK1Qy?=
 =?utf-8?B?eUpRNlZzQVhBak5CNFpvL2FQOVNrOXVDQVZoTnpkYzNUb3kxZi9EcE1nUVlx?=
 =?utf-8?B?aXZJRkdoQ0YyM3pHdU5wSkd4NUFtN25obldOenFUejFZQWU1aE1KenBlZXFy?=
 =?utf-8?B?Z0syUEhMcVcrTGR4c3NCM3ZBMVZVYkVaK09adGZTcTBWZkNQUTZ3T050WExW?=
 =?utf-8?B?YXVzV1FJZFhrY0FMTHZDeWZ1cHhWOUc3dnlBS2FlckNrKzRFSVdPNTdrOUlF?=
 =?utf-8?B?NFVyaUxKYzlYTTBjVWNtUUZrZWZtYWVkUzRuaXl3OUdxUXduVWwyZ1htNmRE?=
 =?utf-8?B?WHNNVVhOQ0pNM3lTQzBxcE5iOGJYWFg5eTZqcFRaWlMyZTVKQmlKWEhSMlgw?=
 =?utf-8?B?eDNCclduWkU3ZEZtaGd1ZExaL2N1dy9yL0xMcDlxb3RSZUhqaG9ZQmlxcGdo?=
 =?utf-8?B?YlVTVGdxQ1FTU2hxSk83MTdGZlhxZ1lIZjNkVkYwZzdvT1NLSHNjQ1pjQ0Rv?=
 =?utf-8?B?elBUUElYNXptSTA5RDlIK0tDMEZnNmZyS1lMR3V3MWk2T1lnQmRZOU01QWVt?=
 =?utf-8?B?ZG5abHp0NEZBMXU0dk03UVBXTHp5b2xYdUN6VWpGbkxleGM3ellXNlpCOUhr?=
 =?utf-8?B?c2N2OHBHYnR0WjJVMmd4TXRYeVpGRExPelJTYWhUL3pEMExCLzhPbmtocVF5?=
 =?utf-8?B?dnRnQm1jMkd5cmhXeGpWNFhWTVhrSk1vM1Q0VGR4Q0JDOElWUi9YRzNIbFpv?=
 =?utf-8?B?MGdMdXQ4Tys4OWJvVkQzOG1KZUxzSmhHb3FHNTZTYnNNbDQyMnBiSzFnekx0?=
 =?utf-8?B?VlBMaDZiOWZmQ3lRZWcyVktFUkNVQ0djQ1BHYktQOVV3bG0zN2FtR1lkdzVH?=
 =?utf-8?B?bWN4SVFia2dLa2pDZjhwQ3VzQytsTm5OK3hjaUFaY1o2QURBZHY0cXYwREdj?=
 =?utf-8?B?TllSdVZENjdOWHhIam5oV2UxSEo0UXY5dnNBcTcrK3BSRllZeW52T29UWWdN?=
 =?utf-8?B?U0JXZGZ4VFIzYm13ZHNrYTdiZGpxQnpVMEhIRVp0WDh1NVFHQ1dUc20xbnU4?=
 =?utf-8?B?c3ZlbzROUlFWMjVzNjlGVmJSM0lqQTNpbDRJaXA2VjR4b0tZWkNRbkpKcU5y?=
 =?utf-8?B?Nlg4WU85akNueVJpbGh6b1RpbHJXZlVkdm0wVGlTWTJTWVRxQjhZNE9xSmRB?=
 =?utf-8?B?dzMvanF4N0dLYW5WeVFLZmZmY3piNlp2U2s0UlNBS01zNy9RcXBGcTZPQy9p?=
 =?utf-8?Q?kmmvtArLW5vwpUL5D+k2MgcdG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878887c4-c0aa-4e3c-7c8d-08db32ea5a37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 19:50:32.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQupfJk8pcF5/T7beSPG/SfJ4mOe4R0DawvG+CEXuiZwRx6hVDHthjO2X/vrVuZppPuJQCNCKqPwQuvQ8gyszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Ard,

On 3/31/23 16:48, Shanker Donthineni wrote:
> Hi Ard,
> 
> On 3/30/23 09:04, Shanker Donthineni wrote:
>> The allocation of modules occurs in two regions. The first region
>> is MODULES_VSIZE, which is 128MB in size and shared with the core
>> kernel when the KASLR feature is unavailable or disabled through
>> a boot parameter. The second region, which is 2GB in size, is
>> shared with the other vmalloc callers. Depending on the size of
>> the core kernel, the 128MB region may quickly fill up after
>> loading a few modules, causing the system to switch to the 2GB
>> region. Unfortunately, even the 2GB region can run out of space
>> if previously loaded modules and other kernel subsystems consume
>> the entire area, leaving no space for additional modules.
>>
>> This issue usually occurs when the system has a large number of
>> CPU cores, PCIe host-brigde controllers, and I/O devices. For
>> instance, the ECAM region of one host-bridge controller can use
>> up to 256MB of vmalloc space, while eight controllers can occupy
>> the entire 2GB.
>>
>> To address this problem, a possible solution would be to increase
>> the MODULES_VSIZE to 2GB. This would improve the system's ability
>> to accommodate a greater number of dynamically loaded modules and
>> drivers when KASLR is not enabled. However, prior to switching to
>> the 2GB region, it is advisable to allocate modules within the
>> 128MB space that covers the core kernel, in order to benefit from
>> the direct branches.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>> Changes since v1:
>>   - Included Ard's recommendations.
>>   - Revised the commit message.
>>
>> dmesg:
>>   On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
>>   due to vmalloc/vmap allocation errors when loading modules.
>>
>>   [   64.181308] ipmi_ssif: IPMI SSIF Interface driver
>>   [   64.184494] usbcore: registered new interface driver r8152
>>   [   64.242492] vmap allocation for size 393216 failed: use vmalloc=<size> to increase size
>>   [   64.242499] systemd-udevd: vmalloc error: size 327680, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-3
>>   [   64.242510] CPU: 32 PID: 2910 Comm: systemd-udevd Tainted: G           OE      6.2-generic-64k
>>   [   64.242513] Hardware name: NVIDIA T241, BIOS v1.1.0 2023-03-18T21:32:31+00:00
>>   [   64.242515] Call trace:
>>   [   64.242516]  dump_backtrace+0xe0/0x130
>>   [   64.242523]  show_stack+0x20/0x60
>>   [   64.242525]  dump_stack_lvl+0x68/0x84
>>   [   64.242530]  dump_stack+0x18/0x34
>>   [   64.242532]  warn_alloc+0x11c/0x1b0
>>   [   64.242537]  __vmalloc_node_range+0xe0/0x20c
>>   [   64.242540]  module_alloc+0x118/0x160
>>   [   64.242543]  move_module+0x2c/0x190
>>   [   64.242546]  layout_and_allocate+0xfc/0x160
>>   [   64.242548]  load_module+0x260/0xbc4
>>   [   64.242549]  __do_sys_finit_module+0xac/0x130
>>   [   64.242551]  __arm64_sys_finit_module+0x28/0x34
>>   [   64.242552]  invoke_syscall+0x78/0x100
>>   [   64.242553]  el0_svc_common.constprop.0+0x170/0x194
>>   [   64.242555]  do_el0_svc+0x38/0x4c
>>   [   64.242556]  el0_svc+0x2c/0xc0
>>   [   64.242558]  el0t_64_sync_handler+0xbc/0x13c
>>   [   64.242560]  el0t_64_sync+0x1a0/0x1a4
>>
>>   Documentation/arm64/memory.rst  | 8 ++++----
>>   arch/arm64/include/asm/memory.h | 2 +-
>>   arch/arm64/kernel/module.c      | 2 +-
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
>> index 2a641ba7be3b..55a55f30eed8 100644
>> --- a/Documentation/arm64/memory.rst
>> +++ b/Documentation/arm64/memory.rst
>> @@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
>>     0000000000000000    0000ffffffffffff     256TB        user
>>     ffff000000000000    ffff7fffffffffff     128TB        kernel logical memory map
>>    [ffff600000000000    ffff7fffffffffff]      32TB        [kasan shadow region]
>> -  ffff800000000000    ffff800007ffffff     128MB        modules
>> -  ffff800008000000    fffffbffefffffff     124TB        vmalloc
>> +  ffff800000000000    ffff80007fffffff       2GB        modules
>> +  ffff800080000000    fffffbffefffffff     124TB        vmalloc
>>     fffffbfff0000000    fffffbfffdffffff     224MB        fixed mappings (top down)
>>     fffffbfffe000000    fffffbfffe7fffff       8MB        [guard region]
>>     fffffbfffe800000    fffffbffff7fffff      16MB        PCI I/O space
>> @@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
>>     0000000000000000    000fffffffffffff       4PB        user
>>     fff0000000000000    ffff7fffffffffff      ~4PB        kernel logical memory map
>>    [fffd800000000000    ffff7fffffffffff]     512TB        [kasan shadow region]
>> -  ffff800000000000    ffff800007ffffff     128MB        modules
>> -  ffff800008000000    fffffbffefffffff     124TB        vmalloc
>> +  ffff800000000000    ffff80007fffffff       2GB        modules
>> +  ffff800080000000    fffffbffefffffff     124TB        vmalloc
>>     fffffbfff0000000    fffffbfffdffffff     224MB        fixed mappings (top down)
>>     fffffbfffe000000    fffffbfffe7fffff       8MB        [guard region]
>>     fffffbfffe800000    fffffbffff7fffff      16MB        PCI I/O space
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 78e5163836a0..b58c3127323e 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -46,7 +46,7 @@
>>   #define KIMAGE_VADDR        (MODULES_END)
>>   #define MODULES_END        (MODULES_VADDR + MODULES_VSIZE)
>>   #define MODULES_VADDR        (_PAGE_END(VA_BITS_MIN))
>> -#define MODULES_VSIZE        (SZ_128M)
>> +#define MODULES_VSIZE        (SZ_2G)
>>   #define VMEMMAP_START        (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>>   #define VMEMMAP_END        (VMEMMAP_START + VMEMMAP_SIZE)
>>   #define PCI_IO_END        (VMEMMAP_START - SZ_8M)
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index 5af4975caeb5..b4affe775f23 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
>>           /* don't exceed the static module region - see below */
>>           module_alloc_end = MODULES_END;
>> -    p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>> +    p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_end - SZ_128M,
>>                   module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
>>                   NUMA_NO_NODE, __builtin_return_address(0));
> Occasionally encountering the "overflow in relocation type 261" error suggests that the
> expression 'module_alloc_end - SZ_128M' may be outside the 2GB range starting from the
> beginning of _stext. Used the following code to resolve the issue And also enable
> randomization of module base within 128MB if CONFIG_RANDOMIZE_MODULE_REGION_FULL is not
> defined.
> 
> 
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -46,7 +46,7 @@
>   #define KIMAGE_VADDR           (MODULES_END)
>   #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
>   #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
> -#define MODULES_VSIZE          (SZ_128M)
> +#define MODULES_VSIZE          (SZ_2G)
>   #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>   #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
>   #define PCI_IO_END             (VMEMMAP_START - SZ_8M)
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index e7477f21a4c9..4f92fc511b85 100644
> @@ -70,18 +70,19 @@ static int __init kaslr_init(void)
>                   * resolved normally.)
>                   */
>                  module_range = SZ_2G - (u64)(_end - _stext);
> -               module_alloc_base = max((u64)_end - SZ_2G, (u64)MODULES_VADDR);
> +               module_alloc_base = max((u64)_etext - SZ_2G, (u64)MODULES_VADDR);
>          } else {


Upon careful review, I have determined that this change, which involves utilizing
different fields for the range and base, is incorrect and not required. Please review
the following code and advise me if there are any missing changes that I may have
overlooked or if it is appropriate to post the v3 patch.

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
@@ -46,7 +46,7 @@
  #define KIMAGE_VADDR           (MODULES_END)
  #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
  #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
-#define MODULES_VSIZE          (SZ_128M)
+#define MODULES_VSIZE          (SZ_2G)
  #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
  #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
  #define PCI_IO_END             (VMEMMAP_START - SZ_8M)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
@@ -74,14 +74,15 @@ static int __init kaslr_init(void)
         } else {
                 /*
                  * Randomize the module region by setting module_alloc_base to
-                * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
+                * a PAGE_SIZE multiple in the range [_etext - SZ_128M,
                  * _stext) . This guarantees that the resulting region still
                  * covers [_stext, _etext], and that all relative branches can
                  * be resolved without veneers unless this region is exhausted
                  * and we fall back to a larger 2GB window in module_alloc()
                  * when ARM64_MODULE_PLTS is enabled.
                  */
-               module_range = MODULES_VSIZE - (u64)(_etext - _stext);
+               module_range = SZ_128M - (u64)(_etext - _stext);
+               module_alloc_base = (u64)_etext - SZ_128M;
         }

         /* use the lower 21 bits to randomize the base of the module region */

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
@@ -37,7 +37,8 @@ void *module_alloc(unsigned long size)
                 /* don't exceed the static module region - see below */
                 module_alloc_end = MODULES_END;

-       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
+       p = __vmalloc_node_range(size, MODULE_ALIGN, kaslr_enabled() ?
+                               module_alloc_base : module_alloc_end - SZ_128M,
                                 module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
                                 NUMA_NO_NODE, __builtin_return_address(0));
