Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01C6C9784
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCZS76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:59:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7B55A9;
        Sun, 26 Mar 2023 11:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd+1MRzs5CntXccvs0PyaRJbZ3UbPJToTNIGAwLuOjInF1a3oVq12WhHdbHau/J0smx82n4DNrmbiLhSC9so1k7/yrrgK9TtbQLfLqjoHvXbCoRRfYZy6QtCqCmk+g96ebb1NoWJiCviwldd7COlzWkUJL4caxInlBkaHi0jaQ9vwBbbJZgacfCTZKI+kQS+6ZqwpmssgrC0cu5Bt3RjPU7TZLiwezSo/8ZBsPaJpF8HZGOhStS/2dkF5ICUhW9wa2vzA/1ZbRlPfriKUM8RSbyV+w3wX5XVDlgnO2UWQU71l89/OI4D3i6GqOsKOoUk8gwAw7Ze3fNXM4uUqP8hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tCNRdHrNKy1z/zL7ei8Pd8YvSpUdbghg8p0u9bFVzk=;
 b=GGx4m5cIX0Yvd0oHrIWVJ/55mpyp5CQuKG4lv3WxfvLsSRvAr5HDF54gfraG1EOWWfnfaCAKBYguQOjJY/FLrOWFFPDlymUy6q8JAZNPwCrNjGt9eg2kuoScTQvLZ8zJukgVvU8S8/6RBvMO8/a9KIFTVtU0e485Upmm3/uW46rCET/QV4/UCVuOKgg0LS4Qao6PKsOUn5RPl853+A6cnchvi2+mxOEI60Knj9CJFdc+rXkebjXyXLp+0nqkDvq96kG4Jep8j2ethWG4c6dzh6wnecx4BvQT++AHN0qlytRHkFRh0Q9xS3eTg8B1pZczfEbZZ79PGJKtSIFXrqHpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tCNRdHrNKy1z/zL7ei8Pd8YvSpUdbghg8p0u9bFVzk=;
 b=GkekD6ofs9gYik0sgJ+VMhYPuTm6hc8+kQrj/BSm1mZWQqWYOL3VZcPKnVT53Q0ajoY6pQiHDH1W/l9Ki5aJIFBcw4vHpijcX7kpVW1yTc5P75ozL0Rw9eUxtRzcvyfexx2QJprZh9rKq9EC+MfsxYS+cL61FX5YffDrye7++1PFO3fmEvf3wqignuffEpPP+X3Sa2yNnZStIrIzEDn9/w89D+i9HIXNxjRdFn3JjCltP/ZgC3pnanLiJUsZAJCEEb+56hNa5PVAEXiPB8w5YKIAtGF0qOuApJR1J9xtk7h1yAxb+iVssqRpoyzmh5+cICS1V0wi0Zf0lJ7pcosErw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 18:59:52 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.038; Sun, 26 Mar 2023
 18:59:52 +0000
