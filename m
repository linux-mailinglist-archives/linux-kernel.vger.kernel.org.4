Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11256F6A30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEDLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjEDLjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:39:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B410B;
        Thu,  4 May 2023 04:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjI+Et/fxPEbWcC5TymwJslWZSvRVW7vxT1ZtNmESOVzqiohg5bUU9Jp4PDDjWpIKQBfUppcvSxV6ynoqALzCk7M3ASjTOyGnIE+QVqIqL1OCmJQIh7Ej+WmBJ3uEEb7FK8428n8dOzgCXdaf0xtdrXklg9/HDj8DrSGvkfObqE4Lkw0rgsQLyMGDuKzPDkjtZopfOaYQpMqiLBNkSMkuXEbfif/pQ6b8gKhzwTwW4Ft+1+RIG0DapzZkHGkXezHDh1mxj52Q0Ya80IUHKqBQIyuqwGIi3eKDtdj/l9Qo4+zDYRFxadX37tmjJtpVvXZOncuPDZysFZekSfUqPK/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ZdzLeXlnFsO5c6S8RNnZeZJ3N13/5ULwpxBv1+vJg=;
 b=T6k2uf56GE256x8Y/TCVkeBiYPrcR9PA/vd9n+mhPf0VQfucjpOrrVQQEHjr1ASot4Cn5WgqM08H9LB8wlOHRyWW4P5FVTD3YV6LGu8Uew3UAEGvwDYdxCigFRcNzMlwMoic4HQ/Gj5bQ8jGwTFH6Uur2jdVEusoO+fzD/aINvKBNWwfBXnOLaXiyRRUyq+VaL8tnvd1e0KS2mbIHzao0QEwsWzHq3TjDrgHhClg3/PgopYGqnRuBBeGXZky19Ozw7JhEAarORe1aFHnRHzX/TzB/yTUuYwhP9B4gXTGjQN7ATnZEnQBIjfN02WhQEnZxukVrLkVGDSEXyCa2h6APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ZdzLeXlnFsO5c6S8RNnZeZJ3N13/5ULwpxBv1+vJg=;
 b=K+n2GT2avmqypUCXteeIxWBU3MteOgSw7F8t4PvRLZmDHmE8+t5TMfmmxlfmlZb2mT+jUwbguzv2vuhNnuQ0C8wXIC7IG7os703YQFw6TE4b1XH+HDvO0qlyzsCyaiSVJT9EC6WYMvwSXpelwLSMKEGDiefAzzKmxUexWeOh8Ns=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 11:39:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 11:39:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg KH <greg@kroah.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Topic: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Index: AQHZfmVsUoWhON65f0ewGxlg24Oc/K9J088AgAAAwyCAAATkAIAAAJXAgAAYoQCAAAoiwA==
Date:   Thu, 4 May 2023 11:39:49 +0000
Message-ID: <DU0PR04MB9417DCA40599A41CBB119817886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
 <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <517aecda-681f-ce77-08df-97738a865f96@linaro.org>
