Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02364CD02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLNPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiLNPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:24:42 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9E7A622507
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:24:38 -0800 (PST)
Received: (qmail 927728 invoked by uid 1000); 14 Dec 2022 10:24:37 -0500
Date:   Wed, 14 Dec 2022 10:24:37 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>,
        Frank Li <Frank.Li@nxp.com>, Rondreis <linhaoguo86@gmail.com>
Subject: Re: [PATCH] USB: gadget: Add ID numbers to configfs-gadget driver
 names
Message-ID: <Y5nqtYa9yC8YY839@rowland.harvard.edu>
References: <20221213041203.21080-1-chanh@os.amperecomputing.com>
 <720b814d-5102-04d3-4938-33a25e87a46d@wanadoo.fr>
 <6044a542-fbcd-0fe7-abd3-83f38b731ecc@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6044a542-fbcd-0fe7-abd3-83f38b731ecc@amperemail.onmicrosoft.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:15:48AM +0700, Chanh Nguyen wrote:

> Thanks CJ for the review!
> 
> I've made some changes as below (in gadgets_make() to remove unnecessary
> variables) and now trying to test it as much as possible. Will re-post it as
> v2 if looks good soon.
> 
> static inline struct gadget_info *to_gadget_info(struct config_item *item)
> @@ -1623,13 +1629,25 @@ static struct config_group *gadgets_make(
> 
>      gi->composite.gadget_driver = configfs_driver_template;
> 
> +    gi->driver_id_number = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +    if (gi->driver_id_number < 0)
> +        goto err;
> +
> +    gi->composite.gadget_driver.driver.name =
> +                          kasprintf(GFP_KERNEL, "configfs-gadget.%d",
> +                                    gi->driver_id_number);
> +    if (!gi->composite.gadget_driver.driver.name)
> +        goto out_free_driver_id_number;
> +
>      gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>      gi->composite.name = gi->composite.gadget_driver.function;
> 
>      if (!gi->composite.gadget_driver.function)
> -        goto err;
> +        goto out_free_driver_id_number;

This should goto out_free_driver_name.

Alan Stern

> 
>      return &gi->group;
> +
> +out_free_driver_id_number:
> +    ida_free(&driver_id_numbers, gi->driver_id_number);
>  err:
>      kfree(gi);
>      return ERR_PTR(-ENOMEM);
