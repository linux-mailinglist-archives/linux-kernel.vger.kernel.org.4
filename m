Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D866D3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjAQBvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjAQBvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:51:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8882298CF;
        Mon, 16 Jan 2023 17:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeOBJDIz8lwgHhgbXPaQ8BlWwSrXQT7Gj5S4oI+dgI5V9GClb0KOqxaVZawroUFHi19FPQY5iYvdhQcYqYj6C1Cc9C2lJjkYY/AE9/XzPaWemSLXaTpVOQtSG9ysaXYDLw0AaSkn9uEerKcm4zzua3/TRH04wT2wo9Cn8EwUrheN+WVlqGt21km4Ya7ntYJLnwq3fcrNq9HlZjvX8U3wtkZXmsgk0NdGpMBFRLV17uzrUuseGNoqpgpDYZ6BrhP4vjuCG3JbbjEa1mGHaoz1/OAUdhBeJ3Lzk/Ufe6VN4BDUUKQ4ExmoLEP2UbLaiRGFQNNg9HWHuwmLmr/+7OKA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss1ra4z5T1EI85itVdkYRv3JUESpl9gLukZJfvyAXh8=;
 b=JCTe/LB8ukv636GvTEZCQKO1NvRm86jebPmZMaH5f82cvinHzGGHEdTMHOagE72pa2veLNCM7MPUbeKMSZ27Dx3KBH40pTszhTFXpLFemszArLiPLQufTnxSXvLWW7bELfDZiPJwB3t/xyV3an1I0LoqFWysMEYzPhI4Ue79CzOJSPaXiWk+bAh5YyYYdOTCpQNN6hkkHidK8iIzEfWU8TC3kI0uEVjLaE54b6qO99AXrpfiKPuPBMC6nlEWkPblquXHT2ncM+sha03Vs7iU9tqvIJ7Bbg7equsHIDfwIcihhBSdyuSviui+memuf0ocRtiDci621Z5pCnKhX/sGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss1ra4z5T1EI85itVdkYRv3JUESpl9gLukZJfvyAXh8=;
 b=mP5KbL0L7BnmqBI33q4MzRHAJoYD6GlyoFqqicVmZNFof4s/Tn3gu9iDg/ssuxHElkgXu+j7z9X89NiThk+yaW5xZedYmZjXy9ouw8d2Uv6WNojcWgJI29w9fekSKvOD2T9E6aMMadFNc6AYW3MjXppNVzq9JvuviZKaSKTqMaM=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 01:51:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 01:51:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 1/2] media: add RealVideo format RV30 and
 RV40
Thread-Topic: [EXT] Re: [PATCH v3 1/2] media: add RealVideo format RV30 and
 RV40
Thread-Index: AQHZJwURmBmlkrJasU+2ey5rCnUVVa6hiWIAgABTfPA=
Date:   Tue, 17 Jan 2023 01:51:08 +0000
Message-ID: <AM6PR04MB634193D0AB2005F1FE4395EAE7C69@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1673582851.git.ming.qian@nxp.com>
         <8cbe08de42af1ecf0df39970d57742445fd0d488.1673582851.git.ming.qian@nxp.com>
 <d06c0c48d69af6acede89cf5a911180f48b3f266.camel@ndufresne.ca>
