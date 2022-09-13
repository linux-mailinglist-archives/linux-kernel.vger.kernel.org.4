Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D425B660B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIMDO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiIMDOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:14:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949E543DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663038856; x=1694574856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dkIfcPta/s9fu1nIRA5wFmoWZ0kdtK7xtKqV9zraVcc=;
  b=nSFVSoyHax3MqQHmHQh7ezCsZc6SB+a87Syx6tEULa0p2QmeK80pns8c
   2LZVytBNh3PvIlsE0r8Iyw8bMUPgEcwZovc5//W3APdeg3TLGQpRT6GPj
   34gHyivzyzSrbnmIRafyMdWUVKZB8DApqc6xv9B5f848Xoq0C/2AZ47R2
   g+8YgrVfgr7SEVpbVONon9V8GGvAtxDxD3TXgn1Zus6gyTznGRwVlp7um
   9LXTlBVCIRUgDX9pYXoKZJvB63n2LrHvJNAvvoLGRr1SYqD2D3fCcoRu5
   oWn7FN2ppodtc5a4THGtNsCcCM9sQes8k6PTY7f70LVchcYTAhR82sIpU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="295610960"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="295610960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 20:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="742010271"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2022 20:14:14 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 20:14:14 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 20:14:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 20:14:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 20:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDxK5b5DYooi40X32ZY9e7iT07Fjc3kS0+kBATRBt4EX1qaLEPtr5uEQxL/Wje49l4uM4wuNz9ZZFm/Ar0jWv7NSEZzlyZkJ3iaWegFjqhSKYC96+1bHdz6X74k2bH7JR+bAs7pNDRkmnTiPoyIEGkW/kR6XZoxdnPKXJewmKeR8BfA6ZNjZxfWtjaAOgAjlFXbVKrrTVS4aSjLGORf9mcunJ+gIPK4BC8O0OWbknrqlILgG2hACmYNUL7EFxC5daYxjftukWvEqIVog+UJDTWExq340U63NqBJ085tH6rb291jF3IrU5nFGTQLs9TtrPt5sYTTn7Mn83A1MJL4w2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkIfcPta/s9fu1nIRA5wFmoWZ0kdtK7xtKqV9zraVcc=;
 b=PbqhbNhZ2qj7PUvFCYmR+zYTUJGJWag+Yxlp5ICtaFxqbW9qa2dwSsha/wOUz1F1qwmSkvH8/xq8m8iicQBQ7ysqX6Pa4maf9Y2NJdoslIhxmQyR5IaafYm7j4pHWGpOKMbTL/v7s1BU9Ort6m7tawJ6JS5MzE7pjZEi2VrKBFrcx1HjOqkqVMukDuefFaRHX9gQkQF82e02pT/GlV1us1be1M3rO1v3v7+ryEaj7mhRhgeLZilpIi5Q5HJAhRs+ifcBuRpeFyFRK+h1DElvdaP2hkZ9Oani5STQQeKDKSEiVQMeNxx6Gk5sob4I6eZ59X+Olz2zRf676Uv3mN4d5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 03:13:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 03:13:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Topic: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Index: AQHYxlL15aXn1csO5EOwQ10Vd62MPq3cr0Mg
