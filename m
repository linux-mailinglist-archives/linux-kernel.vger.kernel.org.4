Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A66A3BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjB0HdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:33:04 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B04EC6;
        Sun, 26 Feb 2023 23:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6xELgpf9aDAxT9koDqUiidShdDb4pKB5lEb9sjzZ1dgvH7ttq3A7hNK66MQkIEci/ZLMyhVfd7A+FOWYfbGxywPhpTi3r2LJJ6yTr6UlE7oe8Szb1Fz1v1QlFey8k0iB1Zv7J22XjU2L6lJIsvsVCX5WnBp8aFXiwHKRK92sxDhiFx7aqqRFnOtYw4Kknpa2aXibalHYbGfD4LKo5Mw4bV/lv2vXE4q7QedC9EqDGl75/FVQWZd2BV+iMmM6Wzj2KbNMobA6QeswojUibEKGGcHexZy06Ky6FpItNM+gSTwi6PRfIlfttbFE/sKpS66d847unZMueMWosTROk5bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miSpdoGm3GGtRFCKL9qz+0mq+q4cQOwdosOrs9tWk3I=;
 b=bGNzIrTxFHWbLN7On0lHLm6L7xVFyxae2TNRrDXf3GBSoC5MG9Qx0nGIWxAXD5IVmbfeiHVEEjqnz0NR/gFiNJRoFYJLq5lh8zQgwNIaCRDCwX4SE85pxfxVqd45lXwt5Vm92lz0ZKuJr+6UjKsRKSZCL0Xa4Sa1V8ffa4MqYzGu7o9ukQlfVHOUIkl38em9uy4n+nfFiFIFPAqkeTwxdWXn9jJ3BoPpau+7XMs4w8NXJW4u5WF58SfkQFLUTK9N+9zVc2BCQpx7go4bzItqQZx0bC8nx9tTPNnL9p1D0xgeVs1O/c+eRbUeOY1CVQqh53vGarelndQrrJ46/CQAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miSpdoGm3GGtRFCKL9qz+0mq+q4cQOwdosOrs9tWk3I=;
 b=HjbQySaLlwkLpIOKuj//mNfmEG3+6ZUQ6jy3USjNUFgMMRxufhVKr3z8wCAbAM/6ViyN2bTCKW9csQ1KCrHCi8CfW5fnvWd179HOjKOAohQ+G0MD+uOllaDDdIU7SRqxf5Y14oaMkxY9DRy1MnFbstzfwvClw/eMXHI5Fk6yPwk=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 07:32:54 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::616b:fd76:ff5f:5ae7]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::616b:fd76:ff5f:5ae7%8]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:32:54 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     "code@tyhicks.com" <code@tyhicks.com>
Subject: RE: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Topic: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Index: AQHZRbcdFbW2kPk2SkKdOcKV1/1LC67ZqW+AgAjGhKA=
Date:   Mon, 27 Feb 2023 07:32:54 +0000
Message-ID: <DU2PR04MB8630B140D8B546864FBA016095AF9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
 <d253d5ba-8e57-dc20-dfb4-08aac9e92a4c@linux.microsoft.com>
