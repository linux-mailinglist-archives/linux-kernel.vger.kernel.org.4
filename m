Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B4729F97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbjFIQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbjFIQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:04:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535626B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdnbWHXo9eBs6hgEhgw+hN5+DYKAVwEsVoJTxnSqWdBD1WVneJ3WkYupWI7lrskEGCL4LNOcQ6F9tUVFLNnhgsPP92fqsE5O4Vn9Nei0Q5mkDb02bIvqaM8VlV0vGDnWVTV/et3y70UVUyJIDgsBxbjvF9rXFU4PY6WHgOd1KdJramFSTdG04N8f4qbvzBjsDKShZacb6jYzsSK+mdL8ODMBjvaCr5b12CrXR729RVSvvPHECUpf08skJIJufAs70cECo1VtxFRDdRCq4wjbacPwcUslTVHmBQCgwJ9Gv/gQXa8sXa7APPZtCfY3bDQFfyDF4KvZBSyPUTNOMNjkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT2lY9XXYZ1K3OByFhBZSemCqMVmvLGTOHnTy2cLTCY=;
 b=OGUE5i80+VcEdDyyTCz46Rs7FOe2xMMcqYZkWYyhh8knZJlct8DfdFcDT0bUKvzSNQh2VQ384iDmOvJpr0AvjTmuM6Riqujz7AxComRHwG69Y02eduxwTfG+zedVaISgCoGukqGYWdu3xEyrHIIgE9w65f5q16Whoh+Ip5lZmP9nMkdVyxRW96YdU3F12sfwPFnhytuuIfYHeqWL1BPpdX3PZHmQ/tfF8DWzEgjSCsVW2TJMyNChwRUoembie3kylYQ4BmNmjTMIewGrR/Cfk0ivq4aTwtf5QPeInGlB3+a50S74AbgXuERnKCJz3ZVNQgC9AuXM0KEET3BRjL3M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT2lY9XXYZ1K3OByFhBZSemCqMVmvLGTOHnTy2cLTCY=;
 b=BTAK8HP1MdymJbK+ljtQoeFZPrZPFKCGCp0lSqB292E+0vgCO4ovhWo/+LwaP4n/YlmgwS+Zl3x8CMhh8ieWq7v77MSvcnSOeL0L3kmPWJY83OolT3KTLInHprHjg/iGwMEcCSbEWCq0jlT0QGgMN5zCa1QOtl5GY221FyjUhdcUivAsqY3pr+McZvnwmRp/txrzuwpezApuMUATnHOqJRNxx7m7zGrpRcID0sOdgT6AF5Dx+pPwMmTYO0jAOPSGWAKjZQZ0b4ZFH1XqD0bV+3sZ9hTII9HMdpSkfTB7xhxn73k+8XNQW3P2vEeLE2+RX9C1ARDx6mWP5x4XkeZfGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:04:05 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 16:04:04 +0000
Message-ID: <599dea2f-f158-fd67-2c62-d5372d1d18a0@suse.com>
Date:   Fri, 9 Jun 2023 19:03:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-4-nik.borisov@suse.com> <87edmkirtd.ffs@tglx>
From:   Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 3/4] x86/entry: Disable IA32 syscall if ia32_disabled
 is true
