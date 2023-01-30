Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD36805AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjA3FgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjA3FgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:36:11 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B4241EB;
        Sun, 29 Jan 2023 21:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYdTGC83sC2k1ii/KTEb+Q63xXFoj3g2Byz1zL3JO5WmwCpalfyumO5eZiCRj6bgqNF7e2wy/ilm3xFHNOKYG4T8JkqOeenDTVogqUByP3f6ma/w3y/9tXao1RGO7VHSvcmfYeOJDg1mDIY1oiqtmjQ8knsQZjoMMlIo+Zr6BnPg2YwyGeJLQV/huUklHNDqWGZbF91iF42b7SoxG29V+r6fXhZPd0aVQvr+8OyBhkQAIeJDWtSOJ4fg3q132+pY/YBf/uYf13eCooRn2g3ybx7IBAe3LW3HZozqoLyyQCiJQPZio18zJX2+xzt5pnoiAhvJIhz19HWlsH/8rhPrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj336kwr0OZtGN8YtSucfBein8Iu3Y/qwcc2jvofxVA=;
 b=E3gYoKF1+RYzfk2Of39b5k+C+YKkbr4B7i71UgaPPEDKd00b4Ixenstpc9weiOSlEGTX+FiS5L4dFEP+dWIdUZC/sSUd3f8RSZ+8FC42TOpi6aXeuRFjphbWFG4bHrV36qZIqgsrkRlA+HH2DdlZUSLkVhzeUkLo/K07/MkiSJosy9+qizq0WzhvomItBN9U0UlTtqlrlIMAdMc9xBNNVhNa0xALIqcAs1hxpM919Rowcbl3CX+4QCbMwMt5hQebfiP73hdGDBrnkJwhI7K115zGAPlDafAboaGY14QdHK45VRUKkz9Liy2WDc509PGjVz/Kg25LPiIUMA/9IFdqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj336kwr0OZtGN8YtSucfBein8Iu3Y/qwcc2jvofxVA=;
 b=Ye/r0mTu7AfYHpRkO9WMiBb4DW1xG0KxvAkt+o2JM5FvjEYYzP8SUTlDUYOMSA0yEnZApz8qFsC68hVtFqLaKmIDV7Rpt+z+JjdclDUeYxk6Y5wWlkxta+gxku9oe3h5QH6tNYx1e6cYQZDSlXmst1R37tU6sOsW0HNZiAIT62s=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 05:36:07 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 05:36:07 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: don't enable
 receiver/transmitter before rx/tx dma ready
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: don't enable
 receiver/transmitter before rx/tx dma ready
Thread-Index: AQHZAubQWWJ3i0zUzECjo39OP5Jhdq62qEEwgAAnVoCAAAPsgA==
Date:   Mon, 30 Jan 2023 05:36:07 +0000
Message-ID: <AS8PR04MB8404A8DF0C01B0AF5B84003A92D39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221128050208.28086-1-sherry.sun@nxp.com>
 <AS8PR04MB8404F38D6586B532A80A0FA592D39@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Y9dT1fLxl/5n8wjZ@kroah.com>
