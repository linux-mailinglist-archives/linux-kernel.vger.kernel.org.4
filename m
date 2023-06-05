Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC0721E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFEGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFEGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:35:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E7DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685946955; x=1717482955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GkqlMVqa0DXv7XFtOf0E61N2nYlqrzSgIocakWBEZqI=;
  b=J8kESphCgD9n3IhlhPHrDvAivZD895rb37YBNJE4/VWrr9PBMJu3BeK8
   NSBIDCC78isU7vWGl9UYvbAFfLVVJvam2zn1wZOOQtFpuPbg6TDadiImh
   SO3SHiUGM7r48ihH57g0JE3jWmS4v513t4Z87oYSLBgTzFKjEOk5TSVYa
   +KTz3XPWRuvCO8Dz2dYs9HGWDAJUuORP/Z2DZxoz+IRuVsjmchtvPXtgA
   wNsG1QMYC2pNrBfeVlBXE30iyIpV9GZtJoGnhJXuAQuaKxO+jMJLLyrqV
   DUMpScK09cNb14uxRaESuhjHS0/XlYSYxgAI15NpDcFuS+9BOxIv9T5Lr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="355150250"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355150250"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 23:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="741591189"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741591189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2023 23:35:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 23:35:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 23:35:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 23:35:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 23:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDoDPEYforYgZpszzvCtAE2MSZScnwdMKHaakw02tCjfO1hmIK4TqcYq7AMftgpIgqdCxiCNx8Ddo1/FVe/qZXyX6U1D7W9/6wr1B4AQv3Cp/FAZkjxART7wOIz4OulkY+tRAKdpTPd+qLFN3cfZ6scbqBQ+sNdlKYNx4+dceTBMbCgjp4niMUArMEMZLQaPgmuEeAL0tDQoFagJlA+aj+Bq6p2+FpYq5Mohbvr3st1VAhgzIEOLB8+fYiE4kZZq1KmlDySDVdReqa5jT2C58hA1tQiNN9yMWAodVQjDZMEsbnBBEUuSf6Cw00YfItIc5yZGB8BqqJboSVGj3D24Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcUtRX3MaUqn8YpoxKMH35VPBXElprMltWBT1HH7NpY=;
 b=WJaduJZ3sSmNndS2Z2R0exZkQLUKP0laXe/ArwKdaGFDXtR+v3whC9D6jI1HWU8oUv4aadgpkvgs3CFfxdxe0lszUTEB1x9YJx4AR7HDhC3W4w/EIMPDGBluO0nBvZnhlEv46zoM8v3gNzSYER7/yN+AoJ20P2JsmIEHHy0VgOAo9NCZoa5KrwD/mauC/xW8H9LZm5ck6uV6DH+EFJSvlA+buvbV+WiFOIM8XeXQBzYBSwxX5vQWWc198vj4HxaVIrVflw3aJquXjVK8EMTs6mi1dRH1Vpee8khiSqYYeH3LB1anArynVXR6KcuZSAtuPGRMf9ysP+qVzEOMiPNmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 06:35:51 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 06:35:51 +0000
Date:   Mon, 5 Jun 2023 14:28:35 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>
Subject: Re: [PATCH v1 2/2] x86/tsc: Extend watchdog check exemption to
 4-Sockets platform
