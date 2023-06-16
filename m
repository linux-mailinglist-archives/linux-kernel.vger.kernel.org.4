Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5E732B09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbjFPJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjFPJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:06:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8965C3C02;
        Fri, 16 Jun 2023 02:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNwiMqoY+bA4XnyzGbm63P7oMNbC8WpiF5eP2LqhpAVp/ro6tLlj0bshlmn6cdlhnMv8Z1VSk0MZO/hX6ZWNqGVovyRoEF9Rf0imhfLVq/PBNDkXG/X/OAMz5tFk7DuVJCxqQyPcsYFAk6GPmYpo7Csr9Z+o55pi99RX8XLkR6KF1+TVnu0Fa2e+1TlVpD6xPmmZSc2Wwx7Ut5OQAGaRhzId1KSXPCSwW5q4JmXjZKZTsmJihA6qY37x7lb2I57BXHIRP8qj6U6EKKmfdFDzxlaZoWbkajd1lPyfSVpl/2Vr26coRcpuRSg3XLrnK4hGeLJ9+nIqPXko4/YDM8s/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2ZTPFqEn9jifgtj5ozo19IuS2Bwy27D66xQWzEzyks=;
 b=d9qZihvxceCKtVu2KslVGbH4NiYrUaPS2V7Ms/ppDp+RrQrcjzVqOMK36e62JnOgHJpYp7+tQ7bY/imodcD8J0z5VwPbS/9pmQHkjftsnA0NqmbNzrOPDc+THp29pgsB1EIT+gwHJz7j7F8auk8SZAeu/zRIyBOVkJ7HLnsMsGEMeRmX1Sufsbtvp5PA2KJUex8htCtVm/uzlOFOcCmT2qoogQTSG5uD4j/zRGhszr6LaMLXRK777DHJS02i9njYlh9brzZVVSG87ToGhOidQzGNLgYNRpaysLRbJr+oinXnnwLIBAgQ89CM7+GwygwK9QqDQWWv05e6mvhynwWEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2ZTPFqEn9jifgtj5ozo19IuS2Bwy27D66xQWzEzyks=;
 b=pNMEPk1iwuNlkIud6mOHnztv2er90mTsHH0CGNYEtjlxd9+flL8JGAgaYbt5q5ZNnQcksmzMSGQo3Lr3osPX6hWSRaogwx5/vr7IZwwSUd3R/3CDw5mmTvdcl7L+dypdY3j48H8ljuHeEzu3QLBcWsfMUXGF3JIPQr0lzNA9uPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 09:03:59 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 09:03:59 +0000
