Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B50740451
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjF0UJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0UJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:09:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F201B2;
        Tue, 27 Jun 2023 13:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKCuyp9zO/NEBRirqSx2HFu0rh4MtM0zheTOB0NbQhdH9RSX4UMtkhlni6lQsIAlGKVoGs++HEN3pvvqy59ZvJl9p8gu35YkG61jWdNuT8MYFgfBT/J3QyMPhciLFr5AHneE/LeM+ypNlgR/fVKgNV66Zr8XMAlE+e4JbJFuEnUzbmC5Yhpl6KI+diemfLUkUwpp0GF8DohWyKSHMKSFccv+toBKmoAVf95MsfdnsCAjFIBDA0guXIXZ2WsxHxwUehebPHiAMCx8N0Iz/bk5nBIRSekyj924QbpJfSfyXvNcLgbFQrZfAmWILfFyKt9RUMFrfdziWtM76776yWOddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6Efy+b6J3t55wn0J7a19Jz9DDEMgNiua+Svbweg/NY=;
 b=aNnxp2rJpgAwblvZeTXt9vW6Yp6unZhn6CVeqJv+uysyr2Gu+d1ss9fb7j6njZ4PMlOexyp99ITuR0Esp515Kzgkl/+Dy9sU/Y5BLbj3A9+9gP6yog3Bzo6gIeLA1aTbLT2d3oZfYEBjUrFIxMlVlhajR0jnjN6G12flfGOaU1aUS4m0Eq2OPZn6mmptqjMsr0/QTuq1o0f0Tn+vfItxbFuJ+goMv7bLsS2YzXOCTYEnqch4i6P0KX3wIxNpl4PGVtBN7FKokujgJlrvObPNgU8JasCgHw9SL3klobV7hT1P+zB4uFFqVYl+23VPIcPe+O0/WOqGqGHr/YCIu8voeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6Efy+b6J3t55wn0J7a19Jz9DDEMgNiua+Svbweg/NY=;
 b=K7vdn/AlMdtGSxKTp25XiqdStXY8KEMp7raXr/fuHAK3Mdm6PeauValocBqK01ibMaxfoxeqRJjLYqf/2StDPVc6K+LURmHghvnE0AWieRcd9yKABiK354zvt/pEcEzHkLkKJ8f9cGxWw+ZG7QMcQ49JgUeXkUXsl+afwEWZlOo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5553.jpnprd01.prod.outlook.com (2603:1096:604:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:09:28 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:09:27 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 5.15 00/96] 5.15.119-rc1 review
