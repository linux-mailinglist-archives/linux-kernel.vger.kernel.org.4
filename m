Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC613674E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjATH01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjATH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B04DBF2;
        Thu, 19 Jan 2023 23:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF73061E00;
        Fri, 20 Jan 2023 07:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E2C433EF;
        Fri, 20 Jan 2023 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199584;
        bh=7nVEl6JJZLed7Nl7C2s6XG1yZRWj0y/ArkqnYAsBCas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+Znc86XB1XpU07Nvnee1eXMRZg215+DuVIoGUYOUOqpOwsl8FvWC/9uPLgSGFI9Y
         r6EBEZY0+gWxp5IvOL/D5ooA9Gmqw6shufogb7SOTHYvCDl54CYNEWIOgdJMxht+vt
         jSgcDsjqKxPT4smfYh+WJkW1bhbFNsT3r55NCAuM=
Date:   Fri, 20 Jan 2023 08:26:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify
 code
Message-ID: <Y8pCHeVNDjGYCh3L@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:06AM +0200, Andy Shevchenko wrote:
> Use DEFINE_SHOW_ATTRIBUTE() helper macro to simplify the code.
> No functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/pktcdvd.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index a53d21dbf2ab..2c5441303e55 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -504,24 +504,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
>  			pd->write_congestion_on);
>  	return 0;
>  }
> -
> -static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
> -{
> -	return pkt_seq_show(m, p);
> -}
> -
> -static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
> -}
> -
> -static const struct file_operations debug_fops = {
> -	.open		= pkt_debugfs_fops_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(pkt_seq);
>  
>  static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>  {
> @@ -531,8 +514,8 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>  	if (!pd->dfs_d_root)
>  		return;

This check shouldn't be here either.

> -	pd->dfs_f_info = debugfs_create_file("info", 0444,
> -					     pd->dfs_d_root, pd, &debug_fops);
> +	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
> +					     pd, &pkt_seq_fops);

For further cleanup, there's no need to keep this dentry at all as the
whole directory is later removed.

But that's future cleanups, for this, nice work:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
