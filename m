Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7462D22D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiKQENb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKQEN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:13:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395628E;
        Wed, 16 Nov 2022 20:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGaaV89UpvQVUJ0R0TDT2PwhEeGfQmMPGYAMLoRMuZsVdcz1du7fuSsxWc8cJOPDWRxgjULy+KIELxyMehinwgkkS6hnPFC07NgDFsOdWXHlqJynfMgstD/ID0RM5xMuNPderkHaHFJRckQWgr0FfMHLLhTtyb6JEObzL/HK9aQ/qhkLi5usRPIrt+YC6PFUmuMcozm0Cm6UZC9SCMYGJ1e0rA8v/ue32fuMNjwjgeurUSDWVGDwe+DMCvpDWOagjAd6iLK3IUpcuHz4+P4STsVHHbqSKz0jWjgL/1fpvM7HjtR4iV5dpuY60jIPnabL00akraoUvVHiJ1Dxkr1F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dut9rsRvx1XLcw0kBUCBvDiHnaMEgOZ2BRi1676ok5w=;
 b=CtoFo8pDjWl62D+pRWcKWAYOqFyExF1Lg4uPcKiqRka6yIy7r1di0n+RD5DC2Z9YcyWD7g8kEcDTYJXWCRqCHA1IM8MQzNv+2ezD+zWo7llxuCOxc7nxKEsBeXsRnmZIyWY66EatzjMwAzrfZLfl51yfB2G7IiKIQqaLYiWGzoTtZjby9SpJNUbTRySa+jPS0Eezdok0iT6Ycp39bjSsys3H08FhQjj0aLTc2RS7RLkBLHRUOTmczYCdCykFY+KW6XTjzLrs/f+SdeqqpBRSODwReqVe3i/O9IQ+UykWmqACusq8pJi1DhDEWFtsvFfltR4Dkciq8OjZ0hW5QYuQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dut9rsRvx1XLcw0kBUCBvDiHnaMEgOZ2BRi1676ok5w=;
 b=LUGdiTjHMiH6sRqCgRbC4xSB//TooC5fNe8+SyLLK7DIDbjvYBRMAdLHK7pTS+svUaDuUktojNHQI4/8mGbQJ61KJ/iaV1K6dKERbj9c5kgj1/CvYnZ/Z0/rIP3T2F6rwkorMvoG3FqkomrTnFWngJOikMXd2dJXTGfLibVinBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Thu, 17 Nov 2022 04:13:21 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b%2]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 04:13:21 +0000
Date:   Thu, 17 Nov 2022 09:43:10 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, ananth.narayan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: amd-pstate: add amd-pstate driver parameter
 for mode selection
