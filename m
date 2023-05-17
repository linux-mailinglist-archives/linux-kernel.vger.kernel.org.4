Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE7706830
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjEQMci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjEQMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:32:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456F10DA;
        Wed, 17 May 2023 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=d9Jyhk81zn7WltFy5aQXb+UcMGaz+x/ng/IdaUhmVLs=; b=ZhPWGvqOzM8ULB/L4Cl8lFdgzs
        6cdLPiVigOP3Z5UQa4kwgLMwInf2GiCiBKnZOHOKDYNrJDan2Tj2l5LjGLMnnR2fpGaT9B37rjSTv
        WACOhbywCgCEyneTr2aGA4+vUkUh8MSry8fwMPOEfwRQitRvNvYIi2o2qgUfPIGr1GFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pzGKH-00D8MZ-Un; Wed, 17 May 2023 14:32:17 +0200
Date:   Wed, 17 May 2023 14:32:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <doug.berger@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: broadcom: Register dummy IRQ handler
Message-ID: <e6817987-f788-4567-8406-c257f3b81caf@lunn.ch>
References: <20230516225640.2858994-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516225640.2858994-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:56:39PM -0700, Florian Fainelli wrote:
> From: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> In order to have our interrupt descriptor fully setup, and in particular
> the action, ensure that we register a full fledged interrupt handler.
> This is in particular necessary for the kernel to properly manage early
> wake-up scenarios and arm the wake-up interrupt, otherwise there would
> be risks of missing the interrupt and leaving it in a state where it
> would not be handled correctly at all, including for wake-up purposes.

Hi Florian

I've not seen any other driver do this. Maybe that is just my
ignorance.

Please could you Cc: the interrupt and power management
Maintainers. This seems like a generic problem, and should have a
generic solution.

In the setup which needs this, does the output from the PHY go to a
PMIC, not a SoC interrupt? And i assume the PMIC is not interrupt
capable?

	Andrew
