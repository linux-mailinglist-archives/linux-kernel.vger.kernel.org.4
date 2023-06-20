Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA66736C96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFTNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjFTNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:00:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3E1709;
        Tue, 20 Jun 2023 06:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHk2CNtKCwtOc9KVb7HPp4jz0BnTuwHqJnqT+QZCu9Khi+ewbtIA+FNivx7trxb0tOgvdZ8CDxV4ibuYQgjHEFa+q+nIqyDXhvZbksguVDwkJfmKcEMwSGO2GIWlfWTmxBux3GOLGjdhiMzjCO/8s8CrO/CsPCbBEr68xCPRuidGeQ7PQAyeQ+K9nGgJLqltdgdKj+yRcS2fNR5V5pA7QlQWuxj27o5VrifBd/3CDjSZPNgWxfllS6bAc90qai47/9StMmGvUXADkElcmIVXGJ9etSWwUEwpV1XTEMejpDfnP996IXNxa3+X9i5x4KRtUaS5mOTKh+5vYmjxK+XVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57zuvfUMzhvSxkHTTah9vwk9okajEuen/GC2Iv0sT0E=;
 b=NMgK9DgR0aQVTkrzCvlK7PVs9ADvY1MykH4Eu/xF+tnLhUnS7okf98nfT1e8mrX5Ud7PFjCVgJ4lvTEcmWvt33T+GwcMM5/10tGlPdN260nl00LXi/U+bovXUEqTl2zn28Z5ncmJ5MhPqJj6XAOyGORurDOx+7LK+NddFMm2A1mltj3EE7PBmHnpPX3/cseXF3F94/WlpveM8RNgikWxrRx5CK2RJ5Y238B8E/YfQghrFCiGqP/ZAKHGsArizAKdojZDf2iKqWcYmBG5boAxEScwZyT4jtxSdd4t18jydVj+6TuXfwCvOsetpE1oGjguFBzviFPbZyVR/rKARKCDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57zuvfUMzhvSxkHTTah9vwk9okajEuen/GC2Iv0sT0E=;
 b=pHU9ZWxv4AJKEFdKfe5TN2H8I+A1O0ruLTQKUrcC+SQ52EgBrjG3j0YarjLeDTOIebaP2TzpkjR302ceQZ5eJ/xK5Lt1+LseKNyNXTTKyzmuw9AupyZqhHfY8Bph/PzaA2m8yupiNJVKTJwBdZMqBE0yqOdSx+yFCCaF9VyRPP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 13:00:07 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:00:07 +0000
