Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD467313B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjASFeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASFdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:33:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF995BD;
        Wed, 18 Jan 2023 21:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApyicA4BHiRWB2BPAWB1HMhxnWdT/lk6JQTb4mVdqDUM/0jfYyeYSUbKHu28dV8yFEIekzzSS5YRYNZzWPcI0YdP5jlvonxX/6jeaPQU6/314XCfGil1gB7A9BiUZY6F6mq3j5eR+mdndd7KDSbQC52peLl9IEJt9oQl5APtWj8wpX5HWwuznLUQQb18ydqRWJ6r6djQBJRMZiuMiuYCVu2W2mm0uLRuqDF65pS8mUypuCVOAa5TRXmRuY1EFQrKwDSJtXQs/BNFlTMd7pNlgLkonjzI/4c1m72sEhlwcJe7lWxUEzcltozHsTKrPsFK6gZNHos0TY9spHBIQUgnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd4gbcPSh6XwLjo7lR3up/+6dVBpy6hUMR96TXVknWY=;
 b=lniv8uhxySyDqtUGMcPEQ9LmAqXH+9S99zq1deir2FPN0gdQDLIQzuw18FkM0NE7P67hyPcEKWFkV9NGSiMrlHsgTikZcULiaW86JA2lG6gcUbGoCuX+aJ6x6sejWPUqR2zOVJtThnHsTwmjEqlnPAkToepl3lR2773SVDgk+FVlSlK7m+I5PmfielN2vLFzI14X8j4rdv7coAqfMhh1WUmI14cECArRczLKM7YvOyp0AwPJBRugAMCLblBagvKB8H7Gv2aw4OV00HX2eZhg1PzUTrsyAeg4LX7ikSRmMKsbAn1k1jQVcs+xVLYqYYcGppwV2LmSzg44BbmuDMerAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd4gbcPSh6XwLjo7lR3up/+6dVBpy6hUMR96TXVknWY=;
 b=S9hzaa8WYiUzywvKCl6haRuA7zQ57qGdHNIohbfxE4jWRcsb8m34OFnnjGMl5lya6TmIVShToqQQ4eSH1HhFzUJQt4oJZkHxG3x6JAuUQMkhCJwDBHqYyJvEylN+t7uHwA6JLbsxGl8CeBZR0HaN2kOjZO8nTYwpI8CrPr8/UT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:33:33 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:33:33 +0000
