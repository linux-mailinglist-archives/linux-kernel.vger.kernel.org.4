Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E2639041
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKYTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:25:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129FE4219E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:25:36 -0800 (PST)
Received: from zn.tnic (p200300ea9733e784329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e784:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19F841EC068D;
        Fri, 25 Nov 2022 20:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669404334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H42Fy7UT7t5CwkJzK6CjHZlz5JvavQTpCUhRQ0ddhfk=;
        b=F+AgpWKqydRuRN/BF2gnTiP+7oKsno81NDRRHkunNo5Lfp+9VRS0/ahcoQxUZCU8EgNC2Z
        v/GE//CJDINCfmIN4QIwsZUb8nuMpSoJhA8Mb3Y0onRf3hatqmu9m6ATaqzPy53yRT1guP
        2qF0vufrvga0RYXDu2DhtVaGMKQltLA=
Date:   Fri, 25 Nov 2022 20:25:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y4EWqbCTBYEF8LOf@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927084632.14531-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:46:32AM +0200, Petr Pavlu wrote:
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..eba7709d75ae 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -120,14 +120,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  
>  targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
>  
> -CMD_RELOCS = arch/x86/tools/relocs
> -quiet_cmd_relocs = RELOCS  $@
> -      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
> -$(obj)/vmlinux.relocs: vmlinux FORCE
> -	$(call if_changed,relocs)
> +# vmlinux.relocs is created by the vmlinux postlink step.
> +vmlinux.relocs: vmlinux
> +	@true
>  
>  vmlinux.bin.all-y := $(obj)/vmlinux.bin
> -vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
> +vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += vmlinux.relocs

Any particular reason why vmlinux.relocs must move out of $(obj)/ where
it resides now?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
