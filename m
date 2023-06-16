Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19887328C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbjFPHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFPHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:23:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE218D;
        Fri, 16 Jun 2023 00:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmba+H3aqs6EzVqdoBCVzHu/AVhjKjGxLip1Z+4MxEfb7HrSt4ejnbAJlxvDcuRxfxZMVlZfDoiVEKKCyPYpLLLdqLwVEGVry+Tt77wycdSfPfOWjOW8TiYdTFpW9JLoQ9PT/sNZWytVmOKeNYTCwroXAtPRdYTDK3zN4uD8slqY2OYbrpNXArde4XNlf26Td5QWqkajMWw9rNbWxKalA5Hs/ZNi+CnwNCzb/G9E8on05hcO4Xw+7jaxmQvDZmkFF0q3mre7RfxYylZ9cyAfAELAVIWl4/QL3zQ2jKOF3zA4XGxPUpUKWsK+nZFglTgF0lxxhQks69j3/ux6uixf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdCZKRKNyfTWD8I6uWW+zmVD7fXr/VUG56G+YMJVOPY=;
 b=GO/yVZOumEPBFfYJRRFrDKkAecm5L8n9jaw5l51SaSfifoT1h0xXg9dqjcjFzYBFqk9RcJGv8fogmSoDMenZW09WfDLRQ799m2TsP/vbwqhGTGERmrh33Y0hOYooFWnmPDU0Fmf9kLlKc0d27oc/AnCs1HN/N4lvVwfMJTaSUxmATCCS/92WUQF8Ul4y+0FvgJdfawMF+Bx2soA5OXs//kEbHQvzR/fEhMIzsCfTeMLJ+oLm8ByQFr3iZ37ujAejh7hMQPEzu0b5oGa3+1lbxPDRZCR+CA2sDqs1Sd5ya1i2i1DKYNsEiFWJSVa0trrbUD2/E+9XuadRihPN51YGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdCZKRKNyfTWD8I6uWW+zmVD7fXr/VUG56G+YMJVOPY=;
 b=wgnxW4zew0ShseOGuG+4nY47G0FS1OLcx67MbzM9FJhR31mO2+EZuAK6BUkNQXfm65PAtCLsNTEj1Ieiog2tSUp6uTVDw48ladDWPYSIxd7XSF1G4cWDVpXyKN5tUvfxroU0gg92At8UvM+C+rkNnbg6R5DOSRg86HamVYxqRl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 07:23:01 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:22:55 +0000
