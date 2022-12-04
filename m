Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276A641A4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLDBrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiLDBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:47:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051214D0F;
        Sat,  3 Dec 2022 17:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670118436; x=1701654436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqgxXPqdv0+qhnM65O/YutSUfPpPeSUluaBFlUNbmc8=;
  b=En2VygL9Z5EG6KGodGlq/Ohrl7cVmTMGVwloO2VH7Du2sRk14cdnHL0e
   dJzMFnJIZhlPoCcd1OLUWQQQjipQ/+RKgUg1OWaB0uQ8fKr6AnIkoAQ1v
   wfWYWsvSinuC1Y81MDdUVcti08kna5l79w2g6859ITNaEYO3icNhYHSnd
   S0rUo7v4p9QgQwMTwz4Ge73W4pvFj5a2YxsBUTVrTMk3Qn5RqfibDapY+
   VsOV5ZepDE+5RR2Qho2fpdLtooqznSrmUxaZ2VzgxB6GrM03fDq5/fPR4
   3vfo+jTT4rLH5RMbTRcUSVQDzCQZoM+uBhhYcCYUj2ezk17zNBXzxlRU4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="378311432"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="378311432"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 17:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="623099300"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="623099300"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2022 17:47:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 17:47:15 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 17:47:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 17:47:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 17:47:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfroP29U6XbxwRPcLwF3yQENafldnCXEUltlyFDLtjlh4c2iB6mRPB0Fy+UlDFQC2qvoYaCq3+qYsZ6RMT/Ki8nBH8tWUYWyon0fOr9jCLe3kcNLmSurkVOWciZowzIziLx7oQlw9vUxgB5su6hz4ysN+3pbL4Zr2jw0hg87mlCGbp5y+fCBq3HA9NQguhEhQ9zp7+3KsU98Bko6+khMKQVxjVGqmZeHm45enfeKlYdIPSJnM4USWUmpOMBSpsYMf2PzyhXh4zh/qwvRn2OIrljYlh/DcMF+4aKErLImPcWIl3oU+XBBQYIkiXqq+K6XTmr31HTFcthdBdx5a+ItLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBxdm+cuPigCMv6NvZxdWK5U0OWAEsuK/DaQKCxMmog=;
 b=UKMy/nK3sSy3u9X7IyoafDk8O/YSMGsO3CnvYjO2KcIclwx1Oye3/JW61bMbOWf6+KUAKIp2bMcmONoR6w1HHFI+55KO16I9ZUh7+D+wbJeFzIYRZ5rXDPs4bBmNVXoAx3f47BQn22Mj08auPhIZVa2a4m4L5sdw9YvzRWNiDwTkaJLPMnnkeESOCocW7lZh0g+6s2XNClI6eyM/MdGb5FUSD9vcGQUxrx+xIHGJFSwXoSqseJj6BZGrr51QTHD71y7rXOmLCmcmr9jPdVR71PRmrCOSQ8eyWwLiEUdq3bWxLQiHXNKvzcF9iiAjonwCksHhLfn71fsroPxOytsKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sun, 4 Dec
 2022 01:47:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5880.011; Sun, 4 Dec 2022
 01:47:11 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Make shrink down to a single callback queue
 safely
Thread-Topic: [PATCH] rcu-tasks: Make shrink down to a single callback queue
 safely
Thread-Index: AQHZBHmgbK+Gas4s2UyDwnafgcYkO65bB6OAgAA6H0CAAA/IAIABqQNA
Date:   Sun, 4 Dec 2022 01:47:11 +0000
Message-ID: <PH0PR11MB5880D9440D871BB09C1D3731DA199@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130051253.1884572-1-qiang1.zhang@intel.com>
 <20221202195723.GB4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B8D62B5EA5643593EC62DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221203002154.GM4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221203002154.GM4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB7871:EE_
