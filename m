Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF25FAE07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJKIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:07:35 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150052.outbound.protection.outlook.com [40.107.15.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A37B1C2;
        Tue, 11 Oct 2022 01:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcC2YheicjHryyu86GD55QLrh7xkn+zN9Bm0pgRYhAiy1D/wW67OUVbnp2hI41mGVpXWH/bQjGzzUb6RXkTy0PdvRzu8UWF4e5iJX/hjkDY5AJQSoENoDB8hapVVSLwonfji1HxnwCBxrYBt1L+k+koc1zKUqcHxjEIhP2d3et1U4uHqW5GClKOtZWwY1exL/7DtSZYyIgj6ltNZiq3f0oYI7fiqIHdTkmL2BD73DHgao+z3Q/HwArcpm6ndWYS9BAIqcy6OOADYcnov8CTLLzXG6zIaS3G0YqEvs5aJqMfoYKF7199YmWeOYxK8qzaupXRGc8mXmbyKk5aP4V1+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRwzhZ97nCu/EhDwWAbCJEoovz4w4I3pi09l09W6ycY=;
 b=J8ajPVh4yTU3aUKd7zf6l3yPIXAhMKb1YOJHa43HHBzvI+5i4DoON9jiRdckVAzyLZAyY6Mm84A7rtj8PDsvfCuca5EVPp64/MbstIhD3iHqK8XeT49Urcs31qVanaXz8/8dKZxhtPWwTrYSpDvrM7SiPQT+qAb9lb9q2VLyq5+2KL78L6As+644cahOuSImJE8Uzou3Dauld8eHAoRStiYcbjqTCMdHOJqxozqJYbDRGtPnksd8it+24fqKA14TgA5BukMsrSYch85R26Ste6uS6ykbySYVQvk9m9x6z6SOft8ymKwkrojfWDuYqXCHDMMmRyY3cTd5wIYJnUp0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRwzhZ97nCu/EhDwWAbCJEoovz4w4I3pi09l09W6ycY=;
 b=GFltTYfSQct6EE34I7ozLdWbOClRWcL3kp/6EISEPLQ2bpB9ZRcAqUlVXeLZH76SRlrgHQ+rQ7XqyWEh3EGHuMaPA8/1qIdWM54FSx1PrzCdpvIjS1faVAFwQx80VT88XGlSnuA4JzguYZIv6XmXzRw2V+g1WZg+2PkqVvR+rA4=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8782.eurprd04.prod.outlook.com (2603:10a6:102:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 08:07:28 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6a46:130:6b95:645]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6a46:130:6b95:645%6]) with mapi id 15.20.5676.034; Tue, 11 Oct 2022
 08:07:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Topic: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Index: AQHY0+EeaAH9c/DrIUi1YG5YmLZWk632OyYAgAAB3mCAAAXMAIABWEgQgABV9gCADfVVEIABgd0AgAF1HhA=
Date:   Tue, 11 Oct 2022 08:07:28 +0000
Message-ID: <AS8PR04MB8404CB3E77A112C0F44E2EB392239@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
 <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
 <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <b4779edd-200-c7df-4bde-7f434fdefa@linux.intel.com>
 <AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <20221010090930.GA23968@wunner.de>
