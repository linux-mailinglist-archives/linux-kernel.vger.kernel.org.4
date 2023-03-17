Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859776BEAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCQOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCQOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:12:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D1B0B85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E26EBB8245E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D22AC433EF;
        Fri, 17 Mar 2023 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679062362;
        bh=LdNHCCkQQg9eFg+yfpzkrshovuJWxQ/o5V+1fE2q5vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9eaDFOtxDDtkuwD629AjxdjjHVQpzNyktDkuIXj8c7/443aSY9tiF160596kEk+g
         +Jf8ilfnCQJpub9ADYafjhJX5tvOXJQQi5D40hvF0+C5lyNSpEcQ5EAAUXppsU4p4J
         JlTKR3nblYd/BD2sxIHZ9duPE+Le/u+D04vkvrZg=
Date:   Fri, 17 Mar 2023 15:12:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
Message-ID: <ZBR1WHPpcrOMFwVe@kroah.com>
References: <20230315010732.633992-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315010732.633992-1-saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:07:31PM -0700, Saravana Kannan wrote:
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
> index 6f04b831a5c0..aac247512d69 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
>  	  Enable support for generic NUMA implementation. Currently, RISC-V
>  	  and ARM64 use it.
>  
> +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> +	bool
> +	help
> +	  This is build time equivalent of adding kernel command line parameter
> +	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
> +	  call sync_state() on any devices that haven't yet received their
> +	  sync_state() calls after deferred_probe_timeout has expired or by
> +	  late_initcall() if !CONFIG_MODULES. You should almost always want to
> +	  select N here unless you have already successfully tested with the
> +	  command line option on every system/board your kernel is expected to
> +	  work on.

As nothing can actually select this, it doesn't make sense to add this
now, right?  We need a user, otherwise the automated tools will come
along and remove this option when they figure out that it can't be ever
used.

thanks,

greg k-h
