Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B5A72DA47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjFMG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjFMG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:57:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E510F4;
        Mon, 12 Jun 2023 23:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686639455; x=1718175455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BVd+sKo4GFrbvBapgWNyNA2IOern9R1BgT+xRo/RjNg=;
  b=U2FyPWOm+V5hdSX9nYHzbk2QjbaWdR6Jw0MFxeWR+A9TDQL4Gg4xE9yA
   7JptVJKviHG5j7VdG69jk5sFIKQ/AMLnkT2OkuSyzbf4hh6bqzs7PPOXQ
   yqEcgx2AC0K4lo1sHbfZI6GUIqAeD8Joist8lDwXUrPyWbdI8mHtUFNG0
   dBhZBUxeGzLrxd2jUBiC49QnuR+LI5KDW1yh2X6zUQTPof22K38DVUy3F
   Lsa5T+mC5Y9H5W9kQBzLPypgpLRckNOtUfTKbuamYuzZt3IowxfR1vS4r
   RXcoLGVI1e7UqL8Fqv4G6pSdQ4V3I7VX0xZ58OkiMnvottOgo4r+d20AD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338606509"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="338606509"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 23:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041641330"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="1041641330"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 23:57:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 23:57:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 23:57:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 23:57:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 23:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZb0bcUyZh1y1TnHUpORMjabw9/PGrIP8ZKF4mCH2EGcdme9tWKcp0D1XNOFhGqHBxArP7gBfCbvlqdeA7yBDCegi2a5pwBGUwR7py4K9InfUoj0bytiBsUVXp1tKNM32XYk/FV/xJkUbT/WmxMgLayOxmvq0TlVGan3hkdhUQb/KCwswsWfNN6/urdWYbPQ9iPshYGzmT+EJ91qvgA1VQ0NdGX4EBB8kuSAA/K6Sl6Op2saM3oI8dixtKt2C0qhxCu0egY/4Et7PwwvVaQ/LxDke5jF+r81RVv+fYUCmvYVxm9q5Vk6aO5QAjr124euQIOqbZ9gplOZ0NGm2Gjf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX0bJGyMtIkgIgXIh/urZKHRgz19YEsKU5vE5QVQh+M=;
 b=I0kN0ynBn7zb5abasY8965mZoN53h5FYRdA623/x2a37vs0XKwKG8x9OxkudG++58ZGYl34rz2Aw2aPO3v9VeiqnSx3g6QWW8+mrSyqCq0WCK2PdoTABAx6j/rrzWGo1glaTpcN57xjpeHsl2DsFcYc0iWNUhrfAOznxYyMZgkD0OeKEzLCS1Me51sco2pGzyOFLRt0KrNnsoK3i/F8M2NE3FGJiTrgQZllx3PlUcyoZRtiJ2/dBU54xHmen9tNCM8i2dfXbTInwo0NpZHmOxdw5zDttmiwsFQyBRKdQkIjGewzB21NRL0nBfjQjgdxS22PlKJ87dpCbVvUoSq6E8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 06:57:26 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::275d:68f:3d46:6647]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::275d:68f:3d46:6647%5]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 06:57:25 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: RE: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter
