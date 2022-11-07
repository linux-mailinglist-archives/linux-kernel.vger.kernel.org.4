Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BA61FA4C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiKGQqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiKGQq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:46:29 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D761EC7A;
        Mon,  7 Nov 2022 08:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB/GDSqSDdHcmRhmagRfpfpbpS6TzwiPZpPxsVH6QPC+fzwPL5Fz9/1MEs3E44RAzvaJp2arLe/mqCv5kgpaEpLGQD2sI0MZbt2KxwBvDOPu92x77M0eMCLfRImbkqwfjtOM0BbgmtE9LRHm1VpYQabnLWf/2cskpmjiCcq2B6Zn7soskKk6VmGTO6j9UOc8si7sr3JKRXHsvDDUvPNI9DoMqESpHPd/k9v7T9se/k8VRlrIkhPUmfiqPRkVTF2MySaBRDEnrVlQqKjRqOZdIWZnAlQrJsSsNXLcJmwxezg4f5oEP5rhvDzMRjs7fS3d1ULPzpRJKFV5pMs0PSesmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO5+akDrpKcG/1Srmq5W7k/GdfjI1/rINxAnet65yG8=;
 b=BUcqg05dWONIfJJ7btTC3tDogqq4WIRw59u5stvri7UV+oEl7fBvs362YSN6ljpoS3ZFUCAmC0Wr0NiBH1adphh0wvWtUs8bM6uPyUaf6bwxznfOc3grZSnFdD6XKJTK5Sji5jaH8p6dLW+id1/XNmUfls65zGGm059j/WzVgYfvRPQXdV4y3WXHl4ep8971gjmSZUxUjyJ8kcav9RrRcRDmYnTa0wavZb4v/S0JUUuUPxLBL6tJLetcJd0LDk17ksYmkk0rQOaITbuy6J04MX4089cFCNn5dcmfEakikKtsSZTePt6tcMvG37vqtELt83zJ0SpwZw2nzQxR+XiBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO5+akDrpKcG/1Srmq5W7k/GdfjI1/rINxAnet65yG8=;
 b=ZKQIxnXvHvQVL7wp4Ky2cl+qns+XON0fqrKTqPKe54lCuM3o6skI+UOBpXKa7L+ZJ+MuuWpedw5Vaa8zXUojzq7ZKe81vKRiLcP1pjt2Om4s6JcG/Qdjq8gUQVq+b7dU5kFWnQ/62ae9IAOQlgyYcafxgoin9HOISZ6oomDDqyM=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB6176.jpnprd01.prod.outlook.com (2603:1096:400:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:46:25 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9a5b:64d4:3aec:c6aa]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9a5b:64d4:3aec:c6aa%9]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 16:46:25 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 2/3] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Topic: [PATCH 2/3] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Index: AQHY79kBujgjxlWKJkiGohPPot5a964t/0oAgAB3ZQCAAEMNgIAE9tyg
Date:   Mon, 7 Nov 2022 16:46:25 +0000
Message-ID: <TYWPR01MB8775F35BAFDB90658F90D5A0C23C9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
 <20221103230648.53748-3-fabrizio.castro.jz@renesas.com>
 <7fcd798a-9cce-9453-1657-7be1abf3b97e@linaro.org>
 <CAMuHMdX-b-DoNGeccO82bh4s9d7HKh_7o5W967a_iKBMo-fckw@mail.gmail.com>
 <69896316-e38d-edae-77dd-9c6aad0ad0dd@linaro.org>
