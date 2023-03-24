Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF986C76AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCXEtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCXEtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:49:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2012737
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679633378; x=1711169378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=euCqTBa9p6cfJqYHAsoM7SuISFziFs27l/Wqz5HIKOs=;
  b=O6sIum8Gnf1r+N1+3eqStMKPyHbgosl2fbWkWuhqSwl1PtbsmOpxDNOb
   eMWAal+3WTuYUzcpuEfLz6BvTe+YmfeRk7LdxQDc38i1zQ4jjYWD+h9yY
   lQL2l74BUXvy30IJ9DXp1xPuIZW0958iHjHfRfuKZGH5GH/+UjRs4/DNv
   Xi0gWpNQOOsuG/ifmp7RYbqyaTFKwb+wlGeP6Ls7gMOAMTToBdHpwdfys
   xsIsRlJufQlgM8ewCfxQpw9YzbLL7cignJAQqHJd2LafK/xXOHKd/9su3
   wfDxqNpnLUBBekahHMYxQi06u3yGbZk5j6/uqpGfpJqXlUlQgAuVARLY3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402276058"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="402276058"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 21:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="685015183"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="685015183"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2023 21:49:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 21:49:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 21:49:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 21:49:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 21:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbci6QD04cxCMV25ki3zWIegMbNYvnv/OiA6EY13JsZRDUekJ9busLw05VMyOK1QbM3t3ESYUk7gC3xmS32ihDxG7faNFci3NIje0PbMBZsy3elgj9amMoGXKzjY9WWiB6wbiQNaMStQQ96EOAiE72yDbuhY8heZ83gMIZWAM6lDiTvkLllUkVi4fjWNSLbmozULb4oVUyX5cHX2ZEkOMwYQ3gmmTtQ7oqe6REShn+ZHdaOo+kz8avXy8LIi6iHMLitFI23ffFTBjhJSE+bN0ZoztkQL0TLcRtBww8VhGFJ+Du2FaQ+SkGiDiItCq3W5QyvuM0mQxIYR/Tcu0wX1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeEeGlfbwQhCTQbElwyVBF1aSEd+IRs97/PtLePQKVs=;
 b=WfzBoKIufUPNs+U8y9Xw784NcQqR/eAa70jmMuQyQYj5h1ycAxzgqfOgoNKMvp4wPVEBo/1pGLTs0f3n3q0EuAGgiXwVbn0YfD/r+XLa2CTXbBwzJNBfi4lb5j/CjHkMHaJ1+DLEZ3ucWl/SmeUHMUZ9z9aSK6ADNfzBNTTxDFEP5Tw2Q9hDFYb0AZ98U/m1LEnL3YDqHQr+jkwLQTwKOAneDeLvbE0w4y0ZKA1PlK5Z7SZtF4XAoX4hPpAV3oqP/iuzZhYyfb/kGcEdmCu/o9/h0MreYBGFAotyKi1Wyr7kC24cW/8qnxM357an+1gYNRQ5fl2dnluc2By96SdVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 04:49:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 04:49:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Srinivasan, Raghunathan" <raghunathan.srinivasan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Allow zero SAGAW if second-stage not
 supported
Thread-Topic: [PATCH 1/1] iommu/vt-d: Allow zero SAGAW if second-stage not
 supported
