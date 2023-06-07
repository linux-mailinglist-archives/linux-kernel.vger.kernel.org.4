Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1757726172
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjFGNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjFGNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:39:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2221993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyX6dqcvTHY4Wybx6IEyQjEa9Qw36zcKSZKaO0YR9xrFMuvbixRQxnKMM5dkZqgfgBW+aGiSasHNDMnQZzji66ZW3cw54MDbV15UDqkN1Tn2lkPTnThiMjlEpCN26/IaxgK05fzwX+//h2ZUcHk2pOyQmHSH3itutBMVfycYe21FD0w9w7xNBV+JDAC++Ct/ZovInnPr72Mhy7YB89EP+5gRViu3Sjc105AzsK0wQRkHvhRq2Hu6I1FhKr0PKy0TiI2RZZptTQhnlN3LOWQUNNuqsgeY9crFZoDoX9ZUHMvcGzoztiyUinGWJPUwL17+Pcaqz64qxVVU3Bk6xC7PyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW6ap9klnCUPg7C3OPsL8nPIe+dbevqaPp7/cRhMfrk=;
 b=V1f4kmvpy2h2PqWS80nkHO+wRhb8qmqrG6yRMQ0hUtGTId/YJgAchfEVkrnE16MNeJFpX6UXcdyfTfEVG7NAwbXhWBnlOrsbFXgM0+Zpjt2GsGV07w+uhtzdi1qLLqnsLVo1bmaHR3JYWWwRdeekXk3/XUKN6iLiccVf1cCrDVUr406oXMRe0tNHzAWWuBpAxGlxYxAmyAapvrmKqyS/MFZHj+HdnSA+aAMVsZpk1u9Kw/iiqTnOg2x18PCslnJQ4rIfCn2HETVMC36B6iq4g216DKMNAs4NmY6BWVbMNSdOWCl+0yejhIdtYO53B5JLQ9ZmxHe1oqsHCheny8Clmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW6ap9klnCUPg7C3OPsL8nPIe+dbevqaPp7/cRhMfrk=;
 b=ptLxmUj96Y02DN4LVt40sY2sso+CueWqdCjqD+ulijmEHDGakI3aV/MQR9U/5B5acLboQ9H/llnGAFYuFN+3T9qNwtg51CVIgrIuqjExowXeNHMUKAJLY8uPX/qKl57fff0erhmaUPG39zJG1xaDvd7YO5qsQ8Q156Pgv8C7gPaLOCOFl5B2u4QeFp2q79gbDCGmAJPL7IW9GPo+Pxb3E1nyHSKXdQ09PRqyPlMi8QpX5PP5r5C3N98+Pd3Wa9DVSV1Wrv/MMImLw1pS3ic7+RPEhbUn638kEwdN8t3TgtEuAKcRvhZD5uJB7qzTUfQ9VTSWgC7twooCvdPlEpiUzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB9307.eurprd04.prod.outlook.com (2603:10a6:10:36d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:39:00 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 13:39:00 +0000
Message-ID: <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com>
Date:   Wed, 7 Jun 2023 16:38:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <87fs73juwa.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB9307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9f8a66-6051-409f-b013-08db675c8cf5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ob0g8h8D4wcNpq3lxacJcpc1k4o4pXJj7Yc+xuPFnJfk12fnUh0+k+OczGtD+B7L9IX6JXLmQYsMpSAxZ8K5F1Uwze8bhl64AV/OHnV3grkWX5T/mxbb7M2+9HH3/xzW+GTBUm+rggOsdQMYMWj5Q+jEpwU449dO7ygDtv6yQrN/D30ahOpPCr02Wc9hUIA8elLVsHNn2WSlOIJQLTsQls0OJ1w+mCpsXhm3kJEz/k+cnjygNX1BrUf8sZscpuYtwrTmGP69gGUoW2r6/ZS3Jke0cAc0IrFVvGNHK/aoO3RgO4TpLIvevkTi0dgSZEFgGJH/YkhgeSdXcPUpe3XHho5SaSmo6VLfO1sPBOcvVHBXjUUalp4NHLUPhFoUyNHr9+9oHBzVdmErXNz4WlP0DFIScJr0fB4JXucHqq0NHjnvK6J0BuvI6coLY4QDpBP+Fw/QFEBKsy/n2o6bprO8cYd4rqKl1+xGygx4vhkLq7V7OGpEa7HQdEuwdFqfPsRDymWlKlw/DkzfI6nO00TATRFxcS/zo5YKdJo0++qGnTIOf49YH0HcnZ+AqM3Dqg/lT/YRBVCMIs0AUXaBGVyuYFFvGFmYeIhTIROMjeSZ/UArsMnR+IE1WXU3Yy0q2Nn4cswIFmEs06JvnAkcThKRMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(36756003)(6486002)(2616005)(83380400001)(31696002)(86362001)(38100700002)(6506007)(6512007)(186003)(8936002)(8676002)(5660300002)(41300700001)(316002)(2906002)(31686004)(478600001)(66946007)(4326008)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDErUHYyQjZLQ1ZDblV1UWlkaWtUVTFJd2NaTEdoWkxQQTFRaTZZWmNQQ0tt?=
 =?utf-8?B?MXpKUVpzRHhpakJkMmNwc3dMQVBkVmtyK0ZVRnlPdGZsMXpLTkZkMXlXNmo4?=
 =?utf-8?B?aUpXcFU3L0Q1cWlydTZ6aFZmaGNhSkhxckdLRmRJeGhkN2lkT3ZHS3NUQzQw?=
 =?utf-8?B?b2VZbEFjaVVQdFhoYk5FUnNoRjZuTjY1NC90cWZHbHRQSnljRk9oZWd5K0dB?=
 =?utf-8?B?SHJhZzBERkR2eTd1UWZDZnFuYll1ZDhhdHJJNkVpTU1nc1drWmlNQTAxMGhB?=
 =?utf-8?B?b2wrSDZORG1BZEJsakhYSGZuQ2pmdEdxa2JkOWZkU1J4dlhaNWRlNUdlc0hy?=
 =?utf-8?B?clVJT3BTRE92WG9QSEQyMHZPbGNQUmtubUpiNFpXWmk3Y3dWbi9MK281SnQ5?=
 =?utf-8?B?Q2JFaFB6QUNMV2h6dHM0VE5RbThSMnpRdHVxRGEwblRnQ1YzODBZdzVYS2FI?=
 =?utf-8?B?UmxaYkJqMDM1U3A2NCtMS1NLNG9rdUlnc2VGU25GN1JMUEF2bGR2STBtNmhE?=
 =?utf-8?B?TWxtS0pPeFU2elBtcWRMbnRGUlJKS0ZLaHFzNE82SmMrU1hpUUpCWkkvcjhF?=
 =?utf-8?B?MktEK0ZSSHRBNW11Z1lscDZoVkRSMzM4UlNzL2RiSE5SQmYza3hZSmdBd0Rq?=
 =?utf-8?B?L3NEQlNya0dia3JSZVBBRW9rUEtub0R1SGpSV1JJTnhmd2RTa2Q3NjhTL0dm?=
 =?utf-8?B?SGRHT29VVkl6YU9IWHp1bERkTi9idVlCeDdocXIvTGJmd2ZsZW9hWUtkd2lC?=
 =?utf-8?B?MDh0VlRPR3E0L2NxUnVCQlNLMnNRMVRxM0M1MVFoWVhidDBaaFdzREJodHly?=
 =?utf-8?B?NjZ1OUxlbHJGRVMwSGpWQXpmNTkxZWl6OHJ1VnZKOHk1aXh0MWtzamtzZmpv?=
 =?utf-8?B?bGw5bFZ3Ykw4dWxXRlczNjlSWW5tdEpqM0FuN2NqYlFvVGJCV2VEb2pMOTVE?=
 =?utf-8?B?ZmN0VkxDT2Y0T1ZJdmZjcVFoYk9xOFRtNmtPVndlMVNmSWRFQ2ZtQ05OcXpT?=
 =?utf-8?B?c2Y4OU5ucHZwYzRRWlpVUlNiWnc5bTdjR25heGFzQ0FjanM0dytZMDQxajVX?=
 =?utf-8?B?eC9OS2JhU0Evbi9uQklYSHB1K01JZzliTWc4UzcyTkpRS2JtN1J3N0tLTmpP?=
 =?utf-8?B?cEFwbnRCTFJZalFIS1RVQnJGTDdzdmNQRmR3TGQ5UzNDbGRyYzZjRm44VSto?=
 =?utf-8?B?Qmk1dnY1Y1FDSWVTTElDdm00ZW9GalNFR2R1Y1kwR09UYUxIdDFFbTJnUmNQ?=
 =?utf-8?B?QldablowK2NFb1BGMjV3SlZRaDNLN2c4TG01SGZ4SHBlLzY1QUV0U2srZ21o?=
 =?utf-8?B?UzJtNG5GN0w2UnVKemw0R3AzWWswc0M3RUpBa3lBeVVaTmlJcy9IQXgzVFBs?=
 =?utf-8?B?UVJiSEZJZ1duNnppbFJ4ZDRnZzFWQkFVSHRHeXdzMS9iTWpmU3MvRU9CenVo?=
 =?utf-8?B?bDF4dFI0dmREL0FsNVhzN3Q4TVhLYXdBZFJqRmJDaTBCdlpjQ3BZT1ZuTFFq?=
 =?utf-8?B?TE1OenlYZ2JMcWdZMVd3THMreXNNZ25hcklGUEJ2VFlmMzBISTJKRW9aR1JV?=
 =?utf-8?B?UmlaQmZYNDV4VUdhRXpjUEc5T0w2d1pFR0d2RzNndTRCeXM4cjBFS09HK0NM?=
 =?utf-8?B?UFA3dU96bUM5Ujk1enZ4VFI2MUVBbmxSN0oxTWl1ZWtMSXRuTlJTUFdaVUFz?=
 =?utf-8?B?SFk4SjVleFgxaXh3aHdHZkdJVGxXM3FwRWtXL2tNR29TS3NjbmZlM1U3ejds?=
 =?utf-8?B?RGl6Sk0zQkRYaXFMOXNlT1BpNnkwTG9MemNEajFxbHh6S3RRVlJEQWpnNllt?=
 =?utf-8?B?NVFPVUpSZHcxS2FTRTNyc3hnOUhJTnYrTUlXNGhSMmdwSWwyMTJDVkVkUk1L?=
 =?utf-8?B?eWFsWUJ5V2tXakp4dDJEVjlta3JPMlpSMk5hWmRFNFhyM2xiRUNXU3laSGpl?=
 =?utf-8?B?Q2U5WVZHaG1WTW5JNUFIMXNOT2pLREwzZ1ZNMzY0OW4weWZQRTFsU0Y3UnZ2?=
 =?utf-8?B?MWxsSUplSHVtelFLUlpDRGdFVURYYUh1SU9tWUJwRWZVRzUzeGNQQS9nWWwv?=
 =?utf-8?B?MWZpMG1CTFU2Y0VQMm1jR2pkbm1ER1NZMGJrVFU5aVJaKzRzWjRzVjRGSk1r?=
 =?utf-8?B?bFEyOW01VHgrOUk0S1poTSs0M2tQSWhSS3htUkpUWVUwemNXcitmT29MSWE2?=
 =?utf-8?B?YVJWUi9DQUwxSm95dVA5K0xwQWxSb1N6bVFOcFRabWtUZUowRzErT0NRNThX?=
 =?utf-8?B?clRocjZqR2tIcENyaGlXY0NqdU9nPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9f8a66-6051-409f-b013-08db675c8cf5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:39:00.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbaZf7vuJDT+UUldQTQjnEs94vgVcZ3ISNS2Bvs+U5sByq+m6vkztIg2AM32J8+SosnxPjx2jcBkHKZH0KpJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9307
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.06.23 г. 15:53 ч., Thomas Gleixner wrote:
> On Wed, Jun 07 2023 at 15:19, Nikolay Borisov wrote:
>> On 7.06.23 г. 15:01 ч., Thomas Gleixner wrote:
>>>
>>>> -	(elf_check_arch_ia32(x) ||					\
>>>> -	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
>>>> +	(!ia32_disabled && (elf_check_arch_ia32(x) ||			\
>>>> +	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64)))
>>>
>>> If I'm reading this correctly then ia32_disabled also prevents binaries
>>> with X32 ABI to be loaded.
>>>
>>> That might be intentional but I'm failing to find any explanation for
>>> this in the changelog.
>>>
>>> X32_ABI != IA32_EMULATION
>>
>> Right, however given the other changes (i.e disabling sysenter/int 0x80)
>> can we really have a working X32 abi when ia32_disabled is true? Now I'm
>> thinking can we really have IA32_EMULATION && X32_ABI && ia32_disabled,
>> I guess the answer is no?
> 
> X32_ABI is completely _independent_ from IA32_EMULATION.
> 
> It just shares some of the required compat code, but it does not use
> sysenter/int 0x80 at all. It uses the regular 64bit system call.
> 
> You can build a working kernel with X32_ABI=y and IA32_EMULATION=n.
> 
> So why would boottime disabling of IA32_EMULATION affect X32_ABI in any
> way?

In this case it shouldn't affect it and the check should be

((elf_check_arch_ia32(x) && !ia32_disabled) || 
(IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64)).

> 
>>>
>>> This issues a SMP function call on all online CPUs to set these entries
>>> to 0 on _every_ CPU hotplug operation.
>>>
>>> I'm sure there is a reason why these bits need to be cleared over and
>>> over. It's just not obvious to me why clearing them _ONCE_ per boot is
>>> not sufficient. It's neither clear to me why CPU0 must do that ($NCPUS -
>>> 1) times, but for the last CPU it's enough to do it once.
>>
>> Actually clearing them once per-cpu is perfectly fine. Looking around
>> the code i saw arch_smt_update() to be the only place where a
>> on_each_cpu() call is being made hence I put the code there. Another
>> aspect I was thinking of is what if a cpu gets onlined at a later stage
>> and a 32bit process is scheduled on that cpu, if the gdt entry wasn't
>> cleared on that CPU then it would be possible to run 32bit processes on
>> it. I guess a better alternative is to use arch_initcall() ?
> 
> Why do you need an on_each_cpu() function call at all? Why would you
> need an extra arch_initcall()?
> 
> The obvious place to clear this is when a CPU is initialized, no?
> 
>>> That aside, what's the justification for doing this in the first place
>>> and why is this again inconsistent vs. CONFIG_IA32_EMULATION=n?
>>
>> I'll put it under an ifdef CONFIG_IA32_EMULATION, unfortunately the
>> traps.h header can't be included in elf.h without causing build breakage.
> 
> You are not answering my question at all and neither the elf nor the
> traps header have anything to do with it. I'm happy to rephrase it:
> 
>    1) What is the justification for setting the 'present' bit of
>       GDT_ENTRY_DEFAULT_USER32_CS to 0?

This was something which was suggested by Andrew Cooper on irc, to my 
understanding the idea is that by not having a 32bit capable descriptor 
it's impossible to run a 32bit code. I guess the scenario where it might 
be relevant if someone starts a 64bit process and with inline assembly 
tries to run 32bit code somehow, though it might be a far fetched 
example and also the fact that the compat_elf_check_arch() forbids 
loading 32bit processes might be sufficient.

> 
>    2) Why is #1 inconsistent with CONFIG_IA32_EMULATION=n?

Because I forgot doing it.

> 
> Thanks,
> 
>          tglx
> 
> 
> 
