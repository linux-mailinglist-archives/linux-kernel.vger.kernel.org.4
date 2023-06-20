Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82D736D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFTNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjFTNWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:22:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250B26BB;
        Tue, 20 Jun 2023 06:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFl7W5swdEpeJGhYw1NbaIFD+IkAyZmbWXoL5JA8PPBpwr52j9fYSnK0QVdhBg0V9f8Al9vV1lunzt7Qcbx/64vCtiAod2F8ioKcmngkc5Ugdh9PCMDW1k5MtDp6evB/LFdDjG5EKfSSjVkqRZMrpeLe2S/JgyBFp/O6Wq8oUUkICsenRaIhO7cZJE/sLqijw9tqIWvRfloffXyENpRQ1cpHf37ph0zijmJ14hpw1AlHqElOREW5dPMVqrtHrD8l6iL4C6T33KuhT2BNPeF3CeZgw7ikBW0D+q5TN1DGMef4aWb9eExlbciT6dlicrvesfbp5yuANNHSNKx0Lza6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8QrLqrRCUV1YUvCS7KsojVyF5tYtMcP03nMb6sKm4=;
 b=QFxfi6xLKphmvSNf09juEYWjTNLuEL/2c3UoeKsnvxgdJihg/hsrq7HNhu5M4S8MpYd3VTutQHEq22W6JQooTg7XmCBndQ8PvX604ja30FyGzCliHZF+/1UDu3XBxJDLPZM6758iVtfFzVl9vptF9yBU1wmgjudc3HkUPeWl6rCnvp0wEF19t0EmSKN0XIxgEuqUk75Xph2bj4U50qAb1ao44wj45vG2u+S/1Sj/7GOGBZFs33AUf1QGOzfzV6szyBgqWqMeRwBY4pcIKd96xHtnz8/6p1A0S1pwsYXXAxUARYUcx3MrvgN51e34/4ENsVL196HQ0LYtmL1f9s6LfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8QrLqrRCUV1YUvCS7KsojVyF5tYtMcP03nMb6sKm4=;
 b=sqU7DiQSzGCntkjhwAvUdix7uo1gnlCIiqCMtuUBrHg8EQD7nhlnLEHg1NEF7bDfHzK2KGCZl1P2Tc8OV6xu3VLr4SurzY6bQ6BudYbQrunw1eZ/gAkKVjexyaOAHbpuFZiQPPAfrJY564L4AqEAUs03++cl/SrEguKDAQ35Zv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 13:21:04 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:21:04 +0000
Date:   Tue, 20 Jun 2023 18:50:52 +0530
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
Message-ID: <ZJGntLOJtY/e+Wp1@BLR-5CG13462PL.amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-5-wyes.karny@amd.com>
 <ZIwNuRQK/mLTzfM1@amd.com>
 <ZIwlcvKCOVRyjstF@BLR-5CG13462PL.amd.com>
 <ZJGiWegN+CctWQBV@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJGiWegN+CctWQBV@amd.com>
