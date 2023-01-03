Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223765C2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjACPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjACPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:20:22 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205EC117D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:20:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D4B6E41F72;
        Tue,  3 Jan 2023 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672759219; bh=P1OxW53H6B4WsZsiAHHYobqYXTg8BXINApqEv3gdiFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IZ+ETcylusI16erWQNbxE4AHNr0/OxkpNgYZzRR4U7Ze5+iudmgsUL8rmAxGlBfsR
         voD4gRDLiOCSzIPGRX6pzEXbErgNHMtRM4gpMJm3wsMz04ge1xuuqr+hhKB1Y9Xad7
         kpHeplSqP7Yhhuach2/FlbvF8CqJQNPjVIY5GYxVyl+rTripXExMA+bJ+0BMXlq3eD
         6uvFWO/jtTl75sX9rDrsiAfw3D2WLDCWsHUaL3P8p1UuygIjemkqz5UxWfq+mzsJbX
         KxPbjQ4rCoB1kh2weSpSDKP5aRdyuYJUAWuAbVrojD4P1vvIfITgXV1giy9KjU0ZG5
         SwzFPvPycf9WA==
Message-ID: <169464ed-34c2-08d3-efee-686c9a5eb15d@marcan.st>
Date:   Wed, 4 Jan 2023 00:20:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] nvmem: fix registration vs use race
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <E1pCiUe-00457v-SQ@rmk-PC.armlinux.org.uk>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <E1pCiUe-00457v-SQ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 23.42, Russell King (Oracle) wrote:
> The i.MX6 CPU frequency driver sometimes fails to register at boot time
> due to nvmem_cell_read_u32() sporadically returning -ENOENT.
> 
> This happens because there is a window where __nvmem_device_get() in
> of_nvmem_cell_get() is able to return the nvmem device, but as cells
> have been setup, nvmem_find_cell_entry_by_node() returns NULL.
> 
> The occurs because the nvmem core registration code violates one of the
> fundamental principles of kernel programming: do not publish data
> structures before their setup is complete.
> 
> Fix this by making nvmem core code conform with this principle.
> 
> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> v2: add fixes tag
> 
>  drivers/nvmem/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 321d7d63e068..6b89fb6fa582 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -835,22 +835,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->dev.groups = nvmem_dev_groups;
>  #endif
>  
> -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> -
> -	rval = device_register(&nvmem->dev);
> -	if (rval)
> -		goto err_put_device;
> -
>  	if (nvmem->nkeepout) {
>  		rval = nvmem_validate_keepouts(nvmem);
>  		if (rval)
> -			goto err_device_del;
> +			goto err_put_device;

You can't call put_device() on a device that hasn't gone through
device_initialize() yet.

>  	}
>  
>  	if (config->compat) {
>  		rval = nvmem_sysfs_setup_compat(nvmem, config);
>  		if (rval)
> -			goto err_device_del;
> +			goto err_put_device;

Ditto.

>  	}
>  
>  	if (config->cells) {
> @@ -867,6 +861,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	if (rval)
>  		goto err_remove_cells;
>  
> +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> +
> +	rval = device_register(&nvmem->dev);
> +	if (rval)
> +		goto err_remove_cells;
> +
>  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>  
>  	return nvmem;
> @@ -876,8 +876,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  err_teardown_compat:
>  	if (config->compat)
>  		nvmem_sysfs_remove_compat(nvmem, config);
> -err_device_del:
> -	device_del(&nvmem->dev);
>  err_put_device:
>  	put_device(&nvmem->dev);
>  


- Hector
