Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4977E701584
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjEMJOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjEMJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA1E30F1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C9A60C88
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9152C433D2;
        Sat, 13 May 2023 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683969242;
        bh=R8BaXvrEqkDtkKLwWmr0dANy8SCHQgwY/EbJ9khwnXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slhfgg2/AWnHNrzIZxddnKGXkyOmDvpcHXzF2mTBQ2ok81VA4ycpZV3005Jsx9z1K
         MuE5pHI7/jTrY9dBlQdZEySom/ao2+H4XppHAz7r8eq0xkR+eg6pCBV1mi1Cg1CGW4
         5+wyYHRf/a0dgK1AbYCLi6THyDZMyQGcpMYajQUCd/ZfaFLSX/T5L6Om1LpxTYi5mX
         O3dxg3CXzsXwkgS9wJInVewBTTHM0mumqOoNO5+NWeoSg7yJ5DrL6KEE9hEbtYFdqR
         qvn5Dcg5CbmYcCUslNnKwYZRokqik4UqzwSTLiU+DqxPewHLga1c+dHKUcukL07aW4
         Mr7YPtKexBuhg==
Received: by pali.im (Postfix)
        id D53FF7F9; Sat, 13 May 2023 11:13:58 +0200 (CEST)
Date:   Sat, 13 May 2023 11:13:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] powerpc: udbg: export udbg_putc
Message-ID: <20230513091358.pzlexqnff5ydhlzf@pali>
References: <20230513055804.23775-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230513055804.23775-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2023 22:58:04 Randy Dunlap wrote:
> In a randconfig with CONFIG_SERIAL_CPM=m and
> CONFIG_PPC_EARLY_DEBUG_CPM=y, there is a build error:
> ERROR: modpost: "udbg_putc" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
> 
> The build can be fixed by exporting "udbg_putc" in udbg.c.
> 
> OTOH, maybe something like this is more appropriate in
> arch/powerpc/Kconfig.debug?
> 
> config PPC_EARLY_DEBUG_CPM
> 	bool "Early serial debugging for Freescale CPM-based serial ports"
> -	depends on SERIAL_CPM
> +	depends on SERIAL_CPM=y
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Pali Rohár" <pali@kernel.org>
> ---
>  arch/powerpc/kernel/udbg.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
> --- a/arch/powerpc/kernel/udbg.c
> +++ b/arch/powerpc/kernel/udbg.c
> @@ -14,6 +14,7 @@
>  #include <asm/udbg.h>
>  
>  void (*udbg_putc)(char c);
> +EXPORT_SYMBOL(udbg_putc);
>  void (*udbg_flush)(void);
>  int (*udbg_getc)(void);
>  int (*udbg_getc_poll)(void);

Hello! I do not think that it is a good idea to export udbg functions
for kernel modules. I have quickly looked at the cpm_uart driver file
drivers/tty/serial/cpm_uart/cpm_uart_core.c and it looks like that once
udbg from it is registered then there is no code for unregistering it.
So I have feeling that compiling cpm_uart driver as module should not be
allowed when CONFIG_SERIAL_CPM_CONSOLE is enabled, and early debug
should depend on CONFIG_CONSOLE_POLL || CONFIG_SERIAL_CPM_CONSOLE.

Any other opinion?
