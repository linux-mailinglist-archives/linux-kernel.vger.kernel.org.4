Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C46803B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjA3CEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3CD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:03:58 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91557188;
        Sun, 29 Jan 2023 18:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB11l3OBxRcFoSXBXaCSEue/tbxtdgpK9sKNBcINT7hPxB54HpSpC5OW0CzxIZ7GkqC3v9eg2Y78H2QWTdDuR27MRIpZjpgps3GB1IbjHh+lIpg9TBnDSfLjy4lnyQPfSEudMfwQ8ILhaOP4cB06R8LoS9IJsdWsUnVn8Ocz9uNOw8/pkHdVPcZnnh6K1EGLM0nZzl0zFHHigumwn/FSofTimFoAcqh67cG+swLOoVL08d/VDtY/zQjvZjgsjPg1XgkshYZOpU6GdwADAiPPXLypoCJRHI4RB7afMg5/dCKlkulDB8z0Oho3VOzjq7OThvbiu746zgO/0eSC2eu+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5ZQaOWlsf0pWABz7tZAZBr/13Og7l/IKeDDS8SCwZA=;
 b=n/IjP8xcQUTgEYm/BK2IYa+cc2V1U2NrmIkPV7MHndbdz7vsySVjsiffE20Q2DJgX6bLl81gVJWPJNfHbAhlDFjQMyOZ75SRLQGgu3zpVgLvTnbUMj4KEF70FME/VoSAh/Q+yS93wNLpF1XD76Xdk61qVH6/rBc7frFAfVcfxPE3ep9FSIs11vQ1ra4MULpxu5tnjlvhjdM8smuHXKkf9QKYyGF+dsR37kRyL6vX3P3MET0To9lBuy+Au8I6OXdHyKEZR65KVLwVqXvR/KAkIUXAEodrGuXvFxjrG5Iymk0RNAp6MISrwIOtDd6WVVuyUz3JBCULrsP3gzah04hlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5ZQaOWlsf0pWABz7tZAZBr/13Og7l/IKeDDS8SCwZA=;
 b=g20xBr6RppmQqMHjcUiHRBbfvE+HXbgkeilEkaBtayjbqO9XfNOfar9x6GDKpKt2OUcRWmUzqKR99hr5/dG5FR/zt49WwWpNjZhfV6d2FWclDXN47PAU419JMIvLM6PW3ICz6Zj+Uyhy1oK3NFZrvIi7OAWxmdLxYhsBnbFbUCY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:03:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:03:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 3/6] arm64: dts: Add i.MX8MQ PCIe EP support
Thread-Topic: [PATCH v6 3/6] arm64: dts: Add i.MX8MQ PCIe EP support
Thread-Index: AQHZLJMhN+ESi2AnW06ZAN9wRf9+n66m86sAgA9RCyA=
Date:   Mon, 30 Jan 2023 02:03:55 +0000
Message-ID: <AS8PR04MB867692DEEF58A8B8A00FC0368CD39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-4-git-send-email-hongxing.zhu@nxp.com>
 <e2f5fb10-8091-5e65-9271-11b1b8380ffa@linaro.org>
