Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238E736C78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjFTM6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFTM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:58:29 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1910FF;
        Tue, 20 Jun 2023 05:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKo501IwySh2zWRn8Kioiq0Z6bd7bgQRGXvsgslwp5C1/82a6IL0WBx3yXY+l0wfeO5u1vKxjPBrVrhW/Tkm+fyxtISVrYpDh+UF/OYBf9/hVCJ1EWcsbdT6IDdMB+uKg14EKpjKc8Rt6i3DTHA5lnxhGxFOYVozGNnxkkPvDokYqaTwK1yarv8qDuax7iQ0pHBALgY2At/EAMbQvk5728McSJGNG6fIOIzzKfUD2R2dWRnT02yU+OJdUiMCWMJfX8TOGqy1sXW47m98sR+cVugdFg6K9vFzKOEwXLso/yg6WjWfgHCPxp4TSru9iedlhM/yjoRVfrVt6E1S4BJrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOisOtgT/6cFqwD+18QYnwp5I+dSO3nk8AmYDmVCqKg=;
 b=bBSBgdHyK2CLA/L39OGT+IoNEGqRjoIrpMRqDOH3hRpg/NxIUwnOoIMiRvXHmS2zRwsyzQBRyCvjMbksdrVgdfjXpI8riI/bcBT3dowj+h1JqWWNWrZ8aqCtz2FAru4CQv3USBlQ6kJKXX+waHgToKvnfevg2SgfHoNGVA7B4reBSK8Iqs54qOyUb+xu1/yty+2sS64iMdieU+bMjE6+Nx9o3Dkl1lvGYrKBGBO/DR9ZzxkURzp8EWIcv+LDDOmDM1WyrQTX8uAHYmGKji0TvHfggpXTEaeWBGSCWCuduJIVQ+/Fdwv1zThvt1EXJAyixAH1Kx1u607b184vcJWCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOisOtgT/6cFqwD+18QYnwp5I+dSO3nk8AmYDmVCqKg=;
 b=Kul1xKsemD1TKW1P0LM5FBohbRddRE98wogWSmn5xCnX8tSG0iKwOn+SZUdvw6MoN076NZcMRk3gKhN5ZxiY+iPr9BJ8FUKaZkpOQr5wOsU2IdVlG34/VcCN+OH/U7s6meb7Ldz71/iHS80shDs2d26AhSxd28n4GEACJVgB0vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 12:58:25 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:58:25 +0000
