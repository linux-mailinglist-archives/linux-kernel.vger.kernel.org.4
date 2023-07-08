Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59874BE66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGHQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75911BB;
        Sat,  8 Jul 2023 09:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D1460C0B;
        Sat,  8 Jul 2023 16:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E0CC433C7;
        Sat,  8 Jul 2023 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688832988;
        bh=oSuDuGuXNiFSmzgo+7r+Wfg/zaVt4lj7wHdTOY12IYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFJdc0SCAG5/5WEv9NY0Dm0o3v4bmjq3fe7gylAotDyQ1jd0xg2keB+zK227HFIXQ
         CZmVq8tad6e8exD8foaFD8+Kak58zyPYpCDp6EDYcHtM4xfN2KUneyA78wjqlxsRqN
         iavvhxj399pzsFBzdYHJqKTD93XTYvM7/7pM+BvwJODfjNIORai6oLTsHkSwkfWKcS
         GKcDaepyr5WMlRf0znUFfiHNkO79gZksIDk755lTJgaCML71Wx+AWVRLsv6s2SfxAc
         XaSsT64U4j+Na7dW4IhClmG0QYY4CElgH5GgBlUD9yVGwS+HZwh33Xl/qO5dNsioMJ
         WzpwijtrdoD8Q==
Date:   Sat, 8 Jul 2023 17:16:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: bu27008: add chip info
Message-ID: <20230708171621.616fad8f@jic23-huawei>
In-Reply-To: <b4cdb81ef9522e94150673b3b78a4cbae5fa67f2.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
        <b4cdb81ef9522e94150673b3b78a4cbae5fa67f2.1688723839.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 14:23:03 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27010 RGB + flickering sensor is in many regards similar to
> the BU27008. Prepare for adding support for BU27010 by allowing
> chip-specific properties to be brought from the of_device_id data.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
One trivial comment.

The ffs stuff is a pain.  There have been a few goes at defining
standard functions for doing that but I don' think anything ever landed
upstream.

> ---
> Revision history:
> v1 => v2:
>  - Move all generic refactoring from next patch to this one so that the
>    next one will only contain the BU27010 specific additions.
>  - reorder bu27008 chip-data assignments to match the struct member
>    placement
>  - Cleanup
> ---
>  drivers/iio/light/rohm-bu27008.c | 323 ++++++++++++++++++++-----------
>  1 file changed, 208 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> index b50bf8973d9a..08e2b1194bf4 100644
> --- a/drivers/iio/light/rohm-bu27008.c
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -211,7 +211,35 @@ static const struct iio_chan_spec bu27008_channels[] = {


> @@ -993,14 +1086,14 @@ static int bu27008_probe(struct i2c_client *i2c)
>  	data->dev = dev;
>  	data->irq = i2c->irq;
>  
> -	idev->channels = bu27008_channels;
> +	idev->channels = &bu27008_channels[0];

Why?  When setting a pointer to the 'whole' array I tend to prefer
the original. Can't see a reason why this should be changed to the
second one.


>  	idev->num_channels = ARRAY_SIZE(bu27008_channels);
> -	idev->name = "bu27008";
> +	idev->name = data->cd->name;
>  	idev->info = &bu27008_info;
>  	idev->modes = INDIO_DIRECT_MODE;
>  	idev->available_scan_masks = bu27008_scan_masks;
>  
> -	ret = bu27008_chip_init(data);
> +	ret = data->cd->chip_init(data);
>  	if (ret)
>  		return ret;
>  
> @@ -1021,7 +1114,7 @@ static int bu27008_probe(struct i2c_client *i2c)
>  }
>  
>  static const struct of_device_id bu27008_of_match[] = {
> -	{ .compatible = "rohm,bu27008" },
> +	{ .compatible = "rohm,bu27008", .data = &bu27008_chip },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bu27008_of_match);

