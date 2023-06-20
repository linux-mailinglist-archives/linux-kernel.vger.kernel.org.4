Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EF736DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFTNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFTNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:49:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D00E2;
        Tue, 20 Jun 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7OL3+9C7WRabW686zWTolEUd3VEbq4VAZy4CjIERm60ctAGjZoCyNSti2anR1SHPO2NQ9oaiNqZoWh1pxw9tt/L4F/EixbbDQjbkEg8xxIuZ0z6REOQ2XQtjuOZmJXG7+BhkDJdZW3t/kzvcF13a7ovdHP+FPWi9H9DfhUf7GtHbZXMTxvw1bzuiXqDSNn/J+kguGXN004tccxMfw+XcXWlJxoq5RNiQrLIbeeojbeXXeOPyNi3MkNwF5oxzk9gJARlTmIgcUVRQ6urp9dbLKwbThQqtCCB/8qn7KrnOQL3EkGZqI4CV+VBpdd82E/h2RvX6VfDABF+WJcZgeBePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7e88OpGzOKH412I/PyloNl8x/EvJAi3C3xgmOQtcvI=;
 b=grjymdwvZj6vTZsKCfg098Oo321RDAuF5LCdlke1ZfIquF8snq9ELK9P0g3jjMLRK/Rl+gO/OC8N4VWc0E7aUhVGt0CyzB3JxNd0TmSNYEmFfXgemvEEdqXq7khXcu7lCEifMi8x/r8hjhmH5Ok5hpQvc7/jK6AZjPq9kBL72DFElLXP8epk5QRrHzBZ1C9tHLmiIyLtNIsUcFEQ2dH1PGSq38UdopE8D7sAqAa73L3RkG2t8saV0Qfx8wKVqdm1vLOvbsImJ9N8gUDrDKRHpSlyEGOJa1bgMYA5yQiRfGFx40Ldd4cxyW0bQHAyHGSbToluA4gRz169c2J7v66+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7e88OpGzOKH412I/PyloNl8x/EvJAi3C3xgmOQtcvI=;
 b=QTOq+BWNOnoCQqC0NO7X2wg79khKmqrV99xz5tMdrnD/MTlgyMU0GfTF8QrshykzMVkoEJ/wTP0BhfbaoUlImZQqkS58qX8p99phtN88lWr8wb5IgmX3wYs+TwA725gui1WC0FQzczod0RXMvFAvRLATR0o2RB5J6rblshthAs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 13:49:28 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:49:28 +0000
