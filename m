Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E656D414A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjDCJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:51:54 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981512041;
        Mon,  3 Apr 2023 02:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLjQFj2XnHOu8RZOk7MOYpo7ixvksMMw+IxJWd1j8WdoYsSA2QYQYDTp7azH9Kfc/7HYaUgVV8X8ShjZ0A7RxTLGKfonlMWgJCZxHkS49urMDscsPpavvWZblVO5PyIkOvCa0H9osdQCKoxwwVaal+vbpcbvUovyVtIKx13YFd8PwWSsv9bLJxIu7RC888YwqiBOpp3McismFmZAX/CWj9zl+hNt9yRV8YMkbb03POAHQHLyhEaLZt1goE+MzveUBp0G9O+umwDUZlRY/F0RnyVbXY+sLl5u9glW7parsYYHWWVDgpLTSromqsvGmN9VPADkKOIN7yx70EknhnfOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R4mUyeMwZMcAEMyUYp0mDC6q1e99ogOPSNzMY8U4sQ=;
 b=XPxVmojLeUwAGZ955TOopSXzjFWWyZdpe9NxmGZ4pKFP8FefvMUrbZBVzxjgcO3FyoL3NjT0lS6zMV46XNLP9c5jV2Sp0v4HR1Mras41/PcpU6P5OCTcmVGtFC0gD5j0QDEK2hnuyIX0rKIs6a5QedtfUFRGHxISUTZtiS4lQ1nfI5JPJHvixWxN2y+WVzhZLh3XG8d0CeCtQ2QSE6im8wAzKiPgBT/6ymcxjeoCjFP5U2BaUF2DSZyQt+RTakwDJ14baYrssH4s14haRfic0/iGBG1yeP4CqX59dV6WySF74Yat473SFDcR38ABQhJCa55fQ4hMfe2SSQMlVhcJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R4mUyeMwZMcAEMyUYp0mDC6q1e99ogOPSNzMY8U4sQ=;
 b=UxILv6z0UDa8kK8lCghUljJd8IFalkl9YpYF6nSkBrj7ftx3fVQCU8T/woMcn5hn5awjLKjuXxktdVaknQKO5qqLkPya4l0jg5uOL6USsCD8l1/zpkIESXxGpI9nLLrIVvqO1gx4eiL5wSr+VFGKm079UTXr586Mh0WjD8eZaXk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:50:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:50:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 6/7] dt-binding: clock: imx93: add NIC, A55 and ARM PLL
 CLK
Thread-Topic: [PATCH V2 6/7] dt-binding: clock: imx93: add NIC, A55 and ARM
 PLL CLK
Thread-Index: AQHZZfsbXTNf5q63tEi1ZKgXG4oYXa8ZVYmAgAABslA=
Date:   Mon, 3 Apr 2023 09:50:23 +0000
Message-ID: <DU0PR04MB94177F4910F7C47B2CCE867588929@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
 <20230403071309.3113513-7-peng.fan@oss.nxp.com>
 <14d7b3ab-5ac6-61dc-a538-62993edadae6@linaro.org>
