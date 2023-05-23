Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DD70DE3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjEWN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjEWN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8CE5E;
        Tue, 23 May 2023 06:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F26086197C;
        Tue, 23 May 2023 13:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3736CC4339B;
        Tue, 23 May 2023 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684850227;
        bh=3axLG1/K+AxB/rbOTBfx2ocK/Ii7na1MiC0XPF5pG20=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=poHUIVXpVVWETw8/bgOC5BRbtv/cBcpF+itnmqrPNrVa0ufX13ni+Ja5L+28pJXME
         ywgBoc/reN96eK4PorILej2avPaL6BXEBfy5GHV5qJvIoGMS7PgjmLSv/K/GZsxF7v
         foxT+k3/aQU2M+uw72J1wXem2Yp9fyZUA3aAl+UZao8BAPh4sMzp89zCAqbDeKccu6
         xJ/iAqjk1QyCafF7/yUNucGHYNVCwZf62alZn1CBI4AMyOrEEByzU/yrO6G553UK57
         KuHhHldasJrKAzYW/A4R3h6DuhG2R2HdJSeGM2AgLwLQM8KaP0M2uFKHPHxmTUShy1
         byhhvzfewmIZA==
Date:   Tue, 23 May 2023 15:57:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ensure timely release of driver-allocated
 resources
In-Reply-To: <ZFWarGkRAfPOmI6E@google.com>
Message-ID: <nycvar.YFH.7.76.2305231554250.29760@cbobk.fhfr.pm>
References: <ZFWarGkRAfPOmI6E@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023, Dmitry Torokhov wrote:

> More and more drivers rely on devres to manage their resources, however
> if bus' probe() and release() methods are not trivial and control some
> of resources as well (for example enable or disable clocks, or attach
> device to a power domain), we need to make sure that driver-allocated
> resources are released immediately after driver's remove() method
> returns, and not postponed until driver core gets around to releasing
> resources.
> 
> In case of HID we should not try to close the report and release
> associated memory until after all devres callbacks are executed. To fix
> that we open a new devres group before calling driver's probe() and
> explicitly release it when we return from driver's remove().
> 
> This is similar to what we did for I2C bus in commit 5b5475826c52 ("i2c:
> ensure timely release of driver-allocated resources"). It is tempting to
> try and move this into driver core, but actually doing so is challenging,
> we need to split bus' remove() method into pre- and post-remove methods,
> which would make the logic even less clear.
> 
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Link: https://lore.kernel.org/r/20230505232417.1377393-1-swboyd@chromium.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-core.c | 55 ++++++++++++++++++++++++++++--------------
>  include/linux/hid.h    |  1 +
>  2 files changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c4ac9081194c..02a43bba9091 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2602,35 +2602,29 @@ static bool hid_device_check_match(struct hid_device *hdev,
>  	return !hid_ignore_special_drivers;
>  }
>  
> -static int hid_device_probe(struct device *dev)
> +static int __hid_device_probe(struct hid_device *hdev)
>  {
> -	struct hid_driver *hdrv = to_hid_driver(dev->driver);
> -	struct hid_device *hdev = to_hid_device(dev);
> +	struct hid_driver *hdrv = to_hid_driver(hdev->dev.driver);
>  	const struct hid_device_id *id;
>  	int ret;
>  
> -	if (down_interruptible(&hdev->driver_input_lock)) {
> -		ret = -EINTR;
> -		goto end;
> -	}
>  	hdev->io_started = false;
> -
>  	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
>  
> -	if (hdev->driver) {
> -		ret = 0;
> -		goto unlock;
> -	}
> +	if (hdev->driver)
> +		return 0;
>  
> -	if (!hid_device_check_match(hdev, hdrv, &id)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}

Dmitry, which tree is this patch against, please? The code above looks 
different in current tree (and hasn't been touched for a while).

Thanks,

-- 
Jiri Kosina
SUSE Labs

