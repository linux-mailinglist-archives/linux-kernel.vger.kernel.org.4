Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364225BDCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiITGPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiITGPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:15:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E059276;
        Mon, 19 Sep 2022 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663654539; x=1695190539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TWP4wALRO+a9oqJvxi8INlLRqTbmeCqX3DpYoUqq9PE=;
  b=mmSihQlu0fJxsw9G6P7AB4ofoNvZ1vcEkQ0Cd6W4hMI2Yxc5H6H04hta
   NWhxcM5DDHeUEOGj/5zWxWFwOiTE7kayep9xksHt6UEQGJ4eHG3i5A+Nw
   1c5o6PqR6Xl7E3jqtCXjjygTD5uiA/zGlc19PJxOeQMNHNoWiAG8XkylV
   sQyZN3VNQn9O8v9MYnWm93vNf+Gy7g29/H70vEjh27KwEeqeUr/QkeY1b
   it/1x5qCfrVLNOKUp+Ri04OAqq4M5b4DqAzTSTRSqGT0xfDR6crDOf/6L
   szY4S8kV6FqfhaqoPALMVjl5pypKk2JAZt9mEfV6iXnTJHmhrbFWz2vCL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282638124"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="282638124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="761175681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 23:15:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:15:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:15:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 23:15:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 23:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX9rqmLUYRQqk3mx7P14WMeYLxHHV92470uhH+nk/y8N3yH5ZTU8T2Qb7LVQeFFSzKpGzeXU3hvb5LYeqrFxFRl3frx+yV+p8zEZtBjxlSsj+uPrwmz6sRP9QGWo0VyGoJ7fwGGnkG1Upvv50QoZD1c39LPsdG7hwGMhA47Zus/iMNI0W7G8QSSm+xKk+JJUnkeVfNzdTgbFDV5M4VcGdFiQ8QH/C/wZHZtqotjbY96bKb0RtD/A1pFRmHlhMi+jcoxUmCtdU7CoepXKSY37uGM6BXG4LSqSGI+49UmB7o7GsU9hW3ed2OtDjfm6+Km6im8Sbrrx3FiQvOol6NPdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMDK89mR9GtrlbMrrbET/3dMq3fBV/1ZnaQkS5qg3v0=;
 b=WKzK6HTPS1euQ0tIyxATrUtr9pp6R5A+lWft1TEJFdhlC0C9rCoJbNo9L9n9P3IY5CiLcuL2gIwn9WDM4LRarvuxEmUEj8in7o1mnC2vbEZ655mzGiuySWgX5QmDSHLO+29ZP0K83VgSX7291YSt8X5Vae3XupxRgoCwbZuupnfBSegVKOZBAC+wyQehXkwVyzGSgKFRgpRrAu+PKz2wMy5SICRhanKOv8SI96NJ/Xk2HwNReRI4MBWuGgcjFLnAz9SNsHjjHNuoqghU7kaQqp9d9e5THPuorGkpfroh93hy5dIZjd4LoKZhPAEieMzfODHXGA+npmXQYBNxaI9QLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:15:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 06:15:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Thread-Topic: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Thread-Index: AQHYyNituwz1+Ol9PE2n60Ec81TVG63n3XuQ
