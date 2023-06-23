Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8F73B354
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFWJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFWJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:16:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7AC2;
        Fri, 23 Jun 2023 02:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBgDEV83OuRkZ9YhCFkjb/gt+b6XHVM4LSLb8NB2mr/hiZRSpQtp6GgLrYiMMt3s8Uv/m9eBRpTEIeBGU40fmWD+yQWkW0cfl6C+1svVEry9Ddt+KwN9X5Vh7Vdon4SGquL2IhS+4nEMyGpk1lP56Sw++0W/hYAjEHaHwZK9BLnSJavyIwBDimms8VzbCjzaUGqcYpTZ67JP9m0Iqp3ec6vmG2/ozbrxv5zpmGf0wGgFQsvt6YaXqSVSNH/t07geypGg43/bfYd2AY1hiJ79WsM0h/+4R4UiGO/L6LxjFABFkCvWNwQxzM83OsbALmhk0LBMQDhPeGKgCIYruSWWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzbeXXxYT29wXN88bi9T7TOGdnm1h1xT3efXReZhDJg=;
 b=Lqtn3ncQuX8Js57a7in1egHpt9qlU3TJVBn+8VqwWhqyuoDEGW27ab4o5TlPhOLKWQHnEkdr6Gw1Nj4sMyNNpBvT71fSjd4tugX6UnEyo5/pPt8ZSl8m0sLjUwnFcU+9cqd8EbJGR0scavP60/mRaCgkXWJ9Ih/bH8RlHv1a5obilHbGxZ972CzfiBaknU1lu6E/UIhbkaQFmLuznHwBXY1YpciPh2UvPqIs2ubdizDDPedMazgQ9WbujN9g0+7a42bjjhNfT13FQVHRrG2PJNY7HIud36kS5VXP2EEKXF4vueqLYewsks4XJtSSwfl/dIxL4PBT67hhjdiJg4KA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzbeXXxYT29wXN88bi9T7TOGdnm1h1xT3efXReZhDJg=;
 b=ldMTrBXJ7pAfRk/jseea2czJpVs1hSC4F2ijd6B8sfFJOP5kF5FCJUN1rXsD1bffexs48Pq9nLebMW9h5T7RmhkV2suNaGYgRWcYjWdKRx74bqb5SlfltMPaVYjdHo8efNM1VxUScypSrCml+3tbIP3p+GyGSKloE2Vw9Um9070=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB9653.jpnprd01.prod.outlook.com (2603:1096:400:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 09:16:24 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 09:16:24 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl
 names
Thread-Topic: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl
 names
Thread-Index: AQHZpaj0yKRHfSM+IE2HpN9cJYVh06+YEXmAgAAAYWA=
Date:   Fri, 23 Jun 2023 09:16:24 +0000
Message-ID: <TYWPR01MB877509DC4980C0B24ED6979DC223A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
In-Reply-To: <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB9653:EE_
x-ms-office365-filtering-correlation-id: 68a820e7-32eb-453d-74c2-08db73ca842f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kv5BoTm/7MmCNRvDM7/zkELqCPXBi0qTgn+Ij74z6G1yLk7B6qCbAYaJotjnjW9YTetLQuotrjhUXEJ/w+Gx5dy6TwM6lXlN7LgFmJI6YnbNcHC1+f8W28ZAP1pH7rm3Nb4J3T/aRRre9ZzDEKVCDSttPn+9e+XRDSH8tioy/qXA0mwf7hkn5UU0HaE0F8aZFvMaiSuPFr4/1Fjd2SxKwjqQ7V7Z7vGi934wjIYtmvtw2WFjhoV5Z/7n6CjNsICblJcXkF8vZOMNJ6PfBphnZHoZJmaXsNLAZhwxsIkPDoJY5Qkgra4BfrbgMROAb2//oBRd6nqtTnzXN/VBp4ga8ZvHWXBCw0exqVVqrdpH9j2ieWSNA5tvSjpkjvVQGI4d0BZS9UU+C8+kx9bJdjq+YYmKprn0yDwr3Ga7mrHGtJSolsD1BN8jpA0xRwJ35SfhCNwHIP4VmqjktAoGRjAlUP71kPhmD1wFQXsB7qfiM2eNNnV9fyqNxd4vqLmyYSZuHDD8SVXn3dkNCf0OCS+rbK+fVdRzeAbDqT4FdWPp6XqKaCfPVhE/ImUdXxW0UiLgH7MpgA7mVUpdb8W0mKxPLAFBcnmgOdXFllPWRcsRVFDTU5IG7h3Uu77jBxrvZbcN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(6506007)(53546011)(478600001)(7696005)(71200400001)(9686003)(55016003)(26005)(186003)(83380400001)(41300700001)(8676002)(8936002)(54906003)(316002)(76116006)(66476007)(66946007)(4326008)(64756008)(66446008)(66556008)(6916009)(2906002)(7416002)(52536014)(5660300002)(38100700002)(122000001)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmdpMHBJbmU1VWpWb2pYOWthbDU3RDBZeHMrVnNYT2NPempJcDhjVWJMWk44?=
 =?utf-8?B?aW5IT2dPUEFTVXdzOXR0amE1TzNqRFgyamdCejBoMlFyTkRONTRTUThwTXRT?=
 =?utf-8?B?c2swcmVNbjZIRWZuVmlIQmNqOVVTM29SS2VRZ2pGQnMwQjcxaHVRTlo2YVo5?=
 =?utf-8?B?cFoxU0h5RUdYRFQ4STlVSXpwdEVLTXJ1RkNKUkZrTWxhS2VodDhrNXIvSUE1?=
 =?utf-8?B?U2d6bkYzalcxNHpGRXRXb3hsWDhmU0lqNEo3cFVDMnk1SXZOazJXWUhaRmFK?=
 =?utf-8?B?TWxsamdSNkZLRUdCUld4WG13aGlZaWs4ZHZsQnVTeTdQSVVjckR6cnJ6NXkr?=
 =?utf-8?B?Wng5L1RLOURVZzV6aVZBZEpRL0cvRHlZNTd0VXZwUi9qK0JoWHZrY0lPNDcy?=
 =?utf-8?B?NVhqa1JtWW9VSDBxWW9wOFZqYUxtMXk3VjdnWTdGaTc4c0k1blhhckZDQTEv?=
 =?utf-8?B?WngxMkJYcTd3KzhGT0V1VTJrQ2lXaEw1NFRjTjUxOHp3cURwSllTU1RCVTV3?=
 =?utf-8?B?Z1NhbEdaRyt0MW4va1BWeVFkS3d1Rzd2ZlBhUWpVYlJ5TFh1WitxK290cTg2?=
 =?utf-8?B?bEtTbVdRT3grLzVlcUsxbHJwMlhDQjBMUllreDdlbGt4TDhpaU5GVUMzRmQ4?=
 =?utf-8?B?NW5VRmp4V1JtSEM5S2NqLzJ5NkR4SndNcmtoZmoyWVBoQytvQU1ETlBTTVhH?=
 =?utf-8?B?WEEreWVRdXlaYTNrUW9qYlc1a0xBbkczR2k1anE2L2w4ekxiNnhhVE16bmoy?=
 =?utf-8?B?Q1FIOVkyenFXT2JhMTV1eHE1c3hTN1F5Syt1NTd4bUowNEt0V2VBYVZYejE0?=
 =?utf-8?B?NVM3Q3NtNWxiRDhqZUU5WXQwcnRtUlUwQlRBeGZJQ2FhR3ZEaHBCVGtkNXdW?=
 =?utf-8?B?ODRpM3JjTXlTNm5PU2t4MkZCcDRvNW1jTlpVMFlFR0ZTdDFKbHNCVUJDY1NC?=
 =?utf-8?B?dEZPbGFwTi9yWGxlL29tNkhES2hJbndrVGpGbW15NGJXNnlWbktiZkx6TVY0?=
 =?utf-8?B?UWhzaFlXdmxmNnl6MUV1UldGelVhcEhIVm5uMUZOZWo2QlpwbDd5aXVhNlZa?=
 =?utf-8?B?ZFZpaFZwc0VCV004YUpxTWNaWEVwRVVzR05NTXNpZDBFa1BZWUZMVzlpL2hW?=
 =?utf-8?B?a1VVa2NxangvdTVDdjhhVytYM0RmZW02OSs1VXFCMzlnYzhQaWE0TldMU0Vj?=
 =?utf-8?B?dDlpQ1dHTDNMejNRbjZlU0pTRytyNHlKMVVyMWsvVWZ2ZWtETHBrMWROYUJn?=
 =?utf-8?B?VXd0dDhXVDZDNWYyNWU4VzlueDZieVNrT2RGaG5hRlMvZ2VlZkNYbmo4ODBK?=
 =?utf-8?B?Z3d5R2d1UnBkVEpoN2p1MFZCdGlNTWllenhCRXN2K0RCelFoMzNKK0JVanpW?=
 =?utf-8?B?ZzNKSTNuME5YSWhCNjNPekFvSFBndGJxWWZaczAydVh2ZlZXWEFraWxPTW9z?=
 =?utf-8?B?VTh4NzlrRzRwdjVRQmtJalNhYWp4WUsvUGRaVVE2dUR6OGN5V1RkRmhjZUhh?=
 =?utf-8?B?c3h6bEF1OW1VbEluVU5FNlF6cVh0eWZXTjJNdEJ6eFV4VzVvMmNYMlJ5QWVP?=
 =?utf-8?B?NjNOSnhrOU42Rkxkb3pJNnZkT0F4Smg3NG03SmxuM3hMUWJvQUFQNXBDQXdN?=
 =?utf-8?B?VE1nVnR5VFdjWGdWSUNNaWRrZkF1YmlVYXVINVFweVJHc0s0Qmt0Y3F4SGta?=
 =?utf-8?B?WUpKTERuTXM0NkdxVHlaeGhGdU5vQmFuelB6a2lqbXRQY2o3Q0R3MXcwQVc1?=
 =?utf-8?B?bXIxV0RJWG5zMi8wbGFOaTFWSHI2R0ZIVHV5aHBBWmtmTkhidGpBdW10U29T?=
 =?utf-8?B?Q0NqQndlZS9qUmQ2bGV4emJEQUJPdm9aaFFheXhqeWh3WHNFNTV4ZU1jWDR6?=
 =?utf-8?B?Z05LT21NTEVFNi81dUhJbTdYUXMyeUN6U1NlbTd6ZkQ5TDNaMGJ1N2pLVmZJ?=
 =?utf-8?B?MThNM3dpNXFveXRUR3ZpNlUzcUpObE1CbWF6aU5rZjBOaCtrOEpnaTB6cXhP?=
 =?utf-8?B?WTd6czhJWGhKVVFpbVZ2TnNsbFNXYlkxZ1RPSzg0UUthQjZQcVFKeUhlRkoy?=
 =?utf-8?B?NnIwNFNSUGpyUXlwa2pOZVlwM3RjM2loWW5CREQzU1Zjb3d2cjc3ZEZJQVI3?=
 =?utf-8?B?eG1xOGF0a3A4NjZFTUdTalpWTWwvYU5jSTRIZHRZbVMxUFhQT3RQUG02T3Zt?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a820e7-32eb-453d-74c2-08db73ca842f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 09:16:24.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kgWu0mR+UnUj01bU8vGg0+uQjEvnkditzxFXeTzNt60viqddQ2YLOz6PaPogpAKIswCcwPnFHOfsqXJms5GxHH4wqTf/hb2xi0pPy8e9DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+IEZyb206IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6djJtZXZrMjogRml4IGVNTUMvU0RISQ0KPiBwaW5jdHJs
IG5hbWVzDQo+IA0KPiBIaSBGYWJyaXppbywNCj4gDQo+IENDIHBpbmN0cmwNCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4gDQo+IE9uIEZyaSwgSnVuIDIzLCAyMDIzIGF0IDEwOjAx4oCv
QU0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdy
b3RlOg0KPiA+IFRoZSBvcmlnaW5hbCBjb21taXQgdXNlcyB0aGUgc2FtZSBuYW1lcyAoImRhdGEi
IGFuZCAiY3RybCIpDQo+ID4gZm9yIHRoZSBzdWJub2RlcyBvZiBwaW5jdHJsIGRlZmluaXRpb25z
IGZvciBib3RoIGVNTUMgYW5kDQo+ID4gU0RISTAgKGVtbWNfcGlucywgc2RoaTBfcGlucywgYW5k
IHNkaGkwX3BpbnNfdWhzKSBsZWFkaW5nIHRvDQo+IA0KPiBUaGF0IHNob3VsZCBiZSBmaW5lLCBh
cyB0aGUgcGFyZW50cyBvZiB0aGVzZSBzdWJub2RlcyBkbyBoYXZlDQo+IGRpZmZlcmVudA0KPiBu
YW1lcz8NCg0KVGhhdCdzIHdoYXQgSSBvcmlnaW5hbGx5IHRob3VnaHQgYXMgd2VsbC4NCg0KPiAN
Cj4gPiB0aGUgYmVsb3cgaXNzdWU6DQo+ID4NCj4gPiBwaW5jdHJsLXJ6djJtIGI2MjUwMDAwLnBp
bmN0cmw6IHBpbiBQOF8yIGFscmVhZHkgcmVxdWVzdGVkIGJ5DQo+IDg1MDAwMDAwLm1tYzsgY2Fu
bm90IGNsYWltIGZvciA4NTAyMDAwMC5tbWMNCj4gPiBwaW5jdHJsLXJ6djJtIGI2MjUwMDAwLnBp
bmN0cmw6IHBpbi0xMzAgKDg1MDIwMDAwLm1tYykgc3RhdHVzIC0yMg0KPiA+IHJlbmVzYXNfc2Ro
aV9pbnRlcm5hbF9kbWFjIDg1MDIwMDAwLm1tYzogRXJyb3IgYXBwbHlpbmcgc2V0dGluZywNCj4g
cmV2ZXJzZSB0aGluZ3MgYmFjaw0KPiANCj4gVG8gbWUsIHRoYXQgc291bmRzIGxpa2UgYSBidWcg
aW4gdGhlIHBpbmN0cmwgY29yZS4NCj4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KSSBh
bSBub3Qgc3VyZSBpZiB0aGlzIGJlaGF2aW91ciBpcyBpbnRlbmRlZCBvciBub3QsIEknbGwgcHJv
YmFibHkNCmhhdmUgYSBkZWVwZXIgbG9vayBpbnRvIGl0IGxhdGVyIG9uIGlmIEkgaGF2ZSB0aW1l
LCBidXQgcmlnaHQgbm93DQood2l0aCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGluZ3MpIHRoaXMg
cGF0Y2ggaXMgbmVjZXNzYXJ5Lg0KSXQgZG9lc24ndCBodXJ0IHRvIGhhdmUgdW5pcXVlIG5hbWVz
IGZvciBzdWJub2RlcywgYW5kIGxvb2tpbmcNCnRocm91Z2ggUmVuZXNhcyBkZXZpY2UgdHJlZXMs
IHRoZSBuYW1lcyBmb3IgdGhlIHN1Ym5vZGVzIGFyZQ0KdW5pcXVlIGZvciB0aGUgb3RoZXIgcGxh
dGZvcm1zLg0KDQpCeSB0aGUgd2F5LCBJIGRpZG4ndCBzZWUgdGhlIHByb2JsZW0gd2hlbiBJIHRl
c3RlZCB0aGUgb3JpZ2luYWwNCnBhdGNoIChJIHN0aWxsIGhhdmUgdGhlIGxvZ3Mgb2YgdGhlIG9y
aWdpbmFsIHRlc3RpbmcsIHRoYXQgd2FzIGJhc2VkDQo2LjIuMC1yYzMrLCBhbmQgYWxsIHdhcyB3
b3JraW5nIHdlbGwpLCB0aGVyZWZvcmUgaXQnZCBiZSBnb29kIHRvIGxvb2sNCmZ1cnRoZXIgaW50
byB0aGlzIGxhdGVyIG9uLCBmb3IgZnV0dXJlIHJlZmVyZW5jZS4NCg0KQ2hlZXJzLA0KRmFiDQoN
Cj4gDQo+ID4gVGhpcyBjb21taXQgZml4ZXMgdGhlIHByb2JsZW0gYnkgbWFraW5nIHRoZSBuYW1l
cyBmb3IgdGhlDQo+ID4gcGluY3RybCBzdWJub2RlcyBvZiBlTU1DIGFuZCBTREhJMCB1bmlxdWUu
DQo+ID4NCj4gPiBGaXhlczogYjZjMGJlNzIyYjBjICgiYXJtNjQ6IGR0czogcmVuZXNhczogcnp2
Mm1ldmsyOiBBZGQgdVNEIGNhcmQNCj4gYW5kIGVNTUMgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+
ID4gLS0tDQo+ID4gIC4uLi9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I5YTA5ZzAxMS12Mm1ldmsy
LmR0cyB8IDE2ICsrKysrKysrLS0tLS0NCj4gLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9yZW5lc2FzL3I5YTA5ZzAxMS12Mm1ldmsyLmR0cw0KPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwMTEtdjJtZXZrMi5kdHMNCj4gPiBpbmRleCAzOWZl
M2Y5NDk5MWUuLjExYzVjZmZlYTVhNSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlbmVzYXMvcjlhMDlnMDExLXYybWV2azIuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9yZW5lc2FzL3I5YTA5ZzAxMS12Mm1ldmsyLmR0cw0KPiA+IEBAIC0xNjcsNyArMTY3
LDcgQEAgJmkyYzIgew0KPiA+DQo+ID4gICZwaW5jdHJsIHsNCj4gPiAgICAgICAgIGVtbWNfcGlu
czogZW1tYyB7DQo+ID4gLSAgICAgICAgICAgICAgIGRhdGEgew0KPiA+ICsgICAgICAgICAgICAg
ICBlbW1jX2RhdGEgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxSWlYy
TV9QT1JUX1BJTk1VWCgwLCAwLCAyKT4sIC8qDQo+IE1NREFUMCAqLw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDxSWlYyTV9QT1JUX1BJTk1VWCgwLCAxLCAyKT4sIC8qDQo+
IE1NREFUMSAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxSWlYyTV9Q
T1JUX1BJTk1VWCgwLCAyLCAyKT4sIC8qDQo+IE1NREFUMiAqLw0KPiA+IEBAIC0xNzksNyArMTc5
LDcgQEAgZGF0YSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcG93ZXItc291cmNlID0g
PDE4MDA+Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
IGN0cmwgew0KPiA+ICsgICAgICAgICAgICAgICBlbW1jX2N0cmwgew0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHBpbm11eCA9IDxSWlYyTV9QT1JUX1BJTk1VWCgwLCAxMCwgMik+LCAvKg0K
PiBNTUNNRCAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxSWlYyTV9Q
T1JUX1BJTk1VWCgwLCAxMSwgMik+OyAvKg0KPiBNTUNMSyAqLw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHBvd2VyLXNvdXJjZSA9IDwxODAwPjsNCj4gPiBAQCAtMTk3LDcgKzE5Nyw3IEBA
IGkyYzJfcGluczogaTJjMiB7DQo+ID4gICAgICAgICB9Ow0KPiA+DQo+ID4gICAgICAgICBzZGhp
MF9waW5zOiBzZDAgew0KPiA+IC0gICAgICAgICAgICAgICBkYXRhIHsNCj4gPiArICAgICAgICAg
ICAgICAgc2QwX2RhdGEgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxS
WlYyTV9QT1JUX1BJTk1VWCg4LCAyLCAxKT4sIC8qDQo+IFNEMERBVDAgKi8NCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8UlpWMk1fUE9SVF9QSU5NVVgoOCwgMywgMSk+LCAv
Kg0KPiBTRDBEQVQxICovDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPFJa
VjJNX1BPUlRfUElOTVVYKDgsIDQsIDEpPiwgLyoNCj4gU0QwREFUMiAqLw0KPiA+IEBAIC0yMDUs
MjAgKzIwNSwyMCBAQCBkYXRhIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwb3dlci1z
b3VyY2UgPSA8MzMwMD47DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4NCj4gPiAtICAgICAg
ICAgICAgICAgY3RybCB7DQo+ID4gKyAgICAgICAgICAgICAgIHNkMF9jdHJsIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8UlpWMk1fUE9SVF9QSU5NVVgoOCwgMCwgMSk+
LCAvKg0KPiBTRDBDTUQgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
UlpWMk1fUE9SVF9QSU5NVVgoOCwgMSwgMSk+OyAvKg0KPiBTRDBDTEsgKi8NCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwb3dlci1zb3VyY2UgPSA8MzMwMD47DQo+ID4gICAgICAgICAgICAg
ICAgIH07DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgY2Qgew0KPiA+ICsgICAgICAgICAgICAg
ICBzZDBfY2Qgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxSWlYyTV9Q
T1JUX1BJTk1VWCg4LCA3LCAxKT47IC8qDQo+IFNEMENEICovDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcG93ZXItc291cmNlID0gPDMzMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0K
PiA+ICAgICAgICAgfTsNCj4gPg0KPiA+ICAgICAgICAgc2RoaTBfcGluc191aHM6IHNkMC11aHMg
ew0KPiA+IC0gICAgICAgICAgICAgICBkYXRhIHsNCj4gPiArICAgICAgICAgICAgICAgc2QwX3Vo
c19kYXRhIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8UlpWMk1fUE9S
VF9QSU5NVVgoOCwgMiwgMSk+LCAvKg0KPiBTRDBEQVQwICovDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPFJaVjJNX1BPUlRfUElOTVVYKDgsIDMsIDEpPiwgLyoNCj4gU0Qw
REFUMSAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxSWlYyTV9QT1JU
X1BJTk1VWCg4LCA0LCAxKT4sIC8qDQo+IFNEMERBVDIgKi8NCj4gPiBAQCAtMjI2LDEzICsyMjYs
MTMgQEAgZGF0YSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcG93ZXItc291cmNlID0g
PDE4MDA+Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
IGN0cmwgew0KPiA+ICsgICAgICAgICAgICAgICBzZDBfdWhzX2N0cmwgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHBpbm11eCA9IDxSWlYyTV9QT1JUX1BJTk1VWCg4LCAwLCAxKT4sIC8q
DQo+IFNEMENNRCAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxSWlYy
TV9QT1JUX1BJTk1VWCg4LCAxLCAxKT47IC8qDQo+IFNEMENMSyAqLw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHBvd2VyLXNvdXJjZSA9IDwxODAwPjsNCj4gPiAgICAgICAgICAgICAgICAg
fTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBjZCB7DQo+ID4gKyAgICAgICAgICAgICAgIHNk
MF91aHNfY2Qgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxSWlYyTV9Q
T1JUX1BJTk1VWCg4LCA3LCAxKT47IC8qDQo+IFNEMENEICovDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcG93ZXItc291cmNlID0gPDE4MDA+Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0K
PiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBH
ZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLQ0KPiBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVy
c29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYg
YQ0KPiBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVz
dCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
