Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8536D22AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjCaO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjCaO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:28:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A320620
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:28:28 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o12so6564901ilh.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272869; x=1682864869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yd8a2rRt4CgsuNoaw1uAdWSFVR3asYYuQ3SN1GygOPM=;
        b=JsNYMn960aSPeOjPjz/EG2ICt2oP8vT4WEz+2/wEatQXwBBjniH11Ht3oxXIhpNirV
         ZRKxw0w/TxfkEvvhjRaoPWC63JyahCs6YFMLXpovKsgzrTP7jN2kORtiSzOQppqxKddV
         xtAsWGT3QdOm8DVq5gX/7zqeqqhVk6pCAqmOmhCXDIGyxI0e07q2ra+a+KlJdMkRD3Cm
         fgop6HfzMGGedbI8y/mBaY4pe1xX9PdampNdKZm08ymzE/d7w7YogSskKtV20Uhfaqrq
         666vC9iTPeh3i5HP+dgdupI3ZnReqfhlyec9nPFQTN2tgbHizJHoEfKGuPS0K3O1G4Gi
         UH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272869; x=1682864869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yd8a2rRt4CgsuNoaw1uAdWSFVR3asYYuQ3SN1GygOPM=;
        b=Zm8ZYUoft2aNdMHm8duWI0xc8b+NDLau1uOZg5F6ghmVkvTnYH1/SjFbRLVlu0M4Vv
         9HTJo++hvo/hbzQ7DMI1pzstkukTl3uqg8OnHVSYlUC0n0sP+s6uto+7hSNWopsu/KIA
         EZ8Mn7lCiM5PkFvM6xQrfSbXq+nyXaP1CDSjNF/RMbhpRby/EVIlVKKdXthzfWW53fJJ
         p6Mm7WFq9mnOf6XWR708F/4BIO7c/vnX8TArdAhrF4lt85X6evTNdXisI7/ddI3UmPTa
         GH48eyGW/r6HfZjZ8ZzjsNNyBfADfnBeNUpoq8y1LpGACsI0x8sycIWzGNCcdzGkj/PB
         xxjg==
X-Gm-Message-State: AAQBX9dAS9ZnWzm1QHpr0yoWbzog6CBDOTtF26uuxJ2yLH8gnvKqjSKW
        YQkdFa01Y0wec3L0seZ/B1LDXQ==
X-Google-Smtp-Source: AKy350aZNorfWB4V2Ge2QcV6oV839CWjp+/XVjrj5bDLpfaK3tmG1dySfUq5FH5Bx1ItFP14N6t75A==
X-Received: by 2002:a92:c812:0:b0:325:c8ed:6775 with SMTP id v18-20020a92c812000000b00325c8ed6775mr17319062iln.18.1680272868928;
        Fri, 31 Mar 2023 07:27:48 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id x20-20020a927c14000000b003261bc23979sm649417ilc.57.2023.03.31.07.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:27:48 -0700 (PDT)
Message-ID: <88a35ed3-78f9-c8ad-93b0-c7335e39a754@linaro.org>
Date:   Fri, 31 Mar 2023 09:27:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 25/26] virt: gunyah: Add ioeventfd
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-26-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-26-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 7:06 PM, Elliot Berman wrote:
> Allow userspace to attach an ioeventfd to an mmio address within the guest.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Mostly minor suggestions here.	-Alex

