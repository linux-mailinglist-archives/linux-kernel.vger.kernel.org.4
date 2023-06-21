Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF1739074
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFUT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFUT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:57:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E5E65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:57:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543ae6ce8d1so5045385a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687377424; x=1689969424;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/oCsBAha5TlkusYS9TJvUJvw6Xp0GQ+FaZxtlvSIy8=;
        b=31NOzH8T0+2VDO2CYEqSKyHjSx4gVZR51gmxRjnAqCA52GzLUvZWT/t9nYLXZAL+qi
         ywsalk0MVUxrtPZPbbn3QEezt/ckSPGzZQKVLq90m3dtRiguXqvJzIVfdy4tU1YDwyKp
         EGC+ePLAG5XxzTRYBcm0iLsvYjTF/QX3rxkUHYAVSS95DEznN25qtG1xtNMXwA9rpc7y
         hkwKF7JdRkoOwg6MmaahIrHH9SPz4ePLRXSkSCVQpWYyj6gHvwGtvOZQ6p5AMUsan8H5
         Jvsq+vmqVAzVHoxpXomDTyNqb3a5WmGugRiDjm1+Q1Qi0xBlQBkYg2FWXbmEbAi+namd
         d1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377424; x=1689969424;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/oCsBAha5TlkusYS9TJvUJvw6Xp0GQ+FaZxtlvSIy8=;
        b=GMIFTQ7uD9liiK2DGCNi46e2BvqgkbTOYLOPCCRo+fcBKWs7uJpxGy3IH9NQJT2Tz0
         qKGJ15r5A7WX9QZTT3Eoasx4VenRR8nnItgLQq1Zq7HbW09qR9TRKmOEDrW7Qa4ZPkxV
         QUa7gcTJzWEx9SBpeRjmvd8bFCAXXTJB/jqo+2STSBAeykxQEbTgwuoV0aVaWL+EMg7a
         oQ1ia70wQizo+H4z4t1so2q9jIyn16AhqvYVyBKTy+aVR2JqNmBoi9YZb+/7TZhQB/Tr
         NTIPNBEDYSc5FCnkuxu9sbRpoSR24ClVGSJjhg0uVxVDVcVV08+DirqVdvDl85cJSvpP
         y5Zw==
X-Gm-Message-State: AC+VfDz6aZk207WHImYwBbcGEj0deI7p9eyBnflCXbYDInbDXcrWSi8R
        BPymlU/gxWXTHo++rvbdo3qkTQ==
X-Google-Smtp-Source: ACHHUZ4PlOcgGzuvd/vrGBXWSweqjzis58nvu5gGAEW7a+L7+rBFMlDT/k/NAs79bhYMEn3+FtkAjw==
X-Received: by 2002:a17:902:6b45:b0:1ac:84dd:6d1f with SMTP id g5-20020a1709026b4500b001ac84dd6d1fmr14999678plt.1.1687377423613;
        Wed, 21 Jun 2023 12:57:03 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b0019aaab3f9d7sm3860360pli.113.2023.06.21.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:57:02 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:57:02 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 12:56:23 PDT (-0700)
Subject:     Re: [PATCH v1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
In-Reply-To: <20230621-panorama-stuffing-f24b26546972@spud>
CC:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        rdunlap@infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-2c7ad1c9-cba1-4501-ae38-0ffb3d5bf487@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 12:00:31 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Randy reported build errors in linux-next where XIP_KERNEL was enabled.
> ARCH_THEAD requires alternatives to support the non-standard ISA
> extensions used by the THEAD cores, which are mutually exclusive with
> XIP kernels. Clone the dependency list from the Allwinner entry, since
> Allwinner's D1 uses T-Head cores with the same non-standard extensions.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Link: https://lore.kernel.org/all/ab38f6af-cb68-a918-1a63-2e7c927a8ffc@infradead.org/
> Fixes: da47ce003963 ("riscv: Add the T-HEAD SoC family Kconfig option")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: Jisheng Zhang <jszhang@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig.socs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index ce10a38dff37..6833d01e2e70 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -43,6 +43,7 @@ config ARCH_SUNXI
>
>  config ARCH_THEAD
>  	bool "T-HEAD RISC-V SoCs"
> +	depends on MMU && !XIP_KERNEL
>  	select ERRATA_THEAD
>  	help
>  	  This enables support for the RISC-V based T-HEAD SoCs.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I don't have an ARCH_THEAD, though, so not sure where this is aimed at.
