Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378B727F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbjFHLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjFHLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C2526B9;
        Thu,  8 Jun 2023 04:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F8C61460;
        Thu,  8 Jun 2023 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52451C433D2;
        Thu,  8 Jun 2023 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686224904;
        bh=ugZB4JpowTSw5maVY2a7prvIYR/oQ04BV7q0yRRRuls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boJKNZpfHyX0Pb4WgHrFV1UsYZ6msrh4OLUMaQP9nJ98IrGgPfTGVm5H03J/JBb2p
         SLhwn+nYzroyktEFi4LMh/Kh0J0bZHlvcV9geFOwv2Vnshdo7kQG7Bgtl4Ed/YDkM+
         ysaDAIOBVk/BCwFTjteUAa7tAaW8OSDMLEU4DHQEcypW1FBPCZbyWDopxad4nXN448
         boenL5l8QYJQY4ZkI75hv6Furka5OLj3sWCnbM1BU/ri6NtT7KQmUw+Xh766Cjd31w
         ItfIAJs0xGH8RHGowJv/c+7USPmJxxTEbvPVspsls02rycaVazddqCIXzWS1bhasfD
         f0AFOVYMU8ESA==
Date:   Thu, 8 Jun 2023 17:18:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Haotien Hsu <haotienh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Message-ID: <ZIHAA6QwRkQ+lS45@matsya>
References: <20230508100320.345673-1-haotienh@nvidia.com>
 <e7ae22f4-52c1-62a1-e5c2-71732bcb04b2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ae22f4-52c1-62a1-e5c2-71732bcb04b2@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-23, 10:39, Jon Hunter wrote:
> Hi Vinod,
> 
> On 08/05/2023 11:03, Haotien Hsu wrote:
> > From: EJ Hsu <ejh@nvidia.com>
> > 
> > For the dual-role port, it will assign the phy dev to usb-phy dev and
> > use the port dev driver as the dev driver of usb-phy.
> > 
> > When we try to destroy the port dev, it will destroy its dev driver
> > as well. But we did not remove the reference from usb-phy dev. This
> > might cause the use-after-free issue in KASAN.
> > 
> > Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: EJ Hsu <ejh@nvidia.com>
> > Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> > ---
> > V1 -> V2: Remove extra movements to clarify the change
> > ---
> >   drivers/phy/tegra/xusb.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > index 78045bd6c214..26b66a668f3b 100644
> > --- a/drivers/phy/tegra/xusb.c
> > +++ b/drivers/phy/tegra/xusb.c
> > @@ -568,6 +568,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
> >   		usb_role_switch_unregister(port->usb_role_sw);
> >   		cancel_work_sync(&port->usb_phy_work);
> >   		usb_remove_phy(&port->usb_phy);
> > +		port->usb_phy.dev->driver = NULL;
> >   	}
> >   	if (port->ops->remove)
> 
> 
> Are you OK to pick this up now?

Changes looks good to me. But title should describe the change, so if
Haotien can change title to reflect the change in patch, I would be
happy to apply

> 
> FWIW ...
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

ofc this should be carried too

> 
> I believe Thierry already ACK'ed V1.
> 
> Jon
> 
> -- 
> nvpublic

-- 
~Vinod
