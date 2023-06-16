Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C877328F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjFPHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbjFPHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:30:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD732D62;
        Fri, 16 Jun 2023 00:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scn2KYbQFq6yvK/2zre3j+jQcbmpVzYq6D8WlJNKMWUYA3f+Zu55WYfPmjLyILTCz8IibQQe5YwfgNH6ec+bBAmwuZF1DhsEzyNjp6+KLKRvBAcOKpMkmtTigjGKIrRoiCbOVxvhlTV+gnDi+VFnRTZ1cjWi0RXBbq/8BXDWauWzlx2fiuMqzqkBckTrAjWU6Q+7uk3NW7e6dU9ZANBckfTN1gdu+iY0rA5qiyod9D6Bc93fy+4J2fBeB7IzC85OvpU8jlL8NRT5Nk8VF6VdLscERP+Q2+5BRpiBxTVMDrwzijAax2211f3J9QQAS4oWj2uVshdSxQSxhIl6Q1djAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL28I/EwS18IIC/MTif2vQTb3zYIJL/Tn67Jsa97RBY=;
 b=FQm3OQuYax43ehHYleLkBtxX3CimXC8De33rlMXLsFiqUYpY9Kh3s0Vr8foNKVPlXOOzmBGD+RryBg2gInNNLdIVXpOwnRzBvYO7188z65gRW5zdy5GwUpX1LEABYQku4pG7ioFVOKvD9TL8UxFz4fhI/l1iJEp4LL0q6YwdQLjRGqZ+g0Q/eCamQYoh69rMjnS2K7P8DHBKnwZGM67qBLd/d9vw1V8dP6y3Zg/X3dFuAo9dGgnovOTQNzTJh9jkfKiwrMUL7KMj9wPMtZyqsgqx+3V1E05n2wyY7BZZDkGBNAp058uNBSQ9Dz2njmlxuHZ9ABodO8HL7GXWbIGFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL28I/EwS18IIC/MTif2vQTb3zYIJL/Tn67Jsa97RBY=;
 b=UJ9ILlvzE2gafV7LZnHeIQxhsA+3EgQgxLzXLFiKSi3SF2TaInuLhys5CY0USgczRH1rb4pKlH6ypby1WK1eM9rqP9FnrfmJRUtBhGHUklzqZ36NG/95YWbhPrZ1pcSzuS3hmy9kwQREPaIEqJBXzA8mypia45t2ypRbRyHCE7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 07:30:24 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:30:24 +0000
