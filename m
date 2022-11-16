Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52862B2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPFgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKPFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:36:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07A2EF63
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668576971; x=1700112971;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwLWtCiZVzun9gNIH+u79S4B5qgVjh2Mksju69qn3Rc=;
  b=H0rCz6VdkqDQhPY26K73uidv3wh4mevngCQiEwjQfB/GuXmIMJlmKJ0P
   FNDlrpKyXYiLe/GYK6F9zLWKlxF2eU/DJE3ACEZlA2ipGlYBBvxHViLAv
   N9fVXOJGy9/x7ogcxpQy+bR3hny543dgsrP8mtbIdnsPQlIuDxYf9VHvK
   UWMf9eqeQAI5g8HzE4EETsC8zJa3rujDddaNJgXpfns0VlLQRmAlixEIt
   8M3cI6gyQ/vzB+lDy1NSgyACMvuJUuQfFUb/19tp5hJZeaqIGjmg4UL5h
   wG2u873s6K9fKfM/AktenGRB8OZsCniOjpbwleUb3efvC7+/uVhZ4lQMV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312461996"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312461996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 21:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="708016556"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708016556"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2022 21:35:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:35:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:35:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 21:35:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 21:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDAFIHuD4RDvWDbiPOx48M/z/l3eCFwYzFNKj9j1DVqxVJwknHiGzgPV/lYrM+jWxCS+kDMmfCb438dfwHmkuPrXEoT/nkr0pRe+W5bBGChYWJpUjPkVYuxPa4+oerkZBxItw+NM4zJ7ADg7F0TaQp5m16eGBhoqw8+/0kRH9ivZ9BrMTo5t3YEQX0PE/MHE2iyvx+3sTr4koXZyScS+KTaTa99tnBm2GZtFBtT+3N/TAMkYVBscRym7RzKAnEWMPFM5Jc2lmRBu13KKjECcKcGiAyYoaJKED9ZGMw342SgpjVU+A3Ba19hC8aZypT62ees2LdbfF1Hob3g7MD0E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwLWtCiZVzun9gNIH+u79S4B5qgVjh2Mksju69qn3Rc=;
 b=LIKjLUZh8O+SGXAWDgROr0KGe4uPoJcx57KNzAtFpsHmU6gJwySq1x+Syc0r7p4zUsWJQDbBKal3bHDCRolTyNMsIBimZNOI4ik4Ct1aG6NC2VebaAv/XUBOcSf9ddCnKVXoKEICl62+7BW8PDn1dllCZyPUKsvpNSTwuNWBab+yR34ghEAsCV3I6+mpjyIeUYgurGwzlM5tVBI8lkfWXlWUoXFHKjFCwgOuyihJsoKsupBLl+PDEkx1J9LyHbDGSOskq13p0VIdKsJQKrloh5jESU04/xtK+TzhZljpFGlZkF8LwN68dNDB+v7hz+8t0QLcjJ78CQpgfQjRnAvbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Wed, 16 Nov
 2022 05:35:41 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%9]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 05:35:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Topic: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Thread-Index: AQHY98siMKR1/esT2UmXGuRo20ktuq5A7buQgAAMpQCAAA4ucA==
Date:   Wed, 16 Nov 2022 05:35:40 +0000
Message-ID: <BL1PR11MB5271F0D4E91A3F6179216ADA8C079@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
 <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
