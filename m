Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3D6C6EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjCWRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCWRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:24:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184F2823C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:24:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t10so863436edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679592245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWO1/jUFd4RJnO28yjlA8l9Qr4+du9+9sjmz8G/d7Jk=;
        b=PLFpiDTtN+CiMt1ZibhiyF6XIqR6IGRFiHd3YLiatnXSMgCkKNPaIsTxDMAkxffeMN
         h0Dlp1RxefC3IPQoUuOT6VsI5KVLAQhw8hBaO07GqAonBTZ8m2d2gEa7vTE4bk/QDnlI
         iRTu0f1/pgNGSnh7TOFkMbEXJuf8VquDWuuiq0H4MXY6HQkF9S/6yfms/ZWdUU3hF2JK
         ky5zwDZnoCBTSRRw1+E2CsbNrmDt9IDcB9ghag/t4XE9CLUvlcGtJN4vsAyC81Yh5cRv
         yOVJAF5xc/b3SQfvmoU0jgyqWqQUmZO7hqddaCHE/ZXLMLDYaJi04ceD+jS2fFHY1lar
         g1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWO1/jUFd4RJnO28yjlA8l9Qr4+du9+9sjmz8G/d7Jk=;
        b=nar2lsjF1hNsnBIxw1aljnJD35vD40q4RzaAFjtVEE1fT62Ey5n8PhIwC/MlkSo9mD
         DKNiPYybr/25d3aP5Uk70qFhJB3Z2gK7kWr2d6C+sUoOynfqumyKfSRJfs7S5lqCVPwZ
         T8eaTh+AquJen0+1NR/VHW8NsW3HBopzNoFhEJFLqND5193of5y6tiASnPwXidjGczaZ
         Cffmiqzn8HtpO0nfcEY9h2YGi1iUra+U6GFHXJTDYICaoEyg7sW7LE9L4o4aCiGr3z0O
         g7qL5e2+hd6UTzsVttO7SobKiR7y4oLQO2QnIak7HtGxdMTahEtzeZ21rs1YXZeKyxZa
         +Jbw==
X-Gm-Message-State: AO0yUKXSrcsfA8vc+Z80EX/Pna7yo6XpzvBqMmPwBhzn1rZPhQXjgs+Q
        dx+nG+8bjYmWGie+ociI+7YV/Q==
X-Google-Smtp-Source: AK7set81fv7ZRLP4oUooBclsYYTpRvTEdvrCtqeHBgokhJImFboslLnFA2d4moFS9zFAO5kO0HRfDA==
X-Received: by 2002:a17:906:9154:b0:930:bcee:eed with SMTP id y20-20020a170906915400b00930bcee0eedmr11196273ejw.9.1679592245178;
        Thu, 23 Mar 2023 10:24:05 -0700 (PDT)
Received: from localhost (cst-prg-89-179.cust.vodafone.cz. [46.135.89.179])
        by smtp.gmail.com with ESMTPSA id ml23-20020a170906cc1700b0092ce8344078sm8956676ejb.33.2023.03.23.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:24:04 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:24:03 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
Message-ID: <20230323172403.nfrtgm5vea4qvinu@orel>
References: <20230323123924.3032174-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323123924.3032174-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 08:39:24PM +0800, Song Shuai wrote:
> RISC-V now manages CPU topology using arch_topology which provides
> CPU capacity and frequency related interfaces to access the cpu/freq
> invariant in possible heterogeneous or DVFS-enabled platforms.
> 
> Here adds topology.h file to export the arch_topology interfaces for
> replacing the scheduler's constant-based cpu/freq invariant accounting.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
> changes from V1:
>   - fix the leading underscore and tidy the patch up 
> ---
>  arch/riscv/include/asm/topology.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 arch/riscv/include/asm/topology.h
> 
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> new file mode 100644
> index 000000000000..727e8d163a3b
> --- /dev/null
> +++ b/arch/riscv/include/asm/topology.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_TOPOLOGY_H
> +#define _ASM_RISCV_TOPOLOGY_H
> +
> +#include <linux/arch_topology.h>
> +
> +/* Replace task scheduler's default frequency-invariant accounting */
> +#define arch_scale_freq_tick	topology_scale_freq_tick
> +#define arch_set_freq_scale	topology_set_freq_scale

I was thinking all the right hand side would line up, which means
the above two need additional tabs and so does topology_get_cpu_scale.

> +#define arch_scale_freq_capacity	topology_get_freq_scale
> +#define arch_scale_freq_invariant	topology_scale_freq_invariant
> +
> +/* Replace task scheduler's default cpu-invariant accounting */
> +#define arch_scale_cpu_capacity	topology_get_cpu_scale
> +
> +/* Enable topology flag updates */
> +#define arch_update_cpu_topology	topology_update_cpu_topology
> +
> +#include <asm-generic/topology.h>

I'd also prefer a blank line here.

> +#endif /* _ASM_RISCV_TOPOLOGY_H */
> -- 
> 2.20.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
