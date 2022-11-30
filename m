Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2F63DC71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiK3Rtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiK3RtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:49:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580F7B4CD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669830519; x=1701366519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sak4iOOMc0uvSe81GT0dZs7CDZLAkR0nE6VO3u1QY/s=;
  b=IF4ktn+45zmP7gtnaJIaOb1N6tRJKC2VzVpXo7lofUBWyF8uew7YJtNw
   7tShqudAnYNLnWaWBG+hWuVJvcPDLkI2e3G1IDx4ikMnbKRzafmOukLGs
   cXQ2/gSCV7GYkGMpdHSqecEw1VQNe0AqCTUDB5iHfyYg0d3TgoAByz4yY
   LE2v8Pm5YZ7SE9gZmXfc+Gwp7Bepo6fyI7Izb6sHvk4KDBA6x7krnY/pW
   p1Mls5C8A7W5hhET5oCXkPakK13iN45RFSrpm2ZRRDPSKXJFE8LoGLMef
   GO1MpcQpRjO8mJep9ws3Z+H3IRXAeajX+11Owpj3PIL7MB0mkdyaJhnd5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342390619"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342390619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 09:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644301213"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644301213"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 09:48:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 09:48:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 09:48:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 09:48:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 09:48:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2DR6CE+vyXQE2Wm3Q6W3/GbaJAO76IAQBdbxt76H5t4cQP0jyTBNLRhbnCFD4rMWfsdBWt4yK4P1ghNZBz8C8lVhMvzfyg4U1fc12NiNHKYMf7hZN5wrDKfxZyd/KnOpH1x+rTZ2JiiUKLB+YqWO6VLNu1JhysQMt33EoS+YqSprXCz79qS1AU4zdQQ09Z/4uynqp+qnoEfnBJiMUUyCWu3ZkCfpEL7JKmPpuVCfOcns0T1wyyFLrK6v95yL0IAIHX9URUQkyDvZgkEHLXvXXwQtRbg6EIvVJF6nLASG/2YEX2G69yAKJUKwtTQPmhda/SFMQqW3+2BLDSB2KP3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sak4iOOMc0uvSe81GT0dZs7CDZLAkR0nE6VO3u1QY/s=;
 b=TZXukMlGNuYmVqVjfyrlntVelUAEKNPigM60Py3+qTcto+g765DvAFYSiQgBWJ9pMh5UpKeajBjiO0Su4vSm9buxJg2MkXFt88daeLSlLJ+W59/E6Cpc7uMe3/0TtBgjWo464lsVSVNkyWBVduBxHOpHeQ98qZQ9EfD5fPzYGEugJKs2Ag5K+z1tk/AaUkb9P77jnI69IsUvhw0/cABaU9pB9X4+a1XDh/j1Zmx0ILXKazTkgMFPAJ56beCTVFVDvi3zmsRCzWb2deD1/UHMTCDAcrlFz6CkslRhMm2dFkW68XT0MuP4dbwTQmfzM7GKyAiwDgufS2oerLsQIdbagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 17:48:35 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 17:48:35 +0000
From:   "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "airlied@redhat.com" <airlied@redhat.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v3 0/2] mei: add timeout to send
Thread-Topic: [Intel-gfx] [PATCH v3 0/2] mei: add timeout to send
Thread-Index: AQHY+bm38Zq64vOhrESbDb/KYLi+IK5XmlcAgAA4oYCAAAGDAA==
Date:   Wed, 30 Nov 2022 17:48:35 +0000
Message-ID: <af23852b836c9740e01ad88d0d7ebc54ea71f57c.camel@intel.com>
References: <20221116124735.2493847-1-alexander.usyskin@intel.com>
         <Y4dmrP9RzXi7wrwJ@intel.com> <Y4eWLWhCy2NLbENs@kroah.com>
