Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF517349DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFSCAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFSCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:00:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CDE44;
        Sun, 18 Jun 2023 19:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHijYQf0DC45tA/2KCakNWIeBkGxYiNPrtXTFScZcHU4lmMyaupvcqg0GPzherXaspquWhOQ7SMkB5rl1esm2v8A+c/GBkGyYlpFYHpyiGkRDI3nH0+nuFawb99+/towNdG/dzmqCeX+CgnA4FlSJ5nCKDiZRObvIbjL/wWixiT0tSvY9Wy5WaZbtm0qIwwvvprbQ7nztXzpWxRaCDHaTkCCaGnqLkmX/k61wqiDWym57dGpRIoxXXSkvYbhNXE7DRtQDMCN44wjXlBzaA06OwIp+TY6+fFgKINBaLYrHtqBUexgiZD/P+W0k2AwtdWFw+amSwFsOEREANntC4XhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnA6muhzLq46yrozVSWJ7kshr9MxWB9cC0sVPxUagMw=;
 b=d1mKCZl5NYMnWWvahRLZCgjtVLWS8lojGz8eP6imtonWYTEbnFHYe1ZrMi3UEHdRfCkPW6JKEwgp/omlQRm+9ReI6j9orpVzfXgIhKndORDArFwjxEPibswnmZrrblVP+lt6zrcP5mpbiRXa/hcmUPpzw7VH5W/Fey+/+I2HP+NMbYXKYQAqB4bil2QNXHXsoxvwY69+2Be/9WFyzHrKNPqhNVwsUQfaWHxEIOpp+UdBALUnGTGTEen5bKoISjCDzIgCWjxz6cM/gxneiYrHfAavKzoWY6Dh5D/p5MakVpEUYJj1y6NfV4wd38E1SCuzwa7xdlRnz7Km9YoU3/5nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnA6muhzLq46yrozVSWJ7kshr9MxWB9cC0sVPxUagMw=;
 b=o7tO7s/TFTPiKWRrsXGtL5mGUOHXTYKRZwOXc+G2pQnsrveNkxfF6pFqYcAIYLGNVXqMRC4N1vvzrgMjM1Om1hJz8x7KJoJLPKnlyrSlQGdbRFGECMINH2QblHUPjIIyfm7fy6Xn/M1tAHoSkn6WEqMnvuKgworSdmguyLrrg2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 02:00:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 02:00:00 +0000
