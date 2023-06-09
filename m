Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C01729373
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjFIIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjFIIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:41:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37312134;
        Fri,  9 Jun 2023 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686300077; x=1717836077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q2CRU2JqGfON8cDYIyAD3A7QAsRvt6fgo1nm7JjI8j8=;
  b=SPaGBTRio39Qh99r6GwjXgr/JK5lSd2EOjdw03nKdHHuJiMnfKtlbRcU
   9jloyskehlBmuFsVWQqSKdjErLD41XLj7TqZap+sKMXvrTNizij8NAULy
   D6y4T8m8UAywj4NXT7ZohmbTQCLyYf6/zIfriusEgBZEGiNX8dWSehTlr
   dh+PctFZW419YPvsOZOUfnv+xnco0G1SqcxtefYB60pAxp4KoYcZ1AqFK
   +LWKsotrT47Y24SUBg8CYJmKAnwi4vauPll0TDlV8ulKlnirsfU8kfB7T
   f6RxnmdBOROenfQD7TAM/75xX0zq8chQmtr2dF6Ot6+N1czXlpKhgmI8X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385906984"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="385906984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="800149421"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="800149421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 01:41:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 01:41:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 01:41:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 01:41:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 01:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrZAQb1F4Dl2uGeLQi1aGav0LblYIRaQ61zvFWHb2Vx1vwpQIVTfknQu4QmHSIjkMmOxWOA4xO9vNBLqx1Izj7nPmLXoHtEXTfcjJq3YesX6T8+xsKFajOPbYrQT49qffMazAIROKdxR+QdSZXrUDOhFQMJa4OcculiQ6vEpVcQ/fbBuzGEO4Eq6R9yHa5qoH0DJi/cx+DrWP9WUW15dnFTUiwA1nP0C8k7B0JZkqDGLiMOGgAm3/30zDUjkz0/xOk908QKtMEIpKbHfFUiMSsANqb/at5/WlOjU8sBnl+jZ/pWRUY8AZD/ZzsFJhsPnllfVqNwz2+za243BP4ijFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2CRU2JqGfON8cDYIyAD3A7QAsRvt6fgo1nm7JjI8j8=;
 b=kkGDhZPMxbOEVOfvQS6RpXvL6mA1qL68XUlLRXleJDGGjLzCW+vZshaE2fpJRT61uQmHLKKQy1YwmycZxXiJ1MRl91b2ALuQoJ15V0luQhHzElWVefwNqtYUs8rCBFav2cJaxFVSntMjVQRrw51mMujUBsQIkWWbjbtN5sgzp4W07O8Pq32+G8uSKazKaPTalvAi3znaXaMrnCe/ZomC5PCP3zoN4dOXFD+Q2q3s84/n5+9F80LPWyq1KUobwgb9mCSDo8mSPZog7xlbhPDvniF3O33jgOQHC8qZtFX6TwucaH3GKKxmxfqp27W2k6Awo3/ffMMIhDswSaiTrzuzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 08:41:09 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 08:41:09 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "masahiroy@kernel.org" <masahiroy@kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [kbuild test robot] random-order parallel building
Thread-Topic: [RFC] [kbuild test robot] random-order parallel building
Thread-Index: AQHZhKDckCf7iah5Kk+VYU3WhlXrya+CUimA
Date:   Fri, 9 Jun 2023 08:41:09 +0000
Message-ID: <7403dd164cff7d9217999cddb66135db47564c4b.camel@intel.com>
References: <CAK7LNATrFbr7kT9HEFgYO6ZstaSx1FB+Q4SQrAX+D8VwG5K0dQ@mail.gmail.com>
         <ZF3mJlMuH2HbNxWp@rli9-mobl>
