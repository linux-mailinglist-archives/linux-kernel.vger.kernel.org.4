Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3C6A024A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjBWFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:13:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AB23673
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677129205; x=1708665205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KgiEUaK+wW+g1A2Qm0M8CchazfgQe8jwS5dSYtW2iNM=;
  b=bPjdZiJeQVXGPgxSc+mUJ3kvl6e6TQIMg55uhQ8KuFawxx7rFAuC+NaV
   LE/FwazHvsU+qTKiuZ3rR83FjDD9d60UtFvrhWOWSb4AT+81gZPFsaEkk
   SbPtd3vHNWhK0/Bk53L3U28ujpoqojo1wd74hPptHlZQX3dulJToI8RiA
   ztI4F7W/zwDBBiyqm83C3QRI1BphqNc7ICvvnMHszeLvlOU+5c9xK7QPw
   Q7P8nPHP157GE/pFQwOG7JvqE+9r59V1q1iXQZgWx/eaN+mY0YOcs2u8g
   2MC0wJid2cNWv761sd5Fa2H2XVH+ybiPDDQUKlQ4skbgg2YL6zG5loXOG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="312742667"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="312742667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 21:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="815188781"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="815188781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2023 21:13:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 21:13:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 21:13:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 21:13:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 21:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWOzP2UvLQywKb9Vicg8XJhg8cBweYNM96IGXVePz5T1cOQtZfFmI7sUl05KpLHEdTxRFjdWeOwVEPfgRBWUIhBHuRGhi1IdVUouYl8NJkpqiFB8ss/HSuybIr5bhFpdCxqmNVAvV1w4eZ7kz+ccajdUtVfVptua2xK0ZGJPZobR5aMPSZoEMs2zjuNHqts7L25mVHYBU2SE+gNxYI1Ls54OapAf9Zxgh8QbxUo5FLzvFfMp7yn1Q0veqWEFLdZNNGMp3TdV/0fRfVWaceV1j2zVdbyi/DIYut97H7yYVbgEu41qwifVAv5gANm/aIF93PoqM9TyhjGbPOO8zxHC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgiEUaK+wW+g1A2Qm0M8CchazfgQe8jwS5dSYtW2iNM=;
 b=OUTlL9nQC8lJBun+h8moRUZz2KZPpZIzwpKtmtN/lsWdfmdAwk6IIwUm14cdt4fcI9AwemyPRnh2uf+SAMjW2jo5VGJVTVMFkQLxUE2MjeSUY3oypV86kuVLvI0gQKHjmdjG/YwDIeVyZRrTk6hTSKP40GaOsS6BNuM925RbtMP6+G4Z6yVx/M/NM3d8cfWDIMNMkK5f57I9HYvP7ZYdyiTn9U0a1QpnY4nfTRtGMEUXsPkle6Uj0CFkWYOccMPR9sCd4q6Zc7CY4ycMlund3l+BEqQKaQ0L0l4Yrj/qU3e3W7TKJK2Rhn9xvZeHu8PWHnAftJP4r8baKTdDOQacgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB5697.namprd11.prod.outlook.com (2603:10b6:208:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 05:13:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Thu, 23 Feb 2023
 05:13:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Thread-Topic: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Thread-Index: AQHZQQOQoUWyhnQ0g0erj0/4773a9K7VHgwAgACdRLCABeTbgIAAUriAgAALPICAAAl8AA==
Date:   Thu, 23 Feb 2023 05:13:19 +0000
Message-ID: <PH0PR11MB58805C9797BEC218610C5145DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230223035359.6jgserikqtc3vnra@offworld>
 <20230223043411.GY2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230223043411.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB5697:EE_
x-ms-office365-filtering-correlation-id: a560c865-5fc7-446c-e967-08db155cadbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mx87M4x3Iq54h0bHA6Twlk1bIGVEpjG+37YQqhOyhJow+P2o3ftxocMCyGvw/0UG+5GADsphYcXOj+Ai6TL1b/ALylrvKi5p+klxOKWzLQ5zWyPrD+DbxwyY28iTqXNfR42UKNY4rHrCmwP4E26GxKw7GD/NUnHDoN5MO0KerpjR9GSGfpGCiY6kWCBT0xN+7tp3S1BElbg0WgEngz5hwZc9wiq6QFvZiHNa2QJvpQsSOTp6lioUBCXZeW275QM+o7yUBda02ZbQJIicZO1HftLr6kMPra+WWnEsAsCioYPSGugilzJ+TemLrFrix7tEhJ2UQNqP3PBt91fINi7KBHfFDoLamNvRWZz92ythsxWg5xSGMpclNWJZltwt4sseoovodLDtWRbRLinkjU5MmocGncKB0C4MQaLU7NYNUlXvzDve+bhmK7nHnDms4n1LMuqtLr+ZxmmdnNim6BSPkoEzO0I31v4/xmrHi3/viJOE98SduLCagozOFEzeS+vZGyMTbXbryXuu6gb8ibl6bt3zYwmjmlZuRorx4Z/rA1KAE7RUF3WiRSltd4xiMNxZ7XULl+K7VCeBXOeTVzCYetgAG0mEnyAtrXfl666Vgd5SEJKwf/Vi6AkNZardjpOpwdpuNRErj+BPcdtNICrKgEhqdbyhsK4/PkRGftrzn0PbbdW7KzcnAqZbbqQUF0jVvTHTx34HUVyvZpQ/Z+a2lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199018)(5660300002)(8936002)(52536014)(55016003)(41300700001)(38070700005)(33656002)(86362001)(2906002)(38100700002)(82960400001)(122000001)(66476007)(71200400001)(478600001)(7696005)(26005)(9686003)(186003)(316002)(6506007)(66556008)(64756008)(66946007)(66446008)(76116006)(83380400001)(110136005)(54906003)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajVuUHg3L3RGdnNodENkbEtXSnZ0b2pMN3g3SVRqdnFnRGJNZ3NuaFJmeVdv?=
 =?utf-8?B?WVNwRDZNQkpqdUh4bmVEckVqa0dZUEVHMnE4cXkrWGF4c1M1ZjlWWVd1NWdJ?=
 =?utf-8?B?YWc2aStwdTljL1ExOVFGeVorRlgzSFdYN3RhaDFvaGl5N3Q5NTc5bk1ETEs2?=
 =?utf-8?B?SHQydVFiNUM3MDA2MlJyU1I3aVJRWUw1b2hvSUhpR1h2b3dESVkxUHZ2VWF0?=
 =?utf-8?B?Ky95cjc1K1NuNjI4Y25PS1llelB0eFlObldBd1BsNS81NGpvTDlXeVRLdVhq?=
 =?utf-8?B?VlUwSXhKbmdVNHJSa3AyTEw3bjRFdGJ4bTVtMER0OUVqVFptcnViNmVpMlRD?=
 =?utf-8?B?VVU4a0FGMjlaQTlqeUdIdVllWHNRWHVlWnhYSG1EOU5wRDdmRndFN0hYTVNE?=
 =?utf-8?B?VGp6VHJJOWIxQkMraUFrdWVXbU1QWEgwYng0MWJHaDNFTytBUXY4OUdtOTIw?=
 =?utf-8?B?L1JET2F4ZkVzeThxN1U0NHlYeUYwSnVZdnFyLzFzazU2dG02eGhSemRhR1VH?=
 =?utf-8?B?M0NOa29IeFRvVmMyYnlRbEFPbXoyR0YvNmpVTm9yc1libGNHR1U5dnlpU1hN?=
 =?utf-8?B?bTZMemUvUXBsZ1NnMEFFRkZlTU9sTlY1L0xReUtoOHV1UHhZcGRzN0ZWQWRD?=
 =?utf-8?B?aFl5L0F0TmsrWXNSWUFkN2RyNWtSUS9NNk45ZWJJM3ZFNzRkY2Z2WXAvUmxO?=
 =?utf-8?B?cEh0Qnk4RHBpVGRSaklLR1pHcVRpQXV1V3haeklWOTBuOHBsWVBHaldNQUhC?=
 =?utf-8?B?RkEyN013bk9jOS90QU8yb2tmMjBldjU3cFBmenUvak5EdlVqS3NqOGVqdkdJ?=
 =?utf-8?B?UVRLeGR2ZWhKaTZyM3JBYWlkc2t3SS9JdTh6ZmNiRW5ieUljVjBXR0w2ZEdt?=
 =?utf-8?B?Yk1QUzA1UW5FcG1jcjEvOGhVMnM3azZtM203SnltVHZKNHRpaStPcDhjS0ZP?=
 =?utf-8?B?b2YybS9NbE1zeWtNTlhXVndJVjJZdkFRVCszZ21Ka0IyWENWM2xqcENFcWN5?=
 =?utf-8?B?cWluOWpRUW0vZloyLzlBa2RaYVAzYyttVWd2QkkxOEVQZDRQczFRUDUzTDBo?=
 =?utf-8?B?WDYzU00ySXpxUEVVMzdxL3E1aFc2cVBBOEdkU3BXb3ZNTE13bVNvMHJTVXQ0?=
 =?utf-8?B?YjNEQVZNZGJhNVFYTkM3b2pGNWw4RUZBUDllRVB3NmRxZ2YvSWpBZlI3SUx0?=
 =?utf-8?B?M01TdEJPZHJQVlQ0c1dKek9pellNWjN0NVVrcjBJTmo1RnQvMjV6SXlqVFEx?=
 =?utf-8?B?d21ta1A5dFJxWlRiN3lBc2s5OXRTMmIrLzMrMFdlOTJXTXJZcmFkL2VBbGpp?=
 =?utf-8?B?ZjBQbWJkRkp1cEw2Q1FVcDRrUXU5aGM3dnJmR2lPc0d5amRmNlczSEdHcEhT?=
 =?utf-8?B?ZnJNczZGcy9EWS94cVFRVHNWc0pMMVRDUEhyYnFJQzVyTG9oT3lPSHRmYjVq?=
 =?utf-8?B?OXBUSkNTTHVPTE1uMlphL2tCdXV4Z3B6ME5MZEJlem9iZnNnQlNCZDVwdEda?=
 =?utf-8?B?RXRPcUt5bGhPLzIwSEN2K1JMZFZPUzJFTWNXTWtQQ3ZOMVpNa1lkNXZZamlE?=
 =?utf-8?B?WVFzL3BNcW1IRGdzV0xSc0xoWU9sR2FZNWlHYnFCQjJSR3RrZEp6ZzZJMS91?=
 =?utf-8?B?dzRSNng1cTVQUVZxbVRpWGR0NzNvVSsvb0ZZUE5ydS9ZNGNVV2RtN3N0bStw?=
 =?utf-8?B?L2hiMWdVK1V1VGQrNHp5aDh5RDJ1bCsybjBwQzluWk8rSXJZU1dNUXZreEIy?=
 =?utf-8?B?OGhucnI1NjVVZENWbWlSc1ZTcVpmNmUyVEo1ZmFiVHlqZlZkNUxPcUhLRXZq?=
 =?utf-8?B?Njlvek9DME10WlNVZjZ2WVRyRE4yeDExSlQrV0ZkeFlmdVJ1WnJKK2JyRnpn?=
 =?utf-8?B?cnoyeVZyZ0dOSjAyUDB0a1E4TTVDdkZHWXlUcEp3RkUrU29ueGQ2aTcrZ2dv?=
 =?utf-8?B?K1hVdXhxYVJTYXFrMmN4bFN5d2taUm9weUVSeGcxcVhnVFNROVhOUnZLb0R2?=
 =?utf-8?B?SFhjMTB1NEwrMytIenVyRWxaR0E0VnBOT2t3Nm14cFpyVnZCcW9ybG9ub0J2?=
 =?utf-8?B?enZsN3pPK3doc1JabzBCOWV1MTB6NkIvYUU4Uy8wK2JRekQ5TmdjbGFNa1I3?=
 =?utf-8?Q?l/HHr9+KtO2aZuo43t+2HE+xY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a560c865-5fc7-446c-e967-08db155cadbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 05:13:19.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9DCQqp02Wyhko2NdnYmj7evYynEUePH1mYo0MByquw3TUcw6nVMeXSax7n8/iWW9hCD76Lr695YlIIYA02Vrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFdlZCwgMjIgRmViIDIwMjMsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+IA0KPiA+
