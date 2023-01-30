Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813756803AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjA3CCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjA3CCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:02:35 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B91CADA;
        Sun, 29 Jan 2023 18:02:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAdmtb1V9QEeD0iuGFbtUFCOHBMhFSXwaIoZUrzy7dNG89iq3WxjDqGC7YGn9Gd3EgfLFFYez7MEGkozcH0y60/MPm5Iu2MoDEsB7ha0Q8iEvBk0Fky0x+N4Xqird6Fhu3/0qkso0TcTdsNOknCKzmWBRIqgS8KTn6ZFHEZBjMow75XhddbNNnGRBpklWREF2p35UMJJTWP6+KMAe0duiZQ6IKK5I38MgHasNOH1Dzf1GR3paosffE4faC9Yc4oblkUuXW3MUMSF05B/Ac1NJN+CgqOIxd0MHd1oq12CLv6xtpKEyy1Ds85UCXja2wU6IAWI1VFVSoe23z3AHbabLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIBi4e3UkGbA0NuMULkYhNHBfaqlLyWYxKNFC/HQ33s=;
 b=YD5aKjaWlKjStESecjAC+nF/ZmzcwgHfxLFGwqtHF/K+AoV/LMeRG30cOei7XWI6iapRHLTYpqyrZnicmEGwgF/4o6jvg5yFCLQMiwcutAM4lpRrNombO5WSzpHVWv2AjNXla+WeR9yenyjc5xog9fHf7rMakHb0AQdJrQqQppo2aiTVFfYZfHloCMlBcehiNdl/4eoPzOMUZW21XZVu8PJctGhbX3rGVmPISLDNu/XP92F4ToFgklQy4cfLmmD6jPzIwyTl4+WRmhn2WjZUWg86n37a3hx/ixqy5ra8UK0hbiDsVpz5Gp0C7s2Hpk1S4yDzwn6nwlQLnXjaLF8Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIBi4e3UkGbA0NuMULkYhNHBfaqlLyWYxKNFC/HQ33s=;
 b=REqVEPZUAiljFXynIl6+rgbTyYGnKA3Iup+9mmsOUQQ6ASCzW3qYdwoBd5BaMXJ6/4ACpOQFqAS8kYdsoMstRVVKk8uzRzBrred8jhaKybwiOhLVcetwBwixn5lOD82Gz12CrBJtL1HOOGds8oHWfoPZCH9394i/2EPK1WLkD5Q=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:02:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:02:15 +0000
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
Subject: RE: [PATCH v6 1/6] arm64: dts: Add i.MX8MM PCIe EP support
Thread-Topic: [PATCH v6 1/6] arm64: dts: Add i.MX8MM PCIe EP support
Thread-Index: AQHZLJMfemkMs1GwMUqt5jLjPaj9aa6m83cAgA9K1iA=
Date:   Mon, 30 Jan 2023 02:02:15 +0000
Message-ID: <AS8PR04MB86769DE0BA3D2D077B2EFF378CD39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-2-git-send-email-hongxing.zhu@nxp.com>
 <c4733adc-4f2f-f4ff-5517-b4d2bc003ac8@linaro.org>