Date:   Tue, 20 Jun 2023 21:49:06 +0800
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
Message-ID: <ZJGuUuwzNouXhOcc@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-5-wyes.karny@amd.com>
 <ZIwNuRQK/mLTzfM1@amd.com>
 <ZIwlcvKCOVRyjstF@BLR-5CG13462PL.amd.com>
 <ZJGiWegN+CctWQBV@amd.com>
 <ZJGntLOJtY/e+Wp1@BLR-5CG13462PL.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJGntLOJtY/e+Wp1@BLR-5CG13462PL.amd.com>
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BL0PR12MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: 973cc4f3-29d7-4d37-9d42-08db71952acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gPRiiWVbacjfBlvWEUNgPNyc/ALT1ulFlFRIFuCihfRDChdkUVXzhhYIHcWV0NMFfvWDYe9hb/SGVTk/HNdZ66mB6dSXPw3US6hy0frFOamJyT41apsoGWuw11+UqY7g1VrbXUPJdbMbweV3y6yksQuOZDXBUaojOjhV2HZ2v4Nrx3ZjcVgnbEUbE3dKMJQX+I1NvgC4nqI/lt0SpsqGz20UXrUx8MPk4UqKygsChXOl2I/SybM6jjBZuwV84DNigVB036Vvo8OT+Vg+HwhKvNWQ0FN2/UroSUSRYwiXavHDlSo+4FQAW1GpaCpJWqdNhh7JaCp2lap9D52FJ51s5vEUhdx42UPUVS3btZLIDBdwnIdttEuQe4EkSrpJ1aaG0KZ0jKON5ISHmKCuVo6MzIEDh/201Gf5i/L0dqditT8IKn3kyyPxVeOCnFhdL/DZC0fBJ2vmyYXmsm6YY+DDXNsD9KyzLFoNJGgVM0UT4tWzf4WdypkkOGk9LphIeYSXDCfNYPysBOOm1Ueai3gfD7ndWMbYtf56dc87rxP5cBgHEI2pnBHXX9Pn02nhCZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36756003)(6862004)(5660300002)(66476007)(8936002)(8676002)(41300700001)(86362001)(66556008)(316002)(6636002)(4326008)(38100700002)(66946007)(6486002)(6512007)(26005)(6506007)(2616005)(2906002)(186003)(478600001)(54906003)(37006003)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHf4hS1ujSrIDIFdyaLMw0cq1im0rsIE29jawANvjQB46RnPoWueQ1Ip5P82?=
 =?us-ascii?Q?RRSQ6NKtfeFWtPyUoV4vbC9P8n2ZRjinmkqpslqDh05wXQ1z5oYVIlG6lZDN?=
 =?us-ascii?Q?GipgdfOnaZhDwuxxZj78e4cBrvDa/WgwHo3H7P+BYZSnNoWDfwaKKvBhUPiI?=
 =?us-ascii?Q?9e6ewcbGxTINXgXfrU2ImiLQa0DKKFZRUtEq9T3jq/+wOyqijRU22uBNLcAt?=
 =?us-ascii?Q?yORdhoRH72jXWsITQ3R93JJQuktuRtr4KbfA0VrDlDcv3nxS/g7VIpdihUU9?=
 =?us-ascii?Q?uTH4AO01EDGSIDm6Td6/OYkOag/opwuwst94udUssxugba7tiMN0dH38H5Pm?=
 =?us-ascii?Q?jUAj+SBSYKfsO1RVxoVSVQMNz+DoVIFQUGPM1TJy1rEca99jS5Kj9xr/iAhB?=
 =?us-ascii?Q?ngBIwB+DjlbUFWNM95+ERL+jxPgGr2ZPbmhXy9XalnCOg6DXtKe3U1YHGuUS?=
 =?us-ascii?Q?5VyasWPEDUQ/lzSMIDmoWEutFeYhxSxpVdT0APbXjYhdpGbWmyznXRRAMHx1?=
 =?us-ascii?Q?P1gWKnxpS4JP8oIYViQM9VEiRCYab0GY5nBFOM7EsV9jsFi8cI5gATc08cyW?=
 =?us-ascii?Q?p0mp/q4Ufd6OtliUuAZX7Q7NqTb8AQDpbpqsa63vuF+DzNj3fiVbLqcTwk/C?=
 =?us-ascii?Q?tgwyo796Qd+ugCvU/gnqFc5xJ38G+1OzrNN7IETj8X3HDKC4T84WTfu6NDir?=
 =?us-ascii?Q?NExhZZs4UgoZwDvpOeFfOSOrDJh9kDe7c4LGo6vm8BDlzbDdHMeMPeHpOBVF?=
 =?us-ascii?Q?D2s0YRvCxT8yTOA4jrj3n//u94x9uhzXhWz3ZNtnUn2uM+WHSR8juJFZmoC2?=
 =?us-ascii?Q?EuR4L+/gaGd+IlXLajejm0lFNhlnKCbiSlO2YKXPAiaunrtJxeDx3/Xxd83u?=
 =?us-ascii?Q?XW4Q7tUTOdbGLgHN/K5k6XSowBSSDbLlH8NP97FHVAFLMXR9QA2zgXiKEgxm?=
 =?us-ascii?Q?NP4XG46O4nw3mPmREKXCwg4MwFoa+qZN+d5viEThRqptW9h57dXfjqliu48K?=
 =?us-ascii?Q?7s0wuS8WoDGnjhH7dh8V75Y8GcQE7bTmDwxalZwiVMCsIXPrFgotj5MokgHT?=
 =?us-ascii?Q?zbe6AqIzaWq2As7If3V8Mi0sgY00cJ+gEUk+MPqpLICGEhTOEoMaV8Uh1fuP?=
 =?us-ascii?Q?pEWBxWE1VT5gk7MmJqjnjdXslvp3SsGi9zVu9pha7/44Uz5Ee8ZDPdaZqRX1?=
 =?us-ascii?Q?BG3Qb3d4p86n+Wyc1pAyAuw4lJGNjulKzUPxsIM55oPsG+thJySwbDQZv0oA?=
 =?us-ascii?Q?BIc3LR9DilsRnWuJ/zrXu+qnD1wC9N0WcmmVZLIfrNIX8Rzu8VFeScW9z4g8?=
 =?us-ascii?Q?iGD/UV/dM2q24PfTg9hepEWVZiQsOtn8N0VZgdXiy2VQNPXq14DgPUpRf3NW?=
 =?us-ascii?Q?vk7MMy4oT0uFboGVAsSnBL4qhUhivxSpT0WILa2jNtxxFFu5RUgb9lIfeVxo?=
 =?us-ascii?Q?X5amJo104Or/icRggR7BCg7yWwjrWPFPBsS16Nl1p5eI0YKb3b8NLabjXHPU?=
 =?us-ascii?Q?MrtUuSFnspm8T2xF1kyVoOTRM1G2BAUiK9j7t1DLf1S+2VV9yHhx+hMlYZnQ?=
 =?us-ascii?Q?8/AOwbqJjMAYBvcMAIP/0B4CZ3kku6TFQNnAEW59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973cc4f3-29d7-4d37-9d42-08db71952acf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:49:28.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vx2NDVHM31al7ntzeT+hu2FQMUA9lcmIZ/lcfYevc3p4/9Fy++BslEn8YzLNrKg+8HZDXxJ7qUqy6deucI9U9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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

