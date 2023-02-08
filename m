Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6D68F455
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBHRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:23:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA530D0;
        Wed,  8 Feb 2023 09:23:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13666173D;
        Wed,  8 Feb 2023 17:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5164C433EF;
        Wed,  8 Feb 2023 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675877000;
        bh=f7lbVLT+REpVNqHg1t7vnuuVkSw7G6LK2Di8+p3BbFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4GANNecDIKw6xmYFqwin3nXWXkEUqWio1dC0XUg05da/RF4sdM2BfyhukpVEdrJu
         cQMSrNSRvwTwuCZZRrFRHHMOF0m9BiOY2oQjY+dtsvj/vVwmsjnAzDcEe6x9d6fc+s
         aGGSoJceZGgjDAM5Ap7894Te6bcL9k9JErM35SrQ=
Date:   Wed, 8 Feb 2023 18:23:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jassisinghbrar@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, stern@rowland.harvard.edu,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] usb: gadget: udc: max3420_udc: fix serialized access
Message-ID: <Y+PafyViJMb6OOAn@kroah.com>
References: <20230208163418.342210-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208163418.342210-1-jassisinghbrar@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:34:18AM -0600, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
>  The mutex 'spi_bus_mutex' should be used, instead of the spin-lock,
> while changing the state of the kernel-thread.

You forgot to say why this is the case.

> Also changing the
> usb-gadget state need not be protected by a spin-lock.

Why not?  Why isn't this a separate change?

>  This should fix the Smatch static checker warning
>     warn: sleeping in atomic context
> 
> Fixes: 48ba02b2e2b1 ("usb: gadget: add udc driver for max3420")
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/usb/gadget/udc/max3420_udc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

You forgot a "Reported-by:" line, right?

And odd indentation in your changelog text.


thanks,

greg k-h
