Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027895BC60D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiISKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiISKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:06:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0012638;
        Mon, 19 Sep 2022 03:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBIJA2QowA6i+xoDyz5Gx5dmKfW58rJSrHH1MlGQmuQVclhqyI8iAaw+sAEnDbJFV7CLqWNYuPBkKiuj1YOeCzpyYsbESLWmv7x3GSEfY5zOqwBlPuxMmR25iYtOF7Dd49biFvIPsd9eS20eGD4fNNip0vfNS5AB1ODFdEzI4RNL4U8+qfNWJGtINwSH5adPkbs962MUhw9pgDCtGPkDCupfH9Zv3Pfioj8/k0BEW8sm3AGMb9RykkIUy60POL7WBx+UyAACs7pui2Xs2abiMwnYc8u0qG09OVeKAH/UfEAWrXo9rKrn0/0kq6fx66jdktiGhp6nNxt1TvaADCWWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn0HKlg6RtdEqiNOV26wXYslEy0J9cS1pOAxDOa+/24=;
 b=XDj0E2+P/RB3iMhgnmNnklBfICbTxcfgOaYOnWQu7yDdtOwexm9Tln9vKS6+wwmLRDqNT4yCsS8tlFmsR5vLek7+YPo5IFFKOcadMMkUC9eKR9tZKCviFdStpyy7quVgq+7nbIAZzpIA5oerbezoAOihBxUOGFsecQoOx110h5Ocf40DVazegkzQrQmyfAImJQwPqDstykV01h1kYDLS9Mgm4DJ1PoZnwWTx1gPAsXZicMpX7DdW39aFp8+Dh6we1gYx8Qc1W59Ax3jxFh/VfCuBtS1Rm65hQp6I4+2Qjke9sDtjmUaEyHDPxhNwaH6N95n488t/+DNSM541DOp/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0HKlg6RtdEqiNOV26wXYslEy0J9cS1pOAxDOa+/24=;
 b=o1U3Gd7pDeHOd1nxGAXo6nGikm8F0w3NeSC9eXvKblZItFtgG4tnejAmHsuSFZw+Y917w3AgeCNLOAOHH/uSh4H6MUOkhVQ++dFWvDR+cA+D4K2QzcB8ACoTDTvgzkj0Ite0Nj9BbvKMqPpbWwYb0oGFvV8b23Sretjof9+AdXc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8564.jpnprd01.prod.outlook.com (2603:1096:604:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Mon, 19 Sep
 2022 10:06:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 10:06:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Thread-Topic: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling
 wdt2
Thread-Index: AQHYyD/rtz77kMV/LUKpS1dYBqhnjK3k6tOAgAGecYCAAAScQA==
Date:   Mon, 19 Sep 2022 10:06:38 +0000
Message-ID: <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
In-Reply-To: <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8564:EE_
x-ms-office365-filtering-correlation-id: 33f62ff5-cb24-4a1b-45f3-08da9a26a46b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0Drd9JQVrA+XCJ/yKh0GwSZfvCphguz8vlpCI5FaQACJ25fWc6KDQB7qZz7Jol1G9SCAEaogvQJvcjs6T6kLJg4mrFWTsUgE5GpW+wUrzAJ6s0itOkSwxcjOyiRTDKgwOqx1QMqQXd5Of3xWEHE1u4vtiHMwSnO7yx8Evh/X9kgYNX0Zwn3ak8trwVCi+qVgBGef4RxyfxGIL91pZnKvnjlDkbScqKEH2H6ym2+zxy+nkKRyP/FOjEwt70nvJhT/ZLEWIf7a+s4fKoZ9Zh44Lsi7y2E9k53lMAzoA0tHZYNBC7BB2FbcScbh94uuCWeMaeWdVcNlI/PnHGV7vVopHkfYI7ZvQZZiseOMbC1Q2tT35n+ZJxfSZsoAZw035/xSFAsAKHW3/MzRhhCZfh0XlzxG/w6K0pL/BjmJN1L2XVa9+MGa5KPjwyWa9dcFdXfR6q9w3lIS2ub/debMTEJCEj3aDPmltKRqZhTRY6yqSW5J0fJ0q9+JJFBJEViu4E9NXbngwTIMwejYkOsNSIimjcoKv7SwzBEDeFnMql5GI7xH027bYTI6YCvgLEf+O7yXs2hPzAzLmCrhl7lDawJPRfkuBpz/l1f9AhsxktZaVRGnDurtjCBAjVE7bak2V78lp65bfJa4LDc8KIImXLEk/71cdXkLH6mxIHjKiE90joA42LTbtxz9K2bpDUDdUgTFMt5cWh3AUgZUgQu+BhNLAgLczyQ78TIEDk2596dqAOqe67scz/lATkgvgF7gjHmHn3Qt6uId0OmfMS86D1sVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(66946007)(76116006)(4326008)(5660300002)(8676002)(66556008)(66446008)(66476007)(64756008)(54906003)(110136005)(86362001)(8936002)(316002)(33656002)(122000001)(38100700002)(83380400001)(52536014)(53546011)(7696005)(107886003)(41300700001)(6506007)(71200400001)(478600001)(186003)(55016003)(9686003)(26005)(38070700005)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJpTzBuWlB1VWRaMENVYXdHN3VOMXcyVTNIdkRFNWdoWUt4K1ZaWlZ1RWxM?=
 =?utf-8?B?QTNTTEE5RUhUZE5tK01Qc2N6SEdtU0Q2RkNyT3pFc083dFY1bHNScUJGcnZO?=
 =?utf-8?B?SG0zK09DMlFZWTZwSDhCNi8vMi85QmRyNURCZkNIREM2ZG1rMWJvZFVGc2VP?=
 =?utf-8?B?ajM3RjVDKzdvRTBtalNMYThxQzlEY0M3YkxLb290U3hHbndVTVhEZHVvWlBr?=
 =?utf-8?B?NlpybGlLbnNmeUR0am1mSmF2MW90b2VmNDNNZXpueTdyTXVPVXZrWUljcWJG?=
 =?utf-8?B?ejIxaEpnOHZHdVBnZW5ET29vd2lyUE1vQSt2NUdYdU5OVUdaUnZCNmR0b2RC?=
 =?utf-8?B?Q2h4VFBBeGtNOWZLRFdjWlVjRFZvR3VTWS9qYXNFU0dXakVtbUVRZWNhdXFu?=
 =?utf-8?B?TFhNQ0thM1FjMWRMeUlsUEZjYmJoejIxOXlsZzJmZmdoTzNDa0xsVDh3eUdB?=
 =?utf-8?B?L1pTQ1dBNXlJVUtlQzVheGlnbytSMVhpb2ZtN01nOGRLK1N2NjV6elYwWkNv?=
 =?utf-8?B?TEQrNDlPT0t5Y1ZzUy9sQ2dBSnRiZmFYdEcxZTZYOTk2aWkvL24yWTVVMlI0?=
 =?utf-8?B?aFNaMTUyc2ViVml0R2tUcmRBWTQ0a0dyaXNFaUFlaGFndXJPS1JiYkk2MVhZ?=
 =?utf-8?B?akl2K2FMTEgvajdvS0JDSHJncy9PUy9FeTZnQmtpQ1NqUjF3cklrZlVZeXor?=
 =?utf-8?B?MjZBMTdXVGlFWWRZajlFcGxvWUwxWStZeXNLcEM2ZmtZZUZSZ1laOVJoWmdv?=
 =?utf-8?B?M0dvTzVKTkFzTVpWaXc3UkZZUnhqM0xGKzl2WVk5UmQycU9obW1BNnhDNnZK?=
 =?utf-8?B?MXpGUG5zWklPbWRhT1ZFWGYzZ1RSN1dhVS91NHc4bnM4YWRzclZDUVFFenBV?=
 =?utf-8?B?bnBGSHZjb3NVdU1kdHJqY0lkbkZTK3UrRjRsQmxsMit2WVZZV1JNVDZUN1Bh?=
 =?utf-8?B?YjEvTldnQ0RpR09yaUVtZWNadXBtaklLYlUwc2VXK3RFb3piYjA3ZHVRUElQ?=
 =?utf-8?B?VkgwNGgzVXRvZ0JhT3FybmxiN3VxbERHMWozdGFKNGZ1NTFhT2tsdEZhVFBI?=
 =?utf-8?B?bHFOdU4wWkdtdEdNTlc5RlVzc2JCcTJYb3piNGMzR2s1Z0dENzNlQ3dMNVRl?=
 =?utf-8?B?RnVRcXlyVyt2NEhBRW5ZbVFSbFBqamFzcEx3YllCbXMvSWJEOVYxZ1JwNjJC?=
 =?utf-8?B?MU0zREhBOHhyOHU1aVNvUWxyY1dxSnFka09RL0tiZ1E4REN0bkJ6L1FoOFAr?=
 =?utf-8?B?Tk9zMWF3Qit3aUdTb1ZlaVhHSlE3aWJMSkgxVExOajVyVzFGc3EyQkdLYVZw?=
 =?utf-8?B?ZUloaHprSTVhMmJoT2FOb2RVMWU5c0xUbWFsUGNaMFl4aHFvLzdTM2YwNFR4?=
 =?utf-8?B?dU5ieEZmY0c4ekdBcVpJY0lURkdLK05STDJwV0tiM1RwbEtKb0NQYTJtQmJx?=
 =?utf-8?B?SFBoVFJJcmtpdVBmdVFhYWpJelhYK28yMlpVS3VpelcwaGVTRmpsK3V6a2xO?=
 =?utf-8?B?N0paVmIvTmx5a1JydnlFTzBZYmNNdjdjczBtWk5zSHY4Z0ptZHJYM0xPeEY1?=
 =?utf-8?B?cjNlVjQxMW43RE81YlJ2b3h6M2pPanpYbHJKZitTUEFYU05MSFZPbEhZOXJo?=
 =?utf-8?B?NUlzUTgrSEZadFRaOVBGSjRkRlErZnpINmtnYW43M3p0bThiZHhuL1EyT2l1?=
 =?utf-8?B?YUlBRkx4VjRoVzBHZElDcTBCeWhGLzhleXh4OTlIYytCK1VPNDhHdHVPaHhC?=
 =?utf-8?B?OFgvaWZWUEFiY0Rhb0VXQ20zcENoaXFmUDhTQ0xPTytoRUhYa3lFOUYwSExJ?=
 =?utf-8?B?ODNCTlc3Y2ZxNUF4WHhWZmEyNUJMTDJjVEhOUHBReE1hcU9JSjdQcGRlZXN5?=
 =?utf-8?B?M1JvVUhkVUZFdFU4SVQrQXFVa2I5SXRwR2kyTVFNY3ZhUW5jSVhwMzdIUXZj?=
 =?utf-8?B?Rk03UUhTTEhjMm1HM1RRVGE3L29kK3NaMUNZdnBjUE9xeVM5OFZ3aVdsTERt?=
 =?utf-8?B?aTlyYmkwUWlnRnRoUDY1NUk5RVlMWXBHVXZaOU1LMllpN3NUZ1NJbXR1Sklo?=
 =?utf-8?B?ZlRkemlPTjNxNVJmZlhJR2dSRG9PbGNwUzIwSWlXWjJ4Q0dNNENDVWhmd1k2?=
 =?utf-8?B?cVhNcEhSeUFteEhvd0pURFg5YUVXeU9icmFXT1VuSGlxb1VhNUVkUXpGdHVj?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f62ff5-cb24-4a1b-45f3-08da9a26a46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 10:06:38.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6DIWq2VskgFTh/DzDVUBGbs5avfihyFL2wTibRIhayCV9hoxc8xm0YYKp4hwWrXNyf7w4YCpkDQ+COUaqOAd1WV1gOEDO0AI/5w+iGVBNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8564
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
ZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4NCj4gU2VudDogMTkgU2Vw
dGVtYmVyIDIwMjIgMTA6NDgNCj4gVG86IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgt
bTY4ay5vcmc+DQo+IENjOiBNYWdudXMgRGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPjsgUm9i
IEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4g
PGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IGxpbnV4LXJlbmVzYXMtDQo+IHNv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPjsNCj4gUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpA
YnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHJlbmVz
YXM6IHJ6ZzJ1bC1zbWFyYy1zb206IERyb3ANCj4gZW5hYmxpbmcgd2R0Mg0KPiANCj4gSGkgR2Vl
cnQsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQo+IA0KPiBPbiBTdW4sIFNlcCAx
OCwgMjAyMiBhdCAxMDowNCBBTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LQ0KPiBt
NjhrLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIFNlcCAxNCwgMjAyMiBhdCAzOjQzIFBN
IFByYWJoYWthcg0KPiA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4g
RnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPg0KPiA+ID4NCj4gPiA+IFdEVCBDSDIgaXMgc3BlY2lmaWNhbGx5IHRvIGNoZWNrIHRoZSBv
cGVyYXRpb24gb2YgQ29ydGV4LU0zMyBDUFUNCj4gc28NCj4gPiA+IGRvbid0IGVuYWJsZSBXRFQy
IGJ5IGRlZmF1bHQuDQo+ID4gPg0KPiBGb3IgY29uc2lzdGVuY3kgSSdsbCBkcm9wIGVuYWJsaW5n
IFdEVDIgZnJvbSB0aGUgUlovRzJMe0N9IHRvby4NCg0KRG9lcyByZW1vdmUgdW51c2VkIGNsb2Nr
cyB0dXJuIG9mZiBXRFQyIGNsb2NrIGR1cmluZyBsYXRlIGluaXQ/Pw0KDQpJZiB0aGF0IGlzIHRo
ZSBjYXNlLCB3ZSBzaG91bGQgcmVtb3ZlIGVudHJpZXMgZnJvbSBjbG9jayB0YWJsZSBhcyB3ZWxs
Pw0KDQpDaGVlcnMsDQpCaWp1IA0K
