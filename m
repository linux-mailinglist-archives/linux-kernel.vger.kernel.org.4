Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979E6CA537
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjC0NKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:10:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD51985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:10:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so36041039edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679922627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ON1TRFTyjP269YlSlypUfBZaP5DJM7YPobS1hNusbJA=;
        b=oPkcSdVZEGtbuQOXS697FnTNSJxMY5MC+8ocH1eK91m1uNM89kJSQzhIqIoiWXl1pk
         iCuROR2/Go4dnukO7B3eGxalDbuIi4oYmQQTDAZTseZhPZQAT6SGKeeE34WsNp7ljS/E
         NwnuILPs46OmmAKz6xfUBPtBYHPTlVKSLNMmRCPSblZzVOCIMI1LvGyV+sBqv5aaZaCI
         XSuiQeSQIeZKLJanv0Wj/lVkz5rbRfFS/N6PqXKAmKTx099fxnDlXiMNqPDFpkTAiF7t
         c0THPpKVaCmH9k2zo05XDcVbt8zPzrw35mT5iOZg1xYZifclwcNzkhwgUKc5sAyw4CVX
         y1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON1TRFTyjP269YlSlypUfBZaP5DJM7YPobS1hNusbJA=;
        b=W8/HZ4e636qaK4eu/HzBBOEQojNqKpmenvBLhH+tuYykpBVvKRE/hod0mLi+LL5zLr
         V5NODvv2uLQ6Rt4lnC5sC1SjBeePanCOwMZVTWeAC296e0t1BQx40ADjXmNxSvVDvGil
         by/Q/L2Y1sxmiOtO2dM0MY1zT7MzFKGHptYcpeihJ0rd5VDQXn7JEDR+sI/po8AdVKNR
         i+dnQYlg1sS+HsNM5ABqRPbCSbsu5J9J3RwtMlERdJXSBvfjkMivNRRHCWPLhry8l10R
         ct6AbpOcBeWhvncdhGFwBjWeWoy5PeejTWPi29GSUs2qk6gSsGaZxCOsx2BtDzwiFahJ
         ELcw==
X-Gm-Message-State: AAQBX9cKpvhjQhSzFa0eISvWeyjtayrKZJRrrcuLn4NORL51nL6WtjQG
        QIuyFKSLbz6yd6j2WoLpocikwg==
X-Google-Smtp-Source: AKy350Yi2wo1LkaGRXXGGfRvdgclqblvOUAJV7al09yJLUCGZzgx0fvK5AIXEyEsSdVVcX154pxpVg==
X-Received: by 2002:a17:906:2f96:b0:932:8cd:1021 with SMTP id w22-20020a1709062f9600b0093208cd1021mr11597586eji.33.1679922627362;
        Mon, 27 Mar 2023 06:10:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b0092b5384d6desm14061725ejb.153.2023.03.27.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:10:26 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:10:25 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230327131025.6bawvoti65sth4rk@orel>
References: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
 <20230323045604.536099-5-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323045604.536099-5-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:56:04PM +0800, Sia Jee Heng wrote:
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
> 
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map. It copies the restore code to a 'safe' page, then start
> to restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
> 
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig                 |   6 +
>  arch/riscv/include/asm/assembler.h |  20 ++
>  arch/riscv/include/asm/suspend.h   |  19 ++
>  arch/riscv/kernel/Makefile         |   1 +
>  arch/riscv/kernel/asm-offsets.c    |   5 +
>  arch/riscv/kernel/hibernate-asm.S  |  77 ++++++
>  arch/riscv/kernel/hibernate.c      | 427 +++++++++++++++++++++++++++++
>  7 files changed, 555 insertions(+)
>  create mode 100644 arch/riscv/kernel/hibernate-asm.S
>  create mode 100644 arch/riscv/kernel/hibernate.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