In-Reply-To: <14d7b3ab-5ac6-61dc-a538-62993edadae6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8877:EE_
x-ms-office365-filtering-correlation-id: 7c1ceff8-7ccf-4708-3976-08db3428d873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfR5mizKV3xMfCC+OIOxh+nwP7C7DRZ50pPUV4zFvrsGQsbLI8BJhXw2G1gjrhl2Liy93mlK2fnOdd0fJehsYbo2p5G8dDEwgY3GtvwjxwJWyubuCbIn5ZALUbhsVaJnaUxpIqfqoR/fZsXvznd5KcE6ofJY+s9tRVgmp+FWNj3HvM/AZtcpSY7jWZxldcx0z5IyFyyHgaCJmNeVOhd0+q2RDlF0KEhovgBZF+zJ2gPX4Yoc7wonIkB+OW4qeZtWSUf40d3w4bBY7iqDLb5pF3ke+gCGazqVqcQtIDRcYeSlQSbQJ2OXNF8hsD3VpdO/81ZJqO0Pa5bx+yGpFTr0LbFBqcbSNSzwRncSXG7I7XoVt+RzCpPB3tLlWJS10FafkJ0KuRIDXNu1Egna1ki3W6OFpbhyknK7r9SpbF8rItkXcd8YLU6IpmXnFetWvnz7IZjOXTiujaWNgpl/chbPwv7Klwhwg1nD0dvXyHs3BwhgHCcWExL6ecZ2xv33C9MEDqys+Al0rvVWAzkxBWoHkkC/Go+7la/IiZtK821l/yRExnhu2ZYr1zMwqkS/zMqt7oV47w66/vDe+v5SX0IcXTSlDst0lUYhPLpgPojKAQiM4JQxnuf7G15uft/F4Q0Xpj74wCbgcmKpZqU9QhnlCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(55016003)(8676002)(4326008)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(478600001)(316002)(110136005)(54906003)(52536014)(8936002)(4744005)(44832011)(921005)(7416002)(41300700001)(38100700002)(122000001)(5660300002)(53546011)(186003)(83380400001)(7696005)(71200400001)(6506007)(26005)(9686003)(86362001)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWs1c3Z2N3I3ZzYzcHRkMEFkdHdndUlBOUErQlNzR2c2dURMKzMzWWZ2ZTBv?=
 =?utf-8?B?d2J0bkdnVlBRWDZtMEIxYTFmWXhRSjlWTmZtYlh2TmVoM281N3F0VmVEOU52?=
 =?utf-8?B?WkZCWEVsTHg2UnFudjFyTUs1My9hWlVNY1YwQkpQVDRmQjJianl3SlVqd3ZJ?=
 =?utf-8?B?b2FMNVNSWHZZT0ppVDU5R3JERFRtbXlKUk5ZVGY3SGZhQlhrU3lBSktHelNM?=
 =?utf-8?B?UXZKaFNSSHRPR1RsY1V3aVFzTWovc3ZvN1hYWnVVS1pIdGZMMFY5Q0xKZUlS?=
 =?utf-8?B?eUQrV05tVmZITEtCRSs5SmZ6cWhOSHp2MUtsSlhDOGxVNWttQS9LZ1p3aHZH?=
 =?utf-8?B?TmxWbW1sVlh0QloyL2J1NG82NFBLVEZJemNHbkE5dmQ0Y1pxN2puc20rdTVV?=
 =?utf-8?B?SmQySG04M2hPVXUyaW9XOTZmcHBydFhTU2ZLOWoyZ3RyOHp6SllhamsxTVFO?=
 =?utf-8?B?bjBRM28vKzdISTJHTCtyZWp1QkhqSzRRWkJubEczVHFoM21uRHJJTENNbEtC?=
 =?utf-8?B?Nk5sSzQvcS9qWldnbEhUTGZ0WG9EZHM1b2J1QmhzQmg3SE4rTm9HOCtpcTB1?=
 =?utf-8?B?OFN3UXN0NkZXeVdDekdyK2lNZFdtbHRCc3FVQlhMZnZTbVJrVUwwb1JsWWMz?=
 =?utf-8?B?UTBDZkdzeTg0Z0hSUnpOOUcvajFHd29Eai9rOWpwSGxSamFtVE5pVHhKb294?=
 =?utf-8?B?YjN1Q01pK1c1aGlBZFhDVkpob3V0YnB4a3JQNkt1djlJak1ET2s0RjhiVEox?=
 =?utf-8?B?NExGNW56SGw1N21KWE9nVldMeEN5dTRTSHFwamxabzhER1hUaVBRbVZIYk1G?=
 =?utf-8?B?SVJJZC9wMFZaSEVXRXVsWmJnVGQ1dk5NY1B2M1dOdUxpbUl2Z1VBT2tyMWdD?=
 =?utf-8?B?TXJVVXBOTmNNM2srYlIvZW92VVF2MTk5SXVFNDF1WTZwQVBSeDZKaVVSaVhy?=
 =?utf-8?B?NU9HK252dWVwR01ENEZhck5OOTZxNXpYSnJYOWJkRmRWbVJkNnJQY2k5Sjkv?=
 =?utf-8?B?Y1hna0ZwV0xraDk0VDFEVFBnUFlJTndacXB1TUE2Q21mY1NBU1QxZHB4NHNp?=
 =?utf-8?B?WjJDL0pKQmU2TVY3bEpiN3RkK3R0dmJtM21EeG1jMGVSSVNmb0pOWXpnSHVx?=
 =?utf-8?B?SnFhSXBCWFZ1a093YVh0QTdvSDVEdERHMXJCcHREd2YzS2hpeDQzUHVVelMw?=
 =?utf-8?B?WHhKSFljYVR5bWU4S3BDdGRhVnpjSEFLTFFlakhhanZxV0h4MXdRMkd0NVlx?=
 =?utf-8?B?c2ErL2xmTXVkUUZ1SUxHTkRvbFZEVC9acWZsYWtpTDVpbUxUb0Y4L1RJeXlB?=
 =?utf-8?B?U205YVJ6UWJrZjhneFhGYzVyOEh3aTdlRFpnbHFCTmkvSE5LSnQ5ZjFINXUz?=
 =?utf-8?B?ZE9KaUhBc1g3ci9UcG9XN0ZGaHFZU0VqZFF1MUsreEYrMlA2TmkvR0pVSkRu?=
 =?utf-8?B?c0hjNkJYcEsvMUdCKy9CTU9lWUN2TmordE1ublg4ZnNMZFVWWkZqRWpzUVNn?=
 =?utf-8?B?OTZRZzFnWExhbEhJWXFzWjZ6bkdBa3k5cFRIUlJaOGluUEpuWllZWXFJQTh1?=
 =?utf-8?B?ZnBEaVMweGlvczVnYWlsdDZsZzg2RlJ0dGFncnVuWVorcEJ0ZjBVbTFmWWpt?=
 =?utf-8?B?aE5RSGdVa3lzMXE5cU1VZFNmL2xad0dOd1FVcFk3UXpEMWQ1a2cyZmFVZllW?=
 =?utf-8?B?eklUR0RrV01haitrV3NaWEMxdG90c2lnWVp6a3lLcXpMK0F1dFNlaXUvSW5X?=
 =?utf-8?B?d0lNVzhhVnlYVmpTVHhTblAwZ1paZWYvQnhieGlTYmFnZ29xVXp1aHlUQlA0?=
 =?utf-8?B?dUFESjl3UnVTaGJoOFlQb3JnZUZrL2xOcFBoRUFYVzdIb1gzTjlDQVlqZUlO?=
 =?utf-8?B?a0JkSFZQK2FqUlcyZkNxbUZWRlN1WFNiblUxNitmRS8wdldqOTdCK1E5b0Rz?=
 =?utf-8?B?R1hKTFg1ME85UzVmMTdBRFIycDc1bVAxWUVvc091TzRxRGI5QlVCWkVrOE9w?=
 =?utf-8?B?S0hNK0cvQVlsK0xXbFk1QisxUW1wYzV2UTEvT1RyUlRDd0lhUzNwRlM1UDRp?=
 =?utf-8?B?Z0pJK1FocWFQWTJTemJhU1NpbU5TeWNBNWdLWE9zTHZqVjNVWGJJVFMvY0JR?=
 =?utf-8?Q?eN/I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1ceff8-7ccf-4708-3976-08db3428d873
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:50:23.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTBkAqQshxAFqZCTq00fmfSWHRECsQaugMYzdiTWqsSNKPd5uHHZ89LZmmBTdTsY/2O2n0ar3M3/fmuUHigr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDYvN10gZHQtYmluZGluZzogY2xvY2s6IGlteDkzOiBh
ZGQgTklDLCBBNTUgYW5kIEFSTQ0KPiBQTEwgQ0xLDQo+IA0KPiBPbiAwMy8wNC8yMDIzIDA5OjEz
LCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPg0KPiA+IEFkZCBpLk1YOTMgTklDLCBBNTUgYW5kIEFSTSBQTEwgQ0xLLg0KPiA+
DQo+IA0KPiBGaXggc3ViamVjdCBpbiBhbGwgeW91ciBwYXRjaHNldHMuDQoNCk15IGJhZCwgYWxy
ZWFkeSBmaXhlZCBhbmQgcG9zdGVkIG5ldyB2ZXJzaW9uIHBhdGNoZXMuDQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
