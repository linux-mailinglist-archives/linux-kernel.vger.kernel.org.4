Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A46D246E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjCaPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjCaPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:53:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A31F79A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A87ffc+d1mW+5pTf1HQQ4FsQgIJpknQCUbv5yvU6vKv6PKkKjQ5LZiO4BCDILW4/rx7gIjQcYdoQsKjOwqn98MzCvoiLO816Qf0LeyT8DnAQv+eMBwh8EJzvdu91MIS/jDvhoLxUdEN1HPbGugxVRRT7PA8BU4VVeAUzDUDiWrxfLscmzQk9qmurowNIJo2Hi4H97KoxWWu8OsFuzpUz6JGThDpOUeEHhypk1/AEEtqFO9cnMhbDbhzIXs65eb9L80l7ImN660ouTAEp/ML2nmwQMgsAThOqJicqFoQyUoENQwP0IMyH12FPZQZVOrBuh8MSK6x9qKLWB6WWYCf4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+2WYNkUgW7+tB4g4ld2CQw5ivDKHrmzp8wrA4EecLc=;
 b=KulgRXNag3KtwoLW+WcTKtfbdaS3oSepajpw3oskOPfWlkyJK34gsUUPHMdbMvAXisZ0bNZyMUk4hNmFiQlEZZKF/6JPzhelhOxABXJmFZm+5nu3GnaSW4XXrfBwcDSfzMTWrnjiQXhf+W5ZtO+MVTYebBVihC1N9qTSXP/qGv79pyuOY1Il00BmKelHpOQrejrBgNtvv5DyXSCT4roE74LRsYzGrwldBokJoQS1P3DwNZjZNwjMdNNvXzrS1WUgGWKSBYekyegQHNtEULxx7U/x+AL4Z/326DQCsbNCJs4LTtSjcSjw/a9HshExc5xXjq6GCSIwsLPC4ciY8h6L7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+2WYNkUgW7+tB4g4ld2CQw5ivDKHrmzp8wrA4EecLc=;
 b=cURDBhJEQ/0lYPQtQYNkwRbGjTAEd0mCsBI4MtOtx9hvEjC9WS1h/hhgLlNTmRTx/gNmxcQCsBIxRWPo/TvwBgApKv4Kk7M75XogW41sUdRKlbJF/iMsmcrmH2biF0T2ubZsD38HIHnv5gBfKvKu54dHGLb9tGTVLFei5jhF5kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:53:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:53:00 +0000
