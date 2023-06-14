Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6998C7305D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjFNRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFNRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:16:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A2BA;
        Wed, 14 Jun 2023 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686763018; x=1718299018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bElFauscUj/jce6ZasHhQ/GmQ1XRDFkaQkLKUKcjtbo=;
  b=PBXCM5RlcGg0ta3+/7MbCKwJfQe3oK5iV3dDrdyVpCSSCcB3dXg1ZSBj
   7fJMrOEIj7URjS1i+ZNMFXw0C9ATrpZ+wC08rGFg6SkxVu2aH7PY94mZH
   YtgLofEVACjquKklMWtgWRvpYbapyCQybvr78uVD7yntOOYnJChnzWitx
   fxn6Nzrcd6CV3e2GCoh7mjspwk55TDLhA9555Lcji+XqM9MHxhy3eO5Eg
   8qfrFyUPH4PykJ76DXopjQngwm/lt+b00fE+J4k1noJLPorxZwEIuAQC0
   fy6RNAZY4lEqLuRyc0xm43oCf39E8ptWFR78KoUqFCN7YIsht4E+rYhja
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361156662"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361156662"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715280368"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715280368"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 10:15:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:15:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:15:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 10:15:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 10:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znd+OCZRvH9IKDZptpJaO85TqN5yWZq+WU/TtENvs8gzZy9fyww5PkQuFiucTI8ayL1gny0yq4OhxldvbpUFLGwAchhHKUFyXUF7YGvAkP40QjDualjXuKmdfedZcDNL+rYsVifEAKx5ODCZncpMa65jKQSwkQgeOhS06sb95MbJlO3ctk459ahxTz5pRoRNsdqGcjbJCa+3Mc2ZulCV2wk661Y/tBm7nhlOX8l7z4sXY1RZS06hVwdPaeKv+u55VLMnX4L0pukqq7y1d7z+hqh7yd6+3L6/7l2/6Sx/a1jk42G5MTSxjjR3sHw9m/QuICELZwg+/3Y+LjS64NWu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bElFauscUj/jce6ZasHhQ/GmQ1XRDFkaQkLKUKcjtbo=;
 b=MB5xp67KGz7KekCRrM+e5vz2hFlCH4VV7yju9T2nPLyTNjzvu9tMDLvVyXJfkB3DIUNFQdC3TzTeFW+okuPtKfMZlaKxbBDAfqSJjcj4Py4WsOtGVH/Af6qsd3a/2RVYnyw85LwuhUzPCRjnqqW6BFIIJhhH67Jjfir3lpvQb0Q2qOKNBrHuRlmScqTy+17RwtjjIHMzGhiY/cCbfJ76C5QzmeYP06bPeSJX/jjDZw6WUmW2svEDKJoBALMJomkQ4Pnkopn/XDnV0ixC5hZ+mmwwkhWcLqTinfxLneACJEUgjpsePjmyo9XjvO6BrNW0h6jYB8eqU1qaTm6popLlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1SPRMB0002.namprd11.prod.outlook.com (2603:10b6:208:3d5::10)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 17:15:30 +0000
