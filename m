Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813FD5B31C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIIIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIIIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:33:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716381B28
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662712389; x=1694248389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CWLU97SVcEz2Vw7X/DGO0CVzzKfiLYM3QCtDfvPyVAg=;
  b=JfPxcEZ2wFPkMWacvhvj7GsT8k5Uvin2jR0UWLXT7pbnJM1o2qsQ7qqb
   xb6sIMafckgumwb+789hIkuH3WpTvP8YGY9eOkFL9C4nhTTkTk7QWQUkZ
   zBZ0HPpbFOK9aEuAYM4ZkjJWgILgyVOgkq9O8dkFFywQeB/dyIFrSIZGY
   b7kyPmTL8Um+Ot98wmrjpirs0DNyTUKlxEH+7y7s3w1FkXu7K7oks754P
   8NqHPJMO2W2OYFzEbdN/oJy0/is03wOXeiE1BXO6aVcFcS8ljQRYOmTPB
   um3P/QCTSvPngOaZVbCkz8QSTSJAfR27xjV7Fd+tVRFafGR0Ery87yBag
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359152493"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="359152493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="566293584"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2022 01:33:08 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 01:33:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 01:33:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 01:33:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 01:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSVV55b9iYETdU8DVHajGxKZy2pkdbnLWRG3ZOGBN1yRD1bkyL+omGcpz6bBPCc4KcC6SQU+MvBpfMnffB2d3ZB1Y/KfOIepjUwUFR7AdBL/SNcLUO6KmySnEO3nEVK+ZC9pix72EUgK99N+oo5wl+cPd41hcs7TF+H1RRMvqZAlreFvRJvKtMAYlUPfaP5d52gIM6vZcun4v1jbNN4AUK477LJzopxhksbs/y+aHYWGmcEDKVTAmo/bKx3eZcPT+WPhCQy9erE9d7w6yqxFH53zTmW9dHkHASLyBQZpw92glspZsA1AsYztkHcEXrEPuQVmbmXeZTfT4PplGvGTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxPEmhw+98pST6jvvXBADIiaXVQASN7d4nqbJg8vtH8=;
 b=M6ZTFDLmgaPRqk5Hw5tFgKsnVlAna65PwqUDNBoZ6BTS/fMtypPCGtFJaeBH9R9EYVbCH/er1UviELl5ui71pJAliQmnUkhTKVIrgaG2qEy7AAPD5/hc3/Iko/MaYDOQFvQhGCK7/SxnQCq74F3cEJ82n0FMk18PT8pq1YipYGEQhefJ7BNpEftghP6Rkh6ENu2lDx4XLLRoRFwAqjbat86Sg5iX/qdR/O5bolRw9kq/tFFiWeIW/2SX6ENk1T0uH/xSnn7ZNjTtIzIfb1WXpX7hje1N2pbnvlapoifAH5EAHddyEz+s96fvppnR3q6jPeiZDNMxW/lurCqFmUPJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 08:33:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 08:33:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Make SVA and IOPF irrelevant
