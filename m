Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD7634DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiKWCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiKWCj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:39:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C026DCFA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669171168; x=1700707168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gLQfcsAtMeGYI6EIBgAd/F3Z9UGIZzPeOZAzu74OTG0=;
  b=KS7vUcX2O4UdW1Ilh97MJxTg1Pv6blfXbF5hvsRcF/2YKa0EmfePk83U
   ybXMVyaN3slBe4pkIwr60z6GGUX3giQiJVE1N2EIzbTwyYldeyGOTQ/JT
   xQXxlJxBxq8VdthR0/0D9HxUNDdejiszp5+zzLd7Peh3ootMwuBaKTUBk
   nbCdmuFTXoE4K2ayZK5frpzlDqU3GVN6AfkhDZRuXl0uQhgjVMu9Sxa6N
   le3yL28T0dNFrTCWkMlKh7L9EWyDhB0VNbpF8/9Srm5ovgnLh3imte3v9
   gA6rkHornRLM/Qtr/ei5AYWT8HhwWXAXCdUqeJbqtsUdZNKDsTl+KZ4Re
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293672658"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="293672658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 18:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747601079"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="747601079"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 18:39:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:39:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:39:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 18:39:26 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 18:39:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6T4A1v1590zr8M2YIMvwtZGDNhfLVYSl6b5qjf/TvtvVu67JYgTafNMJdKY3Zsdf9herR6VkVExpuYRb43XjdEkTNWO+PmodjQRRLFdDrVwF/35NX9iTCFCCbnFYyBLVO27DsH/TED90iXjjB1Hun0Q4XR3jHO2002rkR2X5TKTRYxVJ2WMW3jAln1411lrdSg3ckIGGYAplUdDUyUuIJr4pVl3M0BmfggQgmy87c7i4gVixVef8hXXWybZuo9fcQV1sSpRFTd5PnxxBM3mcAy2P12Y3mwBobmPn9i4eP2PxuBJBR5c3eYPxLW0bLkjy8Vo7Dwb5T12DdZ/nJMSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1koozkgQK0xvqXfrSoyUGiKNtBfBJPLghygQ9KJBs4=;
 b=AsjPJ1YOghbYuBRLimbdGhnbgGkClz/az9KSaPFE+znalbJ1scOccmjvNx8s/o/+wO0KPA1I3uzcqSXMQ8iOfcKPCGSKK7u4RGx5O1LZeIvXDIoa5BporWiBGP+e9ZksnSrZtFE5hoqFx4Ws1KJfxK5DF3QXsiuMzW1sbiAclxeXS9rPRmKeHSPuu1peECDGyd/UzwTeTsIMwBVPJGKHn0wcBLYH2TfqRp0UdeNKlyetGMgyAHHbFYicBTxPhFe+cpqSgYD3MYL/ZTkLvSXoeGo6pUCET6KptVzP30lFdkZKS3uyoLkLgxGo9qBAW1J4S+Dh/ELqQ+nc9iqu9uobZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:39:22 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:39:22 +0000
