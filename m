Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9115B9F97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIOQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:24:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2259DF88;
        Thu, 15 Sep 2022 09:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3GfGenJE5X1Br8y5X3BndT7zEh1zYaWy7CO+zuuuHvj0IQngIv0TRMO2pcVTqOibiBzABvFQ51quAyD9gYhW+mlaw3o72tXJnJnqTSHxRvE1rKY0OHSoXLVp2vwx1uGshAEra5kPKCnGaQY6RL4yG/JVstk+eNcu9RKdoGI6xYSZVhb92VGaYgJW4nKOXyW2xlklui0Q391myh3yGGblu8vZTHspTBZOqaXwE6ONMStvfbemFgI6NBvB2Hrc3ePAmbrvejHU8nFb0+cGyY/GH1ah5vyRsbG+F6kuf8nxJC0VVnCKxdCWrAmtmNNYMSAKct3OLQ/FsHStO0XTdiHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hj29BJGIdHW4Fl11Bf81prw/NEj61ThvD+kx6OKNvQ=;
 b=kognGPyyCMfsuG4eB7Tn7Js/ICylYCjBCZqG394ctcSflgxtaCQmljg0mGEDBnKRdUWj+z+5suIGfnwzwl57eM+UWhgEnQd6kMYoO3ptQCANRkIbP0UIigJ8agjYb7dcn8fGgSnMdzowCb114bgnpzjp00mk049iF0CFBQczeZcNelPGmSbd7gJx7De4wxM8BJEhpoadT8VmKFiZ/6V4e77KAb2q35IV8SHVT7Lf0EsnCw3DMFoqEUDvAl8uRX2IgaJBBmDbZp+zCpK/vHD5thwJghBo1TngIQ+LRFf5dg9qhjOjaRD0/Tia0R7cQo0w1vmuMa/+21gtpJmTjS5PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hj29BJGIdHW4Fl11Bf81prw/NEj61ThvD+kx6OKNvQ=;
 b=mddNS3+CW8vmC7/ELZgT5r/ro7EcIXpGm0hj/Fa4GeDvd2BtAv2UNFY4we+1D6Bljff6T7eA9wHvA8RjFLnecM5iuYlo7aq0I8HG06r6Z3boTc39KbaNPt34IM/nLgbnzdg+P8f6EIjx78xd7e2uWRvg+5f0moo1OCnJIopJK4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 15 Sep
 2022 16:24:08 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 16:24:08 +0000
