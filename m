Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00D618AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiKCWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKCWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:01:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657C2253E;
        Thu,  3 Nov 2022 15:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOwXL769vFGdDdFP7rNugM+s4pWMsflGgv/rcaoBBoxHV8fe5cFlxVggcYF+0Mf/Dji0xVYFRl2O/YNDrJTm0Kx7gNKIXq0f1DONH6SUybPbZkMDaLgxvuT+lgUIbPZnmuEievl7DAi62ZSzc1SERtGUgiUDpu6ppPGWV3zY6+6CixvMPv64kWL1scqDx271M/Yy7o4xyAOuoGF1RTSZO5wGC25OvDltKarkl7l7kq0qaeE6RdtgV4VPVEF95ro9wtd/rzRGeXvvG/bu/KJQ8+HM6eZ8Dp5xFF9R2Pn+Dr0JJo39IVDZg9PTyaLvU6uUlf5giYM+aSwoOBqEHzwp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z7Snaqv8xQB4T+MspVq0uT6rkVZmNk5p6JvZbKbQ5Q=;
 b=QW3qvaaZel9J5homxxo4MpifZeYdz2ZG7PxOsUG6eiV79yTksHYbt6RYKRfR8XiuwnMYZh6Edg6wm3pqAezSbuqf7Gw+i4wMGXmtKfJSUijcNMT9Y1VzHvPJEB96bio2zAovF2uLnVCLZSACmbbPNctu5VSvKKljcfzFbmiaACJ553rNvS6qkH1tG21oYgWu+t7SqfIpc8QiGTWGj/zZAokqdwGAWoPPTRw3wozQEJCzIl3PtrUAEZe6khSxO+InaKyen7FUsKYV7Yvh+7MBHhTmlUxg075Qp6V1RAwRwQ449LBfWr0QFA4FUzZuOt2Co8a8pNKi6QnroPXLt+sSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z7Snaqv8xQB4T+MspVq0uT6rkVZmNk5p6JvZbKbQ5Q=;
 b=REiffqsS1v8OwL1tmwQehGn5v8VOFGFlWJrdlllM/qGB9senGvMhtDzztS0pcvwCS8CWrdEE+2kGEoIdYBkkEkfavM+CLRFJBHylXhdmas6b4CIBycqTDJqBxqUE3ZsHaRghjNzZNI1wuO52H6g2n/9MDIeFXwpoF8neBhS0Tj0=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 22:00:59 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 22:00:59 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoCs
