Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42DA6C6DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjCWQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCWQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6529413;
        Thu, 23 Mar 2023 09:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D96627F5;
        Thu, 23 Mar 2023 16:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E9C433D2;
        Thu, 23 Mar 2023 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679589136;
        bh=Z+hK39DxAGT9ENxUSdUl1KEjAOL/mypmkO9p8VKVPHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2VL2lrMrkls9/9RsRHNlNP49f+/699035XtgRiplt6uuNdu4tw1d52CbgUZhJ54q
         i9e0YVemSSNf2pxi9svB5tt8pK5oGgCBVbdRWBOlde27jYMaWpz8FdVUsWDGesnh55
         QGv5AF0zuCRrM28Dam56m0hrLmWVtp1gtz82BnAA=
Date:   Thu, 23 Mar 2023 17:32:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: pci-quirks: Remove a useless initialization
Message-ID: <ZBx/DeY4rwX+4zg8@kroah.com>
References: <3850d93ff40ed12f4724621a540fb5993c0a0fa9.1679434951.git.christophe.jaillet@wanadoo.fr>
 <a3c703152d89a2c6b34b31f0158f84ba504e24d8.1679434951.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c703152d89a2c6b34b31f0158f84ba504e24d8.1679434951.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:43:10PM +0100, Christophe JAILLET wrote:
> 'info' is memset()'ed a few lines below and is not use in the between.
> 
> There is no need to initialize one of its field to false here.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/host/pci-quirks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 6b741327d2c4..46f2412dcb40 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -208,7 +208,6 @@ static void usb_amd_find_chipset_info(void)
>  {
>  	unsigned long flags;
>  	struct amd_chipset_info info;
> -	info.need_pll_quirk = false;

Why not just change the line above it to:
	struct amd_chipset_info info = { };
and drop the call to memset entirely?

thanks,

greg k-h
