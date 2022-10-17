Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6E600623
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJQFKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:10:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20266520AC;
        Sun, 16 Oct 2022 22:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzrRegoaDID47oIspa5LOWP9TC/13+EkvO4r6k92u2kswhIkK3AI9Jm2nX7DnyV7unKMWYnWj7pEKUmni3EYkzqiyLol9nigVPcgenulAdwYMlvEq41xRMgAAGw8UXr2XtNIfvq1P0OiQ/AqGm1/b9gUO9lZZaqgq04ZjRZgC4129r6IzjJayN3sEKh3UUNzNDsKH6Nd1/4zOjTL5zvaXMZC+IO2I2KaHRpPgAV3ImlmezE2MCSw/Cw/o5/l2uvXLgic0AoAqfiBZNL75i6l7cyDIFYGkUroc91pZRyWWav4TECH//GwBcSfyfDUU4hbC7v6sI9ltdXHKBAHlR6DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3seuytbF2ClXnttmeUwjyjobnfgtaXFyxTpaSdPQQw=;
 b=nLlJYivOREp8AT5IPCOMpi0URmzlAGga28+Hydm0JpDYnorPhYS5usYWYthnlqoF3kPMoaXLaV2L2cDI5o7Y5IPV3H48N1h/+Tjes6SnQCzcJaw8Qid9LXl5v2H4foGyW6EimEsEaNp3DHiB5JI77pVi3VNye6H+NiDUP0Q2LVMFtETLTyb7KmZYORIVQSQXhhYNIMhHeZAyMChPsJquRPDXSuuLVvrSx1kPATXfZDZ1g2skVxeacQ9vgq7L4uhS+YY47sFPSJjpApbp34U/Yk4SPpktjtX89nnATbTqgpOBzHgeYJOgYDiOha4ao8Ki2Vue8PueCu4U6jfxb738Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3seuytbF2ClXnttmeUwjyjobnfgtaXFyxTpaSdPQQw=;
 b=K7oLvHpStXk2iXgENlDrKWUwgp5vp1iluld0BZ5Hn3Vg1KaD2qJ/LYdsYLr2fimvFzwRvY02bfyyFCHzsxSb8ail8zxA0FG33FRQjG17QEExkXqKyQ8OeaOQyiG0WLR+Q5n9jmX3T0qO+XAaoiCNjtPGJgdzvAwpXb6P5OFszmc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 05:10:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 05:10:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH V7 2/7] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Thread-Topic: [PATCH V7 2/7] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Thread-Index: AQHY33pZAZ8rwH1kpUGdOkq3aEhK7a4RKogAgADj0sA=
Date:   Mon, 17 Oct 2022 05:10:47 +0000
Message-ID: <DU0PR04MB9417A4BB57256B7852C42A8C88299@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-3-peng.fan@oss.nxp.com>
 <199bed73-676b-850f-fe1e-f144e1b2f314@linaro.org>
