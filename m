Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157A6869DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBAPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBAPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:16:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1529B1CAEB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675264561; x=1706800561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UltNNIdBWBlomIeMYVP1ug1ZNLDmTakOIKdxIn/csd0=;
  b=DdF3HcHytu4GTbEQG3VGDewoXzp5/1pLv11W8tjbyhCdMI1U6VdQw55L
   GTtCpEqGZ74Fj6YkWs+4yN/jxmUMao9nqyO41tTcNHdNCq+YbEoNVMG1B
   BvevySTEoTplfT/FcUU4nIkx4NAivsil+GaYkoC/6dbzvA1lxajpgI9SR
   f0dW3YDcfUKLdUZ2j+cGwgptqkD+X7QlDc29+mufAEIk6uOs23yzIOrL2
   TXtN6c2WJIUlhYZojmbOxb6od3pOyP9IfdFQIr3aNex0AZSpnNfM3RD/1
   FKhYwTtBhJKDHZZlwUOJ3v7+ndoRbjYYfSjJtQnUXE9DWiEg7jAcftVnv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326823468"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="326823468"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 07:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="664902564"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="664902564"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 07:15:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:15:33 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:15:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 07:15:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 07:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkybBbPwoz5HJZA3TT4bAl59fX6xJYG8rOpXQIT/cOK0YWbVhT3LWeJ+pN9wmMHzxtEoKz3an6FzdxHyAW1FqBoFR9tJSGSlZSS+CyLh9BKlwM+lGPQRepzfWzoj14lAtgRa66jN56WI6Seo1N1mKP1uHnaOVUlMKFqtGUIcfDCF9IpHAg6mInU73oVvufQruPeT5R7bq+RR8ehPaiVG+urC2lruTUNBveP4oprm2SWgwNMxfy4aMBUV3azkZRRQDbrRBJgTrXgol5nsQTK0X7EHuSa5UhHoM/C8dvt/NocOJfeIwdFDBpJ2feb9wAzq1mro/4hk+o0DOUr1uF7Bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLfw5IyejfX9WaDMpnYOFjAS3hR2Ut+d65f8HZ4Amc8=;
 b=Xk15SCVIg43HtLYYPy2snxJedFz/cmlvq8lo4fmQpCPuEUpPF0jW3+CkNsn0rAYVoFhxeJ7dE5uz5HrMsVD7Y73ujlk4T1Yxj80bCZxVtZEeaAa5bbBdhWoC7w8guX6wYIXza3JLmvzKgNKrSDCgR/J9GFGOyBkQl9Sh38e5avUmKq1GH5Cn/CJWBYXzbH1n8V26rCnOtMW6emUWvfiCZEGiE73rec5FOho2Hqhy2REhhhCr0th7IFMp8hH8zG8F2t9oWb7zVZ60NL6N1Tu1DIwG9yXjisKlOTic7TdxHMmc/WYqtTB+HAtLFdvwTHTwPPIs0h88K/Dx5YAxghhk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 15:15:30 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:15:30 +0000
