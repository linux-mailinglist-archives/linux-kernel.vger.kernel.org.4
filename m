Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1156BA0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCNUnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCNUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:43:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230077A92
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678826623; x=1710362623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ga2eu3CIk3Nt8VVwDK0rgtUMidyK+BHycf/u5ccxd0g=;
  b=RKPs0yXpxRVAeKsHXkbsD+Clm8XDXhWuGPNGIZURoL0vhEiM740NTsXC
   a9V2NZhQixFlRPA/iMQhb22eHbi0GDyp4k25tuQTQogCpnbNZg/vlDkt4
   rpHI7XINBqrb2+6UK+VmoNUS9Zdn6DWXSkWfq+G4EPtPEJMrNvj2UvSir
   a73rye3xm2nRL/3bmtcqCKTW1S0sFtdvDDBJmEq81arryS27YX5vS5WuW
   wUOBGMyPKJdopuI01AHUwRrXTbnyWyep/DHkbvkN3Tu5k/ODagvOjTE7J
   5+xIEN8Ba1EWdVvDdCu+w3GzhvUjXPHDJrFoxp0qqwcghc5e3036SvEz1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400120044"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="400120044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 13:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="1008572533"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="1008572533"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 13:43:41 -0700
Date:   Tue, 14 Mar 2023 13:43:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBDcfNOXmGeN2tlb@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:07:10PM +0500, Khadija Kamran wrote:
> Module parameter, read_timeout, can only be set at the loading time. As
> it can only be modified once, initialize read_timeout once in the probe
> function.
> As a result, only use read_timeout as the last argument in
> wait_event_interruptible_timeout() call.
> 
> Same goes for write_timeout.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---

Looks like this is [PATCH v5] and needs a changelog.


>  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..563caf155713 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >= 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			read_timeout);
>  
>  		if (ret <= 0) {
>  			if (ret == 0) {
> @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		ret = wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>  				 >= words_to_write,
> -				 (write_timeout >= 0) ?
> -				  msecs_to_jiffies(write_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			write_timeout);
>  
>  		if (ret <= 0) {
>  			if (ret == 0) {
> @@ -815,6 +811,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	char *device_name;
>  	int rc = 0; /* error return value */
>  
> +	if (read_timeout >= 0)
> +		read_timeout = msecs_to_jiffies(read_timeout);
> +	else
> +		read_timeout = MAX_SCHEDULE_TIMEOUT;
> +
> +	if (write_timeout >= 0)
> +		write_timeout = msecs_to_jiffies(write_timeout);
> +	else
> +		write_timeout = MAX_SCHEDULE_TIMEOUT;
> +
>  	/* ----------------------------
>  	 *     init wrapper device
>  	 * ----------------------------
> -- 
> 2.34.1
> 
> 
