Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC48626F92
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiKMMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiKMMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:50:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B112ACF;
        Sun, 13 Nov 2022 04:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FDFEB80B86;
        Sun, 13 Nov 2022 12:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA6C433D6;
        Sun, 13 Nov 2022 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668343850;
        bh=ZLs7zKpVQjz7HMM6k+kFXTlpaYFs0LUhExq4XQcd1s4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bRL9hllLDlw9+RuOxEp/BTtZqu0sxnMGpsShotQYUQBomE5dvFVoD1N24YGwz6V+E
         bls9ihBMe9GMjEry7sBd0YrrC6rli2crxqF6LGgLrP2JxooH2LV3J8Bw3VYvsrfs+W
         w05hHQ6W8XSvWUY5qtl9FMmxNWvaVq0KPH1abZ6krHZoEF/uWowqkzHh7neWwe1S5m
         34TbGm40XsmFHKDxe+ppF8fgJ9eywuHPOBe8NTVUnLHre3t+AgUrS3t3tphhayQUul
         rZZZhKLrlX52Dr3j+Ch0cOJiZFcA6fekyRn6LnDIK9fHTqyyLtxou9VntemQz768m9
         y85c6lNFSvivw==
Date:   Sun, 13 Nov 2022 13:03:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: meter: replace ternary operator by if
 condition
Message-ID: <20221113130306.517e7aa3@jic23-huawei>
In-Reply-To: <Y3CAdCa17WdWDYUa@qemulion>
References: <Y3CAdCa17WdWDYUa@qemulion>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 13 Nov 2022 10:58:20 +0530
Deepak R Varma <drv@mailo.com> wrote:

> Replace ternary operator by simple if based evaluation of the return
> value. Issue identified using coccicheck.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Applied to the togreg branch of iio.git and pushed out as testing to
see if 0-day can find anything we missed.

Thanks,

Jonathan

> ---
> 
> Changes in v2:
>    1. Use if based evaluation instead of using min macro
>       suggested by Joe Perches.
> 
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index a9a06e8dda51..71b67dd3c8e9 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -61,7 +61,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
>  unlock:
>  	mutex_unlock(&st->buf_lock);
> 
> -	return ret < 0 ? ret : 0;
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>  }
> 
>  static int ade7854_i2c_read_reg(struct device *dev,
> --
> 2.34.1
> 
> 
> 

