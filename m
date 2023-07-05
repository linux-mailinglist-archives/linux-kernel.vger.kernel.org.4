Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DBC7488C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjGEQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGEQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:00:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2113.outbound.protection.outlook.com [40.107.105.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590691731
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipI1P+FsiNFr9c0BEcdyZQrLjJL8pX/h9zQ7lQmP/Mt25U124Kyx0bw8kvuOtCMqR56hBanBqgjDjvDMEIuyKGmG6kyt2gczf8KsJruXQdbQ3weFaaaJ4w4d5WF7AhDE0xje0KDM8Feudhvo/hZH8RPv4vExtK2ziB9kZg//DIGcW6XNlhMBvagzDl0HrMBVhM7FSco+zkABIAUlV15vgrqGUmtEWoP601PRLVEx/mqXjLZaacAmWhXja4TI0CzkjXHhB6VSfh9Hs3G/2QaHF2gGKcRnAyK0Kbdj6tbeOrtDCjJPRuPUDrFJwu0lKaRe4lFDb5xem2aZDOR/iM926g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N5ZW3J8LbccRIitUMMKlMr5xBhCP/SXUJi+sIpEclU=;
 b=ilASd5eCzkaJgd8a0XBB9Elw1nUD77RACsT1jId+rao2Isfb4ZMpZp4/9zaIVYlVjV2Om0iFDaEp8ZyvgyOv6alcEZW61382toZiVRSy1CjDtz/Y5gF33duReqFcRLkDFIqg96BNApHXKBwyso+0tMeoCHw+mo5PShzPl/6yR5MAqBHbQs03pE5CP2/r7ztmmXaH4sQnM8XzFis53hKIzr1ZE507W3su1BJx0IqiwTeH9AqrwgVyi8u7k1ej21HuVNYx0Eqzmy8TilhpulGsc9qBgyraP8dtibOsauohQAes38/nDwxxoavx2CyXudYfCUJFMtCVX1N8+fVqkETv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N5ZW3J8LbccRIitUMMKlMr5xBhCP/SXUJi+sIpEclU=;
 b=WPTz2MvXXh+jz4KbIRtmYJr3RsyqZq+qIHPplrGO9HUuLo/Y21WUI2cfxqNbMMO8MLZ5+GreVD+WQPGwMCJ2+KN6yPh3B0ZsCnTCDk7D9ZL9paoA1VTX1dK0Y+0ea7qhDNKog3bUvCl7c8WtGBgaiF8lG8fhwfaM2ZfdqbMLZaI=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by AM0PR06MB6356.eurprd06.prod.outlook.com (2603:10a6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 15:59:17 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::95b6:78c2:f761:e282]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::95b6:78c2:f761:e282%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 15:59:17 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Michael Walle <michael@walle.cc>
CC:     "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr0Cz0dcPn5O190iV8EdZpHnC5a+rKNuAgAAr8YA=
Date:   Wed, 5 Jul 2023 15:59:17 +0000
Message-ID: <7c9b7191-0f43-3eff-3b35-d33b046d5bd0@leica-geosystems.com>
References: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
 <419d80f252f12f091b9c555da0965c84@walle.cc>
In-Reply-To: <419d80f252f12f091b9c555da0965c84@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|AM0PR06MB6356:EE_
x-ms-office365-filtering-correlation-id: 8f771ad8-ba33-4dbd-4a03-08db7d70c998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Sk7GKZpdqihJXztCeyYIM2wpqfH7l/toLl/7VH4uLuS1CE6CU7zvwqiHj16Q2OGxCb498/rUOynd1rP7mmeDt8fxtOFFfgzzM5kwoXWJLyVKQKPvzyHxg2UcLmSJ5Y40xTtDBQJ9Eq+yIjt0vQK9WgX6vh7m8SQvGc9DXeMXPY8Isbd1pTPienK2vAyLEeqqI8PPAQSs+LUFKCnosptvLIlU9nHGjzyWYbxiLqdfRrvfHTxqyH+Vr6fkaunJqdp13Yo3bZtOhRyLdpwZLJr2NneQfw8WHUq5xhYzd/E5S7WBPnv6R2qJwQnuGPaY8cGv/Vhk81rNvMTkrTiur3Ui0ZbMtmptdsryl1I49r2lcJydztcGEi4a3n/ql3iHGQ37p7wykjU3QHkWJlPRFbQMHwJ/sghW18Qvt8DjTa/6BvqOiemMu+FfgY3bBllmSsZ8TZQp16R0kAIzDRIF4JFAhVQdn/HF8hoIMnNxCyI+T96AnF+VH2ChCuF0RmKyjoja6bgei3OG3A7GsKBeZ9Kx42CmhqBGxSsW2wtcIAde2kepZWuMixcSfCcqeMwZv+G1/w+lt8xXzpZQOdY0lwQhdVj5zgbjTyYGefXMRV3QI97aBXSkuo5LW00uf/pfsngtRjyThFSWQcYhfXxS1UNcHANrvabTYd1fTLmCQhvQ9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(8936002)(8676002)(31686004)(83380400001)(41300700001)(5660300002)(2906002)(316002)(2616005)(122000001)(66946007)(6916009)(38100700002)(91956017)(76116006)(4326008)(66446008)(66476007)(64756008)(66556008)(6512007)(86362001)(186003)(54906003)(478600001)(53546011)(26005)(107886003)(6506007)(36756003)(45080400002)(31696002)(6486002)(966005)(38070700005)(71200400001)(138113003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHRPRUVhcnpJUlBuYmp0NnZ5dEJlVUhHZmF3QStJYjArZVlsYnBHd01xWWF6?=
 =?utf-8?B?QjJrQjArZUhMajN5YzkvdXdONWtUTzVNL2VDMFJmV2tnR0FLMUNURUVNRlRL?=
 =?utf-8?B?ek5lTGxZdFdLMEVsc3V6bE1kd21UazJtUXdmSmVZMWFYRDZTV3lMUWZNa0Fj?=
 =?utf-8?B?Y0pYM0E2RDdZQW1vWjRWMHJSLzFzMUt1K1k3Y0dFMFUxYXIzYWx6ekc3aGMy?=
 =?utf-8?B?WlQ2cXBscSs0QVlLQ2pCbHRadXlacytEb2VkM3U5RW1jSVRqUkYxTHU3UTRC?=
 =?utf-8?B?bjczSVY2STVyL292b1RFT3oxd3l2VGZNalhwOEpTWTFyOWtoQVRON0xIcUVB?=
 =?utf-8?B?aHZaYmZKMjcvRGFPb1FVSGk4OHdXRXV3bnp0NUlpNm95TnJVY2NVbk9USWJY?=
 =?utf-8?B?ZENrdzh3SEVERUt0NFlkMFRTUlRqR05KeUg3WE0zaU1nTXMwSStyaUkzcGdQ?=
 =?utf-8?B?VE1mSjMrM3VPZjQ5VUV6ckFZUHpDbUJ4NHZoL3U5MUxrM0hzcXJUdnhPd0c1?=
 =?utf-8?B?RFhSb3V0NitIaFI1K3oyWXorR0tUKzkrVDFFOG9Cd0MrMGNjNkFpYlVoNUUy?=
 =?utf-8?B?UTJRNElReVJSMWJKSXozSG1NSitidzVlOTA2YmMva2RJYUYzTWRIU1I1VlBz?=
 =?utf-8?B?WXVtZmhkd2dJaVZqcXgxM0Nla2RVeUVQS2VTSFZUTXhyelNHYllNbzQ0RmdS?=
 =?utf-8?B?cnY3OVgwSmVlMCtJZVE4bWZsTWoyeVkvNDk0VDhvdHNyc0ZxekJVZmJFTDBT?=
 =?utf-8?B?eXdjZHJud0g1NENlbmV2azROMkx5blpGR2MwWXE1VGpsMzdpY0ZGWFpBZjUw?=
 =?utf-8?B?Y1l1MGU0WUtWN1B2cWJFY0pBNTZZcmNtWUFkQXNXSElXd1BuM3J6elkyUHVr?=
 =?utf-8?B?MGpUV1MrYVFuQ2pIakd3NDQ2MTR1ekNVbGRGMFBKeGRwRjVWWWYrQlhKYzN3?=
 =?utf-8?B?aDZQUC9GVlBmOUR4YmFQbnlPcFNROEdDMlFaUjZWQnloMjAvMjNiTkd3TTB4?=
 =?utf-8?B?bVFmUWFIb2hlNWdhc2NMQzVZdzJrd0E1RER4dHdWSUI4WWJjQjZRWjdGMWVF?=
 =?utf-8?B?cXp2SDJ5ZjJDeG93Ny9uUVRpWlpoaEdnZ1NhVEd2V3NnUE56Zm1WRWM1ODVN?=
 =?utf-8?B?NG5qNStnOEYreG1aVnZtQ3dRVEZaU0RBZUdPN0ZXZzBYTUQrUnAvSGkrSHhx?=
 =?utf-8?B?dWVSNHBkUzRWYjZPMURuODgyR2RIVmtYSlJBNGdxb3hJQW1DbTU2RHcwNU92?=
 =?utf-8?B?SXNLcXppMFh2aWVDakZBTlhBWU0vY1VNcjlZMVRDZnBpRG5Xd3h6emsrVlhT?=
 =?utf-8?B?R04wbFU5aXBnQ3hwcExycGJ3WFNpOXhTOGVGOXRjMzR3aWRwYkVBTTN1U2p4?=
 =?utf-8?B?aHZQL2U0bHkzQTVKcVh6UHVQY1V0anhhUlh4eUJiTkJBeHNSRTNxV3Q1MlRy?=
 =?utf-8?B?a1ZabXdYWEVYRWNUQ1ZaNVRwT3ZweFNmRWhDZk5jYW4vZWQ0Wjl4MGo5UVhr?=
 =?utf-8?B?c2hXbVdTSFdWSzFlaFN6OTdVRW93OTUvbm9tN3N6ZStIZDF0YTVSMTh0Q1k0?=
 =?utf-8?B?Z0crOS92UElGcTZ2aEZRaEx6Yk1pVjVpY1h3WHRaS3U1VTJIU1E2QWR6U21h?=
 =?utf-8?B?Mkc1clBSdWRvRWVqMEJSOWpEdDA1SlV3MmpuUUxtYXZ4SncwUk12ajQ1YVZJ?=
 =?utf-8?B?VWhhM3NPZ2NRQ2lWejhiNDZObU5sdVg2YWJuNy9tMFBNakIyeHNPREdWanJK?=
 =?utf-8?B?RXdsMzhRWkNvRDEwMTkrKzFjaWt1L3BmUEhVSzNkOTZBUWN2aHpmTTU0TjB0?=
 =?utf-8?B?M0xiL3NVOHVmcW8wU0t6cWp5WU05blcyeDJOdXlwR3Nnc2hMZWtlN0djc25z?=
 =?utf-8?B?QmIrSUFlTjUrb3RQTUhIdVladm1VZjhpZFVYVHBtakc1VFhFZm5jcDZZOHZm?=
 =?utf-8?B?WmF6OUp2Z2YvR2s5d0toeE9SdEtCK01GZ2N4a0FsQTJrbWdEZzdaSFZ3TUJj?=
 =?utf-8?B?MGxXeENZUXVvS1RDYU0yYlRkWEdXVTV5R3F5Qm0xL1lIamFnRnJPWDNwSU5Y?=
 =?utf-8?B?bk9Pc2NTSERhWmtmaUJreXNhZm53QlhhK212bDhPeE9SY2IvZG0wMGVkS0FX?=
 =?utf-8?B?VzFiZllCQy8vb3BidXJ3RTFJTWpIcVBqR1JVaFg5dHBualZBZFNGOVVwTUxH?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <272F5A405E591945B55BE874FAD9A17F@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f771ad8-ba33-4dbd-4a03-08db7d70c998
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 15:59:17.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3wh9CAHlrazdpuMg7qEptfTZXwoshkB1tdb8KO7FaOScQDrgzDpA53ty3Fz4rw5FKrbWmJXyVdFrZJZA/b/+bGkb1x4NbKxysyqpQAwX2T+kYZSbIhh2ijvTyobD3Ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbyBNaWNoYWVsLA0KDQpPbiAwNS4wNy4yMyAxNToyMiwgTWljaGFlbCBXYWxsZSB3cm90
ZToNCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3Rh
bmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCANCj4gd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcg
YXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+IA0KPiANCj4gQW0gMjAy
My0wNy0wNSAxNTowMCwgc2NocmllYiBNYW10YSBTaHVrbGE6DQo+PiBtdDI1cXU1MTJhWzFdIHN1
cHBvcnRzIGxvY2tpbmcvdW5sb2NraW5nIHRocm91Z2ggQlAgYml0cyBpbiBTUi4NCj4+DQo+PiBU
ZXN0ZWQgdXNpbmcgbXRkLXV0aWxzLSBmbGFzaF9sb2NrL2ZsYXNoX3VubG9jayBmb3IgTVQyNVFV
NTEyQUJCOEUxMi4NCj4+DQo+IA0KPj4gWzFdDQo+PiBodHRwczovL21lZGlhLXd3dy5taWNyb24u
Y29tLy0vbWVkaWEvY2xpZW50L2dsb2JhbC9kb2N1bWVudHMvcHJvZHVjdHMvZGF0YS1zaGVldC9u
b3ItZmxhc2gvc2VyaWFsLW5vci9tdDI1cS9kaWUtcmV2LWIvbXQyNXFfcWxrdF91XzUxMl9hYmJf
MC5wZGY/cmV2PWIyNTlhYWRjM2JlYTQ5ZWE4MjEwYTQxYzlhZDU4MjExDQo+IA0KPiBMaW5rOiB0
YWcgcGxlYXNlDQoNCkFkZGVkIGluIHYyLg0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBNYW10YSBTaHVr
bGEgPG1hbXRhLnNodWtsYUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+IC0tLQ0KPj4gwqBkcml2
ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIHwgMiArKw0KPj4gwqAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
bWljcm9uLXN0LmMNCj4+IGIvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPj4gaW5k
ZXggNGI5MTk3NTZhMjA1Li41ZDFkYzhlMGJiYmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210
ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jv
bi1zdC5jDQo+PiBAQCAtMjE4LDYgKzIxOCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hf
aW5mbyBzdF9ub3JfcGFydHNbXSA9IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1G
Ul9GTEFHUyhVU0VfRlNSKQ0KPj4gwqDCoMKgwqDCoCB9LA0KPj4gwqDCoMKgwqDCoCB7ICJtdDI1
cWw1MTJhIizCoCBJTkZPNigweDIwYmEyMCwgMHgxMDQ0MDAsIDY0ICogMTAyNCwgMTAyNCkNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRkxBR1MoU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9O
T1JfSEFTX1RCIHwgU1BJX05PUl80QklUX0JQIHwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgU1BJX05PUl9CUDNfU1JfQklUNikNCj4gDQo+IFdpdGggdGhlIGNoYW5n
ZXMgYWJvdmU6DQo+IA0KPiBSZXZpZXdlZC1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxs
ZS5jYz4NCj4gDQo+IFVucmVsYXRlZCB0byB0aGlzIHBhdGNoLCBidXQgY291bGQgeW91IHBsZWFz
ZSBkdW1wIHRoZSBTRkRQIHRhYmxlcywNCj4gc2VlIFsxXS4NCg0KQXBvbG9naWVzIGZvciB0aGUg
Y29uZnVzaW9uLiBUaGlzIHBhdGNoIHdhcyBvbmx5IGludGVuZGVkIGZvciBtdDI1cXU1MTJhIA0K
Y2hpcC4gTW9kaWZpZWQgaW4gdjIuDQoNCkhlcmUgaXMgZW51bWVyYXRpb24gbG9nIGFuZCBTRkRQ
IHRhYmxlOg0KDQpbICAyMTQuMjc1OTk1XSBBQ1BJOiBIb3N0LWRpcmVjdGVkIER5bmFtaWMgQUNQ
SSBUYWJsZSBMb2FkOg0KWyAgMjE0LjI4MTM4N10gQUNQSTogU1NEVCAweEZGRkY4RUZCQzVBMkMz
MDAgMDAwMEVDICh2MDIgQUxBU0tBIE1UMjVRVSANCjAwMDAxMDAwIElOVEwgMjAxOTA1MDkpDQpb
ICAzMTUuNDUyMTA4XSBzcGktbm9yIHNwaS1QUlAwMDAxOjAwOiBtdDI1cXU1MTJhICg2NTUzNiBL
Ynl0ZXMpDQoNCg0KeHhkIC1wIC9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaS1QUlAwMDAxOjAwL3Nw
aS1ub3Ivc2ZkcA0KNTM0NjQ0NTAwNjAxMDFmZjAwMDYwMTEwMzAwMDAwZmY4NDAwMDEwMjgwMDAw
MGZmZmZmZmZmZmZmZmZmDQpmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZlNTIw
ZmJmZmZmZmZmZjFmMjllYjI3NmINCjI3M2IyN2JiZmZmZmZmZmZmZmZmMjdiYmZmZmYyOWViMGMy
MDEwZDgwZjUyMDAwMDI0NGE5OTAwOGI4ZQ0KMDNlMWFjMDEyNzM4N2E3NTdhNzVmYmJkZDU1YzRh
MGY4MmZmODFiZDNkMzZmZmZmZmZmZmZmZmZmZmZmDQpmZmZmZmZmZmZmZmZmZmZmZmZlN2ZmZmYy
MWRjZmZmZg0KDQpjYXQgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpLVBSUDAwMDE6MDAvc3BpLW5v
ci9qZWRlY19pZA0KMjBiYjIwMTA0NDAwDQoNCmNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkt
UFJQMDAwMTowMC9zcGktbm9yL21hbnVmYWN0dXJlcg0Kc3QNCg0KY2F0IC9zeXMvYnVzL3NwaS9k
ZXZpY2VzL3NwaS1QUlAwMDAxOjAwL3NwaS1ub3IvcGFydG5hbWUNCm10MjVxdTUxMmENCg0KDQo+
IEZXSVcsIEkgbm90aWNlZCB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIE1UMjVRVSBhbmQgTVQyNVFM
IGhlcmUuIEJ1dA0KPiBJIGRvbid0IHRoaW5rIHdlIGNhbiBkbyBhbnl0aGluZyBhYm91dCBpdC4g
SXQgaXMganVzdCBhbm90aGVyIGV4YW1wbGUsDQo+IHRoYXQgdGhlIG5hbWUgaXMgbW9zdGx5IGly
cmVsYXZhbnQvY2Fubm90IGJlIHRydXN0ZWQuIFZlbmRvcnMgdGVuZCB0bw0KPiByZXVzZSB0aGUg
aWQgZm9yIGRpZmZlcmVudCAoc29mdHdhcmUgY29tcGF0aWJsZSBwcm9iYWJseSkgcGFydHMuIE1h
eWJlDQo+IHdlIGNhbiBnZXQgcmlkIG9mIGl0IGVudGlyZWx5LiBUdWRvciwgUHJhdHl1c2g/DQo+
IA0KPiAtbWljaGFlbA0KPiANCj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80
MzA0ZTE5ZjMzOTlhMGE2ZTg1NjExOWQwMWNjYWJlMEB3YWxsZS5jYy8NCg0KVGhhbmtzLA0KDQpN
YW10YQ0K
