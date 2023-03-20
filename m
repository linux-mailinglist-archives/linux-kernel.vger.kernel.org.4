Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785AB6C1BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjCTQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjCTQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:30:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4851270E;
        Mon, 20 Mar 2023 09:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA7x3TRPIchHCdQ8w6V4R+RMatj9Rr9BvPz1HtAPqB1icAtJv7FVZMhjXQHSvni0FQqsEyWD/3sYWWHOBNqWdGNfrdBL9kVCo9NS9vOhDjjvHhBDZTRx/oRUvMrz0pl6cbMRp6KL6lPk+cMLhdFa5jt9JswxYQf1tttYR5clCtbZMxJKo1o3JUcKyT5OP0LA18xcQ/12entfGTDGNEPp0G86YXhbDJ/FOv2e12mUrU/cTYWHjfnln3CXd4WySj30kB4P2kgbVpfWFwr1zS0AofmL5F6xhrQ/ZW0v26401clkHp4pkMnS/RRhOoZ7YCxKtK7+HBQ3UMSpq/tTgOnIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUB4t0xM/Q7BbaJ/HgyQPQ52zZLVIfEK0kVY/abARs8=;
 b=SLq/yhwQuGB3bM6szltFEfOuPFyMTgTVL0jugMLuAmypC55b5c7inpXaoH95lD2DPJE+j3PNQqtyyYRPWx0ILBfhEnCHnZMq71cnCNC+xTEKd0fMMnj6n64ZuWCwciPnw3CVafGV94s0JKZ8MbF+2WpwHtd8McsaB5YXVEHbkDi7Mkx48kQIdLr/8bg9ugT4rvz4XS9br5ouykMQtXipFF63MHEmaeJoencx7KXslqxmJyMSyjncFl6bOYFAs08HQiugL7mDxZCIZxksI7kiwmoXIeQBavvBgbVxdxNnaKZ+na4n0XINl3DHaa3u2bmWfx9IavX9rnle87UfWU0ShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUB4t0xM/Q7BbaJ/HgyQPQ52zZLVIfEK0kVY/abARs8=;
 b=lgoKC9EB465I1SJzrUvPn6QO0uO6xX9Aeq83bDHslPlwnfbTWl9Pwgwb6pnDiAZtmhnlAW1TeAvSqD6HNfRLvBRsDRmuGCoYTIYycCe8ASQRJLlj9oAT/bCuzJzWroWcPjR7gkwzLpyv3KmqEjgnDsiaeBXpasFxKyQSA7evxQQ=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7844.eurprd04.prod.outlook.com (2603:10a6:20b:236::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:22:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:22:47 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZWE4ev2xmRcSa20iFYFwtFRu1OK7+r7IAgABftWCAAueGAIABzLvggAALc4CAAAzzgA==
Date:   Mon, 20 Mar 2023 16:22:47 +0000
Message-ID: <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
 <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
In-Reply-To: <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM8PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: 6b42d449-9307-4ae9-d1ba-08db295f57cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1coNYv2ZMIWn5Vwli0zGl+cAQGjJLyw9yrFNNuLqJVDpDei9NRLMzN7gy6PReL4IEy32tgetphX78CnHeUJtnqIOF6hhDT5z8fUU9J5J2Y9k4gvWKPkgqofurLd/oeNLHW47o+h61voiAUGQJRn1A198tZvi6LVdmq/QNSHxm0ipjl5k2TjJ/bTU6/Cm+h1W/gqtYWmZVozSeR5pcZZ/AaOzHFnTJsenYuaNqqhPo54+C1r/69On80rdj9Wbp7AnEmPqfbpquouHmreHVyqZyAL3uW8+ktwTglG5SXY9qdZdI+WntvTxV4WEJUblEwLUpKkgcATCye7E8/ccH8XWW4pUblha8ETMfzFG7IqstqWhf4u37OZz71AqPywxx3Pbphq0oqOHyzbi9C/dMO7YsBH4Hd1iXmUe4ewiCz6PoofLvnWEczSVtGhunC15MB/ztXPJgyUQFQAhf2MOajE3cS9dTprrPMWv90hxQDEQf6OhbiUgbk5LzA4neqWEif41UU8mY2K6qdQwu275duDyNiP2cK/cd3ysTJTkDo2iJsAPhFXWhI2SfpYhhZF4J553KNmcJHZSrG0TC1eUjyg5zSssN0SP2K7x9F/jNmIujvH9fJmLZEcxujEfQFJDmpDIAS+RmD7ifFnrmvJFboOs9JQsJUByqhFIQy1ia7EaIVvjXBjknvQHUuIu0UTkxQdQ9FYeYzQ+KGSENwyw+0H4o9sN+xFyzz02qfXKw3yOmd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(54906003)(83380400001)(110136005)(478600001)(71200400001)(7696005)(6506007)(316002)(9686003)(33656002)(5660300002)(186003)(26005)(55236004)(7416002)(122000001)(38070700005)(55016003)(38100700002)(86362001)(8936002)(2906002)(66946007)(41300700001)(76116006)(52536014)(44832011)(64756008)(4326008)(8676002)(66446008)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1Sb29mSXRJOHV3Q3ljYlZtZHFjU1NEdkQvUmxjUnNQN2twblVlWVJXY2VY?=
 =?utf-8?B?eDRzT25NSFpEOW1Lemh0cGRSSHNmUHZNU1lLNWRXcnd5V3FJbHZwWlE4QmJX?=
 =?utf-8?B?U09ib0U2TGxVeXA1RXhZa3Z6ek5XODkwZE1kUW15Q1pLNXE3K1dJd2I2TU1s?=
 =?utf-8?B?eDhUYjBUT2laUEhmQmtYclpYYncvZkZHaHlHS2dXSStaYnpLd1RYeU15dDRZ?=
 =?utf-8?B?UVhUZFVQQzVTV2FNeDh1VHVTL0pRNmRiSnJHNG5ad2JWYWMvM1RReUUvVVB6?=
 =?utf-8?B?aGZNSzFBdXdGSWF5ckxuQlNBOUFxMk9tcUFUNUIxOXU4a1VUTTAxRlVmYlZC?=
 =?utf-8?B?Skdna1FkMmpwMjFZQW5GOVJUNG5aVnNlSkgzc0trazhqMDMvR1lTZmIzc0hL?=
 =?utf-8?B?TWhGRGllN2l5TUZvL3ExekdyaXVtNjgzcWd0L3VTN2tML2pYM3ZxemR5TzEy?=
 =?utf-8?B?QU4xYUlXMVErMmZGeDZxR1BvdU9uYkdIVENVdHFLZm9MbTVQU3gycjg4T0xH?=
 =?utf-8?B?QVB1VHowOXMyTVZhTnVaZ3FvZ2o5VHVOa3VSQnZYemV1N085UDYyS1dMemxz?=
 =?utf-8?B?TDRTYXNwNGVPYlZuOWd3VnJSN3hKNVJJa2VPSVBuTTFORjJVNXRNNWZlMTAr?=
 =?utf-8?B?UER1TElZQjZsVWNiUUgzb1Z3SEF4ZmZQblYvTmQzLzAzeHlMemtaKzdrd3l4?=
 =?utf-8?B?M3djNlRpNXF4dTQ0cTJZazgraU1vQ1B5OU1UM3FCTnZyVnYwSDVXVDVOYU9t?=
 =?utf-8?B?UW5UREZBRERUWkNUUVk3czZtdG1qYndWTXNDTklBL1RRbHR3cGR4ekJVTWtj?=
 =?utf-8?B?NkFFZC8yOW1VU08wbTZPMHgyNjJCWkVqWkFyeEJVbWlvUFh0d2dYUWt5Lyt1?=
 =?utf-8?B?ZWNaZU1VK1NwYlI1QVBQMUh5MzRDZlp5QnFLN1FQV3VQMFkzL1AwNVVWSng5?=
 =?utf-8?B?TmhPald5Y0gxVWlwNkJrRmt1dFEwaExWN3BMQUFwNGlLdlZWTk1zeEE1aEx1?=
 =?utf-8?B?WWVaM2NtME1nOUlFNEUzekJYaUpYUno4Y0dTNHhTbjRSWW5jUlE4UHRwYjBO?=
 =?utf-8?B?MEpUTEdqeE1rbWUzcEhST0RpMVc3eGhCS0pFM0NHYnNEZzZQWEw0UjlkbzlU?=
 =?utf-8?B?UkNxb1NhYmhDajlXQmlHZDBGZHJLNDQvKzE4dzY2c25KNzF2YzhBa0drN1hk?=
 =?utf-8?B?Nk5sVWlyeEtMVlVDeG95SG5rL0VHcFRWckNKU0FVaXZWVmJVVHV1aTRubU5S?=
 =?utf-8?B?MnNwelRCTWFHQjdneDc1MmZPalpKclM4ZStuZWMyeTYzUzlidHZUOEJMd2kr?=
 =?utf-8?B?enNzY3NyVHdFN3hicE5hbktOYXRLWWY5elJJTzNEanViMjRwbnZmbjdBM2dK?=
 =?utf-8?B?UUVCaXJveURTWldyT0JjQnpyNXMyTGptbW53akVSQ0lWTVBHZDd3ZEJKbVgz?=
 =?utf-8?B?NWZKa2h5U1FzalJqRWFKdnhQVXQ0dGpQQVNaaVhjdGxvTEw5SDVHUWlVc0lH?=
 =?utf-8?B?QW9UUVU4eG5Pb0JtbFN4bHR1VHlIV2dBUjhwS00zRmN0M0tYRVlLZzJyOWpJ?=
 =?utf-8?B?RDA0cHJjNGR2QWpkZWsxeWtiOWUxMkFiRGtqVE9JZEhPellwSEoxZTNYMjho?=
 =?utf-8?B?SUtLdmxYQTQ2SnVBdzJxakpUbG14YjVjN0haSWswN0d6ZmVZSWhtNVJPaVR0?=
 =?utf-8?B?SlFwTEhJclk3OVBQZU5MNGZwWmJKZmR4Skc3SGZ1WXUvQ2hnQ3hCMlNXRElv?=
 =?utf-8?B?bHFMMjJVNlpwY3JmUWZHSVRBWG9XamRQdFByZnk0SzlKUDVQYVBkYU5SK2Jn?=
 =?utf-8?B?UzhSWGdvU2lvZTFMV2JSVS9nZGhyNWxGQzlRaFhNV25kTng2ditiMGI5QzNy?=
 =?utf-8?B?L2ZmY0FyMTlYRjZxZmYxUDJ3czcrMy9lbThaeHo0akk1R0NoWnVyKzhsOFJ1?=
 =?utf-8?B?czJqMkpzUndEOWp6SXZ0OGJEdVluVnQ1QmtRd2RhQ3dWN2V5cjZGNGhRMkdD?=
 =?utf-8?B?MmpOTXZqeCtyRUQ0YXE4L2o0QnkrYXhPOTByMjNKVWl4REx2M3p5UTZBTStZ?=
 =?utf-8?B?RHlxbEJTOGhtQlFzRzE3VUdXWTJjdXB5Vi92cG5TTVdpVDRCSUlqT2hheG9Q?=
 =?utf-8?Q?8drQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b42d449-9307-4ae9-d1ba-08db295f57cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 16:22:47.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEef2/hds6OW0RbMhr1h6HdUazjJp6ZsbZozFjF22DDn/Z2T9ouGKulXvuB734VqK3eMC0LYOrm7f8R+wMYA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+PiArICBhc3NpZ25lZC1jbG9ja3M6DQo+ID4+Pj4+ICsgICAgaXRlbXM6DQo+ID4+Pj4+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQaGFuZGxlIGFuZCBjbG9jayBzcGVjaWZpZXIgb2YNCj4g
SU1YX1NDX1BNX0NMS19QRVIuDQo+ID4+Pj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQaGFuZGxl
IGFuZCBjbG9jayBzcGVjaWZvZXIgb2YNCj4gPj4gSU1YX1NDX1BNX0NMS19NSVNDLg0KPiA+Pj4+
PiArICAgICAgLSBkZXNjcmlwdGlvbjogUGhhbmRsZSBhbmQgY2xvY2sgc3BlY2lmb2VyIG9mDQo+
ID4+Pj4gSU1YX1NDX1BNX0NMS19NU1RfQlVTLg0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgIGFzc2ln
bmVkLWNsb2NrLXJhdGVzOg0KPiA+Pj4+PiArICAgIGl0ZW1zOg0KPiA+Pj4+PiArICAgICAgLSBk
ZXNjcmlwdGlvbjogTXVzdCBiZSAxMjUgTWh6Lg0KPiA+Pj4+PiArICAgICAgLSBkZXNjcmlwdGlv
bjogTXVzdCBiZSAxMiBNaHouDQo+ID4+Pj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBNdXN0IGJl
IDI1MCBNaHouDQo+ID4+Pj4NCj4gPj4+PiBJIHdvdWxkIGFyZ3VlIHRoYXQgYm90aCBwcm9wZXJ0
aWVzIGFib3ZlIGFyZSBub3QgbmVlZGVkLiBJZiB5b3VyDQo+ID4+Pj4gaGFyZHdhcmUgcmVxdWly
ZXMgZml4ZWQgZnJlcXVlbmNpZXMsIGNsb2NrIHByb3ZpZGVyIGNhbiBmaXggdGhlbSwgY2FuJ3QN
Cj4gaXQ/DQo+ID4+Pg0KPiA+Pj4gQ2xvY2sgcHJvdmlkZXIgZG9uJ3Qga25vdyBmaXhlZCB2YWx1
ZSBhbmQgdHVybiBvbiBvbmx5IHVzZWQgYnkgY2xpZW50Lg0KPiA+Pg0KPiA+PiBTbyBtYXliZSBm
aXggdGhlIGNsb2NrIHByb3ZpZGVyPyBPciB0aGlzIGRldmljZSBkcml2ZXI/IFJlcXVpcmluZyBi
eQ0KPiA+PiBiaW5kaW5nIHNwZWNpZmljIGZyZXF1ZW5jaWVzIGZvciBldmVyeSBib2FyZCBpcyBh
IGJpdCByZWR1bmRhbnQuDQo+ID4NCj4gPiBJdCBpcyBub3QgZm9yIGV2ZXJ5IGJvYXJkcywgaXQg
aXMgY29tbW9uIGZvciBhIGNoaXAgZmFtaWx5LiAgT25seSBhIHBsYWNlIHRvIHNldA0KPiBmb3IN
Cj4gPiBRTSBhbmQgUVhQLg0KPiA+DQo+ID4gVGhlIHNpbWlsYXIgY2FzZSBpcyBuZXR3b3JrIGRy
aXZlciwgd2hpY2ggcmVxdWlyZSBhIHNwZWNpZmljIGZyZXF1ZW5jeSBhdA0KPiBjbG9jayBhc3Np
Z24uDQo+ID4gR2VuZXJhbGx5IGZyZXF1ZW5jeSBpcyBmaXhlZCwgIGNsb2NrIHNvdXJjZSBuYW1l
IG1heSBjaGFuZ2UgYXQgZGlmZmVyZW5jZQ0KPiBjaGlwcy4NCj4gDQo+IElmIGZyZXF1ZW5jeSBp
cyBhbHdheXMgZml4ZWQsIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhpcyBpcyBpbiBEVA0KPiBi
aW5kaW5ncy4gSSB3b3VsZCBldmVuIHNheSBpdCBzaG91bGQgbm90IGJlIGluIERUUy4gV2UgZG9u
J3QgcHV0IGludG8NCj4gRFRTIHByb3BlcnRpZXMgd2hpY2ggYXJlIGFsd2F5cyB0aGUgc2FtZSwg
YmVjYXVzZSBvdGhlcndpc2UgdGhleSB3b3VsZA0KPiBncm93IGNyYXp5IGJpZy4NCg0KQWx0aG91
Z2ggZnJlcXVlbmN5IGlzIGZpeGVkLCBjbG9jayBuYW1lIG1heSBjaGFuZ2UgZm9yIGRpZmZlcmVu
Y2UgcGxhdGZvcm0uDQoNCiAgICAgICAgICAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJ
TVhfU0NfUl9VU0JfMiBJTVhfU0NfUE1fQ0xLX1BFUj4sDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAJICAgICA8JmNsayBJTVhfU0NfUl9VU0JfMiBJTVhfU0NfUE1fQ0xLX01JU0M+
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCSAgICAgPCZjbGsgSU1YX1NDX1Jf
VVNCXzIgSU1YX1NDX1BNX0NMS19NU1RfQlVTPjsNCiAgICAgICAgICAgICAgIGFzc2lnbmVkLWNs
b2NrLXJhdGVzID0gPDEyNTAwMDAwMD4sIDwxMjAwMDAwMD4sIDwyNTAwMDAwMDA+Ow0KIA0Kc29t
ZSBwbGF0Zm9ybSB1c2UgSU1YX1NDX1JfVVNCXzIsIG90aGVyIHBsYXRmb3JtIG1heSB1c2UgSU1Y
X1NDX1JfVVNCXzMuDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