In-Reply-To: <d253d5ba-8e57-dc20-dfb4-08aac9e92a4c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|VI1PR04MB7023:EE_
x-ms-office365-filtering-correlation-id: ae9deb12-3349-4d94-bf6d-08db1894d6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVH5TXDrHgyJoGo8UJdWmr89sCkQEzR83jNvBC0UVPVDg5apJHhgb5uUKPgeR9f2X5/VVYvXT8mz8eWrPuk0iVHL19vczVTSPIzphnotfUNiG30OlZN2D1zONRQI5sqwT7u6+sb52shRdfOq7JFio4ehPP428MnX0KZmilZAWi5VvVDH04ydA5voxtwbyGsJQDEcOZjeJcpPTtfn8cI0HBc9YuNqstXHCGLc3KdhMzZ25aomOpWI85u/uijC5Pu7LTAMHYPynrbJrGVoQOcAdCg0HSv9bvriYAhxrMiHBZctTXVYuZK/GSrJNAnSfta4cigQhH5Fg2DzphTJuGr6Ym7pelyUvsCPk42UJXn/j41Cbu5ypNOoi8jm11z5+mH6fVQBER8rWBHOQyx8DDxi5NXAiwC2PI1tVWbLJmb0WeSHRk1eW/nGunaeEKFsiEpFzs6UICTTPSq9lPoDy5UKySe7zPNyYPdP74B671J0oFMB7jjK50q6AO6HcBS0k1VOA1knsL6RD5SCCCPxgB7ZQ36N0LSQJm10eQLiTKmTiK+tVYu+Ou8iw08yV8T8TDvNHKPskWJ3xm2Pm94wsYNKr5JEesPah+VlSixLYSsqHo+rQm7QsRzESHfuO4vadnfxxri0gXjHbZNtMGI6bHzf0F3foOOYa75CBfpDPaW1Oz/gzI5hvkBv6tVdFXD808YClvYKmDDlpNklkdBPNgJj1VXXe5bJPb9S9CdJTcFo+pjdKLm3Bby/ySjh0axzCNhW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(33656002)(110136005)(316002)(86362001)(6636002)(26005)(6506007)(9686003)(186003)(2906002)(44832011)(5660300002)(66476007)(66946007)(4326008)(76116006)(8676002)(8936002)(66556008)(41300700001)(66446008)(64756008)(55236004)(53546011)(478600001)(71200400001)(55016003)(7696005)(83380400001)(921005)(52536014)(38100700002)(122000001)(38070700005)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU4vMVdpelBXS2tWb2RrL0VGSnFVaUc1blZvQThtRlNsRkVxU2Z4REE1N29C?=
 =?utf-8?B?ZEtxYjNPK3Rnb1lSRGR2ZzFhZDVXRGRIaW54OVk5OUw3ZnpNaTFUSS9DL2xs?=
 =?utf-8?B?dEdic3l4VjVKMWw4NndpSVlYYVZiRUdzejN3WitwTGJNNGU1NXBQOVJYWEx3?=
 =?utf-8?B?TWcvTFQ1elBrWm9BQ2VIZGRmd0Q5WHlsR08zajFxTDlMUUlBU00yQStxWHJC?=
 =?utf-8?B?WGxHOEpKcVk1aWFJZGJOOTBXUEpXR3NmRUtUVU9SU00wVkJWZlZqTENSQk9z?=
 =?utf-8?B?ODJWdFArMkVJU3c2UHNMQzVSYW5NWmt6UmRSS0ptZU40emlKS1VDTUk4QmxZ?=
 =?utf-8?B?WUF2eDFOWUVqRUQ5Y2JQcHY2dUZ0K0xXTjltb3BLelBCMEY5alVKQy9VMUJr?=
 =?utf-8?B?UlhNalpqUWZBdHlGSnR4a2dMeGdKeTlBQkRJNk9NOEk5WmRXamhKOTBzczVs?=
 =?utf-8?B?NU01QTFibnQzc1FvOVF4YkZqZTgwRVo5T0lEVEJkOFJlQ3BLRjl3NSs5WnJI?=
 =?utf-8?B?UjBoYVpwaDBRMXRJZk4yRFdlV25NL0JSKzJUbzBnNUV1VUpwbHRqYVM1QWdy?=
 =?utf-8?B?Tk9lM3NvNUI3VEI5WG9jL0NyV0JwdU5rRWVGSHhPODNVa2RoSjNtY3I2aTJz?=
 =?utf-8?B?YUh4YkhNelpGcTFGRnJiSW43WXRjNFFmMjRpTXZtSEFtQmNGaS94QUhHblhU?=
 =?utf-8?B?NzNMR3B0LzJDNWlQc2JQN0g0eGFVSGx4TmNiVGFUTXZGdmtLKzN1T3JQTFZK?=
 =?utf-8?B?VWtxdzZqMGV3VllGemluRk9XMkRVRjBIMWpRMHZpOWVPcWVLVXJ1RTNBM2Jn?=
 =?utf-8?B?WGR4RjJOT3kzbXhRZVM0dFo5TFppYVVRdmNnc0ZvZW5BVDF6b3ZOci9PT2Ny?=
 =?utf-8?B?WUg2Smc1Zk1EMkpZbm9Ya0VHb0NIV21YcUlNengyZ3NZRVZUZ2wvUHVYZmIv?=
 =?utf-8?B?dmFHLytVdmt1SHVsVGRMYm5PYzhXdkpuRlA1MDcyazltQTlXZllkVU9JV3RN?=
 =?utf-8?B?OVJYOWpPcWtSQURPeGtsSGhzUnFKKzFDYzJhTzlRMFc4c3lHdVZzQ3NNZzQ4?=
 =?utf-8?B?TGlJVkpIWGNrWEswQmtaMDVPNDFYeGJOWUR0WWhCVUJsMDVrdFZEZ2liYVph?=
 =?utf-8?B?SFJGWThzeWp0dEdoeHluM3ZlOTA1RjdPcVdKN1lweDR4bytYeDJOOW9MdkNJ?=
 =?utf-8?B?eEZJa1ozNGlvRHprWkw0OUc1bXFjcnRBWW5LYzNGUjIxbzdBZGNTNFBXV0xY?=
 =?utf-8?B?Tk5UVVhzTDhGbmhyUFpac2sxb2FsWkdPMzY5VEozb3MySVM5ZjFkVVFscWY4?=
 =?utf-8?B?Ty81WXJpYnZVN1VaeFZqUXQwMS9vS1pVcUxyRW5CZEhteWE2Y3pFdDRLZWFP?=
 =?utf-8?B?WTBCaG1GU0NHb2wvOURMeWZabzcvN0RsV3laTUJHZHR1ODR5WVNiRVV1QzZM?=
 =?utf-8?B?MDlwVGRJQmJMUjJsUjFEUnlrZVpvdis1N05xYlRSbFVpVEdlNWVTVmlMTi9z?=
 =?utf-8?B?VWFnaEZOTFBCMUtZU2l3QURlN1luQUc5QjNZRXN0Z1ZnV0RwczhzTnZnNVJC?=
 =?utf-8?B?UlJoWmUzK2srVThtVWZUUVE4L0tKdkZXMVdJNUJLNFNqOWNNMS84aWw1aTFI?=
 =?utf-8?B?N0g2ZEFmQk9qT3JYM0xnMkNOMjJPdFk2S2EwUG5ZUUI3QXpuV211V3BRKzMy?=
 =?utf-8?B?cjl6dmxRUkJVcUdhN0JUZ3Vqd0NCK09yZjIzUjU3U0oxSUZQeTIzWE9RLzlH?=
 =?utf-8?B?dkM0TEMvOGFIcVgvZWdoZGlQTUZNMDExb2dVRHBoejdmQ0UyR1VuWGwvT3dV?=
 =?utf-8?B?aFZGTHU1K2trMkIvZXRvMEFuK2ZCZWFzS0ZxOEtpQmNza1Vud3ppcDJtbGlP?=
 =?utf-8?B?amhxRnFpZUJXTi9EbDBEbURoTVdaazd0TFlGKzE5V25UWEFyRytoM2NpT2N6?=
 =?utf-8?B?N0E1ZU1SS01YZVFzVmpMY3dtMjQrSHViMFRHYS9FS2syV2EvNnBMVG5JSStG?=
 =?utf-8?B?c1hCbFNiVnRQS3l1YnAzVm5SeGNGQzdIbW03T1UvM2MvOU0xYkg3dUlSZFho?=
 =?utf-8?B?SXJ0M0FTL2p2WjNMK1ArNWRxM0pOOU1UNkhpb3IzUWdnTFlseEhGenBXb2o1?=
 =?utf-8?Q?Infq346i/JGkfFIlpi/0Nu/Pq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9deb12-3349-4d94-bf6d-08db1894d6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 07:32:54.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7p9VBly2XViSLJrfJSQqldB2Sdi2ctm6p2Jqcs6KzB9MNV7edokj7ZLSY0Gw6P4hwWV/3oopTgc/jdz0nxNyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHRoZSB5ZWFyIGluIHRoZSBMaWNlbnNlIGhlYWRlci4NCg0KQWZ0ZXIgY2hhbmdpbmcs
