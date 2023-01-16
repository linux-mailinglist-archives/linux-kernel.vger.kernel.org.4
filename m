Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31C166C721
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjAPQ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjAPQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:27:55 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB82CC7B;
        Mon, 16 Jan 2023 08:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvsNtx+SSWnUBGmdeuyKkxRdrSsElF45YdaxHVoPyiGQOcehsc7Z2psYwsX2PEKdOh9lMf873lhj1GO5Lh2z7gt4JqjKpFiHIpp19sPQ7y0KMwId1U8zyb/VKTT4rVvrlBSna6bnd/b98EehjUDAb2r4aI2tPp3ROvKF4yGBho3E4syzsH4F6Y9Gc1H50FbVwwXkITrtdB05K9rbrjNWn/LPwflgHMz2CnCnQH09fD9OcA+Vm/SDNGaZax2SsTcEqwCPiC1XwkzBDb3SOV7gxkl4otRSXiSCPYM3BkKOqsT5p3IIye/GcdZU597DbnTYdqElqp8V7O/PpEn7qae7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxv+dPh+bOQwgoJkkFP8JRBfnL+PFPHZ99qYcR9zRpY=;
 b=FXLJaVeItSQMMJtz5tX3cXKjG7Y4niB2Al8k5zNFSAE2qjhZvo38CMEOhpJDQHnHvKXxZ31TtPp8o2K6IvJcYThGc6t8/M7qkQKeKuLE8W9siah3DfOVQrcurJCT4wn1et2w9aR9ob2Uri4nfUacHC9FHzDVtCWgXwhMFT2ougDI/nZ5v5yBZajWUnpB5/FI02Pkxd9iR3rSRGBWm07u6vEXVRHeircUb6jjPFAwxYdYeDbAd53xTPYpLmY8pUd3f1GzbhvGD9++uKPrNegV6z+F80h8xOx+xK/FrhviRQG7ntgQrRp+0t949d/fPnW4HF3Ikv1LaJKfDTVbnB4nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxv+dPh+bOQwgoJkkFP8JRBfnL+PFPHZ99qYcR9zRpY=;
 b=SL1tU+cIm0wFILXHfuQwU/cJGTwhyMOlLnDqZ2F6R5Ugxk6UuNL7/OV/pfJqf/cbQJc5mnBHtY0UXs9c1x5sprnQpFlAs1O0G57osvG4W5+h/3o6mJrG9YVHjbAklRG/sLcz83k1Z8W2yCi87PomXRFIO4Rk2GmfCc/7eMVGWaM=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB10809.jpnprd01.prod.outlook.com (2603:1096:400:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 16:16:06 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:16:06 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@kernel.org>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Topic: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Index: AQHY8skVBomaV6jUGEK4jsDHAveVPa4zyxuAgG3aDjA=
Date:   Mon, 16 Jan 2023 16:16:06 +0000
Message-ID: <TYWPR01MB8775AA3197A830F8769C01F4C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
 <20221107165027.54150-2-fabrizio.castro.jz@renesas.com>
 <b5f881b7-1f59-623a-a126-d7827dec85fe@linaro.org>
In-Reply-To: <b5f881b7-1f59-623a-a126-d7827dec85fe@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB10809:EE_
x-ms-office365-filtering-correlation-id: 27404065-2861-4a0b-34c1-08daf7dcf8cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KejuE3ZD+CkeKtut8N/Qagop7FD6vshOTyhv06PCtfr9NBQPavi+al8k+8oRFMQj4XYLmaoQiMG/MgfD0J9H0GGAwtF4LAW+ptj6EUGFkpNrLjKFUJFyC9KCh/vRV2Poet8tJ0ZepOKwKNrvNztginp7zWnkpiwDKH+u1jIENyM5e/Tn/urVo3n57ngDY2ak4/NweacZfVGkQ/AjJEqomfrZud6vB31baFjC+hyDfJJWE9dO6xbVVHtpnWR+0jSTI4zrf5wjJDHJgSLn8M+2hyRRdykOZdNu2JOD2RmiUlnXchkXY+waDW+E1/XGfLoIGBp8Bi5NUPHJhbm4WGDkqw3Kwo1UX9VJ3yVXQKRyo6nxXvhqHv6Edn8f+/HnE6Bv0+zvJ6OwRaE6iFrPcaPhctLcgRtj2v5kAhphjTH/rVFabTes8Y0Vh7AQz9sHw9XPSWlqHt2b9lW05yOROIfKknlAbW+8zvgDHjHiHSgLVG5VwKJ1peNGPgCnhrSZ+KhkZIPTlpMdsQA9zJsJqqzBAjaruNvuxjwKl7zSBFEiY8p8kb2/964U2RMlHiaOvxwrDlwX8i6KTOzGeQmtZlBRjfxab+wJs+MJYx3TiA4zYgnmhtBxy4Nkl2ff9p7eFERq30Yj69ZLrLdQ+zNq4aB8qHq+9IguOUzn3ih0jT5OvCOtkhsAUaOwZr3b/vqejxtBhTgVqVUHmrCDnZG/t42M+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(8936002)(76116006)(86362001)(66446008)(66476007)(64756008)(52536014)(66946007)(83380400001)(8676002)(4326008)(38070700005)(55016003)(33656002)(122000001)(38100700002)(5660300002)(110136005)(478600001)(66556008)(7416002)(41300700001)(7696005)(2906002)(54906003)(9686003)(6506007)(53546011)(26005)(186003)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjdxV1RqZ2U5QXhReWpqSzlyWUNVYzhUNSt6UE56akt2OUZmNjdyZHN4V05s?=
 =?utf-8?B?QnJ2RENONC9Yb1ZXclJSZnY1WXdtMFZHSUY5UTJndGR3aGs3YUtrU3JVeElB?=
 =?utf-8?B?d1UvQUpNdkN4cVYxUXJHS1puY1NSSDhTb1FZK3NzalBacWRIWjFQUnNqOHhv?=
 =?utf-8?B?RVZtYnA2dnJPZVJ3aG56dDhhOGMxeFdUM1ZsbDd0RzZWRnRqYnp1clZQbTFQ?=
 =?utf-8?B?aWxDcWUwbHNCSWNZNStjY2dqOW9pMEQwbzN0d29QMmhZZ2hZeWVmd1FGMmNm?=
 =?utf-8?B?NmVSTzYzYnd3clNNd2EveGV0aitEOVZaTGVSZmN2MTNLWjBRSDdLczZEZ2pV?=
 =?utf-8?B?Y1pWY0NzQVozQmFyc3pSaGtGbHlwaW92NU9wZkdwTENTRklIZUdMOGVJZHY2?=
 =?utf-8?B?RGh4SDFpRUZ2RktXVEIySWNRT1FCcUk4N2VvTGZONGNacVljNWZpOXo3dnBO?=
 =?utf-8?B?aGppcjRaMGRSLzF5WFAwT0wwNk82SWZxSTdSNEd4SmNFZFpHYy83S21vTkVH?=
 =?utf-8?B?QUQwMzBFUVpDUG45cm9xb2wxaDJoNmNBVUtEMVpZR3VXN0toSmVaZUdmdnpV?=
 =?utf-8?B?bkpKNU9ER2ZoM1BhMGZuZnBRclpUbU5tSlp4bk1rcThSWVpqL0NOY2hheHk2?=
 =?utf-8?B?eEM3dFNEZ2ZWaG5nZWVPUzVsVmtsajRWNUo0UVg5a0dSVHRsaVkzZE1BS2g5?=
 =?utf-8?B?RjlnQ00xRWlBRDNGTms3ME5DMnNNRmJ4Y3prRkRGYjVYRkxXN2Q0ZGJDNTQ2?=
 =?utf-8?B?UFcyNS9jVnp3U1NvdjFJUkMyanZsVEF0MktuSzcvWVpBdkRzY2hPVG9SRXAw?=
 =?utf-8?B?MU1DNFFRdGZxUnYzdkxBWDJDMjFvUjZyR2kyQnRRTVV3SE5SMWY5MFFCQTll?=
 =?utf-8?B?TUV0YVJpTGF1ck01dEM4U3ZlclZGRWFGY1RUU2ZVR29zbVRnWUNNS3hFSUNz?=
 =?utf-8?B?SWEveVFzUm9uMmw4K1dEK3NjWkp1a1NKbGgwYWRCbTljSjh6YzFCZDBPSnVo?=
 =?utf-8?B?alUyUTl0R1o2b1kvUmdvUk1peG44RHpEYVBsTWlON1pST0JyeExQODlrbmRQ?=
 =?utf-8?B?ZklvdFEwU0xnK291RHFkNkpMbkVlVEZiRXlZMCtWTFJtSmRpZTJpZURaZklp?=
 =?utf-8?B?Q1dsMTd1SExlQ1BPd3crWGhrOGNmV1RnOHpIYUlmZFMrZVZCYWF0Zm1JeE1U?=
 =?utf-8?B?VC9rS0hJa3M4Tkp1VEU2SUxKSmt0cDNCNUVGKzNNRFBLM2JndmZFRDA2eldJ?=
 =?utf-8?B?MnFEbEhMMWw3b3NVc0xiU2pGZzlpVkN3b1RZdG1uNktVQmJBakp3MjZwb1Jv?=
 =?utf-8?B?cThMYWk5Umwwbmc3N2pLQlBNRG5zMjZhUHpPck1FQXRhYmIzZVhMTXJDV05t?=
 =?utf-8?B?bTVGUCtKejRhVGt6VzgzUVpVV1NyOXpucVQ3YXNqQUxCcTA2QUdZK2RMbUpu?=
 =?utf-8?B?NktYaG9sN291S21Ca05FY01kQnpYb2VBcU9pSndma2tudGUvM0VsYTNsdGdB?=
 =?utf-8?B?VWZOUlRXa0s1T2V5cVM5ams2YzZVWkdWQm1EK3RJODZ0b2t0WUhDWElsWFJm?=
 =?utf-8?B?M0o0dDZMMzF4U0VZZXhNUldnckpGTXZSZndCNHhyVndtNGp2KzViWkJhRkFT?=
 =?utf-8?B?MlJGakQ5alBCOVNSTnFqUmtFZHZUN3poV0tPcjdkWUl2NGFSbkdHVHZNSW9I?=
 =?utf-8?B?Tk9LQWhiK0RnNHFUR3c5eTR0cjZ6UjI5MDJKckRTdFFCT1VhTVZ1NGxDcjRT?=
 =?utf-8?B?aEx4SXJEbHl4STAzYzFtb2pzc3JPM01ZUGliVHI1Zm1IcUVPR3BpOWtNMUxu?=
 =?utf-8?B?S3dMRTJWZnl3MFJoUzBIc1NaZERZdjMwbkZWbk01MXRkdzhqdU9STEgya3lH?=
 =?utf-8?B?alI4S0lKVXpqMThad2FWVG8wb1NINVFvQzhEdExyMjQzMlo0NGR5V0k5cEFz?=
 =?utf-8?B?blB5bStsZ3dxanFjdkg0L05MclhMQnd0NXpuOXpFTWZHQmlyY3E4TDlvaG42?=
 =?utf-8?B?TXd6bVdBcDBrOExHVWJ2MG4zSzhTZ0NBNEpMeUJuaytzYnh2ZmQ4QXpFV0sy?=
 =?utf-8?B?TFU2R2ZQTUJRWndqSVUvL2tWOUxyQmI5OWxPQUROaS9sRGcyUGF6WS9wcTF4?=
 =?utf-8?B?UEY0OWd6WDZMazgyUHp1WEh6Z0VJQ0JldEVpZkU4VDFzUVF1ZGlsVitnM2lS?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27404065-2861-4a0b-34c1-08daf7dcf8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 16:16:06.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zniw9YBBaxOvYjwGWlQvOQVxqIE3vaQgTxKsWZTEoAugtsV3HhyKMBLOibHoH6JkeU0j/R4eHrN9LJMiIehpe965/S42RwsHdMeXYxjA0vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbGwsDQoNClRoaXMgcGF0Y2ggaGFzIGJlZW4gcmV2aWV3ZWQgYnkgYm90aCBHZWVydCBV
eXR0ZXJob2V2ZW4gYW5kIEtyenlzenRvZg0KS296bG93c2tpLiBUaGUgY29ycmVzcG9uZGluZyBk
ZXZpY2UgdHJlZSBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuDQp0YWtlbiwgSSB3YXMgaG9waW5nIHRo
aXMgcGF0Y2ggY291bGQgYmUgYXBwbGllZCB0byB2Ni4zPw0KDQpUaGFua3MsDQpGYWINCg0KPiAN
Cj4gT24gMDcvMTEvMjAyMiAxNzo1MCwgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiA+IFRoZSBw
cmVmZXJyZWQgZm9ybSBmb3IgUmVuZXNhcycgY29tcGF0aWJsZSBzdHJpbmdzIGlzOg0KPiA+ICI8
dmVuZG9yPiw8ZmFtaWx5Pi08bW9kdWxlPiINCj4gPg0KPiA+IFNvbWVob3cgdGhlIGNvbXBhdGli
bGUgc3RyaW5nIGZvciB0aGUgcjlhMDlnMDExIEkyQyBJUCB3YXMgdXBzdHJlYW1lZA0KPiA+IGFz
IHJlbmVzYXMsaTJjLXI5YTA5ZzAxMSBpbnN0ZWFkIG9mIHJlbmVzYXMscjlhMDlnMDExLWkyYywg
d2hpY2gNCj4gPiBpcyByZWFsbHkgY29uZnVzaW5nLCBlc3BlY2lhbGx5IGNvbnNpZGVyaW5nIHRo
ZSBnZW5lcmljIGZhbGxiYWNrDQo+ID4gaXMgcmVuZXNhcyxyenYybS1pMmMuDQo+ID4NCj4gPiBU
aGUgZmlyc3QgdXNlciBvZiByZW5lc2FzLGkyYy1yOWEwOWcwMTEgaW4gdGhlIGtlcm5lbCBpcyBu
b3QgeWV0IGluDQo+ID4gYSBrZXJuZWwgcmVsZWFzZSwgaXQgd2lsbCBiZSBpbiB2Ni4xLCB0aGVy
ZWZvcmUgaXQgY2FuIHN0aWxsIGJlDQo+ID4gZml4ZWQgaW4gdjYuMS4NCj4gPiBFdmVuIGlmIHdl
IGRvbid0IGZpeCBpdCBiZWZvcmUgdjYuMiwgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkNCj4g
PiBoYXJtIGluIG1ha2luZyBzdWNoIGEgY2hhbmdlLg0KPiA+DQo+ID4gcy9yZW5lc2FzLGkyYy1y
OWEwOWcwMTEvcmVuZXNhcyxyOWEwOWcwMTEtaTJjL2cgZm9yIGNvbnNpc3RlbmN5Lg0KPiA+DQo+
ID4gRml4ZXM6IGJhN2E0ZDE1ZTJjNCAoImR0LWJpbmRpbmdzOiBpMmM6IERvY3VtZW50IFJaL1Yy
TSBJMkMgY29udHJvbGxlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxm
YWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
