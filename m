Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9A65F47B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjAETax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjAETaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:30:12 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F34676C9;
        Thu,  5 Jan 2023 11:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3h/b/5aXVNeLUcAOFhQPJvWTPhg1iM39Ow7dEJKtf33b1nXm5bEt4m9ONG5tLgDggha8E9vUcgWxegtkjYNwNLUOuLrRoZuahkRrqtpdZ4bvMPbUV1Nu8kJMti9w/5zW2lEjqTo60mkVoYBmI4CMXpaOx6QKMzkRIKhzIKnsn6183ar0b8NCAHe8UT8GM7ZzsdYuCkCVHyFEpNX9K7bNeZTDJL0ypbb149P3C6jRZio29G2LX5EE4ZfudyPhen+xfY2wP5VWOXCVXSRf9OAAG/iteiJqk+ZJ8yT6oT6LUkcDOq95TL16F5IYjGgDv5ACha4guR+QSssOZes7VMNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S95cllgqiO6lnwNogP/v4DcYQkYuBbfY9J/6NxomLJ4=;
 b=Pc1+I1/lYBGXmncBzqMBqvL8ecmBpJIBdwCwmMYmE2akLsmVEkppuX5WWTk62O4uDXe4bYglkyEH1DBw8qzc148LKlXNmlzQvo+2x5+QZBCSbqQEMjQ5RshY5YvT412mnDL2mDKaVPMkhqxz+vochpY9A5b4yvb/v6OkVg5GkedJYMxuT/WdlarjMz66GBjWiMpaBLeO85qxuAauvzsL4aauxOjH8HmxleczxmezMOgO+jmNsj7c3rE8dRZQJR/JK3mvdKxUoAwuYZ6U17EE9M+Lfd2FdMv4RgGBguLHYeBlzkQ4duHhMdWkUBycxWu0vREczSY89eNDp+H2qNyW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S95cllgqiO6lnwNogP/v4DcYQkYuBbfY9J/6NxomLJ4=;
 b=WzOQ4vJtSpYqinl1lWc977VbcvYt8+hza+gB7dvMhZ+qdp9+evV9oausn4mnkRfRVo9ss7zwDRj9FxthXcdUEdGLbHQh6lJdYm3dJyJPj7LbGTPUJdgkJ1DxwGznydl2CVxIKem6N/bNQTXyFAc9WMexLKJKYFAHQf/d23ZZJ6o=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB8244.jpnprd01.prod.outlook.com (2603:1096:604:176::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:24:57 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:24:57 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH v3 0/2] Driver support for RZ/V2M PWC
