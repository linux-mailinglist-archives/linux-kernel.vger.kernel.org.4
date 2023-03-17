Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D96BE641
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCQKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:10:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA46A6C8B6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679047835; x=1710583835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5qovmi0rIYUnlTi1MdOdXtkrta66GTF5hNrzZHNCG/w=;
  b=WY42ytdjlATZJA7m8LfER1lLn6P7TdpayeOewhX7cbYBAq3RkfnOHBqB
   JIOZlkQNO4yoURTbXT+O5o0Md3YZf0FVPpizxWuXEHrNYwEb3P584sxeN
   WxV64rkyCYF86f0P6aowYjoAz6iRe5lnpjTi48OR74nGwN3kvWmli7gEq
   R1ilTHzmTd73uRS7ZuUHsPWzD34+1G3YatD91qmh6YHgjvy3OaS9F6mKz
   Ea2RYnTsuKJaWeJLJz1Do0e4zA4ubfCmDQvRgWri50jnLGlQiddggB+Fq
   zKKiWvke9mNB2Q+EcQUzBcc+B5CGA+Msq3ZOIhK03Z9AyXe7FNTFxoG5A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340592164"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="340592164"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="682631861"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="682631861"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2023 03:10:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:10:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:10:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:10:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqMtIunBIdEFCbqWbroQOty/fDHmMAEIBlwFLkkaH8mjDUZyyCiiBS+cVVmixjEpnHmf4RjQI4ZQgm+Q95Q3sNIrNPdK4K+wiUmG3CdmAX5MczYTslOKkhB5S6poK3Q5jVSNeOZ8X/avgd/2Z9ILoWsGP0qjRaJxyvIW7vLWSYABMMD0cfMXUumLSI+aWpC2WSPu6gqvoBYzXrMjH8baH6MRSuaqOroqJ4nP6Mvnxr+XPCO3wgDbmdHqg9CqsSUccaAUl3ssTv/inAUuMs+AaYmvDf7UfMHI7D7Cn4w0Kn7bdvJlo5cB3S0zBkIlv2ewlvUS0bUcp0+MVn27ZrfiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qovmi0rIYUnlTi1MdOdXtkrta66GTF5hNrzZHNCG/w=;
 b=lYVpQVZ6tTOGhWhbhtL7SiiFmjyW86jB35ETmRYl1/lyEWxpp4kmL6FO78oMOqNsB1RTKepqOmQD2ByD1HJwh6n3r7vy687KVtuSlqAPXjX+aMJEQOvXRC6i2LHOXlkm344FpcsHjvqlI8eUiol8shhnfzAIvJ3pgARbksXC9+MSmtm9o7a+NkoLSoCznxJPbS/fQljLvOtn2QrhAEqMnTkhU7TRiVBdDb2ia8lodd6CttKKF1gF2HQWsyxFSDniRkDw/aUvdOd/Af1O8LmmpNvhsWbOndPWigYkDWHcuMfVWBiN5PvEQsFGxH0j8MumdU0Yp2rKd8VhE77vQ/7W2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:10:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:10:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Thread-Topic: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Thread-Index: AQHZUnWUiZWK9pEL2E+1+XYbwxtqR67ydQKAgAASmACAADzzgIAAKxqAgAErXACAAAkLAIAACQyAgAABpQCACpw3wA==
Date:   Fri, 17 Mar 2023 10:10:30 +0000
Message-ID: <BN9PR11MB5276583A882BFDF84D0015668CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica> <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica> <ZApJGwPjHhlDwTDV@nvidia.com>
 <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com> <ZAtL0Dx0QRbXOTfZ@nvidia.com>
 <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com> <ZAtUyMGIGsl64vM0@nvidia.com>
