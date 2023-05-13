Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549B701651
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjEMLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjEMLJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3440E3;
        Sat, 13 May 2023 04:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CD760B73;
        Sat, 13 May 2023 11:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93D2C433D2;
        Sat, 13 May 2023 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683976154;
        bh=uXFoiR1SWFtZOtGgV5o4WxStrNeNIyIJxeYxRx+a7hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5xMjIXx3kXmI5AGZ+OV2hLCDwdg5B4Io7eigd84X5cC9TCmNGEWkD3eFWtpwqfsN
         IHavtVhWBzvBtYoyMy8qruC3SpuVVoE0fQfF6XwMuzTWqNzIjRYD2Numx1NTD5MZTQ
         PubhhDESdtazxWt29zBxdGxLLKnhefo0yeOXkqkw=
Date:   Sat, 13 May 2023 20:04:40 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
Message-ID: <2023051340-sinuous-darkroom-2497@gregkh>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509094942.396150-2-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:49:38AM +0100, James Clark wrote:
> There is no krealloc_array equivalent in devres. Users would have to
> do their own multiplication overflow check so provide one.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst |  1 +
>  include/linux/device.h                           | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 4249eb4239e0..8be086b3f829 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -364,6 +364,7 @@ MEM
>    devm_kmalloc_array()
>    devm_kmemdup()
>    devm_krealloc()
> +  devm_krealloc_array()
>    devm_kstrdup()
>    devm_kstrdup_const()
>    devm_kvasprintf()
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 472dd24d4823..58f4f5948edb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -223,6 +223,17 @@ static inline void *devm_kcalloc(struct device *dev,
>  {
>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
> +static inline __realloc_size(3, 4) void * __must_check

Shouldn't you have a blank line before this one?

> +devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +		return NULL;
> +
> +	return devm_krealloc(dev, p, bytes, flags);
> +}

I dislike how we have to keep copying the "real" functions (i.e.
krealloc_array) into something like this, but I can't think of a better
way to do it.

thanks,

greg k-h
