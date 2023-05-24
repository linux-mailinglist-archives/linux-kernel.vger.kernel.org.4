Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5131D7100A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjEXWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEXWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:17:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2D183;
        Wed, 24 May 2023 15:17:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2538aa25873so562452a91.2;
        Wed, 24 May 2023 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684966657; x=1687558657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05lEIN21oQi8iWsH3j0kw4MIe4JZuPAlQrx21xPv+7U=;
        b=jmtOfuFiV5A1KlO2y4sbzzNHcbNeHMvzL0OJX4/Uvwpa3mPzC9mFbUozEa9g9VwYVc
         kV2rpeiehvlFBvXdxfW6JDgT3cek0y7OanNGnYnpaNujrCriUI+cMiFB27e7LzWFI/42
         2pK1nIpo3KhHo420WxCMvUuG7iJghbxbZnidionG52BSvEvaSQ+6kL6RSQq2QNoUwFxf
         NN6weimIFgleNJNEWUkHpP3avPJfAIJ7+352+F9CZm+L1gP8rmF44BJgdej4R4W+InXa
         Aygw+s1LxeQIk/w1yG0yGSbS6GnhYc3pihb5Zvgff3oFeL1D5viXfwmRgjaf9G+Kpbhh
         699g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966658; x=1687558658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05lEIN21oQi8iWsH3j0kw4MIe4JZuPAlQrx21xPv+7U=;
        b=dgPGR3broH7qaK/ohVfWZvZLSfKcRDeO7ADJHpbcuiI5FdFa9lzatKvpXDGry/b8r3
         bnGviWTRx3HOgOsxO5uQXlQ6YjVeFbS7AqpKTCpNLezO7jgGuug68oC62wghGoSQhNbC
         kW5t2Aug94tnR4PU9CG1/1J9fI0oBLJenxY7OoOj396fdcS9Oh3YooqJgNLu2VtMANPV
         WhAj4ecYo43x6s7Gg6A5PSkfA/3kl3ItGGfxBfQJ3uQ3FrtXd+el2TmC2RCo5tKCQ8oM
         QRauTBZOIqZB9imikLwxfpVwooXNVeH+oziJj7Ko1I9azLeu8EGFxbwJ8PCMfLvdBfxG
         EeqQ==
X-Gm-Message-State: AC+VfDzVkeOjU/RWpHjLahAHECdtnunzO0mf+EZyMNEMrz24sbG4FHzj
        Q5plrFBqJg8W4LUseQChbhHJT5j0FGQ=
X-Google-Smtp-Source: ACHHUZ4PXLIoL1QjaMUh6zIjqtQvdlc0tTz20tdsRqDzhxHxpZm8amcoFKw2h7saTgMRW6/vNPfWzA==
X-Received: by 2002:a17:90a:d486:b0:253:87e5:384a with SMTP id s6-20020a17090ad48600b0025387e5384amr15972867pju.42.1684966657647;
        Wed, 24 May 2023 15:17:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0024e2980574asm1967335pjd.4.2023.05.24.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:17:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 May 2023 15:17:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adm1266.c: Fix error checking for debugfs_create_dir
Message-ID: <e227fe50-1d46-4d84-b869-f0fa74154d02@roeck-us.net>
References: <20230524165423.21024-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524165423.21024-1-osmtendev@gmail.com>
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

On Wed, May 24, 2023 at 09:54:23PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in adm1266.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is using 'IS_ERR' inline function.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 1ac2b2f4c570..d88b6115b42e 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -340,7 +340,7 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
>  		return;
>  
>  	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
> -	if (!data->debugfs_dir)
> +	if (IS_ERR(data->debugfs_dir))
>  		return;

Just drop the error check entirely instead. It is not needed.

Thanks,
Guenter

>  
>  	debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
