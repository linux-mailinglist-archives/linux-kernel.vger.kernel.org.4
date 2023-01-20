Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D19675098
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjATJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjATJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:19:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71C8F6D9;
        Fri, 20 Jan 2023 01:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajjl5h37/mzMGMWYyx9UvU7jEdmVA4mSB5Pe+HiYNOGoS15BCIR7dHOp2oTX4mBu/+zBtpWGQCYfXAKF+j9bfLgnwJcSkJ6m0ppKKjHwkam8IFoy6HWHv2b04mebh+WiOhllgxkFAW+VHctW3Vb924tTTIaGahUyx7cxogRNUjH93nhcVXM3MYyPzcfiJARz9urm6KR8o67In4Oey6IH6PIqCiJQbjXSpDP5z9Pv4RGJc/eGIrnH+ZHjuqkeU2IHg2C46Rpg8xVsX683jqahEDPlMd3/dqyEuj0/VtlKCk+scceuyPpsJoKvMSLXasNbae1/XzYzvko9OMWletArrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGn0qDE4MaGVGyMNqgmMd3ai7Rsl2tFDnyAKqYLH4Rc=;
 b=TIgg6tf7pXvhEcMa5q09WlnmJb1PXXg6Ra1MBOyrNm0q6YY0OBGydO0l14sFvioZtERwNVYhwfXRnJ58OaGpvF3iH2FLV7i3gwSLinu6OsHTmWaecQER83n16HEp0Qg+hVlgsEA6ti0lwObDFbTPKkX9dKowD+4N2uKdESiyxUI+ars+YxsxHgJHh260f1NYAOrDUcfHaS8iA40MW2dTxYdNkclnfs5jHkCXuEuZ0CK4mrWJiekC1NJI/gVE4rx8dCcbUlb+MCQBukVYeK9JHNTlmGZu+1Z9oJsqcZSPwrpvs52VyIfLonTRmX8Lxx1UdFYeEvCTRNm9t29ted3TBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGn0qDE4MaGVGyMNqgmMd3ai7Rsl2tFDnyAKqYLH4Rc=;
 b=AtvbFV8IXRlNT4+fiGdEk4MbCXfVocVZ4n7lXMCRA/BmVAEyej37uXcVRZ6EPM3x5LQYJYE73hOyVZVHY/QbPmULKEowHylxAXPDj/STDMZeNi3mDMrHzniHtQVXUca5yUDhc9CIfTRjWIZElVbwm0Qcp1PLzfbhhMyQ049iWO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:19:14 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 09:19:14 +0000
