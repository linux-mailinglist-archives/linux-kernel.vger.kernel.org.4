Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B974DCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGJRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGJRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:47:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A06128;
        Mon, 10 Jul 2023 10:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj/dMBO6qqeGGKzmVLyMfVbQi03ElEgMIl9jPzL8gQVxKNKSQAxcNmEbO5xLaoG2ep2lUaHVRA6OnYGMTdWwy1e1FsOmSegD9niDNn2325q7Jte7SzcUIoT9+iweBkBqp7osTzmHSueaE92Aj/raX9ouua0DsRKHUKP+u0UsYQKtn8Y7FOQF5fST5mlI04zHLlqlmNUGPo5W0FTaan7OZ2bvUzDO24qXrVk8u0xOUtNq9UExnGFxjpoEv8jJPdo46oFX/lq7UH7gusbS3Q4Xt3+MIGrolAyAyYfUZ2R4h8k9CFHceFwHwWOMZNSMALlDmwZ8r6sOOFCXYtoBJbPPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHEKoQMLwbQWpdSlFQbDOJsTxRCZqU9ai1bnf8HIVow=;
 b=bxK8zUrQcJI3HIUsV3UvPlWzjnvM3usQsmZH/sP71P/63YX5fy5sorakSqOjtmnFF102nNHCLZdc9eRucnL3xspGBeadwj2kNIR33lxPXh6pR56HNKZbJ6W/p6rm4KnsUMrmqGBSJdA0vfGI4nXE0hkVyjw0Mly4rQIL87rAXG3ZuuCCnAikzOUsHoCMTRQRVpN4hFO4/QcxRo9oiP7s6iuNwFqzu+Kvcqkxca+Mm1Mgrd+txbqGGyMumj7PtMji1lMJxIMtunyxvLV/JTUqbF4TXzRAiP2cB2ucyQsEzit0Jnt1nD9wNbh7EASdeHB38JijFw8u0PRYb1u5MPufbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHEKoQMLwbQWpdSlFQbDOJsTxRCZqU9ai1bnf8HIVow=;
 b=i3ENdVYmr4fNGCZ0oBPrhKZ9dW263GtyS1mOtB8lujZA/pFtxVibgQkD4KxGRvlApku97nNCxjT7StBS7vaJQa+PbHS9GeDqdikK2L9bOAIi7ctrx8TUgY7ef7Wxb9K9g47QI3Ah8W+kfwPv/R7R7A45YxUKqqiLz2nStf3URzQ=
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 17:47:51 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Mon, 10 Jul 2023
 17:47:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 2/7] arm64: dts: imx93-11x11-evk: added
 ele-mu
Thread-Topic: [EXT] Re: [PATCH v3 2/7] arm64: dts: imx93-11x11-evk: added
 ele-mu
Thread-Index: AQHZoFAU1kRS+oeSgk26Qsd1g/1blK+Nak2AgCYBWRA=
Date:   Mon, 10 Jul 2023 17:47:51 +0000
Message-ID: <PAXPR04MB86382D205AC6BBE7501E50FE9530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-3-pankaj.gupta@nxp.com>
 <fc9cf506-76e5-1567-1ab6-194874594727@linaro.org>
