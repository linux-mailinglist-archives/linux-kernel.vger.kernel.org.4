Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2569D48B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBTUOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBTUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:14:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6141E9E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:14:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s26so8955815edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+Wbr+1FrBDToW7AqV/H1MWMx9xByoJE7YPlqeXSlPA=;
        b=CB1sL9McrUfqxvGvfSbcQ0++7q9NQ187eKVG3qTYAlbaTDv+M81f5Xmvn4VLxF06NC
         FwYoGGSXpkhKPrlm8+yYT+bW8g2ZS+OUO8YumD3s3uO3y0boThFbgTldhsU+teV4uK0w
         6xgI7oSicUWs56egbjqob3gRx3Pt4Qsvc0/C29f40CiowuZdDgQVwY+rJD7C2yJcn+Di
         S4O2guihhLAHtW4ic9FyI5B/S5OfWnwWdBmx55f+Hj3laL+EAxNt4tdZgeQxSNnOSfQr
         yQ4JABzFJAP56di3KZHOxrKD20KAyhoM1f2tRxmV+FbVIPqC9N9MHB61T0Ms1kTEaf58
         uWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+Wbr+1FrBDToW7AqV/H1MWMx9xByoJE7YPlqeXSlPA=;
        b=Cw2K/zjA7+nxfjqAczcA7+eXdB5BHE+GumoqJiAifsPD3ujv2TvbxvpQrlkPRwPjnW
         gPCFaVQsDBKFCka+qcgDguwIiWH/3tlb6AjFkJcwvDOckpRZEMcSHcbbieWv0/Q27tWT
         NjI9bl/vNEXEYGlc+lq3r/LCCMopZvfwTuRuKrwNd0T8qMNBQpqceZETcnQ8cLHWgad1
         UGjuHQmKlQpfB2ymnXFENaAZdlkLAdTFGtaCynwFQ4FQWBDy6JSGGL+zplCNO/sgE+vK
         K2EJUfKm3+xMwZx4f9glZ7jF23DIMFYLwiogqU8l80jSeGzqEDl72ZeHeHcSd59/Ooqz
         P8oQ==
X-Gm-Message-State: AO0yUKWvxR4rXMHt79ziYdhKuSalnbddulhYkuQVbV1oyKHk0ZT/8Dyc
        mXPQeaDe/vmmnfMD8Z4C9B+w3Q==
X-Google-Smtp-Source: AK7set/K/1LntFX+Snxn8HPHm4SvMNLxHvAHb57jt/6GbqwtK7GjutOMU6EZsfIt79+a0qKcQJIkjA==
X-Received: by 2002:a17:906:2488:b0:8af:7b80:82c5 with SMTP id e8-20020a170906248800b008af7b8082c5mr7604550ejb.75.1676924078933;
        Mon, 20 Feb 2023 12:14:38 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906595000b008dd3956c2e3sm291245ejr.183.2023.02.20.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:14:38 -0800 (PST)
Date:   Mon, 20 Feb 2023 21:14:32 +0100
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
Subject: Re: [PATCH V2 20/21] MAINTAINERS: Add entry for drivers/acpi/riscv
Message-ID: <20230220201432.5lz7rvwqhfxa4fno@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-21-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-21-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:42PM +0530, Sunil V L wrote:
> ACPI defines few RISC-V specific tables which need
> parsing code added in drivers/acpi/riscv. Add maintainer
> entries for this newly created folder.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a717625..d47212194457 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -450,6 +450,13 @@ S:	Orphan
>  F:	drivers/platform/x86/wmi.c
>  F:	include/uapi/linux/wmi.h
>  
> +ACPI FOR RISC-V (ACPI/riscv)
> +M:	Sunil V L <sunilvl@ventanamicro.com>
> +L:	linux-acpi@vger.kernel.org
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	drivers/acpi/riscv

This section should go under the "ACPI FOR ARM64 (ACPI/arm64)"
section to be in alphabetical order and also in a more logical
place. Also, shouldn't this section include
arch/riscv/kernel/acpi.c and potentially other arch/riscv/ files?
I see arm64 doesn't, but maybe it should too.

> +
>  ACRN HYPERVISOR SERVICE MODULE
>  M:	Fei Li <fei1.li@intel.com>
>  L:	acrn-dev@lists.projectacrn.org (subscribers-only)
> -- 
> 2.34.1
>

Thanks,
drew
