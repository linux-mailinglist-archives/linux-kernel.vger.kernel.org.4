Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9E5FB8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJKRNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:13:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14FBA924E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665508388; x=1697044388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFgZtQgI8BtNJz9OF1UFlJZ1iNFAfcn0WJAh5u/ofzg=;
  b=a4wNtH5M7xXzKMbD7AkkzRDI2tzKh+OY7FowTtfGaqUh5YRSw5rw9uQR
   kXiIN6pLG+bDWMR6V4OeZMkZ+sQ8vOBitJ0FdRYHfUn7oo6kwi7odVufd
   9c1tDJYd+jtYScmWT5HhKnCWPrWwIXuP7ZChcyqD13dL5ffK37h1XpUOg
   4T/47p+bZHhyHcXPLV4hqYuve5A7sAYdN68Q+FzQ+2p7JZAbNMAM49Rvf
   IhANOjCHxU7ktF57aeYXeSLCEChKdpMJnj2891b0TSB7YXYZmWY2xVXTR
   UiO0vivJEkXAq6tttMfSM7pWGMl8JXhsna2STBvN0HEc8uJM1tI4toRlt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="284299099"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="284299099"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 10:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="751813080"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="751813080"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2022 10:13:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:13:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:13:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 10:13:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 10:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSeNvo6lqhGGaFH/CDQ7Y3fVgiD4en66U4Px51vrUwOlyCpj7ul0l9aRT1zf9142w2bo5SyjkUib44/j917gghi2Gm5dmlhVSoQjyUCFMCBY2NMxI6duT5BVpx5bT3DSSa/cH+TupX8+fEmMq3AsnR1rP0RA5nTRVhtKKkdb1Rp8mnDHs9fOoR7EJHp+UDm3PYY0b96u6SaZZhQ7fVDAnKB48PPfYGmZKM+XaAzjjSzhmza8mdnkQh61si7LPNFgz5O+NEZ+gbznCbT4CTb04QgpW54AT5pKlisICQx0DceS5WmvHloLgqbZBKxIvaIm1Y7LjdOSQ41dnpBIXCga+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFgZtQgI8BtNJz9OF1UFlJZ1iNFAfcn0WJAh5u/ofzg=;
 b=IKxjn3p6xkPCKWMymda+UYUPX3csbc6qrAE6oSb+UvL1nN2HzW7FBuMkBOTVGVt3TjDJ7uzL1ig5ovhGqTV4h6lvBPFEvOrfgGhoPjK8V0bm1bieR1pU36/e6gwWs1r1fXdUShk3pNq1Xdifmfpqrt5LFoNmGcfLc4y1hp0vdRu6i4byO+3fzivCCN4/EospB6DoPPOSyh4Nh6EWZ2HZ87HnbeeNIaReFOyVi2Mns/v8uN+aTiKqJzcFq7vDLVHZQ/YrVrp/ZN2YcCQTXRIlz1uwlxHoSWmZF8bxLbRGPhqvG0PwhiuAixc5WT3VAz/misisZuGkjE424fpXwnLmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by SJ0PR11MB5940.namprd11.prod.outlook.com
 (2603:10b6:a03:42f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 17:12:41 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.019; Tue, 11 Oct
 2022 17:12:41 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v2 6/6] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v2 6/6] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHY3OEvG0hpU8EqvUiY+obVU0NNH64Ij7+AgADfhdA=
Date:   Tue, 11 Oct 2022 17:12:40 +0000
Message-ID: <BN6PR1101MB2161F4F40A3432B9CEF3932CA8239@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
 <20221010190159.11920-7-xin3.li@intel.com>
 <CAMzpN2hKr-=9sP=_VjGdsJDX5Pzdr9WAsSs77s_5yPJeqi728g@mail.gmail.com>
