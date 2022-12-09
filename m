Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0771664839F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLIOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLIOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:18:42 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66AE080
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X08RfQJb0W+njtaC0YJ9DbYsokFFYhqgipx7SEV8sZSudobjGCT+XC9PoPHBE25SV5C8zw0lhEfkc6Rq6DgqjCMAejAGggClMmbVbQe+60tePQ5sWrQCthmGpx/I1Zf3R7N7rcL/snJRsyrfE2VHRyeQ5XoGQHm7CyMYq9QdeDQsGyq1pKMHLDzs2uohuMehZK5IRiOhJU12RQjUQzFu3aLyvuJopiNTIQ1Nc6kUD6RIWUXDBqCVEFtuVfmfXPN5kBHqvEfwiAlT0vQOOlLzQCEItKcIOS7rJjjIxk8Q6T64K+7umH5nAd/cqFEIfHixuaXCVNrLNa425lZeUTTKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVAz9uKDQXcnUn5agWOzCUtsaNY7ViMVSIPE/Leypwc=;
 b=KSgVLjDFDnHbrdFwW6rn1rpHoqDtXQKfJRnzuaR943KjLxraCeKRMuDtMzbwQvj49DiX1iKmd2We0LwR79medC6uM0HvoBe25WdOP8yb94eZQesMi4+p8IFl3PDguI+23J6JMeiZReeActC5FWnxqtlRlOnvlB5YLggNYSUBNfVDZ6n1qafotwjT8LLpxZdRcsYG+ClBr1hNS4+bn0myMRvmqjNA5KZuD/6m4FOBQd7wnXeknx7aHX3T70oR8WSRQDz5LBCAcdA2IeNeMBa3VHTtkGBZvcnWzEI9CIG9Zuve/TcgJqMkNPIl2zZbl2hdBhgaICEx9vOJDQUPXrHrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVAz9uKDQXcnUn5agWOzCUtsaNY7ViMVSIPE/Leypwc=;
 b=BORizsCcy8LtBZkuo56sQh2ZB0eDmT+uxNZm9KqV7yXDWWHZa6RjkxSjTaEiaXJUXfKZLay9ZfSSUa84W99RcTtDyDpBX02nzld9u96zhnduS6GbfAstmctSWuJ5wYx0RsiyqDHQLfUc2Sx7wF3QVM20+aTTTvyCgZa8q4VCsE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 14:18:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%4]) with mapi id 15.20.5880.017; Fri, 9 Dec 2022
 14:18:38 +0000