In-Reply-To: <Y4eWLWhCy2NLbENs@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6059:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 8741c04c-5bd2-4cf8-cced-08dad2fb1b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZq9i0kRbamsHD+2Xfp6CDToXslq83MA3HM7rykQlCz3MVYl0pRIrddeknkPLlYeNfFQmyvdyuIZIwYE6s0TgZ2gLGW2AjhtaifvHKXid/c4pBPBDV+ENtURmfTuE57xDE+Jdi6S3oe0UhDRlL6Yl8F+Utn6GraQuOOjx95TOULMFAZ48iR/zOXv1SOU1WqYG5X+YzTAcDCRAKXVyYfDsmScGTO2FOJ/0h9FDP6IFQ2kmXLUweBNbxh8RHcfrUPqIaCCWHe44s2fjAfXRZ0xNwGpt6RKvJl9F0UKKNZ3wvbIM9LobsFi7DwFBu27hpiyANIphyN825a86xLPvVvtcJPFLRLv2K4alf7rS4EXfy1QVfPWz5I+mt757IcyVlOzP0UzO37AYEe2kkEgawlw//jkJS1y/Y4VjAr4aG/3y7y6t7eUz0Gpw4hDDPyCdpKpdeqHXF+bfnCeF+my3IXnrZPKV3MQv4trqHLGetFROiz2w43+CRhBsxzKJDKXQKVHp3/HeSDsi4sGvHsbySfzNjCs2LX9SNGOhxsdGor1mS+ZNFEY3B48+lfheDO/3OzxWCznJuw4jl+c91gXBrX+ghc51lfkzysWIQA+X6g7cVpSvoghPMade7Kw1KaOZVze8PbdvmwkfSYdK8WtJVRHxdLVmrlBSim7lFtDbYAXnjqc3rnhkC5AWuqr8xS3m0Bh95gqiq7pFVjhjbEECZy09w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(36756003)(8936002)(38070700005)(38100700002)(82960400001)(4001150100001)(2906002)(5660300002)(86362001)(66476007)(83380400001)(122000001)(54906003)(66556008)(478600001)(4326008)(6486002)(66446008)(6916009)(76116006)(91956017)(71200400001)(64756008)(186003)(6512007)(316002)(8676002)(66946007)(41300700001)(2616005)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFwbGtPeGZPRjR1L29PS0tqUjlHTGdIMjRPMlFXVFhuSmFQMXZpdTZ1NWYz?=
 =?utf-8?B?aGRYS094UkY5dCtjR2p3SWdicEx6bHVOQnpEUmhNM1BaVk9kbGFCOGFJdERu?=
 =?utf-8?B?bjBud01HZTBJbG50bkIxbDZUQmxUUXY1Qkt4bklGWXZqbmNxUWtXcHNDbVlT?=
 =?utf-8?B?TkxEa2tJZVJhL1pCSXJhOFRzUzQ0ejhjZnN3R0YzaEtOMEJhKzY0ZjhNcmZT?=
 =?utf-8?B?NkhNb2RBN0FhMDM2SmxXL0hlNlpNbmFFOGRhZFFtUzBHalhUb1JDQUJMSVVQ?=
 =?utf-8?B?T0ZxaU03d3BsSEcwVzVoanpmYk1XM0x5NnhlY0hxNUFZT1QrbzAwVVE2bGlE?=
 =?utf-8?B?dDJ0WGtXM29tSTFpT2EvdVgwdjJjemM3Z0FTY3IrMW1pREUwVENvSUYyV0JH?=
 =?utf-8?B?UUZTRTU3cE1kUjZDWFpMd0oxQjFGWWdqWm9XOVZoQmRFakRSd3hzRHBqYmJ0?=
 =?utf-8?B?NHpuaW9xMlBycXVGRVdkYndDWjlMVHhCdVNFZjVWekRJbWJxSHUwS3IxZXZm?=
 =?utf-8?B?RWxFUFU4VGdlL3p4aE1ubXl6OHRlV1ZGa1dJZGRRckRFa1VXeldXTlVBZEV0?=
 =?utf-8?B?NlpXaWJHZE5zbDQ3SEtzZkt6R1hqdGxLeDBJU2lrN09wYjByUlora2VEUTRN?=
 =?utf-8?B?b3oxNkRRNURadzMzTFJGeGVhK0xTUEtzajVXUVJlM3FIRzY3WStmYVVQbE44?=
 =?utf-8?B?RmZsYmlBdzZoZGtablRsamZSOFlSUXBzcEhQT0hSeDcrRUdQZjQyMjRFbFdn?=
 =?utf-8?B?MmJ6UGNPQmJ0LzZHZ3I0d2xBbFBIaTFPRjFiOE5PNDYzalYyQUdDSVBxM1NL?=
 =?utf-8?B?K0JQTzdSaUhzWVVhcU4xYkJSMHEya2QvUE4yWFZJYXJJM3krRkFNRzl1QzAz?=
 =?utf-8?B?YlQ3TE1mSTBoZFRyMExuaHMzZ2FrZXdJV1UrRUVFVFpPWndDVURYQmRHR2NP?=
 =?utf-8?B?SVJBajk4ZEJScEdrOGJmNU50d3AxT0dLVlhsc0RudEg4ZUUreG1nVy9zYlVM?=
 =?utf-8?B?dStWNkdoMm5lKzlvUzNaTmRab3VNRUE4Wk5HR0V1T3BraVZSaEIwMDJmeGw5?=
 =?utf-8?B?Ym5tWDcrZ1d2c1IrRWpvcVRJRUxmSjZmVDcxRjBVdkczMzhOZmkwODlTWUV5?=
 =?utf-8?B?M091dUhyTjBldGw0bDkyZndpeGdJSWM4WVdhYUNWaFB0QzFEcEtlY1JST0FC?=
 =?utf-8?B?S0RuWkpUYkQ5N2RIZ1grZ2kzNElSQ2hrMW9rQ3BhQmJQRXlLdjFBQ0JEOHBT?=
 =?utf-8?B?Nm9vRklqZHJFRXlMTEFwNi92RVZxOCthQTB3eXZtc2FmSVNpOGxSY2dWQ0Uw?=
 =?utf-8?B?NU40b0o4dm55eWtlQ2lIT2tzTUFhMzBxcWxIY0pvS0tNRER3MmNnV2E4VW1F?=
 =?utf-8?B?MXh2cjBDcnZSWEMzeERVVXM0QlJMcVZjLytTcXJYNllFbHRZeEU5Mk9Ha3ZK?=
 =?utf-8?B?M1ZMM3Fpc1pNQmtPYWJWbTAwdHBiY0JQNXNjR2VFd29rUFIzcFVTZ0dxMERN?=
 =?utf-8?B?eFdnZ2xBN3B4YVF0OXRuMGFady8xQlNONUpmTDhOU2Q2dFJTYmF5R1lLUGY2?=
 =?utf-8?B?bW5qNHIyeWZ6QzlVY20rK2tUMmdHZ0J6SStsOGVucnMraElJSnNVSDR5NWEz?=
 =?utf-8?B?bG5PSGxlWE9mS2xJVkZSMHZTZ2RMaFNxWnRrb1loYnFid0dXaHlwM2Q1b1gy?=
 =?utf-8?B?ZC9lQWd0YURSSU9qTmZ1UGJ6ZTRxWENOeVJwWTJQTFVzVVg4OFNMM1ZZZE9S?=
 =?utf-8?B?TUdTNXdrVElyM2xqc3VnVmZFU1IyTTZBUjZvUHpxdjdwbE9YbzYzUWMrV0hG?=
 =?utf-8?B?UHg4cmdGU1ZlbUR2OUhSOHQxRUNZY0tEajluUW5RaEVwU2NRdEQxdnRxNlNp?=
 =?utf-8?B?akhFR0RrSDF1SFpQTDFJVGdLaUxXU3lqeHFUd3pzTVRSaCtTTGlacHB0WHhs?=
 =?utf-8?B?TWIyUUhvbXJZZHNjM1lFMWlmZWFEazVEUE5JNlBXbmRsd1JnS1E5YmlZNFB2?=
 =?utf-8?B?S0RIbHFnZExITlF3U0prVGNrLytMWUNGYUZjazZ1L0VNN0F0Z01iazJENFo3?=
 =?utf-8?B?VlVZMFQ0bG94Rk4rcWVKV3U5TkRGYll3MmJxZ1dydmdXM0ljTmtLVlM4SGdp?=
 =?utf-8?B?MFptcWxveGpXcTI2emtIVElsanVTZEVsVlVXdlBHUEhFcWx3c3NNcG42Yk9a?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DADDA0BA5EB024292145C605454AA57@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8741c04c-5bd2-4cf8-cced-08dad2fb1b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 17:48:35.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzLSm26DGjISUAaIqYJD7gP+Dw5vVA8ZY8RKIuRfkDCYuwS5X29753SB1YUQqBsYP8/lfExtm2juTIZcRhcq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTMwIGF0IDE4OjQzICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTm92IDMwLCAyMDIyIGF0IDA5OjIwOjI4QU0gLTA1MDAsIFJvZHJpZ28g
