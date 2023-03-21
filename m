Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF316C3BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCUU0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:26:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8D2D64;
        Tue, 21 Mar 2023 13:26:09 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1peiYQ-000417-2m; Tue, 21 Mar 2023 21:25:58 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Cc:     slewis@rivosinc.com, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/6] RISC-V: hwprobe: Add support for
 RISCV_HWPROBE_BASE_BEHAVIOR_IMA
Date:   Tue, 21 Mar 2023 21:25:56 +0100
Message-ID: <22291092.EfDdHjke4D@diego>
In-Reply-To: <20230314183220.513101-4-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-4-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. März 2023, 19:32:17 CET schrieb Evan Green:
> We have an implicit set of base behaviors that userspace depends on,
> which are mostly defined in various ISA specifications.
> 
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

This needs one fix, described blow, with that applied:
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>


> +	case RISCV_HWPROBE_KEY_IMA_EXT_0:
> +		pair->value = 0;
> +		if (has_fpu())
> +			pair->value |= RISCV_HWPROBE_IMA_FD;
> +
> +		if (elf_hwcap & RISCV_ISA_EXT_c)

This wants to be 
		if (elf_hwcap & riscv_isa_extension_mask(c))

i.e. elf_hwcap is a bitmap, RISCV_ISA_EXT_c is the number "2" and
riscv_isa_extension_mask() will get you the shifted bit.


> +			pair->value |= RISCV_HWPROBE_IMA_C;
> +
> +		break;
>  
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> 

Heiko


