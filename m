Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292564118A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiLBXfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiLBXfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:35:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE5EBCBA;
        Fri,  2 Dec 2022 15:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024114; x=1701560114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zu7k8CJE6Vd1bk5CoRuiRC45EJJvmvxuYKgqnbPmZHc=;
  b=l7AzuBZDiteMEifdteiG5CIRlhyC5MlMegZXSB3mSyh5hdphJIoDWoXf
   bwkUxs0xRX9E3K6mDiRkaF0t/u6RE+43OtahtPtkkPN106JqP8XOPrRdd
   PmyoYrpTqpW403aAZV/FXd008YStZ1mFvEtrevThCjKYqzszpvl5ph6fB
   usEeiLSCgOTkkp6GhJARs5v03XdkDEpGpZFOsHGtrGBPjuDnNVU80VLhd
   gve/kpMA7VVBHb4wgXds8/QNPxmP4poSg+gF6/QTTj51uGq2Iwi3Kv5yK
   6T/G2yTFChHIzX4hTsKwUJ/e2MSvK7RVf60j9uWpIi7+IeTJiz2EYI7iZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314774828"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314774828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595612032"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595612032"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2022 15:35:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 15:35:12 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 15:35:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 15:35:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 15:35:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv0+dFNpQbZ3SgRJ5I2sCDIUyA4zrLdGvk4YtZWy3145lKWqgCVL2NHNsKLt5Fsc+DBLoFAsFjug0f/Y02Im6hV47LntZOCCbD/4k0nGIjVn0DoPZ1+rcZWFWlL20NCI7yb3IcwUqDt55fR1mYW5/6WGaZWlXAwqxJfV2XZlNCN4CMmrrjg9N1ti0KkUgDWDCmjFgpGeAbQ46g7RnsugW+m1DhTqw/wGSkpn6ytlgYMVA8wf6PcnNmvP/b3wnXFbNmMGmBm9jKHP4PPsaxH6PeNDMuyU0YjftMp+K1GVq9WGkXCS7iUCXS4tcXejKrDdHkV2FJwMzsrGzFd5pZMPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0zQVdlbaZn1gnIrlKlngqB+8Y2asDkpnJLqdklNBDI=;
 b=MPBcXRg20Ibg5KuGpfGAHvGQtVxApwZpe4G8NbVkreSxBD6L10qno8MeRcwGXA/ugPuUU2weUywP9dOQmZUqmTSL4UOjsjNGAEjUyX76lgqDhGzE06uG8sDB8STK5vNU7uIt8TPY8Wvo9PBnA8OZRmoqrd6rt547xfde86+LRlh0XF4UU55KznZdpeNrUfLqs/++V4lwaqGZxGO+QjV5LlFbWndqEhD9Pj70t5eJ5fsn3dR01ixi1IE4fiWRnvDYDR7RD98/qT3B4C5O5rBp8NL8E5MhBRy6KVEozcmfFX6x2a84b/lW7vDv2oRHvWlXfqXcGqDhbjpsD11KNtAbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 2 Dec
 2022 23:35:09 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 23:35:09 +0000
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
Thread-Index: AQHZBHmgbK+Gas4s2UyDwnafgcYkO65bB6OAgAA6H0A=
Date:   Fri, 2 Dec 2022 23:35:09 +0000
Message-ID: <PH0PR11MB5880B8D62B5EA5643593EC62DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130051253.1884572-1-qiang1.zhang@intel.com>
 <20221202195723.GB4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221202195723.GB4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH0PR11MB5561:EE_
