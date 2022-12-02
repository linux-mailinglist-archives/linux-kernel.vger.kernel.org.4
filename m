Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE95640997
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiLBP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiLBP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9123DA216
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:56:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8078D6231A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B09CC433C1;
        Fri,  2 Dec 2022 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669996568;
        bh=nNLwAfwbzR9T6nIdJ2PWoWKnrMlwwx2i2qIP7VtMd1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELDebWTHYJESGHm42Q7mNDqRc9eOB2PWSPtGeDTL2aQFDLUtX/rCiyLqwDmz0exok
         1gGQAF5ZAhqxElKtPDyfD3Z6e9CsTSPItDQ7MVPgPCrRE/hQ9Ggta8zW0BnKO/ccpw
         j8yfgUYQgUaAO+uRsigZy65w1HMNb92CqDGI0E78=
Date:   Fri, 2 Dec 2022 16:56:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: move NULLing the thread pointer before
 unregistering fs
Message-ID: <Y4ogFSOaQtZ+5Xqy@kroah.com>
References: <20221202124502.217462-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202124502.217462-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:45:01PM +0200, Alexander Atanasov wrote:
> In commit
> 31c779f293b3 ("devtmpfs: fix the dangling pointer of global devtmpfsd thread")
> a dangling pointer on an error condition was fixed. But the fix
> left the dangling pointer during unregister_filesystem and printk calls.

And how could it be used there?

> Improve the fix to clear the pointer before unregistration to close
> the window  where the dangling pointer can be potentially used.

Again, how can that happen?  And you have an extra ' ' in that line :(

> Make it clear the pointer at only one place in the function.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/base/devtmpfs.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index e4bffeabf344..773e66ef5642 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -472,17 +472,15 @@ int __init devtmpfs_init(void)
>  	}
>  
>  	thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
> -	if (!IS_ERR(thread)) {
> +	if (!IS_ERR(thread))
>  		wait_for_completion(&setup_done);
> -	} else {
> +	else
>  		err = PTR_ERR(thread);
> -		thread = NULL;
> -	}
>  
>  	if (err) {
> +		thread = NULL;
>  		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %i\n", err);
>  		unregister_filesystem(&dev_fs_type);
> -		thread = NULL;
>  		return err;
>  	}

This all feels wrong and way too complex to have to clean up from a call
to kthread_run().  Are you sure this is the correct way to do this?

And how was this "issue" found?  How does the call to kthread_run() ever
fail for you?

thanks,

greg k-h
