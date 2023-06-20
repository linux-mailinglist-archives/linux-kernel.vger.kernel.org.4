Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934F47370A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjFTPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFTPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:37:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27791;
        Tue, 20 Jun 2023 08:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ZMZMhzeNwd9x5a79z2gkPIEhfCpnRLJt2IezeEgMSu5CWYcVAsVUuI8r7/5WOTjGoxPNTX0wploeLzA3IA1Jz+PvJ5KzoLhyynAW7cv6z60b0bYpNXwlTpj58pLAaYLbMyphh2ti2t/DTLpZ4i2/h5Syv/lyvL4sjieWfL7ihiSqo2I94aMiXDNmm/iNvgiXfRzQG3vaXc4/PrUmGb78U2QNs77aukcpTs0/yebYC1+ZjfiXFEAkCqHjDStVvDqZHlYoXfHaVrftYEw7ov7kOOnVWAq8pff5CP8zSSX5dl1J+q2YWl+m27/8Ny6koyofQO6qU1E2XabQMXREIuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZksLf7vzqZKTBFe/qMnOzTojwL5RI18tzuIYwPv3FoQ=;
 b=M7rJIl6kmxGSQ4iq6Dzbuc5I1KTnYHPeeLR86Aejt+iIDz+V2pS9yVy2uj1IzXb0eXmbVqSF4qobwEs4lXSrdea0O/VQZh0wXnQ2GzO4Cbn6teyUzdsB/DkXGJjQLbemAk5FZLJnx1XELaR39ypt16fEpnpCDWQbbZuYnF4OL6KFlb5OBwmprg8Gkfj+Eq3/ztLprghJKcjDsOmznw0f9Jg8zk36gg2exrOTxGyUACZ7aVX9/AYO+ucF9rPorSPHFo4M/nZE+3iZugeippdb5QOVV6H0hMdAcrnPdDkQzH2z2cY1faQ4KeF1ZEBbHCs10JxMVyKJWxQ2jMr0vd9xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZksLf7vzqZKTBFe/qMnOzTojwL5RI18tzuIYwPv3FoQ=;
 b=fHrHju6tL615q08GhUQwzoF2PrqdWrYEY7JdKER8sR9p2Owgouc5z2tp0s2UDLBGdhIwrsSQ30qhlQbC5xVw2Lt3BzF1lWqqNkjUDQwcAPTmS95Zm7fnTJCJKOBLLWZ9EB3/x7NrIuicZK5KAN7z0Uc2z+qLNi/FCXlt5g1tc6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 15:37:21 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:37:21 +0000
Date:   Tue, 20 Jun 2023 23:36:59 +0800
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
Message-ID: <ZJHHm7RbX1J+LMoh@amd.com>
References: <20230615063225.4029929-1-perry.yuan@amd.com>
 <ZJG+Xhun1Ltw9ox/@amd.com>
 <bffb7ba1-c8cd-2653-94a6-e0b5cb52bc49@amd.com>
 <ZJHAatXe+iVzM/JS@amd.com>
 <9e3577fa-2bd2-da2a-bc35-5e70f49e011d@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e3577fa-2bd2-da2a-bc35-5e70f49e011d@amd.com>
