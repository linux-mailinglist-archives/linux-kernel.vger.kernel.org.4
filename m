Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1596281D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiKNOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiKNOBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:01:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C435222BE;
        Mon, 14 Nov 2022 06:01:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C83D961184;
        Mon, 14 Nov 2022 14:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3185C433C1;
        Mon, 14 Nov 2022 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434497;
        bh=LgDnjseORhZExlo2nhe2J78gfD34hpPFA6GxeMuZ/lI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=My/UbDj0YwGchhbSPgdtOYMXRFNPOXQ9AvQgRMhUkws/fU5YlQAwbUOZMXelHYgKD
         lqEci54UQs5uXXO9q5zcI6aUJ2xBDoWc9rGtZ6ctBuuoveuViRe01e150GdqhB0llO
         phAQ1tOkRMUWLTsZ7gabgn3sWQH7q20BSsRVl6FZe2SBmQ4nUuuD53xXVvz9rT8yVe
         k81ZWRfinyZ3AWCOX15m4Dl8mP6gS/tEu06BDRkqEN7jJKzM8DEQDkb9Zj2195DV92
         hD4IzdmKF5sq/7cUx0dkZDg2aBl2oqGe0Ii+nYTq19NZ5xjrbsiV0dCa++hxNLuFLb
         y4zJrUnKyTpLQ==
Date:   Mon, 14 Nov 2022 15:01:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle
 sensor
In-Reply-To: <20221105223422.417316-1-jekhor@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211141501290.6045@cbobk.fhfr.pm>
References: <20221105223422.417316-1-jekhor@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022, Yauhen Kharuzhy wrote:

> Some devices has two sets of accelerometers and the sensor hub exports
> two hinge angle 'sensors' based on accelerometer values. To allow more
> than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
> PLATFORM_DEVID_NONE when registering platform device for it.
> 
> Checked on the Lenovo Yoga Book YB1-X91L tablet.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
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

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

