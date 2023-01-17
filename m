Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9F66E65B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjAQSpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjAQSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:39:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE31E287
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC508614FC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961E2C433F0;
        Tue, 17 Jan 2023 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673979116;
        bh=C34Ci/xYdbH/8oLA3YDDw/yrOZeRQzsgzaXlxYuh1Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBsL+P/Pnhp3jwwebsmkMk0ME7nkJ/guAhYZ7OtOvxE7lQxJhjpNkuwamrPGpZRtV
         hx8P8u8ZaxjPlwzirpgCpwG4l5WGiVi27LTiL72a5xpbcoFi09lOGXU9IoPy2qjR+b
         aLAIuPhs1vszPNPYF40qirKWUHkZxMOne8a1nD3c=
Date:   Tue, 17 Jan 2023 19:11:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH driver-core-next] platform: remove useless if-branch in
 __platform_get_irq_byname()
Message-ID: <Y8bk6bXGOWp8aPze@kroah.com>
References: <20221111094542.270540-1-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111094542.270540-1-soha@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:45:42PM +0800, Soha Jin wrote:
> When CONFIG_OF_IRQ is not enabled, there will be a stub method that always
> returns 0 when getting IRQ. Thus, the if-branch can be removed safely.
> 
> Fixes: d4ad017d6345 ("platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq")
> Signed-off-by: Soha Jin <soha@lohu.info>
> ---
>  drivers/base/platform.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 968f3d71eeab..6cd7fd478c5f 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -441,11 +441,9 @@ static int __platform_get_irq_byname(struct platform_device *dev,
>  	struct resource *r;
>  	int ret;
>  
> -	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
> -		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
> -		if (ret > 0 || ret == -EPROBE_DEFER)
> -			return ret;
> -	}
> +	ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
> +	if (ret > 0 || ret == -EPROBE_DEFER)
> +		return ret;

It's not really a "fix", so I'll be dropping that tag here.

thanks,

greg k-h
