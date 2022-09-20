Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78E5BDD29
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiITG3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiITG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:29:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7938D10FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663655372; x=1695191372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGDcSBGl7/q2MhzDKae/DMdo2pYdyEdjVgc2vVdQPPw=;
  b=g1jEz9PKu/Y5vL7Rlj9yECoFRDZz6qH9x6F1mHbRfAr6khBQM3cN4Gn8
   VvZG8ud6k+nnjBFGO5AEpiv34j6dlvBvcrgqysJ2kUubDFmnAjyFP4NwB
   FxdvaW4HN9JY29jz5IloyFlPyHshxn0wU+9WXL7p6ZNMOS0E74+OS548S
   +VLCFH1KyHZd/JAijk3LWW8dqgjhy/5LJA9yd8rs1iaUTOGy7Nl2QmFgh
   f++OcFyyO9Sy+1eEv2ct3oMrB+bVDJlnLXlxpW6yzmhVYcpP5QVcVvlxv
   6RN2lqsHjd25kx1s5+9c02hCYo3HmYEskBHvfgNrEQKJeHGgh+Y6tVUgC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325911604"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325911604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="621142132"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2022 23:29:31 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:29:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:29:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 23:29:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 23:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz3DByobDn38CkhOpPtHw+G9x1UK1njGgvFXGRLxHKmAI1qYy50RE6sCE7qQeovDZBnR+U3odT0biNCaJS4B7U3uc/D81vuIyA5fFu8qikqoo7Ah9RqRacix/3uZMREO0SLk6WftjWoGLisoVA/geZlQpV4wgneEnvKUxs4eQEX4miO2pH98uyPGtm/KKhYwuXyWMix8/bAMS6vOgLMq+pZaRrNF3Yg5Rd4bMvJW+v0yY8GJfWsTzmnsjDm20S/Dc/B4tDQSUjqpr4NGQLm8JrPWTFonaHjutWtLgwbw1ow29jiIss39Km+kThQJOD7VdIoSKY5634JBIqg4eJHfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghKI4ggPU6lkzhiOakabRFX5NzxdZBvlCyvRPH+fnv4=;
 b=HVL/k5XCRnR41T8ToSwr+ANXE9F8gG2ydfX2I4TAwSj+MBmjlLFqfjboeWt/CNwffFUSk+RaZeayn/4UDHMvIbjHYDvyFiRKPjaaEwSmJj+L0oPDme+8mpM7Ou0ze4Qn9hXAGw2+O4ikrC7/hBdCaCBhghXzIngqx3Q3jiZF8WV5EO9SSk6dmVo3qG+HnsfPXfvawUz6zJ9PXv8LX/FetExuwkqU/TaFMphiW3OlnRtq97QxaVd1rMIsoHI+DVnKoz+G/AU8I6IEwEzNWnnN3skZNcszlDdx3zj8h3FbKVmb2tjZnwTLIJT2qZ/xgveBhVsnYCwOfMRCyHsZBpa/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:29:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 06:29:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Thread-Topic: [PATCH v3 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Thread-Index: AQHYyNj/cDYEVZNvjECqaTWb+umko63n4c5Q
Date:   Tue, 20 Sep 2022 06:29:28 +0000
Message-ID: <BN9PR11MB52768A3239F75290F7842D0E8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <253f8098664f78f5b5a8a7deb816af8ad7d37122.1663227492.git.nicolinc@nvidia.com>
In-Reply-To: <253f8098664f78f5b5a8a7deb816af8ad7d37122.1663227492.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4902:EE_
x-ms-office365-filtering-correlation-id: 3f08ec92-ca82-4323-1b85-08da9ad17867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aGYhKQyMBgcFJVycs+ozRA/xXVJXog4kzY9qVS7rhk9ZO11lTA9kxOXxTG5/9pEOstJjG57kVnGMI/dFBlsSRaGX845EpAkRLxv/GPar3pV7ItpAV9ZYxFtg0+4h8PWEGBo3Ad6ZZ4IpfX05QoIvE74px68qB1DHfMTDgs798bOLK4c55b/LLdKGUmtbmL2TWc91fuUlwmKYVPqumnc0erPn4mC4uZHSrPAsdp4P5sqcpGhQuY/ZAaUNRo0V6fS3DylW14eMN1hOXNTuu5psYpCg+UzuhL22FbYxe4q1qOwQr8IHYQJ6ZNiz2Cc7X5XieFWZxrNoZXGD1GNyLJBcTEqSgMHL61k71tbjdpYe9XZCQNmSYjgm1qWRZiiQiNdZ7aodqd5Z5tf0QAyXfijrjuhIhtpI3zt54YgeXR++ZjGsVPIr578tGDNSB2WR64MhzXqD73W6aKIo3qX+WqfCPgyAMZ77G/4iWnVkRW1EPk+5LhVv/6nRBztwtmGAJ3oDlh2E3h44K/0xpjn4IGlTEG5YVnIFcuLkdL1dD684xpVNjIUQi8YAu1+fWIEtpmRXQEccv+nX5wK5VqQRf7J6YP9EAF3oqXk0YO/0xKeaZYsjKwUovSSZxK3R0fOUNGDG4ENSXV5ENYD+rwJtp0FoAHFSSaWbLVIhG1nzh5FgSJ+MrN8gO+eDuXJgTH03qQ0I9Yuf6i4J+lpTvEVWFfE6vv4/3pPRWv04DDa9BSopm8VpgIOaNb+d+sLEKI+TRow/DdrLJ6h5qglAeYvtXSg0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(8676002)(5660300002)(186003)(316002)(4744005)(7416002)(52536014)(54906003)(478600001)(55016003)(8936002)(26005)(76116006)(86362001)(9686003)(38100700002)(7696005)(4326008)(38070700005)(71200400001)(6506007)(2906002)(110136005)(82960400001)(64756008)(66556008)(66446008)(66476007)(33656002)(66946007)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0BxztJghTeL/0erl3+6xbXYTPVMJMgoP+U6f9SYnr+7WEYj2e3oUj6e/JP3l?=
 =?us-ascii?Q?PKmdvHwf9Iea2ylxkLZXsbiMtt5n2O0pA67kjhA+lMarcRH0CMlptOKN5I89?=
 =?us-ascii?Q?CBDwujqU9SE71pr6EAi2zFhy7nHqKAcAVpz0SDumSxT4oD2snnoewnBGde5+?=
 =?us-ascii?Q?KvJFZGXkYnpREuTVB8/NX9Z/5ylehhp/KQxjwbFWElZrtwH75aJfoMmb9ppJ?=
 =?us-ascii?Q?+KVEs49zn3aTuSjVAEQ73ElLqOAw/9s7KrFH9ZSoSX6CibicbXSyoogeBInx?=
 =?us-ascii?Q?2YJW9gAkeBcVpmgrSIqJUOyVxDLamzAK65t+x+YuAFZH7vFRwKlZswjzk4Qi?=
 =?us-ascii?Q?4M7zf63aiGxq1mKN7uoO0Y3qHzwh4ZtiztOmLmswfSgKgXPH4D2N4MG0JgWk?=
 =?us-ascii?Q?mYHJUas2+O7JOaYyk64BjDSeBbf5Xe6YWmAkOAjBjIemz/tdN24qzukvHqLt?=
 =?us-ascii?Q?6Ha/lIElXpq9ykkNqLImaWMfiZWqgRrjYUHFphLEOdCTVgnRXg55jVqLjTAW?=
 =?us-ascii?Q?rt3iQMLR1Rg6+oGAPbsZCpCbwuxEQNrSmtR+SZjM0wt1UgYkUcRU+XLFTpxE?=
 =?us-ascii?Q?yYFwTzm8m9PnnLZmpOzq0ZFoVy5ECgRfRE9NJHr7LI8HWR2ecdStOvd+GQ/K?=
 =?us-ascii?Q?QGLhdOlpTkkG4C4+iOY3d5ozNhg1ilSM8sv5TrcM3YWC01cCU5kTFwm5xXY3?=
 =?us-ascii?Q?/v3AM2dqw4sOzorW7A87wpdDmMZwCzzsv6/3jFLAvc0GAoJx70HTdTRzTmyY?=
 =?us-ascii?Q?gvde0sj6jFnZC02/I3wjDRoYpgUkqoZGlzy30ytMiQfqjZI3YS6bfYFel0oF?=
 =?us-ascii?Q?X3jEDWf8N5e0UvZOhgCK+eFbXYf4qC9FVCZ4TFjVh4owTDNkRrhFIPXdsq+P?=
 =?us-ascii?Q?B/qtRkCIb0IgGlneiuBObl01/b8MylHzGbNZFWHzO5Vh3lstX1TcrPeBFJJm?=
 =?us-ascii?Q?14+cHKgXj2U9cAlMTP01QjQqLODnlyiYVmvjfj425PtD9hy9WUQQPhJVa5Fb?=
 =?us-ascii?Q?gWx8lVRPyDxkwrZtsxl+9PVLHv3swZELH+BIPZRxe+w+mw5sE6OEdVcZy4K7?=
 =?us-ascii?Q?KlYd6ReX4lbEOyyRkoQnvTmPZxqrIR14LaxMYAhxHwDZ/ITM9wA5BVPPo4/t?=
 =?us-ascii?Q?ZP6Bl8l6cLy+iRICyE7EDW66evcSou4sxtDNYiQR0uY4gk7uxGKeTw20l6N5?=
 =?us-ascii?Q?wZ2eZ2iAsx2TdmczeezWyQ0h2iMVaWxHU6FLc/aLiTi0WDtxUV/1en7KoX0R?=
 =?us-ascii?Q?6gouqzeYh8gAsYLKRzNc3R5d7abn8DzIoc0kvJX977qCvjnxrJ6KV8lzZ+NC?=
 =?us-ascii?Q?cqfiJt2U/XcQlDrO4GeP77FM+G6efkOvYLNsFnYEjGFIDxBJvesFKYhOFQFy?=
 =?us-ascii?Q?8XrPOyxKIIEqI6AZ2/3BJGxiPvNjbb8I81VfQU4M0wLALVPcBst+Tj8yH2lA?=
 =?us-ascii?Q?Pm108/5+uyDi4Y/WFaTfv+j/x+qfSHS/hFbQMWDHf/yAS3gOD+dx3WC4bj90?=
 =?us-ascii?Q?L1R7XTTA1M9bccH6dM18KInGF/05Xy5eHG/ljL9i2cgLxx0AcIkUzU0gx6Vu?=
 =?us-ascii?Q?DtzZUqSd5F7twqwKsqP7Vyenp1f0GKQSX8ZRN1lT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f08ec92-ca82-4323-1b85-08da9ad17867
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:29:28.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7LwIG4V/dj3XJvgG0dwyo7YFOTNYFT+DQjc4dw6ekrwFiZMP/669V+odzed9PTvSX/gX6KvH2BHl+3dvJY9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 15, 2022 3:59 PM
>
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c5e7e8b020a5..4cadbd744b7f 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -101,8 +101,10 @@ int intel_pasid_alloc_table(struct device *dev)
>=20
>  	might_sleep();
>  	info =3D dev_iommu_priv_get(dev);
> -	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
> -		return -EINVAL;
> +	if (WARN_ON(!info || !dev_is_pci(dev)))
> +		return -ENODEV;
> +	if (WARN_ON(info->pasid_table))
> +		return -EBUSY;

-EEXIST. It's not a busy condition which might change sometime after.

btw below -EVINAL in viommu should be converted to -ENODEV too
since it's a check purely on device side:

viommu_domain_finalise()
        viommu_page_size =3D 1UL << __ffs(viommu->pgsize_bitmap);
        if (viommu_page_size > PAGE_SIZE) {
                dev_err(vdev->dev,
                        "granule 0x%lx larger than system page size 0x%lx\n=
",
                        viommu_page_size, PAGE_SIZE);
                return -EINVAL;
        }