x-ms-office365-filtering-correlation-id: 9e5b2919-9b06-4795-76a8-08dad5997609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVUCeEgTdRXhclP1xBypejD2rSiNNCiko6B3lkNxSJzLCkBflVB6pVvfJaD50gDfynOPThX2IimDL+chjhKFDGA3Wove2d9oB2aoDa4Vrqp5Z40KcN/OixEaCggOHhrkTTChYQVtC8w2qNHc2NfQ3AVIOFuubAJXpwCz7BnSdZ3v6OPW2I5lrQQcMfzh0fj689HppSBMuvRZ6+pAQF2LCnScROYziSpFnnhtYxSaS0/tj2rc5YbJnp6+Y7yg0Ab0HXBZw5aKIa8LK8I27nq1HtOADyN/PRnJN1RoEd8nxPTaTGTOvrizo3YGr9AaoOsYzaF3bJhoebBar4r+R4LL4v6eAwzeu4g307HaxK0U121wDUg/bOeFzO/6Dunw6w5f0370Z4xVwzawg6ElsDM6bmsuvmC8j7WHZ+Ulf4sP/EnxJgNaxbNdeVH/NkbM3kaxBWijP5hYRA4TSoQb0zAHz/DBSncnQhUMbQhnlVFiKjqg1kxmPqxlqHDo0KA1f4BjR/l7tSEY9EdW04qMVqXsmaouhBkseG/x0MJQo88VpN3EAlE32Coi80zCFq02hGhF2HBmVp4E8ykc82dfstrDRWcIo+aG8KYF+EVWOM1rxHwdSvpGN2XhsW9UxmwR9o9FpJSQjw/xVqLEyopq0gM5f0i2DB+3BC20Z2d80ClmNZnTsRfN4il64n7A3En1Yo/odPgkUPVQwxcj0AQ7fNdxPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(122000001)(83380400001)(33656002)(86362001)(82960400001)(38100700002)(38070700005)(41300700001)(5660300002)(2906002)(8936002)(4326008)(8676002)(52536014)(55016003)(64756008)(186003)(7696005)(9686003)(26005)(6506007)(316002)(54906003)(6916009)(66446008)(76116006)(66946007)(66476007)(66556008)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iiBJjGKkF7/qHUr5ubdwZV104NxyrNSpFRmlsmw3mR5MFrvtcEnrzddZo89V?=
 =?us-ascii?Q?OcQAW0mzKn5YTVyNxAMULrj/U+nK26zifwQGO7mRV7J6qiWn7q5VCxwHtt4X?=
 =?us-ascii?Q?QlTqawVAt8VHFwXY0nduBw0Y4iOHjpL/Dx8NybxbyorEjA/Eeo1kJpP7G5YK?=
 =?us-ascii?Q?o/0YHG0a/Nm4eXdC2mTW3+19cdae67YX6ca37ibNGmZF05S7mfPiuchefaVU?=
 =?us-ascii?Q?1QlyOqdUPA3ZOOUvPUTqJtSZSLASPrqS4HRsUYsth1UauYXE+2c8xIGcpJZ+?=
 =?us-ascii?Q?jroGvjqYC2+vXeMzemJCbSVzE26qTO61YFXtYQGpUG0l/HKOf5UMEBxjQYiY?=
 =?us-ascii?Q?5NFPLkckkt4EX5VyrSIu0Ca0GiOc44oEzgx8L5gNFT9DOXxJ73nN/J3bizsA?=
 =?us-ascii?Q?LzUrmpvdHztofOPO3izWtJcq0ybwupk+MoHar2C2cQSo+LJzXsgq4yqi5JsH?=
 =?us-ascii?Q?hrZ6IGwm3n9Ox/N0dPVu1qJss88XNrbydbym9G7d4/rnZ74GiC2Q5/YZJQxk?=
 =?us-ascii?Q?6HCanoLsfBtuZoiVsCsCQsfKBo37bpYzV8lVxxvsVRg1neta/WLMdz5qMjHL?=
 =?us-ascii?Q?iEFQG3q/ed9DztXbB0n3EGMb99wgCigCsbw4U9i0TaN+hoUvpb6sMpsRP6Sb?=
 =?us-ascii?Q?RLhmAwisGdT7hJkuq4jW9NCQbFFYksW7PxTRh5dFgCDNEIXulD6RKl+wQgpD?=
 =?us-ascii?Q?CrERFJbAwfrUixCaQMw+dOpxXmISMBt4UL0vij1SB8WTH1K+aOGK67hrVjEm?=
 =?us-ascii?Q?Tao5dry8/IaO7DItnjOSkc1cfZRpRk6TnhrlZA7aomyQbz4T5ktCDV3q0MXh?=
 =?us-ascii?Q?9KJHgfv6mNDDdVS7U450dzI75mlkub7vfr6HcCDOo652jJdIMhNRR22m+8Zv?=
 =?us-ascii?Q?U+fvctwxpOKspXdFif8Vl518TrsEWkYzP9OrwIw3H7O4cHNzqX3b5xzoJCTg?=
 =?us-ascii?Q?bEU+ClZ/NUHbijg2G/TzIez2kVZasNe7Kr6u59Qbd+VYRFh7m1vhfbHPn+Qk?=
 =?us-ascii?Q?9r1L8pre3D4Ihkwk/BHc4r3lW0aUsmdUtUoVjf0VaRC/9r8e3iEVQrhFS2X6?=
 =?us-ascii?Q?YuAiUUAeeKvkNHcuWF1TssLcpvYEDii5dUXwzv97BGZLG3RazcBLqaTzSrKw?=
 =?us-ascii?Q?8Wuj/GF67JseXNRSPqzXglxp+rCy8YfzLovNZZPKHETtrM5KLC7pLI58a4NV?=
 =?us-ascii?Q?PxVVC5UZlRdOJfw6SlS9FVpbeHLVtVjklm9mlRWa2Xkza0U3N8GwqKZ5FTlx?=
 =?us-ascii?Q?bIkzjvmcpDs3n/qmMh1gvLz3sp8ttnjQZstA1WgFfr2RBWSYm/5ynMBP1cka?=
 =?us-ascii?Q?YhBw9JOY7JJdDkLvEJwNzXx13hrQMRq0LWBpDASWJk5KDp9Q5sefzcqH4RB9?=
 =?us-ascii?Q?MfGJ++4Q+/uiQ7kEoW6BNrRVWmGqViFt32FIN5xm8A1ys+IkxAMHWhnQpWbg?=
 =?us-ascii?Q?gqvswNGrNDXKYugYm1uZ//gqZo34f8bRTSzb6HW17kCXEXkxu/a0tyCPzRiV?=
 =?us-ascii?Q?brWUSOULlxiQyDeucmKeA8tUQet3ysoKUtwX4XVSYGGEM4waMEEqvUvLxY95?=
 =?us-ascii?Q?+ab95s/M0zwP0dIrNi9qFAo2iUc/Ow6znB0dvAze?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5b2919-9b06-4795-76a8-08dad5997609
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 01:47:11.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExrZpZezpcNXrcSXR7WhpW4KTNt6BLNDFhJRHEFrLtFXqBkqq0U5GmETmProX/Ec/e0txtn5pWUkI4SY+y/DpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:35:09PM +0000, Zhang, Qiang1 wrote:
> On Wed, Nov 30, 2022 at 01:12:53PM +0800, Zqiang wrote:
> > Assume that the current RCU-task belongs to per-CPU callback queuing
> > mode and the rcu_task_cb_adjust is true.
> >=20
> >       CPU0					CPU1
> >=20
> > rcu_tasks_need_gpcb()
> >   ncbsnz =3D=3D 0 and
> >   ncbs < rcu_task_collapse_lim
> >=20
> > 					      invoke call_rcu_tasks_generic()
> > 						 enqueue callback to CPU1
> > 					        (CPU1 n_cbs not equal zero)
> >=20
> >   if (rcu_task_cb_adjust &&
> >   ncbs <=3D rcu_task_collapse_lim)
> >     if (rtp->percpu_enqueue_lim > 1)
> >       rtp->percpu_enqueue_lim =3D 1;
> >       rtp->percpu_dequeue_gpseq =3D
> >       get_state_synchronize_rcu();
> >=20
> >=20
> >   A full RCU grace period has passed
> >
> >
> >I don't see how this grace period can elapse.  The rcu_tasks_need_gpcb()
> >function is invoked only from rcu_tasks_one_gp(), and while holding
> >->tasks_gp_mutex.
>=20
>=20
> Hi Paul
>=20
> I mean that It's the RCU grace period instead of the RCU task grace perio=
d.
>=20
> rtp->percpu_dequeue_gpseq =3D get_state_synchronize_rcu();
>=20
> get_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);
>=20
> There is a window period between these two calls,  preemption may occur.
> A full RCU grace period may have passed.
> when we run it again we find get_state_synchronize_rcu() =3D=3D true.
>
>Ah, thank you!
>
>But for that issue, why not just place both "if" statements into an
>RCU read-side critical section? =20

