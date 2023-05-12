Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63585700A38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbjELOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:22:36 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE62D7C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUwRD8IiD6/e/bFFpS33DjCfN/TWf+mv19f/L6UcWCSH8bytvDjUN+FHUnv4mCGq4ZtmJjgyhQkoBAuu+mQoDJ0GsVPtHlBupxxc26KAuqHxj2p1SAx+JgmKFvv0b33tkWFc2IfDudKbRp3T7z3zxtXydlyJgYTokIRUHsb497iMHbabJb2RXwA/7QAwS1KH6lBkbaQ6SYwq1Iv80bhNEv9YHuzwM13cOA7dM8/8OVYoxQ3iHB0lFfEBsfL9xksIHV5VzJ21RsBZ9Mv1LCWS3UCe5gKMQVqVotW0KaBNInkkbP3ZhQOBU2Se0DJM0EYBtnqY/p+CYzgfdwOBO6GIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y86MfdbTnIj/0Yuo5yRtRmjlGXea56FdJ/EHja6Jixc=;
 b=oazRhe2ALBrhXBSyD1TL8TnuNZ/dbStmN3yZNf2xKdpXjtE+n7bD1UZm2lBX9ozVDK0V4LlFzIfia2CnQ6ZHKW8SPianGhAhVKF5j/7Yzaw2A9pJicZobW1G9XNjH9do81/Dl04/6vpeS9i+gBqI62NhjJqp92GZlqmjsWgzgejOTadXJNblpAog8bGwzeD095gTE99nXxshmOOlvKocX0CMNsbCffqqTn92fC/XGu4An2v+isjX9jXIbT7yg0Z1pYAKhZEsafkFqNLuFqqn1Xx48+OTk0iqGa46YNvMsx2LjgJxKJYIew5hVymxAtwnIM6xUFcC01URHwqq6BWUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y86MfdbTnIj/0Yuo5yRtRmjlGXea56FdJ/EHja6Jixc=;
 b=I2Jc27J1qGkxEH1g7y+a0wVVrEt8PHaVwSEdVF/CqHXCNFpcobSHaw94tW8vojhVd4IAO6HS3Sj4emgVlQYBWJAj5tRQtNB2uIecZd8Acwgk2kmYoFJgewJaDUlJT6ssc/JvYEAUOkww9VysCm7pGjBO3QWtDO3tHTxI74MS/lE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 14:22:31 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 14:22:30 +0000
