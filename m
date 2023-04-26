Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341976EF64B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjDZOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbjDZOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:21:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191647298;
        Wed, 26 Apr 2023 07:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5kT+WG8nS3EHSbdRQ5klKkozpHotFpZLKjqJx/OlgDMOWDxFsJhcEOLBINq41MUj/Ojrn7mDKXcKMf/jVr7stpkYysKV1oAVKweG1UWVsy6lT3CX4JUcR4M1V7kPxDLtvFJW2rCNWD6t/w0Hx6/UhmcfZCtZxKdhiUnyuWYzEK3GwUNMJBc7G1DhOoiE70tGgVzlxwYlyRhiJgwJ4DrTVxfvEcKZfVXoyNfTITdC0kyMauzN/gPvwKuPVq7l/4IpzvIZQBytLawYtR5mhWm4hLsubfHk4HkXzWWpYN3A/CG8WCkC+v/KfQKjKg1wEAHM6dfN68TUrX76qgkHWZNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFQd8FiwDy5NJDHjLbBvFzp9L8rv9W1diZJ65EgoTmw=;
 b=NvpfU7PcMpPhTKMwBTY8cf1PZZJHtCSLrE6SpvdiSADl55EC5XhDh0spviYG/QKegK/Ffva1qjt7hraRfjP3Eox3GkN5kwwODbI1A6pR95Avst1a1cWepTPO/JPpgFH8goEu97ACSnK56LzG2OIZ2yo81Ay9jI5yzAiuW2IMdriBCO/fW264CPkB3eDz+kR6ZWFfjnlZD/52QlUg70K/2+c6HWtRsv9KsfS2R3UBQ6Np4fCxsCkLgM11Z3WwJTYLHpZiwLq31WK8h/LOtbtYNEWb+OH28cqhfOECQmxDM8RxSfUzQD3e8gRpTMy/u8sb15oDnSJA+uQZUAGQNsTd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFQd8FiwDy5NJDHjLbBvFzp9L8rv9W1diZJ65EgoTmw=;
 b=K3y1KLHwvvOzVsETdNO9H4LbfeDB4L+8rcz4hhNjzK0LYc+mPwEHe3z9Zeiai6T+sRm1/cGw5qE0l3kZYJYhZcHs8GVBk+lj6gKZKbNaf59Qryk/RjTayP7EZ1YZxRjlRk4fnrP4lYTMSK9Qn8pFntFnwdda4B9mfvzT+Ln8G/c=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB12041.jpnprd01.prod.outlook.com (2603:1096:400:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 14:21:18 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:21:18 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: clock: r9a06g032-sysctrl: Change maintainer
 to Fabrizio Castro
Thread-Topic: [PATCH] dt-bindings: clock: r9a06g032-sysctrl: Change maintainer
 to Fabrizio Castro
Thread-Index: AQHZeCczhR3i6SSgIkq7aIkiZrlJa689pD4w
Date:   Wed, 26 Apr 2023 14:21:17 +0000
Message-ID: <TYWPR01MB8775B41054C570A70EB65BCAC2659@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230426100925.12063-1-chris.paterson2@renesas.com>
In-Reply-To: <20230426100925.12063-1-chris.paterson2@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB12041:EE_
x-ms-office365-filtering-correlation-id: 46eef19e-5f63-4b30-9403-08db46618041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Ze/iC+1EWD6/KmyXrH0Z9LWnCHcWOE75xx29yV87P7pV6tI/ORVROVA+Ao4MAmpjT01BEkZQMxb/byOnecOkRJjeafXAwJQo5esm4R4tLtiuWMxEYKzJxtVOU5/4enLykAkqKUAE79lF7lOssHVzou2/J5pwtvSdkD/pkWiPm2mDooIjXDlaR5Ar9Ck1fkjMxtLMgaTZBSod2vTLZuWQax4EmKNVBvB/190KbGtYGaED++H4U6hh02vrYZdFY9Wq6HoC3n6Q4A6KFsl4FJ142duWm2Zrl2zRUEDTIORroMUf2Ci0L146qC3x2RtEQtQmnY9+6GX8vY+o0ZuQ1aGPqrzAb43P9yi4ZWPllvvQFzEUsvVacju84SLCVd6C0QU6IPRB4eNVXPfLZ1oahGhYChDWC/rWTdSd4Ng8wO2idaSW1M3djETLkhr0siVYWVHlBfwvPvj4wVabtvwdXX/gYL+g762Y/8VzNIBYzPDCRtqgKZQHhCvjIsLsc1DbZ7G6FEsWhTPmdOIqdXeuzymeEQrpGwCGTkWGwQD2TOp0K79o2PjK4wssr9Eb5LQTZDSrUGJvKgtMPlugtr2IW3cteotnYV3rPVHfB5+ojewBI0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(7696005)(33656002)(5660300002)(52536014)(7416002)(122000001)(558084003)(2906002)(38100700002)(71200400001)(478600001)(55016003)(316002)(41300700001)(38070700005)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(86362001)(186003)(107886003)(6506007)(9686003)(54906003)(83380400001)(26005)(8936002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/vaiwMtk6o4EtntnLMVFB5YULdaW4XtFDZx2kZ1x+gPgZ17aIU/Ors3gwZRU?=
 =?us-ascii?Q?pKXxHWt6RJyCQUVkKIfiotRfjUSbHeZQq+oQz/2waGXrQ0LtraIRpnc0GBEG?=
 =?us-ascii?Q?3dNms8N3WwonY0nLgtNGmIW0yBE/schIljY8xwL9IAVSigUhDnXO+3znqGDn?=
 =?us-ascii?Q?JyPH4nqHDos4Oz3IR2qwLEmCUW3G/qxDJt4QP/awn1IGOMA1FSGor6kfbeo7?=
 =?us-ascii?Q?idxyXrRJUQjVwKxKwq/YJaN5mcsuq6KjefCWy+n27tP4PjXgNTSV9VDqBy6s?=
 =?us-ascii?Q?roq0/W0Y2DcDnoCYnKHwIMM2AJ/qgEK6qEQijq7qzYXSraxlxgVDS8caNOK/?=
 =?us-ascii?Q?4u16v3DSA39a/aPozVMWi8GIGKqye2VvmYk/CQhpLSNBHDd6gwxUkrvmxArg?=
 =?us-ascii?Q?ie82f5FdG5yYAbG0mhJhDELxELo33CdE79kZHMoDIK7o3mJz588W+sHbDhGU?=
 =?us-ascii?Q?ZwFOjiVeziwHabsbGP2abKQhpD9gYETg9CBUGq5RUD1qyh4OUcMcesfOyMHf?=
 =?us-ascii?Q?Wo99hI07FX0B9Tg8DOzotF9ANbmX8lCkmLNziY2iMmITs32F0kmq/2vbOiNG?=
 =?us-ascii?Q?QAfmZ573Q8ar2hcTh/yowntk/5u1cHXzg85s1wMqvuv+B6F31hXseoUTOHNu?=
 =?us-ascii?Q?xOdgbpD4GuTGFiJpc3OcNqiZIebItFxAkw3QzINaU6Q2BGctHl/ZrF0KR+ag?=
 =?us-ascii?Q?6+oOSjkhdXIZfzTwIUyJsNA5LXOeT1K2BjHabN3qTzV45itFmOBIlo6hdI+e?=
 =?us-ascii?Q?aNkKtRD7GZ0ATNzDKGLjTKUZqXfMBcOMPqa77HWBJZiyCjQBQwO6di5uhTW9?=
 =?us-ascii?Q?4hZO5no8zQyQrjsd2+KIW3fSgPGlDtkB2Mt9o2tWlYZ2Oa4vspOhA+IClfhs?=
 =?us-ascii?Q?83QDMErtjRPzTtGbA0V361AcgTDxrpTMRNSGB7zpMR3Fb/IeBqlQcoUaNiQm?=
 =?us-ascii?Q?hPT/co+JUZgdTc+4dwweAmaX3ozRPZIi+8hI5caP2uN8IO1N9DK1dIN+P698?=
 =?us-ascii?Q?PSqCjl4vwoZtm9aOLkhmNJo7UqnfFfRMN5PDgmCXFEVjXm7vAc3ntQhCPONY?=
 =?us-ascii?Q?uaaYklTFZuxQNbPpH+bqx+DI0GQrBepkxYw/OO89xaOpWh9zy073Jr62Qgag?=
 =?us-ascii?Q?NYIijG64Yy1ph6bVg6vIkGfi3ucSj3DXJm6NT4DTRez9ba7e3I/43JC+oh8p?=
 =?us-ascii?Q?h64oYN8BgOLDtltuH28W3WzunyOyHEg6eGj9zlHzaurg23TKhbmbCwlZlnsj?=
 =?us-ascii?Q?bvGl5XeS340FKoTpIFnxWrmu7p+5+MiI9gBWUuBCYPQBHNNEcTRGrF9jzgSb?=
 =?us-ascii?Q?2VL1h0HiJeKB4yqMKK/O1I5VipoQ++VBItjoI2Ft6juV0n7uPLxjTnNw1Y7N?=
 =?us-ascii?Q?UmDZpFlmGHxoJCTzvwY+Quoq6kcsGKbXhWx+qDFZdR+5WLts8Rm26gHlGVFe?=
 =?us-ascii?Q?F0re+ir9sNPxzAclYoV/R6rj3nkv63FK2M2OihZ5rtmi/FXQJ39yFPEyCCfr?=
 =?us-ascii?Q?PZfoCqVH+7gPS6/iqr63pv7mxFHEfsm6RlAReM01UdWMt+iMRSM8wtl78jUe?=
 =?us-ascii?Q?A+8TTnSEbZELsZ+Q4fpQOR1znLSdMgEiUFKMZuZ6dP2yvBnyGdr6X/JGyaeJ?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eef19e-5f63-4b30-9403-08db46618041
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 14:21:18.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQVVSNgP9WlA8ZPU8JM81kUxaSdMNtyUnNMGorC6K0AmuWONa0eXx1GU5JD6zF2nR6zqH3RZzDm4U/hN5BpPvMyDnEwDMp35Vh4dqUn4hK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thanks for your patch.

> From: Chris Paterson <chris.paterson2@renesas.com>
> Subject: [PATCH] dt-bindings: clock: r9a06g032-sysctrl: Change
> maintainer to Fabrizio Castro
>=20
> Gareth no longer works for Renesas.
>=20
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
