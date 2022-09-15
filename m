Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A15B9307
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIODXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiIODXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:23:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127D91D2A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663212180; x=1694748180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z59bR4iqP3w7RQGUbg/X3DCoxCBnANuAcfXROmuhkdI=;
  b=H2R03l0/+xiqhfzpR0UQOVXbxIK+h457N/Jx0BzvOIvtJWL0kFvY/yQb
   5XOANQHX05DkUVEdzwhAQ406Wyqh7XbpaRVakbvUSs1qxftw+rVIBUCBi
   hwhyPAjh394i2mX2GNAI9Pv3+5vv5vNx+VSr1nZwzQ/Co1Eu0IcQ9NWsF
   1XwMMfWu6eciRfd+n4i3DTiYfh3qnJHKArcsXZ3FKf2JOa3Cw/B6w4Vcp
   a1gY0EXEZ4gJFsqUrILQWGqpJuqNTnLcTWyHPjdmPjG2zXlFxUE8XKQwO
   Jk1zfltZ8tw0puYDBUrMMDCcAxK7tDNYurEE7D4vyvYGfIqbvwiXsD6pc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299959840"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="299959840"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="862168749"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2022 20:22:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 20:22:56 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 20:22:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 20:22:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 20:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD8KZcY2xdBfyEOVW4+roCglNTLqZTe3ORz2Jac4aPxe9K+PdlCWjLk24mM5CSjyQnmNRBClUFLQlG/VOiInPM3IQ7WF8coJx+M6cRcuqq3j6OJWIuAU//MuNKujNM24dz/g/1g1wjAZcGfQ/49Fob1jgl3OpbKftZjGM0IK2NbLa0/5/m3qEDpLX4rrWJW19OpsrwUARiaT1BbqnLNp6Vw/YKM00Klj6EsFA+s0/PpsVNHE2cRAFesrge+4rcxEobmRVpyD72G6fa2XDhqEMeNJHnH0sgPgMkaEgxtWdC3iYOVvXlQdSjMw4/XIUhZT1ccvfNETN8MrtE3441SCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z59bR4iqP3w7RQGUbg/X3DCoxCBnANuAcfXROmuhkdI=;
 b=QcEwLr/cAHqXM7IsIbzSRI0Ub9IJQw2sZiNIEHXykwQe+ilE/Okr8FdZu3eon6t1ffLSa3kNbbuq6v4IUWNSkQyHH1cCgSvw6wVn/n767nCDxaUDwmaaJvxnHm7X7BFG/9F1IFQlb95THA79WRCpLFQCtNv6uNg+VDCJ8AxYyvQwZze+/NTkBzHnBBFN4ZTE0ITF8F5LSosbn77ofpLEfZfNUenDOy6MkHgFSM+X7ei6enJppfCm09fOtPdqIDReWGzQkQGwhdgneFEik9MmgJ+9Z+Mqnme/IA2KYS/Ao1zanJevJZQ2piYtXaAFg3dc2XaOlapLVTeY2m+FzzUiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 03:22:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 03:22:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Topic: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Index: AQHYxlL15aXn1csO5EOwQ10Vd62MPq3c/4bwgAAZOACAAr0z8A==
