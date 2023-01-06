Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB965F9A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjAFCtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAFCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:49:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABF65AEB;
        Thu,  5 Jan 2023 18:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672973342; x=1704509342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ag5mEw8LQXlLZCZe4er9Jn9amm9ELE2GjjNYcm8mu5k=;
  b=dpZdzKvmG2yV0KDIA92UFuXlOUKV4dOStJjwV0pl9skstnlM40d8NVEQ
   UeBJ4jlDg31hbYRjfx7X4XEVk0EgIFoIBIa0DMof9GQlaFRRwF3mQvQau
   7phXuejw1FJKDuea5ZmQQaq3WfmhAoO29ufDrpJ82v9KHTBe1O3VjP5zG
   St32m2Rt6zyWtOJNo4oSMxDb6zxvyBZkpwihXkg7leWiHSQf7JAhk/3cA
   Htp7VcbNTRn/G/gybsvzSiW6xdind5FvIry/+6O1p3pGdnXTpi5wzAeRQ
   uzIeEyu7qJFNgaRkGA+zkPm7Mt6+LAVgjRy8VlntPASHk7bNsQVZdTRxV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="386836300"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="386836300"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 18:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984531457"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="984531457"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2023 18:49:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:49:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:48:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 18:48:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 18:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5zjnmTMx95UC8IgR6Sqpv0AlZ7+oFEzX9gPzJN2TUi4nyBvl/RxxhpHdWqcLhefue01upCFnwYHkuyiS2stFw6MjO4ZE1chSHMk+uuIMaJo1wy66Q+7Z75/i6/UpfvNGqxpKzSGkz1cqG7YAjx7moL29qjUNz8v1pzIciPab/MerVZSjsVTje/ocbCAsfPZq1BnhiB+71GbAumt05tjGn/UKL7tzkV93vbeskyL/5fvTPzho8QnAWzzTNlxXQfB5WBIsnwQ2JUyX5WfxLeOOBskHiyL4JOlzmQTaWQvMrrSuXOgX5sA1Hx0yaUYG84JX1CAEFKzpwYWu8Nt5RADHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dYzFRkbErG965NCoPqYFfJwHuudrvlqpaTysuM1Kfg=;
 b=a+UUBXX2tLYPsfTTwFeKnrnjJ4Dl6qTOwwmMjnTvjJoAei8cA810B3+CRJDLnCToXC65lazS+vPl4h2Di9NJ0UgpcoUox2axExKcEHahWqBEEWMMsCow9njmWq57qjmRESS+FECx42MJ40twIqJowUuUc0kfc5fAXCruGTeTDebd6S55AcxlArdEMzv4+KKnLdbkVq99gueUyUxVPMf3K4n41GatZ2tvEL9E2MoliXms7sAYrXj3cHvj+wdvXWhBHPdw+cxKCgti5Msgn+d3Ws7tl5OrnkX7W95JwcBzYiC+M70i4df2mjDxbzNzkCBEh53rSenm9dED4h+4K4ZbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:48:57 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:48:57 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Liu, Yujie" <yujie.liu@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a50ePYAgAAL4hCABFctgIAA5ZxAgBaZgACAAIwEcA==
