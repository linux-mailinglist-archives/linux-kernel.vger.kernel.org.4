Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E49654D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiLWIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiLWIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:12:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569128E2C;
        Fri, 23 Dec 2022 00:12:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOOiaS8BIxOFFaRRKeElU3EosJ0+Ul32It6U5DJZP6qOLXA2qPC6WhUnY7yia6j5W0bxXpD909Eh5uCnPoG4MxLBWD6CGbKymZxWRR/1XXGidLXtEtVDMgDIEmharETW1GFhxuaajDPX/YtnWb8KDp0Vm/zfiCg3awsWLkyP4AyZcjqKsSfBJ8UZR/9OnJq8zjQ2GvuqffPGyFeclZ04dHSymLfNTjF6TL7BYn0oV/Q1IskHZPF2ExQqOFXF+XgBFphU37jGZodmn5Zkl2xNSDe62swCsK1ygXmVft3ZnCIZrgzDBSWpzpBptQCoS2OHcCfP6zm3HVTLMm+VumqvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2AHQBvcbOSX+AtRJ9MXimYXJzw3OcgxG/oD4gU/qTg=;
 b=QgNXY5Ty8kvFc1ttpPCYYr7CmJHACh1BA3XfRndslZtpCPOMOeGP11NWYeibZEUldtgTcTMO2fMHz/VC4ibj5ZLioZYGnlWJ3UVGjMBE6XuRiaX5sjWHS4+qrl8peepooZhaDSKtRmpjdhZC0CDkqBPHjh+5o3RiDRaBspOgu1e99p9+d5rx0UG/5VV4UkQLsR+bh+BVpA8ArMuWiEIQj/rLQZ3hczPWTjeN7ne9PozZCvJzuMZWOkHmdcu7pnCzJzH6OYivZzWntpM1zMUVLV6xLsovBxvmtY2SWus39lFnDdxSIv+/J7MMFZDrUYFOfjydGthPii3n+073B5qQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2AHQBvcbOSX+AtRJ9MXimYXJzw3OcgxG/oD4gU/qTg=;
 b=MWqqaS+iKzXI3BNQYzgwF2he1vmFbPl3m19jAmJ1jBYae7FVfZL8TQgl8h0Kg1z8DHLZqXyEi/ghoB9qbKSVpWyBFCIgwTOUSJp0z73qcIqfQzKy0dpCWM58iii3wFWExa9tn2qhQEXOmZt/8/xDC/ujimFEpWpGwPgwqwtUOoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 08:12:34 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 08:12:34 +0000