> ---
>   Documentation/virt/gunyah/vm-manager.rst |   2 +-
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_ioeventfd.c   | 117 +++++++++++++++++++++++
>   include/uapi/linux/gunyah.h              |  37 +++++++
>   5 files changed, 165 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index a1dd70f0cbf6..cd41a705849f 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -124,7 +124,7 @@ the VM starts.
>   The possible types are documented below:
>   
>   .. kernel-doc:: include/uapi/linux/gunyah.h
> -   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg GH_FN_IRQFD gh_fn_irqfd_arg
> +   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg GH_FN_IRQFD gh_fn_irqfd_arg GH_FN_IOEVENTFD gh_fn_ioeventfd_arg
>   
>   Gunyah VCPU API Descriptions
>   ----------------------------
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 2cde24d429d1..bd8e31184962 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -35,3 +35,12 @@ config GUNYAH_IRQFD
>   	  on Gunyah virtual machine.
>   
>   	  Say Y/M here if unsure and you want to support Gunyah VMMs.
> +
> +config GUNYAH_IOEVENTFD
> +	tristate "Gunyah ioeventfd interface"
> +	depends on GUNYAH
> +	help
> +	  Enable kernel support for creating ioeventfds which can alert userspace
> +	  when a Gunyah virtual machine accesses a memory address.
> +
> +	  Say Y/M here if unsure and you want to support Gunyah VMMs.
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 6cf756bfa3c2..7347b1470491 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>   
>   obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
>   obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
> +obj-$(CONFIG_GUNYAH_IOEVENTFD) += gunyah_ioeventfd.o
> diff --git a/drivers/virt/gunyah/gunyah_ioeventfd.c b/drivers/virt/gunyah/gunyah_ioeventfd.c
> new file mode 100644
> index 000000000000..517f55706ed9
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/eventfd.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_vm_mgr.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +struct gh_ioeventfd {
> +	struct gh_vm_function_instance *f;
> +	struct gh_vm_io_handler io_handler;
> +
> +	struct eventfd_ctx *ctx;
> +};
> +
> +static int gh_write_ioeventfd(struct gh_vm_io_handler *io_dev, u64 addr, u32 len, u64 data)
> +{
> +	struct gh_ioeventfd *iofd = container_of(io_dev, struct gh_ioeventfd, io_handler);
> +

I think it's interesting that this signals an event even if
len is zero.  I'm not saying it's wrong, just interesting...

> +	eventfd_signal(iofd->ctx, 1);
> +	return 0;
> +}
> +
> +static struct gh_vm_io_handler_ops io_ops = {
> +	.write = gh_write_ioeventfd,
> +};
> +
> +static long gh_ioeventfd_bind(struct gh_vm_function_instance *f)
> +{
> +	const struct gh_fn_ioeventfd_arg *args = f->argp;
> +	struct eventfd_ctx *ctx = NULL;

No need to initialize ctx.

> +	struct gh_ioeventfd *iofd;
> +	int ret;
> +
> +	if (f->arg_size != sizeof(*args))
> +		return -EINVAL;
> +
> +	/* must be natural-word sized, or 0 to ignore length */
> +	switch (args->len) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* check for range overflow */
> +	if (args->addr + args->len < args->addr)

I think you could use:
	if (overflows_type(args->addr + args->len, args->addr))

This is a relatively recent addition (and I haven't been using it
myself yet) but it's meant for this purpose.  Consider using it
and its relatives here and anywhere else you're making this kind
of check.

> +		return -EINVAL;
> +
> +	/* ioeventfd with no length can't be combined with DATAMATCH */
> +	if (!args->len && (args->flags & GH_IOEVENTFD_DATAMATCH))
> +		return -EINVAL;
> +

Maybe check for invalid flags before before ensuring
valid flags are used properly?

> +	/* All other flag bits are reserved for future use */
> +	if (args->flags & ~GH_IOEVENTFD_DATAMATCH)
> +		return -EINVAL;
> +
> +	ctx = eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	iofd = kzalloc(sizeof(*iofd), GFP_KERNEL);
> +	if (!iofd) {
> +		ret = -ENOMEM;
> +		goto err_eventfd;
> +	}
> +
> +	f->data = iofd;
> +	iofd->f = f;
> +
> +	iofd->ctx = ctx;
> +
> +	if (args->flags & GH_IOEVENTFD_DATAMATCH) {
> +		iofd->io_handler.datamatch = true;
> +		iofd->io_handler.len = args->len;
> +		iofd->io_handler.data = args->datamatch;

I think you might want to rename one or the other of these
fields (datamatch or data).  I might be wrong; I'll explain
elsewhere what I mean.

> +	}
> +	iofd->io_handler.addr = args->addr;
> +	iofd->io_handler.ops = &io_ops;
> +
> +	ret = gh_vm_add_io_handler(f->ghvm, &iofd->io_handler);
> +	if (ret)
> +		goto err_io_dev_add;
> +
> +	return 0;
> +
> +err_io_dev_add:
> +	kfree(iofd);
> +err_eventfd:
> +	eventfd_ctx_put(ctx);
> +	return ret;
> +}
> +
> +static void gh_ioevent_unbind(struct gh_vm_function_instance *f)
> +{
> +	struct gh_ioeventfd *iofd = f->data;
> +
> +	eventfd_ctx_put(iofd->ctx);

It's not a big deal but I prefer to "undo" everything in the
reverse order that they are originally "done".  I.e., put the
eventfd context after removing the I/O handler.

> +	gh_vm_remove_io_handler(iofd->f->ghvm, &iofd->io_handler);
> +	kfree(iofd);
> +}
> +
> +DECLARE_GH_VM_FUNCTION_INIT(ioeventfd, GH_FN_IOEVENTFD,
> +				gh_ioeventfd_bind, gh_ioevent_unbind);
> +MODULE_DESCRIPTION("Gunyah ioeventfds");

