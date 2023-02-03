Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE59468901A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBCHFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjBCHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:05:20 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C42222CC;
        Thu,  2 Feb 2023 23:05:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1BtWLNf2VrjpPfM57pv2ot1bfuZPXhOspOEB2jjNUUtVWY9y/z8CdgfLe4De43E1659ArpDHYDtKcF2jHaBpbDvlA0m84+ski1r2eiPXFLkTL4yt2GtA0FXDfqM27GXnygbhxbVcu6cHIv8sjGElhPE9WInhfgm6v/ACmhqcbV22b7dIR8Yv1gMeAzgY0+b3kRI1gOycrss8lcoY6mtqFhCIn3Tt6t5vN8Gf0pCo2r9mS/q4b/LFGYZUThlUL6+USil43CdHaVEA76P7Zv/+sz8sLK/s8TAN1WZIWt19SHU2VwTAUeyKNn/w2aFI34hccQ/3yxoyGcnDzcevBpMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnOUj5TLMf2PZxo7PDKEU2yiIsuRDwt/vGTXTVee/B0=;
 b=R+jImaa103jDIh3D0PyAenI/aGvkk80ZQqvjWofcuiIG2dtw0Ze9wzbR7TCLTjM8TSC8/YNIaJPKQLCeDS+akGi/kgKIzKQlVglN69GI+tJcCuYpzKUjWH41Ia1WwiY5AxPXcXLt6TihVp+7oSJtpvoqq80kY/z8DVXI65zN4VGm8QtSnuuym/fzOFBlK1IJDeIfuMNyJG6GTzf+DT104ZqtyfE+6FAWNyQcbkeZ2JFB1rM5hg2PHzHu5cLePC3ddNqP2sPmyDN+Wakt6+ukuTMaKPptkCHp59N0yWqAiEVa/BA95MF2A56QGsGqgDB5JaRV1/+pOK7cUKHJvzS6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnOUj5TLMf2PZxo7PDKEU2yiIsuRDwt/vGTXTVee/B0=;
 b=h2xNANVDvaruHO2hDp5vCG5Oxwfxsmt6kKeJPLzrx5YMHE5LM+lK+ZKVSIAra7VCHBVy2UUZ6t3Dj3rZ3waltPXaSblzc/KQKen9sId3xJvNHptpZoj/wXlFuChW1zEYeKglyGq7AWeOiwzAeylYinlv/vnU8MlLOVJ3gscfT709YJGqns1JGn3wDYbEXMQHy4q2Ct/kzaRZVFybEdBszGboCsL2o3HNSGGTBpE/3bensDMXtxyvZY03iiHhMbDm8nuuD33YNVXN0Vq27uPzV1rh1/yyBx9aMhZ/cfIaQfs+A1NyHI5vC5sPEWQ0X09rswTYb54yng6pdcqUiEr2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Fri, 3 Feb
 2023 07:05:07 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::e138:4fc3:705c:d178]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::e138:4fc3:705c:d178%6]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 07:05:07 +0000