x-ms-office365-filtering-correlation-id: 663f4cb8-ffcb-4b44-88f9-08dad4bdd9ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CJFTZgN6Bbne4fD4d6QXWJxGmS+IZOCe5l+S5SNZpCEigWxpl5NsN+kS4G9yJjDB2Ql2hSLZd0/sEF5Q0ABLhIiRkKwZYQv9L4mmhjMyMKS+iqdsiosgGlwURvp6MWeYNtq0id0QQGaX03Da8cJRPJamtNGIvKbyiIem1KSr4SZMPAfCcDO4SvrWYpEA7rd7LJUcCcwfTrFJaMfPwMo4R4YSyNlH/lHV3Av6tl5y9em1gZW6i62T5Gi3FayjfAb/7kRi3FA0hJdKB7psFqDgnE2yMOWUh++sVIYNoBmS/lZDqGCSz+z2BqMHMaycsLg8yM+cSG/Z6jbgCHponDiBag2FXk6rWotJWRreIw8xbs2GiXhvNypmRE5SlJdBDhl7gWRPmRJn/T041jrBd7Y84LGMk3gToeZOVrqpMisegqdQpi+/lH0oiplDAg7r+4MCR5B/PA7TXpFTo+OXPpP1WSubOCFx309e82L9Zvd+tazfaK+Kp6/3x3AJgElSEDeuieAbu9oY9zMLE8kmx29Bn9z3io10jzNpvYtkbxCF1OlXxz3DJt3DllkwVbNDzUe3IxQMiNwV0IVOyOBj0XIwevU0yxIVZpmDbzST5II9pAONCTJ4RzXHHUMoBizx+8Q1icJ0Iv10h3/8KNE7mNd8Tew11UHhaMg9oqkZsNRa+fNbtI/ov8AyUmiqQEpqOILlccrQo2SWpLnLuiB3SP3mSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(38070700005)(86362001)(122000001)(82960400001)(71200400001)(38100700002)(6506007)(7696005)(9686003)(8936002)(52536014)(8676002)(4326008)(186003)(26005)(316002)(6916009)(54906003)(2906002)(41300700001)(55016003)(83380400001)(478600001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9OSEyifURvuCZeu7pao9wQzrymdG7yWD96k7EfeMw8cbdHTGfA8xosN+IuR?=
 =?us-ascii?Q?FqFzv43f85vmoE41qu3slyEcl9Nr5yoqMCvFn1YEsKeAGecOB/6sE01eLqUV?=
 =?us-ascii?Q?FANNhQe25DuSGALtkl/Pwm1WFSrLYPTdX6pgBx24XRfD/ah7ifNsV/VY1J5b?=
 =?us-ascii?Q?QIRdT3Pa+0VFTfgkrW3KljlKfyV1g2076OpWghH9Ipo//z6E7H/BPCO3Au8n?=
 =?us-ascii?Q?1w27Wf7o8yBcWTKlU7UKcUN2cPEyoFPds9J1LBsdPUzyPX056rF+RmULfDUG?=
 =?us-ascii?Q?FwS4P3HOMHEUz7CT/RAxfVlJbjxW5pfiSNOvwjlRAHlXiHmbEjXSFxeeHfWo?=
 =?us-ascii?Q?Eh7M7ykU5vCUf+t8NeQnRZYBrOIk5ga38HrzlU+33MECgtduUai7VPtgNTnJ?=
 =?us-ascii?Q?ngTAKKpQOeKS171sI8m2MQ+FTd/oLUWFbsngGGdV7I3heztaAF2L1BHls6K1?=
 =?us-ascii?Q?7g+fi6J0RNoM3XNNOMVs8AgJbApdqJHnjx1OycgfiqKsdidlpjWc5MiaSfbs?=
 =?us-ascii?Q?iOy52ZJufqCN6ZhJZn+kR729cd30yAnDttKKj75MFkrxuCjP8bbrMxXyIJ7b?=
 =?us-ascii?Q?HAy/jQyReS2+YL9ljlMGpaxP7uGmMFov9bYDWN4swcqVsmZmTVkbv2p7eEk9?=
 =?us-ascii?Q?+nX2VWBAN9sp6XpvYsBMkwUrxTiWskbpqSA84K/d/e4b2NYcQE+PcxrZuquG?=
 =?us-ascii?Q?b4Z+bGs1R2r438QMdsuLtu0VvbOGoNXwuyS5Z2DbNsGZXQsSg0ZEFfbY8D+N?=
 =?us-ascii?Q?7VQwWTDWPS5VdMRK62/y9w+W0HTSVp/mgCdGibhuRuHKLeat48oTcam6kN8C?=
 =?us-ascii?Q?1uSfQ1QSfAbl1AtxuK19CcABL20CbXv2cnNVud1zRKhRhyCckPtRzqE8ZdOO?=
 =?us-ascii?Q?DBO1cVDswbkxVOLi2QH4OKd2n990PTlJI0yhftt0Hsw4IHGk6/CqmUYyW6/t?=
 =?us-ascii?Q?V9t7BMXvHVwf3sttnyBuW/JRfuw1FFe1Os137lcZYiAP6n2eIG9HKF5+BUGq?=
 =?us-ascii?Q?OMUIXKRowcTjbw8oWwlTIRpdetRGOP/Tudkq9hm203QSRuXc+xIalbEcH/v6?=
 =?us-ascii?Q?z3rJWH6jHeruQj6oj46TxmcH99K9mqnWeB3t9izUDc5eEWmcgrr+TXG75YS5?=
 =?us-ascii?Q?I1gil+kCxQQr5j00x6sk/Znl3YAqbQaW2CuW6qMxT+leiMKHpAmEgULLhHrP?=
 =?us-ascii?Q?cs2c7JxCXdT9Od+5DUfbz2KIJEHx8ynE+IlQlO8izA2wOsAu2lW0IKC4wmAl?=
 =?us-ascii?Q?9CvqbvzfZAaJb8lToQZkTTeb+B0WPmCIgX9ljB5fgHYOdHd00vtZ0N7z+vh2?=
 =?us-ascii?Q?K4EJOCq7NUVeMxW7M88db0P36SJPzJy2cXlp0kwH3ZykdnQQoYFPyQAQ2G4k?=
 =?us-ascii?Q?Q/uI2hPiUkznXRLazl0pjLNCYuIP4TKa6sp9T8WLfDUwIVvmYkTPM7ccoCmX?=
 =?us-ascii?Q?EN6/71gN1s8DcQYFCM4SB4SqhG3RHtKgvcu05nq8ImMXmAuH9ywbPhHy6M/k?=
 =?us-ascii?Q?eFhiV+uUFHJSjRwm3EtK8KY1DEAFv2eUV94KHrPToX4LU2zuq1DVoxnhvxOY?=
 =?us-ascii?Q?Vrdnh+IMW70YAbnfTlUZWgU9gGhpqZ4wFzSIcWTW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663f4cb8-ffcb-4b44-88f9-08dad4bdd9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 23:35:09.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ciAfBO4Yvd2DO8G0SXImSrcqePmo8LA++stS5/TeARQTIguoFrzTJVhxWnpeRWW69act/HDadjcZrutyDtDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:12:53PM +0800, Zqiang wrote:
> Assume that the current RCU-task belongs to per-CPU callback queuing
> mode and the rcu_task_cb_adjust is true.
>=20
>       CPU0					CPU1
>=20
> rcu_tasks_need_gpcb()
>   ncbsnz =3D=3D 0 and
>   ncbs < rcu_task_collapse_lim
>=20
> 					      invoke call_rcu_tasks_generic()
> 						 enqueue callback to CPU1
> 					        (CPU1 n_cbs not equal zero)
>=20
>   if (rcu_task_cb_adjust &&
>   ncbs <=3D rcu_task_collapse_lim)
>     if (rtp->percpu_enqueue_lim > 1)
>       rtp->percpu_enqueue_lim =3D 1;
>       rtp->percpu_dequeue_gpseq =3D
>       get_state_synchronize_rcu();
>=20
>=20
>   A full RCU grace period has passed
>
>
>I don't see how this grace period can elapse.  The rcu_tasks_need_gpcb()
>function is invoked only from rcu_tasks_one_gp(), and while holding
>->tasks_gp_mutex.


Hi Paul

I mean that It's the RCU grace period instead of the RCU task grace period.

rtp->percpu_dequeue_gpseq =3D get_state_synchronize_rcu();

get_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);