Date:   Fri, 6 Jan 2023 02:48:56 +0000
Message-ID: <PH0PR11MB5880273B1F5A6FF2CB782051DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588092AB6A014F30420D697CDAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230105182220.GF4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230105182220.GF4028633@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7994:EE_
x-ms-office365-filtering-correlation-id: 1295df47-1f8e-4e6d-b7e6-08daef908e6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKlWnWKAUcItyOmUjvqi6rtJewgdi8syfhcTjMdKQUWxn4k94u2XaUAIx/h+pi1qMLbpTGGcgQAReeiXWzxEAE58cfv5EZv3ZTqDzf0IPCGu2JhbE6cm8efaS46ywFm8+vHnbtnKRkkfoqErDZK2FdOHh2foGY2i+80OluKzlqYkqbhhsKbuKfk/qlYJ4y6Xz5wZ44ZbESPgszDSFUhPHmqdI8VzUVbiy945E2HnCkvR5RA0Om2WNsCk41r6LnjJFQR1l9pWO+inGEPJbwgSdpCB5Jxyi+4F5mo72vPIzPFxO6f9P9PEh+tHvU4eAVpECxHRgdP/9W8H3dEo3ltwKe2XcQceVwvbUq/AaBo5E16gECcoMaE4Uog3IrVzU2lSi/sesd4SSMmNOB4O9lQSo1DRb/WyvCOYntFcJJeTlr82Ao1Dh3GSiD0hYkE3MP8qr38haPzOiMIuZLenDL5IBsROgnN55DnmZ6T1DPUJ8y92+vOvEsa0s9ynp+95GAQoIDfU8l9RRT7koXQIxtQVJ34tKE5ROL1UvYLHotQVfx7rQTSjVZDlnorRjB2XxhaLlo6yvCife2njLT0LbDdeX8TXCXRmJ06JL3xvF2EDF2VH1aYE7WlciwBrAiSxlALa/AQteJFRw0TYznlZgLMV2f/MCVa0GERVFXmixuq2R2vPJTudXFulT/ANDBVV+A+CTs4yjfTRhZHHfZFM1kcpGnwSii/bJwtu8kKR77ylECTtAc+44B3qu/Of1hn7nwh/m3ymeUqdcAlPoRhpiAC1Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(83380400001)(41300700001)(86362001)(5660300002)(122000001)(82960400001)(2906002)(38100700002)(52536014)(30864003)(8936002)(6506007)(66476007)(4326008)(7696005)(316002)(186003)(8676002)(66446008)(64756008)(9686003)(26005)(478600001)(55016003)(71200400001)(966005)(66556008)(45080400002)(54906003)(6916009)(38070700005)(66946007)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2B6n6jCyjGBz16lDzvLaY0p3aWm52v+pwUW/YoqRD+Pa6Gwuq0yRwAXZuufO?=
 =?us-ascii?Q?Hi+rtiLvMShAg/mm3Up7hq+ke4dmeGpsA/4581ZYxMI28EccykdADrt/f9nL?=
 =?us-ascii?Q?BAAcBtf9U17DaUsUCMgeXB0t8HBtuUZpF9iMBGQAGF124UeHs1V6XP85dQf+?=
 =?us-ascii?Q?Dgkdjwaml3LRML1zNItibOCTfzRvYk9rpGO0ZN/ugtBTd1/iGvQXePC8vfD0?=
 =?us-ascii?Q?baCCm2ZiUPfMd8d8T21CTZjqtqFd8gbvnIRnvj4kzDLXXFZzdqhuRqV3Dsk7?=
 =?us-ascii?Q?zAOfB9NKS5g1+a+EuXPo/A/VcWNovQbZPM72EudXCY7swnmGrNRwM+u4p1om?=
 =?us-ascii?Q?FyrqThmERT5r4zab2EGEhowR4Q6KY5gv4JSxAs0jrGA+N7lM2nCB+GAHyMK4?=
 =?us-ascii?Q?e+4Zs+RZgguQdr57qg0R8XwidungwCT3o28Uc1aCSF3zWiJbbz2/3UK84r+n?=
 =?us-ascii?Q?LLXJk1N+Fe4Ws0DQwu/53muR5kliIOqK1W0E7tBcFH3336pMUiZqFersdRPz?=
 =?us-ascii?Q?JWUT45rN/xtK8JY7BXF7ONejyM+gw0JL6OJ6QrbDvVsSxpFklJ+CHL/4mAzy?=
 =?us-ascii?Q?TJPPoplmWSL3aZuivFtMbv075E4fyGweMY3adryEk14wlMQIjlXtmCoMJpYk?=
 =?us-ascii?Q?CdNh4DgFPvXKZQhKnXHg8Eb68TBbSQRDj0rJRFcfR3lGKIj4c0as2FpKL4Fh?=
 =?us-ascii?Q?3PFqClA6e5tTGk3VqpBhPPl8Tm0mOmxLvOXA0biZkdAB/MBKvS6CRbA+E0Gg?=
 =?us-ascii?Q?LCwATRTuj3LoU48vDTr+TlpfNFw/WP11gqXTvZMQQHMLgVryP3P4L8OD11oz?=
 =?us-ascii?Q?peZ5fA12c2JOKiU3cbTWF3uXtXCNS0ibabnJAI7Prpyjsj05orrDBd9ap/nH?=
 =?us-ascii?Q?e35BYTbrTsCsCNs0kwaOZx6WXuULTM3aIUvW71cWSDJGAyRYXfpbyNUXmGya?=
 =?us-ascii?Q?mJMthvLmJOIX41a+4yb4B650MFQz+3a+6kuUF9P3c+awdP87QgCUlDP9Y5GB?=
 =?us-ascii?Q?3iUbcnvLSD6Coryhf3eoZ7n6SSrbNvkk+UvfKC7NZD5L6ckMETfCeQWuB5ph?=
 =?us-ascii?Q?hkcjeWLhxnhk1nrDryPDLja2EwNtZmqWtbUxWnEiegLIECIXBZ4r+zNW78WG?=
 =?us-ascii?Q?00OGat6T2zVLJSvoz3TFbORtUPiMbl9juOIJGKiEaQIiVuH1xXaoW2Mcqgdl?=
 =?us-ascii?Q?jyn6iUlA+c34FRRAjMvtuRUjiJ9f37KgMvOhSZtLgdKCuGmiTAenpjGoiuG2?=
 =?us-ascii?Q?KY6uZgUife7N6ARaUp1MCCoexhUqQUyAfz722xM8gw38HGxRQoyiN0YZR1Qn?=
 =?us-ascii?Q?lPtO09hixymASC8bzu24O4cOhYyZJHrN2reWLBEd+LOk3qbsXmkhtmzzBMx6?=
 =?us-ascii?Q?EZBWkp8WDKU1bldavUNVQ6OAsckCeDUWR8yj8WCwY0aCmqD76pLnd2QLFtk0?=
 =?us-ascii?Q?GkRN2ggjf4MMTvQrYyy+sv+cMpt4DN4xhAxB1Wxn4sjWdnVDTxIM1CJVvbw4?=
 =?us-ascii?Q?Wt+15LzrRhVLQdA8wjexk7+eEAZUfDRO8ldJNWK4tCG0yrWi4HFk0JfTcA7n?=
 =?us-ascii?Q?DowzdRkL4dDqRYH30raX04JeSG6r9OdX/WuvVy38?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295df47-1f8e-4e6d-b7e6-08daef908e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 02:48:56.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkomZYxZUY55kX6axW/R+EnhfOExZGWtab1zvdv54Jk9mXsLkv9Kh5lOo70jtNqpJ01kmlfNvqrtEwpOIaypSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 22, 2022 at 09:35:06AM +0000, Zhang, Qiang1 wrote:
> >On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> > >Greeting,
> > >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_pr=
og_cr[rcutorture] due to commit (built with gcc-11):
> > >
> > >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-task=
s: Make rude RCU-Tasks work well with CPU hotplug")
> > >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-M=
ake-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> > >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.g=
it dev
> > >patch link: https://lore.kernel.org/all/20221130234533.1983769-1-qiang=
1.zhang@intel.com/
> > >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well wit=
h CPU hotplug
> > >
> > >in testcase: rcutorture
> > >version:=20
> > >with following parameters:
> > >
> > >	runtime: 300s
> > >	test: cpuhotplug
> > >	torture_type: tasks-rude
> > >
> > >test-description: rcutorture is rcutorture kernel module load/unload t=
est.
> > >test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > >
> > >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 =
-m 8G
> > >
> > >caused below changes (please refer to attached dmesg/kmsg for entire l=
og/backtrace):
> > >
> > >
> > >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-progress=
 test 0
> > >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-progr=
ess test 0
> > >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_b=
arrier_tasks_rude+0x0/0x10() 0
> > >[  146.800051][  T583] ------------[ cut here ]------------
> > >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcutortu=
re.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> > >[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_msgh=
andler crc32c_intel serio_raw processor fuse
> > >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not taint=
ed 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a=
9
> > >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcuto=
rture]
> > >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 83 c4=
 10 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 83 fe=
 63 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b 45 =