Date:   Thu, 15 Sep 2022 03:22:49 +0000
Message-ID: <BN9PR11MB527688C87CEA57CACD5324608C499@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <826a10fa-7dc3-887d-8a08-e03dcf1fa59c@linux.intel.com>
In-Reply-To: <826a10fa-7dc3-887d-8a08-e03dcf1fa59c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7078:EE_
x-ms-office365-filtering-correlation-id: f3d28221-ee4e-443d-8a30-08da96c9913f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqIBCTrCsvLJhvdLFsCsn2AyEBUHFzn04MW6pTbOUqNBynp/tX0ZvjDRAX2CMeMHMSWGLR3/saNeG5sVxyTtzqTVHVEW+JkVOEntmrkwotX+chTMZ4AOnnW+deWBPoq11V2SJr0Z+mvg/xU2T2JIddR40qawiSASnfyYJkF1gEiqX91Vl3udHEnY6T5wCkOdVDhtgqbSBybYmffDEcBaVAi6PgrXHMIXImJwUvPx1fOWJtYxZUqE0krKIEnTH/VYBkhls2ypDNyaXT95u68MXeoiyqb0G8JLqqUlgVXFYZwHvcOpKQo9elJxcY06x1qF6Cb7ZTK6N2aEG1nVR/m49dAccdLa3iP7cfSMiZddySNaQTILdIXk5H6DgeFyvsw80jZDFzzYsJJlp9oyl3AhEWDi7xAfmfYQINcy8jOE8MTDJ/q9efi1qYNzG877QgfZmmrPv7O/p6MjV79KGl4XSbOgAwxh8RWPnNQoX+Va8RONBozP3FdXsclkcWt7f7Dwgj/sYJ7EDA3ZNimn6jBMnVmvKSaoYb/qTFnTabDcLgEkrWCW/KGAzFOqhBm4NZPZYtKGwEqZ9gc//QZ7buPeiD4r9MeWPo8fjnXClJuKAWFxflV5fK+Rmq5nymbB1tZJZZ4mFOjy/2/wa5UJykrUlpHFtG3cuLGrcjTmRGXwjqmbVA9dm/pq5jvL5Ooc0wE+GIgkdPovP+Hp3IvQ/xPlqw+7A/FGyvxr6y8InfYKmsjuUNUDumk3m0PbgcGe7628Y95IBXFniJiF5RF0wR4C9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(38070700005)(6506007)(9686003)(33656002)(66476007)(66556008)(122000001)(54906003)(53546011)(2906002)(4326008)(41300700001)(52536014)(82960400001)(38100700002)(478600001)(26005)(7696005)(64756008)(55016003)(86362001)(66446008)(76116006)(66946007)(71200400001)(8936002)(8676002)(5660300002)(83380400001)(110136005)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVBL2Zkb0o2UFdhT3M4QyttY2VET0JGMG1zSVdUTnpzaStMU3Z3RCtrVWxK?=
 =?utf-8?B?Q1hPR0pMVFVKMUYveWdiZjh0R2tqaUZLT2o2TE4yMjRZcUlFUEYrSHF0QTZD?=
 =?utf-8?B?aHpyanR0ekdRTVZ4TEpZT3hhSWJNTTJlUlF5b2FBMWx5b2MwVitNU1BpVHkx?=
 =?utf-8?B?N2Q4RmdzdG5FSVEySzVWbXBSZkVNWVFaNEZRaHZtSHlOVGZwcjFQNTNTV1JL?=
 =?utf-8?B?M2ZsbjFrUDVBZFQrLzRuUnlmSDdVYmZpRjFmNU5LTEdqYSt6anlPcTEwNG05?=
 =?utf-8?B?U0g0bERab2JQcGhUYXdVNlIzb2hxcm9wVm53cGFwVHhIbytDb20vR3kyendi?=
 =?utf-8?B?VkdadUlhUFUwYXM1djlvN2hhaTJaTXZKdVV2aXpVWHB1dUNrdVROSGl3bGlG?=
 =?utf-8?B?enphQzdRdThCTm5PZ0d2ZkVSS1VoUFZuSVVhUUR6RFdiaHJWTnhyZTBFSitY?=
 =?utf-8?B?UUMzb2ZJb3FBMDA1QVBOOXp5Z3NGdjhGd3Z3WmIrWGpUQjU3aVA5ajB0T01O?=
 =?utf-8?B?enhEUFkxRmpxVGtKUSt2Q3N5dmVGSERkVG9yYXlRZkZMUm1RckIxNVdGOU9K?=
 =?utf-8?B?UHFmVmF3Yis4N2pia3ZkbXNPTzBrRjhOeWM5am4xWDQ0RS8xWndXY1puakJO?=
 =?utf-8?B?aDQwdUR4MTFuaVlmenlMU2x1UFcvZmhKemR0aGZ1bXk5aktEMm1iOHp5eDdn?=
 =?utf-8?B?TFptR0cxd3kwSitSM0Q0V3VlZzkzaUQ5NE1RQU5zZVU0TTlKV21PRzlOTDdw?=
 =?utf-8?B?RzNPdWVqbGtjSGRDMnd0WC9KdXhPbEVqWkEzZHk5YjFYRFh5WWtmeXFTaytT?=
 =?utf-8?B?TkRPcEZSbU1pTmM3QzRyOVRlUmtuSHRYcVpWK0dQZ1lXMzZOQzVTOS8xY1R2?=
 =?utf-8?B?Wlcrc1Z4YkJGVTA3R0hwNXFKL1g3VlNiWDdLbm90SDI5cVUwZW9qYjlmZFlK?=
 =?utf-8?B?cVZvUVk3RGFrVTlNREIrSlk2bjFZZS80QzFNaGVVYXF2TzVaK0YvWkI5bzN5?=
 =?utf-8?B?aENNb2RteDlvNzdBcVczenZTempKNGZxMHErZXNEcEZjZWVLUHlUcHVDOGpi?=
 =?utf-8?B?dXowMlB5eUhjWW9kMnd2cmdQMDVRcUdPdVROTWxSeDRnMkliczl0QjVGRTdB?=
 =?utf-8?B?dWh1TndiV01FbTdPbnhCcVd5cW9NUk1CWmJaN21sL2E5MVZYYnJjOE1ad3pQ?=
 =?utf-8?B?R3pkSGF6R0xOc053OUsvaFc5Sk1UTUVEQVVvbC9sVWlQQ0ErQTN3NFpZU2lD?=
 =?utf-8?B?SmdnYzNJMTVsTVhnMDQ0Nit0YmtPaXI2T0E0N0FzZjFqelNCaEVqdVNsUUNx?=
 =?utf-8?B?ZzRiR2xuR1JzMTFGNUNoc1VNRWNyTUtnRG9kaVloUFU4VUtxVDlSdVFiK0gx?=
 =?utf-8?B?dldSdkpuQS9YanA4T211WDZmaDI4blVFWEk3RmhldVYyL0l2UDVrNE9MRVFx?=
 =?utf-8?B?cnREVEthOHdsSGo2QVFyckswTXBkd0N6ZnhnU1lOZGR4T2xUdWxTQnpFaUdl?=
 =?utf-8?B?WGNXNk5ia3prOHVBQ3lQaUV6VUtBQWdWZVZWVG81ekVpeEY4VUEyOHQyU2pS?=
 =?utf-8?B?d1h5b3dxUDBOSVQ4NnRtQjVPMWFZTS82U29mY2pCSEVTbjloY1NuQWVESVJ4?=
 =?utf-8?B?VUJwOHkybkFEb24zY2VSSVRTdkoydkZsMU4zV2tNZ3gxY25GU3grOU1aWGRP?=
 =?utf-8?B?UzhuMXVabXUwSGtOUGpjWWo0dmdybUdGVitvZFg0L1VIN0t0Y1BYVzBZazEv?=
 =?utf-8?B?OTdwb3dmNThVS3pCY2NmNzhiYUs0a1FQaWdURjRiT1V5anVRWExwVE9xVzFn?=
 =?utf-8?B?S1o4SndnRFNkWE0zZXVXa0hzZ1J5NnkwTGVZV2p2N0JFQk5FMmVpemEvalhy?=
 =?utf-8?B?V3l3ajdTbmkybklsR3VJYmpTNEs0UldzeDh2Q1VEaTcvQTVOdW5VZGVoU1VW?=
 =?utf-8?B?QkdvUElLeVkzNTJUblZCMEMydlRSdFlDcTFFc1ViQTRQbjlYU1ZXMFdVRURZ?=
 =?utf-8?B?dTVIQ0lQN1RjQ1ViRjdXNVhDdFdaeXlzdTVUM3g3SDd5MENxc2l1VU95SVcv?=
 =?utf-8?B?VFRnQ2RnL3VEOElQbzFZYXpkVzZVQmlOd0xnZWhWbHpaQ2xHMDdhYTNScVBP?=
 =?utf-8?Q?XxZiSGN7RvnhYrJSjXAsSrHbJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d28221-ee4e-443d-8a30-08da96c9913f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 03:22:49.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4Tf7E8d9Ncx/EorFwYcKx1yFNYfcRnpkwCtyAi61Myw45rB4m2FWRHz4eh4kw/K0pa1SjuNwFO4rl5HOb/i4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMjIgNToyNSBQTQ0KPiANCj4gT24gMjAyMi85LzEzIDE2OjAx
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjIgMTA6NDgg
QU0NCj4gPj4NCj4gPj4gQEAgLTE0MDEsNyArMTQwMyw2IEBAIHN0YXRpYyB2b2lkIGlvbW11X2Vu
YWJsZV9kZXZfaW90bGIoc3RydWN0DQo+ID4+IGRldmljZV9kb21haW5faW5mbyAqaW5mbykNCj4g
Pg0KPiA+IFRoaXMgaXMgbm90IHRoZSByaWdodCBuYW1lIG5vdyBhcyBkZXZfaW90bGIgaXMgb25s
eSByZWxhdGVkIHRvIEFUUy4NCj4gDQo+IFllcy4gVGhpcyBuYW1lIGlzIGNvbmZ1c2luZy4gUGVy
aGFwcyB3ZSBjYW4gc3BsaXQgaXQgaW50byBzb21lIHNwZWNpZmljDQo+IGhlbHBlcnMsDQo+IA0K
PiAtIGludGVsX2lvbW11X2VuYWJsZV9wY2lfYXRzKCkNCj4gLSBpbnRlbF9pb21tdV9lbmFiZWxf
cGNpX3ByaSgpDQo+IC0gaW50ZWxfaW9tbXVfZW5hYmxlX3BjaV9wYXNpZCgpDQo+ID8NCg0KUHJv
YmFibHkgaW50ZWxfaW9tbXVfZW5hYmxlX3BjaV9jYXBzKCkNCg0KPiANCj4gPg0KPiA+PiAgIAkJ
aW5mby0+cGZzaWQgPSBwY2lfZGV2X2lkKHBmX3BkZXYpOw0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+
IC0jaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VX1NWTQ0KPiA+PiAgIAkvKiBUaGUgUENJZSBzcGVj
LCBpbiBpdHMgd2lzZG9tLCBkZWNsYXJlcyB0aGF0IHRoZSBiZWhhdmlvdXIgb2YNCj4gPj4gICAJ
ICAgdGhlIGRldmljZSBpZiB5b3UgZW5hYmxlIFBBU0lEIHN1cHBvcnQgYWZ0ZXIgQVRTIHN1cHBv
cnQgaXMNCj4gPj4gICAJICAgdW5kZWZpbmVkLiBTbyBhbHdheXMgZW5hYmxlIFBBU0lEIHN1cHBv
cnQgb24gZGV2aWNlcyB3aGljaA0KPiA+PiBAQCAtMTQxNCw3ICsxNDE1LDcgQEAgc3RhdGljIHZv
aWQgaW9tbXVfZW5hYmxlX2Rldl9pb3RsYihzdHJ1Y3QNCj4gPj4gZGV2aWNlX2RvbWFpbl9pbmZv
ICppbmZvKQ0KPiA+PiAgIAkgICAgKGluZm8tPnBhc2lkX2VuYWJsZWQgPyBwY2lfcHJnX3Jlc3Bf
cGFzaWRfcmVxdWlyZWQocGRldikgOiAxKQ0KPiA+PiAmJg0KPiA+PiAgIAkgICAgIXBjaV9yZXNl
dF9wcmkocGRldikgJiYgIXBjaV9lbmFibGVfcHJpKHBkZXYsIFBSUV9ERVBUSCkpDQo+ID4+ICAg
CQlpbmZvLT5wcmlfZW5hYmxlZCA9IDE7DQo+ID4+IC0jZW5kaWYNCj4gPj4gKw0KPiA+PiAgIAlp
ZiAoaW5mby0+YXRzX3N1cHBvcnRlZCAmJiBwY2lfYXRzX3BhZ2VfYWxpZ25lZChwZGV2KSAmJg0K
PiA+PiAgIAkgICAgIXBjaV9lbmFibGVfYXRzKHBkZXYsIFZURF9QQUdFX1NISUZUKSkgew0KPiA+
PiAgIAkJaW5mby0+YXRzX2VuYWJsZWQgPSAxOw0KPiA+DQo+ID4gaW9tbXVfZW5hYmxlX2Rldl9p
b3RsYigpIGlzIGN1cnJlbnRseSBjYWxsZWQgYm90aCB3aGVuIHRoZSBkZXZpY2UgaXMNCj4gcHJv
YmVkDQo+ID4gYW5kIHdoZW4gc3ZhIGlzIGVuYWJsZWQgKHdoaWNoIGlzIGFjdHVhbGx5IHVzZWxl
c3MpLiBGcm9tIHRoaXMgYW5nbGUgdGhlDQo+IGNvbW1pdA0KPiA+IG1zZyBpcyBpbmFjY3VyYXRl
Lg0KPiANCj4gVGhlIGxvZ2ljIGlzIGEgYml0IHRyaWNreS4gaW9tbXVfc3VwcG9ydF9kZXZfaW90
bGIoKSBvbmx5IHJldHVybnMgYQ0KPiBkZXZpbmZvIHBvaW50ZXIgd2hlbiBBVFMgaXMgc3VwcG9y
dGVkIG9uIHRoZSBkZXZpY2UuIFNvLCB5b3UgYXJlIHJpZ2h0DQo+IGlmIGRldmljZSBzdXBwb3J0
cyBib3RoIEFUUyBhbmQgUEFTSUQ7IG90aGVyd2lzZSBQQVNJRCB3aWxsIG5vdCBiZQ0KPiBlbmFi
bGVkLg0KDQpZZXMsIHRoYXQgaXMgd2hhdCB0aGUgZmlyc3QgcGFydCBvZiB0aGlzIHBhdGNoIGZp
eGVzLg0KDQpCdXQgbXkgcG9pbnQgaXMgYWJvdXQgdGhlIG1lc3NhZ2UgdGhhdCBwcmV2aW91c2x5
IFBBU0lEIHdhcyBlbmFibGVkDQpvbmx5IHdoZW4gRkVBVF9TVkEgaXMgZW5hYmxlZCBhbmQgbm93
IHRoZSBwYXRjaCBtb3ZlcyBpdCB0byB0aGUNCnByb2JlIHRpbWUuIA0KDQpNeSBwb2ludCBpcyB0
aGF0IGV2ZW4gaW4gb2xkIHdheSBpb21tdV9lbmFibGVfZGV2X2lvdGxiKCkgd2FzIGNhbGxlZA0K
dHdpY2U6IG9uZSBhdCBwcm9iZSB0aW1lIGFuZCB0aGUgb3RoZXIgYXQgRkVBVF9TVkEuIElmIEFU
UyBleGlzdHMNCnRoZW4gUEFTSUQgaXMgZW5hYmxlZCBhdCBwcm9iZSB0aW1lIGFscmVhZHkuIElm
IEFUUyBkb2Vzbid0IGV4aXN0IHRoZW4NClBBU0lEIGlzIGFsd2F5cyBkaXNhYmxlZC4NCg0KU28g
dGhpcyBwYXRjaCBpcyByZWFsbHkgdG8gZGVjb3VwbGUgUEFTSUQgZW5hYmxpbmcgZnJvbSBBVFMg
YW5kIHJlbW92ZQ0KdGhlIHVubmVjZXNzYXJ5L2R1cGxpY2F0ZWQgY2FsbCBvZiBpb21tdV9lbmFi
bGVfZGV2X2lvdGxiKCkgaW4NCmludGVsX2lvbW11X2VuYWJsZV9zdmEoKS4NCg0KVGhhbmtzDQpL
ZXZpbg0K
