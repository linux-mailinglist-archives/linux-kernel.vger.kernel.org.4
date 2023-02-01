Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0F686A68
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjBAPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBAPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:32:16 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C074A56;
        Wed,  1 Feb 2023 07:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXUinsH6US0TxYCovMuinxRAjpWCcFRlRYxJTCUbE+BSb7OmJCigt1hZaMwQGsJ12NiNjiymhB9ucLbslaRxXHfX2ZPzysD8C9jDdO1WuL/gcCmwHBa9121bnYIX/lzCD+/0jPT0QapSKGe9a3k6AwSdp/lQUT1JWRkoNgz3qxi5F23pD902VX12NoA/qy3NuRKpO3CVTOxyOoAbr9rnEJemv910FpOT/l4B1ucdLHR7pd4tCRENtbRy5P0ehyFgj11rrva083jaqf4sY41mnZZotojntR8ewYJ/5blZWkjMKliRcDqTeAHdUQufGKKyXATt99RIsop3XIEPaxnz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v4g926Najd70D6JVRBk6pqZDBXe2q3YTcW0i3rC4W4=;
 b=jVgsKknVEhiqhUW0fXF6JhFQ0vwTYcq9tIdUrZF+yC00+t9TmEwGUj9w9+or9971d9OHln/vwdpROkkZzlRV9nBmNG94BKR1pycYwkYr5O7RbkQgy8UVgOQYriuPG3RRGBwuWzo49bB4Qe2ehS78K83kyMpXjmotweE2nl6fdmHZK4vYniwTD9G7FbnL6Hp/QxGz/c+WkAiF2x+e95gNpc1pY9kP5bu6ZadnLaK7mHkwu7l+A4cZ/dg0rpZxdkHvyen7QxQ+bKRv21+CY6yVuZzCeXAKuEbwFQQnRBw6yuwlZqCW4ipyIsvCsolo4hFuP4aJxtOinTWlV3Skg3E3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v4g926Najd70D6JVRBk6pqZDBXe2q3YTcW0i3rC4W4=;
 b=l2gDgQ6SUiEmy7e63G/q0VRUsqD42Qd1+xc1wb8VlnGG/6W09FWKoQXdV6e0MfAdxwk1Y80QS5V8vj/GN175vbUWdj3B/BR9MpPC6phu9b4R74AGwAhcts1iCSRGXgQFk7/mqcOyI+eJ2KOUTUcE8sTWV3XnM7pEUGR63A/gUnS5Qh/SKjrGMuu2/RKB0mER7sadGGtzk+L9O9uvVchieut0hl2o14y/LtpgUfBW0mk7FHigJpH9/fcrLegKti2hk/kDVaV0rFnbcsj6YY2pSRkAULovXrH+UbAyRhJhKtb3rukvMOnbgZlmYQwhJp7+SWOcMlPbbpEQauwi9V17Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 15:31:34 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 15:31:34 +0000