Message-ID: <159ceeab-09af-3174-5058-445bc8dcf85b@nvidia.com>
Date:   Sun, 26 Mar 2023 13:59:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: mm: Increase MODULES_VSIZE to 512MB
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230326170756.3021936-1-sdonthineni@nvidia.com>
 <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:5:335::16) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaefa0c-ed92-4da9-e6cc-08db2e2c4798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8bVg+vwKsMFd4Miw/2PZ3oIjM2+UUgf7aR1u2r5PkPTyAC6jbQtSsyqXqWFGXFnwGkQ6/o3H9tgeQRJlN4o/xavq9VzRyo/xtTh80EI8XJ/krCGopzx+C4rX5/JL+dDx3xCLgv06+VLt4+Wvr0+AHr+a81zIr2mdfSc53DsAcCDrJuIky5uD3ShQ1lKbYh5Fnw/q2kPt844KUQZ4kLX/BaX93Mhw3rDH3+nDB3PRE+ZC/sV1de6zr1U3rN0V9DoFrUOIbD13BTp4W3eLTHQwbndSwVmbE+CHswNEGwrgDxZGDR7X/uB2WUxDShJWg8NKf6EfsS1o6kSPRTi6PHyS55najYcz14QTwusrs+nsF3O+aNVBg49XskIpMFe//AE7MXsxSONLqw8TDFmLMR1m6P6RjG/goJUoNgsk2joDCTfSa/RAECSLeNIPAJFdxpZqCsmaPgm3Flu7OuGJG+v0vhEomJSR1OSJ3h4sVvstq5VphHULUOTc56uaNG6TlvmC55TQoMy6YAKtbQTcH4cpd7BtkT0wIKf9SzLpnce3UfZ7YKXor9lOcbbuDWeaubbGpMLmCKrgf7npXw2AMNxOQvJC8TfcTaScx7JSwiwdyVJwxKndB/bzD8STed1lVX2q8IrFWQaFBWJlJhGZeYxdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(66556008)(7416002)(31696002)(31686004)(8676002)(41300700001)(6512007)(53546011)(66946007)(26005)(5660300002)(66476007)(478600001)(2616005)(8936002)(316002)(186003)(86362001)(83380400001)(6916009)(2906002)(54906003)(6506007)(6486002)(4326008)(36756003)(6666004)(107886003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVXMk0zVTU4a29ndm1sQW1UWXc0eVdDS1lZOG9oQlBCay9KWHV1cmpYUEpF?=
 =?utf-8?B?ekxta0lkQkZzZkNIRkY5QnRpb2ZlSjBSSDRuWFFTN0FxdWZVRDQvV3ArRFFG?=
 =?utf-8?B?cEhEdmlNSytHS095VFhobk1BMjZacGhSSVAxK0IrWWFzTTA3ZjdRVnhBTW9Y?=
 =?utf-8?B?OWU3dzZzSVhFVnVleTh5R21vaTJpVEJxN2x3QjdTK2UzZGd0czdXclYrUEl4?=
 =?utf-8?B?R2pHV2ZJOERDaUE3Umk0ZlUzaGJRZ0dPTDJtVjExb0pPb3VNSVBJeEp4THor?=
 =?utf-8?B?eE1maDZXa3NMcDdKTkUyVUkzQldXU2lrOVBWZ3hRa1czU0dMNWVIZm0wUUlv?=
 =?utf-8?B?Y09NbkZpZ2ZJenJBeGVDWndsbGZKeENPeGtLOUd5MUpVZDRwOTUxZ2ZEb0hv?=
 =?utf-8?B?bUFWV3AxWW9tcFRRZ0QwaFlWUktucHhLTlFGUGVIZGt1S1NDWnZrNENaQ1RW?=
 =?utf-8?B?WGJYVm1vZWRsZ1I2Ky8vbkMrT2pWMjhzRmhEdndNR25iUHJSNEpUS3NOL1hu?=
 =?utf-8?B?bnFhaGRPRXV3ZEI2M0NObG1kMFhKYkY0RDlGc0xPODl2cnoyekJ6L2ZGSGQv?=
 =?utf-8?B?d0FEOEdySkVQNkpEOGR1WnNIYkhiU3pyT0tsU2l0OW90QzRDWS9jUTlvUTlP?=
 =?utf-8?B?WXp2RGNCbzFZSkFjQXpJVWNtUzFGTFlEblZsNGFIZFN2NnU4NUlOTlhBUmdH?=
 =?utf-8?B?MXc3Mk43YWh0b2JoWWpVdExEQUlObjNMT1RkOSt6UXBrd1FDcGU1bTU0T05i?=
 =?utf-8?B?bmt6WW5xazJPcXQvVWFJNWx3d01HOWtDcStXZGI4TFh3NnBYMHY1UDNXQkVC?=
 =?utf-8?B?TWcvL2o0Zy9IOXY5cVlMWjljdEZMaDhyc25MOFp5RFVtOUUvcmszaDN0Yzgr?=
 =?utf-8?B?cWZ4Z093QWRweGFxZUhFWlBIYlJCVzk3TXpHL1M1WVpxdGV4c2VWQlU5YVFu?=
 =?utf-8?B?OFdYT241WUo2R3YzQjQ3T0FQSEo1clRLeWg3dFR2SVc4b1ZQOEFNNmF4UEM2?=
 =?utf-8?B?UWE4dGFXc3lwZExSbkZXbU0yV0d5K3Z6alJFV1ROck1GS0tSZWdqNFNxR2w1?=
 =?utf-8?B?S3E0a0dDRDM4U3ZzZXgwTWIrUWkzMlFKVE5JUi9KUW90MkFRMllVTmQxeTBE?=
 =?utf-8?B?aUJuQlVFNkJ1cXRoSTVhaWIwMm1mVUhqemV0QkJCQWRDL3ArZ1pONjR6Tytr?=
 =?utf-8?B?K2tzWXlXMW4ySW1heHN4dzV4OW16RjVBME1IeWZrWDk1T202a2U3MlhDdG91?=
 =?utf-8?B?SlNEVFUxMS9SRjJ0eDA0L2xXVHlWL0lZRFpRMWl5NkcvRm44RGtkaVJXeU5x?=
 =?utf-8?B?cjBFamRMSllCMDdCYW5lVTVBYnQvNEROak44QjhOaUF4aU5vOHVDdVVJVk5U?=
 =?utf-8?B?MlEydkVJWTZiWFRFZEVNcVJ4Qks4ZGFmQzdsWSt2Y3RkNTNneERCekJYM2t2?=
 =?utf-8?B?TWx6eDYvclVNTlhwb2ZnYlMwWWpTQmd0QmV0NlVqd0NoR2poV1paV0YwVndy?=
 =?utf-8?B?Q0d5QzBSTFJFYmVrY0hMSm1PZnlBQ1pFMm9iSjJrMXA1eFJ3Ymo1ZnVzUG1J?=
 =?utf-8?B?TTdrZWhVQ04rZkJkSkR4OWczVmRDL3BTSEppMm40a0tPbjNTMWlRN3I2SmVJ?=
 =?utf-8?B?ZjBUc2hwemFGZ1JpMzVaazBmdEVQeVpDcjJQMlhBd0cwWHI1TWZZYzhSQzdy?=
 =?utf-8?B?Y29GYTg4QnpHUU00c2FZcnk1eWRPbk51QjZGSTlVREZ6NHR5RmFqMmxQMVU5?=
 =?utf-8?B?WCtpRmxEZ0lTc1BCb0lzc0tpU2RvQXVZWHFpRmN4OUtrVGk4NVV6UlNsemNr?=
 =?utf-8?B?bUwrckd0WHg2Ti82Mk5sZVRobnh1WjhwT3NBT0lyb3VUeG9QcEJyZGl5b0po?=
 =?utf-8?B?QlNEeGZZVWl4cmlWUFl3dFE5RjFnOVNYdFhLeklRUTd4WU12b2kvaDlHSmsw?=
 =?utf-8?B?bGtkZzdIb2k4cm1qNysvUysrK0g2eGxIaTZReDNhd0ZGK1RWODBxRUNIL21P?=
 =?utf-8?B?QytaK1U3VzkzSGJ3RkJ5c3pIc1VRK1VhaER0VGVSOTc2eWdxckVNSXE3RXpu?=
 =?utf-8?B?ekRFcFY5QXp1SkhvVkZ5M2NIYm1IaTJrWUcxaXdNeHdiM1VqTUN6bUhoeG9v?=
 =?utf-8?Q?8qHlNMz3ON/HknVltddWd/7zT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaefa0c-ed92-4da9-e6cc-08db2e2c4798
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 18:59:51.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYNC+8qLp7S5l8fWzQEXm00ngGcPvUHcKfEBJ7tf4aJk0QwH0TdniMAhLvmPFXs3lVNzxCaONSbXVYw0jkjfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ard for a quick feedback.