Message-ID: <4e2675b7-6d6f-7d24-1b78-400431723ecc@amd.com>
Date:   Thu, 19 Jan 2023 11:03:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 10/11] cpufreq: amd-pstate: convert sprintf with
 sysfs_emit()
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
        ray.huang@amd.com
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-11-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-11-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::16) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 872dbe6d-1edb-4c0a-0aa5-08daf9deb45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Nk9YG8Rj1EieXQEv83nlqRQZT5nnCla5/RSzEYOdC0Et7FeGDoE1PD1zBpQ+oGD/lm7pAM4Gl/3pd6hE6zpO0OdxusRbKz11qhdrLvYCvcdmgNk6Bv0fXJqdFg2RDosnU3NF3AS4bUHidtNRV5ELtQWVrx90oq7lUwnpvQc/1qtwCC29QQaiaBDT4jXVienJfAdsi2fph6IoPreFgS51cT2JY5+fTcTyoL4w21IMroL5hsqf1ld9WPv0mZG30DqAIgNbpdJrwvotPNmSKAmsRxeWPCAIcZ65ydu9SkoYUlt74febCzvcvmaZGwmzgk4ZBQ5CwbWPgbH444z7s+aXRs0bbLbH3dXFg/7lg/6K5695bJBzhu+xs46MLJnA/1u1dm31qwp3o5bzDMKOaokhaDNGyitIaf26Hwb57Vcunk4V1wvuRNyY4DNqlw8IBNvbL7wM83MRT9OyVWa8UBXtCxCEIFpZDgW0SXcCsoqWtSyeeVUjGZNmW7820xSVLjKXECzhImTE9f/D/kXCcsNDizuVjezR/hWY6t3a8pNAX82YfKOIbfPAi+dyFs4kvBtohZ+ci90Qk6D55naQnCEFqfvUqIUlUyz8OXma7EJW0wyFo2hE9fPiUFaeQuYsL8QuimSvpAMpcQTzD8e8dN5BPhpu6vXnY3NzBPD5Bxb2KGu8aaVZ5oV004OEAwPO9B0+Rw/iEIC0j5qg/8iWd5Zv/oWdb2BVG8ler59m586BsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(2906002)(66946007)(66556008)(8936002)(5660300002)(6862004)(31696002)(38100700002)(316002)(6666004)(37006003)(6636002)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRuVkZTenZxcmFVYTYwRlU2Q3dkUDZ1K2RmaFUydzFnSmozSHdHbnRRdU1Y?=
 =?utf-8?B?R2krQ1hLSmEvRzRjdFFrSk1qREN3SUdISGxlNFVsTnhBdlpzd0c0RFB5dHI4?=
 =?utf-8?B?RkpzU0wzSXRnWXdGS3lZUnVqSXZibmZhV2lSUlBhbUhqUzR0RTNRTS9iOWpE?=
 =?utf-8?B?L2VOc3o1MjhJanIzTWxKL0t1cnU1VUtIckV6VC9ycHQ1a3NmOFNiaW5HNmd4?=
 =?utf-8?B?dW5PMkQ4RGZxQkxUdnRnYkVwQW1YdW53K3hSMlF1eGZnaEZTaEE1aEVCWXlo?=
 =?utf-8?B?RE5ma3dQdFBNUHFueHExV2wycW1tYkRTQ1JLWWpXT2JZVUlDMitCbWZwa1VG?=
 =?utf-8?B?MFNTcUZ5R2JXVTErMktCZUgybnc0cTRES0I5OWYzTmtFTXQvZEZvZGRsZDMx?=
 =?utf-8?B?T3k5Ri96eG5OV05CNzRBRmZTQnBXMFFOTXNFSVRSdWd6WHpXSE1WMTRSakdK?=
 =?utf-8?B?bGhWQ1FzQzlTcUJrYi9USlBObVlzVVpxMXUxUXdyODV1cW1HU054Umx1MDZ0?=
 =?utf-8?B?T0FxekQvUk1iZm9mQ3FDMzR1NFlUanhBS0ZyQk11S2RCWEVDREU5Q0oxc0lj?=
 =?utf-8?B?WWljcVEyVCtJMitncUNZVXc3aCs4NC9JNnBBTFZEd2VWSW5lWm11QzA1MWVH?=
 =?utf-8?B?REFZeG55QWFTR0o5Umx2V0hwWHI4dGJ0WUVaeG9vM2owV3NuYnpJVXlXZlJk?=
 =?utf-8?B?V0RJYUp3VjYzYVFNdHBnTldScklwQ1g3M0N6VkxERVU4UWhaSFNTSGhXcStz?=
 =?utf-8?B?T0VHZG8wSXVYSjNLYlczS0hkcm5VWDFDaUZkWllxUzdPd1FEd1FLQXJSbi9F?=
 =?utf-8?B?dmEyb3RaTlJZMWhWNDkxbUJMRXJ2dlRicEFINW01NU51b0o4MUtJOVR4QS8v?=
 =?utf-8?B?TzF5YXB0NzhsNHExVW5DcEorOWZ0RGNRREZZZ1Z3ZWExU0IvSE1QRzQ3Qml0?=
 =?utf-8?B?cmlUcmF3TDlIQlhFSUg4aFdhZm11eEJKTW9NRlpOYjhNdU9aenZ1RVN1di9V?=
 =?utf-8?B?YnJHVWFsY25KWU4wcHlHeDZtbnR0NFp3VUxvVE9NTkp2aE9iTS9vT0FtNnhT?=
 =?utf-8?B?NkVMcDRRV3pCWUR6eFpPWmZjTm1IMzlDYXVRWGhpVER4YVcvdGxBR1dyekNs?=
 =?utf-8?B?RjEvUmhEbTJyUE1wOVNWVGpVcU9xcGhYL0JST1F5WC9FamRFVU1QQWJ0dWpN?=
 =?utf-8?B?NVJYc3kwZHpQZUJBRlpLamJPWDlTWk1RUTVDMkxjRStKM2R6ajE1OWxjcGlY?=
 =?utf-8?B?a1ltWGNiUUc4WkMwaXdCU3BFL1gxWUNINFlqb0pGbDRudDdOSzFraFhZMTRs?=
 =?utf-8?B?cDJoZG8rWGVLOFZ1Rml4K0dic0U3M0x5WVlYekV3RmFOMkowblBuRWN3MW82?=
 =?utf-8?B?QzV3TDgwR0dmamZ5bDNBSFVGVDg3amFLdUFiVzFOdUExVmF0RkFLajlTT3hw?=
 =?utf-8?B?dlVTa2RqaWgzNzlueWhkaUNaeWZiVzY4dVlwNlVOaEQ5OFhzTnVPUmhBeWpN?=
 =?utf-8?B?ZFdTSzNobXdndHNPMEdPWjNpc2wyOUxURzBMRk4yTXQrZWdoYUtsVW1Ea3RU?=
 =?utf-8?B?NmhxOHh1RUJCczNFWld2MEFUbzZwZXB4cTVsSytVZ3NFQjEyZmFZQy9Yd3FS?=
 =?utf-8?B?TXlSamhZelhnTlpRUDB2bWlDb1ZOZkRJUnhsRGhSMXJkTmF0dE8rWWJNTUlo?=
 =?utf-8?B?R1N3RlZ2RXlqV2llTnVVbXU1ZEE2WW5SLzRHTTF3NUFLc2QzYTRyelF5eXQv?=
 =?utf-8?B?N1NTS055aEJDTUVqYzFoYzQ0enBVOVBBZVFpcmlKWXgrYjhQQ0JITy92OEdG?=
 =?utf-8?B?Z2lUSlhFTlZUekRVYmh4QVJyTHdNWGloQ1pRYi93VFA1T3NXWDFjOTl1MGMy?=
 =?utf-8?B?aldGRlJiUXdHOWZ0WnVhN3ZHdkhQVEQxVXhodXVQaEJibzE3ME1JVmdKdHFq?=
 =?utf-8?B?T05EQnMyaUtWd0wwZ3J2WFZLLzlyR1YxL2t4dXVUT0FRZnFOYVJ1cDIvWUx2?=
 =?utf-8?B?YlM0bnlWTnhROXpZUW9FKzdlM0pqbzVvSGt2VTNjUDJ1bWxNaWh3eW1PeUds?=
 =?utf-8?B?UHJJWE85cmNlNHJabXNQN1FJYytqWUpTYzE3TkhVQW1xSWdjcHJUME1jME9E?=
 =?utf-8?Q?SIlkxSlI7G/rb3DyHGp/vNkHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872dbe6d-1edb-4c0a-0aa5-08daf9deb45f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:33:33.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7164yYqXg7QvAY9JmAoklS/5yV8LAiOpr7Ti7rt8Wx7bhj4vlbhe10rbbLmr7hiska5uErBI5TPcV4VaDWamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> replace the sprintf with a more generic sysfs_emit function
> 
> No intended potential function impact
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2e5e594dc41e..c307d67a76ae 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -694,7 +694,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  	if (max_freq < 0)
>  		return max_freq;
>  
> -	return sprintf(&buf[0], "%u\n", max_freq);
> +	return sysfs_emit(buf, "%u\n", max_freq);
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -707,7 +707,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  	if (freq < 0)
>  		return freq;
>  
> -	return sprintf(&buf[0], "%u\n", freq);
> +	return sysfs_emit(buf, "%u\n", freq);
>  }
>  
>  /*
> @@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  
>  	perf = READ_ONCE(cpudata->highest_perf);
>  
> -	return sprintf(&buf[0], "%u\n", perf);
> +	return sysfs_emit(buf, "%u\n", perf);
>  }
>  
>  static ssize_t show_energy_performance_available_preferences(

-- 
Thanks & Regards,
Wyes
