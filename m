Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1773CBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFXQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXQfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:35:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436771BCA;
        Sat, 24 Jun 2023 09:35:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668709767b1so1007331b3a.2;
        Sat, 24 Jun 2023 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687624500; x=1690216500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=enC0LALS/kw5+9Xd3ure+QjE8zHEQdAD7WtyIotvYmg=;
        b=Gw0jSs+YXqNZjv8uEOgkajqjs59Gw4ip9Q/nHYZFx1eAPMwwVyBy0EzC+Sy6QX5pa8
         VGDRsJN61sx2m2mBw3hE9RfoI/Kv1U1h+ubUoMf6XPUs09tjWHsk1jN93ubyHJ1LKnnU
         9ZpMNOTgxZSSD3pDJzoUS9vpVBCJhMZW74c6OY7b3urVyhqPkXZ/OaVatWb6Sj8YHt8y
         0RXtsBj/T1c37IFhTDlm2L5Tf2vr41Twn1V06V4Q879s9nUW8cvE9LgSz7wnWWPre+DM
         jewoFMPgpiYGH/DMkdKdD5Z0plFIrO0bh9bXKQknAdkE7jLjoV1PquHBkYvGA5pPyJf9
         8Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687624500; x=1690216500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enC0LALS/kw5+9Xd3ure+QjE8zHEQdAD7WtyIotvYmg=;
        b=Eaj68fKB61MNFQ9SfSzeHS9Chl95/vpFC4vRlqt8a5n/EBAnrs0AZ5EiJBzN9EjZiF
         MDH17k6m5rNQP6qWaDlFCoK6dQGoNzNWE9ov0esFcTxiomRFe5lM/ejeQ3jaZIYWQUIQ
         4dGbqKxQo6WK2XIoXQ0BX584Prg8Lw8kc2OKam0J1DJlkKso4j7l77IL9GJlb/QhxwfX
         ONUT0zBSPiwXzfxwK2AQcdEGQFVH/+ZIZr8MddiNFXDlPCXQ9SMjPVsgSa8avJA3RJOw
         1mDmnEoG+RJiMe1+5fh/G02wLHRaRODqLyDz2U8PsVfWLtV59j7K12F7EQFhklZi7dhQ
         sNtw==
X-Gm-Message-State: AC+VfDyo38jgf+fQB72BD4a6ZzoScn7VBYijrGyKYs9oRv4TrlRtTMv2
        WdfdUETVOfQhCd2J6SG58Y4wTXYWyog=
X-Google-Smtp-Source: ACHHUZ5grrhLMR23hDRlqs7PiS66Hz+wXpbaHxdJpot8RgVbSq+9/tPrwllnyYJZYhyGYoEngcC14Q==
X-Received: by 2002:a05:6a00:15c5:b0:66a:458b:7d43 with SMTP id o5-20020a056a0015c500b0066a458b7d43mr11495347pfu.31.1687624500007;
        Sat, 24 Jun 2023 09:35:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9-20020a635c49000000b00543e9e17207sm1474826pgm.30.2023.06.24.09.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 09:34:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb2f59a0-4054-c8a4-9d75-0ea354b92e3b@roeck-us.net>
Date:   Sat, 24 Jun 2023 09:34:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] hwmon: (sht3x) add device-tree support
Content-Language: en-US
To:     JuenKit_Yip@hotmail.com, jdelvare@suse.com,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB62616C555E4D76672BDC6B7B9220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DB4PR10MB62616C555E4D76672BDC6B7B9220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 09:01, JuenKit_Yip@hotmail.com wrote:
> From: JuenKit Yip <JuenKit_Yip@hotmail.com>
> 
> add "compatible" property for supporting device-tree
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>   drivers/hwmon/sht3x.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 9b2dadd11eeb..e7648c011e5f 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -925,8 +925,18 @@ static const struct i2c_device_id sht3x_ids[] = {
>   
>   MODULE_DEVICE_TABLE(i2c, sht3x_ids);
>   
> +/* devicetree ID table */
> +static const struct of_device_id sht3x_of_match[] = {
> +	{ .compatible = "sensirion,sht3x" },
> +	{ .compatible = "sensirion,sts3x" },
> +	{},
> +};

Add

MODULE_DEVICE_TABLE(of, sht3x_of_match);

> +
>   static struct i2c_driver sht3x_i2c_driver = {
> -	.driver.name = "sht3x",
> +	.driver = {
> +		.name = "sht3x",
> +		.of_match_table = of_match_ptr(sht3x_of_match),

Drop of_match_ptr().

> +	},
>   	.probe       = sht3x_probe,
>   	.id_table    = sht3x_ids,
>   };

