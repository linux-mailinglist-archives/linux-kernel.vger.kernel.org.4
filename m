Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A6745E48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGCONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGCONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:13:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F4106;
        Mon,  3 Jul 2023 07:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVBpuq4pAruc/gTXTriS6NhYh96kvFpAFCjWmEiqt0lqX+2Wr9+iYrhoBzjcdxmwlvZ4jXsq3ACiCjayd43yFFQfnww8ixZFriTgC9e6W0KVJ4ueu0Z+/vO+B8yiJMpVuHRJkpO0y7YgBhnhQftVwJBuPEpCCipH9Qz/spY1XhAiaOgou4kL9enz4G1xV5INnEOZqKXwuJ4b/ldg76n9wXIQ/hc3LuFa3WE45G+bdjNWJXw6iP5wyInKTtm6O1xt2ZBGadEN3sPDIvRZTUwds9O1h+P6o0EnbNGUWVZiPX5M9Yk5JlgMcWkiWhy5sbI0VNvwg7McL71Ij9G+k0c9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLX1TEaQE7l8vkJaEuv2z/a6P87cp7V6QmQgGehdjrs=;
 b=WuRRIeb3a7j6JFSYx9U0+CO54ZhFM7d2tUtdzyENHiYSaYNUeAu/iENS4LwfFohH3R/7nn0H8/V3nwQS56FaxOtUzXogrlhVdD5FenOY40EYkdCI+/+J2CGt1Lu6TAGTS9x0XvbU/mGoF4Jw/k0fIYyzw1PstbRv3iHwODIELuVc9ZrcWuKGvlnodi9Ps+h3mlHjtYzEdwtwW6lfK+pKFxOEQPOET6MtNfafffmvpdmOxNfYykYJyOP/x2h4BHm+8kzpE1fhkD16NnN0a/D/HqV1EZcvUDOC0cgJ6eW1fqZLT9pwgktAgKWgpw7UONucjW/Zmwkbgv9HSI9k+bzFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLX1TEaQE7l8vkJaEuv2z/a6P87cp7V6QmQgGehdjrs=;
 b=ahwsdDWisnfSDoiHwV4PFddr3BY+bEaUK9w9d2JG1IOGFozSBa+ZW04pZUp3eCq4FlNh9FlMb/96D687jfSawDfh0CH9YKLMA4JLC2wHP1CwBuwNPDSE5HZ0MHpLtCZLGlReJTZvpNtRjK68M/SqyJpItLR0ma5gviwr1iwPQmk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10063.jpnprd01.prod.outlook.com (2603:1096:400:1dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:13:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:13:15 +0000
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
Thread-Index: AQHZq0sktriyRHMRaU2I/KvG3PLB4a+n7sYggAASdwCAABiNAA==
Date:   Mon, 3 Jul 2023 14:13:15 +0000
Message-ID: <OS0PR01MB592285AB361A6C25CEDC21F68629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592217C4028606B67B39C6858629A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8sXcHP2AYYLLONLLBDVctMb=fnU=D4+6hNoHGx5Dk2O3Q@mail.gmail.com>
In-Reply-To: <CA+V-a8sXcHP2AYYLLONLLBDVctMb=fnU=D4+6hNoHGx5Dk2O3Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10063:EE_
x-ms-office365-filtering-correlation-id: 5923eb15-c480-4943-e1e3-08db7bcfa482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 246blDy1RMNPZR+Ylreue1cAFHrFrm82xGlfMlmjCfCOqMMAbaN/kOtnSiuNt5X4W4gkCQAwLCqnKtcV9HoseKkkrHnhbqENn7iQ1vR/bunjtKxp8keEBjwPu79lUgpmKXfo/V3zbEVKMffa3kxXMFIaj37UQighimGFQ2YiJ38jUw8crdj3z35VAeheYozTOgIH65aNGPVPizouPj600dqX+yNzamcKdStlou54/wHnnWQOe3POsbODjfdXs59KmRKW9MNlMftnAnkAbPJ2zp7wGuE6d5qMoHgWXjNTq/wm6bUwR3GHZvUSTZG3nRTbUQmjiwsa19R0ecPF13T9VCEZ0pv8EJsFw4r9ZZAo//C9HEwEc4JYlU0SZn5uUV8aZGFTOqF2lSClvSp64Vb5++h4s1k9PiX5kq3pLXcOIAPBASl/Nx+adYVkSfG8dXdlJwhMTrgiZ3ZTMP3B3D2XgHUvL9mGxV+fLI+Xfnd3ZerrOuEvZcZInu/cQ2gblDAHP7L515LBq3y1T7ZaLgaxiL8X+rN2nkZtnP/LpdTnagko+26PtnC683mJMnrzK5uOMs3WJeAfvvFGtESy1Qv+SvssjmoDmBzlQVYO5O4HhY13YQ7YZl4+f+MNWm/wYolK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(52536014)(8676002)(8936002)(7416002)(33656002)(55016003)(86362001)(186003)(478600001)(26005)(6506007)(9686003)(71200400001)(107886003)(53546011)(7696005)(76116006)(122000001)(316002)(6916009)(66446008)(4326008)(66476007)(66556008)(66946007)(64756008)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFBYMUhWajZ2cEhtc0IxS1M4L21xQ0Y0T01VbkZVdEdyalFhM0ZoV2FTaVM3?=
 =?utf-8?B?ZVlpY1VEaW9ydElxT2U5MFk1Rk9yTmJvZW84azAxdTNKcm1td0xrS295NjNU?=
 =?utf-8?B?T3cwZFM1Mkp3MUgwTTQ0OU1NYWVjK2tEemlFejM4bkpGZGlLY3BaSCsxSEZs?=
 =?utf-8?B?Tk9USjF5QTR3c1hJc3d1YklSR1E1elRNYnlGS2VFc3l0bDNZU3B0dXhoYTlC?=
 =?utf-8?B?SytnWHloaVBKb1grU0IxMTZtRkZRZXQvMk1aS1QxVXFTWlh2dG8rS0g5cmNJ?=
 =?utf-8?B?VG1EY25CTHQybFMrcHhKOFpTQk9XN3c1QWRxL212bTkzRHJTYk9USnVWWDhi?=
 =?utf-8?B?RHVOQXFTbGlSaTJmSzA3ZVZZc0g5V2M3ZW16RTJ5V3VaQXg1R1RqYWw0SHdk?=
 =?utf-8?B?NzE1SC9CdE5zOERuLzVud3VNMVo0UUFvaVIvL0RrLzNnWjYvQTgrcjlZVHdM?=
 =?utf-8?B?dUZsaWppRkFDL3ZaYmxNN2sza0tDTE1rWWhhTXkzQktwMUJJVlI0TE5aeXFy?=
 =?utf-8?B?Umw4MnlFd05LS2FVLzdBcjZ2MW1Pemw3Sm94OXNMU3lnekt1R1VZRzc2RnJM?=
 =?utf-8?B?UkkzYVBIcUtzS0N3b2x4Y216UlVmaHNMTTJRWHYzSXpyTk5NbVp0cHE5eHhG?=
 =?utf-8?B?aGxjaXZYSHpBTWxXcnpxNk8wNUhycDJJRUMxdU5sbnU0RTdPNzJSVnFuYlVE?=
 =?utf-8?B?dWhMMHExdGRhVCthQXFEOUpFUldwakZWRndPWjR0U3BIazR6eXdmNHNFbEx3?=
 =?utf-8?B?SnFKQ0VHeGJuUTRScXE5U2FjcmNKK091UWcyNlFRanNXRzhUYVVOVnVsb2l6?=
 =?utf-8?B?U0M3dk9SYnpmNU1OY2x6RjZ0V0x4NUJpRVlvQXFMdWFyUXE4R0VYTzFZam9o?=
 =?utf-8?B?K25TcE1EWURlN3RWay9LRHl4VUxFODJHQjhDN05yUHVqOWM2QWlCbkJvWHFk?=
 =?utf-8?B?YWJ1ekpaekIyZ0k3N0tOUTFpN2g4NVhCYXFWUjVNZVl3dmoyeHFRZ0YyNjEx?=
 =?utf-8?B?ZXN4MXRHU0JOanZ5SHFhTTlXTGE3TExwL3Eyc0tDdmJxbis5eWwyQzN0WlUz?=
 =?utf-8?B?ZmZvaGxWSTBUSzg0aTVpVmFvTGxwUUIvTHBCenV6emRHenZDSW50Qnlqa20y?=
 =?utf-8?B?UFlqTXFVOEhvZG5KZWdCZkdqQjhFUlV0NWNodDJrZFk0NFYvcXJ5anZ4OGtl?=
 =?utf-8?B?ak1IaEpUcXV0Vm8xc2dRRjltQU8zYm1jVWVxNGJycmtsOGlTckt4bkZxaG01?=
 =?utf-8?B?QVdwelVWK0RiMnUrZVJUelNSZzZZUEhjLy9WTjNOR05peUpyMEtvM3pDRnJ6?=
 =?utf-8?B?YWpEZm9XTHpxUWNnbllTeDQwMFRZLzlCbSt3QVFVNmNyMXg0U0h2YlJPelZO?=
 =?utf-8?B?c005Y01vYVE4TysxMHRBRU1CRDNKSmkrL1cyR0F2eVRjcVdVMTduRkIwZU9G?=
 =?utf-8?B?YXo0aWkvZFFmTjFNZnVJRWtkMFVEYmlBNHFpb1AyNVFnVS82YlRYY3B4YjBx?=
 =?utf-8?B?MTViWE5Uekl1dW1SeXRCQ1pUdy8zMzlyc0RTbSs0ekNhYTFob3Q0OFFCZmJw?=
 =?utf-8?B?TkNrYWc0ejZZSXVXcVJtbVRHWXUwT21oT0FPTXhSMS9aVW1vcmgydktRa0Ev?=
 =?utf-8?B?RE1YUzdPV21QRHc3cFppZ2xUTXc4ZGR3WnNWdFBuWnlpN1d3RzJjTGZ0QVpx?=
 =?utf-8?B?Z3J2VUdIbzZBN241blFpSDZ4UUNkenV5M1pEL29YQWlrYk5qL3hSYXRtSkI1?=
 =?utf-8?B?UXhnYkdpbk9qWWJ2WkFxbG5nbW5aZDM3Um9KckppZ3ZkU1pNeVlwZW95SXpZ?=
 =?utf-8?B?UHBTb0oxQ09DL09qU21Fd2Fua3VIeHU1MkFWM0QzZUZJR0tMYnh2eEUvczVy?=
 =?utf-8?B?WGV5dGV0VWZBc0RkdGZUUWc1OEdBOU5IV2UrZW9BNy8raGgxL2RKclVWVGg1?=
 =?utf-8?B?cFlMS1lLVjdDMmVhcFhXajE0VXp3b1UzMmJpWEdIR1RGQlg4eXBBMEsxamdR?=
 =?utf-8?B?Q2w4Y3RxK2RKTVR4THIxSTVqVE9nM2V4N2hrVmg5MXVWbWlMZW9LZWgxcjJU?=
 =?utf-8?B?RklYN3N4UmRGUDFaT3l3UituWjlkbmlKdGVxNDlackRUT2MzMzY2a1FuNE9a?=
 =?utf-8?Q?OqMfXdES5twYLmMogq3Gh08mV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5923eb15-c480-4943-e1e3-08db7bcfa482
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 14:13:15.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smQmyOuiOemZAok0ogmENsIu9tBIz9Pzf+7UYYhLZAXocUlX78+9w/srvpCgr64PsxJoNiI3t5Q5qUHpPusUnhyy1HSj8Pji0FF6EbEzT8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
ZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBKdWx5IDMsIDIwMjMgMTo0MyBQTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiBDYzogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRl
ci5iZT47IE1hZ251cyBEYW1tDQo+IDxtYWdudXMuZGFtbUBnbWFpbC5jb20+OyBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgTGludXMgV2FsbGVpag0KPiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPjsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWdwaW9Admdlci5rZXJuZWwu
b3JnOyBQcmFiaGFrYXIgTWFoYWRldg0KPiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS80XSBwaW5jdHJsOiBy
ZW5lc2FzOiByemcybDogSW5jbHVkZSBwaW5tYXAgaW4NCj4gUlpHMkxfR1BJT19QT1JUX1BBQ0so
KSBtYWNybw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4N
Cj4gDQo+IE9uIE1vbiwgSnVsIDMsIDIwMjMgYXQgMTI6NDLigK9QTSBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUHJhYmhha2FyLA0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21h
aWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBKdW5lIDMwLCAyMDIzIDE6MDUgUE0NCj4gPiA+
IFRvOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgTWFnbnVz
IERhbW0NCj4gPiA+IDxtYWdudXMuZGFtbUBnbWFpbC5jb20+DQo+ID4gPiBDYzogUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPiA+IDxrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBMaW51cyBXYWxsZWlqDQo+ID4gPiA8bGlu
dXMud2FsbGVpakBsaW5hcm8ub3JnPjsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
Z3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IEJpanUgRGFzDQo+ID4gPiA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+OyBQcmFiaGFrYXINCj4gPiA+IDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT47
IFByYWJoYWthciBNYWhhZGV2IExhZA0KPiA+ID4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtSRkMgUEFUQ0ggMS80XSBwaW5jdHJsOiBy
ZW5lc2FzOiByemcybDogSW5jbHVkZSBwaW5tYXAgaW4NCj4gPiA+IFJaRzJMX0dQSU9fUE9SVF9Q
QUNLKCkgbWFjcm8NCj4gPiA+DQo+ID4gPiBGcm9tOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIu
bWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gQ3VycmVudGx5IHdl
IGFzc3VtZSBhbGwgdGhlIHBvcnQgcGlucyBhcmUgc2VxdWVudGlhbCBpZSBhbHdheXMgUFhfMA0K
PiA+ID4gdG8gUFhfbiAobj0xLi43KSBleGlzdCwgYnV0IG9uIFJaL0ZpdmUgU29DIHdlIGhhdmUg
YWRkaXRpb25hbCBwaW5zDQo+ID4gPiBQMTlfMSB0bw0KPiA+ID4gUDI4XzUgd2hpY2ggaGF2ZSBo
b2xlcyBpbiB0aGVtLCBmb3IgZXhhbXBsZSBvbmx5IG9uZSBwaW4gb24gcG9ydDE5DQo+ID4gPiBp
cyBhdmFpbGFibGUgYW5kIHRoYXQgaXMgUDE5XzEgYW5kIG5vdCBQMTlfMC4NCj4gPiA+DQo+ID4g
PiBTbyB0byBoYW5kbGUgc3VjaCBjYXNlcyBpbmNsdWRlIHBpbm1hcCBmb3IgZWFjaCBwb3J0IHdo
aWNoIHdvdWxkDQo+ID4gPiBpbmRpY2F0ZSB0aGUgcGluIGF2YWlsYWJpbGl0eSBvbiBlYWNoIHBv
cnQuIFdpdGggdGhpcyB3ZSBhbHNvIGdldA0KPiA+ID4gYWRkaXRpb25hbCBwaW4gdmFsaWRhdGlv
biwgZm9yIGV4YW1wbGUgb24gdGhlIFJaL0cyTCBTT0MgUDAgaGFzIHR3bw0KPiA+ID4gcGlucw0K
PiA+ID4gUDBfMSBhbmQgUDBfMCBidXQgd2l0aCBEVC9TWVNGUyBjb3VsZCB1c2UgdGhlIFAwXzIt
UDBfNy4NCj4gPiA+DQo+ID4gPiBXaGlsZSBhdCBpdCwgdXBkYXRlIHJ6ZzJsX3ZhbGlkYXRlX2dw
aW9fcGluKCkgdG8gdXNlIHRoZSBwb3J0IHBpbm1hcA0KPiA+ID4gdG8gdmFsaWRhdGUgdGhlIGdw
aW8gcGluLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXINCj4gPiA+
IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJsLmMgfCAxNjcNCj4gPiA+
ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NiBpbnNl
cnRpb25zKCspLCA4MSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1yemcybC5jDQo+ID4gPiBiL2RyaXZlcnMvcGlu
Y3RybC9yZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiA+ID4gaW5kZXggOTUxMWQ5MjA1NjVlLi5h
MGMyZTU4NWU3NjUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9w
aW5jdHJsLXJ6ZzJsLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9yZW5lc2FzL3BpbmN0
cmwtcnpnMmwuYw0KPiA+ID4gQEAgLTY3LDEwICs2NywxMiBAQA0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUElOX0NGR19GSUxDTEtTRUwpDQo+ID4gPg0KPiA+
ID4gIC8qDQo+ID4gPiAtICogbiBpbmRpY2F0ZXMgbnVtYmVyIG9mIHBpbnMgaW4gdGhlIHBvcnQs
IGEgaXMgdGhlIHJlZ2lzdGVyIGluZGV4DQo+ID4gPiAtICogYW5kIGYgaXMgcGluIGNvbmZpZ3Vy
YXRpb24gY2FwYWJpbGl0aWVzIHN1cHBvcnRlZC4NCj4gPiA+ICsgKiBtIGluZGljYXRlcyB0aGUg
Yml0bWFwIG9mIHN1cHBvcnRlZCBwaW5zLCBuIGluZGljYXRlcyBudW1iZXINCj4gPiA+ICsgKiBv
ZiBwaW5zIGluIHRoZSBwb3J0LCBhIGlzIHRoZSByZWdpc3RlciBpbmRleCBhbmQgZiBpcyBwaW4N
Cj4gPiA+ICsgKiBjb25maWd1cmF0aW9uIGNhcGFiaWxpdGllcyBzdXBwb3J0ZWQuDQo+ID4gPiAg
ICovDQo+ID4gPiAtI2RlZmluZSBSWkcyTF9HUElPX1BPUlRfUEFDSyhuLCBhLCBmKSAgICAgICAg
KCgobikgPDwgMjgpIHwgKChhKSA8PA0KPiAyMCkgfA0KPiA+ID4gKGYpKQ0KPiA+ID4gKyNkZWZp
bmUgUlpHMkxfR1BJT19QT1JUX1BBQ0sobSwgbiwgYSwgZikgICAgICgoVUwobSkgPDwgMzIpIHwN
Cj4gKFVMKG4pIDw8IDI4KQ0KPiA+ID4gfCAoKGEpIDw8IDIwKSB8IChmKSkNCj4gPg0KPiA+IEkg
Z3Vlc3MsIHlvdSBjYW4gc3RpbGwgYWNoaWV2ZSBSWkcyTF9HUElPX1BPUlRfUEFDSyhuLCBhLCBm
KSB3aXRoDQo+ID4gKChVTChQSU5NQVAobikpIDw8IDMyKSB8IChVTChuKSA8PCAyOCkgfCAoKGEp
IDw8IDIwKSB8IChmKSkNCj4gPg0KPiA+ICNkZWZpbmUgUElOTUFQKG4pIEdFTk1BU0sobiwwKSA/
PyBUaGVuIHlvdSBkb24ndCBuZWVkIHRvIG1vZGlmeQ0KPiByemcybF9ncGlvX2NvbmZpZ3MuDQo+
ID4NCj4gR29vZCBwb2ludCwgYnV0IHRoaXMgd291bGQgd29yayBpZiBwb3J0IHBpbnMgZGlkbid0
IGhhdmUgYW55IGhvbGVzLg0KPiBGb3IgZXhhbXBsZSBvbiBSWi9GaXZlIHBvcnQgUDE5IHdlIGhh
dmUgUDE5XzEgcGluIG9ubHkgYW5kIFAxOV8wIGlzIG5vdA0KPiBhdmFpbGFibGUgKGFuZCBzaW1p
bGFybHkgZm9yIHBvcnQgUDI1IHdlIGhhdmUgUDI1XzEpLg0KDQpNYXliZSBpbnRyb2R1Y2UgYSBo
ZWxwZXIgbWFjcm8gdG8gYWRkcmVzcyB0aGlzIGNhc2UuDQoNCiNkZWZpbmUgUlpHMkxfR1BJT19Q
T1JUX1BBQ0tfV0lUSF9IT0xFUyhtLCBuLCBhLCBmKSBmb3IgdGhlc2UgMiBjYXNlcw0KDQphbmQg
dXNlIFJaRzJMX0dQSU9fUE9SVF9QQUNLKG4sIGEsIGYpIGZvciB0aGUgb25lIHdpdGhvdXQgaG9s
ZXMuDQoNCkNoZWVycywNCkJpanUNCg0K
