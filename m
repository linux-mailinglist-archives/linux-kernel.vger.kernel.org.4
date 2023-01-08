Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A736614E1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjAHMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjAHMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E76F004;
        Sun,  8 Jan 2023 04:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C524DB802C5;
        Sun,  8 Jan 2023 12:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB1C433D2;
        Sun,  8 Jan 2023 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673179217;
        bh=48TuCSjgDFgkNA8+RuQuEc67VKKKCmCOOKmdeIkUUL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ud0cc/A14kxvIlkbqiile2V+29YPcunjBKfPtmULAMpe0NhembY5fMggAUVU84nCi
         kxgTTGumN20LwVEmwTisNCIDFUOiG+VNQzM+Kbs+/luWFW1qbLL2EOMGSql9mECPmn
         4T8bIe6y6Z7Q0557zhLNJfqoB6ZfKD7pULl+8RagDdFW9wMvP01Aw6QpTZFmsxsoRK
         fx6hQ9wIRunQ0U7mIoy9kWJH/Z9GCUHTFZoUN3MK/8BBBoPgIZY8ONklracsnhttLl
         SRopLc6/pHbUkN1unxkBDJS0fZLcvpOhUX6AmailzSjphOdUK/3jJoAXV56rUMvCDc
         iit2tt4eEEQcg==
Date:   Sun, 8 Jan 2023 12:13:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: max11410: Use asm intead of
 asm-generic
Message-ID: <20230108121345.7fb3b6f2@jic23-huawei>
In-Reply-To: <20230103144903.39905-1-andriy.shevchenko@linux.intel.com>
References: <20230103144903.39905-1-andriy.shevchenko@linux.intel.com>
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

On Tue,  3 Jan 2023 16:49:03 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no point to specify asm-generic for the unaligned.h.
> Drop the 'generic' suffix and move the inclusion to be after
> the non-IIO linux/* ones.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max11410.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index fdc9f03135b5..b74b689ee7de 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright 2022 Analog Devices Inc.
>   */
> -#include <asm-generic/unaligned.h>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -16,6 +15,8 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  
> +#include <asm/unaligned.h>
> +
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>

