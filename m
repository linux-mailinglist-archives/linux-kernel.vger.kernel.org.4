Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739362D2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiKQFgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKQFgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:36:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E43D63153;
        Wed, 16 Nov 2022 21:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5o4CurvilJowCJPfnmAvJq93Knf5qezwo0h9XSuklgU3/A9H5vqHcVE7IWS+X6FYKUIXcy4BaMXGlzuTu4G+wklatHSX/ZbIKKL7Od/dvRoPZwXk+mq/0mf6cSksnrB8mfynUNvF+6LrQKpFox0l4tqBuZV5KwLPDOCK55GrUqXqiDOI2alMHnafPOqQJx2JV2ieORoS12QwslclNCnC8LC68ckpErYumaMXK3v76BZ8fPEHD7ImIm59EsBDiAGSifR6ZcH5VaLQa7IdDupjlHanqIkQxVl0p86mW1pq6hB/pt175YwPB8bYDsCApAOBJlrulFohazvCCO+TG6arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrNezs8XLe18KD2VjPb4/yjD1DxB3qXR4DX6+PxH8lQ=;
 b=R2R+ocs8+mzXe/XUIv3TmXtb5t+a6SQJ9/4Je6sLv01jzWRZquZIKYBbs1U4UG4/N94FMinHb9WMRl/gwWBR4b/+ipiPD+4ysMXatG0brmQ0Ka9T4W41bUtUfQUdvHI1kOyW1A2G+qbk93BKF59HTEY5/7bbDlFJodOyhbWF7cVlNRiyjsl64yIMuNGm2j/lWrLavwjZLJKX8xpLafK5Q+BtxQHdcZuDxPbn9GE1p73Teqd6Ma5mqAb6UlHXR03jpzevNX9sQ+DmnkbgDiJHSyRNzTGn/FF3AEjlzfRSrcNLzlEZ0qnre0AbdtipSFOsN4Pyo7bjv5steSm79xrYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrNezs8XLe18KD2VjPb4/yjD1DxB3qXR4DX6+PxH8lQ=;
 b=0vSfEcLTirIEmtetfDf16l3201iPhqmvQbqLphIOWdtH3NW1EKgQ2buj8OD2s22EGPP3pbhVl9anJRfuiHPrI2c9KAFahi8GELIhmNRBNOx18cazEQ3xPJ348Us9I3dr+4Kc6+xhn9jPCjjFsuRpow6yj5eaFzdrtwvnB0NktxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 05:35:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec49:f96d:d3f2:79d1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec49:f96d:d3f2:79d1%4]) with mapi id 15.20.5791.020; Thu, 17 Nov 2022
 05:35:57 +0000