Received: from IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df]) by IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df%6]) with mapi id 15.20.6455.039; Wed, 14 Jun 2023
 17:15:30 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v3 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Topic: [PATCH v3 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Index: AQHZnPsEjyG+ZNTvPkCf1PRk1KqZia+KWwyAgAAynwA=
Date:   Wed, 14 Jun 2023 17:15:29 +0000
Message-ID: <26a13b81674655e7c2b5f7c53c98ba321acfc358.camel@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
         <20230602-vv-fw_update-v3-1-869f82069c95@intel.com>
         <20230614151417.00002f46@Huawei.com>
In-Reply-To: <20230614151417.00002f46@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.3 (3.48.3-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1SPRMB0002:EE_|DM4PR11MB8089:EE_
x-ms-office365-filtering-correlation-id: a4334409-f033-4675-5da5-08db6cfaf450
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFEHRMxY85p72YrTqWLT0U9EKtwiPYU8E84iL0L0ZdY/T5UbeXZyn7WR6RYdW2/Q3b2DcAFnEGUq0xaCFWIhwXvyq76zDqPjzA9aRB9SkqUBqnv7tI96De9yRRVii3rw93iXXmO+JqGNGuIhvqVfdjgNG5ECog9GO2+jWedJwk/YNnvr/PU0ap7gHikbaMo5tkTml0aNvv13tmZL8WSWWePUwxMlHIMFw48q8Xr3px4YdtK5InV6Vvj7Uj5L20kl91Qemt8anRTexOhiADql5x2esm/GVT7XWAaoSlwKJ+IWtg20jZ9G6OBCGCrCKgIEvchLSQNvGWl/dSxoR+nbEl/VIFIql8vw62pGCYJSeyKty3mZU0yifMAItbTHi5hoY/8lVgPlNxjK8/OYd3RR8zDVbPrVmyLlCiqqvR1n5EJraTg+ofTWbM9EG/LMHYt1RSJZQCFTsN5qSP9IlUMDEHE5n15SbdcjgVrhSmREyYYKtJ3lNgb5vmM+evli9r8xl46+Y7HAegO6occReSduSArW3Ypl4tntlcEjaF/2ljd+R2XK0Xg6t2t7km3016eIRrxFLwJyQg2aNcgAz/fCGgCv+UdQOI+SEkt92mwSSCR5XS2uoq+mjp/MsyjPJ2Wi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1SPRMB0002.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(71200400001)(5660300002)(8936002)(8676002)(86362001)(66446008)(66476007)(316002)(6512007)(26005)(15650500001)(2906002)(41300700001)(186003)(54906003)(38070700005)(36756003)(82960400001)(122000001)(4326008)(66946007)(91956017)(38100700002)(6506007)(66556008)(64756008)(76116006)(6486002)(2616005)(6916009)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1h1bDlHREttVGdnbWh1V0dMSDVmalBwa0RJYzljSUZ6VTJ1aWtyTTZ2UXRB?=
 =?utf-8?B?Q21ZZlNYaTduTElZRVhXV3FTcDJQeHV2aTJweG1KRWhNTWFyK29aaEZScnky?=
 =?utf-8?B?RnJ0L2RuNmhLZmNMLzlQK0QwRkVNWmNSS1pOTHFGTmF3aVNjSnc0dnhQRG9J?=
 =?utf-8?B?a1VGSWw5QVZxN04rampGSlF4emNTZHZta1JjWlNabkpqYzhuUXVkMHE2cmZN?=
 =?utf-8?B?cVF6WDFGems4ZFRCMFJETHNXSlpQRTBJVmRLSDlEVGlTQzg3a2ZlMnhHL3lW?=
 =?utf-8?B?UWJhQXFQOGlGVE1TU3RISHVnczd3MTAwNUFlbkloSkNRdk9TZTRBNWM0U0pF?=
 =?utf-8?B?aTM2Vm9jUm56UENnK2dHb3duMnRrdFRTWjIvWWxEMmMvOVVLWDJKeE5pNHQy?=
 =?utf-8?B?b1hCbzNMWll2em5CZmFUVHFLREJzQTFYZTUrQ3pBeWtNeXJHRTU3MTNUMSs1?=
 =?utf-8?B?anFYSnB6SG82V0RiYnhMOTBTZk5BemI2SXg2Q3dFenUvM1J5Q21SNXNHWFpC?=
 =?utf-8?B?RE5uZVVzNnNoRHNtbFBYaHhWWERybVVXMHJJd3hNRDg4cTVDRWtiYXhLWEo1?=
 =?utf-8?B?TXQ2N0p4R3p6cGc4NkhWeU9VU2l0d0JKcXJaUE5UVXdhNTVMWUdGaGpHQW9w?=
 =?utf-8?B?Y3NrVUMwd25EOWFjVXZRVlhXRHlNeXI2bXZyd2VieTVxU05FeXFaNjBtTU5L?=
 =?utf-8?B?d2dVdzJIbEtZbVM2UXU2OXh2NExYenZDSmpiMVA2TlpKNVRKaUJaZ0V0YXAv?=
 =?utf-8?B?V01pbnZrNXhNS21TTklLanJxeWVhcGZCcHIwV2pQZ0Fhc0pQckRWQm13d3Ar?=
 =?utf-8?B?bjhsdXNEQU9xeFZKTHU4amRsQUJac2lHa0pwSjhsajZqalJ1M2hndzJCUGx3?=
 =?utf-8?B?SmU1OVJ2a09laFByTGZWZVp5WmduTmhha1I3dU9vQ1Q3UTFIRmpXcWJESyt5?=
 =?utf-8?B?ZjZqbjAwMGQvenlxNXUwYWhHU2xjUXcwaitRdm5uRGoxYnFwaHh3cmd2eEZ5?=
 =?utf-8?B?VW5FRldzNEI1NkwxaVZGbldZdU1HU0FRSEpVcHk1emtlREZjaDVaR1dwNzBW?=
 =?utf-8?B?M1pDejRBSStYelVDaEh3SUx4VXNFeXYyVW53c1hsZFdEK1hncmc4RW9CYmhN?=
 =?utf-8?B?czBVVS83QUEwKzA2YlFRempsZ1BGQ2I1ZjBCNmlBV2pOdndHZHNGM0V2Sk5B?=
 =?utf-8?B?R3Jlem03RW56OCtCUmsxL0d3SFphRDRSVUhqTENLS2t5ZUpsTHNXaHpkaGVp?=
 =?utf-8?B?NUpqMU02ZHhSRW9xcnhTVml0UlhldUU1bzJoU2xscUdDd0FpY2xndG9HcC9D?=
 =?utf-8?B?WWp2bU9aNkl2S0hzYnlsOENJL3lUekN6cUsvUjNYQU13Sld4SFUrMC9rclc4?=
 =?utf-8?B?THZsOUhtZFZncjd0N3RNMnRzQk9KdzJwVE9zUU9wNC9TUW9kQ0gzd1k0N2lj?=
 =?utf-8?B?NXZ6WGkwRjBVWS9CaGdkTEpGbUZ4QlNuemJyME5FYnRhYW9FRFA5Rnc0OWFm?=
 =?utf-8?B?bXp2di9aV25hcXZGSlZtUUxoU3YzcW9lTVdyTFlSYlFNR2Z3bnk4NFRONjhx?=
 =?utf-8?B?RTJrTk5XNU5pcmRaNkVONndmZW9EaFFudTRpaUU3cGxVS3Q4YkFuQzNEdmhZ?=
 =?utf-8?B?TW5FbnhJUW1GdnVUZDJFZWZ0SFE3Q1RLc0dJYzJBbmZaQjRYaHNXRjVFd0VS?=
 =?utf-8?B?TTN4c25aYS91S0FnbW5mNEVvL2RKaGNvYW1objNwdkp4TC9IVGhHNnExYXFS?=
 =?utf-8?B?UUxVdHpDalQ3YWp3dHBkYzhxdlYxRW1EcmM0NDg5SzBOdlVSa09MQ25IZkNR?=
 =?utf-8?B?WWVwVzJ4ZHJRd1dhVTVxclJJN2YrTjZ0TVhseWZyQ01yd2R5UjEyNnU0c1hG?=
 =?utf-8?B?anJnU0lMMVlEZytXMng4NExLWS9lTWdkSUlPV1BVa08ySVRxc29lRVNiL0t1?=
 =?utf-8?B?RHYvMmtmVHNraFc3cVlaNjdqQzdWeVlkTTdZZ0JvemJSTnRLWmdYYlNPQ1Nn?=
 =?utf-8?B?SnpubkU1WnBXU05wVzBFYmsvbFkyUW8xeXMrQUd0ZlBEbHJWMUI4NUJZaW8y?=
 =?utf-8?B?QzhwS3JVMU42THFTZmd4a1lRL05XWmdrSnowNmZkSkxUZlJuM2V1VnY2ZUww?=
 =?utf-8?B?TVVZTTdUZFk5V2tkTEFybTFHdklSQTRPbVBnbGxaTWdoazdoenUzY2NpclFp?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29E3F770A1EA0A4292B6C7C05D0F74AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1SPRMB0002.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4334409-f033-4675-5da5-08db6cfaf450
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 17:15:29.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3YoKZ7To0nyVYGlxUbwBkJVT2O2DcTuaD6BJXUL3VzekL3KlsEThMwm2x5DzyYD0vVyB7uR8f5j2NZPll4+KpINmDGP1TRKt+uD5uHTM1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDE1OjE0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDEyIEp1biAyMDIzIDAwOjU1OjU2IC0wNjAwDQo+IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIHN5c2ZzIGJhc2Vk
IGZpcm13YXJlIGxvYWRlciBtZWNoYW5pc20gd2FzIGNyZWF0ZWQgdG8gZWFzaWx5IGFsbG93DQo+
ID4gdXNlcnNwYWNlIHRvIHVwbG9hZCBmaXJtd2FyZSBpbWFnZXMgdG8gRlBHQSBjYXJkcy4gVGhp
cyBhbHNvIGhhcHBlbnMgdG8NCj4gPiBiZSBwcmV0dHkgc3VpdGFibGUgdG8gY3JlYXRlIGEgdXNl
ci1pbml0aWF0ZWQgYnV0IGtlcm5lbC1jb250cm9sbGVkDQo+ID4gZmlybXdhcmUgdXBkYXRlIG1l
Y2hhbmlzbSBmb3IgQ1hMIGRldmljZXMsIHVzaW5nIHRoZSBDWEwgc3BlY2lmaWVkDQo+ID4gbWFp
bGJveCBjb21tYW5kcy4NCj4gPiANCj4gPiBTaW5jZSBmaXJtd2FyZSB1cGRhdGUgY29tbWFuZHMg
Y2FuIGJlIGxvbmctcnVubmluZywgYW5kIGNhbiBiZSBwcm9jZXNzZWQNCj4gPiBpbiB0aGUgYmFj
a2dyb3VuZCBieSB0aGUgZW5kcG9pbnQgZGV2aWNlLCBpdCBpcyBkZXNpcmFibGUgdG8gaGF2ZSB0
aGUNCj4gPiBhYmlsaXR5IHRvIGNodW5rIHRoZSBmaXJtd2FyZSB0cmFuc2ZlciBkb3duIHRvIHNt
YWxsZXIgcGllY2VzLCBzbyB0aGF0DQo+ID4gb25lIG9wZXJhdGlvbiBkb2VzIG5vdCBtb25vcG9s
aXplIHRoZSBtYWlsYm94LCBsb2NraW5nIG91dCBhbnkgb3RoZXINCj4gPiBsb25nIHJ1bm5pbmcg
YmFja2dyb3VuZCBjb21tYW5kcyBlbnRpcmVseSAtIGUuZy4gc2VjdXJpdHkgY29tbWFuZHMgbGlr
ZQ0KPiA+ICdzYW5pdGl6ZScgb3IgcG9pc29uIHNjYW5uaW5nIG9wZXJhdGlvbnMuDQo+ID4gDQo+
ID4gVGhlIGZpcm13YXJlIGxvYWRlciBtZWNoYW5pc20gYWxsb3dzIGEgbmF0dXJhbCB3YXkgdG8g
cGVyZm9ybSB0aGlzDQo+ID4gY2h1bmtpbmcsIGFzIGFmdGVyIGVhY2ggbWFpbGJveCBjb21tYW5k
LCB0aGF0IGlzIHJlc3RyaWN0ZWQgdG8gdGhlDQo+ID4gbWF4aW11bSBtYWlsYm94IHBheWxvYWQg
c2l6ZSwgdGhlIGN4bCBtZW1kZXYgZHJpdmVyIHJlbGlucXVpc2hlcyBjb250cm9sDQo+ID4gYmFj
ayB0byB0aGUgZndfbG9hZGVyIHN5c3RlbSBhbmQgYXdhaXRzIHRoZSBuZXh0IGNodW5rIG9mIGRh
dGEgdG8NCj4gPiB0cmFuc2Zlci4gVGhpcyBvcGVucyBvcHBvcnR1bml0aWVzIGZvciBvdGhlciBi
YWNrZ3JvdW5kIGNvbW1hbmRzIHRvDQo+ID4gYWNjZXNzIHRoZSBtYWlsYm94IGFuZCBzZW5kIHRo
ZWlyIG93biBzbGljZXMgb2YgYmFja2dyb3VuZCBjb21tYW5kcy4NCj4gPiANCj4gPiBBZGQgdGhl
IG5lY2Vzc2FyeSBoZWxwZXJzIGFuZCBzdGF0ZSB0cmFja2luZyB0byBiZSBhYmxlIHRvIHBlcmZv
cm0gdGhlDQo+ID4gJ0dldCBGVyBJbmZvJywgJ1RyYW5zZmVyIEZXJywgYW5kICdBY3RpdmF0ZSBG
VycgbWFpbGJveCBjb21tYW5kcyBhcw0KPiA+IGRlc2NyaWJlZCBpbiB0aGUgQ1hMIHNwZWMuIFdp
cmUgdGhlc2UgdXAgdG8gdGhlIGZpcm13YXJlIGxvYWRlcg0KPiA+IGNhbGxiYWNrcywgYW5kIHJl
Z2lzdGVyIHdpdGggdGhhdCBzeXN0ZW0gdG8gY3JlYXRlIHRoZSBtZW1YL2Zpcm13YXJlLw0KPiA+
IHN5c2ZzIEFCSS4NCj4gPiANCj4gPiBDYzogRGF2aWRsb2hyIEJ1ZXNvIDxkYXZlQHN0Z29sYWJz
Lm5ldD4NCj4gPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBIdWF3ZWku
Y29tPg0KPiA+IENjOiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+
ID4gQ2M6IEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tPg0KPiA+
IENjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4gQ2M6IERhdmUgSmlhbmcg
PGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiA+IENjOiBCZW4gV2lkYXdza3kgPGJ3aWRhd3NrQGtl
cm5lbC5vcmc+DQo+ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tPg0KPiANCj4gT25lIGlzc3VlIGFuZCBvbmUgdHJpdmlhbCBjb21tZW50IGlubGluZS4NCj4g
V2l0aCB0aG9zZSBmaXhlZCB1cCBhbmQgc3ViamVjdCB0byB0aGUgZmFjdCBJIGhhdmVuJ3QgbG9v
a2VkIGF0IHRoZSBmaXJtd2FyZQ0KPiBjbGFzcyBiZWZvcmUuLi4NCj4gDQo+IFJldmlld2VkLWJ5
OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQoNClRoYW5r
cyBmb3IgdGhlIHJldmlldyBKb25hdGhhbiAtIGZpeGVkIHRoZXNlIGZvciB2NCENCg0KDQo=
