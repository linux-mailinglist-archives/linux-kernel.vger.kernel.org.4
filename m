Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267F77400AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjF0QR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0QRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:17:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014897
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687882675; x=1719418675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bIOsQLsxTVS0Uuz2LxzDlNrB/EIqJQ2fONom2eaejfE=;
  b=MnDuObJ6rq+rEhymgzZwSFlK6LjSzRP9LlIb1aprpqZiHJNCeUWuohTs
   nmyuTAJU+e6x1cFCXOgAxxX8kNMgwoDMHzpeq/kJt+YNOaV5ui8M4bfya
   jgkTpbaO/JOmHxnO9o2b488u+cTX0isuNWlAqWiasRoDm7gU9eWCGHyJD
   IB5ZRpycLxg4D5nruOxR4M0JTSq363S3RkN1TDpOpfB6hg0D3yCx8KOdU
   0QlX4619NEqUAOB4mIuJ5jYjVqHqh89IozKT+3tjhq61/OPvc2HlsDR9u
   hahll2ARMzxpeLQsDBLn71cXbM6aBbTbarDC7NuNsbvA0KEAE+YbfC4kX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="346376149"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="346376149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 09:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="746272308"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="746272308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2023 09:12:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 09:12:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 09:12:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 09:12:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 09:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJugYy6LeX2jzpBCR/ctnV+9+Irfc3OMYBX7XPmYLy+qhMxFXR5VQ8hOYOmObxe9uZtKqtahsmqYeZf5GIU8G3NQTh65N/AqdGhMskqXCG3t0a6/DH956sOBKVlgTWBV6njScyH16kRwIAQ1xWpljRzinnRnYmqzwk4mO5viO7N8pa60zEAFUm+v8Xh8R1dwjOgJgqD8icexeZGbieHgyap1BdhKK+r65kwYpUE1B/0AVKhfgfccT0rtGkz+XAE88sA1mcc9nDfc/DTg+uU0A2ElbkkicBiOqGXQ13v9M3bEtUSsYYBQv8KhNSeGRCUNvykHZm0TRooCohFoFmkFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgUAu3BBEle2K2+LERmLK6qICI8DelXaHN7dZLhndn0=;
 b=f1/9ganV4WTYMiOMLY3zqIFiOSCe0kzgHe/CvL7mqocw/xlYtTFPe8mvFD0HDVW1g3md2IVku0ZQbMOFW2x4zCThydiXpxI667AS+7PpGKxk1jI1/OwLYHd023zDCgg5KC3hXd4Z67dtvPndLQGkYcmVmQKm4/+GzIcfhHmY2SRulJox2F+P1NZDp0qXYhX3qbLAIoQE5tEwpPxWKZtNye3lJsMIve4HgnmmzPScgGCXjnVn3KPg3wxPnt9nn2O9Rh7jEeE/pJqN65P/rckGlV5KOqbf76TXCqKCvnqUZNMovzoy63+8mOx0YqImizYlL+BCK4dK8Wvd6enGNol2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) by
 SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 27 Jun
 2023 16:12:51 +0000
