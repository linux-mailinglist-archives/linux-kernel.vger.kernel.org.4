Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454D0680A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjA3KBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjA3KB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:01:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80D2716;
        Mon, 30 Jan 2023 02:01:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B64960F19;
        Mon, 30 Jan 2023 10:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98F4C433D2;
        Mon, 30 Jan 2023 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675072884;
        bh=o4dqwsRXEnWX6zVfh/4HE2Z0WTuD083NeZjgbIqzrOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsxUv9ALlxr1+btx1VMsLmDXaeHRixyoG6l4HT4SP89eEXSaquKGXjt69Wurw+0Fd
         SokJY8XgP5jjIF1nU0Rxg3zRVLZMM3S4OcUt2RbGsSjse81kG2m/Pi/xEcNsJWWpl0
         TuwaUgufjL348Sq1b8R3tU60akMoA03yL6Y7iags=
Date:   Mon, 30 Jan 2023 11:01:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 04/27] virt: gunyah: Add hypercalls to identify Gunyah
Message-ID: <Y9eVcHM9nZZ/4ZSh@kroah.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-5-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-5-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 02:46:03PM -0800, Elliot Berman wrote:
> Add hypercalls to identify when Linux is running a virtual machine under
> Gunyah.
> 
> There are two calls to help identify Gunyah:
> 
> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>    hypervisor.
> 2. gh_hypercall_hyp_identify() returns build information and a set of
>    feature flags that are supported by Gunyah.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS                          |  2 +
>  arch/arm64/Kbuild                    |  1 +
>  arch/arm64/gunyah/Makefile           |  3 ++
>  arch/arm64/gunyah/gunyah_hypercall.c | 75 ++++++++++++++++++++++++++++
>  drivers/virt/Kconfig                 |  2 +
>  drivers/virt/gunyah/Kconfig          | 14 ++++++
>  include/linux/gunyah.h               | 33 ++++++++++++
>  7 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/gunyah/Makefile
>  create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>  create mode 100644 drivers/virt/gunyah/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1e07e39b2f5..fe19e71efc6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9048,6 +9048,8 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
> +F:	arch/arm64/gunyah/
> +F:	drivers/virt/gunyah/
>  F:	include/linux/gunyah.h
>  
>  HABANALABS PCI DRIVER
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..e4847ba0e3c9 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -3,6 +3,7 @@ obj-y			+= kernel/ mm/ net/
>  obj-$(CONFIG_KVM)	+= kvm/
>  obj-$(CONFIG_XEN)	+= xen/
>  obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
> +obj-$(CONFIG_GUNYAH)	+= gunyah/
>  obj-$(CONFIG_CRYPTO)	+= crypto/
>  
>  # for cleaning
> diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
> new file mode 100644
> index 000000000000..84f1e38cafb1
> --- /dev/null
> +++ b/arch/arm64/gunyah/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> new file mode 100644
> index 000000000000..ffed4b71641f
> --- /dev/null
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <linux/gunyah.h>
> +
> +static const uint32_t gunyah_known_uuids[][4] = {

uint32_t is not a kernel type, please use sane ones, like u32.

> +	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
> +	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */

And why not use the kernel uuid type here?  Why create your own?

> +};
> +
> +#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
> +
> +/**
> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
> + * @uid: An array of 4 u32's (u32 uid[4];)
> + *
> + * Caller should compare the resulting UID to a list of known Gunyah UIDs to
> + * confirm that Linux is running as a guest of Gunyah.
> + */
> +void gh_hypercall_get_uid(u32 uid[4])
> +{
> +	struct arm_smccc_res res;
> +	u32 uid[4];

How does this work when you have a local variable the same name as the
parameter to the function?  What shadows what and how?  The compiler
didn't complain about this?

> +	int i;
> +
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +
> +	uid[0] = lower_32_bits(res.a0);
> +	uid[1] = lower_32_bits(res.a1);
> +	uid[2] = lower_32_bits(res.a2);
> +	uid[3] = lower_32_bits(res.a3);
> +
> +	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
> +		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
> +			break;
> +
> +	return i != ARRAY_SIZE(gunyah_known_uuids);

How can a function that returns void actually return anything?

This obviously was never compiled.  I'm stopping here in my review.

greg k-h
