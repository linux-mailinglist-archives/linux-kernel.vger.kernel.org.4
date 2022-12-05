Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED64D6422F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLEGRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiLEGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:17:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83271147B;
        Sun,  4 Dec 2022 22:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFDmYu5q7U+ziKVUGwk0lvAYMhwUhvlGwMUyaoURGSHRZpJeFQysuymoYJhCS7k8X1bx5siNpOnDw0Dp2sVWjbYMIZ8yFx6G9RLoOuFVsz9c5KuwnO0MeNJSStbYmW3Src6JZ4zIkp9waNYmoxJQHVXQjHqmMab+rXKUIcvQ5liMRw1Nhywvg9ozqpuQ7hgguZDiADDbu7PDqtHq0OzM32GkCzRgx4eHHmCHuatk1MB08kTjFcp/xLEK36y13F5xLI4yDLmboLW438ubsVQUxmDCRjSH/LHL6HipxDfII3v2EQtHlRqVslU75R49hfOHdQ/2IEsEo+hldfltP3kN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbKn8evOIAnmiUHT7xJRTSTmp0f6HhF78I3e441ueWI=;
 b=jCxjwMhxpWiBgL0niIkmjlUESO8ydpG4jzQx0sF6EMqRQoTxMXU4GVpTSELq1Gm0RmVHxFnE+aCX/fFthwCoS7cOcT1muRm6VecYO/bM8Lvygk1i72Pc0Gf/Ht9m5z7fC0KmN/aPuCi7OLaoahaNKWHAovGwPgPBTA6cTiSsjeZG6SkRxGUoSWp9jJ6rocrcxH000wsXjeozwStto0P1hZUOxtfp5IoAshA0ZZdKSCCc4JQKOmyps/X/XRZn0OLyA42CKLv+gNwxBI/Cxa1isOmSVs8XFSaOHTaUXc6gVUVqGuirl5TVJNoNFnwXSwjfoWu3gn6u6m3FmMpFvVcKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbKn8evOIAnmiUHT7xJRTSTmp0f6HhF78I3e441ueWI=;
 b=vAuqXSDEEkFKSleEeVCz1km67vFHW8XakoC4PgLzAoteFeAvQ5rsQb0GQKbAGQdrb0k1u0G05f57Wmr4cIwQgF3dPeN26gRBJu2u4k92lWcr9VNof++ID6mcxCHjxxJUzZVF5vi8fChPJs0m5/xqmu2ajorcIHXXDuuhBN+8z5q2wwx8EOz62w1w2+MiIXi3djd+/KD+cxHh/AMmYOaDSGJuPP91hcJ5tY+impMCOM+bHIFHLMpJO8o2AfBCIdXD9ht9eTsZ1Ng6yl27s+F5VLJlKwjbJHctl7aS5hW9dmX+ei9gramTlTq+4DHMrtrZJ9XsKlbZsLtrV4pxbfDq8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 5 Dec
 2022 06:17:02 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 06:17:02 +0000
