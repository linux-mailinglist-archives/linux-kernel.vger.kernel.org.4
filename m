Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211772275E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjFEN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjFEN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:27:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46DDA;
        Mon,  5 Jun 2023 06:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPmi9MuUHMBFh0tPSrAQBY6tGlLeFyzPAephwEGNVJaSNe02nY7atNGlaw17wWkg2ayKVc05yyjVt39usG7rloSa+XAC6RnshbId/qJM9ugTBIcfd1OjE88aCo9uOdzRTnWF5n12Cq+D1BOAI1XaAKz+hSvQ7T+jqrNS3Or+c2EDor4Riu7xjwp3fwlzRfuP8nAEYKPTkKGF32TDFMAMRsQaEo1rFr0U2dX/yTNeDFBVbFN0d+ZKi5z+OAXVMxLYfDp3Y3/AJmJRrw3h9mgGZSXf7HuxT9ypnqHJM4LPXbqrg6E8FVJZAyHJSnRu8zuhKRY/ePvPdUjjsgLsg9Pzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNv7zCtv5R4coYkXfFKa7lkgO9fYlpkdBnuqlFiVCRE=;
 b=Y9nh1GFzg0Zy+tWfT3S7IEsdh5nFDF4sV2kqSkAJhuYar+r/M/U8QmYu3qYKMGPf/2kW9eAOqkgp1z6lVeme9uki5KCFvmpsGDyE5MGzLRUuEYsWrrYf3HbvhDVdfs2DrOmUaJZUVIHdlodK0+EDwwhz77m9cDoC8KzzghiLum11jd+jrwVtSxwTJWT8kB573NSGraXGhGpbEuZyU77m8aqL72L+8W4Bsj+jy8IBCDRMSDUgTp04oQDDeayHIMfcSRYx6WMJFSxsr5EVXFBd+4Uuz+QEjO2VhXWjWWEitTjqdkvQHoqCebVqc8aE7Kh3K8vOFt776FDHc6Ih8OmG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNv7zCtv5R4coYkXfFKa7lkgO9fYlpkdBnuqlFiVCRE=;
 b=n84ocE1O9wBNxDpU6AjKoB0Y89ndrnhn5S40hrUBsN0wifRjGwJ3sNqO9l84hjF9V3tMhdiZi4Z1foOKDGZ3U1Eax1ijTaL2rQr1XpHukQ/i6H6/gBZdxp8V9jjAyIF6owTWLBkyVRw28uJorxWHXnOdnC1RO6dwDXPl5kS4piU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5884.jpnprd01.prod.outlook.com (2603:1096:404:8056::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:27:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:27:42 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Topic: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Index: AQHZlV30mPNpl/zsHU6y3jXrqwORkq98M1iAgAACh6A=
Date:   Mon, 5 Jun 2023 13:27:42 +0000
Message-ID: <OS0PR01MB59225AA8E68D7976BB57A0BC864DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
 <31b1f83f-6baf-46de-a04c-373ad20a6c24@sirena.org.uk>
In-Reply-To: <31b1f83f-6baf-46de-a04c-373ad20a6c24@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5884:EE_
x-ms-office365-filtering-correlation-id: c29ceb5c-e3d0-4e71-c55e-08db65c8a43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zVgK3CN5CoYGeUFzIl7oo/VvsiTRzgmGClj799M22YglE5bTXcXH0hO4qQAB83ja8uugncaKiIAvirfD5HQAhRdMlOJ7VKzHxXQtXx8AvzWRFerSxqfoH6oAHuJ2tz2KeDVtOZ4BiThypGuIcKgiKcnI2bMYrWElbjUd4MUjlqRwUFZOWJqR8k4iErhlPFN9TUOqxF28k3Ct2FjMtgblcm0/7Wc8jiui0xqIdnMaaAjpYKYPi/B3Nrol0P+DlV0WF7sNFIEgUUJkvIhz0vjCdRjkbgzaxPFxOZHIiU7l0Qiu0szruvMv32WPkxNBP8Xz81pw4I1fSbLHO0kmuStzsO1KfqSEeQZoYaykZiYmgZ2Y90ChZXeN9dpm2BSmd7ZutbZLogFhJGK6De888zISeNkkJxFdUI93DJ7mg84IVCJg5qoMmWfrOCR+JhNq4JQr4jyMxRjNANSE3mIJ9WHnlyBRUuR8j7L08YIzLGm373y55qgBL1UIjXjABOpfU92jl56skBJLctEqfOAFtNYL6M+F0F8Hl1QwveECBzal/u7cZIotLBAZp+QGHpDoGLCJvc7kM1VINEQ58pd1udRNxT/pLsPz1DjMWj6IvaN3+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(966005)(7416002)(54906003)(33656002)(55016003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(76116006)(66946007)(66446008)(66476007)(52536014)(66556008)(64756008)(122000001)(5660300002)(38100700002)(6916009)(4326008)(86362001)(7696005)(71200400001)(2906002)(107886003)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XxgizD10iV65CWSNnJkrYaJIOMRcTA0rbhaQHCIljrkTT0V5kSbK9Y6WXCqj?=
 =?us-ascii?Q?8n7lLG+nNxwQES9i074PUN5Js75Juv1Wy4uEc/BMGnBATLc+3w/n+PZPZwjL?=
 =?us-ascii?Q?1NIvIIIDr4uqh2FX+9OVepWY+RUslx/ZeFJJPOcye/C/GVEAsKihpINJpMJe?=
 =?us-ascii?Q?9oXzoCFjiNkBySn8tHblw9A/dYmHpOT7pOI9acOafPgFV9oV6bAfQaZ8ZY5n?=
 =?us-ascii?Q?BxdLy+WsHFYEWZgFjWbo/+U0cu0oJgPu54W6gn3tLjgYXPxKnaCDHd4TqZ3H?=
 =?us-ascii?Q?X1gw8MUMmppLPj2zD6HySmkHJfJSdxC3ZD75Jbh+wVknBZYsfWET5NQwHxT+?=
 =?us-ascii?Q?/laih5SInUsxFOhm2EMMLWbgUr3Jf7jKTOIAYmNUFsPH4rKLW8AthwGHcxoh?=
 =?us-ascii?Q?5oEp0MadNBd57ItPl/1LsKSv6jiOqrxMaCImG1AZ5zvS4qiLHJ8Tg5ET7Ca5?=
 =?us-ascii?Q?IRrGDYGw723U0CI+WKQmbdm4rvrQSQB/bY9bkng5GBHDHDrNtPD5heP3Z05f?=
 =?us-ascii?Q?X+d9YuiZ0GUYqbQwZXp1vvnoMOTkV7TLK3MpPAPqBEUmSf0U+l/Y4EwDyjxA?=
 =?us-ascii?Q?kX7voI1/eTJiqdHmdxjyL6QlPSbiJoXW22KhPWqvL9V6JoOuOyQ9jO3+bvCB?=
 =?us-ascii?Q?+fUgzmu3kSKircLYLOiZEW6RSJx1vRi6EO+YrWDQTj4eqXnc0uoyrpRPnQKV?=
 =?us-ascii?Q?+MSRED/AB1COheNPcBKEBfU/prEIWlGTDxFYN26RhPyUFnTSpIimHaQDtH8B?=
 =?us-ascii?Q?t66XdcJh3QuMG3Vukk2gjBSBv06Z5mgYav+R2ZEQj5L8U6nrJ3oA4QD73/wo?=
 =?us-ascii?Q?O0GYKwzpH6KndvIVaCZef0TKDwUD0dRbKz3ecACG9KxPlnZ5yxVrcBa8zHPd?=
 =?us-ascii?Q?/0BicqFUgBWz0B73dqL5TKy4TcUGyJV5D1b3wyqeqLGPWMugH1eqk/86pztC?=
 =?us-ascii?Q?McP62SwplR4EJnKFbzRSZmZtT4cV1WSeK8HgLe7mWVmd8WR/d/wPqcaRKd0g?=
 =?us-ascii?Q?Q6SC2JKNP3hCfp8BLDdhkbe+WYD3BMjW0KJXMjLiws3KhrxKZ6XvRodDGnIQ?=
 =?us-ascii?Q?rlAdLvUPZSJWhL5aLc/HKHTsxnRrFuqJ7pIDnDJoOA4pRum1ljEB0o1ECAyC?=
 =?us-ascii?Q?Ap1sklHPEE3/q2bjOM4EZqTDx0H7s41JO3/DE8lFa9IGOWsvPB6o0bVszu3f?=
 =?us-ascii?Q?3dZTC01B+H/nzDk5D4boUmfO0BFgH7Ic4+98+0/o4VnvfQQBqGxir8cyG09L?=
 =?us-ascii?Q?F5ebxlz4jiH1JAJWE8VOTTyuNU7R6/gCDDvK+3SnRTLctfBTfqRuQnIkw/r1?=
 =?us-ascii?Q?yLF7fP4RbfH/krix5ZS67nf6QI35zFtAKlUbdUlkyZReKbhhlZ/8vQCMVCAY?=
 =?us-ascii?Q?LBwF+q5mY7Ze8prBbj8JYjjIMR1w6PFfmoV/+YdRnTW1Nd7/aT+6ssWIoykF?=
 =?us-ascii?Q?097Q7v30DhDV2DvspNf4FByl+DfeOfMW+h/Lt/o+6IgdilCDchj+F0QDqs5+?=
 =?us-ascii?Q?Miyg2B0kZLP6M2U6Ia1WGBVGSUyclbXaBLSjK8jAMyIxoBgtMNbt9JZ+HTQZ?=
 =?us-ascii?Q?sIy1u9QkxEu/i15yaJg99CZZD0VxuVBDmzX6DgdA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29ceb5c-e3d0-4e71-c55e-08db65c8a43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 13:27:42.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhDYCRDQ/tBhJTB+koUjF/o7QIIB5CG+tzYy467ElFCCKROm/QCA3Jqq6azledVEZguVc6vgmktOcG8vvAqWVU6iCaKZQvYsCz5bomB5UHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5884
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark Brown,

> Subject: Re: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in
> RTC support
>=20
> On Fri, Jun 02, 2023 at 03:24:15PM +0100, Biju Das wrote:
>=20
> > Biju Das (11):
> >   i2c: Enhance i2c_new_ancillary_device API
>=20
> I assume there's some dependency from this patch in the others but
> you've not copied me on it so I can't tell what the status is...

I will make sure you are in copy next time. Some how missed, sorry for that

The PMIC driver has build dependency on the i2c patch. The PMIC driver
instantiates i2c client(RTC driver)

But RTC driver does not have build dependency rather it has functional
dependency for PMIC rev a0 chips as the oscillator bit is inverted=20

please see [1], [2] and [3]

[1] and [2] has build dependency

Between [2] and [3], RTC has functional dependency for PMIC version 0x11 as
     oscillator bit is inverted

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023060214=
2426.438375-2-biju.das.jz@bp.renesas.com/

[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023060214=
2426.438375-4-biju.das.jz@bp.renesas.com/

[3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023060214=
2426.438375-12-biju.das.jz@bp.renesas.com/

Cheers,
Biju