Date:   Wed, 1 Feb 2023 23:31:17 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v4 2/3] pinctrl: add NXP S32 SoC family support
Message-ID: <Y9qFxbDIzJClmEKz@linux-8mug>
References: <20230118094728.3814-1-clin@suse.com>
 <20230118094728.3814-3-clin@suse.com>
 <CACRpkdZgjoxV-PPUcVHp=e0uMzx8UnvLoLMLXynm8X4VtBdN7g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZgjoxV-PPUcVHp=e0uMzx8UnvLoLMLXynm8X4VtBdN7g@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:405:4::26) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd17444-fbb5-42ec-f904-08db04696645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lriGmScR+7aZ5TLs/xNVeBJ0WgtymmAYPvowdWK1YCnxMB9f1/hYDVQT23NQyneYaNUfL98OX9lBur2F92+NLqyIeL1MJnrpa1lfDi8+GWrwuJLJzmdqZWRvjB6pLCVOTHIoNup0qp8wzKWt4Zwq0MWu22L7g0NXXbkl5y1bSnOBUUzMpOEfxBJMvNYUyFoHAovlTeAYKLnKptr8xHTpHmBbFgpU4j/1MmBLhHXMnWgzyK8KLdOm7aOPNAzuA3Pq5JVqvlgh5E3lSGshc7bgpo4rL/nhih08V/0s6SrjqP/jWzhFcB9MdZ+zsfX8DthPRSSHN8WOBPPRy753EtkP3Q/K4KATBBpO3eTmKRaR77Mp+3wNkKXU3cYXQVLDklmJPROJ05lyqeEXk9sqseSVUy84XzbZpQBDNh++fuh8Zhl6xgsmPpF3qai6kzRCRkFV5uv3zH+G78m0jLFzQx9Jk0TQe7qKqFCx54ieP8S6SfQ4TiI/y04YxbeMrvcoqVLK77zGug/pXMTaX4o3RgcnUtMAttRExpRv88VvlbncXItHvgcpfnVsqQlZYLbKMyjQrUhtzfaCUJYzD56jdB74lqHixp/qb0V7Nz7KNFNSCskBBrU/wu6osNV4lH383v5OHjkgYkxHK91joLzG0LctHv4nV6Q+bOLPbSGXeUHYPRKGT7C6K01glMi5MoV/Qdad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199018)(66946007)(66556008)(66476007)(6916009)(4326008)(966005)(33716001)(41300700001)(8936002)(8676002)(6666004)(6486002)(83380400001)(54906003)(5660300002)(478600001)(86362001)(38100700002)(316002)(6506007)(53546011)(2906002)(26005)(9686003)(7416002)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSJz1IzGFfsAjlfceaS1XUUi4j106aMwMIaEewWpUZwq7GGpgTiQO7M0XLlh?=
 =?us-ascii?Q?C+2LPxxH5Ro97seTQt1Y1PVjquPbANtKjD3Q6dwqZbqbIsBJySdBWyDg/8H8?=
 =?us-ascii?Q?TxAjB8PjCsIggP1KRBZFNXLcxMPPlJS/xXoalTmReDrvvsazWR+8vCSPrDe/?=
 =?us-ascii?Q?AKb3iUipHpqFrGhDho4TPKu7PaYB6Hzj8eG2UinA/EJEZymG098hvuVYcdq7?=
 =?us-ascii?Q?GVKGEJ56ejTv1+cI10fOu95eWWn1Jkkl2uerubJtRegMZZIwZByjUSUHQw3M?=
 =?us-ascii?Q?mNqVj+eGIRUMtfZuX4ERpbC0TvMAiDq6CQCsk0zPpD3DXobd/VeUJCLHqK5E?=
 =?us-ascii?Q?mN020b4twNMrCh9DduDKOmdUOR+bYI2MfA/X3IbQsZSYcsfbWz9kb8extP5e?=
 =?us-ascii?Q?9sncyrmfTe+5toWbUduK8M3biWXgq+cn+3GPiB+2MqH07xRUs+1uIdN7Mkr1?=
 =?us-ascii?Q?niSCdZSoJxGE1rZD+/WG1+0sa5YrySz39t4S/pzNl2A7ogtGJ9tXQ/fW1SON?=
 =?us-ascii?Q?l7H1G07Zn+gG2kogt7pl5q4qxs6xySqvSj0+hmPfqW8aTxXwBbC+vwEeAuS/?=
 =?us-ascii?Q?W1kjcMQxpBhKsQWEOAdpp6s24m6+IWTqXaqkO8GmGpxa5JCV/3CATguFwEDy?=
 =?us-ascii?Q?1oSSWnG5W9KXDbr6ffQePVKkx3uxTsJC6wkEZS9F0zMbv1TukYtgRX2MRiw1?=
 =?us-ascii?Q?6mXWPbK+NZ+0I0CiVu6IMPmFKi4nVf+lQJBti6tec9VeJFvVC1vlDLlk7o5W?=
 =?us-ascii?Q?eBYj80K6khPXQ/N4S4CjiJj6jYLDdyvWYn3fJrfV9Z9FbMm3w/c6uCv/UfRL?=
 =?us-ascii?Q?mnG8ERYZAiTyFhl1YBy05Ux5nZ4MmBQv/w2pEC3AV3yVVcuXRR6t68Q1xJWJ?=
 =?us-ascii?Q?6yoavEC14ICPNI90fScsm8fWqXzkg+rguIjIJnrZi3uBO7OH4o3i4tkA7fiK?=
 =?us-ascii?Q?IKLjgVFuYcEKtpyag110nlO43HuhvznhUDkTp23ANUL41/eC2mmDva2o5iib?=
 =?us-ascii?Q?YtSCJAbAONcvPv9LtexB4ZyK+QCKF0tsDvJsSIZ6H+Y/MrQNQl11Tzfuzd2r?=
 =?us-ascii?Q?rDdTOlZjTFio/yv3yZIEc4JB79Feq8ulZsK+x1Pkn5p9xSO5LrJEW9QtAPWx?=
 =?us-ascii?Q?K7dFd+t0cKkP8PGq2wcW6lyt+Eu4nUVdCojhDqVSoVyO3IcpjaquYYIZcu+l?=
 =?us-ascii?Q?GB7srKDjUHYORDOAMb7gj+Yih3bCaAjS+tk4Ps6pYAyJtF3e/2xVkLZ9t2FY?=
 =?us-ascii?Q?OvobmuofyLQmIAqIfB8LVB0igblMYxsKxHNMTO6FtqxQULos17Ug/ekU/lWX?=
 =?us-ascii?Q?paCxIr4qa6QFq82R+Ptfwyf6tr/F/05tHNKmKp0dd5+cBL+dfr6GvKJsclir?=
 =?us-ascii?Q?prShOSrymXXacgTzCHgEHe4/N9AWZTaauM9LRb+EytUGzYByP/HBziLiLoPX?=
 =?us-ascii?Q?TOUFxaOMKbQF3PtsMeJRw4805dWWSlb1tWDkjSZ/R0xUiZVkYRULbSm25+zk?=
 =?us-ascii?Q?RecUz++wbMYmjQ3w8UgsASdnUVow0fRQOd/fheXivZ4oUgeQMiK3BSbG2Prr?=
 =?us-ascii?Q?qE1C8+FFbDIVeT1d/sU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd17444-fbb5-42ec-f904-08db04696645
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:31:34.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBUjDiqRaVlWc5+ywCsoQ3WocLB4ulHGQPhJRG9Xrny+WDqNx375Gy1Dd8v9Egbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for the late reply and thank you for reviewing this patch!

