Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A47648B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLIXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLIXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:04:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA69655F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:04:36 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so6450249pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N7y0Fsj0V7Jx8UlnHY/tsP4KmC6NWQ+6Fi1dd0y8otA=;
        b=IWkguZSoL2fItk5S/5KatAx6Ma+mRNW1A7ymBYMHQkfco+SqKmg/BgwhmwAmtDFREa
         HXqfbd6u8/EfvxH+tCFcjQUntlUR+GJ27QyHmmVB8qPnfhav4uVut7+5jPAnaAhkYQIn
         tp2ueDwS3HqPgLOU2XAuEXNf2oO6b+3qhX25ywi+jcEhAbAgD3y/9Xn8EHLUELCHZeWU
         Yo5msYHNeK50cvQk6ZPc3Ug1Yhe/yLwar58UrXx9BO+9eHKIFgsyEMkmPZHHsHyHyx2N
         YSt+qWJxXpCP0tgJtl1cJDdZGRte0ul2Ue89e3VlQDkZW3BuHbZH0eKaba8TUCJgj797
         7hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7y0Fsj0V7Jx8UlnHY/tsP4KmC6NWQ+6Fi1dd0y8otA=;
        b=pyLm6+aOay3+BlWDUiYE29NPFAaJ1Da79U2HZLi/xPpzfVhzJF+x5VinwjWZhiZrGe
         lbzSrXP+NuWMdFoPBHJmdUGHLC1k2mzm7z7VO+zvGKPKOVwnfc3ROD2Rt4PNj80uSJSm
         AGDSkaNYxMfdbJwUosxv9Qkw8gzSaO/BGcTVpCskTuxPUKsFsidF1N+WBZJ14Gbd78Sw
         cc2S+vIK4FYdSyDcpgcY1TXQqpdo9hZ0SXd2mo2QbTD/hH1bE/ih267V7w2LolB+B/3A
         KW0ABZ/8usmmsdSHJMTFpw5ONR7aRH7/2PxL7tVn/e49AhaTFPsmZcA0jG+T0zYQx2rv
         3xgw==
X-Gm-Message-State: ANoB5pnzwrfiD6lCkhp7IwMjMt4AH/GFH13/QcE7WPaKHE9l878b+qqI
        hne5buw9ZbZiSu02v+OO7mnuFuG6xYcKdTI9wn0=
X-Google-Smtp-Source: AA0mqf5cA/qtvZTwZolemydZkhpOj8uJXz4RnA1VFMUXuJifwyTUlibOOKUTF/7F0Zjy6vs7xTwZsQ==
X-Received: by 2002:a17:90b:310f:b0:219:d84:4446 with SMTP id gc15-20020a17090b310f00b002190d844446mr7457385pjb.26.1670627075598;
        Fri, 09 Dec 2022 15:04:35 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id gl7-20020a17090b120700b00218f9bd50c7sm1543637pjb.50.2022.12.09.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:04:35 -0800 (PST)
Date:   Fri, 9 Dec 2022 15:04:31 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 2/7] KVM: x86/MMU: Move rmap_iterator to rmap.h
Message-ID: <Y5O+/1CYivRishFE@google.com>
References: <20221206173601.549281-1-bgardon@google.com>
 <20221206173601.549281-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206173601.549281-3-bgardon@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:35:56PM +0000, Ben Gardon wrote:
> In continuing to factor the rmap out of mmu.c, move the rmap_iterator
> and associated functions and macros into rmap.(c|h).
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c  | 76 -----------------------------------------
>  arch/x86/kvm/mmu/rmap.c | 61 +++++++++++++++++++++++++++++++++
>  arch/x86/kvm/mmu/rmap.h | 18 ++++++++++
>  3 files changed, 79 insertions(+), 76 deletions(-)
> 
[...]
> diff --git a/arch/x86/kvm/mmu/rmap.h b/arch/x86/kvm/mmu/rmap.h
> index 059765b6e066..13b265f3a95e 100644
> --- a/arch/x86/kvm/mmu/rmap.h
> +++ b/arch/x86/kvm/mmu/rmap.h
> @@ -31,4 +31,22 @@ void free_pte_list_desc(struct pte_list_desc *pte_list_desc);
>  void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head);
>  unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
>  
> +/*
> + * Used by the following functions to iterate through the sptes linked by a
> + * rmap.  All fields are private and not assumed to be used outside.
> + */
> +struct rmap_iterator {
> +	/* private fields */
> +	struct pte_list_desc *desc;	/* holds the sptep if not NULL */
> +	int pos;			/* index of the sptep */
> +};
> +
> +u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
> +		    struct rmap_iterator *iter);
> +u64 *rmap_get_next(struct rmap_iterator *iter);
> +
> +#define for_each_rmap_spte(_rmap_head_, _iter_, _spte_)			\
> +	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
> +	     _spte_; _spte_ = rmap_get_next(_iter_))
> +

I always found these function names and kvm_rmap_head confusing since
they are about iterating through the pte_list_desc data structure. The
rmap (gfn -> list of sptes) is a specific application of the
pte_list_desc structure, but not the only application. There's also
parent_ptes in struct kvm_mmu_page, which is not an rmap, just a plain
old list of ptes.

While you are refactoring this code, what do you think about doing the
following renames?

  struct kvm_rmap_head	-> struct pte_list_head
  struct rmap_iterator	-> struct pte_list_iterator
  rmap_get_first()	-> pte_list_get_first()
  rmap_get_next()	-> pte_list_get_next()
  for_each_rmap_spte()	-> for_each_pte_list_entry()

Then we can reserve the term "rmap" just for the actual rmap
(slot->arch.rmap), and code that deals with sp->parent_ptes will become
a lot more clear IMO (because it will not longer mention rmap).

e.g. We go from this:

  struct rmap_iterator iter;
  u64 *sptep;

  for_each_rmap_spte(&sp->parent_ptes, &iter, sptep) {
     ...
  }

To this:

  struct pte_list_iterator iter;
  u64 *sptep;

  for_each_pte_list_entry(&sp->parent_ptes, &iter, sptep) {
     ...
  }
