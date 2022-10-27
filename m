Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D060EDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiJ0C2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiJ0C1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:27:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572841413AC;
        Wed, 26 Oct 2022 19:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTq1WsS0V3jJ1sprrgXqxvpZk2LbbXebw7CTWCeruOy7Rra5RrOwyCQH7g+RV9LiscyhYWcKCrmSrKNlqpeMoUuqRcpRrRATzcD2UsAWI/+6FSm1D/+uE2r3ugJe/aCV3c3RBY0r8DJWEPAfMoHg+FHpX2odwgwMO/M7ssmgKxIV9iCZ954tQVzw7fu5GKf4M0X27pSVaKnLGUM+yRhbgmzqlLseK7dDLd7tOUZWt0ypm9TmCOtfB0IEliViz7u55ipwzkIaLDLfVLTmYAOLh7Y8wbTO7nAbEZYQg1dfLFZ73bV511rjjgLta6KnpumZN4vMCdkr4vUvdC0G7mXFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW4f8On1hCNLov0pvrMAu8+f0SYKuASAVJ2nnl8URvQ=;
 b=MsBFkcrdL/DfvQly9HXlllDFswfGpacAuLYj9+5GEPIMas/xe/XJbXGSYKp8ZZB9i3CQHDjCbSREMWe4WEP6c84XgxATCHSK49rsqhCosPbeZdmp6iIS3VtM+GB3DUKMBBplhhFB04cZFagY4LHnoa6coWv7wK8fXh+JVw9rcfwjIsCm75JJvEB0r90OMVae5I8pMQvs+6PgjOTQiHOFJH+PtLv/KPiUBw/qyuqy4W8prwo3bAIn878OpN2OQDW2XvzQJLBL0k/MY4vQ6tiEL2Nh6zwHBl/6ED/8CvOe9gOmWCNS3ruPHZIVJs/2HYHAgWVNIAv8Fq1ZTk4Hpu469A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW4f8On1hCNLov0pvrMAu8+f0SYKuASAVJ2nnl8URvQ=;
 b=Q3VuhPrfw7HShduBXk1Tl4vWePVBfNXp99mE8ax6kJLMC9oIGOK/gWyYP8uzs4e0OFq0eoFlUMC5f6buVIkK7k6CGRT1/4c13sp7ueDw83matRD0PuwoT8X8JNBikDs9loUbKNmFkajqxM7/IlfSIM7/gJ6HCQ+32PLmsE/KVtM=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Thu, 27 Oct
 2022 02:27:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:27:40 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
