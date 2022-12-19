Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E782C6516BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiLSXbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiLSXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:31:12 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B337260F8;
        Mon, 19 Dec 2022 15:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2q3vlvVf6n5vEwr4OiyiGy4sv5nUS0cVISzRoteLNaNlJOeEUYq6sUZiLHGVN44ISa7dxUEIG37DdvbgvoUob3v8spyaP8U4bZGdmKo8DErdLzZ/a4zoxgy1uow+W+25r0UpJn+hSScxwxKCk8653+vybmxpj3ekj/6xGNzKxuG+JFMRHvdeipOmOczMRF2GpU37V22lmZxPBxpzOc5sMyv03Fpq41e7VFb5ti22ZJQmFS87P1r5fRP05WMFF28a7v80roGolasgRoRSZ0UrsxZnWmKnDoEEfAZNL9r2w4Upr14EOBvg3fSqZZhIVvMTmZVywmCO52Er/LG56G4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyDHaUrdf8iQyCaGAkyr28r2o9aN+fY4Fg95u4B34BI=;
 b=W7R0hC493wYWCfspAB0lhD0siMM62lvf93pX6h/1LtTMrMVXwTTVVJV7LybsIXTi9Fx+NzH6s3as+hbiIf0JSsCuwDkyaJg5kAr78umxH6pMOcvP9JTige6n5e4d7+r3WX6BllnZH6/4fRPY2d9Gs7W2EtmuhFmoo0pJ1DbD4IPjhmYe1IyhTmtRJ/MKBorivURF7IdkVKOLop3gElYZNFePwXELsI7Q0sNvgAi6tJWQaa23hLK5oNQk9jBHBt8MsWbUESEHtfTZeoMAW1TJ9lQbK3dfX6HSIdx5jHtFmHyqrH1lVZg7B+bUlZ33Zm3jaKW2O00jt3FGt6M5kzAQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyDHaUrdf8iQyCaGAkyr28r2o9aN+fY4Fg95u4B34BI=;
 b=WxmNg+g+YN/ChoO55IreJ2Xlk8tID78suTQoEoJ8CVDxeaL0qQjn8icuRrGohkmhg6+9xNDaFaEEHyERwxya3BaaUUkAJSw5Vd2DZBADTlyIbXUTY6JaDMydnXktTOTML7aoQgdFNouZfhbkwJT1BfBeQTe8IVgyck6/mQNO2xE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 23:31:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 23:31:08 +0000
