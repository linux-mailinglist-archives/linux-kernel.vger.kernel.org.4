Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A463C333
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiK2Owc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiK2Ow0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:52:26 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4200F4E;
        Tue, 29 Nov 2022 06:52:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVK0usL8tVjhBaRA0P9SgMrf7dNTQx9DPzxxXsCL2sJUxOWr7cmOkirjcQyf+cRQNLW4BzXLCjem9NoRbXjARqoEkOxAlPohFChkHUDT6k6e4BU3xNUD7VTKpnGbQZrQzOJPcbp6gMH5tks8UZcvJ4fqtZIqeXaqxX/6aPGaHA1usZHRMSq8oQL8InHvOC5TLtlVXzZTe5nXw7ZreSBg03kWBXRDSAcEwRyNCzy0YERQ9Dhj/x9LQcvOm76cUza0i8GDTgh56p6avrYhAp55wgAfRmlIsTGMJckIpYLYRIVlBJzoNwU9O461LqSSF6AkwLB8tQa2178Ly6BW6BCUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I1VPNoaZ1UNaTF5uoC+G4KyCg1joWccAbk0wVy7ZRE=;
 b=Qlpsl/thd6QakkBuAShiylUjl0+sPVTrKtW0iwN9V1p1SNjC0mUJMqRxxU3X37FMFkOR16oMJmRauxknKCXEZhEHEEjegD/tgozb8c0KwaVTPxUeMLYjhj+PYwWq/o9rNDRAKjb79QuCb+otGpXvj1yZNAMgWU4/4Pgbu1CYPOzizd9/AzumwdVrEjowY/GpvhlMbez5t6WVuvL5Em0ETMvJimNugXCmLD6ivNxLJ+1Ya3/ZBgkTGnTU1/f3HXVFfDRPEj4eIKA9Hj+/CB8SEUiIgjfh4eGyNuIwhApP8U/8+s0wO123hIPSL6LOVhVYwgGP98UrIuHFaJIT6FXdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I1VPNoaZ1UNaTF5uoC+G4KyCg1joWccAbk0wVy7ZRE=;
 b=DCNPOCh4XxhZv9UXrHcRal69GJj//xj/P3x0LcJ2/7vAXha6y3VWUPmuLo4TaMzK98VttqPAOCMmU32MzWem8nfLdA9/o9unCiwN0FNugVOlkywt7/3oW+tvgVgmvtDl1V30ciacxZvsmbZisGqhThsoNHaE7Qomgs0QuPqaHgF42CwLYQaAfIWuauyR4xT7ufHPEIpLkoKDcfmiA0iiOnNcy3bfr9aNqJ/B+9+efexU3/zgwTV+1o6F/a17xPXsuxnXB7TlxdjRTnHs1crj73Da29CUrdigWNWLQYPNZlKbAGn7qyc2n0f0GOYykQg1D7mmp89E3vENE8Sc+s3U8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBAPR04MB7336.eurprd04.prod.outlook.com (2603:10a6:10:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Tue, 29 Nov
 2022 14:52:20 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 14:52:19 +0000
Date:   Tue, 29 Nov 2022 22:52:02 +0800
From:   Chester Lin <clin@suse.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y4Yckl3wl0i/nTwF@linux-8mug>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
 <6d328461-d705-9e82-ccf3-dec8885f17fe@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d328461-d705-9e82-ccf3-dec8885f17fe@suse.de>