In-Reply-To: <87edmkirtd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM8PR04MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4473e0-b7fe-46ce-b8a6-08db690325f5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Sc9ZaQxrY9fRJVkqldkGnJ+4qUK7pCcQQIRxs5Jo3WmZTgbsGNW1qbvT2djKdygOuqxFHqUj8NZLwJftAz9R83GPy/YI7pGFoYC0K61AcEuaep3e3x2D+w7USGNQHiJdgc/qmbuIHE1/ed6Wsac7IMRSpV9nOzm93TSDK7R4wH3xWaKcfQccJl1sNBZrxMF8waC8aiFKSoxpD1+sMeyL8BJwvK/kQj4VqlBTgHNZB5EAyIztG+GIa9OZGY3FDoldG2RSGQhDw4scH6Wb3gKOQ0Zwga1mCJZuAI0DcxQqX5SA2HU4JpgE1ofihVZyDWxBhAL+53uYcSUdLAI4rNggdgk4LKV+122RRzlOul8lG8ztZOuJ7SE1HU97oqCys05Th+8aN/h+uPeEtupdKOiC4dGjvKz9Vamfos3X5W3N9QxbeS00pRgpq2+pUkpN4lwBnq/cLN68smcbtAGvDnxbJ1oreprweE/PLFS1gC20NCoG49QffFV3xfzJroGmbN1Z5BnUaRJKmTQQdmtKlYpHs2TxKP8G3oNw+2PRa6Sowgc2yeOOn9uKz5tFrfrrOLPI4sBQQ8dsEefFvKTFdzWfspXdiuedAh/59OFSusN8K36R8ABvHaQApAfMxN799TnmHLSM+VvGZgHzLV+1qIfdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(316002)(6486002)(41300700001)(83380400001)(2616005)(31696002)(86362001)(6512007)(6506007)(186003)(2906002)(38100700002)(36756003)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(31686004)(478600001)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFB0SFRQcVUyakU5ZmRsODBIbEcyYzBIUVBub09sYmRvaUhGSmJMektsRC9u?=
 =?utf-8?B?cWhteGhGTmJwbjhQNGRRRzJIcGFCaDRKaFRPS1NSWFdxTzc0QWM4ald2MUJp?=
 =?utf-8?B?UFpHRnFNb3JFeFRPTC9sK25BcEZoWU50R3pJWkRnOVVSZmcxVVVEM0NaNGFB?=
 =?utf-8?B?MllXTEtVRUo5amUwUDAwdXZ3OExBZ2wyL3dBS25kWGZ3d1BjQ2JwYUdBeHo0?=
 =?utf-8?B?WG4vNGI1d2EyK1VLbWVsQ25iSWlzcU5NWmVJbzltdnowK2x3dnY2UVFiZU5u?=
 =?utf-8?B?TnRYeXlXdC9WOWlCMTdpWVo0a24vNVFqWDNZNHFvcjZBdDAwL1lGQlprREhr?=
 =?utf-8?B?MFZqakxBL1hMcTNYcnp5aGU0MWlMSEtWZDdka3Exa093dmpXd2hPRlJlVk5j?=
 =?utf-8?B?NlA1VGRtektsTHpwRXloREVjMlA1MnNIMzcwc20vWHlIaDk3VGplU0IrMEYv?=
 =?utf-8?B?WFZmS2hRL2JRMEVkTlFSRTM2SjJRTWZxb1BXMHpBcXo5V1JCRXVMNFpuMDBh?=
 =?utf-8?B?WHB5M050RkM1aWtEV3pRSEtIZUVQaHphdzZ3N3l2MkZzOC9YSzcrb0xTVXpF?=
 =?utf-8?B?NC80eFRTS29oUVNJVU42TlFuY1YrMkVlajUyeUoyUTNYQjhjd1NEQVNXeEhs?=
 =?utf-8?B?WWh6R3pQSzBDRHFkR0VFVmtKRXM1QzY1OUhyQmdrQmNxS0RSTUZQTWgwSW00?=
 =?utf-8?B?RTNCTy9YSnVHYWE2OUFnN3RodG9HV3NLbjNmZTQxVVdiWkFXT3JVTUx0K21i?=
 =?utf-8?B?aFNTWmpITnNHSlc2R0JiSVZtU0U5Lyt2RmxxWUE5Q0tpejllNGhNVFllQjZi?=
 =?utf-8?B?dTI3WW91MkdvRmdZZTRaM0pocmEwZXpVSllucGNxMVpiWHU5RzhZVXJKdVRx?=
 =?utf-8?B?ZTl0U2ttc2hpYTNIN1NuUWNHeFNXZHFOT1BGeDhBTFJzaDJlMGJaVzVtUVU3?=
 =?utf-8?B?dGJpOCtRQWVUSnNldGFuL2U2b3hDQU96UWNXWU0zWUpGUml4UWQwK1g1bFBR?=
 =?utf-8?B?b01YUS8zdGlpd09EUHg2eFpWTXdGd1c5N1hVOVY0d09UL1RKMTNGS1lHcWl1?=
 =?utf-8?B?RE1RbG5BM0txWlhvb3UxQ2t6NmdOWWFKUk5hc3NJeHNLUk9TM2trR0RvVTdQ?=
 =?utf-8?B?ZzN0aXJneHBpcGRodjRzV1I2Y2I5L0ZrdTZiWHFPNk1wN2pJSWZtNUxzdnNS?=
 =?utf-8?B?QWUvTmpYcnA0T2Jmem9sbElnbHl6OUZJNktYNHZVZ1h6TTBTU1pLQ2p5NGlF?=
 =?utf-8?B?OGt6TE03a3Izd3p2SHpHQktHZDErREQ3RlRqYlhqZ1ZWbnVqcmMyYVhaR3R4?=
 =?utf-8?B?ekNIcUNXT1krU3docnU4SVhmYzRoZ3M5ZjFGWEJ0YVRTTVRjbFRCSW5ac1cr?=
 =?utf-8?B?d2h4ZlhKZFBCTHNuKzBYRVpmbkV4NjBNd3UveDU0MkxmeGdJUzF5Mjd5QU9i?=
 =?utf-8?B?U0RscUtCTmpJTVprS0xHUHhFa0kyRXRxVTFjYS9oVG9IbmR1bE92djlnN25p?=
 =?utf-8?B?QUZiclhtWmw3U0dUSU1YUlk3T01yOUo0MmtqOGFUcGVjOXlFYU9rZHZNaUFz?=
 =?utf-8?B?d0hiMmxXZDFFOXJmc0NpZlFCOXpNZEdDMDEwWDRQNzBiK01PZWRtaXpFQURm?=
 =?utf-8?B?Z0FtRCtRQVJ3S09vVVZhVldUcmJhdXJJbVFtU3F5amc2eVJaeWgvZ1JJZkZl?=
 =?utf-8?B?TDBvZGpxZDBTblNCZU9BMWxkcW5wMHVzN2VGQk12ODlzdlRRK29RN1Z0Q3lk?=
 =?utf-8?B?M25tYjJKOUZPWmFiZVRtQkE0QytuOStHSVlLNXVRNHF0NjRzeGo2dWVsSFFk?=
 =?utf-8?B?NTdEc0JxMzdjaEFmNDM5RHVkS2VOZjE4OE1VVWowOWEwWkZ1T0E3ODcyZHZI?=
 =?utf-8?B?QXMyRUtGTWhQUDNzeWI5VnZEc3lVM0FoWXloTEkwK2Q1WUkwRTByZ2hET3ZM?=
 =?utf-8?B?eTlUZ2N2Rm9JVmQvS1FkVDR6enpnbFZ1a2hCcFFKeEl1OXRheEJDSTloVnpM?=
 =?utf-8?B?bC8wUzVQSDdjUVlFc1ZJWVp0OWo4OU1COGZ3dUhGbDExelZhaDVqWE9FcVR4?=
 =?utf-8?B?NmdBQ0tndHptSSt0N3dOVFQzWlpzWEw3TXFPSy9ERDVYU3RYK2JaNHg3Vy9Q?=
 =?utf-8?B?aXluOCtMRHU4aUxmQ3JaNXZZQUhpbXRSWXFybTBwS2JoQXg2cFVUQkpwZHho?=
 =?utf-8?Q?KgowyHisOnT85MdO/Yk4978XWXhjq75CwW2XxsDg844t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4473e0-b7fe-46ce-b8a6-08db690325f5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:04:04.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZySPVwH+2sm97uVi5oZCcbfV+VN72DaUZi5zl8tbZEdd0aDQ32gO01Hub5vmqW2lo+RbPgwNMaC8tzUDzqYnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.06.23 г. 18:22 ч., Thomas Gleixner wrote:
