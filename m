Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6796A5280
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1FBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1FBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72128D2D;
        Mon, 27 Feb 2023 21:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E38960C74;
        Tue, 28 Feb 2023 05:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76544C433EF;
        Tue, 28 Feb 2023 05:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677560469;
        bh=qWy53upKq1oRKTbh5tpoU6GVg1LXGwqzxxbh1/OgVvg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=myM3AxetGEcFeEZqJVYyiL16GCOyyZdPU4tM8XMXpATVc3biqkpGeauJv2MmvzhE2
         mNU4MJtTVH7XR3vvR5FTilmsyXeWllaa5Kup8Az2Xg+Xahkgqj10TNKqeqBOjdfMEJ
         a0N3hcEJRlRoNVhZtPldeerT046RakOEKMov8WMw3+rgGD3VnhIdAzxqMPifUWy+du
         AG9PxJXoYra0IlS/yTV1fzrsO/NFecov/Hb24Egbn9irdeXWi+DJnvQYFPaCcNBDG1
         7BMuhO9qsDgl5tkwLWoJTweQlebB+MTG+bCFvvQHU42K9C1HxI2e1tOWDHnpwOS2F7
         Maxxbi8ucvfaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1DA645C0368; Mon, 27 Feb 2023 21:01:09 -0800 (PST)
Date:   Mon, 27 Feb 2023 21:01:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        joel@joelfernandes.org, quic_neeraju@quicinc.com, urezki@gmail.com
Subject: Re: [PATCH] bootconfig: Change message if no bootconfig with
 CONFIG_BOOT_CONFIG_FORCE=y
Message-ID: <20230228050109.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <167754610254.318944.16848412476667893329.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167754610254.318944.16848412476667893329.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:01:42AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Change no bootconfig data error message if user do not specify 'bootconfig'
> option but CONFIG_BOOT_CONFIG_FORCE=y.
> With CONFIG_BOOT_CONFIG_FORCE=y, the kernel proceeds bootconfig check even
> if user does not specify 'bootconfig' option. So the current error message
> is confusing. Let's show just an information message to notice skipping
> the bootconfig in that case.
> 
> Fixes: b743852ccc1d ("Allow forcing unconditional bootconfig processing")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com/
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  init/main.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 4425d1783d5c..bb87b789c543 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -156,7 +156,7 @@ static char *extra_init_args;
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  /* Is bootconfig on command line? */
> -static bool bootconfig_found = IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
> +static bool bootconfig_found;
>  static size_t initargs_offs;
>  #else
>  # define bootconfig_found false
> @@ -429,7 +429,7 @@ static void __init setup_boot_config(void)
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
>  			 bootconfig_params);
>  
> -	if (IS_ERR(err) || !bootconfig_found)
> +	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
>  		return;
>  
>  	/* parse_args() stops at the next param of '--' and returns an address */
> @@ -437,7 +437,11 @@ static void __init setup_boot_config(void)
>  		initargs_offs = err - tmp_cmdline;
>  
>  	if (!data) {
> -		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> +		/* If user intended to use bootconfig, show an error level message */
> +		if (bootconfig_found)
> +			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> +		else
> +			pr_info("No bootconfig data provided, so skipping bootconfig");
>  		return;
>  	}
>  
> 
