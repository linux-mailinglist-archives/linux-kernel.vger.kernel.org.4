Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A161E4EF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKFRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:36:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDD25FC4;
        Sun,  6 Nov 2022 09:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9EF60CEF;
        Sun,  6 Nov 2022 17:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A223C433C1;
        Sun,  6 Nov 2022 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667756212;
        bh=KFkAfIG8I6dG0L+fuoOEwux4EkDFFug6VihBxtyS6bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNe9f+dwYwBu5Ihh/ExrBplWFCqMJSg6AEC2sA9NieXzrO+p3mRVkHFygWwqjoxhe
         bDTx3H+z4nmn7nj4HOmjpnYwfGBLQ6BToGQwSrv7a1c2WZnB9v6/v3QlTpBRd7WpF6
         vPGPYCrDAlnRvC+AjXnh4DKsbTFD+6EVaxdlzZxw1zuOnDEXwg8bbsWVns4zatnEzL
         WpC7dl1CWGRrWRv6WlO8UjaEGPnC/NoLrmmIHR0RINGvsux69G+2UpYENvcMDP+M7v
         mfMsrdFPQnGDMikanoa4nEhCdr4oXOaK3VTMFzIm4BB2RGtYveDyxCo/VpFCy/nq3C
         2bgFd41j1QZvg==
Date:   Sun, 6 Nov 2022 17:36:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle
 sensor
Message-ID: <20221106173643.5b4f2a0b@jic23-huawei>
In-Reply-To: <20221105223422.417316-1-jekhor@gmail.com>
References: <20221105223422.417316-1-jekhor@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Nov 2022 00:34:22 +0200
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> Some devices has two sets of accelerometers and the sensor hub exports
> two hinge angle 'sensors' based on accelerometer values. To allow more
> than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
> PLATFORM_DEVID_NONE when registering platform device for it.
> 
> Checked on the Lenovo Yoga Book YB1-X91L tablet.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Purely for curiosity sake, but where are the two sets of sensors?
Doesn't look like it has two hinges at first glance!

Jonathan

> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 32c2306e240d6..a6fc89ee1287c 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -862,7 +862,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
> -						    PLATFORM_DEVID_NONE, hsdev,
> +						    PLATFORM_DEVID_AUTO, hsdev,
>  						    sizeof(*hsdev));
>  	kfree(dev_name);
>  	return custom_pdev;

