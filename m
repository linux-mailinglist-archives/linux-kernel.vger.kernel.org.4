Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E368244A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjAaGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAaGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:04:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1E15CB3;
        Mon, 30 Jan 2023 22:04:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srt/t48aKC9mCDgkawEOoSnssTYm61fRJ0uyCqDc9bd94Z60bEnZ1+pTC3tICkzhgPeXKcGSjq9PER+qWuTojACnF00jeM8F0x/bBL4JcUzXonBp7UWZXhpe15b+Et1ljkmp3V8HgnERQ/DnICexuq9LBzBTJj9XCjAy2+JFfGyKRfcXXcB6p1sqRS/JGQSsvUQpDI4FyPk7y0V2G/q5C1mbshis6+Y5f0W7ofnFYLwXUmqYjTmgF5WreXaxuFWYSqL2LVHUI5LJUgSHXbkUqEeJr99eI/mCRb7MaRXiY2YP5v73Gz3LeK8+JiL8l8ItAfuWo9G8cWrn2bzyrja2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5INvZjJhcfYtiuTsVTpSi3Md9jthvoIO2SQOOsgqkoI=;
 b=Rn1zg5Thf64fwbtvPgMH0Y92rd4gi+oEIkLWbkio1NEIQx9mndjj/CTbisdRRconHazVACfQiS5xKv7g/brn7mrvrc1waFwAVskwXUww7mBRnN1/tbWa7b7+EKdV6nJmiyyIqwHvFCLFqvRZO0aYWcsMuzBZQpjfcJOdXA+rGHUn1RaWx/5M2EVYvdZfIM+H91ivupALHcidGeAzxOWigxoGLpb+h2uopxHDGewfb+aXuniZaVbzjtZjrm3EVB3r7WVFnMjMFayu0oWV8C0tt3bJm7IkQSuTU2qCrJuqycEila6tMuq44FwwciNmzGa06WfN3nUvHNvdC/fsjQ9spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5INvZjJhcfYtiuTsVTpSi3Md9jthvoIO2SQOOsgqkoI=;
 b=YHmnsQ/WG3EGU/k3vdo6pOkvqFaxcp1Tdxpe6cQsQDfpjVYTR5ec1xY1ISfIbUTE1BgTiN3B59kD7/eJC5ca2eWZax5YRkOy1LjgAw9YRo/oA7hh8ovp5/MWvQy4ZB9dSqhNX9OyaVd1wLhrQj2TehKVr8O7jyiWpSdQ8M5OTxY=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by PA4PR04MB7711.eurprd04.prod.outlook.com (2603:10a6:102:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 06:04:30 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%3]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 06:04:29 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Topic: [PATCH v1 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Index: AQHZIO8XC/zE2oGms0+KNaIQIXhCc664Md5g
Date:   Tue, 31 Jan 2023 06:04:29 +0000
Message-ID: <AM6PR04MB60536BE542CDF7E791157002E2D09@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
 <20230105101748.6714-3-alice.guo@oss.nxp.com>
In-Reply-To: <20230105101748.6714-3-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6053:EE_|PA4PR04MB7711:EE_
x-ms-office365-filtering-correlation-id: 87622357-8688-4fdc-2446-08db0351041a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8FQ5X8qNqKn1TeyRUwpfxEB6oK5LAjXZ9Q5yCgI1mtOcaorSK1fVkzpFWbvX/cMjSzo4kLqsNgStOXILcdgk9C7izk2XwebaYgMvaZDUNewsaP474KDeFFsxbJi8abHWbpySZ5Xusd+61MjSl2xusnprjzoEBJl3w7qCLh/k8QIc8jSIKexOUC3chT+wVPfj7AVL0EtvvzgZsmxZ9bkrqG4SnfN5DUNQgqqtnzxvLjGXL/uUQ2vPsPjFgaR6ErRiUKpiecrJA15+Sf3uuT1pNIV+m0Mn894h496VDGcoaIeHJL5ao3bYFm2XuOf1HXdh1e/zbVCr6hBgeuwbNagsMzmSeC38nCI2CpI5VejHJiTxMwdkxkfqglUov4054CqJ38/f/kWTteZRcuG3maM+1pBKL3zx4W+cVijhzjA1zeCnhRmJNdCPxlFTN+6P+0y6tuuHEyVHGgdSHZOTCYJAn5j6V5z7vwBwmiLvRfERlTiyC2Z3jTiCiR3pBSVGkKNYaulRJvoLeqYu8ZDkvBG/XDorUtlhqCkQ9ryAo5uY0l+2LDfA2RU4NEV/46dEZpKhn64a7stNDEHQQViW3PZHmBP4DgA9tzuPDH5G6GTaqYzcEEpJEsy5RH3h+JgMITRFmAMlDb9TITCo1JWcLSkwNf717oFLDYZYBBdsR7MMZHpAf+N0aVfH5frJI4KFJUj6AMhZkcsoFK8gFtBmCjNPuRO+MtcFlNWKwVZnrqYq5RbRp3YWPswNuZoMmyCyLT2b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(86362001)(33656002)(83380400001)(316002)(110136005)(54906003)(478600001)(966005)(7696005)(6506007)(9686003)(26005)(53546011)(186003)(71200400001)(52536014)(122000001)(5660300002)(38100700002)(8936002)(921005)(2906002)(38070700005)(7416002)(55016003)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlBa0lSaWdnK3A5NTJ6SGp1eGJ3dnB6aklFNXNKTU5FUUFkYkxZVnd1R05y?=
 =?utf-8?B?N1JiRDR0eXdQYWQ4eG53STJiR2ZJNFJyM3hNRnZTRGZTKzZTakk5eHRYdzBk?=
 =?utf-8?B?UVdGY1pGTlVaMkpGNmtxNDhpdFFzUnBGVHFQdnNJMXNtYUMzMDkzald3NFcz?=
 =?utf-8?B?UTJyTFJVakduc2hvdUxXQ0pkTlFTd2o3RWNYYjd4ZEJWWUFMdGppZ1NWOGxa?=
 =?utf-8?B?OUozem5ONWtzbm5uUThkSkJJSlNmNHdieEcxQ0kxSlAreFhocVdnbFREenVr?=
 =?utf-8?B?TXQrTWJDNUhKa0lsNUQ4T1MxdUVlbkRLeHFqV2dpMHhHODhxb0xVcURnMXFo?=
 =?utf-8?B?YVN0TWZEcUZOdVIwbXdHUVROV2s0a1NiWVVWam9aSDRHdmlHVytyb2RBMXJV?=
 =?utf-8?B?cWRNSDhKU0VZK3Vwd1lPSlRCa1FFZU13K3ZPTDJUNUZvT3J1MnIwci9ybmVQ?=
 =?utf-8?B?NythbjY4VFdrTVB0UmdyRi9TRWZZenY0RWJhRjRyVi9JQ1B6akJuamdoUCsv?=
 =?utf-8?B?UkhaVlN3MWlta0cvQ3hHVyt4TzU4OTVDa25KVXJJZXFGNWFxdUVJT0QwQ0Vz?=
 =?utf-8?B?WVNHdUhGWFEzeTM1anBEWjU0dDE0STlGQWx3U29GaTFJdzdqL3kzTWpndklz?=
 =?utf-8?B?R0lsNjBnZ0MyaUlJUk1xbUI1SmtSU09vd3NOL3p1b0wwVXIzUHZDMUwxNDU0?=
 =?utf-8?B?Z3ZQcWNuMmd6TGxWMDN3eUlFbUh1SWYrWlRBYTk1QVZHbFpLQUZSUzgraTZC?=
 =?utf-8?B?bnUyOE1DVk01czBIRHVvTlVaRys2WGlkTFNIQjhOY3hNb2dBeHB1MFAvekhI?=
 =?utf-8?B?cTR0V1dwT0hxQUNSbXFBWUFGdTBQMTRZYlJ2TWlhQitYTlNOa3owVld2T3JE?=
 =?utf-8?B?dlV3VEdMMWlkRjQ1RnZ2bWhvU09HYm9oMkpvYzc4WE9uOEpJbVBSQzJhT3VL?=
 =?utf-8?B?SnErVXF1Rno5Y0t0OWZvaGJLVjlveU4zMmVRVkdvaTNXSHg4MXYvWlhPZklQ?=
 =?utf-8?B?UjRySFlyc283NjAvZWlCUGF5djlPWXNQMWV6Y2JnbFh0ZWpzZUw5bU5NRGRH?=
 =?utf-8?B?NWJ1eFhsK0FSc1o3bUdmME1MeC9lbHh5N0ZOZnNVamlqbFJQSytTUHVNdVJr?=
 =?utf-8?B?ak1LWG1TYks0SUwvZTFOSGdQZkxlRTdGbjZIR3NrOWlNYkFyenZ2RzVkV0tp?=
 =?utf-8?B?a1dSUnVTRnRCTU90MXlVQWhxSVhQVE91MWF6ZkR1a2tGcG1yWDhSbGNoM0pn?=
 =?utf-8?B?a3NVQ210cFdVS1p5bWV6dWhKRG82WGh1VW9kY1RhYjRsSVYxaVFrOXoyYmdN?=
 =?utf-8?B?N05hb3lENHBzS3V4TE93OW5mNy9pOGpIVHovL1FoTEZtQkdBRFh6Z2IxaDh4?=
 =?utf-8?B?VytKK0ZKdi9pd3lQL0djOVpSRTRUb3hOY0JHeVd6Y0lHK0RLYVNRTHlaQTNF?=
 =?utf-8?B?dEt5d0ZLTU9TNjRQUlg0YkhSdFlvMC9tYWhJdFlNQmlXWXJaMy9BRy9aWVZY?=
 =?utf-8?B?dnUzdlI3ZHNEMW83UnNBRFVoaTZwcjRhM1QwWWNJV1l4YVN0WG5yZGlKUzQ2?=
 =?utf-8?B?Vmp6dGVGQ2FWbU9neXRWMzJGYTQ2ZTdWcFdvTzNjRWRubnBvYVZ6a0R2R09G?=
 =?utf-8?B?TkpYK2RCbGd3ZklhSGw0YjNWRCtUTCsrL0lnLy9FalhMRWxXbjlHVzZhR1Vn?=
 =?utf-8?B?YjMxMlplMlVmSGppUVVGM0NRWGdlQUZYclUyc3VwNmM3UWdxYzhteitGSEVQ?=
 =?utf-8?B?eXRWSTNyQ2Roc3hETlY1R1dYQzFmS1pLZ1lSaDhtV3M0dFRJdEpKOUNvSk1v?=
 =?utf-8?B?eE5ZTmJkK2MrREpMSFphdms0bWRkcHRIcURCZmpkMGhYTjNGcjNwUWhsakRx?=
 =?utf-8?B?dzJLT2JVUjM3TXdBdGlsVUNzRWZNNmFRVmxRMzlrc2RLZ0R2WmhxZUFaZEc5?=
 =?utf-8?B?SGlEOUlMNnRkVzBTTld6YU8yRXRKOWRIaHVGankxd3FTYVVTcitQemxSQ09G?=
 =?utf-8?B?dTdaTWtOZHcremcxeVJGcGwzZDJCOGl6SzFYTGx4dnVFSTRDaHJWb3g4SE1S?=
 =?utf-8?B?Z2FHVFJWenNCWjdUenpncm9JS1hUK2czbnVDYTNGc0FsTE5CZlNMTmhkWGpR?=
 =?utf-8?Q?Gm6qXz6pF8apWQoZIoaxYKczl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87622357-8688-4fdc-2446-08db0351041a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 06:04:29.8644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqHxwyuDVwGMsRbsPRNiK00bBErNQRRahBLg547gx0pn96L7QaQiRIR9zZQWZXsdMgbKRdSOi3x1baG8nFo/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7711
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2luZGx5IHBpbmcuLi4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtl
cm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBBbGljZSBH
dW8gKE9TUykNCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgNSwgMjAyMyA2OjE4IFBNDQo+IFRv
OiByYWZhZWxAa2VybmVsLm9yZzsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgYW1pdGtAa2Vy
bmVsLm9yZzsNCj4gcnVpLnpoYW5nQGludGVsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogbGludXgtcG1A
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djEgMi80XSB0aGVybWFsOiBxb3JpcTogYWRkIGkuTVg5MyBUTVUgc3VwcG9ydA0KPiANCj4gRnJv
bTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gDQo+IFRoZSBwcm9jZWR1cmUgdG8g
cHJvZ3JhbSB0aGUgY2FsaWJyYXRpb24gdGFibGUgb2YgaS5NWDkzIFRNVToNCj4gMS4gZGlzYWJs
ZSBtb25pdG9yaW5nIG1vZGUNCj4gMi4gY29uZmlndXJlIFRDTUNGRw0KPiAzLiB3cml0ZSBUVENG
R1Igd2l0aCBUVENGR1JbQ0FMX1BUXSA9IG4NCj4gNC4gd3JpdGUgVFNDRkdSIHdpdGggdGhlIHNl
bnNvciB2YWx1ZSBvZiB0aGUgY2FsaWJyYXRpb24gcG9pbnQgbiA1LiB3cml0ZQ0KPiBUVFJDUm4g
YXNzb2NpYXRlZCB3aXRoIHRoZSBjYWxpYnJhdGlvbiBwb2ludCBuIE5lZWQgdG8gcmVwZWF0IHN0
ZXBzIDPigJQ1IGZvciBhbGwNCj4gY2FsaWJyYXRpb24gcG9pbnRzIGZyb20gdGhlIGNhbGlicmF0
aW9uIHRhYmxlIHByb3ZpZGVkIGJ5IHRoZSBUTVUgZGV2aWNlIG5vZGUuDQo+IA0KPiBXaGVuIFRS
SVRTUltWXSA9IDEgYW5kIFRSSVRTUltUUDVdID0gMSwgbmVlZCB0byBhZGQgMC41SyB0byBUUklU
U1JbVEVNUF0uDQo+IA0KPiBJUEJSUjBzIG9mIGx4MjE2MGFyZGIsIGx4MjE2MmFxZHMgYW5kIGku
TVg5MyBoYXZlIHRoZSBzYW1lIHZhbHVlDQo+IDB4MDE5MDAyMDEgc28gdGhhdCB1c2UgdGhlIGNv
bXBhdGlibGUgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIGN1cnJlbnQNCj4gVE1VIGJlbG9uZ3Mg
dG8gaS5NWDkzIG9yIG5vdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2Uu
Z3VvQG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+
DQo+IFJldmlld2VkLWJ5OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gQWNrZWQtYnk6IEphc29u
IExpdSA8amFzb24uaHVpLmxpdUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC9x
b3JpcV90aGVybWFsLmMgfCA1Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9xb3JpcV90aGVybWFsLmMgYi9kcml2ZXJz
L3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+IGluZGV4IGQxMTFlMjE4ZjM2Mi4uMTgwMzBiZDY4
Njg3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvcW9yaXFfdGhlcm1hbC5jDQo+ICsr
KyBiL2RyaXZlcnMvdGhlcm1hbC9xb3JpcV90aGVybWFsLmMNCj4gQEAgLTI0LDkgKzI0LDExIEBA
DQo+ICAjZGVmaW5lIFRNVE1JUl9ERUZBVUxUCTB4MDAwMDAwMGYNCj4gICNkZWZpbmUgVElFUl9E
SVNBQkxFCTB4MA0KPiAgI2RlZmluZSBURVVNUjBfVjIJCTB4NTEwMDljMDANCj4gKyNkZWZpbmUg
VEVVTVIwX1YyMQkJMHg1NTAxMGMwMA0KPiAgI2RlZmluZSBUTVNBUkFfVjIJCTB4ZQ0KPiAgI2Rl
ZmluZSBUTVVfVkVSMQkJMHgxDQo+ICAjZGVmaW5lIFRNVV9WRVIyCQkweDINCj4gKyNkZWZpbmUg
VE1VX1ZFUjkzCQkweDMNCj4gDQo+ICAjZGVmaW5lIFJFR1NfVE1SCTB4MDAwCS8qIE1vZGUgUmVn
aXN0ZXIgKi8NCj4gICNkZWZpbmUgVE1SX0RJU0FCTEUJMHgwDQo+IEBAIC01Miw2ICs1NCw3IEBA
DQo+ICAJCQkJCSAgICAqIFNpdGUgUmVnaXN0ZXINCj4gIAkJCQkJICAgICovDQo+ICAjZGVmaW5l
IFRSSVRTUl9WCUJJVCgzMSkNCj4gKyNkZWZpbmUgVFJJVFNSX1RQNQlCSVQoOSkNCj4gICNkZWZp
bmUgUkVHU19WMl9UTVNBUihuKQkoMHgzMDQgKyAxNiAqIChuKSkJLyogVE1VIG1vbml0b3JpbmcN
Cj4gIAkJCQkJCSogc2l0ZSBhZGp1c3RtZW50IHJlZ2lzdGVyDQo+ICAJCQkJCQkqLw0KPiBAQCAt
MTE0LDEwICsxMTcsMTYgQEAgc3RhdGljIGludCB0bXVfZ2V0X3RlbXAoc3RydWN0DQo+IHRoZXJt
YWxfem9uZV9kZXZpY2UgKnR6LCBpbnQgKnRlbXApDQo+ICAJCQkJICAgICAxMCAqIFVTRUNfUEVS
X01TRUMpKQ0KPiAgCQlyZXR1cm4gLUVOT0RBVEE7DQo+IA0KPiAtCWlmIChxZGF0YS0+dmVyID09
IFRNVV9WRVIxKQ0KPiArCWlmIChxZGF0YS0+dmVyID09IFRNVV9WRVIxKSB7DQo+ICAJCSp0ZW1w
ID0gKHZhbCAmIEdFTk1BU0soNywgMCkpICogTUlMTElERUdSRUVfUEVSX0RFR1JFRTsNCj4gLQll
bHNlDQo+ICsJfSBlbHNlIGlmIChxZGF0YS0+dmVyID09IFRNVV9WRVI5Mykgew0KPiArCQlpZiAo
dmFsICYgVFJJVFNSX1RQNSkNCj4gKwkJCSp0ZW1wID0gbWlsbGlfa2VsdmluX3RvX21pbGxpY2Vs
c2l1cygodmFsICYgR0VOTUFTSyg4LCAwKSkgKg0KPiBNSUxMSURFR1JFRV9QRVJfREVHUkVFICsg
NTAwKTsNCj4gKwkJZWxzZQ0KPiArCQkJKnRlbXAgPSBrZWx2aW5fdG9fbWlsbGljZWxzaXVzKHZh
bCAmIEdFTk1BU0soOCwgMCkpOw0KPiArCX0gZWxzZSB7DQo+ICAJCSp0ZW1wID0ga2VsdmluX3Rv
X21pbGxpY2Vsc2l1cyh2YWwgJiBHRU5NQVNLKDgsIDApKTsNCj4gKwl9DQo+IA0KPiAgCXJldHVy
biAwOw0KPiAgfQ0KPiBAQCAtMjA3LDYgKzIxNiwzMyBAQCBzdGF0aWMgaW50IHFvcmlxX3RtdV9j
YWxpYnJhdGlvbihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0K
PiArc3RhdGljIGludCBpbXg5M190bXVfY2FsaWJyYXRpb24oc3RydWN0IGRldmljZSAqZGV2LA0K
PiArCQkJCSBzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGEpDQo+ICt7DQo+ICsJY29uc3QgdTMy
ICpjYWxpYnJhdGlvbiA9IE5VTEw7DQo+ICsJdTMyIGNhbF9wdCA9IDA7DQo+ICsJdTMyIHZhbCA9
IDA7DQo+ICsJdW5zaWduZWQgaW50IGxlbiA9IDA7DQo+ICsJdW5zaWduZWQgaW50IGkgPSAwOw0K
PiArDQo+ICsJY2FsaWJyYXRpb24gPSBvZl9nZXRfcHJvcGVydHkoZGV2LT5vZl9ub2RlLCAiZnNs
LHRtdS1jYWxpYnJhdGlvbiIsICZsZW4pOw0KPiArCWlmIChjYWxpYnJhdGlvbiA9PSBOVUxMIHx8
IGxlbiAvIDggPiAxNiB8fCBsZW4gJSA4KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiaW52YWxpZCB0
bXUgY2FsaWJyYXRpb25cbiIpOw0KPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gKwl9DQo+ICsNCj4g
Kwlmb3IgKGkgPSAwOyBpIDwgbGVuOyBpICs9IDB4OCwgY2FsaWJyYXRpb24gKz0gMikgew0KPiAr
CQljYWxfcHQgPSBpIC8gODsNCj4gKwkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19U
VENGR1IsIGNhbF9wdCk7DQo+ICsJCXZhbCA9IG9mX3JlYWRfbnVtYmVyKGNhbGlicmF0aW9uLCAx
KTsNCj4gKwkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19UU0NGR1IsIHZhbCk7DQo+
ICsJCXZhbCA9IG9mX3JlYWRfbnVtYmVyKGNhbGlicmF0aW9uICsgMSwgMSk7DQo+ICsJCXJlZ21h
cF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR1NfVFRSbkNSKGNhbF9wdCksIHZhbCk7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIHFvcmlxX3RtdV9p
bml0X2RldmljZShzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGEpICB7DQo+ICAJaW50IGk7DQo+
IEBAIC0yMTgsNiArMjU0LDExIEBAIHN0YXRpYyB2b2lkIHFvcmlxX3RtdV9pbml0X2RldmljZShz
dHJ1Y3QNCj4gcW9yaXFfdG11X2RhdGEgKmRhdGEpDQo+IA0KPiAgCWlmIChkYXRhLT52ZXIgPT0g
VE1VX1ZFUjEpIHsNCj4gIAkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19UTVRNSVIs
IFRNVE1JUl9ERUZBVUxUKTsNCj4gKwl9IGVsc2UgaWYgKGRhdGEtPnZlciA9PSBUTVVfVkVSOTMp
IHsNCj4gKwkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19WMl9UTVRNSVIsDQo+IFRN
VE1JUl9ERUZBVUxUKTsNCj4gKwkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgUkVHU19WMl9U
RVVNUigwKSwgVEVVTVIwX1YyMSk7DQo+ICsJCWZvciAoaSA9IDA7IGkgPCBTSVRFU19NQVg7IGkr
KykNCj4gKwkJCXJlZ21hcF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR1NfVjJfVE1TQVIoaSksIFRN
U0FSQV9WMik7DQo+ICAJfSBlbHNlIHsNCj4gIAkJcmVnbWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwg
UkVHU19WMl9UTVRNSVIsDQo+IFRNVE1JUl9ERUZBVUxUKTsNCj4gIAkJcmVnbWFwX3dyaXRlKGRh
dGEtPnJlZ21hcCwgUkVHU19WMl9URVVNUigwKSwgVEVVTVIwX1YyKTsNCj4gQEAgLTIzMSw3ICsy
NzIsNyBAQCBzdGF0aWMgdm9pZCBxb3JpcV90bXVfaW5pdF9kZXZpY2Uoc3RydWN0DQo+IHFvcmlx
X3RtdV9kYXRhICpkYXRhKQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX3Jhbmdl
IHFvcmlxX3llc19yYW5nZXNbXSA9IHsNCj4gIAlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfVE1SLCBS
RUdTX1RTQ0ZHUiksDQo+IC0JcmVnbWFwX3JlZ19yYW5nZShSRUdTX1RUUm5DUigwKSwgUkVHU19U
VFJuQ1IoMykpLA0KPiArCXJlZ21hcF9yZWdfcmFuZ2UoUkVHU19UVFJuQ1IoMCksIFJFR1NfVFRS
bkNSKDE1KSksDQo+ICAJcmVnbWFwX3JlZ19yYW5nZShSRUdTX1YyX1RFVU1SKDApLCBSRUdTX1Yy
X1RFVU1SKDIpKSwNCj4gIAlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfVjJfVE1TQVIoMCksIFJFR1Nf
VjJfVE1TQVIoMTUpKSwNCj4gIAlyZWdtYXBfcmVnX3JhbmdlKFJFR1NfSVBCUlIoMCksIFJFR1Nf
SVBCUlIoMSkpLCBAQCAtMzE5LDkgKzM2MCwxNQ0KPiBAQCBzdGF0aWMgaW50IHFvcmlxX3RtdV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCX0NCj4gIAlkYXRhLT52ZXIg
PSAodmVyID4+IDgpICYgMHhmZjsNCj4gDQo+ICsJaWYgKG9mX2ZpbmRfY29tcGF0aWJsZV9ub2Rl
KE5VTEwsIE5VTEwsICJmc2wsaW14OTMtdG11IikpDQo+ICsJCWRhdGEtPnZlciA9IFRNVV9WRVI5
MzsNCj4gKw0KPiAgCXFvcmlxX3RtdV9pbml0X2RldmljZShkYXRhKTsJLyogVE1VIGluaXRpYWxp
emF0aW9uICovDQo+IA0KPiAtCXJldCA9IHFvcmlxX3RtdV9jYWxpYnJhdGlvbihkZXYsIGRhdGEp
OwkvKiBUTVUgY2FsaWJyYXRpb24gKi8NCj4gKwlpZiAoZGF0YS0+dmVyID09IFRNVV9WRVI5MykN
Cj4gKwkJcmV0ID0gaW14OTNfdG11X2NhbGlicmF0aW9uKGRldiwgZGF0YSk7DQo+ICsJZWxzZQ0K
PiArCQlyZXQgPSBxb3JpcV90bXVfY2FsaWJyYXRpb24oZGV2LCBkYXRhKTsJLyogVE1VIGNhbGli
cmF0aW9uICovDQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiBAQCAt
MzY5LDYgKzQxNiw3IEBAIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhxb3JpcV90bXVfcG1fb3Bz
LA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcW9yaXFfdG11X21hdGNoW10g
PSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wscW9yaXEtdG11IiwgfSwNCj4gIAl7IC5jb21w
YXRpYmxlID0gImZzbCxpbXg4bXEtdG11IiwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg5My10bXUiLCB9LA0KPiAgCXt9LA0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IHFvcmlxX3RtdV9tYXRjaCk7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwNCg==
