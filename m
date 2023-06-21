Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA5737A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFUF3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjFUF3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCA132
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249C761472
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA7BC433C8;
        Wed, 21 Jun 2023 05:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687325360;
        bh=iB9jajYsdluGlrHxuy+Bfpc4UBICTy3XGxAME+vlLgg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RUWIQFYLLFWCGF9jb6BNsc++LyYsfcYawpPegaQeN/W0Gh//s1cbANEtkwwXNJXnW
         mPsqrzfo6gaosH/K3DfMYw7evGjCij5S0UiA93YEsbT2YlCP6OtyrHOKM80QyF5sDh
         wgzxcSom1382XvGTYyBjut0jVqO8MnZe3f0Z2IMBh30to/oWRsUTx28jCEk/uHePTX
         MdYhUrSb/uJFj3Rul9BBwybtgyH/yIiRLXP4QTjz98loIMD8EJpukXfnPfqpoegB8R
         WEgL+hYUja9H1ZXgMmS34fklUmNURpRfoDSjx/T0bcPtOkieDDh0vKb3bCRIF5X69D
         czfvM2QR6tKzA==
Message-ID: <5ea5a61e-3770-b990-47a6-7bab34ebb142@kernel.org>
Date:   Wed, 21 Jun 2023 00:29:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] firmware: stratix10-svc: fix bug in saving
 controller data
Content-Language: en-US
To:     tien.sung.ang@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230621024930.1392294-1-tien.sung.ang@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230621024930.1392294-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 21:49, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata.
> They both are of the same data and overrides each other. This resulted
> in the rmmod of the svc driver to fail and throw a kernel panic
> for kthread_stop and fifo free.
> 
> Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
> 

Remove the newline.
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>   drivers/firmware/stratix10-svc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index ca713f39107e..60e08987c402 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -130,6 +130,7 @@ struct stratix10_svc_data {
>    * @complete_status: state for completion
>    * @invoke_fn: function to issue secure monitor call or hypervisor call
>    * @sdm_lock: a mutex lock to allow only one pending sdm message per client
> + * @svc: manages the list of client svc drivers
>    *
>    * This struct is used to create communication channels for service clients, to
>    * handle secure monitor or hypervisor call.
> @@ -144,6 +145,7 @@ struct stratix10_svc_controller {
>   	svc_invoke_fn *invoke_fn;
>   	/* Enforces atomic command sending to SDM */
>   	struct mutex *sdm_lock;
> +	struct stratix10_svc *svc;
>   };
>   
>   /**
> @@ -1252,6 +1254,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   		ret = -ENOMEM;
>   		goto err_free_kfifo;
>   	}
> +	controller->svc = svc;
>   
>   	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
>   	if (!svc->stratix10_svc_rsu) {
> @@ -1279,8 +1282,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   		goto err_unregister_dev;
>   	}
>   
> -	dev_set_drvdata(dev, svc);
> -
>   	pr_info("Intel Service Layer Driver Initialized\n");
>   
>   	return 0;
> @@ -1296,8 +1297,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   
>   static int stratix10_svc_drv_remove(struct platform_device *pdev)
>   {
> -	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
>   	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
> +	struct stratix10_svc *svc = ctrl->svc;
>   
>   	platform_device_unregister(svc->intel_svc_fcs);
>   	platform_device_unregister(svc->stratix10_svc_rsu);

Please base this patch first! I'm not sure about your first patch yet.

Thanks,
Dinh
