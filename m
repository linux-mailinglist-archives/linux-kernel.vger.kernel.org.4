Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CBD670E46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAQX6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAQX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:58:07 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B6676C9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:12:08 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5EE753F6D6;
        Wed, 18 Jan 2023 00:12:06 +0100 (CET)
Date:   Wed, 18 Jan 2023 00:12:04 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230117231204.fpvxryjscosg57a6@SoMainline.org>
References: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-17 11:39:44, Andy Shevchenko wrote:
> The node name can contain an address part which is not used by
> the driver. Cut it out before assigning the channel name.

This explanation doesn't cut it.  It's not that the driver "doesn't use"
the address part, it is that this string is propagated into the
userspace label, sysfs /filenames/ *and breaking ABI*.

> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index e90c299c913a..c52bf6722a6a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -628,12 +628,19 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
>  				    struct fwnode_handle *fwnode,
>  				    const struct adc5_data *data)
>  {
> -	const char *name = fwnode_get_name(fwnode), *channel_name;
> +	const char *name, *channel_name;

I don't think this'll compile as name is still a pointer to const data,
while you're assigning (a '\0' char) to it below.

- Marijn

>  	u32 chan, value, varr[2];
>  	u32 sid = 0;
>  	int ret;
>  	struct device *dev = adc->dev;
>  
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	/* Cut the address part */
> +	name[strchrnul(name, '@') - name] = '\0';
> +
>  	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
>  	if (ret) {
>  		dev_err(dev, "invalid channel number %s\n", name);
> -- 
> 2.39.0
> 
