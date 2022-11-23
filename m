Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D8635AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiKWLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiKWLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:03:06 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020B5DB877;
        Wed, 23 Nov 2022 02:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrAcR90fq9TBrdzBnjTVWEHWjtSjE55NSmjtI71cIf9QulD9zWGQrwQxQaMS/V9pjYyPBJCJVuJ3k71TN+CQcv/JLMNSzq4PJlip4+Ju4pSRTNpljWXaSGzYMqbXvVxPrviMg6j+WTLNTSW6IUTYpu3AiT1O+Yg6UfDd7PyHYNFNgKOci166eCua5VsKg122D9IcP9Bl4kqKXF8tMRewXz4k4B8LzKkGvSBjF6/gRNwkKhPe+oEIagH/CFbdJNhlV+6tkfiYQf7zEM0ZTYWQWCi5ajBpiBIgjz5TA3Bhteokxs7egzIYq8sX39OEEULwvCx55nAIPcanNSfyGDbJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1eeGKAfp9XBql9nesMUEXR89U8ctNvQN2HXnoy3XEw=;
 b=aOiDHriC5OZb8WCfdOxKUuYmsXQHrYPSY+bR92i5fGPKoSDq0ZcEHpLIvx4QUCd1Fbq0VERAiBkLSNijUApkCxuBThbX3ofrdjZxBo6vgNyt3JBUFPnggQR3R8OTK1s4gZWYGVJw9evfLDjYSr+bhzkOUuIXG2gJrx8UDxAgIqfsmxGSEUgabZY6VQuQ2ft5YuDH+tb3vNg0CpWD90PN3H++AxwgPJaYxbMGWUsacF3fuS5BSBB8S2+ulWOh2dDwiutQWk8yNbleXEwUI1zE7ow6wudH52qlEfW/RBMq5ktjdTKgo9roWR4RepVoc6K1UJ4/JDUMlXU/8qhKXKEvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1eeGKAfp9XBql9nesMUEXR89U8ctNvQN2HXnoy3XEw=;
 b=gopo/xeN1WRMceiap0QEPXiokNLYSbTbYKM5kIvyGFd4ZKGay0mTX0bkhnulwD4MivRMvA+HGa4VZCtTVJBmYX0fQKDFrDt2OCOa3lMYxVRGhUVb5tjFettjyRndwl13oF64X/0aigmMcpUwowXUtWAFhj541LMa+3l5u0ZfHBQ=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 10:58:34 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 10:58:34 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Topic: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Index: AQHY9N0ndaYC9LLIxEmMDBrWfgwKya5MZJAAgAAD6AA=
Date:   Wed, 23 Nov 2022 10:58:34 +0000
Message-ID: <AS8PR04MB8404EBF13DF7A051650EE76C920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-3-sherry.sun@nxp.com>
 <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
