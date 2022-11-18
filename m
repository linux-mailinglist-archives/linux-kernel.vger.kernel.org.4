Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B862ECF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 05:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiKRExk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 23:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRExc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 23:53:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFF331;
        Thu, 17 Nov 2022 20:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668747206; x=1700283206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vNTPZgTmniBi0S+BctjTT7S489qy/WFLB3blX4BgEBo=;
  b=V1Fq8wQ1R0it5uFD1htnnfYZQKRAxPerGJz2g5IWY+8cCjPNP3CyzMFF
   5KsQtwmpg7ufBtwgxy/WwH++aHzKYAQkmmC9IVUkQ2SGeVMPCV0K/xiLO
   UU8esHM5coHilY/kQCtZ6j5Hem6Q+mB4MmDpfsAgtTDgJXG038MPfUt9F
   G7apAV/Z2EvAVz6PkpZ1OGk3vwZ7cQIopWFmA5f0ZHP9ccdyalKkk4FK0
   CpLM5gG/ZgdTupi4AAA9zRwFhOqLBiv5/wrf+SnqIHMOxSE3FgEW8pPrI
   UuC9NQRK74e3RKpT9wlF7qkNzty1xsd07wI0ceXW199XyuONNzaBoytPA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="339890542"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="339890542"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="590884393"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="590884393"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 20:53:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 20:53:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 20:53:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 20:53:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 20:53:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebmy57yekRxmxYn/5giktL81jrQvO56cfMb8d0PpSIXpOqIVrNLMqiPsrv3ICKFOO57AIqPGf7Seh7e0UZKBrjs70ta7Aufqh3VehEsckVd9/LpTcUsKHDaY2BeHVuwSSADd4o1T+pCcoHJBIVdTNIWRrKb4He/f18ikP4Sb9qNgauwU17GzSRCGCW4xNK+WR70B6Q5PLLsffyZnbRcYWmnYV7lOcr7/NrHnB1fcspYLYYGOBy9ffbEtqxQ6ZVksrSe6wzw+EDcph0DIQZ5BwRxlgxK2UVWvWzQE+jZXpa5uBgw3rjaGGp93UHu20CatRvlGs8CtX/qa/dMD/jSPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDm/tyjtSIviwLc/3wq2Jyi6nDCjEaLCpDGxGwJqrHQ=;
 b=aoLfiISTGu79Q4IzkvG6TTHga/M823N+r7kKVQql+gO9Nr7Jivbn7Mt2gN/HFZELMcDePzpUESe7Pu2jh1m77Th34OFeTb9vLzBuC2v51D4Rlw5XmtCpXcnLDWf3GhqQv5YT48yA/x7mKsZI9TOAp6b52mtMG4NcQQGQP+DvNSPCyUigV18gPwFC8NxqmQoFaB/yDdsCOoAm0g8M93qsZYVeOpl8YXTBX4G9rbv0hjSUw4tAORrCeZN4sfZ+6psPY07nm8b9WPZs02EwgP+UPO7Y3LZlxcUGqPf0tHAzxM7oKh9QfTcV2Oh7bCTozobXiUy3H6PuHWk7Sv1eETgqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 04:53:22 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 04:53:22 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Topic: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Index: AQHY+nXe3fxP1SzD7UGw8RnvZujcXK5DKoyAgADb12A=
