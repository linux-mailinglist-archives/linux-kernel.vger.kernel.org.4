Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAD6B6F84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCMGhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCMGhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:37:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A63864E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 610D0B80DBE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCF4C433D2;
        Mon, 13 Mar 2023 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678689451;
        bh=r9kW8lFttxXP+IM+CgVFDPUgdBtmyVi6pNxZ7oi2iEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDW3NWDXx+DN3mgyjqzm3PvnsVKTvI8/hkt/KAQ8mcFBRYanq9Zv67BPCkYB0RNaD
         C8Kk0EGbyviugjrJyvp0jEAIcGDRfq3fR64XRpHczTZxDnCaN80MSQUbIMQ49Evffn
         1yMXwiClL/P+YHQvFrM111bu4YBm/paZoOLn3HLg=
Date:   Mon, 13 Mar 2023 07:37:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA7EqO0XQ5L8fZej@kroah.com>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 10:33:19PM +0500, Khadija Kamran wrote:
> Module parameter, read_timeout, can only be set at loading time. As it
> can only be modified once, initialize read_timeout once in the probe
> function.
> As a result, only use read_timeout as the last argument in
> wait_event_interruptible_timeout() call.
> 
> Same goes for write_timeout.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index b119cec25a60..7ec8722cef7d 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -			(read_timeout >= 0) ?
> -			msecs_to_jiffies(read_timeout) :
> -			MAX_SCHEDULE_TIMEOUT);
> +			read_timeout);
>  
>  		if (ret <= 0) {
>  			if (ret == 0) {
> @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		ret = wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>  				 >= words_to_write,
> -			(write_timeout >= 0) ?
> -			msecs_to_jiffies(write_timeout) :
> -			MAX_SCHEDULE_TIMEOUT);
> +			write_timeout);
>  
>  		if (ret <= 0) {
>  			if (ret == 0) {
> @@ -814,6 +810,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	struct axis_fifo *fifo = NULL;
>  	char *device_name;
>  	int rc = 0; /* error return value */
> +	
> +	if (read_timeout >= 0)
> +		read_timeout = msecs_to_jiffies(read_timeout);
> +	else
> +		read_timeout = MAX_SCHEDULE_TIMEOUT;
> +	
> +	if (write_timeout >= 0)
> +		write_timeout = msecs_to_jiffies(write_timeout);
> +	else
> +		write_timeout = MAX_SCHEDULE_TIMEOUT;
>  
>  	/* ----------------------------
>  	 *     init wrapper device
> -- 
> 2.34.1
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
