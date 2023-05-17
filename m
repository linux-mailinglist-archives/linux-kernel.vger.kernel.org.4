Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C1705C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjEQBX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEQBXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:23:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8EF59E2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684286618; x=1715822618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FkZp2S4EiILwqYAC8H4ekyJJBk1YTIfeiMjtTZo7Ve4=;
  b=MwiV5VBkcQlPLxBCP6rQGGGL1L9w+hnVmYjOmz59a4IyVwx7lRZXYtSX
   yD532IrNlJlIQG7qWAgFM5/eB3b0RccHfH8Vi0ReG/90mFOpau35ZCHG3
   612J1M1RuI1WzPcCo62FZh+wVB/kQ0Q4d6ZpSffeiWqg6nioXjJUoLfOW
   wBn3q37lVS4ubH2blALv+EF43suzCYF2jVlSM49RyAg2Sf+Ej913ugGQQ
   s1mTb3NVeBx+zHS0FKijvC/+fu2nWBfK/Zf21blbzZUmYwLlB23kYEh2T
   tuCRz+6RFb2tAFHXwHid9qn3+p7zaYn0Qj8hzAbFbLUZTsHZxDka/1PNh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379820889"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="379820889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="1031498979"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="1031498979"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2023 18:23:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 18:23:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 18:23:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 18:23:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 18:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwQEQrAArgsg6dwVGoePqmN1w517NS9VtgKMndasCqcRYKOBaYavf53OIlSKq6K63VvracBtr+hdZvLI48eBeNtbjgQurk4r8V0FnlMhKxF3x5C1exU3UJumYu4vr1w9InFykIj8Q/ySA5s9/teEA34JH8UQSfsGGyM6jNQ8FBsE1u8lYLX2wRuEUArvCSCwFtu9klznWR5bUDfZT537ST1CibhxupvlCIiYcTJ3vnKqEpqFPn+zZ2Ul/Did7yaD9YYl3VHb52Sf0PyDS0TRAgAZqZpSRdgo23wt7v7qyio7avnQhMs3qiA1/22EdTEOyh5p9t5CH6JSUJGr3Enp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+SKjGOw4G+7iEww/GfRSVXdIC9h7yTBzfCaCINIAZ8=;
 b=O/0L8evf2MtSc2zIl8QoHqocRauSXMZlXrNAAqHqyzvU320QcJYeWFoGaMigTzPutDzTiP78DjY5p31ZO8Xqj1cpOOE6mWmX6yZkm3Fq/lAcPQ+/v99VIwOcdA7IESGKsPB88r/UMbbV4pJ+6YodJD4M1YGtxZJnUWjVKATTMs/JDtiVC5AlsxmwyGZMs39X8dqZsUDMvTFTQTnfnyITtrcJadUKJcb/mSCKrKNKf1NwNQYLCLQ6IZaHPgKYyMmWqFJ75hkAVom2xgvFuvVGdqE/AbknShdySJ+/3uMQmns2GvT08vp7ztooVwlKuk/OVVFNQuCIfGEDe13Swkeqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 01:23:28 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::68a3:c079:2a7d:7fe7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::68a3:c079:2a7d:7fe7%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 01:23:28 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel-team@meta.com" <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Topic: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Index: AQHZiFJiFhHsKByFk0WD/OUS1NT5la9doHfQ