Thread-Topic: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoCs
Thread-Index: AQHY6gVeX3SebRJQR0Sx7ujJu+aLiq4tyw0w
Date:   Thu, 3 Nov 2022 22:00:58 +0000
Message-ID: <PAXPR04MB9185E538798F83B3C03C70EA89389@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8828:EE_
x-ms-office365-filtering-correlation-id: 51adb65a-3cb2-4a42-d8e3-08dabde6e3e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCLly5+GMuDvijTLwAFJ42RbfvNLS2qSGvAnW79Y9fBgr05Ya0j/8Gun8HeWCu1jxw6vVvJwAmAG1jqALkn8VfFjf7unE1IhIctB7EJw8kIvuCVp4v7LezndKemf2wkRKZg5l7uCEg83Vg0VlvVDI4YRqyEMfjGG2hqtkP97oVkpfPyuP/PE3QVWJStbij5TXC5x17+fcCurhEWy2KP4OpzLD9WaSxPX76paa+Rq26VJDo0TJrD/0XDZo8WfjkA2qq+ESrT9SCdhfTxWXmrm02tCqxqkDwa8XSef8SeS6aNSr/yHVGIIHtHf2Vt4ieals2ftCvHGE3RN7y1afihRiJfgeqao3Y95qCdDS61SlK7bK7e+DLz5q0TjBAeVTzkHWW6xOeVcrsQVDcXF4uyJd02PgEN+hIF1PNRaf/AXdLvJwLvz4ZqP7USrMrb94/FS8RfmWb7xkBlw21GrMiR4mTy74iI/ylpM/SKpuWk7Lrvr63zQTV7oYfJpmhv7cH7gzcXK3CIGiYAQlBXtpi9KgKoR9t3q8ufPceveh5x38gerofnScAayiFFeypSkMcZnqUtTDaC9/1l6woPukbuOiKhPEIq4LDZyXPRqzq7g3XX+6I7GGFP+n6cEYxwd6fVF7GMRdJIsfZQTSlGO4OBvbeydebfWKQhWfy0GIDONfyjNQAVc1FGKU4+wd/rk4CWJh3s89wte1ptoHaIiWYsHb5aECteCmUiGIau2YmdfSod4elcv0mhp265ha+x06BWUCYTTTgIpD3qe2DyhRG20zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(44832011)(33656002)(86362001)(122000001)(83380400001)(38100700002)(2906002)(38070700005)(7416002)(7696005)(5660300002)(66946007)(52536014)(64756008)(76116006)(66556008)(9686003)(6506007)(4326008)(55236004)(8676002)(41300700001)(66446008)(15650500001)(66476007)(26005)(110136005)(55016003)(54906003)(186003)(6636002)(478600001)(71200400001)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGIrb3FSZ3JVR0duZkJyZHpGdXVrUUpCTUVRK1RaajhYbGp1QmlpR3ZkK0ZW?=
 =?utf-8?B?aVJNNU45dmVvU21DM2crVElqdENYOVhrSUJ1NWRkeVNWbVlzbmFlaDFOMnEw?=
 =?utf-8?B?b2V5SkFsWW5KMnd1aHlrR1VMN2NmUGxQR0xKRkR1aWVXdWNRak1KVHZoNDA4?=
 =?utf-8?B?Wld0VXY2blIxcDhpZlpIbjJya0VjSFN5UzVlY3lUNXB6UnVsYmtldi9MV3Nh?=
 =?utf-8?B?VDRBSWxVdklLRXFJMEtna2pxNDk2ZmJ6d3JTeWs0NThMOUF0Yk4xU21hY2Zx?=
 =?utf-8?B?OTBudEZoMUJEN0hJcElpRnZPUHlvUmZhaGpMbmo2R21vZFdyY084dURQYjJY?=
 =?utf-8?B?K2d3dExRMXVsek80Y1FENUUzUzcrZXgwcmZtSE5HZXBybjY5RDludCtJRGRK?=
 =?utf-8?B?SnlrNjU4ZzNKU3I0SmkvUDhWZkVWT3lYMDQ1Sk9VZHoyMFlva0lsTE9UdDhS?=
 =?utf-8?B?cXFuaUZzWWEzNlpSeUhaZ1FzZ0tFWmx3QVNpWXYyQ2U4SFJMUWpRZjY0T0Jj?=
 =?utf-8?B?VE50MFcrb0gwZk5aTjFKU2VkMm8veklvOERsbkg5ZzR0ZnNNZ3NaQndoY2FK?=
 =?utf-8?B?ZmdmbzA5OTc3cU9LL2NwUVFVczFveVk3WGprTzJ2OW1JQ1Z5M2xCcElVZzlM?=
 =?utf-8?B?TWxVS0FLSENSZjdQeGRjcFhOQ3NZeHVIcExadFpMdkVwbTI0Qkp4QTVMOHFa?=
 =?utf-8?B?WGlkVFJybXIvRU12RXVLNGMrczdLOGRyOXNiU1VRVXdxWnRmSjBVbk9keDNl?=
 =?utf-8?B?T0xTckpXODRONWE0eWtoRXY0MTI0MkwxcHpwVUlTa0Uxb1I0UmxNWFBRQzRu?=
 =?utf-8?B?bU01ZFRtTS9teGtFbXdMdHhNb3FFY3hJbHB3YVdnbTIySlRNci9HYmpqbVc2?=
 =?utf-8?B?bTlXc0g1YndFZ2ZSL2MxUnJPNkx4Z2RxSEc0T1o0OVlRempxZTBZZWZSRXVX?=
 =?utf-8?B?UDF5cVJsU2VpY0tJZnF2WGc5NXZpaXphTStlZk5abmhkSEJFWUxRTFAwNU9K?=
 =?utf-8?B?djU5anJHWjRLYTduQU41SzRVbnJ3OVBOTnpDeUpZR2l4V3YxR1Rac0NmYmt6?=
 =?utf-8?B?L3dNYWxPbUdtMHBkdHJVYXcwSWVRelVDMHIvZFg5dEIyVVg0VE9tSDlCZFZM?=
 =?utf-8?B?b1FOTDNsUWhCaWE3ZjQ2M2QwRURrc3Z4N0FpN3FaamlIeTlOTHc0dFk5eTVk?=
 =?utf-8?B?WjlYOHV0YmJGeldUVkllc0VSYVgyUzVtK3ZWZVlKS3pMenVzZVhYbXRGMWQz?=
 =?utf-8?B?Vk5odzdnYm5SM2tlNnNLNUFpN05zVnl0SFlEMGhPZXJHMGE1TnNOWUNtZTVS?=
 =?utf-8?B?WWQ3a1lBZkk3cUpVUHpDSXQ5WFdMQVRsSWU0dk92WUI5TTZwYkF1RCs0R2Qz?=
 =?utf-8?B?QUhQSDkwc0hNRFJtcWRBWFNYRDVvNHg2cFRmZDhJbWpSZndLemFiTW9YdWVm?=
 =?utf-8?B?RUxHc2FucUxpS3ppYWxFV0V3cHJMbG9veVpoM21kR0wvOURZNU5jZ3RUWjFq?=
 =?utf-8?B?S3cvNVNvUlBmNXNkVGtBQ0tJNG5hYXhzVGhmRW4yTVBPbk1ZVEZMM3FpajR5?=
 =?utf-8?B?Ujkrb2NqeXhCRlVTbEV5ay9IL3dDMVl4L0VYNURTZU9PMzd6SzRQckcrRndZ?=
 =?utf-8?B?TitTd1B1cFhkMm5sNStrd2c0U0g1U2x0emUxMnhIc3AxbGNYcUV4cEQ0ZWpF?=
 =?utf-8?B?WEV6TEk4YkVxdUoxMU1CRUFPWi9mNGJHVlNmWWpzTDV6aHlMeGRpVEdJY0lG?=
 =?utf-8?B?YkNWeVVjS20rNStaSE5LNTR0T3dqd3ozMXI1NXpTRk85WDhESjJUR2J4U1lU?=
 =?utf-8?B?cUdSajBUbm9QU2x3L0V6QVlPR01FYTQyTEIwQWtwQkhlMWUzWVc2ZXAvc1p4?=
 =?utf-8?B?Njg3N3RzV0dOWDNDNmtCcU1FUlo2eHZLSTVXTWliZE9XM2hBQ056TGtvWkN3?=
 =?utf-8?B?b2lrZ2piZ2JJV2p5NDBmT2Q4MUZqM3ZXUnVodG55UU1wOHlZUUhPUVlla3hJ?=
 =?utf-8?B?LzRDNEVmSkJxUGZhd2FzZ2EyY0VGeUx6RDBwRDRDZlIzdm9JMXVxMjEvbWRa?=
 =?utf-8?B?bVFXZStPWFZHdmR2Y2ViMkJiTU5uQll5T0dSdkk0VUUxcjk3UnJ4ejZCa0wy?=
 =?utf-8?Q?AGeR7cmy4b78D16wyvePphqYX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51adb65a-3cb2-4a42-d8e3-08dabde6e3e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 22:00:58.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCqxqIPcQHJy9rQRX0weTC0mxmNDctzmiS7jdx023BOlToS6SnUWUzo3squMMzhBGgIjLGfRclgrdu+U/pDYpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gU3ViamVjdDogW1BBVENIIHY0IDAv
