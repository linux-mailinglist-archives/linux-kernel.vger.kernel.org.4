Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D390A622EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKIPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiKIPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:04:53 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39831705F;
        Wed,  9 Nov 2022 07:04:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VstW5x1QrXlFFN60w8XiASAwurU3h6a+JoW88n1NmStxHoo3kr9ajs4Ar35IGWY3weGLCypFShqmqVECpRELsqZ0xivxoPAHlumAbzxZPjFF3VhrE+IDMcsCgPTPXl6u8nseQi9hbaU+FMV22MurbBQRLM8s5J5tSvYxCk3Y24UwdfJ/65oNMoxF8fLsa5NICsxHL/p17n5UVOD5ify7kJgRVx+DQ1596nhjuchZxwZL9o5k5HMxwVaAgHx3MOYw8hcmh3iNUt0uuceljmi/40HL7CGg5ZFp7pKyWbJGVzbxi8ZZOBv/jXUDZG8A8RSVDYkVO7sG54vMh04BZj9seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDkFu3FZah+MK0t84bFMo9cpc6KJdiR7Y8inoJq5Gb8=;
 b=lP7UYIllavktMjWcbEKWGFmpRa0c3tewLLpt9KhkI0P4xcl4VLJdG/S3UXnUEO5wH8xJkoh8EbBK5ROz0hbF8gcSZ4eWc5sEQp60NTB8j7Whxcr2JPYViQNUT2hdb4F+gph5NQbnaWpOqtu7vUfRHQpXq7MUi5jhItA/X94qQ06f/CLzzk2K0a9bbyYRqBYDuIqO/z4oQpCZrRs4otdtvxO3wb8i+HUbiUo8Oa5xgtkgvqmCmyFAueTjelUQupXWi6LtPeItkmF+jDS7Yri6dtMHZ7Di0/8qUREoYX4ayTgdIWmCKV/sLsggZBx+Wj/8ma5Bam6zK57ln2txK3qeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDkFu3FZah+MK0t84bFMo9cpc6KJdiR7Y8inoJq5Gb8=;
 b=USK4LkDixQ80orEvWFSnhj+h/TPDoSIzeGlNXUOr8bvR1DEsI3xeqH2JNGWmk7gs09eNGL6MIBt23t9pejLXNMq0g8er8+cwJTRG2n7Emao8jOgaQwpcccZd0P2fqe8RrJogUZMB1FqpUOgiLhIZZtMt0KgDLd5Olv9Nhkf1XxykMGIzrP6zHVqiUpCCmxFrxTuDuLXMFXTjOoZ1oPVcEgKuKSDTgU47mo6ikVo2XjGEhft77cxhM08CtehPD2dSKQ1h8ar03yAcXud7pbJwlZUi23DSwTOaiPbScBCvmIHp1cwHGThYWtoEI+tZnuQSDRJ9M066EJk4iU75Cft5uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB7550.eurprd04.prod.outlook.com (2603:10a6:102:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 9 Nov
 2022 15:04:50 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 15:04:50 +0000
Date:   Wed, 9 Nov 2022 23:04:37 +0800
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Chester Lin <clin@suse.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y2vBhcN7IQwgWwMS@linux-8mug>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-2-clin@suse.com>
 <20221102154903.GA3726664-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102154903.GA3726664-robh@kernel.org>
X-ClientProxiedBy: AS9PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::17) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PA4PR04MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 316eed6a-d7b9-4e25-80ad-08dac263bf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tg39vy9/gXEm5Dk92ieUL/LQJtXlS9JNb6NiXMqzQX1op2CneaxIvYRF2jBdb2fiEujJWvIdiLPMXr1dnvOSsPI8v4PoqC8MeA0x9QDqnSnJu9IpUVc5nGGO2tVVktJxOyFYE3/21Dvmacj6GHtUgJDI3XlwYxDuruQh6poH9B40ftfStpaCwFwDcvhuAcvQhT/OCxxU/Fc3sZvhesO7J3qF4RND9Hx8uZr42BwZoJjRfgvAL9wv+4t7i5XlDlwjOTkg/P91F1qYp3WokxHqLI7c5u8UlkCcw9vegPC+bMc/0uT0HIV8N81PXG2fGxLh2JI2OMjasmECSbqW3d2zHTmYBCIKfgwOUyhWotJXcpZY5JXjFLH0ai9jfLHhvJ+54T24JNFJsNF/V00kO+fUJCNf5eiaPQ1AdLRWhmRj26JnMAaw/lMM64FM6SKby8vl4xr9B+8ysGj5lRH7F2twPYaOx+7wEWNfVk9LZ5tQKKkmwzd0qrAghtTgmPDJZcsu57ivj6EwB1uhLRgWTFx7rJp5a71nzWBC37ZF15eHI8BvXN/W0KyMflI2vU03aAcBH7FFuXS8UehrqShpfnR3rHj7DZVNr0V5pZKi08cx0rn3/yARI4KYz9iYriaUlEWWFUtfvl+CXHauSGaGPZ9cWVJR7S13HTzAt/2xHL8xP79c1fSsr2RdwORsNECmBJtz8kUWwPyfswwdIegPr7e2EhnNwNB1uOZzyyzu/acgkdFXaFYpqDZouylN3GaNtcL/v7lpsYn4PatjdhJJp8FaNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(38100700002)(83380400001)(86362001)(33716001)(966005)(2906002)(9686003)(6512007)(40140700001)(186003)(26005)(6506007)(6486002)(107886003)(8936002)(5660300002)(6916009)(7416002)(54906003)(316002)(6666004)(4326008)(41300700001)(66556008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwxBMJo1lD+8586i+7Jqtv2M9L+a1o0NpSNk8YPfJmLuIvfP+o1b/HoljvAZ?=
 =?us-ascii?Q?v+kQqPUroG6ej6vN1UCqjqAnaiONdufHpMCyVmanLbTPMjcqIW8WeU0qc/jJ?=
 =?us-ascii?Q?QFJPw7zGGZiFVstBU9BErKIKtX3IooL91UC0MBYEYDZHIBX1/5Cs4+3I4aLy?=
 =?us-ascii?Q?eDPZoeYkjQ6R//mLX1eBlOzzHfC2rFeGzKERQE2K4clWPgqAnJ+2lFdL9Trd?=
 =?us-ascii?Q?YAyhYx+MDzzojeuI2nWY2NgUv4mQU8pElX64HHRZo/rcCuRVMUgXiSHeDVCl?=
 =?us-ascii?Q?6+cAZStIZgYhWL4y1g3fZGfe/6Vu1MT663NTf+R5G9Dmff1O2M0ljgVvqK2X?=
 =?us-ascii?Q?0vzZwrrW0seyrHMAvvH6Hc9CcED+vexItQ/SI0MBj3Ib34l0/uMnpel8jp3B?=
 =?us-ascii?Q?r8qBD92vy0xzwMXPhuhUom5YpzaxfR2IGJ7XJNAph00aOKX7E7XoG0o4iS0i?=
 =?us-ascii?Q?szehlqwkvbX48HcUjblSnGzF0bXClZg/chWLStaE3S+ZizVpcNT8MnuQDMSh?=
 =?us-ascii?Q?roykRVVSZcko9G8TALkUWigD/eBf4H7oE0dw+JiD0Ax7IxS6Q/fMsflzFdXc?=
 =?us-ascii?Q?f6YtcSGvqybPnjg6Re3BMWcnIHjXhMkwm2nm+xpnT50i6c5EOY+SbcmK6qsl?=
 =?us-ascii?Q?AOhCOD1V62rjXUKmFxgBnd55few4TP1t1f6n4bJ3mIWIShkl8YnG7rK+FXSN?=
 =?us-ascii?Q?0oxMU42Uch3ejZpnUNdaVaSDBwh14tmB1Eap4lK7XTJ36EkRjDW/mEWknpXb?=
 =?us-ascii?Q?rxD5pMFszTYsc2Ux3xyBYr41DuwbRJTnghAhICGv7YSGrBCMHCCnwL9JZG+q?=
 =?us-ascii?Q?AMEVEKleU+89boWWybRd8/oYfIICimnUPMrIn6nE8zDYjsLbnNNgpv5ENFis?=
 =?us-ascii?Q?3ecvaepMrslSYshEgpccY+twEc+u3lkTxcVEt9ISPRKIoQBspN07OSuTasbb?=
 =?us-ascii?Q?MSIln2kPR8zD29v29B8HQe6BniU6y+lQvXJvRXGIWZ6QWi27tm0EtAj2+uRq?=
 =?us-ascii?Q?Jj4m+c2qmhflj1RISJHd2mkWxJDYh47CBO3D44A12DLJeilRj4x1SPAsCSZh?=
 =?us-ascii?Q?wo17xa5kS9el5ybuI91+n6n3WmKkQtySJjO0EGKEzC6JOfSdLbf/vYsS0XAZ?=
 =?us-ascii?Q?J1gQmaEjmWnO0Sn6DeruyFIy385YY9cDWlwoB1UfCOGwZI/XNDsxHhMWS/b8?=
 =?us-ascii?Q?Y2y+RmQAIg/BUOUnAe3Bogy3Z0tOM5QaKRCQcxTCAvGx4NWt2Z5YY3+jm6Wu?=
 =?us-ascii?Q?B+gVKkb5DdrawplyA1/pdahzdt5gkM0VtbwEgguPhgebAW1f68tmHXVbphN9?=
 =?us-ascii?Q?eDpoTwVzmdZRZy57mC+iXQ5IpTfkVw+5oZoBLjJqvhkfueRCIpPse9cXFIIx?=
 =?us-ascii?Q?FL1nHKf6W54sw1UYHO1ax7UiU+Ot9fFVUCx334ZtXyRTYX1lnRVIyhVjUznS?=
 =?us-ascii?Q?syMjGqoKWFZ667wj8tAuVp78Non4m7Mtwlq7GobYhCObOnGBprJUEyXoyVXC?=
 =?us-ascii?Q?gdSar4lNYLdvZWhUYs3wORGVpWyl79nBPNxhXAMaBo3xe9NxukCvycyXUhMl?=
 =?us-ascii?Q?xbdfPjpk14gGDOSKLeY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316eed6a-d7b9-4e25-80ad-08dac263bf90
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 15:04:50.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0MJeNu2H0DhMJXp4f17Fc03BBQPI6tG1iRxIt9TrYHxRBfJlpMucz8ZsF1wI7lY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for reviewing this patch.

On Wed, Nov 02, 2022 at 10:49:03AM -0500, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 06:08:42PM +0800, Chester Lin wrote:
> > Add DT schema for the pinctrl driver of NXP S32 SoC family.
> > 
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..eafb9091cbf7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2022 NXP
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
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,s32g-siul2-pinctrl
> > +
> > +  reg:
> > +    minItems: 5
> > +    maxItems: 6
> > +    description: A list of register regions to be reserved.
> 
> Need to be explicit about what each entry is.
> 

They are
  - MSCR registers group 0 managed by the SIUL2 controller #0
  - MSCR registers group 1 managed by the SIUL2 controller #1
  - MSCR registers group 2 managed by the SIUL2 controller #1
  - IMCR registers group 0 managed by the SIUL2 controller #0
  - IMCR registers group 1 managed by the SIUL2 controller #1
  - IMCR registers group 2 managed by the SIUL2 controller #1

  - MSCR: Multiplexed Signal Configuration Register
    An MSCR register can configure the associated pin as either a GPIO pin
    or a function output pin depends on the selected signal source.
  - IMCR: Input Multiplexed Signal Configuration Register
    An IMCR register can configure the associated pin as function input
    pin depends on the selected signal source.


I will add descriptions for each entry in v2, thanks.

> > +
> > +  nxp,pins:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      A list of [start, end] pin ID boundaries that correspond to each of
> > +      the register regions reserved.
> 
> Looks like a matrix rather than an array.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - nxp,pins
> > +
> > +patternProperties:
> > +  '_pins$':
> 
> s/_/-/
> 
> > +    type: object
> 
>        additionalProperties: false
> 
> (and a blank line after)
> 
> > +    patternProperties:
> > +      '_grp[0-9]$':
> 
> s/_/-/
> 
> > +        type: object
> > +        allOf:
> > +          - $ref: pinmux-node.yaml#
> > +          - $ref: pincfg-node.yaml#
> 
>            unevaluatedProperties: false
> 
> > +        description:
> > +          Pinctrl node's client devices specify pin muxes using subnodes,
> > +          which in turn use the standard properties below.
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    pinctrl: siul2-pinctrl@4009c240 {
> 
> pinctrl@...
> 
> > +        compatible = "nxp,s32g-siul2-pinctrl";
> > +
> > +              /* MSCR range */
> > +        reg = <0x4009c240 0x198>,
> > +              <0x44010400 0x2c>,
> > +              <0x44010480 0xbc>,
> > +              /* MSCR range */

It's IMCR range but not the 2nd MSCR range, will fix it in v2.

> > +              <0x4009ca40 0x150>,
> > +              <0x44010c1c 0x45c>,
> > +              <0x440110f8 0x108>;
> 
> What is in these holes in the memory map? Is this part of some larger 
> block? If so, that block needs to be described.
> 

In this case S32G contains two SIUL2 controllers, which are located in two
different memory regions, siul2_0@4009C000 and siul2_1@44010000. The siul2_0
contains the MSCR0-MSCR101 [starts at 0x4009c240] and IMCR0-IMCR83 [starts
at 0x4009ca40] registers, and there are some other reserved regions and
registers which are not related to pin muxing in siul2 memory ranges. Not sure
what the original reason it could be, but the expanded MSCR112-MSCR122, MSCR144
-MSCR190 and IMCR119-IMCR397, IMCR430-IMCR495 registers are present in
siul2_1's memory space. Besides, in the S32G pin map, some indexes are hidden
since they're not used as pinouts, such as MSCR indexes 102-111, 123-143, and
IMCR indexes 84-118, 398-429.

Anyway, that's why they look so fragmented. I will add more descriptions for
each entry in v2.

Thanks,
Chester

> > +
> > +                   /* MSCR range */
> > +        nxp,pins = <0   101>,
> > +                   <112 122>,
> > +                   <144 190>,
> > +                   /* IMCR range */
> > +                   <512 595>,
> > +                   <631 909>,
> > +                   <942 1007>;
> > +
> > +        llce_can0_pins {
> > +            llce_can0_grp0 {
> > +                pinmux = <0x2b0>;
> > +                input-enable;
> > +                slew-rate = <0x00>;
> > +            };
> > +
> > +            llce_can0_grp1 {
> > +                pinmux = <0x2c2>;
> > +                output-enable;
> > +                slew-rate = <0x00>;
> > +            };
> > +        };
> > +    };
> > +...
> > -- 
> > 2.37.3
> > 
> > 
