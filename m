Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7336064E587
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLPBGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:06:11 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CB186C3;
        Thu, 15 Dec 2022 17:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9Gr0lpWj0cCnq0dRsVQ/hIaJ+1TLsKyBuEr3wnd0FB96+/RoxGsN+m46T9WRJDUx2dL5NpwEFTWpMHvJldzNhtCttGHQALIUZFbhqvemWFPQRk2p4eRJHqdTDP2WvmMotx2wF++6sFbEtALjMenH2xrnlt0vPo2cPQwuHZWof/OaS252UJ4v0nbBnbRjXr4ntpvHwQqDN1w1j0s6LfmEoE2CC4PvrR1An4qNLQSuE+Gdq5rMf77FnkgNmC8lvhx/uHp3RQXtRunDC63Q/HPcRWSAoAr/lY4Rxf8XCgsBkUGMyic5j8xwII64uyNkbB43woLZDLA/ho3idstCjYfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pllJne90N3yVLT3xE0HNswXGmhrMynLRr2MZrBhVvlE=;
 b=UVoJYh4gpxdrP1VT6FohzR5dQOZCZIMVdoHi9IGhlDKvhXn9jL44u+62hDDBu7hWy+RpaPcra5ARSj0VoV5M/TO2cRUwRiNsomfekkhKNFce1npOSJccHFwR8VSTCbW9GyFIPKbIAZoLTQpHryUyMM+lYk/rJiLGcaAE5MFoReb7uoHpjlCRskIO/zWMndzIWyAJ80vz0w5ots2W6RBpvVXt0nKmVuk7fN/TVB0OTtRJlH8dQKHMy1pk9GBEDJhtHYJESU1YTFuZNGma6BT1yetn3nz2hUWh2oMC4LJPp+FSIwg+VcnyCLgBuiMMXmNs8tcknxmUreEY52b3+4ixYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pllJne90N3yVLT3xE0HNswXGmhrMynLRr2MZrBhVvlE=;
 b=XEm5edXE6tovI0ACHGZMuU0ROEW8gviphAPLSF4ZhizmkcobI5kYH4alC89JAsUlObwBBJWVkkxArTv3qshFEgJnRbuyLAqsJm8bDxI16veW6XUNzfeExBzkIIfsyDNEZrb/mfA1lm6M4onVT+wMw1PmzBlHlhL4aei9rdqY7ts=
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 01:06:06 +0000
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24]) by DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 01:06:05 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] arm64: dts: imx8dxl: Disable hibernation mode of
 AR8031 for EQOS
Thread-Topic: [PATCH net] arm64: dts: imx8dxl: Disable hibernation mode of
 AR8031 for EQOS
Thread-Index: AQHZEGkq2uoO+npoSUymdx9u0FEQV65uutSAgADvKqA=
Date:   Fri, 16 Dec 2022 01:06:05 +0000
Message-ID: <DB9PR04MB81066E9892C2916BA6EF0F4288E69@DB9PR04MB8106.eurprd04.prod.outlook.com>
References: <20221215093627.956417-1-wei.fang@nxp.com>
 <035e9326-d507-2930-d1ab-22b95af035f8@linaro.org>
