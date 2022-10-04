Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F145F4C54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJDXBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJDXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:01:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E338A30;
        Tue,  4 Oct 2022 16:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7P+tZqLUrLQ5B3zU1ixVFyiZe0pWrAb3DHfK5WAKWFceoCYW1TiU8FFza0FoMzlWSPEC86FVTB9QBKpvbx3QxZbANwttJ+yrih3bp1agZXeyOL7izkfiuZA8+sC1UT6UK8RZaFnK/CYiRrvZhcyQuVCv3FCtJVVDr5Gh1c8R5/DeO+gQwQmrlS2Q3NFICocmVt7q43qo4HDD7MhRXOo2RCKAOwNjnBFGJso3EMbUThSMrLwYaIFRiqLG3BADpedJYDfpqmuXHDR10+DP3Rl+N/MAmdmOLsfGuIWLmgvVBWIxGD1UBOQZRoq1kpVRO23H97oQcyCj8gHexe/oopgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slti70yEuo46lTlcNsXGVfzKmsd0EGhBmthC2Hc7caU=;
 b=OL0z3raqtq7IIqzmaRnoSuGLBDLefPQTTprL6+705IjL3qByX9uhF/X83TJtCsxpFGEjfs700NL+FKWAiCbXIe8xSTjCYpFlwSVhH+024Doi0k2lV2lw/qsn1gkX4NuokJdwmOxLmv0QtFZA+YNnvqXKyRVuJ64IHTM7kw9PuIhN1yFlnJdG96C1Ua81dzOp2byEjPjmya8urRfVa5x/sE6hJyiDwX6jTseYMGtbyPTbzcYJeA+yg/OA82bKv7Jee1CVaHHYUN7poY7TdiC83Fo+4dWxP9RxdbdNEpJVjp+Js/BRO2KbPauFHNuH7rcLVFV1n+tZzXcfbACdJPIa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slti70yEuo46lTlcNsXGVfzKmsd0EGhBmthC2Hc7caU=;
 b=tkO47knQPXpknf2q8bVQQrJPy5yjXmzLlYvuYxgSEyBEJwCwj8d9RGOr0zfnMPq31THR4BvQUNKCxRNwLpnydcAgYnWy+V/f8WkewT7NxI9i2CT3rSyBQbMFevfPaCzYKaql2nd1ht7lLvwT9TyjPccL9sTX3wN3jc/uFkrLTHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MW4PR10MB6679.namprd10.prod.outlook.com
 (2603:10b6:303:227::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 23:01:30 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f%7]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 23:01:30 +0000
Date:   Tue, 4 Oct 2022 16:01:26 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v1 1/1] arm: dts: omap4: pcm959: add initial support for
 phytec pcm959
