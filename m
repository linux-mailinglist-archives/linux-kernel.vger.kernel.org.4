Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD6628C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiKNWqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiKNWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:46:14 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24218B37;
        Mon, 14 Nov 2022 14:46:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvAQiqgfm+T8oB7p+z6UaMPtWTJc5+ERvuWJux1LVQbS9fk1OOakDiIwNDfbFUYiFksaL7mRGKGmZNMKVYQ2xRaWzyYULyW0bRmaThc2Ur0VmzcZMAOPU9+FkQ2W+vMu5naxuIBb8SNDJf54f1sMvL2PcIsL8ujad/mODO/JmbvX8Dptz5q1L72nJXJPbyuF7pgoD6RcwxrN55f02I0G4o+e6CBidKeK7zJeMzbClH7P0Jjqwr6FtpNuiFq8rafrKhfVcMYxTrZMTFf9dENI6kaSOqbfiuiTqTu0y4Y8Ed8fhKLUVMit5qXxQndlN/fWZYBGuE0hrlJsVf0DVA5bCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uso129n2WusZA1Gpykn7NuukkfJ77/ftzXkXlO0rLvQ=;
 b=eCwZo8Uk+UwYY3JP5zeAKTSyj/V0U1+XB6mvBrVGN908K/BLN80Z9ni0IB0GWTZgCGcywJCkxyX8d/jjiFDei0gO15UJvKql3rjLy2Tjab5ckC8KdfD6ZQl0y/7rO/laALqg89YgArgvr5ArhWihyQ1A6TJsMbkbdU7drXAmavli6h3dbLDbqvxuD38/QfUfee9RfOwmDGe2139s8sGOHks80VFnxrC94NivX1T5ATpNQj0tCBW5H2kkOa5PSRZevYeQS8TUtWK80/YOvig5S2B9ZlJmRx3hmcpxi1cOn/aijINqRNxSyabhym1ieG6S1nCQ532GryKwTgZRpYtu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uso129n2WusZA1Gpykn7NuukkfJ77/ftzXkXlO0rLvQ=;
 b=mG7DXtPEb6NlgKIXV1ZZjeYkCq7jur6mQ8Ga3wf0EuRIiHZCaHxhXcJm2nPad6f1MoXAB7yXScVwIxKf1AHGvkPXeX6AEIHb63HH9GywK6Gb85MKf+GOHyPkqpIz4M8GepHsgl7Q30/OJgibVswl6xNJ/EYWxWR4JDiGOJfrm3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 22:46:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:46:06 +0000
