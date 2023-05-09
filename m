Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E436FD30A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEIXfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIXfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:35:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9924230
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683675322; x=1715211322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+uOYYqPM2In9kxUpr9CwidB7vS8YHTVrB9ObRQ04XH0=;
  b=T6u4fePvl1Nmj+iRvUMK8x85259ZyKxpsX5TCJbOYG9NDZSN5KbsiF8T
   f7kNpr4Aq+n6ZurKifZ7VE2fdTvHSZmybxazZ54FrWKGhrNFV8zntFi5V
   dYurmMhT0Nz/fHEnY8B70hNYVI3SRongRahgIiwnjkJwhmCv9OeUENAkU
   m3Oaw0iaP1wTSzoP7pBICfXGTIQGglEGCwlWMKTifslIepYCHEIINh8l2
   IdxR/lfAorFG/7o+1/1Zy0L1KNA3UpQbC7Y6kLx5eqan81gs4+/fqRzm0
   5rko/MCk64sG0chPD0FWvu7aBtXukT0M/2lx/b6yFezMvyi5TsedwNb7S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="330447834"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="330447834"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 16:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="788710858"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="788710858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2023 16:35:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 16:35:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 16:35:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 16:35:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 16:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFo7nNozyHb6SVcuda4qcfaXOyIJNRoSo6Kvqu1WbBzWba+d4ZbHjQso6f6gy5bBjHzsISXf+VGOZaDWd2fQizkG3q9o3hAcoz3g4YBCRRIp0eoUe04i4p7ylJkgrQ3PcKGf2kqH9ORbmNzYbItIClLypEQJdPvTljRLwbaW/SlLt2XgisUeLqaB+avRIh1gSWYykSh4WjEKap+eyyiOjPvi64MATP1nmCBVo+6JGYSB414vCfiEV5RRSz3gLCq2z4gQ7Qxc1uqKts0S2O3g5900jdS5ajUYp/wPUxV8G2ZLT3vZL9866sZuIbWQyoMQGrOL6AKXm+BT75Zt/sV2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uOYYqPM2In9kxUpr9CwidB7vS8YHTVrB9ObRQ04XH0=;
 b=k9bA6poJAzq8WC2ZBwUMz3O78xut2wlabUNgikWue4Ag9mZFIkGRBlTeCl24IQnORGDqA1SxDtEvaNb52mfzRC1rMLqoeLXqhVTXWKdMXVFNSYngao+v3oS3qOC11vXB46rjXPgwvdADmDvSBZeABg/Dn+Ed4qpA5B+8Oh7zTN6gETY5Hhe0wL9pg5Zuo800oFy49GkxOq4eof3n1TVaJoNBBEkcoA0W7pfzQDz7kDHydRxs/R7lWITAuBFC2d1n1iKsWH4uwzoQu4Xdn8u7DVCMckNpA3T09S6iJ51pA+rRCk+0IIrM+CQzXy6AUpsk1XlV2O8IR+d8Dji0Ge/rGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:35:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 23:35:17 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Topic: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Index: AQHZc9RpUDnrLIcguE2hFRoOJfWMkK9MZ88AgARWAUCAAdZ8gIAABlIA
Date:   Tue, 9 May 2023 23:35:17 +0000
Message-ID: <SJ1PR11MB6083CFFA8CBDD296E966EC85FC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
 <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <237603b3-f553-2ede-5725-239b65626c69@intel.com>
