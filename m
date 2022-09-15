Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC25B97A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIOJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIOJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:39:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CE10E7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663234772; x=1694770772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5eEUOqbu5YA8ehjG6gRifgBdp9KTXMfktM1uKr8LunU=;
  b=PblEkGM0HubLmLt3f77KBsa5YNkQvGXmmPbN1BTfag6/fA1ZgjDzBuL3
   DMzOxjsJhJscb66z8mmwFRlOCId5DqRf/2QC4htYYEVmTBALvRom8yp8S
   JczjcFwohgMwdXJMxSQSR6wxz0H4A6LFdADauCJeO+MLoE/x7OtQIEtCQ
   ppDvq0R26YFzoU1BoClVDzRi/GYEpQAv8cRWv7/J2OXN2+NJA+M+LplTk
   CQJLQkar/919ythqgu2c/CKKUEAzzW5hVA9RjCtifxmF6VWTtyYnemQco
   HIt+FNzWndJQbIlxk2iZ0aUQ7paOfrIJ5UqCyMHkO8sEFjkWxqwjPkvg3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324927396"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="324927396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="650415432"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2022 02:39:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 02:39:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 02:39:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 02:39:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 02:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWe4MEAfjVHZOGefwhMSzFwPXsNfY4uyCkyPjL8bg0wKHj+//bJJtJu5pfB6KQdtVYeAPZqX1VkD5RUXF8ic71TnGpt7O+WieIQzn4feO45tsBsbwTlqWnAFJCHJThx3qb8JaJgZMfWrTnp9n6wsb003iNADnUZfub+7GrG3YYDmJcXEkLbs2LGOIY+bmqUJRqJZgeOqfjyzeasb7recBwUm/g9kElhtJQuVBmoGzM/lbPTUay7uDPwcD7eU5wkZnCWzjn8PsB81D2ykrn14+yWA0EEYRouVsxFZyAtNNHuD0OvJvvMZF6RVBqkm/WJZABcLPGXnso31P2HmrK84ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eEUOqbu5YA8ehjG6gRifgBdp9KTXMfktM1uKr8LunU=;
 b=OTkFj77bZeDPskri4V7koeBt0NlQXX+D2ljxnGokfzs3akWKpD6k7qRdmY5NiDFe1R+xnCrScYx7XqBw0Yjbmypq7fRI2XmWOuFDcakyDlAKM0Xkj6ZTgGVvdhxVjj491pyP7akDHWfeZQUkwX5CCUpj61QrVjMDq8LMfh5FgilCninsPT7B/U0vIO97Y6H+AywDSL/YufKijBxIyJFpTPjY5tD8cI+LBZvYrQbir1zE5KMMScyTxxLmAXR8TqArh5WzTEcKIBHUBBRkkEzKQI4feUiK0hFjyoLmw2mXAHgvsHIh9/NvuR3TA7mEYq2fA0E8c1ecmJs4byWKak8RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:39:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:39:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Decouple PASID & PRI enabling from SVA
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Decouple PASID & PRI enabling from
 SVA
