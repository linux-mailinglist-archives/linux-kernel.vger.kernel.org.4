Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6A5B6925
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIMIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiIMIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:01:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB7756BA2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663056083; x=1694592083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=47cIYHfjtPQIXo+O8YOFaechfYGhACzMtQkuKj4GC9E=;
  b=KXS2ioDYu3hgy0imCn//03M8o9/plzOmShZJvWf0blwLRL3oJsEiE3YS
   L6Ge1PBuCuAHutx2sgWRRkLfFW43Eevq5Nvw6RwsVROMy+v91t7FciH1E
   pZ9ICnKs/u2HtGiUC85zAIshov/gxFdYCFpVYWrM+kc/RDtgbS4b4Plw8
   tVfpS1CFbqt9qvKphdaOzdGDEG/7cpbFifdBbRhqIGXdCARnH0ci51UiI
   If7wRAYegc89Gf+S+Gf+DGiDjTRn9fMvStsC81EN32sRFeO+d0kt6u3Ln
   mkioXspZ/uasjfUu5dA5bwdDsfzuAmxljtqHhInC5NsuyWK5oXW1TDIqI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="295660603"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="295660603"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="944963788"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2022 01:01:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 01:01:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 01:01:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 01:01:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 01:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMhplKhTVdlXJKGKHy6kw3Nsa2JWBvnUXNv4tBXjCJuGELk4zoJQBA0IMRxffX9H2O187bl6wE0YbBMwALOrT8TSh+uXBxjBUBjBA0KzNEnZI57fQRIb50EFuiXrOwC6um/8qatGWvAbj/6SD2t+KF/I0fUmEfMb/SNvlFMn2JIO025tx+LE83l/yceC94wLo8EIVYDzBcvohafc6DejI4OqnYPVdyHu+cgI3REL7O/X8+RweRnow0nkJiWunwVSBqtRmUMbdlbFc5YOEcqtUzfef0yG2kCQ9XSs2FEAg2Y8s7kB46hb2K9IYESFYcopo4GSU9ku97Pk4Gv3g5i1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87pVy8fQEQhf6HMuyI2wVMLYO7V+XhST0UywDdJYf+w=;
 b=NfCpf2pFZJAfxekBKxyLkxQok5UEr5uqOaRPaKKO4vbB3qfwV22WZNq8RTgViC/bgRcGbwMQnUVmBZrFUrJonnu6/kDKxvGKVls6jpSBq2govluHyu874T33aZaTedg+hjiz4fSDAeY2PX+mQhTdlMtCrCQSYWwXOcLqocijxDqimd8WM8JD7FE6vZ5dv0vDzWRdTeaxc/pDoDDZlxt9AGTNiiLAhME8tNdfowQhSIvTTWft25/cojSjPtDyvQPpZGMsq8pknGZaAqPMe/Xb85DpHqJMkWI3916540VTTCTa8NsJb6+VIO6gCQbTTtvz/NXmepFvay7QEWHNb/hrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5352.namprd11.prod.outlook.com (2603:10b6:208:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 08:01:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 08:01:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Topic: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Index: AQHYxlL15aXn1csO5EOwQ10Vd62MPq3c/4bw
Date:   Tue, 13 Sep 2022 08:01:09 +0000
Message-ID: <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5352:EE_
x-ms-office365-filtering-correlation-id: c53b2073-ef47-467a-ecf9-08da955e1e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfethSoMJ2v4+tYpfuArCCePJQC9QLxmBkXzOileJIzArE1VPh1/+Yj4LicTEE5FiNc9vYSfIUGpgDuemodiRA8GiReHCckHZ0ZDlAb9khzpRmRYwYZ9f4Iwv8ZWjguYbAKtvn6OzWl935ztfiJK+VvjV6KJcD3c31YIAdBdHmSX7ef5KB5YwZW6M/18NhGGx7ZODXTShtLIor6JC+hiiZHVfjz3K0+Wtr08y/ZYSXL50JPngo1M/xJxbZZW3KfAQmXYBKoBY7SCEYWTzkFscfEknvv3eeibCAvE2Id5LlKz+phYO+Zn42AyWX8bzmKDEuKOafB4vtNZcwXaHQRS/whdoP5rZphHv9SSf8aTBZYVW1FVHdDpqkkEpy0dmEfUKH7H9EYdXfmCuswmXwufv5G7a3gjfaRBj9xiaUOAkJVbVl/M5NUJOoHbBuqVDvCxq/ibphECsZ9egvzaQctUyRo+1d3niJKL5G9t8ssAhzV47JnvgV+fABtxxFO5JCMNIOJGUvav9WoE8P+PBrGz0wNnFllBzexZS6iNYIEntdd76Wl0VGmDAs+F2CBuXui8DX/8CwJ6yv/mq5WmJmyLolLR0BMNO0bOTXyxuCEnTID0/AsFP3hlTnKmsQI+wSv1judMZKb9EjsRTcV3Fg55WNKDMsYoes3P93Ucuiu9CbMK5z3ECccvGMCOgtiKUyvFsKYuj8MAkSahSKwee52DBafmWwKKzgt6RIcpeP1WuGwA0G1Mik/EdffmSSKh5sBi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(66946007)(9686003)(55016003)(316002)(2906002)(76116006)(8676002)(66446008)(64756008)(110136005)(186003)(7696005)(38070700005)(26005)(478600001)(83380400001)(33656002)(41300700001)(54906003)(86362001)(38100700002)(71200400001)(66476007)(6506007)(66556008)(122000001)(82960400001)(4326008)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vfoMkff4QoCuJGVjmxGi9vcMxaHocjkpPuPLPFxb8yYicStZ7hjmowodRPES?=
 =?us-ascii?Q?e2UArBV8JQhVhChfyX1GCqXSUUvhbn9qbYfYr2ZwGWCURXC4k55xM9us+uML?=
 =?us-ascii?Q?cjvfU80s4LGAuhw9Lzy9ZVOLFR33+WyJiaoF4zdQ5XkQt45qA/tRq4NawdlY?=
 =?us-ascii?Q?NGL2NLpUg4iQNsxKGGiJcJjvSXXXgTF+bSi1INd+fWxnNOpTcgNsS8Iewr2X?=
 =?us-ascii?Q?QGJKIl6ynoiATu1mjYQ1HO9aqsnaSV5k/G0wKEf4FHKAYYWpUrKMGbamwJ7o?=
 =?us-ascii?Q?IOOumK6sTkF9v/B+j6jOy0ZoFWlewa2OtszcK7dge8/56Ckx4pWrnMe/AzqT?=
 =?us-ascii?Q?WxgmOXZzXgELG3zEp2nXilV2dyAqwaj/+XxpxD98sBlXSVW1op338yNGeJGo?=
 =?us-ascii?Q?exMYG2j+ZT+uWnegaDLN8PxJYwJOM+/KH5aU2xFJ2z72/Dn8QrkhzkQSszGQ?=
 =?us-ascii?Q?xbyhD/idlbr56Y8LI1SAd7cYcrhTKrgipMbzZ624et/pU+4lfbF8zkltSio6?=
 =?us-ascii?Q?pohEO+IYbhpYXBGpbXUh+yYGn0al0Dy/6qSE6wG9RG2G7BjMC4Fmb+bd/YZc?=
 =?us-ascii?Q?+TyQnargrJbfnI2CMr9TXaoNmbSVwGbRA/Pc203+zGmgGhhUB0XOcs2bRmFh?=
 =?us-ascii?Q?u+YZsfHDOwYfC2pU2WNqCpAfoGb99AoCuJy9xjKTdkWz2GfQc0Upfh/szXFK?=
 =?us-ascii?Q?zSIh9DlGdDI+TI4NxxpAlSAq9wpQ3SuUUYTSjjGgbfRX0wR7Iejr2VaHmARL?=
 =?us-ascii?Q?ZHfz0H2cx4QOhcYNnSmjSr32Y67PvPFBdXTpRscVHmbgXE2AjP5Yjc9L7QP0?=
 =?us-ascii?Q?ZvUuIG+5xzCVFPN+IaecuDZq+htOM9CYHEFgmFshsusS4HY2psTRInGifWfR?=
 =?us-ascii?Q?mAKDep7MXHMFzHAZBArNT2OJBu09429lLWwGQdoI1hID3U0ciLb+U/1d9PH8?=
 =?us-ascii?Q?cnIThMxm7alpz0fAUG7JJo/V6kJYIx+CaWCHh8UbH8aA7YnA1TLgopTbzHSI?=
 =?us-ascii?Q?F0i9wE/L+ldzFqF2Yt9qqcXMoytjzsHc9mNsLXxD4U7dX8mwfoHpRjVEHTmH?=
 =?us-ascii?Q?otTLsuTZqwE1Um5pMzIvHJ1o1LsCVL2WTLVP2zgcyyEhJdqiHWX3tgB6ANal?=
 =?us-ascii?Q?iLprWGedS/ystI4//1Q77AySOQpAXM8h2f+dKRX26H9CuhKe2LwxWYlpUFAe?=
 =?us-ascii?Q?ahXexnHEHYit5gFvLrjINivK76h2uknecS790p9EQ6BDjVoEY05/rCRDl8OR?=
 =?us-ascii?Q?d5ijosV+xh035WfkivjZjtPli/wSOGHoxheU/FbhW+dCLXiXYlxTIEu8hFbr?=
 =?us-ascii?Q?jNymD40ib5VMf/U07x6aNR6Ciaf/mKGa3DZ0Dg7oZYCAVE4N3EBn6gy0MKD4?=
 =?us-ascii?Q?bldsvMJaZFsgI0Nt3CddptSQR5fVY+ZsyvS1aNF7mu8iu49M3wOayO1FP61o?=
 =?us-ascii?Q?nj+ZLoRZVhoZZroSUeXcnUmLMyRjLSnkOgn+WFibaE1i3j2o7hIxt5gw7lXn?=
 =?us-ascii?Q?6tiOvz2b8rDLAU/sHsZTdiF6S/NxDk9N0dV5ZgelIxRdXh7wurHvlIVAfk2V?=
 =?us-ascii?Q?ayrgkY/Z9fUaWfnqvLQOVNyr0ysR8CoSvvxvdB/m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53b2073-ef47-467a-ecf9-08da955e1e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 08:01:09.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxZQ2CAQdBFas0TVIJx2EXU1FijKUw84E7lTuULyr1QAe/c8rEwyIbpdakiLa12GiVq+Qiqbrw9vdj2yELW/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5352
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, September 12, 2022 10:48 AM
>
> @@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct
> device_domain_info *info)

