Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D192D72B264
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjFKPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFKPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:12:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9B1BB;
        Sun, 11 Jun 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PyrIx0p+IhToMWTXfEMw7KbXRMDA1MJkBZI7jOF9FTs=; b=fOa6/OBaiaAriv0ukzmkf7klKy
        u2Jq4SvvBGebSiOJ6kZjZWUMcwjoIWqfn15H46y0nnJEHIMb5RN49qgEvBl7/dB73Wt4PbNc850q4
        u7qPBIgpQbvFD0DxuBqdkF5k/WvVi3pTRjZ9eHzNgjUFM+nJMpHrsqVyxK+/oucGjEAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8MjW-00FVhc-QG; Sun, 11 Jun 2023 17:11:58 +0200
Date:   Sun, 11 Jun 2023 17:11:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: mdio: fix duplicate registrations for phy with c45
 in __of_mdiobus_register()
Message-ID: <c7ca97c3-720b-494c-9865-b77252954a04@lunn.ch>
References: <20230610161308.3158-1-zhaojh329@gmail.com>
 <20230611145728.655524-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611145728.655524-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 10:57:28PM +0800, Jianhui Zhao wrote:
> Sorry, I misread the code.

So this is by code inspection, not an actual device tree booting on a
board?

What should happen is that __of_mdiobus_register() has:

	/* Mask out all PHYs from auto probing.  Instead the PHYs listed in
	 * the device tree are populated after the bus has been registered */
	mdio->phy_mask = ~0;

So when

	rc = __mdiobus_register(mdio, owner);

is called, no scanning happens. I _guess_ that is what you missed?

   Andrew

-- 
pw-bot: reject
