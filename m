Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BC5B95BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIOHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIOHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:52:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01358DF5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4bF4otgrYV39LFZsJr2rMi2VzaJ46QLDThELV6ZGvrTCj1/EARM0TrbljrUvqyZ8K+vsEHt0AXwUGUOJJAvl6TrgAUu7ELFDpos1wWhV41Nc4ZlxC9F5vsjCOcOR8NDR/G4Tcl8c6yi8Pmq14J7SVsddlBIUSFgaSHZxevUeakEzfcg/S/oAle7qQCqqy7I0IoDweZrLEIb6j1KFXiXiujdTlLOOGSOS239c0/1nw8WdGhdVe9DR5997qf4upK7tNTvFP5S7x8c4Xho8NhntfhRytwm5F6/NNBhSyffDU27459rvTZPygTqngoPCIHbMiwqVZT+oYYZWNS+EbCabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMfChmdPMqGBOKAOrJJcBXqpDj7pZFLThrXFzmFm0I=;
 b=T32txRXuohN4mXC1lkVPG/0Bc5ASWV0beZLjvdWXi4buKV9fOYNxev9QJ/myVmnWiMAo2MnFFCZcOAXbwv78m/S8O/33w3+yfZMGKbP1Ge2Z6Z43MYyHl1v9Wq3g6oTb3R7Aq5yVSoOIFjjgfhRmR/Qyx419WGvePaItE0gwZuiVaAevBJBIRnroox9BM1V3T6pETyM9k4Xic1IQs17u+MT0fMHumymby2hEsXDSE0YHJ/7i8VwIPG2sL1iPN5Aw7s9E7AuN/gyJy04AxScLhfz8ww0ZH3FKth5MX29ADATDmecmAtwaKfuLT1x+a9/vCw67uABpCVMfq92p0cREAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMfChmdPMqGBOKAOrJJcBXqpDj7pZFLThrXFzmFm0I=;
 b=wcWdxb6EqAzwiPxAxCKML6njZd9y5bGTZzqv/ZjyOI5U5LEQhs4LypaewlzXSxGjNj19KEheYXw3Ee6UAyK4OxQOc3jq7GL6g5Llua6rfPhOHbUTniNPhBWQr09A2HygRK/Y7HuzfIKk71QdIJcztYKysg9xaV2ANcrNYu///ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 15 Sep
 2022 07:52:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 07:52:02 +0000
