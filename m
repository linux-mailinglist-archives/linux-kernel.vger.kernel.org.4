Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F65BD472
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiISSHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiISSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547845F61;
        Mon, 19 Sep 2022 11:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxkGUScv83YBXWk5+agufI1MwmV+joU1SKknepr66zq2uhn3V1ZLbkJCnt0wi+c+oZjNq5nVAITzokwYq9DgEBiDxcJYHJauwiXGFiAq3wYgu4jR6Ryn4VGuN296ieXc4fn6pIHytKtnBKaf+cCsq4wNMvdzX4/bd8vpUZ6aLqmuBFCIgHxlgZc1VQ4zO4fO2ywESxzCzlChBvhLOAGQHEPtiyjX0ksPUHkmpwsPuiQ4+SopWCoQiBiTtP6mJFMfebP1kF2tYy3wRlDhh6sDA3kAh6Fe99fGn9jrJRp1RvqidRcENqQl58QsHx8cPrC+sfaBC4YPdYYs+plZ8EpaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riIOQ18Zj+wtFHipvp/WnbS8HABclT2Np3GTyQpdsMc=;
 b=lmMrYoCY5ITic+PjK+/mkh3VWNGUkJYc0yngZ4FnLvrK5BESLGiVLlOmylX41s545+W8PKWJtU3dfydita68KvSnlnYhQT0suTCc71xbx0IxwCVQAkrEhMrx2xVOP1GBPNxfxJ1eNYj/HsAS6tpW4SVvZopbYuzwbZD+a5rrN3StbllAWu0Y2GJsnOzk2yy86fhyTF1Rp+jg0dClI25YwgqwEmmb6ZLqsrLQSjBb6FUAVDjT0hLc3Vb1mIaMu55tWp4qtD32sr/cS71g+Dp/GSR8O8Pzw1z/HBeCVrwADKBl0wQqK/DGI/lUzgOL+Hq8gvvVYD8xRCFrnyeijofH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riIOQ18Zj+wtFHipvp/WnbS8HABclT2Np3GTyQpdsMc=;
 b=fhjdd14o5eDQORZlJW86lmc8+vJuk1krCN37XwCkPI1NcRXGXaacxpDKad334MMCNOwDd7v3SYLAD8v2chQ7hneKHtp6Lta4Imd2zOexTnKdnq2GSAKbGy4l+QZklMyrYsGwtwxWEdf1g3wa+oluRnG+CFZmVi+8Nnm7PlcJau4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 18:06:41 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 18:06:40 +0000