Thread-Index: AQHYyOImkdkHJkZyCUaT+aboDcUua63gPD8Q
Date:   Thu, 15 Sep 2022 09:39:30 +0000
Message-ID: <BN9PR11MB5276F03A090073F388B824488C499@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220915085814.2261409-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220915085814.2261409-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6268:EE_
x-ms-office365-filtering-correlation-id: d393fb3e-f7d2-44e1-09e4-08da96fe3037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcxrag5J/xttEYcJ+UDSBHYHhelk6yZunCkLuws1q79Cm9nYbPJ5z105i5FyOQlo1V5o618wp9xtUGE8b5RoFdT9VIl4Jv4xTRQpAuVcMkLqWIH6cQi0y1RNjKGUm+FeNArzVTzbA6HM7LV5+ki/B9NnrHmRGWIx/pBQsmYSfzVAVsfVaYh2ec7HmznDoA8bKe8TW2q+rhUowR6BpSChvpp8+0vDE/xANHN0pL6cUoce4lQq25Nz7rqOJNWeesXUMOvXsYReKgduhK5b3VwVnCTE4WMhV7BrOiBHvpqhA9e8imW/jEujBdQHLvos1CTpxmmRoJzRrTj0rBdV6TOEA+Zkjk1WvW94Mqq7H7xChNahyxjEd00D/TLqgqhLyEBB43pwLJCNBAk5AQmfaTlLMV1bqpDupWchlbBk9H0Hf2tke+s2y2Z7Bc1IgVVZeEtXEXpfwMSZAO+1oSti2ZJKeIFlMCytZnyy82OE5yHU7ETe5tgUFa7w87SDN+gMsYw27Rin8ptSK68eec0A1N6cXp5e55pff/h7xJz8eY9hjDrIttfhZhhNvVqPkgWbjQW+p69ajuZxHU6/49WXw9F/ZsFjU9ukSTQr9mnLzYP9KwbYALdlo08vFnqIOB76f2fBZV5oJ5n3S9zmvWUD2WamP+1B7kMKET8O3MAgbkBQvqpn1+zh+7qgIQwsYV3D4ooOQMT+HkgOmJkIudOdePllyn/8WChVTR/8AGcFdJBD2NwxJbu70xbDa5rQLq4gRD8xG507byYuA5tKIo8vvPBUjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(7696005)(2906002)(66556008)(66476007)(26005)(316002)(64756008)(66446008)(66946007)(4326008)(122000001)(8936002)(8676002)(52536014)(186003)(6506007)(9686003)(76116006)(38100700002)(82960400001)(41300700001)(110136005)(54906003)(4744005)(86362001)(33656002)(55016003)(71200400001)(38070700005)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?91RMOtuOyLnk82B+5HKQi5SEO4MyKeTtZF+WDedY38SdlX2vd7+Qnnr9MrH4?=
 =?us-ascii?Q?7x3aWanWiLw5sEzr15N25uZ4Ya5t1BADwUVERgmaucKwTfib+ekiVrBhCels?=
 =?us-ascii?Q?K859kIxc8CvPQC5k5vvLkgNiMnZzlvTpGNf8orqvKvP9j1HxfVtm2SuEldJT?=
 =?us-ascii?Q?0LbAaNNdwFYntV4Aknn8eNhnhERF3VJp+uVk6txh/OqVcmG0qrpUf9LDKpXC?=
 =?us-ascii?Q?Onnb66ZJ4hfkshzmGx/3JvqdW5ROQf+pt64qQjB4q0ShxsrgRPNoyG8TZAg7?=
 =?us-ascii?Q?acKFcqeo8gBX2GZUEHE18GyxFlgQIBSKdUfQv+hCNYTM2A6Dp+fe71BizQWK?=
 =?us-ascii?Q?yTQjD14fMTWrL2Tbo6Cmr2p9blhSUFgIKBQtvO+l/krObzc2lPGZolXdZxEB?=
 =?us-ascii?Q?1J0WGrR37pyd189/QtocdU8JSBLlk3UW34hfiyNpJp6zZOp0W7+F7K7/+4Z4?=
 =?us-ascii?Q?hZAcMPXM5BaATBukFRnoZQh9Ry/m9pEcKQcDwkpki/3r4QtSb9e59hJqNgM5?=
 =?us-ascii?Q?QS4xOZ9WjaxJ7qeP7eDaD5qTsIuu3aaUnpDQVkzbPUkpRzH2zSUn+QzFJGYv?=
 =?us-ascii?Q?sRMaBwpUsXrJe2i/RGZQCVgaKOrIX7II/iCO7U7+1WwM7JqN5R3IhZqvass6?=
 =?us-ascii?Q?boh0S4+IUh78P4dcn7SQX2QUX1gwx9I7DpB1rwMaXNN8CrrthZz5oxjYj+kz?=
 =?us-ascii?Q?NeTnAmjZNF++ln3yj6PHg4j56L7msByOZMqx6xV9Md8lL9LT4oyi3YPtSl5/?=
 =?us-ascii?Q?vaEjZ32Se9BcDycqZRch9cIyrNf+NGKyFu4JTv6R+tWc1NSDjm0momt1R7+s?=
 =?us-ascii?Q?D9rmL926Rp8jNd2xwWO0INRgitCOfYpdd75jBYfkvlF22iVywmIJohxf3lUc?=
 =?us-ascii?Q?f/Yr7J/+FbmX0Oo2r6cWiiSvSbZ08UsPwgqMDkBzKrkKq2LnRW9sgkFbyeJY?=
 =?us-ascii?Q?tuVeoK+1sAc0eRD1M+EsN0ULpFQCuVxSK8knyAR/83wui97g9MadDeyEnr8s?=
 =?us-ascii?Q?aFXyqvcCIBIGT3Ft309RQC8VvOIptnl0bo4o7/IKWNCMxDD2bEfnQpv/Gf++?=
 =?us-ascii?Q?eeUEqO+JnZr9cltD1rk4LPX3liK8Isehla9tFMAx1SPuo+Jp5TV8Li/lOMzj?=
 =?us-ascii?Q?7YOJ+NAzXtbu4meOVKixcjVh2fUL6J6048qhXTekxODBz3d1+8jfJP0pXIk1?=
 =?us-ascii?Q?1O+LMVRKwyYNA00W8Vz5P5S9V3svx32BrDZOAdstbTLr/fbV3NJh+/8GPnsF?=
 =?us-ascii?Q?bzjSUFwoX5ErwvhTQxwU8QpIwugSwuOuIx5BC0IkgAk5nUknX9+I4/qZfR5F?=
 =?us-ascii?Q?5EIOKmpbjSSnJgkIteNEiblKGB3jfBlxV/ZZHYFGiDyoflrL/yCtLkdU3gHe?=
 =?us-ascii?Q?6Ywbe+oEC7aoUD6C5E30QYyGHcdXi5hII+lL7fHamxNXDn3HksyxMZ14QWFJ?=
 =?us-ascii?Q?3ic7lkXMrORHp+a2vFdeTigutlpGI4oh8mtpJl9HFK7GWe9PRhbFQuQzPOEe?=
 =?us-ascii?Q?GnxjoI/xXeRPyoo2gYW2xdyL7BWFmM50/U8ebH4IcTfWpg0YOoAoQIonKvHQ?=
 =?us-ascii?Q?AfZSpyrFszVI0/WNRri8lciW/2GppxxW57Rt5owo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d393fb3e-f7d2-44e1-09e4-08da96fe3037
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 09:39:30.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhwM5AZ4VdNqUH/oWdvAAci7zGEbPrqTFoLiwBxVLXnBCrgp0dPMuw0Fewm0gGeYh8Xvket7YNc7j4lnmqqeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, September 15, 2022 4:58 PM
>=20
> Previously the PCI PASID and PRI capabilities are enabled in the path of
> iommu device probe only if INTEL_IOMMU_SVM is configured and the device
> supports ATS. As we've already decoupled the I/O page fault handler from
> SVA, we could also decouple PASID and PRI enabling from it to make room
> for growth of new features like kernel DMA with PASID, SIOV and nested
> translation.
>=20
> At the same time, the iommu_enable_dev_iotlb() helper is also called in
> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's
> unnecessary
> and duplicate. This cleanups this helper to make the code neat.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
