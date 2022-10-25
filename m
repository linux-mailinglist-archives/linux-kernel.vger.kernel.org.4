Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0860C0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiJYBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiJYBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:13:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830C1C97CE;
        Mon, 24 Oct 2022 17:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2hk9Jx/bvN4NEM1J4oXmXA4fdg54cCGBf9VpwfvUa1md04V8v/b3HOcXIXDMuTX/gsNO0bpOgwpAv6pw1L9Q6t3KUGcYY2Bs+5ucI2kiJI77eJCXGeOLpmgWtJDcXVFWd9EKrdw77DpE911Pjuj/zq5vNf4+rmAWvX6M6PKyzH3ofE8UjpkF0HcR82e5qBxJSxFEHsbfzbvLwhjzkl8L9CRo4M3S3LMeaCTmFj/EwSOPQQoui2j0I0FRb++cnvHN4DfyxQHEPHJVESypRDyQdH9RZHN+bThyurpfmScl/KBCtbM8Ip9IwhzzmBtOHX9Zk5zfiwBx4wv3GZNuGndgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHe6OmOkTY9SrpwxbS/VZ4JKZbDK0asjBFnXFBShznc=;
 b=Yb4qMJB6fKV+j9+6mwx/6XbW1S6YZebNDPBUbZYvQyDF+Xihnmrp0dqOLkqfgCPSnZl+7TNOI+NSwJZxgkyC0Q5txpKG/I66PMWsII9V8Mq6CIMiBp1ypOW363inMLtnjYmK1AgtPmTRa7El5r9avPTpavjasJFR1N/svc50PPfUZ0hFFKOQYaBEMyPRibkLjIY4Oyv6xPBv+GEwG5LQNEVEHSb1rz5uFdLaLfe9bcRR8BulWTa8nF0lV9sTeUO0TBaSYZsG/GJf5phOL5UfqG4s+QVVpsWOufehAe7FjasXTvukIAlCL2wIOrgVGCUGPFYugjNra56v+Gf2QGoprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHe6OmOkTY9SrpwxbS/VZ4JKZbDK0asjBFnXFBShznc=;
 b=LNWHUP2X1wlGJNrMvLHCDdUVCzg0z4OGadlZ/n07SF1HnjwQAMqGR1eUfq++Zw25a2B4PXsF7zvVuPV3UZH1gOpg/53jmjLK8MKghgaBqIuH8BhtyTpPr5r/MOnU40nDb88nD00fOiPK2dsOdPNjG4OlUA+5sMNlUF5U93vna7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 00:26:02 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::ec3a:151e:5230:1739%2]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 00:26:02 +0000
Date:   Tue, 25 Oct 2022 08:25:41 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate EPP
 support for shared memory type processor