This is not the right name now as dev_iotlb is only related to ATS.

>  		info->pfsid =3D pci_dev_id(pf_pdev);
>  	}
>=20
> -#ifdef CONFIG_INTEL_IOMMU_SVM
>  	/* The PCIe spec, in its wisdom, declares that the behaviour of
>  	   the device if you enable PASID support after ATS support is
>  	   undefined. So always enable PASID support on devices which
> @@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct
> device_domain_info *info)
>  	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)
> &&
>  	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
>  		info->pri_enabled =3D 1;
> -#endif
> +
>  	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>  	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled =3D 1;

iommu_enable_dev_iotlb() is currently called both when the device is probed
and when sva is enabled (which is actually useless). From this angle the co=
mmit
msg is inaccurate.=20

> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..b3f40375f214 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -21,6 +21,8 @@ config INTEL_IOMMU
>  	select IOASID
>  	select IOMMU_DMA
>  	select PCI_ATS
> +	select PCI_PRI
> +	select PCI_PASID
>  	help
>  	  DMA remapping (DMAR) devices support enables independent
> address
>  	  translations for Direct Memory Access (DMA) from devices.
> @@ -48,8 +50,6 @@ config INTEL_IOMMU_DEBUGFS
>  config INTEL_IOMMU_SVM
>  	bool "Support for Shared Virtual Memory with Intel IOMMU"
>  	depends on X86_64
> -	select PCI_PASID
> -	select PCI_PRI
>  	select MMU_NOTIFIER
>  	select IOASID

this is already selected by CONFIG_INTEL_IOMMU

>  	select IOMMU_SVA
> --
> 2.25.1

