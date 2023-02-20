Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195369D10E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjBTQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBTQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:05:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0D1C591
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:05:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cq23so6288483edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3e35zhiWCC5w36GuRCT0zBRvbQNNUkxPm7/dUxmkrLI=;
        b=k7HRtuKcDehyhGBbLV87fFpnM1YMndgK+VNmMIKK2AJ4/2tgg/ilVbCSK/s+IGJNEm
         anX8HFSYmBFDlwoBg6c84xuIZXahPlt8ZWxZmriPnoHpPONEgIxG5hZx9Ana2uMeKRsE
         LDVheLsVCxDAhYmYVMD6gHuczy/J7XqKFoNcm2LyRLApCfvuADT7TsXiFC4YHaoOd6Dt
         2yfuZWQQrzjq/6UMwNVAUQzCXgJgSXEeJIqI+D+cxv0OlK5ROl8Hs6cvA8zwrJvMaYlj
         fi2y6qltbL021Jvf15z6yqXxTD1XNZmtRyrxST7TAFmPG1z2T8/x7rNGUmzvyEDDtQMi
         +xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e35zhiWCC5w36GuRCT0zBRvbQNNUkxPm7/dUxmkrLI=;
        b=wzfeuukeMB8GmqbrabjA5sTAk588yiHS8Aev6282pwYEWv4NXVZKT4dLvuDwt2yFMb
         O7FsgT+nqAi5U0n+svT5E8IycukKoT3LrzhxBPLeNNMG90DliVZaZ9xnq5Za9Usy3wRY
         Q23Ub5EczhQLIA7qGOdX4Lx537TKDskprZOMsaLPAAEEU9qoZ5iFA7m35Zjtg+Y+W60+
         +Sq0SZ61Da4enjG5m0aGY80kYuZLx3HNU3IekPPWD3R8vbtcGJ2n15ULWA+k/8mdWVTA
         9ThpFaZh3ceevB1KpaFqglRSOpyMRswDKnxg0VGqGtEoJ91at/PZfLOEg6xx235vv59W
         et9Q==
X-Gm-Message-State: AO0yUKUAtExlMEWz0CjMI8W/w1IgVlm8UP2MNQd2BPTsg7THh1Kq0ZK8
        /IemVyClFx3sapBRhoFKA27eaQ==
X-Google-Smtp-Source: AK7set9A8ucqs4LRx+gjcSjfcR5wmgHbbICEDKqyeAUfiKVjouaHw7lsXBe8uVEGz+al2PpLuV1AkQ==
X-Received: by 2002:a05:6402:1151:b0:4ac:beba:dc87 with SMTP id g17-20020a056402115100b004acbebadc87mr864286edw.0.1676909119809;
        Mon, 20 Feb 2023 08:05:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 3-20020a508e43000000b004ad7abf007asm23535edx.74.2023.02.20.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:05:19 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:05:18 +0100
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
Subject: Re: [PATCH V2 05/21] ACPI: Kconfig: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <20230220160518.zuppmgvvhvipawxe@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-6-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-6-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:27PM +0530, Sunil V L wrote:
> Enable the ACPI processor driver for RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ccbeab9500ec..b44ac8e55b54 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -281,7 +281,7 @@ config ACPI_CPPC_LIB
>  
>  config ACPI_PROCESSOR
>  	tristate "Processor"
> -	depends on X86 || IA64 || ARM64 || LOONGARCH
> +	depends on X86 || IA64 || ARM64 || LOONGARCH || RISCV
>  	select ACPI_PROCESSOR_IDLE
>  	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
>  	select THERMAL
> -- 
> 2.34.1
>

The commit message doesn't tell me if this is a premature config
enablement or if it's already necessary for this series. I think
if it's already necessary, then it should point out what requires
it in the commit message or be squashed into whatever patch
requires it (and also point out in that commit message why it's
required).

Thanks,
drew
