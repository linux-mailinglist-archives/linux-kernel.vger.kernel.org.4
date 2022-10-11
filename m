Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5505FAC52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJKGMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKGMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642D46D9F;
        Mon, 10 Oct 2022 23:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E1A5610F4;
        Tue, 11 Oct 2022 06:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5229CC433C1;
        Tue, 11 Oct 2022 06:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665468758;
        bh=Ae6IjMS4Ec5euaDJykUWdGTe4JqhT1q+WOE58vseVdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDuLkvVPKI/uwLy5mWPQ6svVSYpIIKSlkIg2UhbmwLouim6Ig8h4KeDidCu1ObR9T
         LEwYCVOKC+Rvi6MkN6Q2uDpSnRc0XoMEatLj2BgYIOGRr6vNgjkWEVy2hXPeOzH9Z3
         EmCXTXZhbl218Pmb+BkNgQJdSK9X2gjAtTwXDgMw=
Date:   Tue, 11 Oct 2022 08:13:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
Subject: Re: [PATCH v5 06/13] virt: gunyah: Identify hypervisor version
Message-ID: <Y0UJgcc0+AEbHTIM@kroah.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-7-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011000840.289033-7-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:08:33PM -0700, Elliot Berman wrote:
> Export the version of Gunyah which is reported via the hyp_identify
> hypercall. Increments of the major API version indicate possibly
> backwards incompatible changes. Export the hypervisor identity so that
> Gunyah drivers can act according to the major API version.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS                  |  1 +
>  drivers/virt/Makefile        |  1 +
>  drivers/virt/gunyah/Makefile |  2 ++
>  drivers/virt/gunyah/gunyah.c | 41 ++++++++++++++++++++++++++++++++++++
>  include/asm-generic/gunyah.h |  3 +++
>  5 files changed, 48 insertions(+)
>  create mode 100644 drivers/virt/gunyah/Makefile
>  create mode 100644 drivers/virt/gunyah/gunyah.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ed2bc98c3818..c5458aeec023 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8884,6 +8884,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>  M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
> +F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah

That file is not in this patch :(

>  F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
>  F:	arch/arm64/gunyah/
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 093674e05c40..10b87f934730 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
>  obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>  obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
> +obj-$(CONFIG_GUNYAH)		+= gunyah/
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> new file mode 100644
> index 000000000000..dc081e2dc02b
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1,2 @@
> +gunyah-y += gunyah.o
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
> new file mode 100644
> index 000000000000..2893a56f3dfc
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gunyah: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <asm-generic/gunyah.h>
> +
> +struct gh_hypercall_hyp_identify_resp gunyah_api;
> +EXPORT_SYMBOL(gunyah_api);

EXPORT_SYMBOL_GPL()?  I have to ask.

But why is it exported at all?  No one is using it in this patch.

> +
> +static int __init gunyah_init(void)
> +{
> +	u32 uid[4];
> +
> +	gh_hypercall_get_uid(uid);
> +
> +	if (!(gh_uid_matches(GUNYAH, uid) || gh_uid_matches(QC_HYP, uid)))
> +		return 0;

Why return success if this is not true?  Shouldn't you return an error
and fail to load?

> +
> +	gh_hypercall_hyp_identify(&gunyah_api);
> +
> +	pr_info("Running under Gunyah hypervisor %llx/v%lld\n",
> +		  GH_API_INFO_VARIANT(gunyah_api.api_info),
> +		  GH_API_INFO_API_VERSION(gunyah_api.api_info));
> +
> +	return 0;
> +}
> +arch_initcall(gunyah_init);
> +
> +static void __exit gunyah_exit(void)
> +{
> +}
> +module_exit(gunyah_exit);

Why do you need a module_exit() call?

> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");

What will cause this module to be properly automatically loaded?  I do
not see that happening here at all.

> diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
> index 86eb59e203ef..8f9d4c649ba8 100644
> --- a/include/asm-generic/gunyah.h
> +++ b/include/asm-generic/gunyah.h
> @@ -85,6 +85,8 @@ static inline int gh_remap_error(int gh_error)
>  	((uid)[0] == prefix ## _UID0 && (uid)[1] == prefix ## _UID1 && \
>  	 (uid)[2] == prefix ## _UID2 && (uid)[3] == prefix ## _UID3)
>  
> +#define GUNYAH_API_V1			1

You do not use this define anywhere in this patch.


> +
>  #define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)
>  #define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
>  #define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
> @@ -103,6 +105,7 @@ struct gh_hypercall_hyp_identify_resp {
>  	u64 api_info;
>  	u64 flags[3];
>  };
> +extern struct gh_hypercall_hyp_identify_resp gunyah_api;

Again, not used.

thanks,

greg k-h
