Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169866976D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjBOG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjBOG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:57:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9971367C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676444229; x=1707980229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sHlliGwZJKNzjHjLF4/pF7Mmu8r5Jj0INKdjSjJ9FGs=;
  b=G43PcqtfccjwvfBtyR6Qjr0qzguT9Gf9o7n7/zdZKDmK0FoMGPEqam2k
   G+PMVNBmeeF0KxpiJKTKX8sVFu2VWg1YGhKcjbO6Va/uQLuoqdOfpm58A
   ofYehJjoHA6bRTAZgX2ys/qOog2onU26+BkYkFl+8B1904G9Da8FDaJnT
   /bwh9bNMbiIFsTrsT1+/LU7r+lQVJZWiI+QJM/6tJOEIwIhj/d0h9UCLm
   rvEXbwzvdGYyAn2MB6j9NXQ3qAJe6lUBSNDV4OKeUERlcRp1qz0WdzGvi
   mW7RuwocXYHSGZoZaqeChcJXq82Ed4SFu386M2DwO1aimCWAKyRqzMJZ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319392426"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319392426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733169231"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="733169231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 22:56:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 22:56:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 22:56:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 22:56:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 22:56:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHZtQPxLpVtYn9R8TwcJNfZwrqVvJgAR+NG3m93Oyj6GVaA+aa5L7qwNEQTfxJPj5u5AdMa+QqtOXPZxWvItkNY2vv6uMw/qzTDFqIB6u7+vIjWieXeYyKh7Q7b1FOrVxN8QCq1KQhJfnFS1tNKugiGi5QP+OY1pb5cqGGlWAgqXXtBkm+IbVyEdhdTDttPTakTiy0ALq07Sqn5dAO0vZmISqhgawS0/REdKpC6XP6W6QfD3RwV7Q8P9CM7vIpd/6qiT3el+cU7f58czGnuY7iF18wLEOHtbEYjlNE7IR2IdYVUiSynZFNdgqGOJJf94FCSDFMX2yKjDmHdZKVmOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHlliGwZJKNzjHjLF4/pF7Mmu8r5Jj0INKdjSjJ9FGs=;
 b=nVsbOg4SG+YjE+CP8/wJPBCVN3UlqdFQSMc0yIGujjBkLWafzGtkv24DHJpN5dnWow075YHqQdVjqhEdZ2rZIe7ka/7ACE2NPmbMWJe0CVO09Q155m7oIp+ZlNk+ObLvvg/PmCWItRFwofjoU6R8Vz9Gdleh4KzyN4lsCQTH7xzvmX0oNWTgn69EInu7Is5nin2VKwv1q4hRst2ZAFlaeh9Hn9PMoNYf9VLlpz+wvSL/q4i79KNDlyrPiVXA2O4sNB5VDhn20tQxCMRgCkkYGUgFt9ZVxLMraDvMOXRFwv9GoG1r3yC6EpKRsJPAbigzRLs+kOaDNyIgwoBvmXunYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 15 Feb
 2023 06:56:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 06:56:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Thread-Topic: [PATCH 2/4] iommu: Use group ownership to avoid driver
 attachment
