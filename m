Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1B466AC69
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjANQEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjANQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C5901D;
        Sat, 14 Jan 2023 08:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB97B80884;
        Sat, 14 Jan 2023 16:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A83C433D2;
        Sat, 14 Jan 2023 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673712251;
        bh=gHs5qQbPcvSB1cDmNEt/ExisBhwloQ4/ZJ9WLvyno2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B70kyxRhz/FT2yC5bj/XASnWVoShbWYL3n/Q2/Juj3MV4TWF8li6TZW0oECX2oyyI
         PTBmLJGFyrLZR49ooCHtVGBfGLFHdvWJgC4jK/xHYFcdAcIuKaCHNU+lXasvMtbQSq
         GbpVbc5cM3rpXNQJre5j5TRWI296pUJPCJuEDDS6wmB2J5ZjRdl3a4uivH8YCV3llV
         i7AUwwfDubqlGORWu1m1PMKaqO9KAmnKS5/TBWCfokD06783O5/joVTE2F3CoTMQ7m
         rTg4aF+298S+41wITKDnxC40JyRbpfkLxBBMITAAK0xaLdBSbucwKx7E8OhGWmwwY3
         T/bu0Gf04aqJg==
Date:   Sat, 14 Jan 2023 16:17:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: chemical: scd30_core: use sysfs_emit() to
 instead of scnprintf()
Message-ID: <20230114161748.1b316bb4@jic23-huawei>
In-Reply-To: <20230113141117.23353-1-andriy.shevchenko@linux.intel.com>
References: <20230113141117.23353-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Fri, 13 Jan 2023 16:11:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied

Thanks,

> ---
>  drivers/iio/chemical/scd30_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index 682fca39d14d..e0bb1dd5e790 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -354,7 +354,7 @@ static ssize_t sampling_frequency_available_show(struct device *dev, struct devi
>  	ssize_t len = 0;
>  
>  	do {
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ", 1000000000 / i);
> +		len += sysfs_emit_at(buf, len, "0.%09u ", 1000000000 / i);
>  		/*
>  		 * Not all values fit PAGE_SIZE buffer hence print every 6th
>  		 * (each frequency differs by 6s in time domain from the
> @@ -380,7 +380,7 @@ static ssize_t calibration_auto_enable_show(struct device *dev, struct device_at
>  	ret = scd30_command_read(state, CMD_ASC, &val);
>  	mutex_unlock(&state->lock);
>  
> -	return ret ?: sprintf(buf, "%d\n", val);
> +	return ret ?: sysfs_emit(buf, "%d\n", val);
>  }
>  
>  static ssize_t calibration_auto_enable_store(struct device *dev, struct device_attribute *attr,
> @@ -414,7 +414,7 @@ static ssize_t calibration_forced_value_show(struct device *dev, struct device_a
>  	ret = scd30_command_read(state, CMD_FRC, &val);
>  	mutex_unlock(&state->lock);
>  
> -	return ret ?: sprintf(buf, "%d\n", val);
> +	return ret ?: sysfs_emit(buf, "%d\n", val);
>  }
>  
>  static ssize_t calibration_forced_value_store(struct device *dev, struct device_attribute *attr,

