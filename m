Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0665A985
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjAAJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:42:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482F2677;
        Sun,  1 Jan 2023 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672566150; x=1704102150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MkC2RDSqKK/pPVbQzu6ut07qT32F5oVOQDbeGRHQO7o=;
  b=UbZD4NnkGKcu6EJP+UUpPmcliuqbHyaPEIXBJM3sAjO9IhN6hNDb+yUV
   wK4K2Yfvp99iwWfyymxwO3b73TRQn+ij8ZWhlcIKQ9Xrfax0TgXfAW+sq
   usv2H556AScq4Yha6o3xHCTEDw/0AQWXXt0csbVF7D73bcg84qwXQajMu
   crR7tJasqNVwk/cwCDMR2b73p9SetLesqMsWucxaJEQ9tytOa54XlQVIe
   15Lr2hjM3Rqqu5xSZDwHqfu9WHIPhMmIJONefKJYRhqzvHzDSZZG9vR7z
   DvHqxxx7cOFLuL/ysC+XMaT/fX7Ng8NUBG+U8PA36haMc9M9g8bG3p8x/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="383665181"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; 
   d="scan'208";a="383665181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2023 01:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="717558208"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; 
   d="scan'208";a="717558208"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2023 01:42:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 1 Jan 2023 01:41:59 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 1 Jan 2023 01:41:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 1 Jan 2023 01:41:59 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 1 Jan 2023 01:41:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijcd3vooH/MPDORbQfbFx0dwfE5T5QAycZlqHeJlbRpkAc1LpoOP01I+FpR5p39xVC0MX0NendAlzTdPifo2KIlZcpKT7jkLh9RKlBHnl6KECnEvoVSX0PLBq2VSxQG5QpII0Etux4NNfVOcUvRMYykT+s+X34TyOTY6rADYzjHsOMdOYSXlZkY5PMvUuU1kner/xwWGHIZEauViJvPX+pgUjPsx3ur945+jlyKW0GwGXc0Z/CiyVzzTjEh5X4quQsTlNofNz00/Il9+9iFoV45aqpYFZ/J2Q3TTgbNuuX0f099vg5Hm8TzEuthbwzai2a+Op4iIDkdql59t8mbuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UQpJm7VtDg6Xvuuo7uXmdqbzKQBBZwj93MPuXHv7XI=;
 b=GRo754Uy+ZbAY4bfKQ9D24w7iDHoG3vn0k8KC+6YK1ubgHPeED6vmOkQ5JeS2uCTMU8QKw/6fqEzOOob9V8LAShqSc5kG30JGFkQHj8bqhYDCfxwnH48w4naaZyxDtaV0eGw+PZC8KF//v0vf2cgrmdsD7v8AnH02y0c9Y77LKm+OM7ZxBOLCXJwmc3yhIP26SGtvW0bNP0/77rOq29IFjrC30SAZHKt59PsyS9b/uTXO/Z57rRat18dKfFm8epqhz4NtECeT8v/OZIU7iphoygmfxKZJPWIu0W0/A+Qwsve0bzDjo6YSEm4E5eJI87CVeuN/Sh0a+Kwb2amogWRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sun, 1 Jan
 2023 09:41:57 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.5944.018; Sun, 1 Jan 2023
 09:41:57 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Thread-Topic: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Thread-Index: AQHZFGUUOrkEkQdHgkyyhC/0ix1REa54x0mAgA+aWACAAAoOgIAA8kSw
Date:   Sun, 1 Jan 2023 09:41:57 +0000
Message-ID: <PH0PR11MB588001E32A306F2166D55622DAF69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
 <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221231182508.GB205110@lothringen>
 <20221231190107.GX4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221231190107.GX4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA0PR11MB4717:EE_