Date:   Fri, 16 Jun 2023 14:33:46 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Huang Rui <ray.huang@amd.com>
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
Message-ID: <ZIwlcvKCOVRyjstF@BLR-5CG13462PL.amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-5-wyes.karny@amd.com>
 <ZIwNuRQK/mLTzfM1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwNuRQK/mLTzfM1@amd.com>
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: c25ea9f3-35c7-4d81-904e-08db6e489f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWs0WFf6iVzPNplQmj3yhGWoEzBnTUQj5Oa2l1PYzvl0RU4sGaUQ6lJVi1vOfE8RaUHzSTGa7KoEbBnfrwaIGFeT9uFhDSkZVl+xR6R/pNVrkV4D9+MKEgvv2ubUGnWYev5NuGwwAinEGJ5CM0QVUdRSQUshmEAnqKL/6aMxYar/9+UYg//EFIAmJopsIC+cwzIQr8rQEVA4KX5bmgTmayNH5J5+s5g4gD9mIsUZMqpQbHWPjSBtZRxeQacDp9vTCfn2enru0hbkE6GynFzguq4kSqzwRyJJcgXORMqKsCa0VGfZLbvD+fvG3W2poXEdXWqQc25Nbe6nVL3n85LwDbqg2ZscLbbLdsFcla67KxvshoT8f2lm57sCV4xe8NdESk/wJk/4sj1U0n13UI+Ka/hhIV912+U6Dynn52/HcxINSXocYh/+POxIHf8Fb1KsCGg8JaY7y2iYMWlIf1vVd2+8nI2SUoRFhl72p2/I4Mqenr9gZ55Cvow3a55O/mhHEgaswcoRlgtElyB2af2dT/LJK7Bby3jftkeD7zdzNwrfRp1FcZBQ3S6wdgGua2Nl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(38100700002)(86362001)(478600001)(8676002)(8936002)(41300700001)(6486002)(6636002)(4326008)(54906003)(6666004)(316002)(6862004)(5660300002)(44832011)(6506007)(6512007)(186003)(26005)(2906002)(66476007)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87NynYf6j9PoV0+ZNAw9ndm130Tkl2JKo7+8hN/0KPGpK+KOEUU6/SUVlCg2?=
 =?us-ascii?Q?eCX0iivRt5SjcRg9fY3yzDaGJhvRJajiEyxsaXcGmzeToqECCLS7WbNxpopN?=
 =?us-ascii?Q?1rjTZDOb40Ue6kzbujW0rzHJvNqp/Qo/S/B2B1IBpwis4nvkDrWHnBHpo2m3?=
 =?us-ascii?Q?WfihqVBg1Htny9Hbykb6NgeCCBTf5U1IKjCi2n6PE5w6TVxwJEZJgbHKwHT5?=
 =?us-ascii?Q?OSy9RMvALNzxoPG7VLiN3OCgNwYKDhXmjS7U9lOj5ThzUL+BvOwGCcHrL4EJ?=
 =?us-ascii?Q?ddOUjcCHFLMD+suX8t+0Oe5TzTM4cNHiBdOGxOdSnVXwbwkZuAk4HFO60Ya0?=
 =?us-ascii?Q?DRbRi9gb5gC1rF9yfwc7XmHfvotIzVfBhlqLs6DVyaGMBztPKQBRJPlE9b+e?=
 =?us-ascii?Q?n4w2XOfFfSsiQwMRnVfzOwsgF9xjx1AysveMGuHsn1lybI9lnKxPcVMTActe?=
 =?us-ascii?Q?di+d1i7g66ebkWzVdXNFMPTBA+VsWXYNxGrNSJ5TkZJHaaQQNbykMOK978/X?=
 =?us-ascii?Q?/lXK7XVRyLHbVR/4Zzd0W2tjtFpHz7L7LFHN+oaarSvLbE6toG/Dqbs+9rD0?=
 =?us-ascii?Q?+pilBs7Z8uPPvUomvEJ3eU3WzRxGn2HURAzlq33DKl8MlfoAsfLoTtfv/LFC?=
 =?us-ascii?Q?gtuv2Rmfumhmi1UwgaEEeeiLqjQ5mrMf6+EdBY6d2KynBayW/QKMF3wV6CIe?=
 =?us-ascii?Q?srORBzFa0epucNQ1yXQZPYj2r/mUj6eh7Mn+5RvFwdm1BMgsqRITZxMmCPE+?=
 =?us-ascii?Q?huRcok5GhvSbsJT2B7501wEw3ThLtm1sp0yWvArV7eHnS8jKoWAgl1yxyvBV?=
 =?us-ascii?Q?nnd0Ok8wHFPmeGgtl0L+5j7weiSyoVU3oeu0zRxz5muOnOVyXBsbDBsVAEj3?=
 =?us-ascii?Q?yW9+026e/pydoGZd5ZionCaLcQdoWNsqKdvDRrc6Zrg+qt56WZt7eUg5JiMY?=
 =?us-ascii?Q?v3QCL8opo0GhQkiVazOqusIJD1zyq+qERczFQPhlb/zK7vfUfb5ukWrzMO1+?=
 =?us-ascii?Q?KtPciIG1yqDCt014YZFRsQSzoB/Kj7eTbnP5n+a2jylZaV6wgqMvIRyAG7y0?=
 =?us-ascii?Q?VUsYIAm0HSjTUhYsaraApFZD61mxdkm9+vmzbOSQv1C9nMIR/rhCBmfr6wse?=
 =?us-ascii?Q?s0iwCpztlqutg45Tg/tBFL+b8Uj3vJCVAFFa5XoIZAgWMNLQphMrqgzJqWDj?=
 =?us-ascii?Q?pqYsHCl7Iguq4vP9RcJ7baZ/IlmS9MgMT+QfcAJWErciujipyyGp64avLUf4?=
 =?us-ascii?Q?qxkjjmDpkttxNs/cWkrFMWSs3PQKuhNk7GGpyWgtiv5YCKhdl2Vw1RQTJW+m?=
 =?us-ascii?Q?cspOH++6TW8URHheHIj2W92d0ZkDEw3tcyh9v0RYaZzs/WwmtLv6ajLPzFwd?=
 =?us-ascii?Q?NrXO+sQEVcc4ZZUROdquo5UMozQzQGEDyF9K1/FiFJUrMEkk05Rbm3eJcAWO?=
 =?us-ascii?Q?LJSNIvS7vQ9vLZuMsM6nYWFfm5UzUNeK9YmjnZ0FQL723Yf0k0Cmg+eEC/av?=
 =?us-ascii?Q?FnZu7HYsdFM0gFvcXp3MLQlN+pFHerjFHZe72fMICCII54jBCc7WC2s8KYp4?=
 =?us-ascii?Q?5QYRzR2Q6DJaNgA925tzHy103c+rB/W2jx6JHb2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25ea9f3-35c7-4d81-904e-08db6e489f22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 09:03:59.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTtjEbtgarretrQgE7TArAHyjiL7RFkwapswAlrZSn6oadBXzfHn8Z9imUR3meEticaqhXZB2iqqvMRua92wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

