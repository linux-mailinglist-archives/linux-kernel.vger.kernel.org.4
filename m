Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4298870EBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbjEXDnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjEXDnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12603A3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9665C63847
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43A7C433D2;
        Wed, 24 May 2023 03:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684899779;
        bh=sHktuW2u9EmSq6m2KSf3IW+LPmc96edkOkaUgK3ZTLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bOo00Mkk7saYNB+ACcUD6pVGGhPleNpZISm3iHHQLzUx7HIfL7oJrHnt9wO7jki2A
         J2hZ9hsPeiU2UkIflh4t81Qivx+yn8QDwuUtR+w15cNlIMNOlybj7ro/83sZ+osUzF
         HW4/r1k918VLr/dCBinajgPB/LG9oesubhP7wI1U+GGlN1iLqCBhy9vAnTL2vdgkog
         AlvRN7KDUlOj0N+HW3GC1LpIfpK0f13haCrMJww7ERpHMXJeOsYGQhbovpX0JBd0o5
         g4n1PBSrAMGgHdfc9GABp4ewsdDc1bhcX9GUg0V7/bpApMv6zaO8aPc087H8uWVKwQ
         99UzhyU/cDl1g==
Date:   Tue, 23 May 2023 20:42:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mellanox: mlxbf_gige: Fix skb_panic splat
 under memory pressure
Message-ID: <20230523204257.07d2512b@kernel.org>
In-Reply-To: <20230522190713.82417-1-tbogendoerfer@suse.de>
References: <20230522190713.82417-1-tbogendoerfer@suse.de>
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

On Mon, 22 May 2023 21:07:13 +0200 Thomas Bogendoerfer wrote:
> Do skp_put() after a new skb has been successfully allocated otherwise
> the reused skb leads to skp_panics or incorrect packet sizes.

s/skp/skb/

Please add a Fixes tag pointing at the patch which introduced 
the problem (could be the first commit adding this driver).

> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c    | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> index afa3b92a6905..2c132849a76d 100644
> --- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
> @@ -245,18 +245,19 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
>  
>  		skb = priv->rx_skb[rx_pi_rem];
>  
> -		skb_put(skb, datalen);
> -
> -		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
> -
> -		skb->protocol = eth_type_trans(skb, netdev);
> -
>  		/* Alloc another RX SKB for this same index */
>  		rx_skb = mlxbf_gige_alloc_skb(priv, MLXBF_GIGE_DEFAULT_BUF_SZ,
>  					      &rx_buf_dma, DMA_FROM_DEVICE);
>  		if (!rx_skb)
>  			return false;
>  		priv->rx_skb[rx_pi_rem] = rx_skb;
> +
> +		skb_put(skb, datalen);
> +
> +		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
> +
> +		skb->protocol = eth_type_trans(skb, netdev);
>
>  		dma_unmap_single(priv->dev, *rx_wqe_addr,
>  				 MLXBF_GIGE_DEFAULT_BUF_SZ, DMA_FROM_DEVICE);

You should move the code here, after the dma_unmap().
eth_type_trans() will access the payload and until dma_unmap
the data should not be accessed by the CPU.

>  		*rx_wqe_addr = rx_buf_dma;

-- 
pw-bot: cr
