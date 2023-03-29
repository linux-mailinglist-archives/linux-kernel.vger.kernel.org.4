Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DC6CD74E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjC2KHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC2KHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:07:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92198B5;
        Wed, 29 Mar 2023 03:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3E70CE1FD3;
        Wed, 29 Mar 2023 10:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5C4C433EF;
        Wed, 29 Mar 2023 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084464;
        bh=jxsrRCmaqY1PZygl7A7OWDWEQs91XASFaSIP4jc/LyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcFrOTMN0AG2eJC7VzghJ8ZwGIZcMLBSZvPeWvL+7Cjb9gFOKi/pYTguQ83mPS4Fj
         vqMKcF9EJ0mZotczB/I6jW1VZR0hQnQxOExV88C0f/i4P5sX4O6i65CDNPkCcx/Ven
         LAhEhg0cWQ9+iB3T3QP58PSAnsPPJjqoaXGeCxXk=
Date:   Wed, 29 Mar 2023 12:07:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v3 1/4] eeprom: ee1004: Enable devices on multiple busses
Message-ID: <ZCQN7uq7Y3xFY1od@kroah.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
 <20230322140348.569397-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322140348.569397-2-eajames@linux.ibm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:03:45AM -0500, Eddie James wrote:
> The driver previously prevented probing devices on more than one
> bus due to locking constraints with the special page addresses. This
> constraint can be removed by allocating a reference-counted bus
> structure containing the lock, rather than using global variables.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v2:
>  - Remove of_device.h include
> 
>  drivers/misc/eeprom/ee1004.c | 174 +++++++++++++++++++++--------------
>  1 file changed, 105 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index c8c6deb7ed89..0aed5760e370 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -9,9 +9,11 @@
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
>   */
>  
> +#include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -31,20 +33,24 @@
>   * over performance.
>   */
>  
> -#define EE1004_ADDR_SET_PAGE		0x36
> +#define EE1004_ADDR_SET_PAGE0		0x36
> +#define EE1004_ADDR_SET_PAGE1		0x37
>  #define EE1004_NUM_PAGES		2
>  #define EE1004_PAGE_SIZE		256
>  #define EE1004_PAGE_SHIFT		8
>  #define EE1004_EEPROM_SIZE		(EE1004_PAGE_SIZE * EE1004_NUM_PAGES)
>  
> -/*
> - * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
> - * from page selection to end of read.
> - */
> -static DEFINE_MUTEX(ee1004_bus_lock);
> -static struct i2c_client *ee1004_set_page[EE1004_NUM_PAGES];
> -static unsigned int ee1004_dev_count;
> -static int ee1004_current_page;
> +struct ee1004_bus {
> +	struct kref kref;
> +	struct list_head list;
> +	struct mutex lock;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *set_page_clients[EE1004_NUM_PAGES];
> +	int page;
> +};
> +
> +static LIST_HEAD(ee1004_busses);
> +static DEFINE_MUTEX(ee1004_busses_lock);

This really looks like you are just emulating a tiny portion of the
driver core (busses, lists of busses, reference counting, etc.)

Why not just use an aux device instead and get all of that logic "for
free" in a way that will be properly shown to userspace?  Right now it
has no idea what is happening here with individual portions of the
device and the like.

Please look into that instead of this hand-rolled device model.

thanks,

greg k-h
