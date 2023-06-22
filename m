Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7892373A079
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFVMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjFVMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE58268C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7305761804
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83053C433C8;
        Thu, 22 Jun 2023 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687435378;
        bh=lYc3kQQ/9qegKQOhk3TC3ONAYzKaU732PlGw0dTEwJg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uBtT3U2LF14hjRlX5/u9C1qQKTFS6W7m50cCEfnBkhxRlAjKRYFKOR2Voyxj0/CRj
         M8rGdmlVBMMOKWU2h2mvgzCwzyC48o2ZPBI30N1wFH2OOyE9Cwb+6/dwikGcwV2H1n
         9+hmvuFrstfioQ1K6Imz03c43epe9RrjD715aGmbJxkXNXGwELiu5vuNE+BDUZjHPU
         /6Sl+b5ugb0zclQu1igZVvuPakOOhtLnukurqe0VfT8xhabpLDODv9zU+HhYATJE+M
         XvYMxFfer5nKR4tyUx7GhOw+/QI0c75Edr5T2GDSnEw0w8tjVAKZ5Q8aPs42TQ8kd0
         bW84C0aKxV4oA==
Message-ID: <fc0af540-37fb-d2ac-3e3d-e0cb43747e69@kernel.org>
Date:   Thu, 22 Jun 2023 07:02:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] firmware: stratix10-svc: fix bug in saving
 controller data
Content-Language: en-US
To:     tien.sung.ang@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230621064645.1431883-1-tien.sung.ang@intel.com>
 <20230621064645.1431883-3-tien.sung.ang@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230621064645.1431883-3-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, I asked you base this patch 1st! That way I can send this patch 
only to Greg KH. The patch to support N SVC clients need more time.

Dinh

On 6/21/23 01:46, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata.
> They both are of the same data and overrides each other. This resulted
> in the rmmod of the svc driver to fail and throw a kernel panic
> for kthread_stop and fifo free.
> 
> Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
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
