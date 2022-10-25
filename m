Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850B60C0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiJYBPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJYBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:15:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49668B87AE;
        Mon, 24 Oct 2022 17:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJS0jUKr7NY3VVfpziLJ+gQzIPsYsJ73MIbL4rxfn5/QuZd7N5ep70+gtGmvQ/oZiCE1/8rmwxIoUbrKyiPFcMKVt67j2GzepppTsLqMbtXq6CcmFQZUgvvGZSmBqofvUh/LKUJAJkDTtIYnWBi3JwfyM+hWq6Ut4+jDG8EJG9Qzuu3M5UBH5+05Fiz7FVnUObT++xHZiDxuA+CAsu8y0pFq+hkkefFYgA0YsNGNBwJBRL8uaqURD1YiXH8mfhFKKpYIBzxv1Tal3mg6RESvpEGKXSglj9DBPk31mheBypNDN1VLPmyF/tjHC8FBOtU6Fah3ImktpW3gCT6PDTXw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FVFBhLGNBRccOzTkywn4/k3lb+nrGPl4z61hpYU7as=;
 b=lfY/TohPh8cgEGzdf/y5sooqvngMXteT7QI3BoBsjfytdL+3/huAtNUIzmy8dC+UYBSZk4VzV5eYMREaL8cYCuihP+t1vtVaLozQphngUqp/6dCqy7kllpHUuoSK8QtSwUy3Xm9RiFN8JzEvS1qFxYFzYSI/CxFPlNddWZsWegL00+ma9DgMKph9B9CLjSv+6vHDu7PRQqekziddeWsjf1h+wXbmkULwxa19m6/0T/MHlYVAhjNqidV1bOVizo+e6YIpKJSIKkZRCQGBqVkpZp0gcnN5dH0e406eaRu7J8SQHi84Rwh6rG4Kbi+NXdlkm15KNU0nnzAW2Pk7D11/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FVFBhLGNBRccOzTkywn4/k3lb+nrGPl4z61hpYU7as=;
 b=ixELp5ve2PR86PunbakD3st1dSzd6cLcZznM82yj40hE6ojNsUx613jmDj3MeSlcJV61qhpRDTbG+jEtn/sRwUYx6waLMzzv8NnXEWXJAtor8TTyKScAIW9wfBvZc3sYnAxfAsBZ9ElWV9NeXnbKiTKh4qvrMkSAVQAO1tkbz7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 00:32:40 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739%2]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 00:32:40 +0000
