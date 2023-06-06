Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1876724013
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjFFKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjFFKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:47:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F0170C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:46:45 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 355EB1EC0506;
        Tue,  6 Jun 2023 12:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686048404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKZHBTQJsCuoAoohz+zroXcxso0fO+DfPtF4FwQ6JrQ=;
        b=aj+IPK6W+uTJSsj9SzOf9R5uJqxArbY4N4/H6VACktKdkAE0fVh+Y3EfNAjgcCMzRQKgTl
        QIBEOsXDuvyZqB7eSb0iTBBOefZYyN4Z9wiSRIpVsO2y5iz45TTQwEDw3tUE4YemH0Y3l5
        m/yYpiM2T5lcS8W4QdOsMo998wuEWRQ=
Date:   Tue, 6 Jun 2023 12:46:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RESEND PATCH v8 4/6] x86/sev: Use large PSC requests if
 applicable
Message-ID: <20230606104639.GMZH8Oj+84CvdXzAIW@fat_crate.local>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <cover.1684513813.git.thomas.lendacky@amd.com>
 <c5448163eea57a878d9aeae504bf46ad52f9a879.1684513813.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5448163eea57a878d9aeae504bf46ad52f9a879.1684513813.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:30:11AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 973756c89dac..8802a75e1c20 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -657,32 +657,58 @@ static u64 __init get_jump_table_addr(void)
>  	return ret;
>  }
>  
> -static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool validate)
> +static void pvalidate_pages(struct snp_psc_desc *desc)
>  {
> -	unsigned long vaddr_end;
> +	struct psc_entry *e;
> +	unsigned long vaddr;
> +	unsigned int size;
> +	unsigned int i;
> +	bool validate;
>  	int rc;
>  
> -	vaddr = vaddr & PAGE_MASK;
> -	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +	for (i = 0; i <= desc->hdr.end_entry; i++) {
> +		e = &desc->entries[i];
> +
> +		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
> +		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
> +		validate = (e->operation == SNP_PAGE_STATE_PRIVATE) ? true : false;

		validate = e->operation == SNP_PAGE_STATE_PRIVATE;

is enough :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
