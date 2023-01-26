Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF167D555
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjAZT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjAZT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:26:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C0D5C0DE;
        Thu, 26 Jan 2023 11:26:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC2B6618A9;
        Thu, 26 Jan 2023 19:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5369EC433EF;
        Thu, 26 Jan 2023 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674761175;
        bh=n8TZeJo3FvcCJuf7g+eoX/LF31ASk7eOswmcNXrJ6pQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y/D63xP2KAhNqIF4WoGvWZD5HO4ih0nNp8np8wqUhiHOMKsMJvPLI0II6m+TD2u7/
         3k48LCPOXMy5v3LIv0mbL0GolnVtSXaorOzzJgum8544DMmqeCjIX3CDDaioLnGpOy
         roqsYoy3rRFqkve7mcta/YFLrRxnmNrBIOC3L5gwy+p2msU/gD5PH1ftjJdidP031u
         VmiXzRSIGQkO+CiqtVsaZvLWuVfDa9O0ROOjtFS0L18AlmzlWBo2dg99nwM/BWaT+B
         hs/+XiWUkgTdFjFG3UY9DqlCHDxqUh0N79g+F7fidRB9X0/HTg15G0+qR/aI3PUFuc
         6xfM5CmS7lt9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED76F5C0510; Thu, 26 Jan 2023 11:26:14 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:26:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, ndesaulniers@google.com,
        vbabka@suse.cz, hannes@cmpxchg.org, joel@joelfernandes.org,
        quic_neeraju@quicinc.com, urezki@gmail.com
Subject: Re: [PATCH RFC bootconfig] Allow forcing unconditional bootconfig
 processing
Message-ID: <20230126192614.GA691808@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230108002215.c18df95b19acdd3207b379fa@kernel.org>
 <20230107162202.GA4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230108150425.426f2861e9db1152fa84508f@kernel.org>
 <20230109042501.GF4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110085636.5d679f98c5b6914ecf19e724@kernel.org>
 <20230110000732.GD4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110095450.2cb4c875f95459e3a4e7dcf1@kernel.org>
 <20230110010953.GF4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110231721.ed737bcc46ee6b8572d7cdff@kernel.org>
 <20230110150259.GO4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110150259.GO4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:02:59AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 10, 2023 at 11:17:21PM +0900, Masami Hiramatsu wrote:
> > On Mon, 9 Jan 2023 17:09:53 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Tue, Jan 10, 2023 at 09:54:50AM +0900, Masami Hiramatsu wrote:
> > > > On Mon, 9 Jan 2023 16:07:32 -0800
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > On Tue, Jan 10, 2023 at 08:56:36AM +0900, Masami Hiramatsu wrote:
> > > > > > On Sun, 8 Jan 2023 20:25:01 -0800
> > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > > On Sun, Jan 08, 2023 at 03:04:25PM +0900, Masami Hiramatsu wrote:
> > > > > > > > On Sat, 7 Jan 2023 08:22:02 -0800
> > > > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > > > 
> > > > > > > > > On Sun, Jan 08, 2023 at 12:22:15AM +0900, Masami Hiramatsu wrote:
> > > > > > > > > > On Wed, 4 Jan 2023 16:58:38 -0800
> > > > > > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > > > > > 
> > > > > > > > > > > The BOOT_CONFIG family of Kconfig options allows a bootconfig file
> > > > > > > > > > > containing kernel boot parameters to be embedded into an initrd or into
> > > > > > > > > > > the kernel itself.  This can be extremely useful when deploying kernels
> > > > > > > > > > > in cases where some of the boot parameters depend on the kernel version
> > > > > > > > > > > rather than on the server hardware, firmware, or workload.
> > > > > > > > > > > 
> > > > > > > > > > > Unfortunately, the "bootconfig" kernel parameter must be specified in
> > > > > > > > > > > order to cause the kernel to look for the embedded bootconfig file,
> > > > > > > > > > > and it clearly does not help to embed this "bootconfig" kernel parameter
> > > > > > > > > > > into that file.
> > > > > > > > > > > 
> > > > > > > > > > > Therefore, provide a new BOOT_CONFIG_FORCE Kconfig option that causes the
> > > > > > > > > > > kernel to act as if the "bootconfig" kernel parameter had been specified.
> > > > > > > > > > > In other words, kernels built with CONFIG_BOOT_CONFIG_FORCE=y will look
> > > > > > > > > > > for the embedded bootconfig file even when the "bootconfig" kernel
> > > > > > > > > > > parameter is omitted.  This permits kernel-version-dependent kernel
> > > > > > > > > > > boot parameters to be embedded into the kernel image without the need to
> > > > > > > > > > > (for example) update large numbers of boot loaders.
> > > > > > > > > > 
> > > > > > > > > > I like this because this is a simple solution. We have another option
> > > > > > > > > > to specify "bootconfig" in CONFIG_CMDLINE, but it can be overwritten by
> > > > > > > > > > bootloader. Thus, it is better to have this option so that user can
> > > > > > > > > > always enable bootconfig.
> > > > > > > > > 
> > > > > > > > > Glad you like it!
> > > > > > > > > 
> > > > > > > > > In addition, if the help text is accurate, another shortcoming of
> > > > > > > > > CONFIG_CMDLINE is that its semantics vary from one architecture to
> > > > > > > > > another.  Some have CONFIG_CMDLINE override the boot-loader supplied
> > > > > > > > > parameters, and others differ in the order in which the parameters
> > > > > > > > > are processed.
> > > > > > > > 
> > > > > > > > Yes, that differences confuse us...
> > > > > > > 
> > > > > > > I am glad that it is not just me.  ;-)
> > > > > > > 
> > > > > > > I will add words to that effect to the commit log.
> > > > > > > 
> > > > > > > > > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > > > > > 
> > > > > > > > > Thank you!
> > > > > > > > > 
> > > > > > > > > > BTW, maybe CONFIG_BOOT_CONFIG_EMBED is better to select this.
> > > > > > > > > > (or at least recommend to enable this)
> > > > > > > > > 
> > > > > > > > > Like this?
> > > > > > > > 
> > > > > > > > Yes! Thanks.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 							Thanx, Paul
> > > > > > > > > 
> > > > > > > > > ------------------------------------------------------------------------
> > > > > > > > > 
> > > > > > > > > commit d09a1505c51a70da38b34ac38062977299aef742
> > > > > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > Date:   Sat Jan 7 08:09:22 2023 -0800
> > > > > > > > > 
> > > > > > > > >     bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED
> > > > > > > > >     
> > > > > > > > >     When a kernel is built with CONFIG_BOOT_CONFIG_EMBED=y, the intention
> > > > > > > > >     will normally be to unconditionally provide the specified kernel-boot
> > > > > > > > >     arguments to the kernel, as opposed to requiring a separately provided
> > > > > > > > >     bootconfig parameter.  Therefore, make the BOOT_CONFIG_FORCE Kconfig
> > > > > > > > >     option default to y in kernels built with CONFIG_BOOT_CONFIG_EMBED=y.
> > > > > > > > >     
> > > > > > > > >     The old semantics may be obtained by manually overriding this default.
> > > > > > > > >     
> > > > > > > > >     Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > 
> > > > > > > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > > > 
> > > > > > > Applied, thank you!
> > > > > > 
> > > > > > Paul, just for confirmation, have you picked these patches on your tree?
> > > > > 
> > > > > I have, but if you would prefer to take them, just let me know when you
> > > > > have pulled them in.  It is easy for me to drop them.
> > > > > 
> > > > > Here they are in the -rcu tree:
> > > > > 
> > > > > 3d9ccc4a8b56e bootconfig: Allow forcing unconditional bootconfig processing
> > > > > 68b920592ff67 bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > 
> > > > Yeah, if it's not hurry, let me pick those to linux-trace tree
> > > > (bootconfig/for-next). I would like to consolidate the bootconfig
> > > > updates on my tree.
> > > 
> > > Please go ahead and grab them.  Just out of curiosity, are they in time
> > > for the upcoming v6.3 merge window?
> > 
> > Yes, I will do.
> 
> Very good, I will drop them from my tree on my next rebase.

Apologies for nagging, but I don't see this in -next, so I figured that
I should follow up.  Is there some adjustment required to this patch?
If so, please let me know so that I can fix it.

							Thanx, Paul
