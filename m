Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68A600670
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJQFwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJQFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:52:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C34558C4;
        Sun, 16 Oct 2022 22:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAq5rbawcJcnmKx+zvv2o31qlKUeL7doLoXfVSa+cKF3s9pmt4yu4Q9tlhInAZTq4R6kExgWfPiePo9bTfyaJHnKsBWC0IrlegiiTiLW6zzJ3kQvmMQJXVMkTUzTFXOsoFCMjnFTXhYYLs47put2AwkeqTDjQZA2r7bGTwMlvUviXxsS1lvw8xXLch83uNHUvnys3WwX4G/Q/Q2ko0EUZ6ARSYQ+9NFOok9BKE4keufYgvfJRvUS40YiJf4LPvUB/Iu38vbe/oFVkaC2yLfFOIv39weeEBBQpNoKOKn6xMCFyEkba5fLqZQBI8TNQEE1eGKnjl/3tU3g/nctS9Az6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiZnH94x7DSp/RlEH8WvViUJq3JBlCctsymR3dyJ90I=;
 b=oMQYuq9lWNG7iGlkoCBq8LofiWq+5flDN/r1+a6OdXlNZ9TpeqcKWimWjEqiOQLvLVqJ6zYkr8bsQkAWLuw912zLfv96aLC4XllfyrwdeOqa1lbsTqy6d53fETvYzKZOwVLtJUK13DmnHZUD9B51toRf8ap1FX4fBuwND/8p7ptfpLDBy3rO9T7FlEbaw1RHNDiiXMtZvMc+PEbOOPHMUUzLGqCKBdZcFwGd6lRhPqJi/cVhDsJ0w+jubQc/PID6+uDUcgi4L9c8fdWEAfSt1I1DvSldNqA5HsAU39LABip8S4tknCemJS8AcNtDtMPWCNMqWs5vuulsY2YcUA19qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiZnH94x7DSp/RlEH8WvViUJq3JBlCctsymR3dyJ90I=;
 b=rmRQZqM7vcNwkpZQvwry14YtUCVXwuHjNKzzlzKf37lnwwcFxgW4McwapZqDFXJRtjJ+9vPmZ1i4PkiIkRJnZ1Nu5W99kSYtzpiYgHUnAv+PMRQlVNwDniemlHZSvpZQVSeDlp+ofVYOLY6IvJI5Bdm5saMBevCTn8gBSC8vcI4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 05:52:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 05:52:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Topic: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Index: AQHY37JprV1rugCYiEuEviVPf0orFa4N8xMAgAQchuA=
Date:   Mon, 17 Oct 2022 05:52:01 +0000
Message-ID: <DU0PR04MB9417418EB4439E0473F69BFA88299@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-5-peng.fan@oss.nxp.com>
 <20221014142832.GA1903421-robh@kernel.org>
