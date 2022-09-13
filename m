Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D085B7D75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIMXWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B217171E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F66A61683
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074F8C433D6;
        Tue, 13 Sep 2022 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663111345;
        bh=2TX1nccSTQ50w1MEvLtJw+7bvB4T+UvLhS92m1Avg5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2KCtYwGkvv2UwSti7StkyHy5HzpS8R804muUFfMy4d/inhxLA6Yzov4pRkr/NPLZ
         gpvx5ym3dNsEpDPvOc01yI/C6TkgpxZYMJ8lNPe+9YDFTwQcGyF0FF3fuQFRzDbSVb
         52ZSiOZ2CGWrO13M2rZe1LPnO55M2xT1kam26OdrMl7FMn/UbBzvc006aEMFhslGWo
         nlO0qzFB3DXDeguxB9QqDlxHgn/nSvKt9t5NZpnqda+2b5Y+NwwlGmmjfWTFS3MmIv
         XM8x3fKfmoC1IOkm6Mlu0SZf8YHnQd1xG0HP+Q8e4zk9lh7IYwjt41Pu/Ot/SAvUW2
         HUlq5swggpnow==
Date:   Tue, 13 Sep 2022 16:22:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     error27@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, ndesaulniers@google.com, trix@redhat.com
Subject: Re: [PATCH v2] staging: octeon: Fix return type of cvm_oct_xmit and
 cvm_oct_xmit_pow
Message-ID: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
References: <YyEFu8uzoxK64p0Y@dev-arch.thelio-3990X>
 <20220913230412.225957-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913230412.225957-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 04:04:12PM -0700, Nathan Huckleberry wrote:
> The ndo_start_xmit field in net_device_ops is expected to be of type
> netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of cvm_oct_xmit and cvm_oct_xmit_pow should be changed
> from int to netdev_tx_t.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> 
> Changes v1 -> v2:
>  - Update function signatures in ethernet-tx.h.
> 
> ---
>  drivers/staging/octeon/ethernet-tx.c | 4 ++--
>  drivers/staging/octeon/ethernet-tx.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index 1ad94c5060b5..a36e36701c74 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -125,7 +125,7 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
>   *
>   * Returns Always returns NETDEV_TX_OK
>   */
> -int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
> +netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	union cvmx_pko_command_word0 pko_command;
>  	union cvmx_buf_ptr hw_buffer;
> @@ -506,7 +506,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
>   * @dev:    Device info structure
>   * Returns Always returns zero
>   */
> -int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
> +netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct octeon_ethernet *priv = netdev_priv(dev);
>  	void *packet_buffer;
> diff --git a/drivers/staging/octeon/ethernet-tx.h b/drivers/staging/octeon/ethernet-tx.h
> index 78936e9b33b0..6c524668f65a 100644
> --- a/drivers/staging/octeon/ethernet-tx.h
> +++ b/drivers/staging/octeon/ethernet-tx.h
> @@ -5,8 +5,8 @@
>   * Copyright (c) 2003-2007 Cavium Networks
>   */
>  
> -int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev);
> -int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
> +netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev);
> +netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
>  int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
>  			 int do_free, int qos);
>  void cvm_oct_tx_initialize(void);
> -- 
> 2.37.2.789.g6183377224-goog
> 