In-Reply-To: <199bed73-676b-850f-fe1e-f144e1b2f314@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8383:EE_
x-ms-office365-filtering-correlation-id: d5b6457b-29f3-4e07-ed59-08daaffdf3ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGP3Eh77MwFiL0mPGd8sUXe0JYuEShuqDn0e0/cHyg1OxMoYfjYuFsG/vKsdIHH7XybwPEEB6oMebmq8LrhFVvkvUnxgjNoAAtPqk611Yaqd4lgOc8YheRTTezsMDyTHsg5myDbtfZO0PJneb5ugoVaLyIfqWIDJ0eHxNBRWflNMK+Cqoipdgs4Qy+Tcz68fRxb5WL/8HJwdwD4uVmg5mJuTexQw9FbgR0VZ+45el5SQPg+FLE9+ff0RjMU/f+tl5LTdmMt0H0015XuK6kuq7QZv7h0+i8C2fs7JfCEWMV4fVl4y6+QOeeeD9gKNuYpegg3CbHLdyZE9LIUA1SZesPDgYfCZ/ASemEOLnxSmycwxk1CMDyY3nD5xtNtq2/tJpSsU8xF+/DPnyHiCapF6oE1ByeNGCAWtm03/eEynxttDluxPVZ1KZ6PcdmIdq9YM0HYLJj6DSFrcPD0e2R+LDhBwcRWyZNAw6BZ+YjI18byfgg3AomSFiAemj+vVe4bpkOw31WfXiZME6bIkn3mqlbiEgzLPhC6MDue5/4ftzZ0R2EuXf3jcvalZLLpx/nH4bK68oRqmpCHJueELDRY4xEQcCosZZPepx+bVMZ46cqhMMXAFioIZSC9Uo+PDbIJBffNFjsDUbFvQCxSfW8Rim0UgcceschnjCWvJ/bX33l1CODh9cwB8YLbYKjsWROKmZunGKQhlm2JX8I9/GaGpAvONKBWM7jVRaPYhEZuPPWPWw0FFUGJ0Z6b10+PszVa0vmU9DLZLypDnBmiWzqDV3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(55016003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(83380400001)(316002)(478600001)(54906003)(71200400001)(110136005)(41300700001)(26005)(44832011)(7696005)(53546011)(6506007)(8936002)(52536014)(4744005)(7416002)(5660300002)(9686003)(66446008)(66476007)(66556008)(64756008)(76116006)(8676002)(186003)(4326008)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajl0NS9jeXJlY3lPbm1PYVcvRTVPek5aQndob0dicmdZendTUzd6OUF6bkR2?=
 =?utf-8?B?dThVZzhrY0QxeXJwNGpKWklvTFRzOS85VTl5QlVTMU8vR2JISlVXeW1CTzhT?=
 =?utf-8?B?dkRPUjdjeVVTWWs5a3JsNDFFMlloZlB0cW5DSXB4WTg4Sno1T09qUW52cmhr?=
 =?utf-8?B?RW5vMm5keGZPRjU5WW5ocDlJTE9Ra2lRZ21PMHoxNGhzOFh6VER6bk93MDUx?=
 =?utf-8?B?dXF0Y1BzdjBFQW5LYm1UNnJ5aVRZM1BYUXFWUWVjU2o4YWNlOWQyT25UNEpE?=
 =?utf-8?B?aFI5ZzNUNzRDQW1CSU4vUlBlVEt1RTB0Zkd1QWpXQ1FEYUZ5RiswWkpNUGpE?=
 =?utf-8?B?NDBKeGhma245RjMxdEoyWFJmS1hYV3E0SE0xWVVkazJiaXdKOFU5L0dOV1Z3?=
 =?utf-8?B?MXJ2ZjgzVVlZbUZMSTFXcjNETm1BZU9Fem96MDR4WW4yVE1HamtvVkZJZEtP?=
 =?utf-8?B?TUNndzlBa051UzRnVlYrM0ludGZqU1pjNkt5VERDanA3L0dpYkIvR0J6ODlB?=
 =?utf-8?B?VzNSK0J4bWZjRGF3Y3MyZmJwWmtRY3ZpbUZuemYrMzJUNE5zdnVnZHk2SlZy?=
 =?utf-8?B?Q0dSWldwUU5OOHh4LzJ4YnlyREVqbXhkOFBZL05GUUUxRTlacWFpZDdudGhB?=
 =?utf-8?B?aHh1QjhhMjdHb0tUc0RMaUVoN2MxU0UzZE5pNmUvOXpqdHRXOStISzYrWDB0?=
 =?utf-8?B?QUpKck1tOGFKYlhEQXJEUk8vaHhCZWNFY3hFd24xL3l3OXhHVUlKT2FyMGVu?=
 =?utf-8?B?QTl6OUxkZ1ZhbzVMRld5MDNRRTdZcEFaa2lLeXBaZWVGWEo2dHdXdTFQMFVa?=
 =?utf-8?B?WTVpeHdZdW11c3lRRTNRTUlXSWJKdEJFa1ZtMS9zVDhXQzIwTXNyVjEyc3Ru?=
 =?utf-8?B?akhDR1l6UnUxR0dMTWdhdlV0amJXUDM5Mk9SRytMR2JhdDhHcXJ2QlNZUzFI?=
 =?utf-8?B?VllHa0txU1R6NUl1Y3dYZGhrWTdDdHJMbHdQdUY0YmNMckpmSi85N0VtUnVC?=
 =?utf-8?B?T3J1S2ZhRVJXaHNDcU9saWRJTlpXTk41RTh2aXFkbFpFbUVnMTJiOVpFZFhl?=
 =?utf-8?B?S0lYK0U3WnVCZURyR011c0ZKcys0Yysvdm5MM0EzZG1HTHFNTHhOY1gyZzA2?=
 =?utf-8?B?bHJvS0t6NTE3V3Y4OU02L2FUNU1MZW1OZWxMcWZPVGp2Qms2OGYyYjVtRzk4?=
 =?utf-8?B?eDVUbkEyWi9tT3pSNFR4QXVCTWpkQXYrQ0srSVpZbnMydFlVZ0t3SEMwQ2E4?=
 =?utf-8?B?SzlDZlFNa0J3RlZFVDhGR0dxY21MVTlLU2QzbnRVVUNpdk1VdURDaks1bitw?=
 =?utf-8?B?N0M2QUlzaGt2emlMY2xHZEdJWGR6cTdaRGNPclBCU0djTm1OQW0wbDJXTDU5?=
 =?utf-8?B?UDJsdy8yTWZ0VTROV0RBaERJMHhpb2toZFlFSmpHaWFuVmhxN3ZpbVp2UEdV?=
 =?utf-8?B?ZXE1Ry91U3RNYXpKbktTZDZKUlZXWCtOQVpwTE1TaUt5RDVnVzR0aWoveFlx?=
 =?utf-8?B?MGVuNk5EZE1iTk1ZT2UvMytwR3l6M3dVSVlZUWFjelMwRTMza09BcDBxTmt2?=
 =?utf-8?B?Q1JXRWJYSVZkM0c3TGQvcHlrVWpBRW9xazI5MmdkR3hhREx0UUI2K3dMemU0?=
 =?utf-8?B?YXlRdUtna3cxdW5NWlJycnVjdnJ3VnlpZWM2ZWNEOXhydnpiNDltakFhekpn?=
 =?utf-8?B?aWhyWS9rOXpoWnZHVGNPOGV3akFmdnJBKzZHQUZUbi80MUhmdHZZR1pQaDlh?=
 =?utf-8?B?bjV6MmFXN01yNHFqVGdZRjYvVTFvbEgxQmpjMlhRRkhVWmVpUmMvREZjZUI3?=
 =?utf-8?B?dW5KWUIvSWNDYmgrNzFpdVZzUERKLzJoUjZFYVllQ2cxSUFBajBSQWlzQmZS?=
 =?utf-8?B?K05Vby94Y1NXNWZnUnV1elY0OTlTUE5FbUVrUEJVdXBldTJ0SUxSV2V2Z3Jy?=
 =?utf-8?B?ZzlrK1BkMDY1U3c5Uy91bTkzM1NMcVZmZ3pVRDVkeUYyY3dIUTJBUXEzeE1Y?=
 =?utf-8?B?aTlEUWwzUGRnRHFLcXdhSnBaZWFqMGtxOHpUeTViUzBCS3RVUWRyVjF3SGRz?=
 =?utf-8?B?a2p6YTMvc1ZnaFhRYS9NNHJOd0JOdUhtaTVHOTJMNlZCY3NRV3RBTnQydHpY?=
 =?utf-8?Q?w7TQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b6457b-29f3-4e07-ed59-08daaffdf3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 05:10:47.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzPdCgHWi3/zITabm6OOMawnACXbxN0Q3aev3iVVBpAYr9tgiXVNlsxnHypVI1iC9EG565rb4K1kSGbhTq0CEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY3IDIvN10gZHQtYmluZGluZ3M6IHJlbW90ZXByb2M6IGlt
eF9ycHJvYzogc3VwcG9ydA0KPiBpLk1YOFFNDQo+IA0KPiBPbiAxMy8xMC8yMDIyIDIzOjEwLCBQ
ZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPg0KPiA+IEFkZCBpLk1YOFFNIGNvbXBhdGlibGUNCj4gPg0KPiA+IFJldmlld2VkLWJ5
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9mc2wsaW14LXJwcm9jLnlhbWwgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvZnNsLGlteC0NCj4gcnBy
b2MueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL2Zz
bCxpbXgtDQo+IHJwcm9jLnlhbWwNCj4gPiBpbmRleCA3MDMyMmU1N2I2ZmYuLjY0ZTc4MzIzNGUz
OCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVt
b3RlcHJvYy9mc2wsaW14LXJwcm9jLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9mc2wsaW14LQ0KPiBycHJvYy55YW1sDQo+ID4gQEAg
LTIzLDYgKzIzLDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBmc2wsaW14OG1wLWNtNw0K
PiA+ICAgICAgICAtIGZzbCxpbXg4bXEtY200DQo+ID4gICAgICAgIC0gZnNsLGlteDhxeHAtY200
DQo+ID4gKyAgICAgIC0gZnNsLGlteDhxbS1jbTQNCj4gDQo+IEtlZXAgYWxwaGFiZXRpY2FsIG9y
ZGVyLg0KDQpTdXJlLiB3aWxsIGZpeCBpbiBWOC4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+ID4N
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
