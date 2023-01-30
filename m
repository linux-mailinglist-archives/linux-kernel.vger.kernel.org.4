Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A86803B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjA3CEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjA3CEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:04:06 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C958A74;
        Sun, 29 Jan 2023 18:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCYyPP/GawtKcEoPRQ5RMAxZu1fVAy1NZ6FqjAZSP8Tw2kEn3qBniBZXhl6FAm3sDa4GBCD4PZieTEaMIhISOvOlzmpQc7OE6ukeROH0CIHMu7bvxXjYTNQFikiHvKhuds9zLhP3YfbQvJ9W0bYmVY3ywXPoezsdbl94DQcuHw4o64gEFI81rPnEdGhlHhwgGQcQolEk0fzRCM0bF5Knm1BDwAQBZ72Tugb4YKGpyVGKAu2gjapMcc7xhWBrB5CCg1ERNTY0f+NWw1Z1DVKfiQXkyYQWoKhx/OFVR1lnJf52k/HBt83JaCIo+tlh+EQdjhLMyubbWjVUZsJgZyofow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0udK7hkRXVzzMKeGm7n3CeUM3CrJr+6wBRtpcTwYSXE=;
 b=cgcJ3FFosgbMr+kqT2paGO1B6rx2ejV6ZT2C0BfLWY6+006nE9nst+fgVz9W238at90FeOkd/BJr8NN7ltEmYyKqc4CRs3oD97hs+Q2NIsko4+IpGiwz3WwMVLmU14zisQWTILXoYRTueNVXDGawjwmwck0IdP/lbcwuW/nKoZKDeMGHLS4DiMGtk6y+0NPuXM/tAMq7SDe3L2reeEbk/KmX/f5WoRg4JIxjc0cOexZbudxONDfLnCoKlwv972lU3Ih4Pw9wDifeDbZFhoeLhZMTI3v91FhM/C/61H//Dq2f2004zOoxm9U52PbM9F5oyLOnOtROGhZ9ifWCMii14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0udK7hkRXVzzMKeGm7n3CeUM3CrJr+6wBRtpcTwYSXE=;
 b=XBzBC5QwQlagCxb4TPAI5Z2vcxHUSqdVDd2amT6jQHwVRbsJRtC/CHiJPyBdVuJSEttWMS4RLdX+UXHepa9C3SYhcqUdIo6tyxl5q3DWO/Y5nmAx6vlg2xbTscqhxdTeweEaB4puDO57fbnDBP9w0FZ7dB+ZrslJimVbef/fe3k=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:04:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:04:02 +0000
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
Subject: RE: [PATCH v6 4/6] arm64: dts: Add i.MX8MQ PCIe EP support on EVK
 board
Thread-Topic: [PATCH v6 4/6] arm64: dts: Add i.MX8MQ PCIe EP support on EVK
 board
Thread-Index: AQHZLJMhOma9OYXfx06wTcn4fYdWRa6m87uAgA9QVhA=
Date:   Mon, 30 Jan 2023 02:04:02 +0000
Message-ID: <AS8PR04MB8676FE2C5AC0624D1B1D09EE8CD39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-5-git-send-email-hongxing.zhu@nxp.com>
 <2f833638-346a-5e79-bf39-ee4365794b82@linaro.org>