X-ClientProxiedBy: TYBP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBAPR04MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 88306587-b90d-486c-8ce5-08dad21950af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HA/tP3nVQ+zBa02NDBaaqami4zuMlrTiO78t/ue/85aAvISqJTyJrs5G9lj8MA8AegmYsi5DPof9yk0Qvd22klYe5G55uRmboSYaeOorUeQd/PI3h63GmoKtUfYdsdkhAqWhopcR+24vyQ88Ggo83VIelUS6sVtZZAdHSbQGyzC68WQSnzpugrUjHN2BpfcRPxKPBj5Q3yxe0R4mAlOvoztnkWcwb/gwPqdNIXa9O7I5tCDrh4rWZWa8c1WPJzvFvRZxKjYaMnu0FfVEjRBZ0+6rwxuKKgtIagqMSPGY65dMT6DodQnf3gDPK4ZaZyxPlbRobD3W+Hw3K9imdhpybvn/bmd5Ty7Vkft8fD2ST1Og5AfATyCNEmm6xgGYUS0FVluk6p17679xa+R4Kph9+0CR4RKys4nyRWpqOa3COEQChMf0UVjS+b2IP5UL80X3HveSaAhH4czcDnZ+lkof2eTCdHNO2op8dVXiF9FvnMApLqhKMPor5iPa8yz3gCfqeDPaxUPiYhDnfLWao2UrgKWj63/Mh2skOWOVFZDhFiIN9PnFMg2j7FSzA8ryH862lXcKhZQgP6eofCwL30YVe3g2m6SXwVVrWwM87owszaQP9cJ/hLm10UIPFwuWZsv6j31IHorBy5t05gNsry4WrD5ruekSqOgZ/oCEEqfQ77Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(66574015)(66946007)(83380400001)(86362001)(2906002)(38100700002)(41300700001)(7416002)(5660300002)(33716001)(8936002)(4326008)(6506007)(9686003)(6512007)(26005)(6666004)(107886003)(66556008)(54906003)(316002)(6486002)(8676002)(6916009)(966005)(186003)(478600001)(66476007)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Jhu3aKZS7YdPHV3B8tLQPHFi5ggtsCLAt970cZ5i0xlRsu6+5DD/mzuNBA?=
 =?iso-8859-1?Q?VK1DMw88nXDgyHAUFCwSTaYmphHEZlOWsDI26Ae3FQm6nUbdug606uLdRL?=
 =?iso-8859-1?Q?nN6UL1NjpqGXAW3Wx73AV3J32NPIqYz6S+4f4krwcDve0Sl0o8N4yZat/C?=
 =?iso-8859-1?Q?HFJKLhIWTh51Ak+CpzbfAFliuVX6Fj3aiF73r2rM6Jh5O1FsOnqn3sL7/8?=
 =?iso-8859-1?Q?wSjWw5kVruN0qIhJziS+TlcKsIGNQnpqAe/TQlycI+N1kZw97XcnWvsSBQ?=
 =?iso-8859-1?Q?45+QPYrlACwqGInN/Ef884xV+RGH5ZaZ6gsrk3CiSZcZO/KotcLB9e46ID?=
 =?iso-8859-1?Q?71O1srw2Cb7Et81eFUonWdtZyPrmHd2DSkExWFn9g5bBVGUD3IWgtCLBbd?=
 =?iso-8859-1?Q?oi++Ja564ziAVvdQaM4PFxBIudj4BVuXcmOEZHrf1+UpjahWXB1hF8vPcB?=
 =?iso-8859-1?Q?E3q6QIgLezRdYXUGE6p7+1vSab6AVmQZjus58qZKFKRzxKykxC7Y3t1KeY?=
 =?iso-8859-1?Q?53lTENcpfx0wPbjA2fJAJ+oLZdX+38KWY/JYkmlMJWBr+YiT+cChcDC0/U?=
 =?iso-8859-1?Q?khjP/u8LE/dlOnB//YPwwcSBMSJgtR47VN+LjK/U9SfIcvE8OelotTTd2/?=
 =?iso-8859-1?Q?pJukSEBi1gOJX5KD9rvUGtrqE8t9D9m7ZONC+G1ZQt6VJsNYD0+nFemWR+?=
 =?iso-8859-1?Q?FOcS7khc98DUSbn+LlfoGEaz0zdqRIoQlchluBQQzFUlZk5DR2+wRKh3eK?=
 =?iso-8859-1?Q?B6yxzaq6AMStVE8xG2TVpY9BjV4gdTQjzqA2WZ3Ba7MXJEKOVoeEb0VCDX?=
 =?iso-8859-1?Q?aXMkiK0QYzTS27ebKyobC3+58Mdrx/KUBQi767GpM2zScNUdiu1YrCMMKW?=
 =?iso-8859-1?Q?WGFkiIXOCK3Egfg+LtIpsvdGvzL0sGsdCH4SSujidgE0SEGnbeGWDtMjVf?=
 =?iso-8859-1?Q?8tJfxWIidKgnrkNwVwrI6WM3yuZC/3o5Lzu83GGTYTHikAf8M9swCbVMby?=
 =?iso-8859-1?Q?T20CVgQZaoseICExr9yNpt5/aEl+kAwWQodlO7TopNDo5egR580obGSIxm?=
 =?iso-8859-1?Q?6ii9MTDXgVXIyHWLNoUcdjuVDzYF4xLynsJnKAI78VxvUf4fFaknOlsUU9?=
 =?iso-8859-1?Q?3In7OeTEvd3zfGXzAjNnqWodRI0wOcxpob51kKtz/yFe1sjzSROrZQ0b52?=
 =?iso-8859-1?Q?kXiaWymr7y/+9/zjEBD9kVCFamoX1CWkmzYloOuYpRCDkMx5HxEIGBClcp?=
 =?iso-8859-1?Q?UZoAUIh22TzUY9QaPHD2jtjtDvaoFWaHT8qVfgSbuGtcachvOTSdw5M/FV?=
 =?iso-8859-1?Q?XstsRkFe4GvgzChRpuJFEHi/I9DfWfgwm7MGl261It5kLoPYgOSn9/bI+r?=
 =?iso-8859-1?Q?Ur0hUcnQp+j+MCjlVIkE5rQ/KYwwBvxXmVVzFsVnYIENgY24fi29DoKYOj?=
 =?iso-8859-1?Q?C597i/XbSfTR51zG0NiVMmWddYF6LHNhIaw4KRITyiq+KKasIKHakxv4Vf?=
 =?iso-8859-1?Q?MFDV7c0eSQp/6UpTPUKLxRX/Uzasptz2Z29TOdztw+H/gH2JmZumujVl9o?=
 =?iso-8859-1?Q?Qz7djckTZAJ0OsADstQJKG3YurI25/4g/lpJCQUGJRJd8p8Ol6UxD00pF0?=
 =?iso-8859-1?Q?lK0Gc+CPnnHss=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88306587-b90d-486c-8ce5-08dad21950af
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 14:52:19.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRlvA3fvRx8y6eSSOi3IfhAsjhGUoYclDwCCpsW+yFax4nBPyIQYG1PhDHPtERYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7336
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Nov 29, 2022 at 03:00:52PM +0100, Andreas Färber wrote:
> Hi Chester,
> 
> Am 28.11.22 um 06:48 schrieb Chester Lin:
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
> 
> Thanks.
> 
> > - Fix schema issues and revise the example.
> > - Fix the copyright format suggested by NXP.
> > 
> >   .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
> >   1 file changed, 125 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..2fc25a9362af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> 
> Any reason the code is GPL-2.0-or-later but the schema is GPL-2.0-only?
> 