On Thu, Jan 26, 2023 at 02:25:50PM +0100, Linus Walleij wrote:
> Hi Chester!
> 
> thanks for your patch!
> 
> This looks much better and the DT bindings are finished which is
> nice. As the driver is pretty big I need to find time to do review and
> look closer.
> 
> Here follows some concerns:
> 
> On Wed, Jan 18, 2023 at 10:47 AM Chester Lin <clin@suse.com> wrote:
> 
> > Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> > on NXP's downstream implementation on nxp-auto-linux repo[1].
> >
> > [1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt/drivers/pinctrl/freescale
> >
> > Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> > Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> > Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> > Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> > Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> 
> (...)
> 
> > +++ b/drivers/pinctrl/nxp/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config PINCTRL_S32CC
> > +       bool
> > +       depends on ARCH_S32 && OF
> > +       select GENERIC_PINCTRL_GROUPS
> > +       select GENERIC_PINMUX_FUNCTIONS
> > +       select GENERIC_PINCONF
> 
> Maybe select REGMAP_MMIO
> Maybe select GPIO_GENERIC or GPIO_REGMAP
> see further below.
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +int s32_pinctrl_resume(struct device *dev);
> > +int s32_pinctrl_suspend(struct device *dev);
> > +#endif
> 
> I think these are usually handled by tagging the functions with __maybe_unused.
> 

Will fix it.

> > +static u32 get_pin_no(u32 pinmux)
> > +{
> > +       return pinmux >> S32CC_PIN_NO_SHIFT;
> 
> Maybe add a mask too so it is clear that you just rely
> on bits being shifted out to the righy.
> 

Will do.

> > +static inline int s32_pinctrl_readl_nolock(struct pinctrl_dev *pctldev,
> > +                                          unsigned int pin,
> > +                                          unsigned long *config)
> > +{
> > +       struct s32_pinctrl_mem_region *region;
> > +       unsigned int offset;
> > +
> > +       region = s32_get_region(pctldev, pin);
> > +       if (!region)
> > +               return -EINVAL;
> > +
> > +       offset = pin - region->pin_range->start;
> > +
> > +       *config = readl(region->base + S32_PAD_CONFIG(offset));
> > +
> > +       return 0;
> > +}
> > +
> > +static inline int s32_pinctrl_readl(struct pinctrl_dev *pctldev,
> > +                                   unsigned int pin,
> > +                                   unsigned long *config)
> > +{
> > +       struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       spin_lock_irqsave(&ipctl->reg_lock, flags);
> > +       ret = s32_pinctrl_readl_nolock(pctldev, pin, config);
> > +       spin_unlock_irqrestore(&ipctl->reg_lock, flags);
> > +
> > +       return ret;
> > +}
> > +
> > +static inline int s32_pinctrl_writel_nolock(struct pinctrl_dev *pctldev,
> > +                                           unsigned int pin,
> > +                                           unsigned long config)
> > +{
> > +       struct s32_pinctrl_mem_region *region;
> > +       unsigned int offset;
> > +
> > +       region = s32_get_region(pctldev, pin);
> > +       if (!region)
> > +               return -EINVAL;
> > +
> > +       offset = pin - region->pin_range->start;
> > +
> > +       writel(config, region->base + S32_PAD_CONFIG(offset));
> > +
> > +       return 0;
> > +
> > +}
> > +
> > +static inline int s32_pinctrl_writel(unsigned long config,
> > +                                    struct pinctrl_dev *pctldev,
> > +                                    unsigned int pin)
> > +{
> > +       struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       spin_lock_irqsave(&ipctl->reg_lock, flags);
> > +       ret = s32_pinctrl_writel_nolock(pctldev, pin, config);
> > +       spin_unlock_irqrestore(&ipctl->reg_lock, flags);
> > +
> > +       return ret;
> > +}
> 
> If you turn this around, *first* get the offset and *then* issye the read/write
> to respective registers, you will find that you have re-implemented
> regmap_mmio, which will take care of serializing your writes so that
> you do not need a lock either. At least consider it.
> 
> > +static int s32_update_pin_mscr(struct pinctrl_dev *pctldev, unsigned int pin,
> > +                              unsigned long mask, unsigned long new_mask)
> > +{
> > +       struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> > +       unsigned long config, flags;
> > +       int ret;
> > +
> > +       spin_lock_irqsave(&ipctl->reg_lock, flags);
> > +
> > +       ret = s32_pinctrl_readl_nolock(pctldev, pin, &config);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       config &= ~mask;
> > +       config |= new_mask;
> > +
> > +       ret = s32_pinctrl_writel_nolock(pctldev, pin, config);
> > +       if (ret)
> > +               goto unlock;
> 
> And after having pointed out how regmap MMIO was reimplemented,
> here you re-implement regmap_update_bits() which performs mask
> and set.
> 

Thanks for your suggestion.

IIUC, that means I should use devm_regmap_init_mmio() to acquire a regmap and
then use regmap APIs to access registers, such as regmap_read(), regmap_write()
or regmap_update_bits(). My main concern is that this driver would need a regmap
array to map all register base addresses since they are scattered based on the
memory map of S32G2 SoC.

> > +static int s32_pinconf_get(struct pinctrl_dev *pctldev,
> > +                          unsigned int pin_id,
> > +                          unsigned long *config)
> > +{
> > +       int ret = s32_pinctrl_readl(pctldev, pin_id, config);
> > +
> > +       if (ret)
> > +               return -EINVAL;
> > +
> > +       return 0;
> 
> This looks like unnecessary indirection since every call site has
> to check the return code anyway, can't you just inline the s32_pinctrl_readl()
> calls?
> 

Will fix it, thanks!

> (...)
> > +#ifdef CONFIG_PM_SLEEP
> 
> Use __maybe_unused and compile in unconditionally.
> 

Will do.

> > +static void s32_pinctrl_parse_groups(struct device_node *np,
> > +                                    struct s32_pin_group *grp,
> > +                                    struct s32_pinctrl_soc_info *info)
> > +{
> > +       const __be32 *p;
> > +       struct device *dev;
> > +       struct property *prop;
> > +       int i, npins;
> > +       u32 pinmux;
> > +
> > +       dev = info->dev;
> > +
> > +       dev_dbg(dev, "group: %s\n", np->name);
> > +
> > +       /* Initialise group */
> > +       grp->name = np->name;
> > +
> > +       npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> 
> There is a lot of code here for handling the funky pinmux stuff. Don't we have
> generic helpers for this? Well maybe not :/
> 
> > +static void s32_pinctrl_parse_functions(struct device_node *np,
> > +                                       struct s32_pinctrl_soc_info *info,
> > +                                       u32 index)
> > +{
> > +       struct device_node *child;
> > +       struct s32_pmx_func *func;
> > +       struct s32_pin_group *grp;
> > +       u32 i = 0;
> > +
> > +       dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
> > +
> > +       func = &info->functions[index];
> > +
> > +       /* Initialise function */
> > +       func->name = np->name;
> > +       func->num_groups = of_get_child_count(np);
> > +       if (func->num_groups == 0) {
> > +               dev_err(info->dev, "no groups defined in %s\n", np->full_name);
> > +               return;
> > +       }
> > +       func->groups = devm_kzalloc(info->dev,
> > +                       func->num_groups * sizeof(char *), GFP_KERNEL);
> > +
> > +       for_each_child_of_node(np, child) {
> > +               func->groups[i] = child->name;
> > +               grp = &info->groups[info->grp_index++];
> > +               s32_pinctrl_parse_groups(child, grp, info);
> > +               i++;
> > +       }
> > +}
> 
> This also looks like helpers we should already have, can you look around
>  a bit in other recently merged drivers?

You probably mean these two helpers in pinconf-generic.c:

  pinconf_generic_dt_node_to_map()
  pinconf_generic_dt_subnode_to_map()

Since we use specific pinmux format [as described in dt-bindings] to represent
pin ID and mux settings, to my understanding, calling generic helpers would get
nothing due to lack of generic properties, such as 'pins', 'groups' and 'function'.

Please feel free to correct me if anything wrong.

Thanks,
Chester

> 
> Yours,
> Linus Walleij
