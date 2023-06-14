Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57745716AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjE3R3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjE3R3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:29:14 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DFC1B0;
        Tue, 30 May 2023 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=UPIzzM2XTXYlyeunj9pSiEJHYLW/0kBAsxfRPWFzyzA=; b=Zivuydhf0oPmZYxawFyEJu8cl5
        tEPnHcyj7vLPGLzHaug/7uX05H9M0iL1uLFLpLrobUIt8be/bWbYSYqspdbLaYncZubNunEuXCiNv
        5Fuud/fF1+k+AcNyoUM3pjIHwIHB8uOqIjoXTxD81FY9KfF0FsUYEvg4VNzR4YCM4l88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q438t-00EMVz-3z; Tue, 30 May 2023 19:28:19 +0200
Date:   Tue, 30 May 2023 19:28:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andreas Svensson <andreas.svensson@axis.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@axis.com,
        Baruch Siach <baruch@tkos.co.il>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Increase wait after reset
 deactivation
Message-ID: <be44dfe3-b4cb-4fd5-b4bd-23eec4bd401c@lunn.ch>
References: <20230530145223.1223993-1-andreas.svensson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530145223.1223993-1-andreas.svensson@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:52:23PM +0200, Andreas Svensson wrote:
> A switch held in reset by default needs to wait longer until we can
> reliably detect it.
> 
> An issue was observed when testing on the Marvell 88E6393X (Link Street).
> The driver failed to detect the switch on some upstarts. Increasing the
> wait time after reset deactivation solves this issue.
> 
> The updated wait time is now also the same as the wait time in the
> mv88e6xxx_hardware_reset function.

Do you have an EEPROM attached and content in it?

It is not necessarily the reset itself which is the problem, but how
long it takes after the reset to read the contents of the
EEPROM. While it is doing that, is does not respond on the MDIO
bus. Which is why mv88e6xxx_hardware_reset() polls for that to
complete.

I know there are some users who want the switch to boot as fast as
possible, and don't really want the additional 9ms delay. But this is
also a legitimate change. I'm just wondering if we need to consider a
DT property here for those with EEPROM content. Or, if there is an
interrupt line, wait for the EEPROM complete interrupt. We just have
tricky chicken and egg problems. At this point in time, we don't
actually know if the devices exists or not.

	  Andrew
