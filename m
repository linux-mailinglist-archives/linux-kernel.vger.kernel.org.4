Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B7744A83
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGAQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:21:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964A10DC;
        Sat,  1 Jul 2023 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9PVVUcb5RkwFUjMyrKy1zG2bSIkmM/JEyEAWV9cGkZ8=; b=tcEWTOzM+VUgGcLfG7qPNzcJgm
        aFwCefY9v4aGd6IpO37Sivc+M5B6+rIeayxeVKYHfhS7J/8aTrrwiCtl5Fl+kvJ14sIIE7stQ4VbL
        lo33g5f9u98sY8vpRKNmmUvBjihWBl98MavpYqksC7+mVodbn8lk7oLXuD2aCc+x2vMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFdLW-000NLQ-89; Sat, 01 Jul 2023 18:21:14 +0200
Date:   Sat, 1 Jul 2023 18:21:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Message-ID: <34ef466e-df95-4be4-8366-64baf5f04cca@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
 <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
 <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
 <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
 <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
 <d4043e1f-d683-48c2-af79-9fea14ab7cc1@lunn.ch>
 <49f8ca40-e079-ad00-256e-08a61ffced22@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f8ca40-e079-ad00-256e-08a61ffced22@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> it is the PLL related registers, there is no PHY ID existed in MII register
> 2, 3 of this block, so it can't be instantiated as the generic PHY device.

Well, phylib is going to scan those ID registers, and if it finds
something other than 0xffff 0xffff in those two ID registers it is
going to think a PHY is there. And then if there is no driver using
that ID, it will instantiate a generic PHY.

You might be able to see this in /sys/bus/mdio_bus, especially if you
don't have a DT node representing the MDIO bus.

      Andrew