X-ClientProxiedBy: MA0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::12) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe830b9-b5c4-4aa4-276e-08db719132c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0/nD67YIewFO0V5hYdOLgfGSn7wpBxVmRMP9M61jtg5BMsvIrYHrBRA9JsKR7vXPYTUIEvhp9xpXdC3E+miFGARFoOFtCaoP11cDaXXZ6G9T8X/+n20E2bdm3ZZX+Yw+wWSEfd3+SimxsHUqO2f5SGp8uKoqgpFPw0tdGPXgZpTHdqS3RfwonUcv/j1if7TJzv6xgtbXZnJKoAzNQzZ+wsrEB79mBVtuRiVyWWTEYPhXPP5enT4iNgLIrRnwS7WIyf8m4Qo8DbhtDPxrW2UZQGkMkHJ4ximV5BY5CxA6+7vWIiSTOk9HF9cNmREoT3FB7TVmOFeO35jAQ5jUtWdQHhEbV7SOhODZ6tIm+f8SDRhCFpMIzrSYKl1zsKg6yehYmHB8ibX5HPKMSkmG2MHGyEa4C5Ytn90oGGskICSHVGJrrG/E+XfsOkEzAHEjS8A0k6d6EuW+uOwlbfzP+ZgkX1bzs1ahurxaWQTkoZR0dnGl78hNDLUVvVm1TYHxr65EC0mV4pNshk6eRhZvrIkwgXYh1Eg1AgvN54iJV65aFtLinDhMrfAO1w3glEDh8ci
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(478600001)(6862004)(66946007)(66476007)(41300700001)(66556008)(6636002)(4326008)(8676002)(83380400001)(38100700002)(44832011)(6486002)(86362001)(2906002)(5660300002)(6666004)(54906003)(316002)(8936002)(6512007)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rw7km7F49wyyNfmrIt7jbWEhAYVll3UfKMMKyJMRdqnwfigYlxUjVTf/71fg?=
 =?us-ascii?Q?8d7G+I3zpTfdk+eE2/dqhEp978B5enFTpRNP1nxptLmh/YBnBwk/JwMNm5gS?=
 =?us-ascii?Q?4leeKdwYUWpw/iPKxw6kBDOubMJirnM2J7bs6OTivi48PYnLzVeYhpZz7ECM?=
 =?us-ascii?Q?eHlz5B34+8G9Rxpxp5NimaBPJvEhwEfW6xuR4puuzfZoCJ1oGCYsYZ9iFlms?=
 =?us-ascii?Q?V9HeEYVqnWZY5aDC3n3yUT93aBN4IrvVw7H0T5BjD3NEMVPqIki1U4UVdRPf?=
 =?us-ascii?Q?+nnd6XSlWEqXeN5aIwxhzAFqQTuFrbytKl7AH5lgh5L/KH5ezKl1BUsY+hnn?=
 =?us-ascii?Q?VGnWj4TBa2SKFWmsYt415DaEW8NokRpfn1kuLXXlV2OO13nMUqaDM/xjIf5r?=
 =?us-ascii?Q?RqWVn/8WwBtsFk7dPYq+hGBUIGfzRSoSTG3pXLRrEzoiF0Xw74KJNzpNCOTK?=
 =?us-ascii?Q?Ik2zY8Dwn60AfOh7IihEZLNHF3YQmG0JielGgB+MvBtGZxRbq/Wloy6Acybi?=
 =?us-ascii?Q?0pxyGNxEm2XrxKMeH/8WDRlzB1VO61IDkd/S9qn+PQnQgNV12sIG8FJnG659?=
 =?us-ascii?Q?pyBNAdyF8ka03h7O32OW3mD5dFkWMhOaqH0axSL5ZSGBJhgm/b8JEJ1RG18G?=
 =?us-ascii?Q?oaxD/5/Q+OaiOgUmuhgY4aaUsXwZSANkEn/eu0U55ZgY2Qu7Ah3rbbTQsDNR?=
 =?us-ascii?Q?XNlT3aCV5BZXspHqzsDHAmd8Mf+dMDwy8zjv01QAn6rah36L8hi8Y0shzYP8?=
 =?us-ascii?Q?RjVA6rfU0BwhsI/aH+Cdpvdur4jiNvqyuMPjOT9R+M2/evwLB6sIoP8JSIPa?=
 =?us-ascii?Q?I6HUoNl78YLUrevhNwT5hAjfKS/qYXLnP50czivxZUWXrRSzEClG0xnD5mPM?=
 =?us-ascii?Q?eqsbpYNkq/HpOssSccxun29VMnXxcs5twd72eHrsYcBNu3yQCdNFkp3CHxUc?=
 =?us-ascii?Q?1yQtW+yTkhKVhMxiSLW6sFUOXiOKyJqWpAWOClmNgHjTr7ZEbZ5GXFBKIFlD?=
 =?us-ascii?Q?645yPGKALO/hayu1ZOa6d7C5fu/F2OMHxpHP9sBLd/4+MaurkNd2+hL3jbKO?=
 =?us-ascii?Q?fQ7unVuSW7DNqUm+Dov5CYaDaIqkxVxdXp9jR8s5v5uM/462aFJlltqIk1uX?=
 =?us-ascii?Q?pVPGfeiLEBg04qxnv5SXf8zTbRXmTr+ir0rBvvxCMnW+/9Pm5vDvV6FluOv8?=
 =?us-ascii?Q?9UUN5AgjUAvxbNtuQcrLEHqwn46lhFo8ZzBmpkF1DV0n80r29KOdX/4VaOvY?=
 =?us-ascii?Q?H1Rwxd6Zl3hakRAgF2HqL9P1xjj12bA1EQea74eLvmiu2XNOV6KMr8vrYWPs?=
 =?us-ascii?Q?he7K6ktpT8wLrfW+1AddVotMnduYQYx5FYNNtao3AtcDBFF0kO+CBmt7auCr?=
 =?us-ascii?Q?w1eW21dp+MAGowN8dfyRlM13payqUG4hluQ8SFl6yPSHl7NVSXtIpR8oP5B3?=
 =?us-ascii?Q?4uDH2WJtrJgQBf8Km1ybzStsNBjENDTqKVtXLmpUGgEfybgUKH33B5DND0LO?=
 =?us-ascii?Q?xXGixDDRpoN6HBoumMoAhYyOmLl8Uls204f3srpK/wKn+HVQpNBmz1jiXZKb?=
 =?us-ascii?Q?WpLG72DCAqQ2sU2kMvR92iZCuk6WWSbIx6D2DN5x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe830b9-b5c4-4aa4-276e-08db719132c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:21:04.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU9C6JUtQB7YAjXfqnEgUnEc9wROv08Yb4BJtXVTD8Mr/Hx1vCqTVkyMvkFPoVFD79aEZ5NfzoZ9wh5ydgdJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

