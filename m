Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6F67B578
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjAYPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjAYPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:09:32 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E994F5FDA;
        Wed, 25 Jan 2023 07:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDHw7t5VOinald1Fwg/+7pBVnH+2RQlvPu1Jcbl9JNYN6zYiIB1RBWsdwThDVDpzbpFa/OMOodljy4QGJF9nx54pM16um33MWw+vQiLyViZZZJcmGDRyXI2uof9myWLqkBCL57HyG5DFwKOCA9ahulsFZHgQOkSS0KqU8axzH8sN3zEbnX0b+x8rTetpqteE4lT5u+5utDhGtSp4eCmVULINHl8koRD8ZVOLuL/0MlnbiDVXDDT06pQ6dXorHz5Ye8gEzAUZcxAY7beG704Kc0aae8K4KvQr081qk9bpjMAo1WdZrmRbzNqg9xOH4R/Cn9Od8JdfFSnc7qpCUeJQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3LezB8GdLaGtke1AecFbnogarI3shZJm8uE+PsWHr8=;
 b=QOfaiT8aGgbPvgArXnISuEt59e3uVfVv+H2CTvFaZPeX7Bei1askWQ09RyWT8Hn+IEZpLeYq16s41uiHqwLaFiPQhwBa00NYFlcK1ClCVnNSAbIguw9XYHmWa/GWfAb1xSFpFz9Ey6qaefLLOJ0+yLQvvFT23/pv2ckr0bZpNqSFHtmzyd9UhfPUo/uWhEd32/dqILp+6PDzcq0IOpVOLGHWbGtUEuA9gi8h6WuuyqvZFzGQof05rbeOw4IkzoVHNDNkQcjR/UOkfpirCxKl1GmFOnUKNuJHkOMTTZCuqTNkgK1DOyGyk0ZHeQxS1D6cU/s9su+mLtRy9LGlAbDqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3LezB8GdLaGtke1AecFbnogarI3shZJm8uE+PsWHr8=;
 b=fyPCuhAuKvVl8v7YVi13vO6j/LAz3uweIk6PfGRKETpkTvHJeX/O6/ogxlps4Crnj3JkyfclrA7PkG+ZhiYnTKmWX6JvE+PgVmnJqAsoDI00x5f1CxKOjPevu2zMRz6vNUBusjXFDHULXTMgN0yOkF7IipNONvzh3XvOjDVuAow=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB7847.jpnprd01.prod.outlook.com (2603:1096:400:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 15:09:28 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::e087:7d56:2785:ec8d]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::e087:7d56:2785:ec8d%2]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 15:09:26 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 3/3] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC
 support
Thread-Topic: [PATCH 3/3] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC
 support
Thread-Index: AQHZK0vjFhB89lgWXUS7KcNy34FKKq6vO7oAgAALERA=
Date:   Wed, 25 Jan 2023 15:09:26 +0000
Message-ID: <TYWPR01MB8775E63B3C3F5E0F3AAD2BBEC2CE9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com>
 <20230118144747.24968-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXGDETQfOZ4S6_0AZa6QCJ3Kv=hMVHHS7j7tcNJ76GaTg@mail.gmail.com>
