Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9476C7328D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbjFPH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508C170E;
        Fri, 16 Jun 2023 00:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7SADbqHtd8h6/LKgXWbx7Pyi9XCyeOVHSzSG3RhpLJAgHf0ngiBABUWWMNXoso8xxzgev4fZjj+CczdU7bPWYIdhjxxyzqwW8ob20EjjZ+xaYPoc5+R8EHDLLhBpINCb151PcpvnVFFPJj1ahctkoXzeMkLsb+7FordMs7syyD+4tSk8b8ZzFr87gEohe9JH5piDyOmqH1wqYrTrsCxVQrGh2D3FgHXCZawVitUfdApbIOWyH5zJhZb42G61Fnsc3GhUZk+htdusGEgV9Yc87ObWnWuxk4jtaKWqeybBVvev0IXAOVVn/muB8wazLpRURFNxJW/zvBgEyHMdqsbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+ckomhIUlsz8l6xurXJ+ixBnjy7b9f4Ax87jLvzQ8o=;
 b=E9fehLgrAr0nEAcJF5bA36FwLXDWKXYqd2ak/ID1l7ryl+3RgZkjvuHzOU1Tbavg4HOvGtDW0lYzE1eOK4rxICDbs5YLCLxLDNV7jJCRYXdULjS9Z7aKZ5DLfzOstc+CnCrtLVqOTxAkRU+sKNDzyY6PvS4icEgDYyO1ClBJVzub1/KZSBbGaTEsM3wPVxOpQGg8BpmhW6s1Bcu4MVINDRQN45IbxqjFu6O5YqLQCPV8KewmDuyDDd4KD3sOUiih6WCunizqcsKzRiw7x88RFem/qwjGMeKGlA2N6QM7V8p9g2xgCjPWJb34Mw3R3wU7CmnegrH/aAHzQ8jLc1n5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+ckomhIUlsz8l6xurXJ+ixBnjy7b9f4Ax87jLvzQ8o=;
 b=1M7vPizZ+54u9DJk0xtDLZ+e2EBFHmzxBgkE2X5Y1LIE5F/8a/Q9H5CZ7YKgCIPDzhqRAEmaglWC+TfJ387Kt4G0qxVIYS/R7nf0x+1SCgLjdqexsc5YvPocB9ukGrUcy0sT2FyVwBxkakicqcIyJxQctka7ObQXOsjTcx6W18Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 07:28:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:28:57 +0000
