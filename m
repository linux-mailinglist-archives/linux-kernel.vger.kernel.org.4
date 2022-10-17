Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514E600CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJQKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJQKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:55:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AB4F19C;
        Mon, 17 Oct 2022 03:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCo2GR0kJU+APIU46oC4+m99uOAb5/iGJDn0+E1pq1OHlDR/NttdJZgT9zcoOrRzWJ0ePxibUh3n/qY0VoHUw8gtD2R32Avz7giy+WSCsiu7mD26cWCpZUpNdHG/ck0arM+DTD2rm0sju8l74JpGM31FU+LI4INRojMHywFx/D3jOM02pzDMMi4u79Uc1haPKanS/Dg2Wyf2hzFRKy6E8ZpF6eEiRWQcJIGbvFEWVMeGINyIrUTU02GWWxO5jypfQj0ND0gqMMSnnKLkl5mUxsa1Dq9Y9GhPfI8DkGK/x9DraJM4JrwJWzKhn7lNL9joITclg1WUKibR1wMMBE0RUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbbncPY6sM6KKBfHFLlk1RR4mo+iLS30Oq1mU/ZgwE0=;
 b=g636YNTl3qMQQVOmrldvBTshd/bZ7o6fp554K76xU/eEo0RMN8wNPNN33JUYNt3243Sfzu1yHbNIxtfI3SihE2gxBKdpo4VKnQBBwEUpBqrWhAwWC5MLQjr5SnRTVg+bcSl62OklWfkhuvYGS1PjHzH6+HZrUW2/SSk706kI+Qg6JROBgxEYEMdCLST/bQfayNxVNdIPRjZzbICsweXzWpnzQdkmP4+fFbaajBLwlZSh4pozM/vpbfwfDv6Vdq4zLHCjWH63q//VsYy5p5vXEIOY4XhT6m/ZvQClpll3piv5xR/oFGxroMEeC9Cy7MOKd9lee8yOq76D/7AYOKB+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbbncPY6sM6KKBfHFLlk1RR4mo+iLS30Oq1mU/ZgwE0=;
 b=dsEFW9DJ0/9SSAeKEc19//KN552+GJ1TPnkV21U08OJC3GiUA1mLu2JhJgry4HGBnxjPsxC++2qjE4B1HSbiAVQ8lx/iCPc8fd5nWzl53AIeNCE5moFQ4eJyTM81+uHOgPaJwhgvngkad5w1cwlBP/UfnKzaUuEthAp92rLM9QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Mon, 17 Oct 2022 10:55:10 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 10:55:10 +0000
Date:   Mon, 17 Oct 2022 18:54:48 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate EPP
 support for shared memory type processor