x-ms-office365-filtering-correlation-id: d87179ce-98b3-4d9d-c34a-08daebdc6cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gnt/gyNelD7v3w4O+PjM+9AiTyo71c2fnA3UnS0+p5r0ZA9PrxgiV9XbAQWw2If9GlhAb4Fk3D++h22X7QwBrfF3Q1GERNj/INjYqgEWxQf4wAVKTm4P9t5H4b0Zl3OPRAJnHMJMFlq8CDpNM5222ENOVCmecZT+MIj82KxNnqFi8W0LNdhdZpvE/6hJTGysR958HOtr8ERHSbfCqFBz2ApSJhaiAXk88iFktlmqdcUy1ByLF4TyMJ5zmxKHkh4W1hPjuY5lguiBcAavr+vpnd+/Q1ZQ4z1f2NxKAnBStCbS/zzh7hSCwAOURXDEDLbfogxfsUAd+5qCX0eKnmxkFjdoW0kI0YVEUsK8AkFFArJZ9K5XT/uM9+zfooqLEHpIoNvlPKX07v+saHe5txEX0eSzvRTH09nMgtPPOcsANCW/DPxIkAvDoeTnZWNFMOQlSx0cKeslvO0DWvOfgsatnfa/HYXFfHwU8PeUjro3eZA6spUOoCi0ZhTDaQwoBIAfds3G67aiDzb1lIE7KuVkLWQQozU14mRVDYhNhSn8qwv/LRRz8qiEYFBm4kCB202nWMDkgapT/wy0b6QHnDfM1Smv4O/ih+WP6Ioo/CNGtysxEk0LD9EztncYtjNqaMOq1Lf/c9iuMTIRws5qsG5rc68y3LBFyMBFKif0QV7OCg8SfSz7zrXwpP52XDcoNpWrU+7xGqcoL4uwnZ5CblI1S/29Hppmg/FOUhIpHpjL5l0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66574015)(83380400001)(186003)(9686003)(26005)(6506007)(33656002)(7696005)(55016003)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(52536014)(4326008)(41300700001)(8676002)(2906002)(5660300002)(8936002)(71200400001)(478600001)(66946007)(76116006)(66556008)(66476007)(316002)(54906003)(110136005)(64756008)(66446008)(22166003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlAhNdlHUiC+OkwmzBnhXHCQR66BvugptHkMdtCPTUOZD9mWI4WFLGftg/YH?=
 =?us-ascii?Q?tlUw3EEbznQWquKqMT5k0/NyV3fNhUG3PPs4NgIXUzmYQdBFCrp1wio6Px6M?=
 =?us-ascii?Q?zHnTGiL2jVCLcc9NpiQrp2z3NWEQ33TJUPTBbTTGUrP9vgv4KwD7KWkzYuBT?=
 =?us-ascii?Q?o+fZkrZfgaivDqOvW8XRhGdfnsVE3tkzId/oT1afZB53wwT2jBQQ4TKkk+Ey?=
 =?us-ascii?Q?Tnl14EnNGon+KXNTegYB59yPkUNdgAS3RBZbagokz1cH/rTcrSIESIdQtyYV?=
 =?us-ascii?Q?qYweP10DuC3Ps4IkL41Pf1mXY0ycz3NKeZ0Ji0BxuzVlx1I6PmoMSiX4XOKs?=
 =?us-ascii?Q?nurisfwh13s7YQ7D3YY40d5FTdOQyDjuy5i9PFeeFIqr1QAbb3MOjGTPjhZw?=
 =?us-ascii?Q?nNHqRl/s+VKJ79swgmB+zUQpRZvfYGmiQlImk96orKk6aKVn0q5lQiDP8icz?=
 =?us-ascii?Q?uHqUqZ5qmgbdaqMT3O/TlhpJZiTnaGSCjAptYFQp3+0gRYbc5asa/rHdWHST?=
 =?us-ascii?Q?Y/BefwvdnsFReBOzK1u79w8F8aBW0YqZ4o9Zz2ucIl2fz9Dj0QpLX/OBu9i5?=
 =?us-ascii?Q?8f8K/zoQp558IUhUOamWSqoLuQiS/bnWO4P8sMHUOBA4EW9aWEWTdH/Fceqo?=
 =?us-ascii?Q?ifm3IHCvBgDI3mirxAX964/69Figu3G7q9vKNifszSbj3+tP2dm3KnA28dkK?=
 =?us-ascii?Q?do1GlVAmxXAtmJvGMpGslKHyEkvupeWljym0AsVwfPBiDUNV3/9vPzlDXqft?=
 =?us-ascii?Q?CoT++rw2PouE+aO7dtldiR7Qw+nyjQt0hW3SDBXvePtAmOSEd36VLbQgGVSE?=
 =?us-ascii?Q?H2b1UU6CKg4yQc79VjyRF9ynsC48kP4xScTxenn25W7673wxM5l/5YVW1UHW?=
 =?us-ascii?Q?qyBtcTvjFKtGZi58czf1hOsUsMaF+DhBlHlMsDCep7r3SWvnDQnkB9NFP0K7?=
 =?us-ascii?Q?z+wte9sirFk4t+Dd4A9DHt0xvR/akqqR7WaVT4NslW67xH/zNyhqB9Hb/ZEL?=
 =?us-ascii?Q?hOVaOYW8hn2l/cWkFyo9+NgP5MKOv7VvHazLJbACrGfDtU1ahPYXuIlRzoA9?=
 =?us-ascii?Q?azSbjvKNpQ+Khbuqk8aXQu32M6GmynvWbO7cLBMb2s5qKRSRwem1hltYb3S3?=
 =?us-ascii?Q?WKtutgiUWqqS+ztTUg1yW+v128C8/YYoUtUictU08fvl6BbPd+n3WY6I9qX8?=
 =?us-ascii?Q?GPx2YyiHOZ7KnZIRCB1zdGo6jdq/LXDxXfaa3FOBqEyPzxLOOYI0R15Fb6e+?=
 =?us-ascii?Q?JDsRVqclqthek39oePn1bshAPpr4k5PphojlHqJ8HO5PgjoMYZbNOsRw77Jb?=
 =?us-ascii?Q?ORY0JrNuSnI6xPILiZ7zXjhQS1u9WRpdFxWvjQmSBnmnY1zvX0J2/eIwFSnn?=
 =?us-ascii?Q?8J3/ATDwkYrWb7UI9lHIPOjUyWcvbzlao1DgD0kE8Y9Jj93tGI2lsHHHyA0P?=
 =?us-ascii?Q?OV8H/4E8fUdFsLoKzVoE3Oo3IlWo/fXB9WYOZoh/RFKGn4oT7V9ISFWm0MsZ?=
 =?us-ascii?Q?RHLw0N9pKGkuz8ifxHN7G2k4ElM0L3ZvYf3ztD6z3dKhde94lfJs1d6z8/Xy?=
 =?us-ascii?Q?GX6yVk4K6SqmCRGeIWPYIwvIWyFYDkeLAGMV5qRj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87179ce-98b3-4d9d-c34a-08daebdc6cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2023 09:41:57.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy1mH7xKrRvuC1MYVTfBDZre2cJhy+Ri+pGrqKqbk/u2Knt9mFSvaC6WzrOA04NahPKX/37ZcW0XWjkqnOh3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >On Sat, Dec 31, 2022 at 07:25:08PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 12:08:49PM -0800, Paul E. McKenney wrote:
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h index=20
> > 249c2967d9e6c..7cc4856da0817 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  	struct rcu_node *rnp_root =3D rcu_get_root();
> > +	unsigned long flags;
> > =20
> >  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), T=
PS("startwait"));
> >  	jiffies_stall =3D rcu_exp_jiffies_till_stall_check();
> > @@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
> >  		if (synchronize_rcu_expedited_wait_once(1))
> >  			return;
> >  		rcu_for_each_leaf_node(rnp) {
> > +			raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  			mask =3D READ_ONCE(rnp->expmask);
> >  			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
> >  				rdp =3D per_cpu_ptr(&rcu_data, cpu);
> >  				if (rdp->rcu_forced_tick_exp)
> >  					continue;
> >  				rdp->rcu_forced_tick_exp =3D true;
> > -				preempt_disable();
> >  				if (cpu_online(cpu))
> >  					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> > -				preempt_enable();
> >  			}
> > +			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  		}
> >  		j =3D READ_ONCE(jiffies_till_first_fqs);
> >  		if (synchronize_rcu_expedited_wait_once(j + HZ))
>=20
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
>Thank you!
>
> BTW why are we forcing the tick on the whole node?
>
>Now that you mention it, that would be more precise.
>
> And shouldn't we set the tick dependency from rcu_exp_handler() instead?
>
>Because it never occurred to me to check whether this could be invoked fro=
m an interrupt handler?  ;-)
>
>But that does sound like it might be a better approach.
>
>Zqiang, would you be willing to look into this?


Yes,    and I have a question,  we forcing the tick dependency because the =
expedited grace period
is not end for the first time, this means that it is not to set the tick de=
pendency every time.
if we set the tick dependency in rcu_exp_handler(), does this mean that eve=
ry time the expedited
grace period starts the tick dependency will be set unconditionally ?

Thoughts ?

Thanks
Zqiang

>
>							Thanx, Paul
