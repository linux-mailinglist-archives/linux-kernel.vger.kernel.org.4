Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE86FEA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 05:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEKDlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjEKDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:40:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619735A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:40:46 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55b7630a736so121577177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683776445; x=1686368445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENej4jeIUZxBD8VRbCOiI8elHKtxPPI57IP2BPex2w8=;
        b=dRwxCttbruWpOV8kYGHv3nNrU7YtDC+OTBLfOopudv25EcY0eOmFueuJ1hPNX/4yPK
         lZ+CKDV1ixGM1wGcKj6qimEkiOeHP6uO8k5UBK+K1guiiOneHW0aTpdbI9jx4n9a3pWh
         YFOswR2fPcVLNVki1JCjWzUrcXjuJx2vuRzc9QuQNzAXt9LIKAoY0UTfBY1lvuZsc4wF
         pZT0aAuiR0nq7zlCMbbcyMMj9SgafH/QvrYzNVzvWnn9FvZdI2qYWnYMs14sXD98qyJZ
         5JrZz4aeYcjgWQTN89jue2C1nxgpjN2jR5BgjDHmda2BP2F+t1GLE3TEXf4gxBg+jWes
         mQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683776445; x=1686368445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENej4jeIUZxBD8VRbCOiI8elHKtxPPI57IP2BPex2w8=;
        b=HJd072f7WRjwO9Kq0jJxyFoN6zgVS9CpmKc96KDsxcs1fR7X2tgUr0afSrn37/KNMX
         C+kLOJ3fLx5ybPl14KMZFZaYbU/TUwDIQLshhNVy1eNJQB9YwNgXkTAvBiiIU5EPKZ/V
         MIUijlcgWhw0Pjtp+wfwBZAevy1Kp1fGOv8HqqwW1HZgiZ62nx3Tsj8QVz6/HLeuxaiq
         l1YPcLarPnqW5R/Ju+U1UZ28ucZ6pjiHXJazKvS49sTkFLpSOVpmiO0Y3tOR3R14od9N
         1zi8LfAuJlDI9+qXZYLAkOK9GHKBUIBfWCPYC1CUQn+Da4wrUO22NBzb26mNGBWoZkcO
         QD7A==
X-Gm-Message-State: AC+VfDw0W6eg1tnj2FaTsOuEwccu7GO/LzzrikaTJq18NkwGTa6Ja8QN
        iOegdKcRefXUSgc4UeF/Adu8bg==
X-Google-Smtp-Source: ACHHUZ7h//pElwTWDcmRkblmnEL8tpIvH3DpaXFnfKmYUIesZtUkvvAepMEKFrx4IKpikCPoidpc1g==
X-Received: by 2002:a81:8702:0:b0:560:bb81:6468 with SMTP id x2-20020a818702000000b00560bb816468mr6471997ywf.23.1683776445583;
        Wed, 10 May 2023 20:40:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g138-20020a815290000000b0054629ed8300sm4571040ywb.80.2023.05.10.20.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 20:40:45 -0700 (PDT)
Date:   Wed, 10 May 2023 20:40:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/23] arm: allow pte_offset_map[_lock]() to fail
In-Reply-To: <ZFup/fG50MPFF979@casper.infradead.org>
Message-ID: <b9dc75bf-b13c-37ba-6c16-9fc163703dd@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <5011977-d876-6a24-a3fc-c7e6a02877b8@google.com> <ZFup/fG50MPFF979@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023, Matthew Wilcox wrote:
> On Tue, May 09, 2023 at 09:42:44PM -0700, Hugh Dickins wrote:
> > diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
> > index e4c2677cc1e9..2f6163f05e93 100644
> > --- a/arch/arm/lib/uaccess_with_memcpy.c
> > +++ b/arch/arm/lib/uaccess_with_memcpy.c
> > @@ -74,6 +74,9 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
> >  		return 0;
> >  
> >  	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
> > +	if (unlikely(!pte))
> > +		return 0;
> 
> Failing seems like the wrong thig to do if we transitioned from a PTE
> to PMD here?  Looks to me like we should goto a new label right after
> the 'pmd = pmd_offset(pud, addr);', no?

I'm pretty sure it's right as is; but probably more by luck than care -
I do not think I studied this code as closely as you have now made me do;
and it's clear that this is a piece of code where rare transient issues
could come up, and must be handled correctly.  Thank you for making me
look again.

The key is in the callers of pin_page_for_write(): __copy_to_user_memcpy()
and __clear_user_memset().  They're doing "while (!pin_page_for_write())"
loops - they hope for the fast path of getting pte_lock or pmd_lock on
the page, and doing a __memcpy() or __memset() to the user address; but
if anything goes "wrong", a __put_user() to fault in the page (or fail)
then pin_page_for_write() again.

"if (unlikely(!pte)) return 0" says that the expected fast path did not
succeed, so please __put_user() and have another go.

It is somewhere I could have done a "goto again", but that would be
superfluous when it's already designed that way at the outer level.

Hugh
