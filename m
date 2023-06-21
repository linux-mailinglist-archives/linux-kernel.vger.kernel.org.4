Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743B1737975
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFUDDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98EDE68;
        Tue, 20 Jun 2023 20:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A2E6145D;
        Wed, 21 Jun 2023 03:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03ACC433C8;
        Wed, 21 Jun 2023 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687316588;
        bh=w2ndax/dIn8hHqRy2GYj3R5SQpIQobIRN1xdBilDOAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ulEKOqncD0TzcZAJbJ/bKEu3UGhtRJ68LnvzU2rdEgAlY4m2qNoaukYimvt50gHTL
         mR9TVB/BQ1gQwEITI57SurXEBr+om25sVGUA5lDNZxM5BUezSNGWOhR1lsaKCFiXBb
         PrSZsFQ852f+SitMqZ5GqufLr6KTa6SPGUIze1w4FqWNeNQubVC9S731GYSTIlzu0p
         mZNgRmCpom3RU42zpSaSk880Fx9isrnlM8jPvO4NkEApP06FjkowmrStJoXq2LUUGd
         1Wn9tp7cn2Smqi9wTcknL8yOytiUNYz5yr/oi7ivAbsVyGp3SAW+fWbm7CbN1zZHSm
         bM+7GXzA9YHAQ==
Date:   Tue, 20 Jun 2023 20:03:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        simon.horman@corigine.com
Subject: Re: [PATCH net-next v8 03/11] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230620200306.48781299@kernel.org>
In-Reply-To: <1686953664-17498-4-git-send-email-justin.chen@broadcom.com>
References: <1686953664-17498-1-git-send-email-justin.chen@broadcom.com>
        <1686953664-17498-4-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 15:14:16 -0700 Justin Chen wrote:
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165. This controller features two distinct Ethernet
> ports that can be independently operated.

First of all - thanks for splitting the patches up.
This one is still a bit big but much better and good enough.

> +	/* Probe each interface (Initialization should continue even if
> +	 * interfaces are unable to come up)
> +	 */
> +	i = 0;
> +	for_each_available_child_of_node(ports_node, intf_node) {
> +		priv->intfs[i] = bcmasp_interface_create(priv, intf_node, i);
> +		i++;
> +	}
> +
> +	/* Drop the clock reference count now and let ndo_open()/ndo_close()
> +	 * manage it for us from now on.
> +	 */
> +	bcmasp_core_clock_set(priv, 0, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	/* Now do the registration of the network ports which will take care
> +	 * of managing the clock properly.
> +	 */
> +	for (i = 0; i < priv->intf_count; i++) {
> +		intf = priv->intfs[i];
> +		if (!intf)
> +			continue;
> +
> +		ret = register_netdev(intf->ndev);
> +		if (ret) {
> +			netdev_err(intf->ndev,
> +				   "failed to register net_device: %d\n", ret);
> +			bcmasp_interface_destroy(intf, false);
> +			continue;

Did you mean to clear the priv->intfs[i] pointer after destroy?
Otherwise remove will try to free it again.

> +		}
> +		count++;
> +	}
> +
> +	dev_info(dev, "Initialized %d port(s)\n", count);
> +
> +of_put_exit:
> +	of_node_put(ports_node);
> +	return ret;

And in case the last register_netdev() fails .probe will return an
error, meaning that .remove will never get called.

Why are you trying to gracefully handle the case where only some ports
were registered? It's error prone, why not fail probe if any netdev
fails to register?

> +}
> +
> +static int bcmasp_remove(struct platform_device *pdev)
> +{
> +	struct bcmasp_priv *priv = dev_get_drvdata(&pdev->dev);
> +	struct bcmasp_intf *intf;
> +	int i;
> +

since .shutdown is defined this callback should probably clear the priv
pointer and check whether priv != NULL before proceeding. It's a bit
unclear whether both .remove and .shutdown may get called for the same
device..

> +	for (i = 0; i < priv->intf_count; i++) {
> +		intf = priv->intfs[i];
> +		if (!intf)
> +			continue;
> +
> +		bcmasp_interface_destroy(intf, true);
> +	}
> +
> +	return 0;
> +}

> +MODULE_AUTHOR("Broadcom");

Companies cannot be authors. MODULE_AUTHOR() is not required,
you can drop it if you don't want to put your name there.

> +	if (unlikely(skb_headroom(skb) < sizeof(*offload))) {
> +		new_skb = skb_realloc_headroom(skb, sizeof(*offload));

That's not right, you can't push to an tx skb just because there's
headroom. Use skb_cow_head().

> +	if (tx_spb_ring_full(intf, nr_frags + 1)) {
> +		netif_stop_queue(dev);
> +		netdev_err(dev, "Tx Ring Full!\n");

rate limit this one, please

> +		/* Calculate virt addr by offsetting from physical addr */
> +		data = intf->rx_ring_cpu +
> +			(DESC_ADDR(desc->buf) - intf->rx_ring_dma);
> +
> +		flags = DESC_FLAGS(desc->buf);
> +		if (unlikely(flags & (DESC_CRC_ERR | DESC_RX_SYM_ERR))) {
> +			netif_err(intf, rx_status, intf->ndev, "flags=0x%llx\n",
> +				  flags);

ditto

> +			u64_stats_update_begin(&stats->syncp);
> +			if (flags & DESC_CRC_ERR)
> +				u64_stats_inc(&stats->rx_crc_errs);
> +			if (flags & DESC_RX_SYM_ERR)
> +				u64_stats_inc(&stats->rx_sym_errs);
> +			u64_stats_inc(&stats->rx_dropped);

Not right, please see the documentation on struct rtnl_link_stats64
These are errors not drops. Please read that comment and double
check all your stats.

> +			u64_stats_update_end(&stats->syncp);
> +
> +			goto next;
> +		}
> +
> +		dma_sync_single_for_cpu(kdev, DESC_ADDR(desc->buf), desc->size,
> +					DMA_FROM_DEVICE);
> +
> +		len = desc->size;
> +
> +		skb = __netdev_alloc_skb(intf->ndev, len,
> +					 GFP_ATOMIC | __GFP_NOWARN);

maybe napi_alloc_skb()? 

> +		if (!skb) {
> +			u64_stats_update_begin(&stats->syncp);
> +			u64_stats_inc(&stats->rx_errors);
> +			u64_stats_update_end(&stats->syncp);
> +
> +			netif_warn(intf, rx_err, intf->ndev,
> +				   "SKB alloc failed\n");

error counter is enough for allocations, OOMs are common

> +			goto next;
> +		}

-- 
pw-bot: cr
