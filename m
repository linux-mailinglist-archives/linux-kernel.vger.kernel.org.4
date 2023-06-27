Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890673F0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjF0CXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0CX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:23:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBFA1B2;
        Mon, 26 Jun 2023 19:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkLsyxYnBIttcGoxY1kc1FabW3lCebiqiQ4RSVNOZdz7oEbSjix9E6mwAoZgPuHQPHyMpNeCqnj0KBwvrT1FFvaieTU/P35X6eK90i4dVpUjOaJJo3QyVAFrv0TRCfhuzwh0PZuku5HLt1504r9xqdI2NxDcWEdGIehgi0RS3SeGqM72i3UkmYij6MZvvyg+NLlq4x6CyjfV1yPii68hDpg9e5qjwd709h7awR2x1gamaU0NOoNtsmHj4LN123RFHi2uqnyJp6nsdrqgGEq26Z3pCoLzns8qlNM6tvieymqK2XaxpVkQvpJ7NdtkCPbd1r3g6h0iQn/2KFbAGcWwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ni1OZhCjehGHjgmjTEx1qt6yvEoHdnNb2/AUNNuY3Y=;
 b=VqutUB0UaGTGyWMH+zajS8xZidBIkBrrz4IQ/IJeks466hAPPE3c+3EMEOwxFObjeGTbSIrlcfl/fWaOmB5snu7VuQTVJbo/GD/1c/iuEy8n0svhKzKPii+hCPZabnrevk+6Twe7LXLEe9Y9nOJQvZV9CxMB0xVf20pqplvqLSMavLpIYy+1bVFTpUOmgOCj/98lyxKvkqe6up85PuxjjMamICI/WOgY5exUvPFAMk6BAW804CX27XASn3q9o+RDgWrIYo7RY4Wqp4eqSu8528puQw6s2TzKQkMJs2ql4JLOkVR1R/shaUA/WzVs0XAOIFDvjg+2lAcvItjW5i8BHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ni1OZhCjehGHjgmjTEx1qt6yvEoHdnNb2/AUNNuY3Y=;
 b=Mudpo1Q9ivrRtujxJClvAq2EzZGlNiuPCIR0TlsmyeghCnQT+v5WbRtEkvVicCUpEMp3jHdJqbeqGnzcHzqVxsgrK7w2nY3GoV16/cgCugAxA5ttwdW5M0GfW6MmC+sSy42grDi+55lJSGXrhee4RUFQSotJ6+5ZXg9xU+w5YXI=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS1PR04MB9700.eurprd04.prod.outlook.com (2603:10a6:20b:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:23:24 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:23:24 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/3] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Topic: [PATCH V2 3/3] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Index: AQHZp+pJU+7E1FW3j0q3qpxZS8/K4K+dOwMAgACwSMA=
Date:   Tue, 27 Jun 2023 02:23:24 +0000
Message-ID: <AS8PR04MB84043AAD5C0C13BB58CCB4349227A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230626044848.4417-1-sherry.sun@nxp.com>
 <20230626044848.4417-4-sherry.sun@nxp.com>
 <989b42c2-8b5f-5eb5-d61b-dc3f29b374b2@linaro.org>
