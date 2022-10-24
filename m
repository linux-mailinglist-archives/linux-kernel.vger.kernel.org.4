Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDD609E60
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJXJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJXJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:56:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52244A817;
        Mon, 24 Oct 2022 02:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br5L8dfHKnid9R/Ull6NSP3+qsb3+2W+A7j6fir1T9aHBcaV+BRZIJUKUW2ny+BG36zWh+eKNSj8yHBJCT5WPhYNFF4MhZpRis762O2ieQYOhpWhwAF4F6ZIk6Ef72JTiVMUuof0VuEf0TlGFHURtU3gZTJD9BBlEqiDhLj6o4aCw222lyQ+ne56rkxyDRT12hOABmhxjJ4JEYJRvQQ5QNFegKXQRAe5cts7UGWsfs00M+iUgKuyyhEN49n6k8lFJ7wacTGwDu3ZH+9Luwep0wdHoTTxqBKQ4fqtETKoGPmyjnWbCx5QbJWj8xS3oEUkvIcD0g6qs0D3vuobZnXFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlWWmTxVMkw6z3hW2IDAt1itry+++E9MzFV7rP53Lmc=;
 b=mubQzzcnLzm/QchBbCc01ZP1VMC/Dc5avNz4EODkzxdgSa/WhLojCqPTNIRDCY4U1GO4wFRoxFw9tqzOHyV41/jLHIobgAAhpLDI2il9ITLs3DTcKCBh2p3/ch4/SC89fDbCqechhmVpLCV1NS1n5nVIlzxNNROaAbvbtd/vYIOtXe7rMCtefjx7Ds2Ki1XMR0qe8p3kKg2M6wyjZtHhMvTCU8lyDAmomPl5PNf4BBXQL90iDzLCWn7YU6Ilkve2bGbJHN++kasP132aPJIgIIbhp6BYbLBlGVKbGMefd4VJiFiufFLzQt29uf9VToFcEifJ/LPkkJIV7OoecDSPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlWWmTxVMkw6z3hW2IDAt1itry+++E9MzFV7rP53Lmc=;
 b=WelEkhQHk7MX7FxEScCTL0CbFGIvR+qxES9gmYJtObGXhZdfUjVKlIfLZxSvr5PBI1J4e+xuIO3DB1sF7iKDqHxUXUEDRJka/Z9Km8Jt8l3DgzE2p1oWehhH5rhAKfbwq++bEdKC8uRjYpE5iC05PSKrUUwM9mONCQax2wIB7/Q=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 09:56:48 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5746.025; Mon, 24 Oct 2022
 09:56:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>
CC:     "fugang.duan@nxp.com" <fugang.duan@nxp.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] serial: fsl_lpuart: Skip the reset for the early console
 port
Thread-Topic: [PATCH] serial: fsl_lpuart: Skip the reset for the early console
 port