In-Reply-To: <20221014142832.GA1903421-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7139:EE_
x-ms-office365-filtering-correlation-id: d6c88601-2330-4022-967e-08dab003b5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qq2Yf26errj1i2WKKM4VhL2nEw7QVbeIfdA/hQGp5ENA3QdFaiBVBAjWQ/sr5gKkXWnJfvqr3vkjEpS++wWXrjcqJCOzb+eMja/ut8g9CkXhP3z4QLHtX2/0zIhzh1hRIYz6NoLaaYi+wB0bnDYxxX7tOQDEtSzjnDFoFosOpIVWTT+oah6KhQY6ITMjnyW6z3dDymXConbKVEcc6h1iLGei1xWpkIUVmAJ/RW460D7N8OBQSsNXWH5VopM5cJ0IQ51oX/5pjaPVFuVuSZoRukathG6aRZ4fWT5CGv87+zmHFWjdHPqXTc2MVH2UBK2oQUX3zgz0FZbTBPxA31d3/+pscI7WfI5FDuEn7DcUCax7WWS5RHGlrjno829Ez4Gjrj03N3m4vGbQtWLpbq4OStIhutuGX4zNlQyHRSgOkB1rw9UlLVILVcaQvH+ucbreuDJqz1EjjYu1f8sv69U7yJ6H5mDxsxNbmXo53qQllU7aC9nAD/y6arI1bZ1/XfGHH1uaL+kGrK3HPlvQT0tayxuWfodSuHvQYbkHLgq+mPcW5PanfqzxMvITXadJhxeKmNwlgwplsgHuc6weyNrHeU0ZsuTnhNIOxiSPxWn2gMgMFJhlWl/r2TPfqqMPIEwc6cwO4t0dDQ1hUV9WwCg0lxI9RgQs/R8gcrGNyOMOgT/jWZEjDcPqRmlW2ac3yg++aVhQVUaPKojhKGxPDcn2/4shlacOHw0pkJ+eRIAslKXCVkQ6RF57OUl4oSpcqZo9KzpDHal/NY2ZBB28QAhKCuhhd/NQUpI+EpjaNQwXV6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(38070700005)(86362001)(33656002)(55016003)(4326008)(41300700001)(26005)(64756008)(66446008)(7696005)(6506007)(8676002)(5660300002)(52536014)(30864003)(9686003)(66476007)(44832011)(8936002)(66556008)(45080400002)(478600001)(71200400001)(110136005)(66946007)(76116006)(54906003)(316002)(7416002)(38100700002)(122000001)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uoWEjBfuTDorNMPrqTUM7JSk+SHOVanUoPf1kU+5UH56UWjCRiYTgnb7l8zT?=
 =?us-ascii?Q?y7HdnsBvlfG20U5uG3XyWUovhXZ7R3bvgtWVeooYoyC/ZZKC/lxmGBWvaj2e?=
 =?us-ascii?Q?m58Be5AkGN/yrf1WFoMmq5D2pmdfA0UtE4+RJiMOzBhBmugFYt2qJ0mtM4D9?=
 =?us-ascii?Q?kXpLt23IUUyTepoqWUHY2ZeAUw7A7MuRA1RoSNkwRM3Vz/HafzKxiBQYIeSw?=
 =?us-ascii?Q?xSYuIj94LuUhr76iSDoIxjblyn43igLzeSyT5ZrXyuuENmXsnBwSAPuT1KdG?=
 =?us-ascii?Q?PxHQ/yqg31HnepLPTa86GbwrPo4XpYogA815A82MheIMRhqy0qo6yZd3WCYD?=
 =?us-ascii?Q?VnSSqKvay8NqgneeL74ILzrMlFhgYT+Gurgk7B93t3sPMEK+ZItJFV9etVCh?=
 =?us-ascii?Q?S71Sucn7ssPpkACVsQfA5Rpt89Gw/oA2U/KjVZ7EPf7IJq3jbu4i+YCIu/rY?=
 =?us-ascii?Q?beMgfaGQuG3O0lJYY2Vwy/J/kxv9x1C1Xp3Ww/Eciln7b7TXG+10ew2oBXL6?=
 =?us-ascii?Q?03TmzRU8+FZlSJIu39GlXWw674fpSuXsmahbySsArXG+645gB4aQqq76a2i6?=
 =?us-ascii?Q?b2UdBIIdTLzT0yejUKiY3mxo/htVuEpBXv8H/h7vrIR4zZ/FbJSKzm1/64AS?=
 =?us-ascii?Q?O0BrH/qFLMJeLmnge2BGD+XUGn2e94HM/YR3SZx+Wp5Y7fJ+Aujfh1Ayxpwf?=
 =?us-ascii?Q?OGltER/0tXwDLn8AbZ7hosgjf3LSzn+obR20NPg6wYy/UBbzjgHw/KF5tJSG?=
 =?us-ascii?Q?HEXIVW+GipkBm0fZfUS+lgiOv5TaJlx8nrKQ0FBTg0+pEqjgQrG5RJiMXlk/?=
 =?us-ascii?Q?em5hvAW3OJxtIAkoXutGKgMVRNEkyoTwhznFaQ0EJ1MAZtYiTQlX+agVYwmX?=
 =?us-ascii?Q?BNVPlAhQyF/FTENy99hFOI0vHEe2Ljgal7PtY/ubqeGpmJhvF7zg5P3G/gpe?=
 =?us-ascii?Q?aGvp8Og+htJogatfD/HH1PCKmVopLk/RhkIWDuYdm6KbHGjMfAQolkdtMsTy?=
 =?us-ascii?Q?AeMvTzo1pOeqx61Wlx7MQB2q1aykecceNCP1ReXUiVrIj9+FjmuzCR5K0Wru?=
 =?us-ascii?Q?162t0NWzssCGO4RGZc7G/Z96iFYPUu0f7yzGgmTqCdP53hVCf54/1RyaNhD3?=
 =?us-ascii?Q?LXdTyiwsOoygGUKFZBXI5UzyiZ/t14Iss8oCs8/ZNa0uxWatyjR+NMaCbzwB?=
 =?us-ascii?Q?XuQJ9/KJKCSHi/KXK1ouXcIX8Qtitn7PwFXALsMDaTYcPoZwDMJj0zPk0UNy?=
 =?us-ascii?Q?643XuE8X1MoNyMC2M2MyBmilMVe3LBIanMKNYZbQT+5qg1D1TkKWzPB/W5gq?=
 =?us-ascii?Q?PtG7E51gs+3BgAbR8yOh1haip9w+st4DiIERur19ONz2Djb4ggg322P/h29H?=
 =?us-ascii?Q?K712ubrA8+/SUJMFWVWCC8hbzR3TG/eKcDLFEoxbmq1lujcJQn9kbaWuLLCP?=
 =?us-ascii?Q?csvztfn8LU/HvAGPU+oEHa1Nywkt1mHJhw360yoWW9hxL9uqLkVc/aDmAMJ4?=
 =?us-ascii?Q?kBRAEa/M3Md//G3y0U399bKxeaUkvVGHJENnyh6v6L9ir2A+OI2df5me8+E4?=
 =?us-ascii?Q?JudYSurS2nloIgLIZmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c88601-2330-4022-967e-08dab003b5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 05:52:01.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3a/aCl1aKrA1b2BdA4FXd4GGDGqAr7kOlQcqOez5W3pNmHnWQQqRgVlnDdTWjaC22ashSMjHP24Gc3pYNTG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139
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

