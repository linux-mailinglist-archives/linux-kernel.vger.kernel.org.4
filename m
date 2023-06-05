Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A672240D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjFEK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFEK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:59:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE95ED;
        Mon,  5 Jun 2023 03:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPLzMiQFTNMAYk2bfZH7OKNM/0vqoJYHdpe3TWWFKpRI6dlOUGuAvbKTPcRCW40HV/k60nVmBGTqPsdf0OgIdo09ggeuHZae9ZuMFkDLCaAyZ6rKIP1W4HdlMIU/sucdVsaHbUT+01ZdXs8uyvN1BtW7LJelbRfnh8+w1jqw8ndsBncwksbA2q5mVKW/g1fcKWJ1OcT0s9D+/d9AwSMDPfKde7vJpdXXO90Zg6t4MzEcFFah35PtR4oVdgtQX/rqNmoatgMxg3LLMo2HzPYdBC324FNDu8WQ3SxnZu8c1CTdo2NXVJmJeyF9nrmvTf95eReN+jAEu0P1Nx2ErOYU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK3xcsgF0VNEJPS5xmWvxZhwsXdjIAQxE0vUBveYvxY=;
 b=iiTtsCHSHv+gvnp4jy4q+A0z0hutxcapncuaI7sMhQ6hA37CyL6H1Ta3LNvkIz8xgfX2M59N2tfNvcKecC/DYrBP+sUszKXghCexAkoGvcSoVYCPtIf+rjGzNaHfJa8oNMEP4HMDP9WRuP+NuXs3NOduGnIqBEkf+Bf/ncJx32KEKZH6UCQa/W5dA5eciAqwMIFzEGEkufh5sNhwRi+qJYgrbhxqHoHfpSQgcBS6ehoT9M16lVuwKHU7FBk0PoJBxJ+JS+jOtQh5ugL/Ubfbq7hA0YL/nAKxZ1DgYo+/IfNJ7eV6sE263o2hwi36T8z340WV9haXqKYp/JvgoDSqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK3xcsgF0VNEJPS5xmWvxZhwsXdjIAQxE0vUBveYvxY=;
 b=Dris8lm2ZnZH3YNxF8KUCDDtCljoeih5zlDvNUnYAZRpdYGGW5WtYnzwtwbMBJ3951v9adfQoCe8carjuVGJFEAsuc2Td8pOIrvJufpcp+8gpPDMiTJYxydicTV9Pe8mj9by0Ny7YOWxFaEcTqVJJkVnanDeT7Ko/Vb2hpAR7rE=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM7PR03MB6215.eurprd03.prod.outlook.com (2603:10a6:20b:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:58:58 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:58:58 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ASoC: audio-graph-card2: parse symmetric-clock-roles
 property
Thread-Topic: [PATCH 3/4] ASoC: audio-graph-card2: parse symmetric-clock-roles
 property
Thread-Index: AQHZlTEm1GcAcSWVyk+PnLG/bl+QR697YP8AgACuEoA=
Date:   Mon, 5 Jun 2023 10:58:58 +0000
Message-ID: <wxrbvjkpwz75ig4vfixgbviedhkw7yaecy2lxex3wjirfpyvf5@eok5n6m6gyjr>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-4-alvin@pqrs.dk>
 <871qiqiw44.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871qiqiw44.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM7PR03MB6215:EE_
x-ms-office365-filtering-correlation-id: 328a4f2d-201a-46f8-3212-08db65b3dd00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqluTJqHQBZLHaFJ9DNxk6ZBxLpoIkpVF5dqxgOroMbTnYexmdZhDl/FknfVxdOBWDw2R/ow/gpeD9wkh7jApuy5FLyjIjc96ERIJj/PJz/g+PuohJxCXL4umYLF4AaW4nQBVvvUjK7H14zM/WhjQkZ9RdzJYjHIuj3PYdhQoIvhFBGicPMn0QUf5Ndydpn2uLRmLxlVkK99nVhQPZKP3jJk5ejAUphkBfBWlX0YQZjZIfFWSlGkxdTpwvqZ8pD2TdbJ0L9qk0XqA5nuAY7qcioll00FQPqTDipuhPbg75LMhCTBxuNCS0lgP/6FM0M/sOoQ8o8AFQmjEgq50Fcy2JYe4sfPQLGbPseWWHF8g3mNgfztMHT9Qh64RFITbPn1NYL+0fQdLjSnnmsLEJ8L9tDfhsnjEOSuKKMAQjTflg1x//3RpIjlfNzkRbLy9wATe95xVeGNvLCk8tAiAGOk2GJhjolkbTBISQy74BYeU8N1Im6cwHuaP0+ldVgm/kcpZ+8kgLLM6xyX6IzQ+bHdLVo3n0jItk9G14r2OYZMUkJQS3uHXEiWGoNh/pjlB8fzY4Ud4gfQETiqYohzaRvpbbKI0X687mWXlLil9D/mHyR2+wkWpfQSI9qqg4TQ5xYk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(366004)(376002)(396003)(39840400004)(451199021)(33716001)(6506007)(9686003)(186003)(26005)(6512007)(83380400001)(7416002)(6486002)(85202003)(85182001)(71200400001)(2906002)(8676002)(8936002)(54906003)(478600001)(5660300002)(38100700002)(6916009)(122000001)(86362001)(4326008)(316002)(38070700005)(41300700001)(66446008)(91956017)(66556008)(64756008)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJ2V05rWUdPWHlpKzMza0xxeU1QY1hGc01ZQ1ZBVk1RVmtzYVZqSEN4eDVR?=
 =?utf-8?B?ODNLQ21aaERzelRkc0RldkliNklONkdVTGE2TGJUaU1Oek4zY2hQZmp4ZElt?=
 =?utf-8?B?aDcxTkdCVUxtaWRaZWpYcnA4MU15TkVocE41RFFzL2ZCL1RWM1YrMWFBL09z?=
 =?utf-8?B?SkhiMEhyL0RINExyeTBKQzIwaGk0bHZockx5TWVpMlhQd1VzS05rZE8vYWVD?=
 =?utf-8?B?M01oNFZzTUJacjk2MW42Ty8yWHh3ODJGdUtZTFZkdUwxa2FLOFIrckxNc1Bj?=
 =?utf-8?B?ZXA0YVNMUisydVNLcFlwWFBPa0N5Wm1oWlFINWQ0SGdVVlpKRWlDYTRLaUgv?=
 =?utf-8?B?bXNoelB6WWZ1T2tsTEp2NzlIRnhIcXJRMEVURXkvTk1xVG5VZXVOK2k1djFL?=
 =?utf-8?B?WkUxWEtxTkxhdmpxaWxVcCtEUDQ1L0R3bHhjVlJnQi8zY3c3dmdRalN3Z2V2?=
 =?utf-8?B?dUVlMlMyQjVUaXNQVTlwaUVxS21oOG9YeFVZcWt0ZzJlcmxrM3F2My96SFdu?=
 =?utf-8?B?KzF6RWNRU3BUUlk1bHhnWVpYME9Lc0t4R1AyYitxYkYrWVdYQ3ZlMUM0VHpY?=
 =?utf-8?B?TDdwZHBEN3gyWUVlZG5aOXJBaHZPVWpIb25mNkZzUjN3K3lWa1QyRHVoVGJy?=
 =?utf-8?B?SWc0VVN2R0NCSzVjRWFhS2d2VHltQ1hoWFZoY1VGN1I2QWUwRER5QTFvM2wv?=
 =?utf-8?B?dU1UUmQ4d0lMbkcvaTBCY1Y1OTNlbG1pZjVtVzVRcHFIYmV6YStpVGVVQ1hm?=
 =?utf-8?B?OS91L21kRWZkL2Jpa3c1YzdXclBaU1RicUF4QTJDYkVUb2xZR3RlcXEwbFlZ?=
 =?utf-8?B?TXNJRGpBTDFSV0R6eE1aME9kcGhJVkJaeVpkbmQrWklMWlFWbDRTanJwMVdk?=
 =?utf-8?B?M3FlOEtzeHJFUFNiVE04MXNBRXpoZlRQbDZNVjlnMmVIVHpkZXJrNUtmWmUz?=
 =?utf-8?B?eDkrNCtjTm8yeld3NEJiblpBRmRNai9qaXAvYnoyYWF4VDAxWFk2d2JuaGxK?=
 =?utf-8?B?SGJ4RU9NRmdURVp1VmxDRVNweVVWT2dIWEhnQ0pVWkFHLzFJeTVRYStnMVNq?=
 =?utf-8?B?dThFSmtwTTJnRVVRY0NFeWdHK1hiZmhqS1FsWUU3U3FvaG4yOHNuLzUvUGFr?=
 =?utf-8?B?TUxRTllEcHVLRi91SnQza1JlZlQ0cEthTWd5R2wxMUJkWnJlSkYwOS9uLzVB?=
 =?utf-8?B?S1JXbTcva0ttS3NqL3FnY3NibUFuMkVwV05FbVVGeHlGbm1ORTc1R0RIU1lp?=
 =?utf-8?B?V1UvYUYzUDNGMzRlVW10SEV0bUNjMDE1QTYyRVlGSGNjb2pTU0wzMzVJM3Vw?=
 =?utf-8?B?djE4SVd6a3lqK3hDQXZxYWtoRVE1aUJQYWRTclhGeUk1MkNuOHVhTGNOWHpn?=
 =?utf-8?B?dlg0YytpQnI2YThFdm9OVVdiZ3E2MkE1TWVjeW12Y24xRktrVk5IQjJ5OXp3?=
 =?utf-8?B?OGpZYWxZTlRFNlBRZ2NnTlpOOTRmNTdDck5aZE5uSENYWGZTOG0xa0grT3VS?=
 =?utf-8?B?M2cwSk10eWUvVHZrSERLL0FWWkIwZExuTWFFNXJvT3A1YStJOE53ZjBJMUxF?=
 =?utf-8?B?RXFIdkdCRkFnUUJRTnZPT09zdU10bE1qRkxuM2xmeVpOL3ZIQld1L3BFYWpu?=
 =?utf-8?B?VjNCTzUvalZ4aXVZdUNZaFBkc3NyTjhhcUkxcW5TVllLK2lsUnJiZU45M3Yr?=
 =?utf-8?B?dlJjTy8zRDJGR0w2WUFuTWFmV2FLRUwvRG1JS04rb3RLcXpPTFJYeUVad3J2?=
 =?utf-8?B?bUVzK3g2ODE0ckI4aktjeTl4WmpRSjQwdjdPNTJFbm03b1RJb2ptWHU4TDMx?=
 =?utf-8?B?YnA4bEVlRGxlZVNzNmtaT3BnVitIWjlaa1k0cGt2REM1U3lnY3diMUZ2d0lM?=
 =?utf-8?B?amgvNitGeWkvSG5CV3dMS1hmZS9rc1ZNMlJkTDJBNjZ2VGYya3R1Vjg4dWUw?=
 =?utf-8?B?aUE3MFQ5MU9vNkE0Nk11REVHRWpuVnpJWGhpekNLSDNGRW9ocUtXSnNKbzFo?=
 =?utf-8?B?NzcrWUJyMzhWdnRoTWVPdG44cXVCdFhyeUdqMFV5UDZVVkVXOHNwYTY2NFVm?=
 =?utf-8?B?b2wrRHhxYml3ZTA0V0Y5UVp5T2NFeFgzakFoL1B3dzdxNU5sajBLZFlGanVI?=
 =?utf-8?Q?VZDcRPYrIJMn/y+sWnU4q7Z0t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <868F5F9A6F130F48A33A583BA46D8426@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328a4f2d-201a-46f8-3212-08db65b3dd00
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:58:58.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uX3LT1mREQDNed+LFSPa25e+BaXjnV01varBz7q7R9BY/X1BnEzLBynwFEFBQ/V4UCqt2LDsyNEG/3xDpoL6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3VuaW5vcmksDQoNCk9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDEyOjM1OjU2QU0gKzAwMDAs
IEt1bmlub3JpIE1vcmltb3RvIHdyb3RlOg0KPiANCj4gSGkgQWx2aW4NCj4gDQo+ID4gLS0tIGEv
c291bmQvc29jL2dlbmVyaWMvYXVkaW8tZ3JhcGgtY2FyZDIuYw0KPiA+ICsrKyBiL3NvdW5kL3Nv
Yy9nZW5lcmljL2F1ZGlvLWdyYXBoLWNhcmQyLmMNCj4gKHNuaXApDQo+ID4gIAkvKg0KPiA+ICAJ
ICogY29udmVydCBiaXRfZnJhbWUNCj4gPiAgCSAqIFdlIG5lZWQgdG8gZmxpcCBjbG9ja19wcm92
aWRlciBpZiBpdCB3YXMgQ1BVIG5vZGUsDQo+ID4gIAkgKiBiZWNhdXNlIGl0IGlzIENvZGVjIGJh
c2UuDQo+ID4gIAkgKi8NCj4gPiAgCWRhaWNsayA9IHNuZF9zb2NfZGFpZm10X2Nsb2NrX3Byb3Zp
ZGVyX2Zyb21fYml0bWFwKGJpdF9mcmFtZSk7DQo+ID4gLQlpZiAoaXNfY3B1X25vZGUpDQo+ID4g
KwlpZiAoaXNfY3B1X25vZGUgJiYgIWRhaV9saW5rLT5zeW1tZXRyaWNfY2xvY2tfcm9sZXMpDQo+
ID4gIAkJZGFpY2xrID0gc25kX3NvY19kYWlmbXRfY2xvY2tfcHJvdmlkZXJfZmxpcHBlZChkYWlj
bGspOw0KPiA+ICANCj4gPiAgCWRhaV9saW5rLT5kYWlfZm10CT0gZGFpZm10IHwgZGFpY2xrOw0K
PiANCj4gSG1tID8gSSdtIGNvbmZ1c2luZw0KPiBbMi80XSBwYXRjaCBoYW5kbGluZyBmbGlwaW5n
LCBhbmQgWzMvNF0gYWxzbyBoYW5kbGluZyBmbGlwaW5nLg0KPiBOb3RoaW5nIGNoYW5nZWQgPw0K
DQpZZXMsIEkgYWdyZWUgaXQgc2VlbXMgd3JvbmcuIExldCBtZSB0cnkgYW5kIGV4cGxhaW4gd2hh
dCBpcyBnb2luZyBvbi4NCg0KRmlyc3QgdGFrZSBhIGxvb2sgYXQgdGhlIG9yaWdpbmFsIHNuZF9z
b2NfcnVudGltZV9zZXRfZGFpX2ZtdDoNCg0KICAgIGludCBzbmRfc29jX3J1bnRpbWVfc2V0X2Rh
aV9mbXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBkYWlfZm10KQ0KICAgIHsNCiAgICAgICAg
ICAgIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGluayA9IHJ0ZC0+ZGFpX2xpbms7DQog
ICAgICAgICAgICBzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWk7DQogICAgICAgICAgICBzdHJ1
Y3Qgc25kX3NvY19kYWkgKmNvZGVjX2RhaTsNCiAgICAgICAgICAgIHVuc2lnbmVkIGludCBpOw0K
ICAgICAgICAgICAgaW50IHJldDsNCg0KICAgICAgICAgICAgaWYgKCFkYWlfZm10KQ0KICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KICAgICAgICAgICAgZm9yX2VhY2hfcnRkX2NvZGVj
X2RhaXMocnRkLCBpLCBjb2RlY19kYWkpIHsNCiAgICAgICAgICAgICAgICAgICAgcmV0ID0gc25k
X3NvY19kYWlfc2V0X2ZtdChjb2RlY19kYWksIGRhaV9mbXQpOw0KICAgICAgICAgICAgICAgICAg
ICBpZiAocmV0ICE9IDAgJiYgcmV0ICE9IC1FTk9UU1VQUCkNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAvKiBGbGlw
IHRoZSBwb2xhcml0eSBmb3IgdGhlICJDUFUiIGVuZCBvZiBsaW5rICovDQogICAgICAgICAgICBk
YWlfZm10ID0gc25kX3NvY19kYWlmbXRfY2xvY2tfcHJvdmlkZXJfZmxpcHBlZChkYWlfZm10KTsN
Cg0KICAgICAgICAgICAgZm9yX2VhY2hfcnRkX2NwdV9kYWlzKHJ0ZCwgaSwgY3B1X2RhaSkgew0K
ICAgICAgICAgICAgICAgICAgICByZXQgPSBzbmRfc29jX2RhaV9zZXRfZm10KGNwdV9kYWksIGRh
aV9mbXQpOw0KICAgICAgICAgICAgICAgICAgICBpZiAocmV0ICE9IDAgJiYgcmV0ICE9IC1FTk9U
U1VQUCkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICAg
ICAgfQ0KDQogICAgICAgICAgICByZXR1cm4gMDsNCiAgICB9DQoNCi4uLiB3aGljaCBpcyBjYWxs
ZWQgYnkgdGhlIGNvcmUgaW4gc29jX2luaXRfcGNtX3J1bnRpbWU6DQoNCiAgICBzdGF0aWMgaW50
IHNvY19pbml0X3BjbV9ydW50aW1lKHN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAq
cnRkKQ0KICAgIHsNCiAgICAgICAgICAgIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGlu
ayA9IHJ0ZC0+ZGFpX2xpbms7DQogICAgICAgICAgICAvKiAuLi4gKi8NCg0KICAgICAgICAgICAg
c25kX3NvY19ydW50aW1lX2dldF9kYWlfZm10KHJ0ZCk7DQogICAgICAgICAgICByZXQgPSBzbmRf
c29jX3J1bnRpbWVfc2V0X2RhaV9mbXQocnRkLCBkYWlfbGluay0+ZGFpX2ZtdCk7DQogICAgICAg
ICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KDQogICAgICAg
ICAgICAvKiAuLi4gKi8NCiAgICB9DQoNCkZyb20gdGhlIGFib3ZlIEkgY29uY2x1ZGUgdGhhdCB0
aGUgY2xvY2sgcm9sZSBleHByZXNzZWQgYnkgZGFpX2xpbmstPmRhaV9mbXQgaXMNCiJhcyBhcHBs
aWVkIHRvIHRoZSBjb2RlYyIsIGkuZS4gc25kX3NvY19ydW50aW1lX3NldF9kYWlfZm10IGRvZXMg
bm90IGZsaXAgdGhlDQp2YWx1ZSBiZWZvcmUgYXBwbHlpbmcgaXQgb24gdGhlIGNvZGVjIHNpZGUu
IFdoZW4gYXBwbHlpbmcgaXQgdG8gdGhlIENQVSBzaWRlLA0KdGhlIHJvbGVzIGFyZSBmbGlwcGVk
Lg0KDQo+IA0KPiBDdXJyZW50IFNORF9TT0NfREFJRk1UX3h4X3h4IGFyZSB2ZXJ5IGNvbmZ1c2Fi
bGUsDQo+IGZyYW1ld29yayBhbmQgZHJpdmVyIGFyZSBkaWZmZXJlbnQgKGZsaXBwZWQpLg0KPiBh
bmQgYWxzbywgYXVkaW8tZ3JhcGgtY2FyZDIgaXMgdXNpbmcgaW50dWl0aXZlIERUIHNldHRpbmdz
DQo+IChuZWVkIGZsaXAgZm9yIENQVSkuDQoNCk5vdyBjb25zaWRlciBhdWRpby1ncmFwaC1jYXJk
Mi4gRXhjZXB0IGZvciBEUENNIGJhY2tlbmRzLCBpdCBhbHdheXMgcGFyc2VzIHRoZQ0KREFJIGZv
cm1hdCBvbiB0aGUgQ1BVIHNpZGUuIFNpbmNlIGRhaV9saW5rLT5kYWlfZm10IGlzIGZsaXBwZWQg
YnkgdGhlIEFTb0MgY29yZQ0Kd2hlbiBhcHBseWluZyBmb3JtYXQgdG8gdGhlIENQVSwgY2FyZDIg
aXMgZmxpcHBpbmcgdGhlIHBhcnNlZCB2YWx1ZSBiZWZvcmUNCnN0b3JpbmcgaXQgaW4gZGFpX2xp
bmstPmRhaV9mbXQgc28gdGhhdCBpdCBpcyBjb3JyZWN0Lg0KDQogIGF1ZGlvLWdyYXBoLWNhcmQy
IC0uDQogICAgICAgICAgICAgICAgICAgICB2IA0KDQogICAgICAgICAgICAgICAgICAgIC0xICog
LTEgPSAxDQogIA0KICAgICAgICAgICAgICAgICAgICAgICAgICBeDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICctIEFTb0MgY29yZQ0KDQpCdXQgd2l0aCBwYXRjaCAyLzQgb2YgdGhpcyBzZXJp
ZXMsIHN5bW1ldHJpY19jbG9ja19yb2xlcyA9PSAxIG1lYW5zIHRoYXQgdGhlDQpBU29DIGNvcmUg
ZG9lc24ndCBmbGlwIGl0LiBJbiBmYWN0LCBpdCBtZWFucyB0aGF0IHRoZSByb2xlIGlzIHRoZSBz
YW1lIGJvdGggImFzDQphcHBsaWVkIHRvIHRoZSBjb2RlYyIgYW5kICJhcyBhcHBsaWVkIHRvIHRo
ZSBDUFUiLiBTbyBubyBmbGlwcGluZyBzaG91bGQgaGFwcGVuLA0KbmVpdGhlciBpbiBjYXJkMiBu
b3IgaW4gQVNvQyBjb3JlLiBDUFUgYW5kIGNvZGVjIGNsb2NrIGNvbnN1bWVyL3Byb3ZpZGVyIHJv
bGVzDQphcmUgc3ltbWV0cmljLiBlLmcuIGlmIENQVSBpcyBhIGJpdGNsb2NrIGNvbnN1bWVyIHRo
ZW4gc28gaXMgdGhlIGNvZGVjLCBhbmQNCm5vdGhpbmcgbmVlZHMgZmxpcHBpbmcuDQoNCkkgaG9w
ZSB0aGF0IGlzIGNsZWFyIG5vdy4NCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
