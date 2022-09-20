Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C625BDD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiITGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiITGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:36:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820995E338;
        Mon, 19 Sep 2022 23:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRfN2qakcLdP/foe1vdLQxAhfMosCeXAucLFlna1It3m/3we01P8BnUlE3auJOVw6syaa6DSsD2ni1h6suFxUQGfGtc3hsJnF378Z1nXhFADSuZL7sMxCSjyz6B1EhsMXeHlcJuscOviTyyp5HXr7otinM9//ayvFXUC7PgZSTOUcdKeVGwGUcVpb5U53siTk/h+kSS6XdneRGcP7On3DDlybPgUuA9sdmqvADhX8reicSSCJf2DoHG2A6G0hZdwCzTgnnNV8B3jcWUJOan7SNnXB0iwzrKQX3H+RGH8UCuvk59jZvNSVU2FXlnuR+y2s3Fio3aCvvpzcEjUZlcz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrzGIe4K8HqQ8qjGQ9k9iO4kFHhxkUJoFeZoCOEZi7E=;
 b=lQMBLJtybMmxxG9EW4Z8utq3G/o0fazT4gZoE0mIX1J5Ni6PZtisva+EhLjuy8wDx+jySt814FOldzlR/NYCTEaFfYQupnB02x4vPYviy4CIuCAcyI5nLO0NJTryhDPccOLtButNdtUFZbCBc5MgOwhF9hLCpnWN4CvKlg5zyaIhcju/ij5wq9Bqf6FPmevcJNOOw9PkBsVp7sXf46ZzLC3VstQgCzM23YVarZU+oBNJbx2nIjfSQQMkkxp/K0JdBIxA2kYHUXba+EYUhY2AXastlRElFjstQimYFKdfZX3rN1IUafJ3F3PzRoP+ptVYG4gRvFnYDfoA9nVb3Ne2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrzGIe4K8HqQ8qjGQ9k9iO4kFHhxkUJoFeZoCOEZi7E=;
 b=lzg/muTpP3BYtB2SPuF0Q1+Ye/B/d9GoKE8ii2oTayakm/qe92MbB9drQ/H4idsNLXLVTbK9zi/xZ9ZZ4Hf7TYlCZ2kNJF49KoIk2CP+rU5vGulIA11umaPBRKuOH2SQqTO0jB/MOGM+E7Ti4ly7GIQk0TmHvVcqbLAirWnAy90=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 06:35:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Tue, 20 Sep 2022
 06:35:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Topic: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Index: AQHYt1YQLw/DlLV00Eatr29REha5pa3nzPRAgAA6bpA=
