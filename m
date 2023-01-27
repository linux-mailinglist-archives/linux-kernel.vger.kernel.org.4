Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5767EAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjA0Q3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjA0Q24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:28:56 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BB867BBE0;
        Fri, 27 Jan 2023 08:28:55 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pLRav-0002kp-01; Fri, 27 Jan 2023 17:28:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A0ADDC2638; Fri, 27 Jan 2023 17:27:55 +0100 (CET)
Date:   Fri, 27 Jan 2023 17:27:55 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Message-ID: <20230127162755.GB6090@alpha.franken.de>
References: <20230115121922.6359-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115121922.6359-1-sander@svanheule.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 01:19:22PM +0100, Sander Vanheule wrote:
> The CPUs in these SoCs support MIPS32 R2, and allow ebase relocation.
> Even if the default exception base of 0x80000000 is used, the
> MIPS_GENERIC load address of 0x80100000 leaves sufficient space to not
> need an extra 0x400 bytes of padding.
> 
> Suggested-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> Olliver has suggested to make this change, in order to reduce the delta
> with a fully generic MIPS kernel.
> I hope the patch description makes sense, as I based the argumentation
> on the behaviour of the code, and similar commits 7d6d28377783 ("MIPS:
> Loongson64: select NO_EXCEPT_FILL") and dd54dedd947d ("MIPS: BCM47XX:
> select NO_EXCEPT_FILL"). The change was tested on an RTL8380 and an
> RTL8393 device, where it appears to work as expected.
> 
> Best,
> Sander
> 
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2db5c853992e..a8895aaa490e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -627,6 +627,7 @@ config MACH_REALTEK_RTL
>  	select IRQ_MIPS_CPU
>  	select CEVT_R4K
>  	select CSRC_R4K
> +	select NO_EXCEPT_FILL
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_HAS_CPU_MIPS32_R2
>  	select SYS_SUPPORTS_32BIT_KERNEL
> -- 
> 2.39.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