> Subject: Re: [PATCH V2 4/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
> schema format
>=20
> On Fri, Oct 14, 2022 at 05:51:46PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding to DT schema format
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 --------
> > .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 341 ++++++++++++++++++
> >  2 files changed, 341 insertions(+), 158 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>=20
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > new file mode 100644
> > index 000000000000..ed03649f17a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > @@ -0,0 +1,341 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fusb%2Fci-hdrc-
> usb2.yaml%23&amp;data=3D05%7C01%7C
> >
> +peng.fan%40nxp.com%7Cc82aff1e7786408bdfb908daadf05fba%7C686ea1
> d3bc2b4
> >
> +c6fa92cd99c5c301635%7C0%7C0%7C638013545157576176%7CUnknown%
> 7CTWFpbGZs
> >
> +b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3
> >
> +D%7C3000%7C%7C%7C&amp;sdata=3DWCoRU5%2FlPpdKF984bqAmU7WPU8
> XbDvBZoVyJ6K3
> > +nggY%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7Cc82aff1e7786408bdfb908daadf05fba%7C686ea1d3bc2b4c6
> fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638013545157576176%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3Dl6g5TrxpwRjZqUgRmqpAbhCIO4%2BLRp0y1IFV5SS
> nkx0%3D&a
> > +mp;reserved=3D0
> > +
> > +title: USB2 ChipIdea USB controller for ci13xxx Binding
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - chipidea,usb2
> > +          - lsi,zevio-usb
> > +          - nvidia,tegra20-udc
> > +          - nvidia,tegra30-udc
> > +          - nvidia,tegra114-udc
> > +          - nvidia,tegra124-udc
> > +          - qcom,ci-hdrc
> > +      - items:
> > +          - enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx25-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx7d-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - const: xlnx,zynq-usb-2.20a
> > +          - const: chipidea,usb2
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  dr_mode: true
> > +
> > +  phy_type: true
> > +
> > +  itc-setting:
> > +    description:
> > +      interrupt threshold control register control, the setting should=
 be
> > +      aligned with ITC bits at register USBCMD.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ahb-burst-config:
> > +    description:
> > +      it is vendor dependent, the required value should be aligned wit=
h
> > +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property =
is
> > +      used to change AHB burst configuration, check the chipidea spec =
for
> > +      meaning of each value. If this property is not existed, it will =
use
> > +      the reset value.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x7
> > +
> > +  tx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the tx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit
> > +      words while moving data from system memory to the USB bus, the
> value
> > +      of this property will only take effect if property "ahb-burst-co=
nfig"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Constraints? I assume 2^32 is not valid...

Actually I am not sure, per txt binding, it is vendor dependent.
i.MX has value 0x8 or 0x10, but I am not other vendors.

>=20
> > +
> > +  rx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the rx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit =
words
> > +      while moving data from the USB bus to system memory, the value o=
f
> > +      this property will only take effect if property "ahb-burst-confi=
g"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Constraints?

Vendor dependent, I am not sure.

>=20
> > +
> > +  extcon:
> > +    description: |
> > +      Phandles to external connector devices. First phandle should poi=
nt
> > +      to external connector, which provide "USB" cable events, the sec=
ond
> > +      should point to external connector device, which provide "USB-HO=
ST"
> > +      cable events. If one of the external connector devices is not
> > +      required, empty <0> phandle should be specified.
> > +
> > +  phy-clkgate-delay-us:
> > +    description: |
> > +      The delay time (us) between putting the PHY into low power mode
> and
> > +      gating the PHY clock.
> > +
> > +  non-zero-ttctrl-ttha:
> > +    description: |
> > +      After setting this property, the value of register ttctrl.ttha
> > +      will be 0x7f; if not, the value will be 0x0, this is the default
> > +      value. It needs to be very carefully for setting this property, =
it
> > +      is recommended that consult with your IC engineer before setting
> > +      this value.  On the most of chipidea platforms, the "usage_tt" f=
lag
> > +      at RTL is 0, so this property only affects siTD.
> > +
> > +      If this property is not set, the max packet size is 1023 bytes, =
and
> > +      if the total of packet size for pervious transactions are more t=
han
> > +      256 bytes, it can't accept any transactions within this frame. T=
he
> > +      use case is single transaction, but higher frame rate.
> > +
> > +      If this property is set, the max packet size is 188 bytes, it ca=
n
> > +      handle more transactions than above case, it can accept transact=
ions
> > +      until it considers the left room size within frame is less than =
188
> > +      bytes, software needs to make sure it does not send more than 90=
%
> > +      maximum_periodic_data_per_frame. The use case is multiple
> > +      transactions, but less frame rate.
> > +
> > +  mux-controls:
> > +    description: |
> > +      The mux control for toggling host/device output of this controll=
er.
> > +      It's expected that a mux state of 0 indicates device mode and a =
mux
> > +      state of 1 indicates host mode.
>=20
> maxItems: 1

Fix in v3.
>=20
> > +
> > +  mux-control-names:
> > +    const: usb_switch
> > +
> > +  pinctrl-names:
> > +    description: |
> > +      Names for optional pin modes in "default", "host", "device".
> > +      In case of HSIC-mode, "idle" and "active" pin modes are mandator=
y.
> > +      In this case, the "idle" state needs to pull down the data and
> > +      strobe pin and the "active" state needs to pull up the strobe pi=
n.
>=20
> The names need to be constraints, not freeform text.

I am not sure, I have added constraints in allOf section.

>=20
> > +
> > +  pinctrl-0:
> > +    maxItems: 1
> > +
> > +  pinctrl-1:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: usb-phy
> > +
> > +  vbus-supply:
> > +    description: reference to the VBUS regulator.
> > +
> > +  fsl,usbmisc:
> > +    description:
> > +      Phandler of non-core register device, with one argument that
> > +      indicate usb controller index
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
>=20
> items:
>   - items:
>       - description: phandle to usbmisc node
>       - description: index of usb controller
>=20
> > +
> > +  disable-over-current:
> > +    description: disable over current detect
>=20
> type?

It is a Boolean type. I should add "type: boolean"
>=20
> > +
> > +  over-current-active-low:
> > +    description: over current signal polarity is active low
>=20
> type?

type: boolean
>=20
> > +
> > +  over-current-active-high:
> > +    description: |
> > +      Over current signal polarity is active high. It's recommended to
> > +      specify the over current polarity.
>=20
> type?

type: boolean
>=20
> > +
> > +  power-active-high:
> > +    description: power signal polarity is active high
>=20
> type?

type: boolean
>=20
> > +
> > +  external-vbus-divider:
> > +    description: enables off-chip resistor divider for Vbus
>=20
> type?

type: boolean
>=20
> > +
> > +  samsung,picophy-pre-emp-curr-control:
> > +    description: |
> > +      HS Transmitter Pre-Emphasis Current Control. This signal control=
s
> > +      the amount of current sourced to the USB_OTG*_DP and
> USB_OTG*_DN
> > +      pins after a J-to-K or K-to-J transition. The range is from 0x0 =
to
> > +      0x3, the default value is 0x1. Details can refer to
> TXPREEMPAMPTUNE0
> > +      bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x3
> > +
> > +  samsung,picophy-dc-vol-level-adjust:
> > +    description: |
> > +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitte=
r
> DC
> > +      level voltage. The range is from 0x0 to 0xf, the default value i=
s
> > +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0xf
> > +
> > +  usb-phy:
> > +    description: phandle for the PHY device. Use "phys" instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    deprecated: true
> > +
> > +  fsl,usbphy:
> > +    description: phandle of usb phy that connects to the port. Use "ph=
ys"
> instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    deprecated: true
> > +
> > +patternProperties:
> > +  "ethernet@[0-9a-f]$":
>=20
> This is board specific and shouldn't be part of the schema. But you do ne=
ed
> to define child nodes with a reference to common usb schemas.

The txt binding has the child node
 usbnet: ethernet@1 {
   compatible =3D "usb424,9730";
   reg =3D <1>;
 };

I am not sure how to support it. If I not add such patterProperties, there =
will
be dt binding check error. The child node is a usb ethernet, I think common
usb schemas not has that.

If you have a simple example, I could follow that.=20
>=20
> > +    description: The hard wired USB devices
> > +    type: object
> > +    $ref: /schemas/net/microchip,lan95xx.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: usb-hcd.yaml#
> > +  - $ref: usb-drd.yaml#
> > +  - if:
> > +      properties:
> > +        mux-controls:
> > +          true
> > +    then:
> > +      properties:
> > +        mux-control-names:
> > +          const: usb_switch
> > +  - if:
> > +      properties:
> > +        phy_type:
> > +          const: hsic
> > +
> > +      required:
> > +        - phy_type
> > +    then:
> > +      properties:
> > +        pinctrl-names:
> > +          items:
> > +            - const: idle
> > +            - const: active
> > +    else:
> > +      properties:
> > +        pinctrl-names:
> > +          oneOf:
> > +            - items:
> > +                - const: default
> > +                - enum:
> > +                    - host
> > +                    - device
> > +            - items:
> > +                - const: default
>=20
> 'minItems: 1' in the 1st (oneOf) entry and drop the 2nd entry.

ok

>=20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - chipidea,usb2
> > +              - lsi,zevio-usb
> > +              - nvidia,tegra20-udc
> > +              - nvidia,tegra30-udc
> > +              - nvidia,tegra114-udc
> > +              - nvidia,tegra124-udc
> > +              - qcom,ci-hdrc
> > +              - xlnx,zynq-usb-2.20a
> > +    then:
> > +      properties:
> > +        fsl,usbmisc: false
> > +        disable-over-current: false
> > +        over-current-active-low: false
> > +        over-current-active-high: false
> > +        power-active-high: false
> > +        external-vbus-divider: false
> > +        samsung,picophy-pre-emp-curr-control: false
> > +        samsung,picophy-dc-vol-level-adjust: false
> > +
> > +additionalProperties: false
>=20
> unevaluatedProperties: false

Will add this.

Thanks,
Peng.
>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/berlin2.h>
> > +
> > +    usb@f7ed0000 {
> > +        compatible =3D "chipidea,usb2";
> > +        reg =3D <0xf7ed0000 0x10000>;
> > +        interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&chip CLKID_USB0>;
> > +        phys =3D <&usb_phy0>;
> > +        phy-names =3D "usb-phy";
> > +        vbus-supply =3D <&reg_usb0_vbus>;
> > +        itc-setting =3D <0x4>; /* 4 micro-frames */
> > +         /* Incremental burst of unspecified length */
> > +        ahb-burst-config =3D <0x0>;
> > +        tx-burst-size-dword =3D <0x10>; /* 64 bytes */
> > +        rx-burst-size-dword =3D <0x10>;
> > +        extcon =3D <0>, <&usb_id>;
> > +        phy-clkgate-delay-us =3D <400>;
> > +        mux-controls =3D <&usb_switch>;
> > +        mux-control-names =3D "usb_switch";
> > +    };
> > +
> > +  # Example for HSIC:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +
> > +    usb@2184400 {
> > +        compatible =3D "fsl,imx6q-usb", "fsl,imx27-usb";
> > +        reg =3D <0x02184400 0x200>;
> > +        interrupts =3D <0 41 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > +        fsl,usbphy =3D <&usbphynop1>;
> > +        fsl,usbmisc =3D <&usbmisc 2>;
> > +        phy_type =3D "hsic";
> > +        dr_mode =3D "host";
> > +        ahb-burst-config =3D <0x0>;
> > +        tx-burst-size-dword =3D <0x10>;
> > +        rx-burst-size-dword =3D <0x10>;
> > +        pinctrl-names =3D "idle", "active";
> > +        pinctrl-0 =3D <&pinctrl_usbh2_idle>;
> > +        pinctrl-1 =3D <&pinctrl_usbh2_active>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        usbnet: ethernet@1 {
> > +            compatible =3D "usb424,9730";
> > +            reg =3D <1>;
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.37.1
> >
> >
