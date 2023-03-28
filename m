Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A86CB2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1AOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1AOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:14:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E71FCB;
        Mon, 27 Mar 2023 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679962455; x=1711498455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBe0j4Ze9S7XhhpRKx+/KdzMeLCc5kleEUFQTSYdVTE=;
  b=P6iYyGaDO80G+h8oSh0rFodyQUh6/LA9cBZQ1ppGSLc9myn7ydpKBYm9
   ij5sGAXjHNd3yCkyG9725HOaFhZxwkQLTU2Neg6H+7niIXKRLjywcoJs9
   j2t8zV98C7Ebc0Yen6sm+KLSkuyRqi2PhGuPb37NeVJUP9b7HWPDjyyWR
   VpS5Vg4tpgIuPo7Ei67Yji15dsYJglzkX72kGCd5ir3PQypBEGvyknH84
   bw2KI0CBwu5HHr0LXMciDSifLLYXgtAHlfbuXWDZL9hnQyTExZGC3v+xT
   yfLmsMHrTwapFPxd1M3SdLHi1GM9tYMKlcKwUDqLMxOZYFcbsacmqriF5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342005774"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342005774"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 17:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633808526"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="633808526"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 17:14:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 17:14:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 17:14:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 17:14:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 17:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWruXOK8oVBo+aMuc7zbBNQ+FbAxI8GKMOWKXMTp1PDLR31vfWzu8HmH96KP2OniQ7/rqFUkumFJcR04FvEM3Hz6FIor/PwcUw0JHHx8kLP874e2V5Ojk+DEqaMssO5eG+HUHlfuFHC8AScjSPqH63guTda+/BY5vDOEx3IhAgAJGNbYxOYy9373nMJVqMJiklox4YcjPKaMLNsYdFHDGLP73kxZ/NRTlmbhngpY7zamyUQ71KPbDCMJQux3yGHidpPBHnQAFleirpdCDupOROHOKJKWuvRAfqYpoxQuzhjfH8J+JvcLxpgXCDHr2XF5OEP6DZyfMXiq8EGtuthmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBe0j4Ze9S7XhhpRKx+/KdzMeLCc5kleEUFQTSYdVTE=;
 b=b2fA+LSYSeCAk6pkTwvYSUKIRpmCr54Nk9bTAAslK0pQ8on7Wq+Mzjfd4m1C34BC5FC8Rt/YCJeAKrTDyQCFciDxjDMQ6MFZkG9Om1NXQ8BVWZ18MMe2qOvp5iyX65bqsLyJpaxdf/eit3HLBZ3KZV6saWWPvnt1B8RhZ56Tfj1wlXXO0pDj7Lnxf/YdKKBC0LFeLAuZqwSMgG/pHtaCDz3PFu4ttizYXryBwo+Kv0DMisiuFJXR6OJEla4imIwvNUeiTu0vIB0pYe/qKqrXoMGNDfPIN4tqPWHJG3GqetXnhyZa8iFoPJPSHGEqbPsqhJDr8lKX+DdhwCwRE57atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 00:14:07 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 00:14:07 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cQoPnlerMcUKFbHJCjrW4W68FRAeAgAAUR4CACSeJoIAAcOYAgABrkNA=