Vml2aSB3cm90ZToNCj4gPiBPbiBXZWQsIE5vdiAxNiwgMjAyMiBhdCAwMjo0NzozM1BNICswMjAw
LCBBbGV4YW5kZXIgVXN5c2tpbiB3cm90ZToNCj4gPiA+IFdoZW4gZHJpdmVyIHdha2VzIHVwIHRo
ZSBmaXJtd2FyZSBmcm9tIHRoZSBsb3cgcG93ZXIgc3RhdGUsDQo+ID4gPiBpdCBpcyBzZW5kaW5n
IGEgbWVtb3J5IHJlYWR5IG1lc3NhZ2UuDQo+ID4gPiBUaGUgc2VuZCBpcyBkb25lIHZpYSBzeW5j
aHJvbm91cy9ibG9ja2luZyBmdW5jdGlvbiB0byBlbnN1cmUNCj4gPiA+IHRoYXQgZmlybXdhcmUg
aXMgaW4gcmVhZHkgc3RhdGUuIEhvd2V2ZXIsIGluIGNhc2Ugb2YgZmlybXdhcmUNCj4gPiA+IHVu
ZGVyZ29pbmcgcmVzZXQgc2VuZCBtaWdodCBiZSBibG9jayBmb3JldmVyLg0KPiA+ID4gVG8gYWRk
cmVzcyB0aGlzIGlzc3VlIGEgdGltZW91dCBpcyBhZGRlZCB0byBibG9ja2luZw0KPiA+ID4gd3Jp
dGUgY29tbWFuZCBvbiB0aGUgaW50ZXJuYWwgYnVzLg0KPiA+ID4gDQo+ID4gPiBJbnRyb2R1Y2Ug
dGhlIF9fbWVpX2NsX3NlbmRfdGltZW91dCBmdW5jdGlvbiB0byB1c2UgaW5zdGVhZCBvZg0KPiA+
ID4gX19tZWlfY2xfc2VuZCBpbiBjYXNlcyB3aGVyZSB0aW1lb3V0IGlzIHJlcXVpcmVkLg0KPiA+
ID4gVGhlIG1laV9jbF93cml0ZSBoYXMgb25seSB0d28gY2FsbGVycyBhbmQgdGhlcmUgaXMgbm8g
bmVlZCB0bw0KPiA+ID4gc3BsaXQNCj4gPiA+IGl0IGludG8gdHdvIGZ1bmN0aW9ucy4NCj4gPiA+
IA0KPiA+ID4gVjI6IGFkZHJlc3MgcmV2aWV3IGNvbW1lbnRzOg0KPiA+ID4gwqAtIHNwbGl0IF9f
bWVpX2NsX3NlbmQgYW5kIF9fbWVpX2NsX3NlbmRfdGltZW91dA0KPiA+ID4gwqAtIGFkZCB1bml0
cyB0byB0aW1lb3V0IEtEb2MNCj4gPiA+IMKgLSB1c2UgTUFYX1NDSEVEVUxFX1RJTUVPVVQgdG8g
c3F1YXNoIHdhaXQgdG8gb25lIG1hY3JvDQo+ID4gPiANCj4gPiA+IFYzOiAtIHNwbGl0IHRoZSBz
dGF0ZSBmaXggaW50byBzZXBhcmF0ZSBwYXRjaA0KPiA+ID4gwqDCoMKgIC0gZG9jdW1lbnQgZGVm
aW5lIHVuaXQNCj4gPiA+IMKgwqDCoCAtIGV4cGFuZCB0aW1lb3V0IEtEb2MNCj4gPiANCj4gPiBU
aGVzZSAyIHBhdGNoZXMgbG9va3MgZ29vZCB0byBtZSBub3cuDQo+ID4gDQo+ID4gR3JlZywgd2hl
bmV2ZXIgeW91IHJldmlldyBpdCwgcGxlYXNlIGxldCBtZSBrbm93IGlmIGl0IGlzDQo+ID4gb2th
eSB0byBtZSB0byBwdXNoIHRoZXNlIHRocm91Z2ggdGhlIGRybS1maXhlcywgb3IgaWYgeW91DQo+
ID4gcHJlZmVyIHRoZXNlIHRvIHRoZSBtZWkgYnJhbmNoZXMuDQo+IA0KPiBUaGVzZSBoYXZlIGJl
ZW4gaW4gbXkgdHJlZSBmb3Igb3ZlciBhIHdlZWsgbm93LCBzb3JyeS7CoCBObyBvbmUgdG9sZA0K
PiBtZQ0KPiBub3QgdG8gdGFrZSB0aGVtLi4uDQo+IA0KPiB7c2lnaH0NCg0Kbm8gd29ycmllcyBh
dCBhbGwuIFRoZSBpbXBvcnRhbnQgdGhpbmcgaXMgdGhhdCB0aGUgdXNlcnMgd2lsbCBnZXQgdGhl
DQpmaXguDQpXZSBjYW4ga2VlcCB0aGVtIGluIG91ciB0b3BpYy9jb3JlLWZvci1DSSB3aGlsZSBv
dXIgYnJhbmNoZXMgYXJlIG91dC0NCm9mLXN5bmMuDQoNClRoYW5rcyBhIGxvdCwNClJvZHJpZ28u
DQoNCj4gDQo+IGdyZWcgay1oDQoNCg==