In-Reply-To: <ZF3mJlMuH2HbNxWp@rli9-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|SN7PR11MB8281:EE_
x-ms-office365-filtering-correlation-id: 88c46a0d-fb88-43ec-e6e7-08db68c545c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+6RW2Fwx5mrXDn2+gM7otZLfBikoTHm6jAsv7hdHaKMIBjH7jbRSfnFDM14bBPHhE8jr2e9bNUyVVLZtZ+mpd6ATqbHA1f5k9risRK+8i1UpaEGhs0xr6lnZlHKyZtwuiJVBU69wIXKfMFM+MZ/J/MGiRFv72Mr4ly4gZutRbXuQqVDL4N/4LwYDa+emjqEB1ZLpRj0PBAVqHDhkD6TU6U2JdLv8GqzWXSUK7Zg84i/noXq8DwTYOW0n6k7f1lbBltHfvSHyXBUtwBEgm16+XCDXpzI+fTURikU+SgVfa7tkJ9EoHJPlNvHPY7mVU2WKP+Z5Tkcl0H8YbuhYGE/H0kqiRySUwrB0n+dfmPQSkWiVPvwS19Hlb7DGxxtD12Li37rhljTPhTrwvPK0s5FffLOCrc+zP32Z0L9pMSKys5rOYwHklhDG2k86lwBbPxxlNaAM7P+DD4XV46p5mD2giGyQjcbjwcYdrwT6skS4ZE/B4GDTHkSYoqsBY8GRRT3GPd2KARivzSWsckjSZn+t8CLiNaGtfFw4Xq3SezVsDFQRHyAKcTc6xHn7nJ830gCNoaSG4zvq8ORGiMxH1LUDGQWYuDUf6UkFNYqsRKf3rk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(38070700005)(54906003)(8936002)(8676002)(966005)(478600001)(5660300002)(316002)(41300700001)(6486002)(26005)(6916009)(186003)(4326008)(66476007)(76116006)(91956017)(66556008)(66946007)(71200400001)(64756008)(66446008)(6506007)(6512007)(83380400001)(2616005)(2906002)(38100700002)(82960400001)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2VXd0dralRVZ2wxOWhHdG9DRDhNbEpUeUlxa2FVOVdWYWFranFUYkxwVHNV?=
 =?utf-8?B?dlh5NHZaMjZFMXE4bnFOYWNZanVwWU9VdjZBcEZHVC9vR3djUXRwVFlBRjVR?=
 =?utf-8?B?MkwzZzduSW56MjVDM1NDVTZMZk9tSHdhaGc2MWg3U2hFQVpFSUEzdU9FenZv?=
 =?utf-8?B?VWdWWDVPMjAycDEyTUppdGN5bFBmVlpIWWVGaVowNDRGRUI2OU9XMnhjNHBr?=
 =?utf-8?B?cUxSUy80QXNwVjFuSXVaM1hzVnZOSFNvdTNpYWJWYTRuWHdFaHQ4VHBrVldr?=
 =?utf-8?B?WkxxZHJFWlRWRDllcm9sRE9ISTlOOVRueGIva05xZVFGZ0t3RFBNTzArSFNX?=
 =?utf-8?B?elczdENUMHlXWEpkaHpoMTc5Y0V5ZXVlTVFFbExqNCtkckxzOXJjUlBLUmtD?=
 =?utf-8?B?OGJtaG5meEpXclhjWS9BY2xKaUxPYkFmSVJ0STNXbUk2MUZjdDVpQTJ2NGFQ?=
 =?utf-8?B?RDY1L3kvd2J2cVFmWEZtTnBjQSt2WjBDL09qZzZmeHJkYjFWdWFWaWo0R1Az?=
 =?utf-8?B?bXNNSmRIQ3c3WC82SFRoWnRqMndCek4yVmZqbDFYVHE4TDdoemt2YkRia012?=
 =?utf-8?B?VDdhSkk0RzNtNFJaSW84NjFrSGxDQkJMcUJ1dThQeVNxd3ZNaW04VmR6SjFr?=
 =?utf-8?B?MU1JamFja3N1VS9ERE9WWC9SQkMzajFSb1NXakZpY0hDZ3lEVit2ampzNy9O?=
 =?utf-8?B?REdZbitWZHNkQ1FtWE1VY0FBMTZPaExIV2RveHZEMG15Mm0vY2M1dW05Z0Rs?=
 =?utf-8?B?RGUzVFRtT1RIOHBMZzV5eWduOWhjS1B3RUVlcFdQTTFPNWhsb3AzMmRMMU1H?=
 =?utf-8?B?ZUtNam1vbzBjTlhWOHNZTXB6OUxHOUh3ak0yOFV4Y05vUjZQRlUyeXdjRzll?=
 =?utf-8?B?T0RtblM1UlV6emJzQnlveElsckFjZFJ2UTlRdlAvMjJ2V1duaGUyZlJGZFMw?=
 =?utf-8?B?MnVOVW14RGRhS05rb3AvUWJYVzZzZzBhVE0wYm5jeGVUMmJ3M2IwZHJzdEZk?=
 =?utf-8?B?SWNCZy9TU280ZUh4bnhFWTZqTnRNZ0tDSEw2RTBpMisrQnBuanpVc3NtQWxE?=
 =?utf-8?B?WUFLczc1bXltTDloYWRrWWlLZ1BuN1BjTXB6bmU2ZUxRbTZNTWF0QVYrcDhP?=
 =?utf-8?B?Kzg1dDVDMHk1NTBxc3I3SmRJTnFSZW1SblBpUGllVXhGRElvbmI1ZElmYXNi?=
 =?utf-8?B?U0o3S0drTTdTZWtEeUlSb0pmTUVjcWEwQlhNMkRjbHVrN3NoY1VFckp6TXdr?=
 =?utf-8?B?K2V6UjJpWFhVL1FTT1p3M0xjLzFLa2liQWFTSWx3aG0rOW9mcFRmUVpVaVd6?=
 =?utf-8?B?TlVoY1I2L1h1UmN1ZXJIS0d3emwyVElNZk1UY0FLZU4zVElzOGNTRWl0b2NW?=
 =?utf-8?B?cFVOWW5MK1FkWFZLUFB3RlRSRXBPc1VnUlFwaklpQjhWcUxhb1lHbUlWTXhO?=
 =?utf-8?B?eXRvZ2x2aDN0dm5jVTZVTHRseHEyS2NJbjRyQXoxTmZGMm5md3RPSENLRXRs?=
 =?utf-8?B?dlgzNjBRR3pUMCtQYXVSVnBJM1Q0R3dDS3RSZG55ZDIxZTlDV0F2dzBLU2lV?=
 =?utf-8?B?U2YvY1JBd3h4WlBIUno1MW1HNTZGVEhUZGFob2F2cVJoaDFmRTFoUWZGemtI?=
 =?utf-8?B?NnlCZ3dBOXdQNnl3Vit2ckY0ZzNjNytsVWNjTVIyOTBoWFFFc3dPMDJ3V3J6?=
 =?utf-8?B?UEhKUi9HeVIvVVBkalRuODRlYjNObXN1RlRwTVVDL3ZJeXRYaUwxVzJ1MURo?=
 =?utf-8?B?OXdLMHJhZ2xnUms3dDVGalppNlNJS3lRTWNMenFkWjNQYmRmeWdVOFprUTll?=
 =?utf-8?B?d0JmWWM3dy8yYlRLYVZLbVVKc01kbHZ2dlBkRTYwVVdtbUh0UGxSQkdDR0l5?=
 =?utf-8?B?U2VtT0Y5WTNFNWlLakhzSml0Q1pFSmp1SGNQWlBWd3prTkxnS1I3elBwWHhO?=
 =?utf-8?B?YmV3OTVNanp2ZWdnMzBvbFBUQkt6TTJueHl1TmJGYzhFU3VEU29wMHhid1FH?=
 =?utf-8?B?VjU0d3ZWQm0wYThvSURMYWxOSktVSjhzdHE3WCtVSnVnZGFTQy9vZ0grVndO?=
 =?utf-8?B?T3V4VmIra2dFczlxcTRub0I1TEVJZTM1V21xRW9iWWxNZTd4cG40eU5Ka1BZ?=
 =?utf-8?B?Q0R5Tm9uVXprSTNMRHd0Ui9zNzNjakFrclBjVStpdkRZM1dsamhmRnBmdFlE?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BB246BE778712469FEAF177653C186F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c46a0d-fb88-43ec-e6e7-08db68c545c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 08:41:09.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/f0QSyTmJqv6N27zpS7rP4zzvCV/Ag7/x0c7fVLLB6lQt6WeDwfKImuKrMge8TVXPQRWAxOJZx9bMXr+kc7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
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

