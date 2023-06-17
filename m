Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CB734216
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjFQP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:56:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC51B7;
        Sat, 17 Jun 2023 08:56:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e3b15370so818930b3a.0;
        Sat, 17 Jun 2023 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687017397; x=1689609397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2COyOP1exeRBDMmo4rM7FwSDhLMO5a8kz6768+vnkU=;
        b=SpEEBxX4kYnmtdRVsJn1Hdig/pUGCQkmzukP/YKs7RJRdC/XeW65tEwXZwQKOOTrv4
         3l0/hxCJ7ogLvdn3+/VigRxeaHEKL4LMIAaUhUP40ZVgZ2Xs3xv38OJJGUgrDjij6Lju
         JvjDfvWFUB+rgyk2Psy8MwQ/KZ5Zf8ajsQ6RjQQN+5sWejdfF/8R71v4/cUIV395MRrQ
         WRjEg82xClsodUyfAb1OgqdcjsL0OJ+3XE3Y2hWKHxyIifz8mReGW2Rv3KI8aoQ1Xvri
         SKwIpi3BHLzNezH1xweazmte6lN/wH91kan44KZGLkv5nKHHQ2n1OE28r5KI+k4LWSmK
         NKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687017397; x=1689609397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2COyOP1exeRBDMmo4rM7FwSDhLMO5a8kz6768+vnkU=;
        b=PSu3nwGXFBtVCmj3wrhASnQ4X7uJqK2fAFDkUosOJJs1svaTK8RrxD98o9jptYxtUH
         oqpj4NvQUxcTs20CAUZ12Fc7O3jlK3njqoWmIvhNrBPgFxK3nMm5UTBysLwvzxhf5J6g
         R6HfWVl25zXN69evK4DJcrwD0H4CIE2rUdeQGwhcvBrxD7sbPFUa6krcw0u9Q2CQoJt0
         UeRJ8Nf4FmYGUdql5irDPJqvxHm2iJUApIZMA6dNPMQ1X89czJ2pzbmB8zBodhOhlW3s
         IQAcdM0TW5NXqKvApfl+xW5h+T29uwFo4SSpEHSsqjAyN7jouXLCfZRJbp5V0XQnJaDW
         JgvQ==
X-Gm-Message-State: AC+VfDyk7bQYe71V30g7JhDze3cbElokTRPuvVwvQrLqlwlfWs2T296r
        1+pT324REXT4hUD+VWwOhaU=
X-Google-Smtp-Source: ACHHUZ5jMBhnaGcqOHTyqFC2dkmTbVkm1yASjZFRPiHqxDGNrZhqrbNGNc0yI0qe/3o6WgV8kneQyw==
X-Received: by 2002:a05:6a00:2313:b0:64f:835c:a9ff with SMTP id h19-20020a056a00231300b0064f835ca9ffmr4427961pfh.12.1687017397131;
        Sat, 17 Jun 2023 08:56:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a63df0b000000b0053491d92b65sm16294624pgg.84.2023.06.17.08.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:56:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 08:56:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hwmon: (sht3x)add medium repeatability support
Message-ID: <1ef59ee2-432e-4cc6-aca0-2c5f41b93714@roeck-us.net>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261A70CD0444248ADDCC3219258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261A70CD0444248ADDCC3219258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 12:00:15AM +0800, JuenKit Yip wrote:
> add medium repeatability support for matching datasheet
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/sht3x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index ecc64febc..6174b8fa7 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -24,6 +24,9 @@
>  /* commands (high repeatability mode) */
>  static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
>  
> +/* commands (medium repeatability mode) */
> +static const unsigned char sht3x_cmd_measure_single_mpm[] = { 0x24, 0x0b };
> +
>  /* commands (low repeatability mode) */
>  static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
>  
> @@ -41,6 +44,7 @@ static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
>  
>  /* delays for single-shot mode i2c commands, both in us */
>  #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
> +#define SHT3X_SINGLE_WAIT_TIME_MPM   6000
>  #define SHT3X_SINGLE_WAIT_TIME_LPM   4000
>  
>  #define SHT3X_WORD_LEN         2
> @@ -68,6 +72,7 @@ enum sht3x_limits {
>  
>  enum sht3x_repeatability {
>  	low_repeatability,
> +	medium_repeatability,
>  	high_repeatability,
>  };
>  
> @@ -87,6 +92,20 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>  	{0x27, 0x37},
>  };
>  
> +/* periodic measure commands (medium repeatability) */
> +static const char periodic_measure_commands_mpm[][SHT3X_CMD_LENGTH] = {
> +	/* 0.5 measurements per second */
> +	{0x20, 0x24},
> +	/* 1 measurements per second */
> +	{0x21, 0x26},
> +	/* 2 measurements per second */
> +	{0x22, 0x20},
> +	/* 4 measurements per second */
> +	{0x23, 0x22},
> +	/* 10 measurements per second */
> +	{0x27, 0x21},
> +};
> +
>  /* periodic measure commands (low repeatability mode) */
>  static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
>  	/* 0.5 measurements per second */
> @@ -444,6 +463,9 @@ static void sht3x_select_command(struct sht3x_data *data)
>  		if (data->repeatability == high_repeatability) {
>  			data->command = sht3x_cmd_measure_single_hpm;
>  			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
> +		} else if (data->repeatability ==  medium_repeatability) {
> +			data->command = sht3x_cmd_measure_single_mpm;
> +			data->wait_time = SHT3X_SINGLE_WAIT_TIME_MPM;
>  		} else {
>  			data->command = sht3x_cmd_measure_single_lpm;
>  			data->wait_time = SHT3X_SINGLE_WAIT_TIME_LPM;
> @@ -591,6 +613,8 @@ static ssize_t update_interval_store(struct device *dev,
>  	if (mode > 0) {
>  		if (data->repeatability == high_repeatability)
>  			command = periodic_measure_commands_hpm[mode - 1];
> +		else if (data->repeatability == medium_repeatability)
> +			command = periodic_measure_commands_mpm[mode - 1];
>  		else
>  			command = periodic_measure_commands_lpm[mode - 1];
>  
