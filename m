Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3324F67218C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjARPlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjARPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:41:39 -0500
X-Greylist: delayed 1136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 07:41:38 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E9C10D8;
        Wed, 18 Jan 2023 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=gGJRB0GXL6+zSud4WzArEqgR5WzATKM/41V/LwUdSE0=; b=cd22TKwbGHNBlWxEstfxcPg2Kq
        q6TCfeRCdMd8o3uMtMkfgsPYX6KMh9jMtL7xJ4SxCJk3SmwoY9zleiggRcSKvadG7S4ULFzkzshVI
        Ci+ZObOuzZ5+KPXB76HiJbp2vd0p4zd4hMMtmmP1z3llmke8FzAoiX9N00OA8ycC2eH8Of7wNS1Te
        41OikXcPMJdTmd7zQt/2CC4HQItkPFpbGHEAB1eorXfvgUbgFhrI+DhymubZ1vFMr9DUjK9hRTyBZ
        DtpYUePVFQ/DLk+uQ1rjX0ZiGEcFuULNvp7tVy7eu4+ethZqTeNysqa+2yh+8XrKXzFMKV9ckqope
        7bPS612Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pIAGm-0003fk-V6; Wed, 18 Jan 2023 16:22:32 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pIAGm-000Np7-KZ; Wed, 18 Jan 2023 16:22:32 +0100
Message-ID: <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
Date:   Wed, 18 Jan 2023 07:22:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 23:48, Andy Shevchenko wrote:
> None of the current users is using gaps in the list of the items.
> No need to have a specific function for that, just replace it by
> library available __sysfs_match_string().

Hm, I specifically remember adding this for a driver where there were 
gaps. One of the DACs. But it might be that the driver itself never made 
it upstream.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iio/industrialio-core.c | 32 +-------------------------------
>   1 file changed, 1 insertion(+), 31 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 52e690f031cb..26e357f14db8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -205,36 +205,6 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
>   }
>   EXPORT_SYMBOL_GPL(iio_buffer_enabled);
>   
> -/**
> - * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
> - * @array: array of strings
> - * @n: number of strings in the array
> - * @str: string to match with
> - *
> - * Returns index of @str in the @array or -EINVAL, similar to match_string().
> - * Uses sysfs_streq instead of strcmp for matching.
> - *
> - * This routine will look for a string in an array of strings.
> - * The search will continue until the element is found or the n-th element
> - * is reached, regardless of any NULL elements in the array.
> - */
> -static int iio_sysfs_match_string_with_gaps(const char * const *array, size_t n,
> -					    const char *str)
> -{
> -	const char *item;
> -	int index;
> -
> -	for (index = 0; index < n; index++) {
> -		item = array[index];
> -		if (!item)
> -			continue;
> -		if (sysfs_streq(item, str))
> -			return index;
> -	}
> -
> -	return -EINVAL;
> -}
> -
>   #if defined(CONFIG_DEBUG_FS)
>   /*
>    * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> @@ -569,7 +539,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   	if (!e->set)
>   		return -EINVAL;
>   
> -	ret = iio_sysfs_match_string_with_gaps(e->items, e->num_items, buf);
> +	ret = __sysfs_match_string(e->items, e->num_items, buf);
>   	if (ret < 0)
>   		return ret;
>   


