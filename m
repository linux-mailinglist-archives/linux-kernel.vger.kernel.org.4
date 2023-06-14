Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0727308D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFNTxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjFNTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B172122
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B32FE63784
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1596C433C9;
        Wed, 14 Jun 2023 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686772386;
        bh=gyq+c814bbzkOBJezTg1pBWbrnl02FG9KGt6qi2fNzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X01sa44NvfCG0AwAz9IdGtFQzaUMki98jIzLBjIp1GDNrjH3mfoaNT9xmmekaIBcz
         fma0mPkFrHQbekgIpAmG/URzPThk/RMXdVIaJXS2MVoKd9Da4YlhZmlRb0OjQYnawZ
         4VIah7XFAcspy5y3HXz9Pv77QeQkdINofN7pEIiRRiESlhdKSdt9O2xdosODXlPGlN
         zLi1NCHYNgDdnzep/WLBWcHJzCAxAINaAPkbjb1kl9vIF5U3lrUfmC5yUN8F4a2+rN
         btbayFQfXecU8k6hwroNI4BaZCQt1QifmBWY1DA/Q5r9hKsBdCFKe7M/zpfwnqE4nt
         hBNOZLml+l/dg==
Date:   Wed, 14 Jun 2023 12:53:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     vburru@marvell.com, aayarekar@marvell.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, sburla@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeon_ep: Add missing check for ioremap
Message-ID: <20230614125304.294dd2ef@kernel.org>
In-Reply-To: <20230614032347.32940-1-jiasheng@iscas.ac.cn>
References: <20230614032347.32940-1-jiasheng@iscas.ac.cn>
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

On Wed, 14 Jun 2023 11:23:47 +0800 Jiasheng Jiang wrote:
> @@ -981,6 +981,9 @@ int octep_device_setup(struct octep_device *oct)
>  		oct->mmio[i].hw_addr =
>  			ioremap(pci_resource_start(oct->pdev, i * 2),
>  				pci_resource_len(oct->pdev, i * 2));
> +		if (!oct->mmio[i].hw_addr)
> +			goto unsupported_dev;
> +
>  		oct->mmio[i].mapped = 1;
>  	}
>  
> @@ -1015,8 +1018,8 @@ int octep_device_setup(struct octep_device *oct)
>  	return 0;
>  
>  unsupported_dev:
> -	for (i = 0; i < OCTEP_MMIO_REGIONS; i++)
> -		iounmap(oct->mmio[i].hw_addr);
> +	for (j = 0; j < i; j++)
> +		iounmap(oct->mmio[j].hw_addr);

Assuming @i is not changed by the rest of the function is a bit fragile.

Better way of handling this situation is:

unsupported_dev:
	i = OCTEP_MMIO_REGIONS;
unmap_prev:
	while (i--)
		iounmap(oct->mmio[i].hw_addr);

and jump to unmap_prev
-- 
pw-bot: cr
