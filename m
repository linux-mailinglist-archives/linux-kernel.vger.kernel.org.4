Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191C62C034
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiKPN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiKPNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:54:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3F1FF81;
        Wed, 16 Nov 2022 05:52:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o13so16695420pgu.7;
        Wed, 16 Nov 2022 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE8Bywh8BMx9MbBYcJciGWZ2W4r+qqOoJKsSHNwvapg=;
        b=FKXn9ThVvTJ+C2X8Xfc+S3qEitakHp1VdUslk2EgC2x9m6OCWDzC2XdIVLLXf94tt8
         22pajFKgPS5Mdpw+hlB38hfE/pI1yzG62MBat0Dt05rGHK/RR4aFcyb+uxRukQ2MJ3TF
         qV6M1mPucdMee1m2VX2q7iXkK6B36I5xP6/RiiNboDyEdgbLYnTg0NFRE8htSa4BsBp9
         Rks05PT2lv+TUWk2H06nWozALlY2pfjrYvIL+JyUsS0n1HjJjVxd4hzfAtRyDTG/S5nM
         FcQrw2IYxIr6FBjIV3vPWx+7PvNobyKYBsWHIJ/VrvRm+1yFfX5glZUr6aVjLEjK0wVo
         V0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE8Bywh8BMx9MbBYcJciGWZ2W4r+qqOoJKsSHNwvapg=;
        b=U2rQvngCQte0VmrcdzJZNXnSVFll+nsYfvWHsJMcVFlHCCq3vE8lCGVeNMxt7+zSnm
         wG7FIT8V64+mJPhNb8EA16jxBYEp2Qhl/KPXnE1hi0UsfenRqV1nb3cf33rDQT5juuP1
         e/FDWCwiYiTSInwi+zeUi3apqoM/mlSem1UyYdXnTkiujHF+ivPh/OkcbR91WG/8AT2f
         OibJhN1ehRRL9+d/WfLArhXXJaHvj9HdbQTHflHyJU6QzUi3aiEzzA9RFkKer3TPNVnS
         FJ6PcJvFpC3F8EqEgR720SRx6jVlaNZDODakZ+JVtMv1/X4E8n1a3E971InBGN8jTPUT
         uA6w==
X-Gm-Message-State: ANoB5pncSA+PF49akesSY/8EdbbnpIlepuOFFDpa0fYu0pdpA4xJXZz5
        4vxzAcZbEBmMKQOD7hIbL0U=
X-Google-Smtp-Source: AA0mqf7YkAdvoLyaKtPc/sMsNjwotS9YfoiuJtTGFcPdvNug3Ae2cYkRs1nvXCk7j0Gfas2jtf0UMA==
X-Received: by 2002:a63:4b1a:0:b0:41a:4bd4:f2dd with SMTP id y26-20020a634b1a000000b0041a4bd4f2ddmr20643039pga.106.1668606751639;
        Wed, 16 Nov 2022 05:52:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b00187197c499asm12125044plb.164.2022.11.16.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:52:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Nov 2022 05:52:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, haokexin@gmail.com, xuqiang36@huawei.com
Subject: Re: [PATCH] watchdog: Fix kmemleak in watchdog_cdev_register
Message-ID: <20221116135229.GA3498904@roeck-us.net>
References: <20221116012714.102066-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116012714.102066-1-chenjun102@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:27:14AM +0000, Chen Jun wrote:
> kmemleak reports memory leaks in watchdog_dev_register, as follows:
> unreferenced object 0xffff888116233000 (size 2048):
>   comm ""modprobe"", pid 28147, jiffies 4353426116 (age 61.741s)
>   hex dump (first 32 bytes):
>     80 fa b9 05 81 88 ff ff 08 30 23 16 81 88 ff ff  .........0#.....
>     08 30 23 16 81 88 ff ff 00 00 00 00 00 00 00 00  .0#.............
>   backtrace:
>     [<000000007f001ffd>] __kmem_cache_alloc_node+0x157/0x220
>     [<000000006a389304>] kmalloc_trace+0x21/0x110
>     [<000000008d640eea>] watchdog_dev_register+0x4e/0x780 [watchdog]
>     [<0000000053c9f248>] __watchdog_register_device+0x4f0/0x680 [watchdog]
>     [<00000000b2979824>] watchdog_register_device+0xd2/0x110 [watchdog]
>     [<000000001f730178>] 0xffffffffc10880ae
>     [<000000007a1a8bcc>] do_one_initcall+0xcb/0x4d0
>     [<00000000b98be325>] do_init_module+0x1ca/0x5f0
>     [<0000000046d08e7c>] load_module+0x6133/0x70f0
>     ...
> 
> unreferenced object 0xffff888105b9fa80 (size 16):
>   comm ""modprobe"", pid 28147, jiffies 4353426116 (age 61.741s)
>   hex dump (first 16 bytes):
>     77 61 74 63 68 64 6f 67 31 00 b9 05 81 88 ff ff  watchdog1.......
>   backtrace:
>     [<000000007f001ffd>] __kmem_cache_alloc_node+0x157/0x220
>     [<00000000486ab89b>] __kmalloc_node_track_caller+0x44/0x1b0
>     [<000000005a39aab0>] kvasprintf+0xb5/0x140
>     [<0000000024806f85>] kvasprintf_const+0x55/0x180
>     [<000000009276cb7f>] kobject_set_name_vargs+0x56/0x150
>     [<00000000a92e820b>] dev_set_name+0xab/0xe0
>     [<00000000cec812c6>] watchdog_dev_register+0x285/0x780 [watchdog]
>     [<0000000053c9f248>] __watchdog_register_device+0x4f0/0x680 [watchdog]
>     [<00000000b2979824>] watchdog_register_device+0xd2/0x110 [watchdog]
>     [<000000001f730178>] 0xffffffffc10880ae
>     [<000000007a1a8bcc>] do_one_initcall+0xcb/0x4d0
>     [<00000000b98be325>] do_init_module+0x1ca/0x5f0
>     [<0000000046d08e7c>] load_module+0x6133/0x70f0
>     ...
> 
> The reason is that put_device is not be called if cdev_device_add fails
> and wdd->id != 0.
> 
> watchdog_cdev_register
>   wd_data = kzalloc                             [1]
>   err = dev_set_name                            [2]
>   ..
>   err = cdev_device_add
>   if (err) {
>     if (wdd->id == 0) {  // wdd->id != 0
>       ..
>     }
>     return err;  // [1],[2] would be leaked
> 
> To fix it, call put_device in all wdd->id cases.
> 
> Fixes: 72139dfa2464 ("watchdog: Fix the race between the release of watchdog_core_data and cdev")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/watchdog_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 55574ed42504..fdffa6859dde 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1061,8 +1061,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
>  		if (wdd->id == 0) {
>  			misc_deregister(&watchdog_miscdev);
>  			old_wd_data = NULL;
> -			put_device(&wd_data->dev);
>  		}
> +		put_device(&wd_data->dev);
>  		return err;
>  	}
>  
> -- 
> 2.17.1
> 
