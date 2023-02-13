Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931F694096
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBMJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjBMJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:16:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BCAD31;
        Mon, 13 Feb 2023 01:16:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpcO8PTWz5Dnnbf8BqsozMDiir96IgkexDD/NuIaMZfoINhLVtQxeosLOgXdxEVa1AYzmULJHQW6n9Ut24Hg11gKi+LzsHRM0oZhF4wYNgIZNoQQQWIG2nnoareB7nxc1yM4w9ESaNoLPrdbBx6913Ah16ufI8BGogZP3f/jR4hypJWlS9nX8iEBB0kJc7GDYz4JKe3xUx2kzcBLNwPuPhDlGX/qYpX3IlXn1L4YMqcZweroGugS3QdjqWFi3TFcDth1sTYkGL4hzTnNCwxubjqd2vBipAhn2xC6D4I+yo798jUSPwvVMynZWLfXFz9BdRcltpVkZPf/FEgXpZOtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC6fdC/lFM4hKW2uYb8Skj8uwIU3Y8WV5fMxi6HAVNU=;
 b=bzyJDNl0glE3lTxdtJrlh26e4FvCoT05p1aUKBjNrItIKtHxCIYt2IMPEOvo4EU2FfRNWX251dpw2iSrVy4vJcKSkMrKFEJ0Z5BtJUvOiV5X01dib80WLOJWdsBGenj4E59eBnDBPYRslk9B4/abl5k1Cc/hqhEqa6wZZmfvya8f1Ti4x8kjjzoCzb4RBby942ZuBmXt1GrijiMt+4opyOy0oHDxqvFg6xuvbY+cVi7/DRZ72KqVf/PEEcUvaA/uxnHV0vFwOWi8b4CQ8aTjEw3F3iaThKWkcogiYaJYlCDvCS2y9QTJK9fg+oKwxuIQjZu2BbduHmNS3xVZ5DCJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC6fdC/lFM4hKW2uYb8Skj8uwIU3Y8WV5fMxi6HAVNU=;
 b=n7/GKe2fQfJHLzEueA/YlgkG5mGrU15qPK8Es2dUzBcQSeoftS5fh9KSbpkk0iDuKUTHV7xtdeSlJag9oRwUcPrYl3j7tRhmTeG8m9EtA+sk5Eab6bXMN1nV96mMVNs9WbI/nR89DYogdSLOBTMV83BzlxFcGrFKzi1Zhbmf3tU=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB9319.eurprd04.prod.outlook.com (2603:10a6:102:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 09:16:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:16:05 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 01/10] media: Add P012 and P012M video format
Thread-Topic: [EXT] Re: [PATCH 01/10] media: Add P012 and P012M video format
Thread-Index: AQHZFCDfCq6gYCVoVEq/TY5oA18oV66yj9UAgARLEOCAEb/kgIAEUnDA
Date:   Mon, 13 Feb 2023 09:16:05 +0000
Message-ID: <AM6PR04MB63417E088E59E1B6D03E148CE7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
         <dfaef3c8eb29108b1837a1959d598c8b0db63422.1671071730.git.ming.qian@nxp.com>
         <05bfc909-1ebb-b74f-dcdd-adc70dd97f3e@xs4all.nl>
         <AM6PR04MB63418538B02868455752C74DE7D39@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <e60e4abcc9a4ae149844982afd65135d6e1c87b6.camel@ndufresne.ca>