In-Reply-To: <20221010090930.GA23968@wunner.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAXPR04MB8782:EE_
x-ms-office365-filtering-correlation-id: 05aa1511-63ad-4e9e-4cfe-08daab5fa3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oh78b4qLhkTkp1kF6JhCxQqXVG9+FdzEG8wZ1UIIwBDWIcvcyTkqGluFmvGH6+v74G62GpiQn/4QGwVBp9qvirh2Ko5JHneivbj7y1mA3FSSleNCY/3VX4l7nlT/lrAePmOiodYHJ1JW4SaN0n+nX1OI2i2kNm+VlXKsUFL72la5HvZV86RIvBorMHRB3GMi85Zu0k6TKRaOKBNM7no26Trhn0ZQQSbsoTUfg5X0GizTqyb8CoTS9pO1IuXkdRlG7JKPuGcTX7O7aI603l0KiSP1tYJdR2kJ2Nm/0lx1RyN335Qhk5MRqOwJ7MoMIPZUuum+kVZ2oMwYql7mswNMGdIoOGmFCjRK/E4Be7LvkjARUw6n/aplScls+b9Ep7f05dmgxRCIK5+K4wuoWL4CtGz2qLLT4w3RfkP/Q8rmixIApthOGx7dZF7lgdPeqLusXuf/xYYipohjpSwsanut7noFWh61XmGb0miPaJPK+xehNo9fGqtfpJbVpFjg6R6NYWkyIrVy7Vt5osUFqmpZjdn+u6JR27ZjErTcxUCYQr1MWzGfImjwWMirKM9Jwl7NTVgCd6Atnfdi5Hju/ey8jyGS7fIbqn0vFNuLZpbYsDxJBbLOfLo/q4S/tpgcnVbwuOmV1WOnLSc7JbcBd3BqybEW2T4G3QpBR7AnXGNKSlepVEcfNzTRMba/qImUFZHfPKoimx2/B9V7IyLOdEemE0stHJs3BKqMjHZWEyHFXihYaALYzM1BPOACQ+UsY+bceZFIbw5XyZvpZqftTNBZWpKOfC74ahtT7wH2DmRY/5lJmIIqxmkEXKeNqzLpviw5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(316002)(66946007)(76116006)(66446008)(66556008)(86362001)(4326008)(44832011)(66476007)(64756008)(6916009)(2906002)(5660300002)(8676002)(8936002)(33656002)(41300700001)(83380400001)(186003)(38100700002)(6506007)(54906003)(71200400001)(478600001)(38070700005)(122000001)(55016003)(66574015)(26005)(9686003)(7696005)(52536014)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDU3K0NmWVVjVU9wbkJmL2ZQdFV3VHplSXNXVGZGWE1lSDJ5RWxCRU5MS2V6?=
 =?utf-8?B?YSswV0RMMm5ua0RnNUlRK0c3MUNDZW1MWWpwYlo1cjBaUWI3VUE1QmZFQTlS?=
 =?utf-8?B?N0VSK08xcWlMODRvQXZlNkdzT0xZWG9rN1NOU3czMCsvczVhaEtyOWxvekZn?=
 =?utf-8?B?VGs3REdzdDdrYWZ3NCtNR09OdWt6N1puWUQvK2g2OEhHZGkzZ29rdSs2ZjBH?=
 =?utf-8?B?eEt1MmhXbUd3V1B2V1RQVUdmTndJREYzMWlsaVBIb1VXRWJrVm9tNWM1UzBy?=
 =?utf-8?B?WGR2K0FHaERaalQ4d3YvRWwwSWpsTkpWT3FRLzhITmdJaFl5Y3RKS0N5bk9a?=
 =?utf-8?B?UzlmTVFjQkFBcDN5T09YcjhZc3FmOTB6TGVkcHQvZU5iclAzeE9WRldsWW5T?=
 =?utf-8?B?NWdTZFpTalQxYU1RNENQL0c5S3hWN3JodzZtcU1FVXFlZjBsNlhYRWl0Z29Y?=
 =?utf-8?B?eDNLR1VDYktDN1RNOUEraXFuclIxUHhjZFVsTHZKa1hDamVUa3hLek54M3l5?=
 =?utf-8?B?TjdLK1Z3Wm9ocWlUMlJaK01nRTY0ak5TVGVXaHl5clV3bDhDa1JSN1hia05V?=
 =?utf-8?B?YS9IM29ZVnluYnJtUXgwYkpiNWZqUnM0a3lFZnA3cGxDMUZOMmszSkFFeCtU?=
 =?utf-8?B?bmpGYlFYZytISHpnOGd5V2JPSm1XNWNGTDE2SlVweEpjY2VxMGp1ZUxUaGhJ?=
 =?utf-8?B?OVRISHdKZDJ6L3hSR0U1bW1UNEVFT2k1MDlwSEVUWTFJcnA0QTNlMFhjcjdY?=
 =?utf-8?B?MzAvYmU2MDRXbURRMUhFS3JQbkRYRnpkeE1wN05RNHAxcFpiY3dqZUN2emhO?=
 =?utf-8?B?QkpnWHlSVUNHb0UyL3NiOU5qL1grVFBPQys1Y3JLUWJjb0NqK2xpV29PT2JQ?=
 =?utf-8?B?ZVpMNUxIbTl5TFpmeGhwK2M3QlIyVFRGbkdadklEeGhCZEppQlBPTmZtUDd3?=
 =?utf-8?B?VUFWd0JUSCthNVh4ektZYk1XK21ySi9yMHhCWnhZNHd2eDVCekRDYW13RlZP?=
 =?utf-8?B?cGY1dnNVUGdpMThZVm1hY2pFeklLbUgzUktxdTlUdXpMMlhJcjFtaWJSU0hy?=
 =?utf-8?B?WjFUNWhCeUhTYzZwTGYvRHBhR0F1ZDV3UXZ2TGFKSmYrY3owY2hMZExBdjZz?=
 =?utf-8?B?blFMODYzc0RPUmdtUjl0WUhITjVxK3FuVGhpU2pFeHFUQkFwOVFCNW5kRGlr?=
 =?utf-8?B?Rnp0TjZqT0VobzFvaVJwMVp5TlRlQVg0TzB5MVpSUEpUQ1ZoK3dMNG5RdXNV?=
 =?utf-8?B?bkJzbnNtS3JoaUs5cG9IaXJ6RGRZMmYrdFZ0SzhEK09aQWM5eVFLV2tIYWNp?=
 =?utf-8?B?Z0hlWmJ2dnRSRldaZm9oOXg1Nk83Q1VSSUpXT1dXS00xb0ZUWHRyVTJsYkZu?=
 =?utf-8?B?dm9URDRKYlpsWEhNa1ZLa3hONTdVM3F1dFFqTTRGZmhDNDhjTDFlcnNDWWlM?=
 =?utf-8?B?N3BwbE11SmhSTkZ4OTNlRHd5RzY5Q2FrQTU2VEo1dC9DTXdNTVNDSS8zR0Rl?=
 =?utf-8?B?ZWsvNTJrME8zU2tOdElrejFEOG93UVpQN3ViNUFna3RvVmRqQUt6NFlLMVB2?=
 =?utf-8?B?MkNOSXl2Sk5JR0RuK0doMzFzSm9qTE1IQkJxNWFUSjFBNjBUclQ3c0IwM3o3?=
 =?utf-8?B?V0pZMWV5ZXB4WVQ4S2hSNTlGMy9GaDRndFl4RkQ4MmZIbWtJWUVjMFkvQmZy?=
 =?utf-8?B?NTcxRWJTL0ljYmFWOXhoU3hjbzBuamZCMTV6ZHVwNm9lQ1B0Mksxa0lia3RQ?=
 =?utf-8?B?eXNUMFEyb0orK0piQm1tazMyTlVPT3BLb2VuR3V5NlU4cDE1Tm1IMW9KNjF6?=
 =?utf-8?B?OHM2Qkc3dTJITlM2czNIUTNjRkkyd0M0V1NJMHhSbktua1NYUEY2b0FrWFln?=
 =?utf-8?B?QmR6ZGJzZDQzU0JFbUNtUFpuUFgvMVJnQVZXcGhPemhGWW93a3VDYytjN21R?=
 =?utf-8?B?SmFJdlUyb1JtVTZERnBseWQ5TUVOSDhBUGZTeStmeUt4V3hwTHI5U3FHTjNz?=
 =?utf-8?B?SjNGcW55UkhVdlNSWWxHa2Rmekk3aFZPWEkwMXJZbzJOejFod0U0THR5Q1hp?=
 =?utf-8?B?WGtjUXNXbS9RY2djUEVuWlRFSEJKM2ZNM3UxYW5kWlZYa2FySlhieTlzODNX?=
 =?utf-8?Q?xO6Kzmd4bmnIyqAojU2jGttyC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05aa1511-63ad-4e9e-4cfe-08daab5fa3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 08:07:28.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7FE3tBH5PLxsDEu0Jadjwr9Dy72FRwkmWMoxfU2IKMzA0jRnb1O1GtyLQ3U3WwvKbbpEIbV7oqrwTAECmmqqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgV3VubmVyIDxs
