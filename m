Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2F6973C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBOBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjBOBjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:39:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2691D2A987
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425157; x=1707961157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDhYqCNHR8Xba34SUFVwsMMyyST0Cvz9SnffZLbapM4=;
  b=kWVaULnsCGgEJhY+agN7HzGkNzsU9OEA/4gIGXNxzhqT2shnWSkXbS8d
   xbXfOPWC95LqR5QBervZMYoRlwWnfCdiC9131SCvhjV8NitLhFsSG0dq0
   exlb/XmW7wGFfRX9FBVrbp4ibKo4FfPK+Sj09H5M+wAU4L/yqK2uzmzYa
   vNcU3XgB6mppdAhxUImc4LeWUNMA6GqmLdSrVVgU9pyD80J9cz3h1otkY
   weRoNU+SMs3eWWk2pGIVZ81rxqxekClY9mzuj2CtUN4p7vgDWZYUT86lJ
   R9bDls86AyNcMJTT0Bbi0tdGpaq5rRH+z+LBMumw6U/ZFcQN1enkesAwQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329035985"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="329035985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="843381212"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="843381212"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2023 17:39:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:39:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:39:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:39:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:39:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFscme8ik99kzoR6owWtrBUa7jQjpq9/vrt8yjNP8L+AamLlkGDS6y1PVl5ZR2pGY9DDoXRLbbXj7x8EJehylz3sWWc6IE/ZJXuJTCB/sMwxHKX/1lis+FFbumHWC0CxBoIvM0UxFgCImmele6Tr6pCHQ+akuLsO5USwuadpz1oY5VIMVvr0vlc4jHf2qdK3lJ0B9txmcVozhUhw8+Cg8A8cWIyh6KzPrJxPb0QjYOeeXWRBF/NxDikcTiOudUZ5AyaSlPArvRCUmEB1LR3qS2zplRJpca/IqQCOU55q3OdpHO/RmNYUfFNE79pcMfyTcJExFU1kokFLcgfMLAWn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkWcmkpU4WcklH8tDjZKz93gM/NejgnH8ZRjoGFrHyI=;
 b=kFlGC7dFCXUhz+tGHrmqC3a/I6K1gkGnXK/kGv5zG1Y3SFODDUp9UxKVH8Y2zLEEjivphMyliEfF7nHMUuQrt0foKjLDq42c00ZkQ6Mz6OQVGxjy7dWSPDLR4H2viL2dIan3apr4ip00G6SAFI0KN2dcWmM5EbHAZYCM7cj4gmaCS0fyHd3kBzEL7IdFc2ZGIUYyO6+ky77rGX9s/Dxjtu7jx6UdZyhp95bNfpn580TI0D0pXkx7fgrRV61HzuAFI/8pvV3XgA2Dy8fRZDnT33P9QCkojnGpDJ0w0w+BkhpEMFuNN3wJng4RSLb7nxzdSZvm7bl2jshefEq6Vp3jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:39:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:39:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Topic: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Index: AQHZPaM4X827KMb2AkC/Wtvslyhpl67NEuaAgAAlj4CAABH+gIAAItkAgAAafoCAAAb1gIAAAJAAgABvEpCAAI9BAIAAs59w
Date:   Wed, 15 Feb 2023 01:39:12 +0000
Message-ID: <BN9PR11MB5276695C57522C341CE1710B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica> <20230213103455.02f3ac37@jacob-builder>
 <Y+qR5zC8ZOkVphgv@nvidia.com> <20230213134402.194ed7fd@jacob-builder>
 <Y+rFW80DUHvf3hQP@nvidia.com> <20230213154345.0f76eea1@jacob-builder>
 <Y+rLqg66BBPsfsRK@nvidia.com>
 <BN9PR11MB5276D28B4A4BF8DD3AF1A2828CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+uhAvXFq3YKcsuw@nvidia.com>