Date:   Wed, 1 Feb 2023 23:10:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>, <x86@kernel.org>
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Message-ID: <Y9qA81mcxeaHYxJX@feng-clx>
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
 <87wn51znsh.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wn51znsh.ffs@tglx>
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e99629f-5789-4861-a061-08db0467281c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmSSUDVrEi+be2wM3dLno9UFJ3D0XZxLkI4W+STMDtkFae/1t0aIyzr1FqutVrNMjtywyj4dUdeupgCgr/3MenMnYUE66c9lIxCP+35q7JVPTtchMdy3tejz9/dyDXAF5emQC+xOyDqlmd1+B+4aqtGINPBxkXMbm/3504C70b2ViIb2IT8iQVAlaw56a+t1QcJNKd73EiHZlXP5RYM4zHT1ZHy88Zsr38Kl3fmXmtvA0+Y6n/fLPZg5v6YwMMsIczc73T4WWsbLWtzZJSIJLQ0OpjLVwczfuvOVzvH0lLLvXi1jhuv8EGi2+7HUxnaw9EpERVL3vCkJjsOfRbIW+JBgPfYBqspHAkzyLn4TGKOJpBW6gud/dq3Rj1pbzVYsyu8EvFh7KSVU/iCT7JGmHqsoJP62zfKFgkAlsIPyUkqGWMpM1Q8ha/WsNxZm07h5u+YQGr2i1V42Dv2ypDczgjUieC01Drv7cHIPrUn83gKpFhex0oFB1xnP5Ab5q0T15+Pf/tnUxc7wqOjDdgpCS+ppuzt8Bjm8OaSuhxHWF7qX6CWDPDecG+5ZB9mwwT0Vh0ltljjUrbk7MMu+KBCc1iFKkubwuTXQWG9aXiqlacPFiKrFo1ktzQhnVzpi2CaYLENUeZ/sedfn19oVpC6pM05aHPzx61qNlmBoPeLkPFY6vUI7zXXtiyBbPSz+zNxf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(44832011)(6486002)(83380400001)(86362001)(38100700002)(33716001)(82960400001)(2906002)(26005)(6512007)(6506007)(15650500001)(186003)(9686003)(478600001)(6666004)(66476007)(8936002)(8676002)(66556008)(4326008)(7416002)(41300700001)(6916009)(966005)(54906003)(66946007)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3Reco604SAaXfJfLgR5XrJiLKgbZt9le7d4BKBCGCp3XQVEjlY+hJLK5eEs?=
 =?us-ascii?Q?r5/KMdYun+C2ztBokKlKvZn4EZ0PgbLmxoyEBgeazfdYYVpwQDU5cIAMcF/h?=
 =?us-ascii?Q?P1w2/GYY1aOtaMsQFovbDEtWkH/zevh9ih1Kz2i2fElyvcbRg7JUYfn7z1Ie?=
 =?us-ascii?Q?qRbFSKgnPKWtFdyExXI+sXnYLdaNcvBmpsJiIPGvDkbSRK0A78D4hg0Nldp3?=
 =?us-ascii?Q?OMa8gi1WIDn/gj7EvRWA6JoAGf9ugUP8x1c2fKoihYh3LLxfLRCBgIj9AQOx?=
 =?us-ascii?Q?xmSW2plP0+bRem/Z0F60SdidVCQG3y9ON5jSt+6o47+Ogw8CY5/hoSAWpg9u?=
 =?us-ascii?Q?g+iONVyWcfL4P2Kc2QztKZW6jTnG73c2l5DmjurltXGRr2EI+XYkt3FszvSe?=
 =?us-ascii?Q?y+cs/HnX4bZPdIXBbItRFyXRoKh5JgayOEEecg/Bnuids+PNx9hkPzxPTm1A?=
 =?us-ascii?Q?uXbupMppSD+sHBH7ErFbfG/7Lf00z7/wlriXclZgEWbiVmfbZPLrTlph501d?=
 =?us-ascii?Q?hO2yTIN+Vmu2LdPoTGUYDN6YOHwDsov6Yq+9edyLdy/xSXEMo+WyUZAgTJLM?=
 =?us-ascii?Q?mytZzUXm+o/6BODqLXjLjlAxKA+h+OCJWJOCRp3Ilmul2GLifD6R/4i/WwAT?=
 =?us-ascii?Q?nG0H0Amu3bAC1kmSwV4ZVPKzePjuJ9KbB/uvM5YxtC6mQYT3+L3rzZc226v1?=
 =?us-ascii?Q?Fy1jXZq/3h7xGArbKKGyM75PuD3klSAVQE1FVPdx6VEsgsCxYAfEteXhb5qC?=
 =?us-ascii?Q?SJaImvHJPydR1kCZpR3vIRi6cvlc+jsWDgbpa/zompUXy+3ftYyYn9pO7OT5?=
 =?us-ascii?Q?evIhf11egF1QyOMqiWx331ytAOSwwzkwYfv0ny6IlOdmxaezHq4V/kHoxquj?=
 =?us-ascii?Q?AOnKFJ/3R+N1+fPjuKrosBtaroOLRU5LzHd3bhUlwiTPy0TK6hq9+9q6R2VY?=
 =?us-ascii?Q?3E3rsjAPBn+MQWFmyjOnz/T4LRJYyr8t6PqUOUsNQESUL68BJtsGQvJPx//I?=
 =?us-ascii?Q?6I2qAun0TIceoYAI4a7KtjT5dfdjO/RwvbTCGJuTfZQiyBd3V2Rpv2zdNAvC?=
 =?us-ascii?Q?gbEMbN1jFfyIkfu8YJdRF//LKKTLk+L7S56zV5LoS9A+T7zj8rvPW26yKddj?=
 =?us-ascii?Q?ZYifEV5XgKpTh9j7W6qwljdSEhT0qXdH3lAvk6Mb6RUJVRK76a5Dm/HlksF4?=
 =?us-ascii?Q?9QHoOXrZVW14hx2RA1mECErauktLLHL3LtpVj2ZrE/2T/VT7PcC4X+VIa/0I?=
 =?us-ascii?Q?bZrwVEUYiX65ZrpiOlYEdHfEMUqiwYTM6GsIjt0tldxc1bo1COAr97M2PJkl?=
 =?us-ascii?Q?TJo+nRZpMM7vkqyBa5WZbEGt5PFU5Rx1acRM6KPVZO+XlmmtC+xxR+m5TFOY?=
 =?us-ascii?Q?QxdQ7zYfEax2BYDVJLT27mlZ5sXJkislTOFwUWjF7tzr139cXKlpIIETizDH?=
 =?us-ascii?Q?b9PYAsDJC2zbVa4dFCppTk64d5AYsISO/bv3InbnIEhlPAKDU0wGzIQWb/qy?=
 =?us-ascii?Q?eYpKu1Ry4arg6JZpyttZZkPdgS3xh0udjrJXYnV5bK0lY97t64089kq3qPtf?=
 =?us-ascii?Q?C8SK0aHKrXwP99iu+zL2TiR3LJF1i7PelF0qGSH7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99629f-5789-4861-a061-08db0467281c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:15:30.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiA9svP/fTS7vYzSoRJvXOOca4vBL77GRgrV52eTmnIbS9lbEkoC2lVKWPnQ7WhcHwTrtXc2so1zUTII3W3N1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Feb 01, 2023 at 11:24:14AM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
