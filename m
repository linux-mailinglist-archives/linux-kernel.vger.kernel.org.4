Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713A6DFFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDLUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDLUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505A114;
        Wed, 12 Apr 2023 13:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B449161276;
        Wed, 12 Apr 2023 20:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CF8C433D2;
        Wed, 12 Apr 2023 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331531;
        bh=ctATQ9F/PpnQBemPYBeJi6C1TXpCodJZt2hgX/it3mc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MUKiIP+6s1IURZPrk33z4pClWJXPrMWh47zmSrhxOF1Yx/oBbGNqCx4S+nhTWbOQy
         xaqSygHxkXx6NAgjFRGkhWwHgc9Noc+yy0gBnhTvJ5VEBsnaxbVqsgRuoME1KzBofQ
         EEPrpKNWt7qIqsGJknf1K6Ka3z4NOpvK8sMUzdNIY/fJiWqqvaZ/ZxyPbKlH+WKtu6
         7ATQOI3BBRBIgBKeRFu0i2HBs12Rf2BLBzWL6UtcZJsSSYomjPHeqHFcVLZBdTLVpM
         D5mKZsIKf2OynvoTlg4wO5SQ6ZP5gY4FK246NO3ekbFAb3rekMB+67z90Pbgfj7NAf
         D9P8GINHhCeXg==
Date:   Wed, 12 Apr 2023 21:32:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: core: add IIO_VAL_INT_MICRO
Message-ID: <20230412213208.49912897@jic23-huawei>
In-Reply-To: <d31f2ebf08837337d3bbc6a00fd4b5eb3c86a04e.1681301472.git.mazziesaccount@gmail.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
        <d31f2ebf08837337d3bbc6a00fd4b5eb3c86a04e.1681301472.git.mazziesaccount@gmail.com>
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

On Wed, 12 Apr 2023 15:27:14 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> There are a few cases like light sensor integration times, where values
> returned from *_available() and read_raw() are smaller than 1 and often
> in the units of micro. (Like micro second scale integration times,
> always smaller than 1 second). Currently those are often handled using
> IIO_VAL_INT_PLUS_MICRO, which requires drivers to initialize the integer
> part to zero. Furthermore, using IIO_VAL_INT_PLUS_MICRO in iio lists
> requires one to always allocate the 'dummy' integer part too.
> 
> Introduce IIO_VAL_INT_MICRO which allows omitting the always zero integer.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Hi Matti,

I'm not keen on adding yet another case just to avoid having to
have the integer part for IIO_VAL_INT_PLUS_MICRO.
Seems like the wrong trade off of maintainability vs ease of use.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 4 ++++
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c117f50d0cf3..c5ae965e9961 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -628,6 +628,8 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  	switch (type) {
>  	case IIO_VAL_INT:
>  		return sysfs_emit_at(buf, offset, "%d", vals[0]);
> +	case IIO_VAL_INT_MICRO:
> +		return sysfs_emit_at(buf, offset, "0.%06u", vals[0]);
>  	case IIO_VAL_INT_PLUS_MICRO_DB:
>  		scale_db = true;
>  		fallthrough;
> @@ -758,6 +760,7 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
>  
>  	switch (type) {
>  	case IIO_VAL_INT:
> +	case IIO_VAL_INT_MICRO:
>  		stride = 1;
>  		break;
>  	default:
> @@ -952,6 +955,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_INT_PLUS_MICRO_DB:
>  			scale_db = true;
>  			fallthrough;
> +		case IIO_VAL_INT_MICRO:
>  		case IIO_VAL_INT_PLUS_MICRO:
>  			fract_mult = 100000;
>  			break;
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 82faa98c719a..b4e316172c7f 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -30,6 +30,7 @@ enum iio_event_info {
>  #define IIO_VAL_FRACTIONAL 10
>  #define IIO_VAL_FRACTIONAL_LOG2 11
>  #define IIO_VAL_CHAR 12
> +#define IIO_VAL_INT_MICRO 13 /* val is micro <units>. Integer part is 0 */
>  
>  enum iio_available_type {
>  	IIO_AVAIL_LIST,