Date:   Fri, 18 Nov 2022 04:53:22 +0000
Message-ID: <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
In-Reply-To: <20221117142025.GE839309@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: 996c02cb-45fb-45e5-e591-08dac920d221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2Crx8q6LHvf0EgSoq64zbFs3lTIdU6CiRSMChWXVciGCgOjbBgR5AjPnPJNIQM71CUcNq5u+pMfofBI0MbDCyzlHi4/5GdIdp0NCzKIanBhU3xdsR5jdTLirHzxxJh9u7E6l7XFt3UR/Uln/9M5FuNeUYqk4PY9eKj8s391tfh2nrY01YzSmKJsPTex90yWcShKkBgLDHcdOwc6xarnkAd+837mAfqn48crAUuS+xIuU4r09ngZJd0Lloul/KhkW3nCt1GqtHyjjYW7PktLjx/Xgu333YDlQQnG5/IJhDAF097S8/9t50bAD0Uhv+TdMAlOcd1n0PezwdVgAyj0lptgj+5dftkVv9IvLRpx8i6Byh4nvZ7hsEw1EnhA9v69ALiB+jFa/tG8dOAUD0G20Dw6s2yy9hC5O6CGAWF5k1jTCXNcERTNxsj69JaySBFTv4loGMS0kzkzhYREZLllqAzwkHxnj18gBUcwm5W3cRcn6EgIQI9I3KA4gqLEevWSbZW2kkujO5GEpYt4d/SiebLlFyCjp7Nh4zs94QSABSEscS+OKIYw+YldBvTbB9pwY/jd62omRRsaXXCYHwVgtrr/Z9BJGydGB+e7KCoHl3Pb6E4uIrjI70GxbkyNt4JcI6jYqSlWy1CtmHTWhEx+srRBsAd3EPfOUVRgxeOgIJek1LmZe7Tt9/pSGb489BjH7CThLe9X9azL8bJvu4S76Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(86362001)(122000001)(38100700002)(41300700001)(82960400001)(38070700005)(33656002)(478600001)(110136005)(52536014)(66946007)(66476007)(66446008)(4326008)(64756008)(54906003)(316002)(8676002)(8936002)(9686003)(186003)(76116006)(55016003)(71200400001)(7696005)(6506007)(66556008)(2906002)(26005)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MlOesrkuqKCPP5nMOIxB51W0+E5hfLyQs6Iw007DA/C+TmkWqeS5EGPXxAM9?=
 =?us-ascii?Q?T6v+3eSTOXiBVKczdGNBrWtgl42njZaIxp8MUq6NuBHX2Dpy813A0E4ndDIP?=
 =?us-ascii?Q?c67IHaHZGHYnP73I4+5wrPsAjtwqKhPmaA/ZZgxlBa4Aw46iNHWfLZJqK5Pt?=
 =?us-ascii?Q?GprjS2N/ZAch6ev653mj4RzI8RSwDD5PGgXLfxnDfsTl+8sFXeb7yYJ9K/xA?=
 =?us-ascii?Q?6Y/P+hhVd3C2S72qpwH9s1vT2TNlYCYNte6CMHawdqEfpR94cJNU4CHWxlqc?=
 =?us-ascii?Q?i7eGWPfjr4z/Px14xXyQDR8L0JQ3A1b3NJYkLk4yI5CUWjjngYofiiIY8I+5?=
 =?us-ascii?Q?s8pAqYZ0o4c7Hl8emR+Mf9S2GbrM6KlcZ63b2J7uLIfYLhS17WHFokQo5mRM?=
 =?us-ascii?Q?p6uAsqOaEXK2QqBl/eM1+w42I6nbXdmyleDxxmVRMsrekdt4AVp2vuQHLq2k?=
 =?us-ascii?Q?UPn13/TnuC8mQb/8e7Phquw7AtUs6ZQVNXpCTlJFI6jbRxKpI69gOk07zUM3?=
 =?us-ascii?Q?cXxQHN/qc5Vrr9F6cRNDFVTfXMHpOrL1E3Wr9HM22X1zlWcTYefLNBDVbFD8?=
 =?us-ascii?Q?nKlUYC+34QQkfeSVMA/aL82STeNMaj5/hUJZ+nx9g/13yq4+UYhhPd0y1YTY?=
 =?us-ascii?Q?7pmSKAKKiBrtNvUUDBsBZYgiLieCyOrmz0OVGN86lclGIJOVhSyuduodAnce?=
 =?us-ascii?Q?goOZj2qm2xcvZBxeAzX6yUOlchv8cIvC/TvOYgQparLHNqH3AFJkTvBnVcRZ?=
 =?us-ascii?Q?v+iwlxXIezTQIl2yG5rerG6wd24RYMjhVVORGrNIr6IbYd/bx5iopFRWbrsV?=
 =?us-ascii?Q?rojZSiovqaX0u0/KY6dn/18vN5aYZltRgbR7M4QAaG+LpDM/5TiiuwgBGHIM?=
 =?us-ascii?Q?Z26eCLerjbRrVCg4iF90PgszUj6oLEWC1ENFthAsIu7tsyurRMpYP44U8Xq9?=
 =?us-ascii?Q?tKj1I4J38RMvKFIyiQYGcEuTRBqI+oYHOnywEDjRSV5CgRmwrE6hO5OjXptZ?=
 =?us-ascii?Q?DW4+x249MKkZRp5TY4MaBY787YWHDSZ+vxbQFbzGJ4n8JMPB0QnRo+WhBUfx?=
 =?us-ascii?Q?h36QkCaT0Y8os+PE28QK5BU+oX06y/Yx80IBAP5/ljzS6OkmbuQ6oAWAbZ5p?=
 =?us-ascii?Q?n8XRWLqYXfZKoF4FcGYj+SZLSsCAhp9szIefxGenXuuxpFjlPxAktPsuwg66?=
 =?us-ascii?Q?oEnxbFfUSn77SQ7MBFdZ+kHqjpPGcxxDHnnI9WRPkUDjuSU/K2+4Lj5pDhjJ?=
 =?us-ascii?Q?y4EZn1aX3VVxmoMJQJyoGkdfxBEPyFRnZsT1qgbU+VIrsfoIhtNjx1Mk+ZjN?=
 =?us-ascii?Q?KQhdXVr16AASNnxPwO4kvNEcrBlSyQbs/rrDZ0J273rKL6D8w2TULaTNnY5M?=
 =?us-ascii?Q?447wPhmvwqa2Ye06sJqdgxfwcvmWJApRJsQfHzrPzPaOajrKTapL4I1Y0sMA?=
 =?us-ascii?Q?Ks6qriVLEZuRw+Ldy2YmrVKWf/Zgh2gs7UnXcfL1aR7+fpNaqAj89+Qn6EUN?=
 =?us-ascii?Q?b+5RiPc6vCPl7Z3AOjIPXH1uPaSsCLedBJtU0zymdFVKWSoa3pqAqxQNWp6A?=
 =?us-ascii?Q?rjpRfsdfh3fpxJydIrVhvSg0ySJj5IR/ejC8/4Ui?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996c02cb-45fb-45e5-e591-08dac920d221
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 04:53:22.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZzv69M7J8cV9ULLqohIqUhCoi5OU4YW16dW4xkKL8pa0PVDCpGhd+yIOKMUjQvt5UJWm3Boyuw5zTr1i9+t2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
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
>While at it if someone is interested in documenting/commenting on the mean=
ing of
>all these SRCU_SIZE_* things, it would be much appreciated!

