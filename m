Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD8D649405
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiLKL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLKL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:57:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D3EE17;
        Sun, 11 Dec 2022 03:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD1E960DC9;
        Sun, 11 Dec 2022 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216F2C433D2;
        Sun, 11 Dec 2022 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670759852;
        bh=mWMkULjKxBFFnGTfZ+MLCpvFKUSoafn+wfGvflQmGqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9/2QCl2+/dX9s4wmGfcKzs8hZVsTlpp7vUYeCKOZI5hgDb+oYjjKuGKN/hkk5H+F
         2g84VQhf5/cCC55ZmCLul6CKTRlqXXwHpIOQoX0HSYiiPTsUYrIk1uq77cJ/l1XZlb
         tWHRofg8Zakjq7ygl/zIni6W9Xx7WdgfVKnEwW1Rz/ZSLva0IsKlQR9iZkHP9wAzzs
         uB4H2EaSZgKC6JaQiWM5b7tFDysVKT0zxN4nskF4OdzDImgsecH1DoBuwClClcn7mW
         YYUSFtrF06M0l4sgmz5jfhZ3gzjTTf+q+vxPenPtCoF1FGVdqt0HoIIPJKIfLWriN9
         SWk4lnV6nQlAg==
Date:   Sun, 11 Dec 2022 12:10:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <ye.xingchen@zte.com.cn>
Cc:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: health: afe440x: Convert to use sysfs_emit_at()
 API
Message-ID: <20221211121026.10920c57@jic23-huawei>
In-Reply-To: <202212071537405832465@zte.com.cn>
References: <202212071537405832465@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 15:37:40 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iio/health/afe440x.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
> index 0adea0047eba..7750b1adc423 100644
> --- a/drivers/iio/health/afe440x.h
> +++ b/drivers/iio/health/afe440x.h
> @@ -122,9 +122,7 @@ static ssize_t _name ## _show(struct device *dev,			\
>  	int i;								\
>  									\
>  	for (i = 0; i < ARRAY_SIZE(_table); i++)			\
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ", \
> -				 _table[i].integer,			\
> -				 _table[i].fract);			\
> +		len += sysfs_emit_at(buf, len, "%d.%06u ", _table[i].integer, _table[i].fract); \
Please keep to the shorter original wrapping on this.
It's fine to go above 80 chars (below 100) if it makes a significant improvement
to readability.  I don't think that's true here, so better to stick to the shorter length.

>  									\
>  	buf[len - 1] = '\n';						\
>  									\