Message-ID: <a21bdd7d-3ade-4a54-1a7f-42831ce8e83a@amd.com>
Date:   Thu, 15 Sep 2022 11:24:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <20220909164534.71864-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::18) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 676bd08c-bdb2-420b-300c-08da9736b724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+o/bbhNdPxFyv3TXlr4ua3yrNhyiCxrJ++9bGVt/pSNt06EA8A1GnhUn0t9mv8MY+JfeyUnQOSUvvc9gGrSi9ZmTGr/fzgggw6myF86LI1NWYLeXGuhT2IiD558EvFea3VEPO8k66v0vw+0I3d0RE6jDwna+ie1GfP6p2IaYgIfb2DcQS0x1SEgZo+qrXYD1kHCBlxekMuKFmER5w3rNc3/+wks+s9/8cn+iylzcZ7yNs6Ozw+QmjJmjXL1MpSaN58iN7LYTgSU9ZMVS3dKp+Fb8igqIKawQc1QFomKZIRBaGzIUzQsE/7BOqEwuS3fgmnXHJg+KYu+mLQrkWKqKfzltFvCR2kGF0EBouQLTtAqnGMerEhSYLxTv3NFE/ncyUbOjYgibvEuMLpc/C7jXVvNhQhlX85fHgzPJIfO3jFgAM9qrXTUWd4xr1Zekj842rgaunkKNq+786Jbj11WxyQUKjCsvOnhJ7jrQHrGKu8/bXz1POyBMwdmin2hLw7paSI5Mwmb2WoxZhSN58rnW1OD/HexcyO8Ep4gsulrlhpnh8zzIp3Q5B6zLjactytYU+e0654rSROvVCt8SKShZJ0S0466d6z4OWrrHKiUEtxfo4lD3KzGF5ElCLzoP4fu4FHUCUYUZPyF5UN5fx/IwUAW10+hu6sWCd6nt9oknf4m2RZgZMTf2urxyfr/x3FW+Dznjxx2CeiM/ZhqTX/aQ+xKfRbmOMEuiIkBW4LbQZu9k1i11mjLD1wMNnuKH4Ag0eIrb7M5Ju0hqgtJxJe3OpV2GDA6Wu8KLNeympI7UFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(6486002)(6506007)(66476007)(2616005)(8676002)(31686004)(31696002)(36756003)(53546011)(2906002)(6512007)(186003)(86362001)(83380400001)(38100700002)(66556008)(8936002)(5660300002)(44832011)(316002)(66946007)(478600001)(26005)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1lU3Bjb202blA0b3c2YVRPbzZIclRLRGlwdmJsNy9tVGFQYWtPVktrSEZt?=
 =?utf-8?B?bE44OExMRi90Q3V4K1VCZXBBcUxNazZpQW1kNEMwdFVzSnptYWxnNXZTTGVj?=
 =?utf-8?B?UUlSVGhPRi9xdHRnSDVjMTc0NnFVc1hQQlhmVDZ6S1ZpWTgwWWF0ZWYyd0JL?=
 =?utf-8?B?UU1KQ1FicU11aE5mcWM5akpyOXVNMzByNEhzaVJKZ09CV1F0MzdsZ0dRbmxm?=
 =?utf-8?B?dmYxdHBiUjlneEc2YUpYMnIxdUlMYU56YlJXVHJuVGRvS2pIRjlhREdkYXM3?=
 =?utf-8?B?QnYyS0lJNEl6a05oRi8xaFQ4QTNROVFVdVphSDNLaDlWc2JUeHJHbzV2USs2?=
 =?utf-8?B?dzZxZEhZd0xRVVU1R00veFk3M3ZOV1hVa3kvVlFQRGNYRFpncnY4VEZEalp2?=
 =?utf-8?B?UWNpaWo5V1FXalVmWld4MDByeHNTdkJHdTEzbGRsejREclBjdktCekk4UEov?=
 =?utf-8?B?V0JJRzB2c2RwQitJWUdZNmN3a2xyck5Ka2E0cXlUaEdTeHY1U2lVUU1rVGha?=
 =?utf-8?B?Nm15b0NzSEdhSHRyUXVqMDlJOFZBa00vQ3g1cmRIZEp6OUJrMzJrUG01Mnpn?=
 =?utf-8?B?WnlpbFpTWVpqMlhJTlhVMTFJQUtRb3dNUkhGZ1RUOTFKcUFidHJOTzJtVW4w?=
 =?utf-8?B?S0NPQzhYQnp0bkdoTlpBcU5neCtNQmNTZ09xam8ydGk1R0w0N2xzZHNuWjhO?=
 =?utf-8?B?WFlRdUJlZlZRbzY1Yjg5Q1VJNjg1QmJ3TWI0U3c0WnN5ODd2WFpySlp3WXl0?=
 =?utf-8?B?TVl4dlUrMGw2dnNSMUtWd1dJelo3YTlNeWprTUlpOHhhUzdEZXJlbExvYkpa?=
 =?utf-8?B?cHRQV3pNbVpFc0IzdGJBQ0d1TGJvdld4dVpLeWxpQll1bXZDRDFwWkwzRjlJ?=
 =?utf-8?B?WjVyamVZTmorcHZ5eXZJcnBYODVNRzFKTkZ2U3J5S1VLOWZnUzJGdHA0OXN0?=
 =?utf-8?B?enlsTTRaRE5LYW5NVlFqRlpOUnhxd0E1VUpXTVBIZnlUSHFXWlIzeW9ZN2Qv?=
 =?utf-8?B?bWR5V0YwZEkzbkRHWnJFWFBxUU1TaHdWaUd4YS9kTzFVNUZkV3NrWDZWYy9a?=
 =?utf-8?B?dEN1a3ZKVXBwYy9CcXgxc2N1bmsrekllaUgxZExJekdjemc2TldJQldZV3Jk?=
 =?utf-8?B?VUg3Y0Y3U1FyTkZZYnRwT1NFRjdhWmp5OVEyUWExTWo4dkJEenh5UG14K1Y2?=
 =?utf-8?B?OGV3WU9GUlZ1YnZmNlNORXJPQVpGQTRMdTgxZ0R6VjJNRFZ2a0NVR1hhSERw?=
 =?utf-8?B?bENwRzliYW9kS1U3VjhKa3dxME1HdC9OeXRuaENtTTRsWU5PdDdJeTlwTGxC?=
 =?utf-8?B?ZW9vYnZHUCtRVXZHd3ltY1pnZ2tGZ0Vab1AxWCtiN2phY0JKWndhcC9QaTJL?=
 =?utf-8?B?aUsvaHJSZFUyZ3JrTStUS3NRbGZyNE94bXEzVW5qT2VsS29PdjVhZW1nV3A3?=
 =?utf-8?B?eWhHYnpCS2gzOHVMREZSNU5EMUEwaUJGWi9DOTY1SFl0MHh3Tmp5Q1l4Z3hX?=
 =?utf-8?B?NnhPTjYwK2tITThmNWJkM21XZngvUEFuM21SNWl2S0JzYitTVlRzMklvdjZu?=
 =?utf-8?B?cEc4Y2FiSW1zNDZYcENmUEpnQ01BckRYUTIzczlUK3BlMWs2RGppVTZHYWdH?=
 =?utf-8?B?b3lnUUZEOTB6YTYrbG1zanMyVFBKcTMwMEptQlJsYUx0V3NPdEVEUHpqeGVW?=
 =?utf-8?B?SlNJNUd3OFJheWROMnhCRUJDdDM0RU9oK01oTGpqbWVaV2R1UWZZbnRsK2VC?=
 =?utf-8?B?dnpUbndaVER2NTVEeDlDZjJTanBlRW9LUEE0VGhFdUZtdTNzWXJEakhSczhC?=
 =?utf-8?B?S085Y2RiWVZHVHNSRi9lR05xRHdGeFVUWTdEWEc1UWtQR0tpV3hmaFF3Y3VR?=
 =?utf-8?B?NTdzRjhmL3ZUdEIrS3YvUjVaV1Z0bURES2pCaGs1V2U2QzV4QmJFb1RGcmRv?=
 =?utf-8?B?Vm16NWp5NFBNWHJ0c2t3QTIxQmhVWjJ1Mi9nUmhPR05vRStpNEpBZ3g2S2xo?=
 =?utf-8?B?UnlFczNkd0NPR0VVM0V0bk1Qd3JXeWtXWVVYQlEyUURvNlpOOVJncitJTXNn?=
 =?utf-8?B?ak5aMFBmeERyQ2EvMTVoazdaWFdaRXI2S3JyYUszSXhlRnpmcjlPSTJZc2NM?=
 =?utf-8?Q?rFSm6hCHQIfh8IyfzqpRjmhUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676bd08c-bdb2-420b-300c-08da9736b724
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 16:24:08.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aThPdvg9yRc47UwtJQOT3pd5aCQ65D1gOLKKT1erOv64kQ+h3dXLZ1sXbyEfYhJMIrYT2+zQDZbLI1lEkAXAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 11:45, Perry Yuan wrote:
> Add Energy Performance Preference support for AMD SOCs which only
> support the shared memory interface that implemented on Zen2 and Zen3
> processors, because this type CPU has no MSR supported, it will use
> ACPI PCC channel to enable EPP and reset desired perf to be zero.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 451295284a26..fff298744a8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -133,12 +133,24 @@ static inline int pstate_enable(bool enable)
>  
>  static int cppc_enable(bool enable)
>  {
> +	struct cppc_perf_ctrls perf_ctrls;
>  	int cpu, ret = 0;
>  
>  	for_each_present_cpu(cpu) {
>  		ret = cppc_set_enable(cpu, enable);
>  		if (ret)
>  			return ret;
> +
> +	/* Enable active mode for EPP */
> +	ret = cppc_set_auto_epp(cpu, enable);
> +	if (ret)
> +		return ret;
> +
> +	/* Set zero to desired perf to enable EPP control*/
> +	perf_ctrls.desired_perf = 0;
> +	ret = cppc_set_perf(cpu, &perf_ctrls);
> +	if (ret)
> +		return ret;

Shouldn't this entire block be indented one additional tab over since its
part of the for_each_present_cpu() loop?

-Nathan

>  	}
>  
>  	return ret;