Thread-Index: AQHZWURLB+My7yrG6kC1mWF30mCBYK8JZRNw
Date:   Fri, 24 Mar 2023 04:49:34 +0000
Message-ID: <BN9PR11MB52768EB838F5E7219BE058F08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230318024824.124542-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230318024824.124542-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8389:EE_
x-ms-office365-filtering-correlation-id: eaba0e69-5a1d-492c-1dd1-08db2c232a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8siHsS4/WMIncQ8VoE/wRMTB/SqXgn77unvazDGkx/96S60QBTzjBEXzymTZVbDJPlQVsjPX6zE1dAIecbEgHzXQZDrGkT1XxHt29Ou1b6bgeYCOylDOlGURaz0jn7HHd6Y0Gi8vHqaPMnocqE/zrkgQFc7HJHWbZY1N0ih5nIHBnlJpKXGb+HDwKBByZIZ1/YLeR3X3YjoxW8jIll0JG7CqkF7KnPyp4xRHPxdKgGQk6FXt2MfvmZqRxCzzRhM5crN6nQvNXww2NpQTjCv1CFB9I0ozjGuwy3GAxlwS73fXRx4sxsh46k5Klfyf4R4S9QIWBsOpTdjTRZ3qfcz3Oc6kFXpLsNiVRRu9Vde9dhJTQc7OduUPZhdMZiRgNiVp/YAa0/ECdyBpLG48qbBb0NBSfSoVd9HENaMS2/hv9aUVCOEr0RFre6OymcJehRf8J89TaT0DQFwuG6u3aQamXhP6L3E5I+vDv63Vs9bey8ItVJWfMKYYF7fFIE5ur+EVb+s9VfGUXT8e2ipY1GC+yiJ9uQdag32StJc3UCtx/ottm6a+M8OontcFMy3NYEqLEFc7VGaWA01RzUphrvXSQWSCzIgT9sI4gQKAS5zJtELG5vFurfcKHg+1QF2l0ofNoqbR8yFg3wfnPoYWFd6dzAS26NoKn45nB0xiFwalfljD+Il0mjKyBW2TSB3baDDD6/Wz9S90B4h6DfqUtHYNWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(186003)(26005)(33656002)(6506007)(55016003)(66476007)(4326008)(71200400001)(110136005)(66446008)(8676002)(9686003)(76116006)(64756008)(54906003)(52536014)(8936002)(5660300002)(7696005)(122000001)(82960400001)(478600001)(316002)(38100700002)(41300700001)(86362001)(38070700005)(2906002)(83380400001)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9RaB6csJ+IRSIbVSZKy2DX01hwk2q+NHu5TgVoJi4gFTeaLaoG8hh8FnSMRO?=
 =?us-ascii?Q?FkB+pB07G8jr4O1zIobigGYziAtJmMmKO0MX6n76eCkGdMw5e7y37gAjvHcl?=
 =?us-ascii?Q?zUbcpaAU4GngTkkBkUr5yE/uEoM968DJe6MF7uPa6ToLXQmm0/91pTcMN2eC?=
 =?us-ascii?Q?n4V/KnGqFnmLWs72mmsvVR0jo8vRi0vZfh47sQNgJqAXwHE9f3U4FYCn7SIu?=
 =?us-ascii?Q?Lwtsu6Ie4as8CIQaxKcf/FP3OToCYFj5X+MxdtC6TUB6Zrm6Sor9FlhbHYWc?=
 =?us-ascii?Q?rWAWnLZiO4NyMFHdHBkZl6ZVf+3BJ5O5ED08IzxJMY/aZVNs075RPu/7dsa/?=
 =?us-ascii?Q?PuPc/nTadOnMCZD8TMrojkvtO75gdbj4mFUvNx9EFRKaTI/J6UBHrPdMRtcP?=
 =?us-ascii?Q?6yffv48z6WTxO8aax9qSRL0sBQCCDgKERGUUkHI/1+TlLF6wQ/xsbsTugEZe?=
 =?us-ascii?Q?aZj/Gj+Tf1FqTjQw6k/CR9X4y3Zswy5lE50XelpuudlI9QmQnOigLNHqX/Jr?=
 =?us-ascii?Q?DGU/KD+xInuS6fh9KjY8EZFLhIHgGml8lJR5WycJ3dTjJHvGWN+zDJCOMoVi?=
 =?us-ascii?Q?huZuXQfIOXvHmdiD1p5Pf46lnk3WxdU6EhgIMoWvNsNG5/Fofp8LzJTEThv6?=
 =?us-ascii?Q?ez8gJEOZz4Ya4SNN5eZXEQX0YOa3JBZaDy62ZMRC9rIJap+4s1wHFT2MmNw1?=
 =?us-ascii?Q?i86e0bG9z5AR4cEtR/daFkAynH/xolStu15amJOpoAc6XSWFf32SPeoPIjH4?=
 =?us-ascii?Q?f+uWhFJA4iDMuD2ELF+sU6WSQHJzMjgLeFeclr/YNne4BhkoJTxystFxCmX+?=
 =?us-ascii?Q?j/LFwQI6xylFCYyHepanfVfpJ67C+6rxUamJpIX75N81UB4KzuRsi6BHOIiN?=
 =?us-ascii?Q?+jPiUb37zDdhDN383VFhpb3LHDVui7/1Z9wJYOp5kzd59cD+fYERpT4VtXrV?=
 =?us-ascii?Q?ROTvMnpZN6azHHR+tx+zmwrgrFgmnpd9vmD74rOd6yUyBHmynXI5og1Pe3Jh?=
 =?us-ascii?Q?ql520Kdq7AF/7HnLpVjL7nQbwXlwKNHHxBenr2oZzgEenwgzZH/0AcWceSr5?=
 =?us-ascii?Q?bx53umHpwuphNZrmsl1PnjRNuExMTo/GxQl67GYZzj3lFzB4z1M1vwQpGKRl?=
 =?us-ascii?Q?k9z842dMt3sO14liw85aHr4ziNqiGplAMBuhQyhp2oBizXRRv5XB4EQ9w/Du?=
 =?us-ascii?Q?N7ImNvkcfnq0WdN66DjCpRLeI2MLlta+gQHGdUct6V9qSQXtHQnDx7IaEDzK?=
 =?us-ascii?Q?58aYo1xW/iDpzxuFv0mUP4Xpx/O7ZN82/jXFkf5H0R41yrHeIRWf+LJ/Ig8H?=
 =?us-ascii?Q?8UphDNmjWE+R0Gd2I7/v4+0Cyl534Q1MOS2BlO3i0GVycxNNH6HjU1Ny+Nyf?=
 =?us-ascii?Q?zUqiBKiUTVlyBVRVzXrBmaKhP1KZ1sKab7+WITvoDnHwnRA3toZsd/VKK+jk?=
 =?us-ascii?Q?4xF1gYfJOA6fZBNpT5oQ8K47xFCeIILYLL7sLQUu9daFsu9qGecwtAYwuy9c?=
 =?us-ascii?Q?h1OiBcheq44Vw3SP1NM8wHaotOQc7aYXvEzaeoH9buZIsHf13L9iAFvCbPjA?=
 =?us-ascii?Q?r62IO0IRSuMSufL5QNLK/aP0iPBFTSqUzTrF2bdS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaba0e69-5a1d-492c-1dd1-08db2c232a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 04:49:34.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFhJZN3CtDkkR/QpDM/ECneoPmsgY+TaanjDEieJFRhDx/tYetxBO2sLVVzoNZke4demu/pbrnq9t3Y+Wd91gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, March 18, 2023 10:48 AM
>=20
> The VT-d spec states (section 11.4.2) that hardware implementations
> reporting second-stage translation support (SSTS) field as Clear also
> report the SAGAW field as 0. Reflect this in the sanity check of
> alloc_iommu().
>=20
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
> default")
> Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 6acfe879589c..23828d189c2a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit
> *drhd)
>  	}
>=20
>  	err =3D -EINVAL;
> -	if (cap_sagaw(iommu->cap) =3D=3D 0) {
> +	if (!cap_sagaw(iommu->cap) &&
> +	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
>  		pr_info("%s: No supported address widths. Not attempting
> DMA translation.\n",
>  			iommu->name);
>  		drhd->ignored =3D 1;

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw I wonder whether it's cleaner to record separate agaw values for
stage1/stage2 instead of picking a minimal set from both in
__iommu_calculate_sagaw().
