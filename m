Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC16938CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBLQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBLQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:32:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B4CA3B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:31:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so26478452ejx.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRnNrh0Tp9ZXxpjFA/ywNJuMyWK+ZOFUY36BgSa0sFI=;
        b=Nx1SlVzz+aBsCyvWUEdtlBtjS407l6At6bZQtLStUK75pis/Au5mahXmyfQoOBX7Pm
         xpLasDmyVLp1nfOQxx/av+ZdZG3MGxYkgMeS7CvVi+9tdUC+jFGxYa4ieDyarb8cZONh
         pZorZWDSzz5dUEOlwIINwhEGIRZl9gd6oehd+vJXW7iw1odkYxFWhLyH+z5CVktYftt6
         rg9xodQJ2xOkg5pXDT+vJHc5hn5G/NQueb+/bVlGz1dzCEbK48iuWVWa7lwZYFE/iRKO
         udI5iSvmHqqQ7XgCPmmfTxAvuZEP1EkmNN07WjZQw4puAa0MxbnyLzsmwJ6ZPVEe1UDc
         A3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRnNrh0Tp9ZXxpjFA/ywNJuMyWK+ZOFUY36BgSa0sFI=;
        b=reHZKcbOIGXzgWii6MDQca7LDU7JIGRHN7Mi2/SooMkUr8tvssf+IH/ZtoNg3Hzrcx
         OjAi9bhC+zdtkq3PE7pSkMd55EL6u7r/KNWAapsLjCO6t5TObr2WD5P8EKFvVXmG+rP9
         cKusnXozJ+5Va6nqbkseNlsKZuwCxLiE8d0WYfZRJFPfPB5f7W6XXYQMZFD9zX/wEuHN
         vH2qU/PLXYrSX1Gha5HSGyswQ3I/uTT0wwuK+n1n+hJlQZLx/ryE1vtjTD/+/rcRXzYT
         nDAiBP3FgL+Gf2ruNAlWpeXIJ6uyEWZdHlXQdryKizT6ErdNImCCzj0u8Wm5xxVQn+XX
         TDnQ==
X-Gm-Message-State: AO0yUKUgKVMI8LIYW7BLRYwpDMfpSQzAhyjvA/vwAjr8fSb7kGaEvE7P
        872u7jG1Ft5SzcM15J1YxGgIVA==
X-Google-Smtp-Source: AK7set9e8llSTJr2CLKFAlDSEgcVcdigtMmlauBE+/GL5OCHoDDlyoMZHUqxUPVIrmbpdpzGrMWbZA==
X-Received: by 2002:a17:907:6e0f:b0:8ae:6b88:e52d with SMTP id sd15-20020a1709076e0f00b008ae6b88e52dmr20536984ejc.7.1676219499814;
        Sun, 12 Feb 2023 08:31:39 -0800 (PST)
Received: from localhost ([145.224.109.44])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906040400b008448d273670sm5465070eja.49.2023.02.12.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 08:31:39 -0800 (PST)
Date:   Sun, 12 Feb 2023 17:31:37 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Fix Zbb alternative IDs
Message-ID: <20230212163137.y7ylsgyqlrlripgr@orel>
References: <20230212021534.59121-1-samuel@sholland.org>
 <20230212021534.59121-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212021534.59121-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 08:15:33PM -0600, Samuel Holland wrote:
> Commit 4bf8860760d9 ("riscv: cpufeature: extend
> riscv_cpufeature_patch_func to all ISA extensions") switched ISA
> extension alternatives to use the RISCV_ISA_EXT_* macros instead of
> CPUFEATURE_*. This was mismerged when applied on top of the Zbb series,
> so the Zbb alternatives referenced the wrong errata ID values.
> 
> Fixes: 9daca9a5b9ac ("Merge patch series "riscv: improve boot time isa extensions handling"")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  arch/riscv/include/asm/errata_list.h | 5 -----
>  arch/riscv/lib/strcmp.S              | 2 +-
>  arch/riscv/lib/strlen.S              | 2 +-
>  arch/riscv/lib/strncmp.S             | 2 +-
>  4 files changed, 3 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
