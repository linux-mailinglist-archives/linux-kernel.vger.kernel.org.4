Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E126D58E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjDDGok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDGoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:44:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4351FE1;
        Mon,  3 Apr 2023 23:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgCBbmSbwrAyuVR3G/z1NC8vOYNbSrigkLbsj8iVqkos7tXoAooHeDIhk+EJkcKF8bsrMLu7GKvgeG46WzdzhkOPRMPppXD6w2EESe/Bbz6ZZVVEn1aQosqjVrIMiKo2XC6KhP8mBeaYD+/PwrPHI6DBfoRUWB+O0+Nn66uswOz3qJA8Ei5o6orObX73QAGmGhscRmRauaC0Hi5fHSKVSyimrGSRp8c1FO39Mr75DVMCHT+rJzWC4ppgvBicePumJ3de6PItfJX+ELsRQ9jZO8QrExHBnmm2qCDANDtF1KaMNHZSfQlCp1RYxAADXnTgUCFsyyEiRSCuQGQq/R1aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7E8xCpXlCvnX4Fmg+W7fc10a59me7adMP7RMvJMnA8=;
 b=nZMON3XqmuUK7qpKbnj2/OnZLyhQZI5Qt8djKGJFyMHLslcqOgrmbRH6/iaDbN/3eAPUpl84vI5g/JXvLCXHz5guiJxu+WCpTrxmfjcpoqNKQrElADkxT9Ksmol32fyBhRIbC7Da0RNZ7MmReVpVbfqhgU9J02nC/vValGleFYJ3X27WzBrqBaRfbBJKuIRZLQ9dVG4X38AqUlM02NaXh+hMWXDxm2ac7e7d8YIjHTjm0dfGVStxCgp0qjy8E/TY+k4fxQk/LH2kNAubJiV4/LGqceEf6/y7ZWUpGpuLiJxSxo8mP/S1VdOqQZRiemi0alPAFrUvfxZPHGiY4nRGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7E8xCpXlCvnX4Fmg+W7fc10a59me7adMP7RMvJMnA8=;
 b=Y4KhwybonnEbDJWvl5XRevsYYKrXN84zaRCSj6nHfJjq2jLs7IWsj1Lm/OaxlRXDOap6NKBD+fs9CW6Vj/NNzp/GDadkWEd9Mxu0IW+MVdTbkZYmpIgQglLk03f7/lhXxQVyOISFhS/sHqMRwVwFVLYJiSd5Xyn8JXXA0MNtWo4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 06:44:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 06:44:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Thread-Topic: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Thread-Index: AQHZZgrkvUOoKsCx70SkE5mkO6a/468aqRcAgAAMUmA=
Date:   Tue, 4 Apr 2023 06:44:34 +0000
Message-ID: <DU0PR04MB9417000982CDDF5B75E309F488939@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
 <9dc60868-b3f2-e30f-f4fe-d2fbd551d948@linaro.org>