X-ClientProxiedBy: TYCP286CA0190.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ab0820-dcdd-4765-b4c5-08db71a43cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMA6tBSe1D6R6iZnKkCPhat8IEbIewVTmLSGB0Hs4iG46un9HiM4uyy5K1wGbG8aKMtM79V4QHqM/ySao5JjEC2lbXUn/tozHEDKqv/28AAq9X2UuIHi0Lk+o5jZXObHUcvScdTdIyQNVbiZAIMRt8IhDzEc88/WB4i9t7ogM3WWTGWBTH4gt5kcM35VQ4Umj7WXa/hPNBak4KRCgY+QeP+hV2xhU/1HarrveYPLdCy/HTf2VdYi6FsJvMu205YpMGdUbe33J+1VDULVtLYIQxhx2JMCrJyeT+7phx6xljh5Y1l5JEjsdMLKwwTc2OJkC9lzD9TtGhFKWzfkRh5jNQs9cJKxETgO99DcUlVFQdK1AZE0o2PTohgkiFPb+SglVhq4mnQvvokZn2qtdQIzdNfX+ib+V0mCEHqwu+61Rt6r9njgt7g4O0C1DXrK95kIAY26AeHH85xCJLWkLePimRIQSAmOCYr+FyON8RKijjyDp+c4SC6WdWGfGBFXQ6+ZXDdopJSxVkMWuMtpKIPrCZQhs0nfhr59y+DV/9kWzu0vo/tZdDkd4FzGVtyIZo6dAZaJ3tm1Z8cbb7umAQN3eDvesNWRuSpDIlPgBAUTgVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(8676002)(6862004)(8936002)(186003)(6512007)(38100700002)(5660300002)(26005)(53546011)(6506007)(6486002)(966005)(86362001)(2616005)(6666004)(83380400001)(37006003)(478600001)(54906003)(36756003)(316002)(41300700001)(6636002)(66476007)(66556008)(66946007)(4326008)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DLwvmNgzDTU+xlLD3hUu9TEKUmMsijISj/JJckKYZW04ckfYnwSlVtoD/K?=
 =?iso-8859-1?Q?/gzgvsrLetJaKjdJPIWUBulveqaV98bsdSUpfB7zScaLVP9D5MFkTI7+bK?=
 =?iso-8859-1?Q?2RggAU1mQYz4IE7imzuvGmYHIJCTT+YO2BPjCz3aMwSr4MRGjpAc7RS2Ct?=
 =?iso-8859-1?Q?GzUIk/Gpun1nobbNnVdyO+Xp05YAV//8gjQiK3eOwp8N3ys+PxLpoWbVHK?=
 =?iso-8859-1?Q?JEYKyVczbvR4kZMBPlx9lgTEez36WYjIlgW/aj77f+pRZygV+BL8gr0bSu?=
 =?iso-8859-1?Q?eGoC38BdKpzr+zcHB+0NOFDm/knlvWZeqiZpGKUkO2Q5hQSDly6CeIxebP?=
 =?iso-8859-1?Q?N09Htgxt8dJ3nP6g0J/r6V0ChAQWF7FRRE5v4PHMIxkGgaVmfvAI4fOWof?=
 =?iso-8859-1?Q?MT3q8LK49LSyo7ZB86NzPFwoMPlvBix8QkukavM7C/P9XvcjIOaaIMpgV3?=
 =?iso-8859-1?Q?5Ca+KwkGQpsK9z9dsmKPzkQm3xWrLwrg7gNuZTcICE3OKCTRLDUNFE9TUS?=
 =?iso-8859-1?Q?hlYZA80Xiou4aNBAgW8Gm35+kFBXKAbSJF4b4f1oYF4OI2p3Cqbdpnl7Tv?=
 =?iso-8859-1?Q?e5U9B2mhfM1qCLTegtVtk0ke+UXbyTzCV1yGgBckvtixwNy8+aLkGJlKx+?=
 =?iso-8859-1?Q?PWT9eKuW04wbdW/UJ1uXOugQbHTXnS8LvyzcxS6vF2buhLXeoJi/kuzSox?=
 =?iso-8859-1?Q?X2xQaKV0FYeP8VcAcZoYK4s6gZVOrHxJryjJKoIUU6JE6iJXhWTFQ+DxGd?=
 =?iso-8859-1?Q?otMt6kttwmi7Dtsrsh+4XvM46FvoTPzjw/8r3i8rG7DENXzNmp5bdiDp4j?=
 =?iso-8859-1?Q?vmEW3Qo+IgeeKNcBQOC9+T40b1Q/TrjYDvZZeMA+F2zQiPUxQ5OkEkJo29?=
 =?iso-8859-1?Q?zSQc1mKsyLUpBOdlyudlhj6BD1gLtoNCAjRhm4AvARldZbKcGf9lRlbCoG?=
 =?iso-8859-1?Q?xTWQjmuztjvNLC56QU9rrEqloBhz5P6CdeNOkgNxCRtJveq3TmAncp7gLj?=
 =?iso-8859-1?Q?YBJXps6491w2suIt7+QEJeU/Hw0ZHJxo7htHSpW5cScSblfieZfp4cW8zx?=
 =?iso-8859-1?Q?4SVsSwhTQfJa3iHdUaCWeiCrWBWdgQblm5/P0fgedx1zlH/xhiKaSVOeV9?=
 =?iso-8859-1?Q?0fkOC02vAznkWi8CNwDD2fmLlBVdTx2vw8mjasTtOGGiLhr1po25IzvLhC?=
 =?iso-8859-1?Q?anIq99bqJ2lHJyC5m3+bnZU/RPr9MzHCezzCu3hBsHDIUqXpl5eetEJste?=
 =?iso-8859-1?Q?U0GTGm+Kqa49AnZuMxZieF9HBWX1zwQkCHPov7hmKNvlqJRVwN9us5vQiR?=
 =?iso-8859-1?Q?wqfORSG0KOMYic+ur+s4vbsg9+zTDbgJl7t72F9T6jcb/TXo3hMckvfff/?=
 =?iso-8859-1?Q?L49tnTjnDBunsWoKvHu81yPv4XCt+pR1tM4k0ox0mWotaOq7fayxnGWhD4?=
 =?iso-8859-1?Q?wRmatmntUSNic7p/1aHoxpTcnlLZZ+Id4HasjVvyBeCVQnIYogLsdA7yy6?=
 =?iso-8859-1?Q?TPAQnOcEsyGlvEU2zX3f0uB3DJD0gUAPLhbxUjf5lHCz2lfGKoucyec2Vw?=
 =?iso-8859-1?Q?LBsss2MIWlvsF5BpdNvZWxjW69LYK94i92w0LByChCoxG6SUhkFHTV68wQ?=
 =?iso-8859-1?Q?teYIqoiOh3wO7e+rFJEzgSffDIG27/n9sE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ab0820-dcdd-4765-b4c5-08db71a43cd4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:37:21.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJYuV5H6y46REDEZMdXPSa9Qp0OFhOxJWIs7zdfO71M8bb750Jawns+bzhfmFsIx66gJ6d5o+wETZgOcD7tCzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:18:30PM +0800, Limonciello, Mario wrote:
> 
> On 6/20/2023 10:06 AM, Huang Rui wrote:
> > On Tue, Jun 20, 2023 at 11:02:00PM +0800, Limonciello, Mario wrote:
> >> On 6/20/2023 9:58 AM, Huang Rui wrote:
> >>> On Thu, Jun 15, 2023 at 02:32:25PM +0800, Yuan, Perry wrote:
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> If a user's configuration doesn't explicitly specify the cpufreq
> >>>> scaling governor then the code currently explicitly falls back to
> >>>> 'powersave'. This default is fine for notebooks and desktops, but
> >>> May I know if the processor is powerful desktop such as threadripper,
> >>> whether it will be default to 'performance' or 'powersave'?
> >> It's currently defaulting to 'powersave' for desktops and
> >> workstations.
> >>
> >> Do you think we should adopt performance for these?
> > Yes, I didn't see any different use cases here between server and
> > threadripper here. Or I missed anything?
> Workstations and Desktops usually have to go through energy
> consumption certifications.  Couldn't setting it to performance be
> inappropriate for those?

Hmm, that makes sense. Energy consumption certification is sufficient
reason.

> > Do we have a way to separate them?
> 
> If Threadripper identified as
> 
> 3 Workstation
> 
> I'd agree; but I'd think we're going to lump AM4/AM5 desktops
> along with Threadripper.  So should we still set all those to performance?
> 

If we don't have good way to separate them, we can set them to powersave at
this moment with your original patches. But I think we would better dig out
a method in future.

Please add my Acks for these series in next version.

Acked-by: Huang Rui <ray.huang@amd.com>

> >
> > Thanks,
> > Ray
> >
> >>> Thanks,
> >>> Ray
> >>>
> >>>> servers and undefined machines should default to 'performance'.
> >>>>
> >>>> Look at the 'preferred_profile' field from the FADT to set this
> >>>> policy accordingly.
> >>>>
> >>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
> >>>> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
> >>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/cpufreq/amd-pstate.c | 7 +++++--
> >>>>    1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> >>>> index ddd346a239e0..c9d296ebf81e 100644
> >>>> --- a/drivers/cpufreq/amd-pstate.c
> >>>> +++ b/drivers/cpufreq/amd-pstate.c
> >>>> @@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >>>>    	policy->max = policy->cpuinfo.max_freq;
> >>>>    
> >>>>    	/*
> >>>> -	 * Set the policy to powersave to provide a valid fallback value in case
> >>>> +	 * Set the policy to provide a valid fallback value in case
> >>>>    	 * the default cpufreq governor is neither powersave nor performance.
> >>>>    	 */
> >>>> -	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> >>>> +	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
> >>>> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> >>>> +	else
> >>>> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> >>>>    
> >>>>    	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >>>>    		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> >>>> -- 
> >>>> 2.34.1
> >>>>
