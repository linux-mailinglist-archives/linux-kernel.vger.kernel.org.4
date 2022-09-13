Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F315B7D56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIMXJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIMXJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3022637
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B42016164B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94563C433C1;
        Tue, 13 Sep 2022 23:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663110572;
        bh=pcH19MK6ESI/9MZwdBzNsbd8GjA8eDK+xjnqH2krCP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIATb4ijmbgnmb9gCpxebU0lphb4lYu3ILc1nFy44RfIxfsWEjJWZL5XWwCT/aQJl
         yNLwMhVcFsh9/WFjwLmdNc/ZIiNSVkSMb1B0+S3+sZn4G38TQ1wcjTs56RDZtAflP9
         zbhJx4Fh1y08Z2RvmQ3FjLxeSReIS6PGnDYtvjmwr3Mpahp6u639iiTY/MNlXplCY6
         8IYhDG93rMRtT/MGufRw09D+ZVvPbwWm7zWK8ovzUlq4dYKmvsp9pO2CJKTcjBs3Ic
         TDdeUMfHSCiAm3/tLJEE0V1n9eLwGdPzxGFpr4mPlJuft8VRYBZ+M1osxDXSCO8g9h
         LBE+e9mA+DuMw==
Date:   Tue, 13 Sep 2022 16:09:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Fix return type of ieee80211_xmit
Message-ID: <YyENqW9u3LxySbSk@dev-arch.thelio-3990X>
References: <20220912214559.929186-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912214559.929186-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:45:56PM -0700, Nathan Huckleberry wrote:
> The ndo_start_xmit field in net_device_ops is expected to be of type
> netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of ieee80211_xmit should be changed from int to
> netdev_tx_t.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

The protoype in drivers/staging/rtl8192u/ieee80211/ieee80211.h should be
updated as well. With that:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
> index 8602e3a6c837..e4b6454809a0 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
> @@ -526,7 +526,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
>  	}
>  }
>  
> -int ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
> +netdev_tx_t ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct ieee80211_device *ieee = netdev_priv(dev);
>  	struct ieee80211_txb *txb = NULL;
> @@ -822,13 +822,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
>  			if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
>  				stats->tx_packets++;
>  				stats->tx_bytes += __le16_to_cpu(txb->payload_size);
> -				return 0;
> +				return NETDEV_TX_OK;
>  			}
>  			ieee80211_txb_free(txb);
>  		}
>  	}
>  
> -	return 0;
> +	return NETDEV_TX_OK;
>  
>   failed:
>  	spin_unlock_irqrestore(&ieee->lock, flags);

I see 'return 1' down here, that doesn't appear to be a valid
'netdev_tx_t'. Should that be 'return NETDEV_TX_BUSY'? I guess that is
an outstanding issue though, just figured I would mention it.

> -- 
> 2.37.2.789.g6183377224-goog
> 

Cheers,
Nathan
