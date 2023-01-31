Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFC682E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAaNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAaNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:37:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19CA24126;
        Tue, 31 Jan 2023 05:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKgGiG5OgLteLy77BhxZIZPOq6C+7GmZTXhBrftxYUsUCrliJHYCjJNOivLO3I3XKA8YB0B3IYoUWPkvq8zkHa9nBz3oq5KbPtMrcu2pSWslBnLYWG07dj0ZoWAfn93xU3iAGWzeq3U33Lb5GC+DVKpWinkAQFR6+WX0rbypuXv4Zo2TpM31t3MOh1mv4u9cl1DjRm+aKwyV/4H+C1VnmP4WIDVh6XE1TlU5SlPFmweVEd+eLw13tqEJr7SlbfoENtFENhkOT6p6GOYuCaW6tYiyIa3mv9Yf9qJsEO9HeIENBScKcCTl6l9Q85LVgqIYYFxcvllkTrl2mo5ixNdXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf002dL8z0zPbSt72lMQbll6jRkDmhNkWKGq4xLHOkk=;
 b=nIruh1+hYvD5P+G7jGlfcYSpTTbiu0o8R8vgbAP2g2Gxmd9CSIEHQ5xWipkMTUphU+QuQS6+aXSfVTQRKXwhw3G1MJtVg9fOoHQfuhHtAY+W5Kq+vybiAoT+wPRAGFwP45cdNdX67vvy1u99itfXwMlblqo3VVS0i9ttIe/H0n1jyCcSAHHJ7yQdoqm1rEHqMBPOm9eWBVTj5KE8kxYc/uHvOBgGjpvJNgmcqZCFQeY+koDJmoGRDiPMQKaIrA6J7KaeRGEpayEqXRtc+ZtmRb4DOUthsqJKmUsMQ+7oQNABxJqiOpYdFR/XVjdV7oo/i0zBa/6iz1eC7vaE/szi8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf002dL8z0zPbSt72lMQbll6jRkDmhNkWKGq4xLHOkk=;
 b=PjDIc/iegLjZ6R10+48cXzF55PGNDHEmwmZuLUszZvfKEIT6uYxzYGdQ9CQ4n7f/rcKrGYuysq71oC40f3iQk8EODCZy/xqCKK5abgduV5mCfe5wW4xAD0eE4Zc1stOa2IFcskvCpEWTRLpXvEKdY2hmkLmf/F/GicNXW1iyL+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:37:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 13:37:08 +0000