Thread-Topic: [PATCH v3 0/2] Driver support for RZ/V2M PWC
Thread-Index: AQHZITQ7A/Kte8Vki0qsrLRHGm9tS66QM/Zg
Date:   Thu, 5 Jan 2023 19:24:57 +0000
Message-ID: <TYWPR01MB8775E9DD4FB892A2C533FE63C2FA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB8244:EE_
x-ms-office365-filtering-correlation-id: 380edc47-115b-4ce4-0a69-08daef52881e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oyrzb4FNzGbvlwklA7LWcQDhY5uLr3nIcUiToGkUS//ylboPNTk3BjHoiW/iWczgMxkYZd+Bmp4l9FdZ8ru69S3/LnrtDt5qpS2G6Bt8RcYHhAXIwVfVqMGh+sLb6LfYkhjrvWzD9sxHXRuPp5i2iNBMIqRdpzjwQO3wZ78cJXrXju032q5BQ080aMlQgvEnmeZJ1KCrAaZeQUDWXLLjphiLjQyfXTexzqEJzne8MmaPYneohBxi5UWuOebWam6Wqa7O2ApgyYnaac4JptbqA+bzVF4hL3qEqHxNtcNbPhsvOHk4CAs+O8ZtoowBeLQ0w3NKrEnPXgLrwwjdc3w7CzeCLx/yG+3HzCpx6HNCDcejx1e4d6lZ/ICMQFHAZvP6ROcLLmN/hj8u4dK4ArWj52XLIKvEK/JnfFeB/ThSfDWR3JNpD5SKnAXMeo7PlCeyGY85rs+6Lx4L37v5ak0QWeV5EZ4Ih4+mSe3jXuKFaRsF6g57mWOW86IqJi8VRw69HqTc1iyTNkm/udIN5yTE+KHuXv4JnsCI2wF6McmDqxbNaNJlmXYAi52Jr84EsnibT7iGFIdAmhTl4rJsMD70Hjej321Nq9SfOc23kMjPlX1gpFYREec55v+fpHSVHqb2Igmonoof/5J3tuThcRJjtgOseZTQXLUNV4kCEseg5++BBivrT4G0NwCFkCkHzC3hvICasuaP+l2xaf/b5Sd+CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(5660300002)(33656002)(38070700005)(8676002)(86362001)(66446008)(66476007)(66946007)(52536014)(76116006)(64756008)(4326008)(2906002)(7416002)(122000001)(38100700002)(66556008)(71200400001)(316002)(54906003)(110136005)(478600001)(186003)(55016003)(41300700001)(7696005)(8936002)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+0RzxOEdqnwxx/R3jzqzvSSKhB0w5/eCWKgPYXficneh6USgDXMAv6pBDh5u?=
 =?us-ascii?Q?sX2lgAyQ69lme57dz4P5wwTPQQj/A6o3Z1XzMg5dQyjfuvpeV5SgoR6e5zhF?=
 =?us-ascii?Q?ssZUT1AAYzAnhxt9aYk5IAwgDSj5lLb45sNnzxXtG5ZC/9fUclyM0LJoYbZS?=
 =?us-ascii?Q?cstrsZrDVAeBrsYt68DPegrna+hlTuZnRJilAsZp5HAItzjwobU2NqAhyMZ8?=
 =?us-ascii?Q?vIPOlRooyi1fzxxsCRj4FNUWh+Rtvw9UK9OGVPvNwzgadHgDvk0CXYidUclB?=
 =?us-ascii?Q?VEeVjb3c7uQASZlZOUiwQlgVzRwTVxhUdlNcirscWh3gG3DKp0+gWOhRCPNm?=
 =?us-ascii?Q?wkQOkBreZUT3Bo4kZMBBIJ6DUQg0Im1pSWgyN8GKG9/7eCM+ZD2yEr6IChJV?=
 =?us-ascii?Q?Pa9EFo4s97Z8ePde8HWX/jdS3owS/g05Q1xNKnHRPA9zi0HY1tKtxMBMYjgv?=
 =?us-ascii?Q?cxYN6QTw50Ckho5tCLce3gsG6Ul1anDp6/1M6g5DImaWZUKNy9gWIUnmQfJ8?=
 =?us-ascii?Q?fQR+1rNTwFLk0HkVkThgywWlyVYgPHjHTFqdtoq1VE/Y0T3LoD/1kxjQQEEh?=
 =?us-ascii?Q?ff7peCd4HKxXkA4+DvDOO7wKHD+MTZauKr3Dyv6k7PK5G+sa/JK5PiV4ufmh?=
 =?us-ascii?Q?l+bP97JkIB6jCcr0XCnJtQjfhv3jrLTEdEVI5qKebiimAJI/H1YuuRkO3l8i?=
 =?us-ascii?Q?ZmjBiMISgwINHojWH9MdBcyLszZ3p6q4v+vW3/D+DZ4+46ziQThlm0EnY3kP?=
 =?us-ascii?Q?n1JVbEaa1YHn8EzUxEYqkbeSpS5QapXiKCr1E50hzcXmUReQ9T+JTPSXTKCM?=
 =?us-ascii?Q?r8sGBHLQblMt69oRyP9NGmnifmpK/D40BMWELm0xMIMK0zyapEkWFlq9md3R?=
 =?us-ascii?Q?pwR645kSfwWv5IaB5Lbv0Qx60cehbSi93EVSG8dCzfuYLTqHc/1Io/hRp+Gc?=
 =?us-ascii?Q?yOLvrAraTgEE/oEEPBbau99QCskjEkdVXSgMTePuza+r2JLezhzwH/gHpDgL?=
 =?us-ascii?Q?TmV++X4UyIVYBPmtrqzDrqUq+HjN0p3EOYfcqP+GpZuE/IBpL7iocK4a3jk8?=
 =?us-ascii?Q?f/tvpTX7cy9AdjwfskmMBTe/FBH/MF+VRMxbED2B/Axvlu3OArrYT1NrTsDO?=
 =?us-ascii?Q?8Q9PRYNfcuYhiCNxnuNzqqX0ije9qb9F1XDU2dzgm/S2VVjDvNJFTZsGF+nG?=
 =?us-ascii?Q?5ipMpIx2FH1YAhfuES+4+5xUxQastCrEQ2wSu/eP77HlZMA416Q0jCMcRGJm?=
 =?us-ascii?Q?1O9WiAYdjRpIyAz0yevDKT/wQsRIHiXu791QcaTy8seKwWZqI2DRKRYEkgqS?=
 =?us-ascii?Q?ORMN2atcDks/cApQl0CZBemv7Q2FVjCO3+KqUAqf02bvZtBTWWXmZqIbdw1h?=
 =?us-ascii?Q?wSmx7mKOrcOvMZPjUod33u1ZoV+TjBksvdxMumposyA9hVtWhDDwxrw4Hubg?=
 =?us-ascii?Q?Qn02feVAlgk3WziP/rRB5icZffPp69WqM8boGmjL57IKi2aiG1bOEUqKWujY?=
 =?us-ascii?Q?SladrnmhNKel7RWLjQfsgbJpP1RJVMS0de7LtEMjaNIQFRvYdvdupcL6Gzj0?=
 =?us-ascii?Q?X+Ha8g5EFjZ5S8o0QaOCwZwyVVu/FL3QZmwK10bK/hpmYlbfnXWX3OtPtXrf?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380edc47-115b-4ce4-0a69-08daef52881e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:24:57.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmIbTUWxWNuvt638uRYnIh+91zVB8s7KCpSBJH8TI/VfB3aqmK8zNu7ZW8Gs89X0wO8ZmCzJ88geAV/fRzPd+Jljzlsl5s4+KHP0PRvvJcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to move the dt-bindings under:
Documentation/devicetree/bindings/soc/renesas/

I'll send v4 shortly to fix that.

Thanks,
Fab

> The PWC IP found in the RZ/V2M family of chips fits the Multi-Function
> Device (MFD) model quite well, and comes with the below capabilities:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>=20
> This new version of the series merges the 3 drivers from version 2
> (MFD core driver, GPIO driver, and poweroff driver) into a single
> driver.
>=20
> Thanks,
> Fab
>=20
> Fabrizio Castro (2):
>   dt-bindings: mfd: Add RZ/V2M PWC
>   soc: renesas: Add PWC support for RZ/V2M
>=20
>  .../bindings/mfd/renesas,rzv2m-pwc.yaml       |  56 +++++++
>  drivers/soc/renesas/Kconfig                   |   4 +
>  drivers/soc/renesas/Makefile                  |   1 +
>  drivers/soc/renesas/pwc-rzv2m.c               | 141 ++++++++++++++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-
> pwc.yaml
>  create mode 100644 drivers/soc/renesas/pwc-rzv2m.c
>=20
> --
> 2.34.1

