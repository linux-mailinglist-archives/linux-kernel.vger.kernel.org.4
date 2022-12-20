Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134F65192E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLTCxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLTCxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:53:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4B13CD0;
        Mon, 19 Dec 2022 18:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9sj9XvtXCa+heyOfQGa65R+xbqB2FI0G9xQB/v3MbFq4voI84hqin7bMmTz/PYpbU3uefUzU4utlgLdjlD4i90OCLy8zGTMZCR3KZ4128VazWXlIDnn0Qzh6oNzzRdes1i7cOOXlTf9mRF1mmUfbbtf8GwJQkUci2eWtmqQXlbwltORgLEbBlNq7xnlbrCp/ty0keoCnAd3Hd2kxTmYmLxz4MySyXvhVX2aLW4Yz/aj5o9VjtkNpxG3mfF7G6zYGcbsFdIh2t1oFN9gWLNPpALiKA7VxBLqSg7naV7y0ytYXiwR7haT4GEMGiI7ZA20kh7nb4x2299LTzVoqyc1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRzpDxDhl1vFJdBU2Z3i1SGucCoSxHMAFn/muFgtPic=;
 b=UB9hOoeYhKoOHN+BIdCuYHRwF/ldBSjapj5ncKs5L4V31ppw7GPLwR+P2LumTrpQ3VziPTmePnBjKHzPYNBxtmO/YdNoN0M91ToVvxbvQ1DxSSyDTu4QD3uvYqqDaE+jLXRVOKPPnYy6vkcn81u433Qu5WJE9baeC0fqH/5wl42z6y+vhsXsF48zUJZK+w0s9hVFVO8oZC3Cu32AydSOeyQjv265BSSoUOu78PV1QSdMSKMdKC2eMHikPLS8P6b9Z1RBZzHKvSiNzvntRfbVu+4hZZQ4xK7E8kepNiMflZ2dhPR3086lCeGsGrCOGIUsxahAg0cVCJPPn5AwDwRxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRzpDxDhl1vFJdBU2Z3i1SGucCoSxHMAFn/muFgtPic=;
 b=nlWFtqf9wPM8gLj16UFqLFhena+cLRMYXBRdsKyAd6M9fih1edQUE3ppoamhTFhoV+XShzXc3pbGgpD+8rX9FFplz+sqmfJLY+CX0VktaMZug2IatIg7+Ry+1gD1XRbvr8qBEUWnXa3IwGYJd9e/txsdnlLfyIXGpCdlsTMWqlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:53:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:53:14 +0000