Date:   Tue, 28 Mar 2023 00:14:07 +0000
Message-ID: <PH0PR11MB5880E8E099868473028944D6DA889@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZCHWxD7D9N7v115O@pc636>
In-Reply-To: <ZCHWxD7D9N7v115O@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS7PR11MB7737:EE_
x-ms-office365-filtering-correlation-id: bce5b755-e362-4398-51a4-08db2f2158f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbsTpCXMd79TtOT8fCCU1b9m8jsJhh+S2TzkSKpLdwh1AAx9Gb3MXBIEPSfk9EbxD6pkCtUdQYPQ0m3bKMmjfa1t7or3KfGuKX09+rJvOqzd78bJvITABwvyA6KmQl4aitFlefu1yPxpplMoVW0AwCuU+ua91HI0Xz7Lrpm4yhQJdM4si/PPPoATFa9+51JriPJArYcYOjTJyUkFGrE8lWLl75Xz++8Yz5EcMrBmT50578fX3WGozyuV1BG8lTGtM6mMvKQjIaTNYRce55VmPU0KnZI49LfayyJn92jixb4rcmHggGKpMjwZK74h/ecEEdiMcx0vMGj8bCTGcHfw+fjCug1vWPpK7rlhpIrofZ3o+8ld6ToUGsGo3me0sLqLmpcF54hoHumOVatoW195pnxHN62R8oyR9K5fyxcR9V1DGJ1cl5R09sAb5FxZWOsg589PpPxsK9mltSOzRHkPfd+s2M1Be9m2065oswpiCBV+wEVcVIvWhkoPuisGx1IRWIErvm+BXAIKyx+Ocy74+01mipsPWbsbTB6xicNLka35KmE8Vwnx0pjDpu6xiD+kGez2hATrrulLiyD0D9ru9CZLnytx+z8UqPGpA13/6lHHy9z3mvq7v0IkJpe9WepV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(55016003)(478600001)(316002)(7696005)(71200400001)(54906003)(2906002)(9686003)(6506007)(26005)(33656002)(186003)(38100700002)(38070700005)(86362001)(41300700001)(76116006)(6916009)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(122000001)(8936002)(52536014)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTJRQlFGUm92V2wyeDRLT0QybHRyS2dyYVc5RThWMGpNZitoMU92R3N0Z05M?=
 =?utf-8?B?VUhkYURyWkJSQmZyb2RldEkzTVZQUG1NSHBkV1ljM1Z3ZVp1Q01Sd3hoV0R4?=
 =?utf-8?B?OExKWURQK3loQUhZYUVmazdXdEJ5c2lwZWpvNjdVMGFPZXhsU2JGaHZRT1l2?=
 =?utf-8?B?REZNaDdubEhRRnZtRWhZM0xGdlROTWNWeUs0OGJjSFlCRVU4SnRjZHNsODFB?=
 =?utf-8?B?MEpESjhzWEJFRFR6YTBjbk8xY3lwYnR0eVNVSTg3S2xMNjdOVDdRQlFLbjZT?=
 =?utf-8?B?SmpWejVBS2VublIxV1BKTkdzbG9BR0xpbVBObU1aOEdCcVF2RU4vczU2TTZQ?=
 =?utf-8?B?ajE0cmRtV0IybU9GVXRReTlLZFhjV095cVZNYXdxbkJodkxvM1NYa1FCdXFt?=
 =?utf-8?B?d2dOWngxNzhFQkZ1ZXkwZnMycmpRcFZNdVZjNlphKytiWXZ6Mk1RQ1c4amVW?=
 =?utf-8?B?b2Y2eE9sdnh6TkxkNnJHQTFUN2F1SUlJZ3pzNzNyN24vV2RBZGVkT2dSN00z?=
 =?utf-8?B?OFBTak51clVTZzhIMXVkYlZTaUgyWFNZTzFZMTBIR0dENnBramdzcTZiaGRl?=
 =?utf-8?B?UTRYdkZJZW5zaUZVTjhxTDMvWjdmSXBCTWwzMHRISzZIMFNlTUprUGxCb0NV?=
 =?utf-8?B?ckZaRVpWRkJrR3p5djMrMG5JbHZHSE5DWHFRUmRhaEQzTzFobjEvUTNzM2Zm?=
 =?utf-8?B?ZWZKd1NtVnRud2VIVU13OGQ4TzZqcHFUMEdhMW5BMmtTNHlhNG9ZNUNwL3cy?=
 =?utf-8?B?dXdrZXhyRVMzeitxR3NCYTc5QVBPeW5UQXVIRmhNVzlTNGxNd0ZGVDViRnFM?=
 =?utf-8?B?OEFEMjBHZUJRQ3VDY09Zclhud3hxbXBUMGRGeG96cTBiT3FLVldveGFPUldx?=
 =?utf-8?B?Y21uanVKMXI4clpDRGlrZDNhYnhFYVl0dG1La3FESWJ1bjJTazlEaHg3RnhM?=
 =?utf-8?B?MEpFdzA0clgyZFdaOFlaZ1NaZ0t4VGREY2FqcU5qZm45YkFRQXI3OHBHR2xi?=
 =?utf-8?B?NzlXNHovWmFzbVM3czU4Z1ZiZlVvRm41ZmdVMzh6ZXltbTl0c212U2N1SG1n?=
 =?utf-8?B?YU8xM3dqSk5rWW1FRVQrTktjTkZFVGExMTRGYm0rV3NwTE14b1VtQllKOUlN?=
 =?utf-8?B?aG1UaDdTcW9BT1IrdE9hY3JsWGk1SGNYWno2ZnRDeEJWaDhUZ1BNTktVQTZZ?=
 =?utf-8?B?dFBidzY1eGpPZ1VPbzBZTU9sVXJlOFVEUmk2b0ZQWXlrMzVUTStWNWNrZXYv?=
 =?utf-8?B?aytIUHlzN0w5SnZvN1U5NmNoVmhBdGhYOFgxSDNycXdyeGltUjBWcjc0SzVU?=
 =?utf-8?B?WDlScmVZem90dkFEUkc2Uzh0V21pa3MwYmJsQmxJdTNobVZ6SjRxWW5DT2NM?=
 =?utf-8?B?b1oyYnBBa0JlTldibjlnV1RUeEJ5Q0gwUVdKajF0blFkdGJ3R2QvbWFqYlBr?=
 =?utf-8?B?NlMreUgxUzh0dS9tYjNyaXB0Qkp6aWIreHg4a1k3dVViTzZ0cExiU3ZITzhJ?=
 =?utf-8?B?bEtySitqazNBVXJMbVBvdDVTcjVnQUNVZXg3Z1BZcGRsbDkvMXBWb1J6ZXdH?=
 =?utf-8?B?QS9pQmN3WXFtTitibkpTYXRYY2xibmF0TzZsOUtJekVLRTE0bkRyUmZsZ294?=
 =?utf-8?B?MEFYTVJuZURoWXpIcGJCQUNFaWVpdlU2M2lUUFhQVXM5UmlkSy9sUjJNb0pk?=
 =?utf-8?B?R0F2YmFkZmlkZGJ2Y3BlSEorc2RobTF1L0VjWkw3bXk2MUJJKzBBYmxxeHlC?=
 =?utf-8?B?ZjV1SDQ2NVF6NGErWktGSUtPUjM3U1dhM2Z1eDUzbGErVkRzWk9nRXBSM25u?=
 =?utf-8?B?NkhRUGVMMmlnNlFjbCtxZ25LRTdMbE1xWTRLVVFEWDR2MHJiNWlzYmwvRmRR?=
 =?utf-8?B?NENxc214SFZyTWVvd1I1UE1QSDJkTlRkejZZM21EcERmbjB0THQvbzh3U0hx?=
 =?utf-8?B?RW5hRzI4TUtqN1VnQ00wSCtUaUZIbmxhWFdidmNKN0lucTlUc0QvQytjSVpo?=
 =?utf-8?B?bUJ3c2VRcVV3Ui9zeXQ3WDJndFMyOWZCcXBtTW1XOThuY21za3JpYU5SS1ZB?=
 =?utf-8?B?Y2ZTR3ZuVS80S1I3WnUxRTNxVTBIYm5pNVFteXp2Z2FteTAwS1ZicEM3YjJh?=
 =?utf-8?Q?BSMftq3V2YqdbMqDRjwo5/+Gw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5b755-e362-4398-51a4-08db2f2158f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 00:14:07.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x29L1AhgI7Ugfljc4Y3RPP9XihFNm60BtdHoRBs/gBTKebSiOQ9lwipAkNk2GD/f8sJuctV7y481UgSbVvK2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiBGcm9tOiBVbGFkemlzbGF1IFJlemtpIChTb255KSA8dXJlemtpQGdtYWlsLmNvbT4N
