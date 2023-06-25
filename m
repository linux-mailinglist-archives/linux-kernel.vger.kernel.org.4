Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5F73D19B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFYPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFYPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:07:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39B1B3;
        Sun, 25 Jun 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=NKphG9SWcrxgT1kw/gYGZAGNyI3tPHGIuMcUY7Z5Mew=; b=pUQCPjRNKv4ZwyvVvowmON9yY1
        zfLgxbVkwc5Qb8siUCaLVlZDeGyluxUWcaCKMC6u7m8F+cBgB3bB/pNXXEn74rFEVCBXceydvGT29
        QUv3ga6E7CSbAjk0gNs/VKCLILH8cCbusTq47h/QTXZC3dklWCRIDATvZwwfSuDcdgxk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qDRL2-00HUMe-1m; Sun, 25 Jun 2023 17:07:40 +0200
Date:   Sun, 25 Jun 2023 17:07:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] net: dsa: vsc73xx: use read_poll_timeout
 instead delay loop
Message-ID: <3ed4c6dd-b065-4d1b-9686-1bc2df63f17e@lunn.ch>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-1-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:53:36PM +0200, Pawel Dembicki wrote:
> This commit switches delay loop to read_poll_timeout macro durring
> Arbiter empty check in adjust link function.
> 
> As Russel King suggested:
> 
> "This [change] avoids the issue that on the last iteration, the code reads
> the register, test it, find the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
> 
> It also remove one short msleep delay.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
