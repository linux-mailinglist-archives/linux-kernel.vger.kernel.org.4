Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC46FEA51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjEKDom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEKDok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8E30FB;
        Wed, 10 May 2023 20:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1730B64160;
        Thu, 11 May 2023 03:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1A6C433EF;
        Thu, 11 May 2023 03:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683776678;
        bh=0znUxwXk2K0JJbiEiLhhTK64Sd0XVZz9CaoB7WaSTOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk8439F0iNdydOVyHAr9ets543Vgaznl/4yqDjkXoVux9ZjftvyQTZKHy/3L7kEoV
         OGbQmqdKeom9HSU1lSxUVe+c4t8x2H7VtWNr+/CSk1hjtrzqE/JMN8SQEH9HlRDGaC
         UgfyfVLeoAhSW7y0DKufd0mGLED6PyZ5cwOPuEgk=
Date:   Thu, 11 May 2023 12:44:32 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Weili Qian <qianweili@huawei.com>
Subject: Re: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
Message-ID: <2023051110-jelly-barricade-d737@gregkh>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511021553.44318-1-zhangfei.gao@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:15:53AM +0800, Zhangfei Gao wrote:
> The inode can be different in a container, for example, a docker and host
> both open the same uacce parent device, which uses the same uacce struct
> but different inode, so uacce->inode is not enough.
> 
> What's worse, when docker stops, the inode will be destroyed as well,
> causing use-after-free in uacce_remove.
> 
> So use q->filep->f_mapping to replace uacce->inode->i_mapping.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 16 +++++++++-------
>  include/linux/uacce.h      |  4 ++--
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 346bd7cf2e94..740ace422baa 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -166,8 +166,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  
>  	init_waitqueue_head(&q->wait);
>  	filep->private_data = q;
> -	uacce->inode = inode;
>  	q->state = UACCE_Q_INIT;
> +	q->private_data = filep;
>  	mutex_init(&q->mutex);
>  	list_add(&q->list, &uacce->queues);
>  	mutex_unlock(&uacce->mutex);
> @@ -574,12 +574,6 @@ void uacce_remove(struct uacce_device *uacce)
>  
>  	if (!uacce)
>  		return;
> -	/*
> -	 * unmap remaining mapping from user space, preventing user still
> -	 * access the mmaped area while parent device is already removed
> -	 */
> -	if (uacce->inode)
> -		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
>  
>  	/*
>  	 * uacce_fops_open() may be running concurrently, even after we remove
> @@ -589,6 +583,8 @@ void uacce_remove(struct uacce_device *uacce)
>  	mutex_lock(&uacce->mutex);
>  	/* ensure no open queue remains */
>  	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
> +		struct file *filep = q->private_data;
> +
>  		/*
>  		 * Taking q->mutex ensures that fops do not use the defunct
>  		 * uacce->ops after the queue is disabled.
> @@ -597,6 +593,12 @@ void uacce_remove(struct uacce_device *uacce)
>  		uacce_put_queue(q);
>  		mutex_unlock(&q->mutex);
>  		uacce_unbind_queue(q);
> +
> +		/*
> +		 * unmap remaining mapping from user space, preventing user still
> +		 * access the mmaped area while parent device is already removed
> +		 */
> +		unmap_mapping_range(filep->f_mapping, 0, 0, 1);
>  	}
>  
>  	/* disable sva now since no opened queues */
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 0a81c3dfd26c..64b800b74436 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -86,6 +86,7 @@ enum uacce_q_state {
>   * @state: queue state machine
>   * @pasid: pasid associated to the mm
>   * @handle: iommu_sva handle returned by iommu_sva_bind_device()
> + * @private_data: private data for saving filep
>   */
>  struct uacce_queue {
>  	struct uacce_device *uacce;
> @@ -97,6 +98,7 @@ struct uacce_queue {
>  	enum uacce_q_state state;
>  	u32 pasid;
>  	struct iommu_sva *handle;
> +	void *private_data;

Make this a real pointer to the inode, no need to make this "void *",
right?

thanks,

greg k-h