Message-ID: <Y000eLQY/nKqiNFZ@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-7-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-7-Perry.Yuan@amd.com>
X-ClientProxiedBy: TYAPR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f59069-2489-4720-03ed-08dab02e0f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q8GTOFCmnbC10ANcKN2oqmdsiHCwPKPaNJkebCNnJkJaRPQPznXmzfILxaheVoxuiwzYJQKleV/txr0gfJrnrSz7zwJDHDtiTU2NVaCeHv5htPRXE7EXUuTW4fTz6eA0ZVOzGsyk9vxu6CzzLH5UrM1WmL3S6PyMk8IthSPh4gW6iYrxiMwBOf/uxDL3FXlPHUxRPaSOgRLJZBTlmKqVEmKFKCI1zsVXV+1fTZ0IPvAgO3x6iv9Lq10rfMBKehOHaKyYuA+xI7yYBhdR9HWvcRx12DzygfqUPB7J0536HHlepVIn0hc4f0jCUZ3p67TVqlML8Kb+Je4gz20epS2dJxqqJGq4E1kUJcTSePRsr7L/4RuuaJu4AhpmHYim2B+d8lCTg1agBpucsKQtPtGWEPL1/jRlTt+afSGA2w5T2uOb787X2o1WmPgbuoLYQpVaYGFfz5uNYIIKL0URBb89fynudU0RA2hzq7DyDNZEVo3nSjBXUQB0oJ0AlmsK1KEulkwPkcqnkycYglkZf2GX8sPLcn6Ibe4rSLDxlSzRfhpFH1tKQK9XIG0fjq5ld5uib3mZc8nm/IPvqEY2cA/wBMuP71LMpLni2jjSleIvFTHnSwc6zNhKfuEc3R+mSQgFvUOIj5aCTiJBEs04/bEnRqMVg/VCV3+ISscoTnQgyQIfoNTlFuL4C1lt/kpNiHVwZB/lKjAddaqGurUSiJChQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(316002)(6636002)(37006003)(54906003)(8936002)(6862004)(6512007)(26005)(186003)(2906002)(2616005)(5660300002)(86362001)(66946007)(66556008)(66476007)(8676002)(6666004)(41300700001)(4326008)(36756003)(6506007)(38100700002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cakVetwUX/3aJsJGL8xMJs0GzokEpaozvOGLkeBFfMQiVdRfncLp+gB01UoM?=
 =?us-ascii?Q?4TGc5fHeDvKo6rOW5Fgi7xQnSFZrf+WbLPDFdFK+jcDmZ/YhoS3kJvgF1CAv?=
 =?us-ascii?Q?HKzyQKZJRkmAnmMYcw5SuqzFt3BezwJa+zlKJ49D2rg3YWQFHP7dMBkx+h3T?=
 =?us-ascii?Q?3ziG8ir7BAwsOcxIJJUb6mJKyBSFroobmQd9VUxoLbQGvWAuJ2dy1TK1Y2Pn?=
 =?us-ascii?Q?9YCsA/lMDMFxMwFB2UKFg9BP1MMUVTolDgLsrP8/LlXEe+jHx8l3hZEKZ9DU?=
 =?us-ascii?Q?2ySg/I/3fC35PWPvnkspyfMniqNXKQwKSoGNjobsOo5f/iMoEvMop/mmuw8U?=
 =?us-ascii?Q?HOihgEl8MyFrtXhyPtqpX6LoiUsteOiQZzmA0qVUAa9i79aOWiloTK4t4uej?=
 =?us-ascii?Q?cA4orGZ3JWr26MpZCkYNMgLYxn1Lr1BvH4C0IV+YXl3ciCYEN4mfyXEJxmM+?=
 =?us-ascii?Q?qa7xpFpj03N/NwSuHanj3mNQZuQYDM1hDWCRmCcu7eJ0vLF2S7UQl9agDmHQ?=
 =?us-ascii?Q?5MRPmuTTPlK8aTmlOaci/vj1802sIKSAiqveuTGRpavVrIv/HKg1C6Ok+jl2?=
 =?us-ascii?Q?pE4qfQNMm/+u7URmtGnK8qRc+AcEgl+4J7LYFAY3uZIa2gnQtnmXKgC97OwT?=
 =?us-ascii?Q?SWC43A8+ZV4LSJIBJgKYQmPMORliGvejPaZyfAvX8/FK3t5b7uRKbWY7HMv3?=
 =?us-ascii?Q?7w5CgoMwoq7XAkC+hiWw2IhKhV57VKkXip85kNyixpP1vluPVo56DPCrAjRV?=
 =?us-ascii?Q?ZnzSrV1BgJhba8bGjqvALqQoxKFCJIQiGg3W5BPfxBS8bA7qctMpsa96EvH8?=
 =?us-ascii?Q?g47/il+uHTVQ2hL71ERIOQJUzC1KaNg5TXTM/I3n/Pkf+63j1+KcdG39unD7?=
 =?us-ascii?Q?Et2krTQcuhBMcGkK1sxbkkmSzfaVhWKt/YSh1mRoHd0SAuYWpJnf/EC1QMfY?=
 =?us-ascii?Q?vBe5wiw4P/d6X5ujQccfYux7XEh29R1va5y4eh9uRgrSzfu3ZPX5RW1jljee?=
 =?us-ascii?Q?obhU96p+skCRIbAqbDCo3k+gGIj3Rw6TKIDC4IZFxticeukD3d5qX5aZMV5+?=
 =?us-ascii?Q?o8sEBEcPbhEm7Dcoaqa0DcKPymCiClStc4vtqyZf97V65nD8SWDIavizdSnb?=
 =?us-ascii?Q?iXhGqnJUKr0beOw17Xq7WrB/bq9R5JM4G1wJEWUvRt0gn6LW1baEPma3Xfoy?=
 =?us-ascii?Q?7G5+MsnJ3X4zB/7HYdI1taqYhr7aJDuZar3fAdhSrxnkKiWbrvszdwmwXzmR?=
 =?us-ascii?Q?SFGm0AydxuHpOV/IUXEmrAC1Nkk2R91xNyLfA/ePEcyNXaJlYi9BRuf64ewe?=
 =?us-ascii?Q?cJ9WxxXR1P6++KehCIxrBFes+5LY1RP/qaNkWGiwSaSm6niu22M0E46TkQcb?=
 =?us-ascii?Q?n7CckQFqbN3g7TdyAVlTR/fRItUnhGWW7zBRGEfU4SnaSMqKv/kxkazw4+fi?=
 =?us-ascii?Q?zOwfyWKanYlkySV/aZdeTIEECUtVwFtNKX+qo/03ywBRMYrM5imBvL45N/q6?=
 =?us-ascii?Q?vSLc1htlA3h4duvHDg5ug1QV8GWiyrhMGiH/ypENl/Aezx7BoSVz/DZYIJxM?=
 =?us-ascii?Q?FQU61DF+dJPpDyklTrnXSS/tCsxMO3p38OUNP72C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f59069-2489-4720-03ed-08dab02e0f0b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 10:55:10.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PIGrMLOzV+Mhq729P8vhERAtUQPgFXLUU5M70THnBh9rNbLL4k2W1q9FInW+DdwnZvIfKeRfP+vqQYLTP8rAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:45AM +0800, Yuan, Perry wrote:
> Add Energy Performance Preference support for AMD SOCs which do not
> contain a designated MSR for CPPC support. A shared memory interface
> is used for CPPC on these SOCs and the ACPI PCC channel is used to
> enable EPP and reset the desired performance.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2d28f458589c..08f9e335f97c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -135,12 +135,25 @@ static inline int pstate_enable(bool enable)
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
> +		if (epp) {
> +			/* Enable autonomous mode for EPP */
> +			ret = cppc_set_auto_epp(cpu, enable);
> +			if (ret)
> +				return ret;
> +
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}

This patch only writes the desired_perf as 0 to enable the EPP function,
but it cannot be an independent function or patch without the dependency of
the next one (patch 7).

Thanks,
Ray