s/ioeventfds/ioeventfd/

I understand why you might want it to be plural, but I think it's
better to just name the abstraction.  (If you take this suggestion,
check elsewhere and be consistent.)

AND/OR...  You might also somehow incorporate the fact that this is a
VM *function* that is represented:  "Gunyah ioeventfd VM function(s)"

> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 5617dadc1c7b..f8482ff4cc55 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -89,6 +89,23 @@ struct gh_vm_dtb_config {
>    */
>   #define GH_FN_IRQFD 		2
>   
> +/**
> + * GH_FN_IOEVENTFD - register ioeventfd to trigger when VM faults on parameter

What does "faults on parameter" mean?

> + *
> + * gh_fn_desc is filled with gh_fn_ioeventfd_arg
> + *
> + * Attaches an ioeventfd to a legal mmio address within the guest. A guest write
> + * in the registered address will signal the provided event instead of triggering
> + * an exit on the GH_VCPU_RUN ioctl.
> + *
> + * If GH_IOEVENTFD_DATAMATCH flag is set, the event will be signaled only if the
> + * written value to the registered address is equal to datamatch in
> + * struct gh_fn_ioeventfd_arg.
> + *
> + * Return: 0
> + */
> +#define GH_FN_IOEVENTFD 	3

If you added another tab before 3, it will align more nicely with the
next definition.  (If you do that, add a tab in the other function
definitions as well.)

> +
>   #define GH_FN_MAX_ARG_SIZE		256
>   
>   /**
> @@ -118,6 +135,26 @@ struct gh_fn_irqfd_arg {
>   
>   #define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
>   
> +/**
> + * struct gh_fn_ioeventfd_arg - Arguments to create an ioeventfd function
> + * @datamatch: data used when GH_IOEVENTFD_DATAMATCH is set
> + * @addr: Address in guest memory
> + * @len: Length of access
> + * @fd: When ioeventfd is matched, this eventfd is written
> + * @flags: If GH_IOEVENTFD_DATAMATCH flag is set, the event will be signaled
> + *         only if the written value to the registered address is equal to
> + *         @datamatch
> + * @padding: padding bytes
> + */
> +struct gh_fn_ioeventfd_arg {
> +	__u64 datamatch;
> +	__u64 addr;        /* legal mmio address */
> +	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
> +	__s32 fd;
> +	__u32 flags;
> +	__u32 padding;
> +};
> +
>   /**
>    * struct gh_fn_desc - Arguments to create a VM function
>    * @type: Type of the function. See GH_FN_* macro for supported types