In-Reply-To: <2f833638-346a-5e79-bf39-ee4365794b82@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: 372094dd-dd2b-4fbe-ffaa-08db0266427e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JItPGbnT4L+skn7kqz60Jslr+DmyGHQllLRn0uT9ZTedveGdx6qfx4K14jLG9OCqjHWQMfkthqHGreVzPEWbfEoCse4ZC6QtgNpLWGMVkFm3W2XQZ5HV71AkS4Re0Z08RZ7EUYThn6Qjmhw4VGePAqSd6L8awKwCaKg/35VrTA4K+Y5LuRGzQRJ8F3LS02QkUaMIpShW0NxXtckrt7oDn7UXqynoFJYsKMzo/zzV8C8ZDeNW6bPzqIiJvw77c45LfAbDAiRoIx8gdYGA5YISXNpw31vy/DCxQGmLM/I+IADcUgchu974TmPen8aFccPEMUafjMSXwZYgy6Nc50ML0FRkPy6SxohD70YqTLgSlZRgCHNjMyKwl6PmmPMu5sP5hUWqkzAZmjhOpeEEzOIkcR+cLjlXGQJFy3KtJ77LpeQh1s2n1TX7SwHkEoPbZ01DZ51H7bf4fLJDmNNOKaAjhfMJWV9bhuB9LT07aq6K8hBi6jl9jwnRWG9XgG4hyOUdqYHBYu2dFSLNUwfl3JUzOuFpegzfRXyEEuT9yqk0dww81g3vTH8MYG1kbVYxl2OPv1ezK6UBAGl966HCZdbAFMnvvkRD1YG158lHVKbbsDwNo/NqI1U/xUv51Jy9HY0q4Dvyg7rJxOVhsPHvJILhF196wi1S/iAc0SOl031Thxce0i5fO6cN2KTskT/khbkgbX9F+CP5Xs0OdpEWndu7kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(54906003)(316002)(110136005)(6636002)(7416002)(55016003)(33656002)(5660300002)(8676002)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(64756008)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(52536014)(53546011)(478600001)(6506007)(7696005)(44832011)(9686003)(26005)(186003)(38070700005)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDRxWlRWQStIZ3lCTTQrUGlCMUx1UG5sN0M0TlRDMGNQMHg0WE9wZDI5Ry8r?=
 =?utf-8?B?anNtS0ljKzRiSnNuY2ZqMkJreHY0bDRIVlNMQ0xXU24yUXZjeGtUVUhEQkFZ?=
 =?utf-8?B?VjVPbnVUUjgrdmJpQzhVWFV0T1p2S3paUGpPd0hrN01NVjNFY1RJYm4yTk1J?=
 =?utf-8?B?QS9ZazhlR1h0dFduNVkvZ1ZZbVR5UEM5bVBCQk53SXpFbWpHRHNmcmVNZlZt?=
 =?utf-8?B?WXRuc0tKQVlUdGh3RnNMT29WVTlkWmtTNXpQRnpFaFdKTk52cFhWclZjeW1P?=
 =?utf-8?B?NnIzektHbEdnWEdaWk5SeEVHUFkremlWbkk2N3pJbTRjcWczR1lSMFRkcUt6?=
 =?utf-8?B?VzlQYVp1ZmdvOW1acEtPMEVjUFBleDNyeHFCVDkyWlROZHZCbktPUk5WZlox?=
 =?utf-8?B?MjhiVnl5M21HcHc5YS9UY2tNNVNxSlB3bWlYbjZpL3VsSWc2UTlSdEJ1dWdx?=
 =?utf-8?B?QWI5amJZTWxub0F3RU93RWI1UXVTODVWMExNUGtSZXlZSmd3UTBwRnNYWTdw?=
 =?utf-8?B?aEVjcWgzSjR3Y2JlSndzTmJTQUU2RTU3YlVJV3VUZnIxZzE4VjRBZGUxc3lG?=
 =?utf-8?B?dXJ1L1RLZy9jTi9qUmkyeklVQjZ4OUpXeWlPTXY3eXMxck9QNTNGTDVGYnA2?=
 =?utf-8?B?ang0aVNqVm8vMmgwamMyY2VocG5iVnRuVlZsd0g1Ny9LeUNCWVJ2UW8yNjk3?=
 =?utf-8?B?K0wyNHNhQmFWSVo5RzRIZEdOakEyUEFpSERKQjJVVXN0S1JNV3RoTldmeW5G?=
 =?utf-8?B?VDdsaUJGZnNnN0VTcllCY3RvenZNS2RLU2V6akRnaWFtOU5KZDdKSm00Nzhm?=
 =?utf-8?B?LzhsZTB3bVZicy9tZnlsZE0xN2RWRkF2Y21vTGJWWkZ1bEZBamh4OFY4TEs2?=
 =?utf-8?B?dHo3WVZGZFBWbWtYWStjSmozRnlNclZsV3VpQjNoaGhXamNoQUZhR0Z6ZEF3?=
 =?utf-8?B?ZldCbHVGOUpvay9IQ3FsUEF3M2tzakxDVTQ4aWlzQjhuVU5MTFJxSTdWYnQ2?=
 =?utf-8?B?dnRVY2Qyemxra2I3VnI4Tjk1VHBNeXptbWt2TDdpbkoxT2hLQmRSRk1kUVE2?=
 =?utf-8?B?Mlk1ZEgwSzJuVGd1RUcxTVE4V0wyRk54UmphRUFFTUdLZ0lDa2hNRnIwODND?=
 =?utf-8?B?Z2tJb3Q4TEZ6YnVxR3FwQzh2c3dWczhtR0tmazNIUjF5M1dLTURxc1V0WEo0?=
 =?utf-8?B?S1JzVkpZZkJNakhuY2J1Wll3QlhSNnJra2pBbDFzRDBjM1puYjh3bmpPZ2lZ?=
 =?utf-8?B?VmM5SnhpZTZ4RjVyeW9US2dqdUZrSzY5YnpkZEljQzVhOUI3K1VTYVZsMW9K?=
 =?utf-8?B?anFvUzJtbk5xT0VvSld2blMvNXkxNnVGNlNXUlV3QmJjWEova3RlUUNoeDNp?=
 =?utf-8?B?M3d6WGI2WkdMUTVzUEZwYlc5L1d2Y1RjRVpVdDBOc1J4S3pvZ1JRMU53Zk9L?=
 =?utf-8?B?aTFkTkhoRWsxbXpXcnYrbDR3QnhnRzVHMlRLczBsQXJiYnhkcnBuWDR5eHFD?=
 =?utf-8?B?ZlUxM21KcUJKc2xvZEVBMWU2Z3RSamhxaWN5bjdRZ09WdzdLRlpLcUtRcjNz?=
 =?utf-8?B?a3Bjd1B3dkpNMkpCZ25aOGxPZk5XMWVTY1QzcklWUm9FMnpZN1I1SWNWSy9p?=
 =?utf-8?B?K0xuS0R2QXZvZEVCcjdmajIzTUh3aXJ0UThJYzNXZUsrUTVtS0tQc3F6RFNJ?=
 =?utf-8?B?ZnFtVFVsTk94VUd5WGpZUEZvMWR5TnRvYktyU29ZbDUvWXJxZVJ4OEgybEk4?=
 =?utf-8?B?Z3dlcmpCNHNHL1A1Z2Q3clZzZ0E5U3Evcnd3aTlzOUdIVGtuNzYrL2Zqb2pv?=
 =?utf-8?B?b0tNcWV0UTNLUU9mUmNmVFczVGtlc1RtWHpmM2ZCVEJrN2o0Rk9oZnp1VHRG?=
 =?utf-8?B?NFp4N05DOTl6L2M1UCtXY3hwd2Y3ajF3eXJVcXcwcEk2VkQ2TXVJUnM3cU5N?=
 =?utf-8?B?WVp4ZmFVZTlLMm93bGF0WURHZEVQRlBtTDBIMTJtSHhUWDZkemU2SFk4Q0s5?=
 =?utf-8?B?bGdIV1BKWi9QL1NyajhldmgxREd2ZWo0UDBGR1BnTmNaR21KdXlNc25XbWxz?=
 =?utf-8?B?NUtTM1RFcjFJVFFXekl4TjZjMm5wZ2xIaWZlV25hcHU2UDhCa2x2SUYzMm1T?=
 =?utf-8?Q?ctpBtLeOIYB/B/O5cMeQVga4B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372094dd-dd2b-4fbe-ffaa-08db0266427e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:04:02.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEnNw9pb02p806RxhDx0vejUJ8uGcLYspE12IRGZlSC1AA0cdcNt9beMO/cRti0jJD9dSIdmmeQhU4LngZ/eGA==
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
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNC82XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNUSBQQ0llIEVQIHN1cHBvcnQgb24gRVZLDQo+IGJvYXJkDQo+IA0KPiBP
biAyMC8wMS8yMDIzIDA2OjI1LCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaS5NWDhNUSBQ
Q0llIEVQIHN1cHBvcnQgb24gRVZLIGJvYXJkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyB8IDExICsrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMNCj4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cw0KPiA+IGluZGV4IDc1MDc1NDhj
ZGIxNi4uYzQ4Yjk0NzQ2ZWZiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLWV2ay5kdHMNCj4gPiBAQCAtMzc2LDYgKzM3NiwxNyBAQCAmcGNpZTEg
ew0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZwY2llMV9lcCB7
DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZw
aW5jdHJsX3BjaWUxPjsNCj4gPiArCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUENJRTJfUk9P
VD4sDQo+ID4gKwkJIDwmcGNpZTBfcmVmY2xrPiwNCj4gPiArCQkgPCZjbGsgSU1YOE1RX0NMS19Q
Q0lFMl9QSFk+LA0KPiA+ICsJCSA8JmNsayBJTVg4TVFfQ0xLX1BDSUUyX0FVWD47DQo+ID4gKwl2
cGgtc3VwcGx5ID0gPCZ2Z2VuNV9yZWc+Ow0KPiA+ICsJc3RhdHVzID0gImRpc2FibGVkIjsNCj4g
DQo+IE5vcGUsIGl0J3MgdXNlbGVzcyBhcyBkaXNhYmxlZC4NCk9rYXksIHdvdWxkIGJlIGRyb3Bw
ZWQuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
