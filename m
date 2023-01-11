Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC8665CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbjAKNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAKNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:49 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74147389F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:31:23 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 016B21BF204;
        Wed, 11 Jan 2023 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673443882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qf6yWNlKr7QSyIfIHzw7LhyhtqaNkxcbBpvkY0oQPe8=;
        b=OEuM4d9gx3xOYzBNMmCy1p+OKc4MSv+8UWQ+YZpuSHm2QVEGYOqFWbBF+LVIl1EO9uGV1Z
        cyr9/sWiVA6Q6K/WQbw1MTvcCnUh31tdOKYtrLWcplsusog9W76JQz+x5CZey0YyMqv3RX
        QzLsGPnPhVSRgCKwy5BIskfzHDG3v8noh7DN6LCL31N/NlPwRSgqFA1+8/CFim7ElONoWz
        t9DuAURl5GA3mhLPjeFhVYUSqvYehzuZaKHoIlz6l6aiagzOUSr5Y137NNfm2K1SmR2kXQ
        izP8Ulh6j/syJ81EMr/TI4j0od3V/HeS/e2kBjQBkWu3dwtJO1J6YlGoVQxYbQ==
Date:   Wed, 11 Jan 2023 14:31:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [PATCH v2 02/16] i3c: move dev_to_i3cdev() to use
 container_of_const()
Message-ID: <Y766KHAN9oeQX1At@mail.local>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111113018.459199-3-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 12:30:04+0100, Greg Kroah-Hartman wrote:
> The driver core is changing to pass some pointers as const, so move
> dev_to_i3cdev() to use container_of_const() to handle this change.
> dev_to_i3cdev() now properly keeps the const-ness of the pointer passed
> into it, while as before it could be lost.
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/i3c/device.c       | 12 ------------
>  include/linux/i3c/device.h |  9 ++++++++-
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 9762630b917e..d111499061b2 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -208,18 +208,6 @@ struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
>  }
>  EXPORT_SYMBOL_GPL(i3cdev_to_dev);
>  
> -/**
> - * dev_to_i3cdev() - Returns the I3C device containing @dev
> - * @dev: device object
> - *
> - * Return: a pointer to an I3C device object.
> - */
> -struct i3c_device *dev_to_i3cdev(struct device *dev)
> -{
> -	return container_of(dev, struct i3c_device, dev);
> -}
> -EXPORT_SYMBOL_GPL(dev_to_i3cdev);
> -
>  /**
>   * i3c_device_match_id() - Returns the i3c_device_id entry matching @i3cdev
>   * @i3cdev: I3C device
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 1c997abe868c..68b558929aec 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -186,7 +186,14 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
>  }
>  
>  struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
> -struct i3c_device *dev_to_i3cdev(struct device *dev);
> +
> +/**
> + * dev_to_i3cdev() - Returns the I3C device containing @dev
> + * @dev: device object
> + *
> + * Return: a pointer to an I3C device object.
> + */
> +#define dev_to_i3cdev(__dev)	container_of_const(__dev, struct i3c_device, dev)
>  
>  const struct i3c_device_id *
>  i3c_device_match_id(struct i3c_device *i3cdev,
> -- 
> 2.39.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
