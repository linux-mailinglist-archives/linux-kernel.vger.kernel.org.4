Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32273D6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFZErO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFZErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:47:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7463D7;
        Sun, 25 Jun 2023 21:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9B9pQCny83Qoa7/AUBs6sa3uQc8OfyaCvnrZVsH6FJUlX8/s612NACmgmxXc7+K3y2ab67IphXWw/ClAWcxbXEP/aGU7y91A9RlEwGQP3GNvgTdVNzQZiY31oGvS5fm9gpoz/C2sKOl7SoIoWYCaXe2GkVShxgmGuNOXTv4lUkVfZcWoR7lcFSUaltnDAepj14XV/+KXwES6ncP1ucZ2Y+ZmJJHqHyRIecX3gYD4lBkO91E+dzDdC9QlDV8eNPpENT2+tIqFLmuKBrnHCjOf39YgGWDNfpG/pZCTJLd10V43z2ypAF4wuipcezwygVnuan7DcPBIci+jhEaCDw+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vifjcb7QOYmTsrb5TvID0Iep0IOronxYsNwAtMw4C7A=;
 b=XqGBmoSZIf4DrASArTMMGACS3gKWLZFnbikeA0zQl3K+ocaV7rceQHxX7pCtdl8GiQo5rucqXX88LXgjroIGZuZh2qpkfC3ch9KfzxKwiiYk/oKZmki0oHmgoKf0/csPJaG6OgQWnusPBsgYoZ7Xcnsumo0LQ9OSDVtHKLiu4Z3LsYotCu5cJl/B45VLlbuEdHA82dTmGByPzkCjEu7MXF2dSa/Symh2mIL9Evfn1/Zyru+0UXr15mtLfJ+PdQAqwRTB5sjOrTbvcKnwiYfDH1mM172y/N5orzfaa3lkM8PWMaZfYmk+M2lTshHz11mPBUsIwNXScQiFNJJBn6sbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vifjcb7QOYmTsrb5TvID0Iep0IOronxYsNwAtMw4C7A=;
 b=fgjL0+sMXlUkO0Q+Hp90sPnqlggW80kHAgbiGldzpVXAFO/OA608PaHAPGb2IpkcpOz88FiMI49EsUwds95Du3oesAJbpVWanzo5dO7mQqipfimuBc3rWtVgdTpRkExt8fNa6df00pficqn8v6QgA7nrme+1B27fpetE2fw2H7A=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB9PR04MB8121.eurprd04.prod.outlook.com (2603:10a6:10:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 04:46:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:46:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 1/9] arm64: dts: imx8ulp-evk: add caam jr
Thread-Topic: [PATCH 1/9] arm64: dts: imx8ulp-evk: add caam jr
Thread-Index: AQHZoEu+URrY1k2YsU2kTNqnqCLtUa+cWcgAgAA10WA=
Date:   Mon, 26 Jun 2023 04:46:51 +0000
Message-ID: <DU2PR04MB8630F07E727B055388B503B09526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
 <e6829927-d172-abff-f5f0-799a27d14c13@oss.nxp.com>
