Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4362B187
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKPCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:52:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C321EC5B;
        Tue, 15 Nov 2022 18:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQpqK2S8eK7bwyyN312gp4Wgs+LrgIOndrbVdsMc6xmYzd5+bkavez3HbtTzjEwXXuVl6U8ZEQNXEV4vruPTueNMlZz1EzwkUJKRmpWoQaT2j8O3Jacr3lBfDyLVDXhM1OdyPkLOSgrg0DL7FDSvdhuHJqN02rxifsJDGrp6ghxKPOStlxokSfK7lkWxAwWEP+yIVJtWDKx4Gkgw4lSGwkTSACjleiUj158zknfhFJg8BTLzrhiV3g/Zu/HG2b/sSRBKziyB03NBOdCwLdGZg277XqLLA8+BO1Hi6s4LTzRlfOhJOqubB8c5fwgGZmWO6GEoO6eLyDTI40fZsditjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pafjnzGWwxX5+WJS0Uo+Y6EyovdI7d95JY8QNHDYeRs=;
 b=TznMjl7Xc4vg5LWP22etDBvUQKsWDXpHmrt1WI5dSFZMnvmHvegILWEBkz/hAXyTAPMv93/nIbThJh3xxWFN8dGTW3PiPc6IRFBjKsfGBB5N5mn/ZKDZxE3oyhW+yZY4rLyXCX6EzHhrQyyKpnaQzECQVzB2FpXmMwcs2SdL645XV5z1Kt31L1Rz70awlC+04CZaWm9ic4zg0hrrVKd7UMAmngQH6z222PDac8ueiPddKlsBXicM4F6AGLEpKrnSXa7kJKEy4eTP7Sw0gTXRSKCBJktiz0duQwr9PM0FttC4q2usDXH+t1h5h1IdCD5ymOU+MnaTptMKaypo15n7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pafjnzGWwxX5+WJS0Uo+Y6EyovdI7d95JY8QNHDYeRs=;
 b=qLK9zu3PeZQEuqhN8EmCo/lp70QtIJJ1PtSsVXfb9V44/nD48JmCKCy20eQ+JjPl5QkUu4QJVd+LxIuBQZ4zYEgX+FlKA89RCItYDQre41iQMJARqfClZCLRsqnQtk3uImAaStXfDRj2EdElRWWVPsFyasDaABry6zwcef/YXJs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6801.eurprd04.prod.outlook.com (2603:10a6:208:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 02:52:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 02:52:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Thread-Topic: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Thread-Index: AQHY7qwGSZCShnOsAEiFFgQUaE6HCq4r5waAgADAqMCAAj7jAIADun7QgA3C/gCAAIof4A==
Date:   Wed, 16 Nov 2022 02:52:43 +0000
Message-ID: <DU0PR04MB941731CA8DD04715E9DDC8B388079@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
 <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
 <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221104152732.GA1873068@p14s>
 <DU0PR04MB9417DF72B41F79CCF63823DF883C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221115183304.GB61935@p14s>
In-Reply-To: <20221115183304.GB61935@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6801:EE_
x-ms-office365-filtering-correlation-id: 8a0d08a2-cfab-4dba-1189-08dac77da29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyECUdp2B0r1Q3QHYA93Vg+yEeXx/F/hG8hx4R40QyA8srFUYx4fIJ8JTGIRWNOj5oSRzzIM04cPs1sLuGH8J/j3qHolc/8oosICzLEB0HAYerJLCT5xqgAcbV3ZAmYKGEu1W20QyMUxz0rWBODkaNXmGEwqG4kDJbxjVtVXD3Ns2SnwL7gxQRLcXEWzAkRqzSDHHZ2QZ9V+Iw0t9lYL1Sj5qSHkkHQkhfxbcjChiDO8ImvNRcdevdvGPOO2vCbONBENlIWsVN+WjiW8tut3Wf0N+yc3KcDEEA+HGbxF/u60dOnHZRkSELB3Fzep8Eqys6VPx8KU3bJY8lgp8+VKAksVB1wds7NLadJ1ofot9Y/ysJFclqXIPrCAd96n+wummigbR6yWVwFxBdfRe1t+Tybt2PTj1SNEzoixsJiLqisjPICA0p9HNhtWzKP3Uz3knzB69oIVxgx9g2AKA1hqXi/kX8iAe06YSfMfF3simG5F2cZS8XtwOO92aPhvp2G+glwI6XKhRTHzinlGu93uAxAvVeBw2VSxmjin25uH89IoEVhM+iDeb/yS14vDMtemFCDElAl8hYjorFNdPspESvI2X0IxPosMX9QK7KagrokEWjvlzweEWxoNc5zU4VyC4JWa1cpL7aXqZ4lB+CrmitZsoEN/dd0aImazK0aWuAriWJ8PxqsD4Sik06ugTRvpnuE2y4rQcov8Ei0BroE3jLlkztMm0wjXpYIAN0Jere93vy0mal3uxxXdSYudqpvPkl+xwGNomIb/A6HqwXHA6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(478600001)(54906003)(6916009)(83380400001)(71200400001)(8676002)(4326008)(38070700005)(66946007)(66476007)(26005)(66556008)(76116006)(64756008)(66446008)(41300700001)(86362001)(38100700002)(316002)(186003)(8936002)(5660300002)(52536014)(7696005)(6506007)(53546011)(9686003)(44832011)(2906002)(33656002)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlVST09ZS1VhNWoydVdCaE5uUU8xNzBUdFhpemVKN2QzMDZqQmErVnIrZC9F?=
 =?utf-8?B?UWlmZjBKUW4zVlpxNUVmOUlLY2RDVHN1cCtZbnNMSTJtby9TNENPNk80eUxL?=
 =?utf-8?B?emdEckttTzVOc01yK3BCeDNqa3ZGYnZNalFJV3d6YVdoOGJiVjEyYlJzSEVS?=
 =?utf-8?B?b1JkYXVubitjNkc5UHo2M1lMLytxYVRZbjV1dW9OZEJadHZpaTh0MURLc0ln?=
 =?utf-8?B?bGpRcFp6R3ZidmJ3azUzanhwLzBqQ1ZzUTJKMElSVWxXZGEzeXdHbmkvMEh1?=
 =?utf-8?B?dlNBcWN1VXdleDFQWUNpaVN4OGpNN0J4WlZQbVYrVit4VkNXU0p4THZjNlRo?=
 =?utf-8?B?M2Q4SEh5eHV5VXRFdit3Um9zbkxmQTJmRXVMcmNacGZ0Tmd1YmJZN2lwb3lO?=
 =?utf-8?B?WkE2OVZTdEdVRzdkNWx0RUx6UXpiRHFIei9sM1hJcEtLRXNHRm9QTnc5akdE?=
 =?utf-8?B?bnlFM1NzclQ1WXB2Y2hVb1U2UUNVTnNGelp4UzkvZkkxSmFLVFlzanE5aGs1?=
 =?utf-8?B?OTFRRGE2UGlQVGI3VGZBb0dxSWZ2ck43SmdwQ0Z4NGFNT2M2MW9OdW85R053?=
 =?utf-8?B?QnJOdnBqcWxzeGhDNG9jK0ErTGVOS1d4S2w2ZFVxRytDaTRvSHdkU1lFZ1Y0?=
 =?utf-8?B?QkRRZE4wcS9iNGRGR0VkdHJ1eEloclZxN2VjaXZLTHFlN0xOdXRaR3F0dGhZ?=
 =?utf-8?B?UHBUbkZhU1FvdzNQNERVMDZFMlgwN2R0TWdlVHB4c0daV3l5RW5zN203MWhH?=
 =?utf-8?B?N3YzZmVqcS9HcGhYYUdIV3lwMVFWRVc3THV5Q3dWMDUyVGxKS2RjdDQ1b1Vx?=
 =?utf-8?B?TlV1SVpKQ2dpRzVKUllEWEtPdFFHSm4ySjRpcURWSzNDQkRlWUMxczZERG90?=
 =?utf-8?B?SUxWVUZUdXVyc0p3TmFzUG9odWtOcVlLUDE2Rm1pMXZkL3JuS203cFkzZ1pB?=
 =?utf-8?B?ekVFTzJlcUE0czJTWlJ3L2M4Nk9LT0pURDJNbkUyNG9aR0E5UnJEa0w3UHZu?=
 =?utf-8?B?K1RBWGZSd3VWN25aZXU2anFVbXZkM1QxM09JZDdhdGo5MGJGdWl2VkV6aU1D?=
 =?utf-8?B?VGR5VlNrYW9Ka2FiQ24zTXVVTE9xc0dWZkpwSGVlMThWVzlJbnRkbnpjaWVw?=
 =?utf-8?B?RWRVODFrR2FlUlVMSVBhbkVYa2hFYXRmbEJzWjRXZjVJd294Q0JXc2RXdEdR?=
 =?utf-8?B?SmVYZVhDMVJvVDF6K1Z1eUJDVHA0eU93ZCtzeUpoMm9SM1FPdkEvOUI0eTN3?=
 =?utf-8?B?WGpTaitCRDNBaW1kN0J2ODFwSEFTVEFLazFyNXJGZnF4U3BGTXo5U0Y5RHBj?=
 =?utf-8?B?YlFVa3Z0ZVFCV0lveWNHdDBUK0lkclp5K3hZRTJkRFhJUFliUThkZUpWRnc2?=
 =?utf-8?B?Lzl6bUhuRE1lSXVjRjArQmdYSjVHYU53NHBBWnVEVC9IZ3RLVEZiZmF3Q0tD?=
 =?utf-8?B?aVBvMjR4VjNSUzI3RjJzdUNnbXE4ZWR0bk9vRElSSVk2ZHY3cXliSUNuU1Q2?=
 =?utf-8?B?cm1iaGxOSHRLckxjRnlIKytwNWJkbG9SdHdMY1VUK2luT0VPYitGbVd3TDRG?=
 =?utf-8?B?N25oeU5pZWRBQ3hUSWwrdTFnVi8wT0FGM0VTU2VrNXphQVNSYkVKeGJVNzU5?=
 =?utf-8?B?ZHBtQmhUR3JHTzVIQWtuVnpKLzdYU3lpSE1JY0x0dWZSV2RWeDB1V1Q0SG9x?=
 =?utf-8?B?OVhNaEdxSHBlbVdNVkg1RTZJeHFoT1dqS1dZRWdnNVdReTdscHFneC9RRWZM?=
 =?utf-8?B?YkRXSnRjSmNmQjRqa3pWWFlaMi92T05VLzdHRTg2aUZKS0o3SU1pMDdZQ1h4?=
 =?utf-8?B?aHhMMjBCUFFlMUY5MXVWT0hDVEhwWWRDajNOQXdWTktPRjlJLzJicmZVaHow?=
 =?utf-8?B?bTNKYVhlRi9QN29RK1FUbGVCdnNrRW4wS1N5UVRwbWxkMEIzU3F4S0dSTnJ0?=
 =?utf-8?B?bW04ZlQ2M3lkUjZZREZIYnEwaDA0MmEwK05rU21qRU96bkI5RHJXTmxuTEZX?=
 =?utf-8?B?eFoxVm1BTjYxKzBKMkU3K0ZFb3RjTjFLTGRrZmpuWU9PZW85WnVlZkIxSWg0?=
 =?utf-8?B?Q1JUcE1yS0ExZ0Q4TjAveVpYcEVjek5wWFZFOXdyVjZtbWtWM2tIQjVrMlNv?=
 =?utf-8?Q?vWuE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0d08a2-cfab-4dba-1189-08dac77da29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 02:52:43.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjDVFtxQU400to+rM/K0yTh0bMINffiu3CXaI1aYaOhcpeBmzAPFUCtjnoWFZMOzgiPYImhJ1b6dMscGhKhn2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IGNvcnJlY3QgaS5N
WDkzIERSQU0gbWFwcGluZw0KPiANCj4gT24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMTI6Mjc6NThB
TSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVy
QGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiAyMDIy5bm0MTHmnIg05pelIDIzOjI4DQo+ID4gPiBU
bzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiBDYzogUGVuZyBGYW4gKE9TUykg
PHBlbmcuZmFuQG9zcy5ueHAuY29tPjsgYW5kZXJzc29uQGtlcm5lbC5vcmc7DQo+ID4gPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7DQo+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+OyBsaW51eC0NCj4gPiA+IHJlbW90ZXByb2NAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC0ga2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gcmVtb3RlcHJvYzog
aW14X3Jwcm9jOiBjb3JyZWN0IGkuTVg5MyBEUkFNDQo+ID4gPiBtYXBwaW5nDQo+ID4gPg0KPiA+
ID4gT24gVGh1LCBOb3YgMDMsIDIwMjIgYXQgMDY6MTE6NDZBTSArMDAwMCwgUGVuZyBGYW4gd3Jv
dGU6DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gcmVtb3RlcHJvYzogaW14X3Jwcm9j
OiBjb3JyZWN0IGkuTVg5MyBEUkFNDQo+ID4gPiA+ID4gbWFwcGluZw0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gT24gV2VkLCAyIE5vdiAyMDIyIGF0IDA1OjEyLCBQZW5nIEZhbiAoT1NTKQ0KPiA+ID4g
PiA+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBBY2NvcmRpbmcgdG8gdXBkYXRlZCByZWZlcmVuY2UgbWFubnVhbCwg
dGhlIE0zMyBEUkFNIHZpZXcgb2YNCj4gPiA+ID4gPiA+IDB4W0MsRF0wMDAwMDAwIG1hcHMgdG8g
QTU1IDB4QzAwMDAwMDAsIHNvIGNvcnJlY3QgaXQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
Rml4ZXM6IDkyMjJmYWJmMGUzOSAoInJlbW90ZXByb2M6IGlteF9ycHJvYzogU3VwcG9ydCBpLk1Y
OTMiKQ0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3JlbW90ZXByb2MvaW14
X3Jwcm9jLmMgfCA0ICsrLS0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVy
cy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jIGluZGV4DQo+ID4gPiA+ID4gPiAyYzQ3MWU0NmY0Y2Eu
LjlmYzk3OGUwMzkzYw0KPiA+ID4gPiA+ID4gMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcmVt
b3RlcHJvYy9pbXhfcnByb2MuYw0KPiA+ID4gPiA+ID4gQEAgLTEzNCw4ICsxMzQsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGlteF9ycHJvY19hdHQNCj4gPiA+ID4gPiBpbXhfcnByb2NfYXR0X2lt
eDkzW10gPSB7DQo+ID4gPiA+ID4gPiAgICAgICAgIHsgMHg4MDAwMDAwMCwgMHg4MDAwMDAwMCwg
MHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPiA+ID4gICAgICAgICB7IDB4OTAwMDAwMDAsIDB4ODAw
MDAwMDAsIDB4MTAwMDAwMDAsIDAgfSwNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtICAgICAg
IHsgMHhDMDAwMDAwMCwgMHhhMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPiA+ID4g
LSAgICAgICB7IDB4RDAwMDAwMDAsIDB4YTAwMDAwMDAsIDB4MTAwMDAwMDAsIDAgfSwNCj4gPiA+
ID4gPiA+ICsgICAgICAgeyAweEMwMDAwMDAwLCAweEMwMDAwMDAwLCAweDEwMDAwMDAwLCAwIH0s
DQo+ID4gPiA+ID4gPiArICAgICAgIHsgMHhEMDAwMDAwMCwgMHhDMDAwMDAwMCwgMHgxMDAwMDAw
MCwgMCB9LA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQnV0IGhvdyBkaWQgdGhpcyB3b3JrIGJlZm9y
ZT8gIFdlcmUgc29tZSBTb0MgcmVsZWFzZWQgd2l0aCB0aGUNCj4gPiA+ID4gPiBvbGQgbWFwcGlu
Zz8NCj4gPiA+DQo+ID4gPiBBcyBpdCBpcyByZWd1bGFybHkgdGhlIGNhc2UsIHlvdSBoYXZlIG5v
dCBhbnN3ZXJlZCBhbGwgbXkgcXVlc3Rpb25zLg0KPiA+DQo+ID4gVGhlIERSQU0gbWFwcGluZyB3
YXMgbm90IHRlc3RlZCwgSSBqdXN0IHdyb3RlIHRoZW0gZG93biBhY2NvcmRpbmcgdG8NCj4gPiB0
aGUgaW5mb3JtYXRpb24gSSBoYWQuICBJbiB0aGlzIHBhdGNoLCBJIGp1c3QgZml4IHRoZSBtYXBw
aW5nIGF0DQo+ID4gYWRkcmVzcyAweEMwMDAwMDAwLCBJIG5vdCBhZGQgMHhBMDAwMDAwMCwgSSBt
YXkgYWxzbyBhZGQgaXQgb3IgdXNlIGENCj4gPiBzZXBhcmF0ZSBwYXRjaCwgd2hpY2ggd291bGQg
eW91IHByZWZlcj8NCj4gDQo+IFNlcGVyYXRlIHBhdGNoPyAgVGhpcyBpcyBhIHNlcGVyYXRlIHBh
dGNoLi4uDQoNCkkgbWVhbiB0aGUgRFJBTSBtYXBwaW5nIHN0aWxsIG5vdCBjb3ZlciAweEEwMDAw
MDAwLCAweEIwMDAwMDAwLiAgVGhlDQpjdXJyZW50IG1hcHBpbmcgaXMgYmVsb3c6DQogICAgICAg
IC8qIEREUiAqLw0KICAgICAgICB7IDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAsIDB4MTAwMDAwMDAs
IDAgfSwNCiAgICAgICAgeyAweDkwMDAwMDAwLCAweDgwMDAwMDAwLCAweDEwMDAwMDAwLCAwIH0s
DQoNCiAgICAgICAgeyAweEMwMDAwMDAwLCAweGMwMDAwMDAwLCAweDEwMDAwMDAwLCAwIH0sDQog
ICAgICAgIHsgMHhEMDAwMDAwMCwgMHhjMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KDQpGb3Ig
MHhBL0IwMDAwMDAwLCBJIGNvdWxkIGFkZCBsYXRlciB3aGVuIEkgZ2V0IGFuIE0zMyBpbWFnZSB0
aGF0DQpyZWFsbHkgdXNlIHRoYXQgYWRkcmVzcyBpbiBmdXR1cmUuDQo+IA0KPiA+DQo+ID4gVGhl
IGkuTVg5MyBTb0MgaXMgc3RpbGwgaW4gcHJlLXByb2R1Y3Rpb24gcGhhc2UsIGFuZCB0aGVyZSBp
cyBubw0KPiA+IHB1YmxpYyBJbmZvcm1hdGlvbiBmb3Igbm93Lg0KPiA+DQo+IA0KPiBUaGF0IGlz
IGFsbCBJIHdhbnRlZCB0byBrbm93LiAgT3RoZXIgaW1wbGVtZW50YXRpb24gY2FuJ3QgYmUgYWZm
ZWN0ZWQgYnkgdGhpcw0KPiBjaGFuZ2UgYmVjYXVzZSB0aGUgc2lsbGljb24gaXMgc3RpbGwgdW5k
ZXIgZGV2ZWxvcG1lbnQuICBTaW1wbGUgaXNuJ3Q/DQo+IA0KPiBJIGFtIGFwcGx5aW5nIHRoaXMg
cGF0Y2guDQoNCk90aGVycyBhcmUgbm90IGFmZmVjdGVkLg0KDQpUaGFua3MsDQpQZW5nLg0KPiAN
Cj4gPiBSZWdhcmRzLA0KPiA+IFBlbmcuDQo+ID4gPg0KPiA+ID4gPiBUaGUgY3VycmVudCBtMzMg
ZmlybXdhcmUgcmVsZWFzZSB3aXRoIExpbnV4IFNESyBvbmx5IGhhcyBUQ00NCj4gPiA+ID4gdmVy
c2lvbiwgc28gSSBub3QgaGF2ZSBpbWFnZSB0byB0ZXN0IHRoZSBERFIgbWFwcGluZy4NCj4gPiA+
ID4NCj4gPiA+ID4gSW5pdGlhbGx5IHdlIGdvdCB0aGUgaW5mb3JtYXRpb24gdGhhdCBNMzMgbWFw
cGluZyBvZiBEUkFNLg0KPiA+ID4gPiBEUkFNIChvZmZzZXQgMCBNQikJRFJBTQk4MDAwMDAwMA0K
PiA+ID4gPiBEUkFNIChvZmZzZXQgMjU2IE1CKQlEUkFNCUEwMDAwMDAwDQo+ID4gPiA+IERSQU0g
KG9mZnNldCA1MTIgTUIpCURSQU0JQzAwMDAwMDANCj4gPiA+ID4NCj4gPiA+ID4gSG93ZXZlciB0
aGUgaW5mb3JtYXRpb24gaXMgd3JvbmcgYWZ0ZXIgd2UgY2hlY2sgbW9yZSwgdGhlcmUgaXMgYW4N
Cj4gPiA+ID4gMjU2TUIgaG9sZSwgME1CIFsweDgwMDAwMDAwLCAweDhmZmZmZmZmXSwgNTEyTUIg
WzB4YTAwMDAwMDAsDQo+ID4gPiA+IDB4YWZmZmZmZmZdLCAxMDI0TUIgWzB4YzAwMDAwMDAsIDB4
Y2ZmZmZmZmZdDQo+ID4gPiA+DQo+ID4gPiA+IEkgdXNlIEpUQUcgdG8gY29uZmlybSBpdC4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBQZW5nLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAgfTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
bXhfcnByb2NfYXR0IGlteF9ycHJvY19hdHRfaW14OHFtW10gPSB7DQo+ID4gPiA+ID4gPiAtLQ0K
PiA+ID4gPiA+ID4gMi4zNy4xDQo+ID4gPiA+ID4gPg0K
