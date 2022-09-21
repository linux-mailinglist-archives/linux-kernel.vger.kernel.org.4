Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB95BF6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIUGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIUGv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:51:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39233A28;
        Tue, 20 Sep 2022 23:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07125CE1C35;
        Wed, 21 Sep 2022 06:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77391C433D6;
        Wed, 21 Sep 2022 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663743080;
        bh=dE4QRI26YlOn4oFfwbVQHDdyoxQTuoDrVdmUDf2b+uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZanWWv0NIWceQXjh71GdU9Y347VUC6s/OMkt1j8tZj/6L5qWsUwVS8NjBz+rvf1t
         KtiNliYS7zXqXWsenR5yHqxTxDFgsJ/Xtm/jYpicad00uiTW5HKkoBCc03LR6ed9RH
         X4pV+g7pns+S16K6riSrWpBLODfYMkTxn2ULOz/M=
Date:   Wed, 21 Sep 2022 08:51:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "net: mvpp2: debugfs: fix memory leak when using
 debugfs_lookup()" has been added to the 5.10-stable tree
Message-ID: <Yyq0hHcOTelikuOy@kroah.com>
References: <20220920214625.206958-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920214625.206958-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:46:25PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: mvpp2: debugfs: fix memory leak when using debugfs_lookup()
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-mvpp2-debugfs-fix-memory-leak-when-using-debugfs.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 24f9e4af2b16c42327cde7198834a5d58aacb2f8
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Fri Sep 2 15:41:11 2022 +0200
> 
>     net: mvpp2: debugfs: fix memory leak when using debugfs_lookup()
>     
>     [ Upstream commit fe2c9c61f668cde28dac2b188028c5299cedcc1e ]
>     
>     When calling debugfs_lookup() the result must have dput() called on it,
>     otherwise the memory will leak over time.  Fix this up to be much
>     simpler logic and only create the root debugfs directory once when the
>     driver is first accessed.  That resolves the memory leak and makes
>     things more obvious as to what the intent is.
>     
>     Cc: Marcin Wojtas <mw@semihalf.com>
>     Cc: Russell King <linux@armlinux.org.uk>
>     Cc: "David S. Miller" <davem@davemloft.net>
>     Cc: Eric Dumazet <edumazet@google.com>
>     Cc: Jakub Kicinski <kuba@kernel.org>
>     Cc: Paolo Abeni <pabeni@redhat.com>
>     Cc: netdev@vger.kernel.org
>     Cc: stable <stable@kernel.org>
>     Fixes: 21da57a23125 ("net: mvpp2: add a debugfs interface for the Header Parser")
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> index 4a3baa7e0142..0eec05d905eb 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> @@ -700,10 +700,10 @@ void mvpp2_dbgfs_cleanup(struct mvpp2 *priv)
>  
>  void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
>  {
> -	struct dentry *mvpp2_dir, *mvpp2_root;
> +	static struct dentry *mvpp2_root;
> +	struct dentry *mvpp2_dir;
>  	int ret, i;
>  
> -	mvpp2_root = debugfs_lookup(MVPP2_DRIVER_NAME, NULL);
>  	if (!mvpp2_root)
>  		mvpp2_root = debugfs_create_dir(MVPP2_DRIVER_NAME, NULL);
>  

I dropped this at the request of Russell last time around, and will be
fixing this up in a "better" way later this week, so I will drop this
from the stable queues as well.

thanks,

greg k-h
