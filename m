Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D15623A82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiKJDc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiKJDcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:32:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F32F677;
        Wed,  9 Nov 2022 19:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDBbqNUf+bKKFMnsgMd7eSRBBuBabaMxWY9YpNvjE0TjnOcPSD6+c091gylvP4DEQZnv0TQhY8ezj6NelPHpO712gzmwKRCYKQ8jsCwssZCUIoQuWWGgYarjYyuVLAj5rpWwoPrDhsIKw9W76Qf1cEjqZAKBh4fnVXLHgQoa6KzRulLHoUhgoXNqvCUG/xsNNbpbGPa7GvdZfS4gKEHps2DL1XI8K40KVJ+Q52RwRRRxNnTzN7DT8EvnVzxkaeALhRejbvAL364lRlWRnChF3a1ucOTlkVY9LL0R6j7LTvy5DBxLphrt2R4cId/ng5g9nHgqIbawmzAU5rCqqjKtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es0w/AoQlVoea8+IBAqIcOsq7Lzq9fM/KHU7vi6a+pA=;
 b=NuHWMj1ItyUcxEHzyqD8yo84phXFWYLkh2s378c4BhGxUXa9RqH1DQjLE1D/pkizd0f2K+kR7xzQs5LmTwq5+A8lAW8IDBUMWUaunXIwZbKed7a+su2RhFQHXlrWkvPMGmQRRlnxoaeQEg3ffMz/KEzqg52U57qtgNJY40MXSwjPWG7Dzg74rc9fiEak3GHrkWQ3TRsIg8HbMo1X9hV22RxIpNnnQFTC57I3PrlcAvR0ANWWYegmXDv984YI5tI73bjcYBdPEO7NLtJ0EjoQ49IGZHC5hHkO44phs7Ot3e3X+uQ54axS29Q3muA+kjjmOf8XyUNVh/HOZ9lnkmRZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es0w/AoQlVoea8+IBAqIcOsq7Lzq9fM/KHU7vi6a+pA=;
 b=NStj4hY8EONxd3TiTXHGaQNjpseMpc9qhHsyQkdj7We+1dpVJoOYnFJYuANN3fxqRzj32JxlaHiBpMeq669pIQt79FiFQoeXNRgU2EQaxFUaP8mKZzfPF/Cr4cMyk8DisphnpeyFMQEmlUWRpJQq7y9YN/wA9riRfPJ2+q3GP9k=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 03:32:48 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 03:32:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: improve lpuart32 registers
 clearing when shutdown
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: improve lpuart32 registers
 clearing when shutdown
Thread-Index: AQHY9CidRu5iWxRM2EKrB0CeMqSYbK42gqyAgAD+BIA=
Date:   Thu, 10 Nov 2022 03:32:48 +0000
Message-ID: <AS8PR04MB8404AFEC6186CC5F3F3A105092019@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com>
 <20221109104515.17266-3-sherry.sun@nxp.com>
 <9e682825-3420-fbe3-eb9d-8e864430363a@linux.intel.com>
