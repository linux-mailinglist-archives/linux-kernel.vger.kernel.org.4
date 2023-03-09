Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF26B17DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCIA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCIA2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:28:02 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EA13B;
        Wed,  8 Mar 2023 16:27:54 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-176d1a112bfso664186fac.5;
        Wed, 08 Mar 2023 16:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678321674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJBmf2Z8Q7ZeQFMRBJ2hUCFj93WttsNBI3W0yFwZXAY=;
        b=bWYKVfqfrWQUTIOwy24/YGiEMDgukGeAfM1EvAy+kI0hiLaep5/qT0an+TwU+Ckcws
         komc/X9CBQLEqMR1MLdrJDCvrBrfIzBlO5snWhyvzOOdg9QlvbZ7XIvvj0okhwMC6n0J
         Kv7bav1KnUGjmrxW3X4MAHmkEBq30ZvI9y/sBDSdHEx2fWotlg3pHLizVcqwA54L2lu7
         7t1KLUNCE16Zdce/yJBj0IMKokUQZm2IEHlVz9rGtfhA2mtRaTI7GMq1aI56BSB32NBo
         LOJpIP97hQ6OfOF7DvQFzVjor5pLetAfYIHtYX11vjfvlqzmzYEleHYfRHOm6wg75oeB
         exsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678321674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJBmf2Z8Q7ZeQFMRBJ2hUCFj93WttsNBI3W0yFwZXAY=;
        b=Vbip3WVe+4qmaCg9O7pawn3FuQiPko02KJSkPR+KbpjhKvGzqrwjK4+rsIR0Pw1Ux2
         TDAovIOXFmtVa5RkAoN4ahXOQITaQN2R5P//AWifKcFZTYFsInQEKic/Z3RZaCZnVkde
         /4pG2G3EGmLz1gKDXzWmI85lmN2wc1S6iImKUfVWVeGKL3sZr6PDGPUp1xp62WN67tH4
         5oZwQw0oGwnUa78YNir+OfpQGOA+dMW6ShMHJ3IY92esQN3rDJiv9yZb/CqG/PqC8zXA
         OadsBWCs5crIeWOZwRzU9TOLnC+Wlg2Fl0OvNJ+bv93OgD1PJmwiLHRO7KHId55awiQU
         yV3A==
X-Gm-Message-State: AO0yUKUY4+0bBJZ0gmXNclFqDgW28oUjKqK0D4B5RDLVZFM/eg6mBYpW
        wMAXfg7i0SuqrV7lEz74xTQ=
X-Google-Smtp-Source: AK7set8fOyHTZ3eMSb4goRruY3pl5S+G/Jv+leAO+WOaHhIExM7GxVJtVFjbF2Ong4tU3+90AlSvyw==
X-Received: by 2002:a05:6870:9728:b0:163:4a41:ea94 with SMTP id n40-20020a056870972800b001634a41ea94mr2019979oaq.49.1678321673943;
        Wed, 08 Mar 2023 16:27:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d26-20020a4a821a000000b004c60069d1fbsm6707818oog.11.2023.03.08.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:27:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Mar 2023 16:27:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     mchehab@kernel.org, bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Message-ID: <d27127a1-2572-4ad4-b69c-8a6f53384009@roeck-us.net>
References: <20230302093715.811758-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302093715.811758-1-zyytlz.wz@163.com>
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

On Thu, Mar 02, 2023 at 05:37:15PM +0800, Zheng Wang wrote:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
> 
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> 
> CPU0                  CPU1
> 
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..364513e7897e 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>  static int mtk_jpeg_remove(struct platform_device *pdev)
>  {
>  	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
> -
> +	cancel_delayed_work(&jpeg->job_timeout_work);

The empty line is needed (coding style). Also, this doesn't cancel
the worker if it is already running. This should probably be
cancel_delayed_work_sync(). Even then the question is if it is
possible that new work is queued before the device is unregistered.

Guenter

>  	pm_runtime_disable(&pdev->dev);
>  	video_unregister_device(jpeg->vdev);
>  	v4l2_m2m_release(jpeg->m2m_dev);
> -- 
> 2.25.1
> 