On 3/26/23 12:35, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 26 Mar 2023 at 19:08, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> The allocation of modules occurs in two regions: the first region
>> MODULES_VSIZE (128MB) is shared with the core kernel, while the
>> the second region (2GB) is shared with other vmalloc callers.
>> Depending on the size of the core kernel, the 128MB region may
>> quickly fill up after loading a few modules, causing the system
>> to switch to the 2GB region.
> 
> How much module space are you actually using? This 128 MiB region is
> not shared with vmalloc() so it should be dedicated to modules
> entirely.
> 
Is it correct to say that if the KASLR feature is disabled, 128MB is
being shared between the kernel and modules? Approximately 110MB used
by the NVIDIA GPU driver, resulting in the usage of more than 128MB.

root@localhost:~# cat /proc/kallsyms | grep -wE '_etext|_stext|_end'
ffff8000081d0000 T _stext
ffff800009390000 D _etext
ffff80000b4d0000 B _end

root@localhost:~# cat /proc/vmallocinfo | more
0xffff800001390000-0xffff800001450000  786432 move_module+0x2c/0x190 pages=11 vmalloc N0=11
0xffff800001450000-0xffff8000014b0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
0xffff8000014f0000-0xffff800001550000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
0xffff800001590000-0xffff8000015f0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
0xffff800001630000-0xffff800001690000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
0xffff8000016d0000-0xffff800001740000  458752 move_module+0x2c/0x190 pages=6 vmalloc N0=6
0xffff800001780000-0xffff8000017e0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
0xffff800001820000-0xffff800001880000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
...

