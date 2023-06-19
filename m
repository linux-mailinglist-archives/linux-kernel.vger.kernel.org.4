Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B237349DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjFSB7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFSB7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:59:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232B7E50;
        Sun, 18 Jun 2023 18:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDJzOSzdgvcnLPdEaKTKf0P7q3ZKrMZesOfkFvKcHUnSNt7nV49mrUikR2n9gGg3u4jc4coo4RwJZWO/2b8lBYQZXJQRP077KohGd7b4giZeFDO4FSyUaEYVBON2pstBAgCJAhk5gtGo//9/aW+CPTtfhi1oj3aSOe6ld634rNhxBIcq4UOEyilFCGyeW627caVMCbs0qIsy4wZBXxEMFKPTslAqUyWwlHXZOOXnLEntkMWtzJugAIAp+csgNaxBF9H3lCDhoAgMr6CWCovd60gPxT3xVyFN5MORk8DtniJfozPSH/d2sRfCyk5LQu1q6NRyMB1+fmYVybIMyyIB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nl3xH61yAbRDNVCrUNJSNSkdWNwZ5gqNe2M20Z9ZNg=;
 b=dDRRVUNNzH8/3xSsPv3OElplmyEa9+OVvnIQHkYsKx50hGt/8EDNyJH1MyZdUvK6dv3kUrFnD9PWqMAVr5byV1fO0m6vYrb7AKwwnPQZhwNzR2BsEqEC4x7GMJZDMbZA6WDQVfi5QT/vcCCrYgtGTL62tBa7ZMRLQouKDUioW4W4TmQnPOJBZmiHSVhl9+2ApNq7Qcih4nqEMahnOW3340uPn4kADCT6MvUHS1WfGB/jUjQzNAv0rRBvwCuWV3IRNnmOVNltEJsjm/1mACMqXUtjKtp4FjfR9zMrWg5U5uRXkjFxdCqNej3TVo1XYdtod5w5cI/IcLZ5b/w6F59qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nl3xH61yAbRDNVCrUNJSNSkdWNwZ5gqNe2M20Z9ZNg=;
 b=tJI+0t+CnZSnJ6MZepcMATqSkZDnBXva1WR6M+vWzXXLuvq0CRal/zKBvpkmCqax0RIwTzgepS0tyFixClRpGSvJCr6+9gLlyZqLkwJ1MmwZUryrxS8QE0nu48sfSFewLjPagKTnthe/vtLSA4pTUGIsCgGzBaMZ3dtPpozi1Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 01:59:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 01:59:28 +0000
