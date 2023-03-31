Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D356D22BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjCaOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjCaOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:34:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6073620C37
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkrTN30HHOtWr0EZsVnrUtZMCLpmxiEPWegO02M/rHY4ArpJ33wvJottEsbcjG6fiKoK/fcagym0s4M6G77GRuL1XmEHz1Eo27pbaIjN3+ed2P/Ys6/Z54A29qqMw25u8fH8yQ0ytjNf9winpPYOYgzRMdpss+QX3k+YNCvgshwF2fWJb1VxV5T3KOnN4EJYM4jrBAB1GNwxyEQqnvsgVk7o1THPFf2vSAZM8dFdkXxpLtNmauynZAMn7tm1vP46BNq1IpyOPQy7LUo0SRCdMRAMP6Kuqso0ORQSj6otrBNQePCijlc3OidcKBbpUPSwv95l8oWdIwvi0nTUAnPdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64LTBVFMZQGXKFkvXbJXdKusqVMA5H1bj9DXYpvFX+c=;
 b=XrRNRkeRI6w5qzdXCHmWDuHJyrdPXKlYCRrfU55DefSeTuVBvZF80vZXJpammOCjAJdaduD+ukIlHtPBnFRtY3i96mscI8BS038rDx4qI6/G+VWNgBx/7grR6AH19+pdDeDjZhdDmls50BtTwp1p3gbzbrsGgZQ9XdiI6k5noPF6YEhyRsdiyvxhXt4cjZSvsGRmGPEWDJH/J50YQPS6Ma8He+0O/njMJbny9LGGIgndVfA5TVJ/h7Ucw9S6tQ1iiNgiV7ne2hqdcG9VwflIxfTbHVF9zyUqjtnbjMYct+dUhXTR1FWXdgevNepRoCRbOUcg6hBt17NI9BgK9np1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64LTBVFMZQGXKFkvXbJXdKusqVMA5H1bj9DXYpvFX+c=;
 b=Tjb58DP20lK+7TtZrmJAF2c2eWp/ZwjOaI6oJxq/UCTX445h4ExHtBt1QzwAg3w8X0VLqWtiti3zosti8KenrBV5Rohfv1K6kOZqW3e3hdFqGoNRmjG+4cgkHvkQ72k8ndAdjRWX76eP1UzHHpjOog3TryOIbxFXUHHpHCQS+nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 14:33:33 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 14:33:33 +0000