In-Reply-To: <9e682825-3420-fbe3-eb9d-8e864430363a@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB8PR04MB7116:EE_
x-ms-office365-filtering-correlation-id: f941fc8b-fa34-41a0-0aeb-08dac2cc3d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFwWb128V54431PnhDzOn5JybNm4eQBH8uKJtN/AJv8JDSfqLhBe+xPD6fRXPdKzyAEWweGVVXvMH71OM6lhpjYI89OT+xAIK8CWroE0RSMn/SirX1k8eR06MU+hmhTd3spJY0enBZpjlD0ROR7Eqel/B8t/1dyCBmLOUziN59BaLwDAt+cz6CeyPno0C8gUr72e5eVlw/Tk967Uqzw8kqMPSTDeGMtEw6Fj9dDgLRllT1pyxpCk3mIvDioIJSAdPq2IW6hJIld/u8tgXBuwUkKPN2zA4TbO/tFxemZx/l6QIKEhZ2T4u6Ys/dG4aWtvS8Bo24AMY5ZtrWsM0Ln6uHkjQ+DRa+qzvb80UCfhWKTlN0LAbbX9Qj/rzQ8+dTwNbdjmyy7m3ElckorWifTQ6nNcJjvY1Nzb6bzk72YsYi5vRwVy3/YPcrvW8p4UPEJWTlB1FuRyJ3If26II1DuMMVNJIXo7rAMhESQrPqSvZ5oghVeCpjAh/XWjD1y/4GEM0S7apvpL5GW56tGPdJrc0TowK3UJE63Q9fjzB14woyAXiyeth1i5lkxMb8xHqrw2JH1h0rnhlkEZajBkOhYI3BvHiH510r3O1zD5yGtm7tvGcz9wZ1L0bMcUzk2DzfDfuYtqN+TIDkrthwsCF/y6mtc3yS04L0E3XGmZDo2o16i2TC6L7CuEeYM7p8MyuKixYRYABDHP5pzGEwaLvhaXqNFko5ABUoEDInEjlSevqLF0NCht/9NVVDORr3RPyJeit/DPYJrSmOkMDR1B96HwyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(186003)(83380400001)(86362001)(66574015)(38070700005)(38100700002)(44832011)(122000001)(2906002)(8936002)(41300700001)(5660300002)(52536014)(55016003)(7696005)(478600001)(53546011)(6506007)(9686003)(26005)(8676002)(316002)(66476007)(66556008)(66446008)(64756008)(4326008)(76116006)(71200400001)(66946007)(6916009)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJxbzBxenFMQm9FaEdJdXRVYjFJay8zZUN6UlczcmlwRGY4Rmt5OHF5SUtR?=
 =?utf-8?B?eTRqQW0zTFJvek9lUVFaOTU4VTUwM0Q5RS8reE4zRi9vYnpnSk54b3kxZ2ZH?=
 =?utf-8?B?amdwb3FsUWZDWE5sY3dzVGZOV3lxc05pRE04aXpIeXh3TXVnNFR4UWxxNUNt?=
 =?utf-8?B?dmczc0FvVWlrcVVTSnAzQ0RpeHU2MWpPSDJrN2oySVBBai9DZXo1UDhESW9M?=
 =?utf-8?B?WjEza0ZoeEY3c0g2S29xR2N2OVZVSGFjV0hpRVNZZDM3eXJkbWU0TExFUFc4?=
 =?utf-8?B?UUxHQ3duSXNWT1pUdThDVi8yamxtNS9XU0k2cm53Y3JTRHhiU0NLRzlkVU1m?=
 =?utf-8?B?cXNpVkhGWDFQUHN2NmNTMFNUYkkzVEtxU0NON2U0ZGw0b2Jmck45WVB4cktv?=
 =?utf-8?B?OHRwRlJqY28yTG81SWlSenNyVFhPNlJHM2lMNGR2YzZTNGNvRHk2a2gwdnNx?=
 =?utf-8?B?cUZ6dkQxRG94YXNFMVJvc3Jjbi95bENWb2lYeXBtWjU1VnRUMllxWUt6YlhP?=
 =?utf-8?B?NUs2dXNERlQrRWhsbksyMVM5UzRGcUh1aktqWTF2Y2VFa21aTUNML1ZaVkYx?=
 =?utf-8?B?NXlya2xRa2ZoVTlZd0NmcjFPQUdOMGExVjdLU2c0ZHFNUGhCQnlCUmJPYlMy?=
 =?utf-8?B?RG5GM1NCa1hZYWZSUjluV2wyb1EzUnpwdHpCeExvQjJzR3ZscDIreHNSaWNk?=
 =?utf-8?B?TExVZmd1WXgvWlVBb2J4YXl4VVMydUdhUnJBRmNSMmJWUlJOaTRwM2w4TUp0?=
 =?utf-8?B?ekczUkFxMVJobEFxcUJ6alJuaG4rRkYwYVVTSVJJdDNNcS9TMlNHbFptOUQ1?=
 =?utf-8?B?MTFxUG9QdG00MzRNb29EV1lwRkQwRlpGTFRzYWtvWlhYcmxVYUQ3TFZtQmdC?=
 =?utf-8?B?RUlCQmNmNzY5dmFZazltSTFvOU8wRyt5OXgwazFBYk5MN2lnSkhZVVNQSkZN?=
 =?utf-8?B?Q0JlV1J5SFAyNWsrTU8wdWJGYkc0NUs4cFRmeUxWTEFUUkNSZnZ5TlBLMUtr?=
 =?utf-8?B?N0RsN0hVM3FrbEpXSkxuVk5OR2ZTZlA2bS96KzBxbCtXN0NkQzR1QlF4aW95?=
 =?utf-8?B?ZWsxZXlEY21oVnZjb2tZOFQxN0RESVBORUZFVGhuV1ZwN3ptZWJ5UE4rSkEx?=
 =?utf-8?B?YkR0S3lOQWZtVXMwM2tnYWVsWjBxZ29uY25vTS9BZ25WRXRhQlo0dEVUWkdS?=
 =?utf-8?B?aCtHMU9KemVmVTlHUlJJYXZqYUk5ZWhSQjd6bFd4LzVMMnhtbmxjSkVHaGhZ?=
 =?utf-8?B?b3hIbmIzQzBqOEZPN2hyNncwd1d2UWNZUk9tc3d1VVVrSUtWN2JYZnYzZFA0?=
 =?utf-8?B?U0JOM1lFWERuU0pSMFhVd2o2Y2FuclJrNzNjZUtuSU1SdGZVSjVDclZqSmx2?=
 =?utf-8?B?OG9zM3dDdXRrZVpBWDk0TnlsZGVqcTB4blN4QXBqU2xabnBvOGN5V0RYazZK?=
 =?utf-8?B?QzVGT3BkcTR2NTVDZnJXSVRoYlExRkgzbmNMRm9jZ1pTYVNkNktCZVZISzgr?=
 =?utf-8?B?ZWFabXg2bi96QXg4S2JRMk1iSlV2aWxIYncrdCtYUTFwVHVTOFIzdzg1Nkxo?=
 =?utf-8?B?RE5GdW9Uc09aZkN0VDBURjVaVEQzOU5nU3VVdlpaTCsveGpOY2dSUkZKSVZh?=
 =?utf-8?B?bzdkNE1BWHN3aGJoZ3ZwaXVlK1hGSGlaR0w0TGVlZUZ5aWp4NGNPcE91RTM2?=
 =?utf-8?B?NTJDWGlETnJqNnpWZkxTVnd2YWQ2eHcxL0VKMVFncXl6dVh6emFPVTBjTWI4?=
 =?utf-8?B?U3l1N3Y3QVVGaUhRWnlWMzJHQk9rVTZ6TVdQNmQ4WFY4dGJsNFdvaVlrQWpY?=
 =?utf-8?B?T1lodm1vRGZuV3hFTEc0TVBWRlBTQlp2dHRYSUJMN0lSMnExRjYvVGMyMG5V?=
 =?utf-8?B?YjJ4eThwbWNTTkRtZjhmTHl5Y25TRHBra0ZsK1RqcE9Gd3NLM0w0UmJ4R2Y5?=
 =?utf-8?B?U3QraFNuZFpQdHZPMFExNjA0OVpWaXVMN291UzNueHFPT2FNRHhDZzMyMlZP?=
 =?utf-8?B?MStzK0UzQkVGeWpGRjl3Z2tEZVM1T29ISXd0NlRWWFZabVlKS3VOdDVpSXlN?=
 =?utf-8?B?NUJnTDVwYlBhQVRhSFFzTjNWR0FQZXBDZW91OU5xSWFka2FBajY0eGhRWU5J?=
 =?utf-8?Q?jMhH4SUG+YTF6JlrxYdyiZj9y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f941fc8b-fa34-41a0-0aeb-08dac2cc3d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 03:32:48.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGxDbLaSq1t5vX2GUQziZc+PCGYdJ60m6XgHtyH/tx6hbGefSC98D4U444HxBV2z32f2ZYUpHUUvZ4yB6bBs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0MTHmnIg55pel