Thread-Topic: [PATCH 5.15 00/96] 5.15.119-rc1 review
Thread-Index: AQHZqF18u/XiF6dPXEGWw1TmwAA+wq+fD52Q
Date:   Tue, 27 Jun 2023 20:09:27 +0000
Message-ID: <TY2PR01MB37887F4FAACD50A3EB7D1F39B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180746.943455203@linuxfoundation.org>
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5553:EE_
x-ms-office365-filtering-correlation-id: e3e94e11-aad1-4590-05e9-08db774a6923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uX9b2zfsL0tc3u01SUJx1Gf5wDJj8Ws8XJ6I2QsSsDQuYo2xDLKBmkG2/gy+tAQwmC3FJ38d5i9r2PBptBH4IbQXESOZWpjdaPf1m651aqTLh8Wc1QJ7KyMTmeKlcvBK5hgvek86srhZ3hmdaEwEaXMvkeAsmpbz2AA/JiNsHEPEns6dQTg2Yxge8YHoz0MFuERC4l6AVu8VyVfralJRQmKtB6Ukxuwd1d+3iQeduSgnKIMyk3Bhr8OM4ndTVHFKHzllUFmyRvbsORYg1q0NAKcLgX4xOcAfbPsgAXvWEoXpUXfCWdjx9X+vNvZ+zAr2qS+89BaH1cQfBZO3dLO0u94GHj6eFqYQmlH5HWuuMSziCyAXc3NR8nCz+P5zVnnCG87PqnwSIULH7m84TgiJiK8eAE+pa8T5RjQGqQ8DFaRSDX41IWjXGGj4rFyNgbwpAa3v25entvdWkukAEV0KWH/RQRr36qIXo+O4A1eKhGki04zfUQ7idoYp12gESpWqIgK6dJJYAg4SkIzcg3HY++8o/UkC27xFqTxGvQr6Xygktlqsj13DNQTR6s9U80BAsbZjUK1/JgNgCV6haYcGJdVE4CdK4mvC+E5INUu9tlO1uKPEXYQ0CMBUUGdJq20RQTvvKwfnTj6S8BJLtz95zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(55016003)(76116006)(66946007)(66556008)(66446008)(316002)(64756008)(66476007)(9686003)(4326008)(4744005)(6506007)(186003)(26005)(110136005)(7696005)(54906003)(966005)(41300700001)(71200400001)(2906002)(52536014)(5660300002)(7416002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2FwQ1B6MVZKOU5nRjN6eW5nSk9OV1pBczRNWlNBdXFyeU9iM0pyVVBOSzZC?=
 =?utf-8?B?N0V1NGVpeTg5YUZWaW5jZlFBbCtkSmdPM1Q5YmswRzZ1RTBVOCt0RWpvWVNY?=
 =?utf-8?B?WGxDQVdQMFJ1cFQ0QzJjZ3BCUXFpcFBxbVYwME85dEJqSXVJTGFzUS9qeFVL?=
 =?utf-8?B?YWZXVmlzelRrR0s4RXY5T3dVa3F4aUFOQUN3a2FhOW9sL2tId2dIbEc5a1pj?=
 =?utf-8?B?cThXVzNLZ0Y3WVZjMEhXcWFBWVl6QWlWRDk5K3NDbzVPcGs5bEYyRkNEbXI1?=
 =?utf-8?B?SEFSa2xWRDBrSjhtSUN2dDQ0WUVHOXN2MWJiOXp3WWdJY2tyVENmWGZtZnVU?=
 =?utf-8?B?NFRSSzVlS2ZjcEQyeXR2dEdoZS9lOGFQSlBRSUlHa2ZnM09Xd2hIQlRHcjE3?=
 =?utf-8?B?V2pWNVd4djFpYmUvck1GOGZ6czVNYk54MHQxazVQWXB0aHdRYjR0YXE5dmM1?=
 =?utf-8?B?MHgrV0hoY2c1L2pObnJQbXVGTVBKMTQwMjdxdGRvYk9sV3hjdUZQS2VqR2Fm?=
 =?utf-8?B?MVY2YkkyMWdJM212aHRKWVBZRDgxLzNkeU11RThuYkUvY3BWbVlZUXNRMDFr?=
 =?utf-8?B?czVMZFJ2SStDWFlNS241RTRnMU5BdTl1Z1kwMjhxUklpZ3hFVDk5WW1LQi9z?=
 =?utf-8?B?TGcxaFNWVXV0YnhiSEtyY1MxSnRVTHVYMTdtcExieCtMUnBZbEV4amRVV3Rh?=
 =?utf-8?B?NWVnQU1BWGx5dEttMDVHSjNONmZPRWlTQ0I3UHlJanliNU1EL09USWplUXBu?=
 =?utf-8?B?VGYvNmoxS0QvMlhHNmxaaFl4akdpVUJQNjVrdlkyckh1ZERYT0hVWFM3U2l3?=
 =?utf-8?B?NVlaYm5YV1NTTVh1b2ZtdUVmRjVOWU0xNk00U1M3MEk4aHlmMVgvalhwajBq?=
 =?utf-8?B?b1RGKzNNbC9Gb0ordlROVmJab2lYMGoyTW5DSkxqZ2hDTndsM1RLK1J5aDRk?=
 =?utf-8?B?MFd0a205ZlRQVEpYTjk3cmFiWk1aTVlSa1NUVFZZdVpQTzNtem9QRGRYQjVj?=
 =?utf-8?B?c0gxTnErckg4M1hvWGhoNkU2cTc3YTZPbjVSNmFzM2hoY0I2YmU2NEF6ZVFN?=
 =?utf-8?B?T2VXTGFlVUhXTEtTTmdkMzhsRjJrRFFZUGhMdDdRUGFyMnRLSjcxWlhiRUJI?=
 =?utf-8?B?WDdPd21iTXk4Tm9uU2l1MTArb1haaktZOEtmUzBzUk9nSDdOZEpoeGlrM1U5?=
 =?utf-8?B?bi92RWlKVGNVYWhLOVFNaXVvbUVtOXh6dlNyR0tUZk1JV3FmdmVrZjdwM2ow?=
 =?utf-8?B?VWY1d0dQN095MlAwUkdjKzlqM1ZxUDRqd09DVVhlUElxWnptT3hlRTM0ZU8x?=
 =?utf-8?B?ZU5mVFFSU0pvRDNtZVUvZVlISkNNSlBITWtnNk4wRklMU0NLSDYvNWdCN3Rh?=
 =?utf-8?B?RndQQUJhMWg5eFBYa1Z4aTdBdVhMUHVQWmtGVjlxZnoxUGZFYjYyZmc3Qnh0?=
 =?utf-8?B?amVwYTFLb3lySnFoeVlXY01nTjZXUmtJQlRadVUrdm9EaDhiWmtkL2Nqcy9Y?=
 =?utf-8?B?cVZxSlN3K3BQZDM2ZklPVEpMalBTc2EvWk5JRjkzY0x1aVhnck1zaCszUjlT?=
 =?utf-8?B?eWZMek0wYlYrVDVTbFdBc0QrMkFVeTVtN2ZwbjNhTkYzdU9nSWYwL1ZRUE51?=
 =?utf-8?B?ZjJMTURERExDZnlWS1RobCsyZVFXZWFNcG4vS082VEN0TnE3bXBjRjRXbVdj?=
 =?utf-8?B?STlKOXgzVGpyRjdlZkJzd2Zrd0x6dUVNZjk5NUhnUzVqSC9xeU1xWHBGdTI2?=
 =?utf-8?B?azl3ODhGcnhyR1h0WHlUWkFzY2laZ0NDa2tYOGszR3k4clNLU2lkdGIvQlg1?=
 =?utf-8?B?VGlEL3huekxmZCtiYkNRRzlXN2tRL3R1YTdSNzlIY0hoWnRjcEtaaURmV2w5?=
 =?utf-8?B?Z05pbG9TRmJSQjBrSnh0L0tuUXNFL1o3MDh1bjhLOTZRazZwU21mSzVBU1Bo?=
 =?utf-8?B?V0hXdkk3NnVxTXlSNDdQYzFHbFZTS0J5R1UxKzJ6Z1R0UVErK1g1KytRNTBZ?=
 =?utf-8?B?SGR0cE5uN3NuSk1uOVNsZStpT1IrU3NqMGVSQ2kyTnUxQlhVWXM3VkZZTmdB?=
 =?utf-8?B?MGNZS3YwaG9XdGhudW1wQWZyYzQxR2kvQ2pNTytYZ3FjMVg3a1lEZ3NnQTlF?=
 =?utf-8?Q?PPUAPelL6v6KwyRtJNr42ThHx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e94e11-aad1-4590-05e9-08db774a6923
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:09:27.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoBItEa0WjWPLI0QM+kLc2e42K1SK66K+Eb+sIk2ldopLs5lnXguhLO5nB8X6Yqs2jJRHTu1agZYk4q4X7Ss4fcNx2tBpWjnXDy8xDZSNIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMjMgNzoxMSBQTQ0KPiAN
Cj4gVGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA1
LjE1LjExOSByZWxlYXNlLg0KPiBUaGVyZSBhcmUgOTYgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywg
YWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UNCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlv
bmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4gbGV0
IG1lIGtub3cuDQo+IA0KPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkgV2VkLCAyOCBKdW4g
MjAyMyAxODowNzoyMyArMDAwMC4NCj4gQW55dGhpbmcgcmVjZWl2ZWQgYWZ0ZXIgdGhhdCB0aW1l
IG1pZ2h0IGJlIHRvbyBsYXRlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZWxlYXNlIQ0KDQpDSVAg
Y29uZmlndXJhdGlvbnMgYnVpbHQgYW5kIGJvb3RlZCBva2F5IHdpdGggTGludXggNS4xNS4xMTkt
cmMxICgyNzg4M2ViOWI0N2UpOg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10
ZXN0aW5nL2xpbnV4LXN0YWJsZS1yYy1jaS8tL3BpcGVsaW5lcy85MTIzNzMyNzYNCmh0dHBzOi8v
Z2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUtcmMtY2kvLS9j
b21taXRzL2xpbnV4LTUuMTUueQ0KDQpUZXN0ZWQtYnk6IENocmlzIFBhdGVyc29uIChDSVApIDxj
aHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg==