Thread-Topic: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter
Thread-Index: AQHZk6lClEakYUGB6E+RTFZhv5r1b6+IXt9g
Date:   Tue, 13 Jun 2023 06:57:25 +0000
Message-ID: <CY8PR11MB71346F0DFCA82A7501DA0A4E8955A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-6-frederic@kernel.org>
In-Reply-To: <20230531101736.12981-6-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4704:EE_
x-ms-office365-filtering-correlation-id: dbedb84a-640b-4680-6ff5-08db6bdb71b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bmY8aPVFLFJeixoGSbKRrPj0o/JHZFuSRGIvycqYWL1IHpJh2YNa/h8km3CskbQ73hZLaaURMjE5fo2uHCknmZ5Dg4oni397JRBd/0h1JZXSBO2vN5ZGdDqW6VaeiZK8HENeGmKUdtajzBszRme9azFCJrdbCA8BXoKOyfBA3P9+4ghPDJ5lU2oLRKaqAAiYvH1TfdfMKk7FpdPEU7ifyS36N8m6Fs/mzX9XoqqDWc0tEvwVX+foEEDFpH0TDP6nJbc/ftV7DNVCixHktdEB5SUoCzpjKHapXg7yMeQcmlDyh+zVPi79+4Jf/MT7JQA9n9LL4yLQrCm7jVrrJYFGrWJNZeFQt341fPUZLOEqw9/ybrC3epp/S2nkK/MW716/TAQCqfX6OH0OKo1jKmmpPu1Es/DZWPwue+tw9diKLUSLqBUOLiY8izwcLcFzi37gJdH9rZc5OABtrgCcNjcha5DXuOMRNO6TNbA/VVlOkgOD2EtETEcOdKNS9SAsdExBnPHU+Vf0khFlC1Mowj95666PAfpzXgrf/BxF4+Zjz3U7Cu4LsTPF261nisUK8uo7FD7FcTetCc8XAd2tUpINl9UE8/9wTpVGonMRLuzx+z4WzwRT2NApTjaj6sxA7ij
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(66476007)(55016003)(66574015)(83380400001)(64756008)(76116006)(71200400001)(7696005)(9686003)(53546011)(6506007)(26005)(54906003)(186003)(110136005)(478600001)(52536014)(2906002)(8676002)(86362001)(5660300002)(8936002)(33656002)(122000001)(4326008)(38100700002)(38070700005)(316002)(41300700001)(66946007)(66556008)(66446008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R58/wvKKUHkOjL7gtu04DrFY+/ZNQOFgan7+7k49YUAkYAu9cZHXNyjDKM55?=
 =?us-ascii?Q?uDcY9kHwQQd7q2RwJnbqAuTm9qUN/BSywk5jR7VFgxo/QEasH4KuAp4Tku6X?=
 =?us-ascii?Q?9UuTNV47bRx11S2bgy4GlP6QiqUu4HPagCrEZGauJ3p1eeti/91DVDeVcGMN?=
 =?us-ascii?Q?8aSFOcpj2Bo0QOrtoG7SXTPA4IbU+IrulhXQ6RMe2kjD15rYqOTz0hFwpGe0?=
 =?us-ascii?Q?/bg4JmyLdXOfoDdBmGXbNa8Q8nAB9eV0UOHyeD6DKVy3LRF7oYTp+IruDOGy?=
 =?us-ascii?Q?Vg8QkznuzfiwcWl8m9aPBAklzIwD8KFCJpCs2heqdWk5ww8w5NUWzri024fB?=
 =?us-ascii?Q?UuJp/8TWMXpw47WNsHWpDahDyFyMxcRECID9hK+kCtGtsqLH9FBVeWYEf63E?=
 =?us-ascii?Q?JhnZ4CuulrfDu2OXWCzrGdu4VaID+buOD6Ye1SS4g+Wn547QJlgH3bU4b1Jy?=
 =?us-ascii?Q?LccDQkc03jUZ82HsHy4Al/HkzNPu9ivCCFe/AMkE0GMNQwhglkp40ShctTux?=
 =?us-ascii?Q?wRMmPvuYN6CAO75eW8vCdP/UJIh5u51ei05BYANJQrxHWXd22/xW+ycPVPjP?=
 =?us-ascii?Q?tKsut3g4kfN04mvp+bZ9KRHkV6rQNZ8nrK9DuvWSIrqt7+rFGYUrgoVkuFCR?=
 =?us-ascii?Q?jRr9ntU6elgl0g5m94enC/qo54TONEgyZmvMOMTy2IkB5mfNNXUvo75yqxM1?=
 =?us-ascii?Q?MawDoc1wJ9a6M2/xNUZMShH6U5Xx7JzzrlnrsdBvRhuxIYBIZ/Gp3yTt8Yg/?=
 =?us-ascii?Q?tv1yaWxgoedS3U4KZmRW9bCBLqGjHHhQ7wbg29dwtVsA69h9+k7F0wN9HHCa?=
 =?us-ascii?Q?M16nIKpsWhLWchsLPTkqorDRPICLNlIys6NyPi8mHwAvZXVLzmOKhhoNZ8Pg?=
 =?us-ascii?Q?UmNSZqIRFKlDirnkY30md2ot611NW7SvaK+9sQAjviB+MMlQ//CR6p+oqwlY?=
 =?us-ascii?Q?XJryzPE0pvwt+4rYwvtj1dNo3qfaAgoRCLnOV6e8Z4zJ/MQKhHiHyBMH4Ygw?=
 =?us-ascii?Q?9Q7xk4Y/hRnkyvN6J4tXZiF4rMFhNVFogt+W5O7m3ldOIZwidhO9tAKCiTub?=
 =?us-ascii?Q?fCqYUvNNhxBnAub6+u7zwu/HUowEZ3J5gpbqaWlYlltMvxlB8RiOvBlkzwpY?=
 =?us-ascii?Q?lagtSQrDu4/VYgCzhdNkKHQvTYZNNyNkKPwH+1MoDVQbbORyfTKrQrAnFeHS?=
 =?us-ascii?Q?UpNOLuToabpB0JEeFM/nmnvDp/ddMtgMrXy7n7FU5AAXof6lffdDkDnpouEM?=
 =?us-ascii?Q?a2GGkTINBd4UB0iNf6X1dlxv9oPi9zUbXaPpreGPIkFxsq6EuzGKXYVPas23?=
 =?us-ascii?Q?LGzk7yq9WJKzUISgHF6l3xyFQnbbDvhgIavdwyjS7sJD2v2m7JSBmMwT0qrq?=
 =?us-ascii?Q?TxgWpyDvl1gOOs+Eki5u7jJwVspX3eRgpSQBxuv3hW5rO3bUde0iRgK4IhxM?=
 =?us-ascii?Q?NNpHwV6ji4g0+Dxva8Z6Ktr9COEDZ7fSQzFl45gehkHQo4kMGswqEp5lhjrs?=
 =?us-ascii?Q?nQSGcfoK1X+jwlQwgZ6Yu9HrvqXtY1CIwp567hBDgudvujRQb+j35GxnC01X?=
 =?us-ascii?Q?YKSqcGc4WXETdIYZjkHSHa7uLif0kuA+aOh3I4+a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbedb84a-640b-4680-6ff5-08db6bdb71b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 06:57:25.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XqgUR2xnxNLuNGvO+dIIZfWCXWiD2DSSS9D3xak3sqcyou+TK5d7f6EzXq6KSkkMNI4TcAB8hBRq+GBCJzQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Frederic Weisbecker <frederic@kernel.org>
> Sent: Wednesday, May 31, 2023 6:18 PM
> ...
> Subject: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter

I didn't find the 'lazy_enabled' variable in the patch series.
Did you say rcutree. qhimark_lazy?

-Qiuxu

> Allow to overwrite the arbitrary default number of lazy callbacks thresho=
ld
> that is currently set to 100. This allows for tuning between powersaving,
> throughtput and memory consumption expectations. As a bonus, setting this
> value to 0 disables lazy callbacks.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  kernel/rcu/tree.c                               | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 505978cfb548..dd2be4249061 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4798,6 +4798,11 @@
>  			Set threshold of queued RCU callbacks beyond which
>  			batch limiting is disabled.
>=20
> +	rcutree.qhimark_lazy =3D [KNL]
> +			Set threshold of queued lazy RCU callbacks beyond
> which
> +			batch must be flushed to the main queue. If set to 0,
> +			disable lazy queue.
> +
>  	rcutree.qlowmark=3D [KNL]
>  			Set threshold of queued RCU callbacks below which
>  			batch limiting is re-enabled.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> 9b98d87fa22e..e33c0d889216 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -390,6 +390,7 @@ static long qovld_calc =3D -1;	  // No pre-
> initialization lock acquisitions!
>=20
>  module_param(blimit, long, 0444);
>  module_param(qhimark, long, 0444);
> +module_param(qhimark_lazy, long, 0444);
>  module_param(qlowmark, long, 0444);
>  module_param(qovld, long, 0444);
>=20
> @@ -2655,7 +2656,7 @@ __call_rcu_common(struct rcu_head *head,
> rcu_callback_t func, bool lazy_in)
>  	kasan_record_aux_stack_noalloc(head);
>  	local_irq_save(flags);
>  	rdp =3D this_cpu_ptr(&rcu_data);
> -	lazy =3D lazy_in && !rcu_async_should_hurry();
> +	lazy =3D lazy_in && qhimark_lazy && !rcu_async_should_hurry();
>=20
>  	/* Add the callback to our list. */
>  	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
> --
> 2.40.1