Date:   Thu, 17 Nov 2022 13:35:32 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] AMD Pstate driver Urgent Change
Message-ID: <Y3XIJLgIR0aXt3hO@amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117024955.3319484-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BN9PR12MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bed470c-db8f-47f0-b282-08dac85d9a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAsd9YniPqebbd9VqBSeRKyG5UvONX+OvWphod/BRzaH5/Ag33zBjflrUq404pfGhoI8RaoHj6Ki2YArO7bEBlsgHoYI1uYnoGUCoyX+o18fsngNQqjUsZOE0f3Li02SISXdzFTqZBWsSdD4GD3kjwhhDtV8yNKL/yTX4UCKJ/HPTBYeNNCCnCADjX+F8BnPdInCrRGL25tUjeJPhCSRei25TDg0K/SoHNNHpGmmf8AKgPRX6ApWPHl1bz9o0XmzQXz+PEd8cY8wmPAEH2P7ALbCoGVBUOQVls3G9FE2Pt33oQzg0AGSDkXYquBfkgeHUaVhitiSjEpjFAlfTuMQzM7A8XXX8Lm8THigjFZ6NEXAQEWkGfJ2ln/ymLB/SjOWDApZTcX5JjsuekGXXlVHpPK6aJg45IdFqHT1y/OgS0DcnlnclTgr0A79NvOfAFsd6nZUAY1l7dA7U9VoEjvNtTLQfTF+tUo4Cz8oQNa1O6jID/b0/J7PcT5Xez8y7oRBHcy6KQ9ItDJGKdaugVBO62dYrqqi1JOKrJuGO2jCiykOa1yWuZup+rxHrUUWjU7t4Lk6s+7Z1X/Wb5I7CQQh4WiDGkNLuKvkekvMy3lQ4F50sYiJSLNq90MA4U4e56r6a8GgNq4sM7PO2pg1GPeWyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(86362001)(8676002)(4326008)(41300700001)(36756003)(2616005)(186003)(66946007)(5660300002)(110136005)(6666004)(26005)(8936002)(6512007)(6486002)(478600001)(2906002)(6506007)(54906003)(38100700002)(66556008)(66476007)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8G5QxHqrY0/WkUHcun3L8Im84ojrF3+7R/eDPgKfHDLchjAxHHPGQ0AIrWcD?=
 =?us-ascii?Q?cbffoZCsypV3QYf5/rXM0qJG+u++x/XpxJlubWdb7qiT0bzFLvwZzaM63TPF?=
 =?us-ascii?Q?GslBXVHamM73B+tQXnBPtLQUDRGCBD96nVX+YI5PUWPD4p0V5kpLMvKa7nww?=
 =?us-ascii?Q?IsIxJX3OmoLs1Nu0HxtcYOnuIaEcSr+uU1SX8s5tNHzJVwR197iWsdU+lkKu?=
 =?us-ascii?Q?y6ArwNYB+tKK7uOH5Jx6lgb1CbVdsyuGh45p5a+AbOV8aVXncImllbj+wxhr?=
 =?us-ascii?Q?24415AncVh9N/BOMdzBnkrkAC9RmNAdCpzoCV9o/hLPLpQoISsMJzhCyHnLL?=
 =?us-ascii?Q?7bN8s5zP+y7aSrynNRk+E4OxAVwryrPNAfFxBGnmxxV4ORjHyJukOM1MkXEq?=
 =?us-ascii?Q?XA4hOtLVLpo//LiBAa1hEQEf83R9RQiLGKUo0QuOjKCack5YgAbNB504SB05?=
 =?us-ascii?Q?UnB30WeyFBo1gk8+lJ0iiM1YqZ9O+OMMJkjr3PoXqMc9C2uis9Z+aNKE2afr?=
 =?us-ascii?Q?pyo9rTvra5z6W6DRGS4SQ4kGP8uOPyqZbFUOM1jB5sMlc4OyJhdafAgctySC?=
 =?us-ascii?Q?sCk6+PFGtaZ3gW3n16AnBAGk1pwHEgPd0Zxdta6x8kzpNkoyuOLvOaCNtsxb?=
 =?us-ascii?Q?/GiPMYIViDFiLw/lE0Cx1mWfYzMj6PfdE7zYRpecyMwvYLbcZB8LtTLvTVtJ?=
 =?us-ascii?Q?PTRfO5Hpy3QG9G+pDq7RkDigqSxK6Aal0JHu5gaIWoGxY4T5x06Clq/FFKA+?=
 =?us-ascii?Q?Hg/cw3Ej2WfoqzDgsonJoKOl0NYlN0Ifw3H3ztGPCeWREssQH+qmBBmMOBlv?=
 =?us-ascii?Q?xAS7DzXVNkPzW5NfanZtl8I1Sjo2nFCSPtWixOWWqG7MPR+v8fJAA41OTLxZ?=
 =?us-ascii?Q?PMW5rc/+QSR0ffnOdg1QkoAMszeIk7vi5v0Q7Fpo3pfWAn+G7X/fQN235ZNX?=
 =?us-ascii?Q?Z6nMzUK6EcELpQA01yFva3QI8FzKPAy8knpy1ONu7SFpiJGwzw2ngdqFPtN6?=
 =?us-ascii?Q?qlswWwYkgQzzZIAzQWLa715sGbBG2bvkcomB8HFzGcyXDamxPmFBU4UJnLbY?=
 =?us-ascii?Q?3EMoDCpANohGsTgfgU9M//5iP6NUXpkG3q5f9jaDOtLImNN0rJ5/NbeBTGoj?=
 =?us-ascii?Q?rfSeQvspHm9/VNXNwl2IuMtVhImOD1HAo1CksjNESCJfehcTchII4TMfp8MR?=
 =?us-ascii?Q?ZZixMziufw7loRbmx9RdyqzG+IgsY0Sljqk4taoHsuzdWmAS7G2/ZFJGMKI6?=
 =?us-ascii?Q?nvArEhhOvMH18ogW2oilIMof7WRLJyWKgdCQGAPEZwHahIh5e4aZO7ZflQNl?=
 =?us-ascii?Q?QqLJ34O2F42Gjm8w3kTfkd+QaOAoRLJacjK+rt5JfHYve6nEbRCmfYdXf6q7?=
 =?us-ascii?Q?NgEDuqH5SE0EkuFUsaRvwwWWg2QRjslzjHcKXN2Q2Jp4pVh5vP/8RazRO32W?=
 =?us-ascii?Q?6tsCiUxqtVj1IX4h+3+Qs1WtR4gOtCiVFuxs8d8R6dTEC2cCUHXGo7uh6msm?=
 =?us-ascii?Q?nKEwabDw8u2C07mCpF1lm65vE/gNERGsKa79XbxnMkNfmvMZTp0tJmH2mdU1?=
 =?us-ascii?Q?bRCzELkUAdUpLKdeTx1Tw3XX9NyYACbsyxqNMBwB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bed470c-db8f-47f0-b282-08dac85d9a02
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:35:56.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJE+h9WXFS2fWQcEje0lzovth3fgoctuBjv6iH3XQl16Dc5m4bSmj4J40b0s5oXiOgYpOX/rPcb48N5mM5t4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:49:50AM +0800, Yuan, Perry wrote:
> The patchset changed amd-pstate driver as built-in type to resolve the
> driver loading sequence problem, otherwise the acpi-cpufreq driver will
> be loaded as the default cpufreq scaling driver instead of amd-pstate.
> 
> Some new kernel parameters are added to allow user to disable pstate driver
> and load driver with passive mode which use governors to do the
> frequency scaling control.
> 
> * `amd_pstate=disabled` or no parameters will not load pstate driver.
> * `amd_pstate=passive` will load pstate driver with passive mode.
> 
> Set the `amd_pstate` driver disabled by default because of performance
> degradation on a number of AMD ASICs in the passive mode driver,
> especially the shared memory support processors.
> 
> EPP support for the amd_pstate driver is under review. With EPP support,
> the said performance issue is resolved. Once that gets upstream,
> the `active` mode amd_pstate_epp driver may be enabled by default.
> 
> Perry Yuan (4):
>   cpufreq: amd-pstate: change amd-pstate driver to be built-in type
>   cpufreq: amd-pstate: add amd-pstate driver parameter for mode
>     selection
>   Documentation: amd-pstate: add driver working mode introduction
>   Documentation: add amd-pstate kernel command line options
> 
> Wyes Karny (1):
>   cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
>     register at init

Series are Acked-by: Huang Rui <ray.huang@amd.com>

Hi Rafeal,

These series are the fixes for our new processors. Would you mind to merge
them into pm-6.1-rc6 or pm-6.1-rc7?

Thanks,
Ray