Message-ID: <7cdf6256-d0be-0037-4ec1-405ad10f90fe@amd.com>
Date:   Mon, 14 Nov 2022 16:46:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 3/9] cpufreq: amd-pstate: change amd-pstate driver to
 be built-in type
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-4-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221110175847.3098728-4-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: d651e76b-cc39-458a-593d-08dac6920453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AIILpJ8iHIDJ3fD1fINeJmVrJpHizi5NRsKB4kw0Qd6daV6JHkqKuI4rgU4thRiPj6yj5Fq3HvhlscDuLZMbUZRgOsCBXx94TuLojCGLssYADn7+0c6lPTga2LgMvLwErjM9DazhokBA4JRjvCURMd/wCCzC7muLb/Y8mwz+jKbDMRUeuVd+HD7a+HvOYfKI5ef+BEBA+dM7DKC8kHDgNQ6/5x0e0fCf4lPcEc2ZqtPw0wAF6+ppSQcNiiSYDKBpU132b1A2OoSeloS4fkkTsr8PQh5CkW8jFclR9hR9eGbKaLns+LMMjC8S/x7c8lvIMMtRuv8jAz5Y42FSGCjwoieYMy0fTa79FPSlupJXJK71ZGXq6yG1Cpjiea/bGX9Il9FlmdAslPFixFSaqbpbIgFXK4GsrDB0mhSKzuJlDtTVstsDq5HI+B0Uq6CpHXbHi47Qv0LfjxBtI8s1B/nMcrmbnADsCZTf94JOJ7aEst4EcPhTPAgPUZ7ddIooInlakDh5jtKF4SdqP6KzsGJEMQ6fMt3Z0jSMxj2+4HDU6fXSAbVeykLwBWEzEGrFCklrrlq5B2kl9MVcLO4NJOtCu9PGG5HZVxbMqW27W73Pq6OxiA6S4Crr/dSiMMK4/EPRPfU7HKnvAmIgWz/10wzdjyWNK7IylK4PCh5Aro3TaAKffAD37prgIengn1X6PliSujUqidUfsUwBCRnICCIlhpMISMY4Uoa48XVmwzClJOHyEX5bb2OD3JD54kQkc2XcM8WRQ1rJlzuLGEIoccOmcManCl8XZrp6LrGpn7AvAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(38100700002)(31696002)(86362001)(6506007)(26005)(66476007)(6512007)(6666004)(2616005)(478600001)(186003)(4326008)(316002)(66556008)(8676002)(6486002)(66946007)(2906002)(5660300002)(41300700001)(83380400001)(53546011)(31686004)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RJMnRkUTZGaFB3TER6UDVzMDVIYjRZdmEyaE92dnJka3ZOV3hUVVlWa3VW?=
 =?utf-8?B?eDdqUmpXT04vODdyWE5sUnV3d2Z6RXJQMC9Uamt3NDJFdTROaGdaVWFuL0VV?=
 =?utf-8?B?QXdGWFFTNUNCaTFBcHVjMFBnVWE3aUZlWFhLK2F2Y3dEMzhObnNId1Fpbk1v?=
 =?utf-8?B?OEUvRjc5eHRzNjhNQWhpTmNpT01oMXJpL1hnN2NVL2FhV2pPeEd1NE9qb2w3?=
 =?utf-8?B?aFZsblBoWkIzN1RQVm1OdDRwemlmZCs0S2FaWEVpNGdZNndMWG52cnBxZmht?=
 =?utf-8?B?RU1LZzlHVEtmbUNKQVVOVEJsNGhqNkJsMHdSWFZmYTVjVkcxWXJRMTRUY0xC?=
 =?utf-8?B?KzNuU1pXbVRLK3YxMisxWXNJVUVvbkpDRWgvTFhKTHU3aFdxTUhGNkUrTE1s?=
 =?utf-8?B?VCsrSGNQNEptczNXRDJLNDBNT3k0TU01ZUFpMXFTUGdVTDF5RVJpRnV1ZXB1?=
 =?utf-8?B?dUdpTUtZMnZFZmJRUS94Rk92eENoaWtNRitqWHppSktPQVp3VU5GbFBlSDlr?=
 =?utf-8?B?VTg5QXByRzVVOGhzamVhZW9GNHk1YUt1Z2prRGNRbjlvbU4vTnVBS0ZCZFNO?=
 =?utf-8?B?R3VuVUt3eEJpNnQ5NWkxYzV4VVluUUdQNDRKdVpENy82djBoSlVJYmlGRnBJ?=
 =?utf-8?B?Y0RmbU1RaXdzcFVCaVB0eVN4djhKdXR4YXhLV05IbjU1MFNSRHZsNzVaSW5w?=
 =?utf-8?B?NzFKc2VKK1cvODc4N25KR3lIL3BCYzM4TlVRTkVMVThsbHBFdVA3Y3lac0Jo?=
 =?utf-8?B?TnVaTXU2NEdoQVRpb3pVR2xURW5kbVBXVjBFdGFHTXpJWFlIWGxrOG5XZDVJ?=
 =?utf-8?B?SzQzdEFKMUZXWWdDeHlTUlhuODFDUndvVUt4ZGVldndwZHJNVDF6ay9uck5G?=
 =?utf-8?B?a0ppUUFTc1hDWWNUU2hYZXhBbkk1cjVVS0dGaDkwZG9ZK0l1dnI2WkJLMFJE?=
 =?utf-8?B?Sk9MTC9kcUNoZFg2T1Jaby9Ia1BVS0k0L3RFalY0SGo2WjF3NXZjUzMvRnJE?=
 =?utf-8?B?ZFFkSDZ4M1dsSXdieHZMNjJldzdER0RkUEswQWtZci9Nc3BDdnpXVXFUamRT?=
 =?utf-8?B?TDdrWVNBZ21pUkEwQU9Bci9IU0gxUWFNNG5JTGNZbDc0MGkweEJ3ek5kWVB1?=
 =?utf-8?B?dWp2OXpDT013cWYzcmhFaFlXVkF4WFBsSTZKbThKRTRGQlNvbEZ0K2RCMGRM?=
 =?utf-8?B?MjFzVnlYUTlPSmY1K1Jta0FrVW1WT2xFYktOblQzOVEyMUxGV2F5b1pGQ091?=
 =?utf-8?B?SUk0UWx5amhCR0xvVUhuOGJoTVd5Ylg3SiswZERHQUF4RzJlelFBM1VIblp0?=
 =?utf-8?B?dEllcG5Hc1dGRDV5RDF0Q2xkUFRNWjFERE5IRVZLYTgrKzhXU2FNNE9nTU4v?=
 =?utf-8?B?NmI4Z1BwUkZYUnFJTTVnZTY2ZWg5RTZqNS9WKzZKZlJDM1IzYXQ3OHcwWEJ1?=
 =?utf-8?B?RkUxVVZaTnFKaHV3MG42NEtTeHo0LzgwaU5iSHRRcDVrUlZsNk13TzJRcnFT?=
 =?utf-8?B?dW5Ub3oySVZwcy95bFdGOFlpYkFQWmYybGc1VjRLRzJUQTQ2bmlVdWFxeWcx?=
 =?utf-8?B?UVA4RVNPRDZUT0ZhYmFYTy9CTytCMklmSlNYRXV4bFpTNXVyS3VJa09XNVZU?=
 =?utf-8?B?bndaQnZ1UDVYZWNQUEVicHhmNE0zZ2tQdTZCSTk4REVPU1pnMVVuZitzWUVR?=
 =?utf-8?B?YW5VSzFkc1BxNXIxN1Nud1FkeVg1a0tuRW5iWk4vTW9ESC9xdENzVG9PS1BV?=
 =?utf-8?B?Q2hkNnpCR3pEN0lQTEsvVHkwWW0zcVNMMDhqUjlWczRBc0h4bjkxR21GeHFz?=
 =?utf-8?B?VC84TVZrMDZXUDRBSlRvWVRuWktBUVlUYXBWUVlxWUtoaHYyeGR3amNyQ1lI?=
 =?utf-8?B?UVZ3NGhOTHdncGFTalN4Y0pnN3B3QlcxTDB0SjljcmdsWndzekN3TStnVExk?=
 =?utf-8?B?OVUxVUxYWmptTTZWblFwY3JhcEIvMDVFZzAwNFk4RmFKWjM5MDdjcEhKTjRX?=
 =?utf-8?B?d2doYkZxSlJ1bGtxSHZjbWUvNDlWaWdqYkVKbDlKaWxHWXdMTm1rSnJqY2F6?=
 =?utf-8?B?Q0NvOWpaTWJJQjFnZStNZG1DbksxV0k1akJXT3p6dWFQTlFHMVZCcnppNTNB?=
 =?utf-8?Q?bgeOcFAXy743XtbxgCHatGL54?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d651e76b-cc39-458a-593d-08dac6920453
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:46:06.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKXg3bciPSDAw3o+WP/49uSAL86xWDNtmq6Tu+JVI7D7Nm9sFW9PI60Epka5xH118UbYncYg/k5btVq8gZswtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11:58, Perry Yuan wrote:
> Change the `amd-pstate` driver as the built-in type which can help to
> load the driver before the acpi_cpufreq driver as the default pstate
> driver for the AMD processors.
> 
> for the processors do not have the dedicated MSR functions, add
> `amd-pstate=legacy_cppc` to grub which enable shared memory interface
> to communicate with cppc_acpi module to control pstate hints.