Message-ID: <7bf4c9c1-69db-2a79-a925-493a9d993f47@amd.com>
Date:   Tue, 31 Jan 2023 07:37:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-4-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230131052141.96475-4-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d68489-c828-4d60-cc3b-08db03903f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6XcBjliVagOrSdiWKU1wWPShViDKbOGakdufbM6k6mwoIB0IK4CRB8USC3KqQqbClLVbTKnD1hGql2OY7uc38Vie/1fsYBzQelQ190bkYAk4o1/+ES580XoOhJxDdbsRGJSfcyd23NU6xe5rUJfiE3OggYgfK50E1f4eEwTh+sL0xxTezFx7qNTZtt6PC3oU5I+WapsqcrnFhtuUP1gK5HZLV92yBCKwsaWRwJGd4AvqsqTN6yZUxRP992zaF1ilXoQqDH6DPziU0JUOs2uXztTcYVV6G8Wv7RJgZonm8Dr8C4uD2Myb0uDT2D0olEp2EwZNqFxprcedoFwSQvDxDPfiDlWoYfVQ1gvf51aiXjs1smskUNm2z2RNw+JycE5kHi3c0zKOfREZSqKFsVg7hBjxMdz915zc7UBv6D9eqO6mTH1K19JJFboPmyA6jAuHgMl/Od2UCWWAdMHWoUAIDEJJppVEcdeDXdzcQfZyaBr45Qmvcgl4KxUCpMG76WqUW/X8GCCMUjK/XnQizqz2FlagIF5aH82l1Hiko4JDci8/ajyAI7U79BpyDErNvQ1SBALblmmQL+PEVlZoySTpajgOx9M1lB55QsIplvgoDxo2tZhZI/5Yorah0PYZxouyL4UHEPrsWq34WXvTOa/3XwcAZiq/ydJqOR8H5WckP8XTYDwbJTZ/S+MFkKc3niMuXWd83ACMY2rHEFvHrKnvGY1pMt2ZOUxGtBZrS1wFiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(8936002)(41300700001)(31696002)(86362001)(44832011)(5660300002)(7416002)(83380400001)(6486002)(54906003)(110136005)(4326008)(2616005)(6636002)(8676002)(66946007)(66476007)(38100700002)(316002)(66556008)(6666004)(186003)(6512007)(53546011)(36756003)(478600001)(6506007)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpFa0pvemU1bnZ1YXg5OG9XRFJXbktKOUNFRzNGNXpHdVRJOGduLzYyNTho?=
 =?utf-8?B?SHRtNC90ajVhKzlZeUIxU0ZHSVExcGJkeDBVMU5FS2Z3SzNhdkFJQkZCMGdR?=
 =?utf-8?B?YmJZS2hwWHVMOTNMeTdNbTJpbitMcnY0UHR5ZHZMNzdOWklMNTA1VXFwTERJ?=
 =?utf-8?B?UHd1NFZCci8wcmdxVWVXdy9yYVh4S0pTQUphandtQVJuWEFFY1pYWVdJbCtS?=
 =?utf-8?B?VGl0UGpzTEJVWjN6SVRnUktpVDVFRFFrU29XY3ZodWdIS0V0S0FoMXFTbG9N?=
 =?utf-8?B?bDBWM2JBZm5oL1F6ekhwSG5paW9wS3dLQ09jd0thaEsvQnMzekNNUlU0SEwz?=
 =?utf-8?B?dGF4czRmTXEzT25GVmRGTDFieDRBY3NEWFZZMktHUU1Dek9jNGEzRTQ0amxs?=
 =?utf-8?B?M2dXNUdJTXhDbHFkUDVybThGb2FOVUxHK083YlpybWZWNVl5UytBNG9IYS84?=
 =?utf-8?B?VVpLRXdocWdFWVlhSXd3Y1J5UjRqVHFsVkxhNE13bW1QT2hNMTdTRWpFR1lZ?=
 =?utf-8?B?QnhwMktYY0VIb0owaStDT29aMEVYbmZ4dDRJRWlzWURvT2tGS3pWVXR3WFRN?=
 =?utf-8?B?L0xKZFhkOVdwVk05bHdYTUhuNDFKdlpHaGs1REM1Q1NsaTNYS3VadnRUMjA4?=
 =?utf-8?B?WlZTaWRScWRVTXhRUzQvdTNWK2xiNTJmek1kOS9qdTlTeElxTHhhcjNDK21i?=
 =?utf-8?B?eHdSQmQrLzlNZXJjRm9EaWtQYnVaMzB1U21XdVVmUGxyYiswMXRTZEoyeTUv?=
 =?utf-8?B?RlFnWUJXL2ZhVExZbnRzRmNRUlZ0M0RFRDVaR0dETWJFL2tzSlhRS0pFNlox?=
 =?utf-8?B?bWovUzE4ZDRYWUlXTGlHT3plWm1kLzlCWWp2ZmhjVXBuR1p1WXVsOGRNNzNI?=
 =?utf-8?B?Q1gvVFJhS2RsMVMzL0krTlZZOVgxeFZrZXVpZEhucWJDbDYwMlhMb29GSHJi?=
 =?utf-8?B?OEovVWhBMGdjbmpSVXJNdDZHS0dISm52WE5MeU54YmhwbVJwL3MvMng3KzdV?=
 =?utf-8?B?WTUrSG5TK0Y0L1kwSE1GbE16Y1R5cmtsTHdKc3pxSlJrVzFSU1ExSFZ0YlVy?=
 =?utf-8?B?cHA4MXVpRDhTYzJmRUx4V1FqdHd3eVJna1FxZHhyRWQ1QzRHRmdweU5mY3A0?=
 =?utf-8?B?UDRHbTFPTjZGbW1IOVNHd0g0TzRoakZENjliL3NvTEdTLzkzTmtPS3ZHTkNM?=
 =?utf-8?B?S2xDQXB2VFhUNXRVUXY1Myt6VGp0aHRpMkJ2eWhoU0lNc3FIS25mR3BMcVJr?=
 =?utf-8?B?blkzSE0zd1dadFJNQ2c5Y1Z2dUZaS3czRmU1T0dlQ01ycEc4dmJxNXdwRzNY?=
 =?utf-8?B?ZHd3ZkxLTTlQYllpQ3pCd01XaXdTWStibVA5UVZVR2FKdmxRM3RZdWw0TENs?=
 =?utf-8?B?dGlKdDBKUFYzUnVXZ20zc3ArWGk4ampYRVFvbGpiK2ZmdFl0VTZMYm5KZFY1?=
 =?utf-8?B?WVpXNUw0MFQ1VlFIUVQ4MlFwZW1nWjBYVEF3OHo0ZkFnTDNKT2Qwd2xCMTda?=
 =?utf-8?B?WjNHdTF0WnNNZDZpMWlURm11NmtUZmdmZXZwUzBxZVZoU1dxVXYxNG5ReFYz?=
 =?utf-8?B?NndkdlZlN1ZOM2dOd3lYZE14Y0N1R2dleWxSS0cyZml4WlB1NnRGZ09ZUnE1?=
 =?utf-8?B?VEd0bGVpeVFVdk1yUmZUYTJkZ3hiS1F5OThYbksxSWZ1VUZoU2orTXVFSW5k?=
 =?utf-8?B?SnZ5T0VVT1BvZXdzMVRvQVNIR0ttTDJPNjBKczd5WnJERzAvblMwWTAzdEFZ?=
 =?utf-8?B?M1J5b1JwNEZaWnhlck5hYThsbS9semxvanNIU3RVY1FYV2hKODUxMnlOb1VM?=
 =?utf-8?B?VUQwQ1lZU3NuUmNieG05K3p5c2srUlB2SklQc3JjTTd3NklJV0QwUjdBbmp5?=
 =?utf-8?B?MCszazhoUXBsdjQrM1ArMnZWRDEycmoraW9QRzJ0R01YLzNQVitPZ2FiQnlT?=
 =?utf-8?B?S1FGNE1BRWNKa2FBSEJCamFUWHhkWXFSK09NWWY0bDlURVRkYlpxUmZsa0hF?=
 =?utf-8?B?U3lTa1AxUWdkZE1qd3N1aWkvTHFsYnBUeWhqSWt5WFVQcTJ2L3Y1YjZxVkVz?=
 =?utf-8?B?Mld5NnoxYlhjTkZXNXdFbnQyZEdaQmxkVStKOVpaUys3TkswQ2ZHSXc0OUFy?=
 =?utf-8?B?dE5mVjl3SmpjcG9kRElwdDkwTWNnbDMvc3pSMW9FOXh3ZVVKZnUycmNwVno4?=
 =?utf-8?Q?1rkOIQdN6XyDUm4PjnaxoAwKAQr/bVrmyEqs/xCAb1xh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d68489-c828-4d60-cc3b-08db03903f98
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:37:08.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CV+e7YsSYpoapTgvgDWVr/Fi5wIUj2ulRYpIgHN+hYlBgRBhPRgc72V6YwFebFDvKUOoOKncYCX89nWOyi/GvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 23:21, Wyes Karny wrote:
>  From ACPI spec below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>     performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>     frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>     energy performance preference for the workload and platform autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         | 15 +++++---
>   drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
>   include/linux/amd-pstate.h                    |  2 ++
>   3 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e3618dfdb36a..0d8486325c9a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7015,11 +7015,11 @@
>   			  Do not enable amd_pstate as the default
>   			  scaling driver for the supported processors
>   			passive
> -			  Use amd_pstate as a scaling driver, driver requests a
> -			  desired performance on this abstract scale and the power
> -			  management firmware translates the requests into actual
> -			  hardware states (core frequency, data fabric and memory
> -			  clocks etc.)
> +			  Use amd_pstate with passive mode as a scaling driver.
> +			  In this mode autonomous selection is disabled.
> +			  Driver requests a desired performance level and platform
> +			  tires to match the same performance level (if it is

s/tires/tries/

I don't think you need the () either in this sentence.

> +			  satisfied by guaranteed performance level).
>   			active
>   			  Use amd_pstate_epp driver instance as the scaling driver,
>   			  driver provides a hint to the hardware if software wants
> @@ -7027,3 +7027,8 @@
>   			  to the CPPC firmware. then CPPC power algorithm will
>   			  calculate the runtime workload and adjust the realtime cores
>   			  frequency.
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum and
> +			  maximum performance level and the platform autonomously
> +			  selects a performance level in this range and appropriate
> +			  to the current workload.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c5731fefcbef..48ab4684c3a5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -267,7 +267,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   		   cppc_perf.lowest_nonlinear_perf);
>   	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
>   
> -	return 0;
> +	if (cppc_state == AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> +	if (ret) {
> +		pr_warn("failed to get auto_sel, ret: %d\n", ret);
> +		return 0;
> +	}
> +
> +	ret = cppc_set_auto_sel(cpudata->cpu,
> +			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +
> +	if (ret)
> +		pr_warn("failed to set auto_sel, ret: %d\n", ret);
> +
> +	return ret;
>   }
>   
>   DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> @@ -344,12 +359,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   }
>   
>   static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch)
> +			      u32 des_perf, u32 max_perf, bool fast_switch, int guv_flags)

