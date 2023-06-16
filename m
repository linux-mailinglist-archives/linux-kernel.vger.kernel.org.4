Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7077326B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjFPFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFPFhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D72976
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4021661D9C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5427C433C0;
        Fri, 16 Jun 2023 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686893858;
        bh=iyblhOXf+gZeVRqwoZ1cYwv2FEYhn8/Qs7mY7WB/BNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHO8LSkPvoF87hWEWNI0ZsoCXHuP2VisPRCgyzgOpVdxSTjo8eoIZxm4NP1UnX3/M
         PdhQaoMrStEOm+jbTwKX9nKWNm8Q217Y7GtbuCTtMcEo5fFzGnKY9LnW2wcdOf5lTZ
         zFHKSOmVxEy1tDnUkbo422CrHujlZLkAMzqFjxujEgjxJmdFMLSPhEtMwgNUnI584v
         SUq15DxAz0UHjDAm1WVAqZR99Q8G8PKzZ7r6nlJ/Lh1oeUsbTY2M6GaMfIoWmaNlC7
         XmjbI9n5QLF8EOyiNM4Fw3BQs6NMDlZqZXqbrvWhqLSP2fE6m4f9/f57uOoh99vHIK
         cpf1gAR/PZEqA==
Date:   Thu, 15 Jun 2023 22:37:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <bigeasy@linutronix.de>, <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>
Subject: Re: [PATCH v2 net-next] net: hsr: Disable promiscuous mode in
 offload mode
Message-ID: <20230615223736.0577fb11@kernel.org>
In-Reply-To: <20230614114710.31400-1-r-gunasekaran@ti.com>
References: <20230614114710.31400-1-r-gunasekaran@ti.com>
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

On Wed, 14 Jun 2023 17:17:10 +0530 Ravi Gunasekaran wrote:
> When port-to-port forwarding for interfaces in HSR node is enabled,
> disable promiscuous mode since L2 frame forward happens at the
> offloaded hardware.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Bridge folks any thoughts on this? Is this the behavior bridge has 
and if not should we try to align the two?

> Changes from v1:
> ===============
> * Changed the data type of "fwd_offloaded" from "unsigned int" to "bool"
>   and moved it below "net_id" struct member as per Paolo's comment.
> * Collected Reviewed-by tag from v1 patch.
> 
> v1: https://lore.kernel.org/all/20230612093933.13267-1-r-gunasekaran@ti.com/
> 
>  net/hsr/hsr_device.c |  5 +++++
>  net/hsr/hsr_main.h   |  1 +
>  net/hsr/hsr_slave.c  | 15 +++++++++++----
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5a236aae2366..306f942c3b28 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -531,6 +531,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	if (res)
>  		goto err_add_master;
>  
> +	/* HSR forwarding offload supported in lower device? */
> +	if ((slave[0]->features & NETIF_F_HW_HSR_FWD) &&
> +	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
> +		hsr->fwd_offloaded = true;
> +
>  	res = register_netdevice(hsr_dev);
>  	if (res)
>  		goto err_unregister;
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 5584c80a5c79..6851e33df7d1 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -208,6 +208,7 @@ struct hsr_priv {
>  	u8 net_id;		/* for PRP, it occupies most significant 3 bits
>  				 * of lan_id
>  				 */
> +	bool fwd_offloaded;	/* Forwarding offloaded to HW */
>  	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
>  				/* Align to u16 boundary to avoid unaligned access
>  				 * in ether_addr_equal
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index b70e6bbf6021..e5742f2a2d52 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -131,9 +131,14 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  	struct hsr_port *master;
>  	int res;
>  
> -	res = dev_set_promiscuity(dev, 1);
> -	if (res)
> -		return res;
> +	/* Don't use promiscuous mode for offload since L2 frame forward
> +	 * happens at the offloaded hardware.
> +	 */
> +	if (!port->hsr->fwd_offloaded) {
> +		res = dev_set_promiscuity(dev, 1);
> +		if (res)
> +			return res;
> +	}
>  
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>  	hsr_dev = master->dev;
> @@ -152,7 +157,9 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  fail_rx_handler:
>  	netdev_upper_dev_unlink(dev, hsr_dev);
>  fail_upper_dev_link:
> -	dev_set_promiscuity(dev, -1);
> +	if (!port->hsr->fwd_offloaded)
> +		dev_set_promiscuity(dev, -1);
> +
>  	return res;
>  }
>  

