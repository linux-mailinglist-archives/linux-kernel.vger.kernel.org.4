Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89872DCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbjFMIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbjFMIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:44:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1A171D;
        Tue, 13 Jun 2023 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686645865; x=1718181865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coQatNQCCXp30gsIPBpmWBObYj9h4w5j8twp6W7dvSw=;
  b=nmjWoGdhB5vJ+vBo2kDpyOtjKJohvZg/UjSNf99iQxR3ek17CoPEJKBQ
   HUeXIspIgpysswE0Yh/Em4F/XrZoaq6OEJFkdJDsi/RLEteYGYK/QkZdI
   TjDGryEa1qawIguh4xEm7ppJGXbtGyKrl2a6UtmU1uSfGb6b+noetMsVn
   7KUOvUI8qUib796osqNRdu6ylGku0ftuJf87WEHDe17Nu3/pX95bb1Mc2
   zoCgOei979B1rS1yiz4XScTJHhKLbcIroGuixnm2n/LKhkKCYtGv2Qn7+
   5OsEgBY2HaBTyEaCoilUkxUsJrVzWPzCkkPZWsDSTekD9GRClT3zMnlHH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444645857"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="444645857"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741345448"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="741345448"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2023 01:44:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 01:44:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 01:44:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 01:44:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 01:44:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc3bTgsa87pezQPW+cpu0CtOFTLYdBJn4s5js9wzte82gNxXYZC5NN0Mhxu1+nMx1+nNp32x6S6D48tGtoLi4w5ziLfcY3UwtSqq6O/eHwQ0CJw/4YvpbXtijS7o9MJ7ZxPIWGg30gzf/XKbcQPiHMJt5Cq6fHPnmB3imCJfCZmNzGuEib7pXpDU8QxeDlOLK2f+/3/rf5bbNPmMRs0BA2QZVuojpRi46A/Q1c7f/RvVxAEHsoQ9BEC/PWDxl/f/P3UnhBtNiy07FnlM4GnXfXiC6dgtQoV3erpZeg8ooanfutvpMSRoPbF4galuRqT5Ej6uL23TRVd7a7lz/UDhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TQsJMAo/YBd6nXp/Fn+XZVq2FK3Kybuu4f2XlyFIu8=;
 b=ggvdnC1FhtLwWFCe6uvnIb6mw1hcCKb94wr6h8kmDETkAhLSZfW3xu/el1o36KZDCc6g31Rc8Sa/9ln6uT1P1mDD0OqtZNBU/nQg+9DsS9FM7lywtjhmokOc+TyAR0mohHSup2NjPjG5/QoIiElCxkTnj2xBJUPMfTABI/bqLoBXTcjgrkSzNf1x9rPfpE6TW6ObRPO06Z8td0mx8MSzHLX9W0RvhrBmGh3NDXpQ+ml8iiDdlKYkOCdplNZrPsxw93RdFBFGlj9w25QoVcZ4w2TO1ev7CxJbiNa28fCHISGLti6wZnwJynZgaKkSZm/qgNmpyqdfTfut2vtiS1LGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 08:44:18 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::275d:68f:3d46:6647]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::275d:68f:3d46:6647%5]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 08:44:18 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: RE: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
