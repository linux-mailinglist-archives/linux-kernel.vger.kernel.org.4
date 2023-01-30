Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733716803AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjA3CCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjA3CCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:02:37 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B81D1C5B4;
        Sun, 29 Jan 2023 18:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjWGf6RmU/0X+LQyjts+VDaBUH18eODa/I9jxG0x3kTVd/z35pS829XPQo7+SFDhPojUOTEneIPHeQXF7aw4Py2rdmrgNG27o2wO14wWY7nf6G2Ylu86tSxw0mn0DYBsV9OQou0arDn+YqEB8I8M1w6DmiP75qheLH7IyylFdar64IxXC75bGR1X8j2iHZa3mqedkVASpOA5xzScNNFIjlAxx51J0iygEdaKYRXLs2DbdCt9fcNWeLioZvzNF1sbu2woCX3UzL/QC6GYi2IKkxJ3oEhyZUpL7CPHZp621o0UgHGg3MeWeA+Mbzgq3vdD5pGV6Xih7lbGf1738kQK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGyidAzNMSI84Ym/3apmZ0Sw76y/XCc7HIBbT0OgZ7g=;
 b=IK+OCO8omgv4KOwMzdJDSEFnq2WQ9/EupS7drC49oLe8UnrhYcv0oN4O/IL/XDwtrdGWJIlLVHZ3GNwbslcAQ2ykjaOKu3DvSg6oM3r+/bZWAfu3k5rMeglnWBbRi1AmRokOA+MKpJBKNrwfmqMhzdCDfnM2+4gAqVrFoTtuPMDw0rjnim8rkDoC+JSKMqtCz5+mzrILdi2jixYSMkdgU2Ef37+coWqIc+qGn+VVqfZLbHLhlFQ5+25XRwkuy9ZYc1bGcEx8wiB3js7NzVT+8H+5kG+BPjKCVVbgzV7Wq00sSQ9DKoepUjDYvlyOu9bKN2fb904zJCFocodHFkoC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGyidAzNMSI84Ym/3apmZ0Sw76y/XCc7HIBbT0OgZ7g=;
 b=V1+wVSzfkv5Dcp5dDx1LRWS7fraKmHp1Mogj9kq5I7ATHVd0iP9tGEzJ+4evJ2vwoWvLiMs6SFkBe5/aAHUiok8CKUJQ3UBRO3Bs/7dXDAvdPRZXOrlRi67+e9+/f/WUxuH0amf2U6tIP/s/Y5veqTgXoDOigRNWIH/5Eew1L1M=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:02:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:02:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 2/6] arm64: dts: Add i.MX8MM PCIe EP support on EVK
 board
Thread-Topic: [PATCH v6 2/6] arm64: dts: Add i.MX8MM PCIe EP support on EVK
 board
Thread-Index: AQHZLJMflWfx60ZGIkC8V1NmI7DrQK6m858AgA9QNlA=
Date:   Mon, 30 Jan 2023 02:02:33 +0000
Message-ID: <AS8PR04MB867684E4FD61EE706D8A8EDB8CD39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-3-git-send-email-hongxing.zhu@nxp.com>
 <87469ff9-8fd6-7775-3d98-7d0b557d8ff9@linaro.org>
