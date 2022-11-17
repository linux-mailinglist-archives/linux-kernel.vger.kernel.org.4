Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B062D7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiKQKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiKQKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:12:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E92A703
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:12:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id io19so1169658plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TxPSqsonwjR+jb5PgMExEfKpLHjK26PAb4UUm/yOJd8=;
        b=DmzgMB0uQ+dDHl3drW8HkrKDjEsT4b6fKp2gOrgVceAPsBPoGfQ1aj9iyn9nVRXRxT
         tzBrRmynTBnPrmFpYltbKYuXA/29p5JKaNlJTnH7zLBW/SPzwl0MiOSgc5jM8/jbR7yc
         YFOKodX6eBIlACqbAaWy+SP6PylUOVwIZxvFpo3cUC/x9pcKvt66FZDn1DCur9NVLEwn
         gLZwGagga1KE2BD4grKPgEUuWziq+HcYpHm4xwmTcNlvjqtmcI3pfX0gDpsU5YXIbBMh
         BuhttAZkBb9mygKY4jhraU7m9O57q/4quvTf+9YTxtsR+wmKHNoQAXMQ7fxR4NZWz+8l
         uONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxPSqsonwjR+jb5PgMExEfKpLHjK26PAb4UUm/yOJd8=;
        b=dq5kNVhOLRDGE+G4lsV2k0291n6bGM81z/h9c2ZHVr8g8wFQEt9Lf9l5rv8YOXDA4r
         9WtSxj4T+PVAQnp/ed4cTq/fALVB11bVc7htB9y8/802LOr0ZbuBZepEsk4Hzmt7XE2E
         /UMwKtn/2+wCsFyncesPvCOazOBdKjehYf6iwOcDTreVi4E4HSsT5Qz63hpolwB/P94L
         Pko5mQUIlh4pGamsGwCA2A9aZomhHgJ7KTqfoZvT3WyMy07PPYIQWTEcvuA/mFBUA6Nk
         1146whgNzi2sJ73dWpeOwCCQIYWRceE/RTOKibSsfV92qBf7dob5xByZ/wAewdALVCgF
         xEYQ==
X-Gm-Message-State: ANoB5plWXX/TV/WBqU3pKrf9HG6ukjGLvz+EJV/P7JdmhI9vglRCxrrp
        HpxNsZSNn/+XmfR0zDqO2EnIOIyVHYq7uxAabfA1nQ==
X-Google-Smtp-Source: AA0mqf4X/jBMXpXsAsCPAVdEPftZmWjWMN1oy+8kCMECNgiyGi/tE0XnYjkpb5oqCjEcbDbUSQwl0lhKmCzqGu/92Xw=
X-Received: by 2002:a17:90a:1b86:b0:213:acf:dbc0 with SMTP id
 w6-20020a17090a1b8600b002130acfdbc0mr2134264pjc.64.1668679961938; Thu, 17 Nov
 2022 02:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20221117032220.3442738-1-ruanjinjie@huawei.com>
In-Reply-To: <20221117032220.3442738-1-ruanjinjie@huawei.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Nov 2022 15:42:30 +0530
Message-ID: <CAFA6WYNYxiEOjcV7knNSwtHYtmGpuPMt1kAb8KjLBk6Ggj2+sA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: fix possible memory leak in optee_register_device()
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     jens.wiklander@linaro.org, daniel.thompson@linaro.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Nov 2022 at 08:55, ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> If device_register() returns error in optee_register_device(),
> name of kobject which is allocated in dev_set_name() called in device_add()
> is leaked.
>
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/tee/optee/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

There's already a prior patch posted to fix this here [1].

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/thread/BMADRGTZ63GP5ORMMISW7RJPMZKINXE7/

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index f3947be13e2e..64f0e047c23d 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -80,7 +80,7 @@ static int optee_register_device(const uuid_t *device_uuid)
>         rc = device_register(&optee_device->dev);
>         if (rc) {
>                 pr_err("device registration failed, err: %d\n", rc);
> -               kfree(optee_device);
> +               put_device(&optee_device->dev);
>         }
>
>         return rc;
> --
> 2.25.1
>