In-Reply-To: <9dc60868-b3f2-e30f-f4fe-d2fbd551d948@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7723:EE_
x-ms-office365-filtering-correlation-id: 474c58ea-1793-4606-6b03-08db34d80d65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6biahLVj2VofRj1JUgzkEmlsssrHVivEh8fh4iTyXREbc0ASDSoqIRCc+EV+jcnO3x5HR99zZJQfeheABbzyuv4Ks2w01T3fNTpUBEcpchhfZcPeO6SAuNi6BmJNwLz2/ehJOl8eix4PFeMPWcN0Goz6jWISkgzFDn9dlLhRAuq+1fy0nC4S96zBc1mnhnZN/oulIBut02y9QrlB85lOrs95j5jmxG/chqhWnjZNVKtNFohuAI9LZoEw0GuhXsMCOy7OL6lhphm9xrsYrcNe9AoSFfxyXcklsM8EeUxjKHeXcI9LKTxnMCHlArzkRsa2p7KpCQZf84waKiB1OSRSkcOvdgozdIARf0Qo4gEGcDBcGkJikMyLOkwd2RqV1v/N8JpCH/M+AqpPhYez1pT8+KJegDcG+QaJEcy/+XPysnQg3NFE7QHrlJzz3NjvvcRVLIE1T4YmPOudvI5KmJyv6IOWO/15E6uqJ6KLrFX/OnzOLJ9neuTd3qu2iYyLky6aB0gbwDfqt+g233ilmIvkIAkjbnqU4oRo5KAR8XXnvxpce6X2/2ktc2NQISIkc7pOcAXJF7QFo6oZST5xOA8v+BG+WUDIBBJW/weyI+UUCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(186003)(2906002)(6506007)(26005)(53546011)(9686003)(44832011)(83380400001)(55016003)(5660300002)(8936002)(7696005)(52536014)(71200400001)(38100700002)(478600001)(45080400002)(122000001)(41300700001)(316002)(38070700005)(54906003)(110136005)(33656002)(76116006)(86362001)(66476007)(66446008)(64756008)(8676002)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2V/balj3vPmq/LjOofORzdKTsoP6kfT/bjHjOeG3RcuhzTrXZ7evb5/P04t6?=
 =?us-ascii?Q?pqVz7dgImJC+GFmm3EOIA/oQG2G9qMaKVDh2EwJiox4he9yLZU7cMd1RHrc8?=
 =?us-ascii?Q?A7/WhfsJOScrSG8oM7Npgzn+diT5GmOFkDKTsKs4/mz8aOwCqtRg0807mtBj?=
 =?us-ascii?Q?1nMmD2V1hKS5KX7aOhXwST+9nL3LV+SprukhexGvDfNemPxisLHnB0bUe95x?=
 =?us-ascii?Q?tiysqq4c/2e/Ehy0Ob5BbLoz8Tx6kpobSxlkU8tC+yuJGfRGdM6epBrYTVFn?=
 =?us-ascii?Q?eklHEgb0T+N2xWpxA0AQJ04fN/fJQOubplkp3ri/fsXwS10LxK2e4rcVwsX1?=
 =?us-ascii?Q?zW04WELuDs66lZ7+VamyMCrLNSqfGm0FXjYE1RwAsL6FyNT+omkxcIb2m7r7?=
 =?us-ascii?Q?VjxfaWiCHJEVaaNBqnwNfj7/ywtz61Sgsk75XXLj1QWkDPVHxKgSQqIcEwNd?=
 =?us-ascii?Q?k6vRVRkup6DqZ6z4WvASG8+HF9RGqlOMczBSW2qANit3LWDYoznGKzJWB8zG?=
 =?us-ascii?Q?zgaxWeqh4eVs9G7bx6uoxHfFBSURiBwtMywPUYdPV21pfTMWzpjVKtVfLRB8?=
 =?us-ascii?Q?x/AHMLmLhluFT4CZvEaZncDK46clWFvdMNmtSgUYxmBeWY5TxUCzDNsBgbSb?=
 =?us-ascii?Q?heHoEA5RoRFs0gGpZjclOVUgAM2fmsyTBReMO5rd6R235cndrGiXwNh+SHbb?=
 =?us-ascii?Q?pxw2pI+vPTUuZX4xLEQyc44QtKe7lSt0BPXkV34QfRChaSveyY33/wxF96uU?=
 =?us-ascii?Q?S1yxYmeXR6Ow8XQ0GvSIzZq3fbt496gxY4b2WW074devRuh0N7ZVvqKDF8Wd?=
 =?us-ascii?Q?+OjaVVuXsCll0mxKnnQrT+KoRcFL9X0M6FW2Lf6c2XZXsOaakt/uqJ2oM9ZV?=
 =?us-ascii?Q?xK6gL3K5dEzjMLOPhFxZRDfaVSStz6fPRQBJfLzLARqaevHRgsWAvUWmwC0W?=
 =?us-ascii?Q?G/dIwoM4vsTV07DFx3UtSymBn1rROA2tDPcM6axcqLjWW5I/CZVEEhXhv2wq?=
 =?us-ascii?Q?BbMSxNgCchEWWwkukmLhCHYjuex5+5ihDjLgcRZ0+mAf88/QdSMy7wRFVHRM?=
 =?us-ascii?Q?X6cKHPSHNNZGrb+XtAOew84VxYC/hbI2FJ/xdqwVtZ+ZX9MimYw3LF63tmEY?=
 =?us-ascii?Q?YXcj3DAHipiA0f1oqBu+cdl2U1I638BiebEGgYNAAZVcx2bLEv22wIHMH2XY?=
 =?us-ascii?Q?a4JCmrqBcuDkVy5ghTWxJXdUgi/8UnlE09lFqf24LlWVYLEUVeK9qn8goDqQ?=
 =?us-ascii?Q?JByDRuqSFf+7f8BJT6QOYmmZDsMYMXp+goEyJDP5KeO35ZPUGYbmUwU1C8z5?=
 =?us-ascii?Q?vHcUCmBr2sRhGkQ0JyyU7NSQZtnEOPL3w5/wjE4yS2VOPt/LLG0wLBt4jOFM?=
 =?us-ascii?Q?ShbyatiCT0lG3GRjbIadC+8GCeQ0kt7E6Nx9aalYktjy+/Dp2BfLGI0n83ee?=
 =?us-ascii?Q?IowzzNwNYba+YTqZs9RnqdmzRg4ylCVTRhkXpLV5LgsFxzTs9secdtrWqHcr?=
 =?us-ascii?Q?Qylo1IHcHUpwXn9FE/Wa6hLbh89sWFEiQbtuuhE+LZ28awnJ7RrUZ0xBfIm4?=
 =?us-ascii?Q?PPT4N9heJ31sT8tZlQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c58ea-1793-4606-6b03-08db34d80d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 06:44:34.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9wqaNexWtRRn4TjWANRoxhLkwgUDvTgYbbGuVN1tRkkCll3Rq2PRSzoRg0ZI8GO+g30uZiOx+JFEMkQjeGmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt
> schema
>=20
> On 03/04/2023 11:06, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding doc to dt schema, and also fixed the example from
> > fixed-regulator to regulator-fixed.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  License update
> >  Don't need to show providers
> >  Make example complete
> >  Decrease beeper hz
>=20
> Why?
>=20
> >  Misc update
> >
> >  .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
> > .../devicetree/bindings/input/pwm-beeper.yaml | 42
> +++++++++++++++++++
> >  2 files changed, 42 insertions(+), 24 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/input/pwm-beeper.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> > b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> > deleted file mode 100644
> > index 8fc0e48c20db..000000000000
> > --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -* PWM beeper device tree bindings
> > -
> > -Registers a PWM device as beeper.
> > -
> > -Required properties:
> > -- compatible: should be "pwm-beeper"
> > -- pwms: phandle to the physical PWM device
> > -
> > -Optional properties:
> > -- amp-supply: phandle to a regulator that acts as an amplifier for
> > the beeper
> > -- beeper-hz:  bell frequency in Hz
> > -
> > -Example:
> > -
> > -beeper_amp: amplifier {
> > -	compatible =3D "fixed-regulator";
> > -	gpios =3D <&gpio0 1 GPIO_ACTIVE_HIGH>;
> > -};
> > -
> > -beeper {
> > -	compatible =3D "pwm-beeper";
> > -	pwms =3D <&pwm0>;
> > -	amp-supply =3D <&beeper_amp>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > new file mode 100644
> > index 000000000000..a3797f338f46
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Finput%2Fpwm-
> beeper.yaml%23&data=3D05%7C01%7Cpeng
> >
> +.fan%40nxp.com%7Cd0db787eb4ca45afdacb08db34d1ba6b%7C686ea1d3
> bc2b4c6fa
> >
> +92cd99c5c301635%7C0%7C0%7C638161847599379017%7CUnknown%7CT
> WFpbGZsb3d8
> >
> +eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C
> >
> +3000%7C%7C%7C&sdata=3DFUaIpDqrTVLbQYOrqcXjK3cIwbntbdz7zq86mWr8
> yDA%3D&re
> > +served=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpeng.fan%40nx
> >
> +p.com%7Cd0db787eb4ca45afdacb08db34d1ba6b%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638161847599535229%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7
> >
> +C%7C&sdata=3DOhqZ1z81rsRTjnHINrfR4yGh7%2FiuwGU9CuS8xPJ6NFw%3D&
> reserved=3D
> > +0
> > +
> > +title: PWM beeper
> > +
> > +maintainers:
> > +  - Sascha Hauer <s.hauer@pengutronix.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: pwm-beeper
> > +
> > +  pwms:
> > +    description: Phandle to the physical PWM device
>=20
> Drop description.
>=20
> > +    maxItems: 1
> > +
> > +  amp-supply:
> > +    description: Phandle to a regulator that acts as an amplifier for
> > + the beeper
>=20
> Drop "Phandle to a regulator that acts as "
>=20
> > +
> > +  beeper-hz:
> > +    description: bell frequency in Hz
> > +    minimum: 1
> > +    maximum: 4
>=20
> default is 1000, so how constraints can be lower than default? Also - mis=
sing
> default.
[Peng Fan]=20
I am not sure what maximum value should be set. Previously I set 256, Rob
questioned it.

Regards,
Peng.
>=20
> Best regards,
> Krzysztof