Thread-Topic: [PATCH 1/1] iommu/vt-d: Make SVA and IOPF irrelevant
Thread-Index: AQHYwyyLBYMDVOLHLU+l+Fa55FcAOK3WxbyQ
Date:   Fri, 9 Sep 2022 08:33:02 +0000
Message-ID: <BN9PR11MB5276307EAF55B4EE8AB71E278C439@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220908023557.4582-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220908023557.4582-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4712:EE_
x-ms-office365-filtering-correlation-id: dc5426b4-37fc-49cc-1a31-08da923de906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0nYqdI5CUj+d+1/O+srtF+EVO9SiWxtvG9hjJNNjp+pXXxYxmd3Cc/xuQrBT/+0jrvqYV2tbpWKr3UPXUr7bGPYZypA91KBAyD9nc4E8YRsoGe/0iIBY9Lv7P0sWhB5UOPlw8mVIjP0f+ntU+GrTDv/ttcp04HpvB3ekBb/hrg7e5Sbv/Sn4KqEQESDeceHdYqETloiGN4ey4vRXtNvHKO7k3nBVr8npYl48NvUoN4Z3BTzBZmoVF3BI24mj4nH43Yg4d0K3UeqNJ+WbwJ52su8TwvbVisVHs2i9jtprD9gXSxAZQ+rS5/NF/lU7cZyJx0Zu6XO5N6JPcdXfjt0n3w1YbxXxi4tdRsaFHGqV3ymvxzJN0Aa9EcIz5/lUvlnQaUV+fXhMQlzdnr5owznnSTikSXg33RZp93yXZ2q87tZTx2l/B2/URNOOj3SPc4E61vtTltfm58ymsWgq8bEu9eBe1mGhXJZoxM8Nt0ptwunbwanrHDx2PSnZCdBH2tbOTOBBl98K//umJtkxL2aA03nnPODiSKMX8lYRLNGnCVXvSZPG4ZCiNmLgcq8hA/UFiQEmSLmDwTsQhRZ2W9mZ5JZJF4VfMMT/S/Diqh8MriDjpJjXcghF9O6POLUd0uC65npHz7PizEu1CMGyx1dq8gVcY/m4f/dKTSLC3oN4eD1czzovqac+GmCk1nH9yyTf/Vux+c7OL+xexVpJw4iaVUWuBf1XfQuawJHyWpJt3sxLoLy9idBhrKOMb1eBJF5SSycTrssp+k7gtt+8XRTGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(346002)(396003)(478600001)(7696005)(83380400001)(41300700001)(9686003)(186003)(6506007)(26005)(8676002)(66946007)(54906003)(110136005)(316002)(76116006)(4326008)(71200400001)(82960400001)(52536014)(55016003)(5660300002)(66446008)(64756008)(8936002)(66476007)(66556008)(38100700002)(122000001)(2906002)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qV8Hd3N3CNMou5ygEoIa+wD21lkTa4qGk7De21EDEBH37IERb+1oUCC5pAk9?=
 =?us-ascii?Q?Cse3gK59fY3TNu7rnQujiAguTG8f1h2pL60KOxCNvb5LwEdF18e+bM6DmYNt?=
 =?us-ascii?Q?4gJmopBiuylEHgTEduoagH1xP2VHZMaltht89QFTmpVHfuJPV1kl6Yx+QcK2?=
 =?us-ascii?Q?FTPqw0Yex5LM49OcoT/8dJqvg2+Bv9YnQ9RXl+9A7JhBDYIER27YneT6DNmD?=
 =?us-ascii?Q?/9cR2JVFmubxn7l1SET05530zCf1DK4sw3RcDdX84t8AP6AsIJb0CwUvGL9+?=
 =?us-ascii?Q?LWLhna7gVpT4CG8VAG4VAaMRRtwXshkLdR4Z5UyYRboJ03JI8IM6YZesVSL7?=
 =?us-ascii?Q?cKsZPDY0rgaO6SHJSa+HrqdVxRP4qiO0JVfF8Ketby0LuBMz5c2/5B0GUo2U?=
 =?us-ascii?Q?nnWKD77cEHF5mUHfTEyxnlwAsuUmj9F0bNIYlCiytdT4quHh3QaYq0Kpg/kY?=
 =?us-ascii?Q?K1Aw8q2xqZbcCxvL2KYC4fPDlnycf8umvZhOZrAjYBw7b0mLRHEUmhyuhdi5?=
 =?us-ascii?Q?MNUtB7sY84y1/2jPOjV9VfdgFLB2duK62yUOpGtDBibSYKA+cBP0o81197DU?=
 =?us-ascii?Q?xA6VCj1VENGMX+MhPh1vZBJhUoDwi8oQeUtJplBL/4+zrDKpfdKnE6EWldZq?=
 =?us-ascii?Q?CsQEFpm7mXnhd9lMTBJyV2FWx5ZbtxZkrYI5mgGkJ+Vfd2CTFY0OXf3wowba?=
 =?us-ascii?Q?IDtPTCw4SGi1b2pJEME5Ve9OwYWUx+PDiglHJJCmUIqMzSppeDSG7/ms8WNk?=
 =?us-ascii?Q?i/YK/B0Il+i89oaQ3Li5/7d2eWPZ/PrOlxYH2YW8pVpTAQOZ+Z5SWphIvxXj?=
 =?us-ascii?Q?OHbHLGyXzH738HhO2v2iQA5qwciKXfDi9g/4dqP351vjAa8jWC9iw933gxEh?=
 =?us-ascii?Q?mXek+7L7hBByTQdXbhrBop7m/gXxqdyFuT4V7IGtvw8IFGfPRDiYwXG9dxIz?=
 =?us-ascii?Q?ngodBeKJMJcoKzC99NMR79o0xh5k9QCKk8tpQPL0fQHRcGFGI/RWftlyw+0e?=
 =?us-ascii?Q?tLwU4Qi3VPb1DAL5RqW1a+jijhnip666S8t6LEWSEGmQJY3YnPO4WMvJCbWc?=
 =?us-ascii?Q?RtNs1nTQGHDpoe3Wl39Hj1Z5nvbCa2yw62Nh9Y47gKYO/ZSAuyCF7QFOV1S1?=
 =?us-ascii?Q?dfc+w+E5Rb8Qd6PW+NnfPNpwDFSnR+OTmgitapYTpzsbqQXxZoKiXAhs+N9O?=
 =?us-ascii?Q?ARFw+u+4IMD0oaZW0+kyOVNfwTnCAnU4roMNVfvtv7S5E86i+lmARl3FcNR2?=
 =?us-ascii?Q?D8hBlSPIvVzSqKONm5TzjUPkdukyTZVWZoFbEbHS+spfARWg9yWFKVDSl0j7?=
 =?us-ascii?Q?ahX1n8gsM3jJYx+3zKFNFh1yeaSBg/6cmiT7jpVHOM7+V2LAdPUv4MjXkv7d?=
 =?us-ascii?Q?43oVqp4q9o4lUb65iQbCvl75pP8Uxqnt8cAUAU8oe2Nu1IDmnxYw0cVbxTFo?=
 =?us-ascii?Q?vGAwqrB9omkU4w08KoWH+UgJloPnQx0wmFjsDX26iu9V339DM6rkJmm6zbAO?=
 =?us-ascii?Q?qHoYlS7cdgxl/JRp7NVOjUPiP1sxvrQJAucTwz/NYIW6v8ShTHfrfKwL1uVr?=
 =?us-ascii?Q?HEi2gzt10MTfppC1vwJ9rdfxms/VK1D9IsD6WT8H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5426b4-37fc-49cc-1a31-08da923de906
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 08:33:02.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLY0GVFIT8CY6vHAJR9bd7tK18Y9T3D7an+OfToEtX9TS8BZhnohFuD/wLpqpubHgMGTaT0PzeNDTDnHtB04Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, September 8, 2022 10:36 AM
>=20
> The existing IOPF handling code relies on the per-PASID SVA data
> structures. It does not apply to scenarios other than SVA. This
> decouples the I/O page fault reporting and responding code from
> SVA related data structures so that the PRQ handling code could
> become generic.

I think the point is that it's unnecessary to access those SVA data
in the fault path. otherwise 'decouple' reads like an alternative
implementation is added instead of just removing the code.

Overall this is a nice cleanup, but a few nits here:

> -		/*
> -		 * If prq is to be handled outside iommu driver via receiver of
> -		 * the fault notifiers, we skip the page response here.
> -		 */

I didn't understand what this comment is trying to say. But just want
to confirm removing it is the desired thing given the original code below
it is still kept below...

> -		if (intel_svm_prq_report(iommu, sdev->dev, req))
> +		pdev =3D pci_get_domain_bus_and_slot(iommu->segment,
> +						   PCI_BUS_NUM(req->rid),
> +						   req->rid & 0xff);
> +		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
>  			handle_bad_prq_event(iommu, req,
> QI_RESP_INVALID);
>=20
> -		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
> +		trace_prq_report(iommu, &pdev->dev, req->qw_0, req-
> >qw_1,
>  				 req->priv_data[0], req->priv_data[1],
> -				 sdev->prq_seq_number);
> +				 prq_seq_number++);

Previously this is counted per device but now becomes global. Could it
be stored elsewhere in a per-device structure?