Date:   Fri, 16 Jun 2023 15:28:33 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] cpupower: Add support for amd_pstate mode change
Message-ID: <ZIwPIeby2TD1drZE@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-6-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113615.205353-6-wyes.karny@amd.com>
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: e88ba3ed-9fcf-4355-79f7-08db6e3b58b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sddwj5bumkVYabsG4dyBdxHrdeWOpWvM376jLu19bxOQxrPp6PBBLE+x9jJBSdWiH2c5y4qk2tidW7PHUtRCmQELBjMonfcdN7UH0PzdW3Xl8iEfkS9yF3QehXV9uOGDrjd/B1PTMy7Tsvghb9To5vyHVLzmd8UjtcR1C0id1xJssYTFRYpOsNh1FR1PpWzo2WLodgnnvqDfUFrxWeY5MMf7WGplesIRQLS22HNiSJGGSbtHBAKbgcvOI9ZqwjNTaamg6j4MYOHslMYwfpVXWkSzsrtBoEnh75XFONkxFzdP5ptR92ineo2iTD3ao5esVjiJVrK0b6WE7kijC1Ur8Zw7nwWV6GpvvEz1IIDBzrCf3LzMv8U+g2EpATbcEq55onFGvE1uw7jp8O3wWTu6bbXpX/qWNzUX3otUZxFODH+O71M+OWzC3EixZoy9ZL8xt84NRiqrBgozp4bUZ5/vpRrqOhKxwh7DTHbg1ImK0+wBBkIVoFhm5KDqOEMzMQNj9TEPYd1QxzBalJwCdHIyHNG3StEDCs0WZM471fDUb5vCm8aPFYi8fr+h4AIXqBd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(38100700002)(6506007)(26005)(6512007)(8676002)(2906002)(6862004)(83380400001)(5660300002)(86362001)(8936002)(186003)(6666004)(6486002)(2616005)(36756003)(37006003)(54906003)(66476007)(4326008)(6636002)(66556008)(316002)(41300700001)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwYhZNZ9cJxU0mtlbpprzsz8HUifbwkwSkJs4MD80LpeIEZf2OFHfmFvNdq1?=
 =?us-ascii?Q?ei+RD+UHffmbDzoKXdKIkRas7d3hbC7nJ2zd/GghlFOOdOv/4fRspPbaD7U1?=
 =?us-ascii?Q?/fvRuRVfcT7ZgBcfiy7m58K+XR27PczvI4cIDaC01XsHt4K5/pf6Se4DuEaW?=
 =?us-ascii?Q?FSGX28f6bPLnj1/KdPwxxtkSrOV0dzF1iF4dWF/NXiFc3SPJuHwDoxYlzPuN?=
 =?us-ascii?Q?Y4Df0Uog6Unu7b3HJ2LkmzLHfHV2BML7LxhbtD945xzg164yWi7W8b1+P9d6?=
 =?us-ascii?Q?0HkIlHdtZawu4U+LI8OJwzsgivLJSwM3WAD76rrYdNZj2pqIynEHjbEdvFr8?=
 =?us-ascii?Q?Fj/15JUbhoNV3p4inf9WNDAxPcctvLFXd1KwfZnT+fwQhtyNBuEyk4ZYhXBL?=
 =?us-ascii?Q?LZzG57qHXoUprFkDUHZ2K6vLzuSGtxseN2i36lax48KrVZb6dOSwiQJA1l75?=
 =?us-ascii?Q?vuHk2JR1GRFyMmUW812USQ61fXMYRgW+lB8OLuupx6bMwRPxdS32BG4EQu+g?=
 =?us-ascii?Q?4fQwbb4UAWkcjpQ1OP9Ji9LItzDgJ3Pg6gs9ePWJBVu7YKUAJ8I+Cfx8DavZ?=
 =?us-ascii?Q?jFeX76PAaPHijamsuJkXfIUQhg1ejB6znrDcP9sWqmbREpbkuLbVggXdfBiH?=
 =?us-ascii?Q?MKtX1iMT+1lhUqYg8kq8eI2voqSU1tPKKZHRTKPpcTPFwJKoECyB6jk5sTny?=
 =?us-ascii?Q?QdThuGTi4WeXol6STpbhPywSFPniSttRz2TSTLzuq3lJ/zTtdNS1PFehlAdn?=
 =?us-ascii?Q?4fKGtF3KA5t57+hegBnRHytoisCL5TdxouYBwWZir6xP4pmnJNdqhE4mjXxY?=
 =?us-ascii?Q?hpdzFs9XYpP+RDzqnboQcDomk9PKjiipc7C7UwpqzFBb9VrlvggDm/TzLoSH?=
 =?us-ascii?Q?jHDCyPKlhn+rRRfVaO741Jw37H9SNnNx39Wdl9Xle2VgfOwLlhevZT/AzRfT?=
 =?us-ascii?Q?JsKM8PRyQPFqJI2zQRKb+xaMWVlpRPCl3rnal0AjUFKEX7n6PURoXS1CDOuI?=
 =?us-ascii?Q?IYiKjDZ7Ruup2c0+G3o3L34lVbWx036zIdfz9gCQY4IdNavhAmLDCK7KqbqA?=
 =?us-ascii?Q?oBP7dKP//jR1kfGsq6TNxiK8RXbKo/sMKG3CUpsunrQX6KqGSLLPud6j85tx?=
 =?us-ascii?Q?kXqUQqD67sLR2is8pFwxyeXQL7B6UteIZJ2wYQ8ryOp+lvXnMPRGeZmjV7tx?=
 =?us-ascii?Q?CIuDnbfUESZ87zQ9fn++It26iMrw+h37FS4nYC39qk4ehKqMY4wioBx7xTcx?=
 =?us-ascii?Q?Od/ZtvAHopZJKc9BY7dvZN53hPQNV9blTAqY160GX7GjY4jzmsfopU4BIbXI?=
 =?us-ascii?Q?6IReB0K44Bsl0We3zGSpdjtoPO5pHRpEghtSVeyom/hiSJlse50eaBKb0yfd?=
 =?us-ascii?Q?pq61SMB6Tx+LlNV7Xy9uoWtP10g4Bgng2A7chjTS/p4oCaQ4x8IPGqFlxsIT?=
 =?us-ascii?Q?JIkdVGSFKLZ8H3n1+ETDZPYceex9vmX2a0jRd/G8pWAqa6Rp1VdZ5+X10Dep?=
 =?us-ascii?Q?3W5gUioo8UP34XnDmZhZAxQBdrFXIHl3D0/zE0cRmCJypDwYNKa4SjBDgCML?=
 =?us-ascii?Q?jEklKjGnvkYoa9H0sy7YKokEfBPdIblgPkUmawQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88ba3ed-9fcf-4355-79f7-08db6e3b58b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:28:57.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubKn0tlmlMfROEuqV2lxtQUj/YITZ9/qUnfMa8SSNG4dD9/RoO58uVuBT9SpA5WMJ+AqjVdOunHaH1xtr3SD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:36:14PM +0800, Karny, Wyes wrote:
