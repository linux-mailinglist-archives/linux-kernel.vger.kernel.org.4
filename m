Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFF6D2A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjCaVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjCaVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:49:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8182F2546E;
        Fri, 31 Mar 2023 14:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9sE0reuS85MSVifwAaqbPzKadWJDgylG0O6txXdSOBcb7ZxIK76I9fLer2AjUeUjdG4ybmk8Sz8omeCi7dL00z1CkRd7uJH3oN0Hu2dspzNL+JQHTYDcA2mDOtClRR8CdWN4Qjw1Yc7vGxVGInvM+EJnGarT6PZs4TX2f2UEPWc7m+GErhZ6KGV+U95UAz+BSB4MPWSh/9jVXMZOs46N55cFF4hxusZHNW6xvMCztNFr6yrLHKhfWVKKsDSzfoztbxIX1yz5S9CBt8lwcFOtybXj4PCW4audGx5SAdpfqRSijPbhfX5sUz8V5UljRHyhWTwOjCvsdd/YLSZtsPdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA9SANBAto0FnL3dXjrICo3Gcwa9w1/AGVZbkzWTOGk=;
 b=aPH8FmZ6pz/ipmwwdODqyH782IE0xI5cJ+eFMINApcU35L10sElBmLQJpyt1P3gUpTmXxtuPlKSxI73ufXtDXEMUr9u8MsmYlqucYqJ+96xFvDEuKJW3C+Wi4Bh/MFCIuKJG0oPUcfuwVOlSpByU3b7HV/DBljogasjcXmHYwOEY20IqFuQD2Yc89BHpx4qtQJV89OVHfbmHsky6OSJ5OxCaTQ9XfnbQEo4/kq/wl1pQ13wmGzSxAcCKLT5xdEa413cIJlTXUV24+i0vfmnfiNcgleNssKW4RCVxL4Ma0a4WxyWokog8smO5aYhD7dy7B8f6Hki3UjXj5SLBIt6YUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA9SANBAto0FnL3dXjrICo3Gcwa9w1/AGVZbkzWTOGk=;
 b=fQVFVPsgwTQCBNxNp6M6RxMVvHRDlo3zirKwKQLh7dijy84N/kH9SVR+pXzd/+3mG31sJrZia+NxzXXH52Y986cQaGL8QBL/VZq66A+m/aTCOITt0mbXg2Yd9WI6I77oct/OqT01dv7lrN6Xpw2PKyWsPefiIeo3DOfWnxNERxEyevB2KcAfOzaZTEPq2dmH+cABFaVwd8wWF1h2OafEh/JIeS0gwZT55IwUL6uFHsYh4xvSZG9D/M8Nh1fu6n1lzRPf+1diHRLeXj7Zmd8hOk8fBg9w248Quvquot6vgXdNpWqSJiOzxDXQOvbM5+G+hsXKGSILVdUWhIfkGc1yXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 21:48:22 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 21:48:22 +0000
