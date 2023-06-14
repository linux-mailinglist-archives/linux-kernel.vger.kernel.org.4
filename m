Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290DE72F243
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFNB5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbjFNB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:57:00 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C50173E;
        Tue, 13 Jun 2023 18:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtI7y4Yt2TZccmpUZIMZ7vnlSxvf+luQSSiqx8WuoihDNH9qL6bQVbFZFRIoZcRsr69AeXJa9DELFq/zm+JUO7xciaM7fkuFfeqWsyxrbXm12w0b7L9qC1Icfcm3PFuJWSSjXBwRxgZZO2c8m896SzGyeMcRQwuJTnCrP3xwS18hiRymnFhAssHVytYtOSXhtTG9PNN+mGjg+G/Q/P7rkLXQAY+w5oEXWLqV2P5TKwH0q7+V7vNtAiHFzEyqmUw014+6t5wDgwRP704CSYySvgG8YPZzb8fQtJ6rzO2PhqZvYztvVRBjdlhSmoAXjd0PLPwTtXyJwYPrE12MuPXVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoFjPpe0H3C9YVGT9lgRE4FjkBaVqqdyeNEpzBBgfcA=;
 b=ZrJRdcQMXMmwU3VQYo+kFHrpkzdZ6VLSXUe+oN2BQJalf5hSJ+zidsRfAnx+f6c85z+pIpxp2LMjP9M4R4FvbpXPSqlzGt1Vx15YUR3w8Zeg96GJONQ4RogaRf43eZbKHXP44+Em4/XHsNQqJhCzfHdDMXSFUuo6BFALT3U0cX7i1JIYrIk6SskfY5kaP/J6JKPMHItm28IO3zzT7NsYm1kgatpJFwsl3WSgMJlOb0tpaGNIyV2kygwPjfWLaOFkyqaGrbF1wJRvK493yyn+DlTNMhFzWHNVaYhnwC6dyeAE2IWlfHVsysTEp2dje6h7y/Hct4ADc+z1fmhjhzGx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoFjPpe0H3C9YVGT9lgRE4FjkBaVqqdyeNEpzBBgfcA=;
 b=MAI39WRHIwYRQnkBmSsXy8z8UQCOReNJDp7XTd8l92KoOVFtry02MKUo/OQM9v+eLONaRTwhHZ2hp/SEhrrasvX9jYhCDMYWrlUvta+d7g9bTNAnjmLawKPS/pArcrhJvIcyKPEPNGsGdK0eGRzVV9Z+5oexU0njVl9Ns7X3rIc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9893.eurprd04.prod.outlook.com (2603:10a6:20b:653::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 01:56:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%6]) with mapi id 15.20.6455.039; Wed, 14 Jun 2023
 01:56:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Zhanhao Hu <zero12113@hust.edu.cn>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH] clk: imx93: Fix an error code assignment in
 imx93_clocks_probe()
Thread-Topic: [PATCH] clk: imx93: Fix an error code assignment in
 imx93_clocks_probe()
Thread-Index: AQHZnjNtr4qALX2V+0mFvsVFvc8Mfa+JinSg
Date:   Wed, 14 Jun 2023 01:56:54 +0000
Message-ID: <DU0PR04MB94174EB38D6754AC5E6B4F74885AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
 <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
