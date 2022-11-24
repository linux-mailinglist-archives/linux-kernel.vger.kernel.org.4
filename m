Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5996376D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKXKwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:52:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227B42F71
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669287141; x=1700823141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K+B5HJczUu5UIHLydvZX3JKRSsilhsc1kkGcHsOrm9Y=;
  b=1bb/9lZ/9G0Mofb9U4ibUWQpZRPQNPZDSS9WhY3bzOBNUIJXeu25vFcF
   s+Y2KfgPE0yl2diez3FUO4VC6Xg9OyOwppC+w+e5MzD7+0HFADXo9cQHD
   GwOCo14Lu+RM0kpC9kA8dq7zNI/3QSUn7L67herWvvYXoRrEVKeOJBwS1
   VUgV68jm259Fuu9iFyyEUfmhVy9Vyv7yoY3SniLcWV0bOuYzuiFPn61IX
   6g9zQUQa0szhYMspVa2B/ex94jfPiSaPtM1m0JihUt2dOMp8GXA+aHrs8
   Haxnz0a5zYU/7wl96SX13T5VIldBTqjk9PxH8vS4jRX+dfBF0kDp2C7hQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="190407440"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 03:52:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 03:52:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 03:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6ZXV+F8jHeFaDhtPwqaYu4mm2NJidWjMo42c2RSThVshVBUuejzCQVWt2u2jPHVCrba1ROcHTzYfg3qARgJ3OMZBirclS7II21Z+JdTjscyNL/kZ6QCsRPLNI5l3cwsf1TFBPE2r024mTDAsCmr3Rs7slZrrBSxSayACjKGZrpVeM9FNLp4LzCqO9D9XwsCh9Ge02mO9NheJ/3cUQi5MN7QsktXPKArJuqYY0fYvwOf/QcwHwsAF4B60ICTM7MCGnuJTvLG086Io0V3e3uqP8q+y6iy7EDRbVKXGFZY9FkDHypOW2TJ1U8wUBUfmFKzO6MJ6OfIWKTPT2kWtoROig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+B5HJczUu5UIHLydvZX3JKRSsilhsc1kkGcHsOrm9Y=;
 b=TMPJ7jOZsuIAN/ecUjYKWvPr9uo/OJ0F/GgzplCBEgfJZhNF4ux8HUBMANKbBXapegmKjvsImy/bMk0Ce26kgudi+OI7PqkVcV4FBjnvp/cP2VH4ZTQslAfoUDRhygApgaW7ktB+Rz1r2YFD13hnbOmQQ1l/ATCN3+3Oc/a+APUQXZH/GJHox5Z01fgFG0wGgBjWiNkav5cI8TQ09Hkqj//kakLRg0UHp3LAoSTVN89lVsxy2NAOc9Wqlaac4zuxHxfepPw1odXZom6BVR/DBcRUKTUCfigs71nyQrXvo1hmBJA3B+OBx7WmkRtxwaf3fiyd0Ik0/PDGFvWEEqwwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+B5HJczUu5UIHLydvZX3JKRSsilhsc1kkGcHsOrm9Y=;
 b=VcypNdZHWsq/VMMzxBIsg6jxm93Gbd9m7J1w4F3qCwXpTQj2Ofab8KHOS5/AyvXuVU74spQCRHHkxpZMWmB0xFir/JAecOdt84dd/Mtx9I1bwrG/8Xrr/qrI9r6DUMQMhmbJAwTrjsIKp2ZZr+CO7Dgrq/jFtPWXl+Wncmv4TUI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 10:52:18 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Thu, 24 Nov
 2022 10:52:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC:     <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <clement.leger@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Thread-Topic: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Thread-Index: AQHY//LRNs1xAxAVsEqa0Uhu4njSRw==