> amd_pstate supports changing of its mode dynamically via `status` sysfs
> file. Add the same capability in cpupower. To change the mode to active
> mode use below command:
> 
> cpupower set --amd-pstate-mode active
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 24 ++++++++++++++++++--
>  tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>  tools/power/cpupower/utils/helpers/misc.c    | 18 +++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index a789b123dbd4..c2ba69b7ea54 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -19,6 +19,7 @@
>  static struct option set_opts[] = {
>  	{"perf-bias", required_argument, NULL, 'b'},
>  	{"epp", required_argument, NULL, 'e'},
> +	{"amd-pstate-mode", required_argument, NULL, 'm'},
>  	{ },
>  };
>  
> @@ -39,12 +40,13 @@ int cmd_set(int argc, char **argv)
>  		struct {
>  			int perf_bias:1;
>  			int epp:1;
> +			int mode:1;
>  		};
>  		int params;
>  	} params;
>  	int perf_bias = 0;
>  	int ret = 0;
> -	char epp[30];
> +	char epp[30], mode[20];
>  
>  	ret = uname(&uts);
>  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> @@ -58,7 +60,7 @@ int cmd_set(int argc, char **argv)
>  
>  	params.params = 0;
>  	/* parameter parsing */
> -	while ((ret = getopt_long(argc, argv, "b:e:",
> +	while ((ret = getopt_long(argc, argv, "b:e:m:",
>  						set_opts, NULL)) != -1) {
>  		switch (ret) {
>  		case 'b':
> @@ -81,6 +83,17 @@ int cmd_set(int argc, char **argv)
>  			}
>  			params.epp = 1;
>  			break;
> +		case 'm':
> +			if (cpupower_cpu_info.vendor != X86_VENDOR_AMD)
> +				print_wrong_arg_exit();
> +			if (params.mode)
> +				print_wrong_arg_exit();
> +			if (sscanf(optarg, "%19s", mode) != 1) {
> +				print_wrong_arg_exit();
> +				return -EINVAL;
> +			}
> +			params.mode = 1;
> +			break;
>  		default:
>  			print_wrong_arg_exit();
>  		}
> @@ -89,6 +102,12 @@ int cmd_set(int argc, char **argv)
>  	if (!params.params)
>  		print_wrong_arg_exit();
>  
> +	if (params.mode) {
> +		ret = cpupower_set_amd_pstate_mode(mode);
> +		if (ret)
> +			fprintf(stderr, "Error setting mode\n");
> +	}
> +
>  	/* Default is: set all CPUs */
>  	if (bitmask_isallclear(cpus_chosen))
>  		bitmask_setall(cpus_chosen);
> @@ -123,6 +142,7 @@ int cmd_set(int argc, char **argv)
>  				break;
>  			}
>  		}
> +
>  	}
>  	return ret;
>  }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index 5d998de2d291..d35596631eef 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -117,6 +117,7 @@ extern int cpupower_intel_get_perf_bias(unsigned int cpu);
>  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>  
>  extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +extern int cpupower_set_amd_pstate_mode(char *mode);
>  
>  /* Read/Write msr ****************************/
>  
> @@ -177,6 +178,8 @@ static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>  
>  static inline int cpupower_set_epp(unsigned int cpu, char *epp)
>  { return -1; };
> +static inline int cpupower_set_amd_pstate_mode(char *mode)
> +{ return -1; };
>  
>  /* Read/Write msr ****************************/
>  
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 63c3f26ef874..9df9af8a969e 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -106,6 +106,24 @@ int cpupower_set_epp(unsigned int cpu, char *epp)
>  	return 0;
>  }
>  
> +int cpupower_set_amd_pstate_mode(char *mode)
> +{
> +	char path[SYSFS_PATH_MAX];
> +	char linebuf[20] = {};
> +
> +	snprintf(path, sizeof(path), PATH_TO_CPU "amd_pstate/status");
> +
> +	if (!is_valid_path(path))
> +		return -1;
> +
> +	snprintf(linebuf, sizeof(linebuf), "%s\n", mode);
> +
> +	if (cpupower_write_sysfs(path, linebuf, 20) <= 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  bool cpupower_amd_pstate_enabled(void)
>  {
>  	char *driver = cpufreq_get_driver(0);
> -- 
> 2.34.1
> 
