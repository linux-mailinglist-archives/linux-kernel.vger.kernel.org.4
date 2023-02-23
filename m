Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04216A00AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjBWBfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjBWBf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:35:29 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AE2DE46;
        Wed, 22 Feb 2023 17:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHlMCl9b/4G0o0+lHcxKn1df1SfK1QfmVKg5qKlVF9ydZPMy957kHtKagXvcOV1+WQ5+jVxbTc7G+bIiP8nW1ucT1F/tj8QuWWDQwQA8w8c2KlYKpMieNeAm5o2Ph7Gpw1bIKc52Fav7CHCeufPNm2lp2epRvTptaVNesFBfsHwQ0A8hIsb+mPIHyC5pH5XZ4+jaK1u9r6ISt5N1bxPeF6zo/cFiTHQEW/0tT8Ti2ViLj/88Q4ULh2dUBTqvf6M+xXYMBEPeBrWX6NB0n07g7U5PyBqv2eFqMX4YyJvKPaTvYnWM5djDO+fUy8d1g7aZhnKarzs7gWFjR0VrHlPkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjp+WDIpIrTTn044vu6pQG792w5/jf2sMr86aH5k1p4=;
 b=ZC0u/hkciAssz4ddMRfRsOj405Ld2z/dwGf+i10hsUrS2EGJWaRmAgIgz230woevwTGZW9JN59/XFARmjMB8SqY0svW++b3wA92w353LUngqOOX0sh/pQZTBHfqX4DWwL8d4EEq30mqeMvWjT18dNrWrudKGb+z2dkGQ7HqLpyfxl8rgiiT/m0n6ay9lwrtzuP+9Ur6KOaCOX5jpz770X4QagQNaxVHkkBFCXooHlvLuyBgOH20zAL6Xwpn0CX9GLS9ph8Yqwfqpg6/ezn1pOLa0fsTgRNem1++yWRjlwccKHLfPTE0eNAEFEUe9lM4ByTPi2gumV/dfrQIqbxm7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjp+WDIpIrTTn044vu6pQG792w5/jf2sMr86aH5k1p4=;
 b=fxOtZ3mAluroHz5sVD4pm5nDs9PNH8sMVroNHOaHMHjkwVlY1emHkvSjQOqi+w6Z0fVm7eIuBc2rz+64W+r6i8HNZhnGR/03UT4KGpMbusAiVlFy2sQ2wPciv/3o7ljrngyNYf5NF83YY3GUxp0Pi1fwzl5kmhLGpGeG1l1YjEk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8175.eurprd04.prod.outlook.com (2603:10a6:102:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 01:35:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 01:35:23 +0000
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
Subject: RE: [EXT] Re: [PATCH 03/10] media: Add Y212 video format
Thread-Topic: [EXT] Re: [PATCH 03/10] media: Add Y212 video format
Thread-Index: AQHZFCDj5VcRTFDaMUmGmg/2dsxFea6ykYSAgCjrnwCAAKfv4A==
Date:   Thu, 23 Feb 2023 01:35:23 +0000
Message-ID: <AM6PR04MB6341339361DE0F2364F46D3FE7AB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
         <9aa51224d2c37cca5f1283532cb99f3c8251b120.1671071730.git.ming.qian@nxp.com>
         <93c8ae69-c765-f88e-23c3-9c6b8cf67b40@xs4all.nl>
 <605689aa181770ad6c7fca2a55967ab5fc5a3699.camel@ndufresne.ca>
In-Reply-To: <605689aa181770ad6c7fca2a55967ab5fc5a3699.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PAXPR04MB8175:EE_
x-ms-office365-filtering-correlation-id: f489b54e-8810-429a-ecec-08db153e3b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3cTtUR0UKxcGIF0qXCkwOf4k6UbIjp8a+s6d7eTnao4xyG0LMWrVjOicB6WDkGoxqsFaTFEQWS5Zee2JXtYSRPC7ndLvKCogy7qdR2i62tY4rH0r2OxKWeEvEnh3IG3OmIWBlp4hRR2vK2RkLgNldO5SjU4h+cUroJReTZc4hn0yTfy2ojtdkXdfjZze+ISifVaZdK4naWfd3T+qdn4ZUv+2Eaz0RnZbOKW3pXnpl+E9NHrvdjf25TmcYt9UD+onYIuZxwyxwoNhvMbop7eFkooMOpMODc+HGVm4mnBJEdnsJMvbRrxM2zdIntBwf/8CBGyuJhEeBxyV+Bctjp3VfMo8Zjd55sNJiS5XKyZ67Yca7Z2u5tjwZxZKehG28y53rZnwsAdRARt4R4zpEWnF8A+Wyk9hUyVn6AHIFfaHue+ZLzIH+w4HdZEDHBSdi1bcnOQXarCU5KFCTG24y9DZhX8koj2AS+TTX3TcOZxS2Pt3fer1S3UhGMA/Ts7Rq4hWSXXsbMJczvtsz6dlUPwP7bkV1NujFOF1yV+lYyJQvNE8bR4W8lZjCKGx/9gNQWzh2+wpHGVxFUCLmqIVDVN++Hz3WcEFzDrEj6esvb37SWRmAUZiF/EGR9iErpdkU86/e+AbgsPam48sCj37LS866E+X9wj3SezTqObZma+42zAo6Xwd2K6B+M3OI07flaNp76deVbIckp2C1YWsQMyMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(7416002)(44832011)(86362001)(2906002)(66899018)(38100700002)(122000001)(478600001)(71200400001)(7696005)(9686003)(53546011)(26005)(186003)(66574015)(33656002)(55016003)(38070700005)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(83380400001)(54906003)(110136005)(41300700001)(4326008)(6506007)(52536014)(8936002)(8676002)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVgzaFVKUEdTbEkrNG5DOXFPcTlXSHdzRmZlc0ZFeWJjZHh5N080NFNMQVdC?=
 =?utf-8?B?UURMZ0wxK1NLQmhGMi9RL05zU2V4bUJia1RyWEFsMmJxWE5TU2ZCZVRBS3Fj?=
 =?utf-8?B?RGw5MVRzYWFMRVluMDRCRWppRTh6NVljYm5HbHFUT2w2R0pVTGtTU0x6enpL?=
 =?utf-8?B?dEdRcEJhOFZJRjdBQ2hhWnVSaG5HRnN1OGQ0NEw2Z1BmSGVRcll0S1BOSDZY?=
 =?utf-8?B?Um5lODZVZGZHbW1LV0JjS3hMMy9GSEI0NllGUFZja2VYOUloWk0yaldsbytU?=
 =?utf-8?B?YTZpU2haYktDYjR2QXJiVmpobGdqNEIwR3Rzc3BuZlRQblpsYkZpQWtZY0NQ?=
 =?utf-8?B?RG1kMlUxd1FqOEJRZjVqMXNJWWtRWTc4cUhRL0s1eXJUZ3F0cDFpVnF3cmZy?=
 =?utf-8?B?ZGN5QXVYVWVNTHNjYTdGSmJMMjBNTjdJTHBiVmlrdGpjVU5Ub3FuWUlpRGZa?=
 =?utf-8?B?OFBiclB3NGpMWUpjMmE0a1hxTkRBL3ZIZkhrZDVRUktGc0diZ3F5THJtcUYy?=
 =?utf-8?B?T1A0WVhKY3kvUzA5UUEwblNXTlE4dzFsUFN2bkRUZ1FTL01HZjhrY3MwTWpy?=
 =?utf-8?B?L1EzQUdBSFc0WHJ3cThxTEJRbEtzV2VybllaQ2NaNWc3Q0ZTVE12blJ2Z0J2?=
 =?utf-8?B?bEhmZFJxVDlJK0czUURYV3ExYUtEVVBUL2Y5dUdkOWxqYzFJRDNjdFRBRTRn?=
 =?utf-8?B?bTAzakk4NGliNGZ4bnB4QkhMK0tSTEVpOUNCVHBNb1dzbUZGWW9IOTRzNlZ1?=
 =?utf-8?B?Z2FVcWpOMWpXdnlzam5naEZ4WFFZMHJBU2lRUTZuRDJHZ1hNZFpWSDNCUzh2?=
 =?utf-8?B?Z0xwSEtBWHNVR1BOMXNiYjlpZVZqeTVjbU9nZFhhL2lEOHJZTXNTRkZSRTV0?=
 =?utf-8?B?dE4vSUpZL29iUDBVU3JVNStEMkovK1hWSG9GRzZBWUZzUjh5SVRrRVUrSjhH?=
 =?utf-8?B?d3R0algvcDRLanJ1U0QwVUY3b2t2NWFEVmgzZ0xDNEZSV0pBc0VSRUxxMUw4?=
 =?utf-8?B?Y0xjY1ZFSWFOR3NkSmkzUDRZaERZUEJuMjAyRHBzelN6a0VUWjcxYUhDWXBX?=
 =?utf-8?B?dDRaQk1TS2RraFFiS2loUWU4VE1oRFRpZ1ZHK01SS2YreUdteEVGNE9tTkdr?=
 =?utf-8?B?Skd3QUlpRWZyWXlLWi9hbFZBYS9KY1lLSVp1aEpxMXNESFNtYVNGZS9PM3Ro?=
 =?utf-8?B?T1NmbnJDUUNnZkVBU0lmVkNicVM0STZHLzhrOEtKaEVoWlYrTzVua3NxMnBk?=
 =?utf-8?B?ZVhwa2FBc1g2VmxSaElyU2NGcDE1OVZnQlZPUWNuTlZJZWdpLzB1em90eWtB?=
 =?utf-8?B?ZVN3cExENTFKRTcvSXZRMFJIeGt1VXFDLzVFUEVJZnowK2JYYlBoNEJIcDJ3?=
 =?utf-8?B?RjNUU0RYcUgreGpWZ08vZituY2k5Q2xWNTVYQ0ovZmlRL0lSbE9ERUlFcmFR?=
 =?utf-8?B?V2ZsL21SLzFndU1RemxYblBTdzJjRU1DMWU1a2dMdEcveUEwbzNPRCsySHpS?=
 =?utf-8?B?WHR6UVdOazRoTjhxY3VXcWtkcG13N25wK1A5RFNWbXZJVjQyblRrVlRkTVB6?=
 =?utf-8?B?bHFFd3haQ3ZWSmtuUVpnR0lnenpEUzI0RkVIWll0MzlBajRkdVBYT25CbUpi?=
 =?utf-8?B?RnNEM2VCTnlBVkFlanFaa2Z1SG9lR1duZ0dTaENuSThTVmQ5Y2M5QzZkc2pR?=
 =?utf-8?B?dm5rOWswVmMvRU4wOTdBMXN3amFBSzRPTllieHA1OFdGZis2T2NaelNiU2ZH?=
 =?utf-8?B?YjFNUFpqNUFtT2phZVBTcDlpWVFqMXVNQWc3U0dnaVdQTEI3UnZuODFDR2Fh?=
 =?utf-8?B?Y2tlaTRUN1hOSW1NUUxGSStjbXBsRk80SjAyeFdKZUNRQTFSc3JJRlJRbVdh?=
 =?utf-8?B?S09ReDh1Z0p6SkF2aFJkMC9LRzE5Z3FrN21jRWp2VWFiOGJIeEI1dk13dkly?=
 =?utf-8?B?NXRSVFlRSlQ5Q3Zoa2lJUnIwcEx1ZGdndFpJdGdneVlTTklXazM3R2lTQkhS?=
 =?utf-8?B?SlJTUjZ2VXZ0OG91dG5vN1M0YVEvM0F3d3puWWxoZ09QaklnTGg1NndubEdH?=
 =?utf-8?B?RDlVeE1uU3F4RngxYUFOL0tocmJiVVFZUkVjRWhmQ1lTVklaSjd2S25odmVQ?=
 =?utf-8?Q?dN9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f489b54e-8810-429a-ecec-08db153e3b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 01:35:23.3401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3rnaIaXqz6J01TGtUW7Zc+K5nhCpS04c702/1G4IuMlGkjjn9PRL4hr5bQ+nf1s71yBlV597cEnpFqySrr8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTmljb2xh
cyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVzbmUuY2E+DQo+U2VudDogMjAyM+W5tDLmnIgyMuaX
pSAyMzozMQ0KPlRvOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD47IE1p
bmcgUWlhbg0KPjxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsgTWlyZWxh
IFJhYnVsZWEgKE9TUykNCj48bWlyZWxhLnJhYnVsZWFAb3NzLm54cC5jb20+DQo+Q2M6IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj5mZXN0ZXZhbUBnbWFpbC5jb207IFguSC4gQmFvIDx4aWFob25nLmJhb0BueHAuY29t
PjsgZGwtbGludXgtaW14IDxsaW51eC0NCj5pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj5kZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCAwMy8xMF0gbWVkaWE6IEFkZCBZMjEyIHZpZGVvIGZvcm1h
dA0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPkhpIEhhbnMsIE1pbmcsDQo+DQo+TGUgdmVu
ZHJlZGkgMjcgamFudmllciAyMDIzIMOgIDE1OjM3ICswMTAwLCBIYW5zIFZlcmt1aWwgYSDDqWNy
aXQgOg0KPj4gT24gMjAvMTIvMjAyMiAwNDoxMSwgTWluZyBRaWFuIHdyb3RlOg0KPj4gPiBZMjEy
IGlzIGEgWVVWIGZvcm1hdCB3aXRoIDEyLWJpdHMgcGVyIGNvbXBvbmVudCBsaWtlIFlVWVYsIGV4
cGFuZGVkDQo+PiA+IHRvIDE2Yml0cy4NCj4+ID4gRGF0YSBpbiB0aGUgMTIgaGlnaCBiaXRzLCB6
ZXJvcyBpbiB0aGUgNCBsb3cgYml0cywgYXJyYW5nZWQgaW4NCj4+ID4gbGl0dGxlIGVuZGlhbiBv
cmRlci4NCj4+ID4NCj4+ID4NCj4NCj5bLi4uXQ0KPg0KPj4gPiBAQCAtNjE4LDYgKzYxOCw3IEBA
IHN0cnVjdCB2NGwyX3BpeF9mb3JtYXQgeyAgI2RlZmluZQ0KPj4gPiBWNEwyX1BJWF9GTVRfWVVW
QTMyICB2NGwyX2ZvdXJjYygnWScsICdVJywgJ1YnLCAnQScpIC8qIDMyDQo+PiA+IFlVVkEtOC04
LTgtOCAgKi8gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1lVVlgzMiAgdjRsMl9mb3VyY2MoJ1knLCAn
VScsICdWJywNCj4nWCcpIC8qIDMyICBZVVZYLTgtOC04LTggICovDQo+PiA+ICAjZGVmaW5lIFY0
TDJfUElYX0ZNVF9NNDIwICAgIHY0bDJfZm91cmNjKCdNJywgJzQnLCAnMicsICcwJykgLyogMTIg
IFlVVg0KPjQ6MjowIDIgbGluZXMgeSwgMSBsaW5lIHV2IGludGVybGVhdmVkICovDQo+PiA+ICsj
ZGVmaW5lIFY0TDJfUElYX0ZNVF9ZMjEyICAgIHY0bDJfZm91cmNjKCdZJywgJzInLCAnMScsICcy
JykgLyogMzIgIFlVWVYgMTItDQo+Yml0IHBlciBjb21wb25lbnQgKi8NCj4+DQo+PiBUaGlzIGRl
ZmluaXRlbHkgbmVlZHMgdG8gYmUgcmVuYW1lZCB0byBwcmV2ZW50IHJlcGVhdGluZyB0aGUgJ1Aw
MTAnIG1pc3Rha2UuDQo+Pg0KPj4gSXQncyBhIFlVWVYgZm9ybWF0LCBzbyBwZXJoYXBzOiBfWVVZ
Vl8xMj8NCj4+DQo+PiBZb3UgZGVmaW5pdGVseSBuZWVkIHRvIGhhdmUgJ1lVWVYnIGluIHRoZSBu
YW1lIGluIG9yZGVyIHRvIGRlYWwgd2l0aA0KPj4gZGlmZmVyZW50IFlVViBvcmRlcnMuDQo+DQo+
SGFucywgaXQgc2VlbXMgeW91IGFscmVhZHkgYWNjZXB0ZWQgdGhpcyBleGFjdCBzYW1lIGZvcm1h
dCBmcm9tIFRvbWkNCj5WYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuK3JlbmVzYXNAaWRlYXNvbmJv
YXJkLmNvbT4gLyBbUEFUQ0ggdjMgMi83XQ0KPm1lZGlhOg0KPkFkZCBZMjEwLCBZMjEyIGFuZCBZ
MjE2IGZvcm1hdHMuDQo+DQo+VG9taSBvbWl0dGVkIHRvIHVwZGF0ZSB2NGwyLWNvbW1vbi5jIGZp
bGUuIE1pbmcsIGRvIHlvdSBtaW5kIGtlZXBpbmcgdGhpcw0KPnBhcnQgb2YgeW91ciBwYXRjaCAo
YWRkaW5nIFkyMTAvWTIxNiBzdXBwb3J0KSwgdGhpcyB3YXkgd2UnZCBnZXQgdGhhdA0KPnByb3Bl
cmx5IGltcGxlbWVudGVkLg0KPg0KPk5pY29sYXMNCj4NCj5wLnMuIFdlIGNhbiBhbHRlcm5hdGl2
ZWx5IGNoYW5nZSBvdXIgbWluZCBhcyB0aGlzIGlzIG5vdCBmaW5hbCB5ZXQgSSB0aGluay4NCj4N
Cg0KSSBzYXcgdGhpcyBwYXRjaCB0b28sIGFuZCBJIHBsYW5lZCB0byBtYWtlIGEgdjQgcGF0Y2gg
dG8gYXBwbHkgdGhlIFkyMTIgZm9ybWF0IGRpcmVjdGx5Lg0KQW5kIEknbSBnbGFkIHRvIGtlZXAg
dGhlIHBhcnQgdGhhdCBhZGQgdGhlIG5ldyBkZWZpbmVkIGZvcm1hdCBpbiB2NGwyLWNvbW1vbi5j
DQoNCk1pbmcNCg0KPlsuLi5dDQo=
