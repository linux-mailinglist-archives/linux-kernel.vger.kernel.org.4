Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51636724127
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjFFLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjFFLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABC10F6;
        Tue,  6 Jun 2023 04:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D69C6283C;
        Tue,  6 Jun 2023 11:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2036C433D2;
        Tue,  6 Jun 2023 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686051523;
        bh=HH9pjvq7yc5IM5jecOoC9eC3Ehu2iWD+fjeOIBicpnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkVUQ05AKTPwxgB3B9vE1AoNW851mF6RY5RE8j8mtJ0oCYWVNGFkhkZbts1vg3Iyq
         H5xUZOfxwRl0OYomop0wrhA7oBEWmICdYGdCrcznQjYy3NKwdYmPpdimRExxYh6GCH
         tCvkqsKKeBudzhPrF7TnACrxQZa6iGQ0eG94oI9/MFQHQ/76EqvZEtmT1MCfqLp7My
         t/7UijlcjlOxSERG5aq27xqvJGNy0ifQgF8o2JSc4RFi2koYAPFe44dP5odxDWQu2o
         IN+0Xc78LhZeNgS17NjlA0bR7ldSNFSw0irFZntuXLJeoreH4Z+SkWqp2cib8Hr/oQ
         hh3vqu8Cp7aJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6V1j-00068v-5W; Tue, 06 Jun 2023 13:39:03 +0200
Date:   Tue, 6 Jun 2023 13:39:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v2 0/3] USB: serial: return errors from break handling
Message-ID: <ZH8a12ZYtA2RzEK_@hovoldconsulting.com>
References: <20230604123505.4661-1-johan@kernel.org>
 <726a6f5f-5338-50a9-3081-7c02194dd7af@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726a6f5f-5338-50a9-3081-7c02194dd7af@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:18:19PM +0200, Oliver Neukum wrote:
> On 04.06.23 14:35, Johan Hovold wrote:
> > This series starts returning errors from break handling and also uses
> > that mechanism to report to user space when break signalling is not
> > supported (e.g. when device or driver support is missing).

> do you eventually want this to be done for all serial devices?
> That is does cdc-acm need something like this patch?

Looks good to me. If this turns out to confuse userspace we may have to
turn that -ENOTTY into 0 in the tty layer, but we can still use it to
avoid the unnecessary wait to "disable" the break state.

> From 16430d9f109f904b2bfbac6e43a939209b6c4bc7 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Tue, 6 Jun 2023 12:57:00 +0200
> Subject: [PATCH] usb: cdc-acm: return correct error code on unsupported break
> 
> Return -ENOTTY if the device says that it doesn't support break
> so that the upper layers get error reporting right.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Acked-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/usb/class/cdc-acm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 11da5fb284d0..7751f5728716 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -892,6 +892,9 @@ static int acm_tty_break_ctl(struct tty_struct *tty, int state)
>  	struct acm *acm = tty->driver_data;
>  	int retval;
>  
> +	if (!(acm->ctrl_caps & USB_CDC_CAP_BRK))
> +		return -ENOTTY;
> +
>  	retval = acm_send_break(acm, state ? 0xffff : 0);
>  	if (retval < 0)
>  		dev_dbg(&acm->control->dev,
