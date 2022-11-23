Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE6635A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiKWKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiKWKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:42:43 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02B29355;
        Wed, 23 Nov 2022 02:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD40ep0ostEmm1Ir0ywC8BHVK8dIOBiixcToFU74PlFeXRTDZ2lvzurOifT1kLi+5oF5su0uPBd0a1EGkHOANSmtHUetXs6rSBQchn/8AqQwoKWBExmhTBy+OEJCKNFlBUh1H6LLrqjX+Edo+8MDJaNNIXqmjPWzl+G8TugqgAS79y6y9kQbKGjwrsOt3tbrylGEnaKDt4K1HohTLFULa6qpEU6Pmi0QEHNC0rqE29yldBaI7ViW5UQ9ggqNF5TxO9kEhLsrf7qo2exipgTiJAIz8NhoRzPpPFs1OKpNhEOQWjlj5QCTQRZWugw6U7E8c76H0tr9WWRJXwAn8YChFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM8aKKzU+0yQUMmjvg6oSkpk4CAPvKuyH5lk+WGXezE=;
 b=Brwn1ldAptDStOaMDZjVnWnBoit3cBCpyQwNf0fWv2hcHD4vzRN/EkbQZYlDioZZb5jhGYCeX6bamo8QVcgnYJ6Mt+LDcvn2ShbQ0knWjGXtEJNDMV2einnHFxsF49EM/y11Y9iKVwQpMvDOFe3B2W2jn1GWGRhyTeo9dcNqArCIpYSfzNqMrCxNLsQ9tBI9OCt0MsIJdDYPcgwvXPVBzXmyaheRT3VqWQ60bfwze76Tlhgn8UEcu2+Q+sfulv+OJkVSZG3vATNBL2sc/dJy+RAZtSIDdySyDL2a885VOZad0tM7Y9EGrf0w9KMFAF96jusRrqOyH5T17eXBWVk6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM8aKKzU+0yQUMmjvg6oSkpk4CAPvKuyH5lk+WGXezE=;
 b=d6VikYha1ZSz8eK9sE8iuKieOadyPKlB5RYhUCcqb7nCDYOreO5B52zhlADqMGj0ScGQdex+FLSEK4w7y6vWUD7O92WKAo3ilz+veVd3QOmkz8tnuOxZdsO5BQpT/4iT4Rv1ZWyPH9ogoThBJVSS7rkB89PYIGrMfZdVDMCIl2s=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 10:28:01 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 10:28:01 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/5] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
