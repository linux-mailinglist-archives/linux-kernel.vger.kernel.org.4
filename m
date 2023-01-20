Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E796674B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjATFD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjATFDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:03:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C3AD88C4;
        Thu, 19 Jan 2023 20:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190233; x=1705726233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2FcB0gEl0xVU5AvypV5OzP0niJQTNQo3HoVU2pLOV4=;
  b=kLo2T2WvcmYHZWy0Kusmm2vQ3dGwlUq7HKmsLf5oTlt9As7iUFij81SN
   gtdHCygYssWNPbx5emDfbdKs3tWFdEAkHk+HTZl5VNtsUGu/TGz1TVkSE
   HOFSLHeyuS2izlj5FQoMxdZf/PF5L85QpIldjJIq98R6WRDmvkNLu3CUJ
   YfepbSQHXS7w1AN9o2Hp2XaDByvAmzNoF7z8QG6uynKPBXUV3Lqa2bNuU
   VVOjdX9BlRGx0q86h3SeZM12NTtaf4M0EbeVNjW5oWF1mkCDcWFLVwKC2
   lJhY1H6JEp1s41T+zGWE4pZuNdIntLZg/RhQEzGUm74jF3bTJJtdExzbs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309079005"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="309079005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 20:09:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802938131"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="802938131"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 20:09:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 20:09:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 20:09:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 20:09:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 20:09:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhM619R2vT+GoyXb/Od+Jufdxq/I6N29Bw3PVlHCqYawFxeW0SQlLzXGN+sRw3mTHLIr1AkPq8o2Dpw7tYcGBYkTsJjcB85sxqzaQnUdPYdTS1AUityw/6+yklScLAOMr0peCuDsruQyYzV6mSyonkoNFm+JMgxITVR2E7rRuVSwnw6UfbBD3FOuZ04CUlziDt/k+9xdGQejaiulutKukhK7jdcEe4anOZxu664hrQuQVFwvmW4B35XfHiE67W/r03UCJCGIywbtbwMq88QeGR/0BnYH+8/tXoh7qXt76xXoOhwZ3dRpOfGSY9Kaj1CSM1j61UIiDcPSw2ohOpBXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu77mLvNBj2IYpbhxPH1v1rHl2hQ5My+m4cPFptb/hs=;
 b=SftxgZxOHhwmCB1ys6TyLV48BELkta3OEIKkkEAHkmWCIkRYetwjfLDECpBIjN9xvJPxgXyW0Htk5nCfSvBEIgwvEt97l+C/9As+VbxfYe386neNeh3EhE+zh/cK6q1bQNHC1UCPiZ4skjqa4Fafc8/2loNCbJB9UjXotdXpPYP6/m0tHTk1R95flStxW5uuM671wIWx6L8V8ACdDLFSu3Q6qn26q23sg5/eFtQMGkVKsdsI1o+Rx6LhccCU7+e7lq2Kiu1jfFSk5RLbBMLjhs9wMd/soUt2RNXB3J+bxGSWhmSb9sCW3ipEDtZPWF7MkUhDEFZ0KMHQczEh4IDZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB6017.namprd11.prod.outlook.com (2603:10b6:8:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 04:09:43 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 04:09:43 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Topic: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Index: AQHZKxIPnor+2NW260uOVFogeINpU66keT4AgAIrWoCAAAaHkA==
Date:   Fri, 20 Jan 2023 04:09:43 +0000
Message-ID: <PH0PR11MB5880980194CEA45416325716DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8oHL0uuSEef5aiI@google.com>
In-Reply-To: <Y8oHL0uuSEef5aiI@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB6017:EE_
x-ms-office365-filtering-correlation-id: f27a0bb5-f05d-4a69-6cd8-08dafa9c28e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jy22GbSc9FODDIWNxCo1DXqdGZ7KQCxN08/ceCtOi/wNg2bAW14EwSOLVWlJZ4kzQ3yVvWOLvWd85oYbsz4jYr1pDwRMzd0MdXImCBwOtoW4ok6yL6FhPj8NdGlZ5sQUYb4MEZEmARIYw8ema6gqck5XmABezkFU02JTGJebcWQeY2yAx44F06H6nQBQTZZNTUQhabKwbAH52W4Uy2Z0jrGxb34SGuhdmnXmg2saNsarDHYDSnxhxmJwvFH6H/joiiedHrxlAa3ev1FBSfDZ0V7qRjsroLScTWFgZ5vf/PDRjF7sC/3CwhPlOnGPQsbhT33g/fzSux7mmaa1WEqg8gZ1HvpAs48154ol4Hxg7in0hTAHhUvpLVl1VnK1AEOkYBbeInsDYr50mzqGgoGc2+UltlAHxo1Z4HjzjzmtaqH4W/5M4Bse6aIro++DrmQnSdqnkpHzy7fr+NCFoHPkyk95UuVDlADYsA7sDwppd/KupxDCf7tRPDTSI2JaLhvz81Mu0k10Jwdo4lOTeCDIhqtjOORzmKZvKfVxjI7fjh1jpLTQ9F1Fw3YOCX6XWxgjUMm6aCyo3v8T4HGGWFPNGG0XjWFMT70VHJN2XzscBfHqv3WhMA8em1BPpSW5IE4DUDEoCtr2HwkIEe/FDOy5r6jm81hJEHXso+3aPizTXuLlfev8wRb+5Jml9PoD9vR0QheTzbFMFRmXvwnBq1E/mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(41300700001)(52536014)(83380400001)(8936002)(66476007)(2906002)(66556008)(54906003)(76116006)(66574015)(4326008)(66446008)(64756008)(8676002)(66946007)(82960400001)(38100700002)(38070700005)(86362001)(55016003)(5660300002)(110136005)(33656002)(122000001)(316002)(7696005)(71200400001)(6506007)(9686003)(186003)(26005)(478600001)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40tJtNlwkRcI1b9BdazDJRaq4Ut3RD1W82pIzSgQJrRabNRisAJ3+BUrrynX?=
 =?us-ascii?Q?BkH2YGYh/xDHvC7u98xfrczwwnraqRfnBM/O1N94pGo6fXl+g8ugOg3hKVhb?=
 =?us-ascii?Q?r6QrNXNBHleBFGJwUnT40B8yASPVoJ0Kdfp/7fCbDccDx9o4MtNDfRcgq4bV?=
 =?us-ascii?Q?07xm4pXLxaWys0q2RMlLRx52PE55bMWHkizMxmDfdkVb0t2Ks19w2zAav8SV?=
 =?us-ascii?Q?6iYxbbrdsYjnmmEcmETqgPh7TIkSSpn6cNmSybCIjynD6BLG4wenqs8nSbOy?=
 =?us-ascii?Q?hKGz5S/5OOTkyuVjeg85igoofmO1x/qm61icvB1bNdHwpqxyl1zTA3sdTm+u?=
 =?us-ascii?Q?lWS+wwsWkB2A0rRvu/Bib8xO/m2wUipCoqbjRUkxCbmf0LtVGL1m9AKtxEEB?=
 =?us-ascii?Q?XOtxBhUfQy3b5Xbl+53ecYt5IIi1MUqGQwSekKGxToLEF58kcAizAfYk5mw1?=
 =?us-ascii?Q?Zt5kDsFNttg/Oy70ia5iCozbTTU+2qZJMGcgkLj13oofSfxPe0GLL+JPd1ne?=
 =?us-ascii?Q?M4sGBrjMwZjggGBvZsHmP09h+q3rlc7SlEA4oViQU+wJA4zY7/Ycl2m8C7Nb?=
 =?us-ascii?Q?xI0p8bxg67DZLG3sQBXVFVTV7XbYS3W55xZoexBqJ2Cq/EFdpnrcyU5dMBBj?=
 =?us-ascii?Q?CWCWgRZt5W+v5BJlXTD3jGcAtiyw0F1+Ek8JwMTGP+R/ok+85/rMuSfxizIM?=
 =?us-ascii?Q?eiz27fP4YbSRmcDrhmzDRBtwNscFZL977w5y3bRpx8+zpPdI21IsO6OPRmIF?=
 =?us-ascii?Q?XQdaUeOmuWocShVxjV2DOey89WIzh4CXwAd0On7Fj+VO2yRgv3hsVW7f+pMn?=
 =?us-ascii?Q?WbfFbHvo5rEvgUaBTT09ST7il/lbcF6Ms0oXUMVhly+mY/ylXhmhfDHQ4w/b?=
 =?us-ascii?Q?dwR6JAYDVeBF7rqFJfKVjVaWv0OxMCE28eQ1p5gR67wHovbYnTfcU7GfrQXe?=
 =?us-ascii?Q?TXv0vYcHyiBacqc1bevg6Hup2g5q3EABxyHBXb14hYleuSoCWn/LXTGdYmLE?=
 =?us-ascii?Q?J0DwvDuzguloy37EOBz8GxX1Hyln9kw866Kh22azjiR1OVyEGhOIwb6OkKXq?=
 =?us-ascii?Q?/xqILlgZoPyhAsOKevQLdV4g3elg6Sp6+9LBDYrIuSsYWb9qVwprl5cYxjc4?=
 =?us-ascii?Q?BwhXEANXvTc8i/jMBoUGoUOEXftghMmspQGsPqYpUfUCLLi8FHioHLZ/lugp?=
 =?us-ascii?Q?TgFdNMo+f4V9z0x79qcH8bZ4hokehbTKjUqOCeWJteqpqfZJ8WW85u1ZtuPw?=
 =?us-ascii?Q?uF4t1lhFP5DC/W9jnI5Xfwpheefb4nY8XuipE3GMPenfawqjV2+IvCDKpmfT?=
 =?us-ascii?Q?rFRbARwx+RZmCOQpL3Yi8bRPl11sQrucI0CBIBDVKjEdTotydxRljSMBiPhe?=
 =?us-ascii?Q?OD7EpXaY+Hs9WHHjtlAF0yemc7HzW1yJ5MBJ5OFoXYaQipITeSmIC9Vk+ZV/?=
 =?us-ascii?Q?5yEuz9MDMGhn3KC/I4F1M4fu0a28U31dsJleGouC/O8eE7vpUbI+/OaL5L6b?=
 =?us-ascii?Q?phSdYOu+SGTojFxqn40apYAURK94QzYaPkJ8tmcMjlQMWD7Q4c3VAu+VvzZx?=
 =?us-ascii?Q?dJz0gLVUBhyAPFpiEMOC8khbAGcKtHJe7yL6xY7y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a0bb5-f05d-4a69-6cd8-08dafa9c28e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 04:09:43.3915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKzpwpsoaZw78Fooy+K73fxmaKqUJq+TC7UvggsfhbzuYCiHcMqw6ILHk1qK67DhtYaIFNViOSWO7yvXItyzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> > When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's =
->
> > grpmask has not been cleared from the corresponding rcu_node structure'=
s
> > ->qsmask, after that will clear and report quiescent state, but in this
> > time, this also means that current grace period is not end, the current
> > grace period is ongoing, because the rcu_gp_in_progress() currently ret=
urn
> > true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossib=
le
> > to return true.
> >=20
> > This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>=20
> Queued (wordsmithed as shown below, as always, please check) for further
> testing and review, thank you both!
>=20
> 							Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Wed Jan 18 15:30:14 2023 +0800
>=20
>     rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
>    =20
>     The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
>     only if there is a grace period in progress that is still blocked
>     by at least one CPU on this rcu_node structure.  This means that
>     rcu_accelerate_cbs() should never return the value true, and thus tha=
t
>     this function should never set the needwake variable and in turn neve=
r
>     invoke rcu_gp_kthread_wake().
>    =20
>     This commit therefore removes the needwake variable and the invocatio=
n
>     of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
>     rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
>     detect situations where the system's opinion differs from ours.
>    =20
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c2045294780..7a3085ad0a7df 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake =3D false;
>  	bool needacc =3D false;
>  	struct rcu_node *rnp;
> =20
> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake =3D rcu_accelerate_cbs(rnp, rdp);
> +			/*
> +			 * The current GP has not yet ended, so it
> +			 * should not be possible for rcu_accelerate_cbs()
> +			 * to return true.  So complain, but don't awaken.
> +			 */
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		rcu_disable_urgency_upon_qs(rdp);
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>  		/* ^^^ Released rnp->lock */
> -		if (needwake)
> -			rcu_gp_kthread_wake();
>
>AFAICS, there is almost no compiler benefit of doing this, and zero runtim=
e
>benefit of doing this. The WARN_ON_ONCE() also involves a runtime conditio=
n
>check of the return value of rcu_accelerate_cbs(), so you still have a
>branch. Yes, maybe slightly smaller code without the wake call, but I'm no=
t
>sure that is worth it.
>
>And, if the opinion of system differs, its a bug anyway, so more added ris=
k.
>
>
> =20
>  		if (needacc) {
>  			rcu_nocb_lock_irqsave(rdp, flags);
>
>And when needacc =3D true, rcu_accelerate_cbs_unlocked() tries to do a wak=
e up
>anyway, so it is consistent with nocb vs !nocb.

For !nocb, we invoked rcu_accelerate_cbs() before report qs,  so this GP is=
 impossible to end
and we also not set RCU_GP_FLAG_INIT to start new GP in rcu_accelerate_cbs(=
).
but for nocb, when needacc =3D true, we invoke rcu_accelerate_cbs_unlocked(=
) after current CPU
has reported qs,  if all CPU have been reported qs,  we will wakeup gp kthr=
ead to end this GP in
rcu_report_qs_rnp().   after that, the rcu_accelerate_cbs_unlocked() is  po=
ssible to try to wake up
gp kthread if this GP has ended at this time.   so nocb vs !nocb is likely =
to be inconsistent.

Thanks
Zqiang


>
>So I am not a fan of this change. ;-)
>
>thanks,
>
> - Joel

