Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E0626F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKMLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiKMLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:06:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B312AEE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:06:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y14so22005020ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lNkqm5mDHS7GJ3dOEBMgWRtlQ/aBzzuCqiGbGOTN6Q=;
        b=WPijW6+w6bFv/6BfRE0a83Vyo18qlPKeHQ+gPFQw7RGsmomc5387pgA6QvZkfWLC+V
         HTFYCNOtld/x2icd7maxkdWbIwkObecoC4Eznr/FpZszHyiGoFxEP6czsMQmg1FLl8C4
         2b0u8ADg+nGk9jJoWDpC+vmr/EggRCAFUWpOXkpjJErM3tlaySKmMge30ldVKPMDF9oh
         A9DxwMi7aGWKVHMFXfLSmND7Y+OL8KDYxB5ITinq16qXgnrei4vFmuIfAksSAfMM3exp
         cOmDbh3zKAR9rLgUKg7S9/lTQL5hRiA+Amiy2vCohxLgQLJ7x3KP3VZ2xcB2kYwzs7oT
         TS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lNkqm5mDHS7GJ3dOEBMgWRtlQ/aBzzuCqiGbGOTN6Q=;
        b=bsVXyaqISWS5Ev6mKD/kDn8+VQU1WVvBOBDwHeFxdN9G8RMvROgM651WoFiL0sFKjf
         k9aMvVOLcDWqzqMGZTsrg8uqCxCVeeWCXPiNWKG8rgwtMqdyipt6/AxViPbeUFZiQYar
         5CwDiBtqCfRo9tCB4RWx0tMYGh/w5n/9rqJ0bHYDlG4lIzJfUyN1ngxXuwXr4NUmIG75
         asJMooTEmtxW7EPgzXYpeADCZHZl/uyg8gOyxaIVHWvUi22rSxU2ouAEY64TsFvhVqJT
         s2RNnLd+pMeXZvBIKIp0gfaLGQl4j/L8xovAuA202UocYfppz3d/ZXVxQHEFJN7hmn1B
         14Og==
X-Gm-Message-State: ANoB5pmA92kulVeaHz/ABF+58Yh7U7jfQF28o5tDnrBKqcYEB5HR8S4L
        JvuvmJ/UXr84r0vKB2c4o2wszA==
X-Google-Smtp-Source: AA0mqf5b67Xt/CHKfoOz8K1J9qJUTnyhFYZXylUlULKqCHA7cRhnTu/gTTCpIBU5VS4CUoIFPoFYMA==
X-Received: by 2002:a17:906:b6d3:b0:7ae:4236:bfb5 with SMTP id ec19-20020a170906b6d300b007ae4236bfb5mr6931827ejb.428.1668337592188;
        Sun, 13 Nov 2022 03:06:32 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b00782539a02absm2840462ejc.194.2022.11.13.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:06:31 -0800 (PST)
Date:   Sun, 13 Nov 2022 12:06:30 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     debug@rivosinc.com
Cc:     palmer@dabbelt.com, jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gdb-script: updated lx_current for riscv
Message-ID: <20221113110630.y4uppv7d4ocm3lej@kamzik>
References: <20221111195938.1499148-1-debug@rivosinc.com>
 <20221111195938.1499148-2-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111195938.1499148-2-debug@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:59:38AM -0800, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> lx_current python gdb command defined in scripts/gdb/cpus.py updated
> to support riscv architecture.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  scripts/gdb/linux/cpus.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..ce6703f1e35a 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,14 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_task_addr = gdb.parse_and_eval("$tp")
> +         if((current_task_addr.cast(utils.get_long_type()) >> 63) != 0):

Shouldn't there be a get_long_type().sizeof == 8 check somewhere before
shifting by 63? Or are 32-bit targets not supported at all for some
reason?

Thanks,
drew

> +             current_task = current_task_addr.cast(task_ptr_type)
> +             return current_task.dereference()
> +         else:
> +             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> +                                "while running in userspace")
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
