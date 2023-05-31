Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B27180C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjEaM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjEaM5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:57:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A3E47;
        Wed, 31 May 2023 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9a9sWcV3B1HupudEIN770V6gR2bhvM4pEaGkOVzI7Dg=; b=6Qf3UDOaSEL6pVq3e6HbaJSGSo
        eoeenu6PzU7F7oFw2BgTfA9SxiECFR+nEK5Aflf4i3R5rqyaJtjkmUD/qjQ2xQjblcsYqRVRSFOWG
        ifxktaLOrzhVsYlGkyNaBt1eb8Y4x70wdvcYNNWDSnkDLtAM/+fYsm7uLB4r4s67Opms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q4LNM-00ESZe-Ov; Wed, 31 May 2023 14:56:28 +0200
Date:   Wed, 31 May 2023 14:56:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <1a3342eb-5a0f-486d-90af-4e052760cf7b@lunn.ch>
References: <20230530122621.2142192-1-lukma@denx.de>
 <ZHXzTBOtlPKqNfLw@shell.armlinux.org.uk>
 <20230530160743.2c93a388@wsk>
 <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
 <35546c34-17a6-4295-b263-3f2a97d53b94@lunn.ch>
 <20230530164731.0b711649@wsk>
 <ZHYRgIb6UCYq1n/Z@shell.armlinux.org.uk>
 <20230531104346.2a131c42@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531104346.2a131c42@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the detailed explanation.
> 
> With "switch" setup - where I do have MAC from imx8 (fec driver)
> connected to e.g. mv88e6071 with "fixed-link", I do guess that the EEE
> management is done solely in mv88e6071?

So you have the MAC-MAC connection? No back to back PHYs in the
middle. If there is no PHY, linux will not do anything with EEE. What
happens will depend on the reset defaults of the switch. For the FEC
phy_eee_init() will return false, so i expect EEE is disabled.

> In other words - the mv88e6071 solely decides if its internal PHY shall
> signal EEE to the peer switch.

Handling EEE in the mv88e6xxx driver is something on my todo list. But
i don't expect it to happen soon. And before it will happen we
actually need to decide how the user API should work.

	Andrew