Date:   Fri, 16 Jun 2023 15:22:33 +0800
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
Subject: Re: [PATCH 4/6] cpupower: Add EPP value change support
Message-ID: <ZIwNuRQK/mLTzfM1@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-5-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113615.205353-5-wyes.karny@amd.com>
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c1ff60-8e5a-4e72-8f2d-08db6e3a8107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpQUQtYtVJB/2Whzlimzy8clk0rba1gqWoNwjRuyBpof/E8vdQpEsaqNAIxPlevduY2zvaNgJHvT8VlC8g16R3WL5tdgU3paWQStANJwZ6ltYRkoJuYR7qjqjoFde/+PraNmPZb+/uAZZDx3nXN8LJL3Oi6rWgv+n2BN83slY/ID11UF/yzxRcDfk0o3JA//A1htLNTzjypB6eJSVOf6n2pnUraJr9jC8SeDfIa+GYK/0mBheYQbrUQx7TuOmC/A80twnO4XgNcLZxBGwEx78mSz+bmrD7VyAdaJywbXQkuR1GT1I+cAWNzGd4FeblhOkeCXErwiCKLSuBpKWwssfHFZaLvEa5QXnl8hkBClwkJNmEGfjQ6b4P35Rml231t2e6UODp6fdVP/10YlpcIyG/08385BYCLZoA5kDMA4C1OtuKcCedm1erjYvu9pqsu+RIYek7wNNoKpLw+UIMA2xdpYTXzD5loTYLdZqDfvZBZLDVxQiLDbRehuw7GNhK7V4LuzhdeXDzahW8GHgkYQnozGDxiZp7lUQnarn3SyOjk2+tKdje/qdabl6eYHZwhE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(38100700002)(6506007)(26005)(6512007)(8676002)(2906002)(6862004)(83380400001)(5660300002)(86362001)(8936002)(186003)(6666004)(6486002)(2616005)(36756003)(37006003)(54906003)(66476007)(4326008)(6636002)(66556008)(316002)(41300700001)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYdSUnMybuqJHjj8Fux03ZQ9ZaClAlwRbqBqwO+p1UzN0uV5/s8zxUSzGyKg?=
 =?us-ascii?Q?KnWfczbqqSBTklE3Mh3AfAJvLUYSPQnDn3rshISfdH7xzvM9fPbevGOtZXQ4?=
 =?us-ascii?Q?VzCSE/5JqZBnVS+Mjk/0VolnaBNL2v7t7t4InUBy01q76TBeMcert7qjCz/E?=
 =?us-ascii?Q?VkE74x4/Tcx99cUpSb8/IeAXjlUStcrvDDjA51PFqyI12c2W/ZB+XOKJXI4D?=
 =?us-ascii?Q?RkZjls1aBgcA/nw2mWcwf0z84GqLGhwfhbzZ+S1KHxPhnBCJnKHSHcxmSBlA?=
 =?us-ascii?Q?jFDnWqelixN0ENEmzTGS7G12qoBxv02k3+3ccIWcqiWmV5vc6F3YB5WXipA9?=
 =?us-ascii?Q?TsGnsrDNHPTUO5SEVSnT4/dS3PDvLQqbpyZlB5VUXMHAhpv0qbrB795/8sF4?=
 =?us-ascii?Q?5lFR41RErvysn4d77QzfgZa7pPiGXrk7nd5n9+oOSgpEx/DxTQpf0NGeMx4x?=
 =?us-ascii?Q?Q9t6PktzfCTusCfHNbSOuktQc1bmo4VojP8p977yRC62y7T9pB+AoXsIY5RL?=
 =?us-ascii?Q?3tgr0URIh5uEIgi1JCt00sI4NhYRzOhrrH6rAmmC3UxpJpU7llZViKMdDNOO?=
 =?us-ascii?Q?FsUdUVzZOJwXFAFE17Ky+IKIitgb8ZFsSpS/yAjsfv/kKX0ouOZhggdTX/mG?=
 =?us-ascii?Q?czb5ENOGtolxuOIOGB+L5T9MJtyjzZeQGqiyQakJEP1FiLJ6bKdPm3DMsAl9?=
 =?us-ascii?Q?0Rm1Zj+2LDQ1QlMJlIazbZ4x5fAh8lQgTLh3DaAoYZQFwjYXWFqUd5DifJGB?=
 =?us-ascii?Q?lBP+cTvOCPzM2G7FZFlccXMc1ZNhnlO6ipl0deqnWRQYrnvBtfYcg1KYz3XX?=
 =?us-ascii?Q?oC3tun12800glRVBQSxfh4PtF89c1P2QKbNRdRQD4lmVGJ9synylrvfRCx2r?=
 =?us-ascii?Q?QzRu+zyi6YdnQ+z0OVASnewhvAnECIVkhML0XTc6LSCbOy9Daj2z9HAXMyNV?=
 =?us-ascii?Q?fLKeqU6igZe6wXcZh5PSziIaxm9FodwrhgPnhQxhDunULcBMCgUd0OQKCXv9?=
 =?us-ascii?Q?Ez6VbMJ4m9uRi4put3qfk+wyCfl6JxThxD1KwNV3RDY4O30lyD0e5LBOhg1r?=
 =?us-ascii?Q?olaACMgaUadD5+BdYzrH2z/ZBrvMNvT6CxWXZCVoV7coVVaaHTUYpUsEBETe?=
 =?us-ascii?Q?HxOcUyDxqUcp7ZIzn/yVZ7ZbmbEZ3g0P09QHkUdzOgTGaJK/ne/Hwqrtg/ds?=
 =?us-ascii?Q?ZkHU5GP11FGur718dY/J5x8f9His4cVc72pj8jjFZKBy3SdjJo+nIMHujP3s?=
 =?us-ascii?Q?YZdt6+I/ckkecqiLuc4L33V3WRERhSjgS4Wzz6lqJflGB4sRLFOw2kg7kFcv?=
 =?us-ascii?Q?ZiOFB8fvuqRl2sT1jVKV44bQDR1RPJvQ58na2GBQ2RTFFbmXixcZpT3qD6aO?=
 =?us-ascii?Q?sf1azTyhfI4YC5NnpvR/Od77rKxiBy+2bgKTAUYBf1w/9Z5VkakU8sNbMnpI?=
 =?us-ascii?Q?2Gp5Na0LKMUTtdv14KGIy6y7bIE79lPzCuy4d3aGCoCZcV5hOugEm9LK+vHe?=
 =?us-ascii?Q?WVWBE0vV87a5i1/s1e3dXNJDW4lUxZhaHET7zZ3fkBHkDwfMVDe0wLnUX/MF?=
 =?us-ascii?Q?EJKu6Cg4MwhUDPR73Nv0V/PPaBl2HTYVtPvxZZL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c1ff60-8e5a-4e72-8f2d-08db6e3a8107
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:22:55.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdjP3Gg1hQvNhpvrh+w1u6nGtHlnx2K0E3nZv43ZCjDB+gejWq2QQNugj+logakTVcQF7mGkqcjO5HSpTClAfA==
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

On Mon, Jun 12, 2023 at 07:36:13PM +0800, Karny, Wyes wrote:
> amd_pstate and intel_pstate active mode drivers support energy
> performance preference feature. Through this user can convey it's
> energy/performance preference to platform. Add this value change
> capability to cpupower.
> 
> To change the EPP value use below command:
> cpupower set --epp performance
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
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

How about re-using the "perf-bias", I think it should be the simliar
function with Intel's processor?

Thanks,
Ray

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
> index 21f653cd472c..63c3f26ef874 100644
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
