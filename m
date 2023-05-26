Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF7711E92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjEZDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjEZDy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0012F;
        Thu, 25 May 2023 20:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E2564C97;
        Fri, 26 May 2023 03:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F786C433EF;
        Fri, 26 May 2023 03:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685073296;
        bh=BHY/pfIw2hUuaTnVESEiRxkn2QmMt7VyZTxiw2ST2/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jo9QPA6rqq5KvmK2DyY2+wTV9OlRByScL9JF5u8QW4rzmCAD4VQJcrWWfwJUvaWdm
         bYKtT0u9TYP1uKYIOB1ujIiE/a3eYHYMmFOB9WALy4cqxNsbERAzE28Flrsfv16jjO
         /zAE2nBsXCa/QvVQEp+Zo4S5cAGiHzZE1B38Tl2os8CMZpYUBxH4ITmFk9iIE6188W
         dJ2YXTGIwV5kzov+ja1FldTeR6eG4aAVXdqdiGPmlPfUBjniwEO//sHB9xUqdSkY2y
         6s2sK1klCz3dbbXJOpSXvFvpAqByGjsp8L1yTqb/hzkAu6OOXDNyGtCcS9igSBWH7M
         p2/yarnzgRwGg==
Date:   Thu, 25 May 2023 20:54:54 -0700
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
Subject: Re: [PATCH net-next v5 3/6] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230525205454.1c766852@kernel.org>
In-Reply-To: <1684969313-35503-4-git-send-email-justin.chen@broadcom.com>
References: <1684969313-35503-1-git-send-email-justin.chen@broadcom.com>
        <1684969313-35503-4-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 16:01:50 -0700 Justin Chen wrote:
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165. This controller features two distinct Ethernet
> ports that can be independently operated.
> 
> This patch supports:
> 
> - Wake-on-LAN using magic packets
> - basic ethtool operations (link, counters, message level)
> - MAC destination address filtering (promiscuous, ALL_MULTI, etc.)

> +static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct bcmasp_intf *intf = netdev_priv(dev);
> +	int spb_index, nr_frags, ret, i, j;
> +	unsigned int total_bytes, size;
> +	struct bcmasp_tx_cb *txcb;
> +	dma_addr_t mapping, valid;
> +	struct bcmasp_desc *desc;
> +	bool csum_hw = false;
> +	struct device *kdev;
> +	skb_frag_t *frag;
> +
> +	kdev = &intf->parent->pdev->dev;
> +
> +	spin_lock(&intf->tx_lock);

What is the tx_lock for? netdevs already have a tx lock, unless you
declare the device as lockless.

> +static void bcmasp_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct bcmasp_intf *intf = netdev_priv(dev);
> +
> +	netif_dbg(intf, tx_err, dev, "transmit timeout!\n");
> +
> +	netif_trans_update(dev);
> +	dev->stats.tx_errors++;
> +
> +	netif_wake_queue(dev);

If the queue is full xmit will just put it back to sleep.
You want to try to reap completions if anything, no?

> +static struct net_device_stats *bcmasp_get_stats(struct net_device *dev)
> +{
> +	return &dev->stats;
> +}

you don't have to do this, core will use device stats if there's no ndo

> +	ndev = alloc_etherdev(sizeof(struct bcmasp_intf));
> +	if (!dev) {

*blink* condition is typo'ed

> +		dev_warn(dev, "%s: unable to alloc ndev\n", ndev_dn->name);
> +		goto err;
> +	}

-- 
pw-bot: cr