In-Reply-To: <d06c0c48d69af6acede89cf5a911180f48b3f266.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AS4PR04MB9482:EE_
x-ms-office365-filtering-correlation-id: 2c6d45c2-6699-4a6e-d72f-08daf82d4da4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdO7XPMJQm8vDA0evCCGh8QSpsoro8hXdc4zgNyIEbcAgwAet1yvHJ/gAUWfnoP3bS5Z/pU/Sz1YXT5joX/7mFqkHfySepikovHpoVxFslZmySrka94sLRWYACeR0a3ICDqUjfUV8EXRpVbqNHKYpfNuVZXm0gKPx4rX/jusWZ+ybz0IMDgvKteUseSyfHudBNN7O28mJ31wwUOsSEN83vT3Z4z0vCwFSruqhZMz1EGsYhiMkqXX5VemQB+9v6Bh7khrjbyTzhtbR3ocyPjI3ASzhkVKt1JC/I9k2soEMu4hphX6n1MpifxiAZE6SetwfHd8wDrRn8J7ozCnMjD+DQhUOadv6CfAeuQF3BV+KScb7F++Pc729kk/xDA2sZzBgpWqa4x6ftN2qb7dv2nac5bD94VdRbXStZ5eu2w+ubQfuU0fTr7l0RMs8EHCj0nS9AKTsklBJuUl1InMsP8Xd2ke0v3XHDEw6YjPMI811pi3iS1PjzmS6D9VF5QDok//CZg0gm1fVVhVoDzryZqvijQYKcJ3rbHnqM6TclkEw2xm7Vjc/p6WXdHvQeUDPUA+HMHOud+oCT4Gzg1FPlfg3wnlbq5/oQXcmA8j6JIetJnPuMRKuqnbWN+H29XFuIp+eP45U+1K5EEvLCY1jXmIUMKcnSXsyirNjrawdmUruBSHjJDE2ohxEFVvRRu5RN3bJymIWNpqjda1Fh8L86tiCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(76116006)(33656002)(86362001)(8676002)(2906002)(83380400001)(38070700005)(7416002)(55016003)(52536014)(5660300002)(66476007)(66446008)(4326008)(64756008)(54906003)(316002)(66556008)(44832011)(110136005)(66946007)(6506007)(38100700002)(478600001)(66574015)(7696005)(122000001)(71200400001)(8936002)(41300700001)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGd0aVFyeCsrckpaNkVUeXZBMFF6SDRoWUtYUGEvVGQ0MVdZbEdub2NBN0lF?=
 =?utf-8?B?REtDL2UxZkZhZ0hXeUZabk1lK1pZaGpmMHU3bUljdUhTVncxR3JNdHhwaG81?=
 =?utf-8?B?NUlTTEV6YkRzVEpGV2YxMzdwS2VPQllEWHM2OTFTNHNyOG54dW5hV0FDdG9t?=
 =?utf-8?B?dUFUSGpVNzhFQktWSDNwTDJxVFo1UVdnY0RGMkplcWhDRVF1N2swY0UxWGZO?=
 =?utf-8?B?MjY1Rkt0M2hvYkFPOThBUFBwY2VSb0tBM2lXUXJtd2V5SXVZQnNRSEZCNGto?=
 =?utf-8?B?S25yK1RXVXV6VjJLME1HTXRBRkE3UHB2M0VPTVN1N2NuclBhNmNoa01WQ2My?=
 =?utf-8?B?WCtBbEQ2ZmpmNFIzSjZJNWplc2lpbEJ3Z2hVcjNVZGZoZERNeWVSNnR1NGF6?=
 =?utf-8?B?WU1HUWUzcC9PL2p6T1U0VjdqejcxODM4WStxTitYakt5QXV0MzY0bTRIaHdz?=
 =?utf-8?B?NDhQdWsxV0h5Sll6S293WjhQRmRwajdaYTlpbWVlVFBjYjlIbkdPbmFxbXRt?=
 =?utf-8?B?YUl0ZEVNZDA3VWhUMi8veEdLVkNNeW54WkM1OWFMci9YSTlkNmlPTVg0bys4?=
 =?utf-8?B?RGc5QytDUjRNbjdjTnRIUWx0MFMzVDNjUHlsckNLODkwckFjTTJsZHVGVDNr?=
 =?utf-8?B?SVZDYU44c0xtYTc2Q2xhdnBCbjg0T2c3RWg1NzNocURLMXQ2RzNPWWtmaS9D?=
 =?utf-8?B?azJaenlTcjJEdnhPbytnUmhteDRsQVlQbyt4QUk4dXE1SVQzZnVndWhJd09h?=
 =?utf-8?B?S1VkcDM2dTdYaTZKU2ZUc2JRcTFIdS92NUU5Ym1DcDBpeW5Cc0FNUXBodlZv?=
 =?utf-8?B?eHh0NkVFR0J4a2svQUF1ZkVTWlIrK29oWU9tM1hET1BOcWtYWFFLZGJzUksy?=
 =?utf-8?B?Q1BycGc2VVN6ZTJwd1FLeUVjMFZCNXFxT3V2U0ZLdWhwZ0crd2Y5ZHVLS2dM?=
 =?utf-8?B?Y3UwL3JacDQ2YWR5MjU5dytyYjFLTDFEdDUwb2FlWkpKdGxtd1JTNzgvK0w2?=
 =?utf-8?B?bkxYaXVSbjlDUEpDS3VCWlJtZy94NFFQK3NOOTRya29YcTlzcFpyV0QvVm4v?=
 =?utf-8?B?OFZ2QWtSVVlOZEcyWGpTbUhDK2p0Y2hQc0ZJajNFdTZQb1oyeTV0SjVmMlVy?=
 =?utf-8?B?SFU1Qk5GZWV4YSttWFhweWl6eFRORTRvaHYzN0pKb1poQ2hKcXFEL2twdThT?=
 =?utf-8?B?U3EvR09EeFFsbHN0bDN2VndQSThZcVdZQU0wMFBxMW5NdXFuMzNpc3ZJMjJS?=
 =?utf-8?B?REwxUFRGUGVBelVHMXNmMWQ4Zk5NU25JcnlUMkdEcEYrMFAvYkJrckltYlJU?=
 =?utf-8?B?TUdHVGs3eGtUK3doc0FHcnVlNlpXc1JGS3pjVFRFK3ZnY21PbmlDU0Y4STVH?=
 =?utf-8?B?bHBOQkY2VzJPUi9OK29mWTBDY1RERjBqQjc1U1VoUlFQeEh2bUlvbjl3Um9V?=
 =?utf-8?B?bldwVnNrQk1RSGNUS0dPVmZIUTZaNnZYbjgvOGJtRzVkMW5qRWJCTndpSFZG?=
 =?utf-8?B?Uk9rZkV4bDlVSWN1dWkwa2JjaTZJYnk3UjFZVTZ6SkJ3TVQ1dXFWR0xaakpR?=
 =?utf-8?B?c09TejY0VUxzWEg5MzJCeUFBRm82N25RZTlML0lRcHB1RytwRkUxNWZMOUt3?=
 =?utf-8?B?amVRazJCOEhYVHZKUFFDOGhkYkZjc2FMS3FlYk9wVkt2WXl0WVVvbzdBaVpj?=
 =?utf-8?B?K25KdXdUQ1RwdThGVTFQdzhvdFpxanZaTGkxY3BWVC85ZzhPTlVCTUZSMGY4?=
 =?utf-8?B?WTJndXhUNy9IaFZ1MGlmMmpWdTJZYUhEd0N0aDZJQVVhVktIc2hhK213VGJN?=
 =?utf-8?B?ai9uUXM3ZHFSZ0xTdExiVFZqcis1QnVadm5BZzRqelgzVFJxSFJOTXU2NGlQ?=
 =?utf-8?B?MEVnSEhFNEc4dURIZ0xxVkFFM21wR2szU050NnpMZUFYZlR1MzNjSDdSbUxO?=
 =?utf-8?B?YmdrRjI4djhkZldZbXhzNnZpd1ZHdG9tbDQ4bmx1K2w1NDM0VHNOeXRYcENm?=
 =?utf-8?B?UXhjNDhPMllpWjNhZnp5VFlQeXhLS3BzK3RQVnlaNnQ4b3NJNVphMFpDa3JO?=
 =?utf-8?B?dFJ5djY0aWtCTGFIWlNLbHU4QS9VekFLczdQRjlnYVhxSWFwUkhEcGhSR0dE?=
 =?utf-8?Q?kQvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6d45c2-6699-4a6e-d72f-08daf82d4da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:51:08.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU6kD/dds2VFjfAKAGXYDMpVXNCCYrHP3UsFTvICooWbJKh12d8Au+4VANjbLSjN6Xo+NZhofF6OYrLi2g/fbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTmljb2xhcyBEdWZyZXNuZSA8bmlj
