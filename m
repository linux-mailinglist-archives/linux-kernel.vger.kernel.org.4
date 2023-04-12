Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699AF6DEA48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLES1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:18:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FFE12A;
        Tue, 11 Apr 2023 21:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681273103; x=1712809103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nfr/SziU/HbxVNriabaNbq1SMeYVaDOwon79DZpkYAk=;
  b=Dfh9mbWVxWCqTNZI9I+ytU/EHS1NQ2mO8zLDX04JL/NXm9fy9XrWHba6
   s0Qznhs4a0bxesAfnZTU4NlDBBVOtVPQQoAjZhsfcc+DgF/1Np0uGRhiA
   qxa0AHDJ/zmGGRnV4scaSSG7H4VcusJJ+3/r7g0ZzRJt82f8KntwAmROJ
   W8DRqbBGbRooFeZsJR9ZNxozCdMuUFe/YLNoyc8H8YmEyy8nZmVSD8+x/
   ALiG2oJctkRcmZN1Cm2feimMFiob+qpj8v/POzUse0lfHM4FMmHOFH3Iw
   zCNaj2p74hBHwlsDIMJ4Z9qJJsMOZuM2LLiaN5S4y70niOlKsYIvCn4tg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343800752"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="343800752"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 21:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="934972272"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="934972272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2023 21:18:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:18:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:18:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 21:18:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 21:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5xt5e5GYdLY6TAqBS3qUmwWUVo0YmEmxrQjAB04636XEoJ2UhUKH2HOeKPKmYcXAsEFXvtb6HLZZ5TFggym7ORy77FeSIBowU8hW+F9jU1U7gU/NbDmuk1GEplXXKZ1hF2cA1ruENbFiFzuJM8WU8L22HPx2lP1Yw+dDyab9IM4P4bHDgeT/yRjQQhB/PVhTzKWcq16B4BEPf88gMq6LRW5wXn1VXX8tjy3+O2Gz6T7cSGWae9wt98h878wMbelvKFEgf8RNbH59eYrwZAEv8c3p8L4gi4tuL7H1N910Z3MVpXT9ccyTqoyw4S/XEYGkU360pLklY7IHZ7C5YkXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNx6WyI6kPi/J7T7U20e5QH0E02SOik0lXvR/gEk21c=;
 b=EpcFBorcZ8T9F8GVOu16l3lsgl0KpuBGw0LDCahmvuJIW65oEqhhtOiQKLeLjbmPr5pKUD7rTgKNkwUgx+LGqz/UasOWBaOzKTSFP4f/68yqCeZZZN+jyQqisl5NY3yBdKFQDATHopnEDnQD55hWCV48SOr4tMkx83ny2aMy23H4ShFJX+mf8O8/iINxRoPJdvSb5ClLnSlNAUJad9hNZCEvcbKTXuzXi9fvyhM+9fc7i8l26putsxyvu76klSx2d13grNLmgwXwK5GW/d6zGk71tFdVkoHgR3lOjk+AxUDGd2BA4VccYB++hRurB/CIaOgMSoEEujw6S+X7QBeL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 04:18:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 04:18:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaBxqLyldFWH+MUeQ1f1h2hb9AK8dsuCAgADdb4CAAFfuMIAAEHaAgAIXaYCABgJ3EA==
Date:   Wed, 12 Apr 2023 04:18:20 +0000
Message-ID: <PH0PR11MB58805AC5772BECAF65AD4365DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
 <ZDEfFcEhirm443xE@pc636>