In-Reply-To: <CAMuHMdXGDETQfOZ4S6_0AZa6QCJ3Kv=hMVHHS7j7tcNJ76GaTg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB7847:EE_
x-ms-office365-filtering-correlation-id: 8c35f221-3b07-4ce7-c73b-08dafee62668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDQgVkid4vNSeJTHowGd0AsOMhyv6KE7mvifqJywoafnRzGUJYSavnadLXCE+VY0RkYO6iygr+nnNyt1w2LKOYDHJVe2n8XqWWfj5VtGHdBaEy3FnWhBjfB8RCsCvIxF4FlTdEFikbQ3b8ruWlaYBoVqoxUmHlVfBon7zV5qfF3CZKQzE2uSdupioO85lreiuf4g1EcyjsYyX/TkEer3ccsSm57wmUcXhVt5spafMTfNeFsRCTFDien/EDXcQytGqYXQNe9uX0sAi/uvudOI7JN+PWJo6/0L/e4w/YZBX4YSt8HdKemjX3DTbNbn2PlhRSxweFqBh3MKSH2rxm5/vjaVanh7zGA6Jl7bdYFbV2Oj/LMeeFQaTrJZh8W9xj1DhmeSBalHupKq6uKl+d6dG5q6kvmnJoixqCq15AOyCrnQU4m1kO3PNn0PXSn81CwMpfheAvrKVelCEg5uSppCaGie6ogNuD9pT0vQNairA33hzcFaumnEyXB1nvLl4JCoGT/Dj/faK3KQvDtr1XH4lHJp/R5HVZ5gfnO6nfKqqkMGwkENug2+CGgcuMdOPfIyRPjAxZj92zDEdH5tPcj4bf+vk7A8uQNE67OSDgz5O3xkuNh0hYKfSnVNXZgipsmeF+mF2/CN1fkZl2CXrIEQkYuASPw9dGgxFtMGLaELxKhRpLqtqqR9TX0r1WPeFz8x5SkYPbHu1MEfWhIdY8O26g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199018)(41300700001)(52536014)(8936002)(38100700002)(122000001)(2906002)(7416002)(5660300002)(83380400001)(53546011)(6506007)(86362001)(186003)(26005)(478600001)(9686003)(7696005)(71200400001)(64756008)(76116006)(38070700005)(66946007)(66556008)(66476007)(66446008)(55016003)(8676002)(4326008)(6916009)(33656002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXpYeUlua0pnR3BCSnRFVDNZekdGRmVtbmZhVmNHVzFkTVhmTGQ1UFpTRW5T?=
 =?utf-8?B?WGlEVVBmYlJmSXVCVmxELzVDWHFrM1pCa1g1dDVyOEJBcW9zTmhaUy9ySCs3?=
 =?utf-8?B?M1ZmWEoyVE0vMm1EUnNwbE5qTXpDcHJLQ0VPV0dTK1dQNTlUejNNR3MwMGJa?=
 =?utf-8?B?U1ZucnVtajZTTkV0S0xTVDJUdHhzajNHczlkMzNLRWI2SlQ5NmdSQjZ3QVhJ?=
 =?utf-8?B?b2pQaVpVb2JpelRKWTlWVmtQMm9DcG44dEt2YURYeEpkVHBGNEVrcWczeVlo?=
 =?utf-8?B?OWhiRnROaTZjb0RJL1dhR2pwL0lDbnZreDB3dFp0L2JldmFuQmpLbzFqWTVV?=
 =?utf-8?B?SHZxUlArZ0tXNWVtM1ZQckw5N2FvUkV6dllEeStibS9BcC9CV243QmN5cmFV?=
 =?utf-8?B?L2dKc2xmTmcvVGtxRHZSM0tiQ0dYSFp4UGE0MEhzVUZ5czlhaDNCNk1oVldW?=
 =?utf-8?B?dXYrVmNiVUovK1lETFcyNEozQjhYUFZ0SHMreXMrYlgzY0RJZWVSaVVMcmFC?=
 =?utf-8?B?RlhGeEFxUjVRQmkwRVB5QmhjelNIbmsrTHRrTkJqaGpVNXU2R01XQkNDMmli?=
 =?utf-8?B?OTROYkg2L2ZPQ2IwSzFPVk1SUXphaUpxY2RrcUIzR2tKZURpbEVFcHlmWnBZ?=
 =?utf-8?B?Z2t3b05SRW16Rit2eWl6cGdHSHdvTDVCKzdYNm1zUjdUdDR2OUFOOEdJUVBj?=
 =?utf-8?B?Y0RTYTNMZDU1NFFYSGZ6dkliZUhISC9wYy9mUHJxY2JCTkk5dCttZmx3Uk5N?=
 =?utf-8?B?a2QvbTdxTlcrRVpHc3ZNTU85cVJheTlMT2t1K0EzMHNHTFI1ODJXRTJxSzdz?=
 =?utf-8?B?UjBsZTY0Q3gzdVJiK0J4eS8vNnBTUStOd1dEM2czK1VrV2FiNjcrdkJHZG9v?=
 =?utf-8?B?ekRyTWRlR1lXU2N2WWhUK0dhRm1Od2hnVkhjb05PU0l4NmJ1WXZuRjdPN2hZ?=
 =?utf-8?B?QmFSU1pYdlIzenhiU05keitKVElaNW1XczNCUGt3YjlJdjIxQVZVRGkySTFL?=
 =?utf-8?B?N3pUd3RFZUZvbWVIMTBRWCs5SmVzN2lwNXV3Vy9GTWpTYlNQNWRkVlZQMVlJ?=
 =?utf-8?B?Y2luWU9zQTUyN3lJYU1NNlEwNS90dDh6R2NIN0tFUVRHaGpjMnV0MkxhaXBt?=
 =?utf-8?B?eTlHOWtCbmh4RUwzbFpiQm5ZUnhyd1hueDdraFBEVWgzK3Q4YnF0U0NlME5Y?=
 =?utf-8?B?bms5bmpBU1VqMDh1NlZoc3QwUm4rWEV1Q245UzZGRXF2K3JrSVlzZHU4WHR1?=
 =?utf-8?B?Z0N4eG1jMkZocittdU9LY2xjZ1VaUHN2UWN6WG8zYUpBaGU2REtNZWNtWWQy?=
 =?utf-8?B?ellhZHNUYVgvUVFZeWJaY2wzYWRWR21DMGRYUFh4K3dJd01ueXRNNkt4Y2ho?=
 =?utf-8?B?ME5RejBqV3RqR0x5SHhReEFQM2NGMUZJNmg2TnBKT0dtQ1FlSFhOVWpqUlZX?=
 =?utf-8?B?d1dGUE40cVhkcm1lQUp0U2VSQjlsOGtmK0xYZWhaWEVtRmo0S2U0RnNIdUNv?=
 =?utf-8?B?bXl4SHU1RytuQnNmU2Z2bGZGT3V5R1JxZDNKQ2xoR3JGdjlIVmg3YUJ4QzBm?=
 =?utf-8?B?NkhITyt4dXpVaTlkL3NlVkcwaDJKNWpsK3NKTXVSeU1QNWlPQVRvSjJVL0dF?=
 =?utf-8?B?bjIxSktjYmhxMDhkc0FTTTIyb0tibkNZRGRLUzFEcHZqM3d4d2Rxa3ZUd0p1?=
 =?utf-8?B?M2gweU5qWVhmeWVsWUVESThVR21oSGVyWFVuTlVPVitBc3N4NnBSSDVab3Br?=
 =?utf-8?B?QkthRVp3L3pTandUaTJHRm9PZlpWSmloMjU4T2pTemlVRzBHS1RqWDFKZjc0?=
 =?utf-8?B?bzRFSHFQRWF6SW10ZXFOOWxJZXB2Y2dVK2Z3QUplYjZCUGZlOHRJd0dBRzlO?=
 =?utf-8?B?dEZ6di92Z2dwaG95bnVBUjJrK0tNdTFXQ01Fc0xacmVDMlpER05HeHBvTTk0?=
 =?utf-8?B?bUpOTkd3ZUs3YUlKNGFDVmpsZkxEN2lEMFpOVHlpL01ydWxlcitTTFdjY0Vz?=
 =?utf-8?B?and6M1VwVWtNSEVXMlIyMEt6WGpFbm92b1lJM2hNL0dCb1hDZE9EM052MG41?=
 =?utf-8?B?VTM4VXpHaXRBaVcxN3JlNXZnU2NsR0VSZjJBbFJ6V3JlQy85U2t3Z251TjVE?=
 =?utf-8?B?dXJLN0Y2SGFRTkRCcmdRajhRS3lXdTVSYVdGNkplV2VwcFQwQ1FzMlhQam5X?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c35f221-3b07-4ce7-c73b-08dafee62668
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 15:09:26.6523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cOnac+1fjEqwvyTdC9s76LMAK60E/xvsAAWwW+CY/o+LxCfRPIG3G3PHkpuKW8krQ7F5cP6TghuKuN6uZUVccz3vK2XUnNIegiBG04H5p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiANCj4gSGkgRmFicml6
aW8sDQo+IA0KPiBPbiBXZWQsIEphbiAxOCwgMjAyMyBhdCAzOjQ4IFBNIEZhYnJpemlvIENhc3Ry
bw0KPiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBUaGUgUlov
VjJNIEVWSyBjb21lcyB3aXRoIGEgc2xvdCBmb3IgYSB1U0QgY2FyZCwgYW5kIGFuIGVNTUMuDQo+
ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBib3RoIG9mIHRoZW0uDQo+ID4NCj4gPiBQbGVhc2Ugbm90
ZSB0aGF0IHRoZSBwaW5jdHJsIGRyaXZlciBmb3IgUlovVjJNIGRvZXNuJ3Qgc3VwcG9ydA0KPiA+
IGludGVycnVwdHMgeWV0LCB0aGVyZWZvcmUgdGhlIGNhcmQgZGV0ZWN0IHBpbiBoYXMgYmVlbiBj
b25uZWN0ZWQNCj4gPiB0byB0aGUgU0RISSBJUCBkaXJlY3RseSBpbiB0aGlzIHBhdGNoLg0KPiA+
IFdlJ2xsIGNvbm5lY3QgdGhlIGNhcmQgZGV0ZWN0IHBpbiB0byBpdHMgY29ycmVzcG9uZGluZyBH
UElPIHdoZW4NCj4gPiB3ZSdsbCBoYXZlIGRyaXZlciBzdXBwb3J0IGZvciBpbnRlcnJ1cHRzIGlu
IHRoZSBSWi9WMk0gcGluY3RybA0KPiA+IGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiANCj4g
VGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvcjlhMDlnMDExLXYybWV2azIuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9yZW5lc2FzL3I5YTA5ZzAxMS12Mm1ldmsyLmR0cw0KPiANCj4gPiBAQCAtNTAsNiArODEs
MjIgQEAgcGh5MDogZXRoZXJuZXQtcGh5QDAgew0KPiA+ICAgICAgICAgfTsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsmZW1tYyB7DQo+ID4gKyAgICAgICBwaW5jdHJsLTAgPSA8JmVtbWNfcGlucz47DQo+
ID4gKyAgICAgICBwaW5jdHJsLTEgPSA8JmVtbWNfcGlucz47DQo+ID4gKyAgICAgICBwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiLCAic3RhdGVfdWhzIjsNCj4gPiArDQo+ID4gKyAgICAgICB2bW1j
LXN1cHBseSA9IDwmcmVnXzN2Mz47DQo+ID4gKyAgICAgICB2cW1tYy1zdXBwbHkgPSA8JnJlZ18x
djg+Ow0KPiA+ICsgICAgICAgYnVzLXdpZHRoID0gPDg+Ow0KPiA+ICsgICAgICAgbW1jLWhzMjAw
LTFfOHY7DQo+ID4gKyAgICAgICBub24tcmVtb3ZhYmxlOw0KPiANCj4gRG9lcyB0aGlzIG5lZWQg
Im5vLXNkIiBhbmQgIm5vLXNkaW8iPw0KDQpJIHRvdGFsbHkgbWlzc2VkIHRoYXQuDQpJJ2xsIGFk
ZCB0aG9zZSwgcmV0ZXN0LCBhbmQgSSdsbCB1cGRhdGUgdGhlIHBhdGNoLg0KDQo+IA0KPiA+ICsg
ICAgICAgZml4ZWQtZW1tYy1kcml2ZXItdHlwZSA9IDwxPjsNCj4gPiArICAgICAgIG1heC1mcmVx
dWVuY3kgPSA8MjAwMDAwMDAwPjsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAr
fTsNCj4gPiArDQo+ID4gKw0KPiA+ICAmZXh0YWxfY2xrIHsNCj4gPiAgICAgICAgIGNsb2NrLWZy
ZXF1ZW5jeSA9IDw0ODAwMDAwMD47DQo+ID4gIH07DQo+ID4gQEAgLTc4LDYgKzEyNSw2OCBAQCBp
MmMyX3BpbnM6IGkyYzIgew0KPiA+ICAgICAgICAgICAgICAgICBwaW5tdXggPSA8UlpWMk1fUE9S
VF9QSU5NVVgoMywgOCwgMik+LCAvKiBTREEgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgPFJaVjJNX1BPUlRfUElOTVVYKDMsIDksIDIpPjsgLyogU0NMICovDQo+ID4gICAgICAgICB9
Ow0KPiA+ICsNCj4gPiArICAgICAgIHNkaGkwX3BpbnM6IHNkMCB7DQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgc2RoaTBfcGluc191aHM6IHNkMF91
aHMgew0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAg
IGVtbWNfcGluczogZW1tYyB7DQo+IA0KPiBQbGVhc2UgbW92ZSB1cCB0byBwcmVzZXJ2ZSBzb3J0
IG9yZGVyLg0KDQpJJ2xsIGZpeCB0aGF0IGluIHRoZSBuZXcgdmVyc2lvbiBvZiB0aGUgcGF0Y2gu
DQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiBUaGUgcmVzdCBMR1RNLCBzbyB3aXRoIHRoZSBhYm92
ZSBjbGFyaWZpZWQvZml4ZWQ6DQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiANCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRl
cmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0NCj4gZ2VlcnRA
bGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNo
bmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGENCj4gaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20g
dGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhp
bmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExp
bnVzIFRvcnZhbGRzDQo=
