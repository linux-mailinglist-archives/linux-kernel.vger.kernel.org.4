Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63696746C36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGDIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGDIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:42:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC222BE;
        Tue,  4 Jul 2023 01:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwjH/P/1xOuhXaXWq4VTaWr6tYFCHSC1ClI53GCJ4xX0kkEkdAxFTXuM6Bri3f7M4wF7Vhym4BFkKE+ZcQMZb4OFeNuHEUvQzAKr3WiwbW5lLQkZubn0Ut1ajlHhgvXfFU/nZVJvMYoNBYCXYSCXLtmW8jRewF3YE8FoL8Bu4LPHx1TnNLQRV0+kzMIxmtgSrW0bIKFNIBAQDlFW93sEcmVZIs8sw4CGhG2nKA68lSZYbm8r0aKU8JjytxxpKE5gl7jvw8BC2I4MOThJ++RDko70rMdSb3UD+7nQLfKeaUMQaT3YVI5KJBSxXVmcVW9J2P7wSRE1RD2dZ2Ptnovjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1uBpDVmu2og+0g7Np/UEehE9GtTAVcn6YlcyXv3Sys=;
 b=nawxCiSWy2T44rCT7xHT1oOzfKwEjxwrPN4Vv7c6+pnqBbgmVsU7kF9IQD7JqAL9pPH4nhI968GkY8HH4Jt5p6gRB0yjQ3aEySFWErC84oA2mYkQyvewxnT93XJh7dal1cV/iB6idVgPg1v55UTI8dgJ4tzWsW4gG8oD5uq/HfUEudTtw61/tsZGpP7AWKUgo4lcDzRIhzp45WW2LyKG2JVHqwFWEk1cc6ATDBEqHJ5/HjhLkkGj6zb5WtsMI/t8sV/QpKvp/5M/C2im5Or7+giiButFXgJrtVbCq27bJN42MqDoYeWCKnUoeO11SNSRtDT+cI5KBf18jCHTxX8g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1uBpDVmu2og+0g7Np/UEehE9GtTAVcn6YlcyXv3Sys=;
 b=D1aHfi5VltSAShsmFPTQHwbUitr0uGffr5ho2ZU9fHsBj/r+LFclK6ZxoAMCvbUsRz1XMZmfFb12uJY60eYUiQknObmcJEvdif8/cPNv9szWpJ5IAHDHP3vLN2GL85m3qiI6b0K0Xfm86/Mn2iVFBFtPw75HyL1P35shmjEmQSU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11104.jpnprd01.prod.outlook.com (2603:1096:400:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:42:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:42:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
Thread-Topic: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
Thread-Index: AQHZq0sktriyRHMRaU2I/KvG3PLB4a+pTAEQgAACbQCAAABB0A==
Date:   Tue, 4 Jul 2023 08:42:22 +0000
Message-ID: <OS0PR01MB5922BFC7C34062876E53BBB7862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB59223E030DAE587A49C9D0FE862EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8um0xQ2FJyrHs=5Pc2PNvgW6B6z31zyFQ6zAYhi6=zgvQ@mail.gmail.com>
In-Reply-To: <CA+V-a8um0xQ2FJyrHs=5Pc2PNvgW6B6z31zyFQ6zAYhi6=zgvQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11104:EE_
x-ms-office365-filtering-correlation-id: f6a5c32c-bdc1-4939-453f-08db7c6a95c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bzq5we/eZiqk3TmRQ2C+Wmo8ehXHulG0ysaqOhO2Kpz8fdg1JAaGQkuwZ3grgVJtyDuJuBGqn2kPV4XQQyi7BdeTrGLHuvfU2FUBk/NOaXfpVPWFM+nbcoAqKHc/oa9MtIZV7SxiojYc7C7bfXsLeL1T4jgtxhib6tWBeGJkINio1kUQMhhYXMTONpoiaR5dqX5djapwgQ36fx4MQjQTXnPbgUKuylU/hcl6y1wQZ9zj7eErbaeeZDXlAQQCNTt7WD2cgLr++Y1IfOh48SdWnrSBTzgQ+43NYq0VcnZW9gVXSvbDMH9Fv4yZiMbuyKdi9cC7jOM5pvg3/vg3yU0WmxuQ3cjeHLx8pTmovyFU1Y8Vmd3s0GjniQL+hQpV+FnaPm5za9XNiOJgnCGVUTWvi9QqSCnGSp38RnYFFQLWmScmvkp28AjgbOByGxKBGK1dC+TSq7xCcsXfSJ+yc4+vm0XXtMP1v8hh0xqmG8MR3HILe30+rnX/AW6TIKokGK6fXocYTRMmM+fgIDocgNB/RncMuJbOd76jbZEhUgPSe0lxAmzQRGCvlJr1jkN0zOdHUnSaztwDe99+tyQITDwFELcm8YyG6BnEuNUMsSCziw8JmjB98MkLW1upXt4vJgo2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38070700005)(2906002)(41300700001)(8936002)(8676002)(52536014)(7416002)(33656002)(55016003)(5660300002)(86362001)(186003)(26005)(478600001)(107886003)(6506007)(9686003)(71200400001)(76116006)(7696005)(122000001)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(66446008)(38100700002)(53546011)(54906003)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0grSTJwTDVERHJ4dmMvQmJyOFZkL3dqZlJVcWdMRjZrNjBjcEVCclA3ZEdw?=
 =?utf-8?B?bmlDdmRnaGhjKzNBN1VSby9tOHdIblpXZ0EzcHg5NmoxNlFmZGtMYmF3MldX?=
 =?utf-8?B?Q3FGTlE0VjkwL1pObnBNOFRhVWdqU2VXREFSUDFKTnQ3L3FyUU9UWDdVc0xK?=
 =?utf-8?B?NUVadUIvVVZBQ2E4TjZTSFI1dFNnZXRwUGVZdGV5MlNMang4MmZjN0hycVV3?=
 =?utf-8?B?SENvU29XcWZJUnU4ZWZ5TkxPcXllSCsvbTBIOVplK1lQWFl0UUhKTThuRG90?=
 =?utf-8?B?VmNySGtYVUV6bDhMOUZMcWNxQmZuaTI5WVJXbDhzNkhhR2E5bEUzRUpGS2Jq?=
 =?utf-8?B?VUU2b3ZOaVFZMTNhbXlmTFJXenBsMGxST0E3NTQ3cjAvTkhvYjkvdGFacHpM?=
 =?utf-8?B?Z2hnZmt5WWZDcHBWUlNYVFppZ2ZmQVlBQUpaOUFPSVR4REZaeWZVYWR1RTdj?=
 =?utf-8?B?WHBFRER1RXBLSzF6THp3L2FndWRKVWdwNE1qSFlHSTQ4d2kxYnBYSlpjUFI4?=
 =?utf-8?B?UXdVK2thZ0dYcWFMajRzcDc4a2o1U0VQQ0lMUzYyNkZjY0lKZ1orZTZSM0Vn?=
 =?utf-8?B?dEF3ZUhzaDluSlRGVUNVTnJOLzNzNHJnaWdCamc1dlFrS3RlQndhN1ovdXZh?=
 =?utf-8?B?RnBiYy9NMFltNmROWEZmWFgzWXlVQWNpclRJWTFyTit1RFBJcmo0VnFGazgy?=
 =?utf-8?B?UkdsNzA2c0ZpMjFXck0xaHNvM0tPNmw4U2JTa2pDQmFwa2dwRXljZlBqR3VP?=
 =?utf-8?B?ZVZMYmVZNzA2SEFjKzVHelVteWtabGxjQk0zRFFyK3NuY1gwSHVDOGh5TFJK?=
 =?utf-8?B?WnduTWNWMi90TFVINXVYbm54ZzdLUDkzZlNkWENUOVdmVlBBU1RXaVJDanJK?=
 =?utf-8?B?YW40U2JObE9MTGJDdWVNdEJvMjAza2pjdGk4SWhEMFpIQUtYbXZlNjJWRTVF?=
 =?utf-8?B?Zjc0cmxpd1cwRGtaNUNMb2xJNURMTTZzU0FLVGloaUVnMzJPTTF3Wk9ZUmZn?=
 =?utf-8?B?bzN3MEowSlJ2TFlxZ0dGTGpac29YTWEva3RMcGFYM1dodEZoUmlOOUdzU29Y?=
 =?utf-8?B?MytuMXlpN0Eyb3BMeTUrZmJnaTV1cTlrai9FdE9aYVgrLzZzSDZGcVJNQWVk?=
 =?utf-8?B?Q2NKa0E3dTROWmRRelRXeUZVVzhIdldNNmc4ajN2UmFrZnNtanJYTXI0M3k1?=
 =?utf-8?B?YVcyZnFFUWY0Um5BUkdLVEx3OHNhMlZDTG9IMlVxUWw1ckU0eVQrMC9yUFdt?=
 =?utf-8?B?YWN6Q01oUnNJYm1pc1g3aFd6MlJLSThrRjROZ1JFOGx1QldvczUwQUNHYk16?=
 =?utf-8?B?VjhFQXIxMVRwVHIwbGFBZDU4cm5tOFRiUno4S24xQVRlMGhxTWpCNGhaeWo5?=
 =?utf-8?B?QWRTUitCVlk5YmszWG5NS3ZEMjJKdVdxTFhiMFFVdm1zcWtGd3BEREZqT1ZJ?=
 =?utf-8?B?R21RNmE3TFpNTkpQMFFPTW5idHp5SER0OFBTdEg2SlJhVG9qbzdWRGlURk9x?=
 =?utf-8?B?NHZPUDNhajVYLzhYMUZ5OUEyS3hIMUpXeWFuSzluVkxSc0FHbVlWRGlpaEd0?=
 =?utf-8?B?N3Y2UUZpU29CRDhkRG9NV0E5cUlsb1REb3RkbDVpQzZweHVXL0lOVXBvcktY?=
 =?utf-8?B?UzU1T2RoakpsamVuZzRWUk4zRDMzTFVhS3ZuOUVsb2c0ZWNuaEU5aCtXcGh1?=
 =?utf-8?B?WHNUb2cwcVBiMWtnbW03OGJUTVpIcFJJRzM4YXZKMmpvVEw1YXNYVFpjdXY1?=
 =?utf-8?B?VURtV2krdS9wbmR1bHE2UW9ZWjZacEVTL0ovcmRBU3FMeUo4U2ZmUXhaT1g1?=
 =?utf-8?B?VkxRK0psWHRLaEZzcTVOd0NjV3lFQWJzTWQyM05OdHdpRjQzRHR4bnRoRWVX?=
 =?utf-8?B?ZW5aWXN5WlJXK01TcStnR2xRZGU5RGtNelhtZlNvNm1mbHB5T0FPamFDZXQw?=
 =?utf-8?B?NUMyZWl5Ky94S1MyRXpnVld6ZmFkeTVVOTVCWFNzZUxoTFUwbW5BNGMrRWNO?=
 =?utf-8?B?a1N5SHk1Zkl5Z3dCRVFjVW1aQ3ZGYVYxOTcycVMwcWlNclU0cHlOUjNhc0ZQ?=
 =?utf-8?B?V0JBa1RjY2d2QkdxSVBXbWdHMi9RSzRPOCtXejMyWFZ0K1pIS3NpekFqcEI1?=
 =?utf-8?Q?ChG4DLi9b03FOxYeOFUh8Gdkp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a5c32c-bdc1-4939-453f-08db7c6a95c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:42:22.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0IhHTq6qQfk6U6qrknFa80IRBH7wA1zVnd/5ATTUEUFmcTFMP8RTpOckAMMhtyDZW6aX9n1RoKRF5NmYePPUXzqNuyASUPYkFFRV+HQ5SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
ZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVseSA0LCAyMDIzIDk6MzYgQU0NCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gQ2M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+OyBNYWdudXMgRGFtbQ0KPiA8bWFnbnVzLmRhbW1AZ21haWwuY29tPjsgUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz47IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ncGlvQHZnZXIua2VybmVs
Lm9yZzsgUHJhYmhha2FyIE1haGFkZXYNCj4gTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpA
YnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvNF0gcGluY3RybDog
cmVuZXNhczogcnpnMmw6IEluY2x1ZGUgcGlubWFwIGluDQo+IFJaRzJMX0dQSU9fUE9SVF9QQUNL
KCkgbWFjcm8NCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDk6
MzDigK9BTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gSGkgUHJhYmhha2FyLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4N
Cj4gPiA+IFNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyAxOjA1IFBNDQo+ID4gPiBUbzogR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IE1hZ251cyBEYW1tDQo+
ID4gPiA8bWFnbnVzLmRhbW1AZ21haWwuY29tPg0KPiA+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4gPiA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgTGludXMgV2FsbGVpag0KPiA+ID4gPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz47IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWdwaW9Admdl
ci5rZXJuZWwub3JnOyBCaWp1IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PjsgUHJhYmhha2FyDQo+ID4gPiA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+OyBQcmFiaGFr
YXIgTWFoYWRldiBMYWQNCj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUkZDIFBBVENIIDEvNF0gcGluY3RybDogcmVuZXNhczog
cnpnMmw6IEluY2x1ZGUgcGlubWFwIGluDQo+ID4gPiBSWkcyTF9HUElPX1BPUlRfUEFDSygpIG1h
Y3JvDQo+ID4gPg0KPiA+ID4gRnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYt
bGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IEN1cnJlbnRseSB3ZSBhc3N1bWUg
YWxsIHRoZSBwb3J0IHBpbnMgYXJlIHNlcXVlbnRpYWwgaWUgYWx3YXlzIFBYXzANCj4gPiA+IHRv
IFBYX24gKG49MS4uNykgZXhpc3QsIGJ1dCBvbiBSWi9GaXZlIFNvQyB3ZSBoYXZlIGFkZGl0aW9u
YWwgcGlucw0KPiA+ID4gUDE5XzEgdG8NCj4gPiA+IFAyOF81IHdoaWNoIGhhdmUgaG9sZXMgaW4g
dGhlbSwgZm9yIGV4YW1wbGUgb25seSBvbmUgcGluIG9uIHBvcnQxOQ0KPiA+ID4gaXMgYXZhaWxh
YmxlIGFuZCB0aGF0IGlzIFAxOV8xIGFuZCBub3QgUDE5XzAuDQo+ID4gPg0KPiA+ID4gU28gdG8g
aGFuZGxlIHN1Y2ggY2FzZXMgaW5jbHVkZSBwaW5tYXAgZm9yIGVhY2ggcG9ydCB3aGljaCB3b3Vs
ZA0KPiA+ID4gaW5kaWNhdGUgdGhlIHBpbiBhdmFpbGFiaWxpdHkgb24gZWFjaCBwb3J0LiBXaXRo
IHRoaXMgd2UgYWxzbyBnZXQNCj4gPiA+IGFkZGl0aW9uYWwgcGluIHZhbGlkYXRpb24sIGZvciBl
eGFtcGxlIG9uIHRoZSBSWi9HMkwgU09DIFAwIGhhcyB0d28NCj4gPiA+IHBpbnMNCj4gPiA+IFAw
XzEgYW5kIFAwXzAgYnV0IHdpdGggRFQvU1lTRlMgY291bGQgdXNlIHRoZSBQMF8yLVAwXzcuDQo+
ID4gPg0KPiA+ID4gV2hpbGUgYXQgaXQsIHVwZGF0ZSByemcybF92YWxpZGF0ZV9ncGlvX3Bpbigp
IHRvIHVzZSB0aGUgcG9ydCBwaW5tYXANCj4gPiA+IHRvIHZhbGlkYXRlIHRoZSBncGlvIHBpbi4N
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA8cHJhYmhh
a2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1yemcybC5jIHwgMTY3DQo+ID4gPiArKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygr
KSwgODEgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGlu
Y3RybC9yZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiA+ID4gYi9kcml2ZXJzL3BpbmN0cmwvcmVu
ZXNhcy9waW5jdHJsLXJ6ZzJsLmMNCj4gPiA+IGluZGV4IDk1MTFkOTIwNTY1ZS4uYTBjMmU1ODVl
NzY1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1y
emcybC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJs
LmMNCj4gPiA+IEBAIC02NywxMCArNjcsMTIgQEANCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBJTl9DRkdfRklMQ0xLU0VMKQ0KPiA+ID4NCj4gPiA+ICAvKg0K
PiA+ID4gLSAqIG4gaW5kaWNhdGVzIG51bWJlciBvZiBwaW5zIGluIHRoZSBwb3J0LCBhIGlzIHRo
ZSByZWdpc3RlciBpbmRleA0KPiA+ID4gLSAqIGFuZCBmIGlzIHBpbiBjb25maWd1cmF0aW9uIGNh
cGFiaWxpdGllcyBzdXBwb3J0ZWQuDQo+ID4gPiArICogbSBpbmRpY2F0ZXMgdGhlIGJpdG1hcCBv
ZiBzdXBwb3J0ZWQgcGlucywgbiBpbmRpY2F0ZXMgbnVtYmVyDQo+ID4gPiArICogb2YgcGlucyBp
biB0aGUgcG9ydCwgYSBpcyB0aGUgcmVnaXN0ZXIgaW5kZXggYW5kIGYgaXMgcGluDQo+ID4gPiAr
ICogY29uZmlndXJhdGlvbiBjYXBhYmlsaXRpZXMgc3VwcG9ydGVkLg0KPiA+ID4gICAqLw0KPiA+
ID4gLSNkZWZpbmUgUlpHMkxfR1BJT19QT1JUX1BBQ0soDQoNCiwgYSwgZikgICAgICAgICgoKG4p
IDw8IDI4KSB8ICgoYSkgPDwNCj4gMjApIHwNCj4gPiA+IChmKSkNCj4gPiA+ICsjZGVmaW5lIFJa
RzJMX0dQSU9fUE9SVF9QQUNLKG0sIG4sIGEsIGYpICAgICAoKFVMKG0pIDw8IDMyKSB8DQo+IChV
TChuKSA8PCAyOCkNCj4gPiA+IHwgKChhKSA8PCAyMCkgfCAoZikpDQo+ID4gPiArI2RlZmluZSBS
WkcyTF9HUElPX1BPUlRfR0VUX1BJTk1BUCh4KSAgICAgICAgKCgoeCkgJiBHRU5NQVNLKDM5LA0K
PiAzMikpID4+IDMyKQ0KPiA+ID4gICNkZWZpbmUgUlpHMkxfR1BJT19QT1JUX0dFVF9QSU5DTlQo
eCkgICAgICAgICgoKHgpICYgR0VOTUFTSygzMCwNCj4gMjgpKSA+PiAyOCkNCj4gPiA+ICAjZGVm
aW5lIFJaRzJMX0dQSU9fUE9SVF9HRVRfSU5ERVgoeCkgKCgoeCkgJiBHRU5NQVNLKDI2LCAyMCkp
ID4+DQo+ID4gPiAyMCkgICNkZWZpbmUgUlpHMkxfR1BJT19QT1JUX0dFVF9DRkdTKHgpICAoKHgp
ICYgR0VOTUFTSygxOSwgMCkpIEBADQo+ID4gPiAtMTI5LDcgKzEzMSw3IEBAIHN0cnVjdCByemcy
bF9kZWRpY2F0ZWRfY29uZmlncyB7DQo+ID4gPg0KPiA+ID4gIHN0cnVjdCByemcybF9waW5jdHJs
X2RhdGEgew0KPiA+ID4gICAgICAgY29uc3QgY2hhciAqIGNvbnN0ICpwb3J0X3BpbnM7DQo+ID4g
PiAtICAgICBjb25zdCB1MzIgKnBvcnRfcGluX2NvbmZpZ3M7DQo+ID4gPiArICAgICBjb25zdCB1
NjQgKnBvcnRfcGluX2NvbmZpZ3M7DQo+ID4NCj4gPiBDYW4gdGhpcyBiZSBTb0Mgc3BlY2lmaWM/
IE9ubHkgZm9yIFJaL0ZpdmUgeW91IG5lZWQgdGhpcyBjaGFuZ2VzLg0KPiA+IE90aGVycyBTb0Nz
IGxpa2UgUlove0cyTCxHMkxDLFYyTCBhbmQgRzJVTCkgc3RpbGwgd29yayB3aXRoIHUzMiogYXMN
Cj4gPiB0aGVyZSBpcyBubyBob2xlcy4gV2l0aCB0aGlzIGNoYW5nZSBtZW1vcnkgdXNhZ2UgaXMg
ZG91YmxlZCBhcyB3ZQ0KPiA+IGNoYW5nZSBmcm9tDQo+ID4gdTMyLT51NjQuDQo+ID4NCj4gVGhp
cyBpcyB0byBhdm9pZCB3cml0aW5nIHRvIHVuZG9jdW1lbnRlZCByZWdpc3RlcnMgc28gSSBoYXZl
IGFkZGVkIGZvcg0KPiBhbGwgdGhlIFNvQ3MuIEZvciBleGFtcGxlIG9uIHRoZSBSWi9HMkwgU09D
IFAwIGhhcyB0d28gcGlucyBQMF8xIGFuZA0KPiBQMF8wIGJ1dCBEVC9TWVNGUyBjb3VsZCB1c2Ug
dGhlIFAwXzItUDBfNy4gVGhpcyBwYXRjaCByZXN0cmljdHMgdXNlcnMgdG8NCj4gdXNlIG9ubHkg
YXZhaWxhYmxlIEdQSU8gcGlucy4NCg0KSSBndWVzcyB0aGF0IHN0aWxsIGNhbiBiZSBhY2hpZXZl
ZCwgYXMgdGhlIGJlbG93IG1hY3JvIGhhcyB2YWxpZA0KcGlucyBpbmZvPz8NCg0KI2RlZmluZSBS
WkcyTF9HUElPX1BPUlRfR0VUX1BJTkNOVCh4KQkoKCh4KSAmIEdFTk1BU0soMzAsIDI4KSkgPj4g
MjgpDQoNCmlmICghKEJJVChiaXQpICYgR0VOTUFTSyhSWkcyTF9HUElPX1BPUlRfR0VUX1BJTkNO
VCh4KSwgMCkpDQpyZXR1cm4gLUVJTlZBTDsNCg0KQ2hlZXJzLA0KQmlqdQ0K