Message-ID: <81e9b2f3-8964-5a1f-e14e-b3ef52b625d3@amd.com>
Date:   Sun, 18 Jun 2023 20:59:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 5/5] cpupower: Add turbo-boost support in cpupower
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616121101.147706-1-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230616121101.147706-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 710944d0-626b-4a22-3f83-08db7068e3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1aGUf0ed8gEsNnYetcTNrLUl07JtSjbCqqW80hUlSSceH1y8k3fkvOm3dsHvD9Qpd10fXNkXkJJinXD9jKzHsg4J4dXRu50yVTp+VAr6FFlhuWa9vCPH0BapZFMngF2lATwzBemi4GMNrxHD+IqQ9FzkigEy08T0OS2QzFV9wO4LKTukmpIBErDWpr1V5Sz9QhLjiLxh3GKwBXIzSxdaxdzXD7Bcggjq05iO3GQWSuJ3mCI9JFE8VdQH2+jIzfrpXEEKecTGZUAwleM2atOe1zijhdYaIN8LK6WXqz2C8I6xLnWZLBsli8ixm7V37BOkeLshUBgIeTncAXI7YHRi7Ttr+JxEJcbb4vsWywxha8KUBHcGqTiuW760eYztBfVNktsgFdIPvEXqkLt0FynRnvr1oD6+ESas1J6wW5At6sQubZqimNWvHu+dyCb8+Rx2vt5sjqLTn7SrzAhWKEQtayDmw4uJu+UirIyN6kPphpyibYLJ6zrraHqX1H448/PdbHLRTvaoLrqf7gmfPpTPJ+DbBwu2MbyjMTEJVm/9kl18XJVhUBa+8pCzc1HmUwBPI4ji2aI7ezJZx1jmasimgj90JKU6sAKd1i9iTQ4rNUeGcelYqP23lAEWW280G+OKL224UjKwc9xI35Ig8soIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38100700002)(83380400001)(31696002)(44832011)(6486002)(86362001)(2906002)(5660300002)(6666004)(316002)(8936002)(6506007)(53546011)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRIVEs0Q3RkQUtyT2ttNTVhbU1TWXg2Q0hTZmhBek1yVTFwVjZEUzl0SmVT?=
 =?utf-8?B?TmZkQjF4d0lVcnZFOTJ1UDRHalp0SFpSODZKS2dSeTVCZXJRVTIyKzFWMlgw?=
 =?utf-8?B?Y2tBWmtPU2l3UFo1SHpPbWlwZDRaYUJ1Vk1ySERyUStYbG9oQ2ZXdy9wL0tU?=
 =?utf-8?B?di8vZG8yQlFuY1FRS000WDR5bDNiUitSSFRQRDJFOFVVbnJ0OU5XOWRieXNy?=
 =?utf-8?B?VS9XV2xpd3MrRlFwME1KTzkrOUZjbEsrbmFMWTg2djk2dE1jODRVWjFrRzJp?=
 =?utf-8?B?cjZMMWtaTUhEQkpja2c3NVY1c0pCNGlScXNXTGVhK1ZjcTlXTjF4dkN6MmVt?=
 =?utf-8?B?MFM2ZHU0bXZmb2plNFlsRFZEVTA1MDlpUjRaT1liektsYlQvZnF1S1ZKa3VS?=
 =?utf-8?B?RDM3NlI4K2xGWldaQUZ6eFBmaWFUemp1UTM0R21LazZnWWMyVnV1Z2ZLb2N4?=
 =?utf-8?B?cEs4U3BGMXRFYVU0UTQwUGFab3I2MlIzOWthdTJxcnhaaVhvZjY1QkdqSW50?=
 =?utf-8?B?V2dkZUNpRXkycFl2b0xYZURtWWhVNU1FbHBIR0p0MGtPTmZ0ZXpOMmZ1NTNX?=
 =?utf-8?B?UUtOWTYvN0xnUUZwRmFORVJacVUzQWI5ZjVrVEdUQ2lSM0p0R1o0TUtYeDU2?=
 =?utf-8?B?UDYxd2NONVdVcUhPeHFyL21lUEhtd1I2cEVkMy93aElzOVBsTksrTEVsdnZa?=
 =?utf-8?B?SWhncW9DNHBUa0xYR2JnYXI1MTVIMzBydml1blhvbHAyYlVOSDg4T2xSd2lp?=
 =?utf-8?B?eTg3TEJDNXpGV0lNei9aSk1ZaU1RUkxqZTdkaVJoWTJHYVdzemp1RzcyQUho?=
 =?utf-8?B?bWRuVnBjaDZ2R2N5ellPbUQ5WlprTTNHMWlUMGVUY0xER25mNWVEVnBvSmFx?=
 =?utf-8?B?ZitlblJpV21EY2JIUTFPRVZScWdIREJlVWc4V2ZBU1Zhb2tjTk15YWQ2cld0?=
 =?utf-8?B?ZzA1OWtpdFJxamxmRWJqWUVSbW0vVm91VWVBdkRvOHRHaTRNNHZCbzdSbFda?=
 =?utf-8?B?VFZ4dGFMVnNiamIzNWVOdUhOK3lNMFg5dW1DaU5nSkZtT2M1WTdHSVVydWtP?=
 =?utf-8?B?OFNQZU8wa1FrZDhHSkdpRHZ4VkJ4SWltVjh3aElOcGlzSmhHZU1VS1JralBw?=
 =?utf-8?B?OUdoTjRqSXZoRzJmYjBjM2w1UmVjSlZCazBkdXFrQndoK05FY3JsM2lYeXFw?=
 =?utf-8?B?ZzVMTHhBak85QTdhYmtiVXVIV1dqdFZROUQxTDRtNEVlaFpxNGttZFVaSmRE?=
 =?utf-8?B?Zm1lbTAzVjllVmNyNC85MkpENGNtSlQ0ZXNyekczK3l0eUJZbG5FMS9FNGRz?=
 =?utf-8?B?YkdBcE96WG5wSVBXZERNSS9FM2dRMktaUHdDakNpeFZGaGJqUGx1RHQ1MmJY?=
 =?utf-8?B?WVlEd0FwRjUyQUUweWg4Y1h5aUxUQ1JTbTQ0R0FmYUdiT3ZzOEFiM0hsRDAr?=
 =?utf-8?B?S1ZmSEJzVEZGNWQ4QXNMbFB4VVJjVU9QMytHb3NWQXFodWNoTWgyMEdESTNU?=
 =?utf-8?B?NlBiRGxPQnlzRXd4VWtqc3UwQ2FzbVVjRlgrVUVUTHhoZ3dIM2ZWLzQ5N2oy?=
 =?utf-8?B?OWZ1eGNwaDVQOHpGS2V5Z0RtVTdZeFZNNnkwUTBhTm5wUG1QRkRvMjdqL1Uy?=
 =?utf-8?B?TEJjcFo1V2dxSnp2YUtmd3pFR3ZzV3pCbEJJaEpKaTk0MFFWZXRidzdJWEVD?=
 =?utf-8?B?M0xXRHEvQmcyOWZhTUFBNjZnUUdSQ0RMNVh3LzFRUFJJNi9aZTlDbVFEK3Bk?=
 =?utf-8?B?aE9BbWJIY01IMHgrTWc0UW94TmExWGtGanY2bnZ6QjJ5NXgwQzN5bWhIQmFp?=
 =?utf-8?B?MkJrQXk0VjBmV1laQ2ljc1E5R3FUREg0NS9MSlFBN0dQdGVDOGpwdjB0S1c0?=
 =?utf-8?B?RUdXTk9LQ3l0cDNiSk5KcCt0KzRRZW8zelIrTHk5S2hVd20zaG82b0dCQmtT?=
 =?utf-8?B?TVhXQmo2eFB3Q0t0cVNKdVhNN1psMGZPaHNHMHU4MUVBbTdTSkp1ZDZlREdi?=
 =?utf-8?B?L28rcmxaeFBmTGtiQ0FzRko4RkV6aHFUanNRWmYvZ2pQeGlxR29mWWthYmEx?=
 =?utf-8?B?MHJpY1hRalhjbk1HOHBjSzA4V3htNnhrUFZ3QTdQN09RZjB5UTFYWGVBRGR3?=
 =?utf-8?B?K0hSVGhyanFmUi9iL0xMczkySUNhalhicVZGUzlrNVJBQUhocENTZkhiaE9X?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710944d0-626b-4a22-3f83-08db7068e3b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 02:00:00.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bwigfge4GW9W2ym+AahtG52m7fMak3JNsLcjU6j7b8AIdwTy6tHpCpcGYRXaMcoZXAzDNqlD3FoZDCBmZiJ2tA==
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

