Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03718735681
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFSMMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFSMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:12:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FEB12B;
        Mon, 19 Jun 2023 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6f1y6nCpHwghguAOpkCWrKEeehWxm0A0RNp77FEOBz0=; b=VCR4+zkBwMNGteNiO6NtrfbWsU
        rBePzOObN7wDT8UYw5bT7TESwYG8w5qK3SpV8KMXfuRSJ/Oo8PZJibLNuvSohQqI1vOeWPgkzaTR7
        hgqczFetSDX/qc4j3cdN8ReALT8PScmz+IBryE3P+qxfQj4YpbmE5mAePJwVbTQpt6m0g90pQXR8I
        vbwrAHIFyViGgt+UgOeV2/Dk7zeeJkV0bSNLlsCamfOpZb3sD243xeREzclcpZ7faiUY6LXV8Sp/5
        u7ZjKqpEf22TTuHWQnb7TLTvaGll+H0x0ViCYrXZrxYJ1XLfRvnEe7QW6ODoPiUeu343b6K/5qbGB
        zm9Fnr1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42216)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qBDkG-0008GZ-4t; Mon, 19 Jun 2023 13:12:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qBDkE-0005cw-Um; Mon, 19 Jun 2023 13:12:30 +0100
Date:   Mon, 19 Jun 2023 13:12:30 +0100
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
Subject: Re: [PATCH net v6 3/6] net: dsa: mt7530: fix handling of BPDUs on
 MT7530 switch
Message-ID: <ZJBGLhCP+jLE1L7D@shell.armlinux.org.uk>
References: <20230617062649.28444-1-arinc.unal@arinc9.com>
 <20230617062649.28444-4-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617062649.28444-4-arinc.unal@arinc9.com>
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

On Sat, Jun 17, 2023 at 09:26:46AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> BPDUs are link-local frames, therefore they must be trapped to the CPU
> port. Currently, the MT7530 switch treats BPDUs as regular multicast
> frames, therefore flooding them to user ports. To fix this, set BPDUs to be
> trapped to the CPU port. Group this on mt7530_setup() and
> mt7531_setup_common() into mt753x_trap_frames() and call that.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

> +static void
> +mt753x_trap_frames(struct mt7530_priv *priv)

The only niggle is that it's not necessary to split this line, but as
other functions do this, it's better to follow the already established
convention in the file.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