The first modules loaded at the address 0xffff800001390000.

Less than 128MB is available for modules if KASLR is disabled.

> If you are doing EFI boot, you may need to following patch to ensure
> that the 128 MiB region is actually the one being used.
> 
> commit 010338d729c1090036eb40d2a60b7b7bce2445b8
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Thu Feb 23 21:41:01 2023 +0100
> 
>      arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
> 
> 
I have included your patch to prevent the incorrect detection of the
KASLR feature. Otherwise, experiencing the different error
"overflow in relocation type 261", R_AARCH64_PREL32. Seems this is
due to the incorrect initialization of module_alloc_base.

>> Unfortunately, even the 2GB region
>> can run out of space if previously loaded modules and the other
>> kernel subsystems consume the entire area, leaving no space for
>> additional modules.
>>
>> This issue usually occurs when the system has a large number of
>> CPU cores, PCIe host-brigde controllers, and I/O devices. For
>> instance, the ECAM region of one host-bridge controller can use
>> up to 256MB of vmalloc space, while eight controllers can occupy
>> the entire 2GB.
>>
>> One potential solution to address this issue is to increase the
>> size of the MODULES_VSIZE region to 512MB, which would enhance
>> the system's ability to support a greater number of dynamically
>> loaded modules and drivers.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>
>> I am seeking your guidance and feedback on the proposed solution
>> to address the module load failures, specifically regarding any
>> potential side effects that I need to be aware of. Additionally,
>> I would appreciate your suggestions on any alternative solutions
>> to resolve the issue.
>>
>> On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
>> due to vmalloc/vmap allocation errors when loading modules.
>> dmesg:
>>   [   64.181308] ipmi_ssif: IPMI SSIF Interface driver
>>   [   64.184494] usbcore: registered new interface driver r8152
>>   [   64.242492] vmap allocation for size 393216 failed: use vmalloc=<size> to increase size
>>   [   64.242499] systemd-udevd: vmalloc error: size 327680, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-3
>>   [   64.242510] CPU: 32 PID: 2910 Comm: systemd-udevd Tainted: G           OE      6.2-generic-64k
>>   [   64.242513] Hardware name: NVIDIA T241, BIOS v1.1.0 2023-03-18T21:32:31+00:00
>>   [   64.242515] Call trace:
>>   [   64.242516]  dump_backtrace+0xe0/0x130
>>   [   64.242523]  show_stack+0x20/0x60
>>   [   64.242525]  dump_stack_lvl+0x68/0x84
>>   [   64.242530]  dump_stack+0x18/0x34
>>   [   64.242532]  warn_alloc+0x11c/0x1b0
>>   [   64.242537]  __vmalloc_node_range+0xe0/0x20c
>>   [   64.242540]  module_alloc+0x118/0x160
>>   [   64.242543]  move_module+0x2c/0x190
>>   [   64.242546]  layout_and_allocate+0xfc/0x160
>>   [   64.242548]  load_module+0x260/0xbc4
>>   [   64.242549]  __do_sys_finit_module+0xac/0x130
>>   [   64.242551]  __arm64_sys_finit_module+0x28/0x34
>>   [   64.242552]  invoke_syscall+0x78/0x100
>>   [   64.242553]  el0_svc_common.constprop.0+0x170/0x194
>>   [   64.242555]  do_el0_svc+0x38/0x4c
>>   [   64.242556]  el0_svc+0x2c/0xc0
>>   [   64.242558]  el0t_64_sync_handler+0xbc/0x13c
>>   [   64.242560]  el0t_64_sync+0x1a0/0x1a4
>>
>>   Documentation/arm64/memory.rst  | 8 ++++----
>>   arch/arm64/include/asm/memory.h | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
>> index 2a641ba7be3b..76c2fd8bbbf7 100644
>> --- a/Documentation/arm64/memory.rst
>> +++ b/Documentation/arm64/memory.rst
>> @@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
>>     0000000000000000     0000ffffffffffff         256TB          user
>>     ffff000000000000     ffff7fffffffffff         128TB          kernel logical memory map
>>    [ffff600000000000     ffff7fffffffffff]         32TB          [kasan shadow region]
>> -  ffff800000000000     ffff800007ffffff         128MB          modules
>> -  ffff800008000000     fffffbffefffffff         124TB          vmalloc
>> +  ffff800000000000     ffff80001fffffff         512MB          modules
>> +  ffff800020000000     fffffbffefffffff         124TB          vmalloc
>>     fffffbfff0000000     fffffbfffdffffff         224MB          fixed mappings (top down)
>>     fffffbfffe000000     fffffbfffe7fffff           8MB          [guard region]
>>     fffffbfffe800000     fffffbffff7fffff          16MB          PCI I/O space
>> @@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
>>     0000000000000000     000fffffffffffff           4PB          user
>>     fff0000000000000     ffff7fffffffffff          ~4PB          kernel logical memory map
>>    [fffd800000000000     ffff7fffffffffff]        512TB          [kasan shadow region]
>> -  ffff800000000000     ffff800007ffffff         128MB          modules
>> -  ffff800008000000     fffffbffefffffff         124TB          vmalloc
>> +  ffff800000000000     ffff80001fffffff         512MB          modules
>> +  ffff800020000000     fffffbffefffffff         124TB          vmalloc
>>     fffffbfff0000000     fffffbfffdffffff         224MB          fixed mappings (top down)
>>     fffffbfffe000000     fffffbfffe7fffff           8MB          [guard region]
>>     fffffbfffe800000     fffffbffff7fffff          16MB          PCI I/O space
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 78e5163836a0..dd5d634e235f 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -46,7 +46,7 @@
>>   #define KIMAGE_VADDR           (MODULES_END)
>>   #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
>>   #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
>> -#define MODULES_VSIZE          (SZ_128M)
>> +#define MODULES_VSIZE          (SZ_512M)
>>   #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>>   #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
>>   #define PCI_IO_END             (VMEMMAP_START - SZ_8M)
>> --
>> 2.25.1
>>