Date:   Tue, 20 Jun 2023 20:58:01 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] cpupower: Add EPP value change support
Message-ID: <ZJGiWegN+CctWQBV@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-5-wyes.karny@amd.com>
 <ZIwNuRQK/mLTzfM1@amd.com>
 <ZIwlcvKCOVRyjstF@BLR-5CG13462PL.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwlcvKCOVRyjstF@BLR-5CG13462PL.amd.com>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e53cfd-1a5c-4dc5-de8a-08db718e08f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmLHeivgvKBXnKVSRm1mtDyEjfLtBPVbumSsHM7M1jpAsgyN1hEcLpiBlqo92YJpUK6AxxTrLLJBF/JvKVN/VDeyOIx6IEgfWDgmQqAksjEdK/vYuEKaEvNkWCZqjKCSSoLBt/b9U0bEavubzdVn2kwRY4NPuOUD/UYMxvnwtM7B+53mFqjEQfq9kMSf1G+jeQVCSsw2rLpkB2dyXiIFD3M8IH0caxI86pol/6m6Japrhczq8nqbJKZ+xXa8x+fmqKafMuaDOa9kNuqs9cPj+5dhvWktPXH6Q2uKFXm4tzygkzY4nLs5P9arOgl8M35s5Jl1Bmpoiutj40qWFbV2bddF/UR7Fottv583PH8Gc6n5MjGa8LP8rRBBaz2J51xpzCGAMexOLUAYuO0hhda5RC3UhFstKyGjRGmNLxoy0OqCInoJ1MK98hDNt+xMM0IKE004fX1ZBxVy2h2er5kv5AP5kGMkN2kUiClfYMvl1uqcA0OIDcTC/w2fEU+P43NR0WH59I1u1oR/YX3meB0H80eSmTeNmd/+4qN9drSSxOHwz+CtXQFQBo46rffe2C7eiH/yIALyEWFaz0GOkI9no+z109uOWUiThLdyU1VVB4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(6666004)(6486002)(478600001)(186003)(26005)(6512007)(36756003)(83380400001)(2616005)(86362001)(38100700002)(6506007)(6636002)(4326008)(66556008)(66946007)(66476007)(316002)(8936002)(8676002)(6862004)(5660300002)(41300700001)(2906002)(54906003)(37006003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZ+UO/jt1xPOD5/LnkFPOwcTIlwALfd1d703FNJZpqnk+2I6lMizN8/YF+zJ?=
 =?us-ascii?Q?LdhTT7ld2cp7Z7bBjeIng/hMBbg2sTEaELxR6CxS8NYhLiXJlhDzLebOUKfG?=
 =?us-ascii?Q?Bwt8dvjC30+5YAud8pes9btyR2FGrERmJhDjaGzdBxViNLObVMWKJfSRnLBG?=
 =?us-ascii?Q?VxEJjTrE2GOcAtVF1eGZNeeHhBhkb71mYAomVU7TIdpCSHNHD87g7R9Kc1Ui?=
 =?us-ascii?Q?Ec/0u64gXjj9lfrpkzq39d5e+GEtM2dRNZ1rzaXJttJQA38s5iXz+p65doB/?=
 =?us-ascii?Q?cSgC2D4+AzdgWc/IuRwAKzngvD1yg3rq0P1FORJFK7PyqFx8FZ4MF3REIV9q?=
 =?us-ascii?Q?GwAtvaJrV2rytk6I/ihus8ZhbNKBGwb/VB1+/fSvj9uQXTgyLgGtInd0s0a1?=
 =?us-ascii?Q?xyWfTisP7PnzVx7ivvssbMTFHW3HneBx82gITusYSdrcyV11X6eEVP4k6zmR?=
 =?us-ascii?Q?s1toRjuKfXLpW7rbsouor6Roz/XkZTwKvSHqPfYfOmIfEoRP/Q8A4l18nPR+?=
 =?us-ascii?Q?IC3o2F47g9yE7DtlVATO/OepwiVHrhyj6w1e7IFoUAvqrp2qgXkofmDs9gFJ?=
 =?us-ascii?Q?LRWlPtBABlq4OtfzaoQ0KUI2P4ThaWrYuVle1qv8/WdC6HsRycpFMp5tlrEs?=
 =?us-ascii?Q?e0eqIN8K/DHxL8Y49kSxZQrVKMFPCqez+c7qOgvF6GYV+Km/+pLbZHcUPDpX?=
 =?us-ascii?Q?YwSnEzeljYZ4LbwYWLw6FKj+a4EKkvqUVcoPczMA7phgAU/OjHOHvJ50qA9T?=
 =?us-ascii?Q?BOANfVHBxsvN/LytmNyohxqnHIb70eRNpMh3nKuCCswA/sWz7gvDrIpH8SlI?=
 =?us-ascii?Q?igZECkYRRpTtgOdJ8iUsUwzD/sh05CvZ/dszHGKUJgq7TpTUvldGMX5Uo2mQ?=
 =?us-ascii?Q?yIUw3ysrYIh6P2Fb0tlUooHl4Wd5K+ROh2ZhXxsWolG/HqRME6Yh643BuLhD?=
 =?us-ascii?Q?J1EoRyjsAKBAzdwxeQ0yiQ+gnYj5Fu/sI3n+hn8+nlIDjwzWT9jX2xGqH+y+?=
 =?us-ascii?Q?nj+8m1HerrYGLuuYbYxw+eDH/xH7yPgc8A/TsHgjtmgCK4VtO5ZNROig4Evw?=
 =?us-ascii?Q?WD4AkscIyg3/jDEtTdD8kR2Nf9W83iPc8KqKb62QTOBAlBCxz6BM3391qJoR?=
 =?us-ascii?Q?fx8mUyKhp3iKL7jtg80+5c5AE9nh7zWS7pnIbDDmCd2pn5GkJ7d+5RCvCOSW?=
 =?us-ascii?Q?zJXIuF5Zs3tPM600RLm6SW3P4XA4t/aotANhQjB9DRDsADxHYQdipvmdwBtM?=
 =?us-ascii?Q?soIhIgvTz+j3+bztO4oJ677vV7Glpwy3nKo8kpxOBIhhm1tx8iDYfvkhELFM?=
 =?us-ascii?Q?OMAxLmQs8RteC1fRXaJPzjK25LMVOaePDPlIjeXc/aibYHcrdLZm880sGnfE?=
 =?us-ascii?Q?XaCBeJG+7xJP06k2cM7lZ2uNbK+Fs8//qVlEbYEdwFTD6On0SRwaUU6/r7DU?=
 =?us-ascii?Q?4Go1rP+OUI6lAV3vInzB+MrX9DXUXs2xoiJaowbdVvhV27K4+niqGapf8zjT?=
 =?us-ascii?Q?Ff6fvYrydVvdTbR3g5kIXrHUra0s8cEr2E+WmQ7PWrOS2n2lduQAvz/8dzVO?=
 =?us-ascii?Q?DukQZ8MzlcSwQJxPxoQxHVmN3PDQbF/xL3VvB0Py?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e53cfd-1a5c-4dc5-de8a-08db718e08f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:58:25.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYR6a5qtAoQ0sFauzcKOY9sTwHw9cbrYVwJKlM9r35HCcAmszsuDBaLaN+JAj7TzbbX813RBEX7wR889bHHFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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

On Fri, Jun 16, 2023 at 05:03:46PM +0800, Karny, Wyes wrote:
> Hi Ray,
> 
> On 16 Jun 15:22, Huang Rui wrote:
> > On Mon, Jun 12, 2023 at 07:36:13PM +0800, Karny, Wyes wrote:
> > > amd_pstate and intel_pstate active mode drivers support energy
> > > performance preference feature. Through this user can convey it's
> > > energy/performance preference to platform. Add this value change
> > > capability to cpupower.
> > > 
> > > To change the EPP value use below command:
> > > cpupower set --epp performance
> > > 
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > ---
> > >  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
> > >  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> > >  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
> > >  3 files changed, 46 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> > > index 180d5ba877e6..a789b123dbd4 100644
> > > --- a/tools/power/cpupower/utils/cpupower-set.c
> > > +++ b/tools/power/cpupower/utils/cpupower-set.c
> > > @@ -18,6 +18,7 @@
> > >  
> > >  static struct option set_opts[] = {
> > >  	{"perf-bias", required_argument, NULL, 'b'},
> > > +	{"epp", required_argument, NULL, 'e'},
> > 
> > How about re-using the "perf-bias", I think it should be the simliar
> > function with Intel's processor?
> 
> AFAIU 'perf-bias' is not same as 'epp'. Perf-bias sysfs file expects
> 0-15 integer value, whereas epp sysfs file expects one of the string
> form energy_performance_available_preferences file.

I am thinking whether we can have a unify energy performance preferences
input in cpupower for both intel and amd processors. But it seems not easy
to align with them because different hardware interfaces here.

Anyway, it's not a big problem. Path looks good for me.

Thanks,
Ray

> 
> Thanks,
> Wyes
> > 
> > Thanks,
> > Ray
> > 
> > >  	{ },
> > >  };
> > >  
> > > @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
> > >  	union {
> > >  		struct {
> > >  			int perf_bias:1;
> > > +			int epp:1;
> > >  		};
> > >  		int params;
> > >  	} params;
> > >  	int perf_bias = 0;
> > >  	int ret = 0;
> > > +	char epp[30];
> > >  
> > >  	ret = uname(&uts);
> > >  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> > > @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
> > >  
> > >  	params.params = 0;
> > >  	/* parameter parsing */
> > > -	while ((ret = getopt_long(argc, argv, "b:",
> > > +	while ((ret = getopt_long(argc, argv, "b:e:",
> > >  						set_opts, NULL)) != -1) {
> > >  		switch (ret) {
> > >  		case 'b':
> > > @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
> > >  			}
> > >  			params.perf_bias = 1;
> > >  			break;
> > > +		case 'e':
> > > +			if (params.epp)
> > > +				print_wrong_arg_exit();
> > > +			if (sscanf(optarg, "%29s", epp) != 1) {
> > > +				print_wrong_arg_exit();
> > > +				return -EINVAL;
> > > +			}
> > > +			params.epp = 1;
> > > +			break;
> > >  		default:
> > >  			print_wrong_arg_exit();
> > >  		}
> > > @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
> > >  				break;
> > >  			}
> > >  		}
> > > +
> > > +		if (params.epp) {
> > > +			ret = cpupower_set_epp(cpu, epp);
> > > +			if (ret) {
> > > +				fprintf(stderr,
> > > +					"Error setting epp value on CPU %d\n", cpu);
> > > +				break;
> > > +			}
> > > +		}
> > >  	}
> > >  	return ret;
> > >  }
> > > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > > index 96e4bede078b..5d998de2d291 100644
> > > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > > @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> > >  extern int cpupower_intel_get_perf_bias(unsigned int cpu);
> > >  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
> > >  
> > > +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> > > +
> > >  /* Read/Write msr ****************************/
> > >  
> > >  /* PCI stuff ****************************/
> > > @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
> > >  static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
> > >  { return 0; };
> > >  
> > > +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> > > +{ return -1; };
> > > +
> > >  /* Read/Write msr ****************************/
> > >  
> > >  static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> > > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > > index 21f653cd472c..63c3f26ef874 100644
> > > --- a/tools/power/cpupower/utils/helpers/misc.c
> > > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > > @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> > >  	return 0;
> > >  }
> > >  
> > > +int cpupower_set_epp(unsigned int cpu, char *epp)
> > > +{
> > > +	char path[SYSFS_PATH_MAX];
> > > +	char linebuf[30] = {};
> > > +
> > > +	snprintf(path, sizeof(path),
> > > +		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
> > > +
> > > +	if (!is_valid_path(path))
> > > +		return -1;
> > > +
> > > +	snprintf(linebuf, sizeof(linebuf), "%s", epp);
> > > +
> > > +	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  bool cpupower_amd_pstate_enabled(void)
> > >  {
> > >  	char *driver = cpufreq_get_driver(0);
> > > -- 
> > > 2.34.1
> > > 