Date:   Thu, 24 Nov 2022 10:52:18 +0000
Message-ID: <55153e71-9b2d-c0ba-a36f-685dafb2743a@microchip.com>
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
In-Reply-To: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: f8f60472-c563-4f8c-b82c-08dace09f4fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSNhInHfXqNaBfsK8pBTmiECN7BznpaRCIecsZOgwnaQlLtf47fHjIL8/W9tx0nQC50oiaoUnh6BUWlnYsvi2mNhwXBw2tQqR9Wdj4LSmIuwd89I2NQ16oZ2qCacIrV9RvDrPqhLj7pB9XaFCBX7dv+3abYZJKDX5DDxdCNaLTWtlWoavhVqUpthpYfuNFmDnM+0pLPTliNlWfJNKMzNb64e5qwqqZMGless8fNvaDWIwZCb+CSMDQ7KcSWqu1B4AsEe4Xk/ua7YRGFE6iWCGJKIufwDW5eiFrOqhE8FAZDG2vQmArUrahrRuqhn2K5rv3Cx/UsbXiR17NxSkJIsfMOt5H2ldz8KH/Y1LgZxanx4zfQdmBr4RHWtgRFh6ss1oKRgdqLImRQ73DdglAYa6lyPfJtRogEcPWw9hiM5IZHhRztSNDkFGvKp/8fh+KSJ9XzDkGS6VBUSLMiV1bBPtpi4JQqamxH2mh5uyMW4rcnKvhGG4odEXbw8SaRUc145rNdrqFu4xYQSkQaj+qhcOi7wshW5sURCM8Z7j6SeC2y0WC58LbsIbQ1OzaE6pZYjOo8vvIYV5S7dGkpLZ9wKjSIV8aPRYSwMlvVpsAhZRNgtvruISthdPMhf6fouLsF55vHs2XTiqGwwOzlHZVfemiSQxAQ1vIMA+uNKFkspaToKOlTB/oB6e0PRVNbfC/paiE1tq6785f7M+MRKR8u2RWtRF/gQjwhzYJAXocQcBc1UyKhhu9NJtnO/HmP0VbJQ65+AVYWtNDn9rPhCazV+lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(6486002)(8676002)(38070700005)(86362001)(4326008)(2906002)(8936002)(122000001)(38100700002)(31696002)(83380400001)(110136005)(91956017)(66946007)(64756008)(2616005)(76116006)(54906003)(478600001)(186003)(41300700001)(316002)(5660300002)(66556008)(66476007)(66446008)(53546011)(71200400001)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXYyM1NnczVMLy9YdDN4cjBDbzg3disxRE5wbnNUc0RJNTFrWVU2cCszYjRt?=
 =?utf-8?B?SjQybUg4VERUL21QK0VyemFBdWRSMGN6b3ZrWVBWcHVsMldOQzgyOU1xVWpH?=
 =?utf-8?B?TEFsVmlPVTNQQUtHaVVkeDlhQTV3eUJnZS9mMnMwMDViQnZVM2pwZy9qYTRa?=
 =?utf-8?B?ckhVZmRyeGl2RFRTbHZIWFBYOERjWWVOS1RKTkxZVVFRaEFyWEV6Z0RXSnNh?=
 =?utf-8?B?TlZXUUlEdGZ3Z2FSR1lSM05WMEZTN0JMWldSVHBvMVNOaER3ckZzNmZaSjEw?=
 =?utf-8?B?alY2dm9HMkFHZVJrSXRwMUszR285bzZGQ1NOMk85Z2lxRlRlWUphdEhIRGFr?=
 =?utf-8?B?V1FPaXFwa2gzSUp1UDRERFlSS0xCd1ZiVzlyeXhLTFhFWThCK2NOVFRtdHo3?=
 =?utf-8?B?UUZQaTJzaEU2elVyelVmMWlwQmdrTTJKbmV4V2Z2VW1VaGd3Q2lWbDV3Snhj?=
 =?utf-8?B?bGUrRU9VUHVSejVSbXFmeHZPRmtucTM0OHRaK015V3hjZFpyaUZyRFYzY0VX?=
 =?utf-8?B?UXNpMkxMTEdQV1pQZy9PcjFBQzN5YXdEQ3NTVTBLbTdVYm0rMFNMV0RlUEo3?=
 =?utf-8?B?eHZyNHlzdVdSVkpkZUoyQzVQUmM3SnFGTmdyQjZvT2VsR0JwV2pUSVlXQ0Q0?=
 =?utf-8?B?aVRUQ1pHVThXRlQ5NUR5c2hwdWY4N0Y5WVJZUEVhZFEySU9scXBLTlgzMDdw?=
 =?utf-8?B?M0ZkdzIrUkpqNHg0R2lOalBhSEpuOUZUTTVta0xrOFhpUlovNDdKTC9id204?=
 =?utf-8?B?OFhySUdlMUhJVVRZYSt3SkpkUmtqdXBhU2Y1NzBQQ0dJSkdsSit3MzMwTUVW?=
 =?utf-8?B?a01ycitlYlFuSWdvUzB4OWVsbkovcGJ0aDdMV056eXBVS3hHdlJnWHlPSXlq?=
 =?utf-8?B?dnBVWGVhdXJMQkxoMHNPWUowUncyejZ1U3ZMVU14ZVRWZm5wQ2lMSlJIVmFS?=
 =?utf-8?B?L2lIQ2FOUHljbHF3ZERxSEhjK3F0M01FaXd1cGtJaUIxSzRuaHI4c1R1a3do?=
 =?utf-8?B?bElVYy84VzNZOUpUTXdRSkUxSlV0U2ZOS3VqaHM2RXk4U3NTbCtjTEtKRUZx?=
 =?utf-8?B?dVd1OWRERWRILzBBM3RZcUNVYnp5SDdZM3NvM2ZWRG5IdWl3UjBTZWpOZi9S?=
 =?utf-8?B?OWxyYzNlNUVlaUNMYzVqazBaTXJ2NDB1VVViZ2xPK0lXN0N4bTBhMUZ0UzRI?=
 =?utf-8?B?cGhWTkw4SG9ETjJPTVBwTE5rQ21rZDFKaisyVTE0L1IvNVBsRDVwUHY1VFYw?=
 =?utf-8?B?TUJYeXNqRWY5ZnR3TGxTYVpJQXp5YVRia1A1d01RTW41Uy9HZldJQUpwR3l5?=
 =?utf-8?B?VGNJTE9aNkN0TUhUS3RkQzdCdGttWGtjWXc2SWkvaVYwRTFPd0NSQmoyNCtz?=
 =?utf-8?B?R0RYN3JEU0c3U1ZLU283TmdSbWlkamlZeUk2a2RGNm1WRCtDMWZ4K3dvVWpR?=
 =?utf-8?B?b1J1MDgzUy8zRE9xZGVTTnA3WWNIUXlZS1J6N1lWRFdNVTZNZm1jdHA2bXY3?=
 =?utf-8?B?S0pRN2RQNytvZXpuRy91WDhiblJpZnEzd1Btdi80a0pnUkFhQ2p0ajZ6aERy?=
 =?utf-8?B?NmNuWHZmMDQvZXNid3lNdGVST2JjYllRcEVsM2hHZElWN0loNHBtdW94S0VY?=
 =?utf-8?B?aUxQVzNJbU1lV0s4dk9COWJ3Vk0zWmNHdFgwdWRNRkxtZktqWUNZWmZJZzZ6?=
 =?utf-8?B?SEpsZm03UklQaEF5SWhFL25lWTBiRWdRTytLQlYzbFMvZExPdXBENkdkczh5?=
 =?utf-8?B?enBKTCtySUx5UHA3T1NKTDEwOVVReFhzWFpock92WEhPVE90TlhTWWgvaTRD?=
 =?utf-8?B?NnBlZkt0VHVYaGZIU2xwUnpZYWNicFhGNllBeGhhblhLL3ZYS0Z5a240S0sv?=
 =?utf-8?B?TlUzaVRZekRCNzhZZ1JPTHQrenVVT0FUYW5IaVY3NjJseitGWEhJN2ZrUnZz?=
 =?utf-8?B?TGlPUm1xY2xNYWZoS1MwWSs0M2JaVVZ5OUprY1VyK0FuaVQwL3QxRnc3NWp6?=
 =?utf-8?B?NnF2elNLQ3pickNMUlhDektrV3lPeU54cHRUVXBGMDB6MUVyRnNGYWJ3M2x3?=
 =?utf-8?B?ZXMzSXVFQmthUWhCMzk5VGNlSTZuOHlJRmVZWHYwdUVDVWRYSHJkMEpzV0xa?=
 =?utf-8?B?ZTNVdVRibVlGTlF6UEhQRnJBdkZuZE5ZY0drU0g0eU1HckF4Nm5VTnhaRWF1?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A66E51E916460D429D2FD3B11E643AC4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f60472-c563-4f8c-b82c-08dace09f4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 10:52:18.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVJxb+dfuq4oaiYrAr1L1BFuJuW/bwL58tcjNnSz8D7jFmYqjovF8uu+kshqrfSIfF0Ag5WGTc4K/wp5fb/CPkblDO45fqXdA9e+gcAyEo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTEuMjAyMiAxNzo0MCwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIEwyIGNhY2hlIGlzIHByZXNlbnQgb24gdGhl
