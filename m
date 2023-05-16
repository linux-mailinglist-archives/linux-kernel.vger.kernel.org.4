Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0C70422D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbjEPAQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjEPAQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:16:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E75FD1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:16:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ac65ab7432so785035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684196175; x=1686788175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6gh2qYVut9aSylVwiYmVdq2jPzWcix3qnUjMW+9u1Y=;
        b=4DT4IrQPyQsz4h+dcRk/i2LEM+ilSfmH36PEG55MInjjTBGxQELkAy2DYSBQDQwIaO
         4X9iQxrb0bD6WqOfmbVD1TRc+OSr1/fhNSat4Lh1WFRxQfsuAIolN8800kDElXhNXelP
         LlqIpSwDtJPlkSMJL3mCFlcx7Mpde4o4iDk7xUzqFS4y8VdInEFgNXsvhb5OVozPBqPC
         P5nDQrkneFxH9jJ+OustYYE3W7BHQQzUaU7WXrV/bo2+IfYJL0t8d7cDO2VZ7sGKINON
         QPt9EIBsy+JHePYNsII5qP0NAJTzYMjlpMKd/qeQ7nDio77QEz76JhMEYmYceqmrZ+oQ
         Ji3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196175; x=1686788175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6gh2qYVut9aSylVwiYmVdq2jPzWcix3qnUjMW+9u1Y=;
        b=d38R3hzi+qG83ojJt32yQAx04AZZ9qgZY0wweRfGN0ZO5HR2mG8+FamA3eFps2b/e8
         lLgHxxoouHRGXR8E/kCj9tkVrTmmXU2i5FJyjsociJqHPwTgJPX5KFgkD0ws2rWyMHII
         I5bAq/BjLgz9d4iBBXQ+9aQ6Fy1cuk1auyb06KejoKmEDQXiqH1N6m9UvKlUMqTErSh8
         ze2ru7UOZI5fxva18V50yfkDPrp94H4VIEhhJvNSd2AFjUbFqk0HBABEdsqSEeNjn9yg
         T3VGedaVwcvS0VyEXyjBt4EuGQ84TNiVIz/zmjvF2NsJfwKLjqVfsrTq8DcLYaOZr7qE
         CoMg==
X-Gm-Message-State: AC+VfDzTj4PXtO42ZcsGlUNd6g0hgCOyWybvTogCQLrTOvV2/k3O8PSE
        MMk1hDWFbgyS+pnQVMHHDCIx0g==
X-Google-Smtp-Source: ACHHUZ6F8d7WPH/3QMv++9pQyJNemJ8pH/5jv3HUHQFDdhHoClEdG/sj9VEr8QKBhfu3MpNJ0Ldv3Q==
X-Received: by 2002:a17:903:2281:b0:1aa:dfdf:9232 with SMTP id b1-20020a170903228100b001aadfdf9232mr30882plh.16.1684196174906;
        Mon, 15 May 2023 17:16:14 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:c825:9c0b:b4be:8ee4])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b006260526cf0csm12286564pfa.116.2023.05.15.17.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 17:16:14 -0700 (PDT)
Date:   Mon, 15 May 2023 17:16:09 -0700
From:   Peter Collingbourne <pcc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Message-ID: <ZGLLSYuedMsViDQG@google.com>
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> On 13.05.23 01:57, Peter Collingbourne wrote:
> > Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> > the call to swap_free() before the call to set_pte_at(), which meant that
> > the MTE tags could end up being freed before set_pte_at() had a chance
> > to restore them. One other possibility was to hook arch_do_swap_page(),
> > but this had a number of problems:
> > 
> > - The call to the hook was also after swap_free().
> > 
> > - The call to the hook was after the call to set_pte_at(), so there was a
> >    racy window where uninitialized metadata may be exposed to userspace.
> >    This likely also affects SPARC ADI, which implements this hook to
> >    restore tags.
> > 
> > - As a result of commit 1eba86c096e3 ("mm: change page type prior to
> >    adding page table entry"), we were also passing the new PTE as the
> >    oldpte argument, preventing the hook from knowing the swap index.
> > 
> > Fix all of these problems by moving the arch_do_swap_page() call before
> > the call to free_page(), and ensuring that we do not set orig_pte until
> > after the call.
> > 
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> > Cc: <stable@vger.kernel.org> # 6.1
> > Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
> > Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table entry")
> 
> I'm confused. You say c145e0b47c77 changed something (which was after above
> commits), indicate that it fixes two other commits, and indicate "6.1" as
> stable which does not apply to any of these commits.

Sorry, the situation is indeed a bit confusing.

- In order to make the arch_do_swap_page() hook suitable for fixing the
  bug introduced by c145e0b47c77, patch 1 addresses a number of issues,
  including fixing bugs introduced by ca827d55ebaa and 1eba86c096e3,
  but we haven't fixed the c145e0b47c77 bug yet, so there's no Fixes:
  tag for it yet.

- Patch 2, relying on the fixes in patch 1, makes MTE install an
  arch_do_swap_page() hook (indirectly, by making arch_swap_restore()
  also hook arch_do_swap_page()), thereby fixing the c145e0b47c77 bug.

- 6.1 is the first stable version in which all 3 commits in my Fixes: tags
  are present, so that is the version that I've indicated in my stable
  tag for this series. In theory patch 1 could be applied to older kernel
  versions, but it wouldn't fix any problems that we are facing with MTE
  (because it only fixes problems relating to the arch_do_swap_page()
  hook, which older kernel versions don't hook with MTE), and there are
  some merge conflicts if we go back further anyway. If the SPARC folks
  (the previous only user of this hook) want to fix these issues with ADI,
  they can propose their own backport.

> > @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   	VM_BUG_ON(!folio_test_anon(folio) ||
> >   			(pte_write(pte) && !PageAnonExclusive(page)));
> >   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> >   	folio_unlock(folio);
> >   	if (folio != swapcache && swapcache) {
> 
> 
> You are moving the folio_free_swap() call after the folio_ref_count(folio)
> == 1 check, which means that such (previously) swapped pages that are
> exclusive cannot be detected as exclusive.

Ack. I will fix this in v2.

Peter