Date:   Wed, 23 Nov 2022 10:36:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y32HFE+BaATh9+l/@feng-clx>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a88736-a272-4180-d5dd-08daccfbedc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcAAxfs29NI2GmXDMdn6LXRDh74PZfH1E7J5TBgDhYaAl+hqe7dBSeVuiZIQBIWujl6IouLX4oXchUcW04CDskOda9imUrQKkg7jYUvFiP1RvmW/BEgfmNsfbBdWxNkeF1SO7Nn5mu61Db21gfRlpDruYwLdfD//LwAhOIOl43gD79Z2xA64xkUgqpLg/sO38kkHU097/vixNvCF5vYpHeLUzQwkGQ8kXvzgTfk1MgbG6RfArUfJiR9UoqQSe9NFPVsAYanTkDoQDMnT/QjUysfLL7TuX+YBk7gIms4S7tPL7hVdtWeciWSxChM8SsC6Cqd+OHHvVFB2Ws7M1ersj14vERk3sAw82hSp0VQ2leiqIOobYB1eHEX7yNXwYFbGl3cSQBVSGxhLGtioa5+8bYeG7uK8uU1PGLBHjvZd0O0kGL4KJ2R8rIEvxk1pwDoQhvfMXDigKKdTHe/xVCLvE8x7VUHfdXjkFo6IHow8tUvvncW5W9H7KS2c0V+KlVfSkrr+nskNAMBD4yhxTacNtWY5U+LycoulZVMgXsPNeE2JyuFQlcQUa1vMPYfYKfeNJybqLeDOIYSBIQJV2wF+cyb0KoUSUYrUmZ90qw34kjMk9uhThXKtkqKrbJlfc9UdKP4JGf2eXo3aUrAzwW0TiYrsGapt9/Tme+oMGKnVg3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(6486002)(478600001)(966005)(6506007)(33716001)(6666004)(26005)(38100700002)(6916009)(83380400001)(2906002)(316002)(6512007)(66556008)(8676002)(41300700001)(66476007)(4326008)(66946007)(86362001)(54906003)(44832011)(186003)(7416002)(82960400001)(9686003)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wnmjx1k1RLRzVIiPqvQF0kY88pThGlfTX4NtEIAFJrby8XDN8/atWMRKG1og?=
 =?us-ascii?Q?MtmJeZ/rLtiA1/hvThkOTmiffOysz/IIEj4hSl6mCDymelFxgZfBQIc/kl/3?=
 =?us-ascii?Q?6c3e1z4DIf//DN9k5C/jTSN7LX7HiqZOAmgwM3sGzbHSMdNT/C05oJkeGep5?=
 =?us-ascii?Q?v0yVEAN61uPOCvLNCKI6e7etEY6AhXkGG/NEMoCxpoT1CnWubNG02pgTdc0E?=
 =?us-ascii?Q?0UEFm0TAkOSfTxg3Zd4fIduthdF+tEUvEyRFzYlpM6TpQq5UUD52nuRqvAkW?=
 =?us-ascii?Q?aNbQ/01fSNaB+DX08mQLgrLJSzrwU/1Rj4nmEQ3cHzOIa53KLkd2agx1xZn6?=
 =?us-ascii?Q?P5viKiHPbGnjMAh6JviGiB7X5kU8s+YDxigl8i6i+s2xyLb/+I5PNTRbP+I8?=
 =?us-ascii?Q?gOlnUX0ilDHtKOgx8E39PYgocKvrY60Z1ucrjdafxlA9UVVe5hABiBRz4le7?=
 =?us-ascii?Q?5zSlvnpvvTk2oyxUxV2li16PSJv7ocr0OJGK/BPsMBgHox1PEf1SPKrCJFCL?=
 =?us-ascii?Q?h8S5eLzObtugoNv78+ipFPIwAzcFyUzINoJNkmR+8fs4sh4x0x1L8S/3Xzzk?=
 =?us-ascii?Q?kB4fngZf3ZapbD7ogDyRPwB53k/JTstKRKR+mF3TTzsaMbq9U2+CpxbvZGr2?=
 =?us-ascii?Q?TradSNpnXNgVDnPkrXGeOrTq85KxATyIK/+AVkuC9gozCyRcjh5hbR7o2ZK/?=
 =?us-ascii?Q?1eWJCOjuWpNZiphGj1dZSKuubdh91/Cs3FuH4id134ju5o66onBveYpn+v4m?=
 =?us-ascii?Q?B6orq+fyvnwep5Fkf71xDe+wKFuPbOLYrP+j+paaatNchM1H+Ryb9PCglK5a?=
 =?us-ascii?Q?Yy/W3oGy27hWKMDSWyUdDHuvNfgG6ZdHV85jKatfhKEFZDscExx+AbimhA2B?=
 =?us-ascii?Q?b8TFidlJOMnC5IBkPUn6OHrZvHtGZRDRKsy7YmIPl0OTOibxr8N/CgZdi2dj?=
 =?us-ascii?Q?wBjHkTyzZ8Y13NuCUw1wS3rbEBn6AN4umAylKIDw9hmH5ZFMHExRklEyK68s?=
 =?us-ascii?Q?KM6O2xP4w9yO1wppmAtjxwAXeZrDxTNng7QQe5rBfjvas40j2ABk7+zKcDXr?=
 =?us-ascii?Q?mJUN5RvF/EPiq2Y11khKaqyH97j0AztJD/oIFBdCbVgQapUPB70TPNwHxub7?=
 =?us-ascii?Q?HY7QAe2qs/jP+1DF1IarsI+84L2Uok2XYt/P8Bl10x2sx9S6TUYXgS/uAeWA?=
 =?us-ascii?Q?iY5U8M0zjlloR13suX0NA5mby5GOATc2/0sGpAdl3lTe78WEvP8hONrlPYez?=
 =?us-ascii?Q?o+YcXfN6vs+OIk3qmvgV/ltVfSjj+NhFStx8qs+WgiRc12oKU+27bvpmpC5d?=
 =?us-ascii?Q?ykeIM5SARRgQInyMOFP4QXnUK4ordbUVFYBc217NiGIXSuH/t1axCY+LZIjg?=
 =?us-ascii?Q?lHZpueW1FK1TtN4RjcPqvmQLJSlO73vFXhgLEWoj4CEGjARrJZYoGjpPF/0s?=
 =?us-ascii?Q?jX/8n7tHl/iUH1+tGEfWV6jlJSztw90YPtYFV5J+RivV0rZP36iOt6tGs8+u?=
 =?us-ascii?Q?0yr+PBLrAAz4cWMlBCcytNg8UyUYYLd3dA/OAT1CCzZ7EHt3DQD1glKO46ky?=
 =?us-ascii?Q?dAs7kjxVy7orOsg8DotAlS+egHbyj5LoLKP5P8dS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a88736-a272-4180-d5dd-08daccfbedc5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 02:39:22.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7X/KdG8Trs+3gy+by+I3xrQTyV7QV0MVuTsxQYUxD7ku66A19yTQ5OeHblYGiKoWA8r7xQ1oFNLdPtV0K6+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:07:12PM -0800, Paul E. McKenney wrote:
[...] 
> > > If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> > > refined-jiffies.  Or am I misinterpreting the output and/or code?
> > 
> > It's about timing. On a typical server platform, the clocksources
> > init order could be:
> >   refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 
> > 
> > >From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
> > initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
> > the tsc.
> > 
> > > Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> > > clocksource_hpet.flags?
> > 
> > Maybe try below patch, which will skip watchdog for 'tsc-early',
> > while giving 'acpi_pm' timer a chance to watchdog 'tsc'.
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..9840f0131764 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
> >  	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
> >  	.read			= read_tsc,
> >  	.mask			= CLOCKSOURCE_MASK(64),
> > -	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> > -				  CLOCK_SOURCE_MUST_VERIFY,
> > +	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
> >  	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
> >  	.enable			= tsc_cs_enable,
> >  	.resume			= tsc_resume,
> 
> Your mainline patch b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
> for TSC on qualified platorms") mitigates the issue so we are good for
> the immediate future, at least assuming reliable TSC.
> 
> But it also disables checking against HPET, hence my question about
> marking clocksource_hpet.flags with CLOCK_SOURCE_MUST_VERIFY at boot time
> on systems whose CPUs have constant_tsc, nonstop_tsc, and tsc_adjust.

IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
report that the 500ms watchdog timer had big impact on some parallel
workload on big servers, that was another factor for us to seek
stopping the timer.

Is this about the concern of possible TSC frequency calibration
issue, as the 40 ms per second drift between HPET and TSC? With 
b50db7095fe0 backported, we also have another patch to force TSC
calibration for those platforms which get the TSC freq directly
from CPUID or MSR and don't have such info in dmesg:
 "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 

https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/

We did met tsc calibration issue due to some firmware issue, and
this can help to catch it. You can try it if you think it's relevant.

Thanks,
Feng

> Would that make sense?
> 
> 							Thanx, Paul
> 
> > > I am sending the full console output off-list.  Hey, you asked for it!  ;-)
> > 
> > Thanks for sharing!
> > 
> > Thanks,
> > Feng
> > 
> > > 
> > > 							Thanx, Paul
