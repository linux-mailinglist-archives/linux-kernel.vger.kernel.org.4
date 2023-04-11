Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0636DD3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDKHRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDKHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:17:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1BEE7C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8TIGl6vGtpngtwbxzBAP8HDx98fvfOXdUlLKJBJb2SJByfrbd1V21bfXkUur4AbKIeUwzxoW2Q7RRoL8DfwGg+TAQ8TzcOkA/CLeg47RPcMVmJ/+LtCLYS30WOJ/2XNEsHbhvAxmShAujFHRYOUzNHWvazwguJGdHTtKbbwJe12FlSaUb+5OSOMUfv8oo9ocE1cGGgY07CqNj0YtboDUM9cpKzPTT8ecrXjlUtVFz0q116D07NKvSQkKsrbNBsSXKYHXH2YHoHnW1fwsdXkxxROYBPP6V8SuXnrSO2Jw9nIZVVnc5pL9m4uLRO3/Au8bVW5l4CsxzsRfFPI3xF8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfPRdqidRbguQrY+iIRUAZPKsfaq+xuZa9s6sVBWZlU=;
 b=B7MTLDeKO336A9InvPyKpIgw2MIALz0sQKiT30RwyzZ/iaBHELz/WAIMN4HrKJtAWZuuV10Q5rPCr+hQBlDyqXd3PSINWJxxDYEr8+57bIvS3a4q8W+oG5jjwlJz3orQmOLiZgnBTg/iUUEX8TZlTO2IMIXKMOeJfqmgKMg3meMw6m12CupYenzYIzPzIX8T1myIuZSvsIbEVHaR6tB2lD6QzRJJulvsQKQKcV5XzZoULAelTsNESsOM8O+lorPm4DMv9UGZQaIjK1By9+Zg610S/IppGKALRTaUPXiLPauttusvBR2EX5iKjv19ZHR39MJeKRPXzz5zhg3y757eqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfPRdqidRbguQrY+iIRUAZPKsfaq+xuZa9s6sVBWZlU=;
 b=apeZegvOc1W07SsJ17rTJLfMgMCfam3XW0L/D49yLC47wRbfm8EcqZQzd1gKLJcSVIFomsXyma31rlCK+D+qgENxOL4DdThyYNFaDvMQsIQ5ATbXEvabNfLl6z716r2YZbazmCynEdq87JORX2DvCEvJFRLUFf6pE58RApZ52/qj+w+jDPygcRV+OmZFrYNHjkR+HTSECaipS1EXc3QaYixknoft6BcTVDeQo7TRtZ1/dLbyYPDW5yGVdkmvWu4WbDeFj5RLutek9oDJufpmCG56Xp137POXI0LJNUFVHsjTsEBETEYu/iABsE3VIfUjz0gWYmJsi9dpT3MUJ+Rnxg==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR06MB6178.apcprd06.prod.outlook.com (2603:1096:820:d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.39; Tue, 11 Apr
 2023 07:17:15 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:17:14 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKCAAAi3AIAAADGAgAACIwCAAAP1EA==
Date:   Tue, 11 Apr 2023 07:17:14 +0000
Message-ID: <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411025335-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR06MB6178:EE_
x-ms-office365-filtering-correlation-id: a2ae0e12-cf08-415d-0638-08db3a5cc6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qR1vq5Jf3GHHRyMYHBweah2cbUxOrejkWqsTS4aQh6Z2tdA4SvCNx5ELixu9VHCwiU9BwE5zbtN1a8mnFp093/HylyhudPcdyjUK+4Qly8b3khBF3Q6fJHnKfzm6N1Towv1sItduDa4u8XFZjrT38vni8sihYwYGOmHPTvt2jmdRAnX9vFRKnuVmYH3IWXup3UL03Cvgpc5i66uy+YnPQo+MTmHCH12g/16z5cZ2nQM4cHQ5Tc4gkhyxAa9Gg/9u520SaBJXOHpN4RNToa5dOwyySetTZT+8A+mFhj0+GfYCzKFYqAqRiqSsJWhV2KEY8lj6QhxOeEGtzt/9ZdSuq14n4F7pPTC8BWdNo0RX3DMNlZCyezGBg0AhTFtTuLoMia1PLlsP/44W3cyRq4jviai4+azIeTXf71wo1Z6A5MlWIqJyGxoK5/Y0Z4zBkiLoISZ106tUKEaHcuGLBdZ77AiS7lIPGKx7SdSx77uTgyuHL6EOED6AS4uat2qSB59Ktbn+hq0avkDi1x57ukOxTD/JiRrWhUp5pD21yogqxyTMOaRpg+bs1NY6XN8QI30b+TC5JVfg5XAZ9qjBT2zPGWf5wfBAn0O6vmsfNZ0S7J2istS3IkMk0C3o+CRn1Yxa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(396003)(136003)(366004)(376002)(346002)(451199021)(52536014)(33656002)(38100700002)(66476007)(44832011)(38070700005)(2906002)(122000001)(5660300002)(86362001)(55016003)(8676002)(66446008)(8936002)(66946007)(66556008)(76116006)(64756008)(4326008)(41300700001)(6916009)(83380400001)(71200400001)(316002)(26005)(53546011)(54906003)(9686003)(6506007)(478600001)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUdDTmY0b3RWeUxOVEZETlk4MDlHczJ1eE1RbUxvaW5PUkVLSEdzKzRqbXl4?=
 =?utf-8?B?d0FMbDBIcThSb1ZuY0wxWDdpREozcm4wZzdFSDJ1TWRsOVdBT2JWNUlTVHFY?=
 =?utf-8?B?YVhXeDlBc1NPWmh4MVdRdThXWE9tYU8walJtaXZRNGwyQXExblpOd1kzZGc4?=
 =?utf-8?B?RUVSbU5rOUxrVlNLS1NDU1JwaUxzd3lmYzhSamljUjVMaE9XazRzZkhzM3gy?=
 =?utf-8?B?aHozSUZBNXlZS296VDk5azFHU21KYjVlS2crUTJpUEVoUzZlLzU0cldJTGZT?=
 =?utf-8?B?OU45L0NOOW5GSmJYNjlzNVFjMTB4RDUzMkY0dTlYRUJiSHlnZG80dW8wbXV4?=
 =?utf-8?B?WTFIY1dkTU14OHdaWHpxTXd2Z01CdGlFKzZyODhOM0s3Z2pNZWprSGMva0tQ?=
 =?utf-8?B?YXlsRE4vMXFPbk54UWJxdnc4K1dnOG5QN2pncG9yTklIY2VScko2Wm1PWk9D?=
 =?utf-8?B?dHNkQ3E3dXBHOFdXdnoxQmpUWmwwdDZvcktobjhINitzNFgrUVBnSmVzb3pw?=
 =?utf-8?B?dDRBemVHamlmSnIzZWdjZkpHbnBHM1ZUZSsxR2Uzb2VHME9NUFBhMytnNmhY?=
 =?utf-8?B?M0NZbklsQlRsbjBMTHFKVVBEbE1ObytoTnNUMlNtZjh2WHNJSGo1ZTFhL3lv?=
 =?utf-8?B?dVlWTVd3MC9PUU4zL2YxdTlNbEZDdjFBOWNRemQzNlVsQS9mZWVRYmw1OWVJ?=
 =?utf-8?B?UVR0RzZpeEQ1N3VFV0FUZlUzNlF1clM2SDh4aFY4Ukh0akRUa2ZIUStETWgx?=
 =?utf-8?B?UkFyVEx6ZnV3SzhsbGdFVXVjVEN4R3NLbGVmS01xSjdZVm1nWHNEL2hGeWlu?=
 =?utf-8?B?cDFuYUI1bFRiNUFTaEVqZzNWeCsvZmpQYnc1d2pJeDRtZHVCSmpNQm1KRjRt?=
 =?utf-8?B?ckluUEVxdXVjUFNERXVwNmdnY3lGY0o5S0Y4YVNRVkJ6K2sySmlYcjl6WWNm?=
 =?utf-8?B?Zmd3akZlR3BrWHdYMXhjQm9tVno1bnpmZ1RTSVA1bXVHTHlLM2hlVEFrM2g2?=
 =?utf-8?B?VGlFS3g2ZjVXTCsrT3FBOExRZ1VLNXRYUm05eHpHckk2VTRjNkdSZVpoY2JP?=
 =?utf-8?B?V0FrQzJvdFdRRVlyMVBUMnNCb0JmeUF0ZzZTdXl4RVdXL1JEKzdET1M4Vk8r?=
 =?utf-8?B?NjBCS080NVhQMWJSN1NKeEZtSVJCNTFoUFFxdnJCUG9uaDZQYUZzWmNmUWQ5?=
 =?utf-8?B?VVZnbjZOZXRGM3l1ZC8wWkFFUEw2QlJWUUU1eDdxeGlhdjFRRmpDNklzWUZl?=
 =?utf-8?B?MjVxa3g4UG03TXU4QlRObUZGK2VUNEJ5SlVjRGNMVDNvQW53cDVhRVoxSUox?=
 =?utf-8?B?U3FLR0tNSzhQSjh0ZS8wNUw1Unc3Q3VZM0ZocnZybm0vUDhnZ2lIZ0dBdW5X?=
 =?utf-8?B?VWU3eXBpVGswV0RwR2I0VCtOSFdNeVZwRnpVZWxMbkNNYVIwMFRKMWdhTUdy?=
 =?utf-8?B?SURtbW1YbVNGUmJGZDVqM0NTc1ZOSW9wamlpY09EK3grR2o4M21adjdjWkZI?=
 =?utf-8?B?WVJINGFrbGNUbmlXeUVEWWNhUnBGY0xTdVVkRTRVZ2cxZkNZNFFuV0F3eFNQ?=
 =?utf-8?B?V2YzZ0xHT2tXbkt0OFJ1ZTl5ZHlwcWdiTWdwUXF6OXJEVTA1ZERCMG93azI2?=
 =?utf-8?B?R0k0bnRacWpzdEZRTHlvZlVQZVBkZkNycWgzZ2ZkMmxnaVJBV1ZWb1d0anUr?=
 =?utf-8?B?NVhpeGF1RnIzSVJ5bG9IM1Fnd2hrRUszU3hOdmJDdFphcXQ3S2NFUTVJYUZH?=
 =?utf-8?B?T1I0SUFEb3Z5WW5URlJwVzNWSEFxclZ0UFVmSDh0aS93cTNKV2dZVldwb2NS?=
 =?utf-8?B?TU9vRkYwTnJ3NXhOS0dtRk1Pa2ZueXpzdmwwTUFIdXVzZkJQZytVeTBvdlBV?=
 =?utf-8?B?UjkrSk1BOXBLNjUvN21IcmJZL1M5RkhIYjVwRTVsd2R3bGNVd3J6Q0ZubHc2?=
 =?utf-8?B?S2o0YU9yaFdsb0gvWHV5ZzNRbmxNUnlYVW9RS1VYZ2duc0VVTDRucVJGa0g0?=
 =?utf-8?B?TWNYQ1FtZ3p1bURWVThKT0hNZGZTeDhoK0VqMzZTYk5zR3dCN25ENVdUNStj?=
 =?utf-8?B?S0t0U1A4YUFDemt5OHRPL1JCeHYwcXh4Rlo3MHpGRHdXeUZ0aEQyMDZySjZO?=
 =?utf-8?Q?EXZj3axN36Ssmbz2tyxdtLJE2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ae0e12-cf08-415d-0638-08db3a5cc6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:17:14.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXxBJp4M6OXRWK/7MQDOo8zBvh7Di8+N0uB8tNX0aoeGW5yDduEIYOVGlscqtYDd7Xi197VaBo6FNxL1sllo484HlVRXr9UBPdz0ln6C2MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6178
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMjo1
NiBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENj
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gdmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0
byBiZSByZXNldA0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6NDk6MDNBTSArMDAw
MCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4N
Cj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIzIDI6NDcgUE0NCj4gPiA+IFRvOiBB
bmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gPiA+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRv
IGJlIHJlc2V0DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6MzY6MzlB
TSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPiA+ID4gSGkuDQo+ID4gPiA+DQo+ID4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDEx
LCAyMDIzIDE6MjQgUE0NCj4gPiA+ID4gPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1
YXJtaWNyby5jb20+DQo+ID4gPiA+ID4gQ2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gPiA+ID4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTog
V2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgOTozOeKAr0FNIEFuZ3VzIENoZW4NCj4gPiA+IDxhbmd1
cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2aWNlIGFmdGVyIHJlc2V0LA0KPiA+
ID4gPiA+ID4gSXQgaXMgbm90IGd1YXJhbnRlZWQgdGhhdCB0aGUgZGV2aWNlIGJlIHJlc2V0ZWQg
c3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gPiA+ID4gV2UgY2FuIHVzZSBhIHdoaWxlIGxvb3AgdG8gbWFr
ZSBzdXJlIHRoYXQsbGlrZSB0aGUgbW9kZXJuIGRldmljZSBkaWQuDQo+ID4gPiA+ID4gPiBUaGUg
c3BlYyBpcyBub3QgcmVxdWVzdCBpdCAsYnV0IGl0IHdvcmsuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBUaGUgb25seSBjb25jZXJuIGlzIGlmIGl0J3MgdG9vIGxhdGUgdG8gZG8gdGhpcy4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEJ0dywgYW55IHJlYXNvbiB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5
IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uLiBJdA0KPiA+ID4gPiA+IHdpbGwgYmUgdmVyeSB0cmlj
a3kgdG8gd29yayBjb3JyZWN0bHkuDQo+ID4gPiA+ICAgRW4sSSBmb3VuZCB0aGlzIGluIHRoZSBy
ZWFsIHByb2R1Y3Rpb24gZW52aXJvbm1lbnQgc29tZSB0aW1lcyBhYm91dA0KPiBvbmUNCj4gPiA+
IHllYXIgYWdvLg0KPiA+ID4gPiBhbmQgSSBmaXggdGhpcyBvdXQgb2YgdHJlZS5vdXIgdmlydGlv
IGNhcmQgaGFkIGJlZW4gc29sZCBhYm91dCB0aG91c2FuZHMgLg0KPiA+ID4gPg0KPiA+ID4gPiAg
IE5vdyx3ZSBjcmVhdGVkIGEgbmV3IGNhcmQsIGl0IHN1cHBvcnQgdmlydGlvIDAuOTUsMS4wLDEu
MSBldGMuDQo+ID4gPg0KPiA+ID4gSSBhbSBub3QgMTAwJSBzdXJlIHdoYXQgZG9lcyB0aGlzIG1l
YW4uDQo+ID4gPiBTbyBpdCdzIGEgdHJhbnNpdGlvbmFsIGRldmljZSB0aGVuPw0KPiA+IEhpIG1z
dCxpdCBpcyBhIHJlYWwgY2FyZCBpbiB0aGUgSW4gY2xvdWQgY29tcHV0aW5nICxub3QgdHJhbnNp
dGlvbmFsIGRldmljZS4NCj4gDQo+IHllcywgYSByZWFsIGNhcmQuIEJ1dCB5b3Ugc2FpZCBpdCBz
dXBwb3J0cyAwLjk1LCAxLjAgYW5kIDEuMSBndWVzdHMsDQo+IHNvIHRoaXMgaXMgd2hhdCB0aGUg
dmlydGlvIHNwZWMgY2FsbHMgYSB0cmFuc2l0aW9uYWwgZGV2aWNlLCByaWdodD8NCj4gDQo+IAlU
byBzaW1wbGlmeSB0cmFuc2l0aW9uIGZyb20gdGhlc2UgZWFybGllciBkcmFmdCBpbnRlcmZhY2Vz
LA0KPiAJYSBkZXZpY2UgTUFZIGltcGxlbWVudDoNCj4gDQo+IAlcYmVnaW57ZGVzY3JpcHRpb259
DQo+IAlcaXRlbVtUcmFuc2l0aW9uYWwgRGV2aWNlXQ0KPiAJCWEgZGV2aWNlIHN1cHBvcnRpbmcg
Ym90aCBkcml2ZXJzIGNvbmZvcm1pbmcgdG8gdGhpcw0KPiAJCXNwZWNpZmljYXRpb24sIGFuZCBh
bGxvd2luZyBsZWdhY3kgZHJpdmVycy4NCj4gCVxlbmR7ZGVzY3JpcHRpb259DQo+IA0KPiBvciBk
aWQgSSBtaXN1bmRlcnN0YW5kPw0KPiANClllcywgSSdtIG5vdCBzdXJlIHdoZXRoZXIgSSBtYWtl
IG15c2VsZiBjbGVhci4gDQpXZSBzdXBwb3J0IHRoZSB2cml0aW8gc3BlYyAgMC45NSwgMS4wIGFu
ZCAxLjEgaW4gdGhlIHNhbWUgY2FyZC4NCkFuZCB0aGUgbnVtZXIgb2YgZGV2aWNlcyBpcyAxayBw
ZXIgb25lIGNhcmQuDQoNCkJ0dywgdGhhbmtzIGEgbG90IGZvciB0aGUgd29yayBvZiByZWRoYXQs
IHdlIGp1c3QgSW1wbGVtZW50IHRoZSB2aXJ0aW8gcHJvdG9jb2wgYnkgaGFyZHdhcmUuDQo+IA0K
PiA+ID4NCj4gPiA+DQo+ID4gPiA+ICAgQW5kIHdlIHVzZSB0aGlzIGhvc3QgdmRwYSsgbGVnYWN5
IHZpcnRpbyBpbiB2bSB0byBob3QgbWlncmF0aW9uLHdlDQo+IGZvdW5kDQo+ID4gPiB0aGF0IHRo
ZQ0KPiA+ID4gPiAgIExlZ2FjeSBtb2RlbCBvZnRlbiBnZXQgdGhlIG1pZGRsZSBzdGF0ZSB2YWx1
ZSBhZnRlciByZXNldCBhbmQgcHJvYmUNCj4gYWdhaW4uDQo+ID4gPiA+ICAgVGhlIFNvYyBpcyBT
aW11bGF0ZWQgYnkgZnBnYSB3aGljaCBpcyBydW4gc2xvd2VyIHRoYW4gdGhlIGhvc3Qsc28gdGhl
DQo+IHNhbWUNCj4gPiA+IGJ1Zw0KPiA+ID4gPiAgIElzIGZvdW5kIG1vcmUgZnJlcXVlbnRseSB3
aGVuIHRoZSBob3N0IHVzZSB0aGUgb3RoZXIga2VybmVsIGxpa2UNCj4gdWJ1bnR1IG9yDQo+ID4g
PiBjZW50b3M4Lg0KPiA+ID4gPg0KPiA+ID4gPiAgIFNvIHdlIGhvcGUgd2UgY2FuIGZpeCB0aGlz
IGJ5IHVwc3RyZWFtIC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMu
Y2hlbkBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgNCArKystDQo+ID4gPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2Fj
eS5jDQo+ID4gPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4gPiA+ID4g
PiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0NA0KPiA+ID4gPiA+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiA+ID4gPiA+ID4gKysr
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiA+ID4gPiA+ID4gQEAgLTE0
LDYgKzE0LDcgQEANCj4gPiA+ID4gPiA+ICAgKiAgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4NCj4gPiA+ID4gPiA+ICAgKi8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPiA+ID4gPiAgI2luY2x1ZGUgImxpbnV4L3ZpcnRp
b19wY2lfbGVnYWN5LmgiDQo+ID4gPiA+ID4gPiAgI2luY2x1ZGUgInZpcnRpb19wY2lfY29tbW9u
LmgiDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQEAgLTk3LDcgKzk4LDggQEAgc3RhdGljIHZv
aWQgdnBfcmVzZXQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpDQo+ID4gPiA+ID4gPiAgICAg
ICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDApOw0KPiA+ID4gPiA+ID4g
ICAgICAgICAvKiBGbHVzaCBvdXQgdGhlIHN0YXR1cyB3cml0ZSwgYW5kIGZsdXNoIGluIGRldmlj
ZSB3cml0ZXMsDQo+ID4gPiA+ID4gPiAgICAgICAgICAqIGluY2x1ZGluZyBNU2ktWCBpbnRlcnJ1
cHRzLCBpZiBhbnkuICovDQo+ID4gPiA+ID4gPiAtICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVz
KCZ2cF9kZXYtPmxkZXYpOw0KPiA+ID4gPiA+ID4gKyAgICAgICB3aGlsZSAodnBfbGVnYWN5X2dl
dF9zdGF0dXMoJnZwX2Rldi0+bGRldikpDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgbXNs
ZWVwKDEpOw0KPiA+ID4gPiA+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3Vy
YXRpb24gY2FsbGJhY2tzLiAqLw0KPiA+ID4gPiA+ID4gICAgICAgICB2cF9zeW5jaHJvbml6ZV92
ZWN0b3JzKHZkZXYpOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
PiAyLjI1LjENCj4gPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4NCg0K
