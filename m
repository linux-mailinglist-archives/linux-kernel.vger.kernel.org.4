Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B46736FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjFTPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjFTPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:06:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8887C100;
        Tue, 20 Jun 2023 08:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwQ5lj0d4lJKn0S/Z+BeqfvDuZUVuivQoMDyZzpE+fE/j1Ey+zi6xHonbHgnLpDDlRlgH9P9SR/2OeYscf/uy5uGyVy5jvd3AtNkv5Zag0uB/bXFthOZZ3ku/FRcOc4+iOOkf5m9k/HD3z4ngk+2/LZxRYQ65cSci9pC6eIoAmT2YBg9AbQUkXVPpVvbnQSt220jhZK0iwTAW1KLuxw00j6d0M3vyt0mND5ifAPOhxQoT6NXXgjhkj653opQhLtlWh7isTmDJTWIbKW+RkdD39SgsNjyVRaKgnyxANen1tfwdInJUIeAvrPSLlKN+snj3KW4F0VKazg/EuxjxgfCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXDuJpXj7WBrC+3ZFOfwgcI8vDJ1k/tMpgxHPBjlw4A=;
 b=gnIQJNV8a5jA9ZPomhMWWvHk6ErOtsBPhIAybYpoIq156paKt4RYVDNyC0PZOW0cdoNgiNHIf+bLprdtAbXP6GOCieFjaTbQRiLA51MFumpbsqoO3FkCO1V9cMUMltAd0C1d1t/Wd1udHqFVtaMIxQ/i2gvf9F1mMzUzsRO2chxLmBwukREg7snfBcmZao9+4UKvHhw0izrwdbA2ul5LqHusuIraWN7fSuFxwjRIpYBzXoYdNLlPzr4VeE85ALbG2Di1B67kKImsxe2G8y+Md3OdrP/qQin+sN/ELA53bNKiti/+n5Zx0YzxGvJiV3oYSRciuG/pWjQ5pxYFDwD7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXDuJpXj7WBrC+3ZFOfwgcI8vDJ1k/tMpgxHPBjlw4A=;
 b=GqPAyY7oGAutKACDKKBMMwDDjRYB2k4O4JKoiTqvv3Lrdj8Ta6OrGjrLKK3eQQcwUh54wS+5GtSGgL6I2c/ep+OdSS4eQgt7rT0pB2OFKstEbcYJz0ffaZ8nW+WGp9iasRLWWpr5rGbndSTniMx9CPp0PFcEwqk7Hx/ECOitWus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 15:06:44 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:06:43 +0000