Message-ID: <182c4d7b-9e91-c00e-43ab-a2c0bd671828@amd.com>
Date:   Fri, 12 May 2023 19:50:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com> <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
 <87ednnes6o.ffs@tglx>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <87ednnes6o.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9ce4c4-2214-4ec9-be6d-08db52f45147
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gP+JJumSY1FoKgsLW0iDZoN2a7CCyj3Z1cScGTNpASLrxYao7E85ECZWx/nIC25R/wmuNDcHXr+gYf9UJ2Q7T0O6YdpnfIChoKJsPYoaogr49kjqv7kqCT3hqI1EtZ44yzG0eV1W9uqh4S+JRit0XStj1ivn7KJhwRSQ7S/bFefmUvWzlQk0xlSDCBu1m6dbY7Mm3yeYWHjlAuONGPhcSlROECHhVm7V75F59Axy8CtJm8s4jYk+ZSpAAtykcpCzio4CyInOcTNdsJX5JNn9FluEzpd/rAog1wcqBAz+/mo5pF6Qieo+6cy2TT14ihRGbQGg09UwXb+8vWNhHsMey5wBkzrozGgljqnlmD5m3fcPUkmCpVTaOX5cOVFpVd06gbm2amqSTz9s0/RSiXnmShNaCc+SJPbXQ5HSWIU/6ZGX1OXfOGklTq87KvZzN+5ep/CdRjwQCKnSXV2tWH3hnvWKZOAAdI1CRWTmk4MXq9aV/B+/s1MXOVG9Zmo8RMqTB1hu403Y01yZzY2okiYciSJ2KhJvDL4RMfrBLP4PNZ8xbfHJCChLGkni2K9ZSu22FyMJAPDEJ9OuKcdypvT/gwZbn8dU8ycFFtD0RwU+uPgcNz5LPcpi2RXEjee0x0xE0leW1Ni8/W3p8htNumuSgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(110136005)(54906003)(83380400001)(478600001)(66556008)(66946007)(66476007)(2616005)(316002)(2906002)(4326008)(31686004)(41300700001)(8936002)(8676002)(5660300002)(44832011)(26005)(186003)(6512007)(6506007)(53546011)(6486002)(66899021)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9raGJRVy9vRGJtMmQ2ZjBjM2dHU1IvcU9lSFh5dHRnZXNhNFFOZDRBUVBy?=
 =?utf-8?B?dUxxMUZQWUp2TU1IZnBlWjh2RmtaUHZGbGdxMHZiNCtYY0RsK3I4ZENXbHdv?=
 =?utf-8?B?ek03NU5KdWg2VkFBMmZRNE1YVEM0SERnUDFpT3pObTVOd0luWGcwaEZWS3RV?=
 =?utf-8?B?dGZYbjB2aWs4UThDdGxuV1FMdnMxN0JLbUJQdENVS1Q2S3l6a0o3UWd3cWNi?=
 =?utf-8?B?WkRmL0ZROGtHZi9hdG9KQzk4RHhSeGFWalVTTW52TjJBNGxIdEdPOFdpRW95?=
 =?utf-8?B?RC9mdHJsVlEreWh3TDJscStoQVdTSWpRc01xMFFVV0p4RjlhOEhHRitRZnhN?=
 =?utf-8?B?WXMrNTkySktMR1BWN1NydU1jSUwwWGo5NnBuSDVSL3pPTVZBOXVFQTlWN1BT?=
 =?utf-8?B?aFl4M3U2SDZOaTk5MmhlS2Izck1uRFdsUDFIR2xWVGpsb25nd2FEclR4ZjBP?=
 =?utf-8?B?MUlFbCtKclk1RTVQYjVMYzRucVRaZ1FMczg1WGJjT3lmeGRVMlBEQVpDZ1hB?=
 =?utf-8?B?L0ZTYlU1ZXpiV2wyWjZIemVzQ0dJZXVieHpzTks3dFBDVEpraW4wbjRQVWM4?=
 =?utf-8?B?UDQxUlVsYnJLMFBUdHljZFNnVXFIZ2NHakpXZFJ2QWNuOW15TEkxN3FQeUNH?=
 =?utf-8?B?RHBPdXQ0TVJ6WUwxMWlPVjZCSEo0SFQ5b01ZMGtRbDU2VXhvcG5JS2V6U0Yy?=
 =?utf-8?B?azU2emt6WFpHTUtPZzNhQjNYTkttbENzL0NHRzJ6MHlaakRFYXNUY21OYkxV?=
 =?utf-8?B?WG0rSjNpdldwWDlNOVpnV0NYSk1pRk1KWXFOVFMwZmdYZ0xUdWhGWkxqNlVD?=
 =?utf-8?B?dDF2dXVyVGJHaUYzM0lyeS9PSnhLSVFReDMyZmhWMUM5ajhlUjdxSGxkVFh6?=
 =?utf-8?B?VVZjTStBbkdFY05ZTnBJZU52ZkI2K3djRW0yeVgvODdJSjJlbjE3V0EzZTJq?=
 =?utf-8?B?K2VOMzcvSXZJbjIvb3FKVDFvNkVObGQ4WVZjWkdoSmVKaytwdmdHSFVJWE1j?=
 =?utf-8?B?M2hVY0RyUE9KVStTSFV1Y2U1dDAycG1pM1RlZGZDbXBiZS9lTnBseWxja2Zn?=
 =?utf-8?B?TDFQNTRBVkF4TEg4c09qb1dnd2p6R3NwWnVwM29tZ3BQeW1SMW9HNTNtNFhC?=
 =?utf-8?B?eVdnTlk2ME9scUNzYThvNTN1RUlxMUM0YytUdkhVS3NlSHR0THVEYTQwM3JT?=
 =?utf-8?B?N01JcDZ6eDlLWGwwUzVXVUNBOTRWRStaaGxzZ1A1RVU2TGNZcCtkUHFIVHBy?=
 =?utf-8?B?TGo5ZlkyTDYzc01VazQwb2o2enhNaWtXSHZCSng2V0lpaWZvNlBzclpVbmxn?=
 =?utf-8?B?anZMNW5aYisyRngzV1M3Wkdwcm5rOXgreGIxUnFBbzlQUjlEV29iMmROcWEv?=
 =?utf-8?B?VXNrY2U2RHZzb1gxYjZ5Slc1STBtdFhLMGRtNUU3SkdOVzcxcmVmeFU0WjlQ?=
 =?utf-8?B?RlR3MlllalNNYy80VWIrQlRkQ09xeW5LTmZzZ1FyRjNFREpoVnY2N2JYWTFQ?=
 =?utf-8?B?bW5hL3RLT3E5dlZPUUhnRlVzZlNpOWZIbkFDQlJRRTlWNkRRT3pyemJmczVC?=
 =?utf-8?B?YWxNWER6VTNLSXUyVzJKUzVyeWxDdm9Qa2dJOEFuWkdTTVFVdmhnNVRhKzBx?=
 =?utf-8?B?K09Fa3dnamRUL1FaMnp3TXBFUzlYelc4TVlORjRMRG96WDAxL1VFTTluYUQ3?=
 =?utf-8?B?WnVpdEVQMEF6dzJlNHpmdjVjWEZlaXZUeFZWMThreXo5aHNTa01UeW0rSG1S?=
 =?utf-8?B?WEwzcmRDcUg3eFg4RmZTYnNDZzcwTWtieGNSUkYxbHNzQ3RScUtpSkkvaEty?=
 =?utf-8?B?aHFYQUJyOXc1Q1NMNHZ6N0tRVjVWMVdDOTlLdStNTnpibVNhSTVBTERhK1pq?=
 =?utf-8?B?VXBkUlFRYjh6WXhmTkxCSFdnRXYzc2p2YjhmYS8ra09wUm5pU3RXSzFUQUp4?=
 =?utf-8?B?UDFWNUIzb3lYa3lla3RQZzNiMU9iZjVGOHFCTGxveWlTREtScUErbFRmOE4z?=
 =?utf-8?B?b1lpTEVwK3pqLzlmY1krTjFwOUc5dUg2blU5bnpMakN3SGxscVVzQWFRWVhG?=
 =?utf-8?B?S1RNYUtwdFVQNDVFYitBMVArQ1hhRnBhL3U4elpNdnpMWmNaTjZZRHlZYk9t?=
 =?utf-8?Q?hVGp7CxlA7dcuRn/puZbaIYaQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9ce4c4-2214-4ec9-be6d-08db52f45147
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 14:22:29.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7Kn+CJCFvJLZt+cLvQ4ceu9nx0Z9yrE6lhtfKYDQ94/PfUL9eFgLbMng8pg52bi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2023 3:59 AM, Thomas Gleixner wrote:
> 
> Nipun!
> 
> On Wed, May 10 2023 at 19:34, Nipun Gupta wrote:
>> On 5/10/2023 3:31 AM, Thomas Gleixner wrote:
>>> I'm not insisting on that, but you could at least have had the courtesy
>>> of responding to my review reply and explain to me why you want to solve
>>> it differently and why my suggestion is not the right solution.
>>>
>>> Alternatively you could have added that information in the changelog or
>>> cover letter.
>>>
>>> So in summary you ignored _all_ review comments I made, went off and did
>>> something different and provided a slightly different useless changelog
>>> with the extra add on of a broken Signed-off-by chain.
>>>
>>> Feel free to ignore my reviews and the documentation which we put out
>>> there to make collaboration feasible for both sides, but please don't be
>>> upset when I ignore you and your patches in return.
>>
>> Sincere apology for not responding to the earlier comments. Intention
>> was never to ignore the review comments. Appreciate your vast changes
>> regarding the MSI, and the patch series you shared took time to
>> understand (provided other things as well), and it was quite late to
>> reply. I understand that even in this case atleast I should have added
>> this as part of the cover-letter.
> 
> Fair enough. All settled.
> 
>> IMHO, use-case for MSI in CDX subsystem is a bit different from per
>> device MSI domain. Here we are trying to create a domain per CDX
>> controller which is attached to a MSI controller, and all devices on a
>> particular CDX controller will have same mechanism of write MSI
>> message.
> 
> That was exactly the same assumption which PCI/MSI and other MSI
> implementations made. It turned out to be the wrong abstraction.
> 
> CDX is not any different than PCI. The actual "interrupt chip" is not
> part of the bus, it's part of the device and pretending that it is a bus
> specific thing is just running in to the same cul-de-sac sooner than
> later.