Date:   Tue, 20 Jun 2023 20:59:46 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH v3 3/5] cpupower: Add EPP value change support
Message-ID: <ZJGiwuubwS3O2oGr@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-4-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619190503.4061-4-wyes.karny@amd.com>
X-ClientProxiedBy: TYCP286CA0339.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5920c3-a06d-4ae4-9cdd-08db718e45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWexwL+7OvNNeh2ALbZznZZdaK4Tf2IDfZvQVM7CxkEAcyxK87SQOzOORmPHKzdgio00hcOM4r+izpzF5VctsXNe6b4Ep45s6jFc+SCivxw9DqK/BE2vAdJYqY5MRpweJTSR1h/G9MMyW9BZC2T3RddUf08ghS3IQpxr/3BQmFURff9LkaqdrikAryOe2ENQ4+fX9xaKGushugjSwkhsrC0Wqg7TH0U6gmPakZDvEHkab1ht/resAAsguJx2I2U3oJ/KGUtR34VOzNQSKZf936/ZW+fzD1JkNu8ArIEDoVmPIfcwTG7qd7/nliFu7j77LRoUQPqNUjudJ2EpIvaS9uwb1AdJgaAUJMlpIpHgIbukawh/SIhXk+IxZJiQSgnNUAjhmraooyrJzeCSMzE7C10PFQ3QNsF4iVbBHLqLnTnwdOc2xy4aks59XUtq37U2jD6F9wU4Kkc5VC8PNCVJxadcFNc+b83+8NZvvFpQppJO7J0eRoT2hpa7GCzQw8OOUnYPTWlg8xYAJ5VjQgtqDKyzZmTkeoZMxNet865dtW1n7MyWb3R4Sh6Qrwo56KOQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(6512007)(186003)(6506007)(2616005)(26005)(6486002)(36756003)(6666004)(478600001)(83380400001)(54906003)(37006003)(66476007)(66556008)(66946007)(4326008)(6636002)(38100700002)(316002)(41300700001)(8676002)(8936002)(6862004)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtbHM2dejuJD3+xdnzyPOAPjVwri426BLermuTa24Qod3Tzb+/EgDfcClUol?=
 =?us-ascii?Q?rAI/Vdv5EUKorAjGE01OhjGc6tPPs1ph35ybld9pnfhoaE49HtFyfyXmVUFT?=
 =?us-ascii?Q?mgQ1hNet4DoBI+IVd0cEgA9kKLI4FYmSfu2sjRLIKWFtOC87BdE6zslf66ch?=
 =?us-ascii?Q?vdeeR4UJ2iIkhbapTY5dhphKdZLRSqfa/qwKL1aIGOlns+Izz1Os4w9EpAPx?=
 =?us-ascii?Q?KWq/3XLOwmB+9j6ECT8rVXOjhMZFEzFGXuZMW1GuEWSY0B6zvm9GqNh4i+b0?=
 =?us-ascii?Q?jwVzehmEG9BbhAXIY14idyT8gQ/h7sCc7qNew5rPk5wTkM+/Xg7q0A+ciWMl?=
 =?us-ascii?Q?uoS4a2iZNe5SBDiT1oZFzA15OHwnwdZCZu10+4rSsjaUavKecXFOUOPkAmqM?=
 =?us-ascii?Q?2ar9UU3lW6hrBiW8/HK0b8QgZTOKf4ddOmTDbkxtJeKvNGrJLRW4kMLVOA2n?=
 =?us-ascii?Q?NgknfwQMVprGf1Rr4Y3ziwTM3eBYAqVcuDTxuK5FIKWS9HoogzEjmV/UtkMK?=
 =?us-ascii?Q?RImuShOogjHEVwnRXMe627XgeYW3Jsrwmd1wQeOubmuXQF2Oi8fga9flYDlg?=
 =?us-ascii?Q?lqEPGHRnQpNJqgztMKwdBZhzaGl4PkmV+Gf/9ohbDiGL4UMejDhUiQ8IauhI?=
 =?us-ascii?Q?roBoGb8wt1v4nT+sB2KYEfcQxFqjLpcLia3LcYyUUZQf99pV0KWhAwiMcmZR?=
 =?us-ascii?Q?WO0WwekkCQ5UEbAbY5xbaiOBqYN04t1OZueJpNVNMIaujWCsC6sUHb24m246?=
 =?us-ascii?Q?s4HP7A6e8s1MK8d3xw4/bmX8u5KdA8fkhUZIFsna3MimQ5dwa5TO2T8aKjhx?=
 =?us-ascii?Q?G7ik67Ed7hF12zR6/m/qkXpGQ3dotwEGx4C5/YaKwBGAbWMc6jwL8MnjdJ63?=
 =?us-ascii?Q?Dpgz/CpjRS+fR6XkNWbJIuMBxnjKdIP0gYzPtdYcxkU3QPWAXWl/oRNs36iz?=
 =?us-ascii?Q?pKRug3gJUk9vO4fSVAWROEFRL9iOaugziPIEwiiSPOWMaftBV4t8x3drF1mu?=
 =?us-ascii?Q?CumVXcn1oF/tpjGUyzUiCKkxpOxbCR1UwvXQwx2d9rD2UZ/tYf+6CKlWVn8E?=
 =?us-ascii?Q?EoS1aeUiaVGUIXARj5oa8jiF9J351cazV7Zt2Bf9C5vdViDFGXuTKDudpTZD?=
 =?us-ascii?Q?MY35/rxMLkExbNG6NkefpRcwVN1fLIoBGMmDMwW2wsK51mCgCQGB0tG1326d?=
 =?us-ascii?Q?V6IsqbPob5UbKXVgCM9TwvB3BTFI0vxoZGzVa3hWtBworGOiFA0QDcR30vmw?=
 =?us-ascii?Q?jtn0eK144jSl94onUNBy0joWApQQTDJ+Vn7JYPxleiAgTsiiwiDYMIlTQ2K/?=
 =?us-ascii?Q?94RDAiyyi8AaW3uDVVLt+9iUV9S4Q6TDwNJ3QIVLP56b7XEbgQAfI/tShU9S?=
 =?us-ascii?Q?JiHEzepl+lSEZNEc0I9n1avOfto+rAS+HUS4suH6qrTcKelILq+7U1MtL1q2?=
 =?us-ascii?Q?IRU1d2FtUNbmarqb22R1wZ8p0pYmBBtaNGBw098HtCzLImxMZY3x5C9ebNBb?=
 =?us-ascii?Q?u6p+iiiblyVJZbUs5ytSaCM2wQ3apsbsFoiUa0QragC+91tBIKUnbKfHxMz7?=
 =?us-ascii?Q?DpxPrlRhgBeXUTDD1RLh6tOgnSc0FJXm/5hsrYnW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5920c3-a06d-4ae4-9cdd-08db718e45d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:00:07.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dms/IK5+Me1utfau7vDtohAi0Pr2+SxCdMyezAl7j9g8wqRjlmXOH222Jk7DDAXbtPzvvBcLWzztP6rLagpCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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

