Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165C70DCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjEWMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEWMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:47:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED2FF;
        Tue, 23 May 2023 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7Z5/Y4r+BnXvM9EvnVMv2yccz262/5dSGN6oq/NUoxE=; b=NszfJ/oaMuYP47fUZKY/NBRRg2
        9sUgmfsPvhMGkwlaWmT/k/w5e/lr1GyMQIL+V7Ml2NQ8ZmJnip2iECh7rUBZVT8HYBozK+x6p3tV0
        +3ck2QLhLV0xIdzcHzs746qdHqC3r7mz4aETh5mgB5JMSHF6VGJ0RmTx1qhHMM/wbrEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1RQL-00Dgbo-LT; Tue, 23 May 2023 14:47:33 +0200
Date:   Tue, 23 May 2023 14:47:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: Remove redundant checking for
 rx_coalesce_usecs
Message-ID: <436aced8-f7c4-4ecb-96f9-25ab707e95af@lunn.ch>
References: <20230523061952.204537-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523061952.204537-1-yi.fang.gan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:19:52AM -0400, Gan Yi Fang wrote:
> The datatype of rx_coalesce_usecs is u32, always larger or equal to zero.
> Previous checking does not include value 0, this patch removes the
> checking to handle the value 0.
> 
> Signed-off-by: Gan Yi Fang <yi.fang.gan@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 35c8dd92d369..6ed0e683b5e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -917,7 +917,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  	else if (queue >= max_cnt)
>  		return -EINVAL;
>  
> -	if (priv->use_riwt && (ec->rx_coalesce_usecs > 0)) {
> +	if (priv->use_riwt) {
>  		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
>  
>  		if ((rx_riwt > MAX_DMA_RIWT) || (rx_riwt < MIN_DMA_RIWT))

This appears to be a user visible ABI change. For the current code, a
value of zero here is ignored, and 0 is returned. With this change, 0
will result in rx_riwt being calculated as 0, which is less than
MIN_DMA_RIWT, so you get -EINVAL returned.

I don't know this uAPI too well. What values are passed to this
function for:

ethtool -C eth24 tx-usecs 42

where you only want to change transmit coalesce? Is rx_usecs 0?

At minimum you need to explain in the commit message: "This change in
behaviour making the value of 0 cause an error is not a problem
because...."

    Andrew

---
pw-bot: cr