Date:   Mon, 19 Sep 2022 21:06:31 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Message-ID: <20220919180631.x2telgn6d7woggmz@fsr-ub1664-116>
References: <20220919132236.264382-1-viorel.suman@oss.nxp.com>
 <c86d39c9-82d2-0f9f-9836-76ad3b6d8ede@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86d39c9-82d2-0f9f-9836-76ad3b6d8ede@linaro.org>
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: f74d3d2c-5f7a-4cdc-bcb1-08da9a69b3a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvfCkx4WhpAqk5xG79RsW1kTUojZHYMegyZ37GI30cH3yTetWpS0MK/4EFahWsLjERO7PdKw4xjov1lYLlcNBcekGLH8dFzWu6BThKmNRt5kgAJJ+5QmlxywR/A7DhVW96DrgnbUduFozS9UdbkYKws2uQAabHKeuqQJ8GKdjPQzhyog+u9ZApcjQFdZxfyU9jogtHkTSkh//l3bvtNHJUW/wGoBSbgNdVN2qF4PYb2U4BtiUVqGoZINIh8kh551cvM6mZ40uYoSImjfaeNrFPzUwdnJK5CirLzevPf21DfhvahGPezgN9qvg8k4opoeFHWelaKp7UnqvpXNTd7WwngpLUDkj0CqQ9O/GivNLvOFkguOl6Gy7SJ/PMq+SjaZFQhFnABeB4tHmHIaOIVVYxAoSownLzxK7mIzq6AKvFVdw8IqkCw3SbeEDfMjlVYN2MK/kMWqESSXf0RTT30w86R4oZ1T4GtiE/D3bvpx75LLTX6fSfYEwcmhNTG8JnRYn0ehuO8dZ7xb+qKQ6KMn1bRD3cR8vE/b6g3HqDuhlAboXUsv+Ga8SCYwS+ykKllxOWyCqs4QrmBFsWH1m6HleNL8vMVg/Dy8RCtc1jMLvjVOfDU8NVtymuzp/OU6u8cKpDjNKrsAKYOlXmOCezeFDeP8bQTyqhB8quhef18adKHlrVPoEsBw9EsW0EqUODUmLwfaKxbTzJorrg91AfCYbnwKR9qaHJDy3Eq9gm527IKOuDaMj3tAeB0GMIMb52yHX1O3sxEBxmVvZvM52SBBgIHUHukxvpqyRHE1Zti+3bp6K53ykrZzj93uHonbeRsxcGt8eWMdCaTNcF2gdLYSYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(66556008)(66946007)(7416002)(4326008)(5660300002)(8676002)(66476007)(6916009)(86362001)(8936002)(54906003)(316002)(38100700002)(38350700002)(83380400001)(53546011)(41300700001)(52116002)(6666004)(6486002)(966005)(6506007)(478600001)(186003)(1076003)(9686003)(26005)(6512007)(44832011)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mcBWZK6RTRzIQQAIGZ5MQQGHOj2/TjtxCuZmk3r7r3seofGsRlQzDa3WGJL9?=
 =?us-ascii?Q?AFdkTBHu4wN7pkseTY2Hrr0SoSJiTlBcOpikZ2Z52j7QOGHDW+z3Dc4JpYRC?=
 =?us-ascii?Q?y1ZO00QQDW3AwYHzK2IxPzB7pSUuylN9YknpVLzeKXmHOh4w4nRQ+x/8NkHO?=
 =?us-ascii?Q?5pCZpkL9RBZ0aJ+knqEkcJKjZQOzXBOxdAfzClbEQ7tmXcsGcEt5sDD7HBfK?=
 =?us-ascii?Q?C31y2zIoASy3iTGaJrueFY60uvK9ThyATnx47NJwxDx6otE68yi/PVIdYpDo?=
 =?us-ascii?Q?jTbuRhK0Uwltt5Z3FS57xjdjibNlZnCf7Wr2SLq4gvHABVbHgdklhqOFcpIH?=
 =?us-ascii?Q?GM2cFUhp8Q3IGqOG9NN9kwpRZclnKxZDoccofXJj6mac+5ydp7HjaNPZwFDQ?=
 =?us-ascii?Q?h9Ix1KGV84VnS+lj8MZcuMRz5QJ3WOPB/ibtaUGK6y8q305y+GN4b9H7J5QL?=
 =?us-ascii?Q?5+yJiKwyFf1VvTJDliv28KKUGbn0NIthhRE+79k1+tGNgC9xC3oVDlUsdHEr?=
 =?us-ascii?Q?9Rn0Lv9f/u3zLfQ7SyCcXBx4bNzMlPDY+7KcjzdDg+FwtEr6wLEIK2YBqbJS?=
 =?us-ascii?Q?rNWElT7A1pb1f/LPZDCtm17Si7kYysy1k1vov6yR8cmr0mBnPypp5pevda33?=
 =?us-ascii?Q?GCqfWoqTTmPggUUIhALMm5g9E+bIIhHvlOUJtufHbFw/Vfih8L7k2oE04d6w?=
 =?us-ascii?Q?jpxnWbVX7EhoBTFc9pCmihMwltCgbHlq3T89cGk2PhrwbN53zEHEFU1nnf5u?=
 =?us-ascii?Q?20rtKa37rdpjI/o0QaW+IOBNMBlep3DZwFFdCEOQDxj58y+1T9jN6Cm6Cpp1?=
 =?us-ascii?Q?WOZ/POrl3YNk9uFd3UMzq5PUa8Fo4t8d2zFWG4LrYmZbdAbwxRKkVW7ec2qg?=
 =?us-ascii?Q?0yQDnBzYEKdAqRPpkkFQeRyZRIyXqXNKf/uiugBL+fVllZPJRbrDXZc2yU1L?=
 =?us-ascii?Q?AFsIIGyPfzuQZv8xayA7BLfABKkcs21yyMbHZVYAMUGbgt0nymPAaYErjY2E?=
 =?us-ascii?Q?SB+puN8YGZWSshBKmmO8uY0UMYziBM0m+z92rmfTQFAl/0hecSmvIJgbABA0?=
 =?us-ascii?Q?SLaM0uh1Y0QWGoUFJVlBPi0C3ukfRgdGMPPUvU6jJhJ9NHWxjQQAzjfqV1Lq?=
 =?us-ascii?Q?P3ldea8X0ZXYjhSf5KkRN9IiJgD0Xj28zCxF/cTWfnB1W+FJLK+8U+gPfae2?=
 =?us-ascii?Q?78/3NllSHnc9szBsF5jKlD7xzDDWu7QLvXB2COxR6mLQicCUKhKlp3shwEMV?=
 =?us-ascii?Q?RFSg4Y38eGMZ/zlpCUyT67Vk14P6wnqSFQPcB8CDrmQYXeRG6UkjFxIU0QZP?=
 =?us-ascii?Q?3rHMLaKnJCYIpSb5fq3hPuuuk3xwDFMh3bX4d87wT3Zxyaevm3MMJZIufka6?=
 =?us-ascii?Q?HfaFcyJwS/+5Co6u0kXu8OcPF0sRue37WwURbiwg4Eh4r1Edzswbar1klRXM?=
 =?us-ascii?Q?UXeK5k8jcrcYEK8/L6ulAu9Ck4DpHmV+U9RzK5Nwj8dkCaUZn3Gd8Nw5CtBe?=
 =?us-ascii?Q?DSJtUQXx+dVRxn27aUuf6j6NOi4OVqBOmjx93hZ0kCb2HbEPs4PitPKCJVxc?=
 =?us-ascii?Q?NNSdzAL9xvFUL4u8jcYmjMvivfb+xx2pX06zJMeW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74d3d2c-5f7a-4cdc-bcb1-08da9a69b3a3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 18:06:40.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmtVq7Jx7Ezfa8qHS7MxMyR9PQEZkZH2OoM/xZVhOdp/jIK6nwW8JZJWe04Dmf2VB2uDNH/9Jku6xZfIbgnHKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19 18:10:51, Krzysztof Kozlowski wrote:
> On 19/09/2022 15:22, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > Sync defines with the latest available SCFW kit version 1.13.0,
> > may be found at the address below:
> > 
> > https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  include/dt-bindings/firmware/imx/rsrc.h | 294 ++++++++++++++++--------
> >  1 file changed, 198 insertions(+), 96 deletions(-)
> > 
> > Changes since v1: https://lore.kernel.org/all/20220915181805.424670-1-viorel.suman@oss.nxp.com/
> > 	Two patches squashed into one in order to keep changes bissectable
> > 	and compilable as suggested by Alexander Stein.
> > 
> > Changes since v2: https://lore.kernel.org/all/20220919113715.243910-1-viorel.suman@oss.nxp.com/
> > 	Added two more defines in backward compatibility section in order to
> > 	to avoid breaking ABI, so there is no need to change the driver
> > 	anymore.
> > 
> > diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> > index 1675de05ad33..ed33869f184e 100644
> > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > @@ -13,30 +13,30 @@
> >   * never be changed or removed (only added to at the end of the list).
> >   */
> >  
> > -#define IMX_SC_R_A53			0
> > -#define IMX_SC_R_A53_0			1
> > -#define IMX_SC_R_A53_1			2
> > -#define IMX_SC_R_A53_2			3
> > -#define IMX_SC_R_A53_3			4
> > -#define IMX_SC_R_A72			5
> > -#define IMX_SC_R_A72_0			6
> > -#define IMX_SC_R_A72_1			7
> > -#define IMX_SC_R_A72_2			8
> > -#define IMX_SC_R_A72_3			9
> > +#define IMX_SC_R_AP_0			0
> > +#define IMX_SC_R_AP_0_0			1
> > +#define IMX_SC_R_AP_0_1			2
> > +#define IMX_SC_R_AP_0_2			3
> > +#define IMX_SC_R_AP_0_3			4
> > +#define IMX_SC_R_AP_1			5
> > +#define IMX_SC_R_AP_1_0			6
> > +#define IMX_SC_R_AP_1_1			7
> > +#define IMX_SC_R_AP_1_2			8
> > +#define IMX_SC_R_AP_1_3			9
> >  #define IMX_SC_R_CCI			10
> >  #define IMX_SC_R_DB			11
> >  #define IMX_SC_R_DRC_0			12
> >  #define IMX_SC_R_DRC_1			13
> >  #define IMX_SC_R_GIC_SMMU		14
> > -#define IMX_SC_R_IRQSTR_M4_0		15
> > -#define IMX_SC_R_IRQSTR_M4_1		16
> > -#define IMX_SC_R_SMMU			17
> > -#define IMX_SC_R_GIC			18
> > +#define IMX_SC_R_IRQSTR_MCU_0		15
> > +#define IMX_SC_R_IRQSTR_MCU_1		16
> > +#define IMX_SC_R_SMMU_0			17
> > +#define IMX_SC_R_GIC_0			18
> >  #define IMX_SC_R_DC_0_BLIT0		19
> >  #define IMX_SC_R_DC_0_BLIT1		20
> >  #define IMX_SC_R_DC_0_BLIT2		21
> >  #define IMX_SC_R_DC_0_BLIT_OUT		22
> > -#define IMX_SC_R_PERF			23
> > +#define IMX_SC_R_PERF_0			23
> >  #define IMX_SC_R_USB_1_PHY		24
> >  #define IMX_SC_R_DC_0_WARP		25
> >  #define IMX_SC_R_V2X_MU_0		26
> > @@ -56,11 +56,14 @@
> >  #define IMX_SC_R_V2X_MU_3		40
> >  #define IMX_SC_R_V2X_MU_4		41
> >  #define IMX_SC_R_DC_1_WARP		42
> > +#define IMX_SC_R_STM			43
> >  #define IMX_SC_R_SECVIO			44
> >  #define IMX_SC_R_DC_1_VIDEO0		45
> >  #define IMX_SC_R_DC_1_VIDEO1		46
> >  #define IMX_SC_R_DC_1_FRAC0		47
> > +#define IMX_SC_R_V2X			48
> >  #define IMX_SC_R_DC_1			49
> > +#define IMX_SC_R_UNUSED14		50
> >  #define IMX_SC_R_DC_1_PLL_0		51
> >  #define IMX_SC_R_DC_1_PLL_1		52
> >  #define IMX_SC_R_SPI_0			53
> > @@ -151,10 +154,10 @@
> >  #define IMX_SC_R_DMA_1_CH29		137
> >  #define IMX_SC_R_DMA_1_CH30		138
> >  #define IMX_SC_R_DMA_1_CH31		139
> > -#define IMX_SC_R_UNUSED1		140
> 
> This one disappears...

Hi Krzysztof,

Right, it was renamed in the subsequent SCFW kit
versions to IMX_SC_R_V2X_PID0, thus - this patch
rename it in include/dt-bindings/firmware/imx/rsrc.h
file in order to have this file and SCFW kit defines
synchronized.

IMX_SC_R_UNUSED1 is not referenced somehow in kernel,
thus - no compilation issues if renamed to IMX_SC_R_V2X_PID0,
IMHO it does not make sense to me to add the related
backward compatibility define like below:

#define IMX_SC_R_UNUSED1 IMX_SC_R_V2X_PID0

Regards,
Viorel 
 

> 
> > -#define IMX_SC_R_UNUSED2		141
> > -#define IMX_SC_R_UNUSED3		142
> > -#define IMX_SC_R_UNUSED4		143
> 
> Best regards,
> Krzysztof
