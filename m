Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A217349D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFSB7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSB7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:59:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478DE64;
        Sun, 18 Jun 2023 18:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrM+s6HBKFDyIOJB2g9joevB0u2U+CYhzNrdnnJiJhPF/F1TtqUQMKNaAcqjG86V/WR0HuyihRBcQ/fHQbJqaOPETo5nlkfzzz5jvp+JGaW3M1rCi8/6Rz9YIQ2BInUMahqHLZ3t/NqO6yEUzoy05zBWvbntTjXsYkebbOQiieB+wl/AJ1+o7l8DWBoZ4zj6/TGzleRbTntIRuUAcnKbPPx5KMQz5PpfbuAl/vwmKTkq9/BBtybVu2JLcj1k3MjlBbx7uRp4Pd1gX/PFjUSlllkzRfBtfz6ZyMprplHtbCh3GEkY8xwTdi4LOpW0+7RCNNgVwYlDCrxX0AW20yJGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfmqVhsnvWlYVAWMudQhtm1JVDmnTDpTvk4XT/le7vE=;
 b=Fzgbp5yMt5GxCvwl5R9Ar+9zp6YWHVamf1cImOOygNB8yoiCCb8bRe2lYdf9gy5ZRIdLDTBcNy/lJXEP4jYSzeHcAFpzwVrDclvRHXDx2xChXcghNdbisXvI6oz2tFCVYSzXpRYH9EB8VhJMryuHeA3+diRY324AsZfq3+10GqgNwFcUifliDRiRmui+3e+2bcemgUS2dxVWPNf4B97HA0kAiap67siayA4CvPXe05OatrWefWYLcDA/LllqPuSgCBkN6df2B0aEIEthjFx0FWVDCrFEXaz3tT6qJdXW61W6d27qYK2cap0Ov5rF5tubEVWUkwBumiMD0astKVCuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfmqVhsnvWlYVAWMudQhtm1JVDmnTDpTvk4XT/le7vE=;
 b=PsVO43h6gOrUhBzQt1JjZGXGdMPBRZGlkE7IGwtNUlE3Dm6pu0nHlUixAUGkOJR5+3iPq9tKODvnee8L4TrDQ8vvXtLuEyo4NE4zDQVOfmqMWbUGqaFPMRtWc07DNyZXnEL01kIlwd2qxK0LZTLaMv0OUatOA8XlIMrkm0h8qT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 01:58:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 01:58:56 +0000