Message-ID: <Y3W01rB1N9c9rXSL@BLR-5CG11610CF.amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-4-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117024955.3319484-4-Perry.Yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::23) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: b91a0230-1080-4d47-c830-08dac852103a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIjLqnKfsFr2AMbjENM1tTukhdxqpeFKkjarUhNGBCcQ2ICmJrKQpXRjXXX/mzf7PTYMqGV0iBta+QqwRnvu6AzjFJhPTSa9ENF0Rq76Mti49sLErUUETSR5tUeQSGXVYJlwCziNOrMU23fYZu+BK6/nrviObT5bG3uNskbPHrOckppP2uTUxsbvdG8NCBVWpGfUtmTpji+CoJDBXRSr5O4iV2S0x8Mc9N0R8u+X3IJp1V5+h9kwMxN5pAPQHO3SULUt9M5yLi+W0fEdfuhpyMnSXHD3VNFGxigSAsiKIoR/ASeGnsctlYeWad/98ujZ63O/B8s808+BWpR33Y6+uiaP8hnDUQPmkeVhOsX/KwmpmSnhAkE6xQ945jzP2gCU84eCJZwlkVw6GFGvMSs1XAS7q8n4R4xTg1LZ7e+tcR/3pTz3D/B93RqHyqrUEw0f8gl7KueluNaOdL50pE8nvlQQBxXsCTGnByMYRxpCIcb65FIJNeTcgf96tiBFsRPugBDvZevWBFshRdwiWMibuVffYsrQmY020RtTAVUxklnWuvJoP9rELQB1LDgZyUeRaGSlBccM5ojkFT//sw/zLuBPb1Qs03JXb7G5s8xWNvxgZNLEg1SeWcus40UXovKsRoOcICS/UbdhXD3BNtTb8nIYomN64/D0GttT6R9hZCdP4+B4BDdXcn0zp7QnldsIFisgUlZyRst2wKcMC3+XCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(86362001)(38100700002)(6666004)(6512007)(66946007)(26005)(6636002)(6506007)(316002)(66476007)(478600001)(2906002)(66556008)(83380400001)(6486002)(41300700001)(4326008)(8676002)(186003)(6862004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uo8xYknWXqFlQd2GIA7jVywoH6igdG9K+glJP8LCG6t8fisiKbpC7LX3lh6o?=
 =?us-ascii?Q?SVjkHPiExQddtMkRYi6TR6F/6z9CNUZuqqiboaFLQkcEJFGEnSt8PxpqN8wF?=
 =?us-ascii?Q?IHqLvOO23IU0yMRfKNL5JDAiqUSZxQfLrorAyM+ELmpwFYWExJLx71YZLYi1?=
 =?us-ascii?Q?jRwV4FiZQlV7XQqttYexgVoSvo8SELUDYMz+4kjG65xkgJw+a2lvxH1M0P1T?=
 =?us-ascii?Q?Ki7sSosdZqObA+npONbr7r7lwraPL3B7lTs9PcrmuMEVmhFY+nGmbcKiLFS1?=
 =?us-ascii?Q?ChzHNQcUm1Oz4rtWAPpVC3IAOz5/f2UxEJogMk67jD7y+vfAYswWY2NuNGs1?=
 =?us-ascii?Q?V06OLDuSjOSYGu5Ky/iyjsTvQhlAEi0uOsbSVbs9mSK5XQonedXIxhTL+UOu?=
 =?us-ascii?Q?aGgtA93AIrNaWaKp5TLcqre/pbb62hcaJ4QKe38qsgGP58Ee9IVq/971nuST?=
 =?us-ascii?Q?FUynz36ojevF/xn5THLW2sPAKHi5Dag4XdEgi5KTpA54hMfn96Ktu/TpP1r8?=
 =?us-ascii?Q?k09OxgurOjjab4fMf6xGY/7rDbM6MxbHP1irxgryxK+3tfFwdPh7bt12kH1i?=
 =?us-ascii?Q?fYg36EIIvdUeQhsQ5Jklm/naNKyji/g4pOhORnSkHHZDHCEj7XeAwSKzLiXs?=
 =?us-ascii?Q?Ie4S7lPCP2Rc+5RHJIlB2TLd24Rv+BDdizlHQLS1nBNep+iGuwdCE1ZSmCQ8?=
 =?us-ascii?Q?3TBUs/hQhRBRxIDCGMbamtBfcxu88I2NFQDLwLmCs0M0AIxuaToTaLC4Ss9m?=
 =?us-ascii?Q?T2UFclHyixggWl9+LPSXbKQ8AMwaRQRoFs+oLw2g+/LGTbg47MGHRTsE5Wk8?=
 =?us-ascii?Q?J2k6pl37/w2xDcPOLHK6ox1Jh5yKBo8KYojOdJKHv92ohmFVF3yez2giA7Le?=
 =?us-ascii?Q?6m2WxsqAIuXXkkA0RRDqA1Ib7hMPqH+KLftb502VFxWrpnwcFyp+1eSOQvnE?=
 =?us-ascii?Q?kcFPuTW9VZEnImjQmL0U/vFK9gYmUIJfXJBrcDbDoK+0BZZ2PsfjDQHzFM/Y?=
 =?us-ascii?Q?xLIrQ0jHDdo17B78jRpfv6HE6L7di1faGehjm/3CoXgkg22MwFTdTUYdHCWT?=
 =?us-ascii?Q?X7IrFVurhtkrQzjdgJP9DNBFOGYrSBAFSxzNFIuf+VPT9aTcsaWhz9mdzTiB?=
 =?us-ascii?Q?BgmTkmKV1uG8XNMurN50pHFYZAtfmNFPH00HNQw1ziZXx3TSTQzT9gL/M9Oe?=
 =?us-ascii?Q?ou015sa/AlaRiKBSWd+AJ31rJd2nTLMI+ubNyT6rceKNyrx5j4oDnEN78Ng3?=
 =?us-ascii?Q?rMN43tDhOM7UGR9P8pGqqRpZOvpBn55SRnDKIVBDJ4nXGrnpGmo5H+YcqZbd?=
 =?us-ascii?Q?FM+MFpZjSkU92S0qSJrjBtcYhNKsAgPVdFGNrFypuZb1CxFTnpAmZPLnhfAe?=
 =?us-ascii?Q?7WoabahFpH7PrZzrJabMEvncVMlHZVZevovpCh/Vsz0zUGJ3hvV5pOk+stj/?=
 =?us-ascii?Q?lDHVYcITJhVb+TxY6BmMbrP0+zmWSxk0K7Yt5Mov1v8ww8vls5wbCuD7fkdi?=
 =?us-ascii?Q?EWE1xV2ujoRwFF02Qnxd3lx7GDAy1uocJpSW68rsYKW0FZKufyU+3Ax9fNP3?=
 =?us-ascii?Q?AQlQ0FV16upoVDIBnACw9g1NGsfXlyo28RIRH4bM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91a0230-1080-4d47-c830-08dac852103a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 04:13:21.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exbHP83OmDqvTfjapDvj6FtnAhLRiYpgexHiGFrc3G1HOLJicN4/aMZw94eKgvHWXN+ppcRnUDSpXTbq+hMR0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:49:53AM +0800, Perry Yuan wrote:
> When the amd_pstate driver is built-in users still need a method to be
> able enable or disable it depending upon their circumstance.
> Add support for an early parameter to do this.
> 
> There is some performance degradation on a number of ASICs in the
> passive mode. This performance issue was originally discovered in
> shared memory systems but it has been proven that certain workloads
> on MSR systems also suffer performance issues.
> Set the amd-pstate driver as disabled by default to temporarily
> mitigate the performance problem.
> 
> 1) with `amd_pstate=disable`, pstate driver will be disabled to load at
> kernel booting.
> 
> 2) with `amd_pstate=passive`, pstate driver will be enabled and loaded as
> non-autonomous working mode supported in the low-level power management
> firmware.
> 
> 3) If neither parameter is specified, the driver will be disabled by
> default to avoid triggering performance regressions in certain ASICs
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 701f49d6d240..204e39006dda 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,12 +59,8 @@
>   * we disable it by default to go acpi-cpufreq on these processors and add a
>   * module parameter to be able to enable it manually for debugging.
>   */
> -static bool shared_mem = false;
> -module_param(shared_mem, bool, 0444);
> -MODULE_PARM_DESC(shared_mem,
> -		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> -
>  static struct cpufreq_driver amd_pstate_driver;
> +static int cppc_load __initdata;
>  
>  static inline int pstate_enable(bool enable)
>  {
> @@ -626,6 +622,15 @@ static int __init amd_pstate_init(void)
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
> +	/*
> +	 * by default the pstate driver is disabled to load
> +	 * enable the amd_pstate passive mode driver explicitly
> +	 * with amd_pstate=passive in kernel command line
> +	 */
> +	if (!cppc_load) {
> +		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
> +		return -ENODEV;
> +	}
>  
>  	if (!acpi_cpc_valid()) {
>  		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
> @@ -640,13 +645,11 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
>  		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> -	} else if (shared_mem) {
> +	} else {
> +		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
>  		static_call_update(amd_pstate_init_perf, cppc_init_perf);
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
> -	} else {
> -		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
> -		return -ENODEV;
>  	}
>  
>  	/* enable amd pstate feature */
> @@ -665,6 +668,21 @@ static int __init amd_pstate_init(void)
>  }
>  device_initcall(amd_pstate_init);
>  
> +static int __init amd_pstate_param(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "disable")) {
> +		cppc_load = 0;
> +		pr_info("driver is explicitly disabled\n");
> +	} else if (!strcmp(str, "passive"))
> +		cppc_load = 1;
> +
> +	return 0;
> +}
> +early_param("amd_pstate", amd_pstate_param);
> +
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