Message-ID: <0a7720bc-8e9e-a72f-ea97-ad46cbe50aa2@amd.com>
Date:   Fri, 9 Dec 2022 08:18:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 5/5] x86/sev: Add SNP-specific unaccepted memory
 support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <cover.1670513353.git.thomas.lendacky@amd.com>
 <a46c897353203bf24bc104c314cd99dc68f5cdca.1670513353.git.thomas.lendacky@amd.com>
 <20221208221248.slltzm5ehnbltdee@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221208221248.slltzm5ehnbltdee@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:fc::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ced30d8-1639-4125-b09c-08dad9f04415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY1pOGc0HMn/jx3GsqPa/vK9XXnS0CdWsyOCzNcFwxtfS2zLWuljXwQlWH7LuLMwmvSxiH2pnAicobb1mDlYZhyq5u96W8e6xmnysAN6i27XjMM66fDVPePaEUZWpcdgcwIkqqRFNyLfUub4QKxRU8+HHe9EGDZTpTLetOe7cfOKLwzQmhx7MVxclG/UgKD4jPGZ5FDUMnLRP6WiFDn5cTzOTMwY4wry//wNI0ofP/JPcdLUoTkyXRqTRLLYNr3CCZy4eH5BnYW8hOjtyVA21Ui0XxnxOLCcD+LYHkY2e3MDV3LNJa4eZDPo6HLOb73yNHqfqgdPrhlhEmNvwdbcNxxkMi4P7+K1V71/lfw+uqeAanArsz+HCeXIdA4BFa/+W10b8mvvowZJqwHFgLII4i+p4drsvHNWVEdk54XCx9j6gb3iRyGi6bz5ahzmPv5bxboNIKFjeNo53RRbdzivobpv2izSxglBKvFSc8wVrhdRpxT2/nlTkS6/b8uhh3Wf9dhVHelKB6M01Hsxe2UE8ED0Tg2cBx6DzeSB85ujlNQmv7nzw8yTq9g/QjALxKmcx0cyBWRdDPuVbFgHKT8SUBgvnR9gIuHvIEk8IRjGnlgAuE1QsMT1VNNkBZEsxPDgMroZGOBw1KqKZtulcn4Ys1KnznKJRlKXLQ+EmiJ3uknmmzpVUeqhxFmFNxWnGGIf6RX5IXacO1IbCTBszDBrIgptlacNRfkvJrxQlpES/1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(66946007)(66476007)(66556008)(8676002)(8936002)(4326008)(36756003)(41300700001)(83380400001)(478600001)(6512007)(186003)(26005)(6486002)(6666004)(6506007)(53546011)(38100700002)(2616005)(316002)(6916009)(31696002)(54906003)(86362001)(2906002)(31686004)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdya2gzZndVOGhBRGVGdVkxcktwZ2JoYStQK1ZmcENoRE80VVhHNjNZNEdB?=
 =?utf-8?B?NkhFa0dHNUNrMkRiV3ZpbHB6OE9aL1JzKzk5RE05OGYvbEVZdlQwTTYxck9V?=
 =?utf-8?B?eVFjN2RCbkh4di9UVWVURE1MeWRnV2VhSUhSQ0I3dXdSYjlqZ3dVdDdQakJK?=
 =?utf-8?B?Q2pOZENXYjhVMXJBRHJTdGFwcE1Rb3IvUEpPa2M3b1lvVHlrTUQ5TW9Kd09I?=
 =?utf-8?B?UmJNanE1YU1hWXVWcVErR3ZKRnFTVHpyYmEzSjErUFUwMzJoOVFYYzNWLzAy?=
 =?utf-8?B?aUdNVU1OdHRibUtVTUVzWloxQmtST3k1cFg1c1Z1QzdZSElPQ1BDT0lhSFdY?=
 =?utf-8?B?aU4vUmNlRE9wYUpDNjZNaVEwRkI3d3hOSTJ6UEVIL3FJN2xoZlV1a2l5SW45?=
 =?utf-8?B?dzByOE9HcVo4ODZkSWZwMTdIQmYzaG1VVUx3akQzWFEvVkZOU1FHVGkxR3hr?=
 =?utf-8?B?QW9iVG1mR1ljMUJuWks0bkYzZnc1UTcxcDNpYVlDNE1ZWTVrcGhBRm4xTjNP?=
 =?utf-8?B?SmpKeTB0V0Fjd240c2x2Y3BjL1hxcElNUU9nMVpPYVNTcDNiRXl1WnZ1RDZ6?=
 =?utf-8?B?RzFHMnVadHBUSVhJRjhrSkI3TnpLZEdmTWFBTjgvb1pRNGdaYy9MMGxRbGVx?=
 =?utf-8?B?aVNqcTVqNGdVYTlsUUJnQjdrekppUlppUmJUZElGcDV3SWhpK0VzQ3Y4UE0v?=
 =?utf-8?B?a0hHNkhZYXNrU3AwNlJNenRCYnJVRG1VQzRndWg4TlNCUnF6Z2dOTWxIWUw2?=
 =?utf-8?B?MUh6c1VTRHdzcmp2UnM3d3kwZ3JveEYxRDgwVFJxS1JhOE9WUGRERVVxTGE0?=
 =?utf-8?B?Mk9xaG13blptVU1lOTRXTWZjZGhjbHlFOVZnTzdmc2dRNTRaTXlqakZDOFpQ?=
 =?utf-8?B?bzgrUUFxVlFjUlQvclJ0blB0b2VZSlM1V3BrTFhsWDAzSEpZTkpNWGs2WWFM?=
 =?utf-8?B?Z2l4SlZMVkJ3TE5POGErcnYyeTUvWFRjcGYvOGVoaW5uT0tLSEtYRmFiZ2Uz?=
 =?utf-8?B?R253QUQwSnRlNGJIRkhndWRwTk9yYUU4bi9MZ2JkdzJFUnUvWTRvZklMM0pm?=
 =?utf-8?B?ajVOdS9wN3I1RlY1N1VrMFg4d3B5cDV6OTJKbkdnVHlTdU1HMzY4dWl1MDZt?=
 =?utf-8?B?SXlxTzNJMHMxLzVGUEFtaWJkUkthWXJpWmYvQWhGVitkaXlKMHoybktBYmtL?=
 =?utf-8?B?VythNXZlT3FYSjN1ZWRHNGFBa2VLRXBQU2tTR3BCZ3k4OFBWek9tNnh3emJ3?=
 =?utf-8?B?SnFCTnZyS2FzTXdkN0g0WHZJMC9SRzA3ZmdqNEUwOWpURElpbXFLTndyd3RC?=
 =?utf-8?B?QVJDMi9TSE95dWo2aVRjVmVrQ2xvZk1Yd2VnMlFXVU0zVnR4aTh0NjRYZmR3?=
 =?utf-8?B?dU9tdEI3Tk5ock8zT3pQZCtkdk8vV0FndisranVhL1pMQWxsV0x5WkFXZHoy?=
 =?utf-8?B?TWhHa09GQWNKbG9HdlFCeTh3RElDV0N6dWxBc2NvVlp2d2pSOVhvY1A3V09I?=
 =?utf-8?B?UkxMNXhxT3pTbC9pdDJJaUhURWowaWQ4Qkx1Sm1NdzBDRnFqSFFNa1ZzckpD?=
 =?utf-8?B?TUcva052RUg1SnBENnl4bHJuWTV3eFJoaE14Nm1meTlxdU9ncjNmVVRBQ0hN?=
 =?utf-8?B?UDlGUDA3anZXSnppbWFJdUQvajY0QmdRMEFEUEtSNkR2eUE3TVJSOUw4UENu?=
 =?utf-8?B?NkJOb0NGdXN2NEtDVUJZVlJYa0sxVUpiWTFnTjE2MFJrcjgwMW1hR2NWNUlT?=
 =?utf-8?B?cG4rbFFCV2t3OEVWV3hWYldEUnFtNm1EbXRoRHNZQTJOdURaTEx6aS9uNnBV?=
 =?utf-8?B?cnVJUjEza2owZWFDZFZmSG5ycEYxaVEzdkxSWG1yZGN5UHRaOHpvaVNaWFhE?=
 =?utf-8?B?QlQ4ZEhqZUwwWVJCeEFwOXZTS055U1JZU2JDK0djS3V6RjdJb05UVzRKWUo0?=
 =?utf-8?B?ZkR4YVh4d3U2alhPYUc0OFhXbER4MVA5bDN1UUF2Z1RJL2tITEJkY3RHTTNP?=
 =?utf-8?B?Wi9YZCtuRDRCU1B3SGNMcjNjZEJLUkVicmM3cW14UTVrYWtkcXpuMFU2R04x?=
 =?utf-8?B?U3h3TldoKzJGL05SOFpqS3Zvak9mZCs3bGprVzlIMjJaUENwZDZTVWRxWGFs?=
 =?utf-8?Q?bPQwnuM/QUzbMX7WZJgA6z925?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced30d8-1639-4125-b09c-08dad9f04415
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 14:18:38.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9w8N5PXxoFw8dACRGrasjvXP8xnXgCfbzoUSmGwT/7/vHPlHDfL7EEbNwP4Ptst6Lj/DLHfOySYJeFuWds/FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 16:12, Kirill A. Shutemov wrote:
> On Thu, Dec 08, 2022 at 09:29:13AM -0600, Tom Lendacky wrote:
>> Add SNP-specific hooks to the unaccepted memory support in the boot
>> path (__accept_memory()) and the core kernel (accept_memory()) in order
>> to support booting SNP guests when unaccepted memory is present. Without
>> this support, SNP guests will fail to boot and/or panic() when unaccepted
>> memory is present in the EFI memory map.
>>
>> The process of accepting memory under SNP involves invoking the hypervisor
>> to perform a page state change for the page to private memory and then
>> issuing a PVALIDATE instruction to accept the page.
>>
>> Since the boot path and the core kernel paths perform similar operations,
>> move the pvalidate_pages() and vmgexit_psc() functions into sev-shared.c
>> to avoid code duplication.
>>
>> Create the new header file arch/x86/boot/compressed/sev.h because adding
>> the function declaration to any of the existing SEV related header files
>> pulls in too many other header files, causing the build to fail.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/Kconfig                |   1 +
>>   arch/x86/boot/compressed/mem.c  |   3 +
>>   arch/x86/boot/compressed/sev.c  |  54 ++++++++++++++-
>>   arch/x86/boot/compressed/sev.h  |  23 +++++++
>>   arch/x86/include/asm/sev.h      |   3 +
>>   arch/x86/kernel/sev-shared.c    | 103 +++++++++++++++++++++++++++++
>>   arch/x86/kernel/sev.c           | 112 ++++----------------------------
>>   arch/x86/mm/unaccepted_memory.c |   4 ++
>>   8 files changed, 204 insertions(+), 99 deletions(-)
>>   create mode 100644 arch/x86/boot/compressed/sev.h
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index d88f61940aa7..0704d4795919 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1549,6 +1549,7 @@ config AMD_MEM_ENCRYPT
>>   	select INSTRUCTION_DECODER
>>   	select ARCH_HAS_CC_PLATFORM
>>   	select X86_MEM_ENCRYPT
>> +	select UNACCEPTED_MEMORY
>>   	help
>>   	  Say yes to enable support for the encryption of system memory.
>>   	  This requires an AMD processor that supports Secure Memory
> 
> I think it misses "depends on EFI_STUB".

Ah, good catch, thanks. I'll update the series to add that.

Thanks,
Tom

> 
> The code I've submitted contains "select EFI_STUB", but it causes build
> issues for some configurations. I've changed it to "depends on" in git.
> 
