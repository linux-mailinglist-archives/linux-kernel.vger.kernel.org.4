Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E533696468
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBNNRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:17:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049524111
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9752615CE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC60AC433EF;
        Tue, 14 Feb 2023 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676380652;
        bh=YpN+6svA4pxWzICJ3d5XCgD1ctPwFrXyNccYhqNtKzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BSxoCBQNrfesKGBLviwiB/QQ+viKlLv4d91fPi+Hk8jJ9i38LTahyR4AiA/4wJd+
         yQwwTrNpIihZhs5qsc8kIFO2IgwYEyeq8f2VegIj6bVy4/6LDlyyXIOBJtDHa4rNI2
         nok0q/4D9Y4ICV9f7T0iCdOH50ra6WqTXSdIFhtE=
Date:   Tue, 14 Feb 2023 14:17:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Weifeng <suweifeng1@huawei.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com,
        zhanghongtao22@huawei.com
Subject: Re: [PATCH] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
Message-ID: <Y+uJ6ejVNl6RoQPk@kroah.com>
References: <20230214132157.472753-1-suweifeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214132157.472753-1-suweifeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 09:21:57PM +0800, Su Weifeng wrote:
> From: Weifeng Su <suweifeng1@huawei.com>
> 
> The /dev/uioX device is used by multiple processes. The current behavior
> is to clear the master bit when a process exits. This affects other
> processes that use the device, resulting in command suspension and
> timeout. This behavior cannot be sensed by the process itself.
> The solution is to add the reference counting. The reference count is
> self-incremented and self-decremented each time when the device open and
> close. The master bit is cleared only when the last process exited.
> 
> Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
> ---
>  drivers/uio/uio_pci_generic.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> index e03f9b532..d36d3e08e 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -31,6 +31,7 @@
>  struct uio_pci_generic_dev {
>  	struct uio_info info;
>  	struct pci_dev *pdev;
> +	refcount_t  dev_refc;
>  };
>  
>  static inline struct uio_pci_generic_dev *
> @@ -39,10 +40,22 @@ to_uio_pci_generic_dev(struct uio_info *info)
>  	return container_of(info, struct uio_pci_generic_dev, info);
>  }
>  
> +static int open(struct uio_info *info, struct inode *inode)
> +{
> +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> +
> +	if (gdev)
> +		refcount_inc(&gdev->dev_refc);

This flat out does not work, sorry.

You should never rely on trying to count open/release calls, just let
the vfs layer handle that for us as it currently does so.

Think about what happens if you call dup() in userspace on a
filehandle...

> +	return 0;
> +}
> +
>  static int release(struct uio_info *info, struct inode *inode)
>  {
>  	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
>  
> +	if (gdev && refcount_dec_not_one(&gdev->dev_refc))

I don't think you actually tested this as it is impossible for gdev to
ever be NULL.

sorry, but this patch is not correct.

greg k-h