Thread-Topic: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
Thread-Index: AQHZk6k3sDGxCEkCH06DmunYWk7R9q+IbQkQ
Date:   Tue, 13 Jun 2023 08:44:18 +0000
Message-ID: <CY8PR11MB7134D71E6190AD7E2C5C40F98955A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-3-frederic@kernel.org>
In-Reply-To: <20230531101736.12981-3-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 3b9a6ad3-4c4b-4aba-08d6-08db6bea6022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nv9waW3hQ3Gar9ndEhdoQvXE7TwkGk0om/bMKZbsKbmbnPLuC9/ULp0m1NMwpAnEbFXEqHdzB7xgFMxjqfGWSIc2CudGiq9yEg6sMzAQM6P6VhZ9OFu7GB9EnXu/djgvKt3W3pB/hkLo+mxX0f/vOGpHtvro08RVEFlJ/dsDZSzS68bgsr2UojbuqLFWVZaIPuLeUECXVrZP0/1JeM91IGdfrbmSjKbz93svLQtrvL9XGonRQHWctcpaQnncRQ0sTDlFIoC8JAAEkI9c1R7poWhAB8kbvlKEz7iizu0N4stW7VNF/2b9SKd4OlnHjA1Qgw14g2Gqg9l6AVcUeymHUYdLnw8h1PhFe1/RbY4CNYhW/ENdsW0WMv2XTA+RHFh9xakNdDWVZr+fT97rp148Y7ezezW5m5BFZ9fg5GcSHRPmqUMeuHQmitwqxnEBkBpz26JqoRKNhSsVxSIZ618JYX3QXTCCzXGVxCM0zUJk1GIXSc31MLvfuL3sludetCJoW27PNHlTfHmWYl3ry3QuBOIFKTi4m7eBiBZ7PVyKyhJWrhMwtIbYSFRsUxutWjK5Ez4+MrsJcNLyCMGcsUeJpyqFCZDwpSowXBtc5FQ+NycvnfGiA8x/VpR9eP1Nitdd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(186003)(8676002)(8936002)(7696005)(54906003)(71200400001)(478600001)(110136005)(55016003)(5660300002)(52536014)(316002)(41300700001)(26005)(66556008)(6506007)(66476007)(66446008)(64756008)(76116006)(66946007)(9686003)(53546011)(4326008)(33656002)(83380400001)(2906002)(122000001)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nRHttGnD5S1JefG7qtmQXaOEwP4RRvuYYucVzvDM5PKrwbYBwh6t83CiBvJe?=
 =?us-ascii?Q?vPt0YRsWj/MrlqqlqkcZAN2+pSRKoz5e6oDfErxaUV0GGFGT+gHMUfHvk08x?=
 =?us-ascii?Q?qmanD73lEH3QEAwx1o3SJO6eoqyoxZBG7oX0dDMkh274KzHXWocvES1TQNky?=
 =?us-ascii?Q?+T7j2qnq4pVRAwMPAA0HKXQ4PvBR2awCpVoTJeIXecSKWJdFEfmcagkC/67H?=
 =?us-ascii?Q?JicUQYTpviIxr7iJdttbUNlkybNxIimOLpOhWwLif6yCPaOw8CH4D38to0K7?=
 =?us-ascii?Q?n9tv4obzTln63Ah9HYp6I60ruKIUEN3upLETZdAx5Hy6/hl8IyuBznXiAWdA?=
 =?us-ascii?Q?LoEYyiV1seRBWUxa7jvL2wBHLh/N98j7q/Jct7EZzReSjlEIGwGjExxfLyca?=
 =?us-ascii?Q?t3V+lrZvGWO3XkPZvp5BWezUnA4rcUaMnHg8f14xtTMVDT+UXKR1KKmRKkDS?=
 =?us-ascii?Q?UEz3SOn1vzdfHDnPu1lJs+UhBT5N58TYr/pznr0YuYt16rZOaSQXHBt3/7ex?=
 =?us-ascii?Q?K0uiE3+Gu3OqBUJr5VuNaUDnV+hj/jBmL8CjWQhISnBXZjPMjI44vKu8HWF6?=
 =?us-ascii?Q?6mT9AWto7Zk7/JVgD/gAZlPJCTqlY4gSwzJ/LsUe7QqSAhEeTcHVP6axXXVs?=
 =?us-ascii?Q?1suwv+61zwQ0MaSeHng9zP+y2vNAnT1ORdbOh9G25R7Xtru1pNxg/3w/0qsV?=
 =?us-ascii?Q?JEkNLJOqA4Be/AX8DvmgEEJcSm4yyrC9hoe9F8D8qBkmfJkuiA79pjv1p8EC?=
 =?us-ascii?Q?qheX0t1GyKjsM6vP4U3tlDcCOoWwF6pwjXlbzyQVX8kzyiU07bRDfDbuU/4S?=
 =?us-ascii?Q?fpLsgZ44r9TQgOkIYiyAwzf4akmpgcVHbYIw9cGk/KKogDaaV+tcDEzgeU3y?=
 =?us-ascii?Q?MTRzlVYdRMvusFTNc/moXMOqo9agnoMwibYKuwTdDl2WiMUQ0+GDZiolLSxY?=
 =?us-ascii?Q?D8biDTG5eBiqzT1KbYgcLl20pJcSuDocZOTEGMhXnsANTrgRdLl70rtY0ewG?=
 =?us-ascii?Q?uVj0335ReDuJYN1VUgqU1TkP7U1YEx2JegvkHWlfviVBhCKN7r1WGxMoBB25?=
 =?us-ascii?Q?DiSiuKoZfR9eZ/51SU8Y0jOGL6ZdqAAOuncCG8yRchJNraW8gsTxOY+C2/h3?=
 =?us-ascii?Q?s7gU+7xzgOBrrexPG6irVgc7Rr2yNT6esBUzj0xKZqzbDExH+zJGZPIGQWtt?=
 =?us-ascii?Q?BzfCiwWqPFzTnRAjDaY41HHc/vlAmudZgSurVBtBKnLKOsEWW1Ej9RfiHM7J?=
 =?us-ascii?Q?+dL9uaCXRmn4Wqv/5Q04Ex+Uh9FA+4A1JGpDG3jx1tEfIhWLZJmxXnguvhit?=
 =?us-ascii?Q?oggZ+MWM+1G1tOSV/iCPXhfMa4LjEFq4VZStvK+0ipFSim4XVQwq0MEeAlcQ?=
 =?us-ascii?Q?aIcsM8e3XmDNd5VATQH2VGPqxhM1D4RAMb5OMNdlt54rLQKqys/+RC/wm0d4?=
 =?us-ascii?Q?kenJhZxYTj+FBftQY+TSTBQbvm6nTnpqtbuSjrDrEl1GtFVymidsRU9aDWCX?=
 =?us-ascii?Q?HmHy6JJryyOuQZy0bDmzaCQhNmoyHcr5aR6oMFTCXM8GB+Uf8KmICYbuVMFo?=
 =?us-ascii?Q?R095Nzh7d06CV1KK8tPPoRNYINaIAvVzfvSa62ig?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a6ad3-4c4b-4aba-08d6-08db6bea6022
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 08:44:18.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpAgGhPnPpWY0UV8/T0WmK3ZHSLiLSCffCZwSvFwJCadVOGAmhd0ArS3UoP1M31IlO8YkrB8ZO+IGL96GMsy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
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

