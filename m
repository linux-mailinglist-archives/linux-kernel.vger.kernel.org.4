Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AEE728A43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjFHV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:29:56 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BC30C5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsmdH/5PLWllFTVQUyH6cM63mOeGR+jntM3s1t0/Y9ERnC0GbF+HgWH4xOHt3QkXvpOT8IZuF5AlIC5IsyUvEUDESan5dkGStlOU9ZngXig//3Bxp2hHE2njQUD+yi09QuIdNR9YG7qQHWONfGiVIsw8wfaSK+SKQGKAqCCqS5Fvd1XLKIkB/8fFZ/MW/4542gXX/uxBirhqpxxPiRqTdcJZPHNhLBKEq7s24t3rhti8dT8/aGmQQHlIV8aA2xisCU8bB0b6/SQLxYUm3fQ1eZnr64Qv31qtqd2jBWbtn2voBoLLiep9CZrFgaC5JPnJgntSTUav9wehsULoN6sujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o2+H/2E2tcBt80xhooNiw9MlW95lRcGeh4bhbCbyoI=;
 b=F2orqfgLsEaJf+YifDkM4t3xLmqi942MBO3iN+OMgDsyvzcA4jeJIw6Xyi9UIvsHEjlQ6EZR8MFLUhOaLoKetSXRZzcrkfwyxVnxhsf2Q6Z6c88wYQQzVSfX4LEnitzGdf7Kw+qqR+J/+9n91Tt5IaFG12xiaRgU1EFvGkVdQpMdOPv5l7yM8/YeXbMa0dEHWZn1a1OVRSK9my8W/XFom0GL7eiGw48R8G2D+q87YKiWihfaGWTgtEaxU0HtLhZAyOci5sPg0erISMsZYGfskf3vaiq+r6DOykF+scTr3gzjbpwpWtp6PJhx1n6ktzzulSYKYcyaTG+43LSFFxk7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o2+H/2E2tcBt80xhooNiw9MlW95lRcGeh4bhbCbyoI=;
 b=CSDkO10YBPKf1lnrzeH1y2QNcvXqldw1bNerfK1ToM6ZNn9dlQlCmBmKEp7MwyetGhdX5tJ3ik4fYNGEjw6HizZeFNt4Vd4Uqw0rj6svGhPyZnFnVTOIl0wf4P/ATX2zw2bTS2z+GZ2yIKl4zSd/qtuTyV/xDqpibR+SAvIvhIkeQvBbPD66bSgAvpptU9Lq9DMz4SEa2I8cq7BBuA6Q9ljOSeLVNlMyhEq5eLdtB90HsMlixVtGsSHroqjNHbD7UZD68oVG++lvItd9tK9NLAro+9/Jl/MabKIstr3jTJHuP2e6++IOkOPKYaWHXxX1td1vmtoBgzvpcV5soKRW6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DBBPR04MB7996.eurprd04.prod.outlook.com (2603:10a6:10:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 21:29:48 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:29:48 +0000
Message-ID: <42a342ad-d019-c6df-6414-995bb32a3ef7@suse.com>
Date:   Fri, 9 Jun 2023 00:29:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-US
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
 <455418fb-8050-3985-5c6c-8b2068702286@citrix.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <455418fb-8050-3985-5c6c-8b2068702286@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DBBPR04MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: c44ae319-737c-490b-7309-08db68677c74
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPeaBQalaT+UzjjF7SO4uNDw8gOl7F1KU0sQaWsr3Y8E92O4Fl+NYwYpHxnPiTjn+KUgcVYkEUTMkEK7+LhZaakhFHOhCyySJR4G3DVujYACns9WrPvQ0LHbQdjPCvpI4hG5jj0mH8y5FfLMv5BxCFSboyGs8fWQmjLp1jvb2RabPxohydQsk68nvu9BrT9scRoSPCMTLNVEt7TweYDRy2hGnkaFvh8LmuiYjnlwNC3qgVyf/OEtNL5AkwR6cBGospXi4V9NTV5WLqqzJkbTXAp9YzesvlDPMQXii9iPz05HqzkdrToBJfggGwmz9oEVpH7tqLsLTB9byJYHYVcxwKKl46OUoIVNe7HnWgKqPZCIsItCsNSaapR4kfhhjz9/MN00iKjSjHIlr9ROLQ8Cpy4aKVXOEM2dlfSbnDAmOz9h12XFE5kaz+hbGdVYYBjC/xUsMppXejvuHWMcAzsbyl3MOC+xiFZeBE7v2NYc2zZXiUY/DETr4YE7WUyURg9nqDQjzJ7sHoX08lfzVLsuv4WwrczpQpQlaPSs1fLhie9+MXbN3cioWijGUHE0RaJfLzwoJFm0wYUJ83xBspsWmdMn35Qy7LiwUkP5c7G+dO9O7cFblDmhGiVvmzSj3YQPZpsSgQbFmKFE/xdToMJ75g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(31686004)(66476007)(66946007)(316002)(66556008)(4326008)(110136005)(478600001)(86362001)(31696002)(36756003)(6486002)(83380400001)(6506007)(6512007)(186003)(53546011)(41300700001)(8936002)(8676002)(5660300002)(2906002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVrMmh2OHpKU3RmQ1RodFFVaXdGZURhMG8rNHJjUEN4RU5acWhZakhkcWpJ?=
 =?utf-8?B?NGdlTW80azlDSVlqVFJxV1pHcXcxRlh4MnVUc1dpRE5oMGV6bVc2Zk1aR0pN?=
 =?utf-8?B?WUR1S2ZFVjFIZXc3WXcvcXdXTVphR0g2VFZxYnJPSVdockgyUnpaVlk1RkhZ?=
 =?utf-8?B?OUpQMFR4QXNaYzFaYnJ3dUdoYkxuYmtZcTJjK3lHc0lvRlBCRnB6NTYrZVdq?=
 =?utf-8?B?dFFxMkRPZENNK0dkamxOSjZLYXFReitRNi9SRVEwYkxjaGRYNWdudUxaUUtr?=
 =?utf-8?B?dUdKbldFazUvdHkwa21CNnpKV1ZUL3RwZ2QzbU0yT0ZUQXg3RnE5MGU0OXFN?=
 =?utf-8?B?MEUrazd6TVY2ZEdDVXRMUFFnLzR1MS9LYVozVkFSRUFhVFhFSW1jSXBpZEc3?=
 =?utf-8?B?TW4yOE9VMHhpRk82N0JTeU5UNUV3eGQ3ZWNCdHYrbnVYdW8xTHZyM0dBT3lW?=
 =?utf-8?B?Tk04NWFQZHNrSWFmczh2VndaR0p4NldGNkR4Z0FkYTErOVpsZXRNamRTemRw?=
 =?utf-8?B?NW9meFlIYjFrYnNzdVZSYXRTMmpFRFNwRnByNHduem05dDRxQmFham9hUzBu?=
 =?utf-8?B?UDVQUmdKcnRacGc1UW1mUm13RG1MTEtwcjJBZGlSbEJOYnV3V0UyN2tHQlM0?=
 =?utf-8?B?L1Q4c05XQTM0YVRLTENDRHRMaUhOQTNvdG5YbkZLOCs0Q1hnbnRkK05XMU1y?=
 =?utf-8?B?eDhEdFZoZFhkcFZlaUpVcDlDMTZWYnVNUnRBMzNwR2diVEk3L045TU4yQTdZ?=
 =?utf-8?B?KzEyUVRUWlYvSHdKclZsWmppZUhIVWp0R0tFYjNFa3hvYUtUdHB5cU9jV3Qr?=
 =?utf-8?B?RzNtWDM0QXBWYUFPN0swNzIxY0Znc1dQVS9CNGRWMFFBZGl3S2RZYmhCaXAy?=
 =?utf-8?B?T2lFUkpMamdZSzFsdmtRc3RyQ3BZNGNweEhvTHVSMnJpQVNPTEFrL2dYQlhi?=
 =?utf-8?B?OWlCY3hKb0hjNFF5UnhwNjAyMDZtNHZjWE91R3pBSmdBYVlGRlVTb2FtKzRG?=
 =?utf-8?B?TTNGaGJBemMrM0lNWGNOVVZrdWpTMVphS0x1cmVRRTNyT3lhWGE2SW1pT3Nm?=
 =?utf-8?B?OHliYi96dTJ4U1hpeUJTWm54c3dDWk40OVE1L2VLdDZPZmFHUXhIMGNvTnpi?=
 =?utf-8?B?RU1zMU5kM3FDYXlLQ2dST1RSOWhVTGdaMWdDVG81aE9uTE9VU1FGaDFjalpS?=
 =?utf-8?B?RzBMVk0rWGxzMmFwdTZ3TklUZUNIMVNBeitsV0sxVW55bkl4aGlmVWk5RWlk?=
 =?utf-8?B?UWorRVlucVpUYTNIOWhneUtHc2tTMFFaNnQ5YTVLcFJuN2FycCt1RFlYbVls?=
 =?utf-8?B?a3ZlTVViM29yUk1LRU52ZWlXbFAraVFUMEM1ckc3VDZEcW9kcUlaeWZ2bURp?=
 =?utf-8?B?S1pldDhFVWdiR0h6WDUwdXJvbUdGT1ZsYjdqblRXMDBldUI2RVAraWY3eVFI?=
 =?utf-8?B?OXY1a1hhdkRyTEREbE5hdjIzdUVvMnFoL25pTEcrcTRBNWJaUVJhdy9RakJ2?=
 =?utf-8?B?Sld6SlpDZ3ZkMXo5Zlc2d0p4YVRWZDNhUmY0Y29SQ2VCNlBKWnZIYXRlZ3dL?=
 =?utf-8?B?WEloSit5d3Fxa2pCRE92dFc5STFRNnV2OG9LaWg3T2xJb0JkbzFNMi9Qdm1E?=
 =?utf-8?B?NGJUaVczU3dQb1g0S0t1VnZhVVBFK0NJWHhHUGswSFF4NllwMGYwVUd6Ri9R?=
 =?utf-8?B?VDR0d0dCZmRhd2ZmTm4wYzNxUUdTanp0a3hHR3FiWTc5MlRNNUtHMTFjOWxr?=
 =?utf-8?B?TFA4N2djS2UrZ0ZkaVJGVnh2TnYxb01NNFo1djVmYURFOGRRRmpoKyt3dnRn?=
 =?utf-8?B?S0NWbTUvL2FINjlTWGVTQS90LzdWd2w3MmUvV0JOMGVnNU1uVFlpS3J4S2NF?=
 =?utf-8?B?QkxMNVhyYlB4V2ZUak1tb1NscFFOL1pZOEVwNTNKS0loV2FxTEVVTmNjbkJ6?=
 =?utf-8?B?VXhzTTFiUU93TUREZTkwNEdMR0lydmYxNk5yZzFjVlAxMUIzcnpNV0JzejJW?=
 =?utf-8?B?VWhXTEhlVW9JMGNyWWdIdHdmNHlJdEFrQUd1Z0ZCWXpxYmlKQ2dmMzd6MlV6?=
 =?utf-8?B?ZGtxbnZZd01MaUxmV01iZWRQUXhqSkIzWURXN0hCdThLV2xmWDdhcWdpNkJW?=
 =?utf-8?B?ckZsaFJWK1hnZzIxaXBoTThSRGtuSHVMSmc0M3JMdU1hdElwTC80NG9wZSto?=
 =?utf-8?Q?CY5MO+ohsAr4x3yFVlFEF5XcHQ9BYUEdw4sELx2OTUxe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ae319-737c-490b-7309-08db68677c74
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:29:48.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ9gEWKlClUVU9zz8yoLwpQjG4JzHaLgsYz9Jz0prOSHL9M33STMxkYqi+nk1H+VjBtgvTHbRU+PF7ozVW5mpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7996
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.06.23 г. 14:25 ч., Andrew Cooper wrote:
> On 08/06/2023 1:25 am, Thomas Gleixner wrote:
>> On Thu, Jun 08 2023 at 00:43, Andrew Cooper wrote:
>>> And yes, wiring this into SIGSEGV/etc would be a sensible move.
>> The only option is to wire it into die_hard_crash_and_burn(). There is
>> no sane way to deliver a signal to the process which managed to run into
>> this. Appropriate info to parent or ptracer will still be delivered.
> 
> Hmm yeah.  Something has already gone seriously wrong to end up here, so
> terminating it is probably best.
> 
>> I really wish that we could disable syscall32 reliably on AMD and make
>> it raise #UD as it does on Intal.
> 
> You know that's changing in FRED, and will follow the AMD model?
> 
> The SYSCALL instruction is lower latency if it doesn't need to check %cs
> to conditionally #UD.
> 
>>> Furthermore, despite CET-SS explicitly trying to account for and protect
>>> against accidental mismatches, there are errata in some parts which let
>>> userspace forge legal return addresses on the shadow stack by dropping
>>> into 32bit mode because, there's a #GP check missing in a microflow.
>> Didn't we assume that there are no CPU bugs? :)
> 
> Tell me, is such a CPU delivered with or without a complimentary unicorn? :)
> 
>>> For usecases where there ought not to be any 32bit code at all (and
>>> there absolutely are), it would be lovely if this could be enforced,
>>> rather than relying on blind hope that it doesn't happen.
>> I think it's rather clear what needs to be done here to achieve that,
>> but that's completely orthogonal to the intent of the patch series in
>> question which aims to make CONFIG_IA32_EMULATION a boot time decision.
> 
> Fully inhibiting 32bit mode is stronger, because it impacts code which
> would otherwise operate in CONFIG_IA32_EMULATION=n configuration.
> 
> Which is fine, but I agree that it doesn't want to be confused with
> being a "runtime CONFIG_IA32_EMULATION" knob.
> 
> If the runtime form could also come with an equivalent Kconfig form,
> that would be awesome too.


Actually that's something I'm working on. I.e be able to set the default 
state of IA32_EMULATION at compile time (i.e disabled or enabled) and 
provide a boottime switch to override this. That way upstream can retain 
the current behavior, while distros can set the "default disabled" 
config-time switch and finally users will have the ability to override 
the config-switch at boottime.


> 
> ~Andrew
