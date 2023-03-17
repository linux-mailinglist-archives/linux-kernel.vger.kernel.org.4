Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95326BE5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCQJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:41:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6F23C75
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679046097; x=1710582097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IHCa6Y49GKsiXJv/ACo4jIrkVAO5ajenAhedi3yxSZQ=;
  b=OOKr4p+tKYkaZLi0YY7F9LSNaI2nb+7W263LqfO55jc0Vce9bGNi/0bi
   C+DthzCUrFVikU0zU7+w47oj7DC1+ki5UekM+a0Y2/toUT/6sOTzp7okp
   lFBVqETnQrSsiWayUA85VmR6lLQBemZYt6zJlI6VSPSQZSkA+XdzDfPR6
   /tm5X8j8QjE9rZG1Tu6QiZwZKXYtHqXYXEQHEDjT93xSmZUocSTE83cMZ
   kPo1otGitQwD/tXd3d2fNKCdHsManW8BY+yj8lysuzp92X2WOu8ICSm3+
   M2evSrwH7bfxpip+wJQFuB6vl+s2lYMJIGUDymzqCrEt+a+DVArvP+Jw7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400803290"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400803290"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657504762"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="657504762"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2023 02:41:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:41:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:41:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 02:41:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 02:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0ACv8QxTAcdwluXJk/708hRn6SUBHFvzd9BzzS+PuowdcmHxWnyEkvrOdj89bWAAMP1k/Yrd8H3dq86wuEZI6Fx/lBLYvCr3dqmRLauKmfSPk/pcsxjIeDCKWGI5Lm3sEZwUuCR1XSlCf6OFlVQTEArOqPNn3nV+qZrtl0E1V8EtQEdZEdswfJod14eTThG35pI1VWWlftbCgbqX9s/qZXtUm/OKNSy0Yvd+69f6jwfrYc32oj2T/PaR3Ubs5bYt8N8FtuBr965auL8BkL79tvtgTHKJg6zAxuAdBjK3OFeXWobYZWeL5uoLtFD7RqzUvd16Ys9XF3X/h5DPYojkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHCa6Y49GKsiXJv/ACo4jIrkVAO5ajenAhedi3yxSZQ=;
 b=O8NIb8mm/WfqR8GsYxtLwy/tFWiVWD8jLQEhx9WSm17XyRtU5P4NCCUozNwoOj9Zt8HoSpval38ANMzu6aOrJ2v+A8BqBSDGR4D8cyq/XrtmEsUG9yNZNetMw3Ob9vP6YGkpjgg+vz2lCBbEEZDfXoKxfUEyh5yJnC3Rvn4NYDit8jK9blNjLYi9spIiYn3erT1R5JfJJSgmRerBKumDfS/H0AlKhkpH5Ljkq4tb0kyFYR8gXj+FqK0G6Ey9aqDbClp7uD8hlmlFrrQSU2xpSCbU5jFfPAU5ypSbUwxepSD2pfHUzF2OXGsYAE3O/Q/A4Cz8J7uXZr3LDrXdOIM4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 09:41:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:41:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjA=
