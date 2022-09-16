Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C425BB050
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiIPPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIPPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C312F026
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663342604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcDieOXWzwDYad3Or3UKN2ift/v1pBenSYpheluB7r0=;
        b=dZTwYhVKP7/QEbTBOqJu/xJHwl998/L5uE0NVyPcWtR408SOE5wgpo2iClGQ141Df/iPCR
        Vn6Yc3Ce3LvKDAHLYI0XabzMhH3BRSdO4rUk8kzNdXrLSsNURc57dkJfP+Da3Y9O9UAxXZ
        WHaEqckE2R4k5hHbrzQgKNaN6QYdqhI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-D9LIS7urO9a2bRx1RmfhwQ-1; Fri, 16 Sep 2022 11:36:43 -0400
X-MC-Unique: D9LIS7urO9a2bRx1RmfhwQ-1
Received: by mail-pj1-f70.google.com with SMTP id a24-20020a17090a8c1800b0020266349974so3236pjo.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rcDieOXWzwDYad3Or3UKN2ift/v1pBenSYpheluB7r0=;
        b=XKm3C5DOezcXYAwnuuYUfCEQfQ03ILtwHGr8vV0LaN8IHprTn81b5nx7HRX4SrtDjF
         T0VYz05mxlhiI5gdLUw7Zu4IGfF92ui57WeYfl7aYaG0EY57dO3QEyFaSVPgP8hFJqzi
         Gf3gkMupjEUdfM7xqh4XmRCgY7Sy//8pCo4zldeaK2Io1rbmt2hHhzeYbKdJpXVgYDNP
         Mab5qTqIX7XsFHsaN2yJg8MrqTmdj11Edwfc0nlgoqZPU/mnotUAfV2eqZaDV3m2U7Lc
         tw9sSEZ4gSEL2ujkNE8YFZ6LcFOR4pv3/b/17LWIG1O3s6tyoskYEhAkUECBFMric+hN
         /ggw==
X-Gm-Message-State: ACrzQf3RZEn509XulZnzFsUA4uci9/5KZkhdbtbf1t+zL7U/1FRhq7RN
        FNhcp1SBcT5Ucn8Ny9hFDMUqA3/2Ds3zbsk1WtBB+Zw7fI5TyvzqJxCG6vcFGqZ0n7BGONI1KvQ
        3+L5XF3ID/420mot+A7uU0qwL
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr416685plh.142.1663342602567;
        Fri, 16 Sep 2022 08:36:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MxN5GDaKAW0gIQvMUlsiHS3eu5jYGdQYwFNbFfi1lYWJxmztLq24GWXq+Lik+GfMhgVaU3Q==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr416662plh.142.1663342602257;
        Fri, 16 Sep 2022 08:36:42 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p20-20020a63e654000000b00434abd19eeasm13592258pgj.78.2022.09.16.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:36:41 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:36:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <20220916153640.qtb74i63upcncpuw@cantor>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:08:14PM -0300, Rafael Mendonca wrote:
> If the IDA id allocation fails, then the allocated memory for the
> idxd_device struct doesn't get freed before returning NULL, which leads to
> a memleak.
> 
> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

I think there needs to be a kfree(idxd) where it checks rc < 0 after the call to dev_set_name() as well, yes?

Regards,
Jerry

> ---
>  drivers/dma/idxd/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..fdc97519b8fb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	idxd->data = data;
>  	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>  	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
> -	if (idxd->id < 0)
> +	if (idxd->id < 0) {
> +		kfree(idxd);
>  		return NULL;
> +	}
>  
>  	device_initialize(conf_dev);
>  	conf_dev->parent = dev;
> -- 
> 2.34.1
> 