IG5ld2VyIFNBTUE1RDIgYW5kIFNBTUE1RDQgZmFtaWxpZXMsIGJ1dA0KPiBhcHBhcmVudGx5IG5v
dCBmb3IgdGhlIG9sZGVyIFNBTUE1RDMuIEF0IGxlYXN0IG5vdCBhbHdheXMuDQo+IA0KPiBTb2x2
ZXMgYSBidWlsZC10aW1lIHJlZ3Jlc3Npb24gd2l0aCB0aGUgZm9sbG93aW5nIHN5bXB0b206DQo+
IA0KPiBzYW1hNS5jOiguaW5pdC50ZXh0KzB4NDgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBv
dXRlcl9jYWNoZScNCj4gDQo+IEZpeGVzOiAzYjVhN2NhN2QyNTIgKCJBUk06IGF0OTE6IHNldHVw
IG91dGVyIGNhY2hlIC53cml0ZV9zZWMoKSBjYWxsYmFjayBpZiBuZWVkZWQiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KDQpBcHBsaWVkIHRvIGF0OTEt
Zml4ZXMsIHRoYW5rcyENCg0KPiAtLS0NCj4gIGFyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNS5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBIaSENCj4gDQo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIHRoZSBjb3JyZWN0IHNvbHV0aW9u
PyBNYXliZSBTQU1BNUQzIHNob3VsZCBicmluZw0KPiBpbiBDT05GSUdfT1VURVJfQ0FDSEUgdW5j
b25kaXRpb25hbGx5IGluc3RlYWQ/IEJ1dCB0aGF0IHNlZW1zIGxpa2UgYQ0KPiBiaWdnZXIgY2hh
bmdlLCBhbmQgbm90IGp1c3QgYSB0d2VhayBvZiB0aGUgcmVncmVzc2luZyBjb21taXQuLi4NCj4g
DQo+IENoZWVycywNCj4gUGV0ZXINCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0
OTEvc2FtYTUuYyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNS5jDQo+IGluZGV4IDY3ZWQ2OGZi
ZTNhNS4uYmYyYjVjNmExOGM2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvc2Ft
YTUuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvc2FtYTUuYw0KPiBAQCAtMjYsNyArMjYs
NyBAQCBzdGF0aWMgdm9pZCBzYW1hNV9sMmMzMTBfd3JpdGVfc2VjKHVuc2lnbmVkIGxvbmcgdmFs
LCB1bnNpZ25lZCByZWcpDQo+ICBzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTVfc2VjdXJlX2NhY2hl
X2luaXQodm9pZCkNCj4gIHsNCj4gICAgICAgICBzYW1fc2VjdXJlX2luaXQoKTsNCj4gLSAgICAg
ICBpZiAoc2FtX2xpbnV4X2lzX29wdGVlX2F2YWlsYWJsZSgpKQ0KPiArICAgICAgIGlmIChJU19F
TkFCTEVEKENPTkZJR19PVVRFUl9DQUNIRSkgJiYgc2FtX2xpbnV4X2lzX29wdGVlX2F2YWlsYWJs
ZSgpKQ0KPiAgICAgICAgICAgICAgICAgb3V0ZXJfY2FjaGUud3JpdGVfc2VjID0gc2FtYTVfbDJj
MzEwX3dyaXRlX3NlYzsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuMjAuMQ0KPiANCg0K