Date:   Fri, 20 Jan 2023 17:18:52 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Message-ID: <Y8pcfJ9Dd31gj+u6@amd.com>
References: <20230119115017.10188-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119115017.10188-1-wyes.karny@amd.com>
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d8b804-7732-48aa-386d-08dafac765f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wPUcw3OenGo7cNAiRdBNViURARTgZkLrjA1luETxfOBec1kvDobHbEnLhLg/S5lG2frUSN8itMSCR3MhyORbM4AWyZMXi4JTcOL8CvcAL8vBmIDo8gtqRxh849EWnw9aD/ZpgBkmm0WB6jTKa4311m9DPKYdmsykVVa4uoELF25ue5BB+3OD0RS43NVJee4KC4ANG9ljEPDBieECcIW8EcGbz541q4W241xJPyOft83dqXkrmS4VQpfKNWTv1Q5pq+Pb58p+VFQMPQ2yT01+IThvBzgj3Yoogi71nCpX41ZhNvDgh3PsYUwmEPZqsCUCEgIsqBjbq3cjqNX3N2wtIrlSRpnkComAoLSgsGRLY3VBK0VXnefjDjp77XF86S+TwoS0EsPlra/VbW4eR9q3kdr1Yc7njXQIFHbq/fKNshk/18PLn+JUnXrmEn6d6+BIu/pvHmuaJd8f5vlSpsLDRdpQQ4wv2rHJmw5Rxs6AQ9rA4iKsYo6i4OXb7Tksv090IffV9Jq1utJunp4W7zEG/XzcdlejVrMDV1cKT7zmY84FjchBLnQ8UGe6TiLzm16dTguWoM6D9FkIyISiTlzuOxJc8gtJelN/8VQ+3d5Zw+txUkOro/uFmZASSH7zdVopl2R2qlDCIeV/xOK8G6Ktaz/PWw65L3CP2EqIN/0JXbZO7S9ldxkJCjMEz5cAGVdjZK/ojLetBFNHPvzDjB750bvgUxsijuXSvFburqRgeK2dNAALsTn1cMr3mC0elq5B4Ggzmq3wSHkzB+yhANmfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(2906002)(186003)(6512007)(26005)(54906003)(6506007)(6636002)(316002)(37006003)(2616005)(6486002)(966005)(478600001)(36756003)(6666004)(38100700002)(86362001)(83380400001)(41300700001)(4326008)(7416002)(6862004)(5660300002)(8936002)(66946007)(66476007)(66556008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cWHzMiXi2kyBmp+Si9bwFvqPiOjfUcfjxul4xFrTVVOKJOWsXCPGCZeWKR4?=
 =?us-ascii?Q?tVHMEKU1pVN/ssNl5Yrv1qKMwKttJuMwEn1aY4vXdgG3ZSPaL+Pfe3U5DrbU?=
 =?us-ascii?Q?/opgWi6LPl/fSIzASPsn2jKKrqC+I1RcpjCzBEldlFEGV9xzyzxnBMx/HK8R?=
 =?us-ascii?Q?QZgpYy4JmNsfn3ElnNChvwkPBeE8teG4VzVjBKwVZrlmhBe2lrNsz7aTTVN6?=
 =?us-ascii?Q?4yxv0HRxnBCsCinnsDF+XFbJw1IELgQXgroaXtKMK45euJdt3u7ZMaL35Fa7?=
 =?us-ascii?Q?GnmP15Brbr4WqE01L8QM+U+IqKkDQ9TVL3LQZtACFaiCu94uV4qKQOPlW5lO?=
 =?us-ascii?Q?vca74BAzA6BmlUnmqsYRGZgJsTCJyAnkLg9SDdsAqJJS0E4RiZqfzUhCAXkt?=
 =?us-ascii?Q?0Ljw/lZj/7AujdvmUF6LsIEU3r5s36NBPLMzqc+Dv4tzeC9N1lJdktUtMxhE?=
 =?us-ascii?Q?bZThpKoO4RwMTzmtbUI0RF9Hnjx+4lx8h2gzOcPKoVsyntGRseOwuNHE6+ia?=
 =?us-ascii?Q?qbAO1cNaCc0t6sEP6Pny2BFM7K/rUP0IwljFgo8jkNOw83c4WSRvXyT+/PAS?=
 =?us-ascii?Q?7lLku83puQEt8Tn67gz1vaGmEDCWD/czQCOc6Bep3MMt4UaNzr+XPj2SlpDb?=
 =?us-ascii?Q?FibXQc45T2FWrnq0eZWLLL6nK4tPxX92zFY5l2stxRQpJ7IMZ5SyOCXUohu5?=
 =?us-ascii?Q?IPEXod0Lmy5pFaYtU9wU97ywvUeWfA0MJcVS6e7sPFejdIj16gPSPg5JifFG?=
 =?us-ascii?Q?mY7C/0c2d96yj7G7Yrfmw5F+rCtPGc3KBT6vEy4Aa0MnWG+7EUveuQ6wDUEa?=
 =?us-ascii?Q?t7fvxRVfOuQf7dUOdFlEzwbR76+Eyw62Pi+t2RbVxZhitnW11WqmDy7hcKwm?=
 =?us-ascii?Q?+tBF8C3E3PaPca0ImrgH7g8BuQzXflrh/vjdvbyP4yhzCt3QK8c2q5Phi/bb?=
 =?us-ascii?Q?spFv8aoBB6C4uYbbI1Jo/mTpJ8h2SSiz8eLEd+YX8FlrfO49nvMabizeCtRV?=
 =?us-ascii?Q?wEs3c1jzpMPCVGz/Uvos0thRwUFspBXD0RYcIgLOHgJS6euBT7tVlpztDN1j?=
 =?us-ascii?Q?nxReJGWJCwSilVpoI1sXc/XkeKxmK+XeYX9LB4O0gxqharsQfUCQTrMz++Lk?=
 =?us-ascii?Q?DCJLp37AZMpeXE4TgRF0k/CV2nWfLXZd2GPbyci1mOzYcFfqa8nUPckMyRKw?=
 =?us-ascii?Q?gTJeeXnaQt8osABhJ18ruG7CfKq/yvMmqiGtqriYjasT0nZWCq8GW1RtfVsU?=
 =?us-ascii?Q?V0XtRBl4ox2UsYecc+/6B757n2S6PBCERHonqJcHASh+bEaMndN6SCycuv3I?=
 =?us-ascii?Q?xpe/ph/Fvih2/8yqbx4HbzdvDkbSLOw6AAv+wQkl+4M0ERv+X/f0UM6b3FJg?=
 =?us-ascii?Q?TSYcfqY/rF6CO8pA8C2wZlH7kexP6oFiUprKAU1N20rGCzy8Pyaqlvh7U4PO?=
 =?us-ascii?Q?Ec7A7Sa3E+caBcn1sA+ydpEylaG1YF7lVEpYEAzzvCeY8kcManUDHmp0DCZ3?=
 =?us-ascii?Q?M88DLFhEAwmudwKch4SAsLqMl26VNFp7BIEE4MlaMhK+GKbTicGitslji/QW?=
 =?us-ascii?Q?OmY5ZTq0SO0vx+sGuYcLP2L44316pO4wgvJxsdjY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d8b804-7732-48aa-386d-08dafac765f5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:19:14.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQNXHgNmZPsAXCM4vrJ7DstQx32PKiNaBHDQsNy6juW1sglJyiwEMSJSuR26asXNR2BfkGZHq41PDjzHO8cHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:50:11PM +0800, Karny, Wyes wrote:
> From ACPI spec[1] below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>    energy performance preference for the workload and platform autonomously
> scales the frequency.
> 
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support[2]. This change is to support (2).
> 
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
> 
> To activate guided auto mode ``amd_pstate=guided`` command line
> parameter has to be passed in the kernel.
> 
> Below are the results (normalized) of benchmarks with this patch:
> System: Genoa 96C 192T
> Kernel: 6.2.0-rc2 + EPP v11 + patch
> Scaling governor: schedutil
> 
> ================ dbench comparisons ================
> dbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
>     2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
>     4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
>     8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
>    16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
>    32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
>    64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
>   128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
>   256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
>   512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
> dbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
>     2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
>     4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
>     8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
>    16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
>    32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
>    64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
>   128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
>   256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
>   512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
> 
> ================ git-source comparisons ================
> git-source result comparison:
> Here results are throughput (compilations per 1000 sec)
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
> git-source power comparison:
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
> 
> ================ kernbench comparisons ================
> kernbench result comparison:
> Here results are throughput (compilations per 1000 sec)
> Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> 32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> 48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
> 64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
> 96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
> 128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
> 192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
> 256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
> 384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
> kernbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>    32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
>    48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
>    64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
>    96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
>   128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
>   192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
> 
> ================ tbench comparisons ================
> tbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
>     2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
>     4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
>     8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
>    16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
>    32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
>    64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
>   128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
>   256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
>   512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
> tbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
>     2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
>     4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
>     8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
>    16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
>    32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
>    64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
>   128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
>   256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
>   512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
> 
> Note: this series is based on top of EPP v11 [3] series
> 
> Change log:
> 
> v2 -> v3:
> - Addressed review comments form Mario.
> - Picked up RB tag from Mario.
> - Rebase on top of EPP v11 [3].
> 
> v1 -> v2:
> - Fix issue with shared mem systems.
> - Rebase on top of EPP series.
> 
> [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> [3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/
> 
> 
> Wyes Karny (6):
>   acpi: cppc: Add min and max perf reg writing support
>   acpi: cppc: Add auto select register read/write support
>   cpufreq: amd_pstate: Add guided autonomous mode
>   Documentation: amd_pstate: Move amd_pstate param to alphabetical order
>   cpufreq: amd_pstate: Add guided mode control support via sysfs
>   Documentation: amd_pstate: Update amd_pstate status sysfs for guided
> 

Wyes, thanks for the patches. I will take a look at them after Chinese new
year.

Thanks,
Ray
