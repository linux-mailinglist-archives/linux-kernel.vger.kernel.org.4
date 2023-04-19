Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFD6E7EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjDSPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjDSPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:55:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A2297;
        Wed, 19 Apr 2023 08:55:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a8097c1ccfso1243785ad.1;
        Wed, 19 Apr 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681919700; x=1684511700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhXUoh34NamNvTQH69I9zjDnkS1EScZkwBBLHJJcaJk=;
        b=f3766/jpxvMh6aWx2CivzNNam5DgFVbmQyH3f7bEDmr9Q4bv9yXc1ziup1VpH2H7ss
         xnMq3u8CeBo/U0DLNumhUPeIrccMettPew0fPl6yUvYgYFiC4Czk71xjMbmGyp2QTLGb
         QnzCmKv8bTi/RNKP+VXwCJRLPyTvH1vrJxDXWPhppBRGQCTVxAgAKeGPoT74VqxaWmA9
         7yP79UX3TcdWjVv8glS7I1eJsYVIeQs1WXhILqE/U81vflaFOhzdKjTexYyBI8jdV3sE
         jTHFC/cyYlNiIPO95tdGfRzytC2uCuXR7posQXs3LLO9kLff4M7v3P8JYVOeV24NQSEp
         5pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681919700; x=1684511700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhXUoh34NamNvTQH69I9zjDnkS1EScZkwBBLHJJcaJk=;
        b=AVdtc1ztKqFRVnXH/O3Mh5BA6h1FsDlC84kYZE6UzvEgqnyz2J8B1B0an8dQioTmXF
         B/v+ayDlzhzhGzcdah4Smx9+YY+ypr3MTZe6vp0wDk7uS4y5ZbWaJqCIzechFB9dV8ht
         4u7V/FdZqisqkp4zpOkYV4IeLemIDYW92ndPN7sbtf4mFCFPw3ceEmrtaj+Ped5uYu6H
         zJgakHmzr5UjjYc1dI0YnJtCTKJNPgNPnhn/QjVjiPARybxHInyw/E1i7wOnO3X7mkyf
         cHPYInZO5QY6v+CvdfcMoOe1ZBvors5LFycpuWdf/u9xP1jLyHyE10Tkkh4ts6naPC1z
         WFgw==
X-Gm-Message-State: AAQBX9dHKWZBReCbRU1giDP6AWikmRPhQ7cq+c5tDxcqHH90qEF94B3k
        hM6VnAyDXPV3r8iXqU53Jj8=
X-Google-Smtp-Source: AKy350Z93mFy+nER+454siOpfIUydCEDlSjhWndLlNj+1tW9UKJbJFmdRJLQQEUHP6w/pT3U2qjrFw==
X-Received: by 2002:a17:903:22cc:b0:1a6:7570:5370 with SMTP id y12-20020a17090322cc00b001a675705370mr6705160plg.10.1681919699833;
        Wed, 19 Apr 2023 08:54:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b001a50ede5086sm11593130pll.51.2023.04.19.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:54:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Apr 2023 08:54:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, manio@skyboo.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (adt7475) Use device_property APIs when
 configuring polarity
Message-ID: <a0723d7a-c8db-4a9d-bb6e-57bf3d76484b@roeck-us.net>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418233656.869055-2-chris.packham@alliedtelesis.co.nz>
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

On Wed, Apr 19, 2023 at 11:36:55AM +1200, Chris Packham wrote:
> On DT unaware platforms of_property_read_u32_array() returns -ENOSYS
> which wasn't handled by the code treating adi,pwm-active-state as
> optional. Update the code to use device_property_read_u32_array() which
> deals gracefully with DT unaware platforms.
> 
> Fixes: 86da28eed4fb ("hwmon: (adt7475) Add support for inverting pwm output")
> Reported-by: Mariusz Białończyk <manio@skyboo.net>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     I've not currently got access to a DT unaware platform with an ADT7475
>     chip so I'm not 100% sure that this will fix the problem Mariusz
>     reported but looking at drivers I think this approach is correct.
>     
>     Changes in v2:
>     - use device_property_read_u32_array instead of checking for -ENOSYS
> 
>  drivers/hwmon/adt7475.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6e4c92b500b8..6a6ebcc896b1 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1604,9 +1604,9 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
>  	int ret, i;
>  	u8 val;
>  
> -	ret = of_property_read_u32_array(client->dev.of_node,
> -					 "adi,pwm-active-state", states,
> -					 ARRAY_SIZE(states));
> +	ret = device_property_read_u32_array(&client->dev,
> +					     "adi,pwm-active-state", states,
> +					     ARRAY_SIZE(states));
>  	if (ret)
>  		return ret;
>  
