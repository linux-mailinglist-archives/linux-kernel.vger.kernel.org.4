Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC65B7D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiIMWun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIMWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8751165270
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF6061627
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5672C433D6;
        Tue, 13 Sep 2022 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109438;
        bh=+dYScZf8oC85BzrYt8r36FW8HDb2ksPxKtaCWZJR+8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ec/X4JvAF185ieQqqv6tEfOsX/oi8QsRt+Jxw+IewfNoctV8rxBTgvni3+FflANaU
         WO5PlgmQxs9eYz9tPYJ676/+yt1JCaOO5ql2QL5NlPM7Xq5NwZS7F/MJp7KkPK9bFq
         s7mB/UPEAcCEfYWJALD3+5+4BrmlfogrTwm6AHBeiU0UM+rfToS1U1XgfxarZGdmdi
         CQQP00NE7/Qn6vTK5nZJo27iM+0lW0o8C5E9PqQzLtPX0To/YN5YbyMbhxs0lRJ5wV
         J9jYTpXJmWqE9g+GcooDfSaSjVl0iYnAyQLWRt1B+3WVmVLW7EvjkX1RRdgo2xGeGM
         TveaBLAVXfpqw==
Date:   Tue, 13 Sep 2022 17:50:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Ira W . Snyder" <ira.snyder@gmail.com>
Subject: Re: [PATCH v2 08/10] x86/Kconfig: make CONFIG_PCI_CNB20LE_QUIRK
 depend on X86_32
Message-ID: <20220913225036.GA631462@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220911084711.13694-9-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 10:47:09AM +0200, Mateusz Jończyk wrote:
> I was unable to find a good description of the ServerWorks CNB20LE
> chipset. However, it was probably exclusively used with the Pentium III
> processor (this CPU model was used in all references to it that I
> found where the CPU model was provided: dmesgs in [1] and [2];
> [3] page 2; [4]-[7]).
> 
> As is widely known, the Pentium III processor did not support the 64-bit
> mode, support for which was introduced by Intel a couple of years later.
> So it is safe to assume that no systems with the CNB20LE chipset have
> amd64 and the CONFIG_PCI_CNB20LE_QUIRK may now depend on X86_32.
> 
> Additionally, I have determined that most computers with the CNB20LE
> chipset did have ACPI support and this driver was inactive on them.
> I have submitted a patch to remove this driver, but it was met with
> resistance [8].

Only because removing the driver appeared to have no demonstrated
benefit and risked breaking old machines.

Making this depend on X86_32 seems plausible to me.

> [8] Bjorn Helgaas, "Re: [PATCH] x86/pci: drop ServerWorks / Broadcom
> CNB20LE PCI host bridge driver"
> https://lore.kernel.org/lkml/20220318165535.GA840063@bhelgaas/T/
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ira W. Snyder <ira.snyder@gmail.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> ---
> v2: make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
>     (previously only help text and description were changed)
>     upgrade short description.
> 
>  arch/x86/Kconfig | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fdfe8b7e895a..31f778b0cd0b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2739,13 +2739,21 @@ config MMCONF_FAM10H
>  	depends on X86_64 && PCI_MMCONFIG && ACPI
>  
>  config PCI_CNB20LE_QUIRK
> -	bool "Read CNB20LE Host Bridge Windows" if EXPERT
> -	depends on PCI
> +	bool "Read PCI host bridge windows from the CNB20LE chipset" if EXPERT
> +	depends on X86_32 && PCI
>  	help
>  	  Read the PCI windows out of the CNB20LE host bridge. This allows
>  	  PCI hotplug to work on systems with the CNB20LE chipset which do
>  	  not have ACPI.
>  
> +	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
> +	  most probably only for Pentium III.
> +
> +	  To find out if you have such a chipset, search for a PCI device with
> +	  1166:0009 PCI IDs, for example by executing
> +		lspci -nn | grep '1166:0009'
> +	  The code is inactive if there is none.
> +
>  	  There's no public spec for this chipset, and this functionality
>  	  is known to be incomplete.
>  
> -- 
> 2.25.1
> 
