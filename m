Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE365E5FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIVKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIVKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:32:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF4D6910;
        Thu, 22 Sep 2022 03:32:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c198so8822647pfc.13;
        Thu, 22 Sep 2022 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AX7kC+lTBYhiDKEJUnz6TURhGuaQwTcgoa3WakwT7X0=;
        b=Xs6dkvVNhSuwmbPyH2j7ylhlDB2PH7ZPhWMKny+9zLqzIyWBqnLbYRyZyUmS3FUSL0
         5Fy2B7K0GsmF0e8Jjawia+dhYjrDsog2jT9mbJZlNYB3QL38zOH1YB/NKY9KyNXUzvKu
         qtGe9nic3+XIzxvFpDs9xFhu83SnaUWiWES2uGyDTMPupi55qXrxWTJ/YQ1vKCqJMZ5n
         zVtAKqiJL02B0gjhCPTjfHdiG0zHAvVv0jK6aQTZ54YNraH43GBDV8kyy4VVmGJ6KOvg
         T2jo9oTbtbU2yXa3Jeb1m8oXgw5sYDvbSenmk2AZRT2/YkharsSWZ4BbCa1I+yARE1cF
         VaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AX7kC+lTBYhiDKEJUnz6TURhGuaQwTcgoa3WakwT7X0=;
        b=ZkQPsqoBhNAHgaL1V6S8lsldoVAr2lskfWMJoqjm1tdNTBztuV4A0gRX6w0RDPiqIA
         Cus1ZOQdIVhw8zKv7+H+j3glgSE4I+TZz7xYdM9TtbD0c/oK5T3xn54aaQJqB3k3vG4H
         5P9uXhOcPRsmp/1MC4IcbC5k9pBw7k4IjZG44JLMI5Zb8P0sERxR1f1xdq9iPGzJqZ3O
         xK/1UFCLwl4ItSD+YAwpc2MqJ7T8ZyiZQ7Oi/bdNwHuPSOzVMu1qs5zVd7LXMZDJS0tt
         DPAdgkaH6IHJaylq0Cb92Mp274HFFMk0+wTTrK80QdspNMG9kVs3maiEI0mct0p0+q5Q
         XlmQ==
X-Gm-Message-State: ACrzQf23LolPb3dgsGeaXX42TsiRvS5y9OLHVvhGxQXl+VWTB3rk7Kcy
        1KD0rxX4iME7y/XfcevnDpI=
X-Google-Smtp-Source: AMsMyM62OqXFwsv/Bk4jUd+D966gmsAwP3KknZPYGjXIdotbtIAB7/iUy8muw3q7Nm/n6WaA/4GWgg==
X-Received: by 2002:a05:6a00:1a8d:b0:547:c564:1614 with SMTP id e13-20020a056a001a8d00b00547c5641614mr2967779pfv.71.1663842720021;
        Thu, 22 Sep 2022 03:32:00 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id p124-20020a62d082000000b0053e3ed14419sm4018844pfg.48.2022.09.22.03.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:31:59 -0700 (PDT)
Date:   Thu, 22 Sep 2022 18:31:54 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: cdev: add fdinfo output for line request
 file descriptors
Message-ID: <Yyw5mivLAgWZIx0W@sol>
References: <20220922095124.116116-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922095124.116116-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:51:24AM +0200, Bartosz Golaszewski wrote:
> Add fdinfo output for file descriptors created for user-space line
> requests in GPIO uAPI v2. The fdinfo file now contains the name of the
> GPIO chip that is the "parent" of the request as well as offsets of
> the lines requested. This allows user-space to parse the /proc/$PID/fdinfo
> entries and deduce the PID of the process that requested a specific line.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> v1 -> v2:
>   - change `gpio-device` to `gpio-chip` in the fdinfo output
>   - change deduct into deduce as suggested by Kent in the commit message
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

>  drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f8041d4898d1..01c15e9e6896 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1497,6 +1497,21 @@ static int linereq_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
> +{
> +	struct linereq *lr = file->private_data;
> +	struct device *dev = &lr->gdev->dev;
> +	u16 i;
> +
> +	seq_printf(out, "gpio-chip:\t%s\n", dev_name(dev));
> +
> +	for (i = 0; i < lr->num_lines; i++)
> +		seq_printf(out, "gpio-line:\t%d\n",
> +			   gpio_chip_hwgpio(lr->lines[i].desc));
> +}
> +#endif
> +
>  static const struct file_operations line_fileops = {
>  	.release = linereq_release,
>  	.read = linereq_read,
> @@ -1507,6 +1522,9 @@ static const struct file_operations line_fileops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = linereq_ioctl_compat,
>  #endif
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = linereq_show_fdinfo,
> +#endif
>  };
>  
>  static int linereq_create(struct gpio_device *gdev, void __user *ip)
> -- 
> 2.34.1
> 