Message-ID: <e74b4fe3-1233-3fea-4a2b-1d5e344d9a40@amd.com>
Date:   Thu, 15 Sep 2022 02:51:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
Content-Language: en-US
To:     Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>
Cc:     Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>
References: <20220812183501.3555820-1-acdunlap@google.com>
 <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <CAA03e5FLwODdqCpk4BGdxZBrOxQR7rfmrmQg6v5ckzEKuYUx2w@mail.gmail.com>
 <CAA03e5EFk7VjkaT8+xXMaDQcEDTJRzLEuQxxNX=OOyAQG5eCng@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAA03e5EFk7VjkaT8+xXMaDQcEDTJRzLEuQxxNX=OOyAQG5eCng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0279.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc2ac2f-4377-42fc-4e43-08da96ef2cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7qmrre7BbNzr1uEbeWxHYKaqCAD3gRRhl1L9tgDNNZFzgsWcb6ZV9+WD3k9pC77tyEoBHQcVP+RAr+CvoJz/viBhE+GBSyyxnxBQISDvJZiW/H5eBhC3yK5h8Z/u5UzjoJs4bImVH19FOoeTG/U1mrVeELfDI30C/DupsWFu0NQ9Drdrypmf7ns7oyydLUjjtjQF42NK9eC7oqlS8RkGLTcP2Y+5orKj/zqf/jmspMqc854l2Z1XOtL1k/MgUtVdDGJRtKvOlBOCdtyT8DNSh/SkiHaV7ZXeE7BbqiW6xJ/mGH8HBEBENp0uVgmQu0szyDF9iQMSL9F7nxhhbwqkpS7r/YjQhzcKNR6+s9rZlgC/5upzNtiV4uPU87WhyZ3dWAFpqvZ6s+qej27Z5059oAxnidzM6JyijJpTxRdZrt4B9DBagcmRGo4aofZW035becYxfAkq5zyJ0xpdJoqrRdh7CGTfSw8Uxfy2zBWKsVEbiIWv/nCj69ovatjB94rpBsCDDKdezzMc5UfOtNwoHKA7GxJrXO7/vVOi/MiEsWPET8q3OcnB4hKqfsXwPzcwCpbJfF9bjNHS2q/AEYhz4TH+5eLAB1FV8SOyZuE1+1IuZ7Y0NbmD7OU4K8GcsdSeZX+KyAv4Y3gEAWdXd1FIXfDjpwQx/t9xGRY4b2AT9c0L0yH+yJHNBaaY4ciI97yliiNYbaI6RTPnRCgU6i8KCaRf9wVKNn5FC7D+0YC41sREGFTw6TxEU++st4C4PqXLUgSkpsoruYP2wZWqqbXoelFjUFQT5tVwv1vtncYBdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(66556008)(316002)(31686004)(54906003)(8936002)(110136005)(41300700001)(6512007)(26005)(2906002)(6666004)(2616005)(66476007)(53546011)(38100700002)(6506007)(31696002)(6486002)(7416002)(5660300002)(86362001)(186003)(4326008)(36756003)(478600001)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVR1NEtYd1NxS2xhRjNVWlUzbURSU09EMGttNG9PQkxqTHU5anNXM0tvRk5E?=
 =?utf-8?B?bHI4RENROTZ3dWxOOWZtL01PRkJFSHdGa3pWQW9yR1kxeHNvSUZrT01IQXFG?=
 =?utf-8?B?OGlGeWs4b3lGWTZtT2g2UnZNWGlKM3V4Qm9CWWlsYUhUakZoZlhoV0gvRGs2?=
 =?utf-8?B?bmVRUG1SK0xaNXdXM1JxRnJqTitJT3NoWFJUOTFyWU1GOVh4bjlDSklIVmlE?=
 =?utf-8?B?UDF2a1hGMDgycmNJcGJkSVRoaDRndmtxdlVpQmk1S1g2eHR0N2pJZjFUbEs3?=
 =?utf-8?B?Ry9DZ1BSNzM3dXBTang3c3V0ZGU4Wkw3Y0RBeFFCZHZFUElnQ1VEcXh3TGxO?=
 =?utf-8?B?ckVORzJuVGFpbmFDQWNFMDB6V2xwaTVBNnUzaGlzaXA1Zmd3Z0pBNGIzcXhx?=
 =?utf-8?B?a2RnR3BzL0xCaHkyYlUwZGk5OUlKUitDUll6d2lHeld4ZXV2bGQwTHA0MFlE?=
 =?utf-8?B?SmNYZ0thVkdwOVF6OFZWRGpiRGlaYWZOOE1pNWd4ZUVNbm1OSlh3cFQ3WGJi?=
 =?utf-8?B?b1piOUJlaHRKa21IWDFNd1poY1JLWHlwZTFxdkN2Y0RUVmkxSXlDUCt4UXQ0?=
 =?utf-8?B?c1g5VEdlbUtyb3ozUnpVUUllT0J4UHJJWDVzeHUzdU5kamg1Yis3cGsrOHhQ?=
 =?utf-8?B?Q1ZNb3BZZ2Y2YU1YSkViZS91VmlhNktHdXhzMURTd090SW0zbWZDYldWcGo4?=
 =?utf-8?B?dWVsb05qaGE5Qm9Uc3pRT0ZvMXBLMWZBUGxqdk9abktFNktMcXp6QllPb05o?=
 =?utf-8?B?NWJ0bWNqM21XMkNyR2YvTnVRdTd4NUlOQzRiTGY4N2Rqc3V5dXZKSDh5NkVj?=
 =?utf-8?B?M0c3amhiL29RUzVhaHVWSXFRVEZjVGJrL2V6L1RyK0FyYzRBWk1CaUVuVjVR?=
 =?utf-8?B?QXl5QndIRDdVNkd4SVJSWFdOMzE4RVVYNVlDU1JLSXZWSWFVN21nUDhoMldR?=
 =?utf-8?B?WnFYTEZoRU9wTzhPK0h3RVZaVWxWZ3lPNUxxUEJncDEwa2laS2IzOEpCeENs?=
 =?utf-8?B?dkU2aGZOSmMvWVJ2R0I2cnNGNEpuei9RUEJ5MytVMnNnSVcyemU3eSttVkwr?=
 =?utf-8?B?eUcxbTJwSXBDS3YwWjMrZGZ5SEtNZkhCZWovSkMwY0tLY3B3V2JRdURPeXpn?=
 =?utf-8?B?MEJLQnc3YUwvRG1aS0F1NWpXOTFRcElJSkVwMVgzUzJHWGxIVHQvWWZIcVBx?=
 =?utf-8?B?TXRRWHlWNW4zQ3VZNUg3c1AvQzg5ODZvUG1VS0J4T3FTZDYyUEVsSVl2RjB0?=
 =?utf-8?B?QmdsdUsxZHhxTm45ZGpwOW9xcUNQWmhnakhQSk9iMFpsbmN3aG1ZSlNyUDlX?=
 =?utf-8?B?SXFFdXBmNy9xSjRJLzFUcXM4RnkrdEJqYkJxcnkva0pGek5FR2VNK2pnZlRn?=
 =?utf-8?B?VzRTN2R6UHRQRUNPeE5jS3dzTExsTkVneUg1K0VWWHh5ZlA0ZTZZRzc0OW9G?=
 =?utf-8?B?cVNFa3pWYStpQjlXNEpvMzhoL3FicTF5UWFKdnpJTGdpOW5lVlNhL293T3I5?=
 =?utf-8?B?NTEwbUxFT2pqVkFRR0s2TGJ0b1N6Q3lWNTIvWFlFRFBvRHpycTZ0c09hbStM?=
 =?utf-8?B?RE5JMlBrWVFsUG9VWi9nRVpaRXVqcG1mZTRTMXVsQkE1Mm9XK2lGbzFHUTBD?=
 =?utf-8?B?MTdFMWZvSXk4YTFhV3FOcHJacHlsR2hHTTZGNlRSYXpqZFVVekxhODBEaXJU?=
 =?utf-8?B?SktUdzMyL1F0UmxoZ2RONE15Y0Uyc3krc3lIM1loR1Vyd0huR25mV2l0R09L?=
 =?utf-8?B?QlFmYVZEcUo4T2lIMjhnY3JYN0ZWcmtYbndwTjlieXh2b1h5WmVWTk42RmNP?=
 =?utf-8?B?S0thd3B2eTd3QzRhOThhUTZ1T20yd0Y5c1VnK3BoLytQdCtqWVB4WVAvUWRR?=
 =?utf-8?B?WWRpQ1BvOWg1OXhvaEdkajFtUmF6VFJOZnliUUJzSCtXVEQrV2JYaTJmZVo4?=
 =?utf-8?B?cHBsSU5yRk9Gb08rb1BXWHZmNmtRUG1Kc0lJSndaM3lsMUQ1bEF1eXFJN1RZ?=
 =?utf-8?B?aGVZSEE3MkdxUVRPT21WSU0zUG54V0ZVR0NjdlVZMkswN0wzb2NzVkhKK2Fp?=
 =?utf-8?B?VDNrYkVQQnBFUU1Ea2RXb0RnSkk1S1U3YWNYTzkxaUhvZk1VM2pKMjRMVk1q?=
 =?utf-8?Q?IdvPPPUUqU78lGtMhKrp8juqy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc2ac2f-4377-42fc-4e43-08da96ef2cae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:52:01.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEcoQRIcxfF8W9vOh2Qto1uojjG7F7LOH7EYnR/BFP30wI2nhGVbo2DvkczCNnPjDTl4zOqEewUu4HASDav+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 06:59, Marc Orr wrote:
