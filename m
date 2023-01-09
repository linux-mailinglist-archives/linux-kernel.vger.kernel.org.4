Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77F661EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjAIHE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjAIHEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:04:33 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E66361;
        Sun,  8 Jan 2023 23:04:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTijKg2HRiQI4JvLu/qZF9xrwQKsfNH/bMm/nWGiCVKG0tnv0zpwGas1kdMgbymNPPVkhBxyoQdYwJUywYhj301JWLdkj1L1hSAfhU78v1Ip/wH7GE1h8Nh3i3Cbo/GxKPqxjU6UwL4jFCYY5v2MjoccMCalJtmjkMOZCEB4Y1PMEhFyV605odWpDVZAB0Ue43ImERE3SmmWNLkO2g9to4ehjM5oFXxP0nsk78/Q/xBcFw37+kNGYNwfLynBwo84Dx7BZL8qtUAkkfSRMC7reCqzkgIFqkUwi7qbCoXQpKrkzUHHrAq9jRq2RleeC7E9US8/uGST7tCfvD0qk2H2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APy0gY4MRvt3WLsA+4Wfu2cD4LHMtu8dS3fonJhUb4E=;
 b=RGuBbpp+GSSaIy6KubJwuvNMcPixW6SGudH2TyPi8tLpPoqDavbisQI1YrUDkndbLiam+HxQ53pZ9zbTS6QiVxpJ7b8lYL4J6RG7cchMYFCG9/cGDZ2fepRE9yTl/nPeMJ+R5DvUNVoTQXikcnC0atPmISfeZjGc6hl1tvGWZdpiO8VVc89bjfz2lY3yRpBFOb6Vg5yV6vQUJLo7DRGLhRewk/EWyCtKla8glWgWXTfJ3ROvOZk/UOBaRZEuGxswz6hsAQ+MS81DXhPxbUCSHPwhGxg6w4VP3Ysr9FTAojFbia24JJ4BzipUUZscbaIXgqkkrXS47vzIppqv8emSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APy0gY4MRvt3WLsA+4Wfu2cD4LHMtu8dS3fonJhUb4E=;
 b=Ke0xrI7QcuX2vdLHC9EdWqynwgtpWPzJckXXHldto0eb4q+57S7FQQmRU+R7qnVXOMvx5BTsBHFT9NX0L52MlZyEvvPXtDpS8Dc5JHD/hkSTb8QNWyAQl4qhCM4Vp+JXyJr+nzAH6TlvMcUlu8qX3odpgns4GoAbM/cL9XVjffYYWsLk2Ie6NRRjg7MKeY5313ieEW5tpBoFS+14JTzqnFYaKQq9Vco4s8ikqeVht8wS5Fk9mzMxabdkZ+MBaVHFifLO8y1fCJq0hfgQrsdX5/VFrBUTPn8KcYp+nN05PgWrWlpSjDS4eph3BYmT0uTm27pDtSMC3aSjJPIpoBDhug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:04:29 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:04:29 +0000