dWthc0B3dW5uZXIuZGU+DQo+IFNlbnQ6IDIwMjLlubQxMOaciDEw5pelIDE3OjEwDQo+IFRvOiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBJbHBvIErDpHJ2aW5lbiA8aWxw
by5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+
OyBsaW51eC1zZXJpYWwNCj4gPGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwtDQo+IGxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAic2VyaWFsOiBmc2xfbHB1
YXJ0OiBSZXNldCBwcmlvciB0byByZWdpc3RyYXRpb24iDQo+IA0KPiBPbiBTdW4sIE9jdCAwOSwg
MjAyMiBhdCAxMDoyMzoxM0FNICswMDAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEkgYW0gbm90
IGZhbWlsaWFyIHdpdGggODI1MCBzZXJpYWwsIGJ1dCBhdCBsZWFzdCBmb3IgaW14IHVhcnQgZHJp
dmVyDQo+ID4gYW5kIGxwdWFydCBkcml2ZXIsIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3IgaXMgc2Ft
ZS4NCj4gPiBGb3IgdGhlICJyZWFsIiBjb25zb2xlcyAoZXZlcnl0aGluZyB3aGljaCBpcyBub3Qg
YSBib290Y29uc29sZSksIHRoZQ0KPiA+IChwb3J0KS0+Y29ucyBhbmQgKHBvcnQpLT5jb25zLT5p
bmRleCBhcmUgaW5pdGlhbGl6ZWQgdGhyb3VnaA0KPiA+IHVhcnRfYWRkX29uZV9wb3J0KCktPnVh
cnRfY29uZmlndXJlX3BvcnQoKS0+cmVnaXN0ZXJfY29uc29sZSgpLT4NCj4gPiB0cnlfZW5hYmxl
X25ld19jb25zb2xlKCksIGhlcmUgdGhlIGNvbnNvbGUgaW5kZXggaXMgYXNzaWduZWQgYnkgdGhl
DQo+ID4gY29uc29sZSBjbWRsaW5lIHBhcmFtZXRlcnMuDQo+IA0KPiBIbSwgdWFydF9hZGRfb25l
X3BvcnQoKSBkb2VzIHRoZSBmb2xsb3dpbmcgKmJlZm9yZSogY2FsbGluZw0KPiB1YXJ0X2NvbmZp
Z3VyZV9wb3J0KCk6DQo+IA0KPiAJLyoNCj4gCSAqIElmIHRoaXMgcG9ydCBpcyBpbiB1c2UgYXMg
YSBjb25zb2xlIHRoZW4gdGhlIHNwaW5sb2NrIGlzIGFscmVhZHkNCj4gCSAqIGluaXRpYWxpc2Vk
Lg0KPiAJICovDQo+IAlpZiAoIXVhcnRfY29uc29sZV9lbmFibGVkKHVwb3J0KSkNCj4gCQl1YXJ0
X3BvcnRfc3Bpbl9sb2NrX2luaXQodXBvcnQpOw0KPiANCj4gSXQgc291bmRzIGxpa2UgaW4gdGhl
IGNhc2Ugb2YgZnNsX2xwdWFydC5jLCB0aGUgc3BpbiBsb2NrIGlzICphbHdheXMqIGluaXRpYWxp
emVkLA0KPiBldmVuIHRob3VnaCBhIGNvbmN1cnJlbnQgbHB1YXJ0X2NvbnNvbGVfd3JpdGUoKSBt
YXkgYmUgaG9sZGluZyBpdC4gIFRoYXQncw0KPiBub3Qgc29sdmVkIGJ5IG1vdmluZyBscHVhcnRf
Z2xvYmFsX3Jlc2V0KCkgYXJvdW5kLg0KDQpIaSBMdWthcywgDQoNCkZvciB0aGUgInJlYWwiIGNv
bnNvbGVzIHRoYXQgcmVnaXN0ZXJlZCB0aHJvdWdoIHVhcnRfYWRkX29uZV9wb3J0KCkgZHVyaW5n
IHVhcnQgZHJpdmVyIHByb2JlLCB5ZXMsIHRoZSBzcGluIGxvY2sgaXMgKmFsd2F5cyogaW5pdGlh
bGl6ZWQuDQpBbmQgZG9uJ3Qgd29ycnkgYWJvdXQgdGhlIGxwdWFydF9jb25zb2xlX3dyaXRlKCkg
aG9sZGluZyB0aGUgc3BpbiBsb2NrLCBhcyB0aGUgbHB1YXJ0X2NvbnNvbGVfd3JpdGUoKSB3aWxs
IG9ubHkgYmUgdXNlZCBhZnRlciB0aGUgbHB1YXJ0X2NvbnNvbGVfc2V0dXAoKSwgdGhlIHNwaW4g
bG9jayBoYXMgYmVlbiBpbml0aWFsaXplZC4NClsgICAgMS44MjQxNzddIENhbGwgdHJhY2U6DQpb
ICAgIDEuODI2NjI3XSAgdWFydF9wb3J0X3NwaW5fbG9ja19pbml0KzB4MjAvMHgzOA0KWyAgICAx
LjgzMTE3N10gIHVhcnRfYWRkX29uZV9wb3J0KzB4MTUwLzB4NWQwDQpbICAgIDEuODM1MjkwXSAg
bHB1YXJ0X3Byb2JlKzB4MjZjLzB4NDg0DQpbICAgIDEuODM4OTY2XSAgcGxhdGZvcm1fcHJvYmUr
MHg2OC8weGUwDQoNCk5vdyB0aGUgaXNzdWUgaXMsIGZvciB0aGUgbHB1YXJ0IGNvbnNvbGUgcG9y
dCwgdGhlIHVhcnRfY29uc29sZSgpIHdpbGwgb25seSBiZSBzZXQgY29ycmVjdGx5IGluIHVhcnRf
YWRkX29uZV9wb3J0KCksIHNvIGlmIG1vdmUgbHB1YXJ0X2dsb2JhbF9yZXNldCgpIGJlZm9yZSB1
YXJ0X2FkZF9vbmVfcG9ydCgpLCB3ZSBjYW5ub3QgcmVjb2duaXplIHRoZSBjb25zb2xlIHBvcnQs
IHdoaWNoIHdpbGwgY2F1c2UgdGhlIGNvbnNvbGUgcG9ydCBhbHNvIGJlZW4gZ2xvYmFsIHJlc2V0
IHRvIGJyZWFrIHRoZSBjb25zb2xlIHByaW50Lg0KDQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIHBl
cmZvcm1pbmcgbHB1YXJ0X2dsb2JhbF9yZXNldCgpIGFmdGVyIFVBUlQgcmVnaXN0cmF0aW9uIGlz
DQo+IHRoYXQgYXMgc29vbiBhcyB1YXJ0X2FkZF9vbmVfcG9ydCgpIHJldHVybnMsIHRoZSBwb3J0
IGlzIGF2YWlsYWJsZSBmb3IgdXNlcg0KPiBzcGFjZSB0byB1c2UuICBTbyByZXNldHRpbmcgaXQg
aXMgYSBuby1nby4NCj4gDQoNClBlciBteSB1bmRlcnN0YW5kaW5nLCBldmVuIHdlIGRvbuKAmXQg
ZG8gdGhlIGdsb2JhbCByZXNldCBmb3IgdGhlIG5vbi1jb25zb2xlIHBvcnRzIGFmdGVyIHVhcnRf
YWRkX29uZV9wb3J0KCksIHdlIHN0aWxsIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUgdHR5IHBvcnRz
IGluIGxwdWFydDMyX3N0YXJ0dXAoKSB3aGVuIG9wZW4gdHR5IGRldmljZSwgaXQgc2hvdWxkIGJl
IHNhZmUgdG8gYWRkIGEgc29mdHdhcmUgcmVzZXQgYmVmb3JlIGluaXRpYWxpemluZyB0aGUgdHR5
IHBvcnRzLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
