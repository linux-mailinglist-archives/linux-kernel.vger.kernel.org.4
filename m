Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A390634D88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiKWCB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiKWCB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:01:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B78CB85;
        Tue, 22 Nov 2022 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669168917; x=1700704917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uxlRENG1CM77xJvH+cTXv4unyWlvBzASOTWD/6+qxXA=;
  b=fNsxkIsx8BlQfjZfkl5qBM5WWHxd2LMsQ3VO+RSIHobhDKhMF1BeA2VF
   lNn9/ux5PdQ6m2YqkPwNhsi93YMM5U5m3zJkt88iybSXSek/ek11jYbMn
   Ga5KezVcjwjgS6rbLBarE29xw886CI7t7muH0lRB7wDMr92zAk8Xe1aAh
   gHwGxUHz7TGcaMYTlL1I/EMoNd6wZOmpaZmlSlpea5c1u4BHwuwGfqolV
   ZidrBc0c/b4jhD+5WGhe8jdSwJtmWJxRW88aGW6u7HF3rpYbY6AQ8d06S
   DQ2rFVPPahjYHwjI4SZNVA+2N2XN/9dtZyQZQHN6LK3TY7y+4ehqFP1/Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376105528"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376105528"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 18:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="592353391"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="592353391"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2022 18:01:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:01:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:01:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 18:01:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 18:01:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvzSkyOtSe5xRriS+kXEsrgYAANomadyvGUADL/l8H3w18NzSTryKFF+1WNr1LCCQens/ka1Tupkfeu8v0JlkkYru31MiHrTPknkAKwvn8U+kABgRxppjXfbAHjnA6KfIpb0VxalrTDUARglrx7xKLPlmawPIs0RXrEnbiaNWxOsZ/Z664rAtnqbAeZEsS/2CYi0MOI32hjWbCZ45CcnOjvUOrcRIZEmli7+mDHYaMNuHyePzycL3jZ2APKprZX00EZ1KtyFN0Q6IB9R+DwhDVPTw8yf10+Sybhzj5h4HD4prXFB30hR12TgS6OveZerFGIpfhAJpMqEsTBc85HRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0tcp17psdQHTdeWVKhMPwwjYJpL1p+6V+DBI55gdwY=;
 b=AETr0vMHlAWOdrWVZmfMAKE22MrX1CL99UAQQYs9nzIRpFqU7iyOoEE1r0gQ/M92CyIA6SFWGYzWLHMCu0/SKMSHt4cUFnmjq5/Je2hPRCJYE6Ydio9ZEHh+e6t1q4tqjPHpXIldLTdiTtiZ+e51OW/PpZedGr9ffQqv5LcP6CmhjOlTRZ7RSpECF4FnPi2UBdOHQfi8t/06s2+tf+T5+dAWnTU1yBsIUY3eQgpc1JUR+FT5NW7mAY6iK7IiLO04RjeBh5nkGYcs1Tx/yE4CKEfafGt6/OF2aUe3py6lPh2JoZF6guWdD1TorPvCkCtabD3i8czgDz3QJnFmbGV+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:01:50 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:01:50 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Topic: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Index: AQHY+nXe3fxP1SzD7UGw8RnvZujcXK5DKoyAgADb12CAB8DjcA==
