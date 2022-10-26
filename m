Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867460E049
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiJZMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiJZMGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849B96A36;
        Wed, 26 Oct 2022 05:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E19FA61E65;
        Wed, 26 Oct 2022 12:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE63AC43146;
        Wed, 26 Oct 2022 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666786005;
        bh=MvwPEECCTNdUVS8myaqJxMTSBLxFNIpScTXphITkRgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpW5Ebmud2wvkeprcyGE1f6yheeliW4MI+6tV1pFyTVFPRL53GAMHOk6kPnUIoLNa
         UjlMXjGn+AXEplA6MVwWQ78OeAiquHxuhpGlr09SXsmJZg8jmuNCPsJ8reXGJNBagz
         MhPurdBEWfqiQ7YnFsEw46QSRuteKSmrNSWp7TWI=
Date:   Wed, 26 Oct 2022 14:07:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <Y1kjCqUlOFJUgLqZ@kroah.com>
References: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:52:40AM +0300, Eli Billauer wrote:
> xillybus_find_inode() is called by xillybus_open() and xillyusb_open()
> to translate the inode's major and minor into a pointer to a relevant
> data structure and an index.
> 
> But with xillyusb_open(), the data structure can be freed by
> xillyusb_disconnect() during an unintentional time gap between the
> release of the mutex that is taken by xillybus_find_inode() and the
> mutex that is subsequently taken by xillyusb_open().
> 
> To fix this, xillybus_find_inode() supplies the pointer to the mutex that
> it has locked (when returning success), so xillyusb_open() releases this
> mutex only after obtaining the mutex that is specific to a device file.
> This ensures that xillyusb_disconnect() won't release anything that is in
> use.

That's really odd, and not normal at all.  We don't pass around mutexes
like this as how do you know if that's allowed?

> 
> This manipulation of mutexes poses no risk for a deadlock, because in
> all usage scenarios, @unit_mutex (which is locked by xillybus_find_inode)
> is always taken when no other mutex is locked. Hence a consistent locking
> order is guaranteed.
> 
> xillybus_open() unlocks this mutex immediately, as this driver doesn't
> support hot unplugging anyhow.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
> ---
> drivers/char/xillybus/xillybus_class.c | 8 +++++---
> drivers/char/xillybus/xillybus_class.h | 2 ++
> drivers/char/xillybus/xillybus_core.c  | 6 +++++-
> drivers/char/xillybus/xillyusb.c       | 4 +++-
> 4 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
> index 0f238648dcfe..c846dc3ed225 100644
> --- a/drivers/char/xillybus/xillybus_class.c
> +++ b/drivers/char/xillybus/xillybus_class.c
> @@ -211,6 +211,7 @@ void xillybus_cleanup_chrdev(void *private_data,
> EXPORT_SYMBOL(xillybus_cleanup_chrdev);
> 
> int xillybus_find_inode(struct inode *inode,
> +			struct mutex **to_unlock,

To unlock when?  Who unlocks it?  What is the lifespan here?

Why can't it just be part of the structure?

> 			void **private_data, int *index)
> {
> 	int minor = iminor(inode);
> @@ -227,13 +228,14 @@ int xillybus_find_inode(struct inode *inode,
> 			break;
> 		}
> 
> -	mutex_unlock(&unit_mutex);
> -
> -	if (!unit)
> +	if (!unit) {
> +		mutex_unlock(&unit_mutex);
> 		return -ENODEV;
> +	}
> 
> 	*private_data = unit->private_data;
> 	*index = minor - unit->lowest_minor;
> +	*to_unlock = &unit_mutex;

Why are you wanting the caller to unlock this?  It's a global mutex (for
the whole file), this feels really odd.

What is this function supposed to be doing?  You only return an int, and
you have some odd opaque void pointer being set.  That feels wrong and
is not a normal design at all.

confused,

greg k-h
