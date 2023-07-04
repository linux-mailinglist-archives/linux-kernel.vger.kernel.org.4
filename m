Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36310747167
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGDMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGDMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23163D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05A6611EE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C364EC433C7;
        Tue,  4 Jul 2023 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688473915;
        bh=s2gOvhD0O9aB848BRmDyAn7vGh7FJLSnh5v/aAVxXss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nu9+hIY0hmNeet6MYTtxsZMz7DYX38nU+ggkxt77FCJnjqy+9AC4Jbl5F+T/ZJZUC
         GuL29vf2mloZuFILf6DcOdAR3qOLC+zqWFgEbCU5gS9A4wzkkvGyMDUC8ViD9A8GeI
         7DnPybwBR/1t/4JRglF5pLrzt28hmLjLNBTHZTJo=
Date:   Tue, 4 Jul 2023 13:31:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     wangjinchao <wangjinchao@xfusion.com>
Cc:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        xulei <stone.xulei@xfusion.com>
Subject: Re: [PATCH] staging: rtl8192u: Fix assignment in if condition
Message-ID: <2023070401-cried-reroute-f8a9@gregkh>
References: <ZKP/01ECsgmdBFf2@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKP/01ECsgmdBFf2@fedora>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 12:15:57PM +0000, wangjinchao wrote:
> I just participated in Outreachy of KernelNewbies and fixed one 
> 'ERROR: do not use assignment in if condition' issue reported by 
> checkpatch.pl on drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c.
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> index ca09367005e1..52ff9e62ec08 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> @@ -1121,8 +1121,9 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
>  
>  	/* skb: hdr + (possibly fragmented, possibly encrypted) payload */
>  
> +	keyidx = ieee80211_rx_frame_decrypt(ieee, skb, crypt);
>  	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
> -	    (keyidx = ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0) {
> +	    keyidx < 0) {
>  		netdev_dbg(ieee->dev, "decrypt frame error\n");
>  		goto rx_dropped;
>  	}
> -- 
> 2.40.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