Message-ID: <8c6d4a0a-065d-cd01-7799-5f6603c0ebb8@amd.com>
Date:   Mon, 19 Dec 2022 17:31:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 12/13] cpufreq: amd-pstate: convert sprintf with
 sysfs_emit()
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-13-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-13-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:208:23e::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: b97f176a-3b5b-4345-0443-08dae2191b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2NjzEl8U5SlM8j0Wl5XzDAvP0qUKGGCz22ahi1L5L7+SOuCg/S7RcrjKmRgscoNE9fkMy9vD7lS/n4Zg7NW8O7huiOntgjChtdvGxE4uG4mun++x36Y67c0UUSyOfntWXQYrSaxvAeu4RKxre5zSoy1z9by7fh7D6702mCuL6b99RnQBqFsQEJvDZqeLXxNNivxoyyvXq2bPaugHqFBWQKI/asR2/Xdyq30OHbVxV5zlkSTUivhPxzuCW/9XKMSNkrDqVtvzdgYnMglDe5olTWx1kVHgdcq/KvE0YPcSmYbZK8sGEF/sf8xhOe4KsrRgnRDFq17UJrqi8L7krpS0dv8HfZ80vRgEQIxLbvYwo6z4QFWwkExZeHbZj0DAsVL7j8rs6OISQk03DpdYkbyQQjpOOaceB9q4gqm3jsffDB0VWngx+tHwUAUE4PZajc/0+1XgymJjBML4gLJJrNfRYthRa76pd24HAHU6EkGVBqNO9IySxDgkCEvQLgXYVLsTX5FR6SMwhXSe+1hxqNDVZDsAl185FUXYzHJaRjEpGZBVMTwmCBoGpT6tPGlIVcU+3yxpuaO3MkE4zhNVxMcJEgrPk8awsoqBHAsv6vouD/55eYoG1NTz3aIzB41uYtIXk+uPwCBzQFEzXpzCzguspsSKwLWsx4e5T4GZPLszhnNzrlLdrdXqH7PyXFdVREK9JtJA/HKzd0LyqpdDEqyEJIkYb5AfAAaUZvJA1Z8gcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(26005)(6512007)(6486002)(316002)(186003)(4326008)(8676002)(66946007)(66476007)(2616005)(31686004)(53546011)(66556008)(6506007)(478600001)(41300700001)(8936002)(2906002)(5660300002)(83380400001)(36756003)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hrU3lhV0l5b2xWVnJJMWNNNlJPSXNGYmpRZGhqZUpHRWlpQXo1ZG02REZP?=
 =?utf-8?B?cWoySDdDMUZZbkhkL3lDMHZGSGxZbUoxOHc1VjMwdkY2akFUSm5YVHJmZE9z?=
 =?utf-8?B?WWNjeHJZWitOUnVQSnhKbFYrbXZxV3lsN0taNWozeUNwSFNxVG0wZTQ2Qzc3?=
 =?utf-8?B?RVgvMUF5Si9TOHJPZ29SM2cycWxZVGUwY3ZUN1hhbUl2ZE9xdVdzcmY2N1kx?=
 =?utf-8?B?MlVLSlJ4VVAybXliekJzd1Z2T2NzQytDQ0VLUytHWlJQT09SZ3NoMHhMS2U3?=
 =?utf-8?B?K21MTldpQlNwRXYvTGQ1cjFPVWFyaXFTSStHamI5YkJDS29YKzAvbW93MlNz?=
 =?utf-8?B?QXBkQm85Z3JQcHBwZ29laXNtbFk0L3R1MG1kSS9XaGEzajlIVmVXZElVU1FI?=
 =?utf-8?B?d1M4eGxHSTAycTB6dE9Dbysrd2pwSURYQjZYaE1WUDRkTzdOeGd6dnh2Z1Ft?=
 =?utf-8?B?K2lXTHNFeXFvbVZXWHE2UWZTUXNRSVl0R2JISWc5a2d4UmxQeUZUc1U1ZGMx?=
 =?utf-8?B?Tk9aT2FnMTgxOFJEUExvNzNWZXZTT3FxdWdtazVYMmRwQ1dBTFZpRWRSbTk0?=
 =?utf-8?B?RjZ3UTRJaTBDNllVaFhCdDFDbXY0MEJNOUQzL05GU3FHbnhKU1dXSitIaEh0?=
 =?utf-8?B?MkZLUnFBQWZrTE5zeitOOFVUaTdlRm5JRXNiVW9YdHBzU2d6bWYzaWFrVGVz?=
 =?utf-8?B?WVVwMnFlaEM1ZmlISWRFRHdqNWJERmlkSXYrTlZxajh6K2k3cnJxYTA5TmlB?=
 =?utf-8?B?T2tNYys0NXlkcHZoME5IQ2tsNmdqR0xFcWp5ZjVuU2NnVHpQRVpScE40d3Z1?=
 =?utf-8?B?REFBbHU2M3ViVTdnSVZqZ0ZFcmhPeXIzZnVvVVE3RGFrejR3WG1yR0p1MXFC?=
 =?utf-8?B?Y2UzY2FaSFU3WjlFY0xoT1E2Z3B4R1NwZ1cwczlXMkdJSXY0am1ZYkRndldk?=
 =?utf-8?B?SHJENTNQdWl1aGxGc2E5STZpOVJrV2FTSDFLVzhSNEhicEJycUNpVWljUEVV?=
 =?utf-8?B?Mm1CNVJmMndBN3JOS2QwZzdiK2lUc0trZDhwZEFsZ3UrekdCZ2NLYW1RMnZx?=
 =?utf-8?B?K04rTmk3bkFxT2pYbXVvN2ZnTkZGRGJCWTRCV25naXIxcmVWODlweGpKR1RX?=
 =?utf-8?B?amNlVFBTbG52ZzdqSHc2Q1ZlTDgrWnZORkhuMjE1Y2JnN1A5bkxkekdwWjhO?=
 =?utf-8?B?UjU4bmdVMXBYSFMwNG5OK3dIZk5MaFZYOHRiSUwrUW5ZZFhvZXRHTUNqenQz?=
 =?utf-8?B?RFhqNmV0SUpPMkZBNmNiblc4R3RxUVJlQ0ZlTGhRZGhuRyt3MFhCd2FtSXVI?=
 =?utf-8?B?TFhSend0MDZCRnV4OFBuYWp4TTkvWjkxczlEZkUwNm50ZDQzQmpvR3Vvb2hn?=
 =?utf-8?B?bFc1UHh0Q1lNYjdMQ09tR3hldTFmTTBtTC9NUi9kNkY0QTB5N0dYblBNdXB2?=
 =?utf-8?B?QlFlalZ4ZnNhZkJxckx1TWE5eWdkNGNkUG5IYkI4azJGUmhQR3pYSXVsSkpJ?=
 =?utf-8?B?UlhoKzV3Mm5hdVFRUFFUU0d2YnZTRXhrMCtzRkkxSUJWS1N3Y1NyZWFONUVw?=
 =?utf-8?B?YUh0MGh5YVcweGJOVVBWQXpXREpGaEYzY1k2Tm1IV2x0STBJVkF6emNCYis4?=
 =?utf-8?B?bjBFQ3k3OTQvOWNIb0lXK1R4MU5YNnY2NW9MUlFtRzROYWJ6T2RQalhVMGR5?=
 =?utf-8?B?Mi9IbWtZc1VuNE4rdm9ITFZYTVN4dlVsT0FmdnhjcDQwWnlWY3c0Snl6UGFz?=
 =?utf-8?B?TlhrQUFaY0tDNktHSy9OSlk0V0p2QzVsT3B6NFdQSTVBKzdTVkNmTSt0MGto?=
 =?utf-8?B?aUlQQ3BzN1hPMzJ6Z2hXMnM2UGJGYmVKQ0ozamMvQnhtK01LUEpSUldmOXlJ?=
 =?utf-8?B?VEdwSkl6NXpEaFhwb3pId3hFWjhvY2wxUE9iVnVNY2REOHlOU014MVFTRXEv?=
 =?utf-8?B?OXFyYzllK3p3MFZwR05rZk5rZHN0Sm5ySENwNm92YXg0L3ZzcmNsMzUrajdY?=
 =?utf-8?B?eVlNWkhNZnhhbGFHNUozSFJxY3NxSWtaSkNtd01MYWw3bTFGQnptbXpZQXhI?=
 =?utf-8?B?c3FoQmRzRS9lbTJmYndVdW9uQWgrbVh6RVkrWisyUU50RnFuRnl1NHoyVkFO?=
 =?utf-8?Q?b2K1SbiJwyVLpZ38Owneuzkbr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f176a-3b5b-4345-0443-08dae2191b3d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 23:31:08.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhsyLV3WwFS5VX/XdoZFd3axm0s88yYkoIU3EOQRtOzCZaO00wUdhonldo/wzyv5yYQsJlxS64R+Hnpi7rYokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2022 00:40, Perry Yuan wrote:
> replace the sprintf with a more generic sysfs_emit function
> 
> No potential function impact

Anything is possible!  "No intended functional impact." I believe is 
what you meant =)

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

With commit message fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e8996e937e63..d8b182614c18 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -709,7 +709,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>   	if (max_freq < 0)
>   		return max_freq;
>   
> -	return sprintf(&buf[0], "%u\n", max_freq);
> +	return sysfs_emit(buf, "%u\n", max_freq);
>   }
>   
>   static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>   	if (freq < 0)
>   		return freq;
>   
> -	return sprintf(&buf[0], "%u\n", freq);
> +	return sysfs_emit(buf, "%u\n", freq);
>   }
>   
>   /*
> @@ -737,7 +737,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   
>   	perf = READ_ONCE(cpudata->highest_perf);
>   
> -	return sprintf(&buf[0], "%u\n", perf);
> +	return sysfs_emit(buf, "%u\n", perf);
>   }
>   
>   static ssize_t show_energy_performance_available_preferences(

