Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A75F0B59
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiI3MJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiI3MJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1416DDDA;
        Fri, 30 Sep 2022 05:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE25162310;
        Fri, 30 Sep 2022 12:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C0C433D6;
        Fri, 30 Sep 2022 12:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664539769;
        bh=MWCtz2Oh25qxLNuhpkJKCw4gaTdEGebqCTQSJg72jCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=br5SPY0F2q7MBD4j0OrfokYZfjLETE4GiFjBlN5gFBjrk6jwz4ffY78fW4m3KaY2d
         LHuyvpQNHtefH/T3Mxxb0FiBHtLS2lPvaTh+o4oV49GjaexQZ82LZEC0yop6kY7e7o
         ENNRO3lnKpl/G5snSIeDUd2Wr46bCzzTj3N1Kpqo=
Date:   Fri, 30 Sep 2022 14:09:27 +0200
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
Subject: Re: [PATCH v4 06/14] virt: gunyah: Add sysfs nodes
Message-ID: <Yzbcd0r768pRgRMr@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-7-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-7-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:25PM -0700, Elliot Berman wrote:
> Add /sys/hypervisor support when detecting that Linux is running in a
> Gunyah environment. Export the version of Gunyah which is reported via
> the hyp_identify hypercall.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../ABI/testing/sysfs-hypervisor-gunyah       | 15 ++++
>  MAINTAINERS                                   |  1 +
>  drivers/virt/Makefile                         |  1 +
>  drivers/virt/gunyah/Makefile                  |  2 +
>  drivers/virt/gunyah/sysfs.c                   | 71 +++++++++++++++++++
>  5 files changed, 90 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
>  create mode 100644 drivers/virt/gunyah/Makefile
>  create mode 100644 drivers/virt/gunyah/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> new file mode 100644
> index 000000000000..7d74e74e9edd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> @@ -0,0 +1,15 @@
> +What:		/sys/hypervisor/gunyah/api
> +Date:		October 2022
> +KernelVersion:	6.1
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:	If running under Gunyah:
> +		The Gunyah API version.

What does this version mean?  What format is it in?

> +
> +What:		/sys/hypervisor/gunyah/variant
> +Date:		October 2022
> +KernelVersion:	6.1
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:	If running under Gunyah:
> +		Reports the build variant of Gunyah:
> +		The open source build of Gunyah will report "81".
> +		The Qualcomm build of Gunyah will report "72".

So there are only 2 versions variants?  What happens when you get a
third?  And why the odd numbers?

What will userspace do with this information and what tool will parse
it?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index feafac12db35..a26e67ef36b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8885,6 +8885,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>  M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
> +F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah
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
> index 000000000000..e15f16c17142
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1,2 @@
> +gunyah-y += sysfs.o
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
> new file mode 100644
> index 000000000000..ec11510cbece
> --- /dev/null
> +++ b/drivers/virt/gunyah/sysfs.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gunyah: " fmt
> +
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <asm-generic/gunyah.h>
> +
> +static struct gh_hypercall_hyp_identify_resp gunyah_api;
> +
> +static ssize_t api_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
> +{
> +	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_API_VERSION(gunyah_api.api_info));
> +}
> +static struct kobj_attribute api_attr = __ATTR_RO(api);
> +
> +static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
> +{
> +	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_VARIANT(gunyah_api.api_info));
> +}
> +static struct kobj_attribute variant_attr = __ATTR_RO(variant);
> +
> +static struct attribute *gunyah_attrs[] = {
> +	&api_attr.attr,
> +	&variant_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group gunyah_group = {
> +	.name = "gunyah",
> +	.attrs = gunyah_attrs,
> +};
> +
> +static int __init gunyah_init(void)
> +{
> +	u32 uid[4];
> +
> +	gh_hypercall_get_uid(uid);

No error checking?

> +
> +	if (!(gh_uid_matches(GUNYAH, uid) || gh_uid_matches(QC_HYP, uid)))
> +		return 0;
> +
> +	gh_hypercall_hyp_identify(&gunyah_api);
> +
> +	if (GH_API_INFO_API_VERSION(gunyah_api.api_info) != 1) {
> +		pr_warn("Unrecognized gunyah version: %llu. Currently supported: 1\n",
> +			GH_API_INFO_API_VERSION(gunyah_api.api_info));

Shouldn't the "1" be defined somewhere?

> +		return 0;
> +	}
> +
> +	pr_notice("Running under Gunyah hypervisor %llx/v%lld\n",
> +		  GH_API_INFO_VARIANT(gunyah_api.api_info),
> +		  GH_API_INFO_API_VERSION(gunyah_api.api_info));

When kernel code is working properly, it is quiet.  What is this going
to be used for?

thanks,

greg k-h