In-Reply-To: <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9893:EE_
x-ms-office365-filtering-correlation-id: ed79237b-8431-46e3-c148-08db6c7aa0ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCg/6VR9u2Q40Dd4YvQ75WXTLf3TP0vOICs6nl9AJBh4UQE6i33Kptkwv9GtWmBYYOKGApkTqFdbVYcT+Q5GLEMWl+bIczAygP+7xuUAGrLqrkY8UPQtXpRGDjbbR3/Ngi5P8EJ+d3ZJYBC1sTv6+FIdpYM2paM8pk1oAm5NBGxGFreNETLI+tUU8ML4N1a83EvvDpMxP+0lQm3WRTvUp4Ib69DhbdcssY+7GV8zuL4fw/kVQq9VqqYAvfkVxNcEZdhrcvFRDhaFXo6kXS/lqiV2YaiGJ9HnlsLxU2i3AX+g2KUiArB8yAmUA8rsf/d/c8yBxsJI7QYRWu03Z458cWLsx62aYq+X7RFkWlQ9DsrzUPyA/vM4BW/fn4pSg5edOEL6wo16YjIohsb5sF1zoDcCycmzpfEb1oHz5gGjCiY6R/Xu9i2b5CNe87uwE8eRCkUgwkwU3dUOXe9OfpxYwUmHH3w0exgrvlpH/epJdSjDDqvoIq9gGoRW6rYGhgVl28iMRBT6XhKyA118wg0Ccpv4XnPXMB8unAlDif20t2fv4U3ypmN6dMHAqSXVBqKEyZfjeDn210sRm9E2/+GMzhMHHetEn2kkhM2sHxT4GyO0RooF10Ed8qRdIFoOOFF2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(8676002)(66476007)(66946007)(66556008)(76116006)(54906003)(478600001)(110136005)(5660300002)(8936002)(52536014)(66446008)(64756008)(71200400001)(4326008)(316002)(41300700001)(7696005)(55016003)(38100700002)(921005)(83380400001)(186003)(6506007)(7416002)(86362001)(2906002)(44832011)(38070700005)(26005)(122000001)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZxb1o4cmp3S0dsZUJ1Z3BMUXlaby9hQ3IwT2tSbVBtRkFMMW9EdHlBcEVZ?=
 =?utf-8?B?YXM5TGVXS2E3Qnl0eWZwTmNaM2FYc0RIRW5OaFVrb0svQ04vWC94bWtiVU10?=
 =?utf-8?B?Y3RSTkdOYzFURzdtd29yMTFJaUJqYjVTdTZ5NUt6bjN3UE8xNzduMTJESGhB?=
 =?utf-8?B?QWtlU0VZQk9YV3FlV2Y5czRLS09kU1I1U2Z4OHJxSU1qQkorZmVtRlFUanhM?=
 =?utf-8?B?aFNhR2R3ODYzbDhEMXJCSFdTUndoT2JwWVNpYmNhNlNYODdNMjZaS1A2US9W?=
 =?utf-8?B?Y01aSHM0ajd5R0RpZ094M2wrNyt5RXM1L1V5T0tTblQ5Rk1BSDdZU1daTS9J?=
 =?utf-8?B?VFV2QUxEaHoxMmQrbVU0SnNYdFZWSnU0aktQYlgzbDI4WmxmRjZ4V1hBZnZC?=
 =?utf-8?B?NVB6aSswZ3ljT1k1YzhQbUVNUE9BVW9hM1FkUEVlVkEwZWZmclNmcVEzZlo2?=
 =?utf-8?B?QUpHc2xqajNrdENDMWRGSUIycHpOZzE1Qjltd2tBRFJDS3VZa0lET3RNaE1y?=
 =?utf-8?B?MCtqTGlWQ1F4ZWN5Rm9mVGcrZlFWeU11dm5LTTZwYnpxbXhJM3lKUkZreW5h?=
 =?utf-8?B?T1BUY1hWc2JjVjBBNHo2bDJpcTcyblBiaFRPMkZCdjF3cFpTT2ljMUN1R0hh?=
 =?utf-8?B?WmY4eStjZ25qeUo2OFFmZ1MvZVhHQ0U3bkxuMVZzeUJJOENUOVhpYjdwYXBX?=
 =?utf-8?B?Wm1XSkFKV0VMTEszN3BKNkVUSjcvY3lYb0tOMER4WkJhVXo2Y2I5ZmFvRy8v?=
 =?utf-8?B?eWY4NzZ0VWoyWXlET2swNDY0ZTZyZmhKTUE4eVJ6NzBUWUJPUjVVVVJZbVhL?=
 =?utf-8?B?YWYybEpoeGx1bm9ueWIwK1MrWDRJTjhGVEl0VW4zeFBscHpQMkRRNjZSWlJL?=
 =?utf-8?B?WERqQjBobkVpYkxlWkt5SWRMd2xRM3RVNllVMmwwZ2oxby85T01EZ3I3WUdV?=
 =?utf-8?B?bSt2YXl4S1AzWHdHSHdtNWJEVWFKTUk1blZXVWQvUm51Mldnd3dYR2ZKZTVF?=
 =?utf-8?B?RllOWFAyWTJUOGgvM29BTjJsLzlaR3V5U2hZYzh5b2s3ZGVQQTU3aG1CMVVT?=
 =?utf-8?B?Um5kVHVyVEhIR2w1VW5DbUZXRjdzSHMxczkyZENUVk9KWlhjWHY2ajRsLzhF?=
 =?utf-8?B?bkh6cE1MZllYcVUrQUZ6Mms5eHRHOUZJY0taVUROd0thKzgzbyttako2aits?=
 =?utf-8?B?ZXJuSnY0ZURnSjhQTjU3RXcxWHl3djhNc29yd2lzRHNSUWM3QlNTNjJ4cXdJ?=
 =?utf-8?B?ODlOUkVoNXZiWkQ4bHdJM3NlaWNORzA0cDdCZXgwUW5WaGNaWW00ejFVelp6?=
 =?utf-8?B?ZFB4Rko2L05XajV1NkhlQjdYc0N0NTFyMVpVcTVWb3pXZlFzR1VRSEU4SVRQ?=
 =?utf-8?B?b2kwSmJlemdwOTVUVkEwR25zenowUHM0WG43dkFNVnNkaFZlQ2c4UHh2blI2?=
 =?utf-8?B?Qy9lZSs1d2RnbUptVjhCQ3I4MHZzQkJLYVFQWlBPSEFSY0IwQ2RHLzYxSUJp?=
 =?utf-8?B?TC9uLzNJZWRIWlo3R2NCOGFqTTFhb3ZSN015bDBUS3RtL3dNKy9jb3YxYkNr?=
 =?utf-8?B?a3FQeWh3ZnlmRmpXNk1Xb0FmUXRtR1NpVHA4RnlpZmp4MWJheVBwRVRBM1gv?=
 =?utf-8?B?ekgvSEg3V0FUTG02TjkvRkZNR0JGVXZjUllCM1FnbGdIU0Nlc2Q2cE8xTlRj?=
 =?utf-8?B?RkNXeUJCSVVlMzY0MzJOMjh0dmx4WTFtazRFRFB5SmYxcUx6Z2Ftc2dyWjRR?=
 =?utf-8?B?eEg1dWR2NzlCeFg3ZHJqa3Iyd2pZMnZRazJ5RHYyNEJla2R2eVRkWTBGcDY1?=
 =?utf-8?B?SzBGc01MZ2tJb1pkc2YxVUVBa0dQN21oaStnckZCSTZEZXlSTFB3bElMWCtZ?=
 =?utf-8?B?WTZ0bFM2K2ZLY1I4WHlmcXZtYnNrdEJYVUV4ZTQxTnpxYVNpTUlVeFVEOWVn?=
 =?utf-8?B?MnNOeVp4M3JWY0p2ZUpHcUZ3bExMMVlZQ3BtUldwSDduV0QrUDE4allOcldp?=
 =?utf-8?B?YzMwSmI5cVdrWFZ1NXhzVVZKcnRCK003SktNRTVXaFczc3JkT3RXUjlkMHF6?=
 =?utf-8?B?eWd6WDlSNXlhbTl0UGdpb1o5NzE4am9DT0dML24wWVNUeml6V1k1Y0ZvaG1t?=
 =?utf-8?Q?YtOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79237b-8431-46e3-c148-08db6c7aa0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 01:56:54.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71sWJHH4lBOQUi2n5vuZwyycKakNABTgLkohNfseX5aKJgKrSKjveX7CoqQlRxvqEPe9m4XAMpGelLDWs8DZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0hdIGNsazogaW14OTM6IEZpeCBhbiBlcnJvciBjb2RlIGFzc2lnbm1l