Date:   Tue, 13 Sep 2022 03:13:58 +0000
Message-ID: <BN9PR11MB5276B65B2EAF97D53719D2FE8C479@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 19330053-72be-428a-64a8-08da95360018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2Ml5HIc4V1m9N7y1oYOw6uzlGT1a/0dUOYJ5kMg6u4Bf0dlSTX3IKSO+LIUcJ8PDzvL3enze+HzddtvZTCrPCePts8w/GPguU/k7uUhN/q3a7Unn9ymNM0hmVzUIkFjowqWr8x0L0ZwzwO19aKLx9fSmNj2a66vii5LUZFuv9H8x21kXZIP1HFgfJE60Yv9iBnaiRqfxH+FBXT1fNqfZzrSrPGimMeJTf+TOzEka1VvfBW8cdRWIu4K3BQ356fEcDr2jd6A+Q3nUeXfXjsxw/jeyjj7j80SrLd+zEeC95fJkVdsCLLXqCkPG/4KvuH9iLVYRb22c6O175eTYi4HFf7ViFgZQEW4Ed10HrAHSqpKP3cZuNgJHc8D0XyIlQO4USybj0i09IkZcAoTqt+bliyQNo43sG0lLrY60LL1QzkUioyzsay7xJo9PW3xoiMsNNXhCuiX/NXL1FSiAZKs94Xcttfu2x8yRYqkAnnkuu8Xwr4wF5+T3hITbTKde5JPTTHBVIsbP38SyUH37DwqZySyAUw9Ta2nSZauI/Rh9QgFVprNTHpPgRHZU8VeScHZMgtXIXyKZDgFvhA+FKYBpQygv4c80VYpdzwtkMK/96btmMn2YnPhaaIkh/GOJNcLhZKuziJDeZf4p24fuZS0TpZjcpjjf3H6oYcxeUwQhp++NQdhVTk1fLAkjYxAdkKp1AzRm7JgUCWgZTD8KHlU9dNa5fJJS8IWRzTWQ+nUk/bAT/I2AcDcNf3458sBt/1QvLtwKvKVVRcy/Ptf31o+WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(54906003)(2906002)(41300700001)(110136005)(478600001)(316002)(33656002)(64756008)(66946007)(52536014)(8676002)(66446008)(66476007)(122000001)(83380400001)(38100700002)(8936002)(86362001)(66556008)(76116006)(6506007)(71200400001)(5660300002)(9686003)(26005)(7696005)(4326008)(38070700005)(82960400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqjaTN33jlEa6RLZ1XnXUYEQG5ZHz0WdKDH6Jj972ohL0Eo/j3gVT9elSqYJ?=
 =?us-ascii?Q?WH/xBaw47QncUZm0p3GhfePrElW0WRP73P2OpxBIMGcq8qWtC6dSc+jarGuz?=
 =?us-ascii?Q?mIvu5hP4onnRIX4IO+vddC+RIFiVZ0sJpkc9VV3gJSXPAjMAzuA/jLZijicN?=
 =?us-ascii?Q?JB99ry2pZ6sz2gHBPAWLZ0nUdHgxhFrrUYFr3+5tEt6cvUR+c7DD+e0F45F2?=
 =?us-ascii?Q?5w7aGgUiQfRi7v6pNMhhYdB7EHPV8l1D78sqqSBeYyrwu5WUAmmVIaLuZQrk?=
 =?us-ascii?Q?G1sqNQtXscIrCK9RuUyvdq7PdgOzD3SWjirivYbw4NcqRjvnCKiKBYbZlJUc?=
 =?us-ascii?Q?Ye0nFWSaoLFSbCgcGq2DzgjGYZrgpe2Z/5gguEPY42f/weHba9YBufg/fHu7?=
 =?us-ascii?Q?jNOp6/6kct9K2yGTtH/UhyJ41SrADE+bhFQH+YrS2u5MMmKVzyRD0Ct3Tm74?=
 =?us-ascii?Q?U0o/pORdbyhyEasIdpXvu1uwL+XpyoQ4oLIKVFwUNll7rpxi+C7Xw/+LtFcL?=
 =?us-ascii?Q?f2x86IZ7ymTsRj4D0FsXdQb7G74l+G+M5nhK6rE/+Vo/hA9RPWguQx8f/KWY?=
 =?us-ascii?Q?ga8914yMXI73JDQOUwPUX7zcpFGXX9kc1S+tcp98eSF48kvC+w08rTdMW31u?=
 =?us-ascii?Q?FqskWwXo6kQPWZ/TAdctel0nBB6Evssu7e8yA9N5Cy7Z4rpA8nQTm0ZlMkOB?=
 =?us-ascii?Q?+CCtJcdUci/C/ffb7R4GEaQzRlZd81QCRYuX57sILnNI5S+Np5SD1KUiJb1o?=
 =?us-ascii?Q?gTr//38lA1IC2409AoIW9+J+xKdCzAspl2o2IFRa36o2HLycivGig0A9X/4b?=
 =?us-ascii?Q?Bt2N+mukH4NlNH5/VS4MvZq1WRook/n7eyKyu31Ucfq6xUlmgg05BNcCEm/J?=
 =?us-ascii?Q?zHxF3JaByosNLyEkwfxmpdfPOyHZ6UmpZMsoNrPQkGAg4tRcQHZ3/OkgVdC0?=
 =?us-ascii?Q?Vb0UFrH3p+Let4IwXkui5TesA/fQUMa/AENhFx9YpoTUm1BVf8YVUXKpkKQI?=
 =?us-ascii?Q?h3+tIkqU8YLwrfSS2PonGxT2ENzNyQhFxCCx3np1DzDyhThKC6fiaeCp/HfM?=
 =?us-ascii?Q?jM7j5+JhaiVdUz43p7M2HvBcVzIucT0DkCGAAKWIoZdKHwBx7ofjdR9j/ZAX?=
 =?us-ascii?Q?sbQmD3KOhLQM0uaEMDN4jH/aVGeqoQgdjsFNrccTd9y2aeRxts27JRJYQ5QM?=
 =?us-ascii?Q?UC7bYZEQwTcLS4iUA/D6XrFi0Vm9IA2IBJq9thrygxgDbSJbDQVUQwAJjt+M?=
 =?us-ascii?Q?I6IXMY/8koBptyaIBkLlvrrrbvpQ8zIjy1wa/T8bXwXPtekbtoOSx7b/YRwc?=
 =?us-ascii?Q?Afn3ItQDMNPJrE4A6u1nWwI2f4UiWhinfzIE2vMPl3OWDmDdBgV1thkX35sr?=
 =?us-ascii?Q?4go9k22pPqtrLw0w9P2/q+6xHKKJk4Q//9v1UCX6ZX5vyY+nJqqIIfaMtjjT?=
 =?us-ascii?Q?zFAFi0z+7VRJ+ldXY1ePXK59UQFiD5BUKtx1bRna5zUjvtoO68tTrWzCI7hh?=
 =?us-ascii?Q?BSvecKm4qd1SyhifP/fteqzqoZI1PaBSgxspf+XZQZX393NofndueEBBV8P3?=
 =?us-ascii?Q?G9lB7mzU/QTmFbwUXBwalTFSqC10sSSQX4brrIvf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19330053-72be-428a-64a8-08da95360018
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 03:13:58.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS0JMO/dDFRK5gmCND0EAX7Mn1iCW9mZw2CMKI3JXm32W9DD71axn8Ht+w+LsyLVzmWoq3rqV1yE8bYyOTb2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
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
>=20
> Previously PASID supports on both IOMMU and PCI devices are enabled in
> the
> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's
> functionally
> correct as the SVA is the only feature that requires PASID setup. However=
,
> looking ahead, we will add more features that need to enable pasid (for
> example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
> sense to enable PASID during iommu probing device.
>=20
> This enables PASID during iommu probing device and deprecates the
> intel_iommu_enable_pasid() helper. This is safe because the IOMMU
> hardware
> will block any PCI TLP with a PASID prefix if there is no IOMMU domain
> attached to the PASID of the device.
>=20

IMHO it's better to enable something only when it's actually required,
e.g. does it make more sense to have a IOMMU_DEV_FEAT_PASID
instead?

What this patch does has one problem. It's an intel-iommu driver
internal policy. How can a device driver reliably tell that the pasid
capability has been enabled by the iommu driver?

Thanks
Kevin
