Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832866CB3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjC1CPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1CPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:15:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8551732;
        Mon, 27 Mar 2023 19:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxTUyaiAQXCyqOxuDi1OcZO/5HTaNSiZ0fnatgnobVFyBdhL83EaUtljRwr87+4d7cOwNmG0Pzn5/dhobluGVWcaBCuJ0r+PrOvhxeXNRGMXtSsU4SILQFpE96MEJVzXLjI8eVIH//dlN5MH35rasFT/kNzrgD+BuW0pciKluMZybHBp30mQYou1laI9iJvrGoeu0aW9ItCsKSVI0NRPrQ3brS9BaFxYcJvAq6KGmNajwGgDmrrQe1ePAvKYn3eAw8TyBA2Js1a9+3zhI+u6t+EEU9RGsRON6TLXBYClqwErtPjWp1AyJLQ9N0+4s4CDfGy218zt20LEyrXhL3mLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sGIQwJDu1otrHfcbPANXd9sjQjZOa7Bafwyz+OduYs=;
 b=UAFDETTaJMebEsZ+ECUJB3AD6Wm+/viQw9Mi7UNKX95KZVUAp8L7HZ7FZlSmtrlJy0nQMyk1v7tresJPqd3kjpufZvglCkwynCPnn49QA8+kmoXyA+Zs7/fuYLyBmuXYsNPDhdt6YjKEkf8zGV0o5wiCcWuy4LBmczhw+KI7q7Si9Z4NaNpKCW59u4SULrpx97+Rv51ACFh4N4W9lq9YhSW1M9sjYwoh/9y3SDaVQicpVrPG72r0I+hJ61HEJ7Ln10ClkucBHqDGZJcNLQV/MFo8AxRU3Y5XkBlrgrDEt7dOWBxVMvluOg8VFdg/WODTZeYHRTwzqZ0iwUbRl9VYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sGIQwJDu1otrHfcbPANXd9sjQjZOa7Bafwyz+OduYs=;
 b=GZubcowP3U0Hv66zJtnY/s0EZMsDN0xZw0hGh1znKl5Am1xCWUKmgHlJtj0lSRMx7HYzLuOpwmU8ANrwg1XiOYQOXOYjpqcYBzLGm5Cd0cUIbGl0BGodn+2h5VHO0zOSrJ/tpZ9nZIKQrghebShFyZ29QRDCFchjIMWqHlsU8oA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 02:15:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 02:15:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "gerg@kernel.org" <gerg@kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Thread-Topic: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Thread-Index: AQHZYGnzfuhET8vzU0qSzMmiiHJQlK8OZTnQgAA4s4CAANclEA==
Date:   Tue, 28 Mar 2023 02:15:00 +0000
Message-ID: <DU0PR04MB94172ECC59D563B782DBAA5888889@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
 <20230327050642.593778-1-gerg@linux-m68k.org>
 <DU0PR04MB94174D60EE38B56FEB6CD5BC888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87e68e05-8512-17fc-584c-0022ddefb8f0@linux-m68k.org>
