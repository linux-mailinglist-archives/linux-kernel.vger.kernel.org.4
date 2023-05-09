Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4516FBD07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjEICSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEICSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:18:04 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15FE60;
        Mon,  8 May 2023 19:18:02 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pwCvA-006hX7-Oq; Tue, 09 May 2023 10:17:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 09 May 2023 10:17:45 +0800
Date:   Tue, 9 May 2023 10:17:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH V5 03/21] crypto: hisilicon/qm: Fix to enable build with
 RISC-V clang
Message-ID: <ZFmtSReX9/WR5CkK@gondor.apana.org.au>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
 <20230508115237.216337-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508115237.216337-4-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 05:22:19PM +0530, Sunil V L wrote:
> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
> allmodconfig build. However, build fails with clang and below
> error is seen.
> 
> drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint '+Q' in asm
>                        "+Q" (*((char __iomem *)fun_base))
>                        ^
> This is expected error with clang due to the way it is designed.
> 
> To fix this issue, move arm64 assembly code under #if.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/999
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> [sunilvl@ventanamicro.com: Moved tmp0 and tmp1 into the #if]
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index ad0c042b5e66..2eaeaac2e246 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -610,13 +610,9 @@ EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
>  static void qm_mb_write(struct hisi_qm *qm, const void *src)
>  {
>  	void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
> -	unsigned long tmp0 = 0, tmp1 = 0;
>  
> -	if (!IS_ENABLED(CONFIG_ARM64)) {
> -		memcpy_toio(fun_base, src, 16);
> -		dma_wmb();
> -		return;
> -	}

Please leave this bit as it stands.

> +#if IS_ENABLED(CONFIG_ARM64)
> +	unsigned long tmp0 = 0, tmp1 = 0;
>  
>  	asm volatile("ldp %0, %1, %3\n"
>  		     "stp %0, %1, %2\n"
> @@ -626,6 +622,11 @@ static void qm_mb_write(struct hisi_qm *qm, const void *src)
>  		       "+Q" (*((char __iomem *)fun_base))
>  		     : "Q" (*((char *)src))
>  		     : "memory");

And simply add the ifdef around the assembly.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
