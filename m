Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58C6D218C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjCaNkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCaNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:40:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED673469A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn/Zn6RZuhsWfC2JugGYtgPdFKVCHAPvkVQAIHdwtMOs1G45T+ANo0b+2/jGqLvBfuy7GuiyrgZ3pIj3Ygkn/BCNfm8FZ7HIN3bUc49ELsAdoJ+33vbKBZtUer6TptMxI5eJFp62K/cobAT83FojilBr4C4Q2Sdrw7MnuB3yWH2WfnoPSRtmdDC3hCZjmCKdqMp9J2MXEPRELoRBCqgyynbn8FmV5tduLZDZCU7C7agNv5hh777xappw6FvvL2Kc9ojBxdcz6PYCBolpnJGH32vTevInniX6Dion4Zgq+5eX4XfnBngiIGw1NouCnlJJE1G7anYyVbcbZgHTzv0eRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6ISDnC7fN5ffPk1t05ns1e2UB5dZeHN2Du+mWdKA2Q=;
 b=PzM6Jmy/NdJ7VdfegLkGbJFCS0neSu6soWL54mKIU7nfBjdhtruFsqjXaHpbuC8EMnI6BSXE0KG/NgUrDnflxgEFrEe6SqgvFIwTNCIyPZghrQSgOK9p1H7ApwktMOPP0n4F7lzZAHPoEtePySFaluSI3hk+YbBc8D303D2mRfFohjZIoqTMJ6Pdl3NLly9Nrn997n9Rt8AqcNufg0D9IQpm1Y0B4osydkgLISLyOpjj3c6rvMVudCHX8kukmrWifp+xzNDgmXSTjhX+v+duzITkxYUzKAGr2gdEHrHffFABkEiTUJbQoHzFTGq5jaae42kB+EtaW9NjfyrCfJ8hDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6ISDnC7fN5ffPk1t05ns1e2UB5dZeHN2Du+mWdKA2Q=;
 b=wdH28qttyUMmQWiJZiWIYDGvU+moEaPihn9lMDMGeG/Oivx/5LG7W8AuY01InO6SFxoEY3w2JGkvH7Q+/uTlpLmJcxCfo7eU1LyuWxoPm5i0u7JshKC37u4h5GVjmaBZzPJBT1IjkTmn/ZLD7QBwByvTibQStQQAv5PRi220Zws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 13:40:32 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 13:40:32 +0000
