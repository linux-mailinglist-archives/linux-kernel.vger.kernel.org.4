Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF17698D40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBPGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:42:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BA51BDC;
        Wed, 15 Feb 2023 22:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4PgGetCmbBtnbYluV9j6YFcOU6pQ8dursqJF1esCI4NnWU0WLX0IJW1d81al3p7iRhWf/6+P7OqD4mANzh9YYQrf+HN3t2i23dPci7HgktAmtIf+om7jzaZlumRSB6KHYtILHCsDssbN0pMzg1Ogwk4+NTwn0IgEFkf/tweqz2aeDiG46Tx2O1WZkfDMNk6tmNlmPMP9IXciaPnmuKJGqNkrGoZbBkWBl0nANohrbAtdPh8MH2ZAD3ogAhhAagBSZcwH7h84B82vJgYCP4n4Ns9m8Uhp6ToelmH+pMaDeyfj4Y/VoRB2t/JKThUazuu7Znl3ZhavhkzwrIRD9sVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26pOYKkWXU6SFG8ahWyyq3azPj5BskOxsWTPtyd9URE=;
 b=BxrVjFMtcvy4XSSUdeBhO1Rv/5Q6hH1Da/SlJUsdntvSg+oasnPw/C+l7murwubxEslmCs732nBUCCV7L0FiJqLGZsWxV4oD9/wWYFEKtq/kOvLqEhPV1OuC+txr+ppRNiuHxM3e17sP8LCynVVK3a1RdOiGduQrDvTmYwFMkgJZz9O1dB2zcOrTY4l7Xdd7OIs005La3Ct+qu/Acp5596qL6Dj0655KtbuApLeWdSnoBDN411CmG3tT1KY2YeWdMRMqLZuUIz/Tm+s03+ru89NDuhN90TRrfeawqLrIM4b+Noxj945QIELAC1/7l4i9P1e/gXQ1JWXYC9uDj3HSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26pOYKkWXU6SFG8ahWyyq3azPj5BskOxsWTPtyd9URE=;
 b=Q4Xfzitcfh6A4QzNTns20Ccu2ZigU+ACcXiNCaWz4YF+pYLHdRlsUbHQUVY0rUEITbNcJq3mWyy3DKwoJl1SDeRI4op2i1Mb0x8LTMNySdmHORq3I7WoTvg2nHCnv4lEkn7eX1akaA2jQLSPPC6U1ohOG/KUJ4uGqczbpTOxA1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 06:42:15 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:42:15 +0000
Date:   Thu, 16 Feb 2023 06:42:00 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Message-ID: <Y+3QOKrs4FwPwONe@beas>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-4-wyes.karny@amd.com>
 <Y+3Ic/BtRyKUcaS7@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3Ic/BtRyKUcaS7@amd.com>
