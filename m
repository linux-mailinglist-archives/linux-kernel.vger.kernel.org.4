Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1E62263E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKIJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKIJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:06:21 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A420349;
        Wed,  9 Nov 2022 01:06:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m82q0YIlp44cZPPvPS5SI6l+QjXQmA+4Chm4Bz75L1ubFX+gS6oM3I1cYmtF9bCMHHslvw+bOwJfhh2dw+GEDtuzM2iwqXqx7wWgKzzmowD5QsDFHG5W8bSd3k3ZJM2Gxxvp/29tl3vuvhyXkbgGf88Yqa6zb6PGc7us5zfoUEAW0LSD5Z0irzKydQhQGUrG3xpw79hQwDDL8b2cscXFpHwbFt4OkHgjAnlQSHOyhcn3oLlcKOaHG3m0qvYhzNbQ6vK1bQlIa5HBcL+nJ3A/qa3qgURb2POKfKHlpzCpo4PgABHsiCwicFd81Ss1Cig/Lxq4oqyISaTG3iSVNRsK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+iC4w960OQEMhO4Fr5Ho+/CpqK5zMnmUymdpMxx7rs=;
 b=X3QJvz4TcB2sgK9lr5PfeM6jRrAsm4dkKpNjN/gwsdHGoM1aTIo9s17MfEzBOQRYl7sY6StjW4S59V1Df6Q691ULq0hzgwFk3W0MlQONiAPLR/ZNjKRycdh0+Qur1fidBdQgm2iGONYzvFgEMA2xx90kgBcRNTqjOe8N/rk+pzq/vH+j2zyLpWR/CWBVklDyZCXP5SLjdUl1l+eJ51BA7lRaVwjN8hwndJJjOWAUt9+F1jNp6/x+JDbNPf6Mi/d7C/i8dsEJiLSHQLG0z7MKgFnTivPL2ieXOaLmpMNEtnHgWiu743ddX2XUhybqHoUwbd6cmWmzvknBjmxeUHBd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+iC4w960OQEMhO4Fr5Ho+/CpqK5zMnmUymdpMxx7rs=;
 b=S+UCmPqcSr8w7z2u48MJ1LogfoKfQTBxUTxO4Bpc81wG8TkbFM3gy4KqWaR+Z4HujiRok2UnUT7tQRGacdCi79QPT/cjcM2J7aox6sMPajpMDNzVmQEbeXYbTWxg6xFJ/BxMvtfvmdt3A+8I2oubxRaNh8fBlHZdyHDg2y5mPuE=
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PAXPR04MB9471.eurprd04.prod.outlook.com (2603:10a6:102:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 09:06:13 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::2a4f:4339:4af0:f901%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 09:06:13 +0000
From:   Andrei Stefanescu <andrei.stefanescu@nxp.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Chester Lin <clin@suse.com>
CC:     dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
Thread-Topic: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
Thread-Index: AQHY9BqEgzFwGI3WuE6efN170VvRQQ==
Date:   Wed, 9 Nov 2022 09:06:12 +0000
Message-ID: <AM9PR04MB8487A41078460D1792CDA4DCE33E9@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-3-clin@suse.com>
 <AM9PR04MB8487C664E75EBA4D3678DD03E33F9@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <d3905a85-4746-09e8-ecf9-b39757bf6d85@suse.de>
In-Reply-To: <d3905a85-4746-09e8-ecf9-b39757bf6d85@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PAXPR04MB9471:EE_
x-ms-office365-filtering-correlation-id: d6562bc7-c315-455e-07f5-08dac231a68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiWACH5KonwEQ3ml8uY6Iu7gbZ0A47+2BBv8IrIbCUjTKnKx4oKuolPgTneTc9CWoWkHxChP8yTkIrrLDJfJXFnjW/FHRtx0vHfq7698009LYGTtQpLUg/Rzay782aA0Gm2urWH1wAtEXw07PQnpKrQcD38d/Fcd7rsyRsTAZmL9ewX7UNT76i+AO3yvWD8cmc250n23KZtyxq1GDNR3debz7eqkBdEm4Dzg7E2yIn5XLN7MW3/0gtR+MYD8PklJWAWq8wyXVoo0y1SulPILTdZXbj5iYkDfq/7bKwbVPboFINrtIkgDEkUQ6kPIUugAZl2tn3HGxVYfsxmK88fCpLe8/4HMmvpcc5g3FABR5kL3Oy/GhSySXDJNPZ92zcRshM7gN+4tDrd2sEYmGWo4XcFKz5o0u4Rg20dGpTl83y6zGlFq2cWS6/A1WRkvCiD0mzL0T7ljKdQvbL8j8s7GkOcMK1s7MAGbqfgfkREcqJ6cQ6DQJvLyGcl96e9PUULu+r+uuzIGPlL6f+55CQ6+gWwTceRS5Gje6c6L2JQHFOiIbPCCCHkKxHIXolmtqEPe2elGvJ4dDUyTvc2mYHvACPkIIEwYefL+Xagz+ZCYw73OJ8lrWwDyP7dqpANoTLahJTntSubaSVnjVLLlbIIXuU7tTnjGcT7gWUbRfjyB2OcwAaOVuLwwk+3L7l3SnO1xhMftxP2DXmvzjno6zT/iqYNyJC+xGcO6B7VGvrNqWYOjpH+L9p4nXpaFjzfOwXS+I2g2mI5GyKGjkE+/SEKeXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8487.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(186003)(38100700002)(7416002)(122000001)(2906002)(38070700005)(44832011)(33656002)(558084003)(8676002)(66556008)(64756008)(66946007)(6506007)(110136005)(66476007)(41300700001)(66446008)(8936002)(71200400001)(76116006)(4326008)(316002)(54906003)(9686003)(52536014)(86362001)(5660300002)(55016003)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJnalBtM1VWNGloa3ljYVQ3MUVUdjFtbERxMStKbm1aT1EzbUtTNTRpQlp3?=
 =?utf-8?B?bmxQRTZRV1JscnFWU0g1cFl6d2ZnSnJnd05jc2VDQXdlaHlGem9lVVVBQWJy?=
 =?utf-8?B?VUtDNEh5dGdxWXYxL3ZlS2hoUVcyb2JyT1grSS8rbER1dHRpY3pRT1I4TlEz?=
 =?utf-8?B?cEU3VHNLS0R6MlJnaVBadDhieVhnYytINlRPRFd6VHlSTGM3L0pLeXV3b0E4?=
 =?utf-8?B?eUl3eUZUV2xJZlh4QTFLRzF5bjVNQkZzQ1liMkxjWmVGUFhQbTc2UTNpcGRL?=
 =?utf-8?B?enlYbHRVcC9lZUVMZGJxeXlRWVM3Q2dONVpwOXlVSG1FTVFqZjN4c2JPQ3BJ?=
 =?utf-8?B?Y09MMjIybmoyY0l5YmtYNjJzM3Z3d2RONXVZbnJPemNoTlh6MkM5RGU4ampr?=
 =?utf-8?B?VjJnY1RqbXN2ajlMYmxZbVdJSWR4NVRHSVhYNHoxUi96MmFjZDdhMkhSV3Q0?=
 =?utf-8?B?RWtrUEhaSVNBYTdOdFFiMk5UWWJkdWE5QXd2aHpmWHJ2cFlNaWNWQWpCV1Ji?=
 =?utf-8?B?NEhpak9XczB6dm5sSXdKRWdYbzhNRCtBbVFZWmdPSFowUDZ4MU1zSjNlQkFH?=
 =?utf-8?B?bWt1UndqTTNtZVkwTGpSSGF5d2tualVmaFFDVXF1L1BibnMyWi9lQkgrSElX?=
 =?utf-8?B?OGUyQWplMlArS0JhNVM0VXRGMTh4NHd3d0kxR0c3YzZjNWVBS2c1OEhjZUFa?=
 =?utf-8?B?VDBOUXFuK2VRMWVNYWtlMitRcnJrYXk4djIvV3ZCUUZkbjMyQnl3a0IwL3hN?=
 =?utf-8?B?LzFQZU5ya1BpM2YyYkFKc08zZDZJMzhjb0ZXemtOWVJ6SFVYS0xVSDl0QXU0?=
 =?utf-8?B?cE9mZ0w4a0h6Z0VpTDZDQ2hHaE1wV1RTZmxCUnM0bmVhUWVaYmtETHFHRWI1?=
 =?utf-8?B?QVBQdjcwK2pXbHJlRnkxSWY4cVRNaVprM2NSMHR3TDhnV0xUeTI5amNGdEhi?=
 =?utf-8?B?TDAxck9QMHI4Z2YvU0M1dDU5V0o5R3pDOFEwSTFGR0g4dGVnK3ViUG1UQlJ5?=
 =?utf-8?B?RHhVbU5XSFFwRERGOXlXUmt4aDFlNGMveEVXRzdhcWRuTzBwcU5FS1oveUoz?=
 =?utf-8?B?T3BtUHQxQmRRaFFOdFZmRStqZVBYeW5lbFdhSG9ncHVHd1NpOHkvQ0FkcTZy?=
 =?utf-8?B?U3c4amtCNjNYWFUzaFVNZkR1bHpsZnFuZVY2b3hjTDJMQ2dPZldQSHFPR2Z3?=
 =?utf-8?B?LzZJMEhrRk9iRCtxNVRrblQzZzliSnlPZk9xdjRBRWZ0eEFET2l2a0V1N2t5?=
 =?utf-8?B?c05PK0trUWdjM1k5aks4Z0RmUG9qY29GQ1VQUThZVndaV2MrQXNoKzhkT2Nh?=
 =?utf-8?B?UEEyaTl5YkRuTEM5R1E1dFgyQzM5N1dWZHJTREFDRXVFUitJMkVMNmViNFUv?=
 =?utf-8?B?Z3RENHlYNmp5UXBKUkI5djRYREZwMzd2RVJPbHpza3FBelFaeUZkMjZISEtT?=
 =?utf-8?B?aCtseDVkWlRCcEVqdm1VVCtDTHB1WnZTMXFPZVlmOXRtY01kclgyT3ZDVTE0?=
 =?utf-8?B?R1EzblI5OE5ndlVHeFZGcis1THRWZENzV0ZuNEdNYlhtTGxIQnV4ZmI2NS9S?=
 =?utf-8?B?WkNnMEZDaFlNYVRVcmtmN09wUlk3YWVNYmdtWDl6cG9COE03ME1kMUc4blZJ?=
 =?utf-8?B?cFRhQWQzMDM5REJXQWpBaFo3aEJScm9SSkt2WWpRdHNqcGJDUXZEY1hzNGJn?=
 =?utf-8?B?bjhxdFJZQnY0d3NyMWVhMHRIVjNTU3pZQk0yRjg1K3A5dU9zOVo1Q3BKYnNk?=
 =?utf-8?B?ZEt3ODF5eWZuZGdGN3JJa0pHcE1qTVBEa3RVNXFsTjZBdE5KdVlVOExITm1Y?=
 =?utf-8?B?TXprTDdGLzVNdCtJN2ZqOUdRcHZDVXdZVytybmU5akhjUndpL3h5Vm5QRkpn?=
 =?utf-8?B?YnN1QnVWYXVnM2UyS3oyTllIdXRzTnBFZDRqZldKeUJmZUJTWnNTeG92bFB0?=
 =?utf-8?B?YVVUV3cwaTNQb2U2ZDlDQUJIK3pvT3FlQ2hBV2ZTaEMrNEdpbVo4a3VhQWJa?=
 =?utf-8?B?b01CcXlPdzlUVFlrZ0tsSHdkN1pZaHpEV0x0Q2dzRnU2OS9PZHNvWXdYUUly?=
 =?utf-8?B?R1hBeHdCTk5QVTVKbGEvMkpYaXhQN0ZScDZPVittWC94SUxOY0tCdWVaV3JZ?=
 =?utf-8?B?NjVsbTZTMXpBN3AyTjAycVRPbjdPWHJjN2VYNEdSSGlvSm8zK3hDNTc5RHZF?=
 =?utf-8?B?OVBkY2xIRCtDWTNlZWFYR2dJTEo5a05yeG9WUW8vMjgzSEI4dXl1WXZhY3oz?=
 =?utf-8?B?cExUU0JLa3VpVmZOZFVoeS9rL1dBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6562bc7-c315-455e-07f5-08dac231a68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 09:06:12.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIVfvquXl/lIAbwVL1rCjoH+vtpAZ+YqVf06gJrbhQ6l4uU3glTP1VezqXPGYk7/ds/y4IvFEuiSTTLYT3BU2tgLRowHZwqUI/kBlNu88gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlc3RlciBhbmQgQW5kcmVhcywNCg0KPiBAQW5kcmVpOiBJbnRlbnRpb25hbGx5IG5vIChD
KSBvciAoYykgZm9yIEZyZWVzY2FsZT8gKGNvbHVtbiBhbGlnbm1lbnQpDQoNCkkgbm93IHNlZSB0
aGF0IGFsbCBmaWxlcyBpbiB0aGVzZSBwYXRjaGVzIGhhdmUgdGhlIChDKSBwcmVzZW50LiBBbGwg
TlhQLCBGcmVlc2NhbGUgQ29weXJpZ2h0IHN0YXRlbWVudHMgc2hvdWxkIG5vdCBoYXZlIHRoZSAo
Qykgc3ltYm9sIHByZXNlbnQuDQoNClRoYW5rIHlvdSBhbmQgYmVzdCByZWdhcmRzLA0KQW5kcmVp
DQoNCg==
