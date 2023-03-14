Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C16B8AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNGNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCNGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:12:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FA1BACD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A9B2CE0E4A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E477EC433EF;
        Tue, 14 Mar 2023 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678774374;
        bh=IwKzcgaTwqwQYTs70kEWktqJi1K/npa63t9+ZA2J44o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LE/BLlkH+Jag5CI1/x1cFBIDkwoTYKQ5zRtndearb+RE0f29LjGy+T8GLPJTsigba
         LBhQSZ6qKmCgN39L/pIwnlqu/TLfOOpz1NXm0ZIaQS3cxooPJ354mG8tCmq6jv5kOv
         IaWMmXtHyHr+RtJmEi2GnrKLwfZIY4RPW9ITNYXg=
Date:   Tue, 14 Mar 2023 07:12:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
Message-ID: <ZBAQZKY+PuVeGDu1@kroah.com>
References: <20230313232719.3565369-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313232719.3565369-1-saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 04:27:19PM -0700, Saravana Kannan wrote:
> Add a build time equivalent of fw_devlink.sync_state=timeout so that
> board specific kernels could enable it and not have to deal with setting
> or cluttering the kernel commandline.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/Kconfig | 10 ++++++++++
>  drivers/base/core.c  |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 6f04b831a5c0..da91b409482f 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -230,4 +230,14 @@ config GENERIC_ARCH_NUMA
>  	  Enable support for generic NUMA implementation. Currently, RISC-V
>  	  and ARM64 use it.
>  
> +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> +	bool
> +	default n

n is always the default, no need to say it here again.

> +	help
> +	  This is build time equivalent of adding kernel commandline parameter
> +	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
> +	  call sync_state() on any devices that haven't yet received their
> +	  sync_state() calls after deferred_probe_timeout has expired or by
> +	  late_initcall() if !CONFIG_MODULES.

I think you forgot a noun in this last sentence :)

And add something like "You should almost always want to select N here
unless you have successfully tested with this command line option
already"

thanks,

greg k-h