In-Reply-To: <e2f5fb10-8091-5e65-9271-11b1b8380ffa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: 21039980-5a62-4831-f123-08db02663df5
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFBLl5k1Q9vWI7S7WqtPexzka3uwcjVewcZ/0qf6PsY+85oqhSXIbzGNAPyJzpjhNRjT9znY7D6hQCmBRMIEZKRGWq0BpeFKPJNUFI8eb3IwO/1/5CE5yEwr1+qSyZqsKawwwO/j+1PFS4AEFMa+uo2SUQ6X4bF5YCJMVV0TMUMMPe2OAQwCo+McFoQzJMTq3ToxLbvX9AOd3o7NOjeb0O8K8QxL9qDj3DcujUyq/b6ZLOW11FK4Uz1g32/seUdFYYdR40EffT/sa0ite3m0x4lckbMAuVqxVY3shdcCR9hVkt6EjuQLXB7F0p6m2AUdcXOMajzY8MiF8am4D8iFoqIragM8levLvTnu/o68t2dgEgu4XO+YN+fXPthfinVQvMl3fqp5oeEGMkqs3cPzHvLA5ExHJNRweolOATZPeYI87p0pHzlbatpoqJ9uFXVpRO4hwwMiqXvpn3yPfhhFRQwqUakpqPhotSBk1EJu2v0gFDJtKMEDcUtiXW6e8KB3MmrWTV1vqjzgbPaF1Kb4PQt+mR4rZ39RL3ygVdVVwTOrxFqR+DkKRdifYRt8pkk2QxqUbAFlYEs5tuzEuxw+3i4QvmheJNuOjN/y07QNfFomUNPlJ1h6mvrb5Eplm23hHBH6rwl4mD7gx1OqtN6GXAbMVrCsFpXixmqz03xJTmNVtw0tgVLCthnG5aY/nnlPv8d0KfAj2G1NlwxTZN+Jgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(54906003)(316002)(110136005)(6636002)(7416002)(55016003)(33656002)(5660300002)(8676002)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(64756008)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(52536014)(53546011)(478600001)(6506007)(7696005)(44832011)(9686003)(26005)(186003)(38070700005)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJzVGN2RElzanJhd0ttTHlmZDZVQll6ZysrT2VFbFNFWVhWMStSZCtBb0k1?=
 =?utf-8?B?a21sdnBlRFpEV2xGZjFxdWZ2NmdqVlFpVGZmMmQ1ckh4dURIZkl5OUxYMDRF?=
 =?utf-8?B?Z3JlenJoZGRleDBtSWV2Z3pFeDk0MWJwOVZpTXRDREl4OU55R2NvQ0dkcExp?=
 =?utf-8?B?QXRCTkpsdkdOUXlDZUNXdDYycXFGbkgwemlMN1daY1BEUU9BMFFmTGVUcjRU?=
 =?utf-8?B?OC9mQit3M3lVK1VQN3dlM1YzbWE4ZjZycEJVSmh1bnBKRXl0cGduRWE3TGkz?=
 =?utf-8?B?MHFoRnE5VjhnY0pVdTdZRzdXaTd4eko5cVJKTkJHVy93Z2hYWDVOME5sZlhY?=
 =?utf-8?B?WU11RmF1Rjh4UEJVZ0pKcDZUY3RIV3A4UkR5cTQ4dzdjeUVpdXBSZ2tHbFJ1?=
 =?utf-8?B?bzl3WHhDUEs3KzVnY3pJTGZqTndmMnp2aFU5RGZRUkkvZ3FlREgzTEMraVZt?=
 =?utf-8?B?T1cyZVdZTXZja1gyMENXMjdPWmp4REx3NzNLcm5BcGJOVFNXQ2ZzL1ZFNGhz?=
 =?utf-8?B?M2NXOVlrVWQ5cjl4MHEvU1VDV2JCUWQzRHUvQlBjNTlEakt0eWRuQ2RKVFR1?=
 =?utf-8?B?ZjN2ZUhCUTI2T1hRUkRubHo2dWtiTG55MVBCZHVsQ21YaXRNV2p0U0dwb0Qr?=
 =?utf-8?B?QmtrcmZwWS9aTmV2QklUMG5lOSsrWTFROXorRG40bmF2U0NoOVV2S1VSbmxB?=
 =?utf-8?B?NGNhTThtN3RKdmQ4QXFRWWljeC9HUEszN2x0djF5a1ZscmFBVWpMRjlRYU0r?=
 =?utf-8?B?bFkzZVhzQk5YUkdIWVI1d0hsKzFyVkc2SGlCWENRVmFhVk9lQWxMM3hBd29N?=
 =?utf-8?B?K1oreEh5cEl2NlF1dEdmQ0E2VVQ0T2pjWTZsRFBWZ1JXMmM5VzkzTm9WZ2t2?=
 =?utf-8?B?a1NTbUVhTGxXV2tPTFVCeFFOSkZqaThrWVBpMkROM3NnUGJEeFUrekxuVlYx?=
 =?utf-8?B?RFZmSWYybTZGSUFEa0orRFdVRXUvM01mY3V6NTFUdTRxVWFtYUpDMzBRUTRP?=
 =?utf-8?B?d2NvUGkxcTRld3FxaDRrRzl3dE5aQTFVMEtUWGxmcWt4bWxzOEpsY2ZBRkox?=
 =?utf-8?B?RGRxdmhZYkVlcGFDaXJ4N1ZSblpTZnNwdkxEU2Q5UFZ6dklSWmRVT2FzRldk?=
 =?utf-8?B?U3kxWkhDSUVQbHloL01qOXpSYmJiV211VVlidHlLa01vYmhWWE1ZMTNDSHBu?=
 =?utf-8?B?MDM1S3ppak9seFg5RmlNajBjdE5RSEN2L2wrUTdiUElEYm5IR2pnQkJmYlhr?=
 =?utf-8?B?SlIzWUY4MnNsbGg3cFVNMkMwR0Y3OTRpd2JCMS8xLzh6QUtrUU5XclRpZktK?=
 =?utf-8?B?em9Dcmh0Y1RoZjVFRDdTeGNKbENUeG9QVVI0dHBVVXJuUHU5Q1h2L3A2RGNw?=
 =?utf-8?B?UE11bEJ3b3Nxc1lBdUFPbW5GMThuY0FQSzZoeDA1cTdCdzJNVFVJaUgrWVU1?=
 =?utf-8?B?UTVUOGtVa0pSQkFrSmZmcVFmWUduRnQ0Wm1ndytLNkVGZERXQzZ6bEJkc1F4?=
 =?utf-8?B?eFFCR3U1MHh2bzR3OXhjUXRGQlBnL2VUZHVNSzFzdkRJVEdQbjA5Q0NMa2lr?=
 =?utf-8?B?VWZ3SkJMTUFNdWZsZkk4T2dXOEFKamFYVlVGSVFuUkpxcUMvcUlNaWdrU1ZY?=
 =?utf-8?B?NEZxM2FPOFNRS05GTUxUUU9Qc2RTak9IVnNuZWtIcmVFcUZOZVFPbUtCRzhJ?=
 =?utf-8?B?cWhya3lWQU9PK3ZURW4rS1J1am1aLysrY01ZeXRFa2FtbDZFajRLanY3Qkwy?=
 =?utf-8?B?Yks2anpJV3hBYmh1Z3VLTVJNKzU3WHdybysvOEFpa0FUbmhKZmZ3dE9sVGJs?=
 =?utf-8?B?KzA5aWhaZVNZMHB6ZlpnM09YczZ5eUdWa0R0ZGY5RmZ1WEZNd1p3Z1lkUW01?=
 =?utf-8?B?K0l3M1ltMjhVOE9ZTHY4VUl3WnFRQm1NdExxVGQvK1AyOFBWY2VCalgrYTdP?=
 =?utf-8?B?N3ZidldQcC8rNU5NMU5GZHFXRnY2RE9ueER1NiswdTBmVFpWTjhRU3dCc1Jq?=
 =?utf-8?B?Rlppdk5FZjByNmRURmpXL2wydmNUakZtdkwyTEVBMzlZamFBSkhQTHJQdUFj?=
 =?utf-8?B?a3U1RzRmSE1WTS95N0o0aTdvOW54ZExiTHZveDF3c2dTc2d3K2JGU0NCZVFH?=
 =?utf-8?Q?EHW1oleb2cyT3LTzgc1bpyhDA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21039980-5a62-4831-f123-08db02663df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:03:55.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSnCcfpHaYfp+hqhXKmdVoVyoJdPC3YFP42a6Q+c2lz7ZlQFYB0E6xgzWtTAp6fXv4b5ezK44SCgL22U7ypl8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQx5pyIMjDm
l6UgMTY6MDkNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hh
d25ndW9Aa2VybmVsLm9yZzsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBtYXJleEBk
ZW54LmRlOyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47
IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+
IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMy82XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNUSBQQ0llIEVQIHN1cHBvcnQNCj4gDQo+IE9uIDIwLzAxLzIwMjMgMDY6
MjUsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCBpLk1YOE1RIFBDSWUgRVAgc3VwcG9ydC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0
c2kgfCAzMg0KPiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1xLmR0c2kNCj4gPiBpbmRleCA5OGZiYmE0Yzk5YTkuLmUxZmZiN2M5NTg2ZCAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ID4g
QEAgLTE2MDUsNiArMTYwNSwzOCBAQCBwY2llMTogcGNpZUAzM2MwMDAwMCB7DQo+ID4gIAkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICsJCXBjaWUxX2VwOiBwY2ll
X2VwQDMzYzAwMDAwIHsNCj4gDQo+IEVoLi4uDQpXb3VsZCByZXBsYWNlIHRoZSB1bmRlcnNjb3Jl
IGJ5IGh5cGhlbi4NClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
