Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C56E6506
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjDRMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjDRMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA716F88
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A63B63437
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205EC433D2;
        Tue, 18 Apr 2023 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681822437;
        bh=BjazipYxgTQwo3XKY/INqPSd78c2OmndMvy1BAPInRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfH88cwZgeRYKZF03NlzLsLdyR3ew/xBJNYnop8uPCRubrSrqkGZKfsEwEUVa9L1o
         7rXpuPrwo4b1XKxKt7SWPfC5XluEoIkx1J1tiHLbLq909nRz6tuBXXvkgJjlXZqsZK
         uVSzKv2h+UFZwi7uVYz4OWgF9InsRvSfFRFjj70E=
Date:   Tue, 18 Apr 2023 14:32:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: No need to get auxdev->dev
 again
Message-ID: <2023041816-magma-shortly-dfdd@gregkh>
References: <20230418122406.1338-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418122406.1338-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 08:24:06PM +0800, Angus Chen wrote:
> Use dev variable directly.
> No functional change intended.

Not intended, but is it really intended?  What does this line mean?

> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/base/auxiliary.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 4d4c2c8d26c4..ca1d044ff738 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -286,7 +286,7 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
>  	}
>  
>  	dev->bus = &auxiliary_bus_type;
> -	device_initialize(&auxdev->dev);
> +	device_initialize(dev);

While an interesting change, is it needed?  Why make it?

thanks,

greg k-h
