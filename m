Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C8642727
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiLELFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiLELFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:05:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E37F587;
        Mon,  5 Dec 2022 03:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgDrrbwbqOSH9LyvxMOUgDK8yK6z40GdvBnIqUKYchWtWW1A3Xj+Mt61w5Eq5YAeMeIvuEX15xw7SkLBhPxC8KfzplsI93wgg+bbLi01OmBsuaHZ80ZpHZjk+ntZsPNhBdIRE6z2yMvP78owq3LZFgwBGPt6e6yH3cfZlFfaDs0vIlemPbnsqcZQwBAtLR7MyIZMN9gjQWJU62lG2Q4L84+SBtZdEGVxPdCNouBfIQI8rTZOanQwhfCkAJpoLfuhzwz86K8F7HogqIV+Ya3GtrWDqwkCDBm7dyF4vYFLLGneYda7ou7XBgddD9gjPsVYGtWWLoJSr4zwt1cyKjs4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08oa9C+RdUIorBkMgw8biNnB0Es7ENixPL3h+Nnkj8o=;
 b=GunCvmvTVv0Pb1qyb8Dx7cX4wyTZVSzZloKdXURX0hsKDKNQIhWTJTQakCt3yYnrv0YXnZVdLCVvbX3gh8JJylKvLiMISPMOlk1PBO8ctFqP2Y3Yp5khpNl1rzBFVLz4zrtmO86FKtK2IxdGsrTVkUKazl7WelDaPZmr3V36Gom16/h5+oEdT3TEGoKjJ58GeGdH5rFWfd1g3swqNswbWjH38Z70Fr6cl1s3hMVBZS9cuKNv+rPI2G9zWRqQ7JXYWMBdKvCaWd9XXBkHG+ZNDeDLx8/LG9iwQIsLZnWOZYYNCahKIaxGLeyCeVq2GrJ8l8CM85QWsHOLdN64lCxC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08oa9C+RdUIorBkMgw8biNnB0Es7ENixPL3h+Nnkj8o=;
 b=3wTODy4NDv44Tqlw+DswOvYTbLHlEZcoAOqG8xHPQb0jXRuDVdZ/IotCCZtDA0hAr/UMNPVht7iML+tOxmYPIG74EOdNL3sSygQcOuHJ1lDMSyxlxvK4w6LHtMK8X0o9IXoi2N0DaoaXjuRAX7m77Ek1lIJKfPs27wWDoaPahDG2Sfi+nPf46UcBzhCaqKF+1Cdq4YmuQoht0oAaZXPw9D/nh3RDmqS+2BCJWpZhTL7pKha8Tg2EnuJgjea9qs0SLDoeMybrKVWHlxtFGPN5w6XGqEazXlyCB3gC3AM18+aSn3sC0vgqLlG19NhyRbDK6Wi4B3VUhyCvcvXxVxPLdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 11:05:45 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 11:05:45 +0000
Date:   Mon, 5 Dec 2022 19:05:25 +0800
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
        ghennadi.procopciuc@oss.nxp.com, Chester Lin <clin@suse.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y43Qdco0y61C4l1I@linux-8mug>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
 <6ad95ce3-887d-48fd-3c08-f50d4e666ded@linaro.org>
 <Y42MyyLumVa8phpd@linux-8mug>
 <e839274d-6696-63aa-14e6-f52a534c9ed2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e839274d-6696-63aa-14e6-f52a534c9ed2@linaro.org>