Date:   Tue, 25 Oct 2022 08:32:20 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Message-ID: <Y1culOyu6phXn0pR@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com>
 <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y1Isg4q9Vsl8zNPe@amd.com>
 <DM4PR12MB527822E265E6D6C747C5709F9C2E9@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB527822E265E6D6C747C5709F9C2E9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-ClientProxiedBy: TYCPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:405:4::25) To MW2PR12MB2506.namprd12.prod.outlook.com
 (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e3fb72-b1f3-4f0b-341f-08dab6206c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDoKGlbjEtVBTdLxgeSXofVdZguMG1aGhA4GsjcxEAz0dMDVIYhvu25Kf0OkZvOXZ5txDQImsARxxCR+GfzSll8xmCy32GN/HDIiP7iwMBHF+ENJ6qVl4t47QKhdg+6PZWa5BimJPhl18nHjNpVpaZQjJgCda5+nSq+x4zCVqAkVXGO0zB4HoVpR5jIrafkNZjk3ZSQpgeemthooo17tfWrC12W/uM7I8GlGO7JuzPqNfe95lVsFG3CiTYUd8tzbGbcM6oslMGsywbMj0FpEno3I+K+wuJUXNvgOQj3mDVc1oZzr+U7Dxx3Z4T0aqmbwoWC6pFqPL7UTZX7OXPi1fDAMxw165paIPGisr56qWF79IRhPU0OrGJLJQsOvFLcAh9SWDziJxcHONlM32am4Q/vg785LCWsX++iuD0KJHRr7Rd2Vb1hqnTrzLBjtyurBClZyfrn8/1l5mPcpaXmATIObH4g7TNWnLHRJxf4r7CNCZxqE+4t3GIjmyaNiKPH1MRRKIDDzsCDd13Iqtx0R5Dn1EWVjIYsZ/+O58tdLm+9rqI5R/OuAYyZKMFpHLzeuo/pjuSnv+tsBznVhtVrexcF511iVQZ6uXKUrOoHx32shHL5La4pV+2oNz5TDUYgym7Dc+Q+/tZcvJion8PwB7uQIQxq2OS+OhVg/KYOi+wQVFo91XGbblQHv7yEMn8IYGf1PPKAbUCcILqLJdoEjQ0GFod6w/5J9y4ZOWu3Ct093Sfk6z58vSgGbr8OxErVAQ7KNU9sODvYbf7ZgficBPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(36756003)(8676002)(2906002)(86362001)(186003)(2616005)(83380400001)(41300700001)(5660300002)(8936002)(66476007)(66556008)(6862004)(66946007)(4326008)(38100700002)(6636002)(6486002)(316002)(54906003)(37006003)(6666004)(966005)(6512007)(26005)(478600001)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I1CwV/rICX+um6RePbxvlKfzJ9QNEEIytRMlCPrIrA7S1Bi1p3X8BBSFgju3?=
 =?us-ascii?Q?Eq7Lle13nNI025XRCUgCOE0JCYx/9z1a2zK2YkyYUa1gUdtn6j9iUVn0E8r4?=
 =?us-ascii?Q?oiZ4iIULv49DiQexdH5UzmFbLVH+9mPZe6Oj8+ejE4fqlSJ7BQ3JbdmRSPGs?=
 =?us-ascii?Q?eQMv+N2OvR9EB1U9YSoVX3b13DkHSVGoZWXLB80Ry8S11CD8eQHuEe5cNY/y?=
 =?us-ascii?Q?2UppXxJrQdIAQuYsow190CZxhl/bLISL8UdY4JMl9rmlwlT3XZVGilYeAFg3?=
 =?us-ascii?Q?Ig16V4chVRreWxNLr82o5kXomTbxfJ5C/3FRKzAwRcaGep1EywG25M+RYW7x?=
 =?us-ascii?Q?XWHOs+fyvASCWsc7cwW+7PVIJUWRSt75yINSIn0/hF5txiGbhQ1ZExr87kKS?=
 =?us-ascii?Q?50kTIGtGBBG+wVXSh3H0ScLfSd2fqH43Aw16pfG0VLNEqxxV95EhMlr/0tqP?=
 =?us-ascii?Q?t8MIWLYcogQpUhIzqugkjFNKar36lk2tH2c7TQh9mNt6IvPplE4578m5rrlQ?=
 =?us-ascii?Q?9zHaIW9xVTvpd9jkWXVr0QMtDyQltcSSaNwXADAq7Sq9XjeqqmD4bM2/KDCD?=
 =?us-ascii?Q?g3jCyZGdXclxw2vcS4UZNlBursTacvDalm9N33YLoiL29yEudz2L+nN9igB0?=
 =?us-ascii?Q?qhUde6GlJR7UnoQz/Ig6dCuqtVo82LHmEYj5P8vWyWluad8ld5bl8OiYnjua?=
 =?us-ascii?Q?VNmx47jMQVAjXkl2mZmowS4ueFtJAHlxlEpK/nCiWH1s5K6AVfXQ9AFy/6ll?=
 =?us-ascii?Q?0sbXl1+R9/xkxRNoTJ4/iUPmytQjt+iy+GNEBrhlz7Aaw6QfIIjTiAn5IDaE?=
 =?us-ascii?Q?WQ+9nfVWqdZeE3hIKzfw5BHdFaWmHv1WoBrKTmNTWsQt4yiBqHhfHBo3LZF3?=
 =?us-ascii?Q?oMzShEnpG0nGAjB6eEdGhmxFdVkWIwrSOYRozQinZpYqRuHzGpK4RBiUnQxG?=
 =?us-ascii?Q?DePB/jdJIX0OOdpuUAWWmBhNT1LJxhJW/Uzqv6uigKYeAif9ekOVLW2ugeSJ?=
 =?us-ascii?Q?bKrgXgid/EF4041POM3T+5TafpMCG1iaZEc+sCF43npKX+S6dLgigp/bzbZc?=
 =?us-ascii?Q?0YdmpceS8yNx90YhWoB7E0RQkBw52VaxtBML9FX0O1Ft+ir0lD/Fks7tmdtX?=
 =?us-ascii?Q?Zxn+1awW/Z+Zu0pr2HX5fiV/JnqjKJSODbjRWFhmEt9baXLh1eC5WSBvY7c5?=
 =?us-ascii?Q?r+tvzSfEp29y/DWbPnIYiK/dhyVG0K0wLV3Un/jxXn+DKK4WXoUCXfDHMAzF?=
 =?us-ascii?Q?fL1p1CNxs1LuodC/Gbe32IAb1g9+Tb/s8YyqOmjqJrxbdkaWBzSaEs53D64a?=
 =?us-ascii?Q?lo7C/BcRkm024MH8/uF/NccW95zyrubKxinb/o7nd9S2yELrGxukUADry35f?=
 =?us-ascii?Q?gFyw+xcFUD7yjTMgad239U4GaJXC1sL1Dv2/Q38TnhGT5MsZY0ImAqpIeIOp?=
 =?us-ascii?Q?wazwo6pcjcQ0pBHMuEWU1yAZU3bilov0b19q1lwSqF4xR9AWaon0jGHyJlez?=
 =?us-ascii?Q?249jvNJqzeqQmdYDS7eDHDIFmhHmCJSUcX8tOQOE1O02y78wLvV+SNU7hJhS?=
 =?us-ascii?Q?kRTeZ6Rcn9+WZsv1QztMM4ZA+9YUD7HYTt8hK+Bm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e3fb72-b1f3-4f0b-341f-08dab6206c69
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:32:40.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04MmOpWbRT0UVizYszihn1/Uc2pAzUuJq7mBoqHCdwfEctR/J7h8FOkw0JUwWsOsMs0idgL9leJ3yoaHXymhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:56:50AM +0800, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> Hi Ray.
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Friday, October 21, 2022 1:22 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> > viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> > Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Borislav Petkov <bp@alien8.de>
> > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> > AMD CPPC boost state
> > 
> > + Boris,
> > 
> > On Fri, Oct 21, 2022 at 12:05:21AM +0800, Limonciello, Mario wrote:
> > > [Public]
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Yuan, Perry <Perry.Yuan@amd.com>
> > > > Sent: Thursday, October 20, 2022 11:01
> > > > To: Huang, Ray <Ray.Huang@amd.com>
> > > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>;
> > > > Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> > > > <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > > for AMD CPPC boost state
> > > >
> > > > [AMD Official Use Only - General]
> > > >
> > > > Hi Ray.
> > > >
> > > > > -----Original Message-----
> > > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > > Sent: Monday, October 17, 2022 5:57 PM
> > > > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > > > Meng,
> > > > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org
> > > > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > > > for AMD CPPC boost state
> > > > >
> > > > > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > > > > This MSR can be used to check whether the CPU frequency boost
> > > > > > state is enabled in the hardware control. User can change the
> > > > > > boost state in the BIOS setting,amd_pstate driver will update
> > > > > > the boost state according to this msr value.
> > > > > >
> > > > > > AMD Processor Programming Reference (PPR)
> > > > > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf
> > > > > > [p1095]
> > > > > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-
> > PUB.zip
> > > > > > [p162]
> > > > > >
> > > > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > > > ---
> > > > > >  arch/x86/include/asm/msr-index.h | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > > > b/arch/x86/include/asm/msr-index.h
> > > > > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > > > > --- a/arch/x86/include/asm/msr-index.h
> > > > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > > > @@ -569,6 +569,7 @@
> > > > > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > > > > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > > > > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > > > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > > > > >
> > > > > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > > > > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > > > > @@ -579,6 +580,8 @@
> > > > > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > > > > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > > > > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > > > > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > > > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > > > > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> > > > >
> > > > > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > > > > MSR_K7_HWCR
> > > > >
> > > > > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > > > > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> > > > >
> > > > > Could you please make sure address the commments?
> > > > >
> > > > > Thanks,
> > > > > Ray
> > > >
> > > > If I rename that the MSR definition string, that will cause lots of
> > > > driver file change.
> > > > So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR
> > > > is mismatching in the CPPC Pstate driver.
> > > > If you refuse to use this new one, I will reuse that old one.
> > >
> > > To avoid changing too much stuff at once how about if you give an alias?
> > > IE something like:
> > >
> > > #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR
> > >
> > 
> > The mainly concern is that HWCR is for legacy ACPI P-State control not for
> > CPPC. I talked with hardware guys before, it's not suggested to mix them up
> > together. This register has been defined for a long time even before Zen
> > processor.
> > 
> > Thanks,
> > Ray
> 
> I have removed the code not to write boost state to that MSR, just check the boost state from the MSR bit value.
> It will not cause any problems, I have tested and confirmed that the BIT value will be changed after BOOST ON/OFF switched in BIOS setting. 
> So we can just check the boost state here for pstate driver notification. 
> 

If we found MSR_K7_HWCR would impact the max frequency in CPPC, we should
report a defect or issue to firmware team. (Then we can add a quirk
function to workaround this in amd-pstate)

Thanks,
Ray
