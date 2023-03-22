Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C06C45E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCVJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCVJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:13:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC43CE25
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89403B81B9F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4311C433D2;
        Wed, 22 Mar 2023 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679476420;
        bh=uOs3oxeS1GwR5q2hkVL4bYk76jCzRyNx5Oxug1tN4A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOd713InPrBtYUGFWU3iZmzpTJbg9Zu8HyxvWH4coFbi/LjeE1rpSdjnAxpw0hEPY
         +ml7PbRTnw7VN7MZz5RW5+zApTnX61OmcHVIQZp8ueXGvzP+dQjTrYE4allTCeeain
         Lk+t/fpq1mBPtq0nj+dMZhILhx7mBUs+yvfTX2zI=
Date:   Wed, 22 Mar 2023 10:13:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
Message-ID: <ZBrGwZK5YA+hMVM4@kroah.com>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:34:56PM +0200, Menna Mahmoud wrote:
> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline function.
> 
> It is not great to have macros that use the `container_of` macro,
> because from looking at the definition one cannot tell what type
> it applies to.

Note, the compiler will tell you if you get this wrong, so this really
is not an issue.

The container_of() macro is "special" in that it is very type safe and
is very commonly used just as a #define to make it simpler and the
compiler can just do the pointer math automatically without ever needing
a function call to be involved.

> One can get the same benefit from an efficiency point of view
> by making an inline function.

It's actually more efficient to be a macro, so this isn't correct.

But all of this is really moot, and I would normally just take this
patch, but it's not correct:

> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> changes in v2:
> 	-send patch as a single patch.
> 	-edit the name of struct object.
> 	-edit commit message.
> ---
>  drivers/staging/greybus/gbphy.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index d4a225b76338..e7ba232bada1 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,7 +15,10 @@ struct gbphy_device {
>  	struct list_head list;
>  	struct device dev;
>  };
> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +static inline struct gbphy_device *to_gbphy_dev(const struct device *_dev)
> +{
> +	return container_of(_dev, struct gbphy_device, dev);
> +}

You need a newline right before your new function to properly set it
off.


>  
>  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>  {
> @@ -43,7 +46,10 @@ struct gbphy_driver {
>  
>  	struct device_driver driver;
>  };
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *drv)
> +{
> +	return container_of(drv, struct gbphy_driver, driver);
> +}

I'm going to be a stickler here, and say this really should be using the
new container_of_const() macro instead, and with that, you can NOT turn
it into an inline function at all due to the fun use of Generic in that
macro.

So I wouldn't recommend changing this macro at this time at all, sorry.

thanks,

greg k-h