Thread-Index: AQHZP4DzQWpmYHp6I0aZbFmYBMzCEa7M7WIAgAKWogCAABCCkA==
Date:   Wed, 15 Feb 2023 06:56:39 +0000
Message-ID: <BN9PR11MB52768BD174CE9F4AE40C12078CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
In-Reply-To: <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: a0bbfcde-faf2-474b-40a7-08db0f21c9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoBv9KiwgGpPIwqY6Ski8jbaePXbG4IVLw9zqTea5CJxFBoSCIP5ZExBUUNzKYqKJmlxAq69xC4QQuqyi7NMKx9Lo9lcKPpmXZtvlRMETmQ9idyfMdgIl+molc7x7Z5/7nyYDwc79T7zyQuqouyMYDXJqybLIMNaged5e5/PO/BFxDScguhZshjLHbisG1gdOFFP9bNnQP/BZK8ABpdGptgT1CbYptdAZx09TkUL8FH3mMN8uu1TvK3d3F89fRaKiyCpkVmmgNbx+Cbb30Wk+SnFrdMg+xz4wOnjsW9NOh3uJgqb6EZ/yS/jybyy9TVnhnuEUiGp3GLqOjzIbd3rMBlJUip06n3BqvDdlJvRxCtN80f7LeE3rI5Xa0f8Uw5bv9WvKjpeIZOVD0AiX4msChrZ/8or1VvXeeucAauzPhhipycPV41YKtuvOObHyAJI//qNVTaLFB4NAaYNrMGxIg7iNcz6ZPAdvSTuB7KjeEf2K2cna1mOVh7VHgjYHlACKnzSLxBfxUoS2pzYYU6hEABFRo+apxMSmwkQ+emNO0EDfmXEw/HfJBwBRZjK9I1zcEs3nCwf20O9IgKSx73Gh2zr2uH1TAP5OhvWU90UPKsyGl3jegZHd9MJcUXhVK6dHVnCBotHgbz6puwiwP4+h7cAmLhmS1qKNNvZP3JZufBtmk7E90ordlT+HWSWZXsQheC8I5LhOyY/UEckB1OiKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(186003)(41300700001)(4326008)(8676002)(38070700005)(6506007)(66476007)(66556008)(53546011)(66446008)(26005)(76116006)(110136005)(38100700002)(83380400001)(64756008)(66946007)(5660300002)(9686003)(82960400001)(52536014)(54906003)(8936002)(122000001)(86362001)(316002)(478600001)(33656002)(55016003)(71200400001)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TythZk4vWmhzUmpqZloyTTY2RzhFSGo4ajRLTHdHWjNxUXJqYXROd011YVBz?=
 =?utf-8?B?NndxU3lWVklINzI2Q2pOR1pPaWthRXRGM2JKbTJqaCtOdGJqWWlmbVI0dTV2?=
 =?utf-8?B?eXMwNHJ0Y1N3WHdmblZrcnRSUXpMYkJpMHU4Y2RYMlo5ZURuYVRPMHJIRTdL?=
 =?utf-8?B?UGkzRlg1Q01oeG5GaWFRSTRxM2UrSzg2ZERXQ2lxYVZkVXF5YjdmUjFKeGk1?=
 =?utf-8?B?S1krdVBWbTNzUkJjR1FEMXZlOFV0NXdFaUhRM0luZnBuSnFSR3FDVVQ2bW5G?=
 =?utf-8?B?bkJQMzRCQ2VMRko1blRSU1Ardy9EQ1lVZGNWbWZLMTd6RUNScXcxRzQwbDRK?=
 =?utf-8?B?ZUtvQ292ZGkvT2xtWlcySXRTdndaWG4xaXQ0WlUvb29DMmVZcEs5djNlQ29X?=
 =?utf-8?B?Q1VZNW1QTTU3MU83cXZpVTlnYVluUmVjZUloTS91L01EYWZPNXdualFBbXNs?=
 =?utf-8?B?aUxEeitqV2ZqVHVsVmZvSms3N3VKK05pVUZJdEw3MmJRWVFQa3BSOHA3c0dK?=
 =?utf-8?B?Yzkxcm40dFlXdUsxZ2w5dndRUjNBMk41NlZVVTl2dDNjdEwzQUw4dnZmalQ2?=
 =?utf-8?B?bng3TjVXMUo3b0NSeEp4ZTlCbUxIZnZMK0pGRTVLTDk3T2RRK0REQjk3TzZE?=
 =?utf-8?B?QzJIU3lTbmhGMTdjdy92bjJnT2RyL1RDVUZNbE0zZDlZUGFWcEVYSmFPcEQ0?=
 =?utf-8?B?UGFLeE5XbSs3M0xHNVhOSXJERWFpbm5CbnFzSmllbHVYZFJENWNNOXVzbTBM?=
 =?utf-8?B?c0VrQ3hrUHRTVUZkS1c4blZXODNUYVRHR05aWHhxbmpiZ2VmRVVqMjdzYVBh?=
 =?utf-8?B?N3UrTEZEWkhnNlVMRHQwSkM5RTg5R0M2NUViejF2dnRmaHhWUVRGN2liY1kr?=
 =?utf-8?B?Uy9zaUJEd0kwQVRuNjdYMklCelBVUC9vcVZXZlM0bHJqUXpXTGd5d1VQeEZm?=
 =?utf-8?B?MURubVZXaVVzU3BSWDNOdlFDek1rM0J4MXh1RlYxR2FKVlRsMmZRWW5hMGlZ?=
 =?utf-8?B?RFl6NlNHUUtxVFFlaEJ3WWNKY3ZjNXVPY1hzSDFXOGFIZWorbXJzaXRPR3ZR?=
 =?utf-8?B?WnJUdXhnM2tpTHRQRUpuSkxLaThNaW9kS3pQRk5CT0dWZ1FOd1RRY28xZ1RB?=
 =?utf-8?B?eTR6WEZOTkJpUDBxUlhFWWNZajErUjVLMjhoaTJhbkh6Sk5QWnpWaFJlMDlO?=
 =?utf-8?B?T3VmNnIwSTNmMURhT081UFBObHg2TDAwVGJnTnFXV1grQVRoSTZDdU94djRB?=
 =?utf-8?B?ZHpoNXoyckVLWmNCQ3h6Nkgybm5DNjBWaHZqSytaTXROYUV5aXpTa2x6bHlo?=
 =?utf-8?B?ZXdvbVhkOVF5WnhCRDBZcFBsVjFYa0F4L2hTOWhSakszdGJiTVVrcVM2N2NK?=
 =?utf-8?B?US8vZHNwSlZQc0QySVhqTy90S2VTNS83TGx1ZmhYQzFsWjBzSlRVdi80aEVs?=
 =?utf-8?B?TU9BWnYvRkRYaWdjUU5kNzVDc2ZmbzRpanhaUXRVSWpUMVBXajJOekZwK0NJ?=
 =?utf-8?B?ekc0cVFadUxNOVMyVGJZVWFvYUJ1aGNkdmFObVdnaHhEM2VFbGpOK2NFem10?=
 =?utf-8?B?dE1UQzUrT0wyN3hBU1FnL3FOTFFSMU1uSjh1R1dOeEorNkFxemtHKzNzdUEv?=
 =?utf-8?B?Umd2UVVBZGp5bXVEbEdDVE5oUDA3ODR5eG9FS1BVSkZKWGY1ZUR1U0RLcHI3?=
 =?utf-8?B?c3ZGL0Mrek9PNVZQUVAyWU0rQnI5Vk82K2JwMmJyck1tdTBSakYrWEZUbWpw?=
 =?utf-8?B?VjdkY00vR2dyV0pUMnJRYkYyOUdiN2cwUWc4d3l1T0FRdkJ0UGV6azhOcWFj?=
 =?utf-8?B?bWN0ZWJMa0p4bmNzOWc3Z1A0SDFwN0pwVHl5N1FTdXNwS2xRekFrMXM5ek5r?=
 =?utf-8?B?VHo1YUQ4TmUwcjVla0NmY0hUT0U2Ly9HTGRxTHJabXhsOWFTZWNsanl2Ukts?=
 =?utf-8?B?S3pMbENoWFZWMDM1dkNKU2Y4N2FHbUdLY3JhakY2VWxFZjFMb3hNek5zTWRi?=
 =?utf-8?B?WFFianhTQURhTVdTQVc2OHRQQU1DcjRXNDZSL2QrSlRQS0R6RERMQ1luY3Rl?=
 =?utf-8?B?UTZ3dGoyaGhDVGlVVXRlYVBQUXRiVmg2dlpyRFJ6eU8rTUt3VmlMYnR6cTdS?=
 =?utf-8?Q?oVcdMDwkKr3AvjjiFcjcgpGD8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bbfcde-faf2-474b-40a7-08db0f21c9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 06:56:39.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZ6E4+SaqSoao70NP9s3ULyeCUmPRt3rI5PpBaKH78d8k/8fKora8waLdvsiOPe1PJo8CegmvHDa4mEaLWd3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIzIDE6NTEgUE0NCj4gDQo+IE9uIDIvMTMvMjMgMTA6MTkg
