Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23672DD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjFMJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjFMJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:16:25 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C918E;
        Tue, 13 Jun 2023 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uhjzXZe8wgMs5FuwxQ4+Od/2x3sAP3pOp5BpehqGTu0=; b=a6SDmfWfSGf4qCUl5Xj+9Y4j3w
        8iZA6ePlTkG0fhM+2/gr70AiKShBeosfxdrSKfYUQ8myHCHdoZoec5SNjFtkLgzV0JeHkaF7A5oxQ
        FpAE6p/an7ZDmPgIoWHH1qnltjSgF+cBBSMorvxwpAIcy8S6uXOwP0/2mSeVjvETHlYOEeG/Mj61W
        kWzfKi/xqtuq+1xrURM44GLLeDs3ldh0OxGYXL4rr+nEXxDzCZlDDb+4fabNKg/4rM7KVTAdOOImL
        iK9Em1E+xKKgGdeL1VQwj7JZ3J18abp8vzSiVSBb+mpXGMRxT9OKujFq3DnKrcWv5mNIqiujOTH7x
        z3QunHpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47296)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q908Q-00071P-Pk; Tue, 13 Jun 2023 10:16:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q908M-0005u4-A9; Tue, 13 Jun 2023 10:16:14 +0100
Date:   Tue, 13 Jun 2023 10:16:14 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Qingfang Deng <dqfext@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v5] net: phy: add driver for MediaTek SoC
 built-in GE PHYs
Message-ID: <ZIgz3kDA3nmaRCc0@shell.armlinux.org.uk>
References: <ZIULuiQrdgV9cZbJ@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIULuiQrdgV9cZbJ@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 12:48:10AM +0100, Daniel Golle wrote:
> Some of MediaTek's Filogic SoCs come with built-in gigabit Ethernet
> PHYs which require calibration data from the SoC's efuse.
> Despite the similar design the driver doesn't share any code with the
> existing mediatek-ge.c.
> Add support for such PHYs by introducing a new driver with basic
> support for MediaTek SoCs MT7981 and MT7988 built-in 1GE PHYs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Hi Daniel,

It looks like your series wasn't threaded to this message. I assume
that was a mistake?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