Date:   Fri, 17 Mar 2023 09:41:34 +0000
Message-ID: <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com> <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia> <ZAtYphmOuEqQ1BiC@nvidia.com>
In-Reply-To: <ZAtYphmOuEqQ1BiC@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7583:EE_
x-ms-office365-filtering-correlation-id: f9ae8212-dce4-458e-3064-08db26cbcbe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCcf9T3H4R3LPq5SYyJwhjaB/sR+3D+XxF7XkAwBxLIrMvq566kAG/U39HJg0gQgSZcuhx+htCPf4skfrtUT6O0O93FUwQcxhRglnbXwe48mmxMQmdM0B2O+Fbt3ksopEOr4lE+BBD1xx5ow5nD3MG1M+JJwJVkYXf86atkb4L1z/HXuY/WpjWyoL0tSHH2ilpLYayjOxU63jiVH7HP5a7iVvIB0tTbpIxXOWQPhcpwlybW+UdtF1oFPbBrTPXBwVAPO4Z8PJcUpiJ/9aalPl7FGNKCYAblUlOz0Dcq9evrZ5Ia73cz3dz9YS+vglvQ6+LN27mGkwVxtzRKql54NnWsUxQnrvr03GF2IP1qF6p4sD6znZFZAYLIcJHX7y+U0rove5msrp3qYGdxAcRM6nh5a5w/KzworqC5+566cz6jqD6VDq9/EbZBelWGxwxNYDPztMbXaODaRPlRmhPaTnkue4PjXPa8YIStjDXSKmeujVF+iP2Li8c8w/wCsMOzQ3O/O6uCIbZ0QJaZm7xlbS23NMmA7712lW4iYEi2D9Ju7L+eBgBCygynGbokmoCBr2TmKLce5LLpFM14DAd2GBCF9qTXIMAlwuxZzv41hDY3CPuemNiIT3xNjhMjSoNEcJSTeCSd3MBKxUf6ORdMHkFQAg5eAB73YdeK/HWqqasu4GiecxxekXFlmfh8OLLrBRd7alBcx1cg/u4eUDVDPYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(8936002)(7416002)(5660300002)(4326008)(52536014)(41300700001)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(2906002)(478600001)(83380400001)(71200400001)(7696005)(186003)(26005)(6506007)(9686003)(54906003)(66899018)(8676002)(316002)(110136005)(76116006)(66476007)(64756008)(66946007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h/rNhaRr/8bXCuivEIH6xO12rqRIU97Wr7wczel0jaK6cKN0G7mf3UlwKw6A?=
 =?us-ascii?Q?ZLnIsMZipnvefhvFunrGSy+7V+kBfa5BbYIadGwHWycj3iWr+068+p8DETsu?=
 =?us-ascii?Q?Q/um+TjrBLLUQ2xocCUzRbHDsh1cM2mP8RZaUJTv2xmdIIugn9unw5PpqHxd?=
 =?us-ascii?Q?vUyOJpCIngPOZOy65rT6hgRg/E2n9q+WfNriWIMxmzCRTaylAg0LE3ZnQh/X?=
 =?us-ascii?Q?KXjD3O/E5JeH/ZVE9cp9gdlQpRWOlAQiMrE+pQzjLrWuKlSh3Q14SS3/s9A3?=
 =?us-ascii?Q?/GUapRE3G7u/8zrgfzFj6Nco2TX3lgMv2FjUNKZz47kY2YirJuOKOdSCIMfj?=
 =?us-ascii?Q?M5H5R8IOdLpM9hGIlSGJBYwD7mAWOLZucR+O2tk827tRE6vzbmUwYkuiI6Ci?=
 =?us-ascii?Q?z7th2fj4ASBpIedplenymg0J62UYQCmT6l0L6QHJQFUGD5sxl8EjuSYOx79F?=
 =?us-ascii?Q?+kq0d8DSfzdHODhjm9o4kvEB0AaZgImTQg9Cji8u0DSl0y9IF6ZLJicPABSn?=
 =?us-ascii?Q?afMmjeqhp6BmoRr5++MGZ2Hnj7dOriqNW3s20B0Fo+b3wmGUIPAJ1iZ0GD9f?=
 =?us-ascii?Q?eJIhkMJ4RBinCOIKwmziVdgh1t1ahnDZu0TQA2RhslLkLKJudzqwAAq6ziax?=
 =?us-ascii?Q?Ul7SbZtf7N/o1DDezX/70Fp3mvol7q+zIdlOPWIkKwOEsRmCd1wDgy5mE/r9?=
 =?us-ascii?Q?4nTa/Wqs78t+VECXEVNbP7GoyMdNmi0533dBQgEq4/VpXqvZAkTQVv3sXmAR?=
 =?us-ascii?Q?vnW10VGIvRs4sQ5PwJL5sVwbpf1CpP4D051vhGTLgA93333rjmOGiipUcJSw?=
 =?us-ascii?Q?hxBWbhx3NVAuMGz1Ze+FkwB1dUprbR5H9fm5V1mNGzuWww1juW6lKIw+fAMq?=
 =?us-ascii?Q?lUrJF+3+5SfMxjJXF21D7RFjdQz69orAIbb8XlZlZmVLAeiyUj8uwfkqf5Pd?=
 =?us-ascii?Q?UhBpDF65VFd1HG2sUY/7jBDziNRnx9JmxZlLbkiXjrpmhLT+UKBlm+z1cuvH?=
 =?us-ascii?Q?oILdt+ahtOb9xxrnFIMnVwG6UcWPFQ/VCK7VKZg1iVgCUbsJO8ZRusLF+rHh?=
 =?us-ascii?Q?sYxGF2cPLHv9TCzT+cjBJaO/Y3N/MeYy4zctzJaLvDOcS10dNS1IjHfzl+2C?=
 =?us-ascii?Q?MbMqjZbpFrCIN1Iehdcak3eAMeamDX1FeI5XrxH7OagczETKQT/+n7CAhGds?=
 =?us-ascii?Q?bJZxenR78G0bxn9bTAJJWV0oZxp8tCs4SonrKWQn+EZp+bWJBtVqLculBfcI?=
 =?us-ascii?Q?7UQxzr2sHHQVpG1jiDvtnO/gCzXim5FIEVYe0+cGdLKQcwlu1Y60fSXsrc3x?=
 =?us-ascii?Q?3Ds4shw+hcTTveFeuEoQpJ3E3jCXuoooShC1yy6pUL+RMV5f+0/P49Z9B+mt?=
 =?us-ascii?Q?NNFsozeQgA6FzMUIMQ1BBb/Obgx/N0dxrRsGqFuN7BT9UPUN6P3AonX6Ec6D?=
 =?us-ascii?Q?oBKSjLt7GQdVY9NzTlUSPhQQzM+Y5diMeJlZlrqdw0UIXtd3UJ6SIQ3g1Wh+?=
 =?us-ascii?Q?KelnMHWC2s5GRUd9tL8bMc1ujw/K5+3OzfzvyMyuaD5h+pngpVD2vwptZ+Eo?=
 =?us-ascii?Q?PSgGJd5MQpJ3JRMd5txvsvQldsnFef5h1SQbhpEm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ae8212-dce4-458e-3064-08db26cbcbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 09:41:34.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVSUxRBwRhnu0xE2qH2NiipF+uV2jdsMmrUqkmlTAA/eH/aJ8TkZOdyvTQYL4RkGkSDg7WkZHeldiQkPhrfdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, March 11, 2023 12:20 AM
>=20
> What I'm broadly thinking is if we have to make the infrastructure for
> VCMDQ HW accelerated invalidation then it is not a big step to also
> have the kernel SW path use the same infrastructure just with a CPU
> wake up instead of a MMIO poke.
>=20
> Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> support.
>=20

I thought about this in VT-d context. Looks there are some difficulties.

The most prominent one is that head/tail of the VT-d invalidation queue
are in MMIO registers. Handling it in kernel iommu driver suggests
reading virtual tail register and updating virtual head register. Kind of=20
moving some vIOMMU awareness into the kernel which, iirc, is not
a welcomed model.

vhost doesn't have this problem as its vring structure fully resides in
memory including ring tail/head. As long as kernel vhost driver understands
the structure and can send/receive notification to/from kvm then the
in-kernel acceleration works seamlessly.

Not sure whether SMMU has similar obstacle as VT-d. But this is my
impression why vhost-iommu is preferred when talking about such
optimization before.