On 20 Jun 20:58, Huang Rui wrote:
> On Fri, Jun 16, 2023 at 05:03:46PM +0800, Karny, Wyes wrote:
> > Hi Ray,
> > 
> > On 16 Jun 15:22, Huang Rui wrote:
> > > On Mon, Jun 12, 2023 at 07:36:13PM +0800, Karny, Wyes wrote:
> > > > amd_pstate and intel_pstate active mode drivers support energy
> > > > performance preference feature. Through this user can convey it's
> > > > energy/performance preference to platform. Add this value change
> > > > capability to cpupower.
> > > > 
> > > > To change the EPP value use below command:
> > > > cpupower set --epp performance
> > > > 
> > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > > ---
> > > >  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
> > > >  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> > > >  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
> > > >  3 files changed, 46 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> > > > index 180d5ba877e6..a789b123dbd4 100644
> > > > --- a/tools/power/cpupower/utils/cpupower-set.c
> > > > +++ b/tools/power/cpupower/utils/cpupower-set.c
> > > > @@ -18,6 +18,7 @@
> > > >  
> > > >  static struct option set_opts[] = {
> > > >  	{"perf-bias", required_argument, NULL, 'b'},
> > > > +	{"epp", required_argument, NULL, 'e'},
> > > 
> > > How about re-using the "perf-bias", I think it should be the simliar
> > > function with Intel's processor?
> > 
> > AFAIU 'perf-bias' is not same as 'epp'. Perf-bias sysfs file expects
> > 0-15 integer value, whereas epp sysfs file expects one of the string
> > form energy_performance_available_preferences file.
> 
> I am thinking whether we can have a unify energy performance preferences
> input in cpupower for both intel and amd processors. But it seems not easy
> to align with them because different hardware interfaces here.

It will work for intel_pstate as well. Perf_bias is differnet interface
for some intel processors IIUC.

Thanks,
Wyes
> Anyway, it's not a big problem. Path looks good for me.
> 
> Thanks,
> Ray
> 
> > 
> > Thanks,
> > Wyes
> > > 
> > > Thanks,
> > > Ray
> > > 
> > > >  	{ },
> > > >  };
> > > >  
> > > > @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
> > > >  	union {
> > > >  		struct {
> > > >  			int perf_bias:1;
> > > > +			int epp:1;
> > > >  		};
> > > >  		int params;
> > > >  	} params;
> > > >  	int perf_bias = 0;
> > > >  	int ret = 0;
> > > > +	char epp[30];
> > > >  
> > > >  	ret = uname(&uts);
> > > >  	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
> > > > @@ -55,7 +58,7 @@ int cmd_set(int argc, char **argv)
> > > >  
> > > >  	params.params = 0;
> > > >  	/* parameter parsing */
> > > > -	while ((ret = getopt_long(argc, argv, "b:",
> > > > +	while ((ret = getopt_long(argc, argv, "b:e:",
> > > >  						set_opts, NULL)) != -1) {
> > > >  		switch (ret) {
> > > >  		case 'b':
> > > > @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
> > > >  			}
> > > >  			params.perf_bias = 1;
> > > >  			break;
> > > > +		case 'e':
> > > > +			if (params.epp)
> > > > +				print_wrong_arg_exit();
> > > > +			if (sscanf(optarg, "%29s", epp) != 1) {
> > > > +				print_wrong_arg_exit();
> > > > +				return -EINVAL;
> > > > +			}
> > > > +			params.epp = 1;
> > > > +			break;
> > > >  		default:
> > > >  			print_wrong_arg_exit();
> > > >  		}
> > > > @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
> > > >  				break;
> > > >  			}
> > > >  		}
> > > > +
> > > > +		if (params.epp) {
> > > > +			ret = cpupower_set_epp(cpu, epp);
> > > > +			if (ret) {
> > > > +				fprintf(stderr,
> > > > +					"Error setting epp value on CPU %d\n", cpu);
> > > > +				break;
> > > > +			}
> > > > +		}
> > > >  	}
> > > >  	return ret;
> > > >  }
> > > > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > > > index 96e4bede078b..5d998de2d291 100644
> > > > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > > > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > > > @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> > > >  extern int cpupower_intel_get_perf_bias(unsigned int cpu);
> > > >  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
> > > >  
> > > > +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> > > > +
> > > >  /* Read/Write msr ****************************/
> > > >  
> > > >  /* PCI stuff ****************************/
> > > > @@ -173,6 +175,9 @@ static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
> > > >  static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
> > > >  { return 0; };
> > > >  
> > > > +static inline int cpupower_set_epp(unsigned int cpu, char *epp)
> > > > +{ return -1; };
> > > > +
> > > >  /* Read/Write msr ****************************/
> > > >  
> > > >  static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> > > > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > > > index 21f653cd472c..63c3f26ef874 100644
> > > > --- a/tools/power/cpupower/utils/helpers/misc.c
> > > > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > > > @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +int cpupower_set_epp(unsigned int cpu, char *epp)
> > > > +{
> > > > +	char path[SYSFS_PATH_MAX];
> > > > +	char linebuf[30] = {};
> > > > +
> > > > +	snprintf(path, sizeof(path),
> > > > +		PATH_TO_CPU "cpu%u/cpufreq/energy_performance_preference", cpu);
> > > > +
> > > > +	if (!is_valid_path(path))
> > > > +		return -1;
> > > > +
> > > > +	snprintf(linebuf, sizeof(linebuf), "%s", epp);
> > > > +
> > > > +	if (cpupower_write_sysfs(path, linebuf, 30) <= 0)
> > > > +		return -1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  bool cpupower_amd_pstate_enabled(void)
> > > >  {
> > > >  	char *driver = cpufreq_get_driver(0);
> > > > -- 
> > > > 2.34.1
> > > > 