Date:   Fri, 23 Dec 2022 16:12:13 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Message-ID: <Y6Vi3f/1z7QZKGCI@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-9-perry.yuan@amd.com>
X-ClientProxiedBy: TY2PR0101CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::28) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: f39d7c36-6352-4163-75db-08dae4bd7257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvKxiGIxkRbwyLsbDmBcQqmGuMLrwvw+pSJjtsttzOby0J6R6f7MBNqgrzlcqwYaNWHhp+spU1xKWL1AGC7SZUABcpAu6ItouWfiqxv7O/e5EJ4qg+v0NM7vEI7vk4d4OZv5+iJFTu/hW4J2eKZkSB4HBdpmhJD6hBJ8mryTxVmtG/46KqBS9qrZHJdXq9mCOZgVwxMBZbcKhU/GaKqbj0IyXOtYLWijOQBm3fKV2pLij2iCg/0zPE4VLnw0oVulw/EwNZmsvngkJW/j/C2KrVxt3LT2QycjNSiahWGshyDT8noHz1qPQcmYketE6SCeDvCkfm8VY+e0lvDvbEjirdY5BfcJJAOrm/Z+O2D/uXhQDt/f6yRFESUCD4hSexM3StS6H0emI2kmtq5z00fV16UbBjx/+vLH0l8S697MhH3yQYD9sznrBGdOw4swWcZVcdWIw/CZOGL/C22V5H7H536obHRHFRnnAc2l40vAk2m1WBxvzNoKakjdEv4t9R4hDAm8TBWJSMn0VFNCQLIkiW0zgiiluGqLMskKVeoaSmEFjiCRRiZN9Mlss0dMtN97pAC09Lf2LrVyn8x5AH0OMlVNU3uYHYhDgsHRJwDvh1948WYzCvF8ymSBl9qcfZef8dMLuIceXmpr62Cf4lQNaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(478600001)(6486002)(6506007)(86362001)(186003)(2616005)(6512007)(66476007)(37006003)(66556008)(26005)(316002)(6636002)(66946007)(6666004)(54906003)(83380400001)(36756003)(2906002)(38100700002)(41300700001)(4326008)(8676002)(15650500001)(6862004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sz01k0PNkSahNa4vvCdUR3RknsYPNMWL10yg3QnWWNMccxHJAf9/VOpjQVJr?=
 =?us-ascii?Q?AHk0KJShAwlxEmj9fbFHvsL8l88WcQGEJa7xSP56HPXkFlQ7qsFI2Xr1LSTt?=
 =?us-ascii?Q?pU4GJbMU71L7E8HGaPcKOyvCWDdEtoCfJ/dGk1j9A0L6ixb1ar/opTTJEFeq?=
 =?us-ascii?Q?V8cP+44sKrfIe2XDnSHD4xm06nSUD5MhwqvioGV0EBgNQEW1gTlNRY5nJLPF?=
 =?us-ascii?Q?mDoERJ93qRS+Fd91ouIqPsprD8RhAT6yydtVt3K7jDRbOkt0JgApnt0uogB7?=
 =?us-ascii?Q?+yvhlf7iZWhsYYVGp54zO2yB/usy+xIRF9qo1cTEoDPwuiYJ1mx/+INmpNpL?=
 =?us-ascii?Q?iE7vAAN3FRSPmpEMSHscNIxPtYjjN3JzeJIWcyE9ZM+OHira6NUAGiG1O93a?=
 =?us-ascii?Q?jhDAQ5spCyiz2o81xZdchDLGt5dQJQxoWpkqQyMmc/eseBhnZNd3xx48x9oQ?=
 =?us-ascii?Q?QIZ0ljOrcpuEJqdXpkS7cUIUhaO1ZU+RvqqxoaD5sI3RfEU4Q4oA/t9/eOla?=
 =?us-ascii?Q?yiJ/erZSwJJpUlx8OcHO0BQuVHKChB3n+G9W+AMrzN7710chCLEBegroHOoX?=
 =?us-ascii?Q?1dKclgq+DA1ZbC+tP87dJJYbvmQB5yEyRbtSMtYMEA+Do7IT/SBNjPYJWixC?=
 =?us-ascii?Q?T4xSyZOHL8yNdQG5zl4vrkXNr8IbWMhu23WwxOlvzfSNKGuGhaeZbzWJavIk?=
 =?us-ascii?Q?yqKlkEnyuEYqL/+VhZVP1uGRNAUA3svIuTkLYiq9SOluUABwB+HKegKKN+Bc?=
 =?us-ascii?Q?cARC7/SpLUWrKj5MR08eF+xHVLAnNzPv5SGtDo3Hb12j+kYPGLXg3eah63fC?=
 =?us-ascii?Q?g0xNio8Q20Q3XiT0fJtZNAZSljBuJx132/TeFm3ZR9/NEd19qaLgyEmNl+Iv?=
 =?us-ascii?Q?1mjBAD2B1GsI5nVQ41AJzxlXJavwe2N6LnVbuf41jSy+ObdB8DJ7qJN/4bUK?=
 =?us-ascii?Q?/1hhWwGxVMYmrzp4p3M8hPiBAM/9SqoYDgqVLPBNylyIbn/q1qiRr37RlrwK?=
 =?us-ascii?Q?U8y9jIpQ6K2dWEtO7s/ngmzDLjYETp4st+pcGPRIZE8cwtgjp0ypNWllPSSa?=
 =?us-ascii?Q?dTzvQ0eauC4aChgvDQNdtbYs6aJkILw/+1GiPGZz+8qys+dgMuDmE4a/4DJa?=
 =?us-ascii?Q?AykJuwAGKu9JsNC/HDfNfzvQvydV3mLm7lGc2t/NiqJ+XJvUaSh5dFvxOHQP?=
 =?us-ascii?Q?IpkntMitYNrsoWMKUtLwiHP1VqeI2cvtXlADB9gnmncDx9+AXgSnezLe6e+e?=
 =?us-ascii?Q?MOfHsPsu6VY6fLH7GJlkhbU5enFhRF4LLTzEpnCMPnH/q7OvpZ6jOzKqtFYi?=
 =?us-ascii?Q?HAmdnq1BZVCy5/I5SfQU3LQYCCEbLYJeQ6PZljPiUOd6h1J7vML601gM4OCV?=
 =?us-ascii?Q?tPUu1kM/TQe+MDEKJ+qgD6sdxQgBhFNSMvDHWL3iRp6lA5bNzw0gWl5iMSt1?=
 =?us-ascii?Q?HD1zOQQGEBap+pJN100VKUc5SOV1SNIGa/M43SahqjdDgeynNOIBCFIoyXwQ?=
 =?us-ascii?Q?JAY/bsDudP/OaFFEo+E4PQJB5bOgl68bZNXAAzM0Foeo6LxBOLLvvSaM78fd?=
 =?us-ascii?Q?/tnrkMwI96/xbMc6mhj2jgxm3alAy2OFMbHs2n13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39d7c36-6352-4163-75db-08dae4bd7257
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 08:12:34.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7caSZaf0CrD9t8zDa4ot+MtR/YxxFU4SNL1Ba1y3MheP/pTKq/YaLEbDbN40p2Ucr1u1Q5YkSwWegXyI/BtZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:37PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 41 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb647f55a169..fc12d35bc7bd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1107,6 +1107,45 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +        struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +        int ret;
> +
> +        /* avoid suspending when EPP is not enabled */
> +        if (cppc_state != AMD_PSTATE_ACTIVE)
> +                return 0;
> +
> +        /* set this flag to avoid setting core offline*/
> +        cpudata->suspended = true;
> +
> +        /* disable CPPC in lowlevel firmware */
> +        ret = amd_pstate_enable(false);
> +        if (ret)
> +                pr_err("failed to suspend, return %d\n", ret);
> +
> +        return 0;
> +}
> +
> +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> +{
> +        struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +        if (cpudata->suspended) {
> +                mutex_lock(&amd_pstate_limits_lock);
> +
> +                /* enable amd pstate from suspend state*/
> +                amd_pstate_epp_reenable(cpudata);
> +
> +                mutex_unlock(&amd_pstate_limits_lock);
> +
> +                cpudata->suspended = false;
> +        }
> +
> +        return 0;
> +}
> +
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -1129,6 +1168,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.update_limits	= amd_pstate_epp_update_limits,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> -- 
> 2.34.1
> 