dc
> > >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 EDX: =
00000000
> > >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 ESP: =
ed9d5f40
> > >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EF=
LAGS: 00010293
> > >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: =
000406d0
> > >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: =
00000000
> > >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> > >[  146.808384][  T583] Call Trace:
> > >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcutortur=
e 6754ed9afe4685f50ef7fade6309181c73794538]
> > >[  146.809348][  T583]  kthread+0xc8/0xf0
> > >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [rcuto=
rture 6754ed9afe4685f50ef7fade6309181c73794538]
> > >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> > >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> > >[  146.811075][  T583] irq event stamp: 205883
> > >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114bb06>=
] __up_console_sem+0x66/0x80
> > >[  146.811960][  T583] hardirqs last disabled at (205898): [<c114baed>=
] __up_console_sem+0x4d/0x80
> > >[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb40b>=
] __do_softirq+0x2bb/0x440
> > >[  146.813079][  T583] softirqs last disabled at (205871): [<c10845f0>=
] call_on_stack+0x40/0x50
> > >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> > >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barrier: =
3960 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cbs: 5=
0000 cver 1 gps 0
> > >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocation hi=
stogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10:=20
> > >[  149.453780][  T557] ------------[ cut here ]------------
> > >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> > >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcutortu=
re.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
> >=20
> >=20
> > This is not a bug.  this is caused by grace period taking too long time=
, the previous callback
> > has not been completed.  from the dmesg, can be found that the cpuhotpl=
ug test is being
> > performed periodically, this may cause the rude RCU-Tasks  grace period=
 to take more time,
