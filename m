Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8858C6F8E28
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjEFC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEFC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:58:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA819A8;
        Fri,  5 May 2023 19:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E136OMAGWv6EW+I7xFOYpKncilUKsaWnnjfBMOBxqU3ZRFhI7YgXXCPtfrWxXwHy+k4Vi21idmpB6ZUcEnqE7CNpPS18PzorHYGM13JYD8rBiUSLaMCssO8Clwhp5mUq5zmAc28aHnw4w3KaCC4HTGak1gOlsowqfkPK7IQKM63B4GYDE+6FRbfSXA8z/seTx9wwpz2JKo2Hm3fqcjUyMHqZ45KLdZKqvBPF4mAGmaJIeIiOmKxg4Z1Bwct4KomPmXBWDRGm6bwPKnz3/HW0AhqSs05LQycv3elP0uggL2SwPF65cSPPhlTqToQybs/iUY7/36/R2ovS6ceGCNdu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpEbw5aSyLhZPExqrXOPUhscXgEAi9TuWNxYDwxUGO4=;
 b=Txk0iZvDJ57nuVwmVO7bvQgn72zdZN+c3Gp4jVfX9XZYktolNp+mrFSKuPOJ/j6GEXpMhIbJ3LNIquS65KjJLIOVFPjNSJmi6+MecxcosVoIna9KwnmV84Kvv7CDrnNTtDCLOul7WLd6uZKpgoXh/glLv7M1vv0oVzCpbMQPOLfmfzsHyfoOZBa0vNlh/b5ElxqBPZNEgE7VDLjO96FtIeaQr7TLbtcnRTwsfmPLs1w1RPXP7g54icleAef3t2ZZnTSENo9l9t8d5bLaGVQ44CWeih6ySLs29t4jjda+ClatpQ/JJQhseWSBFOTLMlXXKZiNS525Vs6EYI9ED7kukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpEbw5aSyLhZPExqrXOPUhscXgEAi9TuWNxYDwxUGO4=;
 b=N8/woZ2PMgysiRlpfOYTi4/3qgJNFSnc15qeI7lRaoHO458dZ6+CtiYwMljLPYwt1YInhz7fw6M+PwAU5n0YypUqOA5POtIIkf1G3Tms+IR5JKLmBGDUmYptOlnux6Awh6mrEIuA0Am0T41tRfT2VdcF3pWPlePifWlfH2hvXuo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8856.eurprd04.prod.outlook.com (2603:10a6:10:2e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 02:58:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 02:58:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Thread-Topic: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Thread-Index: AQHZfzG8mADyGW6AqEKaxwdRWuz+va9LlCGAgAACUwCAAPZ+8A==
Date:   Sat, 6 May 2023 02:58:01 +0000
Message-ID: <DU0PR04MB9417AE9BA8F91B2E06DB09BF88739@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
 <bb3d374d-0dc1-cf15-2458-f294c5ef23fd@linaro.org>
 <c7f11b40-e4d7-3c4e-53d7-6549f840b702@linaro.org>
In-Reply-To: <c7f11b40-e4d7-3c4e-53d7-6549f840b702@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8856:EE_
x-ms-office365-filtering-correlation-id: d12af055-a8df-4dd9-8827-08db4dddb4cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mktOsZQ6R52UKxNC2NNTtoz0Psf8uvtAhpjGZY2BJaTOaJAheSZ/uPo6dnXM7BfRwNofbjnVHzROUfPu3qgUhPMp8oFU1huOwOqhdFLkUx1UsKipF0MUbZXO5NS4dVBCjtIAkO4R8gMUgpa9lFk3ARHF/W7CZfBqamO2Owvu0dznZ451li2rZQHgF9bt8WiV5JDFIA0noLsly/nqkC7Sc1iJZu8iFvi7PtFmaPPrgvP2eXidwFyuohsEFJqodAIZWP5WO06Rl0E57VYUfgBU15LJXV+tB+MfddULU0Pew0KqA4o/9g37s0KNeTmWr3cfiyI7/HObSGG1W0MRi6E5A2EqqiMzLhNE9cV6IcAyGKcvX223hqsmbnmlQomWu/qG3LLXSDuQ21n8XEf69q32c1kbZagwH7o1Fs5x9EYI8UktBAYBCKQE+weKfyuN6deVoxQf5iTwpmay+OodoTgf9L/d+umhqxaSI29+B9BcvbyupITSBUHfyQLpOVcyCn4Q75d5zk38zsiIB1jg6wO3reeyfBMQXK9E+3UgjO8TYXGeJsmoBe0eHxpzWC+BktTF7XpD7BhIAW6X7SEEmWRoKi3PN3CWKq8algvsJ/upvuCV2pfOw8ClPtpxh0x7+1Oo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(478600001)(45080400002)(7696005)(316002)(54906003)(110136005)(86362001)(33656002)(83380400001)(9686003)(6506007)(26005)(53546011)(71200400001)(8676002)(8936002)(5660300002)(52536014)(44832011)(41300700001)(7416002)(2906002)(55016003)(38070700005)(186003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whIbKOtz/4hEHcJSFs2W4QJFi0SSqEGoKVRru7/PXIpI5gVSeAAYJKZtBzES?=
 =?us-ascii?Q?vOGtBUgEJ/6+vFm5xtaL1Qny/QWww4oLHDSdnLAy77aJ1E+OlLDpfxmOANR8?=
 =?us-ascii?Q?p5pHnTbhUw/RMO20bcdax40nhX5G1SbA2f/a4tRdxvg6ntPiQBDgB8Efybvx?=
 =?us-ascii?Q?7CKwUId9CB9hIA6/Ra0wrUeW5L5JuL5aBHDVdENcKQ5069phgbZo9bfp9UJp?=
 =?us-ascii?Q?aKWiW3dKIxRwKZh14cG2FqoD7swGqG28jt37Q3BAxO7zbI7Dc/gOsF8eyVx4?=
 =?us-ascii?Q?G0CIL1jjRFlRMYjFDiuvrDC9dSJermYErtHRW/QnN94vMxXtCNIATepOOXVL?=
 =?us-ascii?Q?2Y0Qi/RhNUbs12nwqXvLVEkhFTH7QDKRBBfuaYMECgzUK4jkr8WfJokGW1Xg?=
 =?us-ascii?Q?2swp151q6/Vw3KqVfvxs0zTTkdq9fCS+eeHWzxPiqhZnWUgxjPjPgSFHkm4v?=
 =?us-ascii?Q?mvvKvmzX5CIEda3hyG3OSU93kTtRxrKVh0FmAB2Tjcjv2lZWupsZNdbBvF4t?=
 =?us-ascii?Q?ZCVWTIsZLOlUgfNF4Hex93PpXwzKoSZF8DsNYD9KHb1GptJ/ySotbNnXBhoX?=
 =?us-ascii?Q?rhy2o0mKmfn3fR/UOA7lZfAkn4n9h/Yc0kVF/KDY4Fa9QWClcekyqyCYs/tv?=
 =?us-ascii?Q?7hWU7/VrU1a8/pA8wHjJea0ZIi/y9SLXGkdTVk7UWOVhZzAjQAE+u0p3mT4z?=
 =?us-ascii?Q?7EWF/MOuBpey1cJ7jyyGrCTKrU4ZkLUjyRZgPEv42AyChREURkV5EiWR8BlK?=
 =?us-ascii?Q?JHwu5bv44edmTNNr9Bbls4VLH8hlu//5fylwz6iFXINoi4pYE2QA1aikpnij?=
 =?us-ascii?Q?QqZzbLKXaCGOkzcYc38xANJ1kT7x6SMsrKd/zTMyJhl4KciWoZcGK2uRYoKs?=
 =?us-ascii?Q?f/FcB0wjxQJ+nlXgLk/ZxPrGJumX7IDowV9k+VJE96Gnz+azoZGiJmTFivJQ?=
 =?us-ascii?Q?jjWzgBLrLKXkZHndrDzpiqRCwWDdx8whwBy04GwbPMnP/BpGa5IMQMCVPzkB?=
 =?us-ascii?Q?/6BodpeF/m5RjtaflrjQEgqyJlrWAIe3Exc9lvvzxg44V13b9zb35T46Fs20?=
 =?us-ascii?Q?5MRixN0/m3xprlk0QtFyWEfTIjiKJtw22Uww/LP9gpZyPmKRp24PqFGCPw8O?=
 =?us-ascii?Q?D0wWsiI94RRxZfRRzgD18O4wYig5uUMUeDKpktWjVeyB8bU4jbkiFBlZ1lCu?=
 =?us-ascii?Q?Y2+kpj9srFG5AIxw/C2yWgH1Bfr8oJUUCWYJy+NMEv7uUJDrxi5QKiz2gh31?=
 =?us-ascii?Q?oJcvs5/DibkqP2FHdfCg4bgt2Io7blLPUiZYnsU61HNF476t+48qvesH7boH?=
 =?us-ascii?Q?lEC5mfOfyd1ESFWZS60K4YsCRPJzZTz3+fGJjYec+jdl86M8JlW+U61LI+h+?=
 =?us-ascii?Q?rRL3oVxLHq/JS3fl/vcGKqtG/KJxwN4qheAEpiT1UQY3MoFE0Gc0/EsQjBEN?=
 =?us-ascii?Q?P0Zp7/bFdCEfS29dU1T41+BOB6LqzuXL+ihwJFLmGrUywZzku60P34YHCfS8?=
 =?us-ascii?Q?A6nAlisvRy1FMiwP+Tc59ECUTT/6PeAe4fcy/tzVMhz8XFjFq3LEJqF/Lqjy?=
 =?us-ascii?Q?G4eq8VabxdAh8Xf2N9Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12af055-a8df-4dd9-8827-08db4dddb4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 02:58:01.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dr4ss3mHytVZtteZIWGKThJcmW4w10U+TEBZWD/i8wzjI5g0GHYDmM38MX5UXy0hJ9n9Xe2WjN3l6xVnjlKnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
> OCOTP/ELE
>=20
> On 05/05/2023 14:01, Krzysztof Kozlowski wrote:
> > On 05/05/2023 11:17, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> There are two parts of i.MX93 OCOTP, with 1st part Fuse shadow
> >> block(fsb), 2nd part managed by ELE firmware. This binding doc support=
s
> both.
> >
> > Subject: drop second/last, redundant "binding doc for". The
> > "dt-bindings" prefix is already stating that these are bindings and
> > documentation.
> >
> >>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  .../bindings/nvmem/imx-ocotp-ele.yaml         | 65 ++++++++++++++++++=
+
> >>  1 file changed, 65 insertions(+)
> >>  create mode 100644
> >> Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> >> b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> >> new file mode 100644
> >> index 000000000000..024594a2bcb4
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> >
> > Filename matching compatible style. fsl,imx93-ocotp.yaml
> >
> >
> >> @@ -0,0 +1,65 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> >> +---
> >> +$id:
> >>
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev
> >> +icetree.org%2Fschemas%2Fnvmem%2Fimx-ocotp-
> ele.yaml%23&data=3D05%7C01%7
> >>
> +Cpeng.fan%40nxp.com%7Cd779f2b1abe94a0d493208db4d618fd9%7C686e
> a1d3bc2
> >>
> +b4c6fa92cd99c5c301635%7C0%7C0%7C638188853636582816%7CUnknown
> %7CTWFpb
> >>
> +GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6M
> >>
> +n0%3D%7C3000%7C%7C%7C&sdata=3D2uIFOmUqlbgPIRasl%2FyO0CdZAFPhV
> 2qpHnhwKB
> >> +OZ008%3D&reserved=3D0
> >> +$schema:
> >>
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev
> >> +icetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpeng.fan%40
> >>
> +nxp.com%7Cd779f2b1abe94a0d493208db4d618fd9%7C686ea1d3bc2b4c6f
> a92cd99
> >>
> +c5c301635%7C0%7C0%7C638188853636582816%7CUnknown%7CTWFpbG
> Zsb3d8eyJWI
> >>
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000
> >>
> +%7C%7C%7C&sdata=3DiKJpzjsi7TuqxDim7sUjHmwFR1eK9hFNp2ygMap9bq8%
> 3D&reser
> >> +ved=3D0
> >> +
> >> +title: NXP i.MX9 On-Chip OTP Controller (OCOTP)
> >> +
> >> +maintainers:
> >> +  - Peng Fan <peng.fan@nxp.com>
> >> +
> >> +allOf:
> >> +  - $ref: nvmem.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - items:
> >> +          - const: fsl,imx93-ocotp-fsb
> >> +          - const: syscon
> >> +      - items:
> >> +          - const: fsl,imx93-ocotp-ele
> >> +
>=20
> Actually this is the same as existing bindings. Just squash it.

You mean add the compatible to imx-ocotp.yaml?

>=20
> However I wonder - why this is syscon?

Someone may wanna to use syscon_to_regmap?
I just follow imx-ocotp.yaml.

Regards,
Peng.

>=20
> Best regards,
> Krzysztof