IGNvbW1pdCBlZGM5ZDQxOWVlOGMyMjgyMWZmZDY2NDQ2NmE1Y2YxOTIwOGMzZjAyDQo+ID4gQXV0
aG9yOiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gRGF0ZTogICBXZWQgRmVi
IDE1IDE0OjEwOjM1IDIwMjMgKzA4MDANCj4gPiANCj4gPiAgICBsb2NrdG9ydHVyZTogQWRkIHJh
d19zcGlubG9jayogdG9ydHVyZSB0ZXN0cyBmb3IgUFJFRU1QVF9SVCBrZXJuZWxzDQo+ID4gDQo+
ID4gICAgSW4gUFJFRU1QVF9SVCBrZXJuZWxzLCBib3RoIHNwaW5fbG9jaygpIGFuZCBzcGluX2xv
Y2tfaXJxKCkgYXJlIGNvbnZlcnRlZA0KPiA+ICAgIHRvIHNsZWVwYWJsZSBydF9zcGluX2xvY2so
KS4gIFRoaXMgbWVhbnMgdGhhdCB0aGUgaW50ZXJydXB0IHJlbGF0ZWQgc3VmZml4DQo+ID4gICAg
Zm9yIHNwaW5fbG9jay91bmxvY2soX2lycSwgaXJxc2F2ZS9pcnFyZXN0b3JlKSBkbyBub3QgYWZm
ZWN0IHRoZSBDUFUncw0KPiA+ICAgIGludGVycnVwdCBzdGF0ZS4gVGhpcyBjb21taXQgdGhlcmVm
b3JlIGFkZHMgcmF3IHNwaW4tbG9jayB0b3J0dXJlIHRlc3RzLg0KPiA+ICAgIFRoaXMgaW4gdHVy
biBwZXJtaXRzIHB1cmUgc3BpbiBsb2NrcyB0byBiZSB0ZXN0ZWQgaW4gUFJFRU1QVF9SVCBrZXJu
ZWxzLg0KPiA+IA0KPiA+ICAgIFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGlu
dGVsLmNvbT4NCj4gPiAgICBTaWduZWQtb2ZmLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNr
QGtlcm5lbC5vcmc+DQo+IA0KPiBUaGlzIGlzIGEgbmljZSBhZGRpdGlvbiwgdGhhbmtzLiBKdXN0
IG9uZSBjb21tZW50IGJlbG93Lg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2xvY2tpbmcv
bG9ja3RvcnR1cmUuYyBiL2tlcm5lbC9sb2NraW5nL2xvY2t0b3J0dXJlLmMNCj4gPiBpbmRleCA5
NDI1YWZmMDg5MzY1Li5lZDhlNWJhYWZlNDlmIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9sb2Nr
aW5nL2xvY2t0b3J0dXJlLmMNCj4gPiArKysgYi9rZXJuZWwvbG9ja2luZy9sb2NrdG9ydHVyZS5j
DQo+ID4gQEAgLTI1Nyw2ICsyNTcsNjEgQEAgc3RhdGljIHN0cnVjdCBsb2NrX3RvcnR1cmVfb3Bz
IHNwaW5fbG9ja19pcnFfb3BzID0gew0KPiA+IAkubmFtZQkJPSAic3Bpbl9sb2NrX2lycSINCj4g
PiB9Ow0KPiA+IA0KPiA+ICsjaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4gPiArc3RhdGljIERF
RklORV9SQVdfU1BJTkxPQ0sodG9ydHVyZV9yYXdfc3BpbmxvY2spOw0KPiANCj4gSG93IGFib3V0
IGxlYXZpbmcgcmF3IHNwaW5sb2NrcyByZWdhcmRsZXNzIG9mIHByZWVtcHQtcnQsIGFuZCBpbnN0
ZWFkDQo+IGNoYW5nZSB0aGUgZGVmYXVsdCBsb2NrICh3aGljaCBpcyBzcGluX2xvY2spIGJhc2Vk
IG9uIENPTkZJR19QUkVFTVBUX1JUDQo+IGFuZCB1c2UgdGhlIHJhdyBvbmUgaW4gdGhhdCBjYXNl
Pw0KPg0KPlRoYXQgbWFrZXMgYSBsb3Qgb2Ygc2Vuc2UgdG8gbWUhICBJbiBmYWN0LCBJIHRlc3Rl
ZCB0aGlzIGJ5IGRlbGV0aW5nDQo+dGhvc2UgI2lmZGVmIHN0YXRlbWVudHMuICA7LSkNCj4NCj5a
cWlhbmcsIHdvdWxkIHlvdSBsaWtlIHRvIHRha2UgdGhlIHBhdGNoIGFuZCBtYWtlIHRoYXQgY2hh
bmdlLCB3aXRoDQo+YXR0cmlidXRpb24/DQoNCklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIEkg
c2hvdWxkIHJlbW92ZSAjaWZkZWYgc3RhdGVtZW50cywgcmlnaHQ/DQpJZiB5ZXMsIEkgd2lsbCBj
aGFuZ2UgYW5kIHJlc2VuZCDwn5iKLg0KDQpUaGFua3MgDQpacWlhbmcNCg0KPg0KPgkJCQkJCQlU
aGFueCwgUGF1bA0K
