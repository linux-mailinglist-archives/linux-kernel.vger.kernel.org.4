Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69361769F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKCGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKCGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:11:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D219284;
        Wed,  2 Nov 2022 23:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRt6sbZd2QiVJ++WMh5wQEmOLntqVNP0iFdyhtM6JyVnq3pdls95z6u8KGscQujAqv8NzOA7/xj5Gbnok55ZLeUa11o7IBnKePAX4+1+fGGLjW9kRVroGlLTkIwGIShtt7JCJmXMqLP6hBXT2u/VaglUSbMhwgghE603akPC0a4IpW+vxOHa7enhERAwDxpdrfnJr1zVwbZG00qeXuk8oDkzsihiHpvchlCypfZUuVhaLTMb9uxNbhjl+d6K0uRwhIoExphII836pJ965p0R7emZTXdQu1Dcn6M9f1QwlnZYZlUuY3rPee/uwZJyU9YIsSDPCfXX5pF9qR5BjFJPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69O2F9Tql6lvLic5Lr8qBQEABsyianT0cHNrv/p+c5I=;
 b=cDg/H6qrKnWTjW5UadJhS51jaRjCqCucMGMAB1EoV5QENdVnPFbYKJ0BGbPmy7RbSd1DaKAwB0qzRBIDgCkqUuYGzXJMMXhSkZr5P0gEJDOqLoy8obworF26elRg1Wg9r0weP8TvTla4OwICPQnQiiY8W4MDD7S243aaHwrV6SnwvgBMghEHpPmJvetIELuV/Z3P1zgv7h2sE93u+5MBZBFYWMF58W7Li0PBUTLrdsFFyMBmGwmqR3S5LIhz1JJZXiG9H2wrbsawdRMz/A9zg39VdOovTeP+qk9mFwtdXaYDoBFLhfbtZiZSC2PL/sPcjDSaTBhQV6a3mBV+nxepxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69O2F9Tql6lvLic5Lr8qBQEABsyianT0cHNrv/p+c5I=;
 b=PYiGrfm1zhEFvoE3SIz6MIXKIPFcveT1Rq1TF2xDcC65Vg/6Sy4CLgAlvQ0+5YP/ydriLMebhnM/9ZucFYXIwtUdrr6l8dhR8jKgt4vxvlNrpnDSlutCLoFHY/yHdX0xtl6xnyH5yPJ+FbE42gizNDpPabRvuRGJCZHBOu/zbX4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:11:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 06:11:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
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
Thread-Index: AQHY7qwGSZCShnOsAEiFFgQUaE6HCq4r5waAgADAqMA=
Date:   Thu, 3 Nov 2022 06:11:46 +0000
Message-ID: <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
 <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
