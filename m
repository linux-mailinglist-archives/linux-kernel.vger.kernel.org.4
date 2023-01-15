Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40E66B3B0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAOTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjAOTjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:39:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918F9EE6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:39:23 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33F901EC01E0;
        Sun, 15 Jan 2023 20:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673811562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dL7LqB7aW6y9NbE/YU3vhj9TnSPiHu5prudMXC6OMZk=;
        b=deEwjQAj33LZR389CrNBE5LoAzOKgDAyse/2bjq+/GR4VghWvzL24hFcMMGNjV7ecoQx8Y
        Bfzu6MfL64XYWYsdKoA+eVcnp+BbLbdI3pG1fsr9N8VAIJ0zB8xUiZ/MtDfo0LMTxDJsUs
        AGGLzZXO4o406D0S8IIbJSJnyp2n/FY=
Date:   Sun, 15 Jan 2023 20:39:18 +0100
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
Message-ID: <Y8RWZu/SGYV7Eqst@zn.tnic>
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
> @@ -334,7 +331,7 @@ void show_ucode_info_early(void)
>  
>  	if (delay_ucode_info) {
>  		intel_cpu_collect_info(&uci);
> -		print_ucode_info(&uci, current_mc_date);
> +		print_ucode_info(uci.cpu_sig.rev. current_mc_date);

You must be kidding:

arch/x86/kernel/cpu/microcode/intel.c: In function ‘show_ucode_info_early’:
arch/x86/kernel/cpu/microcode/intel.c:332:49: error: request for member ‘current_mc_date’ in something not a structure or union
  332 |                 print_ucode_info(uci.cpu_sig.rev. current_mc_date);
      |                                                 ^
arch/x86/kernel/cpu/microcode/intel.c:332:17: error: too few arguments to function ‘print_ucode_info’
  332 |                 print_ucode_info(uci.cpu_sig.rev. current_mc_date);
      |                 ^~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/microcode/intel.c:311:13: note: declared here
  311 | static void print_ucode_info(unsigned int new_rev, unsigned int date)
      |             ^~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/microcode/intel.c: In function ‘print_ucode’:
arch/x86/kernel/cpu/microcode/intel.c:343:33: error: unused variable ‘mc’ [-Werror=unused-variable]
  343 |         struct microcode_intel *mc;
      |                                 ^~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:252: arch/x86/kernel/cpu/microcode/intel.o] Error 1
make[4]: *** [scripts/Makefile.build:504: arch/x86/kernel/cpu/microcode] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:504: arch/x86/kernel/cpu] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:504: arch/x86/kernel] Error 2
make[1]: *** [scripts/Makefile.build:504: arch/x86] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:2008: .] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