Date:   Wed, 23 Nov 2022 02:01:50 +0000
Message-ID: <PH0PR11MB5880F073FEFFDD11B1AA0642DA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
 <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: 6b691625-7e89-4e16-a9e1-08daccf6afc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nsJ1wuuuBmlYnXBzdp5S8rvxy2R5ftDCH70ZF0IihuNkbdhKxKTon5hTGKdaY4y7V2FByanZEtjiLlHJqGF6UHEU8ludIzSvs02YPvjrCGgZQnVoeQhfFsDtP/8WPBTsL26tgoYPAdVYIiw+IeShZjMmE49YBIYkgkvVNikyPD3J/TilTwCdYiXV6tsqe9CWF9qj5IjfdaSgVkWh5WrvpRuZZqbDSuqwWwXWAdxsSYvXG80f0q91+sCbsPNBUbIYMtrnEvOElipyqNt3heh75tDu64popC2vuY3PMr1xco1FQl05xQg5KNuy4kCFRb53nvUOvy0I89bdHMPmbJqHQRvqF5TzUPU/BLonvIBagWNMAmISW/gPmba4LjaPs2IVq3Y5iRF6BFqBahu/3Do+pxAG5FvaV+dyi2J7d6yIzsib76Ow/inH6+f4wey8ekrdlOjaKgX8CDnKC3M4QLKdpVzvTM+X4F6irFmzcDyBR66bt3vdIOpb9W1cXsJ+7DK61YIhskAC9GE/hPEjTiZEdNw1Jvh68m+ds+m4TmKHTQxrdeE6o5DFGzT3ASNCBc0pIblC2ls+G4p/Z3tZvpNXafbps9Fe+nVkwwpNPYVL78c+eWsIas4fvgaP5th3cpLGqIRmvtlea8Xv2CuC2SFaPqT/K37/+7RUVB4TTjMIs3/SmbyzoZNuQOxAYUjr7xJ2WKKqeHaW8rpJmMz04b71g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(122000001)(83380400001)(38100700002)(86362001)(2906002)(82960400001)(38070700005)(8936002)(52536014)(8676002)(4326008)(316002)(66556008)(66476007)(66446008)(64756008)(55016003)(41300700001)(5660300002)(7696005)(26005)(9686003)(6506007)(71200400001)(186003)(54906003)(110136005)(76116006)(478600001)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VV+varsTq9VkTE05m/zLhgQ756QeKlSM0AZx0RDvlPj3/lSqvtGAxTtd/P0s?=
 =?us-ascii?Q?plu26Y2zLaq/+LzGfAXhCeLoSGGMdnUo0ksxUmU9rPmq5VlUHS40F+2U87mi?=
 =?us-ascii?Q?slcEP/WibsrFfepjPJScLrC4LuliEOieqN+NeA/nQ9+/cFOyAGXrwNK4g7hl?=
 =?us-ascii?Q?ih9IC2HFBShpCr0WmcEwg2RFhSXtPHU5e3B+7mElCBOGSv8yAnHR/6Gzze+g?=
 =?us-ascii?Q?Zp79e7yFGN/1lz2PtTvAbeA407ykQK4N1CXIpbV6kWauhaVTf9TPHk+d8lHe?=
 =?us-ascii?Q?oCBsiFMh9OMNi9uVl096de2mE+Phmboe5Emi4C3Ennzd4yYnsm2eMkw/KTf+?=
 =?us-ascii?Q?v1hpWzGI/ILF5rX3aF+6SovMSD3t2Vd7ROxvOQMOli+mBYHA1gHVGmecgf3o?=
 =?us-ascii?Q?pcQ8dR6cvAMpRKGlTPtWf3C/P6ZOT/XBfuRGv+aJZoyol1THHFeAPEQSjs+d?=
 =?us-ascii?Q?B0bbP4G4qT6dDTVwv6R34MTsEgZNXCI0eWth1wxMXW8Z3zFHkuSFzdgCgwhg?=
 =?us-ascii?Q?LepsSud8zOixeUy99KGdySGPczf79+z6gv89Ou3nLu7hjE6gfMJ9HuhKvatV?=
 =?us-ascii?Q?Ll786bJRJR1leU8HHPdy3tuaLFwJat+5T3pB8zIf2nEQVS9vMmzM37vpGFlE?=
 =?us-ascii?Q?3JX95r9F/iILuF9vuDT0JaUzBpTYpsmhUNVddTY5f22qGM8QUeR55uzJqRxZ?=
 =?us-ascii?Q?DGKd4p1cQJmL8tuKsPw5zCrADdpMbkA1Pdu8wqjD05e2SvFtPKaorKaTXOxz?=
 =?us-ascii?Q?g3Sv/guJo9iZxzME9KsRMc3xV8MQUm4jDjtUcyX2GRDH1viyJXruZqTB/ZFi?=
 =?us-ascii?Q?IcdklMNnGqo2H5dlzoam3odNeVzNcnZBtQ0LNVBQfhNHA1HKiFGP22R3/yxQ?=
 =?us-ascii?Q?0Sj6J8gTg9MdL9QJY4wN/2q1ZTZQguJKVa/NNkh9RUoW7ZVqzkrlK1ezL1Mr?=
 =?us-ascii?Q?FpEzHd+awiw3c0GPpr06C8v++YI/R94/bV56cr6ecHllOwNWmQOskm076APu?=
 =?us-ascii?Q?ZcjCNVXEnBj/WMnYZTghps/HIfpfFeuijYXT5I6btzHvpnObzjLfgbk7VRKe?=
 =?us-ascii?Q?X3t9XA0HB2P4ZS/4qGTjOIomN+RZyek6oDbfrAGsX43pVZjNjITqLv7QbKHN?=
 =?us-ascii?Q?8uMx0/E3Imxa6HHVvNC3QrkjT+v5eszP1m5aOGV2P/UD/b0IKi6UsbQtVh2Q?=
 =?us-ascii?Q?SdBUi49rxUqL3SagwiviaLyvn/L0ssa6VwT8HK4du16uBORAIu5wjXcjlX2h?=
 =?us-ascii?Q?Cx0uTwXzqEjgjUlyYuBETekjDskBE36d5PBYsOq+F80N+njYGwgALmuxtykH?=
 =?us-ascii?Q?4PlWG9Se9VHqE1mtfEcylXY4K3a011nrEJ3/u0YD/00KJue0opg/kAPwl7Ni?=
 =?us-ascii?Q?mFrRjfiY64MQV+4MwydF2Y8g9RXalfLuyq6f0ZvQHmqQMkpV3Qn8+28/gzKT?=
 =?us-ascii?Q?sV8m6DgrDL9fM5o2jgycWZQmHm4eSTHawCa5UEaaiprkuUK8DUhvzzDbGNu4?=
 =?us-ascii?Q?mjDF7yZwSRsnQtP2WI4vcrzZccbxmKF7j19oZBEidyhe8e1jj/Ps7yQs+cCc?=
 =?us-ascii?Q?vudS1lknUq56ScHXOV3ZTtHw3clfVznemzCkOzo+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b691625-7e89-4e16-a9e1-08daccf6afc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 02:01:50.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKqJA3Axtb/CKqH+0s5MuBmbpU+g+mPX0wGeaP5WTDEAr+up18+p8gIQK8w0OOEfWswtC0aLLcilaHDElKJjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
> Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
> callback only insert to boot-CPU srcu_data structure's->srcu_cblist
> and other CPU srcu_data structure's->srcu_cblist is always empty. so
> before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
> pend cbs in srcu_might_be_idle().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/srcutree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6af031200580..6d9af9901765 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struct =
*ssp)
>  	unsigned long tlast;
> =20
>  	check_init_srcu_struct(ssp);
> -	/* If the local srcu_data structure has callbacks, not idle.  */
> -	sdp =3D raw_cpu_ptr(ssp->sda);
> +	/* If the boot CPU or local srcu_data structure has callbacks, not idle=
.  */
> +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
> +		sdp =3D per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> +	else
> +		sdp =3D raw_cpu_ptr(ssp->sda);
>

Hi Paul, =20

For the convert_to_big  default configuration(SRCU_SIZING_AUTO), I found th=
at the srcu is in
SRCU_SIZE_SMALL state most of the time in the system, I think this change i=
s meaningful.

Thoughts ?

Thanks
Zqiang


>While at it if someone is interested in documenting/commenting on the mean=
ing of
>all these SRCU_SIZE_* things, it would be much appreciated!
>
>In the initial stage(SRCU_SIZE_SMALL), there is no srcu_node structures, o=
nly initialized
>per-CPU srcu_data structures, at this time, we only use boot-cpu srcu_data=
 structures's ->srcu_cblist
>to store srcu callbacks. =20
>if the contention of srcu_struct and srcu_data structure's->lock become bu=
sy,
>transition to SRCU_SIZE_ALLOC.  allocated memory for srcu_node structure a=
t end of the SRCU
>grace period.  =20
>if allocated success,  transition to SRCU_SIZE_WAIT_BARRIER,  in this stat=
e, invoke
>srcu_barrier() will iterate over all possible CPUs, but we still only use =
boot-CPU srcu_cblist to store callbacks.
>the task calling call_srcu() may have access to a new srcu_node structure =
or may not,=20
>because call_srcu() is protected by SRCU, we may not transition to SRCU_SI=
ZE_WAIT_CALL quickly,
>need to wait in this state for a SRCU grace period to end.
>After transition to SRCU_SIZE_WAIT_CALL, we enqueue srcu callbacks to own =
srcu_data structures's ->srcu_cblist.
>
>Does my description make my commit more detailed?
>
>Thanks
>Zqiang
>
>


>
>Thanks.
>
>  	spin_lock_irqsave_rcu_node(sdp, flags);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
>  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> --=20
> 2.25.1
>=20