Message-ID: <ZH2Ak28tT3tVlWOD@feng-clx>
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <20221021062131.1826810-2-feng.tang@intel.com>
 <06df410c-2177-4671-832f-339cff05b1d9@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06df410c-2177-4671-832f-339cff05b1d9@paulmck-laptop>
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: ff347f64-a4c7-4f8f-b419-08db658f1a95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcSryCxCPb/xo1EAQJCLcvIYv1KWSbuhF9fM/mwK27jemB7w3Ci2ppoeVMOvNjHMmkslvfQoHR1S8LJU8v1Ei5s/FNY+TepkRxB3knIgyND9GG5SvD2205cSFy+omhCS9mgl44zlkEnd+EKD5KkA13Yk+058b1ZXyRlSi9E9aA+y81HlbMmDkSmQrGiOAbpuL2d81x/lilHTZvrcKuylGzKdfv8DbW6DH3mFls+7F4hfB8Ua8qAKxqqr5JX7D9/lgzr4baYtZUL/eaA3Akw12zSYkTFCrZu0ORXGxGfso2bpMZT6/tTWP2eqqNvVabD3AX7oip7QxvTZQ1VGrIE2+GkJpvgcz2RaSJle9prqlGRFECKW+l1Og4sC36GK51k+P+4Y80HkuIpPnSq/mmZHEeY1i6UuYCKeaTIeVGuXHIV9HNA3bRhUs28fhSyizhIiX+fAaSaE51rTsBTM2iXwRV0Asvpvr+qAkq/uAm0cwJRZCZmGP0Ug8vH5RUbQNnYOAzd7c/Mhb5EZN2qfS6J5UDMs77NJ6DAmqMuPx7IFVVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(83380400001)(54906003)(4326008)(6916009)(966005)(38100700002)(66556008)(66946007)(66476007)(6666004)(6486002)(478600001)(82960400001)(186003)(2906002)(33716001)(8936002)(8676002)(41300700001)(316002)(5660300002)(86362001)(7416002)(44832011)(66899021)(26005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRbhxGQTOHnTRQJ7y6GtUDzpozzFWRrsasUCPNFsndMeMIGgssfUJYDjPKPB?=
 =?us-ascii?Q?tVxNr1/b3TahXwsyD2Q3LJdaZ8I8pUqxX41ueGeGjvDxuMisP7eHaG/ro9a4?=
 =?us-ascii?Q?cIbO7ezF7WGof9g6t490ddnV3qWBudZ6UgNdjoWXO9cvdj9sKSG6LlrytCQU?=
 =?us-ascii?Q?GNgqjzP5iO2vyXiyWEXyhH3y5/dTxMMhUo/qgrHZvBeNquxQOwUFGDgveEgX?=
 =?us-ascii?Q?07dOLdkODu6MfihmkRXJvtwRiMbhSKQn6LGIvxyifNtfeCwS82z8tmm0J+2T?=
 =?us-ascii?Q?bXHB/yQng/JldRTrVKy0s/KNFtuos7ylFc0nZL5lq8HMrqzyBjdvl4qLljhZ?=
 =?us-ascii?Q?dB2KHjxHxeXdoN29C8xWY9I4tvjkA3kJ80QKruHOCbejMgQ2zPxi2DsofIjn?=
 =?us-ascii?Q?fhBfOJ7yGINMlUwzmC/yPfumtU++nmdZQkx+nuQiXThvDvUMdZaR1wJZF9bh?=
 =?us-ascii?Q?wgJXvUi1I20sCkR6Th/kgQv+QAV0ia6hIwUdAQJLdpPsOOSKMvT4x8mogYzt?=
 =?us-ascii?Q?1JpspGCLshfUpHv8seUv40SPi3Jp/GTqrkUTusdRfgjbyASBrhWY9zolMs40?=
 =?us-ascii?Q?9h2OjSwhkqNCaAGtrksHYN2PnhH5slYWXXtp0hs42kU/Stji2UFOx6r47CA0?=
 =?us-ascii?Q?EEA9Tp+XiiK7ouLB/Drk5V6AkAegGxJC2u2AtI/y4A25w1s54K4/PQIZFhQP?=
 =?us-ascii?Q?y3IFfj4D3tNnL71Le0VSOuOYGSpyj73hJlOevmlsjdp2nY8rhjMVmcugf76H?=
 =?us-ascii?Q?SGF8LJdqvftK+1UVbsAdbZo/NTkRsm5fcipVsdJZd0raKQQ2U2XJzsU/m6pS?=
 =?us-ascii?Q?A2PSLnxPAqn09Ozq2ZUUWUYmZvGJHHaawUZ+e/niZXWKZJgFf7eeGc7HR6Db?=
 =?us-ascii?Q?OO6i6ZKP8bJcuMr4Cb3FhMWa2Rh0EejpITKuDK/6QiJfu9Fa+peqSKt3+I7b?=
 =?us-ascii?Q?IOSilKF5JDiWrrq7V+UEJXwC5cNaUs4ZK2S9YrcIJHhlV05mykO8UZBRiBiB?=
 =?us-ascii?Q?SBkk8iqYLz/lEZfgq9hVSuM9Hb8HC5HONjH3yx4gxaqzJHaaMJKsgoI/6Jy7?=
 =?us-ascii?Q?LWVAIRgwaJr74XdwB0VMNiOMJ640VYpw+xGQOeEADRFyPApFIODoeXS7Q+hj?=
 =?us-ascii?Q?DKHskKXG7O0RJgXv4FWUcGEhpeRzXtrsUhxrZjKnJL/Vm0lQ1s5+txgs7Mzd?=
 =?us-ascii?Q?eGudwc5WcHPv1ugkAdNNoTIYLEfPPXOEqQCxRexY+IR9rP4qcITJwuS4hh8+?=
 =?us-ascii?Q?T/X8jVapnH8VReIUdgUjpyK7zA81zQnuE9BFFj2yU5eCMNewuVwcuornNgw2?=
 =?us-ascii?Q?/iRqE4oUFHqU8NpoNu9HRLdbAK/lVyyl0wLWVXHHTd2ZpcrMP1lj884+5dZo?=
 =?us-ascii?Q?3Is0DyFYjpm3qDJu5b5RhTZKtbiTpVqcv/MuslLIQY5bnnTV1/+cOWoLHSW6?=
 =?us-ascii?Q?i0/HOgrOvpfo35gJ/8JJjvQFrO83YzfDNXNfjLPOm78BBaJA/GupTyh2VJBs?=
 =?us-ascii?Q?0+WkrqdG/473A79byFODxY6hm7Y8fkR+zYJzEFxzton+JwgIpJnHZzxCWfaZ?=
 =?us-ascii?Q?6zZ9vqSzRGssjjQEGwZ3lIA7pYO2yorvZ/QQdAeK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff347f64-a4c7-4f8f-b419-08db658f1a95
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:35:50.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxYzD5alZA/J83eMHgLbjbrxcGTj40fMaWNdHR6SPTxYHhAFcPtqyJBvtPw7pBSOIUJzp5XKhnNu+ZnQvgTYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:00:55AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 21, 2022 at 02:21:31PM +0800, Feng Tang wrote:
> > There is report again that the tsc clocksource on a 4 sockets x86
> > Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> > and disabled [1].
> > 
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduce to deal with these false
> > alarms of tsc unstable issues, covering qualified platforms for 2
> > sockets or smaller ones.
> > 
> > Extend the exemption to 4 sockets to fix the issue.
> > 
> > We also got similar reports on 8 sockets platform from internal test,
> > but as Peter pointed out, there was tsc sync issues for 8-sockets
> > platform, and it'd better be handled architecture by architecture,
> > instead of directly changing the threshold to 8 here.
> > 
> > Rui also proposed another way to disable 'jiffies' as clocksource
> > watchdog [2], which can also solve this specific problem in an
> > architecture independent way, with one limitation that there are
> > also some tsc false alarms which were reported by other hardware
> > watchdogs like HPET/PMTIMER, while 'jiffies' watchdog is mostly
> > used in kernel boot phase.
> > 
> > [1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
> > [2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
> > 
> > Reported-by: Yu Liao <liaoyu15@huawei.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> We have a number of four-socket systems whose TSCs seem to be reliable.
> We do see issues where high memory load forces the TSC to be marked
> unstable, but that is because those systems are using an older kernel.

Thanks for sharing the info.

> 
> If the TSCs do start to misbehave, I will of course let you all know.

That will be very helpful! I don't have much access to 4 socket machines.

> But in the meantime:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> The previous patch that changes the definition of "socket" I have no
> opinion on.  I must let you guys work that out.  However, I do note that
> this patch can be rebased so as to no longer depend on that patch.

During previous discussion, Thomas and Peter mentioned they only
saw real TSC synchronization issue on some old generation 8
socket/package machine.

I can separate this and send out for review. Meanwhile I'll rework
on the 1/2 patch and test more.

Thanks,
Feng

> 						Thanx, Paul
> 
> > ---
> >  arch/x86/kernel/tsc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 178448ef00c7..356f06287034 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1400,7 +1400,7 @@ static int __init init_tsc_clocksource(void)
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    logical_packages <= 2)
> > +	    logical_packages <= 4)
> >  		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> >  
> >  	/*
> > -- 
> > 2.34.1
> > 