In-Reply-To: <ZDEfFcEhirm443xE@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB5116:EE_
x-ms-office365-filtering-correlation-id: 75b7de2b-8b1d-4223-ead2-08db3b0cf2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRW8JnZgV6xPjearsGOsqhKGU83ZnhlifR4DBRWhGEorsmixdkfl15fMtHfnvM3sUxbpIaP8bbGNoOdeDUj/iBU7ncqMg1qH0mkeGjSvwtajE5HWdgwPPTuZpAnayQnHYtQ3XmqBHz1ONklFZRTW2miw14hGcNrwm1Il5woSa69jDFTY/msZha8JIsFejRsikpj41iWf3ewe7oXPC1nqrftL37oKGMHVa3lDFP9i70nKNYL213pmEn3guhGcjKnwF799E5LUIyStdQIuGNTPbi7U9fyTx6C3pjfNtYRroSDVB1RdXoo22yZXMtjRIBdf8LlAf2Y+P6j6nsPkGmiWLMouVtkHdFx4YP0YxA/ovWTXuayikWrO+sCByhX9YgaSfXyKQYcIhIPbnhnJCYXS8RGIXM0aDRgHdvrykxm+Xgf5EUyFByCmPsGKnir2Q1nVAH7Yr+UkuqzpsNvzugl7yl/WVYM/PjKqhYCMS5okfBjXl5V0KAhiKh8tu5/nxZUM6lO4gP8I8aFFNC2jTfLpFcrC7kAXyFUjSq0ve4lDW667zKvL2o2FnJPzcYhcn3I81TuUGuCV6azCEUkfuwvEt8TyWIwfcTNA0yFggMoJLfEy5Ctj1nY1PR2VCaQssGHf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(7696005)(71200400001)(478600001)(54906003)(110136005)(9686003)(6506007)(66476007)(186003)(26005)(316002)(2906002)(64756008)(66946007)(4326008)(76116006)(8676002)(66556008)(8936002)(41300700001)(5660300002)(52536014)(66446008)(122000001)(82960400001)(38100700002)(55016003)(83380400001)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HDjJDDVyhSwleKwvlbKso+CCe40Q/MMxasT7m0eFXKpaGrJxvYl88lSPjyvq?=
 =?us-ascii?Q?/KSr+q9Fc3Q5gKGsVpO4h8XHOcYzEKDn9lx0c7ap8kjKTYt901q/3d7IQ1SV?=
 =?us-ascii?Q?vBR1c4XgYRFetnwBj2Rg9HosAzx4nBAu2n/xuMj7lGaifMqdc5XZueeGM9YJ?=
 =?us-ascii?Q?IxVzn34Cd+7VYDSWWd5O5BhmtdB0NQg7eZazIqZZ+v6UW1ocl8yNVYCoRQlx?=
 =?us-ascii?Q?P7RJONCgzllnrMrM0JfFZmJ5L25IynaEu0wd9dGhVL9Ro2eJQIFlHgJdn0+R?=
 =?us-ascii?Q?pRyRBAX37s+Rkkf3sVeiY1KkXreyRy+qx8WYWDjqi/jlYznjdovH0A4MpnCp?=
 =?us-ascii?Q?iFF/U3tmgLGGcUg0D2XMNXHkqqy4iNAHXbwIMze9tEhLMsytoqbkoLPm1JZm?=
 =?us-ascii?Q?/KJ8OCIh7FQQB3abuOHIxithwdjq8K4ur8et4xw51gZhrB9NCWlSSV23oERn?=
 =?us-ascii?Q?OKnMcmVvvP5vAVsFYbnth5WfFg2o4HbtAAyZTbmusmXhY8gtetf0LN6pZI7M?=
 =?us-ascii?Q?/Iy9SEg+pHzie+Xb/X8LJ3Kx1dAzk0DidSJKBQjln11cT0p7wPK31ZvJ1E4E?=
 =?us-ascii?Q?USja39cWSG0zf43eZroYYRUkqFcsHlg4ujMsMKzSOh/3eZeZJ1Avm/ubyC3E?=
 =?us-ascii?Q?cf1H/ztQ0VKbogDWA+nOToYs65KoPMv1HmdlBEMu0LU01WnZ76dnHJsqtnI/?=
 =?us-ascii?Q?ygffX4P2Eh/jT+RhSnJGBa6WbHI8TePnyk2wfWOvtdVp3buJnaJHA/oAFAHo?=
 =?us-ascii?Q?MZRl/7tvvMlGN4235KkeIDamwALgbpiOSCxEM7WsBh9yl32ZIZe/uMvnEQVS?=
 =?us-ascii?Q?KG9B+E0oj6w9GAULLgIUvAebUeGbTSCOEzdlMOqw+3gYQFEigSqepqVls9U1?=
 =?us-ascii?Q?lKpDjVnf3r2wpMjqyEy0BTev6nw6rg6w7t+jxJ76Pk3ixVZlXTHl6Zj+oQST?=
 =?us-ascii?Q?ZTNk55dtSYZZqajvyHRtVyqf394eA6P0Vj4ex8Q4rhqc4dAd4gkQOrhomw5X?=
 =?us-ascii?Q?0BKgNHOmCN+7HonsOJXZ3Q6vp7c5rnD7b5BswvH2tX08tWm+9f+wkMQr20nq?=
 =?us-ascii?Q?tGvm+pRR6alDl073QmtbtnQaw4Ly3eO0O3eA7ZdBJPrMN3szG30s/rmKw6jX?=
 =?us-ascii?Q?IiYEkjHWR4Y/xIQQTNLX75OPPN2BUv76t46WWkseL2cievljAiI46E7+TlLj?=
 =?us-ascii?Q?EcXMkifU9dGYqgiW12g7U9RGt3iEjG5sDmcWD/JFpa6xFFEs30xLldv36xkG?=
 =?us-ascii?Q?JHnhNDOOjUnvhSb/kSVHv0jIC+0Drf/H6ZX1YesO7LZr6ZleRZpiN8tMQEVf?=
 =?us-ascii?Q?0RpDIStdhE6UoEhlKpTL23HuCV/cMhbdyQrsrYLa/cNEHavqnQPllL1b03Ld?=
 =?us-ascii?Q?1S7KeCKPc4peI3QoNfeMGvCYJTcJLvo7X2jmu5mp+SEiKGBn5Aiks5uw6GvK?=
 =?us-ascii?Q?ihJ/Qsa2DrBzTCBJNRrHTI3asIZxnW1Zm5b+fbYIU0QZzIWdzMps6UETDb2m?=
 =?us-ascii?Q?I2sWnjp14hzEw0VK93by+D/WBofpzi/fG32a5YUjVvlFqWc5rwVzYRpLTw+q?=
 =?us-ascii?Q?i3LOeX9UNYxPd1Y7zgmuaSOSn+6Ig4+62667eF1S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b7de2b-8b1d-4223-ead2-08db3b0cf2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 04:18:20.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ztzfnulIQBOUm10znqygccLG7lmXHWLBHpOErRzZ2jPgKuIyRz9zAzBr2v5UQc0DrkGVXkTxW2/EM92VASYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 06, 2023 at 11:11:37PM +0000, Zhang, Qiang1 wrote:
> > >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > executed before kfree_rcu_monitor() to drain page cache, if the bno=
de
> > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode()=
,
> > > > if the krcp structure's->backoff_page_cache_fill is set, prevent pa=
ge
> > > > cache growing.
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 9cc0a7766fd2..f25430ae1936 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2907,6 +2907,8 @@ static inline bool
> > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > >  {
> > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +		return false;
> > > >  	// Check the limit.
> > > >  	if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> > > >  		return false;
> > > > --=20
> > > > 2.32.0
> > > >
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >
> > >Thank you both!
> > >
> > >One question, though.  Might it be better to instead modify the "for"
> > >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> > >of starting at zero?  That way, we still provide a single page under
> > >low-memory conditions, but provide rcu_min_cached_objs of them if memo=
ry
> > >is plentiful.
> > >
> > >Alternatively, if we really don't want to allow any pages at all under
> > >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pag=
es
> > >to zero (instead of the current 1) when the krcp->backoff_page_cache_f=
ill
> > >flag is set? =20
> >=20
> > Hi, Paul
> >=20
> > If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () r=
eturn false,
> > the allocated single page will also be freed in fill_page_cache_func().
> >=20
> > or it would be better not to allocate under memory pressure.
>=20
> That was my thought.  ;-)
>=20
> > How about like this?
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..94aedbc3da36 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2907,6 +2907,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >         struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > +               return false;
> >         // Check the limit.
> >         if (krcp->nr_bkv_objs >=3D rcu_min_cached_objs)
> >                 return false;
> > @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_stru=
ct *work)
> >         int i;
> >=20
> >         nr_pages =3D atomic_read(&krcp->backoff_page_cache_fill) ?
> > -               1 : rcu_min_cached_objs;
> > +               0 : rcu_min_cached_objs;
> >=20
> >         for (i =3D 0; i < nr_pages; i++) {
>=20
> The other question is why this loop does not allow for any pages
> that might already be allocated, thus perhaps looking like this:
>=20
> 		for (i =3D krcp->nr_bkv_objs; i < nr_pages; i++) {
>=20
> Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
> seeing this, but I do feel the need to ask.)
>=20
>Usually we start from zero, this is when a ptr. was not added into
>a bulk array, due to no memory reason for a single argument and no
>cache pages anymore for double argument.
>
>In the fill page function, the limit is checked by the put_cached_bnode() =
itself
>so it stops prefetch once nr_bkv_objs contains desired value.
>

If the krcp->nr_bkv_objs is updated in kfree_rcu_work() and happens before =
invoke fill_page_cache_func(),
when invoke fill_page_cache_func(), we start from zero,  will allocate page=
 and hold krcp->lock,
fill krcp->bkvcache,  but if krcp->nr_bkv_objs already equal to rcu_min_cac=
hed_objs,  this page will
be freed and exit loop,  this allocate page seems like a meaningless operat=
ion.=20

I also want to ask if starting from krcp->nr_bkv_objs is necessary?


Thanks
Zqiang

>
>--
>Uladzislau Rezki