Date:   Tue, 20 Jun 2023 23:06:18 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Message-ID: <ZJHAatXe+iVzM/JS@amd.com>
References: <20230615063225.4029929-1-perry.yuan@amd.com>
 <ZJG+Xhun1Ltw9ox/@amd.com>
 <bffb7ba1-c8cd-2653-94a6-e0b5cb52bc49@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffb7ba1-c8cd-2653-94a6-e0b5cb52bc49@amd.com>
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 27214518-51f5-4d52-6c24-08db719ff517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyO/2Z8D5ZN/J0LMZkJGQIl7vfuqpJuIYSKeYMgoCyF0rncjkDkdQr/JMbtd68bxBigRot3c9BKCCOIU5XOWbe6bu4mc0Zp7r8ny6qrqmMf4VXc5lCjGFpHclYrAY5+/HanJxAj7CPwlQqPPaL0YDFAOx033JFmmCyUf7+i4m+954gAHHB6z6QIMYmXLvfve5+vBz9jBBrTikh4R/vWETCj8mQc2fca/xRUFjalXdhQKAWsX7RsPXK0jmkkJhX0OlmlXVl0aLmJmyNOqMsTuZtQtLGE0Sa34disXQbVdFuWdfWsdvRgzJseffa8UkT2uNTtkWTIA4KgWak7n67FTtTC94XIzIneo7moBFZbDUrGJWTT9T51eTcMCRc8daCfEsF3SfBqCk4FaWwYWjia9JqmjOQF3Y2lUpRyH+3pP/n0SkNtaPkL+lXc+UVTxRuT9ZF7ZFNsbl/ZBXMzAH7SYrmF9fN2aiNVsqugRxq4eGY74Nr3PuEzJ5B2ac0I5c6X9mC0OwRWWrs4Opr8K16mMXZmC7OwK11xxws/M4zfjHkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(316002)(5660300002)(8936002)(4326008)(6636002)(41300700001)(6862004)(8676002)(37006003)(54906003)(66476007)(66556008)(66946007)(478600001)(966005)(6666004)(6486002)(6512007)(6506007)(186003)(2616005)(26005)(53546011)(83380400001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xqtEyKoZMTNhWZTk/Ujz/tEVb0/vJX6sQkYvQkVG/22s1NuHpRoubFPmhfP?=
 =?us-ascii?Q?qVkHcQPCegJwtQ4yCmX5C++VnowwGo4bJtdiO7CjaG9B8YRBP/h4N6G+BdLF?=
 =?us-ascii?Q?jBpiNbcjajVQb+nb7HIgbDV8pBwBmQ9l67A9sOJHM6fC1ks6jRGLzo/VZGBJ?=
 =?us-ascii?Q?ObRhKW09FoOcRUx3+Is4m23e4TqILbb2hHAW39d3U6nVww+RPVTJhDSEgDvz?=
 =?us-ascii?Q?yQC+CcROb2HCl1Wr5aclpWDwoYU8NDHnaTtQm8F8IXdHLzyt71pzHc5SPKmi?=
 =?us-ascii?Q?UtbL76+xuSWcJlMcSyAKq5t/qx38VUz7nwObhjZDejUr4mk2DjhiVMakPYxX?=
 =?us-ascii?Q?58ryVN56DC2FqLj6YJTJ9knICt8ySEY920EcXRfx169CxX9p+5wO/UIDrpZ/?=
 =?us-ascii?Q?evL/9/5w/IbrlNjHEl+v8OD62hDLq3OTAh/BJPx6Zoo1wzvWYLo9X/lSx0a5?=
 =?us-ascii?Q?TBmDga82vobhXUkFs6P6T5qNEa0tLkQ5dec8e0G415jbq31kTPlhmaTFzf5r?=
 =?us-ascii?Q?lQySVc6yt3hMlMRjNX/g5c/R3K3StY6jYIAmoe9YTrTr1UAG1CxmMj9Kb4xJ?=
 =?us-ascii?Q?HutiCmYzNtS3C1ppW/mIuF7Tgy/rDcLwKdJepWEji13CUMbjFhPUaGVSXCj/?=
 =?us-ascii?Q?731pjpzStYX4bbpy6ghaf9nnHz7YafDNuOuNk5n5OFsOgxaipsUhI7DIhXGo?=
 =?us-ascii?Q?0AuBSYpGzkUtmNxt2KYaPylGcoNEKIEcIORusoTVNkc2BNAC5yxc8+Ze13MG?=
 =?us-ascii?Q?DmkEjZHBtTBEso5JZ5RHySuP4TXQtUdFDETPtm5oE/nq5kFKB3CpkM5UGpIX?=
 =?us-ascii?Q?E+53alHGZliLBIZL8o9+0t2UVyZHsYYOwE3VqHw6elSfraR2i7NTmdH6ZjPV?=
 =?us-ascii?Q?x+17Dv/71ChHAgeqwAuKbUOhLikjz9iU92xbMNtoSqQlIt9ovAwazB5q4Lcp?=
 =?us-ascii?Q?ll7Rjg3ndUJE298MI4zP+sLz+9EPNiQd6SUWHbFxVnHl91UG1YDCM1U4gM9/?=
 =?us-ascii?Q?9gN/8izAw9rA3XsZPHSBszU63avbEPivguyt0WMH79TyEX0OkowbLwLiZx8F?=
 =?us-ascii?Q?0jT+ZbY/RmRTiIdzoO4/JKtKNaYbfqb/6esvUeiICUqs2TntoQHumCLPkVHE?=
 =?us-ascii?Q?WF3OG6JnTOUaiM9Oexh4I8WkO6FxImhiEVtklgYvzQoNvNQZLMJueGCHA96d?=
 =?us-ascii?Q?j0A1R8Jv1/S0T2Z5Qf+II6tOw3++6bETXHVweM6nhp9bcLeME1Umn9h94Lwg?=
 =?us-ascii?Q?e1y6muubSZ3iCXnYWpEKRVRzpuAaVjnKSSWeZ7GbUft4kfPBq4WD64ZUoz1D?=
 =?us-ascii?Q?3GcZ3Cv4tMSgHZe8V5dA0GU6alqRJ3qrv4RGDNzmtDmE6cIY+vSh+nXiYUWk?=
 =?us-ascii?Q?1T4pyD2y7BAIA93477WhWUmsb1iZXGReB2a6iM0D/ST6bvzPMjuQTPsp9eG6?=
 =?us-ascii?Q?EARDDte8Jy3CA3lAg3lAz8gDb9hvXqrcPLJkxxq2DUlgW6wrv2ivvxoHosPi?=
 =?us-ascii?Q?1qLIgks+DMDtnkEfKjgNAyXOhWwGIg93L2GIUGAgAloIrQwvm5NfjFq3K7Dj?=
 =?us-ascii?Q?p7v/NJ83ORmR0JbPlQd97f9/61AHGn30x3ZWjnjt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27214518-51f5-4d52-6c24-08db719ff517
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:06:43.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TFUdre8/USsGwUq2CMShDCtMm7EQ7zBu4PxKrki+DYX4AmgYhjLVcHQUXZEBd1Q97O5yirEmark2RB0toxiVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:02:00PM +0800, Limonciello, Mario wrote:
> 
> On 6/20/2023 9:58 AM, Huang Rui wrote:
> > On Thu, Jun 15, 2023 at 02:32:25PM +0800, Yuan, Perry wrote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> If a user's configuration doesn't explicitly specify the cpufreq
> >> scaling governor then the code currently explicitly falls back to
> >> 'powersave'. This default is fine for notebooks and desktops, but
> > May I know if the processor is powerful desktop such as threadripper,
> > whether it will be default to 'performance' or 'powersave'?
> It's currently defaulting to 'powersave' for desktops and
> workstations.
> 
> Do you think we should adopt performance for these?

Yes, I didn't see any different use cases here between server and
threadripper here. Or I missed anything?

Do we have a way to separate them?

Thanks,
Ray

> 
> >
> > Thanks,
> > Ray
> >
> >> servers and undefined machines should default to 'performance'.
> >>
> >> Look at the 'preferred_profile' field from the FADT to set this
> >> policy accordingly.
> >>
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
> >> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
> >> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/cpufreq/amd-pstate.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> >> index ddd346a239e0..c9d296ebf81e 100644
> >> --- a/drivers/cpufreq/amd-pstate.c
> >> +++ b/drivers/cpufreq/amd-pstate.c
> >> @@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >>   	policy->max = policy->cpuinfo.max_freq;
> >>   
> >>   	/*
> >> -	 * Set the policy to powersave to provide a valid fallback value in case
> >> +	 * Set the policy to provide a valid fallback value in case
> >>   	 * the default cpufreq governor is neither powersave nor performance.
> >>   	 */
> >> -	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> >> +	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
> >> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> >> +	else
> >> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> >>   
> >>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >>   		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> >> -- 
> >> 2.34.1
> >>