This patch LGTM. Thanks!

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> From: Frederic Weisbecker <frederic@kernel.org>
> Sent: Wednesday, May 31, 2023 6:17 PM
> To: Paul E . McKenney <paulmck@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>; Frederic Weisbecker
> <frederic@kernel.org>; rcu <rcu@vger.kernel.org>; Uladzislau Rezki
> <urezki@gmail.com>; Neeraj Upadhyay <quic_neeraju@quicinc.com>; Joel
> Fernandes <joel@joelfernandes.org>; Giovanni Gherdovich
> <ggherdovich@suse.cz>
> Subject: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
> coding it
>=20
> This makes the code more readable.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c inde=
x
> f71fac422c8f..1693ea22ef1b 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rscl=
p,
>  	smp_mb(); /* Ensure counts are updated before callback is entrained.
> */
>  	rhp->next =3D NULL;
>  	for (i =3D RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> -		if (rsclp->tails[i] !=3D rsclp->tails[i - 1])
> +		if (!rcu_segcblist_segempty(rsclp, i))
>  			break;
>  	rcu_segcblist_inc_seglen(rsclp, i);
>  	WRITE_ONCE(*rsclp->tails[i], rhp);
> @@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist
> *rsclp, unsigned long seq)
>  	 * as their ->gp_seq[] grace-period completion sequence number.
>  	 */
>  	for (i =3D RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
> -		if (rsclp->tails[i] !=3D rsclp->tails[i - 1] &&
> +		if (!rcu_segcblist_segempty(rsclp, i) &&
>  		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
>  			break;
>=20
> --
> 2.40.1