Thread-Index: AQHY54jWea23q6PbE0CJ+OCK+2O6164dTLow
Date:   Mon, 24 Oct 2022 09:56:48 +0000
Message-ID: <AS8PR04MB8404117759BDE5AAA448FA5A922E9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221024091220.1619822-1-xiaolei.wang@windriver.com>
In-Reply-To: <20221024091220.1619822-1-xiaolei.wang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS4PR04MB9434:EE_
x-ms-office365-filtering-correlation-id: 9920f3ac-8e42-4f2e-1179-08dab5a61174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rs8ySgSqjShZn9Md9FpRoBaeXJcTm9t5BM0191QxL2KJh5MK6mRSo5vcazhAUz5Y1aEQUbdrmRuB8aG9whKLPKUWWsArzZ8LUJa7e1DKxb0sU/XD64AUamEzRBt64JBhWzpMNTxkj9rb9cUmh3W8F4PM4oiGQ3hg/ETnjuUYLbNMa5+RJC/3WvqTBcdPJVaclqYB3pB4BVnbLIHkzHSWfXOdW4GGia3Jydyj7TTaWV3W1RANavnb5L0yUgkvbDi5jcidqCxu7H61D2gqD2ry8ehEVdFIbovgqeAdZ8XRjujyWJ5pcU9wBAPAZ1sVPNiKeXOMA7whPqse6ExoKzmEwn83OIqFa5mH//N6hLPQzyXzAfZKAGwAEqLjyA70Q7ZNsKrnGJVkvLjjk0+kaR0TjwNTIYA0jyBx5N191iRhilBs6xzIn5ssQwBeySYTVvVU2jz3AQ/GwyRNcveo6+kAZ7mPWwd0G8WaCtTqVIxNmlQgdA6AFvbp64x5yCxtp9bk1EYICqA5MxGB4ZboLl2C6q4hGpsuDpI2bKkubuv+7IZK3VwLy+6OYrFehlEcBqn32ELffM/i4GetHrK7ZEA3Z2TcJaO9IXLM3iDMULi4QrTXCOGW4Aixd9g24/9tUBLLbd4B479jxiRTbSVF+QfOtALtTb8zi78LyhIXd7TZ2ovgyGMjDeqoeQXTflp4HeumCbO6WSXGEPCG6Ykz9+SYQ7eMjac6OAtuJQXHjwCu13/QmHUITzgTJvBfs7LtG73m0WWTCKkHmtO75Wifhg+nmhMV3K+/A8Q2xSZwWe8mJ3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(38070700005)(38100700002)(86362001)(66556008)(966005)(41300700001)(122000001)(4326008)(8936002)(33656002)(83380400001)(44832011)(53546011)(186003)(2906002)(478600001)(316002)(6506007)(76116006)(9686003)(7696005)(5660300002)(52536014)(8676002)(64756008)(71200400001)(66946007)(66446008)(110136005)(54906003)(66476007)(55016003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S0pZRERCZU5KK1NaZkxQdU1tNTdXY3JpNWNzRE1vLzVNNytkNWxyS25qZDlo?=
 =?gb2312?B?bTNJV3V5cTJEYkxBV24wL3RibUJ4RlI3Nis0L1c2UENSSi9PWkJTTTBuS1Rs?=
 =?gb2312?B?UncwbXlSaEJTQUFvMTRWU1pKNmpZTmVNdXY4eDI0RFgvWVVOckpXMTA4QnZy?=
 =?gb2312?B?bTQwL0ZGN2dyQ094SHZzRS9OZzZqZ2I2MHNvSU92bUFOdUZDajU3MDVrQyth?=
 =?gb2312?B?K2U3c1BGOHpINXJHeDJ3UDRlc0pYUzg4YUxvaFE3NVFHSEFHenBvVXB2VUxt?=
 =?gb2312?B?RVBuM0lRS0ZrVkxSNXN3bHBTUFVpSmpmT1dXdlk1QzN3cGlCa3Q2L2M2NXBN?=
 =?gb2312?B?dEhzV203L0JoTXp6OG9uSGZydDBWYzdhcHZ2R3BSMUIydi9JdFhsR3UxUkRM?=
 =?gb2312?B?NjgwR2hKUVhrU25YR2dUOGhTUExreW9neVNLdUtuMFdoQ2pNUFk0Z05yUzRk?=
 =?gb2312?B?OHcrMTNHRVhvNXVkSlVhUm14WFduQnhJUEhIc0MvUVNlcFoyWkhDcmZHVWpw?=
 =?gb2312?B?c012anJNcGFid3cyTWhZdDVpdDlJWm9LNlNocmlzaUxFRGJZM2I5N3UzUnN2?=
 =?gb2312?B?UUROb0ZzYk5zaTFFT3VCcWtVMDE1SFlLaXFJY3lwYllTbGhLalNBT01VbEhI?=
 =?gb2312?B?QmYxVVlVcnB4TDczMWx3NElpSWNzcTlXOHhIT0E4RzM2dEhmQy85dUhFb1o2?=
 =?gb2312?B?ejJIdGh6WGhJUzdBUmRlVTRsNWlLdGw2Z3NudkxCYytGenhCT3ZBZFNXcGtD?=
 =?gb2312?B?RjJKWHcrKzJGUnNxb2FaTWJQSkg2NUJqVDhyYnFkaCt2ZktteWszZHRDaTlH?=
 =?gb2312?B?TWZleEt4MVRWRHQxai96eFV0TWg4d0kxTWJzZjVtR3E1akVWMENJc0JzclM3?=
 =?gb2312?B?Yk1USU4zNTdOdkFBc1Zab3pFKzJHVmV3ZHJyZEd2MHBZcVA3ckJaY0I5SzFm?=
 =?gb2312?B?d1NrN29aUm1ZNzR4QVRFSGEyZ0ZVMkxWNVZkMXZHWXArY0F1NXdNeTA2L1ox?=
 =?gb2312?B?dGdEdk9ZSFVSVmpNMHJ0aWw1TG44US9taDZZWm5IOTNob1lhZ0dublNjeUIv?=
 =?gb2312?B?VUVVUlBGUGdjRWt5T0xodnRabUNYZWZoN0ZiUkhoTXNhWEduMUNuTkpITmxM?=
 =?gb2312?B?dW96eW5wL0pUTFVsM0hNaTFiL3lZcmd2NkJKL00wczFHNkJnLzN5L2o3bjJn?=
 =?gb2312?B?bUxoK205VHN1RHZ4SEZjT0dOZUpGbnR5R1NTZUlkZmtMTG05OWZTZXhPaElK?=
 =?gb2312?B?aEkyWFRwLzF1MHN6ZEdkd003ZTlzYzlvZmliRUxkUnBxNU1KOFhqWWNkTU1J?=
 =?gb2312?B?cFdQTi9YVWNJTFdJT25MRVZuNElLSjRBUmtMNEVkeHlXZE85ckpBWUtmcDg5?=
 =?gb2312?B?YXY4MENta1hOQnpMQXB3cFU2RjVCUGppRjFqSHF5cDQxTnpOblRxR2lQWHRQ?=
 =?gb2312?B?N1BNZWZEcXZlVW1SL2d6VDlKSnZmaTRROWhjb1Y0TnREazFQWG1mY2U5N0s4?=
 =?gb2312?B?eS9Bd2kzU095OG1OV3EvcXNFaU1EeHNieWU0eDZnSXM0cHZ2WmlHaUozNjhk?=
 =?gb2312?B?RStWS3A5ZDdDMmNKTHlCOFNYVHRjQ0RWb1RtNGZ3T0NOWjc5bEhVNnNvV2xB?=
 =?gb2312?B?RWM4RlczUDBzSktqVkZpTVNIU0g3NEdlT1lJL2FzQldDTFZYdkttOGNzY1Vt?=
 =?gb2312?B?Q1VBRzA2a0NDSUZLLzFURGJ5SnlrSXBjb0NMNjdmQjZRSmxLYkRIbXJWNGdl?=
 =?gb2312?B?eDYwNGtwSzNweHVvTzFUaG82QnRzNk5tUXczRkVmQWFXaWsxdXpOY2NmOUJH?=
 =?gb2312?B?ZVBLY1dNaUNKbmxqcFU5aW5ydzB3VUNlMXZ0dExoMUQwU3VxS2hiQVFLTDVB?=
 =?gb2312?B?VXZXUXJnOGVqL1dJVWRVcG9zenhsQklrUGxuMTNTZUQ4YTFpcXc1RG8wcTJJ?=
 =?gb2312?B?Z2o3eHBqVDFVaGFmRzYzSUkyZDIrUFQ5TGZhSWpYbjBHT2poYnZaaXVEajMr?=
 =?gb2312?B?emJQSkpFT0Jwb25uWC9mRjFRSExQL0tkaENONWR0Q0d0T0pMSTBteFlrWlAz?=
 =?gb2312?B?R2t0L0dSSlZKMGpObU9iQ05pcnhDMW9CZXRYS1F4OWhOZ09TNFA2SVVVMkVX?=
 =?gb2312?Q?ShkR+2izyAe+7zkP2HYVnN6l1?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9920f3ac-8e42-4f2e-1179-08dab5a61174
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 09:56:48.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8M1wvlqJ/Z/Zgl++yUbGt0FhxX6QuYU/XwZElLJjOZoL3sAuv9j7Fspr7HibpMoXZ7SKgwIlaW3odqqutSwIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGlhb2xlaSBXYW5nIDx4
aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4gU2VudDogMjAyMsTqMTDUwjI0yNUgMTc6MTIN
Cj4gVG86IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsg
bHVrYXNAd3VubmVyLmRlDQo+IENjOiBmdWdhbmcuZHVhbkBueHAuY29tOyBTaGVycnkgU3VuIDxz
aGVycnkuc3VuQG54cC5jb20+Ow0KPiBpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbTsgbGlu
dXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIXSBzZXJpYWw6IGZzbF9scHVhcnQ6IFNraXAgdGhlIHJlc2V0
IGZvciB0aGUgZWFybHkgY29uc29sZSBwb3J0DQo+IA0KPiBUaGUgY29tbWl0IDYwZjM2MTcyMmFk
MiAoInNlcmlhbDogZnNsX2xwdWFydDogUmVzZXQgcHJpb3IgdG8NCj4gcmVnaXN0cmF0aW9uIikg
aGFzIG1vdmVkIHRoZSByZXNldCBiZWZvcmUgdGhlIHBvcnQgcmVnaXN0cmF0aW9uLCB0aGlzIGNo
YW5nZQ0KPiBtYWtlcyB0aGUgdWFydF9jb25zb2xlKCkgaW4gbHB1YXJ0X2dsb2JhbF9yZXNldCgp
IG5vIHNlbnNlIHNpbmNlIHRoZSBwb3J0IGlzDQo+IG5vdCByZWdpc3RlcmVkIHRvIHRoZSBzeXN0
ZW0geWV0LiBTbyBkcm9wIGl0Lg0KPiBCdXQgd2Ugc2lsbCBuZWVkIHRvIGNoZWNrIGlmIHRoZSBw
b3J0IGlzIHVzZWQgYXMgYW4gZWFybHkgY29uc29sZSBiZWZvcmUNCj4gcGVyZm9ybWluZyB0aGUg
cG9ydCByZXNldCwgb3RoZXJ3aXNlIHRoZSByZXNldCB3aWxsIGhhbmcgdGhlIHN5c3RlbS4NCj4g
DQo+IEZpeGVzOiA2MGYzNjE3MjJhZDIgKCJzZXJpYWw6IGZzbF9scHVhcnQ6IFJlc2V0IHByaW9y
IHRvIHJlZ2lzdHJhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW9sZWkgV2FuZyA8eGlhb2xl
aS53YW5nQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9s
cHVhcnQuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBpbmRleCA2N2ZhMTEz
Zjc3ZDQuLmQwZWZlYmE1YzY5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2Zz
bF9scHVhcnQuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+IEBA
IC0yMzksNiArMjM5LDggQEANCj4gIC8qIElNWCBscHVhcnQgaGFzIGZvdXIgZXh0cmEgdW51c2Vk
IHJlZ3MgbG9jYXRlZCBhdCB0aGUgYmVnaW5uaW5nICovDQo+ICAjZGVmaW5lIElNWF9SRUdfT0ZG
CTB4MTANCj4gDQo+ICtzdGF0aWMgcmVzb3VyY2Vfc2l6ZV90IGxwdWFydF9lYXJseWNvbl9tYXBi
YXNlOw0KPiArDQo+ICBlbnVtIGxwdWFydF90eXBlIHsNCj4gIAlWRjYxMF9MUFVBUlQsDQo+ICAJ
TFMxMDIxQV9MUFVBUlQsDQo+IEBAIC00MTAsNyArNDEyLDcgQEAgc3RhdGljIGludCBscHVhcnRf
Z2xvYmFsX3Jlc2V0KHN0cnVjdCBscHVhcnRfcG9ydA0KPiAqc3BvcnQpDQo+ICAJdm9pZCBfX2lv
bWVtICpnbG9iYWxfYWRkcjsNCj4gIAlpbnQgcmV0Ow0KPiANCj4gLQlpZiAodWFydF9jb25zb2xl
KHBvcnQpKQ0KPiArCWlmICgocG9ydC0+bWFwYmFzZSAtIDB4MTApID09IGxwdWFydF9lYXJseWNv
bl9tYXBiYXNlKQ0KPiAgCQlyZXR1cm4gMDsNCj4gDQo+ICAJcmV0ID0gY2xrX3ByZXBhcmVfZW5h
YmxlKHNwb3J0LT5pcGdfY2xrKTsNCj4gQEAgLTI2MDQsNiArMjYwNiw3IEBAIHN0YXRpYyBpbnQg
X19pbml0DQo+IGxwdWFydDMyX2lteF9lYXJseV9jb25zb2xlX3NldHVwKHN0cnVjdCBlYXJseWNv
bl9kZXZpY2UgKmRldmljDQo+ICAJZGV2aWNlLT5wb3J0LmlvdHlwZSA9IFVQSU9fTUVNMzI7DQo+
ICAJZGV2aWNlLT5wb3J0Lm1lbWJhc2UgKz0gSU1YX1JFR19PRkY7DQo+ICAJZGV2aWNlLT5jb24t
PndyaXRlID0gbHB1YXJ0MzJfZWFybHlfd3JpdGU7DQo+ICsJbHB1YXJ0X2Vhcmx5Y29uX21hcGJh
c2UgPSBkZXZpY2UtPnBvcnQubWFwYmFzZTsNCj4gDQoNCkhpLCB0aGFua3MgZm9yIHRoZSBmaXgg
Zm9yIGxwdWFydCBkcml2ZXIsIGJ1dCB0aGlzIGxvb2tzIG1vcmUgbGlrZSBhIHdvcmthcm91bmQg
cGF0Y2guDQpQZXIgbXkgdW5kZXJzdGFuZGluZywgdGhlIHJvb3QgY2F1c2UgZm9yIHRoaXMgaXNz
dWUgaXMgdGhhdCBscHVhcnRfZ2xvYmFsX3Jlc2V0KCkgYnJlYWsgdGhlIG9uLWdvaW5nIHRyYW5z
ZmVyLCBzdWNoIGFzIHRoZSBlYXJseWNvbiBoZXJlLg0KSSBoYXZlIHNlbnQgYSBwYXRjaCB0byBm
aXggdGhlIGxwdWFydCBjb25zb2xlIGhhbmcgaXNzdWUsIHBsZWFzZSBjaGVjayBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjIxMDI0MDg1ODQ0LjIyNzg2LTEtc2hlcnJ5LnN1bkBueHAu
Y29tLw0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo=