I understand your viewpoint, but would state that CDX bus is somewhat 
different than PCI in the sense that firmware is a controller for
all the devices and their configuration. CDX bus controller sends all 
the write_msi_msg commands to firmware running on RPU over the RPmsg and 
it is the firmware which interfaces with actual devices to pass this 
information to devices in a way agreed between firmware and device. The 
only way to pass MSI information to device is via firmware and CDX bus 
controller is only entity which can communicate with the firmware for this.

> 
>> Also, the current CDX controller that we have added has a different
>> mechanism for MSI prepare (it gets requester ID from firmware).
> 
> That's not an argument, that's just an implementation detail.
> 
>> In your opinion is there any advantage in moving to a per device domain
>> for CDX devices? We can definitely rethink the implementation of MSI in
>> CDX subsystem.
> 
> See above.
> 
> While talking about implementation and design. I actually got curious
> and looked at CDX because I was amazed about the gazillion indirections
> in that msi_write_msg() callback.
> 
> So this ends up doing:
> 
>     cdx->ops->dev_configure(cdx, ...)
>       cdx_configure_device()
>         cdx_mcdi_write_msi()
>           cdx_mcdi_rpc_async()
>             kmalloc()                            <- FAIL #1
>             cdx_mcdi_rpc_async_internal()
>                queue_work()                      <- FAIL #2
> 
> #1) That kmalloc() uses GFP_ATOMIC, but this is invoked deep in the guts
>      of interrupt handling with locks held and interrupts disabled.
> 
>      Aside of the fact that this breaks on PREEMPT_RT, such allocations
>      are generally frowned upon. As a consequence the kref_put()s in the
>      error paths of cdx_mcdi_rpc_async_internal() will blow up on RT
>      too.
> 
>      I know that Xilinx stated publicly that they don't support RT, but
>      RT is not that far out to be supported in mainline and aside of that
>      I know for sure that quite a lot of Xilinx customers use PREEMPT_RT
>      nevertheless.
> 
> #2) That's actually the worse part of it and completely broken versus
>      device setup
> 
>      probe()
>        cdx_msi_domain_alloc_irqs()
>        ...
>        request_irq() {
>          ...
>          irq_activate()
>            irq_chip_write_msi_msg()
>              ...
>              queue_work()
>            ...
>        }
> 
>        enable_irq_in_device()
> 
>          <- device raises interrupt and eventually uses an uninitialized
>             MSI message because the scheduled work has not yet completed.
> 
>      That's going to be a nightmare to debug and it's going to happen
>      once in a blue moon out in the field.
> 
> The interrupt subsystem already can handle update mechanisms which
> require sleepable context:
> 
>     irq_bus_lock() and irq_bus_sync_unlock() irqchip callbacks
> 
> They were initially implemented to deal with interrupt chips which are
> configured via I2C, SPI etc.
> 
> How does that work?
> 
> On entry to interrupt management functions the sequence is:
> 
>      if (desc->irq_data.chip->irq_bus_lock)
>         desc->irq_data.chip->irq_bus_lock(...)
>      raw_spin_lock_irq(&desc->lock);
> 
> and on exit:
> 
>      raw_spin_unlock_irq(&desc->lock);
>      if (desc->irq_data.chip->irq_bus_sync_unlock)
>         desc->irq_data.chip->irq_bus_sync_unlock(...)
> 
> irq_bus_lock() usually just acquires a mutex.
> 
> The other irqchip callbacks just cache the relevant information, but do
> not execute the bus transaction because that is not possible with
> desc->lock held.
> 
> In the irq_bus_sync_unlock() they execute the bus transaction with the
> cached information before dropping the mutex.
> 
> So you can solve #1 and #2 with that. Your msi_write_msg() callback will
> just save the message and set some internal flag that it needs to be
> written out in the irq_bus_sync_unlock() callback.
> 
> See?
> 
> IIRC, there is a gap vs. interrupt affinity setting from user space,
> which is irrelevant for I2C, SPI etc. configured interrupt chips as they
> raise interrupt via an SoC interrupt pin and that's the entity which
> does the affinity management w/o requiring I2C/SPI. IIRC I posted a
> patch snippet to that effect in one of those lengthy PCI/MSI/IMS threads
> because that is also required for MSI storage which happens to be in
> queue memory and needs to be synchronized via some command channel. But
> I can't be bothered to search for it as it's a no-brainer to fix that
> up.

Thanks for this analysis and pointing the hidden crucial issues with the 
implementation. These needs to be fixed.

As per your suggestion, we can add Firmware interaction code in the 
irq_bus_sync_xx APIs. Another option is to change the 
cdx_mcdi_rpc_async() API to atomic synchronous API. We are evaluating 
both the solutions and will update the implementation accordingly.

Thanks,
Nipun

> 
> Thanks,
> 
>          tglx
