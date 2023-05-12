Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FE700446
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjELJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjELJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:51:13 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F74C1F;
        Fri, 12 May 2023 02:51:09 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C7EF24000C;
        Fri, 12 May 2023 09:51:04 +0000 (UTC)
Message-ID: <bea1128b-903c-a7d0-9929-d9667999bb6d@ghiti.fr>
Date:   Fri, 12 May 2023 11:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH AUTOSEL 6.3 5/7] riscv: Unconditionnally select
 KASAN_VMALLOC if KASAN
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
References: <20230509035455.59524-1-sashal@kernel.org>
 <20230509035455.59524-5-sashal@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230509035455.59524-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On 5/9/23 05:54, Sasha Levin wrote:
> From: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> [ Upstream commit 864046c512c2cd8418dc928b91981fb12a80396c ]
>
> If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
> KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Link: https://lore.kernel.org/r/20230203075232.274282-7-alexghiti@rivosinc.com
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index eb7f29a412f87..d6aad84efb95e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -118,6 +118,7 @@ config RISCV
>   	select HAVE_SYSCALL_TRACEPOINTS
>   	select IRQ_DOMAIN
>   	select IRQ_FORCED_THREADING
> +	select KASAN_VMALLOC if KASAN
>   	select MODULES_USE_ELF_RELA if MODULES
>   	select MODULE_SECTIONS if MODULES
>   	select OF


KASAN_VMALLOC is broken for any kernel < 6.4, so this one should not be 
backported to any kernel (5.15, 6.1, 6.2, 6.3).

Thanks,

Alex