Message-ID: <57aae4cf-7e66-4adb-055d-698a75171d08@amd.com>
Date:   Sun, 18 Jun 2023 20:59:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/5] cpupower: Add support for amd_pstate mode change
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616121026.147691-1-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230616121026.147691-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:20::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba01e54-a701-40fc-300b-08db7068d079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CWdzB7/ZYfQ20zdCrFj1ZPlVCg3SUORwnb3Wpmz+KHzGjODMlSVQkznFsUO1kx/YAsUX2rTS1cBXQ4opuGhnEuBHP+kFD3dkLUlcStol6HILIkYG4hjl1UOccRIxfP4Sv1VrubZHpXS+YrY/7Z320B33YyZj98Q8mcDTRL86u+iomgjPKAxTFtAWtJSrP6KK7xMimGRX022eTzNZCsQUL08s2qNTbhn7/PNNNQuMIVUDI+kaWOfxyrP37X7chS99vAuf+lIDw65BmG8c29B5Xm49DrC6HtUieme/zVYNz/nRxkovQUzKLipRDO09MEdPiGgjlwc9+X9qUDNZd9C+wz4cR/qCmK38co5fRh5NIa+F5av26KftYWJDhUVvonTNinJkb141c6zHgn+lHm15yH0+EWpVpvJ7a7BhP6F0qIhGpWCypR53m8Ebv0A+xikEgPiNHGfqA4PP1D5hFQmOLnbILJHqPaTD8KhuN13Ju1yOEpYePt01ocx0iCcw5mkaynphmnUKPKwg60J9cWwYnXfGXSzbtIIpfKbyLS4exCcAy1CMIwudK+uSbmgf/sNO02vZf7QmYjJjCK2gKYzo95kNK5+kNhFYbAxl9+ybh+kq6dI5mwEhTEBsjdFuPcT3S5Pij+s8SkF3bqgYumfvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38100700002)(83380400001)(31696002)(44832011)(6486002)(86362001)(2906002)(5660300002)(6666004)(316002)(8936002)(6506007)(53546011)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEY5bVE1ZjFFQkNPYXF2dGhqQjRZcXQ4YWtUMkx2bFh5S2dHc3RYUENTMFNV?=
 =?utf-8?B?bGJackNkalJMK2c4Q2RtR0hNdHdzYUIyZGFwZG5ZQXc1Ym5nRGpZcU5JVE00?=
 =?utf-8?B?WEMrZERYY1NKOFROMkUrUEhEdGN3VkNxZkE3L1BSU0YzUzJTTGI1UXJiWmNK?=
 =?utf-8?B?QW1LWVJVY2tHVCtDL3dWdjdTZmRZbHhtWTRnZkYrUzBhcG9CMWVQL01UdXhm?=
 =?utf-8?B?d2NYM1BuODlLY0E0V21GOEFNNXVVN2l5TFZnaXpGTXd4US82ZDV1VU1XMzRB?=
 =?utf-8?B?T0pvUVJWeW5JTm0wODlncTZUdEtRZThodnVZdjU5VlRYcm5rQzUxQXZKMlJV?=
 =?utf-8?B?OE5IYzVEMFhMLzJUUi82cnZRbVBBUjBnNUNkbUdSbERuM28rZTcxOVp4Q3Vt?=
 =?utf-8?B?ODhGS29lQkJTS3JTdmN6WjZOUTlzY0s4eXN2SlNxSVJVaERDamFGOU9PTWt5?=
 =?utf-8?B?Y2dweXVabHJjQVFTWDBzY0xIbThydlFEOVl6akpJakdDSVA4c2Uyeko0SElj?=
 =?utf-8?B?UExWbzlzUnRPUVllVnRKei91VEhjbGJLNWREcTZxQmQ0NVlRSTNodElYdnAr?=
 =?utf-8?B?WUtWK0hiR1kvYWwxLy81cGhMdmxkV3RjMnErcjNKT0FpazlIdWhaTTFvUTYy?=
 =?utf-8?B?Rzg1bWJndGZRTmpMSW5MNExBVGNkQVd6eURhaTRodTJEaDJ1RENNNDFHcXZw?=
 =?utf-8?B?RkJkNERaL1ZuZms3QzR6Y2Mrd3dXNE9JYlVWbmdyUnorZnVzemk3Wm5GcnFs?=
 =?utf-8?B?aldDd1ZSdTVnYTcrRlBZQi9BdzcyRTdtMTgxZWZNNW9EQjgyT2xVYXlBTEMw?=
 =?utf-8?B?RFU1UnhjRUlJZTc0aXV4ZWMvZThjeTB3VnBtWElSNExnc0ovdjlYNCszNWZl?=
 =?utf-8?B?akZqYjdWMzU0ZWQzbzRGdWNqdlJ2OWRpZkhtWWtNMWEzWENTZ3hOd2dZZTM5?=
 =?utf-8?B?Ym90SkRDZEZwK3Rxd20xRVZzckhLMDFOTi9FNmVXZy9HNGRVNXJTQXQrNEl4?=
 =?utf-8?B?Y1FQMXlsbkRLY1hsT0dpZVNxMjJNeFZ5Y1NPaHA0blBvRDJJb3hHLzNQQUov?=
 =?utf-8?B?NWNpNDllMzdxM1kzWEZ2Qk0xTDN2T3hVcUk5dWtDUm05L1ptdzZqSEdJdXBH?=
 =?utf-8?B?dnM2bGRRaFl4NUhOR2xwNlZUbXA5eCtDVXd0SUFSOEpDL0pOdkM5d2IvbjFE?=
 =?utf-8?B?R244blhKWG5oelUwRU5PQXJkanRkQ3QxYXdzM2JEUHk5MkphWW5KSERNWlVC?=
 =?utf-8?B?amJpbk5pK0E0U3BtQW9Ka1RrOTcxTjNlYlFUbHpZeXh5ZkR5OThkc3NoZGdv?=
 =?utf-8?B?QS9aQWtMYndrVWdrWFJBQUZvQ1hML3FmTkdXT1ZwMzZodno1b3dLMG1SV0du?=
 =?utf-8?B?RElkeHBuOUlFNWFEd1pyWXR3aWFYemVsRm1CclZjcXk3K1ZwZ0lOcWV5R0FN?=
 =?utf-8?B?UTBsdnZtc1dyRXN6eVVsYUIvRXNjZWFMQ1lYSlo1L2I2LzZaQXlMNWxyb2tR?=
 =?utf-8?B?QStveWFrWFgrc0RHWUJCYk8rZ2hGNUlqTGk1c0cvZkI5NjRVWGJZZ1pBOHNY?=
 =?utf-8?B?eVpvUkdrMjhYdEpYaWtnTXpoVER4Ym1sN085YTdQS3F5aDM4TVNwNVlmRW9t?=
 =?utf-8?B?Ny9BNm8wdHJjdXp0SGpxZXg5d21WVjRwbU1jNlQwenUvSmIveFNBdWZYM1dq?=
 =?utf-8?B?Yko3M1VSdytybll6YzloNk9kQmFBeEtVdXNaZ1FSeTJlU2c5N1pqZHdoYnE3?=
 =?utf-8?B?MHh2UnpDSXNyUE92ck9ud2MrUWJOWFBEVHRLQjZhaXZRR2ZGVzhsNUQ2MWVv?=
 =?utf-8?B?eXZHbitqR0J0NnZMeGlFaTM3N0VGRlROQmdwMVo1S2pIaDhIRFJZY0kwVHYw?=
 =?utf-8?B?d2JuejBvNmprZk45YzR1MS9pVGhOR0pPNWJUT3VCQzVPR2FMbGF6QWxUOVVx?=
 =?utf-8?B?eThMMHV3RDkwVFhKWU9XQlJWOTZndHZONmtUYXN6QVNTSUNYYkdhcTZxUHph?=
 =?utf-8?B?VllQYkJkdnNwRFlnZGJ6WEFsSklJdEN0WlluVyt6em1IL3dMMFFjTXk5VGN0?=
 =?utf-8?B?QUF5VVdyNHA4VnVBMldYcWZ3R29VNS9ML2JENUIyQ3NMOVIxRHJybm5sUS9E?=
 =?utf-8?B?ckVjNFl6L1FvaEZITEVHTmliUXdlR3JRMkloK2hoNHFOSHZhQmovTmpqOGxG?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba01e54-a701-40fc-300b-08db7068d079
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 01:59:28.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDo4OkMTHi2x1C7mkKklrRBLmcZscd0UNXaGe5Bsl5GCdV3XB1QDKTv/uUgeMvNSH2fqYremZaXMzpmm3c3FzA==
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

