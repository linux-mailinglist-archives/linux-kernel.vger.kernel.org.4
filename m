Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E92660FEF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjAGPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:22:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DF35937;
        Sat,  7 Jan 2023 07:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A102C60064;
        Sat,  7 Jan 2023 15:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D4FC433EF;
        Sat,  7 Jan 2023 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673104940;
        bh=Zi2+Rs+9NgOOhyZDWo4R1QQ5HZsFFSieUonNtvcIErw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RsCbenW3T9OIRWsg2zkm1j6xq6VmYmSMn1LmKbf0BSkxt0LnnF4kMb4ghn91m79/L
         pg0N2YSC3DJB/iwvoh8Jl6mw+Dpv2MN2UhIVzyb6TcdspXIzubG67GaoHO/d4trgw9
         5eDHYk0k4pj1eK/4nJ6bt/M7ygkgmkvuXrZTLN8m7GzlFv3gg8qPOg2Uaz8aItRiSW
         wTNx45J3qulAe2gD0wWutJeZ3dyxWFooR6ZILMsl8harkUqPk5rh5eLvXzavHb7YD1
         v5LMNcviurNkuFn5vYb9Pe9B/3APqFNZ1whP8t9pj/aLCycNrXBq5jekElIvcotpGh
         +xHuy/dH5S5SQ==
Date:   Sun, 8 Jan 2023 00:22:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mhiramat@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        joel@joelfernandes.org, quic_neeraju@quicinc.com, urezki@gmail.com
Subject: Re: [PATCH RFC bootconfig] Allow forcing unconditional bootconfig
 processing
Message-Id: <20230108002215.c18df95b19acdd3207b379fa@kernel.org>
In-Reply-To: <20230105005838.GA1772817@paulmck-ThinkPad-P17-Gen-1>
References: <20230105005838.GA1772817@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023 16:58:38 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> The BOOT_CONFIG family of Kconfig options allows a bootconfig file
> containing kernel boot parameters to be embedded into an initrd or into
> the kernel itself.  This can be extremely useful when deploying kernels
> in cases where some of the boot parameters depend on the kernel version
> rather than on the server hardware, firmware, or workload.
> 
> Unfortunately, the "bootconfig" kernel parameter must be specified in
> order to cause the kernel to look for the embedded bootconfig file,
> and it clearly does not help to embed this "bootconfig" kernel parameter
> into that file.
> 
> Therefore, provide a new BOOT_CONFIG_FORCE Kconfig option that causes the
> kernel to act as if the "bootconfig" kernel parameter had been specified.
> In other words, kernels built with CONFIG_BOOT_CONFIG_FORCE=y will look
> for the embedded bootconfig file even when the "bootconfig" kernel
> parameter is omitted.  This permits kernel-version-dependent kernel
> boot parameters to be embedded into the kernel image without the need to
> (for example) update large numbers of boot loaders.
> 

I like this because this is a simple solution. We have another option
to specify "bootconfig" in CONFIG_CMDLINE, but it can be overwritten by
bootloader. Thus, it is better to have this option so that user can
always enable bootconfig.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, maybe CONFIG_BOOT_CONFIG_EMBED is better to select this.
(or at least recommend to enable this)

Thank you!

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: <linux-doc@vger.kernel.org>
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 9355c525fbe0a..91339efdcb541 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -201,6 +201,8 @@ To remove the config from the image, you can use -d option as below::
>  
>  Then add "bootconfig" on the normal kernel command line to tell the
>  kernel to look for the bootconfig at the end of the initrd file.
> +Alternatively, build your kernel with the ``CONFIG_BOOT_CONFIG_FORCE``
> +Kconfig option selected.
>  
>  Embedding a Boot Config into Kernel
>  -----------------------------------
> @@ -217,7 +219,9 @@ path to the bootconfig file from source tree or object tree.
>  The kernel will embed it as the default bootconfig.
>  
>  Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
> -option on the kernel command line to enable the embedded bootconfig.
> +option on the kernel command line to enable the embedded bootconfig, or,
> +alternatively, build your kernel with the ``CONFIG_BOOT_CONFIG_FORCE``
> +Kconfig option selected.
>  
>  Note that even if you set this option, you can override the embedded
>  bootconfig by another bootconfig which attached to the initrd.
> diff --git a/init/Kconfig b/init/Kconfig
> index 7e5c3ddc341de..f894fb004bad4 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1376,6 +1376,18 @@ config BOOT_CONFIG
>  
>  	  If unsure, say Y.
>  
> +config BOOT_CONFIG_FORCE
> +	bool "Force unconditional bootconfig processing"
> +	depends on BOOT_CONFIG
> +	help
> +	  With this Kconfig option set, BOOT_CONFIG processing is carried
> +	  out even when the "bootconfig" kernel-boot parameter is omitted.
> +	  In fact, with this Kconfig option set, there is no way to
> +	  make the kernel ignore the BOOT_CONFIG-supplied kernel-boot
> +	  parameters.
> +
> +	  If unsure, say N.
> +
>  config BOOT_CONFIG_EMBED
>  	bool "Embed bootconfig file in the kernel"
>  	depends on BOOT_CONFIG
> diff --git a/init/main.c b/init/main.c
> index e1c3911d7c707..669cb892e6c17 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -156,7 +156,7 @@ static char *extra_init_args;
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  /* Is bootconfig on command line? */
> -static bool bootconfig_found;
> +static bool bootconfig_found = IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
>  static size_t initargs_offs;
>  #else
>  # define bootconfig_found false


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