Thread-Topic: [PATCH V2 1/5] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
Thread-Index: AQHY9N0lxRt0XhxLX02eKV3av9Bu+q5LPOuAgAEjvyA=
Date:   Wed, 23 Nov 2022 10:28:01 +0000
Message-ID: <AS8PR04MB8404ED0C7555DE350F7EBB52920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-2-sherry.sun@nxp.com> <Y3z/K0NI/fw0DPYI@kroah.com>
In-Reply-To: <Y3z/K0NI/fw0DPYI@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PR3PR04MB7289:EE_
x-ms-office365-filtering-correlation-id: 0e69d5bb-b6d1-4f95-c3f4-08dacd3d662a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUyYdlZHhDoBBBYwGomU+hNPgYQu4r0pbKdg4qzYkb7075IXWpPMdUfYXoVjW8EZCwS6DHQe9sRoqz6UpfEReIRmnwORwRmx8fXIFG1+Fu4OXh5Waa4fn16+u0c315Pt55e0vNBhmyyPyAme6xXkjvjRtks+dAe5TmAFrhroV3iqDVRGT6R/2wpHbH9Uxv5SAK5if0iIIc3w+UWoxyXjVB3Z6GI9xOSlsM5YyM7Xay7Vbgx/i7zcj6TWw3fVJ7beyrjQSTcJCGORRfogH77e2ihkfebsFLaFL4NFK3kINvKukPZLGXHWTn04RRe7KB5AX4ui2Y0IN/T6NA9HPI9J3fhIknEQgKo24PsKTYodp6BMwTe5hnnKPp/oVzx4DwzjHwdlPchZQBE9bg6WLg8euibJpoEo7FadsYRgp6YyBBlf51p7YlwRl69335gPQD3a5KDPr/6QyHS3Em7dpx7AcxtPzJGURs4+s9r/mYPdeKEdGJ2oBHUC+GCLg8doKQRi93XenRijX47xCMaPCGUttD1YJ37vaQLF/KemwGB99s5gyYnL+B4p+ixqwu9JqIOyUxJOGVVRAKquF3bDHvgDaYOqARWkVqND7dShpgCWrTEeB0m+Pu1aiAcfFXLcLn5QlPIXiglqff7phC5CVc1X6LhoU53gHbacEelGOlKeF5LU61RERXZw4cPXiEibBPaPDsr7Y5eaQXQy+g3YlUIGgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199015)(83380400001)(478600001)(122000001)(38100700002)(44832011)(38070700005)(8936002)(54906003)(55016003)(6916009)(316002)(5660300002)(41300700001)(186003)(52536014)(26005)(76116006)(9686003)(2906002)(66946007)(7696005)(53546011)(6506007)(33656002)(4326008)(8676002)(66446008)(66476007)(86362001)(64756008)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S2Vqci90WHE5TDdvaW05VVRSNTlnaUtZTjZIRXlyYnEzNWVPKy81dzVNdVVw?=
 =?gb2312?B?aFcxdlhpbVljWEFQUlAyMDVicXl5SHgzVmdBMGwyeXg1UDlUT3dHWGFIVGRp?=
 =?gb2312?B?MjJzeEcyQ1BiNTZKYjlDVjFkU2lGZENIYnJsTVJwOURzR2hQbk41ZjVYL25Y?=
 =?gb2312?B?K3c4Sit0L3g0THAvK3dhdEhLQ1QwK01pZ2ZXN2VUcENHczNFWS8xVmpUS21N?=
 =?gb2312?B?b09YZ2FuY3VFZU9mcEtIbk52TFBYU0x1NU1xTnlPQlZRTzFPaU4xdlJyWGN0?=
 =?gb2312?B?elpobjF3bnh3VjVXVkF5QlBVcHVraFZaeFZIM1RNdWhFT2N1TERTSndZN3FC?=
 =?gb2312?B?N1AvMVVTR2cweEQ1YVZhSzBhZWhVclM5dW03WmJQZVJlS1pZWTRRd2RQUVha?=
 =?gb2312?B?eXo2eHR4bVFsbzdxc0kwRzZWcnM5VWErZ1h1ZzhNMFg4VWxiU0h5MHJ0NXZD?=
 =?gb2312?B?QmNIZXVibUROWjgxMlJQOHRlWUpSNlVWcjc3RUNyVW44UnRYWTJweVRaTkZB?=
 =?gb2312?B?Qm9TcEYxMVhxRGNFMFNacktLMlFUK3pWaGRXVXhlYjlIWkJOR3l0WGd0bk1u?=
 =?gb2312?B?N2V5R2EwcW03QUtmTkRLUDJkQTRGbjVYek5Za3RSUlU4a0tzMGpjbVpGR04y?=
 =?gb2312?B?TnZXSzZSWlF1VnVIV1hDLzNEOVFCUlU4bU5sdFE1MTErMVRpMW1rU05qdlYv?=
 =?gb2312?B?ZTlmN2cxQXZ1Z0NwQzYrS3VrM3pCd2pReUphcTZXNk9xSWoybTBEdkozdmFx?=
 =?gb2312?B?SlM0N1BrRDdpKzhnUG0rcWxQSWE0RzUvMDcyeFI3OWo5TFBMcWNRMGFtNi9C?=
 =?gb2312?B?aDYxM2c5VlBFVEh4dUpGb1RGV1BzRHJDQ01lSzZZMXpid2wwc0NqeDZUMnBH?=
 =?gb2312?B?UmhvbkMxWUY4L2xqekpIeVVqMFlKZU9oZ0Uya2NjRml4YU9oSG9XalhmRUNn?=
 =?gb2312?B?RGRDTHJvOWpRN2ZXNkxJV21oZHJzcEN2RlQxSjFjcUYxVUhZSmc1Yk5OVjh2?=
 =?gb2312?B?aGNCTVBMQnduODJuVGJxM0xIS29uMTVoMURLVFdxdmN3QW0zRWoyQndhNGR0?=
 =?gb2312?B?VlpQVDVPa2h5bGdDdnp2alBwc2haRXp6Mnpid3ZrNW80dzhleHV0NjdCNHBY?=
 =?gb2312?B?WWwvMGtYTG9GenRKZUN3Z0U2dmtrcXRRNmJHNDFWdktVMjlHbHNUTEdqd1Rk?=
 =?gb2312?B?cXU3cCtFWlYrZjZteWk0V1I4MjVYdDZBRndpeEFZZGVTbVRjeWQxTkZDdW5s?=
 =?gb2312?B?b0FEMFBYblEyRTZ3dG1jTFhsOTFjYm9xL0ZmdWFsaDBKck9CRGFQVWYrbmdJ?=
 =?gb2312?B?cFRTYUhtSW5DUXNHM1JoeG5BZUFJWGZvTHBQMzcyVGRQZHdFbmpDV1A5S2pv?=
 =?gb2312?B?WFF1ZjJvaWF1SDRCZ3oyYnl3K1E0TTg4WW5KYU1UYWV2TDJzS29hTjJ6K3dQ?=
 =?gb2312?B?eGJtWk5Kd25jM2pkUmQ3VHFKcXhQR0pvaW1CcVNkOWREQW9HcFBpTldlbVJh?=
 =?gb2312?B?Vy9GMFEza29NSnJKS1pEbDg2QkZIYlJEaHMvTUtHTm9wSnhSbHpzRUhQMmF6?=
 =?gb2312?B?Q3pLcUpabGRtVk1OVUlvcS9YWEZGemJURllBTVMwMnZmQjQ3VGVweVhSWUpz?=
 =?gb2312?B?SzhXZnk0NzRZQytLWm56MnBaejQ5TGEvdWxBRkVjUVhiVHMwbExRZExUNFBn?=
 =?gb2312?B?aUV2MEhqNWpsaElVSTdlemlLbkNFWVFJM280Q1liQVdlOVhHUjNYWnFiMHZV?=
 =?gb2312?B?SzBqYndBRlpjY3NpWE0zcGVqbnJwaklBWlY5elBzNHNoVkROeERJcmpUY3lK?=
 =?gb2312?B?dGRvZUZvN2R5bk9nL3FYTENTU3htS2p1MzF0TXZxMEU1M2FIWG9pcG5CbUVJ?=
 =?gb2312?B?SEF2c3l1SlE3QWtaeXROTlJFVHQ0NkFaM2hIbWlXaDZvbldBVmgvQ2NXeFQ5?=
 =?gb2312?B?NTVvcE03SXVxcGhXMXpYdk4yMmhhY2dFaTRMTHVleGJCbHNRYmlQbnMxMHRp?=
 =?gb2312?B?ejc1UGNoREUydytFYnhmeUtVMVZsY3RVUGcxaDQyNG5wNnZXVU9UR2NQZzBy?=
 =?gb2312?B?VjcxU2lSYzlKQyt3VWNwUEl0eklqS0JCWktzN01iOXloVWpzLzh4YlM4Y3JC?=
 =?gb2312?Q?v4cztaMOepcnC2YwMgUathAuO?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e69d5bb-b6d1-4f95-c3f4-08dacd3d662a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 10:28:01.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFxRsXliUptP9i9GlHdet9TPFeNHHdk/G7Aq3sdONw4cJnL8bDhw+vvcHhSkAVwto3QINfP0R3bUYOz9V1/UFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEx1MIyM8jVIDA6NTYNCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyBtaWNoYWVsQHdhbGxlLmNjOyBqaW5nY2hhbmcubHVAZnJlZXNjYWxlLmNvbTsNCj4gdG9t
