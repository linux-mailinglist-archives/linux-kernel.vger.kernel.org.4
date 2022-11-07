Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DC61FC93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKGSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiKGSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638B22BFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:58:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10147725wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/UsOLSVJeRrP3hKZ9XAB4D/JQx5F5JGX1FwiQPvVuU=;
        b=cN2PpU8w5R2dGTCKi5Q3mrHU2O2eEm8NRLA4oJn3gXKgwYvWUGzX8ieo/RXw6RfGik
         dnpAhH0P9gzQTOtEFsMuej1JSGcRVQT2+jz9EQxY7IW1NmU2uGRHyGwOnWHtqiehjA82
         Qe14hhcb7Ob/3syPlHGOy9eSFnY0s5lUJ01BQXgog2TBMZJUqSACQtWVmIiq2K5sfeqx
         0CN5GAmfwLAp8ZzsHzVmhCM1cPGAUsRs5qh1aGWg+UIPv2TfXtFF7pe8N1Ar7p7qFMHJ
         0gqYD9GtLugFGiVJRyelKODICgOo6FrDlzU/SS6CCTinBOMn1PlHse8jAoL0wga5t3tC
         nOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/UsOLSVJeRrP3hKZ9XAB4D/JQx5F5JGX1FwiQPvVuU=;
        b=YrRWFWr6TDYVHNKxXZkfByPjCnmb4qhlgBzvR9aUejeuEHmNM2inZ3vkO6554pY5BT
         PilOV56VjJl5sdQW0h6xzOzxAHPce9q3t+Y3CRfM4KzM9HhqRXSFsDsQCSzjphcWeOgi
         M0+XVj+1VAuWCfMRDau2Vh24T+P+apEHtNt2CFVCgdWsNvNzUf3xV9ZFYeSdhmUymGoF
         YiN2NrATH+J48yHBWymRtUD5A5+V2sjwSHSbsuG1wS9d2tnQmigCY5meZU+rPnWu4dER
         63ZjwqEVAWG6sWdNcv6TI6yEXZmFxbmGvQAzZ3MyajTB2GJzreNUj3+j8JEzxfoltWip
         NleA==
X-Gm-Message-State: ANoB5pm2VSte4lGmn7LDLjTJOyzp6H+JU2FDgNt4WIzgEYx9m+5oTI9T
        r6FNxf0AI5tpkEN3AE6AXGs0Og==
X-Google-Smtp-Source: AA0mqf45hAf2eMGXeCEaPsHNxIabuTwUDaLIbBELqZs+Mkr1Si2gd7+wy0i/EyOsvqAwI8wbbgmJXw==
X-Received: by 2002:a05:600c:1695:b0:3cf:a9b7:81e7 with SMTP id k21-20020a05600c169500b003cfa9b781e7mr5268454wmn.116.1667843883081;
        Mon, 07 Nov 2022 09:58:03 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d6611000000b002383edcde09sm7994811wru.59.2022.11.07.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:58:02 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux@armlinux.org.uk,
        yezengruan@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        maz@kernel.org, steven.price@arm.com, mark.rutland@arm.com,
        bagasdotme@gmail.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com
Subject: Re: [v2 2/6] KVM: arm64: Add SMCCC paravirtualised lock calls
References: <20221104062105.4119003-1-usama.arif@bytedance.com>
        <20221104062105.4119003-3-usama.arif@bytedance.com>
Date:   Mon, 07 Nov 2022 17:58:01 +0000
Message-ID: <87cz9y3avq.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usama Arif <usama.arif@bytedance.com> writes:

> Add a new SMCCC compatible hypercalls for PV lock features:
>   ARM_SMCCC_KVM_FUNC_PV_LOCK:   0xC6000002
>
> Also add the header file which defines the ABI for the paravirtualized
> lock features we're about to add.
>
> Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  arch/arm64/include/asm/pvlock-abi.h | 17 +++++++++++++++++
>  include/linux/arm-smccc.h           |  8 ++++++++
>  tools/include/linux/arm-smccc.h     |  8 ++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 arch/arm64/include/asm/pvlock-abi.h
>
> diff --git a/arch/arm64/include/asm/pvlock-abi.h b/arch/arm64/include/asm/pvlock-abi.h
> new file mode 100644
> index 000000000000..3f4574071679
> --- /dev/null
> +++ b/arch/arm64/include/asm/pvlock-abi.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2019 Huawei Technologies Co., Ltd
> + * Author: Zengruan Ye <yezengruan@huawei.com>
> + *         Usama Arif <usama.arif@bytedance.com>
> + */
> +
> +#ifndef __ASM_PVLOCK_ABI_H
> +#define __ASM_PVLOCK_ABI_H
> +
> +struct pvlock_vcpu_state {
> +	__le64 preempted;
> +	/* Structure must be 64 byte aligned, pad to that size */
> +	u8 padding[56];
> +} __packed;

For structure alignment, I'd have expected to see the use of "aligned"
attribute. Is there any benefit in using padding to achieve alignment?

[...]