Message-ID: <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
Date:   Fri, 31 Mar 2023 08:40:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:5:335::8) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb0e3ac-e6de-48c3-2f22-08db31ed7fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byZBpWme++5k3Zf7v7/BFG1nZD+k5BvF3EB1OEzlZc2AfQEO9Tc0Tfg9MuqsHX/YtX/QCbkBTAPm5MUSpD98SDMLwYFLCN1AYZ7zSj0PLd6ybmkfGkMFGbliiHYBYNukb0/XsOoBp1bsuRkYY3ubdLcMGeQ5Syg3Gsb7xcVeacNSnhB2/Fi4LL8XTg9R9lSE/Yhtl9gmk3qoLPTfwGe2r4+RTyU1B3iw+CBSLA6/p69dm9B36qZwpR1tC40YmbkuoO1YliuW7cn26i5lc+ApwjmEuskbgsaJ+oJh3hfGxFq4lcgCMCKgeJrNNshgjew73/LdaRWkV24irS1AIQykdvdZM/nnNsI0xXzlTklQ24GFqhldHW3uE/w3gIXr+dkd30vwUwsAA7P1Fjypxsjun+sSALv23saHKAFyCJd8cq/p8j03/YCV4/A0JesY5Amy8jmilULEb2eZ0aI5nwo0BHC7MFybFEM4XQDl+6OqJslnhN/mDD4V31kAAIuoulNIACNLobs/ISQHdsM4uFeJnVNQQIje7YlB10SomQxSsOCyhCFlSmmi+gWS2tNSx56og4k/VscbRkMSeW6CAl6ir/2RR98iHJQDfWmQs8zik5HWkq8ML+yvE9RW87i+sV6MVbuDa+vL2PUwo03wkwrO/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(110136005)(26005)(53546011)(6506007)(6486002)(478600001)(186003)(5660300002)(2616005)(8936002)(2906002)(7416002)(36756003)(54906003)(316002)(66556008)(66476007)(6512007)(41300700001)(86362001)(4326008)(66946007)(38100700002)(31696002)(8676002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlMMjVqT20wWm52L0lacjNuMHowWFJMRlRNYjBPd0cxSEtCZWQvc1NGNW1j?=
 =?utf-8?B?M28wT3hCSWxUWDhLcVpRRzhYMGZ5UzhOa2xhNUhRejNxbEtFejFUNG55OWlV?=
 =?utf-8?B?dzJIaGRSSlRkZGFYbFpPWU9lTlA5UTFSOWRZc3RabGQzN3MzMmgzT3h2cjRH?=
 =?utf-8?B?Y1ovekdBdWJIRGQzSzZFeFBYclNKazBNSVlhd2o2ektFSU5XZ1dwL21NQ1Z4?=
 =?utf-8?B?TEhBRVdtQU5MUUF1eUdmU1RlSHU1NS9xUGZZSmJpaXlzWkc3bVVCUlc2RUNt?=
 =?utf-8?B?ckN0MHd0ellQbUUvam9CMWorNm9FdEJJdmJWRFNzME1ETWFXWWM3YkZIckUr?=
 =?utf-8?B?eDdza0Mra0xKNSt1d3VCSEo0WjFtd2c0UzFSTUExazdxeWtDcE1aTW93NldV?=
 =?utf-8?B?RitqWjJEa2lEU0N4RkZKeEhTNENCa2p2dlNTRFoyS1lTWjRweFcwQ1JNTWRG?=
 =?utf-8?B?QXhNM3BjTFNSbkhpRThTKzJTakE2MXBoNkc1eFAyQTZUSEdSbW0vUmIzaHgx?=
 =?utf-8?B?bHA4OHJ4RHFMNERUL2phTDkyanBGbzJwUmJVcnJabzEwV1F4VDU0VmIvRGE2?=
 =?utf-8?B?czY1ejF6RHNaVmxKZStYWkRvRHpqSVp6akZMTnRqUHFqOTdmOFEwOEc4bnZm?=
 =?utf-8?B?OWJqTHBQSGhoL2w3NVI4TWRENFVPNDhQaDRJMjJJYzA2M1VYY0FJTWJCVmF5?=
 =?utf-8?B?czZoTks5dk9tVmRtZVhsVGRMYlk2UU9VUnFHWUJWNEVhem9CbWVZYVFEWEpT?=
 =?utf-8?B?MjFWbUNGZkFBa0k5SEg5UzdPZ3pKTzN0a0pQS3RMQWV6djhaODNVTjFMb3dS?=
 =?utf-8?B?YlFnU0FxYWpQb0Z1b054cHMyTzJnb3BHMkh6VW5aRStGM2FuM3J5d3h4QVB0?=
 =?utf-8?B?U1BTS2hpZ1NFN1BYNm9wY0Vjc05tTHRiTTlCa1NPQTJEb2JqVXkwbENFQ3hB?=
 =?utf-8?B?MVVZZ0QyZWp3bG5wMVdGYzZSL3FUZnVYY0NiSzVTek1sYmc4UURoYkpNNHFH?=
 =?utf-8?B?N05rcGVyTmtjWXFyOUZtaVNENS9PZVJEVlpJREI5YTZ1M2NoNCtBN2ZUOW9L?=
 =?utf-8?B?OThGTnY1NEVyWHRlSklZcmQya0l0MFVUaGhSc2ozSEdsNThkbERQc1kwKzN1?=
 =?utf-8?B?aUJ1L3ZQaGcvOTF4aXoxdGlZM0RicVppTXAyMW5STGxkQnZTT0xrMnlybkpE?=
 =?utf-8?B?ZnFiODdrWVhBdXhWTDVVYW9pdS9YSVBwZnhRRTBRWkp4MSt2bytxQlN6emo1?=
 =?utf-8?B?c3RoU0x5Q3A3MzVKMmh4NDJOOU95MXUwalZXRVlWUk9rVXJwblRGVFZVaXpK?=
 =?utf-8?B?dUFZZjFSU0RRNmNIdXZ2RDJYRG40eHkwV05nRzZyT3NhVzlKN05jTWc2WU9R?=
 =?utf-8?B?VHFvWi9wbG9lYlZNZXNpZ21EZVNMMVRQVUJMUWVpTzM3OXRGU3JXeTgwRnI3?=
 =?utf-8?B?M1VITU1nU1FYK25RcjdlREpTSTliRUlDekNodGZLSGtNZ0dhMVl6ZUNJK0xJ?=
 =?utf-8?B?RzhkMUdjMGxHL0tzQ1krRzZBN2J3dEpQT1lRV0hZZ05hb0liWUVxMDN1L29N?=
 =?utf-8?B?cGtjWHJBZTlpeXh0dU1QMk0zK3VWUFMwRUR1SE11QTFVdEJPL2x1cXBNR2JU?=
 =?utf-8?B?RkNjSDZybUEyYnNHUktQQlFId0E5eTN3SjJuR2grYjR3ZitmOXgwa2lwL1BC?=
 =?utf-8?B?TnlBTFJ0M3hRUkE0UmJIK1dxajUxbXU1TWJtanJLcW84cTV1VWo5MmI4MDhh?=
 =?utf-8?B?VkFYQ3JCNEZFa3BPS2hqVTdkc241N0JhRU51SEFUeFZnNjZ1akJ5NVRGcVR5?=
 =?utf-8?B?TkMyTm1aYWY1bm1SQi9TUFdIT0VOYlF5OUNsQ2dGb0tieEFFNk5FQktOZ0hX?=
 =?utf-8?B?SlJGTDdMQ3B2alBkZTd4S2dRdzNOOERCQjZSYmtxdjUxM2YwbDQvSmVWdjZL?=
 =?utf-8?B?WVg2T1hvR1Yyb1ZtL1htS2w5b1BOZW1ZVExVTlhPaUZMY2RjbEtLa09NaThZ?=
 =?utf-8?B?VUhtQkVmd3VwR0RteHRGUzloSGZEVVhxakFGQ0I2QzB1RmNTWTFYUmxBT2Ex?=
 =?utf-8?B?TmpWdzRiQnJJMExlSExRcjlHamFvS3IrWEMzV09nek1PT0JwSTVHQWtNKzlU?=
 =?utf-8?Q?AayJrAwsP5h2H4r0ETEl47zM5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb0e3ac-e6de-48c3-2f22-08db31ed7fe1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 13:40:32.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFy9SK3HGnwAKEpW+EqKeYzlI8Gs0q0WAxxDYQO9J/FmqvJ5MkgIXlEqE6SHJCo8B20r4KyNSjg98fjAvsL1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 05:06, Kirill A. Shutemov wrote:
> On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
>> From: Wu Zongyong
>>> Sent: 31 March 2023 03:24
>>>
>>> On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
>>>> On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
>>>>> It seems MOVSXD which opcode is 0x63 is not handled, support
>>>>> to decode it in insn_decode_mmio().
>>>>
>>>> Do you have a particular user in mind?
>>> To be honest, I don't find a specific user which uses the MOVSXD.
>>>
>>> But both Intel and AMD's instructions reference contains MOVSXD and lots
>>> of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
>>> may be useful to support it in insn_decode_mmio().
>>>
>>> Are there some special consideration about this instruction?
>>
>> It is a sign-extending memory read (32bit to 64bit).
>> You pretty much never want to do that to a device register.
>> Also kernel code should be using readl() (etc) which do
>> unsigned reads.
>> So they should never happen for mmio.
>>
>> Of course, if you mmap() PCIe space directly into a program's
>> address space anything might happen ...
> 
> There are two users of the interface: TDX and SEV. TDX doesn't allow
> userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.
> 
> Tom?

The insn_decode_mmio() function is only called by the SEV/TDX related code 
and is specifically MMIO oriented. As David said, this instruction is 
likely not being used for that in the kernel. If we come across a case 
where this is used, we can look at how it is being used in that situation 
and it can be addressed then.

Thanks,
Tom

> 