In-Reply-To: <517aecda-681f-ce77-08df-97738a865f96@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7044:EE_
x-ms-office365-filtering-correlation-id: 5b4c7b04-d1b5-4e38-82df-08db4c9444f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiC2sZ8NVDXRd96lzQAOeIQjY4foHCrmusHjMVsolORDwWFhsBMK0xYr6CMf18dygLla1l1osAeVlppIfhKIg2uQjZHWwTY0fyBSp72X+NrDcDTMkG+fPj6rpNAHvofUhxnjTtk/EQu9lLxTHsjjVrEYwblatvvH6pvnOdBV7mHHUa9kS0l28X9B1nEB1HbPZ8nOKcXnfAK/Z1vEAQOihy7uFkQ0eyYmpLjO2i78DupTT0D7AHDZ5ejxKuw5jG3LIdpERLrsiwN0IfKbDLg3CXjXp0ci3ClS8ccOn5NS6fl2c5OA/Qlf3ERsa2KGXd6hNZi2/ifRnbWZUCGhmk6z2GmH9mZogBbeNUDDXaLyt1A/m8YEGgGRm4YbSy71dY4AkwhuXDhA50t0qaedWJy3wcxwgBc2aMYfzbdP03sbCnCzbuY+mIa3MWJhq1ONTgyiKXpRovR0Ok0g/5yMFKSpibjJUzN4wR33yB430j2sgMXG+GT15R31GwBmxxqZ7xPRcOmXNkNFO6SejGSz1wRtBO+BO5qpt7DEQnNOAFLBSyRekH7laOpegaXHIQGqqy2K3nL0FY0bmXlZue/mMov9pgQ2mTwoQyrji64mRiYEdfcduVYvey0NQ4kcBjYpPoIT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(7416002)(44832011)(478600001)(38100700002)(122000001)(55016003)(52536014)(5660300002)(8936002)(8676002)(110136005)(71200400001)(7696005)(54906003)(6506007)(2906002)(86362001)(66946007)(66556008)(76116006)(66476007)(4326008)(64756008)(26005)(66446008)(83380400001)(33656002)(186003)(53546011)(9686003)(41300700001)(38070700005)(66899021)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uzl4dkd6MjY4N0Z0YTJybkVRUjgzZlpCckh3TTU5Z05jZ1hZSUd6SjNtWjRS?=
 =?utf-8?B?L2hXQktTci9OU2JRbVdXN01KRjNGempGOU51VHE4dFZteGZVMmhPbFRqR0Qy?=
 =?utf-8?B?T01DamFqcVZ4dDc2RjhxMFlPOU1zYUVscGNRRURWd1Z4LzlnU0hpODJmcFY2?=
 =?utf-8?B?ek1Ta0hEZTdlUG9iVFFtQW9nYmJqcm82cEpFaXlFSjJZRWVjNmhTZmVoOHRU?=
 =?utf-8?B?THpPOVI4L3ZmZWkwZUl3N2xkWFg5QkF6TDdZSyt2cG5pazlhRXVhSDZHMjQ1?=
 =?utf-8?B?SHlPamE2aG84Ui85MitVQVYrTml3aXB2cHVqUW9ZM25lMzBHZkxFQS8wcUxV?=
 =?utf-8?B?cXRBajdnSGtJUmZrdWhQcS85WHUybTZOeHorZ1Nwd0E2dUE4TE9vSE1pT1cy?=
 =?utf-8?B?USs2K2N0MDE5dExMY1FvQXNpTEQwQnlDUDVldkxwV0s2d3kzdzQ1NDBBd1Vm?=
 =?utf-8?B?Y3hEUWFHNGcwRms5a1ZXT1ltTkJJN1A0NUxPK1Zoeis2MXl3ZmhvVHVzV2l3?=
 =?utf-8?B?dThtckpIbno2Z1VmK0J0dGhmMEs2dXJFMzB3K1lyL1MrVTV2TkVFeE9LVEwy?=
 =?utf-8?B?eHZmUGdlcTUzTHJpM29peGg1ajA0dWVZOTJSQ2RSY1hWWHRhRVJyNU8xczI5?=
 =?utf-8?B?Zll1ekVmZFZIazVjNGxOWC9yczBmN2ZxLzVEcy84RDdMV3cybnJPZU9GemhN?=
 =?utf-8?B?Mm1vcC8xaFFZZUsrOUVhQkttRGYzOFR3Rzc4K0U5RmZhRmVPU2ZJcHV6MkN2?=
 =?utf-8?B?akZxc1Z4bThBQmlUQm84QTFkODFFK25oSmhycHArRW10VVRUdjJRcis2S3BT?=
 =?utf-8?B?SWdyRFdyYmJvYk9LcmVCKytBQ01IY0RWZHpHSXh1REl1bDRHSnlOYjJtV2VF?=
 =?utf-8?B?VDdsTCsvREE4UWlYMGVmUitCSElhSUZMR3ZFMTdaWnJ0YkdpcStZT2VWT21E?=
 =?utf-8?B?YitaWlhBbGFSQnFBdHBxU2gyWU5uWDJZVEZndnJRRlNJOU05Y0RncGpRRUhS?=
 =?utf-8?B?UnpLNkUrU0lzRnZhOFNHWFNmc3lzWjR3Ym43VUlhZ2RBSDJLckV1S083Qm1k?=
 =?utf-8?B?NTdRUGtsMDAvK1JoZVUrS1hyMEZMMXdlRzAxeml6M0ZNTFY3RExoYzd0Nll4?=
 =?utf-8?B?TnNEU1ZDSkd5RTQzdXJDZkl0b2p3bVlaaHFMd24yOHRnNjVGTmRneVJQNmU3?=
 =?utf-8?B?WVRIazRmelREQU1TeXdlUU1PbkpiZ00yVExSYTdsUWNpQU5jSUg1VHZPYWND?=
 =?utf-8?B?TTZDemhvUGVsSlJLWW5VcllJR0lOSXVZR0p3QmxKSFY1Y3gwWG5adktTNEwz?=
 =?utf-8?B?TSt4Yzd6UGFmZjRsekhkdVNUNmpzdW5Jejg5b3hZYlRUSHMxYkFWb21Xenps?=
 =?utf-8?B?Mjk0blloL0diVnNDb1V6U3JMS0U0K0xFM3pzY2VDMXpPaVNGL2JMSGJUL2ls?=
 =?utf-8?B?dzNPMzd2Q2xySDVCaFF0NkZGVzZabU1TUXExZ0ZPanNlcTA4T0xBZjZlWkEv?=
 =?utf-8?B?a0c4NmVNdE1Zbm94Y0VNc3YrdDJKejhHaXI4cjhKRW0vZXNuQ1JPa3poZTdC?=
 =?utf-8?B?dGRvdG9IT1huKy94OWR6dGJYR0YrRDZ6RkFQa3dBdW1kTU5uVUxGSUtaVEJq?=
 =?utf-8?B?ZmV6cDFRRTQxaThFUk9JQk9vekdka1VTbUhFMUVCN3VYSy9yazJXNVg5NGFu?=
 =?utf-8?B?QU8vSW15OTF6T0RiNmFRM2daWE90cXJvQXdqNytuYUdkRVUveGkreWwzK1lJ?=
 =?utf-8?B?Y3FzVFJHTWZIZVJCd3BkdUZzQWtranBQMnU5NWVPeE1GNnR4YjdLUVlMaEJP?=
 =?utf-8?B?S01NRG9udjJ2aTZYVGhDbnB1c2hVNm1Eeld3WGdJNGtRMktjeWt4M290RElP?=
 =?utf-8?B?SndCSmtnMGk2OUhCbUNpTjVEbElrdmJIcVdHV3d6a01rN0w4RmdTWXpUOThx?=
 =?utf-8?B?RDM3QW1FSTJENlY4RGM3MU13NzZnSVlUOGNFNGpUVzlDdG1tU1hLanpIaFAr?=
 =?utf-8?B?c3RSM3B4QmlkY0lRNC9oRWVZN2VUYmFmTGl6MG0xV000am5tc0xMMDhTb0Z4?=
 =?utf-8?B?Q2tIRS9JVmY0ckxqUzByMEZBNnlucUt2emRVQnl4VFA5YlpKV0hEb3BmVisy?=
 =?utf-8?Q?ghCA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4c7b04-d1b5-4e38-82df-08db4c9444f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 11:39:49.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXm87mvbbTduUuAWgJfgBMP5M74YHrgl0G2pPC0y2N15XfGgdN80AgqSLurorwB4IoMv6o9urar4F5qAt9TBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIz5bm0Neac