On Tue, Jun 20, 2023 at 03:05:01AM +0800, Karny, Wyes wrote:
> amd_pstate and intel_pstate active mode drivers support energy
> performance preference feature. Through this user can convey it's
> energy/performance preference to platform. Add this value change
> capability to cpupower.
> 
> To change the EPP value use below command:
> cpupower set --epp performance
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
>  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 180d5ba877e6..a789b123dbd4 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -18,6 +18,7 @@
>  
>  static struct option set_opts[] = {
>  	{"perf-bias", required_argument, NULL, 'b'},
> +	{"epp", required_argument, NULL, 'e'},
>  	{ },
>  };
>  
> @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
>  	union {
>  		struct {
>  			int perf_bias:1;
> +			int epp:1;
>  		};
>  		int params;
>  	} params;
>  	int perf_bias = 0;
>  	int ret = 0;
> +	char epp[30];
>  
>  	ret = uname(&uts);
>  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
>  
>  	params.params = 0;
>  	/* parameter parsing */
> -	while ((ret = getopt_long(argc, argv, "b:",
> +	while ((ret = getopt_long(argc, argv, "b:e:",
>  						set_opts, NULL)) != -1) {
>  		switch (ret) {
>  		case 'b':
> @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
>  			}
>  			params.perf_bias = 1;
>  			break;
> +		case 'e':
> +			if (params.epp)
> +				print_wrong_arg_exit();
> +			if (sscanf(optarg, "%29s", epp) != 1) {
> +				print_wrong_arg_exit();
> +				return -EINVAL;
> +			}
> +			params.epp = 1;
> +			break;
>  		default:
>  			print_wrong_arg_exit();
>  		}
> @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
>  				break;
>  			}
>  		}
> +
> +		if (params.epp) {
> +			ret = cpupower_set_epp(cpu, epp);
> +			if (ret) {
> +				fprintf(stderr,
> +					"Error setting epp value on CPU %d\n", cpu);
> +				break;
> +			}
> +		}
>  	}
>  	return ret;
>  }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index 96e4bede078b..5d998de2d291 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
>  extern int cpupower_intel_get_perf_bias(unsigned int cpu);
>  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>  
> +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +
>  /* Read/Write msr ****************************/
>  
>  /* PCI stuff ****************************/
> @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
>  static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>  { return 0; };
>  
> +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> +{ return -1; };
> +
>  /* Read/Write msr ****************************/
>  
>  static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 0c56fc77f93b..583df38ab13c 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
>  	return 0;
>  }
>  
> +int cpupower_set_epp(unsigned int cpu, char *epp)
> +{
> +	char path[SYSFS_PATH_MAX];
> +	char linebuf[30] = {};
> +
> +	snprintf(path, sizeof(path),
> +		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
> +
> +	if (!is_valid_path(path))
> +		return -1;
> +
> +	snprintf(linebuf, sizeof(linebuf), "%s", epp);
> +
> +	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
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