In-Reply-To: <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8865:EE_
x-ms-office365-filtering-correlation-id: 6b40e3e3-1ad5-4047-389f-08dabd6249d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziEwyiGMtOUb8c3/WruRwaFKOfYrHD7gDpsUt5gXzFNBnhdAwNUkc36FCB5OE6UiJpVwKA4Zq4FGWnXRXQGitFbfzSgHZ2NfTd5hP3/0VfTXnae3f0t0B+gLAkbnl+De9uKZJ7spGbEHTLP9AZnSb84OhiEvBMjXQqeEB+Y4o5ho3OgxU6mC8wK8RCkHAv9TE3pEim+xucG0+hFiuaDImcjy+YNf+R6TomgpqfTGRr77qqZpqXVNQ65Nl78JLasjwaHawyNLD2XosokDRpI1qnw9MGrZC3RQnkfiXxdiKUpFSJJ9P8Me1tk7+2l83c1LFj/VeEJBFrxfZF9qyiGeq9uiHX0u4+fvIJLeE7D+i4jMNonrmAOlSn8YRQoOmv2FQQmWdDq1SK56C6dAEBkeWuSWwI5dYjeNCnVMIO6W4I6hhshD4udWlUdNqx/M7TLgsZ1td+r0WnYlTHIC3LH9T3EkQ0vuXxH1IVGRSIdc3ITKts1KqKPF5VYyPmiedfKkpk0LvjwVz9huL9d1WUzE6CwV0eJXTknojwc6Vsna3SAhD+uA6xPP/Az63/fWslShZIwVzpQ3USU4XAzvbw5yqtpUcS/2ApIQmWRNeBE0/bMOCj/AUcUChJwqANTQEkh5IGunqruCnsVBEy3Wjaq4gxiURIq227NMIvDVL41FIq9m+tgsnEJeGnBzcifupPMk9Tlex4U0oXVzQ5ML5zlK5giDawGimJcro8D6qlSaUvyoVODNwBlpv10vUVIW0smonBnybYCQQEGsDjHULGi6Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(26005)(7696005)(9686003)(6506007)(186003)(71200400001)(83380400001)(54906003)(316002)(110136005)(478600001)(38100700002)(122000001)(38070700005)(8676002)(52536014)(55016003)(44832011)(8936002)(64756008)(5660300002)(76116006)(66946007)(4326008)(66556008)(66476007)(41300700001)(66446008)(2906002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmZBN2JHbUgzanEzNFFrTzIwMkRtcys4d3lrNWNOVEJjdElva0t4WEUwY2Vw?=
 =?utf-8?B?dHk1NHl3TWNZSkpCRG5nL2xiendTd2c3Y1FRU25Nc1Q1RmNSTG55ZkdFOVJ3?=
 =?utf-8?B?MGdCK0RTVnNQOVdMS0lvKzQwYTZIQWVTL2lLMEJwNTdIQzBLUG9pcmNPWisx?=
 =?utf-8?B?a3E2ZFRnSkJRT3BtSTdtNXRHUTZMZkhnT3EzbExGZWI1Q28zcDFrT0dROXVm?=
 =?utf-8?B?NW9kY3g2SjVGZjhYQlZLZzgxYVBwMjhmdUUvenVrZ1RBc0RqdXZkN2xIeVMw?=
 =?utf-8?B?M2VUbWhYUjBKQjg1bCtJRFZUYVBMeS9OcXIvN20xRmRIeTJmZVdJSzVwZkth?=
 =?utf-8?B?di84ejl3bFY0eTVTemlUYTB4cGN5MmlnbTVmL01BbkZkOXVmam1jMlZCWWVI?=
 =?utf-8?B?QlJCckc5d2hsZEFGOXpPOHMycCtSRERFZDRRdkFGRi81cXI0dkcvT2kxYW1X?=
 =?utf-8?B?bW0wRC9TeXFmcjl5ekRxVXhiNG5jS2ZHWm52OGtJWVJvSEttWkUvOVpJRDJW?=
 =?utf-8?B?aHNBN2JxcXNvUHBPUVd1eVppd2x3bFJlVDRWOFdPd0syblJtK2hUb3prOXRW?=
 =?utf-8?B?S0tpdUpBdWhxSGxSRmsyNGUxd3c5OU53a2RQNUxlN1NXMThUUUtiLzNwYm5U?=
 =?utf-8?B?QnRoamlsZnNpd214TEhJMERDU2k4OUt3dE44MU1DQ1hWa3F0MWdxS2syNTlY?=
 =?utf-8?B?bEU2MGJNYURrdlhWUEJ4R0wyL0o2SWVGR0h5VHFSN3YxWDdneCtqR2REcDk1?=
 =?utf-8?B?UTUyNnhuZkRGUU02elV6WnNMUDdFY29YRllCK0s4Q2pDdEJQSHRUb0R2NzdX?=
 =?utf-8?B?ZHZHUmdRNE1EOGpqK0VzK2pRTjJTTTZlSXYyT3MvQmZBYmdpVFdVcnR0Nmc1?=
 =?utf-8?B?TlNHb3lBV1ptb2hoemF1WjBXMjJLZ3hPVmx1UTA2SG5ETjJXTS9BSnRJQi9t?=
 =?utf-8?B?ZUVuTWM3ZjFDWWNCRGZuNE14QjgxV1orZno0anZ2aVFCOHk3Vy9JSGtmZTJK?=
 =?utf-8?B?NE1lSTVKcy9rYXAyL3ROdFcycjBNS3E5SVJ2a3l0WWFyWWJONTRLazVIR2hj?=
 =?utf-8?B?b3FSdXEzaGh6cnM1UTFEVTJRZytsY1g2c2JPcDdSc0RRL2VLMVMwSG92TG5T?=
 =?utf-8?B?c0s3K3RNWE1kQVlHTkR4dzlUYlp0WlF2ZU1vTkk5L0FCU2o2SWJnUlRVR3Vx?=
 =?utf-8?B?ZGlhbGw3aWUyOEJ0ajlMMi9CejFEM0RPQ1JNQ2tmSStlNXZIRkZzY0xVREFD?=
 =?utf-8?B?bzFNOFVLZ3lQcGVVV1ZPK0p1M0ZIRXMyYkJWTTQ0MTZQZTJLeGQ4VjR1RHcz?=
 =?utf-8?B?NXZaYnFoeWZLdXI5TUIwTk9mZ2VycDI0emFSbHNCRGhwZmVCNVRYei8zbUI2?=
 =?utf-8?B?Yy9RdjhoYzJnN1kwL3ZoWmlSUGQ0UXFIbk5WMmhvckluWkJnVjRScHY4K0tT?=
 =?utf-8?B?ck5tNEZqcXVOLytDWitWUmFUNTR4MnozTFRLdFViUTJkeGY5R2tmRFZpNHRl?=
 =?utf-8?B?WVh2bEdaRVZhcjJ2UzdUZHRNV2pLZkltZlBwNXhjbUhKMmR2VG1JcVh5UUVU?=
 =?utf-8?B?WXFpMXErc21jdHJEWFdobEdZM2tQWjY1aEM3ZUVKWGJyWEhWM1cwQTJpZVg0?=
 =?utf-8?B?TFpSZEZFU0dJejVjbEVKRkJobFlyK0Q5RHNaUnh5OG1XTU82MmJlUWJhakE3?=
 =?utf-8?B?Q0FKV3Q5VTRNdVlJd1loN3RTVDF3eWtLN3VsSWNYOG5QQnVuR2s4eVZ6dWdl?=
 =?utf-8?B?enI0RitUNXZQV28zNk9XU1ZiWEwxd1czL2F2RW5aZnFZYi9CMFYweWJrTlJz?=
 =?utf-8?B?TmtRa2NzbFJiMzFWSEkzb3lQVTU0UGJJYW1iVDl3UjExNDhzT0pra2RqVzNV?=
 =?utf-8?B?RzFYeVh3dVNqNWdqOUlGaDJ2SGY2eUtMZFVvYk9TVVg1RmJEK1NjR3ZZYzFa?=
 =?utf-8?B?Z2RxU0pFa1NlbVlETnlnWU15SnJhdGtxTkF1U0QrWUY3dEMrVnA2UnpTaENU?=
 =?utf-8?B?bmg1cjhyYnNybGlXaEl4TlE0dU5POTRac1RnU2VDcldCK3RFVmhrcDA2aEpM?=
 =?utf-8?B?K3prQ0V4b1B2WDJTMUphLzhLOGR1cXhGOUJOMGVJRDdENkRYVjBmVkdkalVF?=
 =?utf-8?Q?mQ3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b40e3e3-1ad5-4047-389f-08dabd6249d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:11:46.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwHjVHLgluEbAoYzeqqUFec5HBs3nINq0dnabzw803Zcvl7KRZ05JvE82KK8wpMUeZ0u50qpl5Jli8l64KhJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IGNvcnJlY3QgaS5N
WDkzIERSQU0gbWFwcGluZw0KPiANCj4gT24gV2VkLCAyIE5vdiAyMDIyIGF0IDA1OjEyLCBQZW5n
IEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBBY2NvcmRpbmcgdG8gdXBk
YXRlZCByZWZlcmVuY2UgbWFubnVhbCwgdGhlIE0zMyBEUkFNIHZpZXcgb2YNCj4gPiAweFtDLERd
MDAwMDAwMCBtYXBzIHRvIEE1NSAweEMwMDAwMDAwLCBzbyBjb3JyZWN0IGl0Lg0KPiA+DQo+ID4g
Rml4ZXM6IDkyMjJmYWJmMGUzOSAoInJlbW90ZXByb2M6IGlteF9ycHJvYzogU3VwcG9ydCBpLk1Y
OTMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMgfCA0ICsrLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiBiL2RyaXZl
cnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYyBpbmRleCAyYzQ3MWU0NmY0Y2EuLjlmYzk3OGUwMzkz
Yw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYw0KPiA+IEBAIC0xMzQsOCAr
MTM0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcnByb2NfYXR0DQo+IGlteF9ycHJvY19h
dHRfaW14OTNbXSA9IHsNCj4gPiAgICAgICAgIHsgMHg4MDAwMDAwMCwgMHg4MDAwMDAwMCwgMHgx
MDAwMDAwMCwgMCB9LA0KPiA+ICAgICAgICAgeyAweDkwMDAwMDAwLCAweDgwMDAwMDAwLCAweDEw
MDAwMDAwLCAwIH0sDQo+ID4NCj4gPiAtICAgICAgIHsgMHhDMDAwMDAwMCwgMHhhMDAwMDAwMCwg
MHgxMDAwMDAwMCwgMCB9LA0KPiA+IC0gICAgICAgeyAweEQwMDAwMDAwLCAweGEwMDAwMDAwLCAw
eDEwMDAwMDAwLCAwIH0sDQo+ID4gKyAgICAgICB7IDB4QzAwMDAwMDAsIDB4QzAwMDAwMDAsIDB4
MTAwMDAwMDAsIDAgfSwNCj4gPiArICAgICAgIHsgMHhEMDAwMDAwMCwgMHhDMDAwMDAwMCwgMHgx
MDAwMDAwMCwgMCB9LA0KPiANCj4gQnV0IGhvdyBkaWQgdGhpcyB3b3JrIGJlZm9yZT8gIFdlcmUg
c29tZSBTb0MgcmVsZWFzZWQgd2l0aCB0aGUgb2xkDQo+IG1hcHBpbmc/DQpUaGUgY3VycmVudCBt
MzMgZmlybXdhcmUgcmVsZWFzZSB3aXRoIExpbnV4IFNESyBvbmx5IGhhcw0KVENNIHZlcnNpb24s
IHNvIEkgbm90IGhhdmUgaW1hZ2UgdG8gdGVzdCB0aGUgRERSIG1hcHBpbmcuIA0KDQpJbml0aWFs
bHkgd2UgZ290IHRoZSBpbmZvcm1hdGlvbiB0aGF0IE0zMyBtYXBwaW5nIG9mIERSQU0uDQpEUkFN
IChvZmZzZXQgMCBNQikJRFJBTQk4MDAwMDAwMA0KRFJBTSAob2Zmc2V0IDI1NiBNQikJRFJBTQlB
MDAwMDAwMA0KRFJBTSAob2Zmc2V0IDUxMiBNQikJRFJBTQlDMDAwMDAwMA0KDQpIb3dldmVyIHRo
ZSBpbmZvcm1hdGlvbiBpcyB3cm9uZyBhZnRlciB3ZSBjaGVjayBtb3JlLA0KdGhlcmUgaXMgYW4g
MjU2TUIgaG9sZSwgME1CIFsweDgwMDAwMDAwLCAweDhmZmZmZmZmXSwNCjUxMk1CIFsweGEwMDAw
MDAwLCAweGFmZmZmZmZmXSwgDQoxMDI0TUIgWzB4YzAwMDAwMDAsIDB4Y2ZmZmZmZmZdDQoNCkkg
dXNlIEpUQUcgdG8gY29uZmlybSBpdC4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+ID4gIH07DQo+
ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcnByb2NfYXR0IGlteF9ycHJvY19hdHRf
aW14OHFtW10gPSB7DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K
