Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0946B5BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCKM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCKM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:26:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085D12B7D4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE0E60B65
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 12:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02895C433EF;
        Sat, 11 Mar 2023 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678537601;
        bh=9YpHoplazewHr1nZXu365XUjLxsDneDUTbn5yRvSytw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYJq0EIKX3uSEZkC2fdRfFBZuMvdQYIhMVW1L7SQPCSGDShMEEQxqbFN4MXDSVl2E
         YsEvkbTuX0whYqqU+BAFKoTbKVcxCWNwGtaD9mrC1knfI905PPJTsxiJlAJ1OTX9ig
         s1r+vfvOinxaFdGzr9nRGY7XepH44URSvrR0CJGM=
Date:   Sat, 11 Mar 2023 13:26:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: axis-fifo: remove tabs to align arguments
Message-ID: <ZAxzfiOoW0SfW5qD@kroah.com>
References: <ZAxsyX8n7G92nlJh@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAxsyX8n7G92nlJh@khadija-virtual-machine>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 04:58:01PM +0500, Khadija Kamran wrote:
> In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, the
> last argument is indented as if it were an argument of the second
> argument. Remove tabs to align the arguments.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changes in v3:
>  - Do not align the line 530 since it is not part of the last argument.
> 
>  drivers/staging/axis-fifo/axis-fifo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..b119cec25a60 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -384,9 +384,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >= 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			(read_timeout >= 0) ?
> +			msecs_to_jiffies(read_timeout) :
> +			MAX_SCHEDULE_TIMEOUT);

People have been trying to "polish" this mess for a long time, and I
think it's better to step back and see what is really needed here.

There is a module parameter, read_timeout, that can only be set at
loading time.  As it can only be modified once, why are we doing an if
statement each and every time it is read from?

Instead, in the module probe function, how about doing something like:
	if (read_timeout >= 0)
		read_timeout = msecs_to_jiffies(read_timeout);
	else
		read_timeout = MAX_SCHEDULE_TIMEOUT;

and then only ever use "read_timeout" here in the
wait_event_interruptiable() call?  That should simplify this much more
overall, and hopefully allow us to just get rid of the module parameter
eventually as that's not how drivers should be working at all anymore.

Same goes for write_timeout.

Overall the code should be much simpler and easier to understand, which
is the end goal here.

Can you try doing that instead?

thanks,

greg k-h