In-Reply-To: <035e9326-d507-2930-d1ab-22b95af035f8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8106:EE_|PR3PR04MB7337:EE_
x-ms-office365-filtering-correlation-id: f7419f40-9da1-4db4-c87a-08dadf01b574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZutWH5KWMksz2/7Mm9wDHJ1bvkTX8sD/rrMZW6jv93fhF5rzYXAFfDd9BAvAu0z50lxnICNGNZHmOGMPA/hSvUQdRgslwTXJUqOptBvny5gdHNlIZU6MUrTngOqzv+JdNAalYUe+aZIBat7nlfZboezz7nNZhSUR3O6H5paEj7HGNltNK7rIJREKOYABjJiW1lrpG/luToiEJFRgh5ai/kT8GmQYza/n086auQZ56ytyzWHUM2P/K6IxLgRj68q0rX4YgH2eJEBFRS48XCT50unvB/tfthRif0KBJ6MOtJXW/shRqvBjXc2KzGrcJAZIL5PPZe1A/YtAnhnf64Ld7twod9b4gpsD7vTiRoI0XDtgrOU6+pezg8ZkzNIxQziAZfhFwtLRtBNFawpajYUVafxVTxmS/1rAoIDt3fzFzVU4bfQSF3iZ2H22IMXWa/PWU0vbDXa/tnWOuG8w3NTVagbFC5D9Pyqm4J9UgefmKuGETrJlu5h61+vDzTjVCznIuBuLX0m9ce/kKs6hV7PI6v7r80adPkpBTjvh8jZydk+Wx5q2hPeS0Bp7iyvS9jq6+hEZHlaeFFmInQug+q/eKwiwfN9sLGfxiUMoGpZRfdyQqreVtK9tV46vQ5FMWKNR3VKJu7dGQVKiPu3yVTTrqigm9+MhnTAenPOMZsM/72iAvEVw3VoI2CKfc918GAhrFCW3aU2aJy19iuXdOzUaZHTYWNC8XT43W26ronk68PnytKeezYICuJE39iBnaan7mCovCQdllx64QeDhboJDFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8106.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(33656002)(2906002)(38070700005)(921005)(52536014)(7416002)(8936002)(55016003)(41300700001)(5660300002)(83380400001)(38100700002)(122000001)(86362001)(478600001)(54906003)(966005)(45080400002)(110136005)(71200400001)(6636002)(44832011)(4326008)(6506007)(53546011)(76116006)(26005)(66446008)(66476007)(66946007)(64756008)(66556008)(7696005)(316002)(8676002)(186003)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NWZZMkhqcWY4VThidldWYjlQU0MybXM0UEdmWlJHemFDSGJzSkZacHRMQ2NP?=
 =?gb2312?B?RDg1RDlkbXRNVWttNEIzUWRGZ3RWZHJwRHIvYkM0dFJOMWs2WUJkdjdXTWFW?=
 =?gb2312?B?OFpYZTNMeGFvT1FKUWc0alJZRXBWQnVzc0dJcHlWdEVVV1NGbFd3dmRKeXU5?=
 =?gb2312?B?eitHMUliV2JqNnVSTlBIMGJPU0dnUERnU3dWcTRDbjY3MmNidnE5OE1haXJu?=
 =?gb2312?B?RExDcWx5aWxQaGZZZmcxR1Z1ZUw0MkhQMU5QRzJROGFuNHB5bCtIbDg1Ti8z?=
 =?gb2312?B?UXBQK3hmazBYWG9DYWhCZUtKTVhleFBia2ltWEY4QXN4QjJ1L0V5S0ErRUdk?=
 =?gb2312?B?YXFxYVZtVFZaMm1qY0c3b2ZieXJpMEs0Zy8wRFlraUlzeHBDTldXUHNOVSs1?=
 =?gb2312?B?b2Zma0lPcEdRMTJxZnJhc2toTXU3VXRCbUNwOEJMQiszdDZEUlZSYWplYm5T?=
 =?gb2312?B?U1h4RFdsREl1ZlhRd3RCeHBYdHJhelJMdk92b1c3YkJ4dzZqQ3pTa0pPeE9G?=
 =?gb2312?B?a25vSk1mYmhtOFpMZnE0blQ1N2FuUUlIWXNtRmtPTEtaNmtIMTdxRE80MGlH?=
 =?gb2312?B?dFRHK1hYK252WU9saitSVGFDTzBtdlF2bm9ERUZ4UjhJRTN6a3haNXlQYXRw?=
 =?gb2312?B?SHJDaDNjNFB6NXlXby9hU2J5WUhJTWdmeGhZd2F0OU1QSWhJc0NGRmlrWU5p?=
 =?gb2312?B?VlpHUkFRdG1oQXJWTUtqdkU3TnJPbmMwSjNHQy9SYUlSeC8wa2ZjSmZkakxZ?=
 =?gb2312?B?SDBleEcxR0E5VVFXRmVvdmdvWXlOaC9UaElSVURQL2JqT0ExakhEVWhXQjND?=
 =?gb2312?B?VnBoR2psaWJ6bDNpdnRlODZnVkEvYnZZZCtQTlJXakk0TEJ3bzYrdVFpZjZq?=
 =?gb2312?B?QWRDUzFhZ25xdG9STGtEdE5HalF0a2VMd0J5VWRSRWN1Y1l2WEQvMXhWUWYr?=
 =?gb2312?B?cFhVYlNiemR1OHVidjQzWTd3c3dkM1cvbkt3MHNmdFB5OEhKdUJrRTRTYURN?=
 =?gb2312?B?ZjdJRVZlaXVybkpKVEVsWWJHOGdBbVlrUEtzUFlJSzBvYUZJbVhPcnFxYk1E?=
 =?gb2312?B?MzBxQXE1YURCeHAvVm5HV2IwUWNucm1rdkVnQXZzTExMWTJCbm05VUFyN0RO?=
 =?gb2312?B?U2hkV2FTNGNlR2lORlI3VC9TcGJEK0s2aGZHYWR3ZkI2RkdGRVVuUXhNL1dM?=
 =?gb2312?B?aU5QTkNaa0IzbiswTkk3WnZzR3FRc29Pci9ncEpGbXJDN2NpVnBsTG12M3lH?=
 =?gb2312?B?RkhwandaNU1XTjdhei85TldQaisxa3poQXQrazFwN2kyMkRUZ3RkRVdkYmgv?=
 =?gb2312?B?cWcvR3c4dEZiYmpGa2FHYVY0U09TdnJSbWYwT20xZEd1ckdiMVpScWhWN2Zz?=
 =?gb2312?B?YytKTzZmTUtvdHZReSsrL1lJV3M4MExPYWpOZXZZMU4vd1QxUzBFUnhEY2Vj?=
 =?gb2312?B?SjNzNDZTOTY2ZnRLQ0thOTR0ZG1WaWJ2VktkNmxwRU5sajRkd0RYdTl2MlJj?=
 =?gb2312?B?UStGWkZnQWxUdjlQb2E4ckRmOFJTK0dIN2pFdGVKSll1aTJxWGJ5MEpMOGMy?=
 =?gb2312?B?ZzI1Zzg3Z3BVRERrZlN5UlVCYy82b1JPTzA5SElMdGc4UFhYaUE2WFAyNGg3?=
 =?gb2312?B?eklVTkhFTkdWT0l4dVZ2aCsyL0JBTURxc2k2ako0Nk9vU05lU3VnTHNVcnJx?=
 =?gb2312?B?YmNrL0hkblhEcXRVMDhVdVNWc3FYS096NkhqdGFJb1dSQThXcGcvUUZJZTlZ?=
 =?gb2312?B?ektKKzBwR3B0WjdVUjJZd0t5RjA4MDMzZVlNZW81dVZ4dkxkbGRpUnVpVkQ1?=
 =?gb2312?B?SW9abkJkK3NleWZVU0I5Q0czWHRwdjNCeEErS2h2TGZzREt0TUtOTi82K2Jy?=
 =?gb2312?B?ek13ck1aR0MrcHpHTGFEakV0anE3WndTZnVCK0huSkhkbSsvbEU5cFpUY24r?=
 =?gb2312?B?YXMxUTFOQmtqMEJCam5YUDRNUEpWNWVITzlDblhBRnBHWDZKZmc2UXc4OTVY?=
 =?gb2312?B?dnd0VkhWY2l2dEdEWDFUVjZCTlN0SjFwTzF4WGJYeDhCcjBRWEhqL0ZDVGg5?=
 =?gb2312?B?MThoUUZXc1lGbExhdWt0emtnT0tVUndVRlh5VytKSHJMcTNrdW9Jd1NQOHdJ?=
 =?gb2312?Q?8eSA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8106.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7419f40-9da1-4db4-c87a-08dadf01b574
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 01:06:05.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZD0qzYv/x3wqeziwm7ssVEtnrU5Dh8mBaEdpEgRemApUo1QnOuGZBk11EzV+u7GIWuehdJciig3jEvH+mT8IjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337
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
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEy1MIxNcjV
IDE4OjEzDQo+IFRvOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgU2hlbndlaQ0KPiBXYW5nIDxzaGVud2VpLndh
bmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4gQ2M6IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXRdIGFybTY0OiBkdHM6IGlteDhkeGw6IERpc2FibGUgaGliZXJuYXRpb24gbW9kZSBv
Zg0KPiBBUjgwMzEgZm9yIEVRT1MNCj4gDQo+IE9uIDE1LzEyLzIwMjIgMTA6MzYsIHdlaS5mYW5n
QG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+
ID4NCj4gPiBUaGUgaGliZXJuYXRpb24gbW9kZSBvZiBBUjgwMzEgUEhZIGRlZmF1bHRzIHRvIGJl
IGVuYWJsZWQgYWZ0ZXINCj4gPiBoYXJkd2FyZSByZXNldC4gV2hlbiB0aGUgY2FibGUgaXMgdW5w
bHVnZ2VkLCB0aGUgUEhZIHdpbGwgZW50ZXINCj4gPiBoaWJlcm5hdGlvbiBtb2RlIGFmdGVyIGFi
b3V0IDEwIHNlbmNvbmRzIGFuZCB0aGUgUEhZIGNsb2NrcyB3aWxsIGJlDQo+ID4gc3RvcHBlZCB0
byBzYXZlIHBvd2VyLiBIb3dldmVyLCBkdWUgdG8gdGhlIGRlc2lnbiBvZiBFUU9TLCB0aGUgbWFj
DQo+ID4gbmVlZHMgdGhlIFJYX0NMSyBvZiBQSFkgZm9yIHNvZnR3YXJlIHJlc2V0IHRvIGNvbXBs
ZXRlLiBPdGhlcndpc2UgdGhlDQo+ID4gc29mdHdhcmUgcmVzZXQgb2YgRVFPUyB3aWxsIGJlIGZh
aWxlZCBhbmQgZG8gbm90IHdvcmsgY29ycmVjdGx5LiBUaGUNCj4gPiBvbmx5IHdheSBpcyB0byBk
aXNhYmxlIGhpYmVybmF0aW9uIG1vZGUgb2YgQVI4MDMxIFBIWSBmb3IgRVFPUywgdGhlDQo+ICJx
Y2EsZGlzYWJsZS1oaWJlcm5hdGlvbi1tb2RlIg0KPiA+IHByb3BlcnR5IGlzIHVzZWQgZm9yIHRo
aXMgcHVycG9zZSBhbmQgaGFzIGFscmVhZHkgYmVlbiBzdWJtaXR0ZWQgdG8NCj4gPiB0aGUgdXBz
dHJlYW0sIGZvciBtb3JlIGRldGFpbHMgcGxlYXNlIHJlZmVyIHRvIHRoZSBiZWxvdyBsaW5rOg0K
PiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRm5ldGRldiUyRjIwMjIwODE4MDMw
MDU0LjEwMTA2NjAtMi13ZWkuZmFuZyU0MG54cC5jbw0KPiBtJTJGJg0KPiA+DQo+IGFtcDtkYXRh
PTA1JTdDMDElN0N3ZWkuZmFuZyU0MG54cC5jb20lN0M0N2NhODQwOGIzMTI0Y2RjNmFiZjA4ZA0K
PiBhZGU4NGY4DQo+ID4NCj4gMWIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM4MDY2OTU5OTI5Mw0KPiAzNzA3NiU3Q1UNCj4gPg0KPiBua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNg0KPiBJ
azFoYQ0KPiA+DQo+IFd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9
OTJNMHlaJTJGbWNxRnINCj4gVTlwR3JrYm44VGZvDQo+ID4gJTJCRzVNVmdqeWV4aU5SS0Qybmlj
JTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGlzIGlzIG5vdCBhIHBhdGNoIGZvciBuZXQtbmV4
dCBhcyB5b3UgaW5kaWNhdGUgaW4gdGhlIHN1YmplY3QuIERUUyBwYXRjaGVzIGdvDQo+IHZpYSBT
b0MgcGxhdGZvcm0gbWFpbnRhaW5lcnMuDQo+IA0KDQpPa2F5LCBJJ2xsIHJlbW92ZSAibmV0IiBm
cm9tIHRoZSBzdWJqZWN0Lg0KDQo=