X-ClientProxiedBy: TY2PR0101CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::32) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: b29787bf-2b53-420f-7a68-08dad6b0a7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy96mVpZofz9XDmyo6BRll95eiOjKF53AN12KLjNkZxyte1DNIkGMP/701z54VkzoTUgOQ3vUSvy+VjrqFrI/5yCaA2z+/sdHL8aCKrH6c/01Yj0+nE5UAcffxAcfsSwKdZeabbwl1MVYYqjjv91PYUDp3J0Smox5ku5ZCdaJoj8bG+riRXv8dbbBjn3xzOoyU16p/rKoLmJQuHJgJaeaZY6U9A859cV7dWXe+wa8l+wF1kT7u5UuOgm66J1ig7GX9Qj1VoOLyqQJCwQNcMw0rYILTH61comStReVrmHxaDQr8jpY/nqpemZzho1KjrtA2U4o5eMMVLGSvixqdykp6HENkqenNw/3hzv1LkKbDEXF3bXCBktkZiBjd3Dk8dfnyfF1dffOrdL2F3J6CDHtahg3I0O2qYMFsmUZuEc/VKFQ5fIxnqwCXQbVmyLpf1keCsqWBUToydhwFj3CdlAE3fpyV6i6Zk0Kz6h55b3XbBfyvUdAcU6xr6kRyP/IViX7diDiJiS4RwMs5iPwsSfgLEcDCI1MKMvf1DZp9yWaoJMLwnHBcT7vtdehyl77PBgSmx7quobeM9yjTQ32USyiLmkOrKAZ3+EfOF6tHq3TR5Bnk+ATIMWWI1e+VbwJk1F8L/U2rFHebZ7CEYOuuY2QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(396003)(346002)(376002)(366004)(39850400004)(136003)(451199015)(83380400001)(86362001)(38100700002)(7416002)(2906002)(41300700001)(5660300002)(8936002)(4326008)(33716001)(8676002)(53546011)(6512007)(9686003)(6506007)(26005)(186003)(107886003)(6666004)(316002)(54906003)(6916009)(66556008)(66476007)(478600001)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hShi+8H/AkNrbgUrTErzzN+LXyEcZkxIL8XDuOQQkMdOy2YZxqQsf2N7iUCn?=
 =?us-ascii?Q?YhnNz5VmCuQp0cpRW+dqnNNvfjk3Tpjw1pSyAAI8fiuuEYbG83+990/19ZP/?=
 =?us-ascii?Q?AZjcTx0/eIUSsto69JJAU05I3ckFBzNdi6tLBYSxl5vI6ELX56Z+x708WFP0?=
 =?us-ascii?Q?1gDrOQU7ZkH0rKOYa3g37g20Hw8AyzdMERkwUtN2bFm5lyuqAOF+B2VIZK4a?=
 =?us-ascii?Q?3+dqnSotfzbiUAMCLBzaHKhnEW2hHICVCDyj5gFd33pa+xgrle8cnZ0bZy5C?=
 =?us-ascii?Q?twFQk6L4iurEyPFY8C/qSyj4JfLZWFjGnUZY/ztgt64c/HztZA6qMrWv88d3?=
 =?us-ascii?Q?C6T7EKonY4EhQy2rrmru/FThvyxL0fpk44q6pOfqgVEmMb0sh7ywBO/7v/29?=
 =?us-ascii?Q?Ynin4v/syjCM2W1qlfZXQaAHnx/LFNNhEJ6Woh9CCvJCdKgvVioLRHZ1i0ij?=
 =?us-ascii?Q?Umfgn2i6JYOiSIhppDJyA4Gi6lXG/KwtkqYwR4QUw+n672+Da/3dCrqKXp26?=
 =?us-ascii?Q?jRtZDXcPM30GGH5/CLs9kW1JjZ+bR2YMBEzEohtYi20Ld500ahkcpV67sEu8?=
 =?us-ascii?Q?yU/WuVqzZE9T0sp1D/CSdgvdCwKylWhebqhpCpMUw/DR7VqiIzlQPrOP4441?=
 =?us-ascii?Q?RxILqforiv7rdc+g7VrIRLB+JYOkjRROJoPDnZgtjnSGfRiB/hJfa7ffE/MG?=
 =?us-ascii?Q?dShfwXk0Q90LhxGAPY2A1xfHBmi+SgwSrQhVG/A/Kg8DPdYjEJ9YBvjeu9Aq?=
 =?us-ascii?Q?wI4SrBx1uSF4vMnMM45bH8ztOQhJ0pf2uFvQ/bAvdUiMIwEUvLc4ZxtawovW?=
 =?us-ascii?Q?nRhlJbC2nnH8Kv3dSRWzWC2ix49bqF1zPjWiVe/h6j5WejA71IF9a4S8+H5E?=
 =?us-ascii?Q?Tk9emy+CdevAQsiNs8vuVaspIXr58ELgHSKN7eB1ab/bTfyVxxeC1XRt0iBg?=
 =?us-ascii?Q?GMfIfyOUmIt3/bvyBtDVYCYYXWxgpwUUMgxSZ2mZbkSrVBuotWLC8IrO8xj5?=
 =?us-ascii?Q?cKkmU6GnV2oCCbGwKKpea6BhslN45e5cBCag+j85M9Q4zGAsxgkJDEb/71PM?=
 =?us-ascii?Q?CF3Wqs1C9HGnxISlqzLfmf4+pry6fNh5051IeLGptSVEviAezQwZgTJVHCvn?=
 =?us-ascii?Q?AIxqEx5GyqjcRpJf+SLSPmSwEDITZrILgQUZ0iM2YF5A/b6MLvViF55nbKdk?=
 =?us-ascii?Q?doHziFXtcvEvCua6dmqwX2mLvGTmyffzG0CwXfcOQNgV0Do3ijdxoi3alRt+?=
 =?us-ascii?Q?biw4PXHYh6dQDC0aiZFfnhQT9E9b6669tX2R/AHFmJFaY3ep/Y0mNneOjdfy?=
 =?us-ascii?Q?E47/jLhNrfoKzLRvr68nxZLL4+5r9mLiEa4zfv3ZMxsf6rsEBeTscsqj8Qqd?=
 =?us-ascii?Q?du/cIUUl4hJMCCpd9zRqYJs6H6FD+hVH7p5OdHXaWej/HENCbK+F1yToD+ck?=
 =?us-ascii?Q?Uhr77hWzUE36/UNUlrUhx0W8EI7z42aq5D/p3IoBUO1DPe1zwS73hayOZUsE?=
 =?us-ascii?Q?JnfBh+w+UU26ORY1GM87XnU3TulmERVfMXliQMpOZDmrVGXPyCHO+01p7JmP?=
 =?us-ascii?Q?omGupTf60G9+OF3HDzw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29787bf-2b53-420f-7a68-08dad6b0a7de
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 11:05:45.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FF+NQFj6UqOxSrEDlbIDf4mX5Vn08ihurFdms7QDmNI83n2c0y7NOvqHZ0hVvIsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 10:02:14AM +0100, Krzysztof Kozlowski wrote:
> On 05/12/2022 07:16, Chester Lin wrote:
> > Hi Krzysztof,
> > 
> > On Wed, Nov 30, 2022 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> >> On 28/11/2022 06:48, Chester Lin wrote:
> >>> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> >>>
> >>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> >>> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> >>> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> >>> Signed-off-by: Chester Lin <clin@suse.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Remove the "nxp,pins" property since it has been moved into the driver.
> >>> - Add descriptions for reg entries.
> >>> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
> >>> - Fix schema issues and revise the example.
> >>> - Fix the copyright format suggested by NXP.
> >>>
> >>>  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
> >>>  1 file changed, 125 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> >>> new file mode 100644
> >>> index 000000000000..2fc25a9362af
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> >>
> >> Usually filename matches the compatible (or family name), so any reason
> >> why compatible is "nxp,s32g2" but filename is "nxp,s32cc"?
> >>
> > 
> > According to NXP, the S32CC is a microarch which is adapted by different S32 SoCs,
> > such as S32G2/G3 and S32R45. Some common IPs are implemented in S32CC, such as
> > serial, pinctrl, mmc, gmac and some other peripheral interfaces. S32R45 has
> > different pinouts compared to S32G2, which means that there would not be just
> > "s32g2-siul2-pinctrl" but also "s32r45-siul2-pinctrl" in the compatible enum if
> > S32R45 has to be upstreamed in the future. For this case, it seems to be
> > inappropriate that adding a compatible name without any "s32g" keyword in the
> > filename "nxp,s32g2-.." unless creating a new yaml for each platform, such as
> > nxp,s32r45-siul2-pinctl.yaml.
> 
> First, you can always rename a file if such need arises. Maybe new SoCs
> will come, maybe not.
> 
> Second, when you actually upstream new SoC it might anyway require new
> bindings file, because pinctrls are quite specific and it is usually
> difficult to support multiple devices in a nice, readable way in one
> file. Therefore anyway another file is quite likely.
> 

