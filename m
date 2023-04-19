Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEC6E8177
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDSSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDSSuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:50:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C83C1F;
        Wed, 19 Apr 2023 11:50:12 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC6901EC04CC;
        Wed, 19 Apr 2023 20:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681930210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SVVPfMePTugNQXZr+bgsRgFqkCGg3mE6MBdeVlBoODA=;
        b=KXBwS68F4KAcG/GqVEvBT7wIz7lMKDfx7TxeX9FCQ3izpDOo3TqLQeyMHfO2HWbHuqPo8B
        poVubrwJJOpHO0TeCFos7ECY2VW3KlRtUh3Z52GGzDKs8lD5WZr83iolRJU5Ksk3CU5D2o
        E64Ec3jygBPHThdr7twGqWWdNWtmU2o=
Date:   Wed, 19 Apr 2023 20:50:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     broonie@kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Build failure after merge of the tip tree
Message-ID: <20230419185005.GFZEA33e2h2jgF/ll5@fat_crate.local>
References: <20230419182136.112974-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419182136.112974-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 07:21:36PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> /tmp/next/build/mm/migrate.c: In function 'remove_migration_pte':
> /tmp/next/build/mm/migrate.c:222:31: error: too few arguments to function 'pte_mkwrite'
>   222 |                         pte = pte_mkwrite(pte);
>       |                               ^~~~~~~~~~~
> In file included from /tmp/next/build/include/linux/pgtable.h:6,
>                  from /tmp/next/build/include/linux/mm.h:29,
>                  from /tmp/next/build/include/linux/migrate.h:5,
>                  from /tmp/next/build/mm/migrate.c:16:
> /tmp/next/build/arch/arm64/include/asm/pgtable.h:190:21: note: declared here
>   190 | static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
>       |                     ^~~~~~~~~~~
> 
> Caused by commit
> 
>   717f95b494ac36 ("mm: don't check VMA write permissions if the PTE/PMD indicates write permissions")
> 
> from the mm tree interacting with
> 
>   74fd30bd28e4c7 ("mm: Make pte_mkwrite() take a VMA")
> 
> from the tip tree.  I've applied the fixup below

Thanks for letting us know - we'll keep this in mind when sending the
piles of patches to Linus next week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