Message-ID: <Yzy7RjffvnQF6Geo@colin-ia-desktop>
References: <20221004024012.1386218-1-colin.foster@in-advantage.com>
 <20221004024012.1386218-2-colin.foster@in-advantage.com>
 <6d58c08e-1537-f1ab-2883-baf869650ef2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d58c08e-1537-f1ab-2883-baf869650ef2@linaro.org>
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 482c7248-0aab-46b4-dd50-08daa65c5fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkKRyflLcwmko1qZW2uY+q/dgboOVEwFuujUZDQ2xI83gXIBo0sH9nyShyQTTgf1rL2PtyzV+UMy1svQUFiQGlUSRCQAz12DY2TL3pSD6CaRiMTrmGO10O/FmrdlUEOTTufbpfO+7UlnqkLS/QaKZO8ueDbnsHsVTmrPmjWHJtgUA97H/YOYI4hgBrzlW0lEK8nGBXNdNF7dDnPsHBqpUO/uQTe3hVVFCbF8AOq6EcEHEzN5RRGVdlccfSMlljihqodx+e+2Dz+uqeG7Qs1dFfXb0wxMicYVk9oA/5dl42sp1rrazb3UdY7XaRuFcaYHPPJOHGYmfudbgBLHFF4SX+eES+Ajle2MlbK1p1+fHQzE9s0etGrvtKCwVWwZSdYzAPFQZDMtPZ9HQZ21PYBOM+WcfUh1rVMiM6nkrW1qGHOtlA4102clXUWiuuTuVntDDce+fsJga/3nTkdZkfSJoIO2SLwifJrTtZrNqj9arVB7rXAk/3HkDlVwd8lFsQlTnHkLVFL097hgV44AfjCZ7d7QgEaK6ms0mUvZF4bsy7ABtJisQAtfiSrqeMEs9zskXJuCCkaXK9pGtpd1G2sVLZCsdltUSRgb/w4xwOWekP7QzrMjBG6iuFtEQn04hYAo8wzQFZOlnIuzGUXXcRDFhZadv4JMm49pHqqXTngCiwSBUcsOZCOOanx1Jnc4bb2DGie9HQbL9UTqpUsx9OzaGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(396003)(39840400004)(376002)(451199015)(44832011)(7416002)(26005)(9686003)(6512007)(53546011)(6666004)(6486002)(2906002)(6506007)(5660300002)(478600001)(86362001)(33716001)(4326008)(8676002)(66476007)(66946007)(8936002)(83380400001)(6916009)(54906003)(186003)(41300700001)(316002)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIyOvsKs2W/IMlrdC3pD0b428BnlDAsF2wWIHFqD1nRgNOtPyATJ0k4sWp8N?=
 =?us-ascii?Q?IyqoSeCciWi5VNuya1hCAIB9Dhw+fPEvgNFo5wIgxh8zZ3ok0hKOu02e2Jjd?=
 =?us-ascii?Q?0+75kmaaaAjQSzYx/5wH/ViE1HnNdLZBoq2er5DNaVAe93Aa3zszGVQH9b6a?=
 =?us-ascii?Q?tT73iEQaJndYRZ8F59PZVG6Jy+of9j5zYS7oZI0JWXPPQi141eFY6mcxmcRa?=
 =?us-ascii?Q?TQ8g+uDyfaNoEii501FTalNVm2OZ6UvHwDFkqls0R5VyIAN2qt07R1+xdZZp?=
 =?us-ascii?Q?B8w6jCPo1u6iQr4WBbQgWS1hHWZg2FF2MFOZdHYAMVgCfxpypoZM9h3NY8LL?=
 =?us-ascii?Q?f1EzVjeTRBcpLQ+Wz8W1sTbuae2E4GnK37oxuMTMz7YeJ4qGPMu6eSmqQpZr?=
 =?us-ascii?Q?VyPTQ7Hm9jBJQAY7bSooIMkPq6Qmo+APvtERQotGKPuwxQw/3Qouw75lp5BX?=
 =?us-ascii?Q?HdPG5mhQLRiIIZEw92w00X9GRgnpmXI9CLiKBvP3npPjcV+H7/fLy4FnD/e3?=
 =?us-ascii?Q?2xjX5b6BkrVl8SZAt2N6WggvROJ5Japu4s1KuaLk5p3bV3gIDa1iuZ9s/r29?=
 =?us-ascii?Q?TndX3xCmMYlsnsQuJ0pHzb4c+ZJuu/7qYKDtvGigIvrmVT4mLDK+sEMQJvQV?=
 =?us-ascii?Q?yVdIDsxHJAtB/oX6S+7xQwTuS4qjJ4l54fAiVa+rrXAO1g6F/JjoDfJ75u2Y?=
 =?us-ascii?Q?OqxdelWZpicZwKk9Y5YE8z6fFiqgjXhF5Vf6mvfCgW0i6pGOBIuYbD/xjr2r?=
 =?us-ascii?Q?dfKYWX5gPlnZ5bpm36KMJn9sGT6gJ7cAPYZgzribMJmdpMvhksStuuw8wD6N?=
 =?us-ascii?Q?CMYqR2ihR7D1zGIycQ9CcWYx4oR2Pwv/mCUHAN8Lfs93mj+LtLwMsE0545/C?=
 =?us-ascii?Q?UUQUksn6lBRdEQy+Fyphz65Dfr2j2Vzjo6tyPWmh4SI4VnULMQn50ncPFaHk?=
 =?us-ascii?Q?nXYGvd85WLXYm/6+hgpxsjNsG3nBFEvLZXyTli6iRXDhPp1fl4iEmWFGFQgQ?=
 =?us-ascii?Q?/XYJ7OTJFbk3+HN9BMI7b6tXrDVpcKP04Ltm165XRsCgt63TILrWQ88JIsEx?=
 =?us-ascii?Q?fPfyZMYJCzho5fWr4ATWJKuG+lp052dNISXgXIz3b4YgQLivd7ZXUz9WjM7+?=
 =?us-ascii?Q?1sz0k7pppd09wJzi5c1x8ejetbivzU5vcRrMHZqVxkopr4bcc/cRpz77WgMJ?=
 =?us-ascii?Q?CPlDM9RZOks+lVxTGjayHvg3Xhz0bOodbPl/7RlL751S8enQSozYeXmaNug+?=
 =?us-ascii?Q?0j86IYIxI+pGdlRVH3cc+3IQcDSaghi7Jdn5eKVDe+jNzvhzHWvlJ0heZ9YO?=
 =?us-ascii?Q?7Yuo6X5LxdrDemxEB7PgSE+VBCkjsNVPrHVuU1Pz9VGurjGac0b6/rpNlm0q?=
 =?us-ascii?Q?Eyt7JJ6FeCVYfdVG6MBf2XJw8ueGZc+eeTEYlBBEJzOKGxEnytiCl7xVXyLs?=
 =?us-ascii?Q?hzmVNZxh8TrCU8XY5CyBZLp4RA8ieC9oiYYrmAzAmmzZBmMFZbczgLkVREeF?=
 =?us-ascii?Q?L2hZrQwlX00vn/6vTxyr5z1QFtlUX8JoT+daYItkAUnbe463U/v0D99jHwcU?=
 =?us-ascii?Q?4ooy+Mr3Uu367wRT6xGvG5Cv49gDjgFrhK2z+ihIlZcPGyu9EE5dhoRHpgvQ?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482c7248-0aab-46b4-dd50-08daa65c5fb7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 23:01:30.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgBC81IdkBOpYcUvVVryFlBmr50GmIlcoq2HNMnhltrrntE4jcs3ZYAkiFzxRivbGJBqNzdeyfoJUV2iHuf0WPpBtSOk3907p9OJHk3P8IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