In-Reply-To: <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS7PR11MB6103:EE_
x-ms-office365-filtering-correlation-id: 355ada82-8438-463f-f2a4-08dac7946620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD3Y4n0JBH7hm1Id9QUWVkZsGf1Leurj+YqKj9qkkLx6RP363gLjFV092KgI81ypjcsYEDVtHVQ8DEP84NWjU5MfUcrW/2ROeMsVryvupmfzOUGa3lK0YH5XiYGWz6noIBOPTdMfnp8SZEC93LgfkfSIDomPy9BWk3P0y0hHFhWrZjt7lm16RKMjroXIDdXq351aBbFRgJkHpAd1w361Xo+qdLyheUoNzk6tFqIcE277MvD2twen47yewE9eIIcSZDYwFhHVyQWvWKuSswtHQ2lAjoD8BT91VO5VK2FiBZNHPMoJbFXGcDQg6zXKYApAYmeKfTdO733mUsTTUfQ72FtbIKo820d5nAShEEPGSgNGjRLmEfPvdxMf8QV7NQdskCVG7FWyUTuB/EMKnsKxjzBWCA85GhS5gv704pSUWcZKDQaejoRoVsqLuRmpT50r89MM2N850XBBQ+JUootOZwD2XofVoTfQp8N3ctTC7MWtiwyq6LGhaEDMzPdRYe7eabLU4TUkrhmAAd9/SCyot7KYmlvg+7PWyAHzDMZ1wleWHpXXUS/AkBHXsDy7f6uv0rUWUF+14pnQKYngBEtP+C2ky3AIUotF0wWDKHCGQRphYajwAwo1GZuvuD0YgDeHRtlMMuShowcAGPNSsisiwOeGF7I7AEBIRdLPwwWXRwCml5/qrRPgiHSWOu47l0zI+8gNMKAemq3j8zEjdHoxqX1WxCYFCKy1dvEC7X+JxDIpw1gcY+rbE0ALuduX0MnpAMe1cn40m8Wi91eETAG5Ch568gLu81PmVHdt39Gi54cgy3QLS+IgT7QMh4Y6Gz2k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(33656002)(2906002)(4326008)(38100700002)(4744005)(82960400001)(8936002)(86362001)(38070700005)(66446008)(83380400001)(110136005)(186003)(54906003)(478600001)(5660300002)(64756008)(66556008)(122000001)(316002)(41300700001)(66476007)(52536014)(8676002)(71200400001)(55016003)(7696005)(6506007)(9686003)(53546011)(66946007)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpUL1VwRm55ZiszUERzQjFjZzdyMkk3UkRhTHMxemh1Y2x0WHI4SFhqaXpF?=
 =?utf-8?B?bEVNM1d5QkFRYVBtaDFJQmVzc0dvUjBzemw4NmxPdVF1bDhraFEyN1BMWUs3?=
 =?utf-8?B?K3p0SmZ3YVpqR0dVRlNhUFBVdGRLeDIrci9KQ3R4SDN5TzIzWXdoeHNScEdp?=
 =?utf-8?B?SEloc2RJK1lxUUk3TWFPMlVlcDU3SHJYQTFHNjRwKzZYbXhvUGUwR3Y5QTJo?=
 =?utf-8?B?MXZndTRvOUc2c0swVkNpNGdqWlVNTzI4ZkY3VDN3Z3pmVGVpSHlFbkd3UDBJ?=
 =?utf-8?B?U3lDMmF2U2VaN1haQXBrQXp3YjBLNVFCb3lEUnlxZ0RaWnluaHJYZjY0TGo3?=
 =?utf-8?B?WXE2UHdlZVNVelltbUdTVENYZWFIcU9aSk1lNzlQTDk1T0ZqTldxU3pqbnBG?=
 =?utf-8?B?d1VOSTdRVE80WDZLUnZ0SmFzRzBta2hzZzJ0aHF1bld2WmdRbkNpbDBFRzdC?=
 =?utf-8?B?MlpZaXdkOUVYakpKcGhwUWNwN2JRMHNNQXpEVW8zZkszL0oyaVBWNjU1RXdR?=
 =?utf-8?B?NkJCU2s1MVpVM2ZiSXAxeWpxNElIZXpHUGU0VG1Zb0xZT3RxRU1Jbjh2MFFF?=
 =?utf-8?B?NllwQ3paa3lKOTZ2QVdKVDlQOE5FMlU5NE4rT0ZGZUJzVWtLQ0F5dEk4NFQ2?=
 =?utf-8?B?UkJPWlpkZ1pldDlqNEY1RjcxVndEU0owL3dRMEVIS2cyY2hsMlFNTkxZVDhI?=
 =?utf-8?B?QkF1WEVlb1NVNUR5d2VEVzNacFlHdWV1RHJtd01DSUc5VitPeVpQZTVmMkR0?=
 =?utf-8?B?Mkc5VUNXaS9XQ0s0emRPWlVNbFZ4QVhEbzhRbThyQ3l4ZUY2L2liNEFER1hI?=
 =?utf-8?B?U2k1QW1WWlRjTjRIM092SDVMcFQ5WXdIS2xMemVqVnpWSzd5d08rOGxRaFV0?=
 =?utf-8?B?VDVDSFhISmJydy9Kd2YzTzh6dGFUaEJ4ckFsOHFHcGYzNVJ4M21WM2FJcnNF?=
 =?utf-8?B?QUo2Y2NIV00yRnJwVlExd3dnWmJqUmlndDFqVHI3N2lZWnJta1JVS09qTVZu?=
 =?utf-8?B?N3oyT0RHUk5kNFhzRkhGRDdqaFdtQ1pyM0N1RFdJeFlObE9vRGsrMS8rVUZ5?=
 =?utf-8?B?UThKMlozeVdGc2dqb1JXU3BRZ05Vd0dNYXIwbUxmLzB3dHpYaEdQanptbmZC?=
 =?utf-8?B?dmU2TkNqSjNVa0sra2M3MVgrdEE4SUJVUUdyRHYrS0lvZ3I2alZxS3BkZkR0?=
 =?utf-8?B?b3k1VytiT3VzQTRWV1hGQ3J3R05HaUpOUXNyRzZnT3RTT3VKUTUrbyt4ZFVi?=
 =?utf-8?B?QUg0QkpnOU9paFRtd3czdlFiNmN5Vk90WmcrV0kwUTBrbmJtUThrbG5seEFo?=
 =?utf-8?B?djBjbFpva1ZiWDYyQzQ4MEx0RWdWQmtjZ09mWWY3YU9hM1o4L2tqcTEzV0FB?=
 =?utf-8?B?ZDFEZzdOSmptTDFwRUVzSVpYZDhyMngxbFVSTVZiNndad1FqRmF0SzFvY1hG?=
 =?utf-8?B?MlAxajdXTDhUb2lQYmZYaC91YzEzai83cXR6MmNMVEpsOEkxZ3FSQjQzVjZq?=
 =?utf-8?B?V3FHV1U4ODFwaytSd1gxaDdJQkYrNXV1OGJwMkI0ZHdSN0trOGd4VHhWZEdQ?=
 =?utf-8?B?QkNaWlJxZG5yRGpyR1FTMjdxQ2tqdlpTTXJoNmg2NHRFbFJBM3UrOUgvajB5?=
 =?utf-8?B?RmdsdkFTT0lISWI2TlFJem4yRW1ueWZPbE5XdmkxRm1oR2hqL0V5TjgvTlQx?=
 =?utf-8?B?aUpoL0VXN0U4VmNnTmFmQzJNRlpqY21GQ2NSN3N6a0EzZlQ2cjR5ZFloZE1P?=
 =?utf-8?B?STVkZDNJOWIvZUNZNi9yUnh4MkcrSk1LMTNsMXdjYnVzbkg1bVVGNlN1TWxK?=
 =?utf-8?B?V09xOWkrbGFHd21NWmRiYUxJby9kd2JNM3dpTHV1ZTB1Qmd1SS9mc0xNTEhv?=
 =?utf-8?B?MzRGWldTM2V5cS9NejFOa1lVS2VUN3htWVRialhIcnlzNjNuckxWU1hJbW9u?=
 =?utf-8?B?Mk9CNFJUdHAyeFk4SXVXWk0wU0tEcElFY3ZDTW43TWVrOWJvaW9OL0FjVUpo?=
 =?utf-8?B?MWVQVkdMRmNjcXpRVVV3TWdNc1JLaURzdmpmd09xM3hMdFNGdytGYWpNTWdT?=
 =?utf-8?B?TThPUCt3YW44N3htVktvdTYxemE2cDVWRStlQURycmljT1N6a1RQMmZnanFG?=
 =?utf-8?Q?+IksR6J/YnVWgkMA3BARLSh4R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355ada82-8438-463f-f2a4-08dac7946620
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 05:35:40.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed0G55OsSN1HIAKz7bF09QYNfuaS0GzAoJrnQhdC2FkIPEu3EIoyPhVIoCJBdqrhiXNbMciRVJx9spVOjpREZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDE2LCAyMDIyIDEyOjM2IFBNDQo+IA0KPiBPbiAxMS8xNi8yMiAxMTo1
MyBBTSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNCwgMjAyMiA5OjQx
IEFNDQo+ID4+IEBAIC00NTYyLDcgKzQ1MzgsMTAgQEAgc3RhdGljIHZvaWQgaW50ZWxfaW9tbXVf
cmVsZWFzZV9kZXZpY2Uoc3RydWN0DQo+ID4+IGRldmljZSAqZGV2KQ0KPiA+PiAgIHsNCj4gPj4g
ICAJc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2X2dldChk
ZXYpOw0KPiA+Pg0KPiA+PiAtCWRtYXJfcmVtb3ZlX29uZV9kZXZfaW5mbyhkZXYpOw0KPiA+PiAr
CWlvbW11X2Rpc2FibGVfcGNpX2NhcHMoaW5mbyk7DQo+ID4+ICsJZG9tYWluX2NvbnRleHRfY2xl
YXIoaW5mbyk7DQo+ID4+ICsJZGV2aWNlX2Jsb2NrX3RyYW5zbGF0aW9uKGRldik7DQo+ID4gY2xl
YXIgY29udGV4dCBhZnRlciBibG9ja2luZyB0cmFuc2xhdGlvbi4NCj4gDQo+IFVuZm9ydHVuYXRl
bHkgZG9tYWluX2NvbnRleHRfY2xlYXIoKSBuZWVkcyByZWZlcmVuY2UgdG8gaW5mby0+ZG9tYWlu
DQo+IChmb3IgZG9tYWluIGlkIHdoZW4gZmx1c2hpbmcgY2FjaGUpLCB3aGljaCBpcyBjbGVhcmVk
IGluDQo+IGRldmljZV9ibG9ja190cmFuc2xhdGlvbigpLg0KPiANCg0KdGhpcyBzb3VuZHMgYW4g
b3JkZXJpbmcgcHJvYmxlbS4gY2xlYXJpbmcgY29udGV4dCBzaG91bGQgYmUgYWZ0ZXINCmJsb2Nr
aW5nIHRyYW5zbGF0aW9uIGluIGNvbmNlcHQuDQo=