In-Reply-To: <69896316-e38d-edae-77dd-9c6aad0ad0dd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB6176:EE_
x-ms-office365-filtering-correlation-id: 4a682400-aecd-4d34-7a5a-08dac0df9c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eShpisZyWqd6agVgDyl0eipNebWbFEDOkxWIHAkJxBoi0agG60pkWgop3yqLThTtLLrAzFbcVDLbzes0Pg7v+5fbOkq2Xe/Awb3Q+NuGO/BZY/NC9PQVzGerUhn3t7paZhXRIRxIN6PlyY6BIq2m9ZFh/jhbl904/4YQeeKWudFs2uGku+cTjdAb5ZPvNmM1DCJHHeKNAARRjFkUy7Ms/3C89QcFnHJCHjtmFCAFNr9l9b9HzxKOmDI9vLBR5c0v5IR7TL+bfEEADniQLAA8hacCAi5v+cZNT1kFryq15vozR5IoZ/d79NV1y11F458OZNOpO1kDk6XtdDr8jUW/TTMK4vsLLubvlmolNhwlwCYzvaO6CacMiSdJ9qM2ILN1Fwp8/tNhYRT7nLyAU2ynqe0liOd+i3Oi7VzbMnm86+2pXRp0ah9XPZDzmF5M9Z8UxUx4FV0gF68TevGNldwhkHYMYIqSs/LiWM/eODoobWVyTCQqaExvpB2pwvPcFlrnEeIEs1W5ITIDOKinE1/XG/wHrLFwekY33VBN/Jy0sD1JO4b/bgZ6SxThStN3XupykTzcbEQtygBeFSU/7QUm+LrCjd6tf0xyawUCI+gnAuxCPungHs35kTr0d5IvDfEx51uCgNrZN88NdqMxWizQAhdQg7/9kmY/co6H2JvrLpKZWv4klh7rsbtbCLv1eitrkpPB1d5n4bKffj/WYX63dhkVHIzVkZjwXbd+k5Zd65KoVLhuZVq6ZINP8zEFikaf/7ecfh8BaNo3OYpsSo3r8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(5660300002)(8936002)(52536014)(7416002)(38100700002)(41300700001)(8676002)(76116006)(66556008)(4326008)(66946007)(66446008)(66476007)(2906002)(64756008)(83380400001)(316002)(86362001)(54906003)(33656002)(110136005)(55016003)(71200400001)(478600001)(122000001)(7696005)(53546011)(6506007)(26005)(38070700005)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0QwdUx2azlGbGJVbDB2RitNaTRyY3dtREMzL000NEF4UmpIbnZ3SnhiU2Vn?=
 =?utf-8?B?RG1DdXZtVjVCL3F0Z1NMSHkxUmlRWkY0K3RNdkRqdmVHbnJZbmk1WTRVSUtN?=
 =?utf-8?B?dUFHVS80dE82YXo5TEdaVVdHNVZCY25HNzRsdWlKTXUrL1BabzZYSENjUXlX?=
 =?utf-8?B?YmtqUVpic3VkVmpiOW1wMVdiZ2l0ayt5Mm9tVEJQampJNUdoMVFnbGV6aHRM?=
 =?utf-8?B?RVpvMUNoa3NWZlhoYmJwTTRYK1N4dGhtTVB5K1JhSXA3VytxRVBhRW1RUW5h?=
 =?utf-8?B?eWIyMVNtcjN4V2drbGpFeVZXLzcrMzJPaWczK05lUS9ERVBwRUsyUDBGNmNJ?=
 =?utf-8?B?Z2U2RU9aa005K3dMM05ZMittazlKRUg2OWs2WWlqa2VTc0w2ckRKWXZpbC8v?=
 =?utf-8?B?SzltREkyTElSZ05HVHJpaGdsMVlJb29vaC9RZm9FZDlMU3p4amtkSkwvM2wr?=
 =?utf-8?B?dk9QZElWWVVHVDBveklPTnNwR0U0V1hnSEx6VnREeUF0MURJMDUwdEF3Ymd4?=
 =?utf-8?B?NnZnejFOZWpLMm5XVTd4NFNYK0x1Y0tEOXVncFNtdERzVzZXL1JrUTEvZGZE?=
 =?utf-8?B?ZklQcGRxL3RNYmxINmhGQmQ3NW5LUlhMdE1Uc3hWUXZ0VGhOdnpLbUhrWWlY?=
 =?utf-8?B?d1hBNHE1K0l5TjdBbjB5QStEUTNaVURIbU9SY21hbVpmUnVWeE5QUmRBMGV1?=
 =?utf-8?B?UTNadWJObHlLQjRFRnBqQTFVTk5kL1VRUnZ2RnhVRUNQcDh3WmV2MVFqdk1L?=
 =?utf-8?B?N2o3Rncya1REQklTZU5XeEN2ZzB2b1JIR2dZaEY0VzhDTUFkZ2taQVpPaU9T?=
 =?utf-8?B?Y2F0bTlwaUpFbGUxKzhVOUw0UG5EVEg3QitMbEllUTJISUF2SXRtNkpHbnJG?=
 =?utf-8?B?czhpQzJpdFE1clYwUFh6dUJjQWJua05VWUQzK3pBbEJpSEV1MEJoSHdDdXd3?=
 =?utf-8?B?c1ZiNDNadHE1QVV2RlRhUWREbVNpMDdCZkJERE9wTlFEREFPWUxvQjdSU0Ju?=
 =?utf-8?B?RGhpVzRYRU9qcktiVklnTmR4VEhjbUdqc0FBSE1XQUo1SWprVG45T1Y0ZC9F?=
 =?utf-8?B?VXRzN0hObUJwNWN3VUtlSU1WZ3BwSERCTnk4a0xRaXI3S3pLMWx2U3IrTlpX?=
 =?utf-8?B?YzREbE5rY1FOSDVFaUp1VmFSODdQOWhqWHNBN1doZTRBZStxTVJNcFFyTlll?=
 =?utf-8?B?TUU3WHZQRnorWm0rMXIwa1NjMUdRODdwZzFJT1kvS1YzUEpZbzBBUkdqWU1I?=
 =?utf-8?B?aVVWemFhd0htQmhtVUJYZnlaOXpxeEFBeGdaTUYwWkNNVjJBUDBBcFdWK2JO?=
 =?utf-8?B?R2Z1NnUyME9RU1FpS210eStTZUtibldReVVJRGJGVVV0TnNXSWpCVDNPa25R?=
 =?utf-8?B?UXNnTzlBd00zMHB0MHJpVDlrbllUQnRIaUp5ejhWZmFUdWcrdXI5TlNKSEJZ?=
 =?utf-8?B?YllDWW1IWXVnckl1U0dHZmVwMCtqYzVDY3VIamVvUlBFQUlDVVByN2pLTXV4?=
 =?utf-8?B?enJWRU1rNEZDMjBLRDZLdTIrb1ZSRWFQcE4xc012SEEycWtsdnowdG1UbHJJ?=
 =?utf-8?B?MklacTV3aTM2QzAwbTEzV3Q0cU9pVDNtckU4SzU2akdBTDR1WXZGME9XWEQr?=
 =?utf-8?B?cC9zclZOc05IMlRpTUkxc2JwN0NXbUpnb1YxV2pWaHRPN0tWSjhwcHhmNk1U?=
 =?utf-8?B?OXN4NWtOUVBzY0ZlS0s0SlJqZmZVT0p4RFdkM2R2T1dsTDhZOU1MeWt1UVdN?=
 =?utf-8?B?WWdxeEY0SjZ3YnV2TFpmMk5wSC9uckk0V09hY3BUSkZaOXN3MWErTWpWd1d0?=
 =?utf-8?B?K09uSTl1TDd1eUpDVStEM2FOVUt6K1kxNkw0cVJUV0tJeXV6Y3JTcDJnZDI0?=
 =?utf-8?B?aEw1TDFqR1pubkZLc2JUeDhsSkRvMmlBOE1PNnUwL0ZKZ1BERzE1OXdBWW40?=
 =?utf-8?B?d2ZvQi9Ecm5HWlY3Y0Vja0hmSlk1RE5jbGJIQkU4YmNHSm5MT0ZQY3dEdnU5?=
 =?utf-8?B?UHJRakN2ZWlsbzd3WkN5UkU3Y0xveE1GNmg4Y3N3MGllNTE0dUtSaVdWR3lX?=
 =?utf-8?B?Z28vQlZzNkdCQ0crWVdBNDFSQTlRRTF4YUpVcVU1N3ZoWlJwSVpkRzV0MW5I?=
 =?utf-8?B?ekIxYnROZFlaTFdoNzJBazJsTEoyM1B1K2hTVWdncE42UTl4c0I3TzRENmNN?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a682400-aecd-4d34-7a5a-08dac0df9c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 16:46:25.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqOSZAS7XrGPxmEyDwfZIvL78h+myCiA8TEHEQmFL7KMwxxGHBEyJpjb0D+evOCokp4dZFpB3id1te9z9wIL63qxkENZcB7k/ha4Q58SET8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mIGFuZCBHZWVydCwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLCBJJ2xs