In-Reply-To: <237603b3-f553-2ede-5725-239b65626c69@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7935:EE_
x-ms-office365-filtering-correlation-id: c8fb5069-e3f9-45ba-f0cc-08db50e60bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2A2lVlUHHF+n1xn56bfcpcPFjg52l+cQEry+Y157u2sVBM7rsN22tM17tGFZajluZCLAr8akGVsi2xCOrdHW2tBVUqCyD5cSR9Ybq34fHnqP1x4hV+c5NiRYRr9E7Dts/C8rkr+YB9LEU9W6hbzkeq8LUKmyE45E5vlK/mfTbXX1/6v9DcllBiux5fw1JEN9Lmztf1+zcRoO9RZv3qKYpRLsf4eJAeSQGE2x08ta2A/vl9yjsgwVaOskc33hvYU8YyRcIx8jE6PIq2CUbvKtD5B/fyk0NyHknGQ1OlOIlBZclAiSYpbWwp8tVgibI130UQxDleZtgSkJ1tAa03HpurRMY8qBJPaRvKMhdD+0o16inoeaG9tmrpEi2fmYa8pAQq0AVt0Odd51gRePFXM2+Us3RFxCjpJBAvrFNLNdoL06EeDJR+liTr2xNmvNYndYfzvbPPuDsi69XqpH9Gm5ghf/FfKwaI78jQ3iBh9nZOuuXIWTV73Fm2YvpRxw8+6ZAFvlEbW3JkDkeUo83u0IdXOMHZlr9vmAEohGBHsH27VoGx0Vr+x2X4d8XxGQL2Mj7P3dZetQrUrBZcJE4pEGiigAv3KaDtnM8yz3WStaWBkjDDwOpXRFi2satqKriPhFijFYdC0jRteHEv3drQykMgSyCEpS66wI1g/e/O54QVYDHXhEI5xewHEIfqIYjpn2gEdKpMcs2noVAydbd/q/6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(966005)(64756008)(478600001)(66556008)(4326008)(76116006)(7696005)(110136005)(66946007)(66476007)(54906003)(316002)(66446008)(86362001)(33656002)(83380400001)(26005)(9686003)(6506007)(8676002)(8936002)(52536014)(7416002)(41300700001)(2906002)(55016003)(5660300002)(38070700005)(921005)(38100700002)(122000001)(186003)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxPRkZhaWZVRTVocTE1RVZYRzVqdUVudTZ3ekhuZkgxMTBkUEhoVnBYRWd1?=
 =?utf-8?B?UXNHSVMrelF0QU5uKzdnYlJzb0FEY3VXYUJ2MWJkOHhIRzhWZk1JSDlkR0Js?=
 =?utf-8?B?bkx6ek5aQ3lNaGhnZkJiUHJXd1Z0c2E5NDRzMGZnMXliWEwwcnN1U29CLy9V?=
 =?utf-8?B?TllPWEZRWmRCMmhMVTFYRW44aGx0blQrK1BMNWZBUlhGMjR5QStuUytITE53?=
 =?utf-8?B?ZWxMUkJVbDN2a3JRTU1jRjYxYzduZENXRk9nNmg4andMbXFPcFp0RE1TVzhi?=
 =?utf-8?B?bmp1aGRsdFRkaVNWZVJzV3dNRlMvaW1MYVpZbnJ3RUkrMTBPVUpqUDdpRE1l?=
 =?utf-8?B?aGZoSFVFd0k3dDVrY0tRdnhMOFAzdUE1bEI4Y2JFdmpLcDdDVG9OZU1wR29l?=
 =?utf-8?B?S3N2Yy9CWXRoU09aRkZ1T0FIKzQxZ2NDUHBBcmt6cmpFcTNxeDZWdFdXNDI3?=
 =?utf-8?B?dWlzeDFGQk9DYjhlZWFIS25IOVRXT0ZRSmR4R3dYRDN5aUxhM3JTbEpIR1ZO?=
 =?utf-8?B?RlBqWEJiaUJqMEc3VnloSWpoekFDQWJUZ0JMdG83UUgzUGtCd2FtTHAzejRl?=
 =?utf-8?B?U1pYbERBL2h0OXZNdVU3ZndKT1B4ZGFRRy9teEZxQnYzenB4d0ZzaFRJREVB?=
 =?utf-8?B?cTZQL3ZyWWZJUmdxRWVhNzBGMWtQVUZhZDFqU2Y4NnJ4dDlRMTg5ZFpiaWps?=
 =?utf-8?B?d3hOUUZocUhSWjJkVkc3VjBjSlpXQ0ZXTnpIL2NLRkxHaTFJbFBFZ0NpSWFm?=
 =?utf-8?B?WDJJV0Z1bjRsK3FZTVZWaG5za0pDV3JrTlc5SGVlQThjWlBzQ3l3aHgzQXZT?=
 =?utf-8?B?THVIQWtHbUxwaVRrTktKTFRYYkcvaVNCWFUwdjJESzB4MkJYQTFtL1dRWjBD?=
 =?utf-8?B?eW95K0d6Nm9WNnRtZ2R6WDkrY3I2V3NlV2grV05lc2JOU1ZkZHEvYXo2dTVK?=
 =?utf-8?B?bS82YnN2QXBWUENWcWhKQnFqK2c0N0NkVTlIcFIrNzdVK0NDM1hOVmc0RExz?=
 =?utf-8?B?WlpVMlpJR3ZaVkc3cTdMcmdlZ2hjNEVzRW5abkZLSlBuWFJLWnJwM1NZem9M?=
 =?utf-8?B?V0ZPWlNVdXhoWnJkNVdVcW5TamRxL3R5TUpiN3lJK2F5Zjk3NTZ6MjF3dlBI?=
 =?utf-8?B?ZXdzcmNZcm8rYVN0NXpiRmVSTVcxNE05UmdxYlZuQWVyUkswbVZoR05raFZr?=
 =?utf-8?B?S0ZPMnYzRFBkOU5uRnA1SzdUSVRrNVVsMFl5cGhBV0pvREZESk1BRmdFa3V4?=
 =?utf-8?B?dzJRUnJuSUppc3VrYW5wd2JVUU1weUxLa1BMVkNHV2FkQm8xZDdjWTkwK21k?=
 =?utf-8?B?djFpWGcxWnF4aUZYM1RnNWJCS1BxZ3V3b2IzMGNoVmtZK3pmV0V2bFF3dFNt?=
 =?utf-8?B?c2dJdDhKK2VLR291Ni9pajg0YjJTaXZuYUxFTzBPa0lsVFl5MHBOWDVGOG5x?=
 =?utf-8?B?SVQ5bHQxLzVlakplWFU1T25tWnBVTVJIeldpSzhSSlhOY2Iyc29pZzZIdSt1?=
 =?utf-8?B?ZndLcEZTcmEyK1dQR1FOYVg1SXdQNW5ORWhtbXgvYXA1b3FpclVPRnMzYWhy?=
 =?utf-8?B?RDJmMmE0OVMwdktKWVRST3hTNiszS1NIbjRkSWMvcm52VGRsbE8vTTNjMGdn?=
 =?utf-8?B?T3RBQnJheDZMdnlDOGt6aXBiTGYwL0lycko1QkExNE9KM2FFRFVlVGR2ZXpS?=
 =?utf-8?B?RUJEV1dpZi9OT1VmZzkrSE1hOXI5UTRuS1BXcDhQNVFuV2hGVkxEb2I2Z0Y1?=
 =?utf-8?B?Y2ZYMEtHVzF6ajFUNVMydG1NcWk4bHZGakVzblVrSmUzSEhHVGhSamNjb2xG?=
 =?utf-8?B?QXEvWEdIR0ZaNXYwOUp4NnY2RmRQa04wWThCcWlWeWJIcDZFdEpFSERFd2hN?=
 =?utf-8?B?aEwxd3MrM1BZbDVXSTg1bUpTRkFhUzBuYVU4b1VxMnRFWUR1bGo3Qm5PSlFW?=
 =?utf-8?B?MG9CcUswdkRmaHQ1WTFsdmVvRzlCa2ZJWlhHS29ucklFbGRiY1pCMEdsMFRS?=
 =?utf-8?B?ZmtWeWd1VDdqNTJQMkZsQ2hwQmtHYkhRN0wrZlh1OHdqRHpyZUlkb3gzNlBn?=
 =?utf-8?B?cm1tOGI3bEFTUXpRQVVMR2ZZZnBCZXI1OWl3VTllQnRRQ210WjNCVkd4bkZU?=
 =?utf-8?Q?JAgM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb5069-e3f9-45ba-f0cc-08db50e60bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 23:35:17.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEbhSEsP2qduNrzPO1bcJmH8Ly4UbYN7dXEney/1TnV9ESgCj6wXqLgyHV12StdzgUfxAJ/jjtx/fqYtvPergA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gSW50ZWwgaGFzIGFsd2F5cyBoYWQgc29tZSBtb2RlbCBzcGVjaWZpYyAiUkRUIiBmZWF0dXJl
