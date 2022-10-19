Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E46041BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiJSKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiJSKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:45:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732711E459
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:21:36 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 784C41EC063A;
        Wed, 19 Oct 2022 12:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666174323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=udzxnzVBUyuAB6juImJMIDyrr5Y0Y36NoKf9al6QXg8=;
        b=fkPcFsS8NSJP8lLWdzzP5EabuYpaxMGWoVPPY4mQosi3v9ImCZbiDgbN4+7dda/3skQBmG
        ay1ppR2LoY3eQ+5CyikM4aJuFGr4kJNcjy9zCG2pYuKMhdjhbfSWqhncxSGb0DjBUrd/wF
        LbsqUHQOcbE8vs26qjrnUdVayjlb3LI=
Date:   Wed, 19 Oct 2022 12:12:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH 01/13] x86/microcode/intel: Print old and new rev after
 early microcode update
Message-ID: <Y0/NcChbFK5m8jl+@zn.tnic>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014200913.14644-2-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:09:01PM -0700, Ashok Raj wrote:
> @@ -435,10 +435,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
>   * Print ucode update info.
>   */
>  static void
> -print_ucode_info(struct ucode_cpu_info *uci, unsigned int date)
> +print_ucode_info(u32 old_rev, struct ucode_cpu_info *uci, unsigned int date)
>  {
> -	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
> -		     uci->cpu_sig.rev,
> +	pr_info_once("microcode updated early from 0x%x to revision 0x%x, date = %04x-%02x-%02x\n",

That already has the "microcode: " prefix from pr_fmt so make that

		     "early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n"

and fix the late update message too, pls, to look the same without the
"early" in there.

> @@ -479,13 +481,15 @@ static void print_ucode(struct ucode_cpu_info *uci)
>  
>  	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
>  	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
> +	old_rev_p = (u32 *)__pa_nodebug(&early_old_rev);

No, you should add a

	u32 prev_rev;

to struct ucode_cpu_info, save it there and access it where needed.

Then I can do the same prev -> next revision dumping on the AMD side.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