iDTml6UgMTk6MDENCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgR3JlZyBLSCA8
Z3JlZ0Brcm9haC5jb20+OyBQZW5nIEZhbg0KPiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+
OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4ga3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnDQo+IENjOiBhYmVsdmVzYUBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJh
eWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4gY2xr
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBj
bGs6IGlteDogaW14OTM6IGludHJvZHVjZSBjbGtfYnlwYXNzZWQgbW9kdWxlDQo+IHBhcmFtZXRl
cg0KPiANCj4gT24gMDQvMDUvMjAyMyAxMTozNCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IDIwMjPl
ubQ15pyINOaXpSAxNzozMQ0KPiA+PiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBH
cmVnIEtIIDxncmVnQGtyb2FoLmNvbT47IFBlbmcNCj4gRmFuDQo+ID4+IChPU1MpIDxwZW5nLmZh
bkBvc3MubnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiA+PiBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmcNCj4gPj4gQ2M6IGFiZWx2ZXNhQGtlcm5l
bC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOw0KPiA+PiBz
aGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7DQo+ID4+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT47IGxpbnV4LQ0KPiA+PiBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazogaW14OiBpbXg5MzogaW50
cm9kdWNlIGNsa19ieXBhc3NlZCBtb2R1bGUNCj4gPj4gcGFyYW1ldGVyDQo+ID4+DQo+ID4+IE9u
IDA0LzA1LzIwMjMgMTE6MTcsIFBlbmcgRmFuIHdyb3RlOg0KPiA+Pj4gKyBEVCBtYWludGFpbmVy
cy4NCj4gPj4+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBpbXg6IGlteDkzOiBp
bnRyb2R1Y2UgY2xrX2J5cGFzc2VkIG1vZHVsZQ0KPiA+Pj4+IHBhcmFtZXRlcg0KPiA+Pj4+DQo+
ID4+Pj4gT24gVGh1LCBNYXkgMDQsIDIwMjMgYXQgMDQ6NTU6MDZQTSArMDgwMCwgUGVuZyBGYW4g
KE9TUykgd3JvdGU6DQo+ID4+Pj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBXaXRoIHRoZSBjbGsgbmFtZXMgc3BlY2lmaWVkIGluIGNsa19ieXBh
c3NlZCBtb2R1bGUgcGFyYW1ldGVyLA0KPiA+Pj4+PiBnaXZlIHVzZXIgYW4gb3B0aW9uIHRvIGJ5
cGFzcyB0aGUgY2xrIGZyb20gbWFuYWdpbmcgdGhlbSBieSBMaW51eA0KPiBrZXJuZWwuDQo+ID4+
Pj4NCj4gPj4+PiBBcyBJIHNhaWQgb24gYW5vdGhlciBlbWFpbCwgbm8sIHBsZWFzZSBkbyBub3Qg
YWRkIG5ldyBtb2R1bGUNCj4gPj4+PiBwYXJhbWV0ZXJzIGZvciBkcml2ZXJzLCB0aGlzIGlzIG5v
dCB0aGUgMTk5MHMNCj4gPj4+DQo+ID4+PiBvaywgYnV0IHRoaXMgaXMgZm9yIGJvb3QsIHNvIG9u
bHkgRFQgY291bGQgYmUgY29uc2lkZXJlZC4NCj4gPj4+DQo+ID4+PiBCdXQgRFQgaXMgdG8gZGVz
Y3JpYmUgaGFyZHdhcmUsIGhlcmUgSSBqdXN0IHdhbm5hIGdpdmUgdXNlciBhbg0KPiA+Pj4gb3B0
aW9uIHRvIGJ5cGFzcyBzb21lIGNsb2Nrcy4gSXMgaXQgb2sgdG8gYWRkIGEgRFQgcHJvcGVydHkg
c2F5aW5nDQo+ID4+PiAiZnNsLGlteDkzLWJ5cGFzcy1jbGtzID0gPElNWDkzX0NMS19YPiwgPElN
WDkzX0NMS19ZPiIgPw0KPiA+Pj4NCj4gPj4NCj4gPj4gSSBkb24ndCBrbm93IHdoYXQgaXQgaXMg
dG8gImJ5cGFzcyBzb21lIGNsb2NrcyIuIFRoaXMgZG9lcyBub3QgbG9vaw0KPiA+PiBsaWtlIHBh
cmFtZXRlciBmb3Igc3lzdGVtIGF0IGFsbC4NCj4gPg0KPiA+IEN1cnJlbnRseSB0aGUgbGludXgg
Y2xrIGRyaXZlciByZWdpc3RlcnMgYWxsIHRoZSBjbG9ja3MgYW5kIG1hbmFnZSB0aGVtLg0KPiA+
IEJ1dCB3aGVuIE0zMyBpcyBydW5uaW5nLCBNMzMgbWF5IG5vdCB3YW5uYSBsaW51eCB0byBtYW5h
Z2Ugc29tZQ0KPiBjbG9ja3MNCj4gPiBNMzMgaXMgdXNpbmcuIFNvIEkgd2FubmEgbGludXggbm90
IHJlZ2lzdGVyIHRob3NlIGNsb2NrcyB0aGF0IE0zMyB3aWxsDQo+ID4gdXNlLg0KPiANCj4gQXNr
IHRoZSBvbmUgd2hvIGRlc2lnbmVkIHN1Y2ggc3lzdGVtIHRoYXQgc2Vjb25kIHByb2Nlc3NvciBw
b2tlcyBwYXJ0cw0KPiBvZiBmaXJzdCBwcm9jZXNzb3IuLi4gSSBhc3N1bWUgaWYgdGhlIGNsb2Nr
IGNvbnRyb2xsZXIgaXMgZW5hYmxlZCBpbiBEVFMgZm9yDQo+IExpbnV4LCB0aGVuIHRoZSBMaW51
eCBvd25zIGl0LiBPdGhlcndpc2UgaG93IGRvIHlvdSBleHBlY3QgdG8gaGFuZGxlDQo+IGNvbmN1
cnJlbnQgYWNjZXNzIHRvIHNhbWUgcmVnaXN0ZXJzIGZyb20gZGlmZmVyZW50IHByb2Nlc3NvcnM/
DQoNCkVhY2ggY2xvY2sgaGFzIGEgcmVnaXN0ZXIsIHdlIHN1cHBvc2UgTTMzIFNXIGFuZCBMaW51
eCBTVyBub3QgY29uY3VycmVudA0KYWNjZXNzIHRvIHNhbWUgcmVnaXN0ZXIuDQo+IA0KPiBBbmQg
aG93IGFyZSB5b3UgZ29pbmcgdG8gZGVjaWRlIHdoaWNoIGNsb2NrcyBzaG91bGQgYmUgbWFuYWdl
ZCBieSBNMzM/DQo+IE9uZSBmaXJtd2FyZSBjb3VsZCB3YW50IHRvIHBsYXkgd2l0aCBvbmUgY2xv
Y2ssIG90aGVyIHdpdGggZXZlcnl0aGluZy4uLg0KPiBNb2R1bGUgcGFyYW1ldGVyIGlzIG5vdCB0
aGUgd2F5IHRvIGRlYWwgd2l0aCBpdC4NCg0KQWN0dWFsbHkgSSBoYXZlIG5vIGdvb2QgaWRlYS4N
Cg0KPiANCj4gUHJvYmFibHkgQWhtYWQncyBpZGVhIGlzIHRoZSBvbmx5IG9uZSByZWFzb25hYmxl
IGluIHlvdXIgY2FzZSwgaWYgeW91IGRvIG5vdA0KPiBoYXZlIGh5cGVydmlzb3IuDQoNCk5vIGh5
cGVydmlzb3IgaGVyZS4gQW55d2F5IGxldCBtZSB0aGluayBhYm91dCBtb3JlLg0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
