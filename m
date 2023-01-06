Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A065FAE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAFFWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFFWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:22:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B366ADAF;
        Thu,  5 Jan 2023 21:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVD5GYTiirdmMlII4esI4J9QyDNTpIRdNfpAzDzICINa2/ZoD5hlFEwsWVuD+mgQDuEjHFCwJpoIs+BJdnKI4LIztAOsr6xNSqcQGCOI3drKzRynQewzvoWdqTuVRgNCB0SIWrlGAUqN2Iz8ZZhU+UQYAD1skWiPQIzkfM86N/4Kmew5RFXtUmxGV5lQPVqUKl8BTaRyD7xzQiR0rS6K93hwSKVI5asVpJT5B3juOkKqx0eZ/RSCszyR57G1kWEVQ9OAOacpRdBrfFb2+0zbmoZwABImxkIk7Y3ZDo52UU7HvgjgA3c7RLE+kvlwuNcy1LmaPLIZOCvO2Lh2yQBHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0avr6Jwj5Ot7SXOe1bQuwAHWAH/sXelLWRbVenbAXI=;
 b=l6tPxB8H+KccySztWXlfyQT441xn1N5AP8F5PowJB0JS4Yc5za7s3L1SoD+NDVegO/cwo+GnIR+P3yKCHiO2YDUbO3bzOINZUA6JOvqtfcd6+gfY+6uqozwvrjwGdIoJ8IAJqge5bQgYOHTn/QbBm6n0ObbYexZ8+zm7NHRRzKwYWgOrItOjFlQtAbuWU7B90xyAUNDzkgtf/sqcRHhTQw18NnOfBMRtiGslddqQZPslfY6K7mUg83FpvwlZcz1wHXnsLdYhWIeZaEI5D/wEbMg6/a/WglxzzufDvOR1Y2EluKAhn+o2DQsYVUByNMKJ1c2lrR/DpW/byURvJoB6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0avr6Jwj5Ot7SXOe1bQuwAHWAH/sXelLWRbVenbAXI=;
 b=loNc/dmxkPSaUAX9Xy2IBDhabiGmeew+8GOnMJvtxLraQitiJIp1stxMaHIUk/peAzXySFhZR/Q99uQaLz1CkEygseBQ6lIRzNvzdgVRV9AZwP0TClB5YmeMCpJ50/uzJ8OOST3FUOzkaQkbwqDtRUam960ORSCK+eavP6v9XTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 05:22:33 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 05:22:33 +0000