IDIwOjE5DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0K
PiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBsaW51eC1zZXJpYWwgPGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMS01MDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBpbXByb3ZlIGxwdWFydDMyIHJlZ2lzdGVycw0KPiBj
bGVhcmluZyB3aGVuIHNodXRkb3duDQo+IA0KPiBPbiBXZWQsIDkgTm92IDIwMjIsIFNoZXJyeSBT
dW4gd3JvdGU6DQo+IA0KPiA+IE5lZWQgdG8gY2xlYXIgdGhlIFVBUlRTVEFUIGFuZCBVQVJUTU9E
SVIgcmVnaXN0ZXJzIHdoZW4gc2h1dGRvd24gdGhlDQo+ID4gdWFydCBwb3J0LCBhbHNvIGNsZWFy
IHRoZSBSeC9UeCBETUEgZW5hYmxlIGJpdHMgYW5kIGxvb3BiYWNrDQo+ID4gY29uZmlndXJhdGlv
biBiaXQuDQo+IA0KPiBUaGlzIGxhY2tzIGFuc3dlciB0byAiV2h5PyIgcXVlc3Rpb24uIFRoaW5r
IGFib3V0IHNvbWVib2R5IG5vdCBhcyBmYW1pbGlhcg0KPiB3aXRoIHRoZSBIVyBhcyB5b3UgYXJl
IGxvb2tpbmcgYmFjayB0byB0aGlzIHZlcnkgY29tbWl0IG1lc3NhZ2UgbGlrZSA1IHllYXJzDQo+
IGZyb20gbm93IGFuZCB3b25kZXJpbmcgd2h5IHRoaXMgY2hhbmdlIHdhcyBtYWRlLg0KPiANCj4g
UHJlZmVycmFibHkgbWFrZSBhIHNlcGFyYXRlIGNoYW5nZSBvdXQgb2YgYWxsIHRoZXNlIGZvdXIg
Y2hhbmdlcyBpZiB0aGUNCj4gYW5zd2VycyB0byB3aHkgcXVlc3Rpb24gYXJlIGRpZmZlcmVudC4N
Cj4gDQo+IEl0IHdvdWxkIGFsc28gaGVscCBpbiBkZWNpZGluZyB3aGV0aGVyIEZpeGVzIHRhZyBp
cyBuZWNlc3Nhcnkgb3Igbm90IHNpbmNlIHlvdQ0KPiBkaWRuJ3Qgc2VlbSB0byBpbmNsdWRlLg0K
DQpIaSBJbHBvLA0KDQpPaywgbWF5YmUgSSBuZWVkIHRvIHNlcGFyYXRlIHRoZSBmb3VyIGNoYW5n
ZXMgaW4gbHB1YXJ0MzJfc2h1dGRvd24oKSB0byBiZXR0ZXIgZGVzY3JpYmUgdGhlICJ3aHkiLiBU
aGFua3MgZm9yIHRoZSBjb21tZW50cy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KDQo+IA0K
PiAtLQ0KPiAgaS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5j
IHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9mc2xfbHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5k
ZXggZjVhMGExNGZhMzY2Li40M2Q5ZDZhNmU5NGENCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFs
L2ZzbF9scHVhcnQuYw0KPiA+IEBAIC0xNzcxLDExICsxNzcxLDIyIEBAIHN0YXRpYyB2b2lkIGxw
dWFydDMyX3NodXRkb3duKHN0cnVjdA0KPiB1YXJ0X3BvcnQNCj4gPiAqcG9ydCkNCj4gPg0KPiA+
ICAJc3Bpbl9sb2NrX2lycXNhdmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsNCj4gPg0KPiA+ICsJLyog
Y2xlYXIgc3RhdHVlICovDQo+ID4gKwl0ZW1wID0gbHB1YXJ0MzJfcmVhZCgmc3BvcnQtPnBvcnQs
IFVBUlRTVEFUKTsNCj4gPiArCWxwdWFydDMyX3dyaXRlKCZzcG9ydC0+cG9ydCwgdGVtcCwgVUFS
VFNUQVQpOw0KPiA+ICsNCj4gPiArCS8qIGRpc2FibGUgUngvVHggRE1BICovDQo+ID4gKwl0ZW1w
ID0gbHB1YXJ0MzJfcmVhZChwb3J0LCBVQVJUQkFVRCk7DQo+ID4gKwl0ZW1wICY9IH4oVUFSVEJB
VURfVERNQUUgfCBVQVJUQkFVRF9SRE1BRSk7DQo+ID4gKwlscHVhcnQzMl93cml0ZShwb3J0LCB0
ZW1wLCBVQVJUQkFVRCk7DQo+ID4gKw0KPiA+ICAJLyogZGlzYWJsZSBSeC9UeCBhbmQgaW50ZXJy
dXB0cyAqLw0KPiA+ICAJdGVtcCA9IGxwdWFydDMyX3JlYWQocG9ydCwgVUFSVENUUkwpOw0KPiA+
ICAJdGVtcCAmPSB+KFVBUlRDVFJMX1RFIHwgVUFSVENUUkxfUkUgfCBVQVJUQ1RSTF9JTElFIHwN
Cj4gPiAtCQkJVUFSVENUUkxfVElFIHwgVUFSVENUUkxfVENJRSB8IFVBUlRDVFJMX1JJRSk7DQo+
ID4gKwkJCVVBUlRDVFJMX1RJRSB8IFVBUlRDVFJMX1RDSUUgfCBVQVJUQ1RSTF9SSUUgfA0KPiA+
ICsJCQlVQVJUQ1RSTF9MT09QUyk7DQo+ID4gIAlscHVhcnQzMl93cml0ZShwb3J0LCB0ZW1wLCBV
QVJUQ1RSTCk7DQo+ID4gKwlscHVhcnQzMl93cml0ZShwb3J0LCAwLCBVQVJUTU9ESVIpOw0KPiA+
DQo+ID4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7DQo+ID4N
Cj4gPg0K
