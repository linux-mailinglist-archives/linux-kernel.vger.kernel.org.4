Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2A6B5FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCKTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCKTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:02:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955E64B2D;
        Sat, 11 Mar 2023 11:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DD160DD8;
        Sat, 11 Mar 2023 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0275CC433D2;
        Sat, 11 Mar 2023 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561325;
        bh=aRIPsVzahV4VaJZIFCg+vIsGtMpis+9um6e1rA2rVAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+j+kZCat2117EEqGxts5x3SZZDixNF9zpT2XnUIqEHZlQp95CM5+y+uSy1rZnrE1
         Z/5gClmxlQofaa+n3mg9HcR4EZkWWPqoZSw/O/554J+0IgZHlDPN/oiL5/NASKz+1R
         MFXulOEzEx/yj6yNox+iX7rbqnBDm5bX8hv2I3ehoJGRUymVe/JnuxTL9IFraOjjHe
         erWoFcsMZ8kYZgesrgeUpJn6cQkp5KEJBI3NYirUQ4TPh/bLhgersK/6HE6XT3gkvz
         MokA7pKp+QEam/lKA3eAkmGzlSfdOKf0cw3bIoVKw7uuF1I1miQdoOI4J1eN3iBazj
         U6LBsN4CXyI5Q==
Date:   Sat, 11 Mar 2023 19:02:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/4] devres: Provide krealloc_array
Message-ID: <20230311190208.7eca8c12@jic23-huawei>
In-Reply-To: <20230309150334.216760-2-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
        <20230309150334.216760-2-james.clark@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Mar 2023 15:03:30 +0000
James Clark <james.clark@arm.com> wrote:

> There is no krealloc_array equivalent in devres. Users would have to
> do their own multiplication overflow check so provide one.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Trivial comment inline, but otherwise seems reasonable to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/driver-model/devres.rst |  1 +
>  include/linux/device.h                           | 10 ++++++++++
>  2 files changed, 11 insertions(+)
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
> index 1508e637bb26..0dd5956c8516 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -223,6 +223,16 @@ static inline void *devm_kcalloc(struct device *dev,
>  {
>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
> +static inline __realloc_size(3, 4) void * __must_check
> +devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +		return NULL;

For consistency with krealloc_array and other stuff in device.h that is
of similar 'shape' add a blank line here.

> +	return devm_krealloc(dev, p, bytes, flags);
> +}
> +
>  void devm_kfree(struct device *dev, const void *p);
>  char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
>  const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);