Date:   Fri, 16 Jun 2023 15:29:59 +0800
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
Subject: Re: [PATCH 6/6] cpupower: Add turbo-boost support in cpupower
Message-ID: <ZIwPdzc8Bfv/cvTh@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113615.205353-7-wyes.karny@amd.com>
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f8cc8c-daff-44b7-875d-08db6e3b8c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SOH7rlgsekRyTmu4ISV6fo4bCCUoAdr4N7baKdzXjAZtJUMRPFeSeUq91ZwWC8kzPUWMyMdCmgKOgwqWf8SEwFbszWJ7B9/RyI7NfIq4i2V0l7m4YbfEUuo/GQrRjAhT056I0KHD8nR24ue8HdiUNSktGkzyj/GRNsXvxdljnrpNUBSAHRVTLYFGSuozIDHULSI2U8xQsbMPzzTahHrr7YFjYEOs8gw73DnqQ0qsBlv571OqQ2vHvwOBN/yo0c/+0GAkJnntCtJR4w64ElqHbFvLIXa9JbvbofPhgqykSh1Lyi/JwlkgfNFMU0vVJTL9FqVnmkMWR4EEDrOwBCjI0zqZvON5iY3x14ilq3jINPSTNBUF+DIed6/pF9Bh4lz4IaFhSICepo/gkzOyBghxFyXpFRsMn+/cVeE/wqbTB0PuJk65nF1eJnS4tdA+gya3sW2lPzNPclQISU0aq/AN4RQsGvG6fZ5uYNXD7Pqe+l3vQ8uwCnjZasMj5oli4Qef0sLbHt8gZ+ZhmZAlfjheNdYPKGaFl6OhLhxf+fYxs04ejklyyOEqM+wSVHLJQfr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(36756003)(38100700002)(86362001)(478600001)(8676002)(8936002)(41300700001)(6486002)(6636002)(4326008)(37006003)(54906003)(6666004)(316002)(6862004)(5660300002)(6506007)(6512007)(186003)(26005)(2906002)(2616005)(66476007)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79qyINxMXhhga0MLHAQIMRS1P9E4oLq9VaYOvO/Nu7TWoIGkChNvv9aemjpS?=
 =?us-ascii?Q?mjK+g+2f/0hfUeFDrdgablm5o/g9phy5FHKkJdyytvbeh5L2Qh2Cox9UlH3l?=
 =?us-ascii?Q?6GJUNCMEaUJo3PCcY24OIi2z9+FSA8sXWVJJejKFGHD10KyG9UxC8DiD+iaG?=
 =?us-ascii?Q?2udg2aFuYqj5hZKSt5cdjcVvCtN8Si47vTwZ4GRkl63oF8/7rgNkjQpgtrDK?=
 =?us-ascii?Q?IoJ556RaeoFW2baxxowO8wZDWmtkNv5tSc/TTNGowu3eyGCz2OJmrlaMutZZ?=
 =?us-ascii?Q?qtjNoZiAiMPQBZ6xyknutwDIqfceZiani+whDWgmBU7NmBV87KcBDDByIqou?=
 =?us-ascii?Q?QfIJYTbjEzwceBOUijmgibqDwK1CQbc+dOKM8ZqbzYtIIEfLavTU+1v8YvHK?=
 =?us-ascii?Q?ABIBpAaWjqEG1sZn/HI1x2/TQGYSImIUThTmEWngIoIasWPJH4s+dcsi2XsQ?=
 =?us-ascii?Q?0/FCpPTBFlUrD5UjLdE2auu2CDuCWh+B2xZbsprT1lZbSH0kCnOOtNWBZfI9?=
 =?us-ascii?Q?+bDOS2mJ16qPJTcXitu+6c3NoRC7o1MbZtEqrZLnnmWPpHYlSkhfE21AdcdX?=
 =?us-ascii?Q?ccG8aAK7CtqIgcBGNa7TYRQPrQ/0gcNtPEUj3xQozEEzLOHYwfC/Lk8zNiHM?=
 =?us-ascii?Q?NRPUxI/kHgLy9fttQyNVk0Sf1ZGBNYafRoq1m8yMvKi5kzVt9sa4NOa4E7rL?=
 =?us-ascii?Q?Pzc4RQOUPCZ4fVUyBrPqhWuAHsLe4Diq8MjGh24Df6oRMwuihplSxVn3Rpy/?=
 =?us-ascii?Q?mncSLRRd19csSdtrAPBGXXYrqZuwx+MSwy4n1fQJ3W4zCiihJVEZ8WVs5FoG?=
 =?us-ascii?Q?6PqpYTA59xMNyHK83Csdrw0KpcsMbpZrW05XWfMhv9obI6zDrerxV/ulrJR8?=
 =?us-ascii?Q?e8NXHKjiYrsDQskLKIiKiksGobR9UMJ0Wgd4EZ3y4Cu+yk0PKDaVASy3pCNC?=
 =?us-ascii?Q?Rsblzt0KMe9kcp5+J1aIvlta49GSh+RFRVYjFycbFvn/mW7LAJm/NV6o/mO8?=
 =?us-ascii?Q?oXrY5FXozMRTJnbhYMm/4DLuBn2QF5Iu8nmv626uMXKoELC/itaLNmq57wi1?=
 =?us-ascii?Q?PD7lslKlyd1GVV4QGz2ny5ecFLDcthHRNEH74vXroNz8s5ip/I6Yl+hbSPXl?=
 =?us-ascii?Q?hXvBLlKQ9pco4ZxCvp+9KVJS9eAW66FeMWAg/jj7UaJc+7FFeG62JAx61m2A?=
 =?us-ascii?Q?kv4ie0sI1tCvVTvNCkCsXLNx7gGHdOQKdgWEK/OdmstCRSLaUOXuuIJ0EFfm?=
 =?us-ascii?Q?HtNoYFNkJnRbGiLvC+CISpxINWZFDWBy6sfrNfxLRCwCXrrFO3oaNOWxxnH+?=
 =?us-ascii?Q?XbR4xn3rK5h5k+/0QjqZnUBI5rmsmqsiv3z0nQUK/zuGMthSNEJ4W6z3GRaU?=
 =?us-ascii?Q?o0SYqLMSwVqyF7N3dCNIOcq5Tz+6Dm/v9emfvJepE0Aktuv6EWaHmULRHq15?=
 =?us-ascii?Q?k4hoby+3YV5dV08J5Qexsq7aAmqsrETEdbLlGzybDFTqUrfOEEjM3OBUKfxC?=
 =?us-ascii?Q?ItTO0iWqY8vtsZYJajEPZxptzWYSoi5t9LDoZQYddOGyzr6TVXqYY+1gQzG8?=
 =?us-ascii?Q?6ORlDVJ0Z8vIZMbT9kb828hSkT9f+V5GqOiE17zr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f8cc8c-daff-44b7-875d-08db6e3b8c3f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:30:23.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dey0fGABrpHmtvmunMPTu+iyN7dx0GW2PErJ9T1TPEEPYytzm4oqRzYcwDylul45AdMZmXjE1Kr1SeNg9ExvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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