Received: from DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155]) by DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 16:12:51 +0000
From:   "Deng, Pan" <pan.deng@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Tianyou" <tianyou.li@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Topic: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Index: AQHZpBf8y9gtMyr/606YJQEIlMf8Fa+cm1MAgAHc14CAAGHSAA==
Date:   Tue, 27 Jun 2023 16:12:51 +0000
Message-ID: <DM6PR11MB3260026F33333A70AF2F02169627A@DM6PR11MB3260.namprd11.prod.outlook.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <20230627101437.GY4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230627101437.GY4253@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: 25349cdf-c762-40a4-51ab-08db77295b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7fPhmAMv+ocJTox2T0zJqMsROjSOIbaoTTGnsumKrZH7Xx23KSYSFMpMl/2HxpGXhrTOWpp1fkopsUJIXJ3Xg7O6mDREn71o39rHUQX8TJ1P2mbfN5SOUtBS+VBM2WHQmmhs6eJKlwprpSElBi9KzpMY+rTJyXxiTQ6g1ykUdaAnASb4WvUXB5sm8e6R2KURGlngbWD5ntEst6FmYZbznvd66Ouc3ncXucip6hn0zIUEF8+0SO6PcI/vg8wwwk70zqtwDOTTe8K24EBIUqmwMFRgqIwqAG8bB37ftji8i4wRpJNnhRkTFlAtVfEtVd0BJRAtZBUbAiTWFPha/FgGCF7duQ7ssSfGZTUyVumr+8cd2KcVS/QMhMO4kpMqsIgMd2TnSk7M9G866thRUEvMRuCczl8Z1tXLhhJKLTctJpNq6XPZSzqq+tCfhhfH8JH1428QG+vvNraQw9rDjMTO5q8jnPJ4WIi06kCh39hlEnOfh4Y7catVAtmIPKTc1wODNfZifwZznkd65KcT+Cp8yG5dRqOlORX9xNpfBmzFdkJokkHA5IS+k1q9OgqEKAYb/zlANy1oFGe0dopXS/ffSqCNa2maSvF8QVqdds+xEhiDYP2wupO42pyqhy7hHEs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(83380400001)(26005)(186003)(9686003)(110136005)(54906003)(2906002)(33656002)(86362001)(82960400001)(122000001)(38100700002)(53546011)(71200400001)(8936002)(41300700001)(8676002)(316002)(76116006)(66446008)(4326008)(6636002)(64756008)(5660300002)(52536014)(66946007)(66476007)(66556008)(55016003)(6506007)(478600001)(7696005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/oZSgnat1e/NsR5rcmReRETdyXLPAjvFjHKP7Ciowwpfx3rp8XeDHnF7n+K?=
 =?us-ascii?Q?cEjp1S3vlvohpjVfvY0TKzcGdhutpXlDLT37CttN9n1xJIKPrJDVcjDEjGeE?=
 =?us-ascii?Q?LiWXfAuGfzMrX23+hnFeVaRdBEWc0P4WDTitktQyxPVTKbvqGJaUsiF6GrxS?=
 =?us-ascii?Q?TQO3rydfgKwFuJ+DDCjLBjn9N/WM6o6bpthUHdXLoUVOJ8QMtJQEipG4C/yN?=
 =?us-ascii?Q?DhHtJi+DNl+vZDV3rfVAsYo6w0HZK5qK14Wj0FyayLUMnL72ep8CQrRX9IG+?=
 =?us-ascii?Q?69xrTdntfOiL8Pcfk5Kr3H7Tsm+BHFzBwn0F2NA2fza0PtY/C447I8hFHbYe?=
 =?us-ascii?Q?FC6gwJlfAQsitdSR0TcqIaOq7eCdoeBh/DakbDPFsrMuShC3LkIOAg9oz1Sx?=
 =?us-ascii?Q?/1X0gtRQ3p8GMd+Tf+TGZ/pzYA/185dfLciPl66Z5psC4UFGPSVby3eLkgxh?=
 =?us-ascii?Q?aNMpYoXAybnSzZKDs+7o39ck56IDsHXuuIAWlETyMmi4EeE5PZnMATCu00Ul?=
 =?us-ascii?Q?hFZqVgitFOZNoBdPtBursbUeaZ7+YWIjB7hZjB96eM94CuKABn7i+wGDgowO?=
 =?us-ascii?Q?X1XvPci2N2tIXMSQBgpv/R8cW6PaWFsGONj5U+w8s9Y2v6RZSBmhUYmVAi6V?=
 =?us-ascii?Q?E9Isa5iq49mJAXuiJryzRMHpq+TWtdAgy93byaNtAL5hCF4L1KbzQCGR67lv?=
 =?us-ascii?Q?mWK4yrfLGAAV7HlS5XGvxc9sOCsvoZJTi5KyzB4s5Q+WVVyMgrX/P4OXKNUv?=
 =?us-ascii?Q?vywgfUKMc3Yrx01honOik2mt7Xfs24mvQmGiFYDjyyFMMJsGZhx9T97VJyCY?=
 =?us-ascii?Q?wTqG9G6g5IDjQMXy72N2MiTJpnO8EtPiDTN66LDwjM/FQUxZPSOV6mCFy4Km?=
 =?us-ascii?Q?QcyXF0XnqueNVUeEqpvDYELpXiXvwKZZo4vigdBjCJOps/aTIcpw2fjBpMA3?=
 =?us-ascii?Q?SKEQ0K5kLx/7rEpPPKj8e9Hg/ktcQ3tp1SJ/8vyFED5PbfMLqwJwMmsdAeF4?=
 =?us-ascii?Q?Y9yJrKuJFXhRcNMNVhpzl4WBC74UYKTxP5JFiGla/ZQ/wTPo7KMHG4geLEs5?=
 =?us-ascii?Q?EHehFcm1+89mmkgrZgjTpoaieCTbzOYJuN+TwgCQuTYZXZ6XXkG63bRhpRGD?=
 =?us-ascii?Q?MreR5K7FjzBvHIQ1/Wn90gmnzgy30zJZ+BdegrOIDDRQYn2aQZ6lzgmnNOx/?=
 =?us-ascii?Q?vEekNhlCpt9zrvZe3sf9O+4/DS+yXXiWg/f8EaZdlDDTqTyAw6SSr4hv0NWI?=
 =?us-ascii?Q?CYPUvgM98nmAXpLzlPBDBtIOUnqJaa6QWG+5c0gIbYsSq3Wo6cg1ahRjPAQ1?=
 =?us-ascii?Q?/6ayUAITpRs78RhQH43F0sHKKAAm/nsoDSiE8WaMyC71BuNESaYxfC17ZRCj?=
 =?us-ascii?Q?CC2yl4geeHUibERWMdyX290u97WqR5GDP2yxK1RzlBBccMi71HWwQHR5cM5Y?=
 =?us-ascii?Q?VDee5fC7bZmOyt4wBHjcQSdHp+udz3CwThyg3+2U4plj8K0LXcq8n2HUgW5n?=
 =?us-ascii?Q?NpX1I+JJpfQC3IK3JgWb8YIUouM9EIFbc0F7EAFaqRRi/6JV+ZlyQC2uwAru?=
 =?us-ascii?Q?8JsfhVoohOtKWMN485Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25349cdf-c762-40a4-51ab-08db77295b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 16:12:51.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DK0cBx2BnFXU89R/sOHmSF3cyLz2LrJ9dHW/4JGqHLsNJexBWo12mgPy1eqx+7YU03DqQ3zNnfvW9CEB1pGmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Tuesday, June 27, 2023 6:15 PM
> To: Lu, Aaron <aaron.lu@intel.com>
> Cc: Deng, Pan <pan.deng@intel.com>; Chen, Tim C <tim.c.chen@intel.com>;
> vincent.guittot@linaro.org; linux-kernel@vger.kernel.org; Li, Tianyou
> <tianyou.li@intel.com>; Ma, Yu <yu.ma@intel.com>; Zhu, Lipeng
> <lipeng.zhu@intel.com>; Chen, Yu C <yu.c.chen@intel.com>; Tim Chen
> <tim.c.chen@linux.intel.com>
> Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce f=
alse
> sharing
>=20
> On Mon, Jun 26, 2023 at 01:47:56PM +0800, Aaron Lu wrote:
>=20
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > > ec7b3e0a2b20..4fbd4b3a4bdd 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -389,6 +389,19 @@ struct task_group {  #endif  #endif
> > >
> > > +	struct rcu_head		rcu;
> > > +	struct list_head	list;
> > > +
> > > +	struct list_head	siblings;
> > > +	struct list_head	children;
> > > +
> > > +	/*
> > > +	 * To reduce false sharing, current layout is optimized to make
> > > +	 * sure load_avg is in a different cacheline from parent, rt_se
> > > +	 * and rt_rq.
> > > +	 */
>=20
> That comment is misleading I think; you don't particularly care about tho=
se
> fields more than any other active fields that would cause false sharing.
>=20

How about this one:
	/*
	 * load_avg can also cause cacheline bouncing with parent, rt_se
	 * and rt_rq, current layout is optimized to make sure they are in
	 * different cachelines.
	 */

> > > +	struct task_group	*parent;
> > > +
> >
> > I wonder if we can simply do:
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > ec7b3e0a2b20..31b73e8d9568 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -385,7 +385,9 @@ struct task_group {
> >  	 * it in its own cacheline separated from the fields above which
> >  	 * will also be accessed at each tick.
> >  	 */
> > -	atomic_long_t		load_avg ____cacheline_aligned;
> > +	struct {
> > +		atomic_long_t		load_avg;
> > +	} ____cacheline_aligned_in_smp;
> >  #endif
> >  #endif
> >
> > This way it can make sure there is no false sharing with load_avg no
> > matter how the layout of this structure changes in the future.
>=20
> This. Also, ISTR there was a series to split this atomic across nodes; wh=
atever
> happend to that, and can we still measure an improvement over this with t=
hat
> approach?

I just ran unixbench context-switching in 1 node with 40C/80T, without this=
 change
perf c2c data shows c2c bouncing is still there, perf record data shows set=
_task_cpu
takes ~4.5% overall cycles. With this change, that false-sharing is resolve=
d, and
set_task_cpu cycles drop to 0.5%.

Thanks
Pan