In-Reply-To: <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB7593:EE_
x-ms-office365-filtering-correlation-id: c66705fa-81b8-4695-6569-08dacd41aa9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrALJXdNT2huycz0/S2vSQ9szfTSJuC5qHIkROzioUzrobMZr+CqeMM/kNtJf291usZnwwDVpr4NpyUg0qX53PjoOE+SP49d/nUBPq0sfVAbZy5uJbYk5O3U/CPUKOpx6ntppQUjFzY4/sJoY/XnaPIyQwRfit3GZaMOnWCUvRIzokFlpYpvmmUYnWX7fLVLdg2KC40Om8owwokntCAn/mSQNG12FEg5yq3goVY3Mw3ibfgyeld4HvDnZceEw9/69Id7s+zFcaUFwihVZB3hV4CZgad9sj0iihhoScKJCUob/2KrJdPL49ftUEih7PihrlEIMwuEXQsucYNwUrRUkMXGoC05hzBqIxoHmOT9K+ESMFPy7Yxv4H6VrtwGiRF0/Py+RCtaONcIfYVapxZTB6zV5JEDpKbyx5yrrm9Q5TYsprbYZs74RfX8fzmqRHvhN1im2gyeG6UQc/WFQ22bJ5qXqu6J46upM0wp2KwpHJhekejz3fXZcAARKfU23DaLHD6TxB08PCVEaE/zEKoML8ylTBXWIvF/FeMUx4vb7P4468VNLXuXWkLLXS9Sa7adKNWPapJnmXGftaWSH+JNJaHYFmPUvr0e41fWLoKVkM/4VQhSXAycYgm+MjMRtV1BFV0NHzznrSjdefZBtBrzNvQYS1Ohr7KSZCBSBUblmAhiBR4FetGqq95Vl+WwzcTDhfEPmIOf4vG1scvAEVuZwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(2906002)(186003)(26005)(71200400001)(7696005)(53546011)(122000001)(9686003)(4001150100001)(478600001)(38100700002)(38070700005)(86362001)(55016003)(33656002)(83380400001)(6506007)(76116006)(8936002)(41300700001)(64756008)(66946007)(44832011)(52536014)(66446008)(8676002)(4326008)(6916009)(66556008)(66476007)(54906003)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Ynk3WlB1dkZaUUI1RkNCQ2pBY0dOdTZOV1JpK00vT0luanRsaE5qSW51YlJP?=
 =?gb2312?B?clpYcU5WZ3pjZEZPRkpHMDNuckY1TXJ1Y2ZmbTVQU2drOUV0OVhPOWk2cmc3?=
 =?gb2312?B?TDJ3Vkx0LzdQWVFTSWpQNzd6b3d1ZlJXTWN3WVdVLzBPWm9NV0VoS1Qxckdo?=
 =?gb2312?B?VHJnb0VjRTZQMm1pbW5MVzR1dEV5WHZOMnNYRlhSd0E1am5UbVhpZzNmanU1?=
 =?gb2312?B?cEJqWUZlU25zRE0zdEh5b0RQV1lQd3d3dTMxK215QlZub2hDOU9ZUVdablVT?=
 =?gb2312?B?dElndEZldkRUc0w2SWtHRXdOM3NDL1crOUZ1ekhMRkVmblEvZ3d6b0N2ZjZj?=
 =?gb2312?B?aTE3T2MrUGxBQVVzSlFsNVlrZElrdmRnM2xYOGxSWEYwaG9aWXBkcDVlQlhk?=
 =?gb2312?B?RlRqZDZiZmlQKzBSaFN6cVhHa0FHbjQ2STRxaUo4THM1S2RIdzNaNkxldVZ4?=
 =?gb2312?B?T1hKTHJQWEdEVGhINWJMK1UvY0NkbkM4RUJFUXRIVm41OFBpT1RvNHFFUDlU?=
 =?gb2312?B?Sk9UWXJyQ29xYkVCTVNwWHVnOXhrMTNsM3A2UlIxcEJJSVI3MlVzNHhpTS8x?=
 =?gb2312?B?WFVEem02aEtCSTBVcS85OVFGTmhWVUdtTHR2SGJoR0RlQUlHRlhEeFg5WUVt?=
 =?gb2312?B?Zlc3bEtjQTBIQThEZGtmZEp3azh2NFZyYzY2eVB2dHFDbVR1UDFUMytWdlIx?=
 =?gb2312?B?ak1rSi9VUE4xSURNaHd0UlcySUxUK0NKa1dCbnpEK1JEZUV6US9rZ05IaVMv?=
 =?gb2312?B?YXBNQzNYUWVpWDF0cWthL0VVamRkTkhKUytiTkZSa2xIK1FDWEVnbk1peTlS?=
 =?gb2312?B?ZndnNjUvQUJSQlBYbGJhMlRUWWlYeWRZZjRRRlMzVGVzdktnWUZsNTJna2VF?=
 =?gb2312?B?VU5XUktoOXEyOFJBZVZlRmZWa0QxRWt0WmZpRnowcnFmZC9ZMktpUU1OM003?=
 =?gb2312?B?emZCS3NEQ2d0Y1BYd3Z3U1luMUwwZlVGblBOME01YlhpZ1IvVDJ0T2RwUm4y?=
 =?gb2312?B?UEdtMHZ6Q0N2RzBwZFgvL2NRRXlTckp1SnQxN0gxdENGcEdaMnpyWDNYVDBM?=
 =?gb2312?B?RWtldzBnZnZ6QUtjVkRTQ3FlUnN0Z0VIdXdzQ1VpVWJGbzFmRnlBNm9HU2xJ?=
 =?gb2312?B?ZG8wclpCTndpZzFFSmlJNkhpNHRxRm80QW1Kek0waXA2Qi9waTNNNUprMXhF?=
 =?gb2312?B?SHI4YW9xNGRnMEVzRm93T1RmbFZJWEpZZ1NYQVBYVEhza3RlR3FTcWhVQ0VK?=
 =?gb2312?B?Rkg1Y2Ywd2FjVjdBS1llQndqYk1EaHpySUZnWEpZTGZ6bjZhZC9tSXFTS2RG?=
 =?gb2312?B?eS9DLzUreEhZVWQ4SHpqdW83MVBxOWlSZUVTaWRrRU9FaWNtMkpmZ3NQSVl2?=
 =?gb2312?B?cXIzWlI0MUhISlppdTBPWkNqTCtXUlRJZEIrbWxuV2VKTnRuWVhteUJHWWhJ?=
 =?gb2312?B?QjJTdTJnZ0ZtRWVGRWp2enc3bTFySlcwVTcrc3I2eTFNRGE2RUZCRDVLbU9V?=
 =?gb2312?B?TGhyZTJEeEI3VllhVkRON09sZmI4NzgrcEtKOVVoajVGK0JSZzZKeXBieXhT?=
 =?gb2312?B?bWJXZzZaQ1ZXOGNzb0pxQzNHSFR5VHJxd2tvMHMzQ3BUWnFJZUxvTXliWTRi?=
 =?gb2312?B?UXRDRjhCd1d2Z1FQaTczOTV1eXpoTkFJSCtHOVVibXkyVkNHcmhXZjlndnp1?=
 =?gb2312?B?OXNkK0Nxd0cwWGxQUzZsMC9pd1ZnM1MvaDFOWmJ0UnBiVjZZS3VJMi85RWh4?=
 =?gb2312?B?YnN1MFhOVFdHMFo1STlsUXBLazc3L1ZVYVJMejc0NC8xNHNBSGMyMzZXSFlU?=
 =?gb2312?B?M0xNU0FPS0g1amR3M245OVJKVlNFZ3FmazJDK29hRnU5QWwrRFlZU0ZTbmZZ?=
 =?gb2312?B?SFBvdkMrOVpIUVdtOTNFZ3FvY09nbnVzOXd4TGlSa1lEWWF2MHFUR3JLQzN2?=
 =?gb2312?B?QlVJRFR3NWhJRXBaVWJzd29lTmQ4bnZpMmdzeC8raE4xRUJIaW82NGJDRzVN?=
 =?gb2312?B?anZlbzNLWkdqb0pKUXl5bW8vM2lQaC92NWpSUHorZVpNWVVuNklUT25Hek1Y?=
 =?gb2312?B?bVRHdG9abEx3U25sVTBsaTgwVFVsT0gxalFHaGhOTGVTSFVJaHNsUXVmV2Iw?=
 =?gb2312?Q?5Qq5ETtitDPfGYH+O7VaNyi5D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66705fa-81b8-4695-6569-08dacd41aa9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 10:58:34.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev0eO3QO8AYJDfeNIIsdJbQH+/5OJhRLXzWu/SscNJy6vfLRlGpeflZgpDPPM0x2G/X95pXxxsFc95l9fMyjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogMjAyMsTqMTHUwjIzyNUgMTg6MzQNCj4gVG86IFNo
ZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsNCj4gamluZ2NoYW5nLmx1QGZyZWVzY2FsZS5j
b207IHRvbW9ub3JpLnNha2l0YUBzb3JkLmNvLmpwOw0KPiBhdHN1c2hpLm5lbW90b0Bzb3JkLmNv
LmpwOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCBWMiAyLzVdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBjbGVhciBVQVJUQ1RS
TF9MT09QUyBpbg0KPiBscHVhcnQzMl9zaHV0ZG93bigpDQo+IA0KPiBBbSAyMDIyLTExLTEwIDA5
OjE3LCBzY2hyaWViIFNoZXJyeSBTdW46DQo+ID4gVUFSVENUUkxfTE9PUFMgYml0IGlzIHNldCBp
biBscHVhcnQzMl9zZXRfbWN0cmwoKSBmb3IgbG9vcGJhY2sgbW9kZSwNCj4gPiBidXQgbm93aGVy
ZSBjbGVhciB0aGlzIGJpdCwgaXQgc2hvdWxkIGJlIGNsZWFyZWQgd2hlbiBjbG9zaW5nIHRoZSB1
YXJ0DQo+ID4gcG9ydCB0byBhdm9pZCB0aGUgbG9vcGJhY2sgbW9kZSBiZWVuIGVuYWJsZWQgYnkg
ZGVmYXVsdCB3aGVuIHJlb3BlbmluZw0KPiA+IHRoZSB1YXJ0Lg0KPiANCj4gSXQncyBjbGVhcmVk
IGluIHNldF9tY3RybCgpLiBXaGF0IGlzIHRoZSBleHBlY3RhdGlvbiBmcm9tIHRoZSBzZXJpYWwg
Y29yZSBoZXJlPw0KPiANCg0KSGkgTWljaGFlbCwNCg0KSWYgd2UgY2FsbCAuc2V0X21jdHJsKFRJ
T0NNX0xPT1ApLCB0aGUgVUFSVENUUkxfTE9PUFMgd2lsbCBiZSBzZXQuDQpUaGVuIHdoZW4gd2Ug
Y2FsbCAuc2h1dGRvd24oKSwgc2VyaWFsIGNvcmUgd29uJ3QgY2FsbCAuc2V0X21jdHJsKCkgdG8g
Y2xlYXIgaXQsIHNvIHRoZSBVQVJUQ1RSTF9MT09QUyBuZWVkIHRvIGJlIGNsZWFyZWQgaGVyZS4N
ClBlciBteSB1bmRlcnN0YW5kaW5nLCAuc2h1dGRvd24oKSBzaG91bGQgY2xlYW4gdXAgYWxsIHRo
ZSB1YXJ0IGZsYWdzLCBhcyB0aGUgdHJhbnNtaXR0ZXIgYW5kIHJlY2VpdmVyIHdpbGwgYmVlbiBk
aXNhYmxlZCwgd2Ugd2lsbCByZS1jb25maWd1cmUgYWxsIHRoZSBzZXR0aW5ncyBuZWVkZWQgd2hl
biByZS1vcGVuIHRoZSBwb3J0Lg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
