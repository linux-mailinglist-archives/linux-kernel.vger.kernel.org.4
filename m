Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A831A680A43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjA3J7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjA3J7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:59:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71272FCD5;
        Mon, 30 Jan 2023 01:58:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F161B80EC1;
        Mon, 30 Jan 2023 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B3C433D2;
        Mon, 30 Jan 2023 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675072703;
        bh=SoUfX9t3uCDqd1KJttPmVP1c1Ha1TQ8GZrulQxL7hxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEm+cw30u676F7aZTqiojYzEAkm9l6+AeVd6HYEv9qylFDXixh3cqrLwm7ZG6qGQg
         TJdddpypqc8wJTRQDnjNru6+DEoxJXKOffILX6KmELj7CokLks8oAOmfuMnSX9nUNi
         /eFUydHeAHuNtzJs3le2XqxpoMwDdJaymmNNPD8g=
Date:   Mon, 30 Jan 2023 10:58:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 03/27] gunyah: Common types and error codes for Gunyah
 hypercalls
Message-ID: <Y9eUvP0YQlLtAPpk@kroah.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 02:46:02PM -0800, Elliot Berman wrote:
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS            |  1 +
>  include/linux/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 include/linux/gunyah.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9205cb9e988..f1e07e39b2f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9048,6 +9048,7 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
> +F:	include/linux/gunyah.h
>  
>  HABANALABS PCI DRIVER
>  M:	Oded Gabbay <ogabbay@kernel.org>
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> new file mode 100644
> index 000000000000..985c6086348e
> --- /dev/null
> +++ b/include/linux/gunyah.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _LINUX_GUNYAH_H
> +#define _LINUX_GUNYAH_H
> +
> +#include <linux/errno.h>
> +#include <linux/limits.h>
> +
> +/* Common Gunyah macros */

Macros?

> +#define GH_CAPID_INVAL	U64_MAX
> +#define GH_VMID_ROOT_VM	0xff

These are all simple defines :)

> +
> +#define GH_ERROR_OK			0
> +
> +#define GH_ERROR_UNIMPLEMENTED		-1
> +#define GH_ERROR_RETRY			-2

All of these values, they come from the hypervisor?

And then you:

> +static inline int gh_remap_error(int gh_error)
> +{
> +	switch (gh_error) {
> +	case GH_ERROR_OK:
> +		return 0;
> +	case GH_ERROR_NOMEM:
> +		return -ENOMEM;
> +	case GH_ERROR_DENIED:
> +	case GH_ERROR_CSPACE_CAP_NULL:
> +	case GH_ERROR_CSPACE_CAP_REVOKED:
> +	case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
> +	case GH_ERROR_CSPACE_INSUF_RIGHTS:
> +	case GH_ERROR_CSPACE_FULL:
> +		return -EACCES;
> +	case GH_ERROR_BUSY:
> +	case GH_ERROR_IDLE:
> +		return -EBUSY;
> +	case GH_ERROR_IRQ_BOUND:
> +	case GH_ERROR_IRQ_UNBOUND:
> +	case GH_ERROR_MSGQUEUE_FULL:
> +	case GH_ERROR_MSGQUEUE_EMPTY:
> +		return -EPERM;
> +	default:
> +		return -EINVAL;
> +	}
> +}

Convert it to a Linux-kernel related value?

If so, please say that in the documentation here (where the value came
from, etc...)

Also, why isn't gh_error an enumerated type so you can have some type
safety and it's obvious when a value comes from the hypervisor what it
should be and should not be.

thanks,

greg k-h