In-Reply-To: <87469ff9-8fd6-7775-3d98-7d0b557d8ff9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: 416b0034-407f-469a-e03c-08db02660d37
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qap28KJgkREf+1FqEc05vrHyPV9ATnyKzfCKdHu9tmP6SY/0NfWzSi31PNEA6P3CiKk3cthd3AZ0fUyhEt2itWTsqpvtF6O6PjZ9eJM+IHJ68jWHvBJHj7pYt6G/gFTotiZr4itLCdz1yMsgH9U5tnOdtXHN5brMDmAcZ2j71TQsXq5JuCsLw3eKro3F77ouM4OyiWJEbwhyy5QRWLvY+kvAJtOnUeVUZwVRhJMZBALZ9JC+sF6IlxjUWBdxXYxi66pCes4oGolmkEAgnlZzWWieZLHiNdp8k8x8I2SfTosDZOcypsrBEqx+ZVSsf+2JatN875tzNnuAz0IB1NtJULjm19h03qQuqPy3d/hfPxAZD7WDqxJBEq+cgeytq+uEQq/NPKfIM+Px+sgIxHYRNeV7XFbypjXl4PgYziYnQGXxWWGQFgK4Ar3tjOldqMKMSYbGqEdSph37qbh8lIUMVT6LMe32i5w5MIMtNpi1nUGcyt4AZOLU9euoiRJLbY05hIJUFBUbexS9XSRAWPmhcv6+Z8oBDxk7KJAMBfvmanERb/bbxe4Dq4YkxH7Pkd9Ho4kgAY1LiJlR9Xm93+sFtiVVdNu66Vyt1gUgm8eHSyxA8WtmEitWJfZrDYpmycSyBxoFKQJkLMSDLlP2YK39rVjLvUXdO5ieCddF7nlH+HKbBeTVKPF7cGRvglvw7TqcwX30gQKyDRLilQ0RW31t7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(54906003)(316002)(110136005)(6636002)(7416002)(55016003)(33656002)(5660300002)(8676002)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(64756008)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(52536014)(53546011)(478600001)(6506007)(7696005)(44832011)(9686003)(26005)(186003)(38070700005)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FPVi80TVgrTHJkNm15Qk5HNWpnc25QbDl2ZjhYOUVCcFpsaEFWQnJsVjRC?=
 =?utf-8?B?cEwzT01vSldWV1cvYlpCblVmaU9IVlhpUXhEL1lCbWVaMGJGRW9FYTlxZ0tn?=
 =?utf-8?B?QU94bldNUm4rRC92aUVGb1NtS24zdmhhTm1XN2wvT3Naa2k5SjVxRFJaMVhq?=
 =?utf-8?B?UzZGNE53Y1FmaURMY0hVQVJ4WFIyNFVVNG5ZMlo4cmpzTHgwbjBEREtJRHBh?=
 =?utf-8?B?UkxxQzZJY2c2Zmc1c3VuRnpXdWppaEFydjdoMjJ6V1JUUkxIeE0vODVyQ1Jw?=
 =?utf-8?B?bE5qYjhhUG5MT0JLMnYzSkQ1czNQU2h3TFZYc2FPL0NES2hpNW5kQnNsa2FE?=
 =?utf-8?B?L0JxTytLbHJ0eEFmbWZkWXJVYS8zTEtCb2FVRTNXZzRoMVFyZE1KdE5uOFpN?=
 =?utf-8?B?RUdKbllWbW9uMlFuNm93NXozVWtyNU9MdDJTUko1dDdHdzZZMHhCQnZBalho?=
 =?utf-8?B?dzArYUFHaE1HSjF0NEtZNW1WNkN3TG1UallmYndYUUJiRmdKekNxamNsWk1O?=
 =?utf-8?B?MWFFZE5QZUQ1Mlh0a0swcDZpU3JsZkk2VFZ1ZmxzditIYTMyd1hQTmhVZTQx?=
 =?utf-8?B?VWdZOEhRTkNDeURINGFUVVhQY3d4aDlISmpSbExUZ3FvNE5FaHVFUmhKNGN1?=
 =?utf-8?B?NC9UMWJXWnRvMk5WRzkrUWdHQVEvRWh1cy9UaThPcENSYTgxbmVEckNPbElC?=
 =?utf-8?B?MlBnbGpKNllhRmVOTmFac1NRTk9DbVlYWGN2L1laOW9hRzFDL3VCVWVYVU1k?=
 =?utf-8?B?UktxZWwyclg4VklDLzF1anNQazlCS1hKYlJxRzVkT3FMY1drMWpqRnY0Y0RN?=
 =?utf-8?B?dTNQRFNqYW1qMFJmMElZdTJ3TjZ3UGNDeitPejlDekFKeVVmN21VZFN1aWtT?=
 =?utf-8?B?cGtoVHd5M0U1aUc4bGlHR0J0d3A5Q0pENk5nK0NaTlJmRFlYVC8ybG9FR1VF?=
 =?utf-8?B?djRrMlRFODBwY05WMVZtSFdvblM3RmpaQnQ2MFdNSkQvanJMTFZsRHRvbmNw?=
 =?utf-8?B?a3gzSzRFM2F3OUtQQ2l6emNUZlNCU3FkTHRxNS8xaCtYU21SYTVnSnFDODdP?=
 =?utf-8?B?c083eUtEb0RBQ0Z4cU1jaGdsaEJkZWlvbVR6TGd6NE9IOTcyNmZ4QTNDZ2FB?=
 =?utf-8?B?eGVhNXhBL3A4dUFUeFRuc2M1c3pnWUVKQ2x3UUp1ZCtLUDQyQ29adG5HZDg5?=
 =?utf-8?B?aGxxMFlyb0pyMUoyL2ZyWmp6N2UrQWRjOU5ONmhmN2krQmJNVkxwQUk0eVhF?=
 =?utf-8?B?T0ZnaWNMTGVMZlM4K3U3STcvemRJc0w4WlUxZGZPYXhCeXEvV1ZwWjJyODA1?=
 =?utf-8?B?VWU2Y1EvamtOWHZ3VzliZnpVUmxOVTRLYWtxRTNRNXRRU1NrR3BiR0RuQi9S?=
 =?utf-8?B?SEJ0cEl4UmJ4MEdHbnhKYVV4R2NKMlZzNEI2TTVXdTc3ZUZNNXc5cmVZU1hG?=
 =?utf-8?B?aEp6V3RnZytZNUdKNGVKTk15M1ZrNWxMUmRyRG96RHRqY0RBMTl5VHpXWHBV?=
 =?utf-8?B?YVZINnJVeXZaS1JTamRvUldpUGttSVRQcm9qeUNzQngyWmhWUlB3TmxZYWNm?=
 =?utf-8?B?dExYSUJ2akpQeE1KY2sxUTR4SGc1a0srZ09kYVZiYjArWFRIUU5hQlFlSFho?=
 =?utf-8?B?aktaZnlFREloOG01MXNLWjloOEZaY0xDa3dQVXM1NFFuSG83b2FSamdUZjBs?=
 =?utf-8?B?cCtRazlvalVwWW1oZGNWOFhiODFOcncvNDRnL040V1BqUzVuMGRaWWk1NVdU?=
 =?utf-8?B?ZUFQUStabFVQRDJIcHV4L0ZlNWxOTVBJQ09kRVVobHowajZFNHkzb0xmR3Rn?=
 =?utf-8?B?bUJwd2VwL0dDZVJhOHhOSTBaWmZBN01WSy9LcjM4c1p4ZE1oY2F0VGNnTlUz?=
 =?utf-8?B?L3NSMGR2NkVlb3RkMkNOdEpjbVFMQkpSZnBwYlhxc01meGVlSVlPMjhOZEd6?=
 =?utf-8?B?QzBENnUzTzBTb05tTHBzL3hVUzlNa2hyd1VqbytDM0tNUGdKVUV3UklxWkVE?=
 =?utf-8?B?dHB4aUNSbnQrQnBZL1RTSSt4REFJemVSamwzQjBwSHNTTnhjMk5sTURsRTdp?=
 =?utf-8?B?bERmK1lkODUrOEJQclpIUms4QzFvSWNrb2lxcG1zelc0WVlaNUltMkJQdTdR?=
 =?utf-8?Q?O7FQKnL0vhZ7RSc8/vnoq0Pk8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b0034-407f-469a-e03c-08db02660d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:02:33.4262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwUt1PVe+MWAka7kb03Yqk/C3IFwNyqREmPrgrG/4ltkV4M/OlEf7CiEvhULp1m+iudlSY9b//YQ0QyA411DVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQx5pyIMjDm
