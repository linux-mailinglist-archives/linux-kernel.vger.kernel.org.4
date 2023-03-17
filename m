Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF66BF076
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCQSLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE462DB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2AC610FB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 18:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097BFC433D2;
        Fri, 17 Mar 2023 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679076688;
        bh=IEdS6Zt1Y4BK3KiP7CdUC0fSKomz1GUOR5/imJRiHm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2jqPoXmcEb8swUU2SInD1fvWGSbJEtqFxc/iTCZWzULg5SNWw8znkrsUGNI2JSt/y
         WMnrQXlYu6OUOD+ZDpqhkpb0dpSjWkbyLfr0/Li/2q/0n2GL4HoCIqym3KWraQa7xa
         nEYrVCKWvMZvtvZfdiQHmtoQEm5R9nctmM0k+ycs=
Date:   Fri, 17 Mar 2023 19:11:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
Message-ID: <ZBStTXkZwMWj+Amj@kroah.com>
References: <20230317171943.941539-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317171943.941539-1-saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:19:42AM -0700, Saravana Kannan wrote:
> Add a build time equivalent of fw_devlink.sync_state=timeout so that
> board specific kernels could enable it and not have to deal with setting
> or cluttering the kernel commandline.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/Kconfig | 12 ++++++++++++
>  drivers/base/core.c  |  5 +++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 6f04b831a5c0..2b8fd6bb7da0 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
>  	  Enable support for generic NUMA implementation. Currently, RISC-V
>  	  and ARM64 use it.
>  
> +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> +	bool "sync_state() behavior defaults to timeout instead of strict"
> +	help
> +	  This is build time equivalent of adding kernel command line parameter
> +	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
> +	  call sync_state() on any devices that haven't yet received their
> +	  sync_state() calls after deferred_probe_timeout has expired or by
> +	  late_initcall() if !CONFIG_MODULES. You should almost always want to
> +	  select N here unless you have already successfully tested with the
> +	  command line option on every system/board your kernel is expected to
> +	  work on.
> +
>  endmenu
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index fe74a786e2c3..adc81871829f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1672,7 +1672,12 @@ early_param("fw_devlink.strict", fw_devlink_strict_setup);
>  #define FW_DEVLINK_SYNC_STATE_STRICT	0
>  #define FW_DEVLINK_SYNC_STATE_TIMEOUT	1
>  
> +#ifndef CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
>  static int fw_devlink_sync_state;
> +#else
> +static int fw_devlink_sync_state = FW_DEVLINK_SYNC_STATE_TIMEOUT;
> +#endif
> +
>  static int __init fw_devlink_sync_state_setup(char *arg)
>  {
>  	if (!arg)
> -- 
> 2.40.0.rc2.332.ga46443480c-goog
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