In-Reply-To: <CAMzpN2hKr-=9sP=_VjGdsJDX5Pzdr9WAsSs77s_5yPJeqi728g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: d538601b-8b3f-4bc5-0fe9-08daababcdfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQUutzOJvnlYSZjqnIOlBhCW8MUW0DGSDTBASf6WbUt470SRNBRKuXmIdaH+DjBUPR8Ny5QPELiqJYepqSGLfgAFAsDDeuxBCdNDzJRKSP3NYVfQ4Is4OzjNt5IC3k6Vjq+2rbP8Zz4yF0OjKoKDrWg0t73ZFtKJF6vWF6QJD1NYvDKAn6EAhLZMRAi3zQz9rDyQb55NweELCaQtjDufqrB6UqDlMPFFAlDW3eP8cTw0+kNVMQG7D7dCslBNdPPE0lRtndlWfWuokzrnYpavtFGTuF8LzBaGJIWhNoycjoan22MfnV/0zabzZ54FEl3UVXv/i+AGq/CmTeZavXMh4gWwBdOpKP2ztRYZWrQimRSagyigAm+lSa51ZXUzZSX1FXAZKFwhLky0b2/eGveQnS8cL/uoJySV8IQUw8t4EI7iXg2e784ldVSoN4QtCe3OxzoCB8vBMlW9wjK3JHQCZPf/iZZDgNgf9qXew7D2rPCHi3aWH749nrQfE0KH2mJGF3MxfCbBVxotc9PN+Z/Y08SIOQo2xriufRaaJdFBr4tEifgY0QntV9ZV+J5tCO0hRHLbEVN0QoVxOFOxphYsuWTSSrh/m9RFoAvkktHw5RnhItNE65K1fUI5bqyCLmy1iwKCFcJKbt0xyTTIvJZb/fO56nqtSo19AkBe4OYOqlDsw9alRrHUqZ06oosO9npk7qfhtksIlfzud6suWhljzsL25ZaWf/5KuZhbtI1JAhBW6GXv0w8VCehc8bBMhLJcEd1vBsVD0u4OnOYKgo/yPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(33656002)(55016003)(41300700001)(6506007)(7696005)(9686003)(71200400001)(26005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(8676002)(4326008)(82960400001)(122000001)(38100700002)(38070700005)(86362001)(52536014)(186003)(8936002)(5660300002)(4744005)(54906003)(6916009)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkwvbC9IaVZrSU05T2Fld2hra3JERzR2Snc3WlBweHh2S0pHRWVTcStROHlH?=
 =?utf-8?B?L2ppQUU1dWg0TnQvUjFjVTFSUkM0WTEvOFNacWQrbFdvMVUwQjcxQ3dQZFND?=
 =?utf-8?B?NXY5Q2F4cW1xalVnSkkwOGE2cDhlTFZUKzI4eFFJa3hzNnpWdnBXQW5FcmJL?=
 =?utf-8?B?WjkrcnZZQ21GMXBERnVpZXNtU3RYY29FRDRPWk0yT0d0MSsvUk05VW1UVDZo?=
 =?utf-8?B?cVRrRndISGJFRUYvOUF1T0thTEg2cFpjNmRJc3B6SVFNVUg2ejQzRE9sK1oz?=
 =?utf-8?B?YUJBd0l5UGdjLzlPV211R3hCZ2RBNW43eFlFTyt2SXhpV2VhTHhBdWg3b2py?=
 =?utf-8?B?YlFKUUg2c0x2c3I5K21OTm04L2dvY1pyU05UYnFJQ0VkbEt2QVZkRW0va0Qx?=
 =?utf-8?B?WEtUTUhxRGx4UmszOHpqY1RrcG9sUGZxOXZzcWpWaVhrVFZqa29JRXFrcVJG?=
 =?utf-8?B?NnNURXNQelZ3OW9kOXEvakNXU1lOa1VUbCtlUHRaTGx3eFJTVEdjZzJ4V0Zy?=
 =?utf-8?B?cXJKOGhNQm1zdVFMMWd0ZTJlbHJDWGwxLzJqUFFXcG0vN3UvRFAvSFY2TW5N?=
 =?utf-8?B?OFVjYzJiSkVHK1Iza1I2MWtBbUpnR3p0RTQzWkMrb01JSWFXYUsxbWNpVzl1?=
 =?utf-8?B?SDVpaDhHdVRpZGQ5akpYb0ErSC9iMXpYY1RTRXJ3OHlCdEpTbWVqRmZzZkVw?=
 =?utf-8?B?UHBGaHN1WDJSMDVURy9TaEM0VnN6SG1vNnlJMEx0dnBmMitKeHoybHlmV0lH?=
 =?utf-8?B?YlVPL3NBbzJVV2sycmVjRi9sYXl5WklLVXRZd0pjREVSdXcvYUhQNlBZNG5n?=
 =?utf-8?B?N2tIb2U2cTFIRmxNL0tZeVJhNHBlWDlzRTc2VnJ1YWRuZ2J4U0NqQlVkMnV2?=
 =?utf-8?B?ZFBmSGIrUFRRYytEUUVkR3VrSWdaSDNnNFYrRkhEVFVZeUFkVy80aGk2V3Rm?=
 =?utf-8?B?czhmdDVRckdlMEoxTnVLOGpQSjhpcTdtdGY4WG16dUxOZGg2WnNCTEMvejBr?=
 =?utf-8?B?bWJJYUhhMW9DRlhOSjJNTUJsRU9keDJ1NTc3VkJ2TXYxb01zOFQ4UFllb1dU?=
 =?utf-8?B?OEtLWHNhUnk0R01mR0FVSktGbXl5RmJrNmRvSWd1U0o4WEYxbzl1ZVB4NXZt?=
 =?utf-8?B?UnRsUkJxdzVEWFQ4OW9rU1hpQVJqS1lhL1NJTll5Q2cxV3VNNzZFRXNCUlVG?=
 =?utf-8?B?R3pZbGRmTTJ6WUdNOHJPT0NuK3BYVW9lM0dmd1JUNlBvaUJTcG1UaFArRXhj?=
 =?utf-8?B?dmY4bFYxNEdEOXUzWVppTnhNOGNqNVlDQ2RmVXpTYmw0RFhEbTk0Ykh2ODBn?=
 =?utf-8?B?TE9lV0pLYVJMSkNvdWxDT1B6eGhyc3FjOWNxcUZjVURhVVpwWWZ6Wml6emlr?=
 =?utf-8?B?MHg5OG03Q0Y2VlZuaEJmUFR0ZllDMHFxWWRpaFo4bXp0eDFrV1BQK213dW0r?=
 =?utf-8?B?RytGbmJQZ01IcWtkUkVCY1o1R0hicW9nZ2t3SitUMnRrNjdNK2RJdEsreVFJ?=
 =?utf-8?B?TjlST3lYMmw2U0VVRVBzTEE1OC9PaWx1N2hMYUh5dHZkZ1VDaE1ibUZzN1hh?=
 =?utf-8?B?MDUwSXhtaU9MMlQxcTdxeGVJbHdGcDlXWk1ERCtqOG9NaWs1UlNGTXVOblZV?=
 =?utf-8?B?bURSSm9HSUhZWDJ6SXQ4T0lkTUtoaXk2VHJrYS85cjkrQis3czBjdFdjNmFk?=
 =?utf-8?B?ZjVJUFg0bzFvck1acmNYcUJ3enNDaVoreUVNeHV5NGZQSjhleklmc0JidVJ3?=
 =?utf-8?B?QnNualpoVitsblRxYTBqZE5xMVhiaFU4dmYvek9TTVRpc2ZjYkRGa3VWbXl3?=
 =?utf-8?B?WVRrTjBtUWh2Q0dqd1FrZlNYa3lZbTl3b3VpdHg4YStuTC9hOFRwYzB5bmJu?=
 =?utf-8?B?dytZeTlVcGdBSzdPN1czTnVNMzdIbnJCTTh0eUhKajZ5Y2c1RHN1djRYUTAw?=
 =?utf-8?B?Q2pnd0c2UnZyOG5VWGUreFAySWFRYkViNE1tWk1zdU1VTEs1anhrZ1FuV3l3?=
 =?utf-8?B?UW91cFFzVEl4UFJ1RmY1alR1Qk93OEdDRHg2OGpJcTFWbjhtalVENW1tVGMw?=
 =?utf-8?B?SWVucGtKbWJvM0xiL3RmV0VuNmRyNkxUTEF1blliVStnTWRrTmFNZHBkU0N2?=
 =?utf-8?Q?I6Ro=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d538601b-8b3f-4bc5-0fe9-08daababcdfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 17:12:40.9392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwsI/9WKCy1AdoJyeEl7UpolP7EB7DjMRnY/GAvDG4PNLTeKPFrFzETRJ7irJNTmbwUl2J3LrLH7EJgLuycWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgICAgICAgYXNtX2lubGluZSB2b2xhdGlsZSgiMTpcbiINCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQUxURVJOQVRJVkUoImNhbGwgYXNtX2xvYWRfZ3NfaW5kZXhcbiIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9BU01fQllURVMoMHgz
ZSkgTEtHU19ESSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
WDg2X0ZFQVRVUkVfTEtHUykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgX0FTTV9F
WFRBQkxFX1RZUEVfUkVHKDFiLCAxYiwgRVhfVFlQRV9aRVJPX1JFRywNCj4gJWtbc2VsXSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBBU01fQ0FMTF9DT05TVFJBSU5UDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIDogW3NlbF0gIkQiIChzZWwpDQo+IA0KPiBESSBu
ZWVkcyB0byBiZSBtYXJrZWQgYXMgaW5wdXQgYW5kIG91dHB1dCAoK0QpLCBzaW5jZSB0aGUgZXhj
ZXB0aW9uIGhhbmRsZXINCj4gbW9kaWZpZXMgaXQuDQoNCkdvb2QgY2F0Y2gsIEkgYWNjaWRlbnRs
eSByZW1vdmVkIGl0IGZyb20gdGhlIGZpcnN0IHZlcnNpb24sIHdpbGwgYWRkIGl0IGJhY2suDQpY
aW4NCg==