bnQgaW4NCj4gaW14OTNfY2xvY2tzX3Byb2JlKCkNCj4gDQo+IEZyb206IE1hcmt1cyBFbGZyaW5n
IDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gRGF0ZTogVHVlLCAxMyBKdW4gMjAy
MyAyMTo1MDo1MCArMDIwMA0KPiANCj4gVGhlIHZhcmlhYmxlIOKAnGJhc2XigJ0gd2FzIHBhc3Nl
ZCB0byBhIGNhbGwgb2YgdGhlIGZ1bmN0aW9uIOKAnFBUUl9FUlLigJ0NCj4gaW4gdGhlIGltcGxl
bWVudGF0aW9uIG9mIHRoZSBmdW5jdGlvbiDigJxpbXg5M19jbG9ja3NfcHJvYmXigJ0uDQo+IFVu
Zm9ydHVuYXRlbHksIHRoZSB2YXJpYWJsZSB3YXMgbm90IGFzc2lnbmVkIHRvIGFuIGVycm9yIHBv
aW50ZXIgYmVmb3JlIHRoaXMNCj4gaWYgYnJhbmNoLg0KPiBUaHVzIHVzZSB0aGUgdmFyaWFibGUg
4oCcYW5hdG9wX2Jhc2XigJ0gZm9yIGFuIGVycm9yIGNvZGUgYXNzaWdubWVudCBpbnN0ZWFkLg0K
PiANCj4gRml4ZXM6IGUwMmJhMTFiNDU3NiAoImNsazogaW14OTM6IGZpeCBtZW1vcnkgbGVhayBh
bmQgbWlzc2luZyB1bndpbmQgZ290bw0KPiBpbiBpbXg5M19jbG9ja3NfcHJvYmUiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+
DQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5My5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5My5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5
My5jIGluZGV4DQo+IGI2YzdjMjcyNTkwNi4uNDRmNDM1MTAzYzY1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDkzLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg5My5jDQo+IEBAIC0yOTEsNyArMjkxLDcgQEAgc3RhdGljIGludCBpbXg5M19jbG9ja3NfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlhbmF0b3BfYmFzZSA9IGRl
dm1fb2ZfaW9tYXAoZGV2LCBucCwgMCwgTlVMTCk7DQo+ICAJb2Zfbm9kZV9wdXQobnApOw0KPiAg
CWlmIChXQVJOX09OKElTX0VSUihhbmF0b3BfYmFzZSkpKSB7DQo+IC0JCXJldCA9IFBUUl9FUlIo
YmFzZSk7DQo+ICsJCXJldCA9IFBUUl9FUlIoYW5hdG9wX2Jhc2UpOw0KPiAgCQlnb3RvIHVucmVn
aXN0ZXJfaHdzOw0KPiAgCX0NClJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gDQo+IC0tDQo+IDIuNDEuMA0KDQo=
