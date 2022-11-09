Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C16224A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKIHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKIHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:30:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A41EEF5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B2B614D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5C0C433D6;
        Wed,  9 Nov 2022 07:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667979029;
        bh=A7qt0zFqAaMzmKHQqsEQpxmG5gXY5Z/MDjAh8xxm+Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKbJbSnPC/vbm6nr0l4ySwZbWNlOLsm4jzpCufyhgeV8ORzOrhSpquySZriHG1/Tk
         h4A4fJNBqvNNQ1kHPeSpc/xqDaVOuBzakyMuE+5LTg1D9aJVD9T6Z4KjJIC8lSQMXs
         Nrb96WvDIgbV94vy9Prf5Huj0GWzGZEeb6IVzF9I=
Date:   Wed, 9 Nov 2022 08:30:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fieldbus: replace snprintf in show functions
 with sysfs_emit
Message-ID: <Y2tXEibm2QxH37FK@kroah.com>
References: <Y2tBJFSsyUzdb+eO@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2tBJFSsyUzdb+eO@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:26:52AM +0530, Deepak R Varma wrote:
> The show() methods should only use sysfs_emit() when formatting values
> to be returned to the user space.
> Ref: Documentation/filesystems/sysfs.rst
> Issue identified by coccicheck.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Changes in v2:
>    1. Switch to using sysfs_emit instead of scnprintf
>    2. Update patch subject and log accordingly
>       Feedback from gregkh@linuxfoundation.org
> 
> 
>  drivers/staging/fieldbus/dev_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
> index 5aab734606ea..d32599f4eb44 100644
> --- a/drivers/staging/fieldbus/dev_core.c
> +++ b/drivers/staging/fieldbus/dev_core.c
> @@ -67,10 +67,10 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
>  	struct fieldbus_dev *fb = dev_get_drvdata(dev);
> 
>  	/*
> -	 * card_name was provided by child driver, could potentially be long.
> -	 * protect against buffer overrun.
> +	 * sysfs provides PAGE_SIZE long buffer to take care of potentially

No need to ever mention PAGE_SIZE at all, this comment should just be:
	/* card_name was provided by child driver */

But the larger question is, why did you only convert one of the sysfs
show functions in this file?  Why not do them all?

thanks,

greg k-h