> > due to we need to acquire the cpus_read_lock, and the CPU0 always bootu=
p failed, that is to
> > say, only one CPU of your system is online at this time.
> >
> >Onlining of a CPU failing with EIO is a new one on me.  Especially
> >persistent failure.
>=20
> I use the kernel configuration file in the attachment and  base on:
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
>=20
> use "echo 1 > /sys/devices/system/cpu/cpu0/online" can reproduce this pro=
blem,
> the CPU0 always fails to go online. =20
>=20
> Debug found CPU0 is always not set in cpu_initialized_mask.
> causes the do_boot_cpu() to return -1.
>=20
> do_boot_cpu()
>      wakeup_cpu_via_init_nmi();
>      if (!boot_error) {
>                 /*
>                  * Wait 10s total for first sign of life from AP
>                  */
>                 boot_error =3D -1;
>                 timeout =3D jiffies + 10*HZ;
>                 while (time_before(jiffies, timeout)) {
>                         if (cpumask_test_cpu(cpu, cpu_initialized_mask)) =
{
>                                 /*
>                                  * Tell AP to proceed with initialization
>                                  */
>                                 cpumask_set_cpu(cpu, cpu_callout_mask);
>                                 boot_error =3D 0;
>                                 break;
>                         }
>                         schedule();
>                 }
>         }
>=20
> This looks related to this modification e1c467e69040c("x86, hotplug:=20
> Wake up CPU0 via NMI instead of INIT, SIPI, SIPI ").
>=20
>=20
> The following modification can make CPU0 go online successfully(This
> is just a test, not sure if there are other effects).
>
>
>Thank you for tracking this down!!!
>
>Huh.  CPU 0 is normally the boot CPU.  Back in the day, it could not
>be offlined.  Given that your testing indicates that CPU 0 can now be
>taken offline, maybe this "if" statement is a holdover that someone
>forgot to remove?
>
>But I must defer to those who know a lot more about this level of
>x86 code than I do.

I found relevant modification information, maybe it will be of some help

commit e1c467e69040c3be68959332959c07fb3d818e87
Author: Fenghua Yu <fenghua.yu@intel.com>
Date:   Wed Nov 14 04:36:53 2012 -0800

    x86, hotplug: Wake up CPU0 via NMI instead of INIT, SIPI, SIPI

    Instead of waiting for STARTUP after INITs, BSP will execute the BIOS b=
oot-strap
    code which is not a desired behavior for waking up BSP. To avoid the bo=
ot-strap
    code, wake up CPU0 by NMI instead.

    This works to wake up soft offlined CPU0 only. If CPU0 is hard offlined=
 (i.e.
    physically hot removed and then hot added), NMI won't wake it up. We'll=
 change
    this code in the future to wake up hard offlined CPU0 if real platform =
and
    request are available.

    AP is still waken up as before by INIT, SIPI, SIPI sequence.

    Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
    Link: http://lkml.kernel.org/r/1352896613-25957-1-git-send-email-fenghu=
a.yu@intel.com
    Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>


Thanks
Zqiang

>
>							Thanx, Paul
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3f3ea0287f69..26ee9cdf639e 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1013,10 +1013,10 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long st=
art_ip, int apicid,
>         /*
>          * Wake up AP by INIT, INIT, STARTUP sequence.
>          */
> -       if (cpu) {
> +//     if (cpu) {
>                 boot_error =3D wakeup_secondary_cpu_via_init(apicid, star=
t_ip);
>                 goto out;
> -       }
> +//     }
>=20
>         /*
>          * Wake up BSP by nmi.
>=20
>=20
> Thanks
> Zqiang
>=20
> >
> >							Thanx, Paul
> >
> > Thanks
> > Zqiang
> >=20
> > >[  149.455687][  T557] Modules linked in: rcutorture torture ipmi_msgh=
andler crc32c_intel serio_raw processor fuse
> > >[  149.456490][  T557] CPU: 1 PID: 557 Comm: rcu_torture_wri Tainted: =
G        W          6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c=
12c137296733dde4a9
> > >[  149.457660][  T557] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > >[  149.458484][  T557] EIP: rcu_torture_writer+0x71d/0xc80 [rcutorture=
]
> > >[  149.458990][  T557] Code: 05 00 00 8d 43 f4 39 c6 74 c3 e8 0e a0 0b=
 d2 83 ff 63 0f 87 3d 05 00 00 ff 73 fc 68 88 a0 10 ef 68 f4 9a 10 ef e8 10=
 01 d2 d2 <0f> 0b a1 30 c6 10 ef 83 c4 0c 85 c0 75 95 b8 01 00 00 00 87 05 =
30
> > >[  149.460472][  T557] EAX: 00000027 EBX: ef10d630 ECX: e49c0f28 EDX: =
e49c0f24
> > >[  149.461022][  T557] ESI: ef10d694 EDI: 0000004f EBP: ece35f8c ESP: =
ece35f18
> > >[  149.461539][  T557] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EF=
LAGS: 00010292
> > >[  149.462101][  T557] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: =
000406d0
> > >[  149.462642][  T557] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: =
00000000
> > >[  149.463172][  T557] DR6: fffe0ff0 DR7: 00000400
> > >[  149.463526][  T557] Call Trace:
> > >[  149.463795][  T557]  ? lockdep_hardirqs_on_prepare+0xa4/0x160
> > >[  149.464333][  T557]  ? _raw_spin_unlock_irqrestore+0x45/0x60
> > >[  149.464795][  T557]  ? trace_hardirqs_on+0x35/0xe0
> > >[  149.465191][  T557]  kthread+0xc8/0xf0
> > >[  149.465506][  T557]  ? rcu_torture_pipe_update+0x130/0x130 [rcutort=
ure 6754ed9afe4685f50ef7fade6309181c73794538]
> > >[  149.466327][  T557]  ? kthread_complete_and_exit+0x20/0x20
> > >[  149.466771][  T557]  ret_from_fork+0x1c/0x28
> > >[  149.467136][  T557] irq event stamp: 45753
> > >[  149.467457][  T557] hardirqs last  enabled at (45761): [<c114bb06>]=
 __up_console_sem+0x66/0x80
> > >[  149.468145][  T557] hardirqs last disabled at (45770): [<c114baed>]=
 __up_console_sem+0x4d/0x80
> > >[  149.468803][  T557] softirqs last  enabled at (41056): [<ef1037a0>]=
 rcu_torture_pipe_update+0xe0/0x130 [rcutorture]
> > >[  149.469602][  T557] softirqs last disabled at (41054): [<ef10377c>]=
 rcu_torture_pipe_update+0xbc/0x130 [rcutorture]
> > >[  149.470401][  T557] ---[ end trace 0000000000000000 ]---
> >=20
