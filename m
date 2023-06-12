Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0772D322
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjFLVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFLVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:19:20 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17376A2;
        Mon, 12 Jun 2023 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZxDF9F4x7jVIAzdXDxOtWORHWaoYjUMazfvuiYN7/gI=; b=inYxaGKzfXxignIu5Z+sYL3wcj
        muhuh5c76lRw4qiPw+/irJLYdZ0rs/oWAxa6NZqNYM2kSKl0Mnp9boUZJP8SRRGcAfRlEdycFMZLL
        jFPBUcyVPcXo1XPv07qu4LRQMO0PtECfzKyzj7mY3xqVGB4+a6MKvu01VlB0TeWxnXp/MdAUvd2fr
        4p7d4DeIemQZC9qC+nbHTNRabXhgJfUXpbpE9dsVHYPJscgMxPm7AMLw/r9LKv13YJUfYGrHQS1L+
        cQP6v8gL408aNquNq3J7C0NXbaXUd9H/hDXv/WBQ0vHrfQygnMLCZgnpFtzrOHWKJ0NxEFH3HcYFI
        ceBaTXLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51444)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q8onM-0006Oh-OJ; Mon, 12 Jun 2023 22:09:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q8onJ-0005K9-14; Mon, 12 Jun 2023 22:09:45 +0100
Date:   Mon, 12 Jun 2023 22:09:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     arinc9.unal@gmail.com
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4 2/7] net: dsa: mt7530: fix trapping frames with
 multiple CPU ports on MT7530
Message-ID: <ZIeJmF2eVi5nCLIU@shell.armlinux.org.uk>
References: <20230612075945.16330-1-arinc.unal@arinc9.com>
 <20230612075945.16330-3-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612075945.16330-3-arinc.unal@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:59:40AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The CPU_PORT bits represent the CPU port to trap frames to for the MT7530
> switch. This switch traps frames received from a user port to the CPU port
> set on the CPU_PORT bits, regardless of the affinity of the user port from
> which the frames are received.

I think:

"On the MT7530, the CPU_PORT() field indicates which CPU port to trap
frames to, regardless of the affinity of the inbound user port."

covers everything necessary in the first paragraph? Sorry to be a pain
about this, but commit logs should be understandable.

> When multiple CPU ports are being used, the trapped frames won't be
> received when the DSA conduit interface, which the frames are supposed to
> be trapped to, is down because it's not affine to any user port. This
> requires the DSA conduit interface to be manually set up for the trapped
> frames to be received.

"When multiple CPU ports are in use, if the DSA conduit interface is
down, trapped frames won't be passed to the conduit interface."

> To fix this, implement ds->ops->master_state_change() on this subdriver and
> set the CPU_PORT bits to the CPU port which the DSA conduit interface its

... "to the first CPU port" - isn't that what the code is doing with
__ffs(priv->active_cpu_ports)? You're giving priority to the lowest
numbered port, and I think that should be stated in the commit message.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