b2xhc0BuZHVmcmVzbmUuY2E+DQo+U2VudDogMjAyM+W5tDHmnIgxN+aXpSA0OjQ3DQo+VG86IE1p
bmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7IGh2ZXJrdWls
LQ0KPmNpc2NvQHhzNGFsbC5ubA0KPkNjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtDQo+aW14QG54cC5jb20+
OyBYLkguIEJhbyA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IEVhZ2xlIFpob3UNCj48ZWFnbGUuemhv
dUBueHAuY29tPjsgVGFvIEppYW5nIDx0YW8uamlhbmdfMkBueHAuY29tPjsgbGludXgtDQo+bWVk
aWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBbRVhUXSBSZTogW1BB
VENIIHYzIDEvMl0gbWVkaWE6IGFkZCBSZWFsVmlkZW8gZm9ybWF0IFJWMzAgYW5kDQo+UlY0MA0K
Pg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPkxlIHZlbmRyZWRpIDEzIGphbnZpZXIgMjAyMyDD
oCAxMjoxMyArMDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4+IFJlYWxWaWRlbywgb3IgYWxz
byBzcGVsbGVkIGFzIFJlYWwgVmlkZW8sIGlzIGEgc3VpdGUgb2YgcHJvcHJpZXRhcnkNCj4+IHZp
ZGVvIGNvbXByZXNzaW9uIGZvcm1hdHMgZGV2ZWxvcGVkIGJ5IFJlYWxOZXR3b3JrcyAtIHRoZSBz
cGVjaWZpYw0KPj4gZm9ybWF0IGNoYW5nZXMgd2l0aCB0aGUgdmVyc2lvbi4NCj4+IFJlYWxWaWRl
byBjb2RlY3MgYXJlIGlkZW50aWZpZWQgYnkgZm91ci1jaGFyYWN0ZXIgY29kZXMuDQo+PiBSVjMw
IGFuZCBSVjQwIGFyZSBSZWFsTmV0d29ya3MnIHByb3ByaWV0YXJ5IEguMjY0LWJhc2VkIGNvZGVj
cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0K
Pj4gLS0tDQo+PiAgLi4uL21lZGlhL3Y0bC9waXhmbXQtY29tcHJlc3NlZC5yc3QgICAgICAgICAg
IHwgMjEgKysrKysrKysrKysrKysrKysrKw0KPj4gIGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0
bDItaW9jdGwuYyAgICAgICAgICB8ICAyICsrDQo+PiAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVv
ZGV2Mi5oICAgICAgICAgICAgICAgIHwgIDIgKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0DQo+PiBhL0RvY3VtZW50YXRpb24vdXNlcnNw
YWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiBiL0RvY3VtZW50YXRp
b24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiBpbmRl
eCBhMDIzMGYzNTc2ODAuLjUwYWMwOTVjMWYxNiAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZtdC1jb21wcmVzc2Vk
LnJzdA0KPj4gQEAgLTIzNyw2ICsyMzcsMjcgQEAgQ29tcHJlc3NlZCBGb3JtYXRzDQo+PiAgICAg
ICAgICBNZXRhZGF0YSBhc3NvY2lhdGVkIHdpdGggdGhlIGZyYW1lIHRvIGRlY29kZSBpcyByZXF1
aXJlZCB0byBiZSBwYXNzZWQNCj4+ICAgICAgICAgIHRocm91Z2ggdGhlIGBgVjRMMl9DSURfU1RB
VEVMRVNTX0ZXSFRfUEFSQU1TYGAgY29udHJvbC4NCj4+ICAgICAgIFNlZSB0aGUgOnJlZjpgYXNz
b2NpYXRlZCBDb2RlYyBDb250cm9sIElEIDxjb2RlYy1zdGF0ZWxlc3MtZndodD5gLg0KPj4gKyAg
ICAqIC4uIF9WNEwyLVBJWC1GTVQtUlYzMDoNCj4+ICsNCj4+ICsgICAgICAtIGBgVjRMMl9QSVhf
Rk1UX1JWMzBgYA0KPj4gKyAgICAgIC0gJ1JWMzAnDQo+PiArICAgICAgLSBSZWFsVmlkZW8sIG9y
IGFsc28gc3BlbGxlZCBhcyBSZWFsIFZpZGVvLCBpcyBhIHN1aXRlIG9mIHByb3ByaWV0YXJ5DQo+
PiArICAgICAgICB2aWRlbyBjb21wcmVzc2lvbiBmb3JtYXRzIGRldmVsb3BlZCBieSBSZWFsTmV0
d29ya3MgLQ0KPj4gKyAgICAgICAgdGhlIHNwZWNpZmljIGZvcm1hdCBjaGFuZ2VzIHdpdGggdGhl
IHZlcnNpb24uDQo+PiArICAgICAgICBSZWFsVmlkZW8gY29kZWNzIGFyZSBpZGVudGlmaWVkIGJ5
IGZvdXItY2hhcmFjdGVyIGNvZGVzLg0KPj4gKyAgICAgICAgUlYzMCBjb3JyZXNwb25kcyB0byBS
ZWFsVmlkZW8gOCwgc3VzcGVjdGVkIHRvIGJhc2VkIGxhcmdlbHkNCj4+ICsgb24gYW4gZWFybHkg
ZHJhZnQgb2YgSC4yNjQNCj4NCj50byAqYmUqIGJhc2VkIG9uLg0KPg0KPkp1c3QgYSBzdHlsZSBj
b21tZW50IHRvbywgYnV0IHRoZSBmbG93IGNvdWxkIGJlIGltcHJvdmVkIHdoaWxlIGZpeGluZyB0
aGlzDQo+dHlwby4NCj5MaW5lcyBpbiB0aGlzIHBhcmFncmFwaCBzZWVtcyB2ZXJ5IHVuZXZlbi4N
Cj4NCj4+ICsgICAgKiAuLiBfVjRMMi1QSVgtRk1ULVJWNDA6DQo+PiArDQo+PiArICAgICAgLSBg
YFY0TDJfUElYX0ZNVF9SVjQwYGANCj4+ICsgICAgICAtICdSVjQwJw0KPj4gKyAgICAgIC0gUlY0
MCByZXByZXNlbnRzIFJlYWxWaWRlbyA5IGFuZCBSZWFsVmlkZW8gMTAuDQo+PiArICAgICAgICBS
ZWFsVmlkZW8gOSwgc3VzcGVjdGVkIHRvIGJlIGJhc2VkIG9uIEguMjY0LA0KPj4gKyAgICAgICAg
UmVhbFZpZGVvIDEwLCBha2EgUlY5IEVIUSwgVGhpcyByZWZlcnMgdG8NCj4+ICsgICAgICAgIGFu
IGltcHJvdmVkIGVuY29kZXIgZm9yIHRoZSBSVjkgZm9ybWF0DQo+PiArICAgICAgICB0aGF0IGlz
IGZ1bGx5IGJhY2t3YXJkcyBjb21wYXRpYmxlIHdpdGggUlY5IHBsYXllcnMgLQ0KPj4gKyAgICAg
ICAgdGhlIGZvcm1hdCBhbmQgZGVjb2RlciBkaWQgbm90IGNoYW5nZSwNCj4+ICsgICAgICAgIG9u
bHkgdGhlIGVuY29kZXIgZGlkLg0KPj4gKyAgICAgICAgQXMgYSByZXN1bHQsIGl0IHVzZXMgdGhl
IHNhbWUgRm91ckNDLg0KPg0KPkl0IGZlZWxzIHRoaXMgb25lIGNvdWxkIGJlIHdpZGVyID8gQnV0
IGFnYWluLCB0aGlzIGlzIGNvc21ldGljIGF0IHRoaXMgcG9pbnQuDQo+Rm9yIHRoZSBBUEkgY2hh
bmdlcywgYXNzdW1pbmcgZml4ZWQgdHlwbyBhbmQgaW1wcm92ZWQgc3R5bGU6DQo+DQo+UmV2aWV3
ZWQtYnk6IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT4N
Cg0KSGkgTmljb2xhcywNCiAgICBJJ2xsIGZpeCB0aGUgdHlwbyBhbmQgaW1wcm92ZSBzdHlsZSBp
biB2NCBwYXRjaCwgDQogICAgQW5kIGZvciBSVjQwLCBtYXliZSBhIG5ldyBmb3VyY2MgbGlrZSBS
VjQwRSBjYW4gYmUgZGVmaW5lZCBmb3IgZW5jb2RpbmcgUmVhbFZpZGVvIDEwLiBCdXQgdGhpcyBw
YXRjaCB3b24ndCB1c2UgdGhpcyBmb3JtYXQsIHNvbWUgZW5jb2RlciBkcml2ZXIgY2FuIGFkZCBp
dCBpbiB0aGUgZnV0dXJlICBpZiBpdCBjYW4gc3VwcG9ydCBlbmNvZGluZyB0aGUgUmVhbFZpZGVv
IDEwDQoNCk1pbmcNCg0KPg0KPj4NCj4+ICAuLiByYXc6OiBsYXRleA0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4+IGIvZHJpdmVycy9t
ZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiBpbmRleCA5YjViMDRiOGFhNjkuLjA1NDZi
MDBkM2ZjOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9j
dGwuYw0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiBA
QCAtMTQ3Myw2ICsxNDczLDggQEAgc3RhdGljIHZvaWQgdjRsX2ZpbGxfZm10ZGVzYyhzdHJ1Y3Qg
djRsMl9mbXRkZXNjDQo+KmZtdCkNCj4+ICAgICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRf
RldIVDogICAgICAgICBkZXNjciA9ICJGV0hUIjsgYnJlYWs7IC8qIHVzZWQgaW4NCj52aWNvZGVj
ICovDQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX0ZXSFRfU1RBVEVMRVNTOiAg
ICAgICBkZXNjciA9ICJGV0hUIFN0YXRlbGVzcyI7DQo+YnJlYWs7IC8qIHVzZWQgaW4gdmljb2Rl
YyAqLw0KPj4gICAgICAgICAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9TUEs6ICAgICAgICAgIGRl
c2NyID0gIlNvcmVuc29uIFNwYXJrIjsgYnJlYWs7DQo+PiArICAgICAgICAgICAgIGNhc2UgVjRM
Ml9QSVhfRk1UX1JWMzA6ICAgICAgICAgZGVzY3IgPSAiUmVhbFZpZGVvIDgiOyBicmVhazsNCj4+
ICsgICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfUlY0MDogICAgICAgICBkZXNjciA9ICJS
ZWFsVmlkZW8gOSAmIDEwIjsgYnJlYWs7DQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRMMl9QSVhf
Rk1UX0NQSUExOiAgICAgICAgZGVzY3IgPSAiR1NQQ0EgQ1BpQSBZVVYiOyBicmVhazsNCj4+ICAg
ICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfV05WQTogICAgICAgICBkZXNjciA9ICJXTlZB
IjsgYnJlYWs7DQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX1NOOUMxMFg6ICAg
ICAgZGVzY3IgPSAiR1NQQ0EgU045QzEwWCI7IGJyZWFrOw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9k
ZXYyLmggaW5kZXggMjYyZWYxMGNmYTAyLi5iMTIxMTU0YTZlMjQNCj4+IDEwMDY0NA0KPj4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmlkZW9kZXYyLmgNCj4+IEBAIC03NDAsNiArNzQwLDggQEAgc3RydWN0IHY0bDJfcGl4
X2Zvcm1hdCB7ICAjZGVmaW5lDQo+PiBWNEwyX1BJWF9GTVRfSDI2NF9TTElDRSB2NGwyX2ZvdXJj
YygnUycsICcyJywgJzYnLCAnNCcpIC8qIEgyNjQgcGFyc2VkDQo+PiBzbGljZXMgKi8gICNkZWZp
bmUgVjRMMl9QSVhfRk1UX0hFVkNfU0xJQ0UgdjRsMl9mb3VyY2MoJ1MnLCAnMicsICc2JywgJzUn
KSAvKg0KPkhFVkMgcGFyc2VkIHNsaWNlcyAqLw0KPj4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1NQ
SyAgICAgIHY0bDJfZm91cmNjKCdTJywgJ1AnLCAnSycsICcwJykgLyogU29yZW5zb24gU3BhcmsN
Cj4qLw0KPj4gKyNkZWZpbmUgVjRMMl9QSVhfRk1UX1JWMzAgICAgIHY0bDJfZm91cmNjKCdSJywg
J1YnLCAnMycsICcwJykgLyogUmVhbFZpZGVvIDgNCj4qLw0KPj4gKyNkZWZpbmUgVjRMMl9QSVhf
Rk1UX1JWNDAgICAgIHY0bDJfZm91cmNjKCdSJywgJ1YnLCAnNCcsICcwJykgLyogUmVhbFZpZGVv
IDkgJg0KPjEwICovDQo+Pg0KPj4gIC8qICBWZW5kb3Itc3BlY2lmaWMgZm9ybWF0cyAgICovDQo+
PiAgI2RlZmluZSBWNEwyX1BJWF9GTVRfQ1BJQTEgICAgdjRsMl9mb3VyY2MoJ0MnLCAnUCcsICdJ
JywgJ0EnKSAvKiBjcGlhMSBZVVYgKi8NCg0K