On Tue, Oct 04, 2022 at 09:04:15AM +0200, Krzysztof Kozlowski wrote:
> On 04/10/2022 04:40, Colin Foster wrote:
> > The Phytec PCM-959 is a development platform for the Phytec PCM-049 SOM.
> > Add initial functionality for the board. The verified interfaces and
> > peripherals are listed below for the SOM (PCM-049) and the dev board
> > (PCM-959)
> > 
> > The omap2plus_defconfig was used for testing. Only the On-board LEDs
> > required CONFIG_LEDS_PCA9532 addition.
> > 
> > PCM-049:
> > i2c1
> >   * EEPROM at 0x50
> >   * TMP102 (hwmon) at 0x4b
> > twl6030
> > GPMC
> >   * Ethernet
> >   * Flash
> > Serial (ttyS2 console)
> > 
> > PCM959:
> > MMC1
> > On-board LEDs (with CONFIG_LEDS_PCA9532)
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> >  arch/arm/boot/dts/Makefile                  |   1 +
> >  arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 352 ++++++++++++++++++++
> >  arch/arm/boot/dts/omap4-phytec-pcm-959.dts  | 130 ++++++++
> >  3 files changed, 483 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
> >  create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 27eec8e670ec..ef225150c5d7 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -949,6 +949,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
> >  	omap4-panda.dtb \
> >  	omap4-panda-a4.dtb \
> >  	omap4-panda-es.dtb \
> > +	omap4-phytec-pcm-959.dtb \
> >  	omap4-sdp.dtb \
> >  	omap4-sdp-es23plus.dtb \
> >  	omap4-var-dvk-om44.dtb \
> > diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
> > new file mode 100644
> > index 000000000000..05b5cd581f15
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
> > @@ -0,0 +1,352 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > +		stdout-path = &uart3;
> > +	};
> > +
> > +	leds: leds {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).

Ahh, I see that now. I had started with
arch/arm/boot/dts/omap4-panda-{es,common} as my inspiration. I'll review
the documentation and be sure to run make dtbs_check before my next
submission.

And thank you for all your other points. They're all valid, and I'll
be sure to implement all of your suggestions before a future submission.
There isn't much use for me to acknowledge each suggestion one-by-one.


Thank you very much.