Ah, a better method(my brain didn't think of this way at the first time), I=
 have been send v2.

Thanks
Zqiang

That would maintain the diagnostics,
>just in case a bug was introduced into the shrinking process.
>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
>=20
> >
> >What am I missing here?
> >
> >							Thanx, Paul
>=20
> >   if (rcu_task_cb_adjust && !ncbsnz &&
> >   poll_state_synchronize_rcu(
> >     rtp->percpu_dequeue_gpseq) =3D=3D true
> >     if (rtp->percpu_enqueue_lim <
> > 	rtp->percpu_dequeue_lim)
> >         rtp->percpu_dequeue_lim =3D 1
> >     for (cpu =3D rtp->percpu_dequeue_lim;
> >         cpu < nr_cpu_ids; cpu++)
> >         find CPU1 n_cbs is not zero
> >         trigger warning
> >=20
> > The above scenario will not only trigger WARN_ONCE(), but also set the
> > rcu_tasks structure's->percpu_dequeue_lim is one when CPU1 still have
> > callbacks, which will cause the callback of CPU1 to have no chance to b=
e
> > called.
> >=20
> > This commit add per-cpu callback check(except CPU0) before set the rcu_=
tasks
> > structure's->percpu_dequeue_lim to one, if other CPUs(except CPU0) stil=
l have
> > callback, not set the rcu_tasks structure's->percpu_dequeue_lim to one,=
 set it
> > until the all CPUs(except CPU0) has no callback.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index e4f7d08bde64..690af479074f 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -433,14 +433,17 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *=
rtp)
> >  	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
> >  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> >  		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
> > +			for (cpu =3D rtp->percpu_enqueue_lim; cpu < nr_cpu_ids; cpu++) {
> > +				struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtpcpu, cpu);
> > +
> > +				if(rcu_segcblist_n_cbs(&rtpcp->cblist)) {
> > +					raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> > +					return needgpcb;
> > +				}
> > +			}
> >  			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
> >  			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->n=
ame);
> >  		}
> > -		for (cpu =3D rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
> > -			struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtpcpu, cpu);
> > -
> > -			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
> > -		}
> >  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> >  	}
> > =20
> > --=20
> > 2.25.1
> >=20