UE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAxMywgMjAyMyBhdCAw
Mzo0OTozOVBNICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gPj4gQEAgLTI5OTIsNiArMjk4Nywx
NCBAQCBzdGF0aWMgc3NpemVfdCBpb21tdV9ncm91cF9zdG9yZV90eXBlKHN0cnVjdA0KPiBpb21t
dV9ncm91cCAqZ3JvdXAsDQo+ID4+ICAgCWVsc2UNCj4gPj4gICAJCXJldHVybiAtRUlOVkFMOw0K
PiA+Pg0KPiA+PiArCWlmIChyZXFfdHlwZSAhPSBJT01NVV9ET01BSU5fRE1BX0ZRIHx8DQo+ID4+
ICsJICAgIGdyb3VwLT5kZWZhdWx0X2RvbWFpbi0+dHlwZSAhPSBJT01NVV9ET01BSU5fRE1BKSB7
DQo+ID4+ICsJCXJldCA9IGlvbW11X2dyb3VwX2NsYWltX2RtYV9vd25lcihncm91cCwgKHZvaWQg
KilidWYpOw0KPiA+PiArCQlpZiAocmV0KQ0KPiA+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4gKwkJ
Z3JvdXBfb3duZXJfY2xhaW1lZCA9IHRydWU7DQo+ID4+ICsJfQ0KPiA+DQo+ID4gSSBkb24ndCBn
ZXQgaXQsIHRoaXMgc2hvdWxkIGJlIGRvbmUgdW5jb25kaXRpb25hbGx5LiBJZiB3ZSBjb3VsZG4n
dA0KPiA+IHRha2Ugb3duZXJzaGlwIHRoZW4gd2Ugc2ltcGx5IGNhbid0IHByb2dyZXNzLg0KPiAN
Cj4gVGhlIGV4aXN0aW5nIGNvZGUgYWxsb3dzIHRoZSB1c2VyIHRvIHN3aXRjaCB0aGUgZGVmYXVs
dCBkb21haW4gZnJvbQ0KPiBzdHJpY3QgdG8gbGF6eSBpbnZhbGlkYXRpb24gbW9kZS4gVGhlIGRl
ZmF1bHQgZG9tYWluIGlzIG5vdCBjaGFuZ2VkLA0KPiBoZW5jZSBpdCBzaG91bGQgYmUgc2VhbWxl
c3MgYW5kIHRyYW5zcGFyZW50IHRvIHRoZSBkZXZpY2UgZHJpdmVyLg0KDQpJcyB0aGVyZSByZWFs
IHVzYWdlIHJlbHlpbmcgb24gdGhpcyB0cmFuc2l0aW9uIGZvciBhIGJvdW5kIGRldmljZT8NCg0K
SW4gY29uY2VwdCBzdHJpY3QtPmxhenkgdHJhbnNpdGlvbiBpbXBsaWVzIHJlbGF4ZWQgRE1BIHNl
Y3VyaXR5LiBJdCdzIGhhcmQNCnRvIHRoaW5rIG9mIGEgbW90aXZhdGlvbiBvZiBkb2luZyBzbyB3
aGlsZSB0aGUgZGV2aWNlIG1pZ2h0IGJlIGRvaW5nDQppbi1mbHkgRE1Bcy4NCg0KUHJlc3VtYWJs
eSBzdWNoIHBlcmYvc2VjdXJpdHkgdHJhZGVvZmYgc2hvdWxkIGJlIHBsYW5uZWQgd2F5IGJlZm9y
ZQ0KYmluZGluZyBkZXZpY2UvZHJpdmVyIHRvZ2V0aGVyLg0KDQpidHcgaWYgc3RyaWN0LT5sYXp5
IGlzIGFsbG93ZWQgd2h5IGxhenktPnN0cmljdCBpcyBwcm9oaWJpdGVkPw0KDQo+IA0KPiA+IHdo
aWNoIGFsc28gbWVhbnMgdGhpcyBuZWVkcyB0byBiZQ0KPiA+IGFuIGV4dGVybmFsbHkgdmVyc2lv
biBvZiBpb21tdV9ncm91cF9jbGFpbV9kbWFfb3duZXIoKQ0KPiANCj4gU29ycnkhIFdoYXQgZG9l
cyAiYW4gZXh0ZXJuYWxseSB2ZXJzaW9uIG9mDQo+IGlvbW11X2dyb3VwX2NsYWltX2RtYV9vd25l
cigpIiBtZWFuPw0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHdlIHNob3VsZCBsaW1p
dCBpb21tdV9ncm91cF9jbGFpbV9kbWFfb3duZXIoKQ0KPiB1c2UgaW4gdGhlIGRyaXZlciBjb250
ZXh0LiBGb3IgdGhpcyBub24tZHJpdmVyIGNvbnRleHQsIHdlIHNob3VsZCBub3QNCj4gdXNlIGlv
bW11X2dyb3VwX2NsYWltX2RtYV9vd25lcigpIGRpcmVjdGx5LCBidXQgaG9sZCB0aGUgZ3JvdXAt
Pm11dGV4DQo+IGFuZCBjaGVjayB0aGUgZ3JvdXAtPm93bmVyX2NudCBkaXJlY3RseToNCj4gDQo+
ICAgICAgICAgIG11dGV4X2xvY2soJmdyb3VwLT5tdXRleCk7DQo+ICAgICAgICAgIGlmIChncm91
cC0+b3duZXJfY250KSB7DQo+ICAgICAgICAgICAgICAgICAgcmV0ID0gLUVQRVJNOw0KPiAgICAg
ICAgICAgICAgICAgIGdvdG8gdW5sb2NrX291dDsNCj4gICAgICAgICAgfQ0KPiANCj4gdGhlIGdy
b3VwLT5tdXRleCBzaG91bGQgYmUgaGVsZCB1bnRpbCBldmVyeXRoaW5nIGlzIGRvbmUuDQo+IA0K
DQpJIGd1ZXNzIHlvdSB0d28gbWVhbnQgdGhlIHNhbWUgdGhpbmcuDQoNCgltdXRleF9sb2NrKCZn
cm91cC0+bXV0ZXgpOw0KCWlvbW11X2dyb3VwX2NsYWltX2RtYV9vd25lcl91bmxvY2tlZCgpOw0K
CS8vYmxhaCBibGFoDQoJbXV0ZXhfdW5sb2NrKCZncm91cC0+bXV0ZXgpOw0K