NV0gZ3BpbzogYWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQgZm9yIGkubXg4eCBTb0NzDQo+IA0K
PiBPbiBpLk1YOFFNL1FYUC9EWEwgU29DcywgZXZlbiBhIEdQSU8gaXMgc2VsZWN0ZWQgYXMgdGhl
IHdha2V1cCBzb3VyY2UsIHRoZQ0KPiBHUElPIGJsb2NrIHdpbGwgYmUgcG93ZXJlZCBvZmYgd2hl
biBzeXN0ZW0gZW50ZXJzIGludG8gc3VzcGVuZCBzdGF0ZS4gVGhpcyBjYW4NCj4gZ3JlYXRseSBy
ZWR1Y2UgdGhlIHBvd2VyIGNvbnN1bXB0aW9uIG9mIHN1c3BlbmQgc3RhdGUgYmVjYXVzZSB0aGUg
d2hvbGUNCj4gcGFydGl0aW9uIGNhbiBiZSBzaHV0ZG93bi4gVGhpcyBpcyBjYWxsZWQgUEFEIHdh
a2V1cCBmZWF0dXJlIG9uIGkuTVg4eA0KPiBwbGF0Zm9ybS4NCj4gDQo+IFRoaXMgc2VyaWVzIG9m
IHBhdGNoZXMgZW5hYmxlIHRoaXMgd2FrZXVwIGZlYXR1cmUgb24gaS5NWDhRTS9RWFAvRFhMDQo+
IHBsYXRmb3Jtcy4NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+ICAtIGZpeGVkIHRoZSBmb3JtYXQg
aXNzdWVzIHJlcG9ydGVkIGJ5IFBlbmcgRmFuLg0KPiAgLSBjaGFuZ2UgdGhlIHJldHVybiB0eXBl
IG9mIG14Y19ncGlvX2dlbmVyaWNfY29uZmlnLCBhbmQgbGltaXQgdGhlDQo+ICAgIHN1c3BlbmQv
cmVzdW1lIGJlaGF2aW9yIGNoYW5nZXMgb25seSBvbiBpLk1YOFFNL1FYUC9EWEwgcGxhdGZvcm0u
DQo+IA0KDQpBIHNvZnQgcGluZy4g8J+Yig0KDQpSZWdhcmRzLA0KU2hlbndlaQ0KDQo+IENoYW5n
ZXMgaW4gdjM6DQo+ICAtIEFjY29yZGluZyB0byB0aGUgZmVlZGJhY2sgZnJvbSBMaW51cyBXYWxs
ZWlqLCB0aGUgd2FrZXVwIGZlYXR1cmUgaXMNCj4gICAgbW92ZWQgdG8gcGluY3RybCBkcml2ZXIs
IGFuZCB0aGUgYXJyYXkgb2YgZ3Bpby1waW4gbWFwcGluZyBpcyBtb3ZlZA0KPiAgICB0byBncGlv
IGRldmljZSBub2RlIGFuZCBpbml0aWFsaXplZCB2aWEgZ3Bpby1yYW5nZXMgcHJvcGVydHkuDQo+
IA0KPiBTaGVud2VpIFdhbmcgKDUpOg0KPiAgIGFybTY0OiBkdHM6IGlteDhkeGwtc3MtbHNpbzog
YWRkIGdwaW8tcmFuZ2VzIHByb3BlcnR5DQo+ICAgYXJtNjQ6IGR0czogaW14OHFtLXNzLWxzaW86
IGFkZCBncGlvLXJhbmdlcyBwcm9wZXJ0eQ0KPiAgIGFybTY0OiBkdHM6IGlteDhxeHAtc3MtbHNp
bzogYWRkIGdwaW8tcmFuZ2VzIHByb3BlcnR5DQo+ICAgcGluY3RybDogZnJlZXNjYWxlOiBhZGQg
cGFkIHdha2V1cCBjb25maWcNCj4gICBncGlvOiBteGM6IGVuYWJsZSBwYWQgd2FrZXVwIG9uIGku
TVg4eCBwbGF0Zm9ybXMNCj4gDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhkeGwtc3Mt
bHNpby5kdHNpICAgfCA0MSArKysrKysrKysNCj4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHFtLXNzLWxzaW8uZHRzaSAgICB8IDM4ICsrKysrKysrDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhxeHAtc3MtbHNpby5kdHNpICAgfCAyNSArKysrKw0KPiAgZHJpdmVycy9ncGlvL2dw
aW8tbXhjLmMgICAgICAgICAgICAgICAgICAgICAgIHwgOTIgKysrKysrKysrKysrKysrKysrLQ0K
PiAgZHJpdmVycy9waW5jdHJsL2ZyZWVzY2FsZS9waW5jdHJsLXNjdS5jICAgICAgIHwgMzAgKysr
KysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDIyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiAtLQ0KPiAyLjM0LjENCg0K