In-Reply-To: <e60e4abcc9a4ae149844982afd65135d6e1c87b6.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PA4PR04MB9319:EE_
x-ms-office365-filtering-correlation-id: 33661679-e2cf-46f0-97a0-08db0da2ef7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cq4ypqb2kSeIpHfniVwBuodegL0kT7a56aI6o8uGiY2WwgKbkBrPXsZhz8yJRVWid+qZ4qSnMExdrQieamvurVHx7TEfe1/ONHfgP8aXDW2DJHrWl2yvZPSCe057VqsXJzfol3OKv/8mG70D6rR/kj5ow8UMUBBYjTWlQLX4As1BSDSRFVygY2XUAasbHBfxfmBVNLdkOqq5cj7BbuQ8xHc4hXWB307CXF81w+60yCHnimpMcEhZalJWJEwAVRM14TWlNbkix7PQbmZQyOEs5L5XfECTOLSx4GhnRne0CNxFaCP+Nx2bBT8RJIO7LCauc/RrFk8vXGCxQrjwJ2o+OUiwAxfY7xbKVnL8A+Z4oK1YC8StIZS8sw8DugsCFOR7+RFLCPnMFH+UqqWzrOUAyTIYsCKm8b1+vMar4SBO+574WQf4GPmONECD7XozkKaVzrHfoAFpsF/PSE1vsNytWGNi7iyRcfjS0JyzyCNpm2H5jbSk7+ZyqUn614Ve821FhfaBErk5teKe3TJzW6LPWAN079tcWHPvtTSwMQiNnzLRn3rV7jhkOdNRO0r98AWkri2MRQpK87VseqCet24XLBeGaHUXC4qKLzYBuW2bLSNTiHYoMNtEAP3N55RaRP3lcUBDIk+zXjVxLS67XjW1mDv78wAIZOy465t6n2Ouym/fvSl+rD6qgpSpEpqDRcrplUJzNORGUc7ker0JUUg8Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(55016003)(86362001)(33656002)(38070700005)(316002)(110136005)(66946007)(66574015)(83380400001)(66556008)(66446008)(64756008)(76116006)(66476007)(9686003)(6506007)(186003)(7696005)(71200400001)(26005)(45080400002)(478600001)(122000001)(38100700002)(54906003)(8936002)(5660300002)(8676002)(7416002)(4326008)(52536014)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Qzd1cVhaNXhmVFN3c2Yvd0tQRlpoS0JGTGNsWnEzelpIZUMwWGFFUHJJSUN1?=
 =?gb2312?B?MlB4WFZGendzSFlnMURkemF4Nnc5WXdZQVlxTUc2aU05RlAwRENEZ3g1cjI0?=
 =?gb2312?B?S2NrZE1DSUkyQytYTDZCQmF3VDNHbCs1RVFpU3lIbGVpWmlZVWQzU2lpYXEx?=
 =?gb2312?B?MmN3VFpYaCtvNTNHZkVoMzRJUWUvdVRzb3pXb0w1S2N2NDhsalRhbkYyYzFF?=
 =?gb2312?B?Mk44eXZCbUNBdGozQ29lVTV4eWJ6djVic0dBdi9neHZmMXZjZVdKVlhZQmpB?=
 =?gb2312?B?cnJ3bjJYKzkyY05wc2lHdk5GbkxxVElVdWNPTGx4WklVUExsbEtNK0pGcEpa?=
 =?gb2312?B?R21sTG9vSkFOWkpBampzRHVsakluSDNsTGFMMjZDbzhETVBacDl0UFBMSjZC?=
 =?gb2312?B?ekM3aEtmb2lHQjUxQkUyR1RzeCs0WXNZQ3FzdTJNdTRhUEVQSGJpZnE4Q3V1?=
 =?gb2312?B?a09xYWxvM2FDejJaa2tQUGlieWY0NmFscTJDdkt2Mi81OTZxSUVvNmpBT3Jr?=
 =?gb2312?B?NUZnVW41Rnh3ZGE4TXgzeFVOU0JEVC9CYnV4TFdYbkVPS3c4NFRaS0FFejJU?=
 =?gb2312?B?YWI4QnlOR2tmK1krZHpnTk1uQ2RadExZZTdmbTd0aFNaQWdBM21UMDRDWXBR?=
 =?gb2312?B?QTQ3VklSSVYrZ0lOWExURGZ1Ukt3UWpDY2MxZWVycmIwUElsZkFmZEI2aUkr?=
 =?gb2312?B?TmEvTjBOOVd3M3JIU2tNQUs3SC96blErQVMxUHc2bTYxNkgyTnpKZWxtT0tS?=
 =?gb2312?B?a09XL2l1L0F6R2g5cVFYbTBVbUJ2c3hOVkhiR29IaVFDUWp5RU9GdVhhMzVO?=
 =?gb2312?B?ZGEvdVgwN1Vya2pVdDlZbkFhL1A4RHd5WVdDZGpaUm90NlcvYVRQY3ZxVUQ0?=
 =?gb2312?B?dENCTERXa2NEU3cxVm5DbkdGczVmV3kvRGhIK1p0dmpnbm9Ia28wOWRveFFN?=
 =?gb2312?B?citJNTNuUGFCaWRueXFlV0pYVlZkaVp2VEp4OUxXQ21NTjFoWDJwMjBMd04y?=
 =?gb2312?B?R0U4VkVyUllZSFhQR295b3RjUmNaM2NuVWZRa3BUa05wVmNPRWJNM3pMaWw0?=
 =?gb2312?B?YzN5bktoMDJMN0VxU2x3OEdmNGpTbXBVWTkxOXpJa1JhaU1icktzMDQydWhP?=
 =?gb2312?B?dFhuREI3SVZLZUphRjhGblk3NnVyOXNNRmtJRnlwU0hicjVIQjlsUlMwRFhv?=
 =?gb2312?B?NGdGbDg2SWt6cGFMTmdyN1dKUDFHazVtT1ZNY2w0WmN6b1RoTjEyaC9lV2Js?=
 =?gb2312?B?bGdCM2pTSGh5dllMR2VObUVrMEU3RnltckRDUHdIaEtEeUQwaDBWMG10dFUr?=
 =?gb2312?B?U2NKbG02bHV1dkNPUStLNnFBb0Vyb1Y1QXBqZld1NjA5Tkp1MmdUL3F4KzAw?=
 =?gb2312?B?RTgwc01EQWU0aFBiTklwSW5YWmR0WGo4OFgvR2o5MndqY28vTXFVNTdvRHk1?=
 =?gb2312?B?enR3VmE3bDh2TVlmZGdySXZWb0loYmxHTzFoUmJiTWMyZDdaWEovYlRqWVl2?=
 =?gb2312?B?U2xRQ0NJUWJEOVcrMzdRWTcxbnJWTFE3blZTMEI1SVpNQjJocGNHeER4Q2Nu?=
 =?gb2312?B?aE5Qbm1HSGhlc0pNMEhhb1REN0VpRVFUMkZCb3J4ZkEzME84SENySFpSSksx?=
 =?gb2312?B?TGpMWjA5U0gwdG0wMjNsWXhtajJtNElkampwWWZjTWYyL0t2VFozTHlJQS9j?=
 =?gb2312?B?b1ZhUHVmL0tudTQzTmEwemFDamNiUk8zQlQrNXBXY3ladEoxVlBJcGJJbW5S?=
 =?gb2312?B?Sk9aclhZMDRWWXB5b2Q0R3RybGJBemVRd3hQd3dmUmdld1RoUS9qODc5SjUz?=
 =?gb2312?B?azlXMmo2bDhYREM0MFpMSUFiV2lKMjJDK2ZHb0VjWUFySGNWd2syYkNvbHNW?=
 =?gb2312?B?V01wOFZ2QjROdiszekkyR0tNNUdsUVgvSU1rMVljVXdJVC9lOTY2cjV5ZitM?=
 =?gb2312?B?dE9NdVhYWHJEb1JWeUcvcXBFRXZMdDF3MXJnVFdScU9MSGpZVmEzT2d6cHFl?=
 =?gb2312?B?b2xjUXA1bjVNc3RkNGFFdnZ2ZmRqYlFpNkZLNXpFRFN6MkhxOStqU1JJOHA0?=
 =?gb2312?B?dng1Y2FwbnJPaGcycmtyU2FJOTRjUE05K3RQUnVrRTNScGxFWkxhM3NMV2pI?=
 =?gb2312?Q?cI2Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33661679-e2cf-46f0-97a0-08db0da2ef7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 09:16:05.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hjf3+DTKJBakKm+ZVxTM+z1ZkmFMupAilR+LY4O1EYbGURDTgwitC96Ml7K1PG2zedlxPYUVWY7gNGLcOw6wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPlNlbnQ6IDIw