There is a window period between these two calls,  preemption may occur.
A full RCU grace period may have passed.
when we run it again we find get_state_synchronize_rcu() =3D=3D true.

Thanks
Zqiang


>
>What am I missing here?
>
>							Thanx, Paul

>   if (rcu_task_cb_adjust && !ncbsnz &&
>   poll_state_synchronize_rcu(
>     rtp->percpu_dequeue_gpseq) =3D=3D true
>     if (rtp->percpu_enqueue_lim <
> 	rtp->percpu_dequeue_lim)
>         rtp->percpu_dequeue_lim =3D 1
>     for (cpu =3D rtp->percpu_dequeue_lim;
>         cpu < nr_cpu_ids; cpu++)
>         find CPU1 n_cbs is not zero
>         trigger warning
>=20
> The above scenario will not only trigger WARN_ONCE(), but also set the
> rcu_tasks structure's->percpu_dequeue_lim is one when CPU1 still have
> callbacks, which will cause the callback of CPU1 to have no chance to be
> called.
>=20
> This commit add per-cpu callback check(except CPU0) before set the rcu_ta=
sks
> structure's->percpu_dequeue_lim to one, if other CPUs(except CPU0) still =
have
> callback, not set the rcu_tasks structure's->percpu_dequeue_lim to one, s=
et it
> until the all CPUs(except CPU0) has no callback.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e4f7d08bde64..690af479074f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -433,14 +433,17 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rt=
p)
>  	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
> +			for (cpu =3D rtp->percpu_enqueue_lim; cpu < nr_cpu_ids; cpu++) {
> +				struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtpcpu, cpu);
> +
> +				if(rcu_segcblist_n_cbs(&rtpcp->cblist)) {
> +					raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> +					return needgpcb;
> +				}
> +			}
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
>  			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->nam=
e);
>  		}
> -		for (cpu =3D rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
> -			struct rcu_tasks_percpu *rtpcp =3D per_cpu_ptr(rtp->rtpcpu, cpu);
> -
> -			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
> -		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
> =20
> --=20
> 2.25.1
>=20