Message-ID: <4da9ffcd-34f6-d756-1ab5-95ba99a8739c@amd.com>
Date:   Mon, 19 Dec 2022 20:53:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-4-perry.yuan@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-4-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: c0017403-74cf-467b-99ac-08dae235566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MR8KmBuCUHdQaE1LIKLTSmQgsmXH0PGfnhR75lwBcPM/60yRomxQPVXPaxl+pfnsVoFyBvmQ2DEJY+vqsUNB5PE0/WYGPtDE7yfYwl0qq7WfjeEzbmXfN9RssAfhphzo+1FbbvIlbYUKntSkmzJ2iAWb3G2MxvTfQMvjG46cWV/5WyYWaR7G7jkr1/ccbRau7VWkvHez6HrBSgaBvsr8Zbj/2PhDImUtUJMYQ+ptSmhxMzs9quJim4t1LFUbXfQROIxCUTDViBYdTgONvjbX6KCCx4ksSl20lul+gNifjHBPG36NDGifPF5mD5A4ZzRp6ffu+npsJrnSU+TxpTvGkFLbxo9li69QjW+R0ZpClenuFuaNpQ3wjXaD2xVcdiFZdjnEe4lEGQc9qrv1DgDQza54JmVkiB0vYxVeETE+X5CiLyijoDrhtzKDV8MyJk5B9bly2prbObNO7XdbudgMGfOsIe4AYQA4sONZNBkUjSEw6uhlA7xautl2kLAOrZLx4SjaRrnkMbL5aDyopyuK51vZobSPv7heMZhK62QWqjywed7wp13rEbQa213zZS5UQYX12R40ZAS96fWlcCUHOwirh+UQID6G2T8s0cEGJBa/mu3RwPwmbosBLWAsfcU4IZ0boVK2K5kG+Vn5wgPxHcB3pCwW3ysW7HxTdIU6DbADD/ovv9HcV/WTGmYtpUaL9qdmMYkq07QrR5jDW8cA0Du8bu2hpp9JORXU1GPXaUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(31686004)(2616005)(86362001)(38100700002)(6666004)(53546011)(186003)(2906002)(6512007)(26005)(6506007)(478600001)(6486002)(36756003)(8936002)(316002)(66556008)(44832011)(4326008)(66946007)(31696002)(66476007)(41300700001)(83380400001)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndqSHB0UG1WVDBtZGc0OUYwMTVXZThGNGJ1SXVtZU1SZVJKOXI1VGs2V21I?=
 =?utf-8?B?bTk2SWE4eGFsdUNoYVlrN3FzT0Y3S1J5bHo1a0loOXMwN0c2aDlMRjB1dnFq?=
 =?utf-8?B?WnlpSUJpTElZNWIyTVBBT2ZRRDl5TktrK25qWFhadU9oVEl2U2hEbzJ6NjVR?=
 =?utf-8?B?TmtNc2JHQmcxS1E3UFpmYW4zUCs1dzlZOXRLQ2dBT3JTUmQ0dGFkbkc2aEIr?=
 =?utf-8?B?TTNNUkRYWFVaUmwvUUdHSFpudjhqYU91aGkrOU5kMDJMM0gvYjQwU1ROK0JH?=
 =?utf-8?B?ZFhHRjZZbGpsMTlwNUJZbGpEdjdzTjV3dlBGT3VlWFFpQzIwQ2VZZS9WdlV1?=
 =?utf-8?B?c2ZmWHdEaERYRUFkTFpzMEpVSmw5Y01IdXZESzBuNkc1TzVlNXd2QVFNOGVv?=
 =?utf-8?B?cllTZWt2L21XbjFNanlqdFZpblF2aWhuS1p6Y0xtc0NlMnF0bk1sdHY4T3oy?=
 =?utf-8?B?d1RULy9LNGE5M05vVlYwNXFEdXEzWVUwa3hqZzZ6MUVKY2tzalhGVnFuS3Bx?=
 =?utf-8?B?Zk1IQk82Z0NGMXBSa0lpRC91QVI3R2NYYnZDVFBLUmFsWW5udXUzYmFhcWpv?=
 =?utf-8?B?bGpEc0NJSk4xaFg5aXMyTFprUDY1VE1TVlJ3NkMwbDlBMjd5dFpPTFNWMUFK?=
 =?utf-8?B?c1RXOEQ2VW9HRkhSS2lsQUxUZUJXUktjeEYyNVRHN3JZdnBXNkZXcFN0NUZ6?=
 =?utf-8?B?NC9EdjlyclVTcUNRMmlNVlQ5aHNIUFo1U0RFRTh0dFFrZ3ZNRUhXYjlMcEtQ?=
 =?utf-8?B?ZXRRTGd1aUMrRGxrK0pGV0RqMHBDUjhWWTlRWjlxckZKZSsvOVVZOXRMSThO?=
 =?utf-8?B?VEhuZE5IdFF6TlMzWEZGZDhpTzl6VmFRTTI2RjcyVmxxd21sODdBa09xZHRF?=
 =?utf-8?B?YStuTXRwMVVmRG9IWDljdDl6eXhrRGJqeUVJMWcvZy8rc2VpUXBtanorWHc2?=
 =?utf-8?B?dGN6R1FwcVB1NzRUcUQxT0xMSGxzMkY5anRSbXFRSDViaEhURkNPN2lhOVBl?=
 =?utf-8?B?Uk1WNUlHRUQ3NGZPZThKOVR4SUlhcld1bTVGWXZZQmtCR0FadmJhTnc3aFVV?=
 =?utf-8?B?NmVULzkzc2JrMU1Yb2hFYjlmakJtOEoyS0lhMGZWbzBUVHJla0c4dVQ3WEZl?=
 =?utf-8?B?OEs2Wlk4L1lvUXVtc1hXdlBsbStvaldENVlTYkNveUVQNlQxMmp4L0xhblRF?=
 =?utf-8?B?UVI5NUhsV0owTituYkpXQVh3cURhcVlBNVRweTJEZ3oxSktNQ1dtaDZiTjdq?=
 =?utf-8?B?cnozbEgrUzFNcnFxYnd1bWUzVnlGck5HTnBoWVdBdERzMEE4SHZpZ0lKaEVt?=
 =?utf-8?B?SlFOaDl3MG9VMnVXY09tMVR4T1VxY0VGSHJsUS9ITGRIamZBWWFJK3JpQ01n?=
 =?utf-8?B?LzNtU0d5RmNnT3RHN010bVJ0MGdkbVlRL21BRWRPRDVTS0RCOHpXL1FwRFJL?=
 =?utf-8?B?VXYvNE9QcEQ1dFQxRmtlaXJEMGNjSlg2SHFPRlR1K1BJK0tyd3RXYW5mbXQy?=
 =?utf-8?B?VWM2UGdXMEUvUUlMamxjVWxXUThJcG16Z1puRnh4Uy83K2sxSVAybzJLL014?=
 =?utf-8?B?ZmsxdmVFTE1JUW8yMHFWRGNyb0FJSWEwWFA4T3ZTRUQ2MzkxaHQ4MTNITXNZ?=
 =?utf-8?B?NmVkQ1FXdCtyNWNwcGZNTzhYYmJ0VisvZGZEZjdFd2FId3l4ckxEeUZzSVFm?=
 =?utf-8?B?OUVhMTF6bVVEWmp1RUVJZjFYV1o1K0EvMUxNbXU3R2VOaitXVG85Q2Jhak5L?=
 =?utf-8?B?TU5ibVUrUk83NWZRallZMldtTzJyUmN5Rkw4QXlnTFVSYWYwTGwyTWV3OEE2?=
 =?utf-8?B?WFdTR096bC9mRFlUQUJZWitYZWYzM3pVMmFpb1VvcTBIYko4T013b1kybEtm?=
 =?utf-8?B?M1VNQ3JZaWJ1Q1pqMnI2UW9TYTlic0VCS29VWkIwZW05UDVqa1RxQUJQQjZG?=
 =?utf-8?B?TVE4WkpUcjFmejEvcnh4aWtCYkVpTU5JUjVqUUlIcEZ1c3l6eGdsMVYrSnhU?=
 =?utf-8?B?ZEFSK2JsenVzU1dHWDRmOS9GTjNQdmtYS21Ga3psNkprUk9PUFhNbEdINC8r?=
 =?utf-8?B?TWhLUjNzeE9LTEh5N0dxZlZhQ1RZZjNQNlZIbmtLRUtlMHdGTlJQRkVjUXdN?=
 =?utf-8?Q?w54CjjKfvsIDi08mPyt96wUNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0017403-74cf-467b-99ac-08dae235566a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 02:53:13.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZbaPxqK8+h1VnQhPeX866d8aV96Vg9xOcP+juOU+M6rWllikoB7RO2t7FkLlluD+z7t0ermDFd/ugE5eXVQHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 00:40, Perry Yuan wrote:
> make the energy preference performance strings and profiles using one
> common header for intel_pstate driver, then the amd_pstate epp driver can
> use the common header as well. This will simpify the intel_pstate and
> amd_pstate driver.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/intel_pstate.c | 13 +++----------
>   include/linux/cpufreq.h        | 11 +++++++++++
>   2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ad9be31753b6..93a60fdac0fc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>    *	4		power
>    */
>   
> -enum energy_perf_value_index {
> -	EPP_INDEX_DEFAULT = 0,
> -	EPP_INDEX_PERFORMANCE,
> -	EPP_INDEX_BALANCE_PERFORMANCE,
> -	EPP_INDEX_BALANCE_POWERSAVE,
> -	EPP_INDEX_POWERSAVE,
> -};
> -
> -static const char * const energy_perf_strings[] = {
> +const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_DEFAULT] = "default",
>   	[EPP_INDEX_PERFORMANCE] = "performance",
>   	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> @@ -656,7 +648,8 @@ static const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_POWERSAVE] = "power",
>   	NULL
>   };
> -static unsigned int epp_values[] = {
> +
> +unsigned int epp_values[] = {
>   	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
>   	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
>   	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,

I think this is going to make CONFIG_AMD_PSTATE depend on 
CONFIG_INTEL_PSTATE.  What you'll want to do is put these symbols in a 
"common" C file used by both.  How about in the cppc lib stuff?

Please make sure that you test compile/link of v9 both with 
CONFIG_AMD_PSTATE/CONFIG_INTEL_PSTATE set and either or set.

> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d5595d57f4e5..e63309d497fe 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -20,6 +20,7 @@
>   #include <linux/pm_qos.h>
>   #include <linux/spinlock.h>
>   #include <linux/sysfs.h>
> +#include <asm/msr.h>
>   
>   /*********************************************************************
>    *                        CPUFREQ INTERFACE                          *
> @@ -185,6 +186,16 @@ struct cpufreq_freqs {
>   	u8 flags;		/* flags of cpufreq_driver, see below. */
>   };
>   
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +};
> +extern const char * const energy_perf_strings[];
> +extern unsigned int epp_values[];
> +
>   /* Only for ACPI */
>   #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
>   #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */

