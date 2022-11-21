Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C1632F86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiKUWES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKUWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:04:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2147EAE7C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC2FA6149B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1257C433D6;
        Mon, 21 Nov 2022 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669068251;
        bh=d4gYDV9Z2QaWJMVQGXESAv3TG0TB1/00cpoGgXs6/xw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NgR1z4SAUS85F9XfMAW80BKSaxJPdNJPBy5oI9jOprpQAVAinPEfzore/OIGyB7fe
         eFN50S0eMxCT0ehWJ8O5PrYKqrwbVEUDp4oZRvFj0qd+Q6+l8gwS4ylBRxXjevqAjn
         DW5JokfG9KWrxLiBxKLWaVF+l3fG540D2eq35d6k=
Date:   Mon, 21 Nov 2022 14:04:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <yangyingliang@huawei.com>, <jakobkoschel@gmail.com>,
        <jhubbard@nvidia.com>, <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rapidio: fix possible UAF when kfifo_alloc() fails
Message-Id: <20221121140410.dfe2816f743c62fe0c71639d@linux-foundation.org>
In-Reply-To: <20221119040335.46794-1-wangweiyang2@huawei.com>
References: <20221119040335.46794-1-wangweiyang2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 12:03:35 +0800 Wang Weiyang <wangweiyang2@huawei.com> wrote:

> If kfifo_alloc() fails in mport_cdev_open(), goto err_fifo and just free
> priv. But priv is still in the chdev->file_list, then list traversal
> may cause UAF. This fixes the following smatch warning:
> 
> drivers/rapidio/devices/rio_mport_cdev.c:1930 mport_cdev_open() warn: '&priv->list' not removed from list
> 
> ...
>
> Changes in v2:
> - Avoid adding the new instance onto the list until the new instance
>   has been fully initialized.

But it still isn't fully initialized.

>  drivers/rapidio/devices/rio_mport_cdev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 3cc83997a1f8..86b28c4cd906 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1904,10 +1904,6 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>  
>  	priv->md = chdev;
>  
> -	mutex_lock(&chdev->file_mutex);
> -	list_add_tail(&priv->list, &chdev->file_list);
> -	mutex_unlock(&chdev->file_mutex);
> -
>  	INIT_LIST_HEAD(&priv->db_filters);
>  	INIT_LIST_HEAD(&priv->pw_filters);
>  	spin_lock_init(&priv->fifo_lock);
> @@ -1920,6 +1916,9 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>  		ret = -ENOMEM;
>  		goto err_fifo;
>  	}
> +	mutex_lock(&chdev->file_mutex);
> +	list_add_tail(&priv->list, &chdev->file_list);
> +	mutex_unlock(&chdev->file_mutex);
>  
>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>  	INIT_LIST_HEAD(&priv->async_list);

Here we're still setting up state at *priv.  I'm thinking the list
addition shouldn't occur until after the 

	filp->private_data = priv;

Or just prior to it.  I'm not sure what the atomicity rules are for
file.private versus mport_dev.file_list.