Hi Ray,

On 16 Jun 15:22, Huang Rui wrote:
> On Mon, Jun 12, 2023 at 07:36:13PM +0800, Karny, Wyes wrote:
> > amd_pstate and intel_pstate active mode drivers support energy
> > performance preference feature. Through this user can convey it's
> > energy/performance preference to platform. Add this value change
> > capability to cpupower.
> > 
> > To change the EPP value use below command:
> > cpupower set --epp performance
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
> >  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> >  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> > index 180d5ba877e6..a789b123dbd4 100644
> > --- a/tools/power/cpupower/utils/cpupower-set.c
> > +++ b/tools/power/cpupower/utils/cpupower-set.c
> > @@ -18,6 +18,7 @@
> >  
> >  static struct option set_opts[] = {
> >  	{"perf-bias", required_argument, NULL, 'b'},
> > +	{"epp", required_argument, NULL, 'e'},
> 
> How about re-using the "perf-bias", I think it should be the simliar
> function with Intel's processor?

AFAIU 'perf-bias' is not same as 'epp'. Perf-bias sysfs file expects
0-15 integer value, whereas epp sysfs file expects one of the string
form energy_performance_available_preferences file.

Thanks,
Wyes
> 
> Thanks,
> Ray
> 
> >  	{ },
> >  };
> >  
> > @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
> >  	union {
> >  		struct {
> >  			int perf_bias:1;
> > +			int epp:1;
> >  		};
> >  		int params;
> >  	} params;
> >  	int perf_bias = 0;
> >  	int ret = 0;
> > +	char epp[30];
> >  
> >  	ret = uname(&uts);
> >  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> > @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
> >  
> >  	params.params = 0;
> >  	/* parameter parsing */
> > -	while ((ret = getopt_long(argc, argv, "b:",
> > +	while ((ret = getopt_long(argc, argv, "b:e:",
> >  						set_opts, NULL)) != -1) {
> >  		switch (ret) {
> >  		case 'b':
> > @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
> >  			}
> >  			params.perf_bias = 1;
> >  			break;
> > +		case 'e':
> > +			if (params.epp)
> > +				print_wrong_arg_exit();
> > +			if (sscanf(optarg, "%29s", epp) != 1) {
> > +				print_wrong_arg_exit();
> > +				return -EINVAL;
> > +			}
> > +			params.epp = 1;
> > +			break;
> >  		default:
> >  			print_wrong_arg_exit();
> >  		}
> > @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
> >  				break;
> >  			}
> >  		}
> > +
> > +		if (params.epp) {
> > +			ret = cpupower_set_epp(cpu, epp);
> > +			if (ret) {
> > +				fprintf(stderr,
> > +					"Error setting epp value on CPU %d\n", cpu);
> > +				break;
> > +			}
> > +		}
> >  	}
> >  	return ret;
> >  }
> > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > index 96e4bede078b..5d998de2d291 100644
> > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> >  extern int cpupower_intel_get_perf_bias(unsigned int cpu);
> >  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
> >  
> > +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> > +
> >  /* Read/Write msr ****************************/
> >  
> >  /* PCI stuff ****************************/
> > @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
> >  static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
> >  { return 0; };
> >  
> > +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> > +{ return -1; };
> > +
> >  /* Read/Write msr ****************************/
> >  
> >  static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > index 21f653cd472c..63c3f26ef874 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> >  	return 0;
> >  }
> >  
> > +int cpupower_set_epp(unsigned int cpu, char *epp)
> > +{
> > +	char path[SYSFS_PATH_MAX];
> > +	char linebuf[30] = {};
> > +
> > +	snprintf(path, sizeof(path),
> > +		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
> > +
> > +	if (!is_valid_path(path))
> > +		return -1;
> > +
> > +	snprintf(linebuf, sizeof(linebuf), "%s", epp);
> > +
> > +	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  bool cpupower_amd_pstate_enabled(void)
> >  {
> >  	char *driver = cpufreq_get_driver(0);
> > -- 
> > 2.34.1
> > 
