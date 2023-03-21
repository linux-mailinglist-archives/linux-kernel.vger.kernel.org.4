Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8816C34CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCUOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCUOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:52:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EA5252;
        Tue, 21 Mar 2023 07:52:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y85so997105iof.13;
        Tue, 21 Mar 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679410373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jbuk/VUjw++Wvp9c5QPRyHnJPx2dRUo86+cSOxQlz+A=;
        b=oKj4FbaigdjT5YA9JIkCkC2qilVfgSZUPqtC+MMWQlYB3lq+oiSZIF0YqhsAa49vHb
         NAj8FNtVOylq9xo7LVIWBeq68Flvkxltc75UshfgsK9t2c3DXXmWI3ok+dl+06VSead2
         e0KpzwlPa0LiopyHzGbUxMhP29FEybS79LWG3NT7B17OAD7MPZ/3krNGNVfS0hdhd+TB
         GjQ2N9P6SE2uu67g6TpSklYBa1nysSoMiZ90lCvR9EgGzW8lDJPbXvxh1wOM3D/lNYCZ
         YmbUfBoK0P59+nm6Q8LQNJpfV311iCItoS7Upv3LSHSubPiXMpcJ6xFN5Iy8Yzli3fae
         ioBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jbuk/VUjw++Wvp9c5QPRyHnJPx2dRUo86+cSOxQlz+A=;
        b=mIjhcvYQJxUkdVVvxBH5cj4yfGA+2OoTRupprLK2qaMbmmYrFbN4pjly1CxYZxBLtm
         WwA+rLmZsEsOQzQ3ls8wzr64t2Y2xdwL8q8foohDYMfIw6vn1ll8MbYx03jAtP8N7b3J
         EvilYyjTeZEBVuoskUplELqsaJ3jSWb/h1azdPUiXfkOJPDaPBVR0axbl8k5ozyH7LLm
         R42cmz2xK8g6ngtY1Yut+hLpq3/PMYXJtQlVk9R+sXdH9Ky/XUrfEUnBjdRotq4KWTMp
         Lb3gtkN4rMbPdmaMTM14eXqMauKAkaZGXUmtSL2iiZmPTUU2SqFxUsdYlYch5Rxe4Ln4
         CiXQ==
X-Gm-Message-State: AO0yUKW4OcVCDM3BnuwU84iOsJOVRgAcVwWY2/TFoVP1oO0dAVN8hxjv
        gBjI3HoEmS9dBXvc94U/ENs=
X-Google-Smtp-Source: AK7set+svyd4xtMq5jxLWt6UpLds+UXMU19TZXlaHm742t8TY+/7vzvje+DLL5FwwhwTm9H3LL9S/Q==
X-Received: by 2002:a6b:f30a:0:b0:753:7aa7:32a4 with SMTP id m10-20020a6bf30a000000b007537aa732a4mr2233951ioh.0.1679410373091;
        Tue, 21 Mar 2023 07:52:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h24-20020a056602009800b00743fe29dd56sm3682930iob.4.2023.03.21.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:52:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Mar 2023 07:52:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tianyi Jing <jingfelix@hust.edu.cn>
Cc:     Jean Delvare <jdelvare@suse.com>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: hwmon: fix ioremap and memremap leak
Message-ID: <668f31bc-79af-4100-997e-089ed359985a@roeck-us.net>
References: <20230318143851.2191625-1-jingfelix@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318143851.2191625-1-jingfelix@hust.edu.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 10:38:51PM +0800, Tianyi Jing wrote:
> Smatch reports:
> 
> drivers/hwmon/xgene-hwmon.c:757 xgene_hwmon_probe() warn:
> 'ctx->pcc_comm_addr' from ioremap() not released on line: 757.
> 
> This is because in drivers/hwmon/xgene-hwmon.c:701 xgene_hwmon_probe(),
> ioremap and memremap is not released, which may cause a leak.
> 
> To fix this, ioremap and memremap is modified to devm_ioremap and
> devm_memremap.
> 
> Signed-off-by: Tianyi Jing <jingfelix@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Applied. Note that I updated the subject and changed formatting a bit.

Guenter

> ---
> v1 -> v2: use devm_ioremap and devm_memremap instead.
>  drivers/hwmon/xgene-hwmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 5cde837bfd09..a25fae9b19b7 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -698,11 +698,13 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
>  		if (ctx->comm_base_addr) {
>  			if (version == XGENE_HWMON_V2)
> -				ctx->pcc_comm_addr = (void __force *)ioremap(
> +				ctx->pcc_comm_addr = (void __force *)devm_ioremap(
> +							&pdev->dev,
>  							ctx->comm_base_addr,
>  							pcc_chan->shmem_size);
>  			else
> -				ctx->pcc_comm_addr = memremap(
> +				ctx->pcc_comm_addr = devm_memremap(
> +							&pdev->dev,
>  							ctx->comm_base_addr,
>  							pcc_chan->shmem_size,
>  							MEMREMAP_WB);
