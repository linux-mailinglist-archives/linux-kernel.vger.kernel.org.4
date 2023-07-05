Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D2748D99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjGETRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjGETRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5742448A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB9A616F0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E6C433C9;
        Wed,  5 Jul 2023 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688584233;
        bh=5v2Jcbu23jOZ3NaXiTSv75lRiQHToTnbx3t9Ier4ieA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaRFN7is3IkXgvJVuogihBRu2z0M9hIkMOoVNNKz0aqlLr9bWl0sGVxKe64O/gDmf
         COB5jjtZ75SrFflvrcpcpOz5laZmr+8IAq8TFsZauo8Qxt7Z+vTsiguElCzwp3lIgR
         HanYQpRRWpy8UzeRiJmTEDbxBR2xvZxbvl82AMN1bgrz9KDfpW5t86f8dunErGqzIv
         ANDRrSxrxoUuDv3zvDDByMd3ACbFRRg+zfm7ATTy2aiQPtH2IWh/sYZyeZ6zK2ryP2
         plqsqzfA/8zk4qdInLZoucroxki4WylAJh6guGCNBePq5eLsEjuHt8YwdLm5ODeSGO
         v94qReik0nw+w==
Date:   Wed, 5 Jul 2023 22:10:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v2] net:thunderx:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <20230705191028.GP6455@unreal>
References: <20230705143507.4120-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705143507.4120-1-machel@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:34:56PM +0800, Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> wnode_handle_put() before break
> which could avoid resource leaks.
> This patch could fix this bug.

It is very strange typographic. You have ~80 chars per-line, while your
longest line is 40 chars only.

> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8decb..dad32d36a015 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		 * cannot handle it, so exit the loop.
>  		 */
>  		node = to_of_node(fwn);
> -		if (!node)
> +		if (!node) {
> +			fwnode_handle_put(fwn);
>  			break;
> +		}
>  
>  		of_get_mac_address(node, bgx->lmac[lmac].mac);
>  
> @@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		lmac++;
>  		if (lmac == bgx->max_lmac) {
>  			of_node_put(node);
> +			fwnode_handle_put(fwn);
>  			break;
>  		}
>  	}
> -- 
> 2.25.1
> 
> 