In-Reply-To: <fc9cf506-76e5-1567-1ab6-194874594727@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8638:EE_|AS8PR04MB7670:EE_
x-ms-office365-filtering-correlation-id: ab85ffe0-61a7-44f6-a6a5-08db816dc849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsHfa7Cxz2T2m3W4LejRXOZD0xmqQ11ou/OseofxlKE7QdCpHUT7dzKg0yEBpFEdk+lBQ/zNwPZTrojyF1LbJmolAidAZfGem50LhRTsG5iJm9PdnxfUzVFW8zmw6fL4EaNFTE/R5h7/9xei0G8TXVXcuDOTY85waF7VclivebXeJJb9vFGLampEXOU/Mrz2wqwyS6aFwmKEkvbCt5BffIcwI5RhALEE3ULIuWpuCEz6xCN7fdeD4VqMJPo1wtKizoP4dO3fBjWH7jdZ9hXb4iaNYLjuf356cdxbcqpS6fCI29n+tTQI1jHLP4BRhayR70jPGCDLsbZMMFRduKs7ATlgyhiPH8qkJK4mziUdsg+cmzKczaRmu1vZDQEif+XEjYTxoX4R9GHUOgFFAmfdqMOPHgdj6k3qsGz2t511ESyga5I0lj9nrITM6QwEP+PTZql5LJUZ6g61zhdKrMPruT1TR8d4QEKSlaea+/NYsW3AiB+733DeJkPLGO1kcL2HaPzyC9uwkHJylrKwroAHZjIlowfh9Oio9VFG+gQsGF4oU6TtLo4KBx+yOMzTmyZm/jG45WjidXDnqfbuWn1x4DrOReQQplENikUI/HL8mGhTy5cVPrAOTFdxQiTiBZdX0+cf0fW+YtKNWf8kmhbCGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(7696005)(76116006)(478600001)(110136005)(71200400001)(83380400001)(33656002)(86362001)(55016003)(38070700005)(2906002)(55236004)(26005)(53546011)(6506007)(66946007)(186003)(9686003)(122000001)(921005)(8676002)(38100700002)(64756008)(5660300002)(316002)(66446008)(66556008)(66476007)(41300700001)(8936002)(52536014)(44832011)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDRtaGdoY05JSiswd0tWY3JZV0lSZnpZWCt5QXkrZzljd3ZuWFFxSHFmN2hQ?=
 =?utf-8?B?NFhFL2lTWmljbjdmSnVHd0hKTlJENE45eXpuNngwWmtIeTRsczdwYUd0bGx0?=
 =?utf-8?B?R2dQWFJCZXlGeHFReHBHcmtqZDB5Nmt1WEVMN0hSb2doZUYzdFlHdGQ0VUl6?=
 =?utf-8?B?OVVMdG5oZEJsRjNmbFJ0M09PeTN6Zk9RM3ZBeGc4Q1djd1F4MVpTR1RvZFVD?=
 =?utf-8?B?V20vMDd3MnpoKzc3UjROZzBPV2dCRDhBNnpmWk1LZXowWEw2TGR0STEwZjBp?=
 =?utf-8?B?TXZmZWxoYUNZQ0tnNEZJb3VjTlFEZnhyNnVuTEhPTlBuWEVvYXJmUUZuaDRQ?=
 =?utf-8?B?VFF2NnF6WC9QeFNUS2Y1QXVQK0xJdUNCcVlrK1FCU2lGdDlwMWdUV09HSHox?=
 =?utf-8?B?MWI5WDJFamF3Q2pMeU9oYVNyMXZaUG8vcFltWnlZVWo2WDhjb1ZPdTBtRzln?=
 =?utf-8?B?V2N4bVBaSDdXZnBwWjcvMUhHZDZnc0FuYjNiangxbVpiNWtxdS9ERW90aTlV?=
 =?utf-8?B?Z3JHTk9lVWlYc1JacTZnQlN5aVMwOTRpNDJjWkE3aUNveWlFS0I5bkNZdExO?=
 =?utf-8?B?RUlNbHRuelhBOUx5MDhjRmdTY1lpRXRlMnptWTBkUVQ1UlNwU3pWSEtGVHpR?=
 =?utf-8?B?eXMycFNCS3VPLzVsL3ZYaFR0b2I5RnNRTndtVjhpZXZQTTRtU3IwNUdnaHA1?=
 =?utf-8?B?dFUyd3l2L0ZjQ3R0Rm1Bc3VxY3dQaXZHWVVEeUJQT1NsZGJ6dnBWWUZMUG5a?=
 =?utf-8?B?NkRkK0gwNFJma01vY3RZUThKSVRkbWtETlQ5Vjg2ZHlscDJaMlRhYlc4OVJu?=
 =?utf-8?B?M2x6SGViZmtYSmpCTm9EZDBPYmwxYVZjM1FaRkJrRXB3TG1MNzhzaVp4NUox?=
 =?utf-8?B?TFdNUWVPb0pVdVI2OG5VQXFmRkx5L2ZFbk1MeWZSQWd3TlF0clFWa0JhOUFs?=
 =?utf-8?B?QldoOXBPSUljQkxvMWd3SUNBOTN4OHZLeW0wTFlZRkJpL0M2NWxKMlJSYVpQ?=
 =?utf-8?B?V01xcXRLV0tJMjVJVU5XUDg2UFNKeVRUbHZYOEYvVUFhTGh5VVBmQm1Ia3lo?=
 =?utf-8?B?aGt6NmZOQzBMMng0SmNISXZtYzk2ZENqNGEyUGZVNnhFRGRSdGdUZS85UXhq?=
 =?utf-8?B?QVEzakJCMGhQbjJ5R1Nhc1htUlc1eURZcjZLZ1YrU2F3eFdOeUNpYjVxYXFh?=
 =?utf-8?B?cDh4ODg2VnFlb1pkK0tOdTRKWmJHSzJZUVVmdUFvekhTWjNWUW9CSHhteHlG?=
 =?utf-8?B?M04yYXg3dXJWQVp6aXdvOXlZb2NFL0ZwVit3Q0J3MWF3Q3FiOXdzU05ZeEV4?=
 =?utf-8?B?dkY5Z3k1UEEzMXh1NDdhYzUrb0VGS2d3ek02VVk5KzcwanJYY3VsNnkzSmRt?=
 =?utf-8?B?MGRVcFhZOEQyM3RSRTJENkV5UzdMR0NveEQrS1FCblczdFQ2Tm1WdmlZQ0pa?=
 =?utf-8?B?d3FHQmJ5dC9EMmxjODVTT3lCY0ljZjhhQ3dGb0NLUjRkdStBTGk3RXM5UGtO?=
 =?utf-8?B?MXd6SmFpdUtheHdnWHBYdHF0QWlKZ1RQUXJDTzZVSXpzMUpTRWN4RGVwOWZG?=
 =?utf-8?B?TFRoZmc4amlDS0JJNWpUTFU3MWcxSGFzeWZlTTlNYjcyU3dadktxU0JHTzlt?=
 =?utf-8?B?QitGR09XczJ2ZmtId1BmdUlsMWpKQ2NQeER2SklhOVJBK3E1azV1R0VadzI0?=
 =?utf-8?B?TlJXRWJicVUwTVBuYjhxWW92dENVWjNNZE1wcVpQNElTVDVNd0JRYTFCWjhL?=
 =?utf-8?B?WUhja01xQzNxZnZiakVmdU0xY1FrcFNrWW9OY2VvWmRMREYyaSs3cGplZ3hV?=
 =?utf-8?B?M3lWZzlPNWEwMkRBR3lhQnpuU0ZPTG1XNyt2dHo0QW91cXJmM3NkN1JReW1l?=
 =?utf-8?B?Ulpic2svZjFuTGxXalFJcEJRODBqTWRMOVI2WGFGVlk2cWFMS013TkxhMmxW?=
 =?utf-8?B?UjlxZkxTT1NjcXJwOWZrSU5mSmllMU81OEkwS0ZJMVNrYklaVTNYN1NWaWxS?=
 =?utf-8?B?cTUrM3pjZzhDU04ycHg4Y3FaeEJneEJOZVEzeTh0SlIwSTN3SkJVVGg3anNr?=
 =?utf-8?B?U0FPMFkrV3Z4Q2FGMFBaMmxaZStCb0hyV3JpcU9tWjJPdWFRd1ZOcEpIYjk4?=
 =?utf-8?Q?xvaHDG6U+mMEr2te0FVp8mty0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab85ffe0-61a7-44f6-a6a5-08db816dc849
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:47:51.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J39MsCGnZ1PEMLqMDDBgpp6F9ZknDp1ClA4qj0g1To33OY3JnaqeIZWqQiXsFcPVHE/hmo54jN3TBDbSDhme0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bmUgMTYsIDIwMjMgNjo1MiBQTQ0KPiBUbzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdt
YWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEdh
dXJhdg0KPiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYzIDIvN10gYXJtNjQ6IGR0czog
aW14OTMtMTF4MTEtZXZrOiBhZGRlZCBlbGUtDQo+IG11DQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9u
IDE2LzA2LzIwMjMgMjA6MTEsIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPiBhZGRlIHN1cHBvcnQg
Zm9yIGVsZS1tdSBmb3IgaW14OTMtMTF4MTEtZXZrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gDQo+IA0KPiA+ICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OTMtY2xvY2suaD4gQEAgLTc4OCw1ICs3ODgsMTUgQEAN
Cj4gPiBtZWRpYV9ibGtfY3RybDogc3lzdGVtLWNvbnRyb2xsZXJANGFjMTAwMDAgew0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAgICAgICAgICAgICAg
fTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBlbGVfbXU6IGVsZS1tdSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDkzLWVsZSI7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmczRtdWFwIDAgMCAmczRtdWFwIDEgMD47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIG1ib3gtbmFtZXMgPSAidHgiLCAicngiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBmc2wsZWxlX211X2RpZCA9IDwzPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZnNsLGVsZV9tdV9pZCA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ZnNsLGVsZV9tdV9tYXhfdXNlcnMgPSA8ND47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9ICJva2F5IjsNCj4gDQo+IENhbiB5b3UgZG8gc29tZSBpbnRlcm5hbCByZXZpZXcgZmly
c3Q/DQpEb25lLiANCi0gUmVtb3ZlZCBub24gaC93IGRlcGVuZGVudCBEVCBiaW5kaW5nIDogIiBm
c2wsZWxlX211X21heF91c2VycyIuDQotIFRvIGRlbm90ZSB0aGUga2VybmVsIGRyaXZlciBmb3Ig
aW50ZXJhY3Rpbmcgd2l0aCBTZWN1cmUtRW5jbGF2ZSBGaXJtd2FyZTsgcmUtbmFtZWQgdG8gInNl
LWZ3IiBmcm9tICJlbGUtbXUiLg0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNCg==
