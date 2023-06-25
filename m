Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0C73D121
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFYNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:12:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E29E;
        Sun, 25 Jun 2023 06:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs5Thuqf5f2DXxL4xPUvdUYwjI0ZxMyUt3tpCJSfAcdCedLr+PxLwVym7ReKzmBGdd6thwNz6jYmjXKfKvk27XYoSWvBAEILY1/W1aTKJrRhfSbyi01lCxJ30FncGojhojcdIBzjxInnlII8xAeWvpOV/5IETjWOsaIE5UJtzTmNmfovodBWRnGSCEJKPJDNdbpZfFq+m7rIHbCJVyt5VrpoHfnHY+X1rpzoYgCRIAm2bdYWPLhh+EtZ1vtncqIkZh7ljFhmZB6kSDpfTswrt5/3vCCAYk67xXWhxfqIrNCyjof6Nk889qEBiU038akUtOk4qO0rHt/1IZxhb6J8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbz/WMqg3iMsq/iO5Prfv0xLXMIKYqrAqNa7BwCH/9Q=;
 b=k/AQj7SxLqFBiv/vGMiguEzNf5JdlJTHQvmXUIRbpsrvt05PqByTlzrRNuW36spytC6/+RRNsHm/s13vb8tBDZGBggS7zFJtHUtehJztOuNF6cVJA5v0vIgGVQA66wDx/QCSURQycHpWW0halsDTitRIkGJAqv6nYeEUCKuQO6m1lZO6DkY1gw2ZYYxhdJ+7ka9A5vsvK/YN+7dE9s4rcigQrkbDT34iTkWrOXv0I8i3qaXdQ6U1INp4VRZsnrP0tMtoWm2FK5HeJjwJMLrNSZVE156HCia6u1AKLivodfxHw5nXlB8P73dbSwagXml4u+9rPdxgnZFxVp+epVZDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbz/WMqg3iMsq/iO5Prfv0xLXMIKYqrAqNa7BwCH/9Q=;
 b=E5L8gbD/8KW+X41gxbDNS1cMB5ARWRErFMcHh5IypWo39v464TWo1ZYyMAanUrXv3UrJejnWQ0BMUSzOJ9jjrukrGEtjBd76gnZZOoG9ATOUEJrc1wi9V+AnLWvHeH1fDeM7/n7/rEDtiPxg1hb56nRVu54QyoUJOwKyh3FQXQI=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 13:12:05 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 13:12:05 +0000
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
Subject: RE: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Topic: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Index: AQHZp0sbmRUgGoZupUyaQLK7zLF8TK+bTeyAgAAqn6A=
Date:   Sun, 25 Jun 2023 13:12:05 +0000
Message-ID: <AS8PR04MB84042EF903689014CC0C33809221A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-5-sherry.sun@nxp.com>
 <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