Date:   Wed, 17 May 2023 01:23:27 +0000
Message-ID: <SA1PR11MB6734A17FF1E12FC3AC256C91A87E9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230516235817.2323062-1-song@kernel.org>
In-Reply-To: <20230516235817.2323062-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: dedf526e-b9d8-4a94-24a3-08db5675516e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lPqGc7df4QquMfLQ40Arp2XAa40Ew3ss8vxP4SA6bKc9ayUEkshsj6ue9zBpTf7pEifEdHRaEjyyFWyIFpabejS2tvw1M++V7BxJJkXxU9H1M0i027hPZjTm89F7dJCIC0m746cKgcpdGTbVemWk0TvWzX1UOgRb+yB9sVud14nesZM4kin6DfcuMNeSFDZnwJd/YwsqjPP6OVC8ojIIBL7d6u7k3y2B0iZOLnkF3D87d0lg7ycwoGDqk8M7dOIVQu/QZiqBdkT8vN8KwMl4esGysh1UFukxxoBFaWqIxBlYJ8058vgTObnI9+D8M5HgKch8F4wQwa1k06Uag+K/9YH1G6U7Jn9E/5/gpgxtmVZ+UcsBduuw2khfmRPZajk9D1o33X++TQU7Y15+jkehCQS84Any2R72sYiVfjqGUvzsENmbadyAxhDHneJIg4YW+i0RunvIj8Hi4Yk9AXNQvx5txNFH4skE/Mtf2soBV4UwFWhPMvoT+8W15GpyOCQogM+bKRn1DGuCiYbFAlTc51gMH/Mq7fGA2704pFE6cManA8wcS7NsEHJynpFPS5oI2aIyVElScUBJeeQg3OrAgZPcptgSoWUcScvzdMvRE+tQjdx1xchhhD/P9WQxnZ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(82960400001)(71200400001)(26005)(41300700001)(55016003)(122000001)(38100700002)(186003)(110136005)(6506007)(9686003)(83380400001)(8676002)(33656002)(2906002)(8936002)(5660300002)(52536014)(66556008)(66946007)(64756008)(7696005)(76116006)(66446008)(66476007)(38070700005)(86362001)(4326008)(316002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DifEp8EJlF1kJCutlcZXnQ6vkJmZ8o7fsuCXs7EIj4Oa9umE6lPJ1DE5/rWi?=
 =?us-ascii?Q?pDnkqw04h54zgdPUqgMF2WAra4r2+gouSN+TXzN5RrDyhDyMSqBTtuNhasHh?=
 =?us-ascii?Q?UcrnekFr1IcC86Gybd8yXFbDyh1Ska64O11JfJAfddazXRLE1W6kvCv/PtT2?=
 =?us-ascii?Q?tw1DJQxz7ZiYuYjyHM5mqWuE2/6NKiumdKG2dfTqCGaB3cBDEkW4Nqr0UU4p?=
 =?us-ascii?Q?pc6P/3T1o5Nc6RS5rYI7cLXyIlX1TDFf6Cg6hIBnLIu/ptRxH34K+r60KvEx?=
 =?us-ascii?Q?ZvCWMtUvSK7JT6+aDuLW+tr4MOREbjIrzFjJMehVVLZ288PoM7H7hzkl0vi/?=
 =?us-ascii?Q?cRJXYpifylNIAInY7Bmr4h4ITyPRjPAQRPfV4w9lQaA2o6gFZi/x1qYoz/Qf?=
 =?us-ascii?Q?cQbrTT6pWrvCqU61QvFZpdpxjJh3Zs4OGlBuyF0ntXsX3DVDSagwb+St+xwL?=
 =?us-ascii?Q?BYcTujtLdExaBuYQhIt1lKVNlia3pevN+MiisAvpSC1qRrVCS8p15yEK+w/5?=
 =?us-ascii?Q?Z5qcUNeiURDb1uNLOpaLdmPXQmHY89iHc9o47Bc45K1zXJQtBB2DdJZ0KRPE?=
 =?us-ascii?Q?fs7l5vGyp9UcZ67a8HPwmNpWPrxcw4OfhiPpWR4KkNn6umpUWbx0ej9WuPRQ?=
 =?us-ascii?Q?E7E80u1QrS5OEHwk3vPz+p5ZL0RDXTq55N40Hq8Fj8B/NDMRbuz8/FPlngGp?=
 =?us-ascii?Q?Ys12dbAmTYhjwCsn0xHRdeXIkGOeMPbHQiCOtH7hI+jeA8x69Sk3Lil6vEZv?=
 =?us-ascii?Q?xJRT52YU1j+aRlHg9TvTfOvFNK4IWh4QFVmjbF9e/9G/T1p1Svev5VPBM+2q?=
 =?us-ascii?Q?6BJY/8vMMlTYHBWky/Ki1ngg2z8yRUk954A0Lnu+5BtOiWq2jYsdoYC7pDHe?=
 =?us-ascii?Q?UkIcijzvsiyei0qogXUPZ+6LHYqGW+9xgmmum7X2k0jGkCET2LpGUuUnKd+o?=
 =?us-ascii?Q?G232RGZW/IYOi5t2Ms14qobjORFlKoSwOdlRtRsml0YsbGiIPfWmA5VtLfri?=
 =?us-ascii?Q?dVnBg44MmgO9+MrvIbKAcQYewFsMdJhaI+m6oDNBiF41fmY+38c9f1G27VtJ?=
 =?us-ascii?Q?RPAjY3ozRg//9wmoqvicw1iFNHn0GYewjOJ0zwKjajMn1/hKr+r0b470clHD?=
 =?us-ascii?Q?p0XIvXUo+Dg29iG8lququNPc621lG1K2MPYOWvhKuv6tJoyR4rVgx0AtnVvb?=
 =?us-ascii?Q?8mX9UCYACtqUMdaREMxybxrw71qjhWZziE4FMblXTEz//6fVLuSq3y0pW2gD?=
 =?us-ascii?Q?/iSfYHyj4E/RMZoIbYdufg+Gwn6nD4Pj1Y7s0M6gQhnc4OnAYW3vPs/XEoVW?=
 =?us-ascii?Q?haGjbzslb85miaAvm/Bif5qecWSOgz7RgjCZKsviKRr1SYH6RlN8lq4ovRN6?=
 =?us-ascii?Q?gyrxOsWffmsb17KZ7xwjIVbdRcRZUnv1+/kOCPM43ZOJdPZx9LXPT25y+8NM?=
 =?us-ascii?Q?RAXO0IDhRyFmBd2ePEaF8KOA+7hV4INu7dItC9yl4oNxJbXf04a25ar3RA1I?=
 =?us-ascii?Q?xR297GXD9iKZxraQInpJI5/8kenJfLLr9XeM28K6Wotgtq8pW90fGSc8gRff?=
 =?us-ascii?Q?Zo5ZUqDjImL2+XdM+vY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf526e-b9d8-4a94-24a3-08db5675516e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 01:23:28.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juUjiVZGEbBs0qfzirN/OfNOyLGv2WHbqTsggVAQNKeFST7A6TY1P9qg9nGrtg2puOIGsWB7XhrN6EIPJyCoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
>=20
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarel=
y
> used. Try use "ref-cycles" for the watchdog, so that one more hardware
> counter is available to the user. If the CPU doesn't support "ref-cycles"=
,
> fall back to "cycles".
>=20
> The downside of this change is that users of "ref-cycles" need to disable
> nmi_watchdog.

From the discussion in v1, the users don't have to disable the NMI watchdog
*permanently*, right?

>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>
>=20
> ---
>=20
> Changes in v2:
> 1. Do not send warning when failed to create ref-cycles event.
> ---
>  kernel/watchdog_hld.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..a1d2a43ea31f 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -100,7 +100,7 @@ static inline bool watchdog_check_timestamp(void)
>=20
>  static struct perf_event_attr wd_hw_attr =3D {
>  	.type		=3D PERF_TYPE_HARDWARE,
> -	.config		=3D PERF_COUNT_HW_CPU_CYCLES,
> +	.config		=3D PERF_COUNT_HW_REF_CPU_CYCLES,
>  	.size		=3D sizeof(struct perf_event_attr),
>  	.pinned		=3D 1,
>  	.disabled	=3D 1,
> @@ -163,7 +163,7 @@ static void watchdog_overflow_callback(struct perf_ev=
ent
> *event,
>  	return;
>  }
>=20
> -static int hardlockup_detector_event_create(void)
> +static int hardlockup_detector_event_create(bool send_warning)
>  {
>  	unsigned int cpu =3D smp_processor_id();
>  	struct perf_event_attr *wd_attr;
> @@ -176,8 +176,10 @@ static int hardlockup_detector_event_create(void)
>  	evt =3D perf_event_create_kernel_counter(wd_attr, cpu, NULL,
>  					       watchdog_overflow_callback, NULL);
>  	if (IS_ERR(evt)) {
> -		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
> -			 PTR_ERR(evt));
> +		if (send_warning) {
> +			pr_debug("Perf event create on CPU %d failed with
> %ld\n", cpu,
> +				 PTR_ERR(evt));
> +		}
>  		return PTR_ERR(evt);
>  	}
>  	this_cpu_write(watchdog_ev, evt);
> @@ -189,7 +191,7 @@ static int hardlockup_detector_event_create(void)
>   */
>  void hardlockup_detector_perf_enable(void)
>  {
> -	if (hardlockup_detector_event_create())
> +	if (hardlockup_detector_event_create(true))
>  		return;
>=20
>  	/* use original value for check */
> @@ -284,7 +286,13 @@ void __init hardlockup_detector_perf_restart(void)
>   */
>  int __init hardlockup_detector_perf_init(void)
>  {
> -	int ret =3D hardlockup_detector_event_create();
> +	int ret =3D hardlockup_detector_event_create(false);
> +
> +	if (ret) {
> +		/* Failed to create "ref-cycles", try "cycles" instead */
> +		wd_hw_attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> +		ret =3D hardlockup_detector_event_create(true);
> +	}
>=20
>  	if (ret) {
>  		pr_info("Perf NMI watchdog permanently disabled\n");
> --
> 2.34.1

