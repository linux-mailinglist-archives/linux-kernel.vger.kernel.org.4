Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E76803FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjA3DC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3DCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:02:25 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6F1BADB;
        Sun, 29 Jan 2023 19:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5OHAI7UDLu/WYXBO4qhikpTIi6SI0ZClFmfuj9rLzsIVfJGfSyIViL8qPOgDkL0bO3bc96yPOWRjgadvQXwiceCfQdFigzfam7MrGvwEiw8pr3TgRzaQo3MmBbwMAVAyKglEQxrcjN5h/kWurSPnHtJeLt+faEjWZwyWaotbxU3csE8SJWWTUApwNrqfCO0X1iQsfbuXm8776FDRf8SwjqIJUZI7k3YPf3Yz0PBxajCGoK5HJ3SFFi0bz/FKpxypL/HQMcEfULcOm8gL01q6t5vJJqHpweI4Vo19NDmsaWNMZpsXQLJ51fVWcWWXNcBgWpQ1SiBcQOAlAMXxoJ8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoSyxDGFkz1zHAxV6FxRYH1r8uS1pmtxStpWOSC65Io=;
 b=FHJzY6EwhJYTVH6I6L4g8byiWadNR5Jb3AGlqGbg+gZWUaPZjHqE8ybpPVKD8SH/zqk8Ao1+QCkQ1zEViL1nWYvgtW1PQBv1ykd4QYifYuY/BfUf9ytkQyZb1KMCOZZsfic4ciJU0v5HCS/gYcPwYqG7+v2XWNLv052ATzLeWJKGqUhOOuCU7yggR7Qbj7g0vBVs39CP2iHubBayHQzl7/mHA+ANau/8UrWEWIJwt/0laxj3rxaaUgH8ysfT/Fu7ayukUbfHcbJYZRnALDvXBcxt4V3R8o4GeVqV+GAbEIjccFHt63NdCyR301Vyt9Fm9mP2hOGhAD41F/CYtXu8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoSyxDGFkz1zHAxV6FxRYH1r8uS1pmtxStpWOSC65Io=;
 b=G7MoQbumKRmyTsgEljgs8SdH93I32mGQdUED4xeCBdHCXv6yZV6w3Hp3Cki21hJJUPvwhMXeImJGfml8zsSkQj2sujAUFD/xCCWRg32FcN+/C+pPw2rD8sA5MEZD/Y2OpYgRGyePjDDVuPB9EAHmYBCjUpo3YtEB2sR+anL92Eg=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 03:02:21 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 03:02:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: don't enable
 receiver/transmitter before rx/tx dma ready
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: don't enable
 receiver/transmitter before rx/tx dma ready