On 6/16/23 07:10, Wyes Karny wrote:
> amd_pstate supports changing of its mode dynamically via `status` sysfs
> file. Add the same capability in cpupower. To change the mode to active
> mode use below command:
> 
> cpupower set --amd-pstate-mode active
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   tools/power/cpupower/utils/cpupower-set.c    | 24 ++++++++++++++++++--
>   tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>   tools/power/cpupower/utils/helpers/misc.c    | 18 +++++++++++++++
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index a789b123dbd4..c2ba69b7ea54 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -19,6 +19,7 @@
>   static struct option set_opts[] = {
>   	{"perf-bias", required_argument, NULL, 'b'},
>   	{"epp", required_argument, NULL, 'e'},
> +	{"amd-pstate-mode", required_argument, NULL, 'm'},
>   	{ },
>   };
>   
> @@ -39,12 +40,13 @@ int cmd_set(int argc, char **argv)
>   		struct {
>   			int perf_bias:1;
>   			int epp:1;
> +			int mode:1;
>   		};
>   		int params;
>   	} params;
>   	int perf_bias = 0;
>   	int ret = 0;
> -	char epp[30];
> +	char epp[30], mode[20];
>   
>   	ret = uname(&uts);
>   	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> @@ -58,7 +60,7 @@ int cmd_set(int argc, char **argv)
>   
>   	params.params = 0;
>   	/* parameter parsing */
> -	while ((ret = getopt_long(argc, argv, "b:e:",
> +	while ((ret = getopt_long(argc, argv, "b:e:m:",
>   						set_opts, NULL)) != -1) {
>   		switch (ret) {
>   		case 'b':
> @@ -81,6 +83,17 @@ int cmd_set(int argc, char **argv)
>   			}
>   			params.epp = 1;
>   			break;
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
>   		default:
>   			print_wrong_arg_exit();
>   		}
> @@ -89,6 +102,12 @@ int cmd_set(int argc, char **argv)
>   	if (!params.params)
>   		print_wrong_arg_exit();
>   
> +	if (params.mode) {
> +		ret = cpupower_set_amd_pstate_mode(mode);
> +		if (ret)
> +			fprintf(stderr, "Error setting mode\n");
> +	}
> +
>   	/* Default is: set all CPUs */
>   	if (bitmask_isallclear(cpus_chosen))
>   		bitmask_setall(cpus_chosen);
> @@ -123,6 +142,7 @@ int cmd_set(int argc, char **argv)
>   				break;
>   			}
>   		}
> +
>   	}
>   	return ret;
>   }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index 5d998de2d291..d35596631eef 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -117,6 +117,7 @@ extern int cpupower_intel_get_perf_bias(unsigned int cpu);
>   extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>   
>   extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +extern int cpupower_set_amd_pstate_mode(char *mode);
>   
>   /* Read/Write msr ****************************/
>   
> @@ -177,6 +178,8 @@ static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>   
>   static inline int cpupower_set_epp(unsigned int cpu, char *epp)
>   { return -1; };
> +static inline int cpupower_set_amd_pstate_mode(char *mode)
> +{ return -1; };
>   
>   /* Read/Write msr ****************************/
>   
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 63c3f26ef874..9df9af8a969e 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -106,6 +106,24 @@ int cpupower_set_epp(unsigned int cpu, char *epp)
>   	return 0;
>   }
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
>   bool cpupower_amd_pstate_enabled(void)
>   {
>   	char *driver = cpufreq_get_driver(0);

