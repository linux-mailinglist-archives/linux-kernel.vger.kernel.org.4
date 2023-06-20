Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D319F73751E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFTTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFTTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:33:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B51704;
        Tue, 20 Jun 2023 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fo/Ob0KLpIGN+a/RSOJyxjLCvbABz+sPt5T9bSGSNJs=; b=zkcJHK3bVcB6Jmw9PV+rGTplAy
        66NnVtWzwKQZgvVe6VGDg16mALXivovFcINYRPTd5sSWcgLeVsFCtvtuw6uFh2chLVqhBE80Tve/2
        aRLYSk8DzPVACiNLJdGl4UIho6psg974vtqDiwd2zRg8ebA/d+3vUwaEY2EcYg0H51Qc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBh6K-00H3Fu-6T; Tue, 20 Jun 2023 21:33:16 +0200
Date:   Tue, 20 Jun 2023 21:33:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net: phy: dp83td510: fix kernel stall during
 netboot in DP83TD510E PHY driver
Message-ID: <f2772f0f-31a4-41ba-b1ea-bfe3e5bdc87f@lunn.ch>
References: <20230620125505.2402497-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620125505.2402497-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:55:05PM +0200, Oleksij Rempel wrote:
> Fix an issue where the kernel would stall during netboot, showing the
> "sched: RT throttling activated" message. This stall was triggered by
> the behavior of the mii_interrupt bit (Bit 7 - DP83TD510E_STS_MII_INT)
> in the DP83TD510E's PHY_STS Register (Address = 0x10). The DP83TD510E
> datasheet (2020) states that the bit clears on write, however, in
> practice, the bit clears on read.
> 
> This discrepancy had significant implications on the driver's interrupt
> handling. The PHY_STS Register was used by handle_interrupt() to check
> for pending interrupts and by read_status() to get the current link
> status. The call to read_status() was unintentionally clearing the
> mii_interrupt status bit without deasserting the IRQ pin, causing
> handle_interrupt() to miss other pending interrupts. This issue was most
> apparent during netboot.
> 
> The fix refrains from using the PHY_STS Register for interrupt handling.
> Instead, we now solely rely on the INTERRUPT_REG_1 Register (Address =
> 0x12) and INTERRUPT_REG_2 Register (Address = 0x13) for this purpose.
> These registers directly influence the IRQ pin state and are latched
> high until read.
> 
> Note: The INTERRUPT_REG_2 Register (Address = 0x13) exists and can also
> be used for interrupt handling, specifically for "Aneg page received
> interrupt" and "Polarity change interrupt". However, these features are
> currently not supported by this driver.
> 
> Fixes: 165cd04fe253 ("net: phy: dp83td510: Add support for the DP83TD510 Ethernet PHY")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

It would be good to add a Cc: <stable@vger.kernel.org>. It will
probably get back ported with it, but the process does require it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
