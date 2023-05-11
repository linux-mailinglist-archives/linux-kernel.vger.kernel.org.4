Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585F6FEA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjEKEFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEKEFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:05:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E23AA5;
        Wed, 10 May 2023 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=es1hAOZEanSpUzrO4i+W99kSmiTSzzhtBMlo8JnwlYU=; b=XiM0jwFnKxFWGJpiCOPcZXBOTf
        7Lff2nNv1b4BAaAzu2+8+Z6IL8XztnltccQ/JJuih56T1wL6PGmnGsDk5E0M2IhLX/LK07JbuLSIZ
        7MeUi0RBKlVjXfF2dQ49aEOFQTTDRlx51zHwTVQTE5xRu4I0fDcigOhciITUn6bZwgzkWHvP5GDoh
        2fdZoKkTwbsFp75btQY8vp64HMyDOb8xRvh6sSFXwAn6is5GoyjejZl85uiLUVi+kd01BW70CUhr5
        tVCPkz/2NQ/hoG7jre3wotCKe/XGVrVJE/Z2HuYhiIxeH3PutobfBK7QQ7ocB4hd/asQ7TR+7XP1K
        n3LuDq7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwxYC-001apk-2B;
        Thu, 11 May 2023 04:05:08 +0000
Date:   Thu, 11 May 2023 05:05:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Weili Qian <qianweili@huawei.com>
Subject: Re: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
Message-ID: <20230511040508.GF3390869@ZenIV>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511021553.44318-1-zhangfei.gao@linaro.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

IDGI.  Going through uacce_queue instead of uacce_device is fine, but why
bother with file *or* inode?  Just store a reference to struct address_space in
your uacce_queue and be done with that...

Another problem in that driver is uacce_vma_close(); this
        if (vma->vm_pgoff < UACCE_MAX_REGION)
                qfr = q->qfrs[vma->vm_pgoff];

        kfree(qfr);
can't be right - you have q->qfrs left pointing to freed object.  If nothing
else, subsequent mmap() will fail with -EEXIST, won't it?
