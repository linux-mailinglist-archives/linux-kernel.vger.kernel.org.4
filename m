Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5B61F400
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKGNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKGNIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:08:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8219286;
        Mon,  7 Nov 2022 05:08:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so7116713wmg.2;
        Mon, 07 Nov 2022 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjQ3EIftToSDAs8kIxnNN64z6dj2+/KZibkFT+hIH+I=;
        b=L+hnZtSjLy47alR2cv82vQMSOeIO5hmyynkrCswoFbg6CZe+MECKFqdR+16N+FwdRV
         mTfeI/nKmiCpm7kXfdpfr2o6wVMlc77JTgoDiJoY2GfASOCYamlmMnaKRBtOCzdw4ciT
         tP6ez2pQmAgww836XsX1PtCqwsGCx9/QvbWx97gYyqKd+XV4/oZANewMfhCa9gpaAtxq
         G8phyU/pynmFQBuB8oQbtjGidYGlYpHSnzubftS0CApdvaO+oyWT8x5xPexUzGuovy1V
         EkR9q8lSk5G9NVpuc5lO4AMHgRr7qRnMgs2iUZJ0S5hjgXz0m6n2IbwqkPiOT05AiriD
         bR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjQ3EIftToSDAs8kIxnNN64z6dj2+/KZibkFT+hIH+I=;
        b=xBQqTV0reyQLAQEtBqH5mt5nGQooMZHzWERUSuY8zZVOxLfcMDHFLH9/9/fTItgGjm
         W5Dw6cc1RJRhHTcVfTNramMSjnpNzSb69/wLViiyNLles9qShz+9elDvclfUtLa5iPQF
         CkWv0uHEIawIoa8GmaSiCHOMsEUgCW/rTKWVICFS0f79pXBagdshFu+9A6XgjhrEXdR0
         eV7zkiyA6a4coYrPGMCIVskfPhRPljntKaIjUxoxlY60oFFFBwhOum6qU+hg1uM7vuel
         CRqJkcV5cbv8Z9CvzDljhHw578/gTvvLHFJ95P1WsVyKdAkOtA4GdDlrR9bd2KnWeGQP
         8Dlw==
X-Gm-Message-State: ACrzQf13Nm8gED7LFpCTeHAdfNiliqbhSNsCzA8YmNMAqFKuCQ7P58pX
        uYPHWMqxAUjXMRokteV7qO4=
X-Google-Smtp-Source: AMsMyM5XlevBa2XTwPGVMGYwItpf9GANoVu6vIuqwg96EaKpvguJYcU66RI593ZqRNf1hMY8VrkxUw==
X-Received: by 2002:a7b:cc8c:0:b0:3cf:7b8c:d18a with SMTP id p12-20020a7bcc8c000000b003cf7b8cd18amr25194367wma.0.1667826514866;
        Mon, 07 Nov 2022 05:08:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003c6bd12ac27sm8667304wmb.37.2022.11.07.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:08:34 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:08:31 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: use min() for comparison and
 assignment
Message-ID: <Y2kDTxE38epBN368@kadam>
References: <Y2iFGA3A1w+XMlYU@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2iFGA3A1w+XMlYU@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:40:00AM +0530, Deepak R Varma wrote:
> Simplify code by using recommended min helper macro for logical
> evaluation and value assignment. This issue is identified by
> coccicheck using the minmax.cocci file.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index a9a06e8dda51..a6ce7b24cc8f 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -61,7 +61,7 @@ static int ade7854_i2c_write_reg(struct device *dev,
>  unlock:
>  	mutex_unlock(&st->buf_lock);
> 
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);

The original code is better.

If it's a failure return the error code.  If it's not return zero.

You can only compare apples to apples.  min() makes sense if you're
talking about two lengths.  But here if ret is negative that's an error
code.  If it's positive that's the number of bytes.  If the error
code is less than the number of bytes then return that?  What???  It
makes no sense.

In terms of run time, this patch is fine but in terms of reading the
code using min() makes it less readable.

regards,
dan carpenter
