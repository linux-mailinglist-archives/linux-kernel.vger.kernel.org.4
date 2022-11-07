Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80DE61E7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKGA2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKGA2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:28:03 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB163FA;
        Sun,  6 Nov 2022 16:28:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMamAYx7Hi8NU3tDf0HlDs7CEWFGZtrnbhek2kmN3egLIYxyexR1C9lD22FZQUxnLjfMGeYFoDkQwcOIxSgkDUH4dy+gxgh00Ql7NCpaKjNuj04IwalxT3SRiqp6jtjYlH+uQxHyASM5PzM9QpK5VUC44KB4Z5j41hhbW8HHmO1Y/g+JQ2eI5bfHtkPrutJp8NtE8xeP37yoj+ie6QQew73cGr7ejtlSfgxvDZ61F90uT/CozdWQuY6L1h4kyLG4y82ZektgQ32ENusGN3IYjBbIZ/q9lwk30QA1o2kMII/6RyD7raGgvH/ZsjgGFodmWZ36h/Q6V7sFXrQ6bgjG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6smTDKDGhMx7lE3OvxSrKxf/Pahx8bt6uP9Io9VdGo=;
 b=AlfOEI5aMg680Wp54Adp/rW+FK650UnsHt6clgwA0KcdSi3K4+jst9zVnsXGWZ4KNsEhZs7tcOLt3Pt+yo9mYCw7yZmkO/vp+zujxXw3PW2gc3oMTQs14sukLhiPYFTqWwv45Uq7sSXJyqzSqP+wErDUS9qcAH5P9X8ozNrJxpQ8q0zi+1ZbMLGHHiFz2lJdN2DxQzKuzlh5JyeDbtaG4Bic/acRYF/qfk9jaEtwc6ZzGhnud8+aQgnIlSY+pgqNEUIF5mtk6qpHtz2ZsUwxU1HD3Naf/jAfrNS1NRuJ52VMxjmf0uuKSuGQcuvazYxJRz+ljgPNn3YsjV5LM4yxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6smTDKDGhMx7lE3OvxSrKxf/Pahx8bt6uP9Io9VdGo=;
 b=AN9E3Ep0r4KiQbKjybA5SrCS4MJ+AdxeJBWrF7S6WdkIanb5B3xSVToiBKDi4vM1IylTGL3IlE83nN5zP5Ak/SvzRvBfY7JUgUEoX4kLJYdePxO8IDy4YTv3s7FlYSel3sMthZRrWOgcE8UBnDs2s5asZuBPsfl72nZU4lrcrWo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 00:27:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%8]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 00:27:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Thread-Topic: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Thread-Index: AQHY7qwGSZCShnOsAEiFFgQUaE6HCq4r5waAgADAqMCAAj7jAIADun7Q
Date:   Mon, 7 Nov 2022 00:27:58 +0000
Message-ID: <DU0PR04MB9417DF72B41F79CCF63823DF883C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
 <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
 <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221104152732.GA1873068@p14s>
In-Reply-To: <20221104152732.GA1873068@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7756:EE_
x-ms-office365-filtering-correlation-id: b8c354e1-d082-4d1c-bf70-08dac056ec27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcQM00Ma0GdB50D2T1KcJU2TSLJDxhjE3x1MC2kn04u/OtvKro+12J03vwjXIbRvf7I2rNkKWs3dJtLuWSqet1jV1qh12CEDxF2rfNAYq8BETXXw1rA7vCOhsnzCcRLuMd7MSOcdfhjjSJm/D+REqx5l4RdtNaLV/GufMvHL4B3uR3mYBy0QgzaE9wDV4UJwrXJS9omuIGqNcZqH7X1l7c675rYCx7MlyI+mkY8LHN5eB4qRxtDzM083vLJl9380F/4EAzJAwpVdQi/f3nJo6ZCew75lW9bsNBA8/yzfZTAr1f0hyIlyuazjNI/0KhIqpgtV8ae7k3kDdnFhK7bR8qVb/HrAC9AjplGpLVxqMmg8GLWuMEkkudTJmDpLdGl02RLCKrzRpRZD47HuB+/mPuetQWaY96flfJ6oRrn0eIkkl+tj6u6Fu7hCYXDcGlbyoRNcxdLlf2NeDJaxRBAxCDnBiE9b797iTPN7YsLn8cX7tNWzSCrz8kLv/Y82masZWQvUHvKpm5CPvmHtWBAJ+4UrEIyjO06ix2ewonSGGQh1eN+pNl9oNHiyWTjPZrU7+S+AmX2mwC8IKezN+3dxHeaEnrqUpByC369qs+usTMpTie8kmdulAONrrilMbzI+g+6gTLLquyTTQEWPZ27M6N5E2VPR59ZK3v3nNIESlVeoTsleE3cF7/uypInhkW09kXk/6eMp1C87r5yESGjFfH4NB+N/EZ0wdd/PxGrnHmKKOBYZww182gR45Qv5cECWP7+5wSpmlatMhXBWOSrMEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(9686003)(26005)(41300700001)(33656002)(83380400001)(38100700002)(122000001)(5660300002)(52536014)(8936002)(38070700005)(2906002)(186003)(44832011)(478600001)(55016003)(71200400001)(76116006)(66556008)(66476007)(54906003)(66446008)(6916009)(64756008)(66946007)(316002)(6506007)(7696005)(53546011)(4326008)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SElJSEsxL1BhQ0NNSmd4VUx3ZHhXZ2R2d2N1YjNHN1U3QVJmcllWOUppeUVP?=
 =?gb2312?B?VlZ0czcwS0xhVGRDdk1iRVprbjNxaTVsM1RvRDloYU9Sb1NvVGM2YVlrcEl1?=
 =?gb2312?B?aThWQ1NrejRjM0RpdjRoaVM4TS9LK2pDeGhXckVmYkFZbkNmZHF5UUNvQlpY?=
 =?gb2312?B?a0NUUHd6a0NqZm5ZanVteXEwNWhINmh1Ym9vNGpGcFZuL2k1Qk9wWEc5andX?=
 =?gb2312?B?ckgrZEQyeGNxSDQvSG9zTjlhd1FzVmJZS2crRStLMUxCWkhiS3JBV1hJakw2?=
 =?gb2312?B?U1BybDZQUmNKdGFpbFc2eDFBd2E3UENsbHhXY1J5bUoyQkFvZHhXY2x6WXgy?=
 =?gb2312?B?d0w2Y0p2SXZnYngxTWVwaUFxMkZNWURJVXhYbjRQUk90RUZWbnVvNFMvbm1s?=
 =?gb2312?B?Ny9QZm5Ia0Jad0g1UklzMTNQdFJKZXU1RTJwc3BGZUltQUtFTDFTWjlKVXlw?=
 =?gb2312?B?bGpGUEhmQ3BtUW1KZVVSbkxjOC9ld1NwRUQwTDh6Y1dNaE9VVkcwN1N5TWhl?=
 =?gb2312?B?V2ZIblR5UU1ZbE14SUVkSkd6dS9aYlBtaXpNMlhSaFNudEtpUkdTOEhQeWw1?=
 =?gb2312?B?c2JIc0V0TXR5SU1hTmR2c0ZjaUJINGpQMlY4TE5LWmV6NXRSUXJHQW5mYWc2?=
 =?gb2312?B?czFMVE1yRWwyUU9CQTBheEJZOUY5SCthUm9aWHB2TFhPTHdFOFNJMDdDVUZM?=
 =?gb2312?B?dzlyNWZ0QWlKenhPMXBSNmxRTXdCTmVySVgwK2tPNGxNalZWUW4rTUV5Uldp?=
 =?gb2312?B?Qzd2a25wdWQ5UDRKOUNKMG9iYysyR0NHMkNRQlJjazFFTWxvNDBBUWhpSG8v?=
 =?gb2312?B?TmxkUG5aRGdHUzdLcmk4R3NYelQvNnllK0k0UGE2eWdVVHkzQmZrWVk0d2JZ?=
 =?gb2312?B?OHZvdlcwL2k3U0pmSzJ0WDAwZ0lnM2hmY3dJa2hZWFJQZE9ySExSN1JFWFFx?=
 =?gb2312?B?djNTSzZNWlFNVWtwT3RHS1JEQlhpSGtReHR4bGVuRlI2VjVMNGZrUm1RUjU0?=
 =?gb2312?B?d2Q3ZE1CZ1VmaFJyVWp5YWdML1JuKzZuWk9lbmxvVUNCcE9KNnNEWkhWbUNq?=
 =?gb2312?B?dW5BelVMNGVLWWVZTSs3aHVaczhyNVpubDBRRjFVT1dQaVJQTGJLYlNEeDdB?=
 =?gb2312?B?dmQ3ZG0vRll4ZFBXQTIwdURrSkVDanRHekFHWkl2YVdPYktMcTd5eTA3WFpT?=
 =?gb2312?B?cmw3cHpoWnJ3M3lCKy83ejNMR2hhQUNTbjFPNW4zNmFaYzlRdTVnbUMrNWsr?=
 =?gb2312?B?VUg5NVVpeHBEVDgxVDU0WHY3b2E0TE02WERkd0hhOHBKTWVpejN5ZzBWRTZu?=
 =?gb2312?B?eXordXM3OVFSVnZTUlNzV3kzYzNoLzhMVjNMT0xLQVd1UEMyRktTTVptOTg2?=
 =?gb2312?B?VkUvSGNWRENmWVJyTjBRYkliaDFDdDV6QTNrS0FzaUZBMWt5NkRCWWxvRlRH?=
 =?gb2312?B?cHp0czBuajJhb21nZFVWWVk1OWFlM01YMjIyc2dzU2ZkVkJoaWd1RXRLNnls?=
 =?gb2312?B?VWRYT1Y5TUI5ZC82b21mUlpJcEZQejhtZDAvRXdZS2pqZlBkaHRGYkNwTm1B?=
 =?gb2312?B?Rk9sbVpnTmFVQmhaT3ZYR3B4YlhkdFVVSGg2TDZObFdUcmI3UkhUT04rSE50?=
 =?gb2312?B?VTFUaE8xQzYrWDBWemFBM1h3L1BjTHNyWm5FMDdHU2s3VjR1MkZRRlhMTjA2?=
 =?gb2312?B?L3ZEK0tTeHpoSGpBKyt0RURWMU0va01mYUUwSlNySHpQS3N6RmFXMHpxMmd1?=
 =?gb2312?B?Rks2UWQ1V1gwc1ZpN1RlMjdOTnkzQUhFaU9ZVldnb0RHT2tDZDhQK3N4TXEy?=
 =?gb2312?B?dURLVjBwNGtaWVVjcDZuTGRQWm9QNXZvMk5HVFRMdDJEUlorZzY3NzB1OHQ0?=
 =?gb2312?B?cjRRT0xuR1A2K0JIa0VMVVYxWGVhbktwV1pmVzhwSkV3cXpveFJSQVMxQ2d5?=
 =?gb2312?B?S29wVUkxaHlqYWdqbjRTemFLOGhjayszMlFzcHhySE8rSUFYSVNIOXFKT1ZO?=
 =?gb2312?B?RkxYU3ZKaSs4aXpwdFQ5YTRjTS9PUkhIMGV6UTd6dVZTVkZreUhaWEFGcVlv?=
 =?gb2312?B?TE5pcjlXdFlFbjFSR0ozMlB1ZlVDRzgvclFTNE51cXc1T2VqbGw2ejJSVWUz?=
 =?gb2312?Q?Uwoo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c354e1-d082-4d1c-bf70-08dac056ec27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 00:27:58.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vHpAlt1Y06Sopu9sJWsxriJqtT+CrmYjqjnOMkrgoUmfySIOddFXk/yLZjwTJRQaQ4SVhFhfLJUmjAyDsboOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0aGlldSBQb2lyaWVy
IDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMsTqMTHUwjTI1SAyMzoy
OA0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiAoT1NT
KSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+OyBhbmRlcnNzb25Aa2VybmVsLm9yZzsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+OyBsaW51eC0NCj4gcmVtb3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBjb3JyZWN0IGku
TVg5MyBEUkFNIG1hcHBpbmcNCj4gDQo+IE9uIFRodSwgTm92IDAzLCAyMDIyIGF0IDA2OjExOjQ2
QU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gcmVt
b3RlcHJvYzogaW14X3Jwcm9jOiBjb3JyZWN0IGkuTVg5MyBEUkFNDQo+ID4gPiBtYXBwaW5nDQo+
ID4gPg0KPiA+ID4gT24gV2VkLCAyIE5vdiAyMDIyIGF0IDA1OjEyLCBQZW5nIEZhbiAoT1NTKSA8
cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJv
bTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEFjY29yZGlu
ZyB0byB1cGRhdGVkIHJlZmVyZW5jZSBtYW5udWFsLCB0aGUgTTMzIERSQU0gdmlldyBvZg0KPiA+
ID4gPiAweFtDLERdMDAwMDAwMCBtYXBzIHRvIEE1NSAweEMwMDAwMDAwLCBzbyBjb3JyZWN0IGl0
Lg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogOTIyMmZhYmYwZTM5ICgicmVtb3RlcHJvYzogaW14
X3Jwcm9jOiBTdXBwb3J0IGkuTVg5MyIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcmVtb3Rl
cHJvYy9pbXhfcnByb2MuYyB8IDQgKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcmVtb3Rl
cHJvYy9pbXhfcnByb2MuYyBpbmRleCAyYzQ3MWU0NmY0Y2EuLjlmYzk3OGUwMzkzYw0KPiA+ID4g
PiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jDQo+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYw0KPiA+ID4gPiBAQCAt
MTM0LDggKzEzNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3Jwcm9jX2F0dA0KPiA+ID4g
aW14X3Jwcm9jX2F0dF9pbXg5M1tdID0gew0KPiA+ID4gPiAgICAgICAgIHsgMHg4MDAwMDAwMCwg
MHg4MDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPiAgICAgICAgIHsgMHg5MDAwMDAw
MCwgMHg4MDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPg0KPiA+ID4gPiAtICAgICAg
IHsgMHhDMDAwMDAwMCwgMHhhMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPiAtICAg
ICAgIHsgMHhEMDAwMDAwMCwgMHhhMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4gPiAr
ICAgICAgIHsgMHhDMDAwMDAwMCwgMHhDMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+ID4g
PiArICAgICAgIHsgMHhEMDAwMDAwMCwgMHhDMDAwMDAwMCwgMHgxMDAwMDAwMCwgMCB9LA0KPiA+
ID4NCj4gPiA+IEJ1dCBob3cgZGlkIHRoaXMgd29yayBiZWZvcmU/ICBXZXJlIHNvbWUgU29DIHJl
bGVhc2VkIHdpdGggdGhlIG9sZA0KPiA+ID4gbWFwcGluZz8NCj4gDQo+IEFzIGl0IGlzIHJlZ3Vs
YXJseSB0aGUgY2FzZSwgeW91IGhhdmUgbm90IGFuc3dlcmVkIGFsbCBteSBxdWVzdGlvbnMuDQoN
ClRoZSBEUkFNIG1hcHBpbmcgd2FzIG5vdCB0ZXN0ZWQsIEkganVzdCB3cm90ZSB0aGVtIGRvd24g
YWNjb3JkaW5nDQp0byB0aGUgaW5mb3JtYXRpb24gSSBoYWQuICBJbiB0aGlzIHBhdGNoLCBJIGp1
c3QgZml4IHRoZSBtYXBwaW5nIGF0IGFkZHJlc3MNCjB4QzAwMDAwMDAsIEkgbm90IGFkZCAweEEw
MDAwMDAwLCBJIG1heSBhbHNvIGFkZCBpdCBvciB1c2UgYSBzZXBhcmF0ZQ0KcGF0Y2gsIHdoaWNo
IHdvdWxkIHlvdSBwcmVmZXI/DQoNClRoZSBpLk1YOTMgU29DIGlzIHN0aWxsIGluIHByZS1wcm9k
dWN0aW9uIHBoYXNlLCBhbmQgdGhlcmUgaXMgbm8gcHVibGljDQpJbmZvcm1hdGlvbiBmb3Igbm93
Lg0KDQpSZWdhcmRzLA0KUGVuZy4NCj4gDQo+ID4gVGhlIGN1cnJlbnQgbTMzIGZpcm13YXJlIHJl
bGVhc2Ugd2l0aCBMaW51eCBTREsgb25seSBoYXMgVENNIHZlcnNpb24sDQo+ID4gc28gSSBub3Qg
aGF2ZSBpbWFnZSB0byB0ZXN0IHRoZSBERFIgbWFwcGluZy4NCj4gPg0KPiA+IEluaXRpYWxseSB3
ZSBnb3QgdGhlIGluZm9ybWF0aW9uIHRoYXQgTTMzIG1hcHBpbmcgb2YgRFJBTS4NCj4gPiBEUkFN
IChvZmZzZXQgMCBNQikJRFJBTQk4MDAwMDAwMA0KPiA+IERSQU0gKG9mZnNldCAyNTYgTUIpCURS
QU0JQTAwMDAwMDANCj4gPiBEUkFNIChvZmZzZXQgNTEyIE1CKQlEUkFNCUMwMDAwMDAwDQo+ID4N
Cj4gPiBIb3dldmVyIHRoZSBpbmZvcm1hdGlvbiBpcyB3cm9uZyBhZnRlciB3ZSBjaGVjayBtb3Jl
LCB0aGVyZSBpcyBhbg0KPiA+IDI1Nk1CIGhvbGUsIDBNQiBbMHg4MDAwMDAwMCwgMHg4ZmZmZmZm
Zl0sIDUxMk1CIFsweGEwMDAwMDAwLA0KPiA+IDB4YWZmZmZmZmZdLCAxMDI0TUIgWzB4YzAwMDAw
MDAsIDB4Y2ZmZmZmZmZdDQo+ID4NCj4gPiBJIHVzZSBKVEFHIHRvIGNvbmZpcm0gaXQuDQo+ID4N
Cj4gPiBUaGFua3MsDQo+ID4gUGVuZy4NCj4gPiA+DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+
ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcnByb2NfYXR0IGlteF9ycHJvY19hdHRfaW14
OHFtW10gPSB7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzcuMQ0KPiA+ID4gPg0K