Date:   Tue, 20 Sep 2022 06:15:21 +0000
Message-ID: <BN9PR11MB52769AEAFD33D2501B6571538C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <031c4ec032025a299d72665118d58dd48aa936ac.1663227492.git.nicolinc@nvidia.com>
In-Reply-To: <031c4ec032025a299d72665118d58dd48aa936ac.1663227492.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5008:EE_
x-ms-office365-filtering-correlation-id: d6ad4aff-94d6-41d1-1554-08da9acf7f6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+KQapMUjYZCzMR2v8t4rUEA8Sn6m2TTY6Ro7xHdI2fRKg0WycA5jmO/gYyxq6zLUlUikedRjZN0UoCGxlm1mdZ4B4bCw1ZVHQH+Km37Cv7vWOdDNWQC+DJqgTVEdzxgEjb2UC3JJjD5TAZab+tVY7sAX6bc/5Yaj37TG2liVFyKngtCxAdOallBK5ly5jnl/f5jzGaAcMdlmvSPwBe2DzM8p48T4SXZCj25mXRzErNS/oyyhFmzp5W7R3QTJ2CZIbByRJeoEOloRHHyUn9ogD0SrIQB8TOWKNBG5O196kYwBu97dt4n0MQvvDdxbx5jiq9UEPCMMBs7FyixQRRUAMoG2l/5LmzNFRGNADLpmx3XplMIPqXUBQIKOQP1D3zAiiaDNRmWa+gE82uhLtwNIPVmzTpa7rhwHcsUZp4oz3FqFtIf/IbofHyj9fS/gcfXWuz/sy6gGT4yOc0bKH0nQM//AuxbjkEjxTtI8bFAKkWZN8qlnmDmOUkyUKVfrMI3G92MuZsB+PUJIoxysmPT+PyezpmZzaAfrKo68oNCZQ2ZEplGHyV9qdc4zZzwdhkSq7wkGrgHMF4Vw/CFO3dZ67P/iGQ/kKft1bCwElb0UPfwAXPJziET+O84gHt3eLL1YRpIBJmv3vGhwaopo9fEouXtG5pxMBATlNHuKvVucyQEn1rtJm0NOgEUzRJBCivm9ThnEa3aN71gfzbRgjbpQS9YP+gKMMH4sSAVvZFOeyy6K2tnahSmpm7SIsbSsxNcP79vkD9VkQp9Dd/jTAOqNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(66556008)(64756008)(76116006)(66946007)(5660300002)(66476007)(4326008)(7416002)(66446008)(110136005)(54906003)(86362001)(8936002)(33656002)(316002)(122000001)(82960400001)(38100700002)(8676002)(83380400001)(52536014)(71200400001)(6506007)(7696005)(41300700001)(478600001)(186003)(26005)(38070700005)(9686003)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rZGr2d5jBikEil+XQ56fPAhz3ewviQCVj5dc94xAm+K/tMXvXBcAuCmcVsmY?=
 =?us-ascii?Q?/2DZOeQnPRWMz5bDS6geMCnbgmzTlfFSRSQuJ3oFbxVjWEdZ+mP/46X4I/b5?=
 =?us-ascii?Q?91MQIcBg2zce9xFzFS7nvtsbpQ8AqUp4He43cuIpJp8w5cYDeUWO8YzLsdhm?=
 =?us-ascii?Q?3w8PCOosvOKOQHhCDBq10dABkxRcL8yopVEi5ml68ZXMxiIlTJY7aq5qiaDy?=
 =?us-ascii?Q?EGGccWVuF2i7XnfJb3YIrlB1KSFBQtta3mCCi5LVCyGTuVxTY3G/VgLnJnZf?=
 =?us-ascii?Q?0HG9uI5yNcF12kggejzoG48DXb8Oe492+wlyGJwojIhfP8pvb8GeofSG7Ah4?=
 =?us-ascii?Q?NaepXKdQVBWe1WPESQJPu16CoGmrpRQ38s4Weu08DHAlhh4outomA1eFMTQq?=
 =?us-ascii?Q?aXkaCN/Lf1g2SM2S6Kdi8o62HjCzRuSSgpbAC6otHG51HgpwNVmQ5oOP/6Hs?=
 =?us-ascii?Q?9EOTulbCQCdBhWmdqkzbjJhZwXUw1PkdJzzxEuUOSaSs1rGhlJJ5lNKN6WZL?=
 =?us-ascii?Q?47Ufel4Ec4GFXpxv+Qa8WBUhuV0GgsTodeJfs2R6l8+VcLwnhKxNBpvXa4Oa?=
 =?us-ascii?Q?P73BBylpMJNn9/r6SYpErjn4Uo2kQWNmXgLR2Okur/yK+X2lw4h12mbiV6KG?=
 =?us-ascii?Q?xFRGNuEMQwd8wDr6Cjm6zqw1mc+ouICDpH1iOW+fp7ltby5tBdNNZNgYfOHC?=
 =?us-ascii?Q?VCHAwLacXMYCLHlf058aaerIz3O0abu0bSjOwVtE7+C3wykoS4ZCxK4knwHI?=
 =?us-ascii?Q?3X7l/wPCNvImncVweMvBDRFQ3DEVlPAUCzOh1PxWohf2hFuR46fZWlAo5Y3W?=
 =?us-ascii?Q?UIyLsD4typCZwrcHWl4ata2+HwrSpLIRT0kukFYrzm0fwvMNrpS4eaHdg6qC?=
 =?us-ascii?Q?2p/GgLwGK1TG4pcE/BJxFr8rauXVS/5bLZ+VwZ9X4iiah1eFLi7U95zVaWir?=
 =?us-ascii?Q?B7+GfgmFc/r6fMIrdAJYuetmn8eUxMx+yBcgPilyCKZAYMdWm6Teau30jSPx?=
 =?us-ascii?Q?7l8HzjZa41xWRif21q6zrDp9Nucsq29F6+Bv2dHLB9aIdDEmZU5Ji+ka4uxs?=
 =?us-ascii?Q?8/peXUXfd6rYRd3zM9QVpmHRKj4eRyNMJ5kJ1Ssd58bk/U4J3v/7D1lW42xF?=
 =?us-ascii?Q?XeMlQblMNSPRXsHG+n5iiVdEBlzTySOTFa0LINSSY5WqWjUtb4nNNMyUP+vw?=
 =?us-ascii?Q?XWJsph+v9L1e7IKcl5F/dgPfItEeJyZBG73FOMSZ4nyXwz/seMostoN+sf6Z?=
 =?us-ascii?Q?+pxyf+uUk/xoV60B2drJJNviVTPCaLwMy01Df8zrN6HVVtZfmR9+VOJSuoTu?=
 =?us-ascii?Q?mKxUFMszg6VLVJaFv8b7MXg6mIh7FtjVmQe/47nQXw2AZy/FW37Ccgu5DuBT?=
 =?us-ascii?Q?4ZL97z8AcrV4c1x1u41+lP2rymUBVlQpSEVEQ2lpas3Mw5HAOSjN832VNLa8?=
 =?us-ascii?Q?/nX5NnnkwsbF9+VgsYuCBRN3salPGof/nnbATUhKmMTMjx18hjbkYjRNCktK?=
 =?us-ascii?Q?WmQSbha/rY0+8SJHR+PHe2oXzj0T+LDfIEsAn8CW8VCKBd0cZBQ3Uu89kipd?=
 =?us-ascii?Q?PeG6AYhRYfIi0DoEHvHtJNt7Or1wbacWxppdhoMc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ad4aff-94d6-41d1-1554-08da9acf7f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:15:21.2666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UtGV/xMhZYvLnupr4RoLCTGA1XlufH+d090FsGSN6ZQm7qG9nDXLWiMB6PnIvIJKI8SnT8RV7UBKHRI6QGOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 15, 2022 3:56 PM
>=20
> The clock is not symmetrically disabled in the error-out routines.
>=20
> Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> Cc: stable@vger.kernel.org
> Cc: Sricharan R <sricharan@codeaurora.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/msm_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 6a24aa804ea3..a7d41ba4a47b 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -418,6 +418,7 @@ static int msm_iommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  			list_for_each_entry(master, &iommu->ctx_list, list) {
>  				if (master->num) {
>  					dev_err(dev, "domain already
> attached");
> +					__disable_clocks(iommu);
>  					ret =3D -EEXIST;
>  					goto fail;
>  				}
> @@ -425,6 +426,7 @@ static int msm_iommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  					msm_iommu_alloc_ctx(iommu-
> >context_map,
>  							    0, iommu->ncb);
>  				if (IS_ERR_VALUE(master->num)) {
> +					__disable_clocks(iommu);

also need to free_ctx() for already walked nodes.

btw it's a bit weird that although here is coded based on a list=20
in reality there is at most one node per list. According to
insert_iommu_master() a master object is allocated and inserted
to the ctx_list only if the ctx_list is currently empty...

>  					ret =3D -ENODEV;
>  					goto fail;
>  				}
> --
> 2.17.1

