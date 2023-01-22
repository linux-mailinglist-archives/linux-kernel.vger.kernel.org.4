Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548976770FD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjAVRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjAVRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:11:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FAD61AA;
        Sun, 22 Jan 2023 09:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1329B80B28;
        Sun, 22 Jan 2023 17:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F2C433D2;
        Sun, 22 Jan 2023 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674407456;
        bh=3Mfk191ggzdExTq0b2HwwqXCDca7qSKJuGQ7daqNE0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YUmZL6S3T/Ht1SQiUunupVx6IxgVtzG9yGCu3xv1+rLGWxaFit30RwlbL69FV5H8H
         lLwc+gbnYK54yTwLEkbFMai1Sl3856yz7vQNjbQZ00b7UmM0sv2WSmwmmEonSidtpq
         JebjtgD6ZwidgzLkyG35gw6R2Po4x74+B7t5Mk+A5qXj7CEA402YUpHJdpqZyRJa9U
         GMqzKtXnI97QrG/ReLlrBOArcaoTXE52DqF9lPFjzbnIT3APHz6gzet61dOBM+RtH+
         bB0B1LeGXVTR0hR8vVX8zS+JmQjOsXWDVNsOGYfyJ8VjQOaDZakVL4R5YBlQg0Y0/D
         ldk6q7XxYp3Ww==
Date:   Sun, 22 Jan 2023 17:24:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230122172441.4f8d75f5@jic23-huawei>
In-Reply-To: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 18 Jan 2023 12:06:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The node name can contain an address part which is unused
> by the driver. Moreover, this string is propagated into
> the userspace label, sysfs filenames *and breaking ABI*.
> 
> Cut the address part out before assigning the channel name.
> 
> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM, but given it will have ABI impact, I'd like to hear from 
Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
who has touched this driver fairly recently.

Mostly I want to be sure they know this exists before it causes surprise.

Jonathan

> ---
> v2: rephrased commit message (Marijn), fixed compilation issue (Marijin)
>  drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index e90c299c913a..c2d5e06f137a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -628,12 +628,20 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
>  				    struct fwnode_handle *fwnode,
>  				    const struct adc5_data *data)
>  {
> -	const char *name = fwnode_get_name(fwnode), *channel_name;
> +	const char *channel_name;
> +	char *name;
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

