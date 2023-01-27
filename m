Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03D67EAED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjA0Q3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjA0Q3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:29:06 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAEE183069;
        Fri, 27 Jan 2023 08:29:03 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pLRav-0002kp-02; Fri, 27 Jan 2023 17:28:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AC99EC2638; Fri, 27 Jan 2023 17:28:11 +0100 (CET)
Date:   Fri, 27 Jan 2023 17:28:11 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     xurui <xurui@kylinos.cn>
Cc:     ralf@linux-mips.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [RFC] MIPS: Fix a compilation issue
Message-ID: <20230127162811.GC6090@alpha.franken.de>
References: <20230118085912.608758-1-xurui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230118085912.608758-1-xurui@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:59:12PM +0800, xurui wrote:
> arch/mips/include/asm/mach-rc32434/pci.h:377:
> cc1: error: result of ‘-117440512 << 16’ requires 44 bits to represent, but ‘int’ only has 32 bits [-Werror=shift-overflow=]
> 
> I guss we don`t need a left shift here?
> 
> Signed-off-by: xurui <xurui@kylinos.cn>
> ---
>  arch/mips/include/asm/mach-rc32434/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mach-rc32434/pci.h b/arch/mips/include/asm/mach-rc32434/pci.h
> index 9a6eefd12757..3eb767c8a4ee 100644
> --- a/arch/mips/include/asm/mach-rc32434/pci.h
> +++ b/arch/mips/include/asm/mach-rc32434/pci.h
> @@ -374,7 +374,7 @@ struct pci_msu {
>  				 PCI_CFG04_STAT_SSE | \
>  				 PCI_CFG04_STAT_PE)
>  
> -#define KORINA_CNFG1		((KORINA_STAT<<16)|KORINA_CMD)
> +#define KORINA_CNFG1		(KORINA_STAT | KORINA_CMD)
>  
>  #define KORINA_REVID		0
>  #define KORINA_CLASS_CODE	0
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
