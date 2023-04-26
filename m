Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827866EF8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjDZQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDZQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09153599;
        Wed, 26 Apr 2023 09:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C11E63787;
        Wed, 26 Apr 2023 16:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60921C433EF;
        Wed, 26 Apr 2023 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682527644;
        bh=LQIlZBXyvbpRW/w7bY9aSuiYQzw21Inh3Gti8/6IHO0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sKZvNectox1rW/0Kt+dYBwGPPJyiXg/4k6NvGpRI/m3H/I1ZyTCgo54bLncGXM15x
         1AQ5mmloG8jT8XJd8KasLmwdRAm0lFLwFMG9Io4HoxUyA0rqXdOlBXI2zrxNazX81q
         WKgBJBQ6k/Peg/xD7UpueXtlG1s4ySQovbI/kAsmeZAOEU2+nZQBXhZJPyj4ph2Sfe
         ajKQQm31OtiPNfdz33ot6Y5A8HBt3UNngT3WVqjDNLSpv0L7cYv8dJhTI+f7bqnZZ6
         DLunByvUsKVa91qD51NoR05GAJDp/UH86hcoNCzQYq4g6dMPlRBqmsSU8gSMCH5uPM
         G4gwU3FQgRP/w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V4 05/23] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
In-Reply-To: <20230404182037.863533-6-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-6-sunilvl@ventanamicro.com>
Date:   Wed, 26 Apr 2023 18:47:20 +0200
Message-ID: <87a5yua8vb.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil V L <sunilvl@ventanamicro.com> writes:

> Without this, if the tables are larger than 4K,
> acpi_map() will fail.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/osl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..f725813d0cce 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size si=
ze)
>  	return NULL;
>  }
>=20=20
> -#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
> +#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISC=
V)
>  /* ioremap will take care of cache attributes */
>  #define should_use_kmap(pfn)   0

An observation, which can be addressed later; The acpi_os_ioremap()
(called when the config above is enabled for RV), does not have an arch
specific implementation for RISC-V. The generic one calls
ioremap_cached(), which on RISC-V defaults to ioremap() -- caching
disabled/_PAGE_IO.

That is probably not what we want, but rather something similar that
arm64 does.


Bj=C3=B6rn
