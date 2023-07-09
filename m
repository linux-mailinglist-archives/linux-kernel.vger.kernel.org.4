Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B774C4A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGIOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:06:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0E97;
        Sun,  9 Jul 2023 07:06:27 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko.stuebner@vrull.eu>)
        id 1qIV3J-0002bh-B1; Sun, 09 Jul 2023 16:06:17 +0200
From:   Heiko Stuebner <heiko.stuebner@vrull.eu>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v3 4/4] RISC-V: Implement archrandom when Zkr is available
Date:   Sun, 09 Jul 2023 16:06:16 +0200
Message-ID: <3566075.R56niFO833@phil>
In-Reply-To: <20230709115549.2666557-5-sameo@rivosinc.com>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-5-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 9. Juli 2023, 13:55:46 CEST schrieb Samuel Ortiz:
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
> 
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---

> +static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
> +{
> +	if (!max_longs)
> +		return 0;
> +
> +	/*
> +	 * If Zkr is supported and csr_seed_long succeeds, we return one long
> +	 * worth of entropy.
> +	 */
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))

While this whole thing looks really nice, I don't think you can only
check the ZKR existence though.

To access the seed csr from supervisor-mode, it looks like the SSEED
bit in the mseccfg register also needs to be set by firmware.
And in the kernel we will likely need to check this setting somehow
before enabling access.

At least my qemu fails with an illegal instruction otherwise during the
early random seed initialization.


Heiko