IHlvdSBjYW4gYWRkIHRoZSByZXZpZXdlZCBieSBtZS4NClJldmlld2VkLUJ5OiBQYW5rYWogR3Vw
dGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFZpamF5IEJhbGFrcmlzaG5hIDx2aWpheWJAbGludXgubWljcm9zb2Z0LmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjEsIDIwMjMgMTE6MDIgUE0NCj4gVG86IE1lZW5h
a3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5jb20+OyBIb3JpYSBHZWFudGEN
Cj4gPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47
IFBhbmthaiBHdXB0YQ0KPiA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBHYXVyYXYgSmFpbiA8Z2F1
cmF2LmphaW5AbnhwLmNvbT47DQo+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5jayBMZW5vcm1hbmQNCj4gPGZyYW5jay5sZW5vcm1h
bmRAbnhwLmNvbT4NCj4gQ2M6IGNvZGVAdHloaWNrcy5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSF0gZHJpdmVyczogY3J5cHRvOiBjYWFtOiBqcjogYWRkIC5zaHV0ZG93biBob29rDQo+
IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDIvMjAvMjAyMyA5OjQwIFBNLCBtZWVu
YWtzaGkuYWdnYXJ3YWxAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBHYXVyYXYgSmFpbiA8Z2F1
cmF2LmphaW5AbnhwLmNvbT4NCj4gPg0KPiA+IGFkZCAuc2h1dGRvd24gaG9vayBpbiBjYWFtX2py
IGRyaXZlciB0byBzdXBwb3J0IGtleGVjIGJvb3QNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdh
dXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KPiANCj4gVGVzdGVkLWJ5OiBWaWpheSBC
YWxha3Jpc2huYSA8dmlqYXliQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IA0KPiBUaGFua3MsDQo+
IFZpamF5DQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jIHwgNiAr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMgYi9kcml2ZXJzL2NyeXB0by9jYWFt
L2pyLmMgaW5kZXgNCj4gPiA4NzQ1ZmUzY2I1NzUuLmEyYTk5ZDA5YjRhZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMNCj4gPiArKysgYi9kcml2ZXJzL2NyeXB0by9j
YWFtL2pyLmMNCj4gPiBAQCAtMTk4LDYgKzE5OCwxMSBAQCBzdGF0aWMgaW50IGNhYW1fanJfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAgICAgcmV0dXJuIHJl
dDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBjYWFtX2pyX3BsYXRmb3JtX3NodXRk
b3duKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICBjYWFtX2pyX3Jl
bW92ZShwZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIC8qIE1haW4gcGVyLXJpbmcgaW50ZXJy
dXB0IGhhbmRsZXIgKi8NCj4gPiAgIHN0YXRpYyBpcnFyZXR1cm5fdCBjYWFtX2pyX2ludGVycnVw
dChpbnQgaXJxLCB2b2lkICpzdF9kZXYpDQo+ID4gICB7DQo+ID4gQEAgLTY1Myw2ICs2NTgsNyBA
QCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjYWFtX2pyX2RyaXZlciA9IHsNCj4gPiAg
ICAgICB9LA0KPiA+ICAgICAgIC5wcm9iZSAgICAgICA9IGNhYW1fanJfcHJvYmUsDQo+ID4gICAg
ICAgLnJlbW92ZSAgICAgID0gY2FhbV9qcl9yZW1vdmUsDQo+ID4gKyAgICAgLnNodXRkb3duID0g
Y2FhbV9qcl9wbGF0Zm9ybV9zaHV0ZG93biwNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0YXRpYyBp
bnQgX19pbml0IGpyX2RyaXZlcl9pbml0KHZvaWQpDQo=
