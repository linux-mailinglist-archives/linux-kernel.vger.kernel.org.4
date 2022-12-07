Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB156455CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLGIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLGIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:52:27 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBE26566;
        Wed,  7 Dec 2022 00:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKeZ6zu4/J0reJ4H8Ychgta0xNPgVfshqfVSh+tdUx+SSaXtH2rEjC2wbARrKcpBm2cxJeWIHRKB2wyJe6P7RkCd8qcZZL5BIk9rzCO4xWUhLaDHP11n4V0rqVsNui3hOeSxQAHovdpG906/e0ca8SrEfjuJBXLNC/O58DBSk4eyJu93bcTy/qqDHkwIZoB2ZYRxfi6zY6U8v+OEj88v5hI/KbTszMk+Bi73Q/f+9kBTz1xPhWg7NoRZua1STWerOxAHOgwWcV2TH5z/U6hxJ5vXCMEDgR+3N/5Wjc6zktQoDwf8CsWWxK+TcyiXM/EN5128sibA6QbadiNsKwwklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksC8pl8YwXYSI29qN++cX36yVZ+aDW3gOmv6M0rOIqo=;
 b=Mh9fBX70qTYwuUlrqO3KNKoSUGkLHj5jpPdiINSSnKZX1Mu3D0Pxc35VsDSGIqgPKL3Uyl24Bvd+nYIm51tO1zhcyAikDKG4MicQOVF5RYJg8+a/xHZ0SuwaLArkKr7KNF8pv0mXKKjo2hRKdJ7KA4D/YPo+WqcHdGcGzTQGfuKhGy8v2mt2N8pxXm7nYpbDSYgbGKhx0nhYHYDv0wHzWAuzp783aWCeBJmtsl3wP/92vY6NynrNCz+vfxrD2jIHZtNiyaI4D560Hqu50qCDZeBmWuL4Bwr6t/Zmi44R7lndLG18afni4C1VIEcmC72oVoXwc8eV/xiFfVrT2qOGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksC8pl8YwXYSI29qN++cX36yVZ+aDW3gOmv6M0rOIqo=;
 b=QvF7yDluX8LHMnJ59+d60k4njKPkBt0mUzL1TyvrTWzCrBGJf3ztCEqlbFfgOkvASC1CxCMoe/5SDWa6NodPFxZdr8+WqbhrzC9kc7BCsk3EooSm/mPpMHbG2/XEP1iY8hRv8LCDpOhvzu+puYYZBYo5fILIsI9msSavjUpY168=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6940.eurprd04.prod.outlook.com (2603:10a6:10:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 7 Dec
 2022 08:49:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 08:49:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_HEADERS_ONLY flag
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_HEADERS_ONLY flag
Thread-Index: AQHYldMfa/yDJFvL5023OK69Vdnq9a5Otz4AgAH92YCAEMLtAIAAkc6AgAD7uIA=
Date:   Wed, 7 Dec 2022 08:49:36 +0000
Message-ID: <AM6PR04MB6341F861DA6493045F0CE070E71A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220712093754.23370-1-ming.qian@nxp.com>
         <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
         <35256805b1ce0b2b7533f53f658c799a37255469.camel@ndufresne.ca>
         <34d5c5d7-cedd-a12c-557b-33274f62cf70@xs4all.nl>
 <3c3a7b0c053c5366be4ad0c4a9a3bd205aaea731.camel@ndufresne.ca>
In-Reply-To: <3c3a7b0c053c5366be4ad0c4a9a3bd205aaea731.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DB8PR04MB6940:EE_
x-ms-office365-filtering-correlation-id: 06ba9ce3-89ba-4da7-be96-08dad82ff86f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4wiq9ZSbKvH1V4sOIlNzBxg4wW+BqHmtiSrokXzhtjo5ka4kvISWZWaQNJE1VrPxmOPFMg97Mmoj5u8736Eh6pqDgTSqziCRUmh0nopUS8+31rQxpF1C642b5yc6qn2yVm2klbEa4KcQd/nr5xKGusHH081Wfqb5boMWBvz4q6f/4vX6KAlNgmNEMp6dNQ7NRGFKyla+niXt8ZM23dct9b5oBQtr6fN+08I5qLpvZ8+H7U4u3elrLFrc8wQFse2fPGkzY0ulzA2LWX/NxzIUGiTovYHgzZDf5EnapP7J0jxAIrBi7rdxqOm+QRY/3lihBFJfHH5kd2tttAPca/D2TmyTlEfaj+lovkkuF57ykWQMD2uSeJms1l2rOWHRJpQ3yT411o42nqB4Xl+hbSf7AMbh+s1sCiaDjVyq+nNGOpf3XMJDOsdOpX3LZEktht49lbu6BvAcNutX8SwTUr8TuIT1Ibt21lk9yHSzEjbHGHkSyqQx8pn8sb2nnCXDThvgFhASNlEf4FEShhBPYduNAUi2NxPWqdKYvdsvj26OI1NtimFlfGiKEMtmVOpibS4GNr9V9vV29PmcgEv8+OAnp+CHyRgkpgSWq5J0Ckvi64qbWnWptKRNENtIqp8OOtrkVU3t9BjuRoxZDluOoQAPbrFH24rS/lLsrZ+cnB9CzLaoJTMOEBqBEDz2xa+WH2iwiXLjdhcOKvu2s51/xtlRLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199015)(38070700005)(55016003)(86362001)(33656002)(6506007)(478600001)(7696005)(71200400001)(9686003)(8936002)(8676002)(26005)(7416002)(44832011)(52536014)(41300700001)(4326008)(54906003)(76116006)(110136005)(66446008)(316002)(64756008)(2906002)(66556008)(66946007)(66476007)(5660300002)(38100700002)(186003)(83380400001)(122000001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWo0citIc0RvUlg5aUlNV3lJc1RlckVYSzRQVDFaRm4rM1dFWm1LQW14a2ZL?=
 =?utf-8?B?RHFSYk5HcUQvMUdKMThQdjc0aGxYenlQcGE5dDNIUjNxSC9tY2RpYkFITkZq?=
 =?utf-8?B?KzJncWpGRHMvRjFiSTVqb1gyNldIUVljeDNheFc0UjRoNFp1WS8rR3dMRytv?=
 =?utf-8?B?aGY1MUNwYVdFd2pJdUZzS2xOSVhqZWNPY3pZZStxTzM1cWp5aGhHNml2QU1r?=
 =?utf-8?B?L2tHVjZnQkFRbnRJWkdOemhpRTZPeFNwa09ad3pjNXFUOHB2Ty9IN2E4T1ln?=
 =?utf-8?B?bWFETUdtZ1BCUFZOdmxWOWVWdVJLeUxVOWo1N0RFM1VURkRxV2lnZ0xialRD?=
 =?utf-8?B?dkE1aWJMWGZib29IQ1FJbSsvSTlLam1OQmM1Rks0dXAyVjAvTUtRUy8wTGFu?=
 =?utf-8?B?VHhhcEg1ZzkvNm4yQkdxTitYR0JkcVRHc2pBaDBkbFVNTUNnME9nNCtZMEZn?=
 =?utf-8?B?dU5XT2V6YnN5bFpXY3hnN2ZrbFRSSFBvempxa2N3MDZhbCtEZnAxR3dLbmdi?=
 =?utf-8?B?NE1IODlyQjNEWjRLa0Nqdm5zMU9rYjBsalcwd2sybzFuOURQeEd5Z244R0I0?=
 =?utf-8?B?aXlwZzFQeWRHdlBaaEpIeDZsSzZWZkJTSHZuaTgwdGFJaUpOR2R5NVo4QmJq?=
 =?utf-8?B?TFVvSXBkYktzaThUVVh1YTdYYUZtNEFpZkRHd0hDSnc4K1pBb2Q2b1UrUWZY?=
 =?utf-8?B?Yy9FT1ZKT08rN212dUowQjNBTFpmNmZ4d3B2ZmczWWlMbGJ3ajB2RzF6allu?=
 =?utf-8?B?Z2ErTUNtQTBmYmRwZ2JNS1Jlby90dndXQm4vL1ZKYnZNVklxZUZYaHRuaWF6?=
 =?utf-8?B?ajlnUUR1UDV3QmFQYlVaVzJod3VwRmtpWXJjbnlGMFlKd0ZRQkZ4Z3pjbHlh?=
 =?utf-8?B?ODZzMjY1YWY0UFBseXgwWTdwWDRYUVBCUm15akpnUW1lSGt4VUUrNGJmL01t?=
 =?utf-8?B?aVp4ZDY2TUE5K0xidG9SRTZuaDYwTEt1VElPRHJHUkRxOWx2VDBlSkxQZlZI?=
 =?utf-8?B?R1NuNUVZLzViQU9nZDVKZENxckxObHZVa0FidTJ5WlA5N1lIMGwxbWFOUE9v?=
 =?utf-8?B?ME1DRitWUHZQYVdVczZyOXQ5Z21XNDhQQjdraWwrMFRkNm1jVTJ3KzdGK0Fr?=
 =?utf-8?B?V0tiZGxwdm0xM0VSa0tjV1NiL3JWK2gzVXpDRHpJTWdXanNQZmc5ZzlGRzEy?=
 =?utf-8?B?WFpwZ0RSNW8vVStMVDkwTXBCU1BZZTJWU283ck1sajdvSnd3cWwvUXNnMkcx?=
 =?utf-8?B?ekJFM25VNnp4SjB6ZGlST1loZE5VRmxwajdsUWZxcXJIVkFXN3Ntb05CdHZt?=
 =?utf-8?B?akRrZS9zdWNremE5SDlZZVZ1a3ZSZEs2emNRSHg0MENwUk92RVIybENjYXhK?=
 =?utf-8?B?aUJORzdTclEwVDNuOE1HSVQ4QjBMK2hDSFRDMDB4Vkl1ZzBabWVUcjY1NENi?=
 =?utf-8?B?VVcxT21DN2pKejVXSWp5QW5wQnZuWDA5MXhTY25XQU94RVBGRi9UcjFjckN0?=
 =?utf-8?B?Y3dhY29ka3c4QjE1QXJSbzFKb3FaUCtBT2ltVGswL2xXajh1NWcreWVwa3JJ?=
 =?utf-8?B?STBNbDN2cDhzZXRBRFNVM2x6Z3B3QjlYVjNwci8vZHNZZHhqajkvcWtBdnV5?=
 =?utf-8?B?Vyt5VzJUeDkxRDZXdEVEdVkrQmJRMFhkNlpwQ0FWUm4wZkI4TnhNRFhQUFEx?=
 =?utf-8?B?WHBTQU94WUR0Q25VTTkxS2VBME1ua3Q0UGpZZFMxakE5UC81QnJsZEMvZThU?=
 =?utf-8?B?WnNoVmxRQWdaN3RYVGtRV3l4ZEwreVdEVDF2aXo0dnhIY3dNdkF2WmdBNFlk?=
 =?utf-8?B?QXBrSldkRmI0UGNXSlIrZEZ5ekpuWmJZSTZVVmZnWlJwNTR1V1hEZXpDTjZC?=
 =?utf-8?B?cExwaTFLZ3crM3lURFhCUkpIVjBNNmFJQlNHZVJyeENzUE00NkdON0tzN0F3?=
 =?utf-8?B?QzNHaWN6ZUZxK3lUdld1c0VYYWsrRjVWazA5NnhDcjZSQyt0TUU0SUFwU2xP?=
 =?utf-8?B?R1JFR0VVL2lKM0loVmIybVpRMldJYlVHdTVhaXl6eVdiQzNPUHdHZTIvejll?=
 =?utf-8?B?QzRLMTRPcUtPNU5BcU82aEp6SXZ2MkZ3QXJWNFZmczJRUHVjMytCWG5zY085?=
 =?utf-8?Q?MH6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ba9ce3-89ba-4da7-be96-08dad82ff86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 08:49:36.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTW6O9Agc33MRjmpLYT4COOtYX0TIWOMFpenptTA4TgGNeTEoaWCEM+Ladc8BKUBpGuV4ASiQ5vjBpa9BPFdpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE5pY29sYXMgRHVmcmVzbmUg
PG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPkxlIG1hcmRpIDA2IGTDqWNlbWJyZSAyMDIyIMOgIDEw
OjA1ICswMTAwLCBIYW5zIFZlcmt1aWwgYSDDqWNyaXQgOg0KPj4gPiBGb3IgZGVjb2RlcnMsIGlm
IGEgYSBkZWNvZGVyIGlzIGluICJzZXBhcmF0ZSBtb2RlIiwgaXQgc2VlbXMgdGhhdA0KPj4gPiBz
ZW5kaW5nIGhlYWRlcnMgbXVzdCBoYXBwZW4gdGhpcyB3YXkuIElmIHRoaXMgdXNlcyBhIHNlcGFy
YXRlIHBhdGgNCj4+ID4gaW50ZXJuYWxseSwgdGhlIGtlcm5lbCBuZWVkcyBhbHNvIHRvIGJlIGF3
YXJlIHdoaWNoIGJ1ZmZlcnMgYXJlIHdoYXQNCj4+ID4gKGFuZCB3ZSBkb24ndCBwYXJzZSBpbiB0
aGUga2VybmVsKS4gSW4gdmVyeSBiYXNpYyBjYXNlLCB0aGUgZHJpdmVyDQo+PiA+IGFzc3VtZSB0
aGF0IHRoZSBmaXJzdCBidWZmZXIgYWZ0ZXIgc3RyZWFtb24gaXMgYSBoZWFkZXIsIGJ1dCB0aGF0
DQo+PiA+IHByZXZlbnRzIHJlc29sdXRpb24gY2hhbmdlcyB3aXRob3V0IGENCj4+ID4gZHJhaW4r
Zmx1c2gsIHdoaWNoIGFuZHJvaWQgYW5kIGNocm9tZW9zIGZvbGtzIHNlZW1zIHRvIHVzZS4gKEkN
Cj4+ID4gZHJhaW4rYWx3YXlzIGRyYWluDQo+PiA+IGFuZA0KPj4gPiBmbHVzaCBmb3Igd2hhdCBJ
J20gZG9pbmcpLg0KPj4NCj4+IE9LLCB0aGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4NCj4+
DQo+PiBTbyBpZiB0aGlzIGlzIGdvaW5nIHRvIGJlIGFkZGVkLCB0aGVuIGV4aXN0aW5nIGRyaXZl
cnMgdGhhdCB1c2UNCj4+IFY0TDJfTVBFR19WSURFT19IRUFERVJfTU9ERV9TRVBBUkFURSBoYXZl
IHRvIGJlIGFkYXB0ZWQgdG8gdXNlDQo+dGhlIG5ldw0KPj4gZmxhZyBhcyB3ZWxsLg0KPj4NCj4+
IEZyb20gd2hhdCBJIGNhbiB0ZWxsIHRob3NlIGFyZSB0aGUgbWVkaWF0ZWsgdmNvZGVjLCB2ZW51
cyBhbmQgczVwLW1mYw0KPj4gZW5jb2RlcnMuDQo+PiBJIHN1c3BlY3QvaG9wZSB0aGF0IGl0IHdv
bid0IGJlIHRvbyBkaWZmaWN1bHQgdG8gYWRkIHRoaXMgbmV3IGZsYWcgdGhlcmUuDQo+DQo+VGhl
IGV4ZXJjaXNlIHdpbGwgYWxzbyBiZSB2ZXJ5IGluZm9ybWF0aXZlIGZvciB0aGUgcmV2aWV3ZXJz
LCBzbyB5ZXMsIEkgd291bGQNCj5hc2sgTWluZyB0byB1cGRhdGUgYWxsIHRoZSBkcml2ZXJzLCB0
aG91Z2ggaXRzIGZpbmUgdG8gb25seSBjb21waWxlIHRlc3QgdGhpcyBhbmQNCj5sZWF2ZSBpdCB0
byB0aGUgbWFpbnRhaW5lcnMgdG8gdmVyaWZ5IChhdCBsZWFzdCB0aGF0J3MgbXkgb3Bpbmlvbiku
IEkgZG9uJ3Qgc2VlIHRoaXMNCj5jaGFuZ2UgYXMgYSBicmVhaywgYXMgYW55IGV4aXN0aW5nIHVz
ZXJzcGFjZSB3aWxsIGp1c3QgaWdub3JlIHRoaXMsIGFuZCBtYXliZQ0KPm1hbmFnZWQgdG8gc3Vw
cG9ydCBpdCBieSBkZWVwIHBhcnNpbmcgKHdoaWNoIHdpbGwga2VlcCB3b3JraW5nKS4NCj5PdGhl
cndpc2UsIGV4aXN0aW5nIHVzZXJzcGFjZSB1c2luZyB0aGlzIG1vZGUgaGF2ZSBiZWVuIGJyb2tl
biBmb3INCj5yZW5lZ290aWF0aW9uLCBhbmQgdGhhdCBjaGFuZ2Ugd2lsbCBub3QgZGV0ZXJpb3Jh
dGUgKG5vciBpbXByb3ZlKSB0aGUgZW5kDQo+cmVzdWx0Lg0KPg0KPk5pY29sYXMNCj4NCj4+DQo+
PiBSZWdhcmRzLA0KPj4NCj4+ICAgICAgIEhhbnMNCg0KSGkgSGFucyBhbmQgTmljb2xhcywNCiAg
ICBJJ2xsIHRyeSB0byBwcmVwYXJlIHRoZSBwYXRjaCB0byB1cGRhdGUgYWxsIHRoZSBkcml2ZXJz
IHRoYXQgbmVlZHMgdG8gYXBwbHkgdGhpcyBmbGFnLg0KTWluZw0KDQo=
