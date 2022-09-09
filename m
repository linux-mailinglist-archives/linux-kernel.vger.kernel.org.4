Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB35B3F17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIISw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIISwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:52:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B741B133A3A;
        Fri,  9 Sep 2022 11:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG2z2RIl5DeWxdhE1rpESZElFJVUK6EYFxcZePy3Cr5GuzR+CcjYWw2QXACzfyPBKvmnRGAIJjN2mgJNsB2lYzQCTrXkkgpTXP7Iod1NQxIkBZtqWlGj9kWrKoBgaJ39BBITpDIRvBDj/7ao0bDYdTYX4c2miIj9pyXLhpTbhGEtwZL7RZMRXpmgf6vPxAzZEw7Jk9LYS/zPf+4HZQtDb/jrD152EZ/9OOiRozr1B6eVYQu/23qeTIzxa4Tyk0zZkVTZJygoi1/dvlReGDdGtrP2NNvmRpUk14oZX9MjzwsXoY5VRgho62L5CquXfeqeQE7TppVmnRVY5nWjj/Wgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agk8fVLhR/WJGSJAw20SN219bmXFma26UXiF8B8JTmc=;
 b=lj07E4xbkeDrA2pcrA4JAeTVcOulvKdMei80BQ1Jg1mnlXA0qRH6cvpRGemZ6j/nVJQLOxQXrgO1/eI8Yxsb/rXCj6aG5OWlVZ93RRZJvI2Yp4/l0uwSiEiOzh5TH7yEoYwVlB4gK5Ih/tM/Rb6Ux3msurLNfHt2AjGO2LdSghIROv3cFZkNRpapPuJS0B7UJ+VzFi+Y04BaG7bV85u/xZurvNFPf+k9wa3509L0eYpGYmgieelU86B27Pj+Ulg72QbsKRNgNNNEVZjbFIhYKf5NI4LkhoOuc/KCZWsuKTUqFAYLP4wBtWmFZhOLvFv45rHOJaj2qOokfouGpvNwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agk8fVLhR/WJGSJAw20SN219bmXFma26UXiF8B8JTmc=;
 b=ZR97Ulp1JdK2CqQsbYGnMqFGwFyN+rUK4TX7Qh4BHs1lOwtyXDDrgWmmTTAo+F2oMBD/kglZcCY16f/iwyj5jfBgNNdXLwW5joeuL/JhllcYU7mLh28emCCZRvdCa+fIuqU/IVvPFr6pD7eFKrunX7bviXTWLnpyka1u0Qc2aKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 18:52:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5%6]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 18:52:49 +0000
