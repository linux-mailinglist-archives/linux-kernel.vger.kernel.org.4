Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388006C1455
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjCTOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCTOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:06:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE616326;
        Mon, 20 Mar 2023 07:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXafLtUoCR1zker0ju5KBLRiaIs+7Y7jpPg7KpOKceexj+8Xu9T23SY00RE6/vbVIAXplz0PGKoo/N3JwsZwGi+QZglldskcR4/5ImH0ffWmK5XC8MZEFxHphvYdSPqFuWkwBKXIeRFNXtPHFIem3ORgV6KhrT1qIOTtRgWf39pc2AvbHrxMWVc4cKH7R++pd7iC9eixWdSTpcxi30Ab5m51g0e7C03PFwYm5hlgFafAqMnlvhELmVFdlz5n6HnK1gI7cbAI2HdRfUSJTl3mn6CRwXhoHK1VA56NUhuwd+yFwZisXQggO21uy7E8IEo4IDpBTshZl9J1wojm/Xp2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1YA+aG3Eztii+ggulFGRRTmwwYaEhcuT7dmku9fbfk=;
 b=YFEsg5Ge267ZOxShLZuTjSEIlnK4T0SxTGRYaKGY+VJoG6TzuwGJvP0wTa/T+d/dL5blZ+GEd6KOGLB1oIRg/ffu8TZwJTNFYfbukafnagnXXydv6apRELTGEzmocAKD2D2AATjbVQ5nWdRcpyXXrD5jovF9LJbNsnzvLOWCDzDX5vfYrHjrMHbvvaldybfHRs0byzWSFyYr00A8vZMs2Zn2d4FsxXn3wEyysEqWMHIOoOygDHhOBNKPZt4ww/Tle2NfcLmcWJiPX8TG1bzZjn2zaXIeYTjiankH65S6neujDrahHQ5lOnHoIjSaGT/oP8mpDq/jSwx5lccKyC3uPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1YA+aG3Eztii+ggulFGRRTmwwYaEhcuT7dmku9fbfk=;
 b=q+kMc1qYIk+ve6caxr7kzCR/E9T0mRaqzdSbawXn8zm97gNy9Uj5s8Pw7OTwwpR3lxI/Iig3eTCjuJJ4HkFSsENOTLjKs6CsFwxpwBQMCrqEOgb0IEd/gX9oQqazCrU8RCBx/IK0KOzEjBK0IMZ3PYdlbHRQ4rNoBcZImnWcFDM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:06:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:05:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Topic: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Thread-Index: AQHZWs/6lJ7epjxGPkeRDAwzZgO0X68DPJiAgABD8SCAAAsMAIAAASdQgAAGL4CAACERAA==
Date:   Mon, 20 Mar 2023 14:05:56 +0000
Message-ID: <DU0PR04MB94174D9E7DCBC9C15AB5335088809@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230320020714.955800-1-peng.fan@oss.nxp.com>
 <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
 <DU0PR04MB9417D88E67200F4A74C5CF4888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <355d5dde-cc86-018c-85d5-51cf59bdb36a@linaro.org>
 <DU0PR04MB9417FBDEC58F46C069A359B888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <e98f0068-dfd0-0402-8089-3ca53870263d@linaro.org>