In-Reply-To: <87e68e05-8512-17fc-584c-0022ddefb8f0@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: 4eb0d101-7b18-4c0d-385e-08db2f323bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HG7zKEHULsIARAIztjPm4G06l7GZaSdC92a2Vw0r0tUhgkKM/FV/kNTe4Qh4N3qZUBnLs8ConDAeEPmaVtqEtzhP/KAtaaNtSDkgdR96qSnEQtX+VA3xAZ6Ps2qQI9w+hTPBwLzLLtY9Z64e8YEaX0pDWeUFKEOP33OwC+2qS79L/1jTUY7HVu2ttkhmA9yD0ygjShDPJWTOk8dCyCK/AMQ55coRDpSuSvxhg8IwHZISqVqHP3EbcMdPgL7otb4C4auVOiVWA9NjbfWypxtxP5lVGGHLTVvtw9Yz8fcvLxWNWxOQx7Bja2c6lk9Hy+Z/ekqcfLFuvX54nvHv88Zehv6IJQJ+oG48ArghK63QNX54tz3lo6nUdQdOU0+Jyx1CkzcBli1irqqeD3EC48TwukVtiuFFdBwPFHfmip52ypFT2jyMoimL21+FofdiS8sxiJl41XWYM7ooWMBBhW7HUHeIdbmD6lCebkvTWgPns8sIdrdO0e9ah3cj4Unwb+Jt+BxQTIP6Pl66tzg4Rh3nfU1+BZ2V14gl1EgW76E0x6BHdb3Z5rQrHQOepix864QcBVOBRZOXhPg7Jv/yWV0T4mE4ZrCvGnQwIEIjz1NLJvS3hCvDsb4TNA9iM5mcHF/GVGp6cdD4vX8BGFloK0qWTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(2906002)(71200400001)(7696005)(44832011)(38100700002)(7416002)(86362001)(38070700005)(478600001)(316002)(54906003)(110136005)(52536014)(122000001)(5660300002)(8936002)(66446008)(64756008)(8676002)(4326008)(66476007)(66556008)(76116006)(41300700001)(66946007)(55016003)(186003)(26005)(33656002)(6506007)(9686003)(53546011)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXU1T0F0WTFrcDE2dE1laU42MkVxSFJ4TVBaRXNtRmVXRzFtSmdqaXNBTWdM?=
 =?utf-8?B?SVVzdUNOQ2lwWEppQ0RJd1c3WUdrUzQxV204MHc0RnhYeVV0WWI4WEwyWTZN?=
 =?utf-8?B?T3NWM0NpRDkwTHM2YWtBVzZFMHFhZXlHaG4xYUdjcmRCYXVTVUlsemd1UmdI?=
 =?utf-8?B?WHk5SmRJM3I0VFpQSWI0a2ovQ2FYYzVDZENrMlhvWG05Y3habkJ4cUVYRllz?=
 =?utf-8?B?bnB5NE9FSnQwcU5rb0lVUnZRdytVbUFac2ZOM3J3T2pkOXZXOXdHSkQ4U0dC?=
 =?utf-8?B?YXErNGMxTW1vMDhGNFB5Zk9wTmE4SnJTeXNuSzVSVC9ET2phTjJVRlBNU3ZQ?=
 =?utf-8?B?UUVLalpEZFlESkFEcWRzZHpjTEl3RGkzOFk5eXlDV0lzS3dZeTlsMmdVRG1j?=
 =?utf-8?B?RTVnUU42UHZTWE1EYTlRRVNCNHZrZWJrbmpHT0toSkdYZ0k4bTZjK2g1dE5r?=
 =?utf-8?B?RlhQQ1l4M0Vleno5UDQvKzNiTkF3SE9hcmdyWjROYzI4b2JKMUZzU0VHZVBV?=
 =?utf-8?B?aE1DMVpsdWN2cXpid3QvaHVMSDJSQ0VsaVZhQjlXSkY4QmlFT0VNK2RoSy9i?=
 =?utf-8?B?SWlDajJ1K1VHVEp2dzd5aVNEMkcwM3VXOWFBRnVIZ0hOTTlEek9OZFV6WDZY?=
 =?utf-8?B?NisvOWtZc1dsTmNQa05IcGg5K2FZNnIwaWhyUXRwNWJqRFpFOEw4UHVkWjdp?=
 =?utf-8?B?ZFFTT1BEck80bFc2c0l2eXpVOXlxcllpUzJqdENiVE9xenNqYnpiQ1JOKzNl?=
 =?utf-8?B?dUJwenErRW9rdzZEZ0xncytVSzZydTRkSlp0TVpFZ1BBdVlkQlVrUERQWVZQ?=
 =?utf-8?B?QXZLL0R3aTFHSXJIWXdqR2hhZGVBZGJKeUwwT0VqeDA1Vm41Z2IxL1dqeG1Y?=
 =?utf-8?B?eVFyMXliVHdIcWFTQmowZzIwTGtLSzd6RUFjbHRpZTBuOGg4OTdpUW14bE1q?=
 =?utf-8?B?TXNoVXIxbU1Obnp5UnRMOGRaTDIxbk95ZjdEbTJiQjdMRHNLcFJENmUvY1NO?=
 =?utf-8?B?K0dPK3R1bGk3UG9uYi9PN1ZFRDV4U0wvVWZmR2M5OFJDS3N4a2txREwxT1JD?=
 =?utf-8?B?cGRoUUQ1RU5IY0I5YlV6ZFJzZ3VGL0d0RGNrMnI0UDlkSDRESFJuQ1hCbk9z?=
 =?utf-8?B?UkE1cHNCaTVOdUJMeFlCOGtnUzhDVlY4UElTVDEzVGJxZjYzNTFUbGJ3ZXAr?=
 =?utf-8?B?akFOdjRqTWZ3TFJEdVJmcVBTRkdMWmtXUElQcVFDUWJTQkFBeGc3S3FXT3BL?=
 =?utf-8?B?Qi8zZXZ4bGdqZFkxcjBZN3JEUWtIT1VZUjkyMXcxUU0vRW5iL0FzN2t5VFpw?=
 =?utf-8?B?MjBQSVFVSE8rT095cFNmdkEyaGNmTWZiNUF2U2FaeUNQaW9tc3d5eVU3YmFG?=
 =?utf-8?B?TnZqeStrSVMxaDFhbTYvQm9LMEhYai9QZkttL1Z1eFpMNjB4cE8yU21ubzFI?=
 =?utf-8?B?b0xoVHF5M05USmtpVnJDNkVlTmlqeCtaNkV5V0VGQW9TM1FCWkhoRENZangz?=
 =?utf-8?B?cGpYTVNmRlZDMkhRdGpqOGFBYmlKK2JSc1o0Tnl6YWtSTWp5Q0hjODdQWkRU?=
 =?utf-8?B?aWNXWi9ISndFc3Robnd2NEJlTlQxZVo2dENHYkhJNk0xUEhyMGxRbHB0SWNX?=
 =?utf-8?B?Z28zT0M2SDhyd281bWZYU1ZPdjJzZnkrbUpEdVZvUCsyOG02cjh0dnB1Mnlk?=
 =?utf-8?B?REVsNDR2bkViSDBZbFVlZDVDTjgzN25PSUFzMlB2REhIMUhSekdRVllsZEsw?=
 =?utf-8?B?RkFOL3JxYzEyYlA0cVovbEVJZExvRmtpMFBBWFJKbEdHZ1cxQVI2am40a2lq?=
 =?utf-8?B?ZzJReVdpT081NlZKMkNvZmJ2ek92WmxTU2dOL3Zsa3dNZTVYeDJKTjFDZmlx?=
 =?utf-8?B?ZG1Wb1NSbGJJVGZOa3lBL0dGZWMydEVoWExQdi96UFRxUk9IVHZFbTJxMXp2?=
 =?utf-8?B?MGdOQkNyL09ZUVZJUVI0ZnIzMkpTWWpMNnNKc1I5M3VFZDA0dlRkVGxUcFBL?=
 =?utf-8?B?ZXloT05nWlRuRnE5a29KbkZMNHpPbjdyT2RzTlVjcVN3R3EwVk9zWFpQOFpT?=
 =?utf-8?B?MFFkY1ZUSGpVL2x6c3BnUU40bmluNkJuekxDaGhTMTVobmExdnBuQW1vNGVI?=
 =?utf-8?Q?HlOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0d101-7b18-4c0d-385e-08db2f323bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:15:00.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4orAW4hGx9owQz6ot4j52upEjPtcsYRCPYGW0UA6R/qT8kTIyiy3mJENFGG01V2broab2j4ST998xjTz5gzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBVbmdlcmVyIDxn
ZXJnQGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyMDIz5bm0M+aciDI35pelIDIxOjI0DQo+IFRv
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZh
bkBvc3MubnhwLmNvbT4NCj4gQ2M6IE1hcmt1cy5OaWViZWxAZXcudHEtZ3JvdXAuY29tOyBhZm9y
ZDE3M0BnbWFpbC5jb207IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGtyenlz
enRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4g
bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtYXJleEBkZW54LmRlOyBwYXVsLmVsZGVyQGlk
ZWFzb25ib2FyZC5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgZ2VyZ0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDhtcDogYWRkIHZwdSBwZ2Mgbm9kZXMNCj4gDQo+IEhp
IFBlbmcsDQo+IA0KPiBPbiAyNy8zLzIzIDIwOjAxLCBQZW5nIEZhbiB3cm90ZToNCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgdnB1IHBnYyBub2Rlcw0K
PiA+Pg0KPiA+PiBPbiAyMi84LzIyIDE0OjQ1LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4+IEFkZCBp
Lk1YOE1QIFBHQyBub2RlcyBmb3IgdnB1LCB3aGljaCBhcmUgdXNlZCB0byBzdXBwbHkgcG93ZXIg
Zm9yDQo+IFZQVS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNoYXduIEd1byA8c2hhd25ndW9Aa2Vy
bmVsLm9yZz4NCj4gPj4+IC0tLQ0KPiA+Pj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAuZHRzaSB8IDI3DQo+ID4+PiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4g
ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+Pj4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+Pj4gaW5kZXggMGIx
NjVmOThhODJjLi4zNGFmOTgzYjAyMTAgMTAwNjQ0DQo+ID4+PiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPj4+IEBAIC01OTgsNiArNTk4LDMzIEBAIHBn
Y19pc3Bkd3A6IHBvd2VyLWRvbWFpbkAxOCB7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0NCj4gPj4gPElNWDhNUF9QT1dFUl9ET01B
SU5fTUVESUFNSVhfSVNQRFdQPjsNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsaw0KPiBJTVg4TVBfQ0xLX01FRElBX0lT
UF9ST09UPjsNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwZ2NfdnB1bWl4OiBwb3dlci1kb21haW5AMTkgew0KPiA+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwwPjsN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDxJTVg4TVBfUE9XRVJfRE9NQUlOX1ZQVU1JWD47DQo+ID4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPTwmY2xrIElNWDhNUF9DTEtf
VlBVX1JPT1Q+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH07DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGdjX3ZwdV9nMTogcG93ZXItZG9tYWluQDIwIHsNCj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47
DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBw
b3dlci1kb21haW5zID0gPCZwZ2NfdnB1bWl4PjsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDxJTVg4TVBfUE9XRVJfRE9NQUlOX1ZQ
VV9HMT47DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX1ZQVV9HMV9ST09UPjsNCj4gPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+Pj4gKw0KPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBnY192cHVfZzI6IHBvd2VyLWRv
bWFpbkAyMSB7DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmcGdjX3Zw
dW1peD47DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8SU1YOE1QX1BPV0VSX0RPTUFJTl9WUFVfRzI+Ow0KPiA+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGsgSU1Y
OE1QX0NMS19WUFVfRzJfUk9PVD47DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwZ2NfdnB1X3ZjODAwMGU6IHBvd2VyLWRvbWFpbkAyMiB7DQo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjcG93ZXItZG9t
YWluLWNlbGxzID0gPDA+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmcGdjX3ZwdW1peD47DQo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPQ0KPiA+PiA8
SU1YOE1QX1BPV0VSX0RPTUFJTl9WUFVfVkM4MDAwRT47DQo+ID4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsaw0KPiA+PiBJTVg4
TVBfQ0xLX1ZQVV9WQzhLRV9ST09UPjsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+Pj4gICAgICAgICAgICAg
ICAgICB9Ow0KPiA+Pg0KPiA+PiBUaGlzIGNoYW5nZSBjYXVzZXMgbmV3IGVycm9yIG1lc3NhZ2Vz
IHRvIGNvbWUgb3V0IGR1cmluZyBib290LCBmb3INCj4gPj4gZXhhbXBsZToNCj4gPj4NCj4gPj4g
ICAgICAuLi4NCj4gPj4gICAgICBpbXgtcGdjIGlteC1wZ2MtZG9tYWluLjg6IGZhaWxlZCB0byBj
b21tYW5kIFBHQw0KPiA+PiAgICAgIGlteC1wZ2MgaW14LXBnYy1kb21haW4uODogZmFpbGVkIHRv
IGNvbW1hbmQgUEdDDQo+ID4+ICAgICAgaW14LXBnYyBpbXgtcGdjLWRvbWFpbi44OiBmYWlsZWQg
dG8gY29tbWFuZCBQR0MNCj4gPj4gICAgICAzMDg5MDAwMC5zZXJpYWw6IHR0eW14YzEgYXQgTU1J
TyAweDMwODkwMDAwIChpcnEgPSAxOTcsDQo+ID4+IGJhc2VfYmF1ZCA9DQo+ID4+IDE1MDAwMDAp
IGlzIGEgSU1YDQo+ID4+ICAgICAgLi4uDQo+ID4+ICAgICAgaHdtb24gaHdtb24xOiB0ZW1wMV9p
bnB1dCBub3QgYXR0YWNoZWQgdG8gYW55IHRoZXJtYWwgem9uZQ0KPiA+PiAgICAgIGlteC1wZ2Mg
aW14LXBnYy1kb21haW4uODogZmFpbGVkIHRvIGNvbW1hbmQgUEdDDQo+ID4+ICAgICAgaW14LXBn
YyBpbXgtcGdjLWRvbWFpbi44OiBmYWlsZWQgdG8gY29tbWFuZCBQR0MNCj4gPj4gICAgICBpbXgt
cGdjIGlteC1wZ2MtZG9tYWluLjg6IGZhaWxlZCB0byBjb21tYW5kIFBHQw0KPiA+PiAgICAgIC4u
Lg0KPiA+Pg0KPiA+PiBUaGV5IGRvbid0IHNlZW0gdG8gY2F1c2UgYW55IHByb2JsZW1zIG9uIHRo
ZSBoYXJkd2FyZSBJIGFtIHVzaW5nLA0KPiA+PiB3ZWxsLCBhdCBsZWFzdCBub3QgdGhhdCBJIGhh
dmUgZm91bmQgc28gZmFyLg0KPiA+Pg0KPiA+PiBUaGlzIGZpcnN0IGFwcGVhcmVkIGZvciBtZSBp
biBsaW51eC02LjEuIEJ1dCBpdCBpcyB0aGUgc2FtZSBpbiB0b2RheXMNCj4gPj4gbGludXggNi4z
LSByYzQuIFJldmVydGluZyB0aGlzIGNoYW5nZSAobm90IGNvbXBsZXRlbHkgdHJpdmlhbCBkdWUg
dG8NCj4gPj4gYSBjb3VwbGUgb2YgY29tbWl0cyBhZnRlciBpdCB0aGF0IHJlbHkgb24gaXQpIGZp
eGVzIGl0IC0gbm8gbW9yZSBlcnJvcnMuDQo+ID4gW1BlbmcgRmFuXQ0KPiA+DQo+ID4gVGhlIFZQ
VSBCTEsgQ1RSTCBzZWVtcyBub3QgZW5hYmxlZC4NCj4gDQo+IEhvdyB0byBlbmFibGUgaXQ/DQo+
IEkgaGF2ZSB0aGUgYmxrLWN0cmwgY29uZmlnIG9wdGlvbnMgZW5hYmxlZDoNCj4gDQo+ICAgICAg
Iw0KPiAgICAgICMgaS5NWCBTb0MgZHJpdmVycw0KPiAgICAgICMNCj4gICAgICBDT05GSUdfSU1Y
X0dQQ1YyX1BNX0RPTUFJTlM9eQ0KPiAgICAgIENPTkZJR19TT0NfSU1YOE09eQ0KPiAgICAgIENP
TkZJR19TT0NfSU1YOT15DQo+ICAgICAgQ09ORklHX0lNWDhNX0JMS19DVFJMPXkNCj4gICAgICBD
T05GSUdfSU1YOV9CTEtfQ1RSTD15DQo+ICAgICAgIyBlbmQgb2YgaS5NWCBTb0MgZHJpdmVycw0K
PiANCj4gUnVubmluZyB3aXRoIHRoZSBmdWxsIGFybTY0IGRlZmNvbmZpZyBhbmQgdXNpbmcgdGhl
IGlteDhtcC1ldmsuZHRiIHN0aWxsDQo+IG91dHB1dHMgdGhlc2UgbWVzc2FnZXM6DQo+IA0KPiAg
ICAgIFsgICAxOC4xNTA2NzldIGlteC1wZ2MgaW14LXBnYy1kb21haW4uODogZmFpbGVkIHRvIGNv
bW1hbmQgUEdDDQo+ICAgICAgWyAgIDE4LjE1OTI0MV0gaW14LXBnYyBpbXgtcGdjLWRvbWFpbi44
OiBmYWlsZWQgdG8gY29tbWFuZCBQR0MNCj4gICAgICBbICAgMTguMTY3ODIyXSBpbXgtcGdjIGlt
eC1wZ2MtZG9tYWluLjg6IGZhaWxlZCB0byBjb21tYW5kIFBHQw0KPiANCj4gT3IgZG8geW91IG1l
YW4gc29tZXRoaW5nIG1vcmUgZnVuZGFtZW50YWwsIGxpa2UgdGhlIGhhcmR3YXJlIGJsb2NrIG5v
dA0KPiBiZWluZyBlbmFibGVkIGJ5IGJvb3QgbG9hZGVyPyAgKFNvbWV0aGluZyB0byBrZWVwIGlu
IG1pbmQgaXMgdGhhdCB0aGUNCj4gcGxhdGZvcm0gSSBhbSB1c2luZyBoYXMgbm8gdmlkZW8gb3V0
cHV0LCBvbmx5IHNlcmlhbCBjb25zb2xlKS4NCltQZW5nIEZhbl0gDQoNClRoZSBpbXg4bXAgdnB1
IGJsayBjdHJsIGFscmVhZHkgaW4gaW14OG0tYmxrLWN0cmwuYywgc28gaXQgc2hvdWxkIHdvcmsu
DQpIYXZlIHlvdSBlbmFibGVkIGlteDhtcCBpbnRlcmNvbm5lY3QgZHJpdmVyPw0KQ09ORklHX0lO
VEVSQ09OTkVDVF9JTVg4TVANCg0KUmVnYXJkcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMNCj4g
R3JlZw0KDQo=