On Mon, Jun 12, 2023 at 07:36:15PM +0800, Karny, Wyes wrote:
> If boost sysfs (/sys/devices/system/cpu/cpufreq/boost) file is present
> turbo-boost is feature is supported in the hardware. By default this
> feature should be enabled. But to disable/enable it write to the sysfs
> file. Use the same to control this feature via cpupower.
> 
> To enable:
> cpupower set --turbo-boost 1
> 
> To disable:
> cpupower set --turbo-boost 0
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 22 +++++++++++++++++++-
>  tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>  tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index c2ba69b7ea54..0677b58374ab 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -20,6 +20,7 @@ static struct option set_opts[] = {
>  	{"perf-bias", required_argument, NULL, 'b'},
>  	{"epp", required_argument, NULL, 'e'},
>  	{"amd-pstate-mode", required_argument, NULL, 'm'},
> +	{"turbo-boost", required_argument, NULL, 't'},
>  	{ },
>  };
>  
> @@ -41,10 +42,11 @@ int cmd_set(int argc, char **argv)
>  			int perf_bias:1;
>  			int epp:1;
>  			int mode:1;
> +			int turbo_boost:1;
>  		};
>  		int params;
>  	} params;
> -	int perf_bias = 0;
> +	int perf_bias = 0, turbo_boost = 1;
>  	int ret = 0;
>  	char epp[30], mode[20];
>  
> @@ -94,6 +96,18 @@ int cmd_set(int argc, char **argv)
>  			}
>  			params.mode = 1;
>  			break;
> +		case 't':
> +			if (params.turbo_boost)
> +				print_wrong_arg_exit();
> +			turbo_boost = atoi(optarg);
> +			if (turbo_boost < 0 || turbo_boost > 1) {
> +				printf("--turbo-boost param out of range [0-1]\n");
> +				print_wrong_arg_exit();
> +			}
> +			params.turbo_boost = 1;
> +			break;
> +
> +
>  		default:
>  			print_wrong_arg_exit();
>  		}
> @@ -108,6 +122,12 @@ int cmd_set(int argc, char **argv)
>  			fprintf(stderr, "Error setting mode\n");
>  	}
>  
> +	if (params.turbo_boost) {
> +		ret = cpupower_set_turbo_boost(turbo_boost);
> +		if (ret)
> +			fprintf(stderr, "Error setting turbo-boost\n");
> +	}
> +
>  	/* Default is: set all CPUs */
>  	if (bitmask_isallclear(cpus_chosen))
>  		bitmask_setall(cpus_chosen);
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index d35596631eef..95749b8ee475 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -118,6 +118,7 @@ extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>  
>  extern int cpupower_set_epp(unsigned int cpu, char *epp);
>  extern int cpupower_set_amd_pstate_mode(char *mode);
> +extern int cpupower_set_turbo_boost(int turbo_boost);
>  
>  /* Read/Write msr ****************************/
>  
> @@ -180,6 +181,8 @@ static inline int cpupower_set_epp(unsigned int cpu, char *epp)
>  { return -1; };
>  static inline int cpupower_set_amd_pstate_mode(char *mode)
>  { return -1; };
> +static inline int cpupower_set_turbo_boost(int turbo_boost)
> +{ return -1; };
>  
>  /* Read/Write msr ****************************/
>  
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9df9af8a969e..fc822a0e6b7b 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -124,6 +124,24 @@ int cpupower_set_amd_pstate_mode(char *mode)
>  	return 0;
>  }
>  
> +int cpupower_set_turbo_boost(int turbo_boost)
> +{
> +	char path[SYSFS_PATH_MAX];
> +	char linebuf[2] = {};
> +
> +	snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
> +
> +	if (!is_valid_path(path))
> +		return -1;
> +
> +	snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
> +
> +	if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
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