On 6/16/23 07:11, Wyes Karny wrote:
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
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   tools/power/cpupower/utils/cpupower-set.c    | 22 +++++++++++++++++++-
>   tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>   tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++
>   3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index c2ba69b7ea54..0677b58374ab 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -20,6 +20,7 @@ static struct option set_opts[] = {
>   	{"perf-bias", required_argument, NULL, 'b'},
>   	{"epp", required_argument, NULL, 'e'},
>   	{"amd-pstate-mode", required_argument, NULL, 'm'},
> +	{"turbo-boost", required_argument, NULL, 't'},
>   	{ },
>   };
>   
> @@ -41,10 +42,11 @@ int cmd_set(int argc, char **argv)
>   			int perf_bias:1;
>   			int epp:1;
>   			int mode:1;
> +			int turbo_boost:1;
>   		};
>   		int params;
>   	} params;
> -	int perf_bias = 0;
> +	int perf_bias = 0, turbo_boost = 1;
>   	int ret = 0;
>   	char epp[30], mode[20];
>   
> @@ -94,6 +96,18 @@ int cmd_set(int argc, char **argv)
>   			}
>   			params.mode = 1;
>   			break;
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
>   		default:
>   			print_wrong_arg_exit();
>   		}
> @@ -108,6 +122,12 @@ int cmd_set(int argc, char **argv)
>   			fprintf(stderr, "Error setting mode\n");
>   	}
>   
> +	if (params.turbo_boost) {
> +		ret = cpupower_set_turbo_boost(turbo_boost);
> +		if (ret)
> +			fprintf(stderr, "Error setting turbo-boost\n");
> +	}
> +
>   	/* Default is: set all CPUs */
>   	if (bitmask_isallclear(cpus_chosen))
>   		bitmask_setall(cpus_chosen);
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index d35596631eef..95749b8ee475 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -118,6 +118,7 @@ extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>   
>   extern int cpupower_set_epp(unsigned int cpu, char *epp);
>   extern int cpupower_set_amd_pstate_mode(char *mode);
> +extern int cpupower_set_turbo_boost(int turbo_boost);
>   
>   /* Read/Write msr ****************************/
>   
> @@ -180,6 +181,8 @@ static inline int cpupower_set_epp(unsigned int cpu, char *epp)
>   { return -1; };
>   static inline int cpupower_set_amd_pstate_mode(char *mode)
>   { return -1; };
> +static inline int cpupower_set_turbo_boost(int turbo_boost)
> +{ return -1; };
>   
>   /* Read/Write msr ****************************/
>   
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9df9af8a969e..fc822a0e6b7b 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -124,6 +124,24 @@ int cpupower_set_amd_pstate_mode(char *mode)
>   	return 0;
>   }
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
>   bool cpupower_amd_pstate_enabled(void)
>   {
>   	char *driver = cpufreq_get_driver(0);

