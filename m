Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45570F5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEXMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEXMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:08:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2304E135;
        Wed, 24 May 2023 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xf1YvtJ7TRchA12FbJ7TofxVs1riTDKRUCiMHm9yH28=; b=xS24z8dS5s7Ua2iR3VtLQF93c8
        j71ah6GyBTetUVcQwO45zu2qwTUwaEGbIzOItL5IYQ6tR87VzTlbvPKhxyKc42b4JQ4G7dklcStZA
        GNzmvB59EofcfOHEECAgLvbDWNrmqJrOMBmF6O9lmE5MvcZEz93BybB9aIoehPe0mmnt+MawTER1b
        migEtx3dlizUFK8N1ED5CAOMzxCsybAZM6wmy+J0ByvOgjeLeTwAcimaMX3I+qrO13mHrEoePam0a
        pMGZXRmVI+JGcJF52/ulfFDs+g8eEzz0uodnGalspgV+9Do67K7A5qbkk0jTrN/G+oM8GrmQGAPa5
        kdMbopRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59850)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q1nHw-0002FY-6v; Wed, 24 May 2023 13:08:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q1nHt-0001bK-76; Wed, 24 May 2023 13:08:17 +0100
Date:   Wed, 24 May 2023 13:08:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dsa: marvell: Define .set_max_frame_size()
 function for mv88e6250 SoC family
Message-ID: <ZG3+MT29vcRfmuC1@shell.armlinux.org.uk>
References: <20230523142912.2086985-1-lukma@denx.de>
 <20230523142912.2086985-2-lukma@denx.de>
 <ZGzRE48DchoclbBl@shell.armlinux.org.uk>
 <20230524140636.0cd31b13@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524140636.0cd31b13@wsk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:06:36PM +0200, Lukasz Majewski wrote:
> Hi Russell,
> 
> > Also, subject line should be "net: dsa: ..."
> > 
> 
> Ok, I will correct that subject line.

Also, please use "mv88e6xxx" rather than "marvell" - consistency in the
subject lines, particularly when referring to a part of the kernel tree
is desirable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