In-Reply-To: <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB9PR04MB8332:EE_
x-ms-office365-filtering-correlation-id: 66a05815-c171-4758-85d0-08db757dc600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORfMcKJuxPn4UsFabnrk0brGkEsUNjnt2IDUEJ8jGxhO6G67GTmQsMuqqW7+pKvv45F+hCjGxN/+ACaZ8kDs4n2cU4amDE8f1Zl+CYGVGCxJbcpo3Jt/jFuli5maHo+k21wurMeKBNf7hzMcHzU4kArv3qwuRwq59prfR9D75PLBmnLA7R5aSbKkJeK2z+SvwFC4rSz+Qa4PlpHazuR8UnXPWKo/01yHAAgqbeudVJvZESOoFNYUKqiCOXa32hAnilnOH33FUUA3hWH9txCEksBtVdNPH+r9a0iyNcj098+nsPkabGjaJmm0CO3nlATVGJuwonWU1sYMqXEY9zTNmN76pll5U/OtB0VwJzCTW61CHsAsMVLeNrJKuvzmQX809Oo/AZT/D84otb+Tm+WKHe8NG7fzL8jyJpjvSPVnagqfXGEemykS84qq5u0hYT5EX6yDwdquftZnsXYaHNFcWrwqUa9Hpd+09637fIa5s8pNmVLZLOeDLnD3eaSNSSS9bagZPJdJUNJXhL7rgfv01ftxnYJCpBKKqXgmEB0zgOvART0cYHjTzZX3KbR5Zhtg2nZorYYxoHA279uGHE5Cwe5dzlLyVIkYgykD8t71ojEx9USbZ/CN23jjxXniZbNOY4ddCpFyepxqGnysW/0bWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(33656002)(52536014)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(8936002)(8676002)(66446008)(38070700005)(64756008)(66556008)(76116006)(4326008)(38100700002)(122000001)(55016003)(66946007)(26005)(6506007)(53546011)(2906002)(186003)(9686003)(7696005)(71200400001)(478600001)(110136005)(54906003)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmpoTXBGZW9NUVlsaWNVeW1JVW1mOE9XT1h6WXIxUG9nVEk2RnoxYndOVHhl?=
 =?utf-8?B?VEJJTEFROU41Qm1jQU9Td3NKKy9lNFlMOVg4ZlQ1SnFBc3NFVEpua0NSQW1p?=
 =?utf-8?B?ZWFUeWx3eUxPWE9IbHcyL0dmYkVWczdtVkl1SG9PWHVMSE1WSEFVVGFEWWRZ?=
 =?utf-8?B?SEZlVzg4RnRLZjA5VDUxd3dKTUtQSnNSZDlzeHBxVnVYL0UxS1Z0T2M2anBi?=
 =?utf-8?B?UFY2T0J3Z0RHS0QvejNFeGNkWjhyT0tMR2ZELzRaTnRXRkYvM1QzVENRcW9E?=
 =?utf-8?B?Z2JlUzZ4U3ZHZ0VmaEs2QlZjQnFZLytaUzNvSWFCQy9aY0dPeVZzNGtHS0tO?=
 =?utf-8?B?U0F3MVo5WUkxMExpSDVpS3ZGQTZmbkVUUlBBc21NR3d1RFJYVnZsbHRyZk12?=
 =?utf-8?B?Y3QxMm1XTG1EWWVTelViSlZsUURRQnhUZ1FzSlh6dWlGejdjUWkya2VnVmRD?=
 =?utf-8?B?TmFlRllNeXhVR0lYMDZDUWZmTGtDL0psa042bkZuYVBlTlpxbFlLOUY0THMw?=
 =?utf-8?B?TFFESnNTcTRrNjBUSjNwVkhIS1ZXbzd4RUo2Tkxldm9NYlhxdHc1eXhKTzk4?=
 =?utf-8?B?em5pVGtrcU9aYzA2dmJPUkhtNk1keW1EZCtrbjhKdVlWUm4wNWdFNFN3YmtO?=
 =?utf-8?B?K3UyWmdFb2hhY1dndzMxRGE3UjF0WGVZNUdTMWM5VWl5WWcrUkdPc1hNLzBE?=
 =?utf-8?B?QjhFNXpOOHlEc001WHNWQ0ptUG9mekx6bmVodUViSzVyaXIvUnZVWGtIdGxR?=
 =?utf-8?B?UW9MLzJidlpjUEVweitNSzlBSjMvckFuV3VGcURWOG45VjJ2LzgwUHJrWkpj?=
 =?utf-8?B?cUVzRm1reldpeHdicVpZb3R5OWFBUFdlQzhCRW9MSzJ1bnM4WGRKUjlQRHpB?=
 =?utf-8?B?N21mMlZJakI2Y2xpTXpYWEJGQWVhZUdqNVZKckJxd0VDNDdBekhsaEJIc09L?=
 =?utf-8?B?UHpDVW1BQVFwN2xJMWxIdE51NXhVbFJjY2ZVc2hUUmpVYTZRTTVyejkyOFQ0?=
 =?utf-8?B?SGs3YXA5ejY4Z2Q1LzlCdUNrQjZ1eUI5NkFSWGlwOWVNaVp6eDdnQVNYa1E3?=
 =?utf-8?B?d2h2Rkw4dEE2dUEzd3Zqdndzek9hNjhYQ0QrcCttdkRQSTlLQW1IS1ZxemJ2?=
 =?utf-8?B?OTJ5V252ZHd3eUk3ODZXWmVhVEVRMHRualZGaTRKbzhRZlNBRU5MNDdydEp4?=
 =?utf-8?B?OEFjZTRxYS9YSTNYNjFVTjJLdzBhM1hpYnBTdHpHZEFUdXZDTHBKL3lLN3Z2?=
 =?utf-8?B?RzNDV1c3ZXRUcWxOTUh5Nk1PejJlaW4wUktwdzlOTjg5MkRueXNWSm85YW1E?=
 =?utf-8?B?L2JXbGE3U1BoRVgvZGprcG1seW0zVE1vRUtXRmlPQnk2YjZqK1F4bHMzY24x?=
 =?utf-8?B?MTlFY3hWQS8yUU4wT1VGeXNCeUhVRUJ6YjhwaEtBZnVKVXlwTFRPdVdPQytV?=
 =?utf-8?B?ZzI3MG5QN1dZc2M3eDNJU1YrR0NvdXArc1VyQXlQTWdjWnU1TjFiQ24yUmdJ?=
 =?utf-8?B?NjA0QmJHSVk3VzNRek1sRmJxQ2UwbFRJT1liR0xTekNTazR5Q0twLzFWYWZr?=
 =?utf-8?B?ZUxJRFd4a2lqRHNQZ294LzE3dlFQaWhyeHdEYWhtaUxONDRNTEV0UjhJVkVQ?=
 =?utf-8?B?OTNhZ2MzZ2drck9URlpvUHg2TmNXZWV3c2J1UGVnT2c1bDlDTEM4bzM3N2Vo?=
 =?utf-8?B?dFlIY05HYUJyVjFaelF2WTdDSGZoR0t3Vk9jRk1kN1VONkV4cnJ2dnl5U2VQ?=
 =?utf-8?B?aUZCQTQ3N0hlRDlENjR6MG1LS3VQMFh2NmFZcFcxRjVXTmtreGt5WlBtYVV0?=
 =?utf-8?B?WmU0b3V1bE00QVpsNU9DRTNsWUtKYk9COUowRENBakNuRFQ3czhGbGkzTlg2?=
 =?utf-8?B?NEhRVk03bDgydkQvaEI2eE5hS2hFUy9IaEhkV0xiakVGRTRUNjNFVHY2dW83?=
 =?utf-8?B?dUhtNnN1WlQ1N0JLR2ZLdnY0ajJabzgxWDFvcmpkajdCQ3VZM3djdklvQ2oz?=
 =?utf-8?B?ZjJnTWdlQ1RFTEkyNkQ4d1lIeG5SQXNmd0kzR2N4UGpxQStQbHNtREczV0V4?=
 =?utf-8?B?WGxNbS9JdE44SFRES0lldXpkZXdNNTVRdzZvQlgzZnpUUkp5TVNxb2h0TVY4?=
 =?utf-8?Q?WyVs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a05815-c171-4758-85d0-08db757dc600
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 13:12:05.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj2jO5ShZA9nD8E6KROC2dPpbuBwFLuy2EUIawwMnoZOk1xQCFCxBJ735AjAbT42b19mfHA+Nhb+ok+3ona9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIz5bm0Nuac
iDI15pelIDE4OjE4DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29u
b3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkdC1iaW5kaW5nczogc2VyaWFsOiBm
c2wtbHB1YXJ0OiBhZGQgaW14OHVscA0KPiBjb21wYXRpYmxlIHN0cmluZw0KPiANCj4gT24gMjUv
MDYvMjAyMyAxMTo0OCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBMUFVBUlQgZHJpdmVyIGFkZHMg
YSBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGlteDh1bHAsIGFuZCBpbXg5MyBpcw0KPiANCj4g
V2hhdCBkcml2ZXIgYWRkcyBvciBub3QsIGlzIG5vdCByZWFsbHkgY29ycmVjdCBhcmd1bWVudCBm
b3IgY29tcGF0aWJpbGl0eS4NCj4gVGhlcmUgYXJlIHBsZW50eSBvZiBjb21wYXRpYmxlIGRldmlj
ZXMgd2hpY2ggaGF2ZSBib3RoIGRldmljZSBJRCBlbnRyaWVzIGluDQo+IHRoZSBkcml2ZXIuIFdo
eSB3b3VsZCB5b3UgZHJvcCB0aGVpciBjb21wYXRpYmlsaXR5IGJldHdlZW4gZWFjaCBvdGhlcj8g
SXQNCj4gZG9lcyBub3Qgd29yayBsaWtlIHRoYXQuLi4gUHJvdmlkZSBjbGVhciByYXRpb25hbGUg
Zm9yIHRoaXMuDQoNCkhpIEtyenlzenRvZiwgDQpXZSB0YWtlIGlteDd1bHAgbHB1YXJ0IGFzIHRo
ZSBiYXNpYyB2ZXJzaW9uIElQLCB0aGVuIGlteDh1bHAgYWRkcyBzb21lIGltcHJvdmVkIGZlYXR1
cmVzIGJhc2VkIG9uIHRoZSBpbXg3dWxwIGxwdWFydCBJUC4NCkFjdHVhbGx5IGlteDh1bHAgY2Fu
IGFsc28gd29yayB3aXRoIHRoZSBpbXg3dWxwIHZlcnNpb24sIHdlIGNhbiBzYXkgaXQgaXMgY29t
cGF0aWJsZSB3aXRoIGlteDd1bHAsIGJ1dCB3ZSBuZWVkIHRvIGVuYWJsZSB0aG9zZSBuZXcgZmVh
dHVyZXMgYnkgZGVmYXVsdCBvbiBpbXg4dWxwLCBzbyB3ZSBhZGRlZCB0aGUgaW14OHVscC1scHVh
cnQgY29tcGF0aWJsZSBpbiBscHVhcnQgZHJpdmVyLiBTbyBmb3IgdGhpcyBjYXNlLCBtYXliZSBj
b21wYXRpYmxlID0gImZzbCxpbXg4dWxwLWxwdWFydCIsICJmc2wsaW14N3VscC1scHVhcnQiIGlz
IGNvcnJlY3QgZm9yIGlteDh1bHAgcGxhdGZvcm0sIHJpZ2h0Pw0KDQpUaGVuIHdlIGhhdmUgdGhl
IGlteDkzIGZhbWlseSB3aXRoIHRoZSBzYW1lIGxwdWFydCB2ZXJzaW9uIGFzIGlteDh1bHAsIHNv
IGhvdyBzaG91bGQgd2UgaGFuZGxlIHRoZSBjb21wYXRpYmxlIHN0cmluZyBmb3IgaW14OTMgcGxh
dGZvcm0/IE1heWJlIGNvbXBhdGlibGUgPSAiZnNsLGlteDkzLWxwdWFydCIsICJmc2wsaW14OHVs
cC1scHVhcnQiLCAiZnNsLGlteDd1bHAtbHB1YXJ0Ij8gQnV0IHRocmVlIGNvbXBhdGlibGUgc3Ry
aW5ncyBsb29rcyB0b28gbG9uZyBmb3IgbWUsIHNvIEkgd2FudCB0byBkcm9wIGlteDd1bHAtbHB1
YXJ0IGFuZCB0YWtlIGlteDh1bHAtbHB1YXJ0IGFzIHRoZSBiYXNpYyBjb21wYXRpYmxlIHN0cmlu
ZyBmb3IgaW14OTMgYW5kIGxhdGVyIG90aGVycyBpbXg5IHNlcmllcywgSSBhbSBub3Qgc3VyZSBp
ZiBpdCBpcyBzdWl0YWJsZSwgc29tZSBzdWdnZXN0aW9ucyBoZXJlIHdpbGwgYmUgYXBwcmVjaWF0
ZSwgdGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo+IA0KPiA+IG11Y2ggbW9yZSBj
b21wYXRpYmxlIHdpdGggaW14OHVscCB0aGFuIGlteDd1bHAsIHNvIGNvcnJlY3QgdGhlDQo+ID4g
ZHQtYmluZGluZyBoZXJlLg0KPiA+DQo+IA0KPiAiTXVjaCBtb3JlIGNvbXBhdGlibGUiIGlzIHRv
byB2YWd1ZS4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