In-Reply-To: <Y+uhAvXFq3YKcsuw@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7459:EE_
x-ms-office365-filtering-correlation-id: 346d444a-2ed8-4824-9baa-08db0ef57113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f1GaLY7EgMRVbqsqbiuFW3aqTVPjky8q98JbEeDlw60eunDet2ydLJnTo9O/dGMc/x/kQSmsy3m5SLFkLh7ZKTFKbfMin5TNnCTxbfjx2IF/9zaEdYtSDKWqWQcm84TI3E3te+endgaDzEuanLqghH213Hg9kV5Mt9S6/RdigubguAsIk6nMneVsSd1PXs6gcCaBohn/dcEb/EDx5AE7hJ+agm1DaiMqWBVtaBw7i89zPZqU+5YmRT1GVq+IYgnTizs1hoXZgmct3fBrkVPqVChH+Jp+FlmDyiK/mmqn7POsDYHBY0xftJjTkv3C4sYoOX0Qk0V92o6tBxzsWaixpeP4TrsB6yeus/KNfjYgVJDoKJ9TJ68j5NfbSIebfCl/M6SOB0S3n1i1lIo7v31GBpFTkr+7X+3mf+dtq3AJQpNR4nksqEUSeq0V7AdTV9Cq7ddgo+DoNMIXDUDuoQwDIVRyJmlnVbIXSX6itbXT2AKR//+seXDFVRw0NABqpvQAwWTBtMZYLB1LFCbVTGvdZNESEsApg/P6T8mYkWuhDw7jRtCvZl1mMtrU/k8wVIowXqex94Zwv6fkV6dkhIHiiieYjTVQNgWyn6Ra991svPwKOh4bYUcBn+mJEbFb/xHjeNtUQdM0Pnnu6B4Bkk4s+Me0+no3LfKv4oDvxTBrqc5Xz2NkK5yhdahj4g9de37BH/l6+5S0R49OanfAlnEreA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(6916009)(52536014)(5660300002)(4326008)(41300700001)(33656002)(8936002)(6506007)(122000001)(316002)(9686003)(2906002)(186003)(26005)(54906003)(7696005)(4744005)(8676002)(86362001)(76116006)(66556008)(7416002)(64756008)(66476007)(478600001)(38100700002)(82960400001)(66946007)(66446008)(38070700005)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIMUY1F2ve0BheyRGVDBf0FUCZcHx4Ev//ew0GTh85tnOkzDN4rSFy23bl5v?=
 =?us-ascii?Q?KvfhzZQzQ+jW+VQuaBZHvS76Y7xjV4oBrlNqqiXmtdL84KUcHzpcc/PdKyfr?=
 =?us-ascii?Q?JqVwF1QGd17b84etxPVz3eA/PrZkh0FnAzxZznExKy6X6txM814hEzK3hO+A?=
 =?us-ascii?Q?bOOeNeSwmtQMFtk7GbRBs/bfictb/KsRwMHJtJU2Z59fLFZ+uCYVQC48H4iZ?=
 =?us-ascii?Q?Luq4+OQrZebWOhXV05kPp+KWHDC9tZo8LiH9B7xXcJCIrDZJJyrEHgzA5baS?=
 =?us-ascii?Q?10xeg5enk9u9xcAka7JIHK6knoNnbUZfecumY6YTtqs+y8nVm6/9NOm4LWfx?=
 =?us-ascii?Q?xpthYYT8ZzWPG/TBMUumH5OiwAWZqiZ+0r2kUwl32HuTUFi1HDp/cIMQv2ik?=
 =?us-ascii?Q?4twvdVqYMsySIo9RVf+PXegXCClY9Hlnu/Vs7gJlR925NtWLb67UKKoON2r3?=
 =?us-ascii?Q?drbVcGLSVA55tpcmzVsRfwn+xIJbisyglnEC3mWEZGYdxx4OlpYMip18JpYH?=
 =?us-ascii?Q?ez918AfVUQmftWKGnEpM7lSpZL71GKMbbsShuRW3j5Sfyy7/LULKUy+NoE3w?=
 =?us-ascii?Q?WN6BUElNQdVM71z87IITwA8SWQU9HQskvqmJ+4Hh4dh5hK2ZRbNoo0X8HPw1?=
 =?us-ascii?Q?8mLopD6Xl/eQR0eVIBlAgd/cyzoAx5HSNF22EeCbY65VsjL//UwR/6OXThe3?=
 =?us-ascii?Q?g9ZBOb5/L9vig+im3LDkklfb7VJTV2Bvvmui6FLjH8QsUFKLHOmcgyf7DZ8+?=
 =?us-ascii?Q?R8AoCiFzz8PGyQJTOANe0oCE+ns66LuZTLIvthSb/b5I/6DuobEogDaYvzZC?=
 =?us-ascii?Q?jpTEi/O+KeTeZdrBZeDsko5mTxVUaCbSC9bZGIxctMbXgFzh/dCo+JlnZKlI?=
 =?us-ascii?Q?1H7u8UOBiWU2xTWQ7m/FNfGUbAfhCzBsvr5Jm0H+nsn7YNxhRwbueLElBh5y?=
 =?us-ascii?Q?LKk0ztZ7Dr+cSd4yZD52EQnjdXoJSPfM/iFQf7J05/EuNVHKcT54ngogziqg?=
 =?us-ascii?Q?WyKpDv4/uEtYiTh4bdolQIdF3BqA3VnY3lVyh5xNDOoJJjvn380fsV7qK6y5?=
 =?us-ascii?Q?9BHtUEUi2iglGRPVUvpjgpjVxxpO/MASb8T9iVBvONfQWLovVf8wjmBseTNn?=
 =?us-ascii?Q?yVuZV5geQEZQ2Ex8s+zvUwf/f0l2ALrjjZ8izAd9NOgROhO5KET0etxbZcsQ?=
 =?us-ascii?Q?ppD0RQdyYrVl6TJEE1FFRHMcPHiL0Rjsz7yM5vRgBVIv0kvo2DpZ6xDHA0DX?=
 =?us-ascii?Q?ckC0FXfp5FHMEjNDK9VGPOtJD4A2kOetjhFJhlDsDND6nZEKyVxGr/4gM6M3?=
 =?us-ascii?Q?MwORWL2DPOjvmFfnIrh8xRC/PoTUP+c+PaR/0tN/T/GBu7NhYjVK4WuxKlN6?=
 =?us-ascii?Q?PMi8FUDWjvgFj3jiW6XQCV8tHu0qAdYID0Gnu+zbmFQxJw1NcanCYIxViWLB?=
 =?us-ascii?Q?ESGshINAO9pRN2Mi0X223VMmiC0D3RIsegUQk3h/kuXUe+2ztNERPKgm12ny?=
 =?us-ascii?Q?GUGFQffUp/kmg21oEAO9nA0eSs8sYm9yRrTucykzdySq8sxKS/De/4MOLgVr?=
 =?us-ascii?Q?JQmHzxEMfscQoXFbC8J+m9PBZaFbMz+K39S0DvUP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346d444a-2ed8-4824-9baa-08db0ef57113
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:39:12.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dH6zkd8QNv/UmxlZ4ZXjpbuP9tm2t06eimVl2CU5N8ktfRORC6N9Jt/kzeMJV0O02A36o5KlBv1RVbAnm+PQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 10:56 PM
>=20
> On Tue, Feb 14, 2023 at 06:26:25AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, February 14, 2023 7:46 AM
> > >
> > > > > So if a cgroup comes it is just a matter of putting charges in th=
e
> > > > > right place which is auditable by looking at calls to attach pasi=
d
> > > > > functions.
> > > > shouldn't we charge cg during allocation? Or it might be too early =
for
> > > > iommufd so we have to wait  until attach?
> > >
> > > We need to sort this all out. I would expect that iommufd will have a=
n
> > > allocation API.
> > >
> >
> > yes.
> >
> > btw presumably iommu_global_pasid_ida should be move to iommu.c
> > since it will be used beyond sva.
>=20
> Yeah, maybe, I'd think about moving it when we get patches to use it
> more than SVA.
>=20

that also works.
