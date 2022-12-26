Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0386563CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiLZPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLZPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:19:33 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A251260ED;
        Mon, 26 Dec 2022 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=CJ0s4RC8ixikC2btIIdHDJkIJhgIxIMo2x6A5xpALMk=; b=5Y2X3l4ayBSYhKB92xci3QHhza
        3+rZitQO+VAVq7GdeQsfaKzvkXLi3YAd5W/LiKV+lsp1KUfeDV6auyENA1c0Dn9bJ3HvJHZsNevHg
        Gedc5W2EBEAPzoAp15tYOHjSOeFhzkiTzreplDFmPnrLOA8oLtfIpitn+TeH3i8UnUCM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1p9pG4-000VyF-Uc; Mon, 26 Dec 2022 16:19:20 +0100
Date:   Mon, 26 Dec 2022 16:19:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang =?utf-8?B?KOm7hOW9qik=?= <Biao.Huang@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Message-ID: <Y6m7eNdWVL3IKFj2@lunn.ch>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
 <20221223015029.24978-2-biao.huang@mediatek.com>
 <Y6W4vwJHG+6PI8fd@lunn.ch>
 <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't want to restrict phy-mode to rgmii-id only, so I don't think
> we need mask RXID bit, then, User can use rgmii-rxid/-txid/-id as their
> will.

The phy-mode is a property of the board. It describes what delays are
required, in addition to what the board itself provides via extra long
lines. As such, there is no choice, it is set by physics.

How you implement those delays is then up to the MAC and PHY. 95% of
all MAC drivers simply pass phy-mode to the PHY and let the PHY add
the delays. The Renesas MAC driver is one of the exceptions, it often
adds the delays, and then passes a different phy-mode to the PHY in
order that there are not double delays.

So you can be different to everybody else, have MAC do one delay, and
the PHY do the other. Just be aware that nobody else does this, no DT
developers will expect it, etc.

Or you can just do what everybody else does and let the PHY add the
delays.

What some MACs do is implement rx-internal-delay-ps and
tx-internal-delay-ps These allow fine tuning of the delays. These are
expected to be small values, adding 10s or 100s of pico seconds. They
are not expected to be 2000ps.

    Andrew