Date:   Tue, 20 Sep 2022 06:35:22 +0000
Message-ID: <DU0PR04MB941763C3EBF8AE9A9CD69445884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94179E5E1563DD72849BEDCC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94179E5E1563DD72849BEDCC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8814:EE_
x-ms-office365-filtering-correlation-id: 3a3b9ccc-a6a6-4a0d-946f-08da9ad24ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7n8Hi4o0mjkbWPY+YKyQ0vUVaPvphSEzYO14TxNqINV6bXquAvEuwEKUo848uk96st8Fm0oCPR4V+Y4JpgUL/zPc7YoOneBaAgW0SLa1uNNIyVem9EgsMBDsB74gT8mA53IoETyxooX6qBxneEfarGBB+NjzlKjUBIh8GbKueaXH4scF6Sn6fmwo2nE9O2E91zfwwOHV7IY+YRaK0AKjZcjx0P+COVuS+2Xsb6xYEw6gXZwHqhqGxurygWSDsM1J1jtbne9UiVB+ylx2wU0005CS671/xEeE/gcKvrbw2c4Gf23wI1t73GEXLfe82PZx+8N6osvnxuU2Rael83pBM0+uBW4LQTLiQTiT7+fAl03jX2tgFwnlITW9RSr8cRcBlDUIqHhvHFaeinWF52hfenNB8YrXsMR1Rueu7iUlXLP1QbNLC2q/HFUwP6Txsticiwwjeam1lu3Mx4RKBPBqiv/1tIuht9TTI6dPcNWpHZZF1iBE8AN8R0OF4uWpAlGv5mkN1wiQ1q3LwNx3sfeqdOGYD1tmTlEy/SQqFhhE9ru3QiUhM3Sna2aTewtT8YQRI9LUS6oP8QiQ/zofl9ub3z3SLIFjcszbsO8eQyf52NIJLRjiMQasGGh5YRLKDIQiS5WGSkl/FsR4ipWmzIfgZfL+3W6eS3H74mdz6RaFdT52txTOQnzqcJkuHpSpULRzQBZqTi4SNZyXPtWKVu9KF9Vk21LBsHTX3y0zB8G9nydkp1PHAsnjLbLL46Uab3tvGJXYhNeEfnedFqhSikWggnPWZMDv3zr1WcTt3GUnwzaqF7OfrNjwTGwRBoAZjR9d7Q/+w+9e92vUsU7fMnMRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(55016003)(66446008)(66476007)(66556008)(26005)(66946007)(8676002)(2940100002)(4326008)(76116006)(64756008)(9686003)(110136005)(7696005)(6506007)(71200400001)(53546011)(5660300002)(52536014)(38070700005)(8936002)(41300700001)(83380400001)(38100700002)(966005)(478600001)(44832011)(122000001)(186003)(86362001)(33656002)(316002)(54906003)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R0pEZkN0dUlVZmo1dzUvdU5xRVNJajFpcVZWaTAzcFUwWDQvSEMzVE5haGFl?=
 =?gb2312?B?NldnaStWakRZT3NPbWFqK3N1WHFLMUQwSjBJNzlNRVVnK0pMdDAyRk1YY1Zy?=
 =?gb2312?B?UEhhRnNLb1lyeVVDYXdVUEZwYzV0Q2JGYi84NVZHMURTQzFUOVpUYWxMR1JP?=
 =?gb2312?B?UWdLL2ZoRjVscWQ5Qmo4Zm9KNlg1b0VEVVJ0NjBHN1N2SW1NVXoxeTR2dTJq?=
 =?gb2312?B?dThGSVZrZzRXT2czY2czVEM5QldzWDBXd1B2NzJLWDY3cksrYWorL0E4akhV?=
 =?gb2312?B?R3RxaU9Qa003Q081RGFybXUrK3h1ekd2MDNnZkUvdGhpU013OUpER3NDbFNZ?=
 =?gb2312?B?b2J6UVpjV0djR2dEV0ZUdXlSSTN5cGxmUVZhT2V1MmV2U2p6VFFSOVI3dXhF?=
 =?gb2312?B?U3RFOTJhZjBobmJDTDV1SXN1cTh0R1BwTFgwVWcrdVZXbVV2OUZHekZmTnpw?=
 =?gb2312?B?TkpOaWpLcWhGYzJoUTU2a3lyWXlkQ3lteEFxR05yMTF3T0ZxU1pXejY2c25M?=
 =?gb2312?B?bW5ER3E5ZU8zSGpRNktlVjlIQTRBNTlpeHMzT3o0bW5vZCtrL1BneGdTb2VU?=
 =?gb2312?B?M2dmeWZJRWhRUmNFaGxhMGYrdTBVc0NuNkorZlkwZlVlOXluaWNEZjdOSjFI?=
 =?gb2312?B?MTZyQmZoSlErLytBWVY4dDN0ZWZGeCtDdkJpSHZ1cUsySlZnTW9ZUnRuOFd5?=
 =?gb2312?B?YVNUbjFyTDFqenM5cDkwZDdIUExnTVdaSG5Jd0ZwSkZsVC9FY1lBWDFYbHdG?=
 =?gb2312?B?b0QzSGNDQnpsRUZyK3ZGVS9saVdpaDh4dDBEQ1ZXVmQ3VHFvRjVtdEZMVFhz?=
 =?gb2312?B?N1VaMFJqTERZTElibHM5N2V6TW1OVXhsK2czVlFYU0pGcVcya25yWXAwWXky?=
 =?gb2312?B?Y0RkODBnQUZ6MkRLMnlmMzJtQWk3Y0JvcG5EbW1FMXVTUG03dWMweEJyQk1y?=
 =?gb2312?B?dy9ydVdabkU4TXZUVVBBTC9KMFhZUnBYclljeXY4V2NjMGJQSG9VTEVuMlJI?=
 =?gb2312?B?MWZndlBaMlBHWVFZeWxFdTFlYUtyZW16eWRXTWNnWGFPRndvNjVjamM0Q1cv?=
 =?gb2312?B?a055ZTlOVUVyMTFRVHo5dDVVMWxhVklQVTZLdk5BakhMWUNGWkxsMFhvRTBs?=
 =?gb2312?B?dFNzYVNFcFdzRHJtL2lvR1JhcFJEbEVrcVNzWnJha05DZ016akd2YlhlRkd5?=
 =?gb2312?B?blpmWkt6Y3UzRjVkMHZ2bW4xR3pFYVlOWGI2VkY4WTJrRFArK2R4SldqcXc0?=
 =?gb2312?B?WkF2TTRTQUU3TmhRUmU1WDFlZUw1N0EwL09wN0E4TkQ0NXdvbEtpbVl0RkNx?=
 =?gb2312?B?Ti8vOHVsVXFOT0s3VU5OL1JRNU5aV2VibC9kWmI5ZVpVSkc3alFCdkxWdkNM?=
 =?gb2312?B?RHcvejZlMDZ3VGZkcHlEUUFybmIvcDI2bCtEV0t2R2V5ZjFwM2NIY2cxbklj?=
 =?gb2312?B?SzZjSGRxSHJCMlR6SFhPQmhtNlJSWnlPMTdFbk9TcldqdHEvdkExNi82ZHlZ?=
 =?gb2312?B?U3NFVFNxaEJGQzY5bGtkQU5vSkZyM2dDbGp2Tmk4V1NxaXAyVlFOTm9tNThK?=
 =?gb2312?B?Q0o0NHQxN294UTNyZlFCSTJmdnVBekE4WWt0K3JYbGdmNERzN1pCMWpQZFRB?=
 =?gb2312?B?d3pwYU9XUVliakZpT09oMVZpVzlSdG5iVVNsbHNiQklrRG9WWS9JZTZVcnZu?=
 =?gb2312?B?bEtTNTVGM2VLVDI0cFllS2JiRThpeXBXUko0bWtGSXRhQnlvQkhWaTVnTzZN?=
 =?gb2312?B?S25zU2w3cWVqUHNlOEM4UlhwZ2VDblZLY3F3a2pwZGpxVjV4Z1VsbjNOQll2?=
 =?gb2312?B?Yk14Tnc1dC9WSzYrb1JrRFNkb2ZqVmc5ZTcwNU5nUi9JSyt2a1A0Z0E2N1F1?=
 =?gb2312?B?QU0wWXIvcVE2bUhKeVpNdFNBZFR5U3R2TmRwZTh2MVRQdk54U3Q4cFdOMmxm?=
 =?gb2312?B?SHhxbzBEakVJVmpCN1F0UnVPZUtOajNuVjZPT2dyYzVEVGl3RVFOd1JEbEJB?=
 =?gb2312?B?cytKVWd6cDBzcFY4UW1IWlVDR3lrazc3VlhNaDl1eGhWT01ZVElUR29FWER1?=
 =?gb2312?B?SFBZWC8zcU0wNEZIK09YQzhYcWtTRFpYRHdaS0NaUzc5OUF4SmdoZ0VWdVl0?=
 =?gb2312?Q?A3ah9DeIEV2Ew38rHalUnVE/+?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3b9ccc-a6a6-4a0d-946f-08da9ad24ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:35:22.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBGzlaojNG7AB2aCHfpUoPtELjKGnrLXoHLAiGOVBsXyC7BMEX3ODy54VTJjqZvtuCiG5lHipkzluh6bVitJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29ycmVjdCBCam9ybidzIG1haWwgYWRkcmVzcy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogMjAyMsTq
OdTCMjDI1SAxMTowOQ0KPiBUbzogUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29t
PjsgYmpvcm4uYW5kZXJzc29uQGtlcm5lbC5vcmc7DQo+IG1hdGhpZXUucG9pcmllckBsaW5hcm8u
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBD
Yzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlt
eCA8bGludXgtDQo+IGlteEBueHAuY29tPjsgbGludXgtcmVtb3RlcHJvY0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggVjUgMC82XSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBvcnQgaS5N
WDhRTS9RWFANCj4gDQo+IEhpIEJqb3JuLCBNYXRoaWV1DQo+IA0KPiBJcyB0aGlzIHBhdGNoc2V0
IGZpbmUgZm9yIHlvdT8NCj4gVjQgd2FzIHNlbnQgb3V0IDIgbW9udGhzIGFnbyBhbmQgbm8gY29t
bWVudHMsDQo+IFY1IHdhcyBzZW50IG91dCBuZWFyIDEgbW9udGggd2l0aCBvbmx5IGEgbWlub3Ig
cmViYXNlIGNvbmZsaWN0Lg0KPiANCj4gVGhhbmtzLA0KPiBQZW5nLg0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSCBWNSAwLzZdIHJlbW90ZXByb2M6IGlteF9ycHJv
Yzogc3VwcG9ydCBpLk1YOFFNL1FYUA0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+ID4NCj4gPiBWNToNCj4gPiAgVGhlIHBhdGNoc2V0IGNvdWxkIG5vdCBhcHBs
eSBvbiBsYXRlc3QgcmVtb3RlcHJvYyBmb3ItbmV4dCBicmFuY2gsDQo+ID4gc28gcmViYXNlZC4g
T25seSBwYXRjaCA2IGhhcyBhIG1pbm9yIGNvbmZsaWN0LCBvdGhlciBwYXRjaGVzIGFyZSBub3QN
Cj4gY2hhbmdlZC4NCj4gPg0KPiA+IFY0Og0KPiA+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjA3MDExMDQ3MjUuNTU3MzE0LTEtDQo+ID4gcGVuZy5mYW5Ab3NzLm54cC5jb20vDQo+
ID4gIEFkZCBSLWIgZnJvbSBEVCBtYWludGFpbmVyDQo+ID4gIEZpeCBwcm9iZSBmYWlsdXJlIGFu
ZCBkcml2ZXIgcmVtb3ZlIHBhdGggaW4gcGF0Y2ggMywgNCAgQWRkIGNvbW1lbnRzDQo+ID4gYWJv
dXQgaS5NWDhRTSBlbnRyaWVzIGZpbHRlciBpbiBwYXRjaCA1DQo+ID4NCj4gPiBWMzoNCj4gPiAg
RHJvcCB0aGUgZGVwZW5kZW5jeSBpbiBWMi4NCj4gPiAgVGVzdGVkIG9uIGkuTVg4UU0vOE1NDQo+
ID4gIFVzZSAnZnNsLHJlc291cmNlLWlkJyBhbmQgJ2ZzbCxlbnRyeS1hZGRyZXNzJyBQZXIgZHQg
bWFpbnRhaW5lciAgRHJvcCAncmVnJw0KPiA+IHByb3BlcnR5IFBlciByZW1vdGVwcm9jIG1haW50
YWluZXIgIERyb3AgbWNvcmUgc2VsZiByZWNvdmVyeSwgdW50aWwgd2UNCj4gPiBsYW5kIGluIGNv
bW1vbiBmcmFtZXdvcmsgc3VwcG9ydC4NCj4gPiAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LQ0KPiA+IHJlbW90ZXByb2MvY292ZXIvMjAyMjA1MTcwNjQ5MzcuNDAz
MzQ0MS0xLXBlbmcuZmFuQG9zcy5ueHAuY29tLw0KPiA+DQo+ID4gVjI6DQo+ID4gIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj4gPiByZW1vdGVwcm9jL2NvdmVy
LzIwMjIwMzA5MTAyMTE4LjgxMzEtMS1wZW5nLmZhbkBvc3MubnhwLmNvbS8NCj4gPiAgRGVwZW5k
cyBvbiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+ID4gcmVt
b3RlcHJvYy9saXN0Lz9zZXJpZXM9NjIxMzExDQo+ID4gIFRlc3RlZCBvbiBpLk1YOFFYUC9RTS84
TVANCj4gPiAgQWRkcmVzc2VkIE1hdGhpZXUncyBjb21tZW50cw0KPiA+ICBEcm9wIFYxIHBhdGNo
IDUvOSwgcGF0Y2ggMy85IGlzIHJlcGxhY2VkIHdpdGggdXBwZXIgZGVwZW5kZW5jeQ0KPiA+IHBh
dGNoc2V0IE1vdmUgVjEgcGF0Y2ggNC85IG91dCB0bw0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj4gPiByZW1vdGVwcm9jL3BhdGNoLzIwMjIwMzA4MDY1
NzU0LjMzNTUtMS1wZW5nLmZhbkBvc3MubnhwLmNvbS8NCj4gPiAgVXBkYXRlIGNvbW1pdCBsb2cN
Cj4gPiAgRHJvcCBtYWdpYyBudW1iZXIgdG8gZ2V0IGVudHJ5IGFkZHJlc3MgZnJvbSBkZXZpY2Ug
dHJlZSBpbiBwYXRjaCA0LzYNCj4gPg0KPiA+IFRoZSBWMSBwYXRjaHNldDoNCj4gPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+ID4gcmVtb3RlcHJvYy9wYXRj
aC8yMDIyMDExMTAzMzMzMy40MDM0NDgtNC1wZW5nLmZhbkBvc3MubnhwLmNvbS8NCj4gPg0KPiA+
IFBlbmcgRmFuICg2KToNCj4gPiAgIGR0LWJpbmRpbmdzOiByZW1vdGVwcm9jOiBpbXhfcnByb2M6
IHN1cHBvcnQgaS5NWDhRWFANCj4gPiAgIGR0LWJpbmRpbmdzOiByZW1vdGVwcm9jOiBpbXhfcnBy
b2M6IHN1cHBvcnQgaS5NWDhRTQ0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBzdXBwb3J0
IGF0dGFjaGluZyB0byBpLk1YOFFYUCBNNA0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBz
dXBwb3J0IGtpY2tpbmcgTWNvcmUgZnJvbSBMaW51eCBmb3IgaS5NWDhRWFANCj4gPiAgIHJlbW90
ZXByb2M6IGlteF9ycHJvYzogc3VwcG9ydCBpLk1YOFFNDQo+ID4gICByZW1vdGVwcm9jOiBpbXhf
cnByb2M6IHJlcXVlc3QgbWJveCBjaGFubmVsIGxhdGVyDQo+ID4NCj4gPiAgLi4uL2JpbmRpbmdz
L3JlbW90ZXByb2MvZnNsLGlteC1ycHJvYy55YW1sICAgIHwgIDE2ICsrDQo+ID4gIGRyaXZlcnMv
cmVtb3RlcHJvYy9pbXhfcnByb2MuYyAgICAgICAgICAgICAgICB8IDI2MSArKysrKysrKysrKysr
KysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNzAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi4zNy4xDQoNCg==