On Tue, Jun 20, 2023 at 09:20:52PM +0800, Karny, Wyes wrote:
> Hi Ray,
> 
> On 20 Jun 20:58, Huang Rui wrote:
> > On Fri, Jun 16, 2023 at 05:03:46PM +0800, Karny, Wyes wrote:
> > > Hi Ray,
> > > 
> > > On 16 Jun 15:22, Huang Rui wrote:
> > > > On Mon, Jun 12, 2023 at 07:36:13PM +0800, Karny, Wyes wrote:
> > > > > amd_pstate and intel_pstate active mode drivers support energy
> > > > > performance preference feature. Through this user can convey it's
> > > > > energy/performance preference to platform. Add this value change
> > > > > capability to cpupower.
> > > > > 
> > > > > To change the EPP value use below command:
> > > > > cpupower set --epp performance
> > > > > 
> > > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > > > ---
> > > > >  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
> > > > >  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> > > > >  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
> > > > >  3 files changed, 46 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> > > > > index 180d5ba877e6..a789b123dbd4 100644
> > > > > --- a/tools/power/cpupower/utils/cpupower-set.c
> > > > > +++ b/tools/power/cpupower/utils/cpupower-set.c
> > > > > @@ -18,6 +18,7 @@
> > > > >  
> > > > >  static struct option set_opts[] = {
> > > > >  	{"perf-bias", required_argument, NULL, 'b'},
> > > > > +	{"epp", required_argument, NULL, 'e'},
> > > > 
> > > > How about re-using the "perf-bias", I think it should be the simliar
> > > > function with Intel's processor?
> > > 
> > > AFAIU 'perf-bias' is not same as 'epp'. Perf-bias sysfs file expects
> > > 0-15 integer value, whereas epp sysfs file expects one of the string
> > > form energy_performance_available_preferences file.
> > 
> > I am thinking whether we can have a unify energy performance preferences
> > input in cpupower for both intel and amd processors. But it seems not easy
> > to align with them because different hardware interfaces here.
> 
> It will work for intel_pstate as well. Perf_bias is differnet interface
> for some intel processors IIUC.
> 

Sorry, I mixed up the energy performance preference (epp) and energy
performance bias (epb) in the intel pstate driver. You're right!

Best Regards,
Ray

> Thanks,
> Wyes
> > Anyway, it's not a big problem. Path looks good for me.
> > 
> > Thanks,
> > Ray
> > 
> > > 
> > > Thanks,
> > > Wyes
> > > > 
> > > > Thanks,
> > > > Ray
> > > > 
> > > > >  	{ },
> > > > >  };
> > > > >  
> > > > > @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
> > > > >  	union {
> > > > >  		struct {
> > > > >  			int perf_bias:1;
> > > > > +			int epp:1;
> > > > >  		};
> > > > >  		int params;
> > > > >  	} params;
> > > > >  	int perf_bias = 0;
> > > > >  	int ret = 0;
> > > > > +	char epp[30];
> > > > >  
> > > > >  	ret = uname(&uts);
> > > > >  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> > > > > @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
> > > > >  
> > > > >  	params.params = 0;
> > > > >  	/* parameter parsing */
> > > > > -	while ((ret = getopt_long(argc, argv, "b:",
> > > > > +	while ((ret = getopt_long(argc, argv, "b:e:",
> > > > >  						set_opts, NULL)) != -1) {
> > > > >  		switch (ret) {
> > > > >  		case 'b':
> > > > > @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
> > > > >  			}
> > > > >  			params.perf_bias = 1;
> > > > >  			break;
> > > > > +		case 'e':
> > > > > +			if (params.epp)
> > > > > +				print_wrong_arg_exit();
> > > > > +			if (sscanf(optarg, "%29s", epp) != 1) {
> > > > > +				print_wrong_arg_exit();
> > > > > +				return -EINVAL;
> > > > > +			}
> > > > > +			params.epp = 1;
> > > > > +			break;
> > > > >  		default:
> > > > >  			print_wrong_arg_exit();
> > > > >  		}
> > > > > @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
> > > > >  				break;
> > > > >  			}
> > > > >  		}
> > > > > +
> > > > > +		if (params.epp) {
> > > > > +			ret = cpupower_set_epp(cpu, epp);
> > > > > +			if (ret) {
> > > > > +				fprintf(stderr,
> > > > > +					"Error setting epp value on CPU %d\n", cpu);
> > > > > +				break;
> > > > > +			}
> > > > > +		}
> > > > >  	}
> > > > >  	return ret;
> > > > >  }
> > > > > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > > > > index 96e4bede078b..5d998de2d291 100644
> > > > > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > > > > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > > > > @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> > > > >  extern int cpupower_intel_get_perf_bias(unsigned int cpu);
> > > > >  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
> > > > >  
> > > > > +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> > > > > +
> > > > >  /* Read/Write msr ****************************/
> > > > >  
> > > > >  /* PCI stuff ****************************/
> > > > > @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
> > > > >  static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
> > > > >  { return 0; };
> > > > >  
> > > > > +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> > > > > +{ return -1; };
> > > > > +
> > > > >  /* Read/Write msr ****************************/
> > > > >  
> > > > >  static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> > > > > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > > > > index 21f653cd472c..63c3f26ef874 100644
> > > > > --- a/tools/power/cpupower/utils/helpers/misc.c
> > > > > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > > > > @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +int cpupower_set_epp(unsigned int cpu, char *epp)
> > > > > +{
> > > > > +	char path[SYSFS_PATH_MAX];
> > > > > +	char linebuf[30] = {};
> > > > > +
> > > > > +	snprintf(path, sizeof(path),
> > > > > +		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
> > > > > +
> > > > > +	if (!is_valid_path(path))
> > > > > +		return -1;
> > > > > +
> > > > > +	snprintf(linebuf, sizeof(linebuf), "%s", epp);
> > > > > +
> > > > > +	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
> > > > > +		return -1;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  bool cpupower_amd_pstate_enabled(void)
> > > > >  {
> > > > >  	char *driver = cpufreq_get_driver(0);
> > > > > -- 
> > > > > 2.34.1
> > > > > 
