Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C965E6CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiIVUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiIVUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5BE8DAC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663877216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlDx58buz1NO+JYU/5r/GIV4poX4sHqJ9QfL+BBtIvo=;
        b=a6S+6g40CH7l7K/91gSlINm0wsfTfNcQl1m03w0Mzs/thk3u523ukj+8btxY2dsINlSqw2
        O3zTutLhT+3kBxhTu5BJV0PSmQZdOizu/MivrQGxD3699JcjyM+HPvLdIcs0oBUgtIwnX0
        yFhUYygI3l84JN8JE/EHoNHoS2OUubw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-QlgEeocFPy68TJqH-UT-Xw-1; Thu, 22 Sep 2022 16:06:51 -0400
X-MC-Unique: QlgEeocFPy68TJqH-UT-Xw-1
Received: by mail-qt1-f200.google.com with SMTP id fv21-20020a05622a4a1500b0035cc9b4fc20so7153244qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WlDx58buz1NO+JYU/5r/GIV4poX4sHqJ9QfL+BBtIvo=;
        b=6qs+tx65rVq5/u3kWhcilwzMrC3uSotRzKHW1HalpCMscxOvR5Ni/uOstwnLlXMtKa
         bvxbuxxhXmG9G6uZC566JVb4g2BPehAiDDBlZ254bWlUH4MEQX+L5mbZsG89IkCJyGhV
         cO1nhSxf6FU77bzqgfsx0MYDnqX5KKK6r4awfGoFnxNNrAMbOgLEyAyTq45B06LXm4EE
         49K8r/ggIJhFLy4ZAdzPLwLv5c5QlRi5o1qlZoApiDsHqf900uBxY2YywHULAKys9lx8
         nO++Je3vEmId06uRyBTpCfLIwRvQ+0fz2POEwLLoCm828ycW6+IdIiS/lV9ONcen82d6
         26Wg==
X-Gm-Message-State: ACrzQf3TSR5ErDGWQsdn59Ie9+EkXIlZz3JNovIadnhBQ6aqywJboJiP
        eoUHFwMRELUCWGhcLRz5mF4XfvrnORJJpg8V9Z1UHVnnmoZ2G0GEzEC1oTbGAikFqLZhos9J8f+
        bG9s1NaRJjGFQQbKZ4i+e/F1s
X-Received: by 2002:a05:6214:20ed:b0:4ac:b2b4:39af with SMTP id 13-20020a05621420ed00b004acb2b439afmr4014725qvk.57.1663877210073;
        Thu, 22 Sep 2022 13:06:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7cp/R2aPOJidkotV4qE0F+VqTWFgvRrWrnqT6AZcJi4NhHX2Cd4NT40J4wIbUo+zZgWP6lSg==
X-Received: by 2002:a05:6214:20ed:b0:4ac:b2b4:39af with SMTP id 13-20020a05621420ed00b004acb2b439afmr4014712qvk.57.1663877209890;
        Thu, 22 Sep 2022 13:06:49 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id u5-20020a37ab05000000b006b8e8c657ccsm4262851qke.117.2022.09.22.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:06:48 -0700 (PDT)
Message-ID: <3da8a0c9ae4e6d8a1d772498e4d4186bf969fd76.camel@redhat.com>
Subject: Re: [PATCH 1/9] Input: synaptics-rmi4 - fix firmware update
 operations with bootloader v8
From:   Lyude Paul <lyude@redhat.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Sep 2022 16:06:48 -0400
In-Reply-To: <20220608124808.51402-2-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <20220608124808.51402-2-matthias.schiffer@ew.tq-group.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would add a Cc: stable@vger.kernel.org for this

With that fixed: Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-06-08 at 14:48 +0200, Matthias Schiffer wrote:
> Commit a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in
> f34v7") allowed the F34v7 driver to probe with bootloader v8, but it did
> not update various other bootloader version checks in the F34 code.
> 
> Fixes: a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in f34v7")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/input/rmi4/rmi_f34.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index e5dca9868f87..3afc94f679ed 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -370,7 +370,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
>  
>  	f34 = dev_get_drvdata(&data->f34_container->dev);
>  
> -	if (f34->bl_version == 7) {
> +	if (f34->bl_version >= 7) {
>  		if (data->pdt_props & HAS_BSR) {
>  			dev_err(dev, "%s: LTS not supported\n", __func__);
>  			return -ENODEV;
> @@ -382,7 +382,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
>  	}
>  
>  	/* Enter flash mode */
> -	if (f34->bl_version == 7)
> +	if (f34->bl_version >= 7)
>  		ret = rmi_f34v7_start_reflash(f34, fw);
>  	else
>  		ret = rmi_f34_enable_flash(f34);
> @@ -413,7 +413,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
>  	f34 = dev_get_drvdata(&data->f34_container->dev);
>  
>  	/* Perform firmware update */
> -	if (f34->bl_version == 7)
> +	if (f34->bl_version >= 7)
>  		ret = rmi_f34v7_do_reflash(f34, fw);
>  	else
>  		ret = rmi_f34_update_firmware(f34, fw);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

