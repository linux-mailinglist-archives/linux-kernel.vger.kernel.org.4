Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227A65F0B90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiI3MTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiI3MTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:19:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA617B509;
        Fri, 30 Sep 2022 05:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95D6AB82795;
        Fri, 30 Sep 2022 12:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9D8C433C1;
        Fri, 30 Sep 2022 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664540354;
        bh=nVR4dEDGuhHyPbGE1LbJ0tXE+TXxgnaQVIcG0EZELq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWQRzdEc5zZ6iirLoyIKxTSZZvRv0ziAVOPNDkX3YIJME1oW/kvMTpIe8Rez2giEg
         Z9D7LUrsDVmrpDGb9rHFtSCZO3e+wH+FmJcbeWktV1YKoclUx/VSt+88y+ZnJG59n4
         XgMbE/gh34wl6yRYMdOmc3RqGvudZIEi6QVA1680=
Date:   Fri, 30 Sep 2022 14:19:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/14] gunyah: rsc_mgr: Add auxiliary devices for
 console
Message-ID: <Yzbev2mZodsZhFY3@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-14-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-14-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:32PM -0700, Elliot Berman wrote:
> Gunyah resource manager exposes a concrete functionalities which
> complicate a single resource manager driver.

I am sorry, but I do not understand this sentance.  What is so
complicated about individual devices being created?  Where are they
created?  What bus?

Use auxiliary bus
> to help split high level functions for the resource manager and keep the
> primary resource manager driver focused on the RPC with RM itself.
> Delegate Resource Manager's console functionality to the auxiliary bus.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Kconfig   |  1 +
>  drivers/virt/gunyah/rsc_mgr.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 78deed3c4562..610c8586005b 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -17,6 +17,7 @@ config GUNYAH_RESORUCE_MANAGER
>  	tristate "Gunyah Resource Manager"
>  	select MAILBOX
>  	select GUNYAH_MESSAGE_QUEUES
> +	select AUXILIARY_BUS
>  	default y
>  	help
>  	  The resource manager (RM) is a privileged application VM supporting
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 7f7e89a6436b..435fe0149915 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -16,6 +16,7 @@
>  #include <linux/notifier.h>
>  #include <linux/workqueue.h>
>  #include <linux/completion.h>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/gunyah_rsc_mgr.h>
>  #include <linux/platform_device.h>
>  
> @@ -98,6 +99,8 @@ struct gh_rsc_mgr {
>  	struct mutex send_lock;
>  
>  	struct work_struct recv_work;
> +
> +	struct auxiliary_device console_adev;
>  };
>  
>  static struct gh_rsc_mgr *__rsc_mgr;
> @@ -573,13 +576,31 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>  
>  	__rsc_mgr = rsc_mgr;
>  
> +	rsc_mgr->console_adev.dev.parent = &pdev->dev;
> +	rsc_mgr->console_adev.name = "console";
> +	ret = auxiliary_device_init(&rsc_mgr->console_adev);
> +	if (ret)
> +		goto err_msgq;
> +	ret = auxiliary_device_add(&rsc_mgr->console_adev);
> +	if (ret)
> +		goto err_console_adev_uninit;
> +
>  	return 0;
> +
> +err_console_adev_uninit:
> +	auxiliary_device_uninit(&rsc_mgr->console_adev);
> +err_msgq:
> +	gunyah_msgq_remove(&rsc_mgr->msgq);
> +	return ret;
>  }

Why can't you just have individual platform devices for the individual
devices your hypervisor exposes?

You control the platform devices, why force them to be shared like this?

thanks,

greg k-h