Message-ID: <c8e15651-d4d3-bdb1-f9d3-b5efb93fcd5b@amd.com>
Date:   Fri, 6 Jan 2023 10:52:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-7-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221225163442.2205660-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: a056360b-b671-4c84-9be2-08daefa60367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exrhCGviWsEsIqrnWot+he/Sjizr4OBP/tzQRxPBr3HCrY5eTh/xw0D0nz3xrYDXxmYH1UMvhFDWwcd1itSB4l0szhnf/1U74n7PZSC8WBq/PAXfLoZ7j1kMni48xeirV5Q1GDfWCmbc3uvBK0Cq5wXawLwaqm71yeTvYkImBkgYuFXgm5zoqx8aMy87HQocyJxMzOEn6l8vGbBo50fEBynQLL0NLCY3vAUey7sojw9lDQXmlOvl/BnZKAhQ877YoWY6bEHp+i/lTxa7zYggkxZWf4fiWwvqQILYp7idr+t/rrrB4z3IFu4hypJ8ONAjtBhRG0q7jw4K40G3ngbytTL5s2YSsMNJ+Kb90cvXJqVeth078WGF6fiJ141CibikcKBfbgibAv9LX829iyZp9RRYTPBQDXlrtF+Kx9j6zeYf4k4L5197WHhHSMQX7DGGcPz/BrdlSNFPFprDEtgU0APzWZo/p11vnvm8Svww6WIcQV1ulpqg6KSDGu7dqUgUCggBZMa/igh/F03UmAwYDl/OfH/usAJ7OxP59ML8jRd4dTdlfnCWs2rQ5/GX/vyPhe1ETKeMbKv0Nv67joXbKLEDLrLjD/sMjYkw+PeDvelrynt2GSZGfn1757IrvEaSFt1M5Emqd7JS434RoCXC+IRqcYugakv5KnrckSKk9UGu7YtpebRy2NCBqnE3Dpw9ahIV2VgGg+KeW5X59L7Lf7hbXj9Uu7pnmTUeXiFUjpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(31686004)(36756003)(86362001)(8936002)(8676002)(66476007)(66556008)(66946007)(4326008)(44832011)(2906002)(38100700002)(31696002)(83380400001)(5660300002)(478600001)(316002)(6486002)(41300700001)(53546011)(2616005)(26005)(186003)(6512007)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1hnOWJyVEVGTWRUQllhK1hhYkpRVnBKUWZPQmtyVnJiYUllNlVoWlk5amVz?=
 =?utf-8?B?SXM4VTlyb201aWltNnV6WmxQanhIeWRCbzNjbitFQ1lnVmQxUHNQOUJ5NE44?=
 =?utf-8?B?SGpyMDZQWkRHZWNRdy9BYkdDZVBoTUpndnZHWkN0dDN0cElvVFgzalZzcGtl?=
 =?utf-8?B?YUNGTnU2SkZsQzJSSDJMQWRsdGFMODdQTFExc2hwcm4ySmVZdGN1bUV1Qk9Q?=
 =?utf-8?B?TVl6a0Z5UldPb1E5N2M4YjBIeFRUNTgvRE4zS2pTVkZnUzRzK0NLV29IYkh5?=
 =?utf-8?B?OS81Rm9LQVlBekpXbWtGRHo2WGV5N1NCS2VzQXNNcGRJMTZXUHlzOVN0S05R?=
 =?utf-8?B?dmJPcm9TNjcvZFlPSGlXWE9qdXVhM3pSMXZ0emFJVmUraGgzK0ppeE5jckhv?=
 =?utf-8?B?aHNWZGtqTGJGVnFUbnYwc01xVG14WDhKMjdVL0tsS1FDN0toTm10QUg5dkxO?=
 =?utf-8?B?ZDArNUVUR09Ua2NBWFlOUFZNY3U5VStrZHVxT2VBUWhPSmRFSkxERXl2THFB?=
 =?utf-8?B?QWR5U1UrNUk3dEF4SHBjU3hURURSQU9GZGdVM0JlYmtZMzZ2YXRBZzJMODNq?=
 =?utf-8?B?L2oyYmx4OFhCQ3RYTUxjUWxSbE95QzRWeHAyaUlReUtBSlA0WmgybmY4L2tB?=
 =?utf-8?B?TFg3bjlUbEZGb2srdzJHSVBOaVBPSDRjSnpOZFcxajAwZXFCRWR4ODFDVTh6?=
 =?utf-8?B?WkJSOEdIQUw0TThkQno5dFJZcFhWbHZxejZ2MXBJak5LakNYaC8wb0FMeVZM?=
 =?utf-8?B?ajZuSVpjbjVFcjN1eHE3dVJIRG9oOXBvMVpUQldHb2YraTVsSEo3MWtsUXQ5?=
 =?utf-8?B?WHdhcXkvOGpQL1hnbjFaRk00SjJGMHQ5bGF5VklESkVxMC9IV0FxVHl3ZXE3?=
 =?utf-8?B?THczckdHRCsrUnIxR2JIbktlemU4c1dObDRBYmxiNk5oVmFWcUdZdG1hV1Fi?=
 =?utf-8?B?bUJ2WlhNaWpkKzdEazNLZFI5VjNmemRRcXZQWEVyeWs3enJHOFdocis1WTJK?=
 =?utf-8?B?MmxVcnI5emZ0aDE0YjZaWnVWM2diM1JBc3lvazNSU1VjdXR0YytVQnpaRU9M?=
 =?utf-8?B?b1ZrUmZHMGNzUGwyVVhKMGhBd1FzN29jL2p2eFFrMmozTVA1OFFwcXpiVVlT?=
 =?utf-8?B?ekxTQTdQbzRaWkxjeEgvNnIrdHdTSlpGREVrMEVxUE1DUkRJUG51RjVwbS93?=
 =?utf-8?B?VC8vMVZLMEhhYTd0eVVwblpoQjVVYVFHOGd3dlBOeVhQTUVqOTJzU0xjQUV4?=
 =?utf-8?B?bjgzeUd0ODVmK0hHK3hnWlo2cE5FdCttRnhIaWFpR1RQTHdXaFhyUVFQZm1D?=
 =?utf-8?B?ai83NW82Rjh4emsvTkw3NmV1aCtJb2xRcnE4a0RMZ1VsMkJvWDRQUWZtMnlZ?=
 =?utf-8?B?cEFXTUdoZ1Y5Q1BCTFQ4Z0xoOHA3cEN5WndQdGt0aGFLWXdoMi9RU01QZktJ?=
 =?utf-8?B?NUl3NFh2MWRzVFIvdVJIeUUzYnNpRXdFUnZEN1JEdlM3ZmpMZW1pcjV6dVdH?=
 =?utf-8?B?bVFJTEpJbVlGYzFxdEdnU3VlY2ZxR0NQMUdSNzRybFExdVEvWkk1YVNkSWdW?=
 =?utf-8?B?UzFFeDc0TWVGRnhkYkdJbkluWTNJaUZMTm5paU9EL3hRTnFjL1ZZQzdMcXB2?=
 =?utf-8?B?V0RaQktQYURsQk12RGVEVVRpTjI0RE1Pa1ZsaVBoZ0ZWdHpJZ2taL0lXYjVJ?=
 =?utf-8?B?TDJ1RUpFMzYyQkVzR2dPcFZ5WFBkeDlpbWUzdnRLQlhrOHhYVTJSR2VvSDVG?=
 =?utf-8?B?THFLNnA4SWYrZ1c4MTl5b0E4cHExUW9rUk5tODcwV2xrMDhUMUhNTTU3ZTBh?=
 =?utf-8?B?QWJTR2J3TjdXZVRSVTJITG16WFhuVWpJNndDSWVtM1lQK2pmSkMzV0pvcjYx?=
 =?utf-8?B?UUpPYjh0WHJoaGNFVGM5K2ZyQmg5RDFpWGNWdDZrUUkvd3c3NC9RT2NRV3B6?=
 =?utf-8?B?UVRhcGRPQ1ZCWTcxaXBuaFZ1UlpJZjZhWlRpNGp3TmlDOWg5OWZlTytDTkpE?=
 =?utf-8?B?U1Z0cmd4dTlmNHJvYmFtNlhhVnZNVnllWU1ia1hZMkJBbk1ja1ZXK0p1MVQ3?=
 =?utf-8?B?WFRjRW1obmpYRzMxVExPME1WWFdESGQzdzcwWSt6V3RwOE9CeUhkT2FESlFB?=
 =?utf-8?Q?iWw/xrbRJx9CHfzosd353inYI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a056360b-b671-4c84-9be2-08daefa60367
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 05:22:33.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bL7k6DXRhNFXh/mkGKSnrPLaPl9ZzLoyomQ0f3YFAkRSoSqbKdC9tx8UBHiBdtqI+a8OXaWf4E69+dDG2ALog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 12/25/2022 10:04 PM, Perry Yuan wrote:
----------------------------------->8-------------------------------
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.name		= "amd_pstate_epp",

Small nit, amd_pstate_driver name is "amd-pstate", whereas here for
amd_pstate_epp_driver name "amd_pstate_epp" is used.
Should amd_pstate_driver renamed "amd_pstate"?

> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
>  	int ret;
> @@ -656,7 +1012,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -667,14 +1024,13 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>  
>  	return ret;
>  }
> @@ -696,6 +1052,12 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_DISABLE)
>  			pr_info("driver is explicitly disabled\n");
>  
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver = &amd_pstate_driver;
> +
>  		return 0;
>  	}
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index dae2ce0f6735..8341a2a2948a 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>  };
>  
>  /*

-- 
Thanks & Regards,
Wyes