In-Reply-To: <e6829927-d172-abff-f5f0-799a27d14c13@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DB9PR04MB8121:EE_
x-ms-office365-filtering-correlation-id: 7dc5a60c-d918-4a22-3552-08db76005bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ETew2nz7qU1ecZqcRc5z6QUkQNMHw8KB+jTnjXqg1aLqGUuvqYM1HAHJxdBWlgfRw+WrCO860dawxA+zp/wwustjKH+y4mVFsOTuS6VFto7NC13QwFgQK9YFJK6t16ccOmvWPlL3oULBsckYWAxz3tKPV5MRpdTehmIU2nT1ZX2UcB1ZmE3vXhV4pYqg25BRU08djW4ten5vEjIF+Fxcu39VSVHwN0LchA7V2JZH38dQRQQ7Ws5mIzbP8LI2lkW6YgOZglf2PvVKANGOsFcIP9r9GS0baVWiB2ji3wEm8OoyQ8kxr3BLh4ciC18KquTQS+CBp1oI27bPI0YaaEhAYr8s0LZ0hNJaxYuZLK1nohMaD7dz4l0INxwBvnepkhpCRswyRfSCdXAedTUB3d9FWrGlPrJTfOIH69h0yzF5OI7e/1cowvtYqVUyFSWrzEHbZYv645TfcmGaJhVI+j67SAEBBVJNveHDu+WOd56aLj8d3JLjbgiY8bIDhN87/p+qljruqFDsbIOD/6tSRjGfhken5VKKuV5XRlmoRwylOPU8KbhdyuqHWM8g1BJ2oPlOsQ3zoRvVu+VUmXcyXIHPyn1wsYJKCnfGz9O09p7rDy8dGRNpqw/s6kfLJzMcBxqehf+eauRT9ChfTu1xhshnfRk4UgJ+BFtO6b4rABUhug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(921005)(122000001)(38100700002)(38070700005)(83380400001)(33656002)(86362001)(478600001)(110136005)(7696005)(71200400001)(41300700001)(55016003)(66476007)(66556008)(66946007)(316002)(8676002)(76116006)(8936002)(66446008)(64756008)(53546011)(26005)(4326008)(6506007)(186003)(9686003)(2906002)(44832011)(7416002)(5660300002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0pCTHNwK05JZitGZEhiNnd1VHJGUnBVVXlmS1VSZGtwTXNrK3Q2akl6d3BN?=
 =?utf-8?B?bUVQdE9IbVYxU1BVK3RtbWhhODR5UEhlK2dxaEp0VW5TN2o0amc2c0lUY0xN?=
 =?utf-8?B?bmhSU0ZuY0k4RUZYNUhOcWpFcUFidjRXTzM5eTVDWTJwbmpLOW5FVks1V09D?=
 =?utf-8?B?YXE3QnQvd0UwUlFSdHlYa2VvNlFQenZYRWFVMW44VXR1L0c3eXNmcGhsQm9S?=
 =?utf-8?B?RkZnNUg0SEZxclZHVXhva2pqMDl1TGVWSGFqUUhvb0FaUkFzd0pyRHlneFpX?=
 =?utf-8?B?SGZZTE85OGt6VTNVZlV0bXo0RXArbWc5QWZ3ZmZyUHRYZHdmVE53aHUrK00v?=
 =?utf-8?B?THZ5NEltbC9jU3dIVm5CdVNUakJ6N0RpNVdKZWNPUzVzWmV1NnJKTGpCTHhF?=
 =?utf-8?B?dExBVjBCamMxRVdpMGV1SEVDTDcvT2R4aloxSVFGUGhINnFRY1ZBdGR0Smht?=
 =?utf-8?B?ZC9UTnk5ampFZXFvVjdoY3VWb0trbGZraDliY0VTZUVhNGlESUpHT1g0VmpU?=
 =?utf-8?B?U1FKOVBJZE5sbEtvdkNiTjQxKzE2QzJWY3A5bk9WYU95ZnNaVlJTUXEra21u?=
 =?utf-8?B?K1gzaXVaakZGVlMzUUNFeUlYWXk5RXBJZW9BL3pmYWNiNnYrVVQrZFNwcG5V?=
 =?utf-8?B?WlI0T0JQTDh1V21HMjBQejk1SnJIWkVOSjM0R282UEwzV1V6cGFvVFA2bnhM?=
 =?utf-8?B?bksrZnBnZEtHZmV1YWlFdEpReG8vMzZ6amNNQjdTdDNhMHBXcGttN1pnNHl0?=
 =?utf-8?B?QXZ5c2JlbWZQd2RTeUg3N3VTL2h3eitOOTkxNzYwN21TYmtLR2dtb2NlZ1ls?=
 =?utf-8?B?TUtiQW9JYmdkMll4TEp1V1dQdW9pSVpSUG5ITlZIMGRobGtUaFl0cW5OaS9M?=
 =?utf-8?B?L3pxTUpLL2thWHZHWEl2dHVBQmZuN05UaE5LNi9PbFlEdVo5N01sb1JObkd3?=
 =?utf-8?B?V09TYVNRbGFIMlNWV0h5ZE5aek5ZYTlWRkZCWitzdUp6d2hpbzkxNUpsalVG?=
 =?utf-8?B?ejluNzlnY2tIeW9DRzlBeDBxNm1LcDgwbDF5SmtUZWtIN3lTUkxoaWpOM21L?=
 =?utf-8?B?Si80bkRKNGdNQUtSVzVycUxGUlpPZkI3TkhIQjdqQjM4RzY4aW0xRUY1QmMz?=
 =?utf-8?B?VjMwMmY4VVhmSXRqOFQ2TnBtQVlsMTlBYTFteGoveHA3YzhwYkxDMlVhQmc1?=
 =?utf-8?B?c2M1aDNGMUlVV0xTMG1aYnFhUSs1OU9uWlFUTFlKbERQckdwOW9kQVdONUVs?=
 =?utf-8?B?eTBHU0VXMlo3WmlyelVRaytDRzhDV1UzWHd1N0EyUmhycWNkV1JEUDlHclpu?=
 =?utf-8?B?R2NVazFTYW4zQWdldnovZ25nVXM0SGRZQ2M5US96VjZudGwveTNvWGJLNUJW?=
 =?utf-8?B?eTI3VVJIdG1kWlRIc2RKNjRJMHh2SjY3UFRIQXJvSnVVMmR3MTNzTmRDNFRq?=
 =?utf-8?B?RS80RTlLV2ZJSlRHNVVHRFl0RUJXVzg5QmdPVnozeEVOczgrT2x1bElrbnM0?=
 =?utf-8?B?SVJ5VGVab3ZiTm85RUlaNWdZdUk4WW9VNEtxc2d3S2FHS0dSSHhSUytsWnVC?=
 =?utf-8?B?TktIQzIvRTRoREU1YlJxUlZ1VldHWDJ4RG5vQzVKc1RJRHViU056M2NpRzcz?=
 =?utf-8?B?Wk4vY2FydmJaTjhXaHJOelgxbnZJN0dBUWFGU3UxZ2ZjVVQ4RTRXcG1aR0xB?=
 =?utf-8?B?TjdSTU9rN2Z1eXE2eTdBdHZ6b1hjOUp1ekJlZTkyaXhIOHVqY1ZidXJ5bTdv?=
 =?utf-8?B?aFBmS1hwdFJNMWcwa2cvL2tSSnZ4MFRwMzc5cUI1SlBFT1YrVTA5RG9vcUpu?=
 =?utf-8?B?YzMzM3E0RU0xbGlrbTllV01ITHBxcldKeWxCWlRxNTRVSUlHUDZEZi9TOE5W?=
 =?utf-8?B?SGd4cFIxMXY5MXFJcWltTmVEdVFCdXQycTdCZFA3cmdaM0NOTHl4N3FsY1Q3?=
 =?utf-8?B?TjdRbFJLUjRMRlozZncvZkoxNHBxTTBPZVJCWngxUGtFUU1SZ0VPNk5Ba2U3?=
 =?utf-8?B?VTd3MmNOMnFaajlaQWl4cTF0cXNQczQ0ZG52eUxWbXF1RmNYd1pWb2pxMmhp?=
 =?utf-8?B?MEYxV0Z1U3Q5cmExeStSNk5oWTdaYnNpZURZci80UEN0ZjNXN1ZLRmFPOEtk?=
 =?utf-8?Q?lmK8FZWiO1IB/1d0KRW7HurdS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc5a60c-d918-4a22-3552-08db76005bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 04:46:51.3990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSgfUlEaGw+b5rpBRFifU11qsHTt0moYvoukn13b9uh7KODTVRy8uZs480s9RO/lhZuamRC40B/1VZ9d3a+PWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGVuZywNCg0KSXQgaXMgdGhlIHNpbmdsZSBwYXRjaC4NCkkgaGF2ZSByZS1zZW5kIHRoaXMg
cGF0Y2ggd2l0aCBjb3JyZWN0IHN1YmplY3QuIA0KDQpSZWdhcmRzDQpQYW5rYWoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5A
b3NzLm54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA2OjU2IEFNDQo+IFRv
OiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3Jn
Ow0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5v
cmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS85XSBhcm02NDogZHRzOiBpbXg4dWxwLWV2azogYWRkIGNhYW0ganINCj4gDQo+
IEp1c3QgYSBzaW5nbGUgcGF0Y2g/IG9yIHRoaXMgYmVsb25ncyB0byBhIHBhdGNoc2V0Pw0KPiAN
Cj4gUmVnYXJkcywNCj4gUGVuZy4NCj4gDQo+IE9uIDYvMTcvMjAyMyAxOjQwIEFNLCBQYW5rYWog
R3VwdGEgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IEFkZCBjcnlwdG8gbm9kZSBpbiBkZXZpY2UgdHJl
ZSBmb3I6DQo+ID4gLSBDQUFNIGpvYi1yaW5nDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYXJ1
biBTZXRoaSA8di5zZXRoaUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBHdXB0
YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4dWxwLmR0c2kgfCAzMg0KPiArKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+IGluZGV4IDMyMTkz
YTQzZmY0OS4uY2U4ZGU4MWNhYzlhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+IEBAIC0yMDcsNiArMjA3LDM4IEBAIHBjYzM6IGNs
b2NrLWNvbnRyb2xsZXJAMjkyZDAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNyeXB0bzogY3J5cHRvQDI5MmUw
MDAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLHNlYy12NC4wIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHgyOTJlMDAwMCAweDEwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJhbmdlcyA9IDwwIDB4MjkyZTAwMDAgMHgxMDAwMD47DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2VjX2pyMDoganJAMTAwMCB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLHNlYy12NC4w
LWpvYi1yaW5nIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4MTAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODIgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlY19qcjE6IGpyQDIwMDAgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxzZWMt
djQuMC1qb2ItcmluZyI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDIwMDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWNfanIyOiBqckAzMDAwIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2ws
c2VjLXY0LjAtam9iLXJpbmciOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHgzMDAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA4MiBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VjX2pyMzoganJANDAwMCB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLHNlYy12NC4wLWpvYi1yaW5nIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4NDAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODIgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICB0cG01OiB0cG1AMjkzNDAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDh1bHAtdHBtIiwgImZzbCxpbXg3dWxwLXRw
bSI7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MjkzNDAw
MDAgMHgxMDAwPjsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