Cj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDIxLCAyMDIzIDY6MjggUE0gWy4uLl0NCj4gPiA+
IFN1YmplY3Q6IFtQQVRDSCAxLzFdIFJlZHVjZSBzeW5jaHJvbml6ZV9yY3UoKSB3YWl0aW5nIHRp
bWUNCj4gPiA+IA0KPiA+ID4gQSBjYWxsIHRvIGEgc3luY2hyb25pemVfcmN1KCkgY2FuIGJlIGV4
cGVuc2l2ZSBmcm9tIHRpbWUgcG9pbnQgb2Ygdmlldy4NCj4gPiA+IERpZmZlcmVudCB3b3JrbG9h
ZHMgY2FuIGJlIGFmZmVjdGVkIGJ5IHRoaXMgZXNwZWNpYWxseSB0aGUgb25lcyANCj4gPiA+IHdo
aWNoIHVzZSB0aGlzIEFQSSBpbiBpdHMgdGltZSBjcml0aWNhbCBzZWN0aW9ucy4NCj4gPiA+IA0K
PiA+IA0KPiA+IFRoaXMgaXMgaW50ZXJlc3RpbmcgYW5kIG1lYW5pbmdmdWwgcmVzZWFyY2guIDst
KQ0KPiA+IA0KPiA+ID4gRm9yIGV4YW1wbGUgaW4gY2FzZSBvZiBOT0NCIHNjZW5hcmlvIHRoZSB3
YWtlbWVfYWZ0ZXJfcmN1KCkgDQo+ID4gPiBjYWxsYmFjayBpbnZvY2F0aW9uIGRlcGVuZHMgb24g
d2hlcmUgaW4gYSBub2NiLWxpc3QgaXQgaXMgbG9jYXRlZC4gDQo+ID4gPiBCZWxvdyBpcyBhbiBl
eGFtcGxlIHdoZW4gaXQgd2FzIHRoZSBsYXN0IG91dCBvZiB+MzYwMCBjYWxsYmFja3M6DQo+ID4N
Cj4gDQo+IA0KPiANCj4gQ2FuIGl0IGJlIGltcGxlbWVudGVkIHNlcGFyYXRlbHkgYXMgZm9sbG93
cz8gIGl0IHNlZW1zIHRoYXQgdGhlIGNvZGUgDQo+IGlzIHNpbXBsZXIgKG9ubHkgcGVyc29uYWwg
b3BpbmlvbikgIPCfmIouDQo+IA0KPiBCdXQgSSBkaWRuJ3QgdGVzdCB3aGV0aGVyIHRoaXMgcmVk
dWNlIHN5bmNocm9uaXplX3JjdSgpIHdhaXRpbmcgdGltZQ0KPiANCj4gK3N0YXRpYyB2b2lkIHJj
dV9wb2xsX3dhaXRfZ3Aoc3RydWN0IHJjdV90YXNrcyAqcnRwKSB7DQo+ICsgICAgICAgdW5zaWdu
ZWQgbG9uZyBncF9zbmFwOw0KPiArDQo+ICsgICAgICAgZ3Bfc25hcCA9IHN0YXJ0X3BvbGxfc3lu
Y2hyb25pemVfcmN1KCk7DQo+ICsgICAgICAgd2hpbGUgKCFwb2xsX3N0YXRlX3N5bmNocm9uaXpl
X3JjdShncF9zbmFwKSkNCj4gKyAgICAgICAgICAgICAgIHNjaGVkdWxlX3RpbWVvdXRfaWRsZSgx
KTsgfQ0KPiArDQo+ICt2b2lkIGNhbGxfcmN1X3BvbGwoc3RydWN0IHJjdV9oZWFkICpyaHAsIHJj
dV9jYWxsYmFja190IGZ1bmMpOyANCj4gK0RFRklORV9SQ1VfVEFTS1MocmN1X3BvbGwsIHJjdV9w
b2xsX3dhaXRfZ3AsIGNhbGxfcmN1X3BvbGwsDQo+ICsgICAgICAgICAgICAgICAgICJSQ1UgUG9s
bCIpOw0KPiArdm9pZCBjYWxsX3JjdV9wb2xsKHN0cnVjdCByY3VfaGVhZCAqcmhwLCByY3VfY2Fs
bGJhY2tfdCBmdW5jKSB7DQo+ICsgICAgICAgY2FsbF9yY3VfdGFza3NfZ2VuZXJpYyhyaHAsIGZ1
bmMsICZyY3VfcG9sbCk7IH0gDQo+ICtFWFBPUlRfU1lNQk9MX0dQTChjYWxsX3JjdV9wb2xsKTsN
Cj4gKw0KPiArdm9pZCBzeW5jaHJvbml6ZV9yY3VfcG9sbCh2b2lkKQ0KPiArew0KPiArICAgICAg
IHN5bmNocm9uaXplX3JjdV90YXNrc19nZW5lcmljKCZyY3VfcG9sbCk7DQo+ICt9DQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChzeW5jaHJvbml6ZV9yY3VfcG9sbCk7DQo+ICsNCj4gK3N0YXRpYyBpbnQg
X19pbml0IHJjdV9zcGF3bl9wb2xsX2t0aHJlYWQodm9pZCkgew0KPiArICAgICAgIGNibGlzdF9p
bml0X2dlbmVyaWMoJnJjdV9wb2xsKTsNCj4gKyAgICAgICByY3VfcG9sbC5ncF9zbGVlcCA9IEha
IC8gMTA7DQo+ICsgICAgICAgcmN1X3NwYXduX3Rhc2tzX2t0aHJlYWRfZ2VuZXJpYygmcmN1X3Bv
bGwpOw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiANCj5VaC4uIEkgYW0gd29ya2luZyBv
biB2MiBvZiBvcmlnaW5hbCBwYXRjaCB3aGVyZSBpIG5lZWQgdG8gYWRkIGEgS2NvbmZpZyBwYXJh
bWV0ZXIuIFlvdSBhcmUgaW52ZW50aW5nIGEgbmV3IEFQSSA6KQ0KDQpMb29raW5nIGZvcndhcmQg
dG8gVjIg8J+Yii4NCg0KVGhhbmtzDQpacWlhbmcNCg0KPg0KPi0tDQo+VWxhZHppc2xhdSBSZXpr
aQ0K