Did you sync with Wyes already as I had suggested?  Was this the outcome?

I was a bit surprised to see this still as legacy_cppc when reviewing v4.

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86  |  2 +-
>   drivers/cpufreq/amd-pstate.c | 25 +++++++++++++++----------
>   2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 310779b07daf..00476e94db90 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -35,7 +35,7 @@ config X86_PCC_CPUFREQ
>   	  If in doubt, say N.
>   
>   config X86_AMD_PSTATE
> -	tristate "AMD Processor P-State driver"
> +	bool "AMD Processor P-State driver"
>   	depends on X86 && ACPI
>   	select ACPI_PROCESSOR
>   	select ACPI_CPPC_LIB if X86_64
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ace7d50cf2ac..85a0b3fb56c2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,10 +59,7 @@
>    * we disable it by default to go acpi-cpufreq on these processors and add a
>    * module parameter to be able to enable it manually for debugging.
>    */
> -static bool shared_mem = false;
> -module_param(shared_mem, bool, 0444);
> -MODULE_PARM_DESC(shared_mem,
> -		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> +static bool shared_mem __read_mostly;
>   
>   static struct cpufreq_driver amd_pstate_driver;
>   
> @@ -653,16 +650,24 @@ static int __init amd_pstate_init(void)
>   
>   	return ret;
>   }
> +device_initcall(amd_pstate_init);
>   
> -static void __exit amd_pstate_exit(void)
> +static int __init amd_pstate_param(char *str)
>   {
> -	cpufreq_unregister_driver(&amd_pstate_driver);
> +	if (!str)
> +		return -EINVAL;
>   
> -	amd_pstate_enable(false);
> -}
> +	/*
> +	 * support shared memory type CPPC which has no MSR function.
> +	 * enable amd-pstate on processors with shared memory solution
> +	 * (amd-pstate=legacy_cppc enabled), it is disabled by default.
> +	 */
> +	if (!strcmp(str, "legacy_cppc"))
> +		shared_mem = true;
>   
> -module_init(amd_pstate_init);
> -module_exit(amd_pstate_exit);
> +	return 0;
> +}
> +early_param("amd-pstate", amd_pstate_param);

Documentation/kernel-parameters.txt needs to be updated for this early 
parameter support.

>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