Message-ID: <3578e2fc-a5bc-74f4-2e6b-6c2494ac3790@amd.com>
Date:   Fri, 31 Mar 2023 10:50:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wutu.xq2@linux.alibaba.com" <wutu.xq2@linux.alibaba.com>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
 <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
 <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
 <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
 <20230331140916.ofb7ecrjpg7shaav@box>
 <e9c3019f-936f-8bcc-d20f-16220993ff1c@amd.com>
 <20230331152508.s7phgif3iozbbpqn@box>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230331152508.s7phgif3iozbbpqn@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 58991965-2447-4710-edae-08db32000115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSpWt2SiKyQ0n5ifsQaRAgyVBMMmbQ6kBJn4lbLILkldTaOYc3ORXSFN1YAaZvu34G6VK2nebXfBiSMYlwZ8wFeIBCl8t8TTQWoZTAQlFnhDqDTGDrjMnY+OOop3zYEGvZITQXiyj0GfSeguHKN7R07Zx9MUBSPY7oGiKZBeONUmCFQ43mCnmafE9wbiclr5BKsJhcIE+TEqviC0m8Q44STzVHSBUxPlGSJp4AwFShKHYuyvcUrM5hDjSv8VOvLhPP7sZ4zGZjroVZ/3Fcq6eRdJgXHfAYoUIk4PRgd0wpezpN9xgU2vBD7F5udjlNWlfIg7pdpbWH6wpzGlMnaCHVtt/E4ARYTFl6aevzM8VAxac+aoGPzOL5T6H5HCG69ecvBvxrJhAvqxc3CIUjKGHSI9ZAyW+bvxo5gB/JJ9K5hlcMa0CmuyE4pJg6JWRbP1+vOmySwGEuVY30o0hM/Ltz+G9KwgZOR71gQ0+7+E0wwhBjuE3m9InJsJaxPxezK6DzJRekWk8ydfNEjbdSg5stKcQhRHCpfhNXgqjJ4Tb16387NUQOQGbDsWOsDOoTHM2syoSVVrBOd2KInWn3DCnuzIxd+mIjmt6kRtiScCWRCv7jC8pFQTtHtlTdV48cjqk2ya7RC5nxx7pMuDrF5vDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(6666004)(31686004)(6916009)(8676002)(4326008)(316002)(54906003)(6486002)(66946007)(66556008)(66476007)(36756003)(26005)(53546011)(6512007)(2616005)(38100700002)(186003)(83380400001)(5660300002)(8936002)(41300700001)(478600001)(31696002)(86362001)(2906002)(7416002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vng2b2RNTmJUU0NtczkzR1krSmd4anlDdUNHbWQ1SWRueHE1MXVpM2dtdWts?=
 =?utf-8?B?SW04eHlTaWhnTE8yWFNOa05USTZ2SDZReVBnaWU4VlVnWHJiRkZZenc0VnVV?=
 =?utf-8?B?VTRnWTNCOFFqOXhZdTFNTFVGQVVhYVRraFl2SzdQdko4QjduQzR1OXdCUFhu?=
 =?utf-8?B?Z1Yrc1lxbENTYi9aVnpZUHFIVlB4dnBqU0ZFNisyWCt3ZzJsblNXZGJHbFFx?=
 =?utf-8?B?eUFsa0xOSDFIeC91UkhpcCtDdE80cmxkSVI2QWxzbDVSVUt3d1gxdFVOOHJo?=
 =?utf-8?B?YTgrdk5Nbnc4c0tVZ3JTb0ROYlQzZFZTeGNrTUJqMjhIM0xHMDBPeW84ckJ2?=
 =?utf-8?B?b2FubGRZVzh2bVhIT2hKdDh6SSt3WHNMam5jeE1uMzUwdU9mdUc0cU5ub3B0?=
 =?utf-8?B?YkI4UUF5bFdaWW1BRDNRb0FSWXZsQzhPVCtodnZtNkFkbTVOZGZWNDNKRUI1?=
 =?utf-8?B?WkliWG14cXcrMVpZbFdCZDNqVWczVCtqR1U5NmhhVG9mMzV6U05UekZDZWhk?=
 =?utf-8?B?bWVseTlwVkJCQ1ZHSXJtQU5wUTRuRkJJSXZQaWVyR0VwcFluU1JjUmROYk1u?=
 =?utf-8?B?aVMyWXozR05lTlFuUDZJL1RSc1VVeU03eGorQzJiS29lb1NvUHl4Qk9qRFhn?=
 =?utf-8?B?UitDZGFVYnlFRHU3TUUvM1hpL3VPRmd0b0FZZjZ5Zy85R045MVVtcGhGdlds?=
 =?utf-8?B?VkxBRlRiaVFQaUNxM2FRclA1M1c2eFNLWXJzMHNuWnNGMUQrV2xyNkRNN3U4?=
 =?utf-8?B?VlY0d3FyZVdzblZOZVZKWTBLeVFtSkhtelVoOG8vMnczZDBGNldPR2prZEo2?=
 =?utf-8?B?NEJIRTg4d21nYk5kODBFRERvN1M2T3JyOFVqaVl2dzR5QTdOVitwVms3V1NN?=
 =?utf-8?B?RnVmUjNjcG42d2pFZ2NQL3RGd01aTkYxREhYcTNvVFZqd1NhU3lZbTdzMVUr?=
 =?utf-8?B?TXFjZ3lqZkNHNytRMUJCYjFZSHNkZlB2WWlzS0RSU0tJa3ppaUdZVU1xVDlC?=
 =?utf-8?B?SzZCQVlVYk1VelVyYmJickgyazQ0S0UrZ2lZOC9JaFhIVWhXUzNjY1FHOWI3?=
 =?utf-8?B?Z2FiWk5EUkpWdjMwTmtNYlErOVYvNlUrNlROSlJyQnlqSGVvbWQ2RnVPS1ZV?=
 =?utf-8?B?eVZGR3h1UkhUa3U2UXlKYjJKbk1iTlZiM3hnd3pSbnIrWE9rMkxQaFNPVUJN?=
 =?utf-8?B?MmdTTzFFM29rcGRpVW4rby8wSFErSmNTcEp0YzZYdVBOL0pxMmZNMlJDOEFi?=
 =?utf-8?B?bFNJUnUzL0JJM2YvY29zZEpHUk0wblRha0RDb1JxdU03eTRLOUROWnZTREZl?=
 =?utf-8?B?TWxBdGRiNndqM3hyNTFtbkYydTUrbk55b0NpNzVXZzFOWm83TGZpRkJxYXpC?=
 =?utf-8?B?bEtGZHpMZ2FvaDRQSjE3MFQxVXExMlFCL1hxUTc2TUpBNUIzeUdWRlZTM0Qz?=
 =?utf-8?B?RTNLektUWGwvaEZrTDQ5N0JWak9BNmhCd0g0eTBrZHlicE11Z1RQRzFSQnZH?=
 =?utf-8?B?SHdGT3k1WVpzbUprb2Y0VmF4WEUvUkoyRjloR1B2ZitWQzZrOU5ISEROT2FO?=
 =?utf-8?B?elA2cHVCSnpRQVRDUmF5ck4zVlhwOE91ZkxadE5jTlF0K2hsc0xRTzRnbXBU?=
 =?utf-8?B?WDJYYmZnMmpVd2hyWEdOWExtQzNxYjVzczRUN1JPUW9ZNDBYY2hjWDl0YmZa?=
 =?utf-8?B?UDRUR0YxUS9Va3ZEc3lyNkJNb0piTWdSbGJGNVdkY29GblV2Ui9uNzRsSUpM?=
 =?utf-8?B?K0x3azRzQUptYVVHc29RSkRiNU9yOVdaZkpjalhCVlBiY21vVHNhR3BpT0lP?=
 =?utf-8?B?Mm1aaFVHMWFFOUdKZldaa1Z0bW9kZEN1VTAvS0RXdUVEaFlmZE1pZ3pQbmZ0?=
 =?utf-8?B?OG5OSGM3SWhlOWtpM1oyV1h2UTFGdkY2WW9jalJXNUFoeXJ3dXdlL28zQlA3?=
 =?utf-8?B?ai9kR05YN0lSejROaW8ySVBFRTZGYUg3YXBXbkViOG1yMGJ5amVJbk0yUWMv?=
 =?utf-8?B?cWFvWGRyTVJ3ZXpFUXZtQUcxUHZtS1Qybk5qZGhnaWFoYnI1T2Z0NUNtRjJn?=
 =?utf-8?B?ZTZmSSttaHBFMXFvMGVYWWV5U2JJak5LMUZYVHQ1VmdrV2dhd3c1YmQremha?=
 =?utf-8?Q?8cmlI2Jnv5ZZQVoKGaBRNIm87?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58991965-2447-4710-edae-08db32000115
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:53:00.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+q5xttto00A4AdXswLiXagJt81IyapUMi02WpuuoJhytoIfQT+qyTZPWsladaZfzxczJ5tNGz5KkR6agtBVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 10:25, Kirill A. Shutemov wrote:
> On Fri, Mar 31, 2023 at 09:33:31AM -0500, Tom Lendacky wrote:
>>
>>
>> On 3/31/23 09:09, Kirill A. Shutemov wrote:
>>> On Fri, Mar 31, 2023 at 08:40:30AM -0500, Tom Lendacky wrote:
>>>> On 3/31/23 05:06, Kirill A. Shutemov wrote:
>>>>> On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
>>>>>> From: Wu Zongyong
>>>>>>> Sent: 31 March 2023 03:24
>>>>>>>
>>>>>>> On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
>>>>>>>> On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
>>>>>>>>> It seems MOVSXD which opcode is 0x63 is not handled, support
>>>>>>>>> to decode it in insn_decode_mmio().
>>>>>>>>
>>>>>>>> Do you have a particular user in mind?
>>>>>>> To be honest, I don't find a specific user which uses the MOVSXD.
>>>>>>>
>>>>>>> But both Intel and AMD's instructions reference contains MOVSXD and lots
>>>>>>> of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
>>>>>>> may be useful to support it in insn_decode_mmio().
>>>>>>>
>>>>>>> Are there some special consideration about this instruction?
>>>>>>
>>>>>> It is a sign-extending memory read (32bit to 64bit).
>>>>>> You pretty much never want to do that to a device register.
>>>>>> Also kernel code should be using readl() (etc) which do
>>>>>> unsigned reads.
>>>>>> So they should never happen for mmio.
>>>>>>
>>>>>> Of course, if you mmap() PCIe space directly into a program's
>>>>>> address space anything might happen ...
>>>>>
>>>>> There are two users of the interface: TDX and SEV. TDX doesn't allow
>>>>> userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.
>>>>>
>>>>> Tom?
>>>>
>>>> The insn_decode_mmio() function is only called by the SEV/TDX related code
>>>> and is specifically MMIO oriented. As David said, this instruction is likely
>>>> not being used for that in the kernel. If we come across a case where this
>>>> is used, we can look at how it is being used in that situation and it can be
>>>> addressed then.
>>>
>>> I was asking if SEV supports userspace MMIO. And if yes, how do you make
>>> it safe?
>>>
>>
>> No, SEV doesn't support userspace MMIO.
> 
> But where do you filter out userspace MMIO? AFAICS, it goes straight from
> from #VC to insn_decode_mmio(). Hm?

The userspace mapping would have the encryption bit set and MMIO to 
encrypted memory is detected and not allowed.

Thanks,
Tom

> 