Message-ID: <e9c3019f-936f-8bcc-d20f-16220993ff1c@amd.com>
Date:   Fri, 31 Mar 2023 09:33:31 -0500
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230331140916.ofb7ecrjpg7shaav@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb051f7-31ac-47b4-1884-08db31f4e7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buzeLBCg2hye3KdDCBbtiwEf/5bcXbN6w6+t7jWAgyPT/ufVUnDmihKPqM0KAOvDq6Foth+1SdaQqJmk0VQpo3oxEs7TcsfdTH+HTDR64MCVxE/gojqPX1cfGzbzB2dz9h5b2BlDfNfKAxe9aZDKC79wTssQsO3mDiouFAQ1TOiHqXsc79ZgvZxDayAfy9G6WKmpN53jFbIHWkbXnBOCUTyYGePWyWH4w56lhYY4vfvvDOR4seDV4sYceg0A6JfVZRERv3w4eJ621fMy0R9BlWs4ZwbUJ17+MTw4i1KqvxTgcJh+g8far7uhpi79iOWc338l05yzzBKyUsA9Ny7ilhEBEEJ0OeFEENcRl0jTscppiUedFJRv/AiLZiPrWXeZw1ZflQu+qxkFHWHFDgEMxCO6pi8lXEBvkBYI2DSkJr4egv9tOxu76wwe0lPR/n4Te+Y5FAG8bUvzYqDfZq6lP9TXGSKBVuoDZndqcFdI86cimuQFeoRiY6/w2l4IcMz+oDG+aEIpajENq2mkqmrDC53FJvZ+LfFnWEZb1FEi4Fjqj+xhRv25ku9O6y93xI5gD5jJtajHTkFBz4S4BpN/3FjoEBw3yKDBALyhxZWd/kaGMSS+6tOSbaYdGwvF7FaxDsfiHMD/S6JpJ9duPMl+dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(38100700002)(6486002)(83380400001)(6512007)(6506007)(186003)(2616005)(53546011)(26005)(2906002)(7416002)(5660300002)(8936002)(36756003)(478600001)(54906003)(66556008)(6916009)(8676002)(66946007)(66476007)(41300700001)(4326008)(316002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFcrMFhCeXhCaTNPZVpLbTFmbWpKWFl6cGNDZEE5WU5FMTZ4YVEraFB5TU1Q?=
 =?utf-8?B?aVRjREtnNFp1dGIyaHg4U25wQzRDczRkYmNzR3BmWXBNd1lSaGR5UFNTdGw0?=
 =?utf-8?B?RXBkUkRZWEtHZXQwYkV6bEdTZGtxK3crUUNnSGh1d2F2Y2huQkpOb1M2ZDND?=
 =?utf-8?B?OHBpZG9sZHQ4NnRQREpWNkFmU3NhWk43WGRqeE01R21FM1BmaWpESmRWemY4?=
 =?utf-8?B?bjg4RVNXQ2ozN0plL1A0N3l4UGl1TFp3L253aTJUdjViSEhEQjFTeTNLK2dQ?=
 =?utf-8?B?Ym5hMHlxVlE1ckNwREFkOFRpb1VXMDFGNXVHNWFFZFEwRkJBNFg5dXVMcXNm?=
 =?utf-8?B?bnFiTVhNSlVrWHR1cmdIMDA4bEtWcVpBWXNHL01kUzNibzJJN1R3VmRQVzZT?=
 =?utf-8?B?b21rYkx6cW95Zm1HZkdNRGhEckZhei8wZHIyODhqYnZrbjBhK1dIVGxNMUky?=
 =?utf-8?B?K1hSSzlscFZkL0g3M0w1a25BbERqTnJ3bVkzU3BxUWgrbEc0eGdmRE9VOUo1?=
 =?utf-8?B?ZXlrRHZ0K0FHSEVDa0VPMlpTYWswWGJJQXBTb0NtSVFUanVTdGVYQ2xKaGRn?=
 =?utf-8?B?RWlQR0RLMjBnayt6STRQVUxuV0NHSWp4V1JMazlIZmcrWHdXaTQ3MkxEL0hF?=
 =?utf-8?B?cVVTblczTmlZb0ZEZzUxUUVoN3BZNEFiTWtWSXZ3K3VZYXY3OUNEY2JEMENh?=
 =?utf-8?B?SjBLUXZWMi9xdnRqK3NwK0dXVWNBcDJrUVVQWlNWdjBiNFlLNWhFalhoeXVG?=
 =?utf-8?B?WWQ1c1lLMU5Yc05XRFZzcEtlZllDU1dScGZzUDFRUUxuU0hnM0Uvb3h1clVl?=
 =?utf-8?B?VnJIZlg0aGxmdXZMWk00Myszay9rS1c5aU5RZnd1L3BvYWxkak00WnUyZm9F?=
 =?utf-8?B?cE55T01RcmIwVzVYa2pxWUFJcVNRSnZCWG1ib05SYU01MkxKRENpRjFrWWVj?=
 =?utf-8?B?RUowcWMydTcxMkFVdzBRam9FR0RxYmVFN2hoQUJLNjlYRTRmOGpkZTYxWUk4?=
 =?utf-8?B?TmRLTldmYzcxYStPNEJlZjRBMUlreHltbCtoaStCNEh1aUhyM2VyUGs3MVVr?=
 =?utf-8?B?NkZhdEcxdFNoeXJzVDJ2QytZSm9Ea0xLOTRITjRrcGtFNkVJNDlKdWpmYzM5?=
 =?utf-8?B?VGxsU05tWWFKOCs4Q3c0Vm11QUIwbklJZVhkOU1DRDF1MEtNWVhXT3k4NXhs?=
 =?utf-8?B?MEN0R0pKbmI1SUpzWVRJSmNIb29nRVVsMy9uNGdxVmRYc0tiSks3Z0k0bGov?=
 =?utf-8?B?ZlY5c2tyODdzcllRS3RkK0NqODdWQmRWbXVqdWxxMVNjb1M3STB3Si9DaXZt?=
 =?utf-8?B?Y3VlQWorZ2JQMDV6eVZxYm5hQVpzN3NuVU44azVBVVVmT0lzSlZPZElFZDFE?=
 =?utf-8?B?bHAyQ3FvTTFrSXVvSHgrcEtRYURCUmZ2dnBjekVRNDZjWWNpWUZoeHdzNXp6?=
 =?utf-8?B?dFJtbURLUTV0NkE3aklESzlkOHBwd0pGSUtvTVVpOWgzdjNuSjA5UHNuOWpy?=
 =?utf-8?B?dWYwYVRUUU9ia0hrU1BUZzVrZHBKZklyS21QVFNaUTA2alM5N2M0UElXcng0?=
 =?utf-8?B?Y3pEMlRFd0cwaFpiV1IyZEk5RmxsSUNxNXVYKzNxTXh6MDhEZm5Ua1dmS2xh?=
 =?utf-8?B?ZW5NMURtczlwNDErMWpnWWpvTm0rZmpOSUV0WXA1NS9kMmhBZk5jeFpidU1n?=
 =?utf-8?B?NHd6Kys1SkZjMmdZbFVGWDR2MUFNK1ZlbGlxNHFEOFMzVWxuZEYyQVVBOEU0?=
 =?utf-8?B?RWZQVGlWenk5MXNYM3dNSVM3QWFrOGdiOXBrbEZWbnFYVE44VUtJbXI5UGc4?=
 =?utf-8?B?TnRrd1NVTmYwZXJ4ZEJkcmwzVjRJVEVZNElKOTJ6UWU3V3BPcUhLQktTd29a?=
 =?utf-8?B?dnRLcEp1b3kxOTdEaDhqS0Q1U09XRSs2WVAwZHZ3ZGxXTXRISmVQNlNneVdx?=
 =?utf-8?B?SS9aZFpvRUlncWlyR01MaFlBNjZ1MlM0MnJ5WThtQjNpUDU2ZDRybnprY1Fk?=
 =?utf-8?B?d1NTWE0rL2JkQmtGdFdwazZuazR4Q1o2VUVLMWh6bDhnR1VBSy94SzJqVU1T?=
 =?utf-8?B?c2xibDAxbHRZZzc1VEhFOFFtUWE3NDJOMXlZSE00U2ZJZ2VFblg0NXltQWdC?=
 =?utf-8?Q?Tb+A1k/aITtn8rR1jsfN6pkbW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb051f7-31ac-47b4-1884-08db31f4e7ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 14:33:33.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efiw7OY8rbEMP4iCcbmf1vVXuL1FjyUA04XPFGv4AESHiyjxYqgLaFeH+zB8sNhFF7GOUjlfqZqJo4VGvjEF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/23 09:09, Kirill A. Shutemov wrote:
> On Fri, Mar 31, 2023 at 08:40:30AM -0500, Tom Lendacky wrote:
>> On 3/31/23 05:06, Kirill A. Shutemov wrote:
>>> On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
>>>> From: Wu Zongyong
>>>>> Sent: 31 March 2023 03:24
>>>>>
>>>>> On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
>>>>>> On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
>>>>>>> It seems MOVSXD which opcode is 0x63 is not handled, support
>>>>>>> to decode it in insn_decode_mmio().
>>>>>>
>>>>>> Do you have a particular user in mind?
>>>>> To be honest, I don't find a specific user which uses the MOVSXD.
>>>>>
>>>>> But both Intel and AMD's instructions reference contains MOVSXD and lots
>>>>> of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
>>>>> may be useful to support it in insn_decode_mmio().
>>>>>
>>>>> Are there some special consideration about this instruction?
>>>>
>>>> It is a sign-extending memory read (32bit to 64bit).
>>>> You pretty much never want to do that to a device register.
>>>> Also kernel code should be using readl() (etc) which do
>>>> unsigned reads.
>>>> So they should never happen for mmio.
>>>>
>>>> Of course, if you mmap() PCIe space directly into a program's
>>>> address space anything might happen ...
>>>
>>> There are two users of the interface: TDX and SEV. TDX doesn't allow
>>> userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.
>>>
>>> Tom?
>>
>> The insn_decode_mmio() function is only called by the SEV/TDX related code
>> and is specifically MMIO oriented. As David said, this instruction is likely
>> not being used for that in the kernel. If we come across a case where this
>> is used, we can look at how it is being used in that situation and it can be
>> addressed then.
> 
> I was asking if SEV supports userspace MMIO. And if yes, how do you make
> it safe?
> 

No, SEV doesn't support userspace MMIO.

Thanks,
Tom