Date:   Mon, 9 Jan 2023 15:04:17 +0800
From:   Chester Lin <clin@suse.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y7u8cWR7p3/MfKgB@linux-8mug>
References: <20221221073232.21888-1-clin@suse.com>
 <20221221073232.21888-2-clin@suse.com>
 <17dc933d-e46c-ddfa-b185-5c24fa7dddb6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dc933d-e46c-ddfa-b185-5c24fa7dddb6@linaro.org>
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de87068-c704-406d-4733-08daf20fc058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHcr73k6wjkA7LK4GZDcPNzJFn3ti7OOxuGVyZ39jCe2VoF/rEnYjHagOopjuiJ9dSSCmHdQTUfkrhH9iTs/WUQBgI/B81BQc00mgHqLEdRTPZjLd/tnrTxIkN2u90F+0J7ukEqufp+E3vp/WnldSSmnn926xGivZ+9THEEZTSm2RNcMtKXS7bRwNQ6IxMyeHPrpOGkJnBXKpEgeB2+2FcI7KalAHG0UwHwHujgichVL5LP6g8pjGnerAQf2BGwlAH8qPGyfO9ePvopFGGVTEmAOV9+FFmIE7FOQkAsjRGHq/tY81GSVzDZmodSVW8ru8gC5Ag07maR0plztEJaLpRUtM0jpyZC3C/0/fLOCG9PfY8DjJx1nxEuEHrrLDYpqP/f5ympQU/YSiJ72grA6dCEryaxFPuZKHOWiVD33Lr5zK0/ae/bgwAPqWDnmh9atpMawA6j0S1xTAXzzbV1EQvaV7xFKDjt8ha7YTrEurgy5f6oVhv3Cq4MR9I/F6qsPrJjRO1ZLH9tFX3Az8ZNNrmhOWv7t0LyGlDhtjNPJ8M0+ZTDxWUWLerkwF9ZjgzhXaAroriEVCUQANbCyWvFTzioB5xvBa5pX+k2XEtXREOg2Wj5UibD40aueSAUZCbs/d0RgKjRzkYX2dOZCbvMIizXh6oJGJ8mdfb3WQ8Q8D/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(2906002)(8936002)(7416002)(5660300002)(30864003)(41300700001)(6666004)(8676002)(66946007)(66476007)(66556008)(316002)(54906003)(4326008)(6486002)(966005)(478600001)(53546011)(26005)(6506007)(9686003)(6512007)(186003)(6916009)(107886003)(86362001)(33716001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tq2d6T7XPnEUjvk0+t4OdKHHkQMxFGTKIdWPNco+F2MNSQQr2UjetHziPYd2?=
 =?us-ascii?Q?lkkJ6l9rgo8L8C9HoPSs9eUsS/BoJRSkirWwsbgpsryNtlGM/odZxYqpPEic?=
 =?us-ascii?Q?C1/RZPGYBr9/4kdBJeGC0U2om4V4HVrjDr9qBfkuFUeXfSPYnw26poh9rucl?=
 =?us-ascii?Q?zmFdR2KgcZlBobcRcj87773RrCehGBsLkUHDPm+jVKVf0nrEK0uqGEboXrxP?=
 =?us-ascii?Q?PEYHkf+GyDmRGrYWBjb8xtNgXEaf0MQjekrRZICKiK+X5HkRRTCjrDw4YRxV?=
 =?us-ascii?Q?OUn3HMLKRgpuGFzs0+fWJtX9OBILWwurIwR7Tk20/alpIxIZ1P0RkHWNRaA5?=
 =?us-ascii?Q?4lAtzQ84eQich1FfROOk7BboAxvxBvvsTcgQgzuXaqW/XrdrasBv4al0ipU5?=
 =?us-ascii?Q?fMsr17JI0tDGhUS9XAqD9Pq++CmIuFft1tYnFZwcGpS6S4BOjx0/zKtsx+pe?=
 =?us-ascii?Q?Pl4xrM/kctOiTVjMA9qVWTn8nyeZYVK/gix5EeVtNOXhW+tW791WbXh4se8o?=
 =?us-ascii?Q?pcQqkxHppUMt2qnvazrZJsdi5VxOeAUgKdTvFF8AwiIBcYpMupBCpiJDyqSG?=
 =?us-ascii?Q?1NwZUQa2sIf/pTOW8wK/jVZH3CEoOLiuMZOURk2C5yUvRD338hZt65ey4reX?=
 =?us-ascii?Q?iwo419SdWSR3KaWIUgfCIQbcgCnB+2n0d91ZNBbX5jJHxTUxFbP7oPb3Rr1r?=
 =?us-ascii?Q?rqiAmY34nzGzfOndYAOGUZrdaYqx2LwAD6qRG0DX6jhuYEDmtTbgAbD/YBH5?=
 =?us-ascii?Q?EjGcPR0B+njMuvweZNxy0ovhJIkmErmIkrQFokQ/agSjCrbetMRyAi/eXUrL?=
 =?us-ascii?Q?3JS8Cmm26uTlAYPJvYPMang31vrj+sesRdc+/NEQprL0IOaHrn+7Blb2/SSI?=
 =?us-ascii?Q?QbqTVTsrRulO+2n2s6TTnaZAJ/BbNsZNwAec0fqnoqNYhr6dnDJedWZGAnKJ?=
 =?us-ascii?Q?qrBHEvnc87MZUOGrZMQmTqfN1RzqHwRZou7m5UAITTDKK27ovryQMrZN7SjC?=
 =?us-ascii?Q?ZjEC/cKz/Fg1n0Hjso3t8h8NyNO6+gBPDx4gbz/LUY3sKA+wX2iOH4ybu/2A?=
 =?us-ascii?Q?m7XZtfAN3wNTwUcNQeK20Y7EVstO9tGbeGQaLjvvE00MfvAqte5LTT0BO5i9?=
 =?us-ascii?Q?iRu+zsi2NlFdwWXidTMpaYmojNUcAvoogZHGOH4IT43KZnIhuFm1YP70NgC8?=
 =?us-ascii?Q?6HM2pPmZuAHZ3byXECGqEFCffq5IFE8FeDV71Z0wV8PmZ6N+tVCxzvEPXssN?=
 =?us-ascii?Q?RZe3o0MTgxQDjXEO8wpkE628W8Qt1oXtLxKE2R09TH03RlUyUfSNj0rq2jkx?=
 =?us-ascii?Q?6rjIJ8er4vyAHTtw2LDjJsMEOh0xlA4iZmFR0b3TgudWqy/nbM2vG/EKQsj3?=
 =?us-ascii?Q?YI/u/gEYssah69MG5CAs3r1IQw0vNuzqBbP1xIgYJwKmCL2tXD1z23wNOGHU?=
 =?us-ascii?Q?pv6MNWjGwMrytIBq1Y8SgflN3LC2T4gG3JaWOB+0R8syYvmM8YlG6LBTByBp?=
 =?us-ascii?Q?Diow2HaZT1lnuOm117TGy0YoTduNDLkKbV94WNQC4wgVbwgFZkCGywmnztz+?=
 =?us-ascii?Q?fpT9aWGLIo2gipsgZzM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de87068-c704-406d-4733-08daf20fc058
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 07:04:29.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKrx4+t48GG/0QaXIbeYq4PBAQ1UaZsHiU0Gvfhls1aI5yoxSQFTcZJ/G+m9BDrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Dec 22, 2022 at 12:28:31PM +0100, Krzysztof Kozlowski wrote:
> On 21/12/2022 08:32, Chester Lin wrote:
> > Add DT schema for the pinctrl driver of NXP S32 SoC family.
> > 
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > 
> > Changes in v3:
> > - Remove the minItems from reg because there's no optional item for s32g2.
> > - List supported properties of pinmux-node and pincfg-node and add more
> >   descriptions.
> > - Adjust the location of "required:".
> > - Fix descriptions and wordings.
> > - Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.
> > 
> > Changes in v2:
> > - Remove the "nxp,pins" property since it has been moved into the driver.
> > - Add descriptions for reg entries.
> > - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
> > - Fix schema issues and revise the example.
> > - Fix the copyright format suggested by NXP.
> > 
> >  .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 129 ++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..1554ce14214a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2022 NXP
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2 pin controller
> > +
> > +maintainers:
> > +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> > +  - Chester Lin <clin@suse.com>
> > +
> > +description: |
> > +  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
> > +  whose memory map is split into two regions:
> > +    SIUL2_0 @ 0x4009c000
> > +    SIUL2_1 @ 0x44010000
> > +
> > +  Every SIUL2 region has multiple register types, and here only MSCR and
> > +  IMCR registers need to be revealed for kernel to configure pinmux.
> > +
> > +  Please note that some register indexes are reserved in S32G2, such as
> > +  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,s32g2-siul2-pinctrl
> > +
> > +  reg:
> > +    description: |
> > +      A list of MSCR/IMCR register regions to be reserved.
> > +      - MSCR (Multiplexed Signal Configuration Register)
> > +        An MSCR register can configure the associated pin as either a GPIO pin
> > +        or a function output pin depends on the selected signal source.
> > +      - IMCR (Input Multiplexed Signal Configuration Register)
> > +        An IMCR register can configure the associated pin as function input
> > +        pin depends on the selected signal source.
> > +    items:
> > +      - description: MSCR registers group 0 in SIUL2_0
> > +      - description: MSCR registers group 1 in SIUL2_1
> > +      - description: MSCR registers group 2 in SIUL2_1
> > +      - description: IMCR registers group 0 in SIUL2_0
> > +      - description: IMCR registers group 1 in SIUL2_1
> > +      - description: IMCR registers group 2 in SIUL2_1
> > +
> > +patternProperties:
> > +  '-pins$':
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    patternProperties:
> > +      '-grp[0-9]$':
> > +        type: object
> > +        allOf:
> > +          - $ref: pinmux-node.yaml#
> > +          - $ref: pincfg-node.yaml#
> > +        description: |
> > +          Pinctrl node's client devices specify pin muxes using subnodes,
> > +          which in turn use the standard properties below.
> > +
> > +        properties:
> > +          bias-disable: true
> > +          bias-high-impedance: true
> > +          bias-pull-up: true
> > +          bias-pull-down: true
> > +          drive-open-drain: true
> > +          input-enable: true
> > +          output-enable: true
> > +
> > +          pinmux:
> > +            description: |
> > +               An integer array for representing pinmux configurations of
> > +               a device. Each integer consists of a PIN_ID and a 4-bit
> > +               selected signal source(SSS) as IOMUX setting, which is
> > +               calculated as: pinmux = (PIN_ID << 4 | SSS)
> > +
> > +          slew-rate:
> > +            description: |
> > +              0: 208MHz
> > +              1-3: Reserved
> > +              4: 166MHz
> > +              5: 150MHz
> > +              6: 133MHz
> > +              7: 83MHz
> > +            enum: [0, 4, 5, 6, 7]
> 
> You have known values, then use them. This is much more readable in DTS.

The main reason of mapping with register values [0-7] is to simplify the
driver implementation while handling register r/w. To improve readability
as you suggested, I am thinking of having a DT header "s32g2-pinfunc.h" with
a few binding macros/helper as below, the only difference compared to v3 is
using S32G2_PINMUX and S32G2_SLEW_XXXMHZ macros rather than pure integers
to represent pinmux and slew-rate property values.

Regards,
Chester


From 3a29d905ae104e694230ffc02dc9f9de4191c5d1 Mon Sep 17 00:00:00 2001
From: Chester Lin <clin@suse.com>
Date: Fri, 28 Oct 2022 16:44:29 +0800
Subject: [PATCH] dt-bindings: pinctrl: add support for NXP S32 SoCs

Add DT schema and hedaer file for the pinctrl driver of NXP S32 SoC family.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 136 ++++++++++++++++++
 include/dt-bindings/pinctrl/s32g2-pinfunc.h   |  17 +++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/s32g2-pinfunc.h

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
new file mode 100644
index 000000000000..9083d299dd85
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2 pin controller
+
+maintainers:
+  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
+  - Chester Lin <clin@suse.com>
+
+description: |
+  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
+  whose memory map is split into two regions:
+    SIUL2_0 @ 0x4009c000
+    SIUL2_1 @ 0x44010000
+
+  Every SIUL2 region has multiple register types, and here only MSCR and
+  IMCR registers need to be revealed for kernel to configure pinmux.
+
+  Please note that some register indexes are reserved in S32G2, such as
+  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g2-siul2-pinctrl
+
+  reg:
+    description: |
+      A list of MSCR/IMCR register regions to be reserved.
+      - MSCR (Multiplexed Signal Configuration Register)
+        An MSCR register can configure the associated pin as either a GPIO pin
+        or a function output pin depends on the selected signal source.
+      - IMCR (Input Multiplexed Signal Configuration Register)
+        An IMCR register can configure the associated pin as function input
+        pin depends on the selected signal source.
+    items:
+      - description: MSCR registers group 0 in SIUL2_0
+      - description: MSCR registers group 1 in SIUL2_1
+      - description: MSCR registers group 2 in SIUL2_1
+      - description: IMCR registers group 0 in SIUL2_0
+      - description: IMCR registers group 1 in SIUL2_1
+      - description: IMCR registers group 2 in SIUL2_1
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '-grp[0-9]$':
+        type: object
+        allOf:
+          - $ref: pinmux-node.yaml#
+          - $ref: pincfg-node.yaml#
+        description: |
+          Pinctrl node's client devices specify pin muxes using subnodes,
+          which in turn use the standard properties below.
+
+        properties:
+          bias-disable: true
+          bias-high-impedance: true
+          bias-pull-up: true
+          bias-pull-down: true
+          drive-open-drain: true
+          input-enable: true
+          output-enable: true
+
+          pinmux:
+            description: |
+               An integer array for representing pinmux configurations of
+               a device. Each integer consists of a PIN_ID and a 4-bit
+               selected signal source(SSS) as IOMUX setting, which is
+               calculated as: pinmux = (PIN_ID << 4 | SSS)
+               It's recommended that using the helper macro S32G2_PINMUX()
+               defined in dt-bindings/pinctrl/s32g2-pinfunc.h in order to
+               assemble a pinmux value.
+
+          slew-rate:
+            description: |
+              0: 208MHz
+              1-3: Reserved
+              4: 166MHz
+              5: 150MHz
+              6: 133MHz
+              7: 83MHz
+              The available slew rates are defined as macros in
+              dt-bindings/pinctrl/s32g2-pinfunc.h.
+            enum: [0, 4, 5, 6, 7]
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/s32g2-pinfunc.h>
+
+    pinctrl@4009c240 {
+        compatible = "nxp,s32g2-siul2-pinctrl";
+
+              /* MSCR0-MSCR101 registers on siul2_0 */
+        reg = <0x4009c240 0x198>,
+              /* MSCR112-MSCR122 registers on siul2_1 */
+              <0x44010400 0x2c>,
+              /* MSCR144-MSCR190 registers on siul2_1 */
+              <0x44010480 0xbc>,
+              /* IMCR0-IMCR83 registers on siul2_0 */
+              <0x4009ca40 0x150>,
+              /* IMCR119-IMCR397 registers on siul2_1 */
+              <0x44010c1c 0x45c>,
+              /* IMCR430-IMCR495 registers on siul2_1 */
+              <0x440110f8 0x108>;
+
+        llce-can0-pins {
+            llce-can0-grp0 {
+                pinmux = <S32G2_PINMUX(43, 0)>;
+                input-enable;
+                slew-rate = <S32G2_SLEW_208MHZ>;
+            };
+
+            llce-can0-grp1 {
+                pinmux = <S32G2_PINMUX(44, 2)>;
+                output-enable;
+                slew-rate = <S32G2_SLEW_208MHZ>;
+            };
+        };
+    };
+...
diff --git a/include/dt-bindings/pinctrl/s32g2-pinfunc.h b/include/dt-bindings/pinctrl/s32g2-pinfunc.h
new file mode 100644
index 000000000000..f5abf0388547
--- /dev/null
+++ b/include/dt-bindings/pinctrl/s32g2-pinfunc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-or-later) */
+/*
+ * Copyright 2022 NXP
+ */
+
+#ifndef _DT_BINDINGS_S32G2_PINFUNC_H
+#define _DT_BINDINGS_S32G2_PINFUNC_H
+
+#define S32G2_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
+
+#define S32G2_SLEW_208MHZ	0
+#define S32G2_SLEW_166MHZ	4
+#define S32G2_SLEW_150MHZ	5
+#define S32G2_SLEW_133MHZ	6
+#define S32G2_SLEW_83MHZ	7
+
+#endif
-- 
2.37.3
