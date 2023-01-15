Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5366B3A4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAOTZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:25:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9612846
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:25:19 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78B061EC01E0;
        Sun, 15 Jan 2023 20:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673810718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEkjuHl01v5acTI5Ul3UqetHoCr95OWSxTE9Z+mZFoU=;
        b=E1QAB7CIV2MiVNIa1BxNHcua9tBZmQTvQ+QxPjkLzYSIy4cqGuCL5kfbX8svQb5PyQifwT
        YxysdVw4Rh6TMXt30dW0pWpIc7fCA2vOLO6NeYyirINw89/Qsxptn4A3H9maOU4vmqVLp9
        RJ+hNyh5RN1c/25VkeYBXfCKGTFMlbQ=
Date:   Sun, 15 Jan 2023 20:25:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 4/6] x86/microcode/intel: Use a plain revision
 argument for print_ucode_rev()
Message-ID: <Y8RTGguX9yXoEGKv@zn.tnic>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-5-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109153555.4986-5-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:35:53AM -0800, Ashok Raj wrote:
> @@ -343,33 +340,23 @@ void show_ucode_info_early(void)
>   * At this point, we can not call printk() yet. Delay printing microcode info in
>   * show_ucode_info_early() until printk() works.
>   */
> -static void print_ucode(struct ucode_cpu_info *uci)
> +static void print_ucode(int new_rev, int date)
>  {
>  	struct microcode_intel *mc;
>  	int *delay_ucode_info_p;
>  	int *current_mc_date_p;
>  
> -	mc = uci->mc;
> -	if (!mc)
> -		return;
> -
>  	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
>  	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
>  
>  	*delay_ucode_info_p = 1;
> -	*current_mc_date_p = mc->hdr.date;
> +	*current_mc_date_p = date;

Here's how I know you haven't tested this on 32-bit:

arch/x86/kernel/cpu/microcode/intel.c: In function ‘print_ucode’:
arch/x86/kernel/cpu/microcode/intel.c:344:33: error: unused variable ‘mc’ [-Werror=unused-variable]
  344 |         struct microcode_intel *mc;
      |                                 ^~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:252: arch/x86/kernel/cpu/microcode/intel.o] Error 1
make[4]: *** [scripts/Makefile.build:504: arch/x86/kernel/cpu/microcode] Error 2
make[3]: *** [scripts/Makefile.build:504: arch/x86/kernel/cpu] Error 2
make[2]: *** [scripts/Makefile.build:504: arch/x86/kernel] Error 2
make[1]: *** [scripts/Makefile.build:504: arch/x86] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:2008: .] Error 2

Testing is overrated, right?

The maintainers can do that, ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
