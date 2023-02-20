Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1869669D458
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBTTvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:51:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37381C59C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:51:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g1so8546100edz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiNBdogVb/ctJRbRDskVYVFlh5rTlqKKL5FmI6kPZ8w=;
        b=cuiQ8z5ITbd3IB7rit7AwPXG0vORAkRAG63Zp9/IcLR8dKofsaq8zcD1HztVYPB4NF
         Dvlwh1lC0n26Z8wGxQvGI/WAzN3PSKOyy9JYHe44YeuhapZVNnvVV0l/nKOPIyK8MSku
         EFxR5PpAVadFmkAcAAnD5xhlggWWqDHmLuNXoii5IL1o+Strz6vQg5kQgNhru0pQ6wot
         0nuMV/gP7WFxothHDTqQZ/mRELysY8kig5lSEvIS25JCI5dh3YYzmXOlB8MoV+KBqeLZ
         qx/JV9oF0YRh/ZUBaqHZ96dx4Od0X/o18nmdeI4g5LKpOHf+oNvOY7wqMH+aZcJadJ5r
         SdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiNBdogVb/ctJRbRDskVYVFlh5rTlqKKL5FmI6kPZ8w=;
        b=FqGWmQk2q0o8MzO5ncB9Mcjfm4ckBG4fW9A06z4as7HQRVvSVxYyPlUEnnYCjljpsO
         wS+M0en77u+L5N0XsMkuzD72pNcVAU2AThc7O0yQBD5e3xJ5whSD1PNddA0s3QMRWuwK
         TnRG7vOCcmAFdLpFLEURZmwJosGLCFam7ssP2GdBYYebTO6p/uWI1Q4s4LfMwm6/fgRS
         Kvq2daaxRIl2eDOA5YRvlg+o17N1iSA7L8T+q65HZuJvT0y+dH1Kko4rQ0rr/SFC+Ufo
         2LLFZzUuOCV9NgGfCHrVNqWMQDqxIWV8do5+ze/fcAhxe4/A8ssPR68S5Ahdyh2kVNls
         4qGg==
X-Gm-Message-State: AO0yUKW6PN2fMhSNrjRRvISIYVPw72zAum0E/biwjkqsGThQ/ixYNuTa
        u/8J0zYoQDWFiS7+/HsWYF1Ccw==
X-Google-Smtp-Source: AK7set9V4qNdEX1rBCkKVXTOHRcZ49m2r691BtX2HHFvehjI813L7cOfgHotp9O0ya6YpqHH/ZRG4Q==
X-Received: by 2002:a17:907:764c:b0:88e:e498:109b with SMTP id kj12-20020a170907764c00b0088ee498109bmr10663251ejc.5.1676922669248;
        Mon, 20 Feb 2023 11:51:09 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id um8-20020a170907cb0800b008cca31606a8sm2356990ejc.51.2023.02.20.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:51:08 -0800 (PST)
Date:   Mon, 20 Feb 2023 20:51:07 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 16/21] clocksource/timer-riscv: Add ACPI support
Message-ID: <20230220195107.ixdfumgvfnobjlnt@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-17-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-17-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:38PM +0530, Sunil V L wrote:
> Initialize the timer driver based on RHCT table on ACPI based
> platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/clocksource/timer-riscv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 2ae8e300d303..5fb0eac52bdd 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) "riscv-timer: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> @@ -201,3 +202,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  }
>  
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> +
> +#ifdef CONFIG_ACPI
> +static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
> +{
> +	return riscv_timer_init_common();
> +}
> +
> +TIMER_ACPI_DECLARE(aclint_mtimer, ACPI_SIG_RHCT, riscv_timer_acpi_init);
> +
> +#endif
> -- 
> 2.34.1
>

This could probably be squashed into the last patch, but anyway

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
