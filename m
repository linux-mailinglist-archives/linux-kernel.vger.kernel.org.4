Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE14670251C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjEOGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbjEOGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:44:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7566187
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:44:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so64445425e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684133046; x=1686725046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mINZbq2wMQRhpwFl+Y59OPBXfOB4g1POM+virNwffyI=;
        b=zXstS5FJk3Y6WhtfGZna+TX3lPy37HQZUSK7ZyQ5+Dkso6lAY9z9tfFBb3Kc6GUlqV
         KubQ9hhk7rDy9Xjjq0UURvLgUhAiD+uEMONYkPMEoY468E5QJHSfJ2g2c/ouR4okf8VA
         LPd0jMbC+pLmOS5qQ6YhZiZfDWFfszfi2ev3S74W3GXyU/hB7VKmu+erCew2zOqg3Fv9
         Q9ysLgZa2VXIPDdcAXf04cvGfSAgdT23UPyp4Kl3lUrBBGco+g1jFMC2zL7e1cy0rGKD
         Z9+b8+6G+tpa5kWa7N/+6mGMCLKtoL5BQ1fOu+9uhtmvHF76ANxv7iGcJzR7Jnikheem
         IDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133046; x=1686725046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mINZbq2wMQRhpwFl+Y59OPBXfOB4g1POM+virNwffyI=;
        b=alsv9rJSNAxsXMEKhWfBhRmuftGihGo0YD1EuRdL2WS+lj2G0lOu2A97Qsp14Wo647
         D7PVbc9V0b4B2gYAHT6wg120x0Az30oW0NmmvRo9njL7EhceHAEBiSLfAPx4T//C92sn
         kujoJ12DhjAaBkdHCcN7AcB3GiysEwOyOziBm+u6XlEFdz9cDhPrvbUe7+Y0uS0Ze1M9
         TwFiBFfW7SMIWUvz0s112xMtBiJ0DMyNbFy2IbDjCZL6f3q9dhiMExVe4Q6p4kgNrE40
         emj/AyMUOAgAF4Zz9ibrRU+8NocwzMUtIZkirMQxxaZmHAgiSKfV5LR06z1fanxrKRSh
         5uMg==
X-Gm-Message-State: AC+VfDxl+bFvcDsyFXqbs9TERzVxAOZGaMdSz9XUrW5enoqyNi4DCUuz
        E/OIlCasmtRoDh0L8YLJe+1eNw==
X-Google-Smtp-Source: ACHHUZ5QpvRjC+7tACbyjNlhLvZ7v/GvXWKRLRirZNp7JRIWNwTwe7UKRj7ZDI5u9mb86MQc52txUw==
X-Received: by 2002:a05:600c:2210:b0:3f4:2174:b285 with SMTP id z16-20020a05600c221000b003f42174b285mr18145388wml.9.1684133046331;
        Sun, 14 May 2023 23:44:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm24028570wml.18.2023.05.14.23.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:44:05 -0700 (PDT)
Date:   Mon, 15 May 2023 09:43:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rts5208: rtsx: fixed unbalanced braces around
 else statement
Message-ID: <fd255e48-e1e0-43ff-b9af-cd1b188875a4@kili.mountain>
References: <20230514064936.7895-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514064936.7895-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 12:19:36PM +0530, Deepanshu Kartikey wrote:
> Fixed unbalanced braces around else statement
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 2284a96abcff..0ab9355873f7 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
>  			chip->srb->result = DID_BAD_TARGET << 16;
> -		}
> -
> -		/* we've got a command, let's do it! */
> -		else {
> +		} else {
> +			//we've got a command, let's do it!

This is v2 of a patch.  Here is my guide how to send a v2 patch.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