In-Reply-To: <Y9dT1fLxl/5n8wjZ@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAXPR04MB8110:EE_
x-ms-office365-filtering-correlation-id: 8d108269-f3e7-4994-5e7c-08db0283e31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilGtpe15FYAr2i7pKG20TkEEEl94sUNFxeS/aTJaECvUXEj+XPcnot7mTyW5P5UY66Y0t5rJv5YgX/nQsyyJmDwuCrSJFXcP8gyxRbiRSj0XPOr0AV93L8LKCT8LHq2Ccch8cd1H2KyvoA7KwmYiUjJNOWiI9bklntzNEoe7w06dc434cDU+L588uC8dAvdsMY5mLjwppICOyR5tWZhyK7N/XjTgxN58vl/57gDE/EJfGUX3dGcdlWhJdajoUQiankNS/86xHNDg8k+Q2G1f4fmeJmQYu17UTBKz9wSkoEYKhxSs2HFvhb0a3feEqwCeZwD0NO/21i6iHt/R8JN+A9+UqTDGcq/P7SVDFHzya+J0reeDb1NXBaBXzCALjLUNHQBPCVjJ3NSkjRTw81o4vJFm6qzCdiPQs0VDY4WzdASCkD7Ob3YcRdmgpic0knL4KEypMFAM9dTnOfWf7b3SMaXj2XJBBmfAeP8XMCkbONNKCEJ68BLYLYO0v6UmsDtA6HxJExKlpwgz6t6OzfuJzLaMNVGd0dSqIbW9kc0CU4SiidGxbbMzKBZKkuRTcazlBPZ72UZ2EfCxkfBKLggtRPOsBVO0mCvqrOUKfIhkeiU8OwDgsRQGYxUAP4BtL/pcULQ9Iq76AVuG42QzBDAYbSWgxHP0Wo9aCE4AdhwV/bn2wehcJaOLcAO6MbOlx/8cFl6yxKaIXLuPvQG9k2Fnog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(186003)(6506007)(53546011)(478600001)(26005)(9686003)(7696005)(66446008)(8676002)(76116006)(4326008)(6916009)(64756008)(66476007)(66556008)(66946007)(122000001)(83380400001)(41300700001)(8936002)(52536014)(86362001)(38100700002)(71200400001)(44832011)(33656002)(2906002)(5660300002)(316002)(4744005)(54906003)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aUgwckZGZ0pYbHJGKzMzZUxQZlNuakNyZFRHZFQrcjhZMkpMQVZUMlVDaFFJ?=
 =?gb2312?B?R1d3dVJCaFp0ZGNsK3RhRW0vUy9UN3BvMndXa1hRQUg4K1hrQitrRlBpRU93?=
 =?gb2312?B?V01ESGlIbHlPRS94VE1JRy9lZ0puTHlUQlhYT1NVa3Y5YkJNdnNlVHkyYmIz?=
 =?gb2312?B?NnI5aEpjNjNBazhkNkhRVkxUWDJSZzVkV05GK2lHZEhhRWNXaFN5RjdadGc2?=
 =?gb2312?B?T2gvNXR5b1I3YkVKUDE3NWJ2TUZZVUxQSGNuTFU0SUFiNVV6R2tid0ZIM3d4?=
 =?gb2312?B?SlNxZGhUbkEyL3lhQ1MwS25kUUdsOUI2R1I4RWQrRVk3MjdsSzE3cTBkNnEr?=
 =?gb2312?B?SGhRdmxrVm5qeWxRUWVuU051WUtvVFRNNHc3M01UZTBBSXIwY3daMnpnb2ox?=
 =?gb2312?B?ZmJoRGNuanAyZmxKMDhRcTUyY3RUdlFYTUN0VVNBa2VSWFIxTDhneklucm1q?=
 =?gb2312?B?NEhPa1IyOG1EL3FBaTBtcEM4YUpQWlU5UEtLcm84dmQxZVNNYk9BNXVsN283?=
 =?gb2312?B?TkFmQWx0Z3E2WldxVEgrM2xtSmFnLzY3S0YwL3dONGpORWhaaUlmcUdQZjMr?=
 =?gb2312?B?c05JTWYveExFMGNaalJXS2hIcGMyWVREVlBaenFaL3REOWs4RXBCSjA3RFRO?=
 =?gb2312?B?TGdrcThTUk13RUFySmMya2kzZ3VVaWpkSXZRUDJNKzBCaFRuL2YvM1FLRjRs?=
 =?gb2312?B?dmprZTAzekdldDEzWEExOFU0Z01FMVFLd3N6QjVSYUtpZDBYaDNkbW9JbXNP?=
 =?gb2312?B?aFg4L2pXaUV0Q3FlRzlXYVV2MEFEVXNEQXJyemFZU2FDSUJFUUpzTXQzektL?=
 =?gb2312?B?RGtpVlQrMVBZS3B5UzFORVl1OXJLNUNCeTZ5MFFyZjFkQ1ErTVNJQTU1SUg1?=
 =?gb2312?B?Z2RTdFZlTVJtUXgycmJFWFFLZVpmaUs5UTFFSDRUdGF6WCt6ZWVtUTU4Wllx?=
 =?gb2312?B?TmJKdTdMWkFBem9pQStSNWJhSzVHOTlqeWtSMHJoNC8reWk1RHh2bkRGWWZa?=
 =?gb2312?B?MWRJUWsrelNqdk9mc1UrTzNpdTVsbTQxakYrM1ErTk1BajVYeGM4dG9zYTV1?=
 =?gb2312?B?eW1VY1R2Z3FRNXlJNU05NklUN1FRMC8zeFloQm45NWJheDM5aVZTNHpnTzJu?=
 =?gb2312?B?V0h3WFRTWlFmVXhEOG1WQUF5cDlTRXhERWNvLzIweG1YbGc1dU9WUnQxREZi?=
 =?gb2312?B?N1BTQkdTZm5zeDQySCs5M1d6M0JLczdDMUd3YXFyTWh1SytIREpoNWN6OHl0?=
 =?gb2312?B?WnBrRDRCYmRJVjE0d3pQR0pxS2ZEYi8wM0pEd25vWEJsSUs4WTdWMmQwTzc1?=
 =?gb2312?B?Q3ZxczhTU0JoQ2NRMEdYUG55LzM0WVpRRDZXU2hlUWNmc2RtSzh4bFhuOVRt?=
 =?gb2312?B?Y05jYVp2djFFVjVQTC9xSTlIeVdvZFUrTEh3ZG5tazUrcm9KK3Vsbm8xa3cy?=
 =?gb2312?B?ZGlnN2NEMyswKys1Rjh6MVExUi84RUZQaHJNMDJSbDFrYm9sVWU0bUVMSEVZ?=
 =?gb2312?B?OFZEaG4wb3NNQ09vQ1NOK3NCNjA0LzZ4Y1U0bU11bE5RbVdQTlhYRWR5eVFI?=
 =?gb2312?B?OVhMbVVVUTZCZmJWYTFHZjBkakdiQkN4U05TQVdNSEFlZzhNMXBxdHZFQW5T?=
 =?gb2312?B?bHY2RW9LeVpvY0RhT3c4U2t6Umcvc2xUbGE2MEcwOC9aaUpRT3RjUkl4Tmdk?=
 =?gb2312?B?cjNGVzdDaDgyZVZ0a1RFQU5KbU8rcmdObHJCVWJ1eGF3Z2lGNU4zbXJxTVRv?=
 =?gb2312?B?R2RtaUllb3VIWi94OUJNays5aTBsM1N5VVFyVVdzTE5jSEtLM1NpR2Y4RWx5?=
 =?gb2312?B?MXFlMllyaDR3YXFvZHpZT3AxeDkvYmRuWFZYdWNnTnRwRmRMMDJsWVI0SzI4?=
 =?gb2312?B?Qjhoc2xZL1FLNEdDcm1aY2d6dmNTM0pZdEVmNDlhYW13c3FHSk9EelFUazAx?=
 =?gb2312?B?eGZKWms5Q0Z2ek95bllRUHh2RktBWEVYSDJHVGJUZUUxTi9DbEJMSDZYYUhi?=
 =?gb2312?B?Z0tRc2dZMHlrT1lNZkpMcWNJTklmandFZlA1V0tXclg5Wk1HK1ZzSU9Wd2hP?=
 =?gb2312?B?bmFLc1JNZ2lKNStpVEtIbW94dUxtS04wbnBiNS9yVlBrcVZYc0NnTWhpRFZv?=
 =?gb2312?Q?ZxbeWM/AUI/KN4PH2gw2g3v23?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d108269-f3e7-4994-5e7c-08db0283e31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 05:36:07.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32BlMCfcgY2Zw8JXaP+Ok4EZ6uFIKSqQ9Nh1QK28yS+6rnymcfApxvCmiVTlE0AX8ubuMGSk4JN48bTfGccCiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiAyMDIzxOox
1MIzMMjVIDEzOjIxDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENj
OiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBk
b24ndCBlbmFibGUgcmVjZWl2ZXIvdHJhbnNtaXR0ZXINCj4gYmVmb3JlIHJ4L3R4IGRtYSByZWFk
eQ0KPiANCj4gT24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMDM6MDI6MjFBTSArMDAwMCwgU2hlcnJ5
IFN1biB3cm90ZToNCj4gPiBHZW50bGUgcGluZy4uLg0KPiANCj4gVGhpcyBpcyBub3QgaW4gbXkg
cXVldWUgYW55d2hlcmUsIHNvcnJ5LCBpdCBtdXN0IGhhdmUgZmFsbGVuIG9mZi4gIENhbiB5b3UN
Cj4gcGxlYXNlIHJlc2VuZD8NCj4gDQoNClN1cmUsIHdpbGwgcmVzZW5kIGl0LCB0aGFua3MuDQoN
CkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