> On Fri, Jun 09 2023 at 14:13, Nikolay Borisov wrote:
>> First stage of disabling ia32 compat layer is to disable 32bit syscall
>> entry points. Legacy int 0x80 vector is disabled by zeroing out its gate
>> descriptor in the idt and the sysenter vector is disabled by re-using
>> the existing code in case IA32_EMULATION is disabled.
> 
> This describes WHAT the patch does without providing any context.
> 
>> +	if ((IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) ||
>> +	    !IS_ENABLED(CONFIG_IA32_EMULATION)) {
> 
> I told you before that my brain based compiler complains about your
> patches not building with CONFIG_IA32_EMULATION=n. The above still fails
> to build.

Yes, it does. My bad.

> 
> Aside of that this condition is convoluted and can be simplified to
> exactly a simple and understandable
> 
>          if (foo)
> 
> which is actually the obvious solution to make it compile in all
> configurations.

I fail to see how this can be done the way you suggest given that 
ia32_disabled is visible iff IA32_EMULATION is selected, this means an 
#ifdef is mandatory so that ia32_disabled is checked when we know it 
will exist as a symbol, the same applies for the entry_SYSCALL_compat 
symbol which has to be used iff IA32_EMULATION is defined. I.e the 
ignore code should also be duplicated in the #ifdef IA32_EMULATION && 
ia32_disabled and in the #else  condition.

> 
> It's not too much asked to flip the config switch which affects the code
> you are changing for a test.

Sorry, missed it the first time.

> 
>> @@ -226,6 +226,13 @@ void __init idt_setup_early_traps(void)
>>   void __init idt_setup_traps(void)
>>   {
>>   	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
>> +
>> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) {
> 
> Ditto.

This actually doesn't fail, because if IA32_EMULATION is n that 
conditional expands to 'if (0 && ia32_disabled)' which is eliminated by 
the compiler.

> 
>> +		gate_desc null_desc = {};
> 
> Lacks a newline between declaration and code. It's documented to be
> required, no?
> 
>> +		write_idt_entry(idt_table, IA32_SYSCALL_VECTOR, &null_desc);
>> +		clear_bit(IA32_SYSCALL_VECTOR, system_vectors);
>> +	}
> 
> That aside, I asked you to split IA32_SYSCALL_VECTOR out of def_idts[]
> and handle it separately, no? If you disagree with me then reply to my
> review first instead of ignoring me silently.

I tried doing this but it's no go since def_its is defined statically. 
Since tha IA32_SYSCALL_VECTOR is the last one it can't simply be tacked 
at the end of this array in a separate place. Hence the only viable 
solution ( apart from making def_its a dynamically sized array) was to 
simply overwrite IA32_SYSCALL_VECTOR in idt_table before it's being 
loaded into the ldtr.

<snip>