Message-ID: <82b3b47a-c6f6-5d06-d1d5-3a1c132d80da@amd.com>
Date:   Fri, 9 Sep 2022 13:52:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220909164534.71864-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 851caf51-42c8-4c23-cbb5-08da92947e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XStpLIv3oVa3M40xJHQHGKRlQyKvK/9Jfyl/5P5Wz4/muJ/0tY1/f7IQ/teLiI+UM+ed82PSiVgEjkhOGXTseu0gjyX+mgP2WfoNnaENG1VuiPw3cHzEIKJtVxuIcWOHxesk5edsRp2Bm8BfVtF2Nj0RfOOlElSctdCs+EtwHlRAoKIxxaf3zdNoyf0LSkmU9yCFC9YKvBf3ysfAiBmEffe1KydIMrfWGzs+1l4m9f8s7kvr5rzJ+AETgGR86x9pO1PHRCABJysCDnGXv0oKnjCZ6L/RVCnAzyCPh3tVbkCU0SU+eUZeXIg1JY7+dWz5fAgG07lr4hJeg2vILqHF6YqdIcI+0S3/hGvGC6/n0/kI7T2fujiY5JxvLVAnOTynPU26gJs3EVQtZ1x466Rxje+aSDEsQSXkJyH2QaQbqGzMAG3y+KcMjZ4zjzRmeinDM49DhZuq2jJvMq41CtXrZInKgt0Fr5jwNuohJmIHiTW6BkJuoZ/IkH9lw/wj+963Hzxp5QyBLPDgMoXnEqe/Sh96E4k80V6I2gLZ5vTgxm/Di2JE/XBkjU0yIChynxcafTXTTqbjkHqqYMcDfSkK1pI9nGHmUgKVolkCtYdKnEgB+t7xJzBj/zFmDrOpWn35ZvI138f0hckSeZXS3XY0eSC3M84hP/weJ0/MdYAH6J+l7pEmP4EEMLrtevGGxcWJiE5OmEVKo6zK/PgP8YNNFJduQRZoqxYKNFnfZ1QxPT5UmpW45Jj3r5RDJyF80NWc+fAhO1/zUtlB3EaetRaYHsYrRwp3i+wymhQMgoLoGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(38100700002)(31696002)(316002)(5660300002)(8936002)(66556008)(2906002)(4326008)(66476007)(8676002)(66946007)(2616005)(53546011)(6506007)(186003)(41300700001)(478600001)(6486002)(6512007)(86362001)(36756003)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN0VjhadmlzdTV3dDVrOG1jcytmT0tlMkRCOHZYQmVubitPdjlrNkdqUmY3?=
 =?utf-8?B?QVplamI2Q1lUeTUrR1llRGRlOW5NQWtuUThvalRKdXlhdXNZc2NyWDk5LzBw?=
 =?utf-8?B?dTNWQnhtWm1qSVlHMkRFVW1pTEtORGJ5REFSUW5SYkw5U3J2TEdkcWVnTHBI?=
 =?utf-8?B?a0VnWkk2ZkkrL2lBSzJJTDVwMVkycExCVjloT0JBT0x1T1V0QjF0NHFueHhZ?=
 =?utf-8?B?bzJXd1JwVCtQT1RmYmJJd1AxeTRVU3VyMXVadjNnYUh1SEJlMUNMQ2poRWJX?=
 =?utf-8?B?bFBoMHF5ZW13UVlWMm5SVzNvTlpERUpEb01VVmJpaE43TkNOU25OR0piVTlW?=
 =?utf-8?B?QjlBTTJBeEtZRnBpTm5ieVk5a1VFdG5XTmpPOGNKdEdXNW9hUG9ac2FGRVg5?=
 =?utf-8?B?VzN4RDQxY3Nrdk1xNzAva2pENUE3N1FOL0RlM2VnNDk4MGdGYXlabG5sK3Zu?=
 =?utf-8?B?WklhZE1NYVNvenVobUN2eFllNXA3aFZrT3dYd2psT1pGWjc5bllRVG9JZXJ1?=
 =?utf-8?B?T1BTckh5RFczOXpYSXZXQVhCOFNjUUVuNno1UHZOSk00bXlDZXNsdkFUTzVv?=
 =?utf-8?B?bG15SHJ3amJ3MThZNFRiV3gzRnNKWG1xMlVXSDJqNngwVlJuOHd4OGJYY3B4?=
 =?utf-8?B?SU1ja3A4bUNtcWNYV0FIRE4xYTd2QWd6eThnR1VPbG9NUzhCVk9ldW4yb28z?=
 =?utf-8?B?cWtzR1NDYmlpWnRZN3dFNzFVbGxhaVFKaHNMVDZLSG0zZEluMjJlNWZweENr?=
 =?utf-8?B?a1haVVU5RHNST2RMMjNBc2U3MkxKYkRmdS95VXJRb1puVzJIRWtUY2dPMEZQ?=
 =?utf-8?B?OHpxeUhiZkZjQUszeUZPUGFNRUdsVzlvUndHcER4TFVtQ000aVcra2JoZnBs?=
 =?utf-8?B?N21PZXlrcmsyMHp2TDZDNllnUzR1UHNweEhLaHdrTkJwbFNRZEFydWMwWW9m?=
 =?utf-8?B?Z0hzRTBVVEVFbHRzSm9XZlNWci9LeGRQa1RORVNncW9JWk1nNFBoRE9VTERW?=
 =?utf-8?B?VWRhVTVxbU1uWnlMcUx6R0xzM1N1b1d0eTA4cnZvMlRPVVdIL0drVDV1bC9i?=
 =?utf-8?B?bVQzcS90cG5YYVB3djlnYk13ZmY2Qk96NHk4bVoxTUEzblNLUHU3LzRZeGt1?=
 =?utf-8?B?VjZNb1NObTdjS1gzY0lMMGdMVDF1aGRYM00zUk51Y0k2cUplRlhaSU5WL3Uz?=
 =?utf-8?B?VmVaNklDM1BhRGlZd2UxUDVySUhGVW9XbS9Vend5eWJ3aVBaeCtLcnNBbW43?=
 =?utf-8?B?cng3eDVWQ2ZqNkpuOFl3QTRsKy94TkwwanRKa0cxbnlUSWxPR2g3bDdUYmx4?=
 =?utf-8?B?OWU2N3h2dEJEaXZxaTltK29MaFdWeXozZEUrdkRJZFFEY0VaTk1WWkVubDFE?=
 =?utf-8?B?NVdOZmZzTTRwVVpQTlg4OC9DVTNnYkU3QTRESWdzWVV3clo0Q3ZvdDhLZDdy?=
 =?utf-8?B?bkp0R2M2V1dtZEVpWExjYVB4ZDVPcFRTSnZldzRYdmdoREJCendtenhPYjZp?=
 =?utf-8?B?dkhMcnE3eEZ2dXVuQXBDZXR0LzlMMjRZTy9pbHEzVndVWVNuVkR6ZkVHMk03?=
 =?utf-8?B?eWdRZkFCbXhtazF2K3NjdG1WRnVhcm1JRk00WmlENkhoSEZDYWhqTEpjaVFq?=
 =?utf-8?B?ZG52VzRWdzdhS2hpSGI1ejFxc2VFOEJwY1ZINHltVkRxMDJudWY5QTRVTGgx?=
 =?utf-8?B?ajk4RHg1cHBVVmpmVVQvVnBiN3o0T2tBU1JmY1NGV0VoRnpPV1k5MlVBSUwv?=
 =?utf-8?B?VTUrU1pTZDN6NWRheGkreDVhb0pCVWdGZzYrdWlwZzFPUjNJYWQzWUVaZ2h0?=
 =?utf-8?B?QzZUNFk5ckRFeEhwV1pnZVpYUk1uc0l1YmNhTWYvYk9IUFhzbHRmM0hicklr?=
 =?utf-8?B?bXRjSE0vVnJPam8ydTBnT1NlSXp4OWZHRTg1b1JsU05jalRBbEgwZWkyOFJ4?=
 =?utf-8?B?TjhvNmhoSzZlRXVZd3lCUHFXYTRhKzNCS0tlVlU4dHNGZVZEREpmNGFCTGYv?=
 =?utf-8?B?bDFwT0dWZ2ZZNGM3OFRsemhpRzVaTW4rSFpWL1BTVzVNdWlGTm0vVXFVUjI2?=
 =?utf-8?B?bFo2NEZHUzlFRm5qcGI0S3VOZ1RYSHdENTNwcVJqNlhtVDBNRU5pSFZUMTVa?=
 =?utf-8?Q?JFbQe4o2/iRUDJTh+3XKUYiLD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851caf51-42c8-4c23-cbb5-08da92947e3c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:52:49.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crmU8SSwWtSxg+VWM4FptkMz9zS7xEXNOr1Ryz+HA5OAEluxSns8UU99LFPAZf6kJ0zTv4EfeZniPQWL/qqBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 11:45, Perry Yuan wrote:
> Add Energy Performance Preference support for AMD SOCs which only
> support the shared memory interface that implemented on Zen2 and Zen3
> processors, because this type CPU has no MSR supported, it will use
> ACPI PCC channel to enable EPP and reset desired perf to be zero.

This reads like all Zen2 and Zen3 processors don't have the MSR, but 
that's not true. How about:

"Add Energy Performance Preference support for AMD SOCs which do not 
contain a designated MSR for CPPC support. A shared memory interface
is used for CPPC on these SOCs and the ACPI PCC channel is used to
enable EPP and reset the desired performance."

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 451295284a26..fff298744a8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -133,12 +133,24 @@ static inline int pstate_enable(bool enable)
>   
>   static int cppc_enable(bool enable)
>   {
> +	struct cppc_perf_ctrls perf_ctrls;
>   	int cpu, ret = 0;
>   
>   	for_each_present_cpu(cpu) {
>   		ret = cppc_set_enable(cpu, enable);
>   		if (ret)
>   			return ret;
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
>   	}
>   
>   	return ret;

