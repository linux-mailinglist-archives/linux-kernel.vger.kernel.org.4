Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E3617FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKCOjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:39:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B431126;
        Thu,  3 Nov 2022 07:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4FD9B825E5;
        Thu,  3 Nov 2022 14:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0369EC433C1;
        Thu,  3 Nov 2022 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667486372;
        bh=mjK0TvF5WgfZ7bhhx8ze1rsPxF3bhUFuKxm8G+Vxj4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3xOJrFwzx0HBHoGykDBvpELDGkqLTR9mvcBSBQRqX4IXQBcgpku+jl1XDboLnxsu
         Mu0gC4VRDjOq3qmoLKYdaZ+1z5nk18Kg+wsZxxDvkH9yJE+LSfgchzE1swnAkQjcLQ
         VINk/gp+mWc7hM7jeJlPN9D/AUlMTb6BaQ920hD8=
Date:   Thu, 3 Nov 2022 23:40:12 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/2] of: export of_device_add()
Message-ID: <Y2PSzCEr2c2g9ZJp@kroah.com>
References: <20221103141233.20179-1-m.szyprowski@samsung.com>
 <CGME20221103141239eucas1p167f44609369010a20293d5123214426d@eucas1p1.samsung.com>
 <20221103141233.20179-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103141233.20179-2-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:12:33PM +0100, Marek Szyprowski wrote:
> Export of_device_add() function to let DWC3 driver (Exynos variant) to
> instantiate DWC3 core device from the respective child OF-node with a
> custom, addtional properties added.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/of/device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 8cefe5a7d04e..bc60c9b6863c 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -52,6 +52,7 @@ int of_device_add(struct platform_device *ofdev)
>  
>  	return device_add(&ofdev->dev);
>  }
> +EXPORT_SYMBOL(of_device_add);

I do not see any user of this symbol after this patch (no 3/2?)

So why is it needed?  No driver should ever be calling this function
directly.

thanks,

greg k-h