> On Wed, Sep 14, 2022 at 12:59 PM Marc Orr <marcorr@google.com> wrote:
>>
>> On Wed, Sep 14, 2022 at 12:13 PM Peter Gonda <pgonda@google.com> wrote:
>>>
>>> On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
>>>>
>>>> Previously, when compiled with clang, native_apic_mem_read gets inlined
>>>> into __xapic_wait_icr_idle and optimized to a testl instruction. When
>>>> run in a VM with SEV-ES enabled, it attempts to emulate this
>>>> instruction, but the emulator does not support it. Instead, use inline
>>>> assembly to force native_apic_mem_read to use the mov instruction which
>>>> is supported by the emulator.
>>>
>>> This seems to be an issue with the SEV-ES in guest #VC handler's
>>> "emulator" right?
>>>
>>> If that's the case I think this should be fixed in the #VC handler
>>> instead of fixing the code that is failing to be emulated. What if
>>> there are other places where a testl is used and our tests have not
>>> caught them.
>>
>> That was my initial reaction too. But we spoke w/ Tom offline (before
>> sending this) and my understanding was that we really should be using
>> MOV for MMIO. I've cc'd Tom so he can speak to this directly though.

I did finally find the section in our PPR that references using the MOV 
instruction, but it was for MMIO configuration space, not general MMIO 
operations.

So, yes, the #VC handler could be extended to handle a TEST instruction to 
fix this. My worry would be if the compiler decided to use a different 
instruction in the future. I see that the native_apic_mem_write() is using 
assembler to perform its operation, it just seemed right that the 
native_apic_mem_read() could do the same.

Thanks,
Tom

> 
> Actually cc'ing Tom :-).