Message-ID: <Y1ctBSNrc+2y0nSV@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-7-Perry.Yuan@amd.com>
 <Y000eLQY/nKqiNFZ@amd.com>
 <DM4PR12MB52781C923DDA85CB93F7D3129C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52781C923DDA85CB93F7D3129C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To MW2PR12MB2506.namprd12.prod.outlook.com
 (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 865232f9-a94b-4bbf-313e-08dab61f7ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4eebJOITqVNDMJ5lWIH1V8JM23ORBJ6ZO0g5vC06HDYjY8O9CGpmjQ1GC9QZt3ZF9NbVfdPl6l9LMHCBTv+kMHi7GERfODWWCcJdWD9MPvqIE/mV+/eyjY+5PkYF8hy0OrSlovlBHBGUEYWNloSssGPmYm7SOOHMYDUGOsrTSfHhSdCLvw26kN6W1DZoVQxLEA8v5Gr/BVLU8LDoLgxD+wytepoLtd0YPq+lqQq6a1WFLZJ5Q3b5tyHTFjwzqp1ETqBqFTy7itqN9YazqZOfStJ4s2BolMA7+5Hz+cUzbl2gNOy2irsFmFIB2r7BhySo0xvQEFVZWr5HLF7LpmTkqEDdtjLnLGg4bh1pESQ7ixnFmdHIwOcA9oupLzMMoV/5K6/+6KoakxKf4MDCAxiV5RvK7Up0Er9sav5imEZkJZ5IzsZq2CvVzmAApPSjRVbV2uH5XWRFbC9SUpEJUgpfAUCUhmUifrn+jilj2l32nUsNerOuCFj9urN0mGtUZAe5+S17jU+3pxhOPfJwFoGEN9PNBmrvaN90S4EoFMr0FUCcmBGr3hHhQQ6G9zrRVIdrCa6bWcHzW83tpH5R0xhITSE8OLcsg3ffw00Q0JPFiZvc9EDlTqUiuUB71SAeBSX5JnSc5EX/d8lTpTXRQK5zz32yWhN1muMoRhj5kzqHiagM7+dytvIUCzK63laXDttAy/a50W/JK2w14Euc8NbrLvDymZiqyRWE0bCIT+GTNyCCvUDaSsG922zrdVveNWRGTaZt5WX/RGeFa2BtGfW4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(6862004)(36756003)(38100700002)(86362001)(6666004)(5660300002)(53546011)(8936002)(83380400001)(2616005)(54906003)(6512007)(37006003)(316002)(6636002)(6506007)(66946007)(478600001)(41300700001)(6486002)(66556008)(8676002)(2906002)(4326008)(66476007)(186003)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgsIsaHAhhf0Dka5mv6AjtqDhn+pvlu7Sty5dutuKlx/xeaG3/WAjbFTks4L?=
 =?us-ascii?Q?jXCOsXTyxS7YyYGzyE5Me0CockaoJUtWzU8U7QsZkslxOtXXFbGObse6Cjqj?=
 =?us-ascii?Q?I4sZX5F+prYaQcN/Mjk24FtmoIn6yKHE5TLaoecyvKIoOJNWsYbf9mmPKTf9?=
 =?us-ascii?Q?s6sKlbftCUsJYx9aC6AJq42948+M3KUJUTFcncgdlgpUABmzHSj+QbFEjost?=
 =?us-ascii?Q?po7IC4iJNIGwKYPyPvVAmRtyF9847aTPSGip9ZN/dMZgk0OT5OsxhWvqxe7f?=
 =?us-ascii?Q?Vs9AtqV0tDdNIpcjoXKh9K6aW3vDUuOe6FT8F7YnTwDlLBu6GUieAo7qfCiv?=
 =?us-ascii?Q?ccr1JwA4Hp7FmfbBhCjGOamkv6zbIpNNu0r183SDj5fZJBexg1gFjmc7Nd7X?=
 =?us-ascii?Q?9LLMg7WbfL6+NuGVYumuatOv9ZTrZB24uBV+0rfLazhVkBCU4ylYySRDXx3n?=
 =?us-ascii?Q?CbFVodwc7WwUcpsIfo91zn90JukRMrF/qHMbs8SItD9tdI8NuJ4/9M6cSi3o?=
 =?us-ascii?Q?vNPkZrsZPlawGCxB8CDOzFpjC+iV2HKSRq0jh8qrSDTzM+SQ0Jacz4/IX30z?=
 =?us-ascii?Q?WiFASS0IhOii3+TUT0uIs+duiF8x2mqsgP8AGWR1bDOw9qk8Bv3Xe0nadcO7?=
 =?us-ascii?Q?rmYTRQsLFVegDlkaFosZ3o4ZaW4rhoL989NUK/JKMBZVv+DFAJHq1Rfym4tG?=
 =?us-ascii?Q?zMiaH9uRvvZ8dSLdinnJjFwWnYx507flXYYXAhdeTQglWdfkBos3i4C/TPqb?=
 =?us-ascii?Q?NW7vUOjFUqAKa2bhQsVBRfn/RNigBsKesS910bN2ZV34G2G68tavamFscStb?=
 =?us-ascii?Q?aONLczrSUGChdrKLC0wPz9uKQhyUnXdHhs9lP2JJKA9P37r99FdfJrou4aAW?=
 =?us-ascii?Q?Sa1QUaNk+8WYDN7s22EnIpuZ3jgUlYzC3S/UqLDMCy20awUuix4+OzL00Hfh?=
 =?us-ascii?Q?aIjYFT7WAgHa6n8n/eBp1DuecobvAzH27DuH4/9HKFttDUCFPcokCYUikOHt?=
 =?us-ascii?Q?Uy+DrlQnZPcmiJ6H8+N4JtiaDFPlVhibwCNKeuYO35nkZJzU8Nywh8mBL0Kv?=
 =?us-ascii?Q?hAD050HpNqTbgON4l/knJV6yYk3emFIipOXnacFv3DBytMTwxmesaoClZkzU?=
 =?us-ascii?Q?ksCdiHya6PuWObtyxxZlNUw9IgmSd1vpi6KT8j/EWBJVwA2A+3UmvbjNvJHX?=
 =?us-ascii?Q?b/exG2A7Pro2omENzbwW80z013yqus48hhkOVW6emoglTkCSJ/+CrXr/CLsT?=
 =?us-ascii?Q?9ktSzasjVoa3HV4KtAOhCvUICgdPphDsDbHgDYdsmgng+i+nOTK7Ap2dWrQ6?=
 =?us-ascii?Q?EwKSAWxM3RAbnzQwFVD4/zoZwhDdePMgwbF6/o5gNKnXK2Ovz3v4l6ZmnDi5?=
 =?us-ascii?Q?fL3AEtD2Kj4DPmG/pUZ+hM+GFNgkDZp3bVwW+s9cT8IsZt1SXHkPlYk/746W?=
 =?us-ascii?Q?hHNqem6mHxsfmdH3ioPYNk+vSRE3Z9Pdd/YwDaEA8cGP8l9BZFcmzcqBTrAf?=
 =?us-ascii?Q?OJ+QowxB16NspY+hhcycTItbcn9B9fwC7dl321ND+LP3WINW0aVNpxjLpJtu?=
 =?us-ascii?Q?CcTAmiWbjsyMt72c8woUtjAdkvVf1dM99M4eqMzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865232f9-a94b-4bbf-313e-08dab61f7ee9
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:26:01.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMXh4+UoXFlBxVUO9E1/CjlhGApTZUHdPl3FUNjwmkzedfvFeZ65ua20Q1D4uJQsDUZtJWrg0XnCa0o3880osA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:04:26AM +0800, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> 
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Monday, October 17, 2022 6:55 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate
> > EPP support for shared memory type processor
> > 
> > On Tue, Oct 11, 2022 at 12:22:45AM +0800, Yuan, Perry wrote:
> > > Add Energy Performance Preference support for AMD SOCs which do not
> > > contain a designated MSR for CPPC support. A shared memory interface
> > > is used for CPPC on these SOCs and the ACPI PCC channel is used to
> > > enable EPP and reset the desired performance.
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index 2d28f458589c..08f9e335f97c 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -135,12 +135,25 @@ static inline int pstate_enable(bool enable)
> > >
> > >  static int cppc_enable(bool enable)
> > >  {
> > > +	struct cppc_perf_ctrls perf_ctrls;
> > >  	int cpu, ret = 0;
> > >
> > >  	for_each_present_cpu(cpu) {
> > >  		ret = cppc_set_enable(cpu, enable);
> > >  		if (ret)
> > >  			return ret;
> > > +		if (epp) {
> > > +			/* Enable autonomous mode for EPP */
> > > +			ret = cppc_set_auto_epp(cpu, enable);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			/* Set desired perf as zero to allow EPP firmware
> > control */
> > > +			perf_ctrls.desired_perf = 0;
> > > +			ret = cppc_set_perf(cpu, &perf_ctrls);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > 
> > This patch only writes the desired_perf as 0 to enable the EPP function, but it
> > cannot be an independent function or patch without the dependency of the
> > next one (patch 7).
> > 
> > Thanks,
> > Ray
> 
> Do you mean that I could squash this patch into Patch 7 ?
> If so , I will get this into V3. 
> 

Yes, thanks.

Ray
