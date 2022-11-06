Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9956D61E261
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKFNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:36:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06965DFFF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:36:06 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7a5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7a5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DFC81EC06A9;
        Sun,  6 Nov 2022 14:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667741764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I5cmTwqL0wnTPzviAC8jMaIF1V7iZJ2LVpUVD7MHVyw=;
        b=MiLdg8CNRGju7VBzB6BnFJKqhB0FvJ4JVdisauoGxdYXMEuXHPGbCJ0BfuXNAYb7jFF81I
        57aETF36yfGntLgbe4pEJaGdpzkNDkOXxRKAGKyDPlrI6uAn+qFWWeSCkz1v1QnjUTJNiy
        pXJ+K7eD4I9kcPLtjXl0Y6OO1J0Rv90=
Date:   Sun, 6 Nov 2022 14:35:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2e4PgwAEXuFzoMd@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103175901.164783-2-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:58:49PM +0000, Ashok Raj wrote:
> @@ -696,8 +697,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
>  
>  	csig->rev = c->microcode;
>  
> -	/* No extra locking on prev, races are harmless. */
> -	if (csig->sig != prev.sig || csig->pf != prev.pf || csig->rev != prev.rev) {
> +	if (bsp && csig->rev != prev.rev) {
>  		pr_info("sig=0x%x, pf=0x%x, revision=0x%x\n",
>  			csig->sig, csig->pf, csig->rev);

And now that we've established that we don't do mixed steppings anymore
and the microcode revision is the same system-wide, you should simply
drop this pr_info(), in your next patch you're adding

+static u32 early_old_rev;

That thing should simply be

/* Currently applied microcode revision */
static u32 microcode_rev;

and you simply update that one each time you update microcode and print
it as the previous and the new one and then write the new one into this
var and that's it. Simple.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