Message-ID: <84f06212-b212-8bc7-d0f0-21b55a9bd3aa@amd.com>
Date:   Sun, 18 Jun 2023 20:58:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/5] cpupower: Add EPP value change support
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616120953.147676-1-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230616120953.147676-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:806:20::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e61424-505b-4308-9e62-08db7068bdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJy6SfZsvypI2E3chkQt22DAzLRqOOylayUpWh1fVVeKC99v9+35zifSsMwLxVVWZ/cXkDN47h8OtfSvCqwXuRgefIapBNiu693CiGAo4ZG4JrRxVlnPMOOfg8384dYk9U+du16AbOQFTGElu+5Za4Rrt+fAQ3uk9mqjLiQUifDY0ETcnQTf/BNCZOoBEqSzxbZThvj76/DOxWnm+5a/YFUyfLcmfW1grwg1aIZmygrZmIfXpe3e3g6eyZPSwx1ubw9qRiPofiKOXtZi94XOQdS9rSLkwXiMOlCvwhwzrQKP3yc5Txk3UOCuH4VN4Epua6p1xago29euc7xTv4nOQHSBhh76YCH2s0AeacwRrTKlhGwyOqAEvdiKqEkjLvaOAxaHnjPLT89nCX8YIOjuTQ5YIQnLZagYobiOcNEZQPgrGKnvLT5X3JuKRbXN/y8hUejdcAVswzSzXke6cHoPdQm7n5jABd+Fmx7kPCMmU4FadgeQShclFET3AGRLuVpE4DREbeP5qSrcmv/XWyABZBDZnLScKFKBAdVF/j+NTuy0QBTdOkSFi6nRm/uTYr8BiVEKWnMXk9VCDmcwmPoP1IwrFmwcr28OBZ+66aY0h8KaTYd917ukZ43THCPr4DecGSeS5+KKqRca9LaiU6EEFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38100700002)(83380400001)(31696002)(44832011)(6486002)(86362001)(2906002)(5660300002)(316002)(8936002)(6506007)(53546011)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUsvaWtuN0NjYkV5aVZKK2lCQU9FbWhyU3RDQ3lYM2duM1BpZlpUakNGMHcr?=
 =?utf-8?B?dFhCVGRsUUN5RVhoeWlpSFdVWm1odTFZUHEzSFMrRzY2UzlvV1lXa2pIakli?=
 =?utf-8?B?VWsvTXRxd2YwWHV1OUJsdzN3OGlQa2VNMnZ0enhHa2wrU01sc05iSHduSTBx?=
 =?utf-8?B?M2xIajNCMmxQelQ5ZTkyUFhTZXNNelgwQ0RsYWtzcEdBK1F0YUw0VHIrc1dG?=
 =?utf-8?B?TFBZT2lGcHdqaWQxUUR1VENORzNRbkhaRmk0YkVvRUhpRmFiaVVZekpxVkow?=
 =?utf-8?B?cUtIZkgwWDdwVTIyMmtpMWVvMzdrOU5GTWZTWVY0L2p1ZUJrMVRpWXR0NzRq?=
 =?utf-8?B?a3g4YktwN3Q0cDNuNGpoOUVRWGs4Y1RzSEZBdUJTQzc0Y0ZoSzhuVG1UQi9C?=
 =?utf-8?B?elk4bDY2bFp3dWxFMC9wMmZyRHFPbzVlelg2Slh2dDJPUWFlajc4VVRBM0Jr?=
 =?utf-8?B?amlGZCtWQmluRUVsdHdPWmIweXdNVWc3UmhGOUp4Rzd0UUtCVDhEMUE5ejVB?=
 =?utf-8?B?azRRVGx6V0RBRjNaOHI2RTRFTlErR2dERWNvMWFMcTgzajRQbTd6cXpiMHBD?=
 =?utf-8?B?MEpVOVVYYXdYemtiM2Yxb0VuUmtIY0doUDhtQS9nclYzZWJkV2h6YnBlbGlC?=
 =?utf-8?B?RWQxZ2dVNFhxeERIUys2VXdPYlJTejVVVVY3UkthZ0pHZFp4L1BYTm91N1hm?=
 =?utf-8?B?akxRVC82TVl1ZjM5UUJFcU9CSHlHbllBRDlXMnQwZGR1dUtZVS9oUytHM05r?=
 =?utf-8?B?cTIxZXZqYUJ0Smw1WnlmY1c2VUNvc2FBcWt2V3lqdkZsYlAvWitETHdUQVRw?=
 =?utf-8?B?YkZ4eUc1bTdiRlpTZDZxU0JLU0VkTm1QR0F3WVE5T0crckFoZUUyOUFsNE5F?=
 =?utf-8?B?UCtLTGc1SExDS1hyeERycVVTVndqN0ZTd0F1K2VZN3RuZW1xdWJmRGN0YlBO?=
 =?utf-8?B?Y1cranBlak4zcFUza0R6NmpITHZDaFMrbHBhcHRQRUlvVTY1NkNJeWxkMU5C?=
 =?utf-8?B?KzgyWjJRQU12UTM2czQrQ0l4a3dtelhYa3MvOTZ5SEUrdG5Xa3EwM2kvTFdR?=
 =?utf-8?B?TS9zOGxQenJxQWNTQmJrWFlncmo5d1IrZUxiVmFreG5hSXF0UlpwWHVGRVVD?=
 =?utf-8?B?anFKZnp0YmE2bkRiM0I1RVlza21NN3RzSU9jTkFjL2JoY2hUdnZYSlpHZzZY?=
 =?utf-8?B?UFVRR2FSM2Z3MWtaQ0JUcGR4d0gzMW9RdGtZMXZqQ0lqZEw3Y0ZwdTBhM3pT?=
 =?utf-8?B?YzZVMU0vVTBmY1JxcFFteVlmejFQZlh3OHF2dVdjQ2c4UFRKVWRNa2RSS21E?=
 =?utf-8?B?bUFQcDREc3dsSjVKNWRGYUt0TnpHYmlYMGVmR3U3aUVBaXMrSTZYQ3F5L29U?=
 =?utf-8?B?WHB0N2k0Q3A4b000OXBMekFUUUxOcXFXMVFneEFaSEdYNTVYTiszdkt0SlRT?=
 =?utf-8?B?UXplUVcySVgvRkdKTnd4SmJNUGhHb0ViMWpWTUhROFMzeHZUQVErTXdVajl2?=
 =?utf-8?B?aTZPcGJRSGM2YU1ORkV3NzV3SjU0ZG40Wm5jSzcrL3lSQjg3S2ZKK05oeHkw?=
 =?utf-8?B?T2E1RERwSzN3R3JwYldZNHl1TmZmK3h4NTBHZHlFZHZWMFpSVVAzRXJaUnQz?=
 =?utf-8?B?T2JuaGt6Vis1T1ovM2s1NXArTkZ4RlNJUDBaNWxXeVJKdGwvUEdtODhnM2tk?=
 =?utf-8?B?N1RHd3pHZjY3NGpHMVZhRVZBRGw0aXFNODUxbHFIZjJ1QmZ4MHRtR2dXeDFR?=
 =?utf-8?B?SUxrdTBFWHU3c0xnTDlIZ1U5Y1ZJUktZb1VrS3V0clFQcUdITXVncnc5Qnl0?=
 =?utf-8?B?TjhrbGZ6QlBvbzZteDI1QTJFRzdqSTA3d2dONmw2MXg1QWNIcGhkS1dYR1ZR?=
 =?utf-8?B?TXhFdXBkVzUvaVdLNm9oYURZZjl0dHF6MGhwVHppV1NNMjAvQ3dJcGxmM21a?=
 =?utf-8?B?QWQ2THJlNmNOaWJpajM4V05sOEZwZkxXQWNHZTNDVVJOVUVJQjNPdytCWkFH?=
 =?utf-8?B?dW5mbllPQnlFcVNFQ3ZJY3R5a0RCR3E2NzdLbkxpUXlaQlA2VXY3Q3BHaTlV?=
 =?utf-8?B?VHJxZXl3UUV0VmhWNHdtdXZsZzdHN0hDcFFMblF0Vy9rT3dncUtTWjY2MUli?=
 =?utf-8?B?dWM5OWZiNHpYT3FiMFhOckpOOVdJcmtYK2lUZkc3OUdIV1BrMHJRZTQ5cEQr?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e61424-505b-4308-9e62-08db7068bdc6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 01:58:56.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH+VwY+J33nTy87yCwvEfnF4eUIZRlDNGJKTIR1xBPM1oH08KwS3FWaztQOZSy+S+k0IJ7hLmR3SQiKLhpsL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 07:09, Wyes Karny wrote:
> amd_pstate and intel_pstate active mode drivers support energy
> performance preference feature. Through this user can convey it's
> energy/performance preference to platform. Add this value change
> capability to cpupower.
> 
> To change the EPP value use below command:
> cpupower set --epp performance
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
>   tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>   tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
>   3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 180d5ba877e6..a789b123dbd4 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -18,6 +18,7 @@
>   
>   static struct option set_opts[] = {
>   	{"perf-bias", required_argument, NULL, 'b'},
> +	{"epp", required_argument, NULL, 'e'},
>   	{ },
>   };
>   
> @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
>   	union {
>   		struct {
>   			int perf_bias:1;
> +			int epp:1;
>   		};
>   		int params;
>   	} params;
>   	int perf_bias = 0;
>   	int ret = 0;
> +	char epp[30];
>   
>   	ret = uname(&uts);
>   	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
>   
>   	params.params = 0;
>   	/* parameter parsing */
> -	while ((ret = getopt_long(argc, argv, "b:",
> +	while ((ret = getopt_long(argc, argv, "b:e:",
>   						set_opts, NULL)) != -1) {
>   		switch (ret) {
>   		case 'b':
> @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
>   			}
>   			params.perf_bias = 1;
>   			break;
> +		case 'e':
> +			if (params.epp)
> +				print_wrong_arg_exit();
> +			if (sscanf(optarg, "%29s", epp) != 1) {
> +				print_wrong_arg_exit();
> +				return -EINVAL;
> +			}
> +			params.epp = 1;
> +			break;
>   		default:
>   			print_wrong_arg_exit();
>   		}
> @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
>   				break;
>   			}
>   		}
> +
> +		if (params.epp) {
> +			ret = cpupower_set_epp(cpu, epp);
> +			if (ret) {
> +				fprintf(stderr,
> +					"Error setting epp value on CPU %d\n", cpu);
> +				break;
> +			}
> +		}
>   	}
>   	return ret;
>   }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index 96e4bede078b..5d998de2d291 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
>   extern int cpupower_intel_get_perf_bias(unsigned int cpu);
>   extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>   
> +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +
>   /* Read/Write msr ****************************/
>   
>   /* PCI stuff ****************************/
> @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
>   static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>   { return 0; };
>   
> +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> +{ return -1; };
> +
>   /* Read/Write msr ****************************/
>   
>   static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 21f653cd472c..63c3f26ef874 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
>   	return 0;
>   }
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
>   bool cpupower_amd_pstate_enabled(void)
>   {
>   	char *driver = cpufreq_get_driver(0);

