Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02F70C242
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjEVPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjEVPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:22:37 -0400
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85E139;
        Mon, 22 May 2023 08:22:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id 778D920619;
        Mon, 22 May 2023 17:22:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8pDyng2re-HT; Mon, 22 May 2023 17:22:27 +0200 (CEST)
Received: from nucnuc.mle (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id EBF67202D0;
        Mon, 22 May 2023 17:22:26 +0200 (CEST)
Date:   Mon, 22 May 2023 17:22:21 +0200
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: phy: mscc: enable VSC8501/2 RGMII RX clock
Message-ID: <20230522152221.GA21090@nucnuc.mle>
References: <20230520160603.32458-1-david.epping@missinglinkelectronics.com>
 <20230520160603.32458-4-david.epping@missinglinkelectronics.com>
 <20230521134356.ar3itavhdypnvasc@skbuf>
 <20230521161650.GC2208@nucnuc.mle>
 <20230522095833.otk2nv24plmvarpt@skbuf>
 <20230522140057.GB18381@nucnuc.mle>
 <20230522151104.clf3lmsqdndihsvo@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522151104.clf3lmsqdndihsvo@skbuf>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 06:11:04PM +0300, Vladimir Oltean wrote:
> On Mon, May 22, 2023 at 04:00:57PM +0200, David Epping wrote:
> > Since the clock enablement now happens in all modes the existing rgmii
> > function name seems misleading to me.
> 
> To be fair, it's only as misleading as the datasheet name for the register
> that holds this field, "RGMII CONTROL". Anyway, the function could be
> renamed as necessary to be less confusing: vsc85xx_update_rgmii_ctrl()
> or something along those lines.
> 
> MDIO reads and writes are not exactly the quickest I/O in the world, and
> having 2 read-modify-write consecutive accesses to the same paged
> register (which in turn implies indirect access) just because readability
> seems like the type of thing that can play its part in deteriorating
> boot time latency. Maybe we can deal with the readability some other way.

You are right. It's an easy job for the CPU and saves time for
hardware access. I'll prepare and send a new patch set.

> > Also we don't want to enable for
> > all PHY types, and the differentiation is already available at the
> > caller. I would thus opt for a separate function and fewer conditional
> > statements.
> 
> I don't understand this. We don't? For what PHY types don't we want to
> enable the RX_CLK?

I meant all PHYs using vsc85xx_rgmii_set_skews() via vsc8584_config_init().
As you pointed out they don't have a clear definition of what bit 11 means
for them.
But we can easily differentiate using the condition you suggested.
I'll do that for the new patch version.