Date:   Mon, 5 Dec 2022 14:16:43 +0800
From:   Chester Lin <clin@suse.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y42MyyLumVa8phpd@linux-8mug>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
 <6ad95ce3-887d-48fd-3c08-f50d4e666ded@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad95ce3-887d-48fd-3c08-f50d4e666ded@linaro.org>
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a76eec-c304-4984-6213-08dad6885272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcNA1h0yyVjlijOc6K0OcAqqCpTlysiePkiJq2GsXwyjll3NaRXg/NoRtt2k3Fv2juKoAQJ82wnVf+Oxeb5SZ4En7KdMXUfyP8o3i6gXMYcn6NKs/qxmr26LLEpJ7LcNooIpa7gwB2/TtkuoXAvR8wEbbo44mAIgMM4PQgI7cdrM0mkEN7IXhUHB+L4rTwsFazFb+FgYThLHUXF0c6kZO/w8Gp7YxwfXHj7faJENiPKLZeo3tQBoGmiaf4NSCrdreFeUSMfVJ45MZTnj38/EQB9o9OjlqlQXWC2L66mIuYDQGtjAer6tMplqsMn6hdTO9ssD0L4LHRnV2s1PSX4grMRtQ6zn4QcYnbIX2MSQkjViurXwabg6sIOdW76bQlHngqZwLkpaRClXyqKRAp/XMHFu9rDodx0hiiaJAuM8kEl39VA24NK0vGsrv9tCa+nzrblkV7W7GsBkJ1/1F8cJibXhqfnKKiXHlzXs9hcs/daYYrDtn6XScNppV6q+LIIctHkx0jF8FujUIJScSo/hcEkWAKyUcKpVYO1Dm6MybBbh8ImdtQRpXAXIlD4XDVjndSk2NZrRAZIl8QdJ9k1y0prLDxX+rxwxWvknip21hZQplik4T32zpEtJ8aeR4Rq+HnO42kewNWLM8AaAiyk3wL8tVrxT8iFBHLytJLah+QJDU/qJgCDIWdaYwucnIeLQHULD04kE+RqbRJpxDgvhcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(38100700002)(86362001)(7416002)(2906002)(66476007)(66946007)(4326008)(8936002)(8676002)(41300700001)(66556008)(33716001)(53546011)(26005)(9686003)(6512007)(6506007)(186003)(6666004)(5660300002)(6916009)(316002)(54906003)(478600001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8YVYoDbdjNpbTvX+zdikH+NUhPuUUUGOx0a5df/xxHjuSY2sW5CUiuQ1y44?=
 =?us-ascii?Q?UAn5QBlLvsUml/yHOeIjYlnZMHSkgKNTo3ttzhO7P6FuwKkPDIDfBnDhWFmh?=
 =?us-ascii?Q?/+M3vouuQ7hqvsC36GvqQQPgiz1o730L5wuY96W7fMx3/IQH6egbjKaehO3r?=
 =?us-ascii?Q?kR790uAA8+dE3Doq/BlQLzPuUkmXLu1pgvBTLeOPshBbht92O89jB9uMtfJ4?=
 =?us-ascii?Q?6erwuDzF+ek9agrf7tnNk08rV5iMd5Xyz5AdE+OIazTpIB+hJYr99Gv9wTkm?=
 =?us-ascii?Q?mgiVT6/+PAqmdQE7cC5Ww6zghQeiknXGIcZxsYFg+6OfzWg7mF1xZc0XsAy5?=
 =?us-ascii?Q?8ys/QBqX5/4RnyhSDcqydGHLybztsvfC4xoZ1v749as3jvD2amXDuOl9pY8p?=
 =?us-ascii?Q?AZmjwTbBSuyNdxBfyXYZbUq4ZcAGNFD4nqoQDQIrf0kDaq1c2Sjs6kPMeQaX?=
 =?us-ascii?Q?Njepngkf5o1cSEmUOYMLL+GX+GG9xW+k8P7q4g9a5r+BE99JVu0VxxCVgZD7?=
 =?us-ascii?Q?Jb2DY+X1dUEM96PJJS6ZiAY7M1NFzDP6tWXqONqFfXxsA2pWk+V2iXVzCO72?=
 =?us-ascii?Q?aCwRuXYY1+Q28OONIm87h4Y4IodyLAHzr0EHUsKgdlWE1kEkoe45c0kMynTK?=
 =?us-ascii?Q?K8MSAMVuDXgejrv9BnlgMkvG4KcR7escwCc7wIJAIAzx1yQ01wCi2ZSjK8xM?=
 =?us-ascii?Q?vJz3qbID0HlRP42aFIRBWp8mPiL29XO6mmKktgyvHXNlzL6+X79uBSOi98be?=
 =?us-ascii?Q?1JcqSvT1LxtHdgg+TTd9Mb84fp1IGA90GjeT9m4TuBzqV7TzMBpYB7zN76ma?=
 =?us-ascii?Q?4W65RjUhuz396aG8FjOokjz9ht5mW55HDmTJ4Vn5sCYO2JDrCDLMY7P6cGg9?=
 =?us-ascii?Q?XVrMULMsEj/PpCiFeXG+nsjMuHOJvp56r28NZL9UWXi888vfvq/raJDzvPSv?=
 =?us-ascii?Q?tg4azqX1n4j81Fry2hiNfJ0QgYvlGD/mNkzj3tFRuWEZ9NUgzrO5jtwe1feH?=
 =?us-ascii?Q?TkKMnQ1F3+Uv2eHg0QSmJ/3v8xVaGsWKMty08gejDEvY/OAknQptya8OL+w+?=
 =?us-ascii?Q?DBWL0TzNfgKjL3I+RZtLgyDjDXLH/3l54KArT3vTfi2bDwtB5HLurOdmx3jw?=
 =?us-ascii?Q?3kVFexprYCbWeiNVhzzQjSn3g75IdW/13q0kv3JWNqv2cBLA8nl3A98M9Lfv?=
 =?us-ascii?Q?zamw/G1W5oAVS3sJSc3LgxfWXDwe8LRf2m9g6oBg9lbhp3SXfiQzX44Hl3zZ?=
 =?us-ascii?Q?i/GpFzoWwBZe9uCdkCtJNz96eoSYVzSdGZ/Fcc5nS3oH0qYiqEw6PX8plEM5?=
 =?us-ascii?Q?KiKPgfCS/DdyNy1AfjlMDcYt+l470AZYv5oMUhw0dL7Etqo/I5ZsWc/tUpFt?=
 =?us-ascii?Q?5booVyqYSRwftMVo7cDj1HI4YvPRMaII8dc1fdX89pmlqsr5bCS0lxRmvUQz?=
 =?us-ascii?Q?vBkuXmG3sbG+N8U5l8xBrtDUxSrPdcbh6KK+GleAxLtx540ad/pWLHk4mGJ6?=
 =?us-ascii?Q?o9qW9SVY+l0zbPPc8KdhYqJzGM06gsAkl9teTqVjDI5bfr+UWRxx5n/emZ9b?=
 =?us-ascii?Q?LStMl5GTV7xHi1zMldw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a76eec-c304-4984-6213-08dad6885272
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 06:17:02.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5igKmtCsXt0yEuOQwAo2lLuBd8Sih4RroWgamHyXbsrh3zV2M1WD0R65HzLUDYs2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
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

On Wed, Nov 30, 2022 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2022 06:48, Chester Lin wrote:
> > Add DT schema for the pinctrl driver of NXP S32 SoC family.
> > 
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > 
> > Changes in v2:
> > - Remove the "nxp,pins" property since it has been moved into the driver.
> > - Add descriptions for reg entries.
> > - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
> > - Fix schema issues and revise the example.
> > - Fix the copyright format suggested by NXP.
> > 
> >  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..2fc25a9362af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> 
> Usually filename matches the compatible (or family name), so any reason
> why compatible is "nxp,s32g2" but filename is "nxp,s32cc"?
> 

According to NXP, the S32CC is a microarch which is adapted by different S32 SoCs,
such as S32G2/G3 and S32R45. Some common IPs are implemented in S32CC, such as
serial, pinctrl, mmc, gmac and some other peripheral interfaces. S32R45 has
different pinouts compared to S32G2, which means that there would not be just
"s32g2-siul2-pinctrl" but also "s32r45-siul2-pinctrl" in the compatible enum if
S32R45 has to be upstreamed in the future. For this case, it seems to be
inappropriate that adding a compatible name without any "s32g" keyword in the
filename "nxp,s32g2-.." unless creating a new yaml for each platform, such as
nxp,s32r45-siul2-pinctl.yaml.

> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2022 NXP
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/nxp,s32cc-siul2-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32 Common Chassis SIUL2 iomux controller
> > +
> > +maintainers:
> > +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > +  - Chester Lin <clin@suse.com>
> > +
> > +description: |
> > +  Core driver for the pin controller found on S32 Common Chassis SoC.
> 
> If "Core driver for the" refers to Linux driver, then drop it. If refers
> to something else, please elaborate.
> 

Will fix it in v3.

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,s32g2-siul2-pinctrl
> > +
> > +  reg:
> > +    description:
> > +      A list of MSCR/IMCR register regions to be reserved.
> > +      - MSCR (Multiplexed Signal Configuration Register)
> > +        An MSCR register can configure the associated pin as either a GPIO pin
> > +        or a function output pin depends on the selected signal source.
> > +      - IMCR (Input Multiplexed Signal Configuration Register)
> > +        An IMCR register can configure the associated pin as function input
> > +        pin depends on the selected signal source.
> > +    minItems: 5
> > +    items:
> > +      - description: MSCR registers group 0 managed by the SIUL2 controller 0
> > +      - description: MSCR registers group 1 managed by the SIUL2 controller 1
> > +      - description: MSCR registers group 2 managed by the SIUL2 controller 1
> > +      - description: IMCR registers group 0 managed by the SIUL2 controller 0
> > +      - description: IMCR registers group 1 managed by the SIUL2 controller 1
> > +      - description: IMCR registers group 2 managed by the SIUL2 controller 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> required goes after all properties, so below patternProperties.

Will fix in v3.

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
> > +        unevaluatedProperties: false
> > +        description:
> > +          Pinctrl node's client devices specify pin muxes using subnodes,
> > +          which in turn use the standard properties.
> 
> All properties are accepted? What about values, e.g. for drive strength?

For those unsupported properties such as drive-strength, the s32g2 pinctrl driver
returns -EOPNOTSUPP.

> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    /* Pins functions (SSS field) */
> > +    #define FUNC0  0
> > +    #define FUNC1  1
> > +    #define FUNC2  2
> > +    #define FUNC3  3
> > +    #define FUNC4  4
> > +    #define FUNC5  5
> > +    #define FUNC6  6
> > +    #define FUNC7  7
> > +
> > +    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
> > +
> > +    #define S32CC_SLEW_208MHZ  0
> > +    #define S32CC_SLEW_166MHZ  4
> > +    #define S32CC_SLEW_150MHZ  5
> > +    #define S32CC_SLEW_133MHZ  6
> > +    #define S32CC_SLEW_83MHZ   7
> > +
> > +    pinctrl@4009c240 {
> > +        compatible = "nxp,s32g2-siul2-pinctrl";
> > +
> > +        /*
> > +         * There are two SIUL2 controllers in S32G2:
> > +         *
> > +         *   siul2_0 @ 0x4009c000
> > +         *   siul2_1 @ 0x44010000
> > +         *
> > +         * Every SIUL2 controller has multiple register types, and here
> > +         * only MSCR and IMCR registers need to be revealed for kernel
> > +         * to configure pinmux. Please note that some indexes are reserved,
> > +         * such as MSCR102-MSCR111 in the following reg property.
> > +         */
> > +
> 
> Either this should be part of description or should be dropped. It blows
> example and probably duplicates DTS.
> 
> 
> Best regards,
> Krzysztof
> 