In the initial stage(SRCU_SIZE_SMALL), there is no srcu_node structures, on=
ly initialized
per-CPU srcu_data structures, at this time, we only use boot-cpu srcu_data =
structures's ->srcu_cblist
to store srcu callbacks. =20
if the contention of srcu_struct and srcu_data structure's->lock become bus=
y,
transition to SRCU_SIZE_ALLOC.  allocated memory for srcu_node structure at=
 end of the SRCU
grace period.  =20
if allocated success,  transition to SRCU_SIZE_WAIT_BARRIER,  in this state=
, invoke
srcu_barrier() will iterate over all possible CPUs, but we still only use b=
oot-CPU srcu_cblist to store callbacks.
the task calling call_srcu() may have access to a new srcu_node structure o=
r may not,=20
because call_srcu() is protected by SRCU, we may not transition to SRCU_SIZ=
E_WAIT_CALL quickly,
need to wait in this state for a SRCU grace period to end.
After transition to SRCU_SIZE_WAIT_CALL, we enqueue srcu callbacks to own s=
rcu_data structures's ->srcu_cblist.

Does my description make my commit more detailed?

Thanks
Zqiang




>
>Thanks.
>
>  	spin_lock_irqsave_rcu_node(sdp, flags);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
>  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> --=20
> 2.25.1
>=20
