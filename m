Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D115E67BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIVP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiIVP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:56:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAEDE5FA7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:56:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id c6so7100108qvn.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=5FPZpJ0fRyMuZJ1L9OxeKsqck40ptxGwxidl+b3tGX4=;
        b=Da57zXRlppFxRnO7kfk3kFe5O1RdWTzETBZtJPzoi5CO89N5ZX4zOxOuOSzOJaSvWf
         2bX8mVhK8d9cyPXD9df+GwY/0pb0XsF2PU1qbqALZNSortKqO64KlDnvErbKNGFFAwxW
         Y42eJt11BkHq0i7CaJXq4mXmziZF5qNZf0ZbjlAlNL0TnjQFntQf2bAHF1xAtjHA0aWP
         EdzH41uXrjL5Yosf4bRoPU/3+RJywmUJ577i7cmqriW7i1URh5/5vanizkWmGgadifv2
         +unsoEeyVp7Ya6HLS7SAulZ1P3XkL2bZwLdVMU5Nn5NAg/Zv3RQaR3TAIZ20+zEtm8PD
         HXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=5FPZpJ0fRyMuZJ1L9OxeKsqck40ptxGwxidl+b3tGX4=;
        b=BeqerXVwlfpbnjLo3BbTp4wBXSdHZxDCT/OVV9kd2vtJkISdZpWelooeP094BsZXud
         olA3XJFyJB/mgAfsx6QY/zYXkgSFbWlUo62UAm5IIFXRcFNfv9C4x1wkPvPVw9WvOh88
         9lwPdr9lhIIP5l4yY1VEb/qDd9W+J1XaveV92E886dDbrF7nv4u20/HIxOFYm7b3plXZ
         QApI60B4tDJMAOEJnnHCycJWUr+91gP5qypzWyenIkMOYwNizBX7onG5+0JmeWU6ZeOj
         G7CFZRUfJJzhDkGN9ZM7RVzRSSFzMOIZXEyu2Bz9x4+6TemeZta68qLYDEfz5eorqTOQ
         Cvhg==
X-Gm-Message-State: ACrzQf2lOhRDC3vt5JAN/Al9IMRni3li8IBIaJFTJbxvBU7++Jlqnog6
        R/m3d0Djxgl0otlEsyUQAM+PtX3bzA==
X-Google-Smtp-Source: AMsMyM6lo+S2hjJFpo8MoFJAXaVpld/ZiBVdMkyLYWk6HxyY4pOCBVXY1xBkeJiUULuRjVlHl1Vj2Q==
X-Received: by 2002:a05:6214:3011:b0:4ad:82d6:d579 with SMTP id ke17-20020a056214301100b004ad82d6d579mr2326059qvb.37.1663862185767;
        Thu, 22 Sep 2022 08:56:25 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id dt10-20020a05620a478a00b006ce3cffa2c8sm4350348qkb.43.2022.09.22.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:56:25 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5d3f:d09:85d2:d6e])
        by serve.minyard.net (Postfix) with ESMTPSA id 084AC1800BD;
        Thu, 22 Sep 2022 15:56:24 +0000 (UTC)
Date:   Thu, 22 Sep 2022 10:56:22 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Add __init/__exit annotations to module init/exit
 funcs
Message-ID: <YyyFphRSkO4roYlk@minyard.net>
Reply-To: minyard@acm.org
References: <20220922111924.36044-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922111924.36044-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:19:24PM +0800, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.

Applied, thanks.

-corey

> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c         | 4 ++--
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 4 ++--
>  drivers/char/ipmi/kcs_bmc_serio.c     | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 13da021e7c6b..e1072809fe31 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -2098,7 +2098,7 @@ static struct platform_driver ipmi_driver = {
>  	.id_table       = ssif_plat_ids
>  };
>  
> -static int init_ipmi_ssif(void)
> +static int __init init_ipmi_ssif(void)
>  {
>  	int i;
>  	int rv;
> @@ -2140,7 +2140,7 @@ static int init_ipmi_ssif(void)
>  }
>  module_init(init_ipmi_ssif);
>  
> -static void cleanup_ipmi_ssif(void)
> +static void __exit cleanup_ipmi_ssif(void)
>  {
>  	if (!initialized)
>  		return;
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index 486834a962c3..cf670e891966 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -548,7 +548,7 @@ static struct kcs_bmc_driver kcs_bmc_ipmi_driver = {
>  	.ops = &kcs_bmc_ipmi_driver_ops,
>  };
>  
> -static int kcs_bmc_ipmi_init(void)
> +static int __init kcs_bmc_ipmi_init(void)
>  {
>  	kcs_bmc_register_driver(&kcs_bmc_ipmi_driver);
>  
> @@ -556,7 +556,7 @@ static int kcs_bmc_ipmi_init(void)
>  }
>  module_init(kcs_bmc_ipmi_init);
>  
> -static void kcs_bmc_ipmi_exit(void)
> +static void __exit kcs_bmc_ipmi_exit(void)
>  {
>  	kcs_bmc_unregister_driver(&kcs_bmc_ipmi_driver);
>  }
> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> index 7e2067628a6c..1793358be782 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> @@ -140,7 +140,7 @@ static struct kcs_bmc_driver kcs_bmc_serio_driver = {
>  	.ops = &kcs_bmc_serio_driver_ops,
>  };
>  
> -static int kcs_bmc_serio_init(void)
> +static int __init kcs_bmc_serio_init(void)
>  {
>  	kcs_bmc_register_driver(&kcs_bmc_serio_driver);
>  
> @@ -148,7 +148,7 @@ static int kcs_bmc_serio_init(void)
>  }
>  module_init(kcs_bmc_serio_init);
>  
> -static void kcs_bmc_serio_exit(void)
> +static void __exit kcs_bmc_serio_exit(void)
>  {
>  	kcs_bmc_unregister_driver(&kcs_bmc_serio_driver);
>  }
> -- 
> 2.17.1
> 