MjPE6jLUwjEwyNUgMjM6MDgNCj5UbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IEhh
bnMgVmVya3VpbCA8aHZlcmt1aWwtDQo+Y2lzY29AeHM0YWxsLm5sPjsgbWNoZWhhYkBrZXJuZWwu
b3JnOyBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPjxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT4N
Cj5DYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPmZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8gPHhpYWhvbmcu
YmFvQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPmlteEBueHAuY29tPjsgbGludXgt
bWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCAwMS8xMF0gbWVkaWE6IEFkZCBQ
MDEyIGFuZCBQMDEyTSB2aWRlbw0KPmZvcm1hdA0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0K
PkxlIGx1bmRpIDMwIGphbnZpZXIgMjAyMyCopCAwODoxNSArMDAwMCwgTWluZyBRaWFuIGEgqKZj
cml0IDoNCj4+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5o
DQo+PiA+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggaW5kZXggMWJlZmQxODFh
NGNjLi41NDQ4YWEzYjc4NTgNCj4+ID4gPiAxMDA2NDQNCj4+ID4gPiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmlkZW9kZXYyLmgNCj4+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlk
ZW9kZXYyLmgNCj4+ID4gPiBAQCAtNjI2LDEyICs2MjYsMTQgQEAgc3RydWN0IHY0bDJfcGl4X2Zv
cm1hdCB7DQo+PiA+ID4gICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9OVjI0ICAgIHY0bDJfZm91cmNj
KCdOJywgJ1YnLCAnMicsICc0JykgLyogMjQNCj4+ID4gPiBZL0NiQ3INCj4+ID4gNDo0OjQgICov
DQo+PiA+ID4gICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9OVjQyICAgIHY0bDJfZm91cmNjKCdOJywg
J1YnLCAnNCcsICcyJykgLyogMjQNCj4+ID4gPiBZL0NyQ2INCj4+ID4gNDo0OjQgICovDQo+PiA+
ID4gICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9QMDEwICAgIHY0bDJfZm91cmNjKCdQJywgJzAnLCAn
MScsICcwJykgLyogMjQNCj4+ID4gPiBZL0NiQ3INCj4+ID4gNDoyOjAgMTAtYml0IHBlciBjb21w
b25lbnQgKi8NCj4+ID4gPiArI2RlZmluZSBWNEwyX1BJWF9GTVRfUDAxMiAgICB2NGwyX2ZvdXJj
YygnUCcsICcwJywgJzEnLCAnMicpIC8qIDI0DQo+PiA+ID4gWS9DYkNyDQo+PiA+IDQ6MjowIDEy
LWJpdCBwZXIgY29tcG9uZW50ICovDQo+PiA+ID4NCj4+ID4gPiAgIC8qIHR3byBub24gY29udGln
dW91cyBwbGFuZXMgLSBvbmUgWSwgb25lIENyICsgQ2IgaW50ZXJsZWF2ZWQgICovDQo+PiA+ID4g
ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9OVjEyTSAgIHY0bDJfZm91cmNjKCdOJywgJ00nLCAnMScs
ICcyJykgLyogMTINCj4+ID4gPiBZL0NiQ3INCj4+ID4gNDoyOjAgICovDQo+PiA+ID4gICAjZGVm
aW5lIFY0TDJfUElYX0ZNVF9OVjIxTSAgIHY0bDJfZm91cmNjKCdOJywgJ00nLCAnMicsICcxJykg
LyogMjENCj4+ID4gPiBZL0NyQ2INCj4+ID4gNDoyOjAgICovDQo+PiA+ID4gICAjZGVmaW5lIFY0
TDJfUElYX0ZNVF9OVjE2TSAgIHY0bDJfZm91cmNjKCdOJywgJ00nLCAnMScsICc2JykgLyogMTYN
Cj4+ID4gPiBZL0NiQ3INCj4+ID4gNDoyOjIgICovDQo+PiA+ID4gICAjZGVmaW5lIFY0TDJfUElY
X0ZNVF9OVjYxTSAgIHY0bDJfZm91cmNjKCdOJywgJ00nLCAnNicsICcxJykgLyogMTYNCj4+ID4g
PiBZL0NyQ2INCj4+ID4gNDoyOjIgICovDQo+PiA+ID4gKyNkZWZpbmUgVjRMMl9QSVhfRk1UX1Aw
MTJNICAgdjRsMl9mb3VyY2MoJ1AnLCAnTScsICcxJywgJzInKSAvKiAyNA0KPj4gPiA+IFkvQ2JD
cg0KPj4gPiA0OjI6MCAxMi1iaXQgcGVyIGNvbXBvbmVudCAqLw0KPj4gPg0KPj4gPiBUaGUgbmFt
ZSBvZiB0aGUgVjRMMl9QSVhfRk1UXyBkZWZpbmVzIGluIHRoaXMgc2VyaWVzIGFyZSBoYXJkIHRv
IGRlY29kZS4NCj4+ID4NCj4+ID4gSW4gdGhpcyBjYXNlIGlzIGl0IGRlcml2ZWQgZnJvbSBWNEwy
X1BJWF9GTVRfUDAxMCwgd2hpY2ggcmVhbGx5DQo+PiA+IHNob3VsZCBoYXZlIGJlZW4gbmFtZWQg
ZGlmZmVyZW50bHksIGJ1dCBpdCdzIHRvbyBsYXRlIG5vdyA6LSgNCj4+ID4NCj4+ID4gU28gSSBn
dWVzcyB3ZSdsbCBzdGljayB3aXRoIHRoaXMgbmFtaW5nLCBidXQgaXQncyBub3Qgb2J2aW91cyB3
aGF0ICdQMDEyJw0KPj4gPiBtZWFucw0KPj4gPiB3aXRob3V0IHJlZmVycmluZyB0byBkb2N1bWVu
dGF0aW9uLg0KPj4gPg0KPj4gPiBPaCB3ZWxsLg0KPj4gPg0KPj4gPiBSZWdhcmRzLA0KPj4gPg0K
Pj4gPiAgICAgICAgIEhhbnMNCj4+DQo+PiBIaSBIYW5zLA0KPj4gICAgIEknbGwgdXBkYXRlIHRo
ZSBmb3JtYXQgbmFtZSwgYXMgeW91IGtub3csICB0aGUgUDAxMiBpcyBmb2xsb3dpbmcNCj4+IHRo
ZSBQMDEwLCBhcyB0aGV5IGFyZSBhbG1vc3QgdGhlIHNhbWUsIGFuZCB0aGUgWTIxMiBjb21lcyBm
cm9tDQo+PiBnc3RyZWFtZXIgKEdTVF9WSURFT19GT1JNQVRfWTIxMl9MRSksIHRoZW4gSSBkaWQg
c29tZSBuYW1pbmcgbGlrZSB0aGF0Lg0KPj4gICAgIEknbGwgY29ycmVjdCB0aGVtIGluIHYyIHBh
dGNoLg0KPg0KPkkgYWdyZWUgdGhlc2UgbmFtaW5nIGFyZSBub3Qgb2J2aW91cy4gSW4gR1N0cmVh
bWVyLCBhcHBhcnQgZnJvbSB0aGUgX0xFIHBhcnQsDQo+d2UndmUgaGFkIHRoaXMgaGlzdG9yaWNh
bCB0ZW5kZW5jeSB0byBqdXN0IHN0aWNrIHdpdGggTWljcm9zb2Z0IG5hbWVzIHdoZW4NCj50aGV5
IGV4aXN0LiBUaG91Z2ggTWljcm9zb2Z0IG9ubHkgZGVmaW5lIDEwIGFuZCAxNmJpdHMgKFAwMTAv
UDAxNiwgWTIxMCBhbmQNCj5ZMjE2KS4gSW4gdGhpcyBjYXNlLCB0aGUgMTIgaGFzIGlzIGRlcml2
ZWQgZnJvbSBpdC4NCj4NCj5odHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsZWFybi4NCj5taWNyb3NvZnQuY29tJTJGZW4tdXMl
MkZ3aW5kb3dzJTJGd2luMzIlMkZtZWRmb3VuZCUyRjEwLWJpdC1hbmQtDQo+MTYtYml0LXl1di12
aWRlby0NCj5mb3JtYXRzJmRhdGE9MDUlN0MwMSU3Q21pbmcucWlhbiU0MG54cC5jb20lN0M0OTQ2
ZDk4MzI1Njg0YTU1NGQNCj5hNDA4ZGIwYjc4YWEzYSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzgNCj4xMTYzODUxMDYzODQ2OTglN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMDQo+Q0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZA0KPmF0YT01WjZtMVdWeG1m
NldZWFJEWmlVdUtUOXdqeDdjT3R0JTJCUk1Iemx5VDNuNUUlM0QmcmVzZXJ2ZWQ9DQo+MA0KPg0K
PldoaWxlIFAwMTAgaXMgdmVyeSBjb21tb25seSBzZWVuLCBJIGRvbid0IGtub3cgaWYgWTIxMC9Z
MjEyL1kyMTYgaXMgYSBncmVhdA0KPmlkZWEuIEl0IGlzIGEgMTZiaXQgY29tcG9uZW50IHdpZHRo
IHZlcnNpb24gb2YgWVVZViwgd2hpY2ggYXMgd2Uga25vdyBleGlzdCBpbg0KPmFsbCBzb3J0IG9m
IHN3aXp6bGluZy4gU28gdGhlIE1pY3Jvc29mdCBuYW1lIHdpbGwgYmUgaGFyZCB0byBleHRlbmQg
dG8gb3RoZXINCj5jb21wb25lbnQgb3JkZXIuIE15IGFyZ3VtZW50IG9mIGtlZXBpbmcgaXQgdGhp
cyB3YXkgdGhvdWdoIGlzIHRoYXQgaXQNCj5tYXRjaGVzIHRoZSBvdGhlciBjb3B5IG9mIHBpeGVs
IGZvcm1hdHMgZGVmaW5pdGlvbiB0aGF0IGV4aXN0IGluIExpbnV4LCB3aGljaCBpcw0KPmRybV9m
b3VyY2MuaC4NCj4NCj5OaWNvbGFzDQoNCkhpIE5pY29sYXMsDQogICAgVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnRzLCBJIGFncmVlIHdpdGggeW91IHRoYXQgdGhlIG5hbWUgbGlrZSBZMjEyIGlzIGhh
cmQgdG8gdW5kZXJzdGFuZCwNCkknbGwgY29ycmVjdCB0aGVtIHRvIFlVWVY2NF8xMiwgIFlVVjQ4
XzEyLCBCR1I0OF8xMiBhbmQgQUJHUjY0XzEyLCBidXQgZm9yIFAwMTIsIEkgcHJlZmVyIHRvIGtl
ZXAgaXQuDQoNCk1pbmcNCg0K
