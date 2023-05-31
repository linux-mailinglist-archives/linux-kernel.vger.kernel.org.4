Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B962F71892A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjEaSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjEaSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:14:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE9132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:14:19 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9779C1EC042D;
        Wed, 31 May 2023 20:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685556857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShXFZDFEDmPlX5Y3XBvXdK5GQ9yQ1nqotnDFM/A0v50=;
        b=pSEmarCJ7ae6RE2dRKTy4kIE02HMibao+y7kGU9agAA2DuF8wAfoL5qq1I+OlPHwsjAX8h
        c43XOwoKhOSLLUUBEzqTdf3i49wT0Excdpw2bFcleHfp+yxHzMJqYSc8wNl6UpluFmcUYq
        WO9QuqV6jYjwZkzRbDAZ7cGF6gVIWU8=
Date:   Wed, 31 May 2023 20:14:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        drm-intel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RESUBMIT][PATCH] x86/mm: Fix PAT bit missing from page
 protection modify mask
Message-ID: <20230531181412.GFZHeOdMHIGOXB2hwL@fat_crate.local>
References: <20230519183634.190364-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519183634.190364-1-janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 08:36:34PM +0200, Janusz Krzysztofik wrote:
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 15ae4d6ba4768..56466afd04307 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -654,8 +654,10 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  #define pgprot_modify pgprot_modify
>  static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>  {
> -	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
> -	pgprotval_t addbits = pgprot_val(newprot) & ~_PAGE_CHG_MASK;
> +	unsigned long mask = _PAGE_CHG_MASK | _PAGE_CACHE_MASK;
> +
> +	pgprotval_t preservebits = pgprot_val(oldprot) & mask;
> +	pgprotval_t addbits = pgprot_val(newprot) & ~mask;
>  	return __pgprot(preservebits | addbits);
>  }
>  
> -- 

This certainly needs Jürgen and he's on CC already, moving him to To:.

Also, why isn't this a Xen-specific fix but you're keeping _PAGE_PAT for
baremetal too, i.e., modifying the generic function?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
