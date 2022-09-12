Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278565B6222
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILUZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiILUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:25:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC3491D2;
        Mon, 12 Sep 2022 13:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZUi7BEf5vAevSZ/aqIN/ehoj3qCKLeij/eSuWaB30cjXfRlzMdPOrhPq+NrupvV1I/vZ4RZBbgpWI4pIIGGr5+23h8e59STL6G54jD5iN0E4FJKCieu/mYQaT0ODDd1Rvb+78x1zvhUes0yGisPOnr8F0Yqztd3sAq6I8nZOtUbRRqG25rbnlSw3BYTivUb1mAAtEPK8uFLppKWCPWm0sV4cRKDz1ysJnMf6gTO0vo4AS+OAIAEgxqUIlZolPmKqGbhP7f/RD/0mqGHZBb1aWrTAaUSEHVdax7MPMtndEQMreaYPdk9P9ZrNI6/RBaoymbkMw1mCLYB5sJF0g3HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtyJfyAa2vXdfaRRJ/2gqPN92w/EJ7hH+5vPoIksXPk=;
 b=CY04wB6nAv4Rf5gm1nFmx7IGx8hlgpJtGRVBzG14uNsyRj0yOSdQvBQwG0J/tR+Yg7QWXGZRTjjAT+4GDgRVUdzBz0kV/o1yE0yWuf39u9CTm89YJleRUX79VhEUN1D3diWU95r2tROQDzMVJqFaVCtmF42Kbwhl7BIb1WV9nM1UT6pzGPfvz8ew8wS48+gD7A3Fr9PsGh8JBjAPV5zmIIAVAMffl1qeKAXXcX05Okro6E3zJpMHoneqIyUDEU4ABzGwbL/1lnkwWcGH0u9zJQUnJc6Cjprico02VgqXX9tbByZGE2G3Sb9SLbJcc0qg37hKSxNW3RyDx00G9P+x5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtyJfyAa2vXdfaRRJ/2gqPN92w/EJ7hH+5vPoIksXPk=;
 b=Bv7KVuWWzO0gCUTBChgMOf1L/veUsprFVj+OlxolSHJoFN3aQnxO3dWICAS5Vb54gwNowiXNd6vUlGrv4UKu2jJTBGY4IUCtVU9VO+4JVj2D+9d0Q9P0mFLQdNAN3kv7gl0G4PWSkBGWvzRNBvGVEUBCT3rILC/yFvFeFRTp4l8=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 20:25:40 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7d0b:b02:69b9:a3b4%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 20:25:40 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Topic: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Index: AQHYsneOky2+HjmY4EWzmWjEy+MxQq3bhxCAgADehdA=
Date:   Mon, 12 Sep 2022 20:25:39 +0000
Message-ID: <AM0PR04MB6289B28243FCBA64CAD110B98F449@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
 <20220817202538.21493-2-leoyang.li@nxp.com>
 <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
