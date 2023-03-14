Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68DF6BA018
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCNTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCNTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:53:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F743430A;
        Tue, 14 Mar 2023 12:53:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd5so32851831edb.7;
        Tue, 14 Mar 2023 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsp8Tj0Vktuf9bbrjDiQaJ9V5M9finhOPDw8dAUIlFQ=;
        b=QRy9UBfQi/bmZP2AMa6LauQh1VorDM8ZrVcpeEFJYZ0LnAdvOX5JcghVGOPDf9/TCR
         Xlk2evnPwBe60SCL69UtvMbHoKjI8gItlfvKSKOUzlFyhzZT01xFoux8YD20tQTXYEX3
         c6QlWOR9qWYRN4QLaTLo+cJlnTO1sRmnUOm3au7yxfk9EkmGVge91mhj0KHUV5TfILZa
         kbof++5IA8CBHsvpSOONobt2u4aPz3OyyubfLNXApoUzYEEBms6jR1RANbdfRpW0LcrQ
         7NiGinbujqirCtCbGGGLsTi48KwMpfqyUF2YtVAjd9gizGEAGeTmoq9uxYdAeVZ3+s4B
         v4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsp8Tj0Vktuf9bbrjDiQaJ9V5M9finhOPDw8dAUIlFQ=;
        b=WgVNIIkhexp6WyvZFuh/7q/kiQ+tT0d17IqSez56ILs5kyeRbU3p2ypq4lECpepjXK
         9nRuSF99hskcEf3cTdLgKe9x/Emy4gR1JV9UL4/ZWoQQYOUmoJ76FvMpoCcnGNg/A3+k
         RO7j4in7C2nogZW0mUwm7nG0PsuL7AGOFEgbdhRk3FGSwOv9bLspjcQPcvL/uMLFJ4HE
         q3OpQ7ArNYxn9NaTJbpetNC6tiy+s8ux1xjKtDqLLgW0NZTKuCDS1oZWryi47ECAYha3
         o8ZoND02kpuF8TkVfwkHTegTu60wznOX+aDaXhmwWWbrNWUILCOgFLqU+HPgEzRdghty
         w+WQ==
X-Gm-Message-State: AO0yUKWXwS+yIz7v8ySdxlWHzuwUEyt2HZyXaQFH+9QIThs/YtulJBFh
        pyQjq0FORh3xg1M0ut057gg=
X-Google-Smtp-Source: AK7set/aZQdUOqZ2pfdQ1/SmUcMim+rOjI0ri/3qpQg1f1JZzTN0Sb5PQFFOEMQcK+x6rxZijFw+9w==
X-Received: by 2002:a17:906:dc3:b0:839:74cf:7c4f with SMTP id p3-20020a1709060dc300b0083974cf7c4fmr4344319eji.8.1678823603740;
        Tue, 14 Mar 2023 12:53:23 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id rq4-20020a17090788c400b00927341bf69dsm1523827ejc.88.2023.03.14.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:53:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, Zheng Wang <zyytlz.wz@163.com>
Cc:     hverkuil@xs4all.nl, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH v2] media: cedrus: fix use after free bug in cedrus_remove due to
 race condition
Date:   Tue, 14 Mar 2023 20:53:22 +0100
Message-ID: <2274018.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230313163120.3741811-1-zyytlz.wz@163.com>
References: <20230313163120.3741811-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 13. marec 2023 ob 17:31:20 CET je Zheng Wang napisal(a):
> In cedrus_probe, dev->watchdog_work is bound with cedrus_watchdog function.
> In cedrus_device_run, it will started by schedule_delayed_work. If there is
> an unfinished work in cedrus_remove, there may be a race condition and
> trigger UAF bug.
> 
> CPU0                  CPU1
> 
>                     |cedrus_watchdog
> 
> cedrus_remove       |
>   v4l2_m2m_release  |
>   kfree(m2m_dev)    |
> 
>                     | v4l2_m2m_get_curr_priv
>                     | 
>                     |   m2m_dev //use
> 
> Fix it by canceling the worker in cedrus_remove.
> 
> Fixes: 7c38a551bda1 ("media: cedrus: Add watchdog for job completion")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - use cancel_delayed_work_sync instead and add Fixes
> label suggested by Hans Verkuil
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c
> b/drivers/staging/media/sunxi/cedrus/cedrus.c index
> a43d5ff66716..a50a4d0a8f71 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -547,6 +547,7 @@ static int cedrus_remove(struct platform_device *pdev)
>  {
>  	struct cedrus_dev *dev = platform_get_drvdata(pdev);
> 
> +	cancel_delayed_work_sync(&dev->watchdog_work);
>  	if (media_devnode_is_registered(dev->mdev.devnode)) {
>  		media_device_unregister(&dev->mdev);
>  		v4l2_m2m_unregister_media_controller(dev->m2m_dev);




