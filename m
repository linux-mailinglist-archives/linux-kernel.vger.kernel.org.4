Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E326701C00
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjENGiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45481FEA
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EA360FBB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9141DC433EF;
        Sun, 14 May 2023 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684046278;
        bh=E0hJNeluinyMUhmWFoGDbW0eO1GmmRxA0vP/bh4Hrl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgLjKAc7YVb0mpnmNxUi9iBOdRoupTW8zcf3gTNmHC296CsPfDfw6i43iCW7bqgSo
         0w0SkcqJe1JKqe9HJE4bRo1Tt303f44W8VbTDog2lJ2u88igqGUvkSLB+SiGsh6Rjj
         TjSQrojel24RlT5TI1ro9xGOOjNY4wWuICsXB8m0=
Date:   Sun, 14 May 2023 08:37:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] axis-fifo: use devm_kasprintf for device name
Message-ID: <2023051411-happier-mural-a8ef@gregkh>
References: <20230513214029.122689-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513214029.122689-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 03:10:27AM +0530, Prathu Baronia wrote:
> - Replaces devm_kzalloc and snprintf combo.
> - Also made the fops alignment proper.
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..8b46699efb34 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -720,11 +720,11 @@ static int axis_fifo_close(struct inode *inod, struct file *f)
>  }
>  
>  static const struct file_operations fops = {
> -	.owner = THIS_MODULE,
> -	.open = axis_fifo_open,
> +	.owner   = THIS_MODULE,
> +	.open    = axis_fifo_open,
>  	.release = axis_fifo_close,
> -	.read = axis_fifo_read,
> -	.write = axis_fifo_write
> +	.read    = axis_fifo_read,
> +	.write   = axis_fifo_write
>  };
>  
>  /* read named property from the device tree */
> @@ -820,10 +820,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	 * ----------------------------
>  	 */
>  
> -	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
> -	if (!device_name)
> -		return -ENOMEM;
> -
>  	/* allocate device wrapper memory */
>  	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
>  	if (!fifo)
> @@ -861,7 +857,9 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
>  
>  	/* create unique device name */
> -	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
> +	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
> +	if (!device_name)
> +		return -ENOMEM;
>  	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
>  
>  	/* ----------------------------
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