Thread-Topic: [PATCH v3 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
Thread-Index: AQHY6KBK/UJi3tb5606lXM5u6pHcnq4gNMCAgAFQ9PA=
Date:   Thu, 27 Oct 2022 02:27:39 +0000
Message-ID: <PAXPR04MB9185CF77132019C534142C6289339@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-6-shenwei.wang@nxp.com>
 <20221026062011.GA18160@linux-1xn6>
In-Reply-To: <20221026062011.GA18160@linux-1xn6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DBBPR04MB7578:EE_
x-ms-office365-filtering-correlation-id: c790776f-9d11-4395-f1e9-08dab7c2d1f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0rSzDi3l63hvMXzneRluZgU8Uo1fEeRqzWcI5CM8P9CYLrpflXnsm1+/1FR0ktb3ldUhvDY4F+xJklEA9zg9jsSSmXZrAyoGg6WwnSZy9FeCVssuZyYd9H6f/pl8MPwhZiSuoVl5BB0+Nu/xq3Owji3FYXlyOwQssbcW9jTme+jDVFfQ3RS7WUI/PMHrH9K4oF2lDEpGfvtKJCsf3HLk9iOdivknfz+pkaHFA8uMZffR7HQRUs1JaDrMrwVSyGzHFGDx/eZz2M/orJTo5BS3ha/eaov04I0jt6VrcXgJY5wz2RWr9x6ns8yV1crHJcGr+uJwyDL3y02/Bb8od/k9Rf8WtT+TyRQplbB//NaEecsj3ump4LK4L8DYMdkBljjJOMIZCQY/FeRJnX+bOdrlOIlilsBp0CTpQBAZxjp5IRnMm/Tv8K57tU8DVzVZ6QzKHLntVYzsCakZWw7k6o7GqmFUJ6JWkIeNtjLlScxAFy1rv8LIvrIl1Ceei/fj0ZaU/R8IPkmP0sHg0gZUyqA0RiY1nm7Sa1+2D4akwXMqHGYllEKJMUU7XdOMjcTOfhPYvnXdr2qyQ95h8dbVUBEmV32soy1ck1T7utEUk6kvmKvYhr8oWG2rUBzeKcVjyF+ibF2GPKgWHYccWN3nAQFgkaGVDFHKmbaezVd9LnnlRsnsYC+/MeJRlszqaZeB1FeGZ3vOPBzjZJUNMmopc1dWuABbkytTml11DlxyzHRM367btSSvoD37RZzLKeLi0zS0cg7uN4SCl4QIw4mV9Lssg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(71200400001)(7416002)(2906002)(186003)(38070700005)(478600001)(44832011)(316002)(54906003)(6636002)(83380400001)(66946007)(76116006)(33656002)(6506007)(66556008)(66476007)(66446008)(4326008)(64756008)(55236004)(8676002)(7696005)(52536014)(8936002)(6862004)(5660300002)(9686003)(26005)(41300700001)(86362001)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdBVGdSZWM2Q0JRaHJjdUZoZkpVaktvWHBtSUxINUorZUxnVVp2VC9qeWlo?=
 =?utf-8?B?T1hwK2dhUUVwRGloYXNkUG9KdDZ6SVhUUGlEYkVSRUJjUU5RZGtnb2pjRytL?=
 =?utf-8?B?NkhlY0J5Vk4yOEphWnRLQU1lOW8vVzhBMk5NeXpRM2FIbUNYbDF5a0RmSFpN?=
 =?utf-8?B?Q0U0QnFLTVZSM09keUUvdmpKNEJweUZVLzRKUWl2UEl5ZUF4MitWWUZjS0tD?=
 =?utf-8?B?ZlMzZnBlSnd1WmlhaGNTOXA5VnlPSWViU0xNcVZ4TFBCRmxDWXRmeEZtdlY2?=
 =?utf-8?B?bWhQSnFXN2wxcE9SQ2pDaUlDSVZheEMrZGc5eU1QL2U4eDl6cDZTSHdNemRp?=
 =?utf-8?B?aUZPQjBva0tkeHM0TEEwMitkRUlGTHBvMkpEQ21nMWZINWg4a2xEOFhBRUdR?=
 =?utf-8?B?LzRmdmZRVzVqMWR1YklYWkwzUE16MHFFRlJZSHhvMUFITVBjV2VKVkpxVUh6?=
 =?utf-8?B?U3U3SEkxZ3JtMU1JVGc0cjRERkdyK0s5UWRTQm4rTzBFQytjWGRtZ2UxVEpG?=
 =?utf-8?B?T2FZTXRIUW9tVTQ4U0pOdXlRdXpiRUdvc0FVY2E1OHZ6ZGExYzlFUXJ6bWdu?=
 =?utf-8?B?eUlKcTZQWjA1QzlEZ3FzLzRGOEZEN0R4Z1gwQVd4N1lGNVgzemdJSHpHRm9B?=
 =?utf-8?B?WEpSTitUT3RFcTE2QitDeTlWTFlLVXplVDlMc0szejNPUk9mSnMxTTRiUkZR?=
 =?utf-8?B?NGN1ckhabHVVRmE5eldDU21jZ21JVHgrcE1qQW5pWHUzQkU3MVNzWDVXVXVH?=
 =?utf-8?B?UjlnM0lMTVlDa00rTXpFZXR2VTY4dVdGZ3NMTUJlZkRKVGMrTTBydzQ5QWx4?=
 =?utf-8?B?dWg0MkxaeUpPREZzdHN3Zjl2SHJTQko0RUMxUzlmS0UvcVdFWElvYkZqUmNs?=
 =?utf-8?B?MlNwamFGVWh6aWxEUGdpa3RkZFZaU0tabjl1SVpIWDBVZzArdWEwaEd2S2FL?=
 =?utf-8?B?TFV3ZG8zdUtXazNxbmtYZGUyWHhYZjJiS0RnanZjTFU3d3hnbzR4TWtPMDI0?=
 =?utf-8?B?NThvRHM2bmVUNWd4NG9wYlNhY2o5UzJORjkzWmZvcWJpdUVzeUJ6RllrS2Zq?=
 =?utf-8?B?bUxjSzBJSndRdnBSOU9NcHFsSWpCTzJsWmEyZ1dZd1pmVlUvWG9nUng1dWtu?=
 =?utf-8?B?a1EvZHR0Y0Q5a3pMMXp5YkxTNE93WmwzcWhaQ1lqZm9FamF4bzZ1Q2tFdkpk?=
 =?utf-8?B?ZnFPVzdZditoQXY1eUd1QThaSWgrMFBTRkE2MVY4ZVdBeHVkUXltQUZhajND?=
 =?utf-8?B?RnFsNVkzRnNDdE9VMWg5UXY0LzRXTEwvaHVlQXRwNW1ucnNscHJybjVGRkxB?=
 =?utf-8?B?RUhRT2RHV2dLNmV1OEVSblgzR3g4TlZkbUozTnZVaW5JRDBEaloraFBPd2g1?=
 =?utf-8?B?Yk9tZ09uMVplVGRkUy9HY1JFQzVOSGZLR1lTc3YyQ2dPTTRTSURBamlUY0tS?=
 =?utf-8?B?VFJONUpsVUxJOExSNnpzL2NsWnhJK0FUTktpRkt0SkpmS0Z5Z2NURGlzd05k?=
 =?utf-8?B?UnFxMFlSWGNjTkNEdzBUcUNxV21nVm8yTE5zNnNTd25VMXhab3BJZ0NvODFt?=
 =?utf-8?B?WHZxTlcxU2RIMnc2NmxpaUdaTy9OOE8xa1RpMUVLMW5DQkJwZzBEWkVKSDhJ?=
 =?utf-8?B?Rnk5NHJUYjdTT1ExZUdmSmFQWFptMGtVamFlNURDUmo5NnlKRm9BR0ZwTHBy?=
 =?utf-8?B?cWFDWDR0a1NzUXkvS0U3dzlzRW9EQUJzcmplNXhObHhuelZDemZETThXZmhW?=
 =?utf-8?B?N1RJdkQ3N1cySlFEaS9sSy9iQjFBTTRpdjdZa05BVXVUajErS3ltM1JOQWN1?=
 =?utf-8?B?WHJwWlY2djZOdE12dU9ROE1BcFJYZ2lKbm8yMEV2NVc5NHo0YXlkaG5CdXpz?=
 =?utf-8?B?OUFvUThMeURRUFFvRVhjK200MVlpUzRDUXc4cFl5elViOTZlNEhEUE1XclNZ?=
 =?utf-8?B?K3hKYm53NUI0cUtHYVpMWFRTZm41UUlPZTdwRjVQc0xUZlVFN01oSnBuZVNm?=
 =?utf-8?B?MWttSzBoZzl3a0xsSXhKaGFvS1dTMStnTTFtRTZMaDZUNDdzZGVIV3MwdCty?=
 =?utf-8?B?KzNEelZkOXVkMVVobFphdG9vTjE5ZHpYYzhOam1FL3A5cVRjQ1B6ajl4OHRv?=
 =?utf-8?Q?8BaWsDhA8yIwaaY4Q8FlxxzU1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c790776f-9d11-4395-f1e9-08dab7c2d1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 02:27:40.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zew46/2Boz3ZNzxfHpvoMnTkr2VNb/IZlDUcAcafjCEL5QS41rMoXXTcTCNbAoQ34LrSp7seh1C3d//cHIfizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAxOjIwIEFN
DQo+ID4rCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImZzbCxpbXg4ZHhsLWdwaW8i
KSB8fA0KPiA+KwkJb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJmc2wsaW14OHF4cC1ncGlv
IikgfHwNCj4gPisJCW9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAiZnNsLGlteDhxbS1ncGlv
IikpDQo+ID4rCQlyZXR1cm4gZ3Bpb2NoaXBfZ2VuZXJpY19jb25maWcoJnBvcnQtPmdjLCBvZmZz
ZXQsIGNvbmZpZyk7DQo+IA0KPiBjaGVja3BhdGNoIHNob3VsZCByZXBvcnQgd2FybmluZy4NCj4g
DQoNCkl0IGlzIGFjdHVhbGx5IG5vIHdhcm5pbmcuIPCfmIoNCiQgLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgMDAwNS1ncGlvLW14Yy1lbmFibGUtcGFkLXdha2V1cC1vbi1pLk1YOHgtcGxhdGZvcm1z
LnBhdGNoIA0KdG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTAgbGluZXMgY2hlY2tlZA0K
DQowMDA1LWdwaW8tbXhjLWVuYWJsZS1wYWQtd2FrZXVwLW9uLWkuTVg4eC1wbGF0Zm9ybXMucGF0
Y2ggaGFzIG5vIG9idmlvdXMgc3R5bGUgcHJvYmxlbXMgYW5kIGlzIHJlYWR5IGZvciBzdWJtaXNz
aW9uLg0KDQpSZWdhcmRzLA0KU2hlbndlaQ0KDQo+ID4rDQo+ID4rCXJldHVybiAwOw0KPiA+K30N
Cj4gPisNCj4gPitzdGF0aWMgdm9pZCBteGNfZ3Bpb19zZXRfcGFkX3dha2V1cChzdHJ1Y3QgbXhj
X2dwaW9fcG9ydCAqcG9ydCwgYm9vbA0KPiA+K2VuYWJsZSkgew0KPiA+Kwl1bnNpZ25lZCBsb25n
IGNvbmZpZzsNCj4gPisJaW50IGksIHR5cGU7DQo+ID4rDQo+ID4rCXN0YXRpYyBjb25zdCB1MzIg
cGFkX3R5cGVfbWFwW10gPSB7DQo+ID4rCQlJTVhfU0NVX1dBS0VVUF9PRkYsCQkvKiAwICovDQo+
ID4rCQlJTVhfU0NVX1dBS0VVUF9SSVNFX0VER0UsCS8qIElSUV9UWVBFX0VER0VfUklTSU5HICov
DQo+ID4rCQlJTVhfU0NVX1dBS0VVUF9GQUxMX0VER0UsCS8qDQo+IElSUV9UWVBFX0VER0VfRkFM
TElORyAqLw0KPiA+KwkJSU1YX1NDVV9XQUtFVVBfRkFMTF9FREdFLAkvKg0KPiBJUlFfVFlQRV9F
REdFX0JPVEggKi8NCj4gPisJCUlNWF9TQ1VfV0FLRVVQX0hJR0hfTFZMLAkvKiBJUlFfVFlQRV9M
RVZFTF9ISUdIICovDQo+ID4rCQlJTVhfU0NVX1dBS0VVUF9PRkYsCQkvKiA1ICovDQo+ID4rCQlJ
TVhfU0NVX1dBS0VVUF9PRkYsCQkvKiA2ICovDQo+ID4rCQlJTVhfU0NVX1dBS0VVUF9PRkYsCQkv
KiA3ICovDQo+ID4rCQlJTVhfU0NVX1dBS0VVUF9MT1dfTFZMLAkJLyoNCj4gSVJRX1RZUEVfTEVW
RUxfTE9XICovDQo+ID4rCX07DQo+ID4rDQo+ID4rCWZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKSB7
DQo+ID4rCQlpZiAoKHBvcnQtPndha2V1cF9wYWRzICYgKDE8PGkpKSkgew0KPiA+KwkJCXR5cGUg
PSBwb3J0LT5wYWRfdHlwZVtpXTsNCj4gPisJCQlpZiAoZW5hYmxlKQ0KPiA+KwkJCQljb25maWcg
PSBwYWRfdHlwZV9tYXBbdHlwZV07DQo+ID4rCQkJZWxzZQ0KPiA+KwkJCQljb25maWcgPSBJTVhf
U0NVX1dBS0VVUF9PRkY7DQo+ID4rCQkJbXhjX2dwaW9fZ2VuZXJpY19jb25maWcocG9ydCwgaSwg
Y29uZmlnKTsNCj4gPisJCX0NCj4gPisJfQ0KPiA+K30NCj4gPisNCj4gPitzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIG14Y19ncGlvX25vaXJxX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7
DQo+ID4rCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2Uo
ZGV2KTsNCj4gPisJc3RydWN0IG14Y19ncGlvX3BvcnQgKnBvcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2
ZGF0YShwZGV2KTsNCj4gPisNCj4gPisJaWYgKHBvcnQtPndha2V1cF9wYWRzID4gMCkgew0KPiA+
KwkJbXhjX2dwaW9fc2V0X3BhZF93YWtldXAocG9ydCwgdHJ1ZSk7DQo+ID4rCQlwb3J0LT5pc19w
YWRfd2FrZXVwID0gdHJ1ZTsNCj4gPisJfQ0KPiA+Kw0KPiA+KwlyZXR1cm4gMDsNCj4gPit9DQo+
ID4rDQo+ID4rc3RhdGljIGludCBfX21heWJlX3VudXNlZCBteGNfZ3Bpb19ub2lycV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4rCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYg
PSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gPisJc3RydWN0IG14Y19ncGlvX3BvcnQgKnBv
cnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPisNCj4gPisJaWYgKHBvcnQtPndh
a2V1cF9wYWRzID4gMCkNCj4gPisJCW14Y19ncGlvX3NldF9wYWRfd2FrZXVwKHBvcnQsIGZhbHNl
KTsNCj4gPisJcG9ydC0+aXNfcGFkX3dha2V1cCA9IGZhbHNlOw0KPiA+Kw0KPiA+KwlyZXR1cm4g
MDsNCj4gPit9DQo+ID4rDQo+ID4rc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIG14Y19n
cGlvX2Rldl9wbV9vcHMgPSB7DQo+ID4rCVNFVF9OT0lSUV9TWVNURU1fU0xFRVBfUE1fT1BTKG14
Y19ncGlvX25vaXJxX3N1c3BlbmQsDQo+ID4rbXhjX2dwaW9fbm9pcnFfcmVzdW1lKSB9Ow0KPiA+
Kw0KPiA+IHN0YXRpYyBpbnQgbXhjX2dwaW9fc3lzY29yZV9zdXNwZW5kKHZvaWQpICB7DQo+ID4g
CXN0cnVjdCBteGNfZ3Bpb19wb3J0ICpwb3J0Ow0KPiA+QEAgLTUzNyw2ICs2MjUsNyBAQCBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBteGNfZ3Bpb19kcml2ZXIgPSB7DQo+ID4gCQkubmFt
ZQk9ICJncGlvLW14YyIsDQo+ID4gCQkub2ZfbWF0Y2hfdGFibGUgPSBteGNfZ3Bpb19kdF9pZHMs
DQo+ID4gCQkuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUsDQo+ID4rCQkucG0gPSAmbXhjX2dw
aW9fZGV2X3BtX29wcywNCj4gPiAJfSwNCj4gPiAJLnByb2JlCQk9IG14Y19ncGlvX3Byb2JlLA0K
PiA+IH07DQo+IA0KPiANCj4gRXhjZXB0IHRoZSBmb3JtYXQgaXNzdWUsIHBhdGNoIGxvb2tzIGdv
b2QgdG8gbWUuDQo+IA0KPiBSZWdhcmRzLA0KPiBQZW5nLg0KPiANCj4gPi0tDQo+ID4yLjM0LjEN
Cj4gPg0KPiANCj4gLS0NCg==