Thanks for your guidance. Will fix it.

> (...)
> 
> >>> +
> >>> +patternProperties:
> >>> +  '-pins$':
> >>> +    type: object
> >>> +    additionalProperties: false
> >>> +
> >>> +    patternProperties:
> >>> +      '-grp[0-9]$':
> >>> +        type: object
> >>> +        allOf:
> >>> +          - $ref: pinmux-node.yaml#
> >>> +          - $ref: pincfg-node.yaml#
> >>> +        unevaluatedProperties: false
> >>> +        description:
> >>> +          Pinctrl node's client devices specify pin muxes using subnodes,
> >>> +          which in turn use the standard properties.
> >>
> >> All properties are accepted? What about values, e.g. for drive strength?
> > 
> > For those unsupported properties such as drive-strength, the s32g2 pinctrl driver
> > returns -EOPNOTSUPP.
> 
> I don't care what the driver is doing, we do not discuss the driver. You
> need to describe properly the hardware and I doubt that hardware accepts
> all drive-strengths, all forms of pull resistors (so any Ohm value).
> 
> Add constrains.
> 

Thanks for the suggestion. IIUC, I should specifically described the supported
pinmux and pincfg properties in this schema and then add an "additionalProperties: false"
in the end in order to constrain unsupported properties listed in the pattern
pin groups.