In-Reply-To: <c4733adc-4f2f-f4ff-5517-b4d2bc003ac8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: 4516b7c6-7283-4829-cd34-08db026602a0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAKdDvmUfPpb6BuhJXZOo5E65A6CNENJGuAEZJjC5S+fCqwa4+lERmKP6gY4lBwM+cR/nU4P60yUz/ec9HRsgaJ80sviOMiQ/YtB6vng4dDpAmoVm6KS3rih4kCqWwHQOEGaS4NdQGcsg1kgFCuW6v5XxWCDe7wfBwz8IHlPOwwZ09hdIaK8zc60654ntq7GD2boJNWpVJRqnHDaGG/zvBSGoBmnCA0Y4RiNpvLa6bU4fl4Wu7hyFr+Gt7MYtRQzPOKy1oLJaqHl8xzdkTrYKlvpw3TEIBGSWXCg1QzdXKdHJXNjfY9jk3n5bEiRgFl1/X7ESP4GEG5FHb0FDNhL1Ldb9pjdBNl45iiwB6fG5lZZpEJrLcyyY/lanffTQ0zltfktMTTotNK4k3TteCNvXqLf5WmSFfBENvecDq5K2JOBV7HuKdwBhA/sypBuObaxTyVmoidXuZhxxvmMlG6Lj57Jsf/+vFT2j2pfEPkL/zEreRUwP9uFJbaWmAdLD437bK3g1JLf5DoI/A7iMVOQQVAFpxdBwob1/FbDd2xysM58yFmSvqvI1sgphhskbf8HkniVgZzkQsZ/rZDlk4/L5OB9Pz4LzlcbLK56cyq5QAxgVKSVb2e1LCOFj5VYaSEoNYrRAZ7d1v+q60a9+nWluoZSVTkzyg/RHHI8Yso6WHrPYepUdflSJC0m8rLhQZd+KYZSpRcQtZgwveivtu1+KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(54906003)(316002)(110136005)(6636002)(7416002)(55016003)(33656002)(5660300002)(8676002)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(64756008)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(52536014)(53546011)(478600001)(6506007)(7696005)(44832011)(9686003)(26005)(186003)(38070700005)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1c5NHZiSFArOUlST01qTGNrcnJUUVY3ajFONmNMbDlaTXRnMThIYTdCelA2?=
 =?utf-8?B?aWY4VnNUaGlvRFppTXl4Wk1VUlZxUksrMUE4UDI4U21IQURHbG1yR2tZdkM1?=
 =?utf-8?B?aGt4RDZDdkFiVGJ4VmsvNWlKTHA0bjl5Tk1zeEVLQjd4VUNYbnN2Vm5Zcm5G?=
 =?utf-8?B?YjlWakNvMGxYM3Y0ZzVjbWk0OElvVjBXMUorekphdkxNZnZrWWo3RjNHZEV5?=
 =?utf-8?B?OU5OMUkzajcrQVRMRkI1dDhrVHVSNUdwK24yODVpSWRycTU2UkFwTk5uY2h1?=
 =?utf-8?B?aVJsZzBqc29qSEs3MHZJWkZWQnQ5RnlZNlVPN2xUcHRJSHdtRU4yeFR0akFZ?=
 =?utf-8?B?cUxYMFNoZXVtSVRvZFFoTExZTGZFZGh4dGxVZGVwWllndVdvU2hDeW9aQ1RS?=
 =?utf-8?B?YlhMdDltbUNnb3VCS1BrN0hDYmU4Y2dBU0lGK0xBdVBoMjl0YXRhR3kzRHd5?=
 =?utf-8?B?c0R0bENvTUovWXlCMitkdmtPZXBKeE9Hd1Z6ZHdTOW5hVFIzemdIN0dEWjR5?=
 =?utf-8?B?R2c4YThYVUFaZGE1THRjUENWYUQ5Ukt1cUd4RFZTczdmVElLNk50YTliNzhJ?=
 =?utf-8?B?c0JobDJNeExlV0o0SUI5Slk5Nnd2SXF5akpGMDF3TWRmdW81NmVZcG9XNHdG?=
 =?utf-8?B?OW5oRVYzVlVMSHhlSjZCZzk0dzR3STlhNEZNeTlkWmlsYWlOWDhmQWFwdk1v?=
 =?utf-8?B?UXBvMU9KOThJQzQwb0QxZ3VSS3czamF1V05Mdi84cUlwcUxMMWJVeUFKWjh4?=
 =?utf-8?B?SktXdVNJSTI4WHp4SHl2MEN4RVhra0FETFU2WGRHREVweVNzc00yZ1prQ2Uv?=
 =?utf-8?B?R1d2c3ZiZ3kvNWUybjRnUnFIZmY2cjJNaGsxRTIzNTQ2SCtCWWd5WjVzV3Nr?=
 =?utf-8?B?L0dTQlhIY0dEdkRpTzY5ekNxV3lZWFlaZEtsdXhzN2p2aHFkS3hIclIxNnJ0?=
 =?utf-8?B?L0R5ODl3YjBUSUNvM1BsYWZBK1Z1eVR1Vnp0eDBHckh6MUxKUlFvQUFxZXdC?=
 =?utf-8?B?S1BBbjkrcGxJSGo1OTEwNmdUU2FWQ25TTDdhY3pvOFR5ZkEvL1MyL1F0T1Qx?=
 =?utf-8?B?MlBjU2s5ZmdSZGJXcW00T1QwNisxQjZjRWZLZjFET3lwZU40cnVudXZ4UCtv?=
 =?utf-8?B?Szlkcjh3Y3BLdm0xZDZZMFFEUDlrdkxOWnNuT0Y4NUVHZjN6eVZvT3FGVi9M?=
 =?utf-8?B?ejJpZkJtd0ZLVDF0R2F3M1ZzR0hXTldOckVsZFcvcXlkcklDclVxMjdPc3BM?=
 =?utf-8?B?WkI1b1JLVkRzUzhDRC9Ea0FSWGRBbE9hRmloeW9NMURvMWp3VGtTM3phdW8v?=
 =?utf-8?B?eFV0Nm9GMjM5eWRkTXdCeTU2STdNRVhJNW9ES3JNem5Ud1JUV2VManRON3pW?=
 =?utf-8?B?aWNYQUJnKzdFSlVZdE00OWtwb0EwZGs0SVBPQVVWY3Y0ZkhVRHM5d1FYMi91?=
 =?utf-8?B?ZlpxQmlQbzVKWk5jNUVrbDBFWmc0M2YvZDJDMXdxVnRzQnhsMmY5Y0JGc0tj?=
 =?utf-8?B?S3VrOUtGQ04xY2VSN1hRTnlySmhVQkZYVmFPVjRlZEVyMGd6TDMybm1PSlBk?=
 =?utf-8?B?TGhwTVE5dnZWak1YSnp0UHoxWnhYeS9ZeVQwR3phSjN4ZzcxWHFpSEJDT2NE?=
 =?utf-8?B?aU82RjhxTkpBQ0ZaTjlIS01tR29pcDVmcjgzOGpHS1ZnR29FR1pyVzB0T2F6?=
 =?utf-8?B?TGYzcnplZjgyallLY3FLYnR1OWtFTHZIQWF0M1hXSGtvR1V4L2ZzKytwcmxR?=
 =?utf-8?B?UEM4SGxSWTg1T1Y5ZjR1cFVxSmlUUzV6Y25TcWp4Z29aUkw5Y0lVdjdnS1J2?=
 =?utf-8?B?MDdQWlh2NWNzd0pqSC90K3pnenZlTlhYNWQwUHRFaFJrRnVEN3BkZlpLWmYw?=
 =?utf-8?B?WjdkZTdaUk8vWXlJd3U2RDAvZy9xTmFadzlwY2s1dXRRNzUvVzdNRlNyWFQ4?=
 =?utf-8?B?QVgvaGx5ZzZ0TzdUZnJ6cmFCWGJVUWd2bEFPakFtYmQ2YUJnY1E1a055YzdY?=
 =?utf-8?B?U3IrUUxIVWJycldVT0J2U1BQUVNiTXNUMlRJdVhHd1p0Mmo4T3hkdlBWTFJZ?=
 =?utf-8?B?ZmQ1WEp6UCthR1NHNm9pWWNtbFlWdmNWZjZ6MGpSRFNPazZROTZxOWdEVGJn?=
 =?utf-8?Q?kr9+4bfunomLpXNPmkEkPOauP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4516b7c6-7283-4829-cd34-08db026602a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:02:15.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vlc/EMjjTdQQmq5EAWDA5u16gTQBon9N7PVILRLB5vjvovLBYo8DaaPg5K3UY6m7D4/WJdRboykw1VaVJGzWiQ==
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
l6UgMTY6MDgNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hh
d25ndW9Aa2VybmVsLm9yZzsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBtYXJleEBk
ZW54LmRlOyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47
IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+
IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMS82XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNTSBQQ0llIEVQIHN1cHBvcnQNCj4gDQo+IE9uIDIwLzAxLzIwMjMgMDY6
MjUsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCBpLk1YOE1NIFBDSWUgRVAgc3VwcG9ydC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0
c2kgfCAyNA0KPiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kNCj4gPiBpbmRleCAzMWY0NTQ4Zjg1Y2YuLjk2NjJhZWNjZGIzYiAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4g
QEAgLTEzMTUsNiArMTMxNSwzMCBAQCBwY2llMDogcGNpZUAzMzgwMDAwMCB7DQo+ID4gIAkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICsJCXBjaWUwX2VwOiBwY2ll
X2VwQDMzODAwMDAwIHsNCj4gDQo+IE5vIHVuZGVyc2NvcmVzIGluIG5vZGUgbmFtZXMuDQpIaSBL
cnp5c3RvZjoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQpTb3JyeSB0byByZXBs
eSBsYXRlLCBzaW5jZSBJJ20gdGFraW5nIHRoZSBTcHJpbmcgRmVzdGl2YWwgVmFjYXRpb24gaW4g
dGhlIHBhc3QgZGF5cy4NCkdvdCB0aGF0LiBXb3VsZCBiZSBjaGFuZ2VkIGxhdGVyLg0KPiANCj4g
PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXBjaWUtZXAiOw0KPiANCj4gRGlkIHlvdSB0
ZXN0IGl0IHdpdGggYmluZGluZ3M/IERvZXMgaXQgcGFzcyB3aXRob3V0IHdhcm5pbmdzPw0KPiAN
Cj4gDQpJdCdzIG15IGZhdWx0IHRoYXQgSSdtIHRyeWluZyB0byBsZXQgZnNsLGlteDZxLXBjaWUu
eWFtbCB0byBjb3ZlciB0aGUgYmluZGluZw0KRFQtc2NoZW1hIGZvciB0aGUgRW5kcG9pbnQgbW9k
ZXMuDQoNCk9uZSBzdGFuZGFsb25lIGZzbCxpbXg2cS1wY2llLWVwLnlhbWwgc2hvdWxkIGJlIGNy
ZWF0ZWQgYXMgRFQtc2NoZW1hIGZvciBpLk1YDQpQQ0llIEVuZHBvaW50IG1vZGVzLg0KDQpJIHdv
dWxkIHN1bW1pdCBuZXh0IHZlcnNpb24gYSBtb21lbnQgbGF0ZXIuIFBsZWFzZSBoZWxwIHRvIHJl
dmlldyB0aGVtLg0KVGhhbmtzIGluIGFkdmFuY2VkLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