l6UgMTY6MDkNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hh
d25ndW9Aa2VybmVsLm9yZzsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBtYXJleEBk
ZW54LmRlOyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47
IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+
IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi82XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNTSBQQ0llIEVQIHN1cHBvcnQgb24gRVZLDQo+IGJvYXJkDQo+IA0KPiBP
biAyMC8wMS8yMDIzIDA2OjI1LCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaS5NWDhNTSBQ
Q0llIEVQIHN1cHBvcnQgb24gRVZLIGJvYXJkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kgfCAxMyArKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBpbmRleCAw
Y2UzMDA1ZDU3OGQuLjlkNjViNzA5MzlmYSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBAQCAtMzcxLDYgKzM3MSwxOSBA
QCAmcGNpZTAgew0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZw
Y2llMF9lcHsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwlwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfcGNpZTA+Ow0KPiA+ICsJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19Q
Q0lFMV9ST09UPiwgPCZwY2llMF9yZWZjbGs+LA0KPiA+ICsJCSA8JmNsayBJTVg4TU1fQ0xLX1BD
SUUxX0FVWD47DQo+ID4gKwlhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1BDSUUx
X0FVWD4sDQo+ID4gKwkJCSAgPCZjbGsgSU1YOE1NX0NMS19QQ0lFMV9DVFJMPjsNCj4gPiArCWFz
c2lnbmVkLWNsb2NrLXJhdGVzID0gPDEwMDAwMDAwPiwgPDI1MDAwMDAwMD47DQo+ID4gKwlhc3Np
Z25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1NX1NZU19QTEwyXzUwTT4sDQo+ID4gKwkJ
CQkgPCZjbGsgSU1YOE1NX1NZU19QTEwyXzI1ME0+Ow0KPiA+ICsJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gDQo+IEl0J3MgYWxyZWFkeSBkaXNhYmxlZC4gV2hhdCBhcmUgeW91IGRvaW5nIGhlcmU/
IEhhdmluZyBkaXNhYmxlZCBub2RlIGlzIHVzZWxlc3MsDQo+IHNvIGVudGlyZSBwYXRjaCBzaG91
bGQgYmUgZHJvcHBlZC4NCk9rYXksIHRoZSAyLzQvNiBwYXRjaGVzIHdvdWxkIGJlIGRyb3BwZWQu
IFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0K
