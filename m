Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB884667D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbjALSKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbjALSJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:09:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F27464A;
        Thu, 12 Jan 2023 09:37:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5906205E;
        Thu, 12 Jan 2023 17:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4817C433D2;
        Thu, 12 Jan 2023 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673545067;
        bh=HXALqRZtlCaFSHe30HCG0ocQ7PVCQxc3yrath6As/Zs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UClruSFxvw5t/jRHOFW025K2YrjsX8C3k+ZIzIbA3WXuzciIjTz10/ltM8EpTvCBP
         Zv/JZhlrPJbxXWfGZ4vopTdMs0BdAweliRVHCxYN7rpfn5H2LdFzKWqfrbfTGhwWzC
         eMUWVyaoyJnOZIlgQl4kNCaO2HLx9kuKxZ4rTBE7Wh0Yn86VjlO+CYp7Kw3fQi8m3c
         1w+eeOCJldp+EumI4YcQLIoppH/NStjg/0XhXw37mtUenRnAkuAxAoQTPBoyBYZIoJ
         +y+XNPkF4iobPIlckgjPHwBPNomgxv9cr5luf3mkpzridJZJZpbchh5SA7t0el2Tsy
         jrz0V9XX+rQ3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D0005C0AF8; Thu, 12 Jan 2023 09:37:47 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:37:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the tomoyo tree
Message-ID: <20230112173747.GO4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230111111439.4c4745d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111111439.4c4745d2@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:14:39AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   security/tomoyo/Kconfig
> 
> between commit:
> 
>   80f8be7af03f ("tomoyo: Omit use of bin2c")
> 
> from the tomoyo tree and commit:
> 
>   ed87f6865857 ("tomoyo: Remove "select SRCU"")
> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I have it noted down, thank you!

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc security/tomoyo/Kconfig
> index 772d2ab58fd1,a9796b400312..000000000000
> --- a/security/tomoyo/Kconfig
> +++ b/security/tomoyo/Kconfig
> @@@ -6,7 -6,7 +6,6 @@@ config SECURITY_TOMOY
>   	select SECURITYFS
>   	select SECURITY_PATH
>   	select SECURITY_NETWORK
> - 	select SRCU
>  -	select BUILD_BIN2C
>   	default n
>   	help
>   	  This selects TOMOYO Linux, pathname-based access control.