In-Reply-To: <e98f0068-dfd0-0402-8089-3ca53870263d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8615:EE_
x-ms-office365-filtering-correlation-id: fe39ea9b-dded-4b02-cb3d-08db294c39c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCPQyRMHX8h829Szuqdn5mlro3iBj6SbUjZcRh6hDRFjdBnLfspBLulSJv7yohffZk6cd5fgYo61TTYWBOx892EY2fVimOX/QKOvGVNerpMPHnzZ1/XTL+Qhehf4TPZPLdUklHCf5z1zdrrD85LG7gnTS4YR/HEOdeATWh9EaC9f4lnGLfEAn/UjBtWQ3TMC1QCN43HMa2xi5dZuPrG+6GCblVnriKiOnJU453ntJDZCWQFFVilxG1Ac3STknCMU46+l7QTMxRca4N2k5bEoAYpU8FgtpIzeZYjTb93Y4Gf2baEfIiiPE1riLTeUU9KpM3TWskSVy3cxu1XpCOQfVHSveiWxEaUjj1iDexv5806o7+pj+Ksj7WgtrZyjFv1XIxtVqyAcQBDYpdIijr2jOw8EcFKCyOq+8l2bHYjer8vEbjgEBfRfh88vgS5SPvB3q0CgGCrjgamBI9a8o5kicXlINK1pvGIST8MkgoNxbfSq5orH3KA2TuNTUHHw7bld96Lbr5FJOUUOm6fardf/nmLGSNnF3rGOvmcvAIXeHKdjw9voa7bF8whzRilcCbuIQCNYuyUln9mN4939KcUN6C7Kw3WChG16aBxcbtCsnVSRmBzm7p+1Fy0LDNgAK4XPb+wZejW1uoO9shyGEl3iegnr5cY2YL39o4s/Ow5zt2mUzt5wToTFWemOJyzxZZN3WXMLCE/uMZZokZ9QJWMCgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199018)(9686003)(6506007)(26005)(186003)(966005)(316002)(64756008)(66946007)(6636002)(71200400001)(7696005)(66446008)(53546011)(66476007)(8676002)(4326008)(83380400001)(66556008)(76116006)(54906003)(478600001)(110136005)(7416002)(5660300002)(122000001)(44832011)(41300700001)(8936002)(2906002)(52536014)(38070700005)(38100700002)(33656002)(86362001)(55016003)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c0pWRHdFaXhLUXkveEVaQTNEVVFYbTZ1dmxwSDZ5K3pQN0d5Znd2aWFIMnkr?=
 =?gb2312?B?bUt4eldQN1RLcEV0dzJiSFdEQUhMcytUMk0zRWJxM2tQVmM5NDNKS2ZJTWdI?=
 =?gb2312?B?LzlzbUtVZG1XSGg5QitFQW01U3BSV3M4YTV0SCt1MVZFYytJeGdKTlVCOTcx?=
 =?gb2312?B?R2o2aDUwZm12VElVYk9EZkJ1NWJYL1pUOXZXVTEzVXdSaWwwcjVRZjNBYms0?=
 =?gb2312?B?b2dmNDViOXNSR3VKbEJlMEpBbnBNUUkzT1QzdWszaEZDa2s0bzNxaDdRYjJH?=
 =?gb2312?B?bnhzb3JTVHNUZXU3TklTNmRzS2xhbGl3QWhaK25FTDB6bGh6Z3ZPcTdHOFVn?=
 =?gb2312?B?U2tKNVVDM0tFRWVIOVQraDZ4VkQ4SGdJc1d4V1JsRzZiTDlnMzJrbEFRK2xr?=
 =?gb2312?B?TFFBVGo5NmRNcFNjSTFWOXNuaTVTcWo2WEs4Q2hVbnlaUHU2WkFZYk9lTzc4?=
 =?gb2312?B?WUprQTFqb0QyQXAyaytsNTN2MEp1M1c3MHdjWVFad0xGUUxhblBQOW9Xb2VM?=
 =?gb2312?B?VU5KVmhMcEo3TjIwSjVSRHJ4ditVS3J3b0g1STBEcTU1L2luMVNkZllPa3Jn?=
 =?gb2312?B?b01BbnF6eWsxL21LUml1bm1ScnFWYytMQ3pMeVZiNU1qcFJrei9pNTFDVXZq?=
 =?gb2312?B?UWhtY1NJRTlwYWRWYWx5YkxGY1JjMjFHWFRpM1lnSE90ekZZc09tbmRRMWd1?=
 =?gb2312?B?UjhHVGxzalg2VW1aWUEwM0FrU2tENG9QMUhtTEdtaTNWSWVYWmJqS2w4aVJU?=
 =?gb2312?B?V2JIYWVkQlBNZDQ4TjFuSjdSemtxUnYyVHBFUlAwMVQvSnNqdTVSMmswL2ZE?=
 =?gb2312?B?bWRRdFJFdzFpMmRxVGRCUDRyRmI5ZDc4dlZuSndMa1VKa0lKSjkwV0lwN0Ew?=
 =?gb2312?B?SjFNZHlhVHI3MlNURE5zVS90SngzMDRDWDFuVUwyQ3pEc3BZT09QRVBwWjVo?=
 =?gb2312?B?WThrTm0vNnNrTjIxS2pzaWVLYjlFeHU3WFRlckd6Tk16MkFNRWYycTNPRmgz?=
 =?gb2312?B?VWg3UzlJMXNyYVdFRXVUNko5aHRCOEF3NzY5L1pDZlFRc1hpNW1lcm8xZnlL?=
 =?gb2312?B?U1BXRWhVZG5aUlN1eWdLVnJZV0R6T1FZNFprMkYxRWhvVHl0bHpLSWdNSGNU?=
 =?gb2312?B?S0p3aDdjMlB4MFJINUhWN2JHanNOZk9rNUVvd3dzOElhYThTTWVBRXptdU1v?=
 =?gb2312?B?Rmh6cGEzZ25Tcy9Ha3lsNjBNLzlkdHcwMDV5UUJqallyYVdZSzllNmd1M3By?=
 =?gb2312?B?MFdCSXhXM1VVRXZKMFJhWVRPSjlnQnhsNlNYYkdRNXdqWnhsdVV1VTh4TzJR?=
 =?gb2312?B?YjlaNnh1OXJhNzQ5QXcyQW4xQ3dYK3ZoTjR3Q0p3eWtOL0RpejRwbVdjMTFK?=
 =?gb2312?B?WVgwaU5EVEVZeURCSmtFUlpDRFM0aVc0Tk1mQnd0KzBMNjBXQndwRUtlTE9F?=
 =?gb2312?B?VkZ6MFpsc2FvZTUzNGJvVTFZN0N5VXh4YVM0c05Hd0UxTUN0TE1WZmpOYmR3?=
 =?gb2312?B?ZFM4ZDVQYXRNcUtpeXVFT1lsOFFFZ2piMytVakVqdzF5ekMrWnVKV0ZxYWxl?=
 =?gb2312?B?VDNPN2xKSlpBWk1uRldJZmdyUUNXWVRDSnRyYTIwdG1CellHOE9VMlhCckZN?=
 =?gb2312?B?ODZTUC9FbEk2VnhvVFhWTHBveE1ZMWNHaFVhQzU1NWxUb1h1UHd5dUZqOWZC?=
 =?gb2312?B?bDJPSVg4NVhJR0VMVUxSSkwyWkZRbTJkUWM3T2lEVEY2b1F0RVVabEZuU2pV?=
 =?gb2312?B?MDlOd2lHUUNETVdUS3FqOXBtUmx0clFiNXN6cG1XckpPY0p3UEhPY3NhalhZ?=
 =?gb2312?B?aFVIQjN1ajE4UXR2NEN0dzFQV0ZWQWZLNk5abnpPYXVBT3FQNUFaSFAxYjNn?=
 =?gb2312?B?NUR4UVZMQzM0RlI3NGRDdk9XUGtJT1JOUjFIK0E5V0hzUzAzb0srQmpnR01V?=
 =?gb2312?B?SnZMV0tIb29saTFsMmlVcFpzSEw2TzJXTmhKMmM3bVBlOE9KOEYxaVYveDQ3?=
 =?gb2312?B?MXlzYVpXaEJLMlNNTHA1ZEMrVXczRjhWU0VyRVNlMHk2ZzZBOWkwY1dlZWMy?=
 =?gb2312?B?aHhzcUNjQkZRUWpwMWpvVTdpVVNOcHNoS01sVGJyREozMzlXMUpjM1lXRjcr?=
 =?gb2312?Q?AyIE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39ea9b-dded-4b02-cb3d-08db294c39c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 14:05:56.5818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXPBS+SkhypdyNXorCnfCz5aruQIVtuJuO64uUU17C8VpY0mgZ4/lS2PYGnboSTOzMx7Tm5S33DIy6ExUX4Y0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIzxOoz1MIy