In-Reply-To: <989b42c2-8b5f-5eb5-d61b-dc3f29b374b2@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS1PR04MB9700:EE_
x-ms-office365-filtering-correlation-id: 59f6e516-fe7a-4062-31f2-08db76b57c2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDzHRDWBSiM+YKfIRaR/BtcHuw49flOdmBmK00IyjTKhwEdTOneuyH1dZFrgiHTrvmebnSZdJnq8KddmVthzFZDh7zhLCkiwAKXsaX1RRw1M3gv8XbLbjcjFiAIAXCrxdgGyowAWZZaVKJ9at+AjVlLmhHg/Wr7akxz+IDoopiRY6WFXQF10VF5a/2UksHhd5/kLQTobdof8qXTdOWMl17SsXGnQskR6m+kxZX+OMw28DUJBjxg0g27q7HoKSWKGwLta6C66r2DlEny3dNS0NkW2v4p+z4gEa4KPkKRVo0ilirQC2EPiRXLgeDSPAHZ9aAy6oQTdQCQ4vARjsc8FMKY+qsHbiaXgnvgLJk5ESx4EEtC7IS5pg3D0cKygdL/vTj/5i199Ct6q0M1jVgW3fL5I5/xYYUQw0wHIPQC1c4o7kupmqFEUM+FPrOUHvA4lSnbp7ZLrdo7lOspC4Ehl49HfHZaQeOBLfmlvfMOCPTB2VqLjfCzTziPIrsCohFWVy9e+fF6DwKpsy/H0HnRU2S5M8GUfnWznCEsIak/EMgENrgGm2OLTP+HRcyREpkgiDGBE/MlnrAtR1gPhMU0fNt4Vgsr7CAvn4u1cbrIq35JpZv2LGWfupUW6Eb1tCPB19CwNTQdnAW5DHGUwo+wC8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(8676002)(8936002)(76116006)(66946007)(55016003)(66556008)(66446008)(66476007)(316002)(64756008)(9686003)(4326008)(6506007)(186003)(26005)(53546011)(7696005)(54906003)(110136005)(41300700001)(71200400001)(2906002)(44832011)(5660300002)(52536014)(7416002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUtFUGdNaWsvdXZPY1ZxNFBXTUlKNVY1RmVvbDFJUm9IUGUxMXNaY3pIaUFj?=
 =?utf-8?B?RzNEVGU4Q0VMVXpvS3dacUM1eVFJRW4wTVNNZGh2WXA3Tzg3UDAwSVpvRUxz?=
 =?utf-8?B?Z3Q0b3FCUmpSQnV0OWUvak1qMjcvdTFmdmhFUkdJODBXYXFJbjlYQS82bklo?=
 =?utf-8?B?eXhmZE9IOUMwc09IempCOWFwdHRuOWM3MS81SVMwZTgxRFN4Q3pxbGx5Slhm?=
 =?utf-8?B?Q28rQ0hQM2taMStzTUhNU1plRk9kSDJSUDVYM0xocWYvWXY1cXRxTzlIL0Zo?=
 =?utf-8?B?ZWdFdXpKY2pwNHVEYTJjOXJOVjcrTGkrSnNXV3EvamdLRlBTQXQ5dHJpQ0lX?=
 =?utf-8?B?NW0zTDJtMDJSSlZSY0d5c0VTYy9mRm04UG1KbkVaSGNORFBid0dqTk0zMnpL?=
 =?utf-8?B?eUFsdkhlRlUzYXA1VER4Rkt2NGFITGYyZjJraGQ0NEZyYjl2NnYxYm1WZGNw?=
 =?utf-8?B?bFhmNzFCWWxTZzBBQnlsSkdBUTM0d1V4MEVaVEtUZ3dWSEc1MXlwWE9zd0t5?=
 =?utf-8?B?S0o4YW9IQUE5VEd4bTdLS0lGaVhnRUR2ZWQyNTlqNnJrM25zc3RIaHBFN2NR?=
 =?utf-8?B?V2VIRmdQRHphRm1kaU9JK3VqUzZNUldqSzZTRWdiYTdUS3NHN09JMzd5ZGxC?=
 =?utf-8?B?a3lHZjJmMnM0aFlMQTNEaUI1YWkzOFNlVnh3dGRjUndreEVydVlmZEZRMUtq?=
 =?utf-8?B?OG43MkhjWERRSlhFb3VpMHN4UWY5NVVkR0VuY0xOeEplbmt0MmxyamgvOXVS?=
 =?utf-8?B?WERQRW5nUVhsWk1wcG1HeStaRVRhamlUNGZXNW9Zc2cvam1WR2EvdXZNRllp?=
 =?utf-8?B?R0dhM0YxNEdTdU9kZVpCaVhtVGN4dGc0ZHJXZWIxaGVJd0lwRTkrSlNpWDN5?=
 =?utf-8?B?anN4cU5yZFUrQlJ4VjJITUg4emZtZ1pKQ3BQeHoyQTVwR0hxdG5OdVRQS1BD?=
 =?utf-8?B?Wnk2T2pnRUkrWlpaN2s0ZWY5N1NIbldNY1l4YmZ6MGI1VGljMGlqblpQUHBa?=
 =?utf-8?B?RENVZ0I5SUJrOFFidFVNNXdqRVdyRFBFbnoycDVRMHpXWVhYQ0ZqTHM5N2dS?=
 =?utf-8?B?aVJBbzAzcW94MFdzY0ZoTGp0VmZrS0lDbEFOZUlRSUl4WXQvaTc5dWQwVm13?=
 =?utf-8?B?bHpyVWZxN1hDYmJpWEpKZW95OUR1MWpadFBURHFTNFlkekdTcXhiRkZJd05X?=
 =?utf-8?B?ZzhoSGNCM1BpN0ppUXNUS2RoYm1VL21lVmQ0Qy91VUY1N0ZpNXlvSm9jbHBi?=
 =?utf-8?B?VWV4S21zT3pYaG5NVFF3dWE0MmE1eHV5L3A5MmFVeWFuT3hab2o1Mmh6T0pT?=
 =?utf-8?B?SStaL1k5WE51UDJ0WjgyZVhpbEFMVEZRalQxZHM5aHhvRVFLNnJIcUExUWJm?=
 =?utf-8?B?TkFlVTRJTGYzZUJsclNQUUtWUk5DMjNnMzZJN3dGZHNsYndDcENWaGlKZXcr?=
 =?utf-8?B?S1UxanBUZndJemh5dGEwbW5DdE9sZDRVdUJreUdxTmdqUGE1Z2RvVWJWaTIy?=
 =?utf-8?B?ZlVrdENEclg4Rk9oeDJFYldHZWRrVFZ5eXM4RzZDbnJ1eG1RejdqOUpTamh5?=
 =?utf-8?B?bWtkN1hraTlaeWREZmJvUWRIYmkrRmRTYVQxM2JuNU9IbTNSaUU5WXNLeXFP?=
 =?utf-8?B?N1Q3S0tVNUpBNXYxcnhZNnRtOGJ5aUZKNmpnRE5LWWQ5NWZ0MXRXSmtyL3Rn?=
 =?utf-8?B?eVJpeDRxLy83NzBGdzRONkx5ZCs4ZEQ3NUQ5eko4NlpHZ1MyQkQwTmNGL25S?=
 =?utf-8?B?R0FWRXNpUHUrbzdxTjRSV1V3QWsyamJyTDZkZWwrZkR0cVY3Z1g4ZnJ4QWdK?=
 =?utf-8?B?VkhtZ1BJVW1qS1NZV1gwdVF5cDVtbU1BNDZTQk5Id3FRSVpVNDBFVTR5U1Vq?=
 =?utf-8?B?aUVreGlwalpnZTlCUUozTlhMd3d1ZVpTWHgxdnk3VElDUTNhVmFtUm1QaFAx?=
 =?utf-8?B?NndpUjE2WkFMTnBMbndISmtlTnFRajNGMlVwcUlQa0VkeU1vSE1ZSVdmd0tK?=
 =?utf-8?B?azBGUTBmR0REdXUyVi9zb1l6aFdjWXdRUG4yZGo2ZUkrY3RIUkpWdkpjcnl1?=
 =?utf-8?B?UEJEWENjNUE2elVESVpBdTlxYnduVVEwQ1JWSUtLZWRTVWFDbDJDWUNvNkRm?=
 =?utf-8?Q?BJqs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f6e516-fe7a-4062-31f2-08db76b57c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 02:23:24.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbKuU7Uee6caYtOQxwpCcID1elP77HAsXJ1UkTy3Rw46TlRB4lOdn8kGahPhLFPjyRrSW9mssbgwNAGt8LnX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIz5bm0Nuac
iDI25pelIDIzOjQ3DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29u
b3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMy8zXSBkdC1iaW5kaW5nczogc2VyaWFs
OiBmc2wtbHB1YXJ0OiBhZGQgaW14OHVscA0KPiBjb21wYXRpYmxlIHN0cmluZw0KPiANCj4gT24g
MjYvMDYvMjAyMyAwNjo0OCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBBZGQgaW14OHVscCBjb21w
YXRpYmxlIHN0cmluZyBpbiBscHVhcnQgZHQtYmluZGluZywgYWxzbyBjb3JyZWN0IHRoZQ0KPiA+
IGlteDkzIGNvbXBhdGlibGUgaGVyZSwgaW14OTMvaW14OHVscCBhZGQgc29tZSBuZXcgZmVhdHVy
ZXMgYmFzZWQgb24NCj4gPiBpbXg3dWxwIGxwdWFydCwgc28gbmVlZCB0byBhZGQgImZzbCxpbXg4
dWxwLWxwdWFydCIgZm9yIGlteDkzIHRvDQo+ID4gZW5hYmxlIHRob3NlIG5ldyBmZWF0dXJlcy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9m
c2wtbHB1YXJ0LnlhbWwgfCA5DQo+ID4gKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtbHB1YXJ0LnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvZnNsLWxwdWFydC55
YW1sDQo+ID4gaW5kZXggOTMwNjI0MDMyNzZiLi4yNzJiZmJiMWNkZmMgMTAwNjQ0DQo+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9mc2wtbHB1YXJ0Lnlh
bWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2Zz
bC1scHVhcnQueWFtbA0KPiA+IEBAIC0yMSwxMiArMjEsMTUgQEAgcHJvcGVydGllczoNCj4gPiAg
ICAgICAgICAgIC0gZnNsLGxzMTAyMWEtbHB1YXJ0DQo+ID4gICAgICAgICAgICAtIGZzbCxsczEw
MjhhLWxwdWFydA0KPiA+ICAgICAgICAgICAgLSBmc2wsaW14N3VscC1scHVhcnQNCj4gPiArICAg
ICAgICAgIC0gZnNsLGlteDh1bHAtbHB1YXJ0DQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhp
cy4gQ29tbWl0IG1zZyBhbHNvIGRvZXMgbm90IGV4cGxhaW4gdGhpcy4NCg0KSGkgS3J6eXN6dG9m
LA0KVGhhbmtzIGZvciB0aGUgY2F0Y2gsIHNlZW1zIHRoaXMgaXMgbm90IG5lZWRlZCBhcyB3ZSBo
YXZlIHRoZSBiZWxvdyA4dWxwKzd1bHAgZW50cnkgZm9yIHRoaXMsIHdpbGwgcmVtb3ZlIGl0IGlu
IFYzLg0KDQo+IA0KPiA+ICAgICAgICAgICAgLSBmc2wsaW14OHF4cC1scHVhcnQNCj4gPiAgICAg
ICAgICAgIC0gZnNsLGlteHJ0MTA1MC1scHVhcnQNCj4gPiAgICAgICAgLSBpdGVtczoNCj4gPiAt
ICAgICAgICAgIC0gZW51bToNCj4gPiAtICAgICAgICAgICAgICAtIGZzbCxpbXg5My1scHVhcnQN
Cj4gPiAtICAgICAgICAgICAgICAtIGZzbCxpbXg4dWxwLWxwdWFydA0KPiANCj4gVGhpcyBjb3Vs
ZCBoYXZlIHN0YXllZCBhcyBlbnVtIHdpdGggb25lIGVudHJ5IHdoaWNoIHdvdWxkIG1ha2UgeW91
ciBkaWZmDQo+IG1vcmUgcmVhZGFibGUuDQo+IA0KPiA+ICsgICAgICAgICAgLSBjb25zdDogZnNs
LGlteDh1bHAtbHB1YXJ0DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14N3VscC1scHVh
cnQNCj4gDQpTdXJlLCB3aWxsIGNoYW5nZSBpdCB0byBlbnVtLCB0aGFua3MuDQoNCkJlc3QgUmVn
YXJkcw0KU2hlcnJ5DQo=