> > On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > TSC is disabled.  This works well much of the time, but there is the
> > occasional production-level system that meets all of these criteria, but
> > which still has a TSC that skews significantly from atomic-clock time.
> > This is usually attributed to a firmware or hardware fault.  Yes, the
> > various NTP daemons do express their opinions of userspace-to-atomic-clock
> > time skew, but they put them in various places, depending on the daemon
> > and distro in question.  It would therefore be good for the kernel to
> > have some clue that there is a problem.
> >
> > The old behavior of marking the TSC unstable is a non-starter because a
> > great many workloads simply cannot tolerate the overheads and latencies
> > of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > sometimes can tolerate significant kernel-space time skew as long as
> > the userspace time sources are within epsilon of atomic-clock time.
> >
> > Therefore, when watchdog verification of TSC is disabled, enable it for
> > HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > time-skew diagnostic without degrading the system's performance.
> 
> I'm more than unhappy about this. We finally have a point where the TSC
> watchdog overhead can go away without adding TSC=reliable to the kernel
> commandline.
> 
> Now you add an unconditionally enforce the watchdog again in a way which
> even cannot be disabled on the kernel command line.

Yes, this is a valid concern. Waiman, Paul and I discussed this and
had some proposal to handle this side effect, like only watchdoging 
HPET/ACPI-PM timer for a short period of time in this case.
https://lore.kernel.org/lkml/20221227183819.GI4001@paulmck-ThinkPad-P17-Gen-1/
My bad that I didn't follow up as my proposed code looked ugly as
bringing more complexsities. Does the idea of setting a watchdog
time limit sound fine to you?  

Thanks,
Feng

> Patently bad idea, no cookies for you!
> 
> Thanks,
> 
>         tglx