> >>
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +
> >>> +    /* Pins functions (SSS field) */
> >>> +    #define FUNC0  0
> >>> +    #define FUNC1  1
> >>> +    #define FUNC2  2
> >>> +    #define FUNC3  3
> >>> +    #define FUNC4  4
> >>> +    #define FUNC5  5
> >>> +    #define FUNC6  6
> >>> +    #define FUNC7  7
> 
> This is another surprise - functions are texts, not numbers.
> 

Maybe the FUNC[0|9] are not accurate to describe Source Signal Select [SSS].
I will drop these definitions from the example and try elaborating 'pinmux'
in its property description.

> >>> +
> >>> +    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
> >>> +
> >>> +    #define S32CC_SLEW_208MHZ  0
> >>> +    #define S32CC_SLEW_166MHZ  4
> >>> +    #define S32CC_SLEW_150MHZ  5
> >>> +    #define S32CC_SLEW_133MHZ  6
> >>> +    #define S32CC_SLEW_83MHZ   7
> 
> Don't store register values in the bindings examples. Instead you need
> to be explain the slew-rate property.
> 

Will do.

> >>> +
> >>> +    pinctrl@4009c240 {
> >>> +        compatible = "nxp,s32g2-siul2-pinctrl";
> >>> +
> >>> +        /*
> >>> +         * There are two SIUL2 controllers in S32G2:
> >>> +         *
> >>> +         *   siul2_0 @ 0x4009c000
> >>> +         *   siul2_1 @ 0x44010000
> >>> +         *
> >>> +         * Every SIUL2 controller has multiple register types, and here
> >>> +         * only MSCR and IMCR registers need to be revealed for kernel
> >>> +         * to configure pinmux. Please note that some indexes are reserved,
> >>> +         * such as MSCR102-MSCR111 in the following reg property.
> >>> +         */
> >>> +
> >>
> >> Either this should be part of description or should be dropped. It blows
> >> example and probably duplicates DTS.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> 
> Best regards,
> Krzysztof
> 