In-Reply-To: <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AS8PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: 0286530a-c2f0-4905-35f1-08da94fcf5a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tORfKZPStf0MNEKZ7ke85fLDmY8ihtykRh4g5ehTH8u/7IjS9kgUnuAtvLO/4fA/BkCFjLOpIP8onH6LvTcJnlqddHPA8EyYiSL10E85ASOjH9EeT3zUrPiJmKAhWZyXwGyPzElizg5DnJ/jiTiSyRdO0Vv6IINgoi1n1vE3LGgtT9qrlN5IKa/ad3dwLU/UiUwMkhlNRji9R34EHOUSiQO/gkrFW/BOh62bO2LAhjTa0fLVFrqksu5oseYcIN/PAtzxI1L456K5vouI6U+CRGzl7HDIuef0qLo1XuPLY33GJtz+Z834bg6Sf+dqFPQE8HHYhvQbwPDXsifmOn0trEPiOZi00HcvV07DfdAEmTrB0lRaGBEbvcKTosdkdq1R/dlL6qtrMsv8ccrEPnFa6mSJwJVQ559zKZ57aSnNa2PtnhH4fkDjLKB8UE7afufaa1uSUbQCPmf/eakEnYiM/s+KFmkXWkbih2e0nEq+EFarwUS/3c2Cex0q4Uv9z2yrBYJ71CNsD0v6AVeNPlhlu668iKym5r7IckUn9wr2MOY9DTSUUd/h4SblZ0qpLTmiHbZiXoyz6J6+G4jY6r53IZnGyKVQdclQ6SRzR9YtzAcLqpckVNcvxp7+kjLbLv2+rDduHHqjMhBHImMrJi2BR6BcDiywV2GMDJGbH6r+ucJS/C0os1Ywq4MkWkrul9S1DVH/wASCKzl2fayNuQR8sHpcOSEu7YuI8pvThYHHE53GJqyBaNsiMF+6MjHRiyC9xAGJEoskRzbONztRQ5IdhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(83380400001)(55016003)(186003)(9686003)(52536014)(8676002)(6916009)(54906003)(5660300002)(4326008)(71200400001)(55236004)(86362001)(53546011)(6506007)(66476007)(7696005)(76116006)(66556008)(478600001)(38100700002)(15650500001)(33656002)(8936002)(41300700001)(122000001)(66946007)(64756008)(26005)(316002)(66446008)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlEwNnkwcmRFeC90OWI0RXJGMWxsTlB0Rm9LTDFSZlJEZVBvNDBDUzkybDd5?=
 =?utf-8?B?Vmc2MW9rQTY2dHAzVjNCbVBycVZ4VmdMdTlNTmp1WEhXb0FLeTJQUU9DeG04?=
 =?utf-8?B?Q01YR3h6S1RETzhRWEhiZTdabWtrU2NTa1VCMTNiTE1tRTZuQnhuckNuNXR6?=
 =?utf-8?B?YkNzcUNkWkU5bUlJWE9KdFFFMlh5SFpucTBLazRSQ2F5a0lSMVNJbzN6TVcr?=
 =?utf-8?B?TFB4L1M5Z2wvT2hIQ2xWYThIamtoWnF0MC94Y055QkNtaWcrbk5WTk5OQnV1?=
 =?utf-8?B?SlAybmhDaGpuVXZwc2ZpQklLMnJHTlRCdUxvVkoyZlk5cEYySFdzK3cwT1B5?=
 =?utf-8?B?TVlFY1p1Mll4bWhvdDNFZXRRZGlaekdGMFlUWHJxdnVqM2taY1Q4MXJDaG5S?=
 =?utf-8?B?L0JMcVZNTE1OeTZ5N2ZHMFFJd3E3MUlKViszdForRVYwVTFqTm5XSThwL3d1?=
 =?utf-8?B?WTRhNWpka1hvTW80RVNmMEZLU1JnQ0syN0IxMnJ0Q01PRHNXNFQ5bElJT2h5?=
 =?utf-8?B?ZkQrdHR3YStGQUdtdmMrT2lQeU04dUlVVWRiQnNWT1o4WDRWVldMUG5SNkhL?=
 =?utf-8?B?Um9INkZxZEJUMUdKaWU5ZWtYNERiRGFBTzA5dWJCOFpiVkdzcFg1NUhMbU8v?=
 =?utf-8?B?dm5HVGN6cFVObU9yblBEdzFQVE5Rd0d6Z3JhckJEM3Y1eWF3STltRUZDcTFL?=
 =?utf-8?B?cVVneWpPSitsUTg1R2diN3JsWFNETldzdmQ5cDcrb3dxUkhkUXMvSmIxVlg5?=
 =?utf-8?B?WENCYlhGZmFBRkJhYk5rK2FGZm13SGVxVVN6bG5SM1ZaaFVTZzVXYmk0WDJq?=
 =?utf-8?B?cHFIb0Vrbkh3VHlzS1lBeC80TVVpNXhWdzVVTWIrRXN5OEZaVEpjRWpjVmcr?=
 =?utf-8?B?cVZEZkp3M2Y4dUZxeTJtUVN3WDNuNEp1eGlPend1L2cxYzMvYlgzTTZ0QlNv?=
 =?utf-8?B?UHhxc3FMbEYyQk9VMHk3MVlxbUFjbk92NDlLRmtMSjVobm80MmlTZEk5ZmJK?=
 =?utf-8?B?MnZiaDRuNGtLZnRDNHh4K0VHNFh5ZXBVcFBJNEZiMUprL3BHdi81Wi9ZYkpm?=
 =?utf-8?B?Z01FL0pUUC9ubllMYkxpdVhsUHNSSnJ6WktjalFtTm5paSs4Z2VxZ01scEdB?=
 =?utf-8?B?MExwYUVZL3FRbkdvbDd0cVpVVDhSQkVJS0lpREJiQ0IzQzZrWFlMaVRhTjd1?=
 =?utf-8?B?OW8zSS8wWEkyRGtYeUJrTDEzbzdVM3NrYkhvZnhjQ2ViMnNaUkZBU2lQYit4?=
 =?utf-8?B?dXk3dHRMdW1iaWYrVHowUWhwS2YwRnBTbThXdm1FNVBnMWQwcUZIZEgycDgw?=
 =?utf-8?B?L0ttVDJndHkwNmw5U3ZodGJlRFBocEhZdkhPWm52cVBqQmFhUW44TE9uZDJW?=
 =?utf-8?B?S3B2SElTT1hOTkc2dzZwenRCcEsrbkxkSVV4NStTdndoekJNSTZneFZPcHZx?=
 =?utf-8?B?dXJQRFJkYmF2SjV4R1NPOWowSzF3NUNvZ3pVRXJ3cCsrODl4UURzT1U1b1dB?=
 =?utf-8?B?NldlbTFsTVQzSjMvanFaUUMwbXdXRy9neHNUeEMzcDdrNlk2d1lReGwxQzRE?=
 =?utf-8?B?ajNmWWlDNTBwQlJVMmQ4M1hKK0hSKzVEd1krakdyOFIzS0paOVI0ay82aDZH?=
 =?utf-8?B?a2xFUUtBQW9xdEx3dStlNERrczZlR0xkdk1QT29FQTFCVjlUcUVpa25RM1lo?=
 =?utf-8?B?Ny9scnZRZ3NUZ2oyQ1k3bHh5VmJoOGpCZ0R0a2RhNTBkYm0rSzJqbnZRL2Nv?=
 =?utf-8?B?Q2ZNRFY2TkQvcW0xS2N4eUg1ejhSeWNjaW5xUEdQVEZJejBIc28xMHQzWHhE?=
 =?utf-8?B?SUpEV1VkNDZqSkl6MGpuRTRzM0Zqb3MwaGZleitmbEI2SVQwSVZSOEJJbS83?=
 =?utf-8?B?WDE3WGR0SW9zakJDak8xN0paZG4vSkRVNSt5VnUzQjlhd3lPZklKMXRFU2NU?=
 =?utf-8?B?KzZDdEh4MjZaTTRSeHF6T2Y2MEUva2dzYUZmRC9TQ1JHaUxwQVk4MEFIQVMy?=
 =?utf-8?B?MUNLbHpCbW1LWkdpMnFNUGdHK21vYXB5L0paZks3Vy9OM2dYTmZSWHdyeHVC?=
 =?utf-8?B?T0J6T1J0aFg0SjN1UjA3clVwb1EzaUdvdlJWUGd4eDVzM3FYTkd2WTY0RXZV?=
 =?utf-8?Q?bQjnzitg1iO87/CoZMi7SEc/K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0286530a-c2f0-4905-35f1-08da94fcf5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 20:25:39.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8RMyEOn1hL4eb87vp1ddDm+mp+sxbdX2zZtgFwiGPSrTd02knX6hHC0EBRoubAHzjbO+O9O4pcKVFzwOz0cqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24g
