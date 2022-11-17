Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC47162E61A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiKQUpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiKQUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:45:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FE5597
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4C262245
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D439C433C1;
        Thu, 17 Nov 2022 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668717918;
        bh=EOrXBauR4yrNyEgewtXc3MPjEK0rmkIMgfLwn6Fzia8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvmgMim8jJzXD9E0y+KTE/sI0XKkzb/5fDuSiZnhNuRSapV3IiAbXlG7LaXPAnLK7
         RXtnB06pXoWGRfJ26sFOZQR9rPPPaT2OjwE99vaK8DgqWFURoFHySHCCiE6bEYVup5
         YuV9AYOv6oOZ7eIrtGxkpJwE9GQQ5K1ZWVnJYv1c=
Date:   Thu, 17 Nov 2022 12:45:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <yangyingliang@huawei.com>, <jakobkoschel@gmail.com>,
        <jhubbard@nvidia.com>, <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rapidio: fix possible UAF when kfifo_alloc() fails
Message-Id: <20221117124517.9d8290e553b1e6d76b1ff7e8@linux-foundation.org>
In-Reply-To: <20221117021802.46872-1-wangweiyang2@huawei.com>
References: <20221117021802.46872-1-wangweiyang2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 17 Nov 2022 10:18:02 +0800 Wang Weiyang <wangweiyang2@huawei.com> wrote:

> If kfifo_alloc() fails in mport_cdev_open(), goto err_fifo and just free
> priv. But priv is still in the chdev->file_list, then list traversal
> may cause UAF. This fixes the following smatch warning:
> 
> drivers/rapidio/devices/rio_mport_cdev.c:1930 mport_cdev_open() warn: '&priv->list' not removed from list
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 3cc83997a1f8..c66b2c552b38 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1930,6 +1930,9 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>  	filp->private_data = priv;
>  	goto out;
>  err_fifo:
> +	mutex_lock(&chdev->file_mutex);
> +	list_del(&priv->list);
> +	mutex_unlock(&chdev->file_mutex);
>  	kfree(priv);
>  out:
>  	return ret;

Surely it would be better to avoid adding the new instance onto the
list until the new instance has been fully initialized?