You meant "gov_flags" not "guv_flags" right?

>   {
>   	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>   	u64 value = prev;
>   
>   	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +
> +	if ((cppc_state == AMD_PSTATE_GUIDED) && (guv_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> +		min_perf = des_perf;
> +		des_perf = 0;
> +	}
> +
>   	value &= ~AMD_CPPC_MIN_PERF(~0L);
>   	value |= AMD_CPPC_MIN_PERF(min_perf);
>   
> @@ -404,7 +425,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>   
>   	cpufreq_freq_transition_begin(policy, &freqs);
>   	amd_pstate_update(cpudata, min_perf, des_perf,
> -			  max_perf, false);
> +			  max_perf, false, policy->governor->flags);
>   	cpufreq_freq_transition_end(policy, &freqs, false);
>   
>   	return 0;
> @@ -438,7 +459,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (max_perf < min_perf)
>   		max_perf = min_perf;
>   
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +			policy->governor->flags);
>   	cpufreq_cpu_put(policy);
>   }
>   
> @@ -1238,7 +1260,7 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		if (cppc_state == AMD_PSTATE_PASSIVE)
> +		if (cppc_state != AMD_PSTATE_ACTIVE)
>   			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> @@ -1300,7 +1322,7 @@ static int __init amd_pstate_param(char *str)
>   		if (cppc_state == AMD_PSTATE_ACTIVE)
>   			current_pstate_driver = &amd_pstate_epp_driver;
>   
> -		if (cppc_state == AMD_PSTATE_PASSIVE)
> +		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
>   			current_pstate_driver = &amd_pstate_driver;
>   
>   		return 0;
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index e9e291b7c2f9..85e980b8e0ac 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -92,6 +92,7 @@ enum amd_pstate_mode {
>   	AMD_PSTATE_DISABLE = 0,
>   	AMD_PSTATE_PASSIVE,
>   	AMD_PSTATE_ACTIVE,
> +	AMD_PSTATE_GUIDED,
>   	AMD_PSTATE_MAX,
>   };
>   
> @@ -99,6 +100,7 @@ static const char * const amd_pstate_mode_string[] = {
>   	[AMD_PSTATE_DISABLE]     = "disable",
>   	[AMD_PSTATE_PASSIVE]     = "passive",
>   	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDED]      = "guided",
>   	NULL,
>   };
>   

With two nits fixed

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