MMjVIDIwOjA2DQo+IFRvOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFBlbmcgRmFuIChP
U1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgWHUgWWFu
Zw0KPiA8eHUueWFuZ18yQG54cC5jb20+DQo+IENjOiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5jb20+OyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBKdW4gTGkNCj4gPGp1bi5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIGxpbnV4LW5leHRdIGR0LWJpbmRpbmdzOiB1c2I6IHNucHMsZHdjMzogY29ycmVjdA0KPiBp
Lk1YOE1RIHN1cHBvcnQNCj4gDQo+IE9uIDIwLzAzLzIwMjMgMTI6NDQsIFBlbmcgRmFuIHdyb3Rl
Og0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIGxpbnV4LW5leHRdIGR0LWJpbmRpbmdzOiB1c2I6
IHNucHMsZHdjMzogY29ycmVjdA0KPiA+PiBpLk1YOE1RIHN1cHBvcnQNCj4gPj4NCj4gPj4gT24g
MjAvMDMvMjAyMyAxMjowMiwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBsaW51eC1uZXh0XSBkdC1iaW5kaW5nczogdXNiOiBzbnBzLGR3YzM6DQo+ID4+Pj4gY29y
cmVjdCBpLk1YOE1RIHN1cHBvcnQNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIwLzAzLzIwMjMgMDM6MDcs
IFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIHByZXZpb3VzIGkuTVg4TVEgc3VwcG9ydCBi
cmVha3Mgcm9ja2NoaXAsZHdjMyBzdXBwb3J0LCBzbyB1c2UNCj4gPj4+Pj4gc2VsZWN0IHRvIHJl
c3RyaWN0IGkuTVg4TVEgc3VwcG9ydCBhbmQgYXZvaWQgYnJlYWsgb3RoZXJzLg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBGaXhlczogMzc1NGM0MWM3Njg2ICgiZHQtYmluZGluZ3M6IHVzYjogc25wcyxkd2Mz
OiBzdXBwb3J0DQo+ID4+Pj4+IGkuTVg4TVEiKQ0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwgICAgfCAyMSArKysrKysrKysrKystLS0t
DQo+IC0tLQ0KPiA+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sDQo+ID4+Pj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pj4+PiBpbmRl
eCAxNmM3ZDA2YzkxNzIuLjYzNDdhNjc2OWVlMyAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pj4+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1s
DQo+ID4+Pj4+IEBAIC0yOCwxNSArMjgsMjIgQEAgYWxsT2Y6DQo+ID4+Pj4+ICAgICAgZWxzZToN
Cj4gPj4+Pj4gICAgICAgICRyZWY6IHVzYi14aGNpLnlhbWwjDQo+ID4+Pj4+DQo+ID4+Pj4+ICtz
ZWxlY3Q6DQo+ID4+Pj4+ICsgIHByb3BlcnRpZXM6DQo+ID4+Pj4+ICsgICAgY29tcGF0aWJsZToN
Cj4gPj4+Pj4gKyAgICAgIGNvbnRhaW5zOg0KPiA+Pj4+PiArICAgICAgICBlbnVtOg0KPiA+Pj4+
PiArICAgICAgICAgIC0gZnNsLGlteDhtcS1kd2MzDQo+ID4+Pj4NCj4gPj4+PiBBbmQgd2hhdCBh
Ym91dCBhbGwgc25wcyxkd2MzIGRldmljZXMgdGhlcmUgKHdpdGhvdXQgc3BlY2lmaWMNCj4gY29t
cGF0aWJsZSk/DQo+ID4+Pj4gUHJldmlvdXNseSB0aGV5IHdlcmUgc2VsZWN0ZWQgYW5kIG5vdyB0
aGV5IGFyZSBub3QuLi4gc28geW91IGp1c3QNCj4gPj4+PiBkaXNhYmxlZCBzY2hlbWEgZm9yIGFs
bCBvZiB0aGVtLg0KPiA+Pj4gW1BlbmcgRmFuXQ0KPiA+Pj4NCj4gPj4+IEkgYW0gbm90IHN1cmUg
aG93IHRvIGFkZHJlc3M6DQo+ID4+Pg0KPiA+Pg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3INCj4gPj4NCj4gZSUy
RiZkYXRhPTA1JTdDMDElN0NwZW5nLmZhbiU0MG54cC5jb20lN0NiODVhMzcyYTFhM2Q0NjdmYmY1
NQ0KPiAwOGRiMjkzYg0KPiA+Pg0KPiA2OTlkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzODE0OTEwNzMzDQo+IDQwMzQzODklDQo+ID4+DQo+IDdDVW5rbm93
biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDDQo+
IEpCVGlJNkkNCj4gPj4NCj4gazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZz
ZGF0YT1ldGJsNjNqWDNkMExWTTMNCj4gJTJCOFA4JTJCQg0KPiA+PiAyejhkY0JkZGtucyUyRngw
TzYzVUhjMkUlM0QmcmVzZXJ2ZWQ9MA0KPiA+Pj4gLmtlcm5lbC5vcmclMkZhbGwlMkZDQUxfSnNx
JTJCbnJxVFg1TkQzJTNEJTJCa0ZVbVN0eC0NCj4gPj4gJTJCYiUzRHFwRV9Xc0xfTGUNCj4gPj4+
IC1ZWDhjMjg1LQ0KPiA+Pg0KPiA1QSU0MG1haWwuZ21haWwuY29tJTJGJmRhdGE9MDUlN0MwMSU3
Q3BlbmcuZmFuJTQwbnhwLmNvbSU3QzFlDQo+ID4+Pg0KPiA+Pg0KPiA2N2RmNzk2OTIyNDNmMDU4
ZmEwOGRiMjkzN2JlZmQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzDQo+ID4+IDUl
N0MwJQ0KPiA+Pj4NCj4gPj4NCj4gN0MwJTdDNjM4MTQ5MDkxNTg2OTMzNjE4JTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUMNCj4gPj4gNHdMakF3TURBaUwNCj4gPj4+DQo+ID4+DQo+
IENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0Ml
N0MlN0Mmcw0KPiA+PiBkYXRhPXIxDQo+ID4+Pg0KPiBmZXNCMWMlMkIzWXhvaENHTTM2eHlTRnVj
VlUyNVdWWUlNbHBnR2tkb1drJTNEJnJlc2VydmVkPTANCj4gPj4+DQo+ID4+PiBSb2Igc3VnZ2Vz
dGVkIHVzZSBzZWxlY3QsIGJ1dCBJIGFtIG5vdCBzdXJlIGhvdyB0byB1c2UgaXQgaGVyZS4gVXNl
DQo+ID4+PiBhbiBleHRyYSB5YW1sIGZpbGUgd2l0aCBzZWxlY3Qgb3IgZWxzZS4NCj4gPj4+DQo+
ID4+Pj4NCj4gPj4+Pj4gKyAgcmVxdWlyZWQ6DQo+ID4+Pj4+ICsgICAgLSBjb21wYXRpYmxlDQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gIHByb3BlcnRpZXM6DQo+ID4+Pj4+ICAgIGNvbXBhdGlibGU6DQo+
ID4+Pj4+IC0gICAgb25lT2Y6DQo+ID4+Pj4+IC0gICAgICAtIGl0ZW1zOg0KPiA+Pj4+PiAtICAg
ICAgICAgIC0gY29uc3Q6IGZzbCxpbXg4bXEtZHdjMw0KPiA+Pj4+DQo+ID4+Pj4gSSBkb24ndCB1
bmRlcnN0YW5kIHdoeSB5b3UgcmVtb3ZlIHlvdXIgY29tcGF0aWJsZS4NCj4gPj4+IFtQZW5nIEZh
bl0NCj4gPj4+DQo+ID4+PiBNeSBsYXN0IGNoYW5nZSBkcm9wcyAnY29udGFpbnMnIGJ5IG1pc3Rh
a2UsIGFuZCBicmVha3MNCj4gPj4NCj4gPj4gVGhpcyBJIHVuZGVyc3RhbmQuDQo+ID4+DQo+ID4+
PiByb2NrY2hpcCxkd2MzLCBzbyBqdXN0IGJyaW5nIGJhY2sgdGhlIG9yaWdpbmFsIGNvbnRlbnQN
Cj4gPj4NCj4gPj4gVGhpcyBpcyBub3QgYSByZWFzb24gdG8gbWFrZSB5b3VyIGNvbXBhdGlibGUg
dW5kb2N1bWVudGVkLiBZb3UNCj4gPj4gYmFzaWNhbGx5IHJldmVydCB5b3VyIHBhdGNoLiBJdCBk
b2VzIG5vdCBtYWtlIGFueSBzZW5zZSB0byBtZS4NCj4gPiBbUGVuZyBGYW5dDQo+ID4NCj4gPiBv
aywgbGV0IG1lIHRoaW5rIG1vcmUuIEhvbmVzdGx5IG5vdCBoYXZlIGdvb2QgaWRlYSAoOg0KPiA+
IElmIHlvdSBoYXZlIGFueSBndWlkYW5jZSwgdGhhdCB3b3VsZCBiZSBoZWxwZnVsLg0KPiANCj4g
WW91IHNob3VsZCBvbmx5IG5lZWQgYSBzZWxlY3QsIGhvd2V2ZXIgbW9zdCBsaWtlbHkgc2VsZWN0
aW5nIGFsc28NCj4gc25wcyxkd2MzICh3aXRob3V0IHNwZWNpZmljIGNvbXBhdGlibGUpLiBBbnl3
YXkgdGhpcyBiaW5kaW5nIC0gaW5jbHVkaW5nDQo+IGhvdyBpdCBpcyByZWZlcmVuY2VkIGJ5IG90
aGVycyAtIGlzIGdldHRpbmcgdW5tYW5hZ2FibGUuIEkgdGhpbmsgSSBjb21tZW50ZWQNCj4gYWJv
dXQgdGhpcyBvbiBzb21lIG90aGVyIG9jY2FzaW9uLiBUaGUgcG9pbnQgaXMgdGhhdCBubyBvbmUg
cmVmYWN0b3JzIGl0IHRodXMNCj4gaXQgZ3Jvd3MgYW5kIGdyb3dzIGxlYWRpbmcgdG8gbW9yZSBv
ZiBzdWNoIHRyaWNreSBzY2VuYXJpb3MuDQo+IA0KPiBIb3cgaXQgc2hvdWxkIGJlIHJlZmFjdG9y
ZWQ/IFByb2JhYmx5IGp1c3QgbGlrZSBhbGwgb3RoZXIgd2l0aCByZS11c2FibGUNCj4gY29tcG9u
ZW50czogY29tbW9uIHBhcnQgYW5kIGRldmljZSBzcGVjaWZpYyBiaW5kaW5ncyBpbmNsdWRpbmcg
aXQuIFdoaWxlDQo+IHNucHMsZHdjMyBhbG9uZSBzaG91bGQgbm90IGJlIGFsbG93ZWQgYW55bW9y
ZS4NCg0KVGhhbmtzLCBJIG1heSB0YWtlIHJvY2tjaGlwLGR3YzMueWFtbCBvciBvdGhlciB2ZW5k
b3IsZHdjMy55YW1sIGFzDQpyZWZlcmVuY2UgdG8gaW50cm9kdWNlIGZzbC1pbXg4bXEsZHdjMy55
YW1sIHRvIGp1c3QgYWRkIGEgc2VsZWN0LCBhbmQNCmRyb3AgdGhlIGZzbCxpbXg4bXEtZHdjMyBj
b21wYXRpYmxlIGZyb20gc25wcyxkd2MzLnlhbWwuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