In-Reply-To: <ZAtUyMGIGsl64vM0@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5266:EE_
x-ms-office365-filtering-correlation-id: e5d724e7-fc04-4b36-ccf4-08db26cfd6f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jts1WHmB3oP/VLP2aY/kersjY6IKK1vUG1iA3q5PaVlsEw9+msr7ISTST1iLe0hasf4+s+HDTTPWzO55SrmGc0X6ighfg+0rs9UxghGnZj0Wc7oFzwxVbeghUQ1r1W3ed6lDY4xo5CG2XvMlg1oFXKr0QSsbTYFvxh3thNeKWk+7IuLAWknaY+fmigdUJAfAr+80cfa3g0AHzrqvSXEnkLt7pIa3nRrViUf6phXMneOgphHiutNO2h3ODJ0iqy4B522PpBrmB/ZVq74YQa6DEBp/sUvu944f5EHc+snd0nmAkmiifSwh2wm/9Omk2vUGTAYHHw3BeE2D4+URRvXQz2mVQ+YfjfiSN2CeQJIxKyAKOutlUMmBLsHir7uCV7SijFsdd3qBws3FqH2kYuEgbFJVr/LirmzLcnHmIp3KZhKBxvVIx+cqvYFyTZsLRF+L+FS+tW00pTE2/ht3jODarcu4wJTs4NrT9JDqdmqyMPjuQlFY4stOZH8klARF73t5v8qxIQcFHNEKDtCiWTDCeN3uM1bLZbAY2Ni7PqARWhAMOQDPbimJ64dcriQC05IbIU+rDAB/pZVQJo12t1t7dkl+SEsHCiz9hIKqo1MmTPaCTpGGnVh4wTDPO7o3ethNTyvceSogL7iSVLHpp8AkdftxjNlW+7vN6GqkQtmdd54x62gnzygEFF2tfSOmpz5w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(38100700002)(33656002)(122000001)(86362001)(82960400001)(38070700005)(2906002)(8936002)(5660300002)(7416002)(52536014)(110136005)(71200400001)(478600001)(55016003)(316002)(4326008)(41300700001)(7696005)(76116006)(8676002)(66446008)(66556008)(64756008)(66476007)(66946007)(83380400001)(9686003)(186003)(26005)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dndwVmZCS2R1RlczK1JOWEozMTh5dXF0eGVNNWZ2QnhhK1dYWDBaQzI1c01B?=
 =?utf-8?B?YXlzL2tFb09NYldQdld0cVFxMWtLQTdaRi8xOFFsUzZzSzFleGVyOHBrandz?=
 =?utf-8?B?VTJYVEhDWWJ3cEk3STNaQ3UvTnQ3Z1h1VEorbjZicjdaNXlzWEs3TXpXMzRF?=
 =?utf-8?B?eHBxOThQa1ZGRGhEMWFhZWkrYWVTdXNhNjdJNEtscG02aEc5Z0tTbGFmdGx3?=
 =?utf-8?B?QzZZbWVudWd4SkZ0N1phYUo4cVdCb3Z6bmRndXVIQWVScXlQZjNFaFZTbmxx?=
 =?utf-8?B?M0lFQmk4MFNVb3BjV3EyVndTb1lxUG1YamtWMXk1c3hNMHdGL3VJMmQvaUV2?=
 =?utf-8?B?dFZKQkVxRU8walh4SitYVEc1NXB1N05ISjFGSldSZ3BtVS9TdmFNcnkrTVRt?=
 =?utf-8?B?Z0NHSW1sQmhORUJrMnhtK2trT1pkVm5mQlR1T0JzVUUxRCtPYmIyUmY0S3lL?=
 =?utf-8?B?TVlSUEJUSm9tOHpUb01ySWlxRnBzbmtHQ3FGSmZsTzR6YXVtdk9ob1hXZ0I2?=
 =?utf-8?B?SUVWS2NQc2R5N3c5NStNK1kwbmdPeTV0ejNoSkh5RWdraFE3ZW00ek1rQ3B5?=
 =?utf-8?B?TFV6UTVXOW8yMEZzbUZOSzl0SHNhTGNGeTBzZjgvNFpqZjBJMWc2K2RlU2Q4?=
 =?utf-8?B?OTBodTBsYjB1ZS9HOXAzYlNWamhHZXJPc1JibmJkYS9iTWkzTzQwQUYreDdL?=
 =?utf-8?B?U3h4cFhod2JqT1N4UWhyQTQ0WXFhNUcvVE9qMmgvQ0o1SDlvRmFSeGduUUdv?=
 =?utf-8?B?RjRDSjNwZDBRdi9md0RFczZOcjVYUVVHVTc4MTB2VlRSTzluUE16aDNRODd1?=
 =?utf-8?B?U0lpNEMrSEMxTVd6ZTE3c0x0bis2bVFUbkcvY3Q0Y3lCdmlGRzMxN2MzemN2?=
 =?utf-8?B?OFAvaWxYTm9OQXp0aVhQNUNlUXJWcFQ4Tlg1VUM0eEZZQXdlUjVXRVZmTlRV?=
 =?utf-8?B?QU5DaERlc3NVaDJZT1VCRUlRSk4xMXpMVVJjRVdBL2xhVjhiL0orWHpBRTUv?=
 =?utf-8?B?UCtNSjdqS1lBaDJFSVpCTVp4Mzlha3lPTm1MbjNuWUNpMGx1SGtRdjlzVDdY?=
 =?utf-8?B?TWU5clV2LzI1bGVSbkRpVXR4Y2JwYkwzbHVYWGo1bjBuSkxoQXRDS3dNQnQ1?=
 =?utf-8?B?RjRraTBNQ3NUc1ZtRDJaTHUvMEVURlpkV2c1NjRJK1dNRFc1WkZZTjFvU3hY?=
 =?utf-8?B?Z0lTaVA4ZGp0dHBJdTJsamxJM24rT21DbU1JODVwRUt3V2Vrbm9RS2YveUpL?=
 =?utf-8?B?bTM1eGdxcU0vWWwrZjV4NEdveHpJdVJvamdrei9sdENKSG5UMzU1RCtXcWk4?=
 =?utf-8?B?OGVSa3g1V1J3NlprWDVKUmYydjRvRGE5ckFBMlA3SjUzNEJ5UmREdjVsYVFo?=
 =?utf-8?B?RFFFT0d5QVBaMHphaEdKRk1mMDU4bUZKWUVHcWJTcHVMS09kNWZ2SmlGaFNy?=
 =?utf-8?B?eDQ3bUxRR3Mwd2hleG9kMnpuWjRwdVdsTlhyQ1IyanFGcTJxQTJvNzVmVVBV?=
 =?utf-8?B?VFF2dktCd3lyZ1ZkdjZKK3huaEczcXJUdzhPWmZKMGYrdzhnaWZIZlM0VGl2?=
 =?utf-8?B?ZHdCdlVTekEwam9jUE1FN3N2WkpiNUlTZ2lSQlNlRkNjeUxubk02N0ZkV2ov?=
 =?utf-8?B?YVJNdXU2bzJRalV5YUE1TllxSnZnUG84Y2FGRjZRRFFWRksvZ014T3J4clk4?=
 =?utf-8?B?RkczRUZlRHh4SmNPdjE4S3pWUUJSNVJBS2E3M1ZhS3RvTGQ1dnBFY2RPTDVM?=
 =?utf-8?B?OHhXWTdUNm1pUjcvQzlTY08zSEM5amJCK04xTXEvNzlJRDRVMS9RMkZ5UXI4?=
 =?utf-8?B?eFM2TWt6R0tzUXkvN0FxOUhjSi9XcHBIZXVCMldpb0FKNlczcWd4Mi9UVHJR?=
 =?utf-8?B?N2lHQW13ZllOa0doaHVOeFlOZWVlQUUyS1pzRU9RVXRwYkNWU2orNEVjeGJM?=
 =?utf-8?B?Ylo4RWoxa0tibXN1WSthWGh4N2xObkoyT1VPeFJLN0hTcHNkdjdCVCs2aEp1?=
 =?utf-8?B?ZTdxeldqVFNLdkN0dVVVcDgvMWJMOURHOTZocG04blJKbGlmU1M3bllPUmtS?=
 =?utf-8?B?WVI3a0FUTHNYS1NtY0RTa2pWSkVHM3NwbUNJUXgvT1dETHhYeWFod1lmUnVX?=
 =?utf-8?Q?FjABS+WlDGgKii+Ua0nOuSLVF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d724e7-fc04-4b36-ccf4-08db26cfd6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:10:30.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJIdqHCjbOdJIer6a70uP97Vn+duqihAu+j4uVr/BOmV4Be81gdXH7tHZiyRK6PmFISmAEeGkWEJ73UJo7zGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
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

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgTWFyY2ggMTEsIDIwMjMgMTI6MDMgQU0NCj4gDQo+IE9uIEZyaSwgTWFyIDEwLCAyMDIzIGF0
IDAzOjU3OjI3UE0gKzAwMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gDQo+ID4gYWJvdXQgdGhl
IG5pdHR5LWdyaXR0eSBvZiBhbGwgdGhlIElPTU1VLXNwZWNpZmljIG1vdmluZyBwYXJ0cyBhcm91
bmQgaXQuIEZvcg0KPiA+IGd1ZXN0cyB0aGF0IHdhbnQgdG8gZ2V0IGludG8gbW9yZSBhZHZhbmNl
ZCBzdHVmZiBsaWtlIG1hbmFnaW5nIHRoZWlyIG93bg0KPiA+IFBBU0lEIHRhYmxlcywgcHVzaGlu
ZyB0aGVtIHRvd2FyZHMgIm5hdGl2ZSIgbmVzdGluZyBwcm9iYWJseSBkb2VzIG1ha2UNCj4gbW9y
ZQ0KPiA+IHNlbnNlLg0KPiANCj4gSU1ITyB3aXRoIHRoZSBzaW1wbGlmaWVkIHZpcnRpbyBtb2Rl
bCBJIHdvdWxkIHNheSB0aGUgZ3Vlc3Qgc2hvdWxkDQo+IG5vdCBoYXZlIGl0cyBvd24gUEFTSUQg
dGFibGUuDQo+IA0KPiBoeXBlciB0cmFwIHRvIGluc3RhbGwgYSBQQVNJRCBhbmQgbGV0IHRoZSBo
eXBlcnZpc29yIGRyaXZlciBoYW5kbGUNCj4gdGhpcyBhYnN0cmFjdGx5LiBJZiBhYnN0cmFjdGx5
IGlzIHRoZSB3aG9sZSBwb2ludCBhbmQgYmVuaWZpdCB0aGVuDQo+IHZpcnRpbyBzaG91bGQgbGVh
biBpbnRvIHRoYXQuDQo+IA0KPiBUaGlzIGFsc28gbWVhbnMgdmlydGlvIHByb3RvY29sIGRvZXNu
J3QgZG8gUEFTSUQgaW52YWxpZGF0aW9uLiBJdA0KPiBpbnZhbGlkYXRlcyBhbiBBU0lEIGFuZCB0
aGUgaHlwZXJ2aXNvciB0YWtlcyBjYXJlIG9mIHdoYXRldmVyIGl0IGlzDQo+IGNvbm5lY3RlZCB0
by4gVmVyeSBzaW1wbGUgYW5kIGdlbmVyYWwgZm9yIHRoZSBWTS4NCg0KdGhpcyBzb3VuZHMgZmFp
ciwgaWYgQVNJRCBoZXJlIHJlZmVycyBhIGdlbmVyYWwgSUQgaWRlbnRpZnlpbmcgdGhlIHBhZ2UN
CnRhYmxlIGluc3RlYWQgb2YgQVJNIHNwZWNpZmljIEFTSUQuIPCfmIoNCg0KYnV0IGd1ZXN0IHN0
aWxsIG5lZWRzIHRvIG1hbmFnZSB0aGUgUEFTSUQgYW5kIHByb2dyYW0gUEFTSUQgaW50bw0KdGhl
IGFzc2lnbmVkIGRldmljZSB0byB0YWcgRE1BLg0KDQo+IA0KPiBBZGRpbmcgYSBTMSBpb21tdV9k
b21haW4gb3AgZm9yIGludmFsaWRhdGUgYWRkcmVzcyByYW5nZSBpcyBwZXJmZWN0bHkNCj4gZmlu
ZSBhbmQgdGhlIHZpcnRpbyBrZXJuZWwgaHlwZXJ2aXNvciBkcml2ZXIgY2FuIGNhbGwgaXQgZ2Vu
ZXJpY2FsbHkuDQo+IA0KPiBUaGUgcHJpbWFyeSByZWFzb24gdG8gaGF2ZSBndWVzdC1vd25lZCBQ
QVNJRCB0YWJsZXMgaXMgQ0Mgc3R1ZmYsIHdoaWNoDQo+IGRlZmluaXRlbHkgd29uJ3QgYmUgcGFy
dCBvZiB2aXJ0aW8taW9tbXUuDQo+IA0KDQpUaGlzIGZpdHMgSW50ZWwgd2VsbC4NCg==