PG9sb2ZAbGl4b20ubmV0Pg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMiwgMjAyMiAyOjA1
IEFNDQo+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGFybTY0OiBkdHM6IGx4MjE2MGE6IHVwZGF0ZSBQQ0ll
IG5vZGVzIHRvIG1hdGNoDQo+IHJldjIgc2lsaWNvbg0KPiANCj4gSGksDQo+IA0KPiBPbiBXZWQs
IEF1ZyAxNywgMjAyMiBhdCAxOjI2IFBNIExpIFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGUgb3JpZ2luYWwgZHRzIHdhcyBjcmVhdGVkIGJhc2VkIG9uIHRoZSBu
b24tcHJvZHVjdGlvbiByZXYxIHNpbGljb24NCj4gPiB3aGljaCB3YXMgb25seSB1c2VkIGZvciBl
dmFsdWF0aW9uLiAgVXBkYXRlIHRoZSBQQ0llIG5vZGVzIHRvIGFsaWduDQo+ID4gd2l0aCB0aGUg
ZGlmZmVyZW50IGNvbnRyb2xsZXIgdXNlZCBpbiBwcm9kdWN0aW9uIHJldjIgc2lsaWNvbi4NCj4g
DQo+IEhvdyBjYW4gSSBjb25maXJtIHdoYXQgdmVyc2lvbiBvZiBzaWxpY29uIEkgaGF2ZSBvbiBh
IHN5c3RlbT8NCj4gDQo+IE15IG5vbi1ldmFsdWF0aW9uIGNvbW1lcmNpYWxseSBwdXJjaGFzZWQg
c3lzdGVtIChIb25leUNvbWIgTFgySykgaGFzOg0KPiANCj4gIyBjYXQgL3N5cy9idXMvc29jL2Rl
dmljZXMvc29jMC9yZXZpc2lvbg0KPiAxLjANCg0KVGhpcyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUg
aW5mb3JtYXRpb24gSSBnb3QuICBJZiB0aGVyZSBpcyBzdGlsbCBhY3RpdmUgUmV2MS4wIHN5c3Rl
bSBpbiB1c2UsIEkgd291bGQgYWdyZWUgdGhhdCB3ZSBwcm9iYWJseSBuZWVkIHRvIGNyZWF0ZSBh
IG5ldyBkZXZpY2UgdHJlZSBmb3IgdGhlIHJldjIgc2lsaWNvbi4gIFRoYW5rcyBmb3IgdGhlIGlu
Zm9ybWF0aW9uLg0KDQo+IA0KPiBBbmQgSSB3aWxsIGJlIHJlYWxseSBncnVtcHkgaWYgdGhpcyBz
eXN0ZW0gc3RvcHMgd29ya2luZy4gSXQncyB3aGF0IEkgdXNlIHRvIGRvDQo+IGFsbCBteSBtYWlu
dGFpbmVyIHdvcmssIGV2ZW4gaWYgdGhhdCdzIGJlZW4gZmFpcmx5IGRvcm1hbnQgdGhpcyB5ZWFy
Lg0KPiANCj4gSXQncyBvdmVyYWxsIHNldHRpbmcgb2ZmIHJlZCBmbGFncyB0byB1cGRhdGUgYW4g
aW4tcGxhY2UgZGV2aWNldHJlZSB0byBhICJuZXcNCj4gcmV2aXNpb24iIG9mIHNpbGljb24gaW5z
dGVhZCBvZiBhZGRpbmcgYSBuZXcgRFQgZm9yIHNhaWQgcmV2aXNpb24uIDIxNjBBIGhhcw0KPiBi
ZWVuIG9uIHRoZSBtYXJrZXQgZm9yIHNldmVyYWwgeWVhcnMsIHNvIGl0IGp1c3Qgc2VlbXMgb2Rk
IHRvIGFsbCBvZiB0aGUNCj4gc3VkZGVuIHJldHJvYWN0aXZlbHkgbWFrZSB0aGluZ3Mgbm9uLWJh
Y2t3YXJkcy1jb21wYXRpYmxlLg0KPiANCj4gDQo+IA0KPiAtT2xvZg0KPiANCj4gDQo+IA0KPiAN
Cj4gLU9sb2YNCg==