SGkgTWFzYWhpcm8sDQoNCk9uIEZyaSwgMjAyMy0wNS0xMiBhdCAxNTowOSArMDgwMCwgUGhpbGlw
IExpIHdyb3RlOg0KPiBPbiBGcmksIE1heSAxMiwgMjAyMyBhdCAxMjoyNToxM1BNICswOTAwLCBN
YXNhaGlybyBZYW1hZGEgd3JvdGU6DQo+ID4gSGVsbG8sIG1haW50YWluZXJzIG9mIHRoZSBrYnVp
bGQgdGVzdCByb2JvdC4NCj4gPiANCj4gPiBJIGhhdmUgYSBwcm9wb3NhbCBmb3IgdGhlIDBkYXkg
dGVzdHMuDQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIHRoZSBwcm9wb3NhbCBmb3IgdGhlIHNodWZm
bGUgbWFrZSwgd2Ugd2lsbCBkbyBzb21lDQo+IGludmVzdGlnYXRpb24gdG8gdHJ5IHRoaXMgcmFu
ZG9tIG9yZGVyIHBhcmFsbGVsIGJ1aWxkLiBUaGUgZ251IG1ha2UNCj4gd2UgY3VycmVudGx5IHVz
ZSBpcyA0LjMsIHdlIHdpbGwgdHJ5IHRoZSA0LjQgdG8gc2VlIGFueSBwcm9ibGVtLg0KPiANCj4g
Rm9yIHRoZSB0aW1lbGluZSwgd2UgbWF5IHByb3ZpZGUgdXBkYXRlIGxhdGVyIHRoaXMgbW9udGgu
DQoNCldlJ3ZlIHVwZ3JhZGVkIHRvIG1ha2UgdjQuNC4xIGluIGtlcm5lbCB0ZXN0IHJvYm90IGFu
ZCBlbmFibGVkIHJhbmRvbS0NCm9yZGVyIHBhcmFsbGVsIGNvbXBpbGluZyBpbiBvdXIgcmFuZGNv
bmZpZyBidWlsZCB0ZXN0cy4gVGhlIHNodWZmbGUNCnNlZWQgaXMgZ2VuZXJhdGVkIGJ5IGhhc2hp
bmcgdGhlIHJhbmRjb25maWcsIHNvIGl0IGNoYW5nZXMgb3ZlcnRpbWUgYW5kDQpjYW4gY292ZXIg
dmFyaW91cyByYW5kb20gb3JkZXJzLiBXZSBhcmUgc3RpbGwgZG9pbmcgc29tZSBpbnRlcm5hbA0K
dGVzdGluZyBhbmQgd2lsbCBwdXQgaXQgb25saW5lIG9uY2UgZXZlcnl0aGluZyBpcyBkb25lLg0K
DQo+ID4gDQo+ID4gDQo+ID4gR05VIE1ha2UgdHJhZGl0aW9uYWxseSBwcm9jZXNzZXMgdGhlIGRl
cGVuZGVuY3kgZnJvbSBsZWZ0IHRvIHJpZ2h0Lg0KPiA+IA0KPiA+IEZvciBleGFtcGxlLCBpZiB5
b3UgaGF2ZSBkZXBlbmRlbmN5IGxpa2UgdGhpczoNCj4gPiANCj4gPiDCoMKgwqDCoCBhbGw6IGZv
byBiYXIgYmF6DQo+ID4gDQo+ID4gR05VIE1ha2UgYnVpbGRzIGZvbywgYmFyLCBiYXosIGluIHRo
aXMgb3JkZXIuDQo+ID4gDQo+ID4gDQo+ID4gU29tZSBwcm9qZWN0cyB0aGF0IGFyZSBub3QgY2Fw
YWJsZSBvZiBwYXJhbGxlbCBidWlsZHMNCj4gPiByZWx5IG9uIHRoYXQgYmVoYXZpb3IgaW1wbGlj
aXRseS4NCj4gPiANCj4gPiBLYnVpbGQsIGhvd2V2ZXIsIGlzIGludGVuZGVkIHRvIHdvcmsgd2Vs
bCBpbiBwYXJhbGxlbC4NCj4gPiAoQXMgdGhlIG1haW50YWluZXIsIEkgcmVhbGx5IGNhcmUgYWJv
dXQgaXQuKQ0KPiA+IA0KPiA+IA0KPiA+IEZyb20gdGltZSB0byB0aW1lLCBwZW9wbGUgYWRkICJq
dXN0IHdvcmtlZCBmb3IgbWUiIGNvZGUsDQo+ID4gYnV0IGFwcGFyZW50bHkgdGhhdCBsYWNrcyBw
cm9wZXIgZGVwZW5kZW5jeS4NCj4gPiBTb21ldGltZXMgaXQgcmVxdWlyZXMgYW4gZXhwZW5zaXZl
IENQVSB0byByZXByb2R1Y2UNCj4gPiBwYXJhbGxlbCBidWlsZCBpc3N1ZXMuDQo+ID4gDQo+ID4g
DQo+ID4gRm9yIGV4YW1wbGUsIHNlZSB0aGlzIHJlcG9ydCwNCj4gPiDCoCBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxNi8xMS8zMC81ODcNCj4gPiANCj4gPiBUaGUgcmVwb3J0IHNheXMgJ21ha2Ug
LWoxMTInIHJlcHJvZHVjZXMgdGhlIGJyb2tlbiBwYXJhbGxlbCBidWlsZC4NCj4gPiBNb3N0IHBl
b3BsZSBkbyBub3QgaGF2ZSBzdWNoIGEgYnVpbGQgbWFjaGluZSB0aGF0IGNvbWVzIHdpdGggMTEy
DQo+ID4gY29yZXMuDQo+ID4gSXQgaXMgZGlmZmljdWx0IHRvIHJlcHJvZHVjZSBpdCAob3IgZXZl
biBub3RpY2UgaXQpLg0KPiA+IA0KPiA+IChTb21lIHRpbWUgbGF0ZXIsIGl0IHdhcyByb290LWNh
dXNlZCBieSAwN2E0MjJiYjIxM2EpDQoNClRoYW5rcyBhIGxvdCBmb3Igc2hhcmluZyB0aGlzIGNh
c2UuIFdlIHRyaWVkIHRvIHJlcHJvZHVjZSBpdCwgYnV0IGxvb2tzDQppdCBkYXRlcyBiYWNrIHRv
IHY0LjktcmM3IGFuZCB0aHJvd3Mgc29tZSBvdGhlciBlcnJvcnMgd2hlbiBjb21waWxpbmcNCmlu
IG91ciBrYnVpbGQgZW52LCBzbyB3ZSBhcmUgbm90IGFibGUgdG8gcmVwcm9kdWNlIGl0IHlldC4g
Tm90IHN1cmUgaWYNCml0IGlzIHJlbGF0ZWQgd2l0aCB0b29sY2hhaW4vY29tcGlsZXIgdmVyc2lv
biBvciB0aGUga2VybmVsIGNvbmZpZy4NCg0KVGhpcyBjYXNlIG1lbnRpb25lZCB0aGF0ICdtYWtl
IC1qMTEyJyBjYW4gcmVwcm9kdWNlIHRoZSBicmVha2FnZS4gV2UNCmFzc3VtZSB0aGlzIGlzIHVu
ZGVyIHRyYWRpdGlvbmFsIHNlcmlhbCBvcmRlciBidWlsZC4gRG9lcyBpdCBpbXBseSB0aGF0DQpp
dCBpcyBsaWtlbHkgdG8gdGFrZSBtdWNoIGxlc3MgcGFyYWxsZWwgam9icyB0byByZXByb2R1Y2Ug
dGhlIGJyZWFrYWdlDQp3aGVuIHNodWZmbGUgaXMgc2V0LCBzYXkgJ21ha2UgLS1zaHVmZmxlPVNF
RUQgLWozMicsIHNvIGRldmVsb3BlcnMgYXJlDQphYmxlIHRvIHJlcHJvZHVjZSBpdCBvbiBhbiBv
cmRpbmFyeSBDUFUgd2l0aCBsZXNzIGNvcmVzPw0KDQpOb3Qgc3VyZSBpZiB0aGVyZSBhcmUgb3Ro
ZXIga25vd24gY2FzZXMgb2YgcGFyYWxsZWwgYnVpbGQgYnJlYWthZ2UNCihlc3BlY2lhbGx5IGlu
IHJlY2VudCBrZXJuZWxzKS4gSWYgYW55LCBpdCB3b3VsZCBiZSB2ZXJ5IGtpbmQgaWYgeW91DQpj
b3VsZCBhbHNvIHNoYXJlIHRoZW0uIFdlIGNhbiBmaXJzdCB0cnkgcmVwcm9kdWNpbmcgdGhlbSBp
biB0aGUgYm90IHRvDQpjb25maXJtIG91ciB0ZXN0IGZsb3cgd29ya3Mgd2VsbC4NCg0KQW5vdGhl
ciBxdWVzdGlvbiBpcyBhYm91dCBiaXNlY3Rpb24uIFNheSB0aGUgYm90IGNhdGNoZXMgYSBicmVh
a2FnZSBvbg0KY29tbWl0MSB3aGljaCByb290LWNhdXNlZCB0byBhIHByZXZpb3VzIGNvbW1pdDIu
IElmIHdlIGtlZXAgdGhlIG9wdGlvbnMNCiItLXNodWZmbGU9PHNlZWQ+IC1qPGpvYnM+IiBjb25z
aXN0ZW50IGR1cmluZyB0aGUgd2hvbGUgcHJvY2VzcyBvZg0KYmlzZWN0aW9uLCB3aWxsIHRoZSBi
cmVha2FnZSAxMDAlIHNob3cgdXAgb24gYWxsIHRoZSBjb21taXRzIGJldHdlZW4NCmNvbW1pdDIg
YW5kIGNvbW1pdDEsIG9yIGl0IGlzIGtpbmQgb2YgcG9zc2libGUgdG8gcmVwcm9kdWNlIHRoZQ0K
YnJlYWthZ2UsIGJ1dCBub3QgMTAwJSByZXByb2R1Y2libGUgb24gZXZlcnkgY29tbWl0IGR1cmlu
ZyBiaXNlY3Rpb24/DQoNClRoYW5rcyBhIGxvdCBmb3IgdGhpcyBwYXJhbGxlbCBidWlsZGluZyBw
cm9wb3NhbCwgYW5kIHdlIHdpbGwga2VlcA0KdXBkYXRpbmcgdGhlIHN0YXR1cy4NCg0KLS0NCkJl
c3QgUmVnYXJkcywNCll1amllIExpdQ0KDQo+ID4gDQo+ID4gDQo+ID4gR05VIE1ha2UgNC40IGdv
dCB0aGlzIG9wdGlvbi4NCj4gPiANCj4gPiDCoCAtLXNodWZmbGVbPXtTRUVEfHJhbmRvbXxyZXZl
cnNlfG5vbmV9XQ0KPiA+IMKgwqDCoMKgwqDCoCBQZXJmb3JtIHNodWZmbGUgb2YgcHJlcmVxdWlz
aXRlcyBhbmQgZ29hbHMuDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gJ21ha2UgLS1zaHVmZmxlPXJl
dmVyc2UnIHdpbGwgYnVpbGQgaW4gcmV2ZXJzZSBvcmRlci4NCj4gPiBJbiB0aGUgZXhhbXBsZSBh
Ym92ZSwgYmF6LCBiYXIsIGZvby4NCj4gPiANCj4gPiAnbWFrZSAtLXNodWZmbGUnIHdpbGwgcmFu
ZG9taXplIHRoZSBidWlsZCBvcmRlci4NCj4gPiANCj4gPiANCj4gPiBJZiB0aGVyZSBleGlzdHMg
YSBtaXNzaW5nIGRlcGVuZGVuY3kgYW1vbmcgZm9vLCBiYXIsIGJheiwNCj4gPiBpdCB3aWxsIGZh
aWwgdG8gYnVpbGQuDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gV2UgYWxyZWFkeSBwZXJmb3JtIHRo
ZSByYW5kY29uZmlnIGRhaWx5IGJhc2lzLg0KPiA+IFNvLCByYW5kb20tb3JkZXIgcGFyYWxsZWwg
YnVpbGRpbmcgaXMgYSBzaW1pbGFyIGlkZWEuDQo+ID4gDQo+ID4gUGVyaGFwcywgaXQgbWFrZXMg
c2Vuc2UgdG8gYWRkIHRoZSAiLS1zaHVmZmxlPVNFRUQiIG9wdGlvbg0KPiA+IGJ1dCBpdCByZXF1
aXJlcyBHTlUgTWFrZSA0LjQuwqAgKG9yIEdOVSBNYWtlIDQuNC4xKQ0KPiA+IElzIHRoaXMgdG9v
IG5ldz8NCj4gDQo+IE91ciBwcm9kdWN0aW9uIGVudmlyb25tZW50IGlzIDQuMyByaWdodCBub3cu
IEl0IHdpbGwgdGFrZSBleHRyYQ0KPiB0aW1lIGZvciB1cyB0byB1cGdyYWRlIHRoZSBlbnZpcm9u
bWVudCBidXQgaXQncyBkb2FibGUgZm9yIHVzLg0KPiANCj4gPiANCj4gPiANCj4gPiANCj4gPiAt
LQ0KPiA+IEJlc3QgUmVnYXJkcw0KPiA+IE1hc2FoaXJvIFlhbWFkYQ0KPiANCg0K