b25vcmkuc2FraXRhQHNvcmQuY28uanA7IGF0c3VzaGkubmVtb3RvQHNvcmQuY28uanA7IGxpbnV4
LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWMiAxLzVdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBvbmx5IGVuYWJsZSBJZGxlIExp
bmUNCj4gSW50ZXJydXB0IGZvciBub24tZG1hIGNhc2UNCj4gDQo+IE9uIFRodSwgTm92IDEwLCAy
MDIyIGF0IDA0OjE3OjI0UE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gRm9yIHRoZSBs
cHVhcnQgZHJpdmVyLCB0aGUgSWRsZSBMaW5lIEludGVycnVwdCBFbmFibGUgbm93IGlzIG9ubHkN
Cj4gPiBuZWVkZWQgZm9yIHRoZSBDUFUgbW9kZSwgc28gZW5hYmxlIHRoZSBVQVJUQ1RSTF9JTElF
IGF0IHRoZSBjb3JyZWN0DQo+ID4gcGxhY2UsIGFuZCBjbGVhciBpdCB3aGVuIHNodXRkb3duLg0K
PiA+DQo+ID4gQWxzbyBuZWVkIHRvIGNvbmZpZ3VyZSB0aGUgc3VpdGFibGUgVUFSVENUUkxfSURM
RUNGRywgbm93IHRoZSB2YWx1ZSBpcw0KPiA+IDB4NywgcmVwcmVzZW50IDEyOCBpZGxlIGNoYXJh
Y3RlcnMgd2lsbCB0cmlnZ2VyIHRoZSBJZGxlIExpbmUgSW50ZXJydXB0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
IENoYW5nZXMgaW4gVjI6DQo+ID4gMS4gVXNlIEZJRUxEX1BSRVAoKSBhbmQgR0VOTUFTSygpIGZv
ciBlYXN5IGFjY2VzcyB0byBVQVJUQ1RSTF9JRExFQ0ZHDQo+ID4gZmllbGRzIGFzIHN1Z2dlc3Rl
ZCBieSBJbHBvLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5j
IHwgMTEgKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gDQo+IFRoaXMgY29tbWl0IGJyZWFrcyB0aGUgYnVpbGQgZm9yIG1l
IGFzIEZJRUxEX1BSRVAoKSBkb2VzIG5vdCBzZWVtIHRvIGJlDQo+IGluY2x1ZGVkIHByb3Blcmx5
IDooDQo+IA0KPiBQbGVhc2UgZml4IHVwIGFuZCByZXNlbmQuDQoNCkhpIEdyZWcsDQoNCkl0IGlz
IHN0cmFuZ2UgdGhhdCB0aGUgYnVpbGQgaXMgcGFzcyBhdCBteSBzaWRlLiBCdXQgYW55d2F5LCBJ
IHdpbGwgaW5jbHVkZSB0aGUgY29ycmVzcG9uZGluZyBoZWFkIGZpbGVzIGZvciBGSUVMRF9QUkVQ
L0dFTk1BU0sgYW5kIHJlc2VuZCBpdC4NClNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4NCg0K
QmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