Message-ID: <d0f20427-256d-d88c-5a40-5e4aa5c0618f@nvidia.com>
Date:   Fri, 31 Mar 2023 16:48:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: mm: Increase MODULES_VSIZE to 2GB
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
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20230330140437.984211-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 25022fd5-7647-4a92-6ba4-08db3231a593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72Xy0ta8EcXFaevSSey+MZd8MJI1PhIJhWqvT17PyBjX4D1uQgna+Fc2dv28Z68TkNxLD38e/+giYNK0bhpJ8Os41qFg5Y3K80DETsF0U8PyY+gk+gH0vlD58aGdc48ij8Rv1XDCWQYTPVBd6Ocyli4noqo259r4+rEHGnAsjbq8fNMWGQjPZStIZCkb3Uvw1EaoMExiq5XJ7DzKp8krUJsAizloaLqF4WxOsSheT7Ul1qLh86JD9mxg4i3NoYwGBvMjQSj+CNQZG6bzw/1Tx8Hkds4Uh1ktdCTzU+1s/8/56y98sTxiKqSzJiOCCQnzF+liP4/n7o34h/+ACw//8WzCJMJ82ZXoekYkCtpTSBGSk64eISTb5su1uBEIRb4afYy7wBtgmQy41kJLd6ClZNeSO3CpKzPyRX1zSLX8B9SeZq584pzPSlnqrQdq38c97ZOiHJUqXQGabJ2IHAjpN60lK/teZhub8AQJA6EARw+3eUNar6Ecn09bTZFLp598/TrKcUe5wr+Y3ZuJn0b4Ox95IQ7ASrLm27hTfK2l4cyrCqYibUZinedQ8x9S8TZwdFNrQ8y7aUfhAxsENCzem0V0G1f927PUy/b05T/P0oECTq7oZQ9XkNpY5WYOf4TDy3Mqqf0Pu2HDnnN+Uwen5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(54906003)(6486002)(186003)(31686004)(31696002)(478600001)(66476007)(8676002)(83380400001)(110136005)(66556008)(316002)(4326008)(66946007)(2616005)(26005)(53546011)(6512007)(6666004)(107886003)(41300700001)(7416002)(5660300002)(2906002)(6506007)(8936002)(38100700002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhYaFBEV2xuTXlicGgyUGl3cWFLK1laUVhERFhBb3VDejFRZklzQVRNSEtU?=
 =?utf-8?B?MG1TNjFtZWxmTEZINHVWN0xRcHF2NUg0VDIzdDVseHdsMFlPM2E1VCtWT1Rm?=
 =?utf-8?B?NXZObU12TzNmWndOOEthNUwyU010aTNPYkloK3BIdk12bU5pR0VvZnhRVGd2?=
 =?utf-8?B?Ym9hd05zSkZyYWtJRnd6VEdDaWp6QXFIaFpkaHVuNHFjMFV5UnRrZjZGeHk1?=
 =?utf-8?B?UzMwdDFEM0d4ZFVKbnBXOFhXYUZBK0lUanBkZDZIWENJTTZIdys2Zm9Gbk1O?=
 =?utf-8?B?ZFVadVJwbGpWM21rOXJVMjQ1SDA2SlJwc1UvQVY4WmhUSDNwdzNHVHJtcEQz?=
 =?utf-8?B?bUdzUzZrYWs0b1NhL2o5dTZlSkdwOTQ1WEtiWjJWVXFVOUlFaml2WXRCbW9Z?=
 =?utf-8?B?a3VwNTlJbWxGU0gzZE5KM1g4a2FZTE1CcXZKVFVPSDRReXhsaEFJSitrTGhm?=
 =?utf-8?B?YWhWVDlUbzBqY2Y1QVFEMisrUEhZR2ZMaDduaTBxZ0xjMXBpZUpqSEJOSzlM?=
 =?utf-8?B?TDRTWi91S0wxTGIwWGVDMFFmZVU3WmpFMGgwYTdqMlcrVFZvNzVhbkNCSHZD?=
 =?utf-8?B?alJPbjI5VWsyRHhTTUs0cnNqOC94emYxMlNuSnczYjBxTkNqS1NJN05PKzJt?=
 =?utf-8?B?OEVHQ24xUllCUTJwSEpHZC8rQTJRam1PVnI4SFRJb05FY3l3ajVqaStvMWMv?=
 =?utf-8?B?YzZieXJTYWIvR3hmemhiYUdpYVNvdHFGU0paOWsrRGFaTHpyRGZsN1Y5R2xX?=
 =?utf-8?B?byszcmRGNDlScGpPWmdjUW81M3RPQ1BPQ3dvTDlyZ2gwM0t6VTg1YTZjUkhr?=
 =?utf-8?B?OTdQcnNFTndxK1p3SlAzdzFrbmxGek8vRTJubHJuSFdhVW5pYS9JSXZhRi9w?=
 =?utf-8?B?VFJxREUvMXg2QTVwNkZNTGFmSEZYRmtxSFZESTZndFNSakxZLzBEK0VkSEtr?=
 =?utf-8?B?cUhJcEVveG1nalIwMEFubjJ0QnZ6Y3E1K0dtNkJwUDhsV0QzMWlhcWxLeUds?=
 =?utf-8?B?a3BOZFNDcW50VzlIOFJyZnN1Z3hLejFDeXhMejVabGF6ZzVYS203U1J2Ykpq?=
 =?utf-8?B?YTl2TEZGYlZSaTJ4MXM3akMzZFlnT0hwaE5oRCsrWXJ6R2FQcXdXcnFMNnJ6?=
 =?utf-8?B?TFBtSVpaWks2QnQzVEF2dXhyN080NDM2V1FRaXVwY1BxMDd1emU3ZEY2TXdK?=
 =?utf-8?B?WDNZM2hpcmJaQjFDczA0TlJDeWg2S3dqOCtGdnJxSkVXUXZxcGFaSm1qRDFp?=
 =?utf-8?B?SkRMT0tCeCtJVk5uKzBJQWRQckU5L0RiWnNoOE1aL1FhM0FOSUNFMUtYVXkw?=
 =?utf-8?B?dHB3WUJFZ2VndS9ZTkVFTE1ENW1rMjl4OGVXck43aXd6MXBOaDR6L0NlWnh6?=
 =?utf-8?B?d3JHRzVIajY0c2VsUThZR2VDWllXc3hTQ2RYamsvRytpNnRGWU5WY2Ivb0Ir?=
 =?utf-8?B?V3BhcnJ6MnVORHRqUW1WMVFHTG8wbGY0QmlvVElsdlB6cnladE8vNVVzS0VM?=
 =?utf-8?B?ZmtUTGZXRHBzT1E2NVJQR1UyMHZ0MmlXdnVHUWcwemRpWjBlSTNKTzllSktp?=
 =?utf-8?B?WEVYVDZtMnU0VDNwMDNTUFlmZC9NbmFkcWVkOTBnbERPeXdIRDdKTGN3N01l?=
 =?utf-8?B?ZnFnV1FrSzhjeTdEdnpFTVQ2N0xKT3J6MHJIQkZXVVlKWWdZdG9xUVloQjA0?=
 =?utf-8?B?dld4T09WcUJmYVN2NEJROGN6TFZSQkpBeVNWZytXbU1oNVVBdis0UjFDVmp6?=
 =?utf-8?B?Snp2VW5XamIwdXdyVGZvaDQxalBmb2pZQkxpaUhqUUZZKy8vMkkwdmNCOE43?=
 =?utf-8?B?OEVLTGRpY0xPVUFBdFFycEZiZ2FGTEJzTlBwZkZaa2ZOWno0dFJQU2N0VkZa?=
 =?utf-8?B?R1lSd29tYnA0Mm1mVHdRUndCLzlPMm9sRDloOWJ0ZU84RWJyVlNvZjc5bzIv?=
 =?utf-8?B?TVdnMllDZWFlWWdHejAxL2FyYThhY3dlTU1JbVhwMForWFd3NytRS1ZuRml3?=
 =?utf-8?B?K0VRbWYrM0VCWXNQbU1sRmVvVldsZ1NVRktvTDJQcnZnNElPbmFoeTNZZEZK?=
 =?utf-8?B?ZlNjazlORTRZT0lVNW5PeXhiUEUxbW1oRnZkdFdsOG44aWZDRXprM2NMeGhR?=
 =?utf-8?Q?WrsTzs9A2lHerdhm2gGpvmfEo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25022fd5-7647-4a92-6ba4-08db3231a593
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 21:48:21.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScadElABFiVR3QqNmYMawcP6UTDzB+XaD0NTOPFoa777TmIaT0zx1vhtk5XAwxP7B2CSzdG6vPWdKqXMr/23Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 3/30/23 09:04, Shanker Donthineni wrote:
> The allocation of modules occurs in two regions. The first region
> is MODULES_VSIZE, which is 128MB in size and shared with the core
> kernel when the KASLR feature is unavailable or disabled through
> a boot parameter. The second region, which is 2GB in size, is
> shared with the other vmalloc callers. Depending on the size of
> the core kernel, the 128MB region may quickly fill up after
> loading a few modules, causing the system to switch to the 2GB
> region. Unfortunately, even the 2GB region can run out of space
> if previously loaded modules and other kernel subsystems consume
> the entire area, leaving no space for additional modules.
> 
> This issue usually occurs when the system has a large number of
> CPU cores, PCIe host-brigde controllers, and I/O devices. For
> instance, the ECAM region of one host-bridge controller can use
> up to 256MB of vmalloc space, while eight controllers can occupy
> the entire 2GB.
> 
> To address this problem, a possible solution would be to increase
> the MODULES_VSIZE to 2GB. This would improve the system's ability
> to accommodate a greater number of dynamically loaded modules and
> drivers when KASLR is not enabled. However, prior to switching to
> the 2GB region, it is advisable to allocate modules within the
> 128MB space that covers the core kernel, in order to benefit from
> the direct branches.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
> Changes since v1:
>   - Included Ard's recommendations.
>   - Revised the commit message.
> 
> dmesg:
>   On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
>   due to vmalloc/vmap allocation errors when loading modules.
> 
>   [   64.181308] ipmi_ssif: IPMI SSIF Interface driver
>   [   64.184494] usbcore: registered new interface driver r8152
>   [   64.242492] vmap allocation for size 393216 failed: use vmalloc=<size> to increase size
>   [   64.242499] systemd-udevd: vmalloc error: size 327680, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-3
>   [   64.242510] CPU: 32 PID: 2910 Comm: systemd-udevd Tainted: G           OE      6.2-generic-64k
>   [   64.242513] Hardware name: NVIDIA T241, BIOS v1.1.0 2023-03-18T21:32:31+00:00
>   [   64.242515] Call trace:
>   [   64.242516]  dump_backtrace+0xe0/0x130
>   [   64.242523]  show_stack+0x20/0x60
>   [   64.242525]  dump_stack_lvl+0x68/0x84
>   [   64.242530]  dump_stack+0x18/0x34
>   [   64.242532]  warn_alloc+0x11c/0x1b0
>   [   64.242537]  __vmalloc_node_range+0xe0/0x20c
>   [   64.242540]  module_alloc+0x118/0x160
>   [   64.242543]  move_module+0x2c/0x190
>   [   64.242546]  layout_and_allocate+0xfc/0x160
>   [   64.242548]  load_module+0x260/0xbc4
>   [   64.242549]  __do_sys_finit_module+0xac/0x130
>   [   64.242551]  __arm64_sys_finit_module+0x28/0x34
>   [   64.242552]  invoke_syscall+0x78/0x100
>   [   64.242553]  el0_svc_common.constprop.0+0x170/0x194
>   [   64.242555]  do_el0_svc+0x38/0x4c
>   [   64.242556]  el0_svc+0x2c/0xc0
>   [   64.242558]  el0t_64_sync_handler+0xbc/0x13c
>   [   64.242560]  el0t_64_sync+0x1a0/0x1a4
> 
>   Documentation/arm64/memory.rst  | 8 ++++----
>   arch/arm64/include/asm/memory.h | 2 +-
>   arch/arm64/kernel/module.c      | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> index 2a641ba7be3b..55a55f30eed8 100644
> --- a/Documentation/arm64/memory.rst
> +++ b/Documentation/arm64/memory.rst
> @@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
>     0000000000000000	0000ffffffffffff	 256TB		user
>     ffff000000000000	ffff7fffffffffff	 128TB		kernel logical memory map
>    [ffff600000000000	ffff7fffffffffff]	  32TB		[kasan shadow region]
> -  ffff800000000000	ffff800007ffffff	 128MB		modules
> -  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
> +  ffff800000000000	ffff80007fffffff	   2GB		modules
> +  ffff800080000000	fffffbffefffffff	 124TB		vmalloc
>     fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
>     fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
>     fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
> @@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
>     0000000000000000	000fffffffffffff	   4PB		user
>     fff0000000000000	ffff7fffffffffff	  ~4PB		kernel logical memory map
>    [fffd800000000000	ffff7fffffffffff]	 512TB		[kasan shadow region]
> -  ffff800000000000	ffff800007ffffff	 128MB		modules
> -  ffff800008000000	fffffbffefffffff	 124TB		vmalloc
> +  ffff800000000000	ffff80007fffffff	   2GB		modules
> +  ffff800080000000	fffffbffefffffff	 124TB		vmalloc
>     fffffbfff0000000	fffffbfffdffffff	 224MB		fixed mappings (top down)
>     fffffbfffe000000	fffffbfffe7fffff	   8MB		[guard region]
>     fffffbfffe800000	fffffbffff7fffff	  16MB		PCI I/O space
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0..b58c3127323e 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -46,7 +46,7 @@
>   #define KIMAGE_VADDR		(MODULES_END)
>   #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
>   #define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
> -#define MODULES_VSIZE		(SZ_128M)
> +#define MODULES_VSIZE		(SZ_2G)
>   #define VMEMMAP_START		(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>   #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
>   #define PCI_IO_END		(VMEMMAP_START - SZ_8M)
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 5af4975caeb5..b4affe775f23 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
>   		/* don't exceed the static module region - see below */
>   		module_alloc_end = MODULES_END;
>   
> -	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> +	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_end - SZ_128M,
>   				module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
>   				NUMA_NO_NODE, __builtin_return_address(0));
>   
Occasionally encountering the "overflow in relocation type 261" error suggests that the
expression 'module_alloc_end - SZ_128M' may be outside the 2GB range starting from the
beginning of _stext. Used the following code to resolve the issue And also enable
randomization of module base within 128MB if CONFIG_RANDOMIZE_MODULE_REGION_FULL is not
defined.


--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
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
index e7477f21a4c9..4f92fc511b85 100644
@@ -70,18 +70,19 @@ static int __init kaslr_init(void)
                  * resolved normally.)
                  */
                 module_range = SZ_2G - (u64)(_end - _stext);
-               module_alloc_base = max((u64)_end - SZ_2G, (u64)MODULES_VADDR);
+               module_alloc_base = max((u64)_etext - SZ_2G, (u64)MODULES_VADDR);
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

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 5af4975caeb5..b4affe775f23 100644
@@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
                 /* don't exceed the static module region - see below */
                 module_alloc_end = MODULES_END;

-       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
+       p = __vmalloc_node_range(size, MODULE_ALIGN, kaslr_enabled() ?
+                               module_alloc_base : module_alloc_end - SZ_128M,
                                 module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
                                 NUMA_NO_NODE, __builtin_return_address(0));