IHNlbmQgYSBuZXcgdmVyc2lvbiBvZiB0aGUgYmluZGluZ3MgYW5kIERUDQpwYXRjaGVzIHRvIGlt
cHJvdmUgdGhlIGNoYW5nZWxvZy4NCg0KVGhhbmtzLA0KRmFiDQoNCj4gRnJvbTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAwNCBO
b3ZlbWJlciAyMDIyIDEyOjU1DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBkdC1iaW5kaW5n
czogaTJjOiByZW5lc2FzLHJ6djJtOiBGaXggU29DIHNwZWNpZmljDQo+IHN0cmluZw0KPiANCj4g
T24gMDQvMTEvMjAyMiAwNDo1NSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiA+IEhpIEty
enlzenRvZiwNCj4gPg0KPiA+IE9uIEZyaSwgTm92IDQsIDIwMjIgYXQgMjo0OCBBTSBLcnp5c3p0
b2YgS296bG93c2tpDQo+ID4gPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6
DQo+ID4+IE9uIDAzLzExLzIwMjIgMTk6MDYsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPj4+
IHMvcmVuZXNhcyxpMmMtcjlhMDlnMDExL3JlbmVzYXMscjlhMDlnMDExLWkyYy9nIGZvciBjb25z
aXN0ZW5jeS4NCj4gPj4+DQo+ID4+PiByZW5lc2FzLGkyYy1yOWEwOWcwMTEgaXMgbm90IGFjdHVh
bGx5IHVzZWQgYnkgdGhlIGRyaXZlciwgdGhlcmVmb3JlDQo+ID4+PiBjaGFuZ2luZyB0aGlzIGRv
ZXNuJ3QgY2F1c2UgYW55IGhhcm0uDQo+ID4+DQo+ID4+IEFuZCB3aGF0IGFib3V0IG90aGVyIHVz
ZXJzIG9mIERUUz8gT25lIGNob3NlbiBkcml2ZXIgaW1wbGVtZW50YXRpb24NCj4gPj4gbWlnaHQg
bm90IGJlIGVub3VnaC4uLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEZpeGVzOiBiYTdhNGQxNWUyYzQg
KCJkdC1iaW5kaW5nczogaTJjOiBEb2N1bWVudCBSWi9WMk0gSTJDDQo+IGNvbnRyb2xsZXIiKQ0K
PiA+Pg0KPiA+PiBZb3UgbmVlZCB0byBleHBsYWluIHRoZSBidWcgLSB3aGVyZSBpcyB0aGUgaXNz
dWUsIGhvdyBpdCBhZmZlY3RzIHVzZXJzLg0KPiA+PiBPdGhlcndpc2UgaXQgaXMgbm90IGEgYnVn
IGFuZCB0aGVyZSBpcyBub3RoaW5nIHRvIGZpeC4NCj4gPg0KPiA+IFllcC4NCj4gPg0KPiA+ICAg
ICBUaGUgcHJlZmVycmVkIGZvcm0gaXMgIjx2ZW5kb3I+LDxmYW1pbHk+LTxtb2R1bGU+IiwgYmxh
aCBibGFoIC4uLg0KPiA+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZh
YnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvcmVuZXNhcyxyenYybS55YW1sIHwgNCArKy0t
DQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2kyYy9yZW5lc2FzLHJ6djJtLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaTJjL3JlbmVzYXMscnp2Mm0ueWFtbA0KPiA+Pj4gaW5kZXggYzQ2Mzc4ZWZjMTIz
Li45MmU4OTk5MDVlZjggMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaTJjL3JlbmVzYXMscnp2Mm0ueWFtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9yZW5lc2FzLHJ6djJtLnlhbWwNCj4gPj4+IEBA
IC0xNiw3ICsxNiw3IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAgICBjb21wYXRpYmxlOg0KPiA+Pj4g
ICAgICBpdGVtczoNCj4gPj4+ICAgICAgICAtIGVudW06DQo+ID4+PiAtICAgICAgICAgIC0gcmVu
ZXNhcyxpMmMtcjlhMDlnMDExICAjIFJaL1YyTQ0KPiA+Pj4gKyAgICAgICAgICAtIHJlbmVzYXMs
cjlhMDlnMDExLWkyYyAgIyBSWi9WMk0NCj4gPj4NCj4gPj4gTm8uDQo+ID4+DQo+ID4+IERlcHJl
Y2F0ZSBpbnN0ZWFkIG9sZCBjb21wYXRpYmxlLiBUaGVyZSBhcmUgYWxyZWFkeSB1c2VycyBvZiBp
dCwgYXQNCj4gPj4gbGVhc3QgaW4ga2VybmVsLiBOb3Qgc3VyZSBhYm91dCBvdGhlciBPUy9ib290
bG9hZGVycy9maXJtd2FyZXMuDQo+ID4NCj4gPiBBcyBzdGF0ZWQgaW4gdGhlIGNvdmVyIGxldHRl
cjoNCj4gPg0KPiA+ICAgICBTaW5jZSBpdCdzIGVhcmx5IGRheXMgZm9yIHI5YTA5ZzAxMS5kdHNp
LCBhbmQgY29tcGF0aWJsZQ0KPiA+ICAgICByZW5lc2FzLGkyYy1yOWEwOWcwMTEgaXNuJ3QgYmVp
bmcgYWN0aXZlbHkgdXNlZCBhdCB0aGUgbW9tZW50LA0KPiA+ICAgICBJIHRoaW5rIGl0J3Mgc2Fm
ZSB0byBjaGFuZ2UgdG8gbWFrZSBjb21wYXRpYmxlIHN0cmluZ3MgbGVzcw0KPiA+ICAgICBjb25m
dXNpbmcuDQo+ID4NCj4gPiBUaGUgYmluZGluZ3MgZW50ZXJlZCBpbiB2Ni4wLg0KPiA+IFRoZSBm
aXJzdCB1c2VyIGluIHRoZSBrZXJuZWwgaXMgbm90IHlldCBpbiBhIHJlbGVhc2VkIGtlcm5lbCwg
aXQgd2lsbA0KPiA+IGJlIGluIHY2LjEuIFNvIGl0IGNhbiBzdGlsbCBiZSBmaXhlZCBpbiB2Ni4x
Li4uDQo+ID4gRXZlbiBpZiB3ZSBkb24ndCBmaXggaXQgYmVmb3JlIHY2LjIsIEkgZG9uJ3QgdGhp
bmsgdGhlcmUgaXMgbXVjaCBoYXJtIGluDQo+ID4gbWFraW5nIHRoaXMgY2hhbmdlLg0KPiA+DQo+
IA0KPiBBQkkgYnJlYWsgcmVhc29ucyBzaG91bGQgYmUgZXhwbGFpbmVkIGluIHRoZSBjb21taXQg
YmVjYXVzZSBjb3ZlciBsZXR0ZXINCj4gZG9lcyBub3QgZ2V0IG1lcmdlZC4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