Message-ID: <513e2851-9098-b510-588e-1e68d44d23fc@suse.com>
Date:   Fri, 3 Feb 2023 08:05:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     Josef Johansson <josef@oderland.se>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <952fdc14-a8e5-a59a-9c7d-af1adf361d77@oderland.se>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <952fdc14-a8e5-a59a-9c7d-af1adf361d77@oderland.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|VI1PR04MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: ace03b3d-b680-43c5-a094-08db05b4fad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hV/69WOu7eCLyTjgxftEWTKauPnF0kOJM1a5QkoXU3cHUU8yffCeacgVYZxq0TMqelfMdTqY2wGrVsxslypbeNP7ELXFiP0zZsFUt0eO+w00icoxLmxdK7ym66D+0cbtCJ78FRT+m8ExWyLpHK8ZKP6y7yanU04KjK1xrFzV8E3jTnVg2UW9U51nYi47rbz4S/e4IUjLlT+HFgTn2oJC/OaBPKchTQSWO8sexdSHCnQve9R6FXwn7e37LQENhFvcQeMA8vd3AbiNlbSVxoljloXzbDXXGGSGXKKh9LF1gOCTJf3yq3gzYmG0qTp+GFhiV37FM/+gaz8cMa5jXmyRjPEac6EK8HaRgjqwGfWkwHPHivFCmZipRs9AOQHmMytU5/YbHR7L222aOQLEbkvSC+uhd5rdeL6aB0QFlbl8KwxulgB5dv2CsTzmHXT9oVB4M+Q7vbJA77nTsH8x0lwdk3fjuRqbiclU0YT9uyc3JqPZgMLQiwHTEEMsCcnDxCuro88Xflw2hIZrNWd9pZiB20/jtZzbwi7l8ZUZXIX8ED8TNVtpKh6iIWozbvVydREdcWc0pd22fjdGe3yPlhnC1jxLxGvFo1WoBhlvHBNMQ433cEn+/YbGOSGPk7CMItStBZiY6CkSg1X7VUzlsC36ZDyOdPAxJm93n7gq4YK8jpKQL/ewuPLyaJgOyWi5KiE3pfiswjMed2T3NXVfevUm03IO5RPdifd4QindPmzL2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(4326008)(66946007)(66556008)(6916009)(8676002)(83380400001)(26005)(8936002)(41300700001)(6506007)(5660300002)(6512007)(66476007)(186003)(31686004)(2906002)(316002)(38100700002)(53546011)(6486002)(6666004)(2616005)(478600001)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWgxYnJDV2FXcUVmcjAydTd0eDR0NlhBc3NNLy9DdmptcTBvUG0yZHZqY2o0?=
 =?utf-8?B?Wjd5V29ZUnY3bExuMkNkYkIrc3NHVURYMVM1eHA1U1d0WU1Tem5vWWpuaHRQ?=
 =?utf-8?B?T08xd3U1Z3pKbVA1NDQwT1FWakdsSDlXcWNVUGtYTmpOUFhZc3I4aDhrVzQv?=
 =?utf-8?B?RFdxS0k4VGM3Yk40cjcvL1NkSTYzQkUzeStoRXRXa08rNjZzbm0yU2c4Y1dm?=
 =?utf-8?B?LzA1Y05nSUh1ZitkMkg0MzdWUWJjbjc2akpKa25SWk5rWUNiMFZkMFRxeVFC?=
 =?utf-8?B?UjF3eC9jWE1BLzdrTzJmbGpCOWdjckdUZ2ZMcDVOZHVnVG42cDIreUxYWkUx?=
 =?utf-8?B?Nml0cWZScXpXTXlPN3c1OVFyUVBQNEpDMkhJaXhuOERaY1c5OXZZeXQ2cGxI?=
 =?utf-8?B?UUhRUlR5OXFNQm9OQ29XZFBrM2ZmZ3dQaTRwaGJ1Y3FzNUh3WGFuNnBqQURk?=
 =?utf-8?B?NlozemNnYW5DZFFCYTBsNDdjYTlta1NEK3FTL3hHenZQcDhiWjBUempJMmY5?=
 =?utf-8?B?Y3JXNDZRb1Y2K2Rzemh4ZXpUS3JtMWRteUpVQnVzT2NKYnlaSkZqUkhnaml5?=
 =?utf-8?B?T1hCRmwxcHYxL3BHOTZBSmtnY0QvNlB0R3oyQVNVWnRtV2xUSnppS0FxSTl4?=
 =?utf-8?B?U0xlYWY2NjVLekZJZXpDUERwV2xKb0pORmRyQVREbGdqQmxiaHNIaktCTVBZ?=
 =?utf-8?B?UE53ZWZMS2lhNXBGamdTcTQzV3N4TXFhSlE1RGlGb1pjSkE1Q1dENjhsd0Fo?=
 =?utf-8?B?Mnk5OHNtcFdBajBnL0dIem5LUkwwbjBEZW9pZUlmaHQ5SW85QzV3MElsWXRw?=
 =?utf-8?B?NGhLSnAyeUF0TEViVnVpOEdrVGQ0cVorcEpPeE1SS0hYYUVxSFlBWFNVemNG?=
 =?utf-8?B?ckd2VnM2ZE9xbVg4NytpQm5jUXVBa0xwb3c3RmtmTitJWjlxVU5ldFNPS0l2?=
 =?utf-8?B?SXdDcWw1dkJYSCtHS2NLTEZVbXRjQ3N5Z2E5R0NXOFBNdFAwc0w5LzkzeHh0?=
 =?utf-8?B?SkY2OERhbHR4UmdsSGxCMkNNVXZlYy85dW1TcVBDUFF3NnRkZEtwQWQxN2pt?=
 =?utf-8?B?QmFPQWdrSmhGekRxZTE3c0hyRG4zNmdIbEpyaklhdVdOOUt3eUMwNEdrNjh5?=
 =?utf-8?B?NytaYStDcTdvWW44YWZvUk9sMGEzS204ek80NVBGTWFEWjBzQ084WTFYSFNT?=
 =?utf-8?B?VnpGQzJVUkw2akd6V29QL1FxcjlHQkZCNTNZV2dvZVk3eS9qWjJYQUxxUXRM?=
 =?utf-8?B?bDhtTUZnR1Jxa3doWmZ3d2FvQWJ4RVNiZGZURXMwSmxyS3ZOMjI1d1g4b1JG?=
 =?utf-8?B?NlV5d3MzR2FHalFJaUl4MlYvMW9jZDM1YlE5T0F5UmVLVGR3ZTlwL0dtTGNq?=
 =?utf-8?B?cExVN2g2djQwT3VHWFh5aUlESi9pQ3BYdjl3Y3grcTlGN09VZ0dkV0xXc3Nt?=
 =?utf-8?B?MEdEK29DbnY2WHdseXNaZ0hKaGJRK3NQQ0pwQTZjRnRXaldGcXlhMUVaWjhi?=
 =?utf-8?B?cVZBK0pxS3dYV2F5RGlJcmFpdkZnS3llclBQcHE3QUlub0ZJTCttUWVUdHhw?=
 =?utf-8?B?LzdIb1hEczVqWUIxY2NBMUEwaXBPUlRKc2cvOEI5THZPbGY4b0dCZ0owRk4w?=
 =?utf-8?B?dHYxR3M3amhyUVA2eXJUTVhjcmJPbTBoWUQ0d1gybGxqMUZRNnhoUHplN1Y0?=
 =?utf-8?B?VFNjdEZYdHdrYlJYOEVzNitKcFR5TENvTmYzMFdTeTV4QW5lbGRtRVhEQThK?=
 =?utf-8?B?TVRBQnQ4WkRQYVZ5cEN2VWZaek1GeFJUMis2dzlkeU00UzkvZkgrLzdzTFZV?=
 =?utf-8?B?T2o5UGxCOWZVY0EwNlZsVlhNUE9sdFJOcFc3bDVxOFFQMVVVSzNneFduSXZ0?=
 =?utf-8?B?My9KbFc3b2pWaTQ1TTdnM1lhaGJYYW5JSXhtU1NGOHMwSi9LMk1jUVJWQkZj?=
 =?utf-8?B?RXJnL3ZHMmt6OG1MSDVsWlRMcVhwM3NxVlU5ckxucjJKR1R0MFJiMEtpT254?=
 =?utf-8?B?cTZSZnRjL0xxMVFhS2NRVmV3WmsvZ3RNVTBGUzRIOCtkZm9CbXZicUhXdnBS?=
 =?utf-8?B?MVg5ektlSGVLaE85NUw0dVpoT0Fmb1RSQlp1dngwN3VFOEh5U0ppWUhyVlND?=
 =?utf-8?Q?n6rTn3eevYyvWpeBBa48TlE9q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace03b3d-b680-43c5-a094-08db05b4fad4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 07:05:06.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WhyymPM/XO21ZNovBoGrzM2UGoqoqGVu3+N4UZLOhoZ2vp4vRzhLppJDJY++whLd7oYVsHFFmXyN3iPOmJNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.2023 10:21, Josef Johansson wrote:
> On 11/21/22 11:21, Roger Pau Monne wrote:
>> --- a/arch/x86/xen/enlighten.c
>> +++ b/arch/x86/xen/enlighten.c
>> @@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
>>   }
>>   EXPORT_SYMBOL(xen_arch_unregister_cpu);
>>   #endif
>> +
>> +#ifdef CONFIG_XEN_DOM0
>> +bool __init xen_processor_present(uint32_t acpi_id)
>> +{
>> +	unsigned int i, maxid;
>> +	struct xen_platform_op op = {
>> +		.cmd = XENPF_get_cpuinfo,
>> +		.interface_version = XENPF_INTERFACE_VERSION,
>> +	};
>> +	int ret = HYPERVISOR_platform_op(&op);
>> +
>> +	if (ret)
>> +		return false;
>> +
>> +	maxid = op.u.pcpu_info.max_present;
>> +	for (i = 0; i <= maxid; i++) {
>> +		op.u.pcpu_info.xen_cpuid = i;
>> +		ret = HYPERVISOR_platform_op(&op);
>> +		if (ret)
>> +			continue;
>> +		if (op.u.pcpu_info.acpi_id == acpi_id)
>> +			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
>> +	}
>> +
>> +	return false;
>> +}
> My compiler (Default GCC on Fedora 32, compiling for Qubes) complain 
> loudly that the below was missing.
> 
> +}
> +EXPORT_SYMBOL(xen_processor_present);
> 
> `ERROR: MODPOST xen_processor_present 
> [drivers/xen/xen-acpi-processor.ko] undefined!`
> 
> Same thing with xen_sanitize_pdc in the next patch.
> 
> +}
> +EXPORT_SYMBOL(xen_sanitize_pdc);
> 
> Everything compiled fine after those changes.

Except that you may not export __init symbols. The section mismatch checker
should actually complain about that.

Jan
