Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D6693EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBMHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:07:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8010279
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D289760BB1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2240C433D2;
        Mon, 13 Feb 2023 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676272033;
        bh=iqM15pxYu/X3UjusJTmBRxtold7LtIBwjK9SL+l6t/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emfgOx42ALbYWgtBmU5Rv5s0sX2KvwRQC/8NDv9Ch/vkgtoLRELcEmJuntPUOZc99
         0+f2jq6NvlWgw18KfbJwb9V8oV93t9Ar57IERWGILJxrmJtAa5lpwzqOsid67eI2ZD
         jsoREc6xqlzaSci3gm1rGWXQiRuIShTLqfCcZANo=
Date:   Mon, 13 Feb 2023 08:07:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver: core: Prevent NULL pointer dereference in device
 name functions
Message-ID: <Y+nhnauiUDspXwNM@kroah.com>
References: <20230212220441.258258-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212220441.258258-1-alexander.sverdlin@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 11:04:41PM +0100, Alexander Sverdlin wrote:
> Prevent similar scenarios:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000038
> ...
> PC is at dev_driver_string+0x0/0x38

How did this "scenario" happen?  What in-tree code caused this?

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  drivers/base/core.c    | 3 +++
>  include/linux/device.h | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0c..4ff2ddea7c9b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2174,6 +2174,9 @@ const char *dev_driver_string(const struct device *dev)
>  {
>  	struct device_driver *drv;
>  
> +	if (!dev)
> +		return "<null>";
> +

None of these functions should be called with a NULL pointer as the
reference should have been properly gotten on them before calling these
functions.  So let's fix up the callers please, something is really
wrong with them.  Again, what in-tree code is causing this to happen?

thanks,

greg k-h