X-ClientProxiedBy: PN2PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::28) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc61ed7-0f5a-4b3f-2f3e-08db0fe8f098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enisukKg1jHrqhMOm0FQKzf8jyckdGusu3lPKYFKfqLPR9ThTZi9y9DoYAswEWUe58LvRD72IJJJmuExqSE3zNXZF0oBQrZ/XWjPBtu9S4JHMx9TfUjYAFKDzDVb4IKV+5r/9GRb9xyyceIaEe5dGmRbsf/ue0pgPLs7NEQJwHbN8iBemuJNR4TDD6S4Ea/++p7e9SFcwezEukiMB+2HkTHeQBQV8YGRRH2mD0r09V8yvuTkwxVdXXrIVdB4JQHaxRFtqQFclKQ4doZirD1Z8VTappY8AlSAbv/FA2OUF2qRvLW0Ft3J5/3ZTSi2vjmoHXFcL8XF3tGskvF6ybKIG8XGJ1ETGCwVc92Hl2e/qAGF3kQWhi6+rMJnaJnLCp3xaSjQoCxHRNSCjZ7PpvN83F4wLwh0fqO6wA8nNTAbmsQNGT7NCKTSlJL3UZ1hX0Pal65WEcNIhoZFJtL1i4oQcUeMx7vUYdwbRADI4Piy3U9TohCCN1E4ZR6BKgSEQKiyNCjP9yRTBj0gCZWrGUwGWd5m9gWP15IzHaeP1f+VIpVBh3j4rLMuP7GspTVcieI0RT2YBYu899L1Ji3tbx0x2TjeXHodTnbnZh1EylRWlXn9aLz+RMRF9phK30jXm6nlJBROt3zQ/geh/eqBn2aCU4VT+xpzdh6IkZQAJ9HMYo5P7N6K7SK0y6ITpUg+4SEk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(86362001)(38100700002)(83380400001)(9686003)(6486002)(6666004)(26005)(6506007)(6512007)(186003)(478600001)(66946007)(54906003)(66476007)(4326008)(66556008)(316002)(7416002)(6862004)(5660300002)(6636002)(44832011)(2906002)(33716001)(8676002)(41300700001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDQDvYYHxDWGBGmruInYNTsX7n6cCyQ7R2j54MLlxIkF7fZsXiL2f25aB7j6?=
 =?us-ascii?Q?NFwqm48G5UVWSS9io9btX0xf2R1Krnm5scFGLWszp232vvyr0Srqw73VZwCJ?=
 =?us-ascii?Q?MJUDIl2N3waApGUM05+SRMwCDbRiHkb2CXfixkT/d2wk+cWT3d2MTEqCiwuM?=
 =?us-ascii?Q?P12uDAGRW8kj6oM9MR8UQS6sp6VgY91tgrmAUYHbgvl/rk2P1TeWUj8Ap7h/?=
 =?us-ascii?Q?t/9le3JzWCWtWW2R4TlvXyew3QF1Z1E4XOjUd00YyYK7i8jqhNLQDm2W2qoP?=
 =?us-ascii?Q?Gs5IBpS/SYn8wlVWslK+sYuylUPYmCMTfhAJnL18ruA4m7XHZImEc1g+BwiL?=
 =?us-ascii?Q?rQkoVzF+PjIDN59C7Tzrmf21vONrgk+AuLAFvBd0RTSHbTl8dkejkpleCmXh?=
 =?us-ascii?Q?P43SBdAWctDKcLZsoIfoIsC4YE6r2WjH4+y+ws79d6gXlgWSt1iis/rk2n3z?=
 =?us-ascii?Q?nQgbFlaFT5iNyA36iHz0HW7u38uvobEgPo60jSoYmXt0zlxT49AUpDMwn3U6?=
 =?us-ascii?Q?dGje1C8/8P0fFZCePyBCS85RRIR17sU/cs1lSZbxwpdAZRay+P5WkqSy6A0H?=
 =?us-ascii?Q?HpUYco2CFObMz2lSfBLYiPPOuK0FH7NLp6DTHurP0gdQtydCESih3PgoSyPE?=
 =?us-ascii?Q?XZsAjW9LicEBxNUO9m53ppXPYLvSemElmFHnS7hNur5vhrN9JLr2TxLUWErd?=
 =?us-ascii?Q?SvoePjoG2bq+cvPPKx/bKjKNCl1r2tHTvWHXHE4WbxHaoK6murO6FZ4cxuwh?=
 =?us-ascii?Q?qFodK5pUEjQ2Rp1wLNYrh+W65drb5d69j8528sHAgxdprstpbyJK30rqN0P2?=
 =?us-ascii?Q?vDso/vl1156GDu4lOfNl1N9j5xbF0OJRAxM2+BBzjky4pO2G61vuKC90XdWC?=
 =?us-ascii?Q?7RNNyjbmi4Rko8EYQ0XyZeUlWD6gsyyyl/oFc8jG4KE+kZkKb38oOks9AGu9?=
 =?us-ascii?Q?ZEVp0zpWPEezoXsxQbc0Duk8WzsywK3HBfmDzQyJner2LhHOP9txwSoDE+yF?=
 =?us-ascii?Q?GsJOijxA/rN+DCkvrgJg6apf/3WYQktwXuw2IFRl2bH5yMI5Kx3Bakg2h8xZ?=
 =?us-ascii?Q?lj/zcZ7g1gtxbZJ6h9kzaYxC2BrKQKL3jc/d9UsQkXyqIg7wCp7GWYrZ16i7?=
 =?us-ascii?Q?USE+o5XJoRTyvd7CcD39FORz2VvKO+fuTNfBRpHmzzT5UVaYs6M2SZZ3t4Jv?=
 =?us-ascii?Q?Jh8otXYtNJGAp20mzyk+DTdUgvU5U5qPnCGZZD66RZZwSthw3tshe1ItZZcv?=
 =?us-ascii?Q?xuwT9hAsKkSH2aCbG//XtJz1Kjgo52BbbaakTiQWH0WPZWWIcdA3lM6Biutn?=
 =?us-ascii?Q?WxCCAaoHVrbUpjNMlk54wX4gj2OOsGccxoDdjAEvOvcSj7g+tZB7/AbQmQr7?=
 =?us-ascii?Q?3CkugiOVcA8U1nMpLYw/7TcC2O1b8RosLNs/WxGWFmPJbMk41kQhXEBLeXEJ?=
 =?us-ascii?Q?/L2r19A6doLZC77B8BP1qubuL2GDg5rp57wmcI0BI/E22z3vGaKXm+CRi7Tl?=
 =?us-ascii?Q?r+kDtjkq8EH9gblwK64N7yEQMY+p6BBLdDrtpl81uqaQDXWIfsGF+tgKogRT?=
 =?us-ascii?Q?dG2Io4+m7WD/5daQzxtkkzmpqChJg9Mf6kmXPsxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc61ed7-0f5a-4b3f-2f3e-08db0fe8f098
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:42:15.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtXU3DkCvo7RMQExtlPZ7SozRIWKhIiDoyFBoMsVqakdsmb5cpl4EV/8t3sr5u7pyp9xGmF1AuQbVN8wZ/A1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 14:08, Huang Rui wrote:
> On Tue, Feb 07, 2023 at 01:21:54AM +0800, Karny, Wyes wrote:
> > From ACPI spec below 3 modes for CPPC can be defined:
> > 1. Non autonomous: OS scaling governor specifies operating frequency/
> >    performance level through `Desired Performance` register and platform
> > follows that.
> > 2. Guided autonomous: OS scaling governor specifies min and max
> >    frequencies/ performance levels through `Minimum Performance` and
> > `Maximum Performance` register, and platform can autonomously select an
> > operating frequency in this range.
> 
> I believe the processors which are not sensitive to power consumption can
> use this mode. Because this way can have better performance than "non
> autonomous" mode. :-)
> 
> > 3. Fully autonomous: OS only hints (via EPP) to platform for the required
> >    energy performance preference for the workload and platform autonomously
> > scales the frequency.
> > 
> > Currently (1) is supported by amd_pstate as passive mode, and (3) is
> > implemented by EPP support. This change is to support (2).
> > 
> > In guided autonomous mode the min_perf is based on the input from the
> > scaling governor. For example, in case of schedutil this value depends
> > on the current utilization. And max_perf is set to max capacity.
> > 
> > To activate guided auto mode ``amd_pstate=guided`` command line
> > parameter has to be passed in the kernel.
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Wyes, could you still use prefix "cpufreq: amd-pstate:" as the subject to
> align the previous patches? Because it's easy to sort out all amd-pstate
> patches for us.

Sure, will do.

Thanks,
Wyes
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 15 +++++---
> >  drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
> >  include/linux/amd-pstate.h                    |  2 ++
> >  3 files changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e3618dfdb36a..56d5c189e458 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -7015,11 +7015,11 @@
> >  			  Do not enable amd_pstate as the default
> >  			  scaling driver for the supported processors
> >  			passive
> > -			  Use amd_pstate as a scaling driver, driver requests a
> > -			  desired performance on this abstract scale and the power
> > -			  management firmware translates the requests into actual
> > -			  hardware states (core frequency, data fabric and memory
> > -			  clocks etc.)
> > +			  Use amd_pstate with passive mode as a scaling driver.
> > +			  In this mode autonomous selection is disabled.
> > +			  Driver requests a desired performance level and platform
> > +			  tries to match the same performance level if it is
> > +			  satisfied by guaranteed performance level.
> >  			active
> >  			  Use amd_pstate_epp driver instance as the scaling driver,
> >  			  driver provides a hint to the hardware if software wants
> > @@ -7027,3 +7027,8 @@
> >  			  to the CPPC firmware. then CPPC power algorithm will
> >  			  calculate the runtime workload and adjust the realtime cores
> >  			  frequency.
> > +			guided
> > +			  Activate guided autonomous mode. Driver requests minimum and
> > +			  maximum performance level and the platform autonomously
> > +			  selects a performance level in this range and appropriate
> > +			  to the current workload.
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 168a28bed6ee..6582c922ad3a 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -308,7 +308,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
> >  		   cppc_perf.lowest_nonlinear_perf);
> >  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> >  
> > -	return 0;
> > +	if (cppc_state == AMD_PSTATE_ACTIVE)
> > +		return 0;
> > +
> > +	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret) {
> > +		pr_warn("failed to get auto_sel, ret: %d\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	ret = cppc_set_auto_sel(cpudata->cpu,
> > +			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> > +
> > +	if (ret)
> > +		pr_warn("failed to set auto_sel, ret: %d\n", ret);
> > +
> > +	return ret;
> >  }
> >  
> >  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> > @@ -385,12 +400,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> >  }
> >  
> >  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> > -			      u32 des_perf, u32 max_perf, bool fast_switch)
> > +			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
> >  {
> >  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> >  	u64 value = prev;
> >  
> >  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> > +
> > +	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> > +		min_perf = des_perf;
> > +		des_perf = 0;
> > +	}
> > +
> >  	value &= ~AMD_CPPC_MIN_PERF(~0L);
> >  	value |= AMD_CPPC_MIN_PERF(min_perf);
> >  
> > @@ -445,7 +466,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
> >  
> >  	cpufreq_freq_transition_begin(policy, &freqs);
> >  	amd_pstate_update(cpudata, min_perf, des_perf,
> > -			  max_perf, false);
> > +			  max_perf, false, policy->governor->flags);
> >  	cpufreq_freq_transition_end(policy, &freqs, false);
> >  
> >  	return 0;
> > @@ -479,7 +500,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> >  	if (max_perf < min_perf)
> >  		max_perf = min_perf;
> >  
> > -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> > +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> > +			policy->governor->flags);
> >  	cpufreq_cpu_put(policy);
> >  }
> >  
> > @@ -1279,7 +1301,7 @@ static int __init amd_pstate_init(void)
> >  	/* capability check */
> >  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> > -		if (cppc_state == AMD_PSTATE_PASSIVE)
> > +		if (cppc_state != AMD_PSTATE_ACTIVE)
> >  			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> >  	} else {
> >  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> > @@ -1341,7 +1363,7 @@ static int __init amd_pstate_param(char *str)
> >  		if (cppc_state == AMD_PSTATE_ACTIVE)
> >  			current_pstate_driver = &amd_pstate_epp_driver;
> >  
> > -		if (cppc_state == AMD_PSTATE_PASSIVE)
> > +		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
> >  			current_pstate_driver = &amd_pstate_driver;
> >  
> >  		return 0;
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index f5f22418e64b..c10ebf8c42e6 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -97,6 +97,7 @@ enum amd_pstate_mode {
> >  	AMD_PSTATE_DISABLE = 0,
> >  	AMD_PSTATE_PASSIVE,
> >  	AMD_PSTATE_ACTIVE,
> > +	AMD_PSTATE_GUIDED,
> >  	AMD_PSTATE_MAX,
> >  };
> >  
> > @@ -104,6 +105,7 @@ static const char * const amd_pstate_mode_string[] = {
> >  	[AMD_PSTATE_DISABLE]     = "disable",
> >  	[AMD_PSTATE_PASSIVE]     = "passive",
> >  	[AMD_PSTATE_ACTIVE]      = "active",
> > +	[AMD_PSTATE_GUIDED]      = "guided",
> >  	NULL,
> >  };
> >  #endif /* _LINUX_AMD_PSTATE_H */
> > -- 
> > 2.34.1
> > 