Actually this patch is modified from an original downstream schema, which has
"GPL-2.0-only". See:

https://source.codeaurora.org/external/autobsps32/linux/tree/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2.yaml?h=bsp34.0-5.10.120-rt#n1


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
> SoC family
> 

Will fix in v3.

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
> 
> Does this multi-paragraph text not need "description: |" like above?
> 

Will fix in v3, thanks for the reminder.

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
> 
> I notice that neither this patch nor the following one introduces a
> dt-bindings header for these macros? Is the plan to only have them in TF-A
> sources? Thinking of DT overlays for SoMs, for example.
> 

Yes, it is. Since the current arch relies on the FDT offered by NXP's
downstream TF-A, only TF-A sources include the dt-bindings header in order
to refer to these macros. However, introduce these macros in this example
can still help developers to understand how a pinmux constructs.

Regards,
Chester

> Regards,
> Andreas
> 
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
> > +              /* MSCR0-MSCR101 registers on siul2_0 */
> > +        reg = <0x4009c240 0x198>,
> > +              /* MSCR112-MSCR122 registers on siul2_1 */
> > +              <0x44010400 0x2c>,
> > +              /* MSCR144-MSCR190 registers on siul2_1 */
> > +              <0x44010480 0xbc>,
> > +              /* IMCR0-IMCR83 registers on siul2_0 */
> > +              <0x4009ca40 0x150>,
> > +              /* IMCR119-IMCR397 registers on siul2_1 */
> > +              <0x44010c1c 0x45c>,
> > +              /* IMCR430-IMCR495 registers on siul2_1 */
> > +              <0x440110f8 0x108>;
> > +
> > +        llce-can0-pins {
> > +            llce-can0-grp0 {
> > +                pinmux = <S32CC_PINMUX(43, FUNC0)>;
> > +                input-enable;
> > +                slew-rate = <S32CC_SLEW_208MHZ>;
> > +            };
> > +
> > +            llce-can0-grp1 {
> > +                pinmux = <S32CC_PINMUX(44, FUNC2)>;
> > +                output-enable;
> > +                slew-rate = <S32CC_SLEW_208MHZ>;
> > +            };
> > +        };
> > +    };
> > +...
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Frankenstraße 146, 90461 Nürnberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nürnberg)