cyB0aGF0IHdlIGhhdmUNCj4+IG5vdCBhdHRlbXB0ZWQgdG8gcHVzaCB0byB1cHN0cmVhbS4gUmF0
aW9uYWxlIGlzIHRoYXQgYXJjaGl0ZWN0dXJhbCBmZWF0dXJlcw0KPj4gaGF2ZSBsYXN0aW5nIHZh
bHVlIGFjcm9zcyBDUFUgZ2VuZXJhdGlvbnMuIE9uY2UgdGhlIGNvZGUgaXMgdXBzdHJlYW0gaXQN
Cj4+ICJqdXN0IHdvcmtzIiAoVE0pIGZvciBhbGwgdGltZS4gQ2x1dHRlcmluZyB1cCBjb3JlIGNv
ZGUgd2l0aCBmZWF0dXJlcyB0aGF0IGFyZQ0KPj4gb25seSBhcHBsaWNhYmxlIHRvIG9uZSBvciB0
d28gQ1BVIGdlbmVyYXRpb25zIHNlZW1lZCBsaWtlIGEgcmVjaXBlIGZvcg0KPj4gZGlzYXN0ZXIg
ZnJvbSBhIGxvbmctdGVybSBtYWludGVuYW5jZSBwZXJzcGVjdGl2ZS4NCj4NCj4gQ291bGQgeW91
IHBsZWFzZSBlbGFib3JhdGUgaG93IHRoaXMgc2VlbXMgbGlrZSBhICJyZWNpcGUgZm9yIGRpc2Fz
dGVyIj8gSQ0KPiBjYW4gY2VydGFpbmx5IHNlZSBob3cgcmVtb3ZpbmcgYSBkcml2ZXIgaXMgZWFz
eSB3aGVuIGl0IGlzIGRlY2lkZWQgdGhhdA0KPiBzb21ldGhpbmcgaXMgImVuZCBvZiBsaWZlIi4g
SSByYXJlbHkgc2VlICJlbmQgb2YgbGlmZSIgaW4gcHJhY3RpY2UNCj4gdGhvdWdoIGFuZCB2aWV3
aW5nIHJlbW92YWwgb2Ygb2Jzb2xldGUgY29kZSBmcm9tIGEgZHJpdmVyIGFzIGEgImRpc2FzdGVy
Ig0KPiBpcyBub3QgY2xlYXIgdG8gbWUuIFJlLWZhY3RvcmluZyBjb2RlIG9jY3VycyBmcmVxdWVu
dGx5Lg0KDQpJJ20gdGhpbmtpbmcgb2YgdGhlIGFtb3VudCBvZiBjb2RlIHVuZGVyIGFyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC4gSW4NCnY2LjQtcmMxIGl0IGxvb2tzIGxpa2U6DQoNCiQgd2Mg
LWwgJHJlc2N0cmwvKi5bY2hdDQogICA5OTYgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2Nv
cmUuYw0KICAgNTgxIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jdHJsbW9uZGF0YS5jDQog
ICA1NjAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCiAgIDg0NSBhcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQogIDE2MDAgYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL3BzZXVkb19sb2NrLmMNCiAgICA0MyBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvcHNldWRvX2xvY2tfZXZlbnQuaA0KICAzNzMzIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVz
Y3RybC9yZHRncm91cC5jDQogIDgzNTggdG90YWwNCg0KRmVuZ2h1YSBkaWQgYSBidWlsdC1pbiBp
bXBsZW1lbnRhdGlvbiBmb3Igb25lIG9mIHRoZSBmZWF0dXJlcyB0aGF0IEknZA0KbGlrZSB0byBp
bXBsZW1lbnQgYXMgYSBkcml2ZXIgYW5kIHRoZSBib3R0b20gbGluZSBvZiAiZ2l0IGRpZmYgLS1z
dGF0IiBmb3INCmhpcyBzZXJpZXMgb2YgcGF0Y2hlcyB3YXM6DQoNCjkgZmlsZXMgY2hhbmdlZCwg
MTMwMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KUHJvamVjdGluZyBmb3J3YXJk
IGEgZmV3IENQVSBnZW5lcmF0aW9ucyB0aGVyZSBtYXkgYmUgMi0zIGRpZmZlcmVudA0KdmVyc2lv
bnMgb2YgdGhhdCBjb2RlLiBQbHVzIGFsbCB0aGUgb3RoZXIgbW9kZWwgc3BlY2lmaWMgZmVhdHVy
ZXMgdGhhdA0Kd2UnZCBsaWtlIHRvIHN1cHBvcnQuIFRoZSBjb3JlIHJlc2N0cmwgYXJjaGl0ZWN0
dXJhbCBjb2RlIGlzIGdvaW5nIHRvDQpkaXNhcHBlYXIgaW4gdGhlIG1hemUgb2YgImRvIHRoaXMg
Zm9yIENQVSBtb2RlbHMgWCAmIFksIGJ1dCBkbyB0aGF0DQpmb3IgQ1BVIG1vZGVsIFoiLiANCg0K
DQo+PiBJJ20gYWxzbyBndWVzc2luZyB0aGF0IHdpdGggb3RoZXIgYXJjaGl0ZWN0dXJlcyAoQU1E
LCBBUk0sIFJJU0MtVikNCj4+IGFsbCBidWlsZGluZyBvbiB0aGUgcmVzY3RybCBmb3VuZGF0aW9u
LCBzb21lIG9mIHRoZW0gbWF5IGFsc28gaGF2ZSBzb21lDQo+PiBmZWF0dXJlcyB0aGF0IGRvbid0
IGZpdCBuZWF0bHkgaW50byB0aGUgY29yZSBvZiByZXNjdHJsLg0KPg0KPiBUaGV5IGFic29sdXRl
bHkgaGF2ZSBmZWF0dXJlcyB0aGF0IGRvbid0IGZpdCBuZWF0bHkgaW50byB0aGUgY29yZSBvZg0K
PiByZXNjdHJsLiBJIGFtIG5vdCBhYmxlIHRvIHRlbGwgd2hldGhlciB0aGlzIHN0eWxlIG9mIGlu
dGVyZmFjZSB3b3VsZA0KPiBzb2x2ZSB0aGlzLg0KDQpJJ20gaG9waW5nIEphbWVzIGFuZCBvdGhl
cnMgY29waWVkIG9uIHRoaXMgdGhyZWFkIGNhbiBjaGltZSBpbiB0bw0KYW5zd2VyIHRoYXQuDQoN
Cj4gVGhlIHNlY29uZCBtb3RpdmF0aW9uIGZyb20geW91ciBvcmlnaW5hbCBlbWFpbCB3YXMgdGhh
dCB0aGVzZSBuZXcgZmVhdHVyZXMNCj4gaGF2ZSAiaW5wdXQgcGFyYW1ldGVycyB0aGF0IGRvIG5v
dCBmaXQgbmVhdGx5IGludG8gdGhlIGV4aXN0aW5nIHNjaGVtYXRhDQo+IG1vZGVsIi4gSXQgaXMg
bm90IG9idmlvdXMgdG8gbWUgd2hlcmUgeW91IGFkZHJlc3MgdGhhdCwgYnV0IG1heWJlIGl0IGlz
DQo+IHJlbGF0ZWQgdG8gIlE2Ii4NCg0KVGhhdCdzIHJlYWxseSB0aWVkIGludG8gdGhlIHNwZWNp
ZmljIGZlYXR1cmVzIHRoYXQgYXJlbid0IHVwIGZvciBwdWJsaWMgZGlzY3Vzc2lvbg0KYXQgdGhp
cyBwb2ludC4NCg0KPiBJIGFncmVlIHRoYXQgd2Ugc2hvdWxkIG5vdCBleHBvcnQgdGhlIG11dGV4
LiBZb3UgbWF5IGJlIGludGVyZXN0ZWQgaW4gdGhlIHdvcmsNCj4gdGhhdCBKYW1lcyBpcyB3b3Jr
aW5nIG9uIHNlcGFyYXRpbmcgdGhlIGxvY2tzLiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIzMDMyMDE3MjYyMC4xODI1NC0xLWphbWVzLm1vcnNlQGFybS5jb20vDQo+DQo+IEl0
IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBqb2luIHRoZXNlIGRpc2N1c3Npb25zIHRvIHNl
ZSBpZiB0aGVyZSBhcmUNCj4gc29tZSBjb21tb24gcmVxdWlyZW1lbnRzIHRoYXQgY2FuIGJlIHNv
bHZlZCB0b2dldGhlci4NCg0KVGhhbmtzIGZvciB0aGUgbGluay4gSSdsbCBnbyBvZmYgYW5kIHJl
YWQgdGhhdCB0aHJlYWQuDQoNCj4+IFEyKSBXaGF0IGFib3V0IGV4Y2x1c2l2ZSBncm91cHM/DQo+
PiBBMikgSSBkaWRu4oCZdCB0cnkgdG8gaGFuZGxlIGluIHRoaXMgUkZDLiBBZGRpdGlvbmFsIGJp
dHMgd2lsbCBiZSBuZWVkZWQuDQo+DQo+IEl0IHNlZW1zIGxpa2UgZXZlcnkgdGltZSBhIGRyaXZl
ciBuZWVkcyAiYWRkaXRpb25hbCBiaXRzIiBpdCB3b3VsZCBpbXBhY3QNCj4gYWxsIHRoZSBvdGhl
ciBkcml2ZXJzLg0KDQpJdCBkZXBlbmRzLiBJZiB0aGUgbmV3IGhvb2sgaXMganVzdCBzb21lIGFk
ZGl0aW9uYWwgY2FsbGJhY2sgZnVuY3Rpb24sIHRoZW4NCmV4aXN0aW5nIGRyaXZlcnMgd291bGQg
aGF2ZSBhbiBpbXBsaWVkICIubmV3ZnVuYyA9IE5VTEwsIiBpbiB0aGUgcmVnaXN0cmF0aW9uDQpz
dHJ1Y3R1cmUuIFNvIHdvdWxkbid0IG5lZWQgYW55IGNoYW5nZXMuDQoNClRoZSBob29rcyBJIGlt
cGxlbWVudGVkIGluIG15IFJGQyBzZXJpZXMgYXJlIHRoZSB1bmlvbiBvZiB0aGUgcmVxdWlyZW1l
bnRzDQpvZiBlYWNoIGRyaXZlci4gQnV0IGVhY2ggZHJpdmVyIGp1c3Qgc2V0cyB1cCB0aGUgaG9v
a3MgdGhhdCBpdCBuZWVkcy4gRS5nLiBteQ0Kc2lsbHkgZXhhbXBsZSBkcml2ZXIgb25seSB1c2Vk
IHRoZSAiYWRkIGZpbGVzIHRvIHRoZSBjdHJsbW9uIGRpcmVjdG9yaWVzIiBob29rLg0KDQo+PiBR
MykgSG93IHRvIG1ha2UgdmlzaWJsZSB0byB0aGUgZHJpdmVyIG90aGVyIHJlc2N0cmwgYXNzdW1w
dGlvbnMgKGUuZy4gZGVmYXVsdA0KPj4gZ3JvdXAgaXMgQ0xPU0lEPTAsIFJNSUQ9MCkuDQo+DQo+
IEFjdHVhbGx5IEkgdGhpbmsgcmVzY3RybCBhc3N1bXB0aW9ucyBzaG91bGQgYmUgX2ludmlzaWJs
ZV8gdG8gZHJpdmVycy4NCg0KVGhhdCdzIGEgd29ydGh5IGdvYWwuIEknbSBub3Qgc3VyZSB3aGV0
aGVyIGl0IGNhbiBhbHdheXMgYmUgbWV0LiBFLmcuIGZvcg0KdGhlIGRlZmF1bHQgQ0xPU0lEL1JN
SUQgY2FzZSB0aGUgZHJpdmVyIHdpbGwgd2FudCB0byBpbml0aWFsaXplIHRvIHNvbWUNCnVzZWZ1
bCBkZWZhdWx0IGJlY2F1c2UgcmVjZWl2aW5nIGNhbGxiYWNrcyBmcm9tIHRoZSBjb3JlIHJlc2N0
cmwgY29kZSBhcw0KdGhlIHVzZXIgd3JpdGVzIHRvIGZpbGVzIHRvIHNldCB1cCBhIHNwZWNpZmlj
IGNvbmZpZ3VyYXRpb24uDQoNCj4+IFE0KSBTdXBwcmVzc2luZyBzY2hlbWF0YSByZXNvdXJjZXMg
ZnJvbSBhIGRyaXZlciBzdXJwcmlzZWQgeW91Lg0KPj4gQTQpIFRoaXMgaXMsIGFzIHlvdSBndWVz
c2VkLCBhYm91dCBjb25mbGljdGluZyByZXNvdXJjZXMuIFRoZXJlIGFyZSBvdGhlciB3YXlzIGl0
DQo+PiBjb3VsZCBiZSBoYW5kbGVkLiBFLmcuIHVzZSBleGlzdGluZyBtb3VudCBvcHRpb25zIHRv
IHN1cHByZXNzIHRoZSByZXNvdXJjZSBmcm9tDQo+PiB0aGUgc2NoZW1hdGEuIFRvIGJlIHNhZmUg
dGhhdCBtaWdodCBhbHNvIG5lZWQgc29tZSB3YXkgdG8gZmFpbCB0byBsb2FkIG9mIGEgZHJpdmVy
DQo+PiB0aGF0IG5lZWRzIG90aGVyIGFjY2VzcyB0byBhIHJlc291cmNlIHVubGVzcyB0aGUgY29y
cmVjdCBtb3VudCBvcHRpb25zIGFyZSBpbg0KPj4gZm9yY2UuDQo+DQo+RnJvbSBhYm92ZSBpdCBz
b3VuZHMgbGlrZSB0aGVyZSBtYXkgYmUgc2NlbmFyaW9zIHdoZXJlIGEgZHJpdmVyIGxheWVyIHdv
dWxkIHN0aWxsDQo+YmUgYWNjb21wYW5pZWQgYnkgY29yZSBjaGFuZ2VzIChsaWtlIG1vdW50IG9w
dGlvbnMgYWRkZWQgdG8gdGhlIGNvcmUgdGhhdCB3aWxsDQo+YWxsb3cvZGVueSBjZXJ0YWluIGRy
aXZlcnMpLiBJZiB0aGVyZSB3YXMgbm8gZHJpdmVyIGxheWVyIGl0IGNvdWxkIGp1c3QgYmUgaGFu
ZGxlZA0KPmluIGEgc2luZ2xlIHNwb3QuDQoNCkkgdGhyZXcgb3V0IG1vdW50IG9wdGlvbnMgYXMg
YW4gYWx0ZXJuYXRpdmUgdG8gc3VwcHJlc3NpbmcgZmVhdHVyZXMuIEhhdmluZw0KdGhvdWdodCBh
Ym91dCBpdCwgSSdtIG5vdCBmb25kIG9mIGl0IGF0IGFsbC4NCg0KPiBUaGUgc2Vjb25kIHBhcnQg
b2YgbXkgb3JpZ2luYWwgcXVlc3Rpb24gd2FzICJXaGVyZSB3b3VsZCBpdCBiZSBkZWNpZGVkIHdo
ZXRoZXINCj4gdGhlIG92ZXJyaWRpbmcgZHJpdmVyIHNob3VsZCBiZSBsb2FkZWQgYW5kIHdoeSBj
YW4gdGhhdCBsb2dpYyBub3QgYmUgaW4NCj4gZW51bWVyYXRpb24gd2l0aGluIHJlc2N0cmw/IiBJ
dCBpcyB0aGUgdXNlciB0aGF0IG5lZWRzIHRvIGRldGVybWluZSB0aGF0IHRoZXJlIGFyZQ0KPiBj
b25mbGljdGluZyByZXNvdXJjZXM/DQoNClRoZSBob3Jyb3Igb2YgbW9kZWwgc3BlY2lmaWMgZmVh
dHVyZXMgaXMgYXBwYWxsaW5nLCBvciBub24tZXhpc3RlbnQsIGVudW1lcmF0aW9uLg0KSW4gdGhl
IGRpbSBhbmQgZGlzdGFudCBwYXN0IG9mIHJlc2N0cmwgdGhlcmUgd2FzIG9uY2UgYSBwb2ludCB3
aGVyZSBpdCBkaWQNCnN0aW5nIGNvbXBhcmVzIG9mIG1vZGVsIHN0cmluZ3MgYWdhaW5zdCBhIGxp
c3Qgb2Ygc3BlY2lmaWMgU0tVcyB0aGF0IHN1cHBvcnRlZA0KZWFybHkgUkRUIGZlYXR1cmVzLg0K
DQo+PiBRNikgRG9tYWluIGF3YXJlbmVzcyBvZiBkcml2ZXJzLg0KPj4gQTYpIFRoaXMgaXMgYSBj
aGFsbGVuZ2UuIEVzcGVjaWFsbHkgYXMgdGhlIGRvbWFpbiBmb3IgYSBkcml2ZXIgbWF5IG5vdCBt
YXRjaCB1cA0KPj4gd2l0aCBhbnkgZXhpc3RpbmcgcmVzb3VyY2Ugc2NvcGUgKGUuZy4gZHJpdmVy
IG1heSBiZSBzb2NrZXQgc2NvcGVkLCB3aGljaCBtYXkNCj4+IG5vdCBiZSB0aGUgc2FtZSBhcyAi
TDMgY2FjaGUiIHNjb3BlZCkuIEFmdGVyIEkgcG9zdGVkIHRoaXMgc2VyaWVzIEkgYWRkZWQNCj4+
IGFuIGVudHJ5IGluIHRoZSByZXNvdXJjZSB0YWJsZSB3aXRoIHNvY2tldCBzY29wZSB0byBoYW5k
bGUgdGhpcy4gRHluYW1pY2FsbHkgYWRkaW5nDQo+PiBhIG5ldyByZXNvdXJjZSB3aXRoIGEgY3Vz
dG9tIHNjb3BlIGhhcyBjaGFsbGVuZ2VzIChiZWNhdXNlIHRoZSBkb21haW4gbGlzdHMNCj4+IGF0
dGFjaGVkIHRvIHRoYXQgcmVzb3VyY2UgYXJlIG1haW50YWluZWQgYnkgdGhlIHJlc2N0cmwgY3B1
IGhvdCBwbHVnIGNhbGxiYWNrcyBhcw0KPj4gQ1BVcyBjb21lIG9ubGluZSBhbmQgZ28gb2ZmbGlu
ZS4NCj4NCj5NeSBjb21tZW50IHdhcyBub3QgYWJvdXQgYSBuZWVkIHRvIG1ha2UgZHJpdmVycyAi
ZG9tYWluIGF3YXJlIi4gTXkgYXNzdW1wdGlvbiB3YXMgdGhhdA0KPmRyaXZlcnMgYXJlIG5vdCBk
b21haW4gYXdhcmUgc2luY2UgSSBkaWQgbm90IHNlZSBhbnkgcmVsYXRlZCBpbmZvcm1hdGlvbiBz
aGFyZWQNCj53aXRoIHRoZSBkcml2ZXJzIGFuZCBzaW5jZSB0aGUgZHJpdmVycyBvdmVycmlkZSB0
aGUgc2NoZW1hdGEgZW50cmllcyBJIHRodXMgYXNzdW1lZA0KPnRoYXQgdGhlIHNjaGVtYXRhIGVu
dHJpZXMgdXNlIHNvbWUgZHJpdmVyIHNwZWNpZmljIHNjb3BlLg0KPlRoZSBjaGFsbGVuZ2UgdG8g
YWRkIGEgcmVzb3VyY2Ugd2l0aCBhIGN1c3RvbSBzY29wZSBzZWVtcyBsaWtlIHRoZSBiaWdnZXN0
IHByb2JsZW0NCj5yYWlzZWQgdGh1cyBmYXIuIElzIHRoaXMgcGVyaGFwcyB3aGF0IHN0YXJ0ZWQg
dGhlIHZlbnR1cmUgZG93biB0aGlzIGRyaXZlciBpbnRlcmZhY2U/DQoNCk5ldyBkb21haW4gc2Nv
cGVzIHdhc24ndCBhIGRyaXZpbmcgbW90aXZhdGlvbiwganVzdCBhIHRoaW5nIHRoYXQgd2FzIGZv
dW5kIGFsb25nDQp0aGUgaW1wbGVtZW50YXRpb24gam91cm5leS4gQWZ0ZXIgcGxheWluZyB3aXRo
IHNvbWUgd2F5cyB0byBoYXZlIGVhY2ggZHJpdmVyIGtlZXANCnRyYWNrIG9mIHNjb3BlIEkgZm91
bmQgdGhhdCBJJ2QgcmVwbGljYXRlZCBzb21lIG9mIHRoZSBjb3JlIGRvbWFpbiB0cmFja2luZyBj
cHVocA0KY29kZSBhbmQgZGVjaWRlZCB0aGF0IGp1YXQgbWFraW5nIHRoZSBjb3JlIGtlZXAgdHJh
Y2sgb2YgYSBzb2NrZXQgc2NvcGVkIHJlc291cmNlDQp3aXRoIGNhbGwgYmFja3MgdG8gdGhlIGRy
aXZlcihzKSBmb3Igc29ja2V0IGFkZC9kZWxldGUgd2FzIHRoZSBjbGVhbmVzdCB3YXkgdG8gZ28u
DQoNClRoYXQgbWlnaHQgbWVhbiBhc2tpbmcgdGhlIGNvcmUgdG8gdHJhY2sgb3RoZXIgc2NvcGVz
IChsaWtlICJ0aWxlIikgaW4gZnV0dXJlIGlmIHNvbWUNCmNvbnRyb2wvbWVhc3VyZSBmZWF0dXJl
IGhhcyB0aGF0IHNjb3BlLiBIYXZpbmcgY3JlYXRlZCBhICJub2RlIiBzY29wZSBpbiBteQ0KcGF0
Y2ggc2VyaWVzIGZvciBTTkNbMV0sIGl0IHRoZW4gaXMgcXVpdGUgdHJpdmlhbCB0byBhZGQgYWRk
aXRpb25hbCByZXNvdXJjZXMNCndpdGggYW55IHNjb3BlIG5lZWRlZC4NCg0KLVRvbnkNCg0KWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDEyNjE4NDE1Ny4yNzYyNi0xLXRvbnku
bHVja0BpbnRlbC5jb20vIC4uLiB0aGF0DQpzZXJpZXMgaXMgbm90IGZvcmdvdHRlbi4gSnVzdCBu
ZWVkcyBhIHNsaWdodGx5IGRpZmZlcmVudCBhcHByb2FjaCB3aGljaCBuZWVkcyBhbiBpbnRlcm5h
bA0KYXBwcm92YWwgYmVmb3JlIEkgY2FuIHBvc3QgdmVyc2lvbiAyIG9mIHRoZSBzZXJpZXMuDQoN
Cg==