Thread-Index: AQHZAubQWWJ3i0zUzECjo39OP5Jhdq62qEEw
Date:   Mon, 30 Jan 2023 03:02:21 +0000
Message-ID: <AS8PR04MB8404F38D6586B532A80A0FA592D39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221128050208.28086-1-sherry.sun@nxp.com>
In-Reply-To: <20221128050208.28086-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|VI1PR04MB6926:EE_
x-ms-office365-filtering-correlation-id: 0669fc09-0adc-4379-503d-08db026e67a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vElbe5O0UMxqvp0VH+CNbvSRc0/701nG5KpKjngQuwjgyxdMlTlzz2KjplaWfvXtUNUp+DVRjsGbQhpc/FwxTBhgdzZA1beigsftNOJembHSoozPHr+fohint0FtwWomqVKY43SaMKRpKE1WHhKQlXbg19VqnGZEIg0nbJ05FakX4UGpQIziA8FQLwgR2D/AUgHu6SiJaOnAw/Z0PB1/wX3fvyHd9Z+ZsatD7behx641hWfS4zV2ATwerN8mRlAKqduqGQEOBwddvLV9ghjHsl13ZqelyVQ93SbG3Z+6e7CxdPtr9siwy+6CrNzM+yI/kxNxTXqEvMbv1+6pkNNG3ncZCn/za+7Ha3X9J4xCNxD+aFedg+1uCJbxgcYk/PCHYUt6FI/LvGR/TStg2/XgOrF9gRDJAOrgFHiXQLhmgnsy/wRo4VKxqq7XiinME5mC6XCxKHfk0RSNY+qfnKP2tdVFYZqR/dV8Ht6tBjbdFVYNhkqPvxrAiKqwfq39A2HgfiYGA83fNEmsCuY0lo+ESTD8mOEmrnhGScn+Nrhd4+2OigIAcOC3T5X3BQGIEtgA7hw08BBJs/j1VJ9mt7BBgyVatue1QZX0t/GIk30pF8xqA0qwh/2OBKnQVBIVYCirlmXdDq4tlrtcA6VUcd9ZXIbkfkOYlCt/VP3isD+BeVKYXaRJEQW7ewvXmkGz0NrimUZ9LTQwps77asDib2jZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199018)(26005)(9686003)(186003)(122000001)(38100700002)(44832011)(5660300002)(2906002)(71200400001)(38070700005)(478600001)(7696005)(53546011)(52536014)(66946007)(76116006)(86362001)(8676002)(4326008)(83380400001)(6506007)(64756008)(66446008)(54906003)(66476007)(110136005)(316002)(66556008)(8936002)(41300700001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OTd0MnV6ajJ4Mk9GWEtEUGlERzNScXRueG9MOU14ZEtJUWo1MUptd3pUY2la?=
 =?gb2312?B?cnV1eC84S0dlVTV0NG5ZcStzb0FHTXVKUndaMmhEMnVUbFI0NkFiRzhuM2tt?=
 =?gb2312?B?S0NLWFVJSFN4VE1sVG54NFlQeTA4U0MybC9lOUNta2tua2c2d0ROR204WUVo?=
 =?gb2312?B?eWYxd1R2V2N4aVVuVkNkeWFLNzZPR0JPVHFHT3BlSkwyT0R1emRLZFNiS3ZV?=
 =?gb2312?B?dlF6V0NSeEFReFRIdm9hUVB4aTZ5VEJ3RWE5RStic2dobU1kSmQzbFloMUR3?=
 =?gb2312?B?MWhnczFoYVgwU3JOMXlzRjc2WkFRQkhTaEZUWjIxc29UU0lQOTAvSE5TVGJV?=
 =?gb2312?B?Mm8wRFI5ay9QYmllb1M0QlptNzZCUXZqMVNRUVdPbGJLNGh0QWVMT3h5c0hB?=
 =?gb2312?B?aTg1REdpMjh6c0F4M2tRckJ2ZWlpRkJSTGY2K1cxUS9aSWVqSjNsZ2hiK1cy?=
 =?gb2312?B?S1ZGL3ZzYUNlK0pFK2xlSnlYVmt5dm9KbkNMbGtTajBUQVBUQUZBdnFmOTdU?=
 =?gb2312?B?WlozY1FLSnhxNWpFNkRJcHFXaUVxRU83VVIrRmYzN2krZWZzRU5lZ0NTYkw5?=
 =?gb2312?B?Q0ZEUVlUVytrRWJmZmFEeDJDckUxMW9vMkh6OWJwd3l6SzB0RElSbktoUy9y?=
 =?gb2312?B?cUtXZGFqR05sZXdXbHlyQUVNRFVJb3RxOGJVMzg0NmJJU0xzUzAxRXZ5ZnJp?=
 =?gb2312?B?NEw1ckZ0c2J0UlZVdjQ1eGNiRVZlTlE3SDg4Q0ZwZEFSOTM5c3VXYVRtdlFn?=
 =?gb2312?B?OHlzaHZXTEdzTDNYUlczUTJ6RjFNS2lwS1dQZjlKQU9BTHJKNHgzTUdyeVhE?=
 =?gb2312?B?amtBRGg4REJ0TTQ0NWF4ZCthN3FIL2lDU1NmQzMyTTU1VFNiVXdEaTNPbnUw?=
 =?gb2312?B?NmVsbXl2bVNsWTBLWGthRWJWejgwVDd6UmVNMTJEMytqTEpweklrV1hzSjJS?=
 =?gb2312?B?OUxHaUhUZlc0TXFraFZock15QVE3NVBESzVJQ1l6UXlUYThsQ1BkRnhuQ1hw?=
 =?gb2312?B?OS9nS3dRbXNvbFhCZ3RKR29vcFhwcGx3ZnBNc3B6WGtyYnppcnRST2N5cjVT?=
 =?gb2312?B?S2tVYTVlMVZBMGhhczdCRWp0aGRYRU94QjRUQlMrWVRsTUtJTmVmdXlwRi95?=
 =?gb2312?B?NTREVW0vcVBucVpvTlE4MjJRTFg5MHozSk5CeHFibVkzdFl0Ly9rUStXUHZL?=
 =?gb2312?B?NmIrZ2t2NUZqR0NLbHRZemhlcVp2Y0JsOStaTGNqRzUzSHFERXBDc2ZVNzZm?=
 =?gb2312?B?SzZTZVNOejgwbTVvcGY0S2F2c0N6NDVWWHJoeXpSb3JqaGVLYmw1ZE0rK1Jk?=
 =?gb2312?B?UEVXam0rRU5ZbVdFaFBxSXlBMXN5dmZ0b0tZNVJ3cXlPMElPRXp6RjZNUGln?=
 =?gb2312?B?M0wrUU03VWVaZjVVM1VWdjNQakRJaDlwZk5jMHNVcmxKN2Q5Uk5UOXVXTkhr?=
 =?gb2312?B?T3dUeGFxN3FFV1lpdFRHMytYM3FFa29XMXB6MldQTXRJMWhTeEYyOTlaNHRX?=
 =?gb2312?B?cjV4YUl0M2g3S21hN05weDBGN3JlaHhMcnhFb0ZvUEdsVW1lb29jU05JUnpj?=
 =?gb2312?B?Z3ZJMTBBQm5VSFZSd2p4WGNGN3daTFl1UGdrNzVweHpzL1Q5UFRFeUcxU3JU?=
 =?gb2312?B?N2VMWnVQTDV1VDFtb2NpYW16aXEvRnluUFE1RnNMNWFNbTN3Snk3TXlZM1hr?=
 =?gb2312?B?dE9NdGFWZFRhaDVTY1FTZkxuL0x5NmR6dWFRdERDNDJxZ1hrbVFBanR4MFNa?=
 =?gb2312?B?c05UdEhEMXhPdGhmMEVsQ05LWWsrMUllOGV6TUk2L2czbW1mZlByd2Y4SWF2?=
 =?gb2312?B?bmhmVXg3SUNFbjYzM1Jpc3Racnh3SEtBOXk4a2hIdVo1S2pldzQzcE45bE96?=
 =?gb2312?B?UFl6STcxck9qdGY3aTRNcHdJNit2Rld3R0swMDQzQmVKVTBXSDd1K3c3OFdq?=
 =?gb2312?B?WFRIRHFMc2Q0Tm1Hb2VYbG9ab0pxWjR2NFkvNHkrdE85ZTJjK3VpSFVIaXBz?=
 =?gb2312?B?K1IyNy9weXNXblJDbFhpTGpjcXNoajNSOHdkRk8wYnptZTBGcGVkaGxHMDdM?=
 =?gb2312?B?SU5oMVJJUG9hd1J1VzdzaDJ0NDBWRGZuYk93NkxxV2sxOVR4dHN5UGIxU3I3?=
 =?gb2312?Q?wIVUahjA8yXaofB+pvNZGfrbp?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0669fc09-0adc-4379-503d-08db026e67a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 03:02:21.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEyWBqIc0cBtbni0L3tVa3pTgNZ+o7z5hE3ZJDCJlm2ATPhojZQ0C6dy9Mcb1v3nPEWflf9av06EK8o9bUegtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jEx1MIyOMjV
IDEzOjA0DQo+IFRvOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGRvbid0IGVuYWJsZSByZWNl
aXZlci90cmFuc21pdHRlcg0KPiBiZWZvcmUgcngvdHggZG1hIHJlYWR5DQo+IA0KPiBscHVhcnQz
Ml9zZXR1cF93YXRlcm1hcmtfZW5hYmxlKCkgd2lsbCBjb25maWd1cmUgdGhlIFVBUlQgRklGTyBh
bmQNCj4gd2F0ZXJtYXJrLCBhbHNvIGVuYWJsZSB0aGUgcmVjZWl2ZXIgYW5kIHRyYW5zbWl0dGVy
LCB0aGlzIHNob3VsZCBiZSBkb25lDQo+IGFmdGVyIHRoZSByeC90eCBkbWEgc3RldXAgcmVhZHku
DQo+IA0KPiBBbHNvIGFkZCBscHVhcnQzMl9od19kaXNhYmxlKCkgdG8gbWFrZSBzdXJlIHRoZSBy
ZWNlaXZlci90cmFuc21pdHRlciBhbmQNCj4gaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQgZHVyaW5n
IHRoZSBkbWEgc3RldXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnku
c3VuQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8
IDEzICsrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9s
cHVhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gaW5kZXggODkxOGUw
OGJiMTllLi5iYjEyYjMyOGUyMjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9m
c2xfbHB1YXJ0LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBA
QCAtMTY4Miw2ICsxNjgyLDE2IEBAIHN0YXRpYyBpbnQgbHB1YXJ0X3N0YXJ0dXAoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBs
cHVhcnQzMl9od19kaXNhYmxlKHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpIHsNCj4gKwl1bnNp
Z25lZCBsb25nIHRlbXA7DQo+ICsNCj4gKwl0ZW1wID0gbHB1YXJ0MzJfcmVhZCgmc3BvcnQtPnBv
cnQsIFVBUlRDVFJMKTsNCj4gKwl0ZW1wICY9IH4oVUFSVENUUkxfUklFIHwgVUFSVENUUkxfSUxJ
RSB8IFVBUlRDVFJMX1JFIHwNCj4gKwkJICBVQVJUQ1RSTF9USUUgfCBVQVJUQ1RSTF9URSk7DQo+
ICsJbHB1YXJ0MzJfd3JpdGUoJnNwb3J0LT5wb3J0LCB0ZW1wLCBVQVJUQ1RSTCk7IH0NCj4gKw0K
PiAgc3RhdGljIHZvaWQgbHB1YXJ0MzJfY29uZmlndXJlKHN0cnVjdCBscHVhcnRfcG9ydCAqc3Bv
cnQpICB7DQo+ICAJdW5zaWduZWQgbG9uZyB0ZW1wOw0KPiBAQCAtMTcwNiwxMSArMTcxNiwxMiBA
QCBzdGF0aWMgdm9pZCBscHVhcnQzMl9od19zZXR1cChzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNw
b3J0KQ0KPiANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmc3BvcnQtPnBvcnQubG9jaywgZmxhZ3Mp
Ow0KPiANCj4gLQlscHVhcnQzMl9zZXR1cF93YXRlcm1hcmtfZW5hYmxlKHNwb3J0KTsNCj4gKwls
cHVhcnQzMl9od19kaXNhYmxlKHNwb3J0KTsNCj4gDQo+ICAJbHB1YXJ0X3J4X2RtYV9zdGFydHVw
KHNwb3J0KTsNCj4gIAlscHVhcnRfdHhfZG1hX3N0YXJ0dXAoc3BvcnQpOw0KPiANCj4gKwlscHVh
cnQzMl9zZXR1cF93YXRlcm1hcmtfZW5hYmxlKHNwb3J0KTsNCj4gIAlscHVhcnQzMl9jb25maWd1
cmUoc3BvcnQpOw0KPiANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzcG9ydC0+cG9ydC5s
b2NrLCBmbGFncyk7DQo+IC0tDQo+IDIuMTcuMQ0KDQo=
