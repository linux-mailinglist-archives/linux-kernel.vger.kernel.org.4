Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4C63822A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYBtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKYBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:48:56 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267A29C95;
        Thu, 24 Nov 2022 17:48:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9Evz5NWEBFZ5G0PJI+hBkPzUsCpc6EdrE+3DFsj/Kv2sfqHtlaYtKpLHKACIdyaaP8/QOddadF1Aec4FQUFxnlr72tKVeweK1lbFYKOzZuDdezuwwz5AcEc/PvqMwRtfBcvq5s844BiIMdDQiN+gXbW1nt7tbs6X4uJcOg1ldvd9JeCIzw87q3ZSL4chk/nZixSmzxZApmdA6t4rU3q2qUsWrS8NSPrhWMN+zAsMWx4yLrlv1PgzlqjAM3Bp7UmRBjapnEghz0AL+4OCv0XkYNky+sYhFohZTRLfXM9bYRgEPNaRWpj0mW3fgdrWuQnRnWuPKf3dPtCK8203Yyetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxI7JKH6GMd/qe6oPm6PR21lOYYDkMxZk4BBJ2BugZ4=;
 b=cYe5FCUnig0J0s+ajPhOuGkI/2KMud3b8KfEHC15Ujj4+xJqpOPbMT1Hg3795Ow+C45EWSXAaci6SEqZJgI4rW3KUjAdGwuSMpJLAqW0bjYcKrRhVau4QpnVAhsKp+okYPrmW3ar33qxriKQxi+RcuMKr5yOCEsWj2vd4gKJeqw2m1+/rRWDXRM3KoOdhmHX9myC8ak0ZKdIzdVLWYrnJ2K4mafQ7ow2bUJnrvciaLzmtB+jussbXC2V/iA4il4h6antPBUxl+O1nkQBnZP/ytuJcHQGTnY5TLRetqAlBtQx4Gd/JEj4gL3eFcxSOzu+Nc15YZmJ3Ko8tSAzAI359Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxI7JKH6GMd/qe6oPm6PR21lOYYDkMxZk4BBJ2BugZ4=;
 b=kgg4AE9JrKj3sNhSkXuYivgqM3LMmnTl+wWzPuwPlgBPPmELtkZ88ixzTUEAjdFGc9ekSLakVft9ElcYDazYNdMOwRE9kWOYJp7EvQSiNMC/AmuwnHBo9z8W+8C0gu+40hoiIzEOdOF0iPaW4FVYUEpkENbKk2ZEBTZ10/uWYjQ=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB7012.eurprd04.prod.outlook.com (2603:10a6:208:19e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 01:48:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 01:48:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_HEADERS_ONLY flag
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_HEADERS_ONLY flag
Thread-Index: AQHYldMfa/yDJFvL5023OK69Vdnq9a5Otz4AgAD4r2A=
Date:   Fri, 25 Nov 2022 01:48:44 +0000
Message-ID: <AM6PR04MB63419629E384A48E4FFFCBFBE70E9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220712093754.23370-1-ming.qian@nxp.com>
 <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
In-Reply-To: <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM0PR04MB7012:EE_
x-ms-office365-filtering-correlation-id: 731cbdfa-7e48-4dc7-a77e-08dace872ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCFh7UPfOwaUAmpw2WwvvZYF0KsAb9bMKnq8ilZDbbHX/KPUlo1JrOq5MWy6QmQBTH8sKOlfU4OyueF0g3QqTHBMSU4/+RBcbXGq8TPrlVEwFs8NlJtBy0yZ6cvVO9VyCnXhZT4qajrmXi6+2g9aLb04YtFVq1KekaF563OhV9BFGHiIqUwvvPUeCZL35yEhP8fkS4WPU+LdVilPfa8EAsNIzJ9XVei76Bj2qOiCAZ/mF3HzBosQNfytZiEYVWvErW7GD0nA/M7Goo4XZ/n94DBl7JtvDuZwtkkq5bCJfd65lrSwUcDS6DQT0IfuYvEU85OVdTgkpclqJrb5GP3vzjO9i3ZcFspFeq/X3SujoHp7rTMlMit47D/KH6o5wDU6APYn+YFa/jwT7DxDaUeVHcDUHg0DFMkvEYlgTMLo689ubU0TsejX5HLyV2C7KJDYO8CfD/EH7qldzMpIxV8e8cYcIlqycsfd+FVl+nGgrvcHxSd30eRF8hM5NgcHZ83YaE2bxJdTea64Us0JgZHTUhDtH/gbK8glQG8Fr2YUH+Xr4RQz4oszGAZY8875VfezkehB2es28YnlTal/d62cWctvNCHQ7k4s9exj3XO+WHBEsdLkErnddtUrWF1fUqi5hoiftqSpzjy5LW/UvAbL7mBd3jUDBCgqwmKr8yZf1giLym/GzNStZf3d77qvDnWbE75fYxEhvfaBbcWmrfHOtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(122000001)(2906002)(83380400001)(26005)(38070700005)(41300700001)(7696005)(7416002)(6506007)(54906003)(316002)(110136005)(86362001)(33656002)(52536014)(186003)(44832011)(5660300002)(55016003)(9686003)(76116006)(478600001)(8936002)(38100700002)(66446008)(8676002)(66556008)(71200400001)(66476007)(4326008)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdMVFVuZVV2a1pMeXZxSnZVVnI1U0hxNW1xbCtxUmhjaWZxWjFlOVdhVERl?=
 =?utf-8?B?L3BmMTRjQ3ltd2tESS9TT0JUWU1PaE8yU3h0dVE1a2F0MjZvWEpIdmxXWHlz?=
 =?utf-8?B?bFZkNkRFQ05ES2hrUXdWalZrb004RjVRWWRYMjdiMUdOZndxY2Q0b0kxSXBi?=
 =?utf-8?B?QWU2dThkSEJTVEdZemxGYXBQTDllNVptRkJ5dHliNGRQcXhlKytBWkk5Tkx5?=
 =?utf-8?B?V25USDR4TFhvd3dSWk1JRHI4Qys5bXF6L2RTSHQrMDlTZHVXanhMTFVCclpz?=
 =?utf-8?B?UnU1Y0lBcXdrcW9TOTF1aG5XMEloTldxMnBuYWhlQmZJSENKWnZjMmZyakhq?=
 =?utf-8?B?dmhXM2NRVCtQZ0xJSXhjS3Z2YnNEaFJDbHhqakRaQ1BERlMvczJ2dFl3OTMx?=
 =?utf-8?B?ZmlYNkhiUnoxTmxCSDVVV3p0VDY2bzVJM1FFd0FIWlNtL1V3cGpxdHUzRUFJ?=
 =?utf-8?B?U1cwK0RTQ2NqNzRxV0xDa2RKQVEveVByMXZTOEcyMHdGamsvaGhsTWVYSnpJ?=
 =?utf-8?B?ZDlrS2NEbSsxUzZNQTMzNTBicllJNlkxc3ZVcDZkWGVTcS9ONkt0MmV4N1A3?=
 =?utf-8?B?UktqMzFmbWNkTDA0cW0rUC9iME9uM3pQWGszTkJGRzRoU0dVdlg2eW5RRWtQ?=
 =?utf-8?B?STlZdllpYVlla1VhOUhOQ0U5Y2dpNzM3ZnVzMnRMdnRDNmo0NHk5U3lZOEly?=
 =?utf-8?B?cnIxcWZrR0JvUjFNVHVPTitVWFpQNmk2cVVzUXBYaldpbWFlSXhGRTRmNDQ3?=
 =?utf-8?B?eWwyKytpMjZ2WnU3b09taFNCakFKM0RMQ1haTnFyKzNwejV6UXdHT25mYk5y?=
 =?utf-8?B?M0FtcWloUk5xcEVsNm9HVHAzOWN3RUN1TUxtZ0hnSEVMSFo5Ylo3Vm1ncUxj?=
 =?utf-8?B?Q1F4VHNtTktTRWQ1YnpSaEczbkZmcGtubkFNVlVsV2xXMkoxbGNrdHlaZUtL?=
 =?utf-8?B?Q0VsN0VhTG96bTJiLzZFK3F0am9sL2hSS3RHdUR3elVuTGlIV0d1c25nL1Nl?=
 =?utf-8?B?Vzk0NE9DQVdqVCtScEE0bE1HOHNBcFJJT1hINXNwQmFxRDhwNXlxbXQwVHl2?=
 =?utf-8?B?Tm9GQldkeUhXZFpaaDFDUmJucXc0bWp2RXhGdjVQWENZVFJHRWxzamRHTEI2?=
 =?utf-8?B?L3NSVnhZMk1jTjh6eDZLa0hlSDY4L1lMMVVKWnRrbC9xM2hvb3VKcHJzVCtn?=
 =?utf-8?B?VWNoWC83RTFhajNCVWtMZDZDcFIyY1VFVHhPYkhVcGwyb1BRTjFsczVYZFVY?=
 =?utf-8?B?NmZPOHdNVmJRcXRxRUF4OFVHYVpTbVFxSGFQNWh5STdzQy9zQkxNc0FsU3ZL?=
 =?utf-8?B?Q0Foa3lJUnVleitQamxOSWJsRkdaN1RqZE9MWkplZm02WEV3QnhnZUNXYWU5?=
 =?utf-8?B?RUw4RTZQTGxjdjlHTyttSktnelZuSEQwdlBiRFgybG54c2JJMm5aQzVGamFZ?=
 =?utf-8?B?SVFrRkt2VW56M1A1bGNuMkpuU1JHYVpwcGhJRzV2QVRhWGszQWI3SWlxRW1y?=
 =?utf-8?B?UTE2L0NlOHFaRk5oRWFic205TjNzQUI5MWZodlRqNzBBdDExQyt4S0pzajl4?=
 =?utf-8?B?dGxBVjVUc2Y1R0pTelFuV2YvR1dYOE4rNUxkSXJQaWplRW1hWkZQalpWek9X?=
 =?utf-8?B?enAvZlNmNEtXUDMrQzQrUVhFME9HT0EvNXBCT280emJwSE5SWjVBbTlpREJl?=
 =?utf-8?B?RU0wZzgyQk56MnFMRUNUTEhUV2tLSlI5TGtVOGczOTBzaHV1bEJzTXBpQkU0?=
 =?utf-8?B?QUtkdnlScys1QmIrNWR4czVqeVl6SzF2Y2dmRzdoRHZrMWMyV3JCR1Raem5L?=
 =?utf-8?B?Y1VvNmlQZFk1MVc5OE8rSTdTeGFtY2JJZFJPVFlXY3VZVDRzR3Y1M1hKNmZS?=
 =?utf-8?B?UzlPRFd3UEMyZW5vV0ZNditZeENOWjk5Z3JsNlFwYUc5aUdad2s3T3ZVdGx1?=
 =?utf-8?B?TnJOSHZFeHlyV1dTQ0dsNElWMm16YkhDVGhVOEQzU1htSzN1TlhVcjRkcTQy?=
 =?utf-8?B?a3BOaW5aRy9XU3FpOVJwd1cwRVNLd3lndWlUMGdKeE1kdHdJMzVpNDRKK1Ns?=
 =?utf-8?B?c1ZYWjY1dE5oeldLQm9OY1d6eUg1OUNRR0JpTlZDZ255WUdzdHc5Rm5JNEdU?=
 =?utf-8?Q?uGjM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731cbdfa-7e48-4dc7-a77e-08dace872ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 01:48:44.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npP5/amPGuJR6rS5p2FEMPbXehunjTvGfqcUbGi/elCI+noRppGM8FAhdN9b7OpV4a1tsANZzsu0BYhRG/8zng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IEhhbnMgVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPg0KPlNlbnQ6IDIw
MjLlubQxMeaciDI05pelIDE4OjQyDQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+
OyBtY2hlaGFiQGtlcm5lbC5vcmcNCj5DYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBr
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPmtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPmlteEBueHAuY29t
PjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTmljb2xhcyBEdWZy
ZXNuZQ0KPjxuaWNvbGFzQG5kdWZyZXNuZS5jYT47IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1
bS5vcmc+DQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IHZpZGVvYnVmMjogYWRk
DQo+VjRMMl9CVUZfRkxBR19IRUFERVJTX09OTFkgZmxhZw0KPg0KPkNhdXRpb246IEVYVCBFbWFp
bA0KPg0KPitDQyBOaWNvbGFzIGFuZCBUb21hc3ouDQo+DQo+SSB3b3VsZCBsaWtlIHNvbWUgZmVl
ZGJhY2sgZm9yIHRoaXMgcGF0Y2guDQo+DQo+T24gMTIvMDcvMjAyMiAxMTozNywgTWluZyBRaWFu
IHdyb3RlOg0KPj4gQnkgc2V0dGluZyB0aGUgVjRMMl9CVUZfRkxBR19IRUFERVJTX09OTFkgZmxh
ZywgaGludCB0aGUgdmIyIG9ubHkNCj4+IGNvbnRhaW5zIHN0cmVhbSBoZWFkZXIsIGJ1dCBkb2Vz
IG5vdCBjb250YWluIGFueSBmcmFtZSBkYXRhLg0KPj4NCj4+IFRoaXMgZmxhZyBuZWVkcyB0byBi
ZSB1c2VkIHdoZW4gaGVhZGVyIG1vZGUgaXMgc2V0IHRvDQo+PiBWNEwyX01QRUdfVklERU9fSEVB
REVSX01PREVfU0VQQVJBVEUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5n
LnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9t
ZWRpYS92NGwvYnVmZmVyLnJzdCAgICAgIHwgMTEgKysrKysrKysrKysNCj4+ICAuLi4vdXNlcnNw
YWNlLWFwaS9tZWRpYS92NGwvZXh0LWN0cmxzLWNvZGVjLnJzdCAgICAgICB8IDEwICsrKysrKyst
LS0NCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyICsrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1h
cGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4+IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBp
L21lZGlhL3Y0bC9idWZmZXIucnN0DQo+PiBpbmRleCA0NjM4ZWM2NGRiMDAuLjE4YTZmNWZjYzgy
MiAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwv
YnVmZmVyLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0
bC9idWZmZXIucnN0DQo+PiBAQCAtNjA3LDYgKzYwNywxNyBAQCBCdWZmZXIgRmxhZ3MNCj4+ICAg
ICAgIHRoZSBmb3JtYXQuIEFueSBzdWJzZXF1ZW50IGNhbGwgdG8gdGhlDQo+PiAgICAgICA6cmVm
OmBWSURJT0NfRFFCVUYgPFZJRElPQ19RQlVGPmAgaW9jdGwgd2lsbCBub3QgYmxvY2sgYW55bW9y
ZSwNCj4+ICAgICAgIGJ1dCByZXR1cm4gYW4gYGBFUElQRWBgIGVycm9yIGNvZGUuDQo+PiArICAg
ICogLi4gX2BWNEwyLUJVRi1GTEFHLUhFQURFUlMtT05MWWA6DQo+PiArDQo+PiArICAgICAgLSBg
YFY0TDJfQlVGX0ZMQUdfSEVBREVSU19PTkxZYGANCj4+ICsgICAgICAtIDB4MDAyMDAwMDANCj4+
ICsgICAgICAtIFRoaXMgZmxhZyBtYXkgYmUgc2V0IHdoZW4gdGhlIGJ1ZmZlciBvbmx5IGNvbnRh
aW5zIGNvZGVjDQo+DQo+U2V0IGJ5IHRoZSBkcml2ZXIgb3IgdXNlcnNwYWNlPyBPciBlaXRoZXIs
IGRlcGVuZGluZyBvbiB3aGV0aGVyIGl0IGlzIGFuDQo+ZW5jb2RlciBvciBkZWNvZGVyPw0KPg0K
PmNvZGVjIC0+IHRoZSBjb2RlYw0KPg0KPj4gKyAgICAgaGVhZGVyLCBidXQgZG9lcyBub3QgY29u
dGFpbiBhbnkgZnJhbWUgZGF0YS4gVXN1YWxseSB0aGUgY29kZWMNCj4+ICsgICAgIGhlYWRlciBp
cyBtZXJnZWQgdG8gdGhlIG5leHQgaWRyIGZyYW1lLCB3aXRoIHRoZSBmbGFnDQo+DQo+dG8gLT4g
d2l0aA0KPmlkciAtPiBJRFINCj4NCj4+ICsgICAgIGBgVjRMMl9CVUZfRkxBR19LRVlGUkFNRWBg
LCBidXQgdGhlcmUgaXMgc3RpbGwgc29tZSBzY2VuZXMgdGhhdA0KPj4gKyB3aWxsDQo+DQo+aXMg
LT4gYXJlDQo+DQo+c2NlbmVzOiBkbyB5b3UgbWVhbiAnc2NlbmFyaW9zJz8NCj4NCj4+ICsgICAg
IHNwbGl0IHRoZSBoZWFkZXIgYW5kIHF1ZXVlIGl0IHNlcGFyYXRlbHkuIFRoaXMgZmxhZyBjYW4g
c2V0IG9ubHkNCj4+ICsgd2hlbg0KPg0KPiJzcGxpdCB0aGUgaGVhZGVyIGFuZCBxdWV1ZSBpdCBz
ZXBhcmF0ZWx5IiAtPiBxdWV1ZSB0aGUgaGVhZGVyIGluIGEgc2VwYXJhdGUNCj5idWZmZXINCj4N
Cj5jYW4gLT4gY2FuIGJlDQo+DQo+PiArICAgICBjb2RlYyBzdXBwb3J0IFY0TDJfTVBFR19WSURF
T19IRUFERVJfTU9ERV9TRVBBUkFURSwNCj4NCj5jb2RlYyAtPiB0aGUgY29kZWMNCj5zdXBwb3J0
IC0+IHN1cHBvcnRzDQo+DQo+PiArICAgICBhbmQgdGhlIGhlYWRlciBtb2RlIGlzIHNldCB0bw0K
Pj4gKyBWNEwyX01QRUdfVklERU9fSEVBREVSX01PREVfU0VQQVJBVEUNCj4+ICAgICAgKiAuLiBf
YFY0TDItQlVGLUZMQUctUkVRVUVTVC1GRGA6DQo+Pg0KPj4gICAgICAgIC0gYGBWNEwyX0JVRl9G
TEFHX1JFUVVFU1RfRkRgYA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9tZWRpYS92NGwvZXh0LWN0cmxzLWNvZGVjLnJzdA0KPj4gYi9Eb2N1bWVudGF0aW9uL3Vz
ZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2V4dC1jdHJscy1jb2RlYy5yc3QNCj4+IGluZGV4IDYxODNm
NDNmNGQ3My4uNDc4YjZhZjQyMDVkIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi91c2Vy
c3BhY2UtYXBpL21lZGlhL3Y0bC9leHQtY3RybHMtY29kZWMucnN0DQo+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2V4dC1jdHJscy1jb2RlYy5yc3QNCj4+IEBA
IC0xMzg2LDggKzEzODYsMTIgQEAgZW51bQ0KPnY0bDJfbXBlZ192aWRlb19pbnRyYV9yZWZyZXNo
X3BlcmlvZF90eXBlIC0NCj4+ICAgICAgKGVudW0pDQo+Pg0KPj4gIGVudW0gdjRsMl9tcGVnX3Zp
ZGVvX2hlYWRlcl9tb2RlIC0NCj4+IC0gICAgRGV0ZXJtaW5lcyB3aGV0aGVyIHRoZSBoZWFkZXIg
aXMgcmV0dXJuZWQgYXMgdGhlIGZpcnN0IGJ1ZmZlciBvciBpcw0KPj4gLSAgICBpdCByZXR1cm5l
ZCB0b2dldGhlciB3aXRoIHRoZSBmaXJzdCBmcmFtZS4gQXBwbGljYWJsZSB0byBlbmNvZGVycy4N
Cj4+ICsgICAgRGV0ZXJtaW5lcyB3aGV0aGVyIHRoZSBoZWFkZXIgaXMgcmV0dXJuZWQgYXMgdGhl
IGZpcnN0IGJ1ZmZlcg0KPj4gKyAgICB3aXRoIGZsYWcgVjRMMl9CVUZfRkxBR19IRUFERVJTX09O
TFkgb3IgaXMNCj4NCj5vciBpcyBpdCAtPiBvciBpZiBpdCBpcw0KPg0KPj4gKyAgICBpdCByZXR1
cm5lZCB0b2dldGhlciB3aXRoIHRoZSBmaXJzdCBmcmFtZS4NCj4+ICsgICAgQXBwbGljYWJsZSB0
byBlbmNvZGVycyBhbmQgZGVjb2RlcnMuDQo+PiArICAgIElmIGl0J3Mgbm90IGltcGxlbWVudGVk
IGluIGEgZHJpdmVyLA0KPj4gKyAgICBWNEwyX01QRUdfVklERU9fSEVBREVSX01PREVfSk9JTkVE
X1dJVEhfMVNUX0ZSQU1FIGlzIHRvIGJlDQo+PiArIGFzc3VtZWQsDQo+PiAgICAgIFBvc3NpYmxl
IHZhbHVlcyBhcmU6DQo+Pg0KPj4gIC4uIHJhdzo6IGxhdGV4DQo+PiBAQCAtMTQwMSw3ICsxNDA1
LDcgQEAgZW51bSB2NGwyX21wZWdfdmlkZW9faGVhZGVyX21vZGUgLQ0KPj4gICAgICA6c3R1Yi1j
b2x1bW5zOiAwDQo+Pg0KPj4gICAgICAqIC0gYGBWNEwyX01QRUdfVklERU9fSEVBREVSX01PREVf
U0VQQVJBVEVgYA0KPj4gLSAgICAgIC0gVGhlIHN0cmVhbSBoZWFkZXIgaXMgcmV0dXJuZWQgc2Vw
YXJhdGVseSBpbiB0aGUgZmlyc3QgYnVmZmVyLg0KPj4gKyAgICAgIC0gVGhlIHN0cmVhbSBoZWFk
ZXIgaXMgcmV0dXJuZWQgc2VwYXJhdGVseSBpbiB0aGUgZmlyc3QgYnVmZmVyIHdpdGggdGhlDQo+
ZmxhZyBWNEwyX0JVRl9GTEFHX0hFQURFUlNfT05MWS4NCj4+ICAgICAgKiAtIGBgVjRMMl9NUEVH
X1ZJREVPX0hFQURFUl9NT0RFX0pPSU5FRF9XSVRIXzFTVF9GUkFNRWBgDQo+PiAgICAgICAgLSBU
aGUgc3RyZWFtIGhlYWRlciBpcyByZXR1cm5lZCB0b2dldGhlciB3aXRoIHRoZSBmaXJzdCBlbmNv
ZGVkDQo+PiAgICAgICBmcmFtZS4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
dmlkZW9kZXYyLmgNCj4+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oIGluZGV4IDUz
MTFhYzRmZGUzNS4uNmZkOTZhY2Q2MDgwDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC92aWRlb2RldjIuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2
Mi5oDQo+PiBAQCAtMTEzMSw2ICsxMTMxLDggQEAgc3RhdGljIGlubGluZSBfX3U2NCB2NGwyX3Rp
bWV2YWxfdG9fbnMoY29uc3Qgc3RydWN0DQo+dGltZXZhbCAqdHYpDQo+PiAgI2RlZmluZSBWNEwy
X0JVRl9GTEFHX1RTVEFNUF9TUkNfU09FICAgICAgICAgMHgwMDAxMDAwMA0KPj4gIC8qIG1lbTJt
ZW0gZW5jb2Rlci9kZWNvZGVyICovDQo+PiAgI2RlZmluZSBWNEwyX0JVRl9GTEFHX0xBU1QgICAg
ICAgICAgICAgICAgICAgMHgwMDEwMDAwMA0KPj4gKy8qIEJ1ZmZlciBvbmx5IGNvbnRhaW5zIGNv
ZGVjIGhlYWRlciAqLw0KPg0KPmNvZGVjIC0+IHRoZSBjb2RlYw0KPg0KPj4gKyNkZWZpbmUgVjRM
Ml9CVUZfRkxBR19IRUFERVJTX09OTFkgICAgICAgICAgIDB4MDAyMDAwMDANCj4+ICAvKiByZXF1
ZXN0X2ZkIGlzIHZhbGlkICovDQo+PiAgI2RlZmluZSBWNEwyX0JVRl9GTEFHX1JFUVVFU1RfRkQg
ICAgICAgICAgICAgMHgwMDgwMDAwMA0KPj4NCj4NCj5PZiBjb3Vyc2UsIHRoZXJlIG5lZWRzIHRv
IGJlIGEgZHJpdmVyIHRoYXQgdXNlcyB0aGlzIGFzIHdlbGwuIEFuZCBkcml2ZXJzIHRoYXQNCj5z
dXBwb3J0IFY0TDJfTVBFR19WSURFT19IRUFERVJfTU9ERV9TRVBBUkFURSB3b3VsZCBuZWVkIHRv
IGFkZA0KPnN1cHBvcnQgZm9yIHRoaXMgZmxhZyBhcyB3ZWxsLCBJIGd1ZXNzLg0KPg0KPkFuZCB3
aGF0IEkgaGF2ZW4ndCBzZWVuIGhlcmUgaXMgKndoeSogeW91IG5lZWQgdGhpcyBmbGFnLiBUaGVy
ZSBhcmUgYWxyZWFkeQ0KPmRyaXZlcnMgdGhhdCBzdXBwb3J0IFY0TDJfTVBFR19WSURFT19IRUFE
RVJfTU9ERV9TRVBBUkFURSwgYW5kDQo+dGhleSBtYW5hZ2VkIGZpbmUgd2l0aG91dCBpdC4NCj4N
Cj5SZWdhcmRzLA0KPg0KPiAgICAgICAgSGFucw0KDQpIaSBIYW5zLA0KICAgVGhlIFY0TDJfTVBF
R19WSURFT19IRUFERVJfTU9ERV9TRVBBUkFURSBpcyBvbmx5IHN1cHBvcnRlZCBieSBlbmNvZGVy
IGN1cnJlbnRseSwNCkFuZCBJIHdhbnQgdG8gYXBwbHkgaXQgdG8gZGVjb2RlciB0b28uIEFzIHRo
ZSB1c2VyIG1heSBxdWV1ZSB0aGUgY29kZWMgaGVhZGVyIGluIGEgc2VwYXJhdGUgYnVmZmVyLg0K
RXNwZWNpYWxseSBpbiBhbmRyb2lkIGNhc2UsIGJ1dCB0aGUgYW1waGlvbiB2cHUgcmVxdWlyZXMg
b25lIGJ1ZmZlciBjb250YWlucyBvbmUgZnJhbWUsIGlmIG5vdCwgZHJpdmVyIHdpbGwgbWVyZ2Ug
dGhlIGhlYWRlciB0byB0aGUgbmV4dCBJRFIgZnJhbWUuIFNvIHdlIG5lZWQgdGhpcyBmbGFnIHRv
IGhhbmRsZSBzdWNoIGNhc2UuDQoNCiAgIEFuZCBmb3IgZW5jb2RlciwgaWYgdGhlIFY0TDJfTVBF
R19WSURFT19IRUFERVJfTU9ERV9TRVBBUkFURSBpcyBzZXQsIHRoZSBzdHJlYW0gaGVhZGVyIGlz
IHJldHVybmVkIHNlcGFyYXRlbHkgaW4gdGhlIGZpcnN0IGJ1ZmZlci4gQnV0IHRoZXJlIGFyZSBz
b21lIGNvZGVjcyB0aGF0IGNhbiBwcm9kdWNlIHNwcywgcHBzLCB2cHMgc2VwYXJhdGVseSwgaXQg
bWVhbnMgdGhlcmUgbWF5IGJlIG1vcmUgdGhhbiAxIGJ1ZmZlcnMgcmV0dXJuZWQgd2l0aCBoZWFk
ZXIgZGF0YSBvbmx5LiBTbyBJIHRoaW5rIHRoaXMgZmxhZyBpcyBhbHNvIGFuIGVuaGFuY2VtZW50
IGZvciBlbmNvZGVyLg0KDQpNaW5nDQo=
