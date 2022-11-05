Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E561DDB2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKET3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKET3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:29:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43515DE9A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:29:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a5so12021040edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5WiDnJYUMPEroIJVQhoDLGCwGwQSDuzD60DQkwC21U=;
        b=XDXvj1FgNwwxOavSqI5F6MfzY3W7wZ6QiIBe4PadMQSGJ51QnDJV02SJYfmuS06uZO
         dxOBNd0gzXZsXLVJvFFnpS4MEJSE4O0GB63eokcPk+R+DPNvm7/XavHRBL+Q4VpnOMFE
         FR6d5yiFdt9lcSoG8hL4gIy+q0N5Dew8zx7ALRr5hy1buOBBI5CSiL+FAB3k3uNhPRKN
         3oB6WxhQj8EUN9NQCV97Lgn47sfbCJhkWbHyuCiSJSGg1PL8X8NBQnx452UobkWdnDvA
         BlYMezSzkys4AxT6nLQS9AIiYYAzQ7te/JYys4eAdv6YN5gZBbLMljk1wlgZnFNIepRL
         N2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5WiDnJYUMPEroIJVQhoDLGCwGwQSDuzD60DQkwC21U=;
        b=bTmRE2oHAXl+h48iT7BYpgcQ5U5VmXBuixf2XhyePwoWkKHObmJH2M/2qeIVMIGkQ7
         +2gUca3yu5oexyHDU+9ag3wwb+Qx2GhncwtoqIKfw1y57tcO/+qvllQcQMFHVLn1lF72
         MWoaYJCrjDJ6eZ2qFuChA441RzSMAkON8O6gWXfVelDZHzh3mRFVS0HUdfO5SD2V/ULY
         uArzeS66e6QIYabLhcIvKC84tADDXUjRDEGDXqE/gmJuHlmW5IEr4JXOgIdG4dOwlp13
         VDkE/sEbK4Y4zBLl4zkAKV8JfDBx/90wmLUZ0v1qt2BQBKZX7slzrB8LuEsFm4pVOe4N
         XuDw==
X-Gm-Message-State: ACrzQf2glQQ7mHM2Jdxt6kIiQhzJCZjZOGgiaHWdhC34dY45lpbRsBO4
        NOV3dNxGtyRqDBG0bQo/7h0=
X-Google-Smtp-Source: AMsMyM5OwVk8D3AHxkt9RmUJOdie6sDw+sHJ8tcCbe0A/BYCweeCFTHh9v2l13vFBF21Ccdryh6pKA==
X-Received: by 2002:a50:950d:0:b0:463:298a:448c with SMTP id u13-20020a50950d000000b00463298a448cmr35877817eda.153.1667676557640;
        Sat, 05 Nov 2022 12:29:17 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b007812ba2a360sm1253482ejc.149.2022.11.05.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:29:17 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] bus: sunxi-rsb: Remove shutdown callback
Date:   Sat, 05 Nov 2022 20:29:15 +0100
Message-ID: <2652299.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20221105191954.14360-2-samuel@sholland.org>
References: <20221105191954.14360-1-samuel@sholland.org> <20221105191954.14360-2-samuel@sholland.org>
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

Dne sobota, 05. november 2022 ob 20:19:52 CET je Samuel Holland napisal(a):
> Shutting down the RSB controller prevents communicating with a PMIC
> inside pm_power_off(), so it breaks system poweroff on some boards.
> 
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Fixes: 843107498f91 ("bus: sunxi-rsb: Implement suspend/resume/shutdown
> callbacks") Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/bus/sunxi-rsb.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 4cd2e127946e..17343cd75338 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -812,14 +812,6 @@ static int sunxi_rsb_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> -static void sunxi_rsb_shutdown(struct platform_device *pdev)
> -{
> -	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
> -
> -	pm_runtime_disable(&pdev->dev);
> -	sunxi_rsb_hw_exit(rsb);
> -}
> -
>  static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
>  	SET_RUNTIME_PM_OPS(sunxi_rsb_runtime_suspend,
>  			   sunxi_rsb_runtime_resume, NULL)
> @@ -835,7 +827,6 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
>  static struct platform_driver sunxi_rsb_driver = {
>  	.probe = sunxi_rsb_probe,
>  	.remove	= sunxi_rsb_remove,
> -	.shutdown = sunxi_rsb_shutdown,
>  	.driver	= {
>  		.name = RSB_CTRL_NAME,
>  		.of_match_table = sunxi_rsb_of_match_table,




