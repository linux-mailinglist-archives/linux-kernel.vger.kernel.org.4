Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D4619507
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiKDLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiKDLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:01:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6532CC88
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:00:45 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A2721EC02DD;
        Fri,  4 Nov 2022 12:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667559643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2DfDMvDEfCl6f+iu1DNkuxGDVrbKAhxaEEbnZy/Px9s=;
        b=H4U2IZt86sqQ9/5FOmQOD73FkEYRiwkjtZNOJ+ShOVUls31EhxleJFTFGpr/O9Ext+277g
        L1bO5wb3PqE6PG9WuB6Q6bviSbREa84GOLxCYNCP3OO+gaorT9crBy8fGLILlee22+yq4d
        hE+8QRm/XISwICNq4iDHI+gldlyqA1E=
Date:   Fri, 4 Nov 2022 12:00:43 +0100
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
Message-ID: <Y2Tw2+LCmZe8XBJn@zn.tnic>
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

This basically means that the loader is not going to support mixed
steppings microcode.

Yes, no?

If yes, can I remove the patch cache too and use a single buffer for the
current patch?

That would simplify things even more.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
