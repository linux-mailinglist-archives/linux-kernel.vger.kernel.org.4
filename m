Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714435EE377
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiI1RuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiI1RuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:50:17 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34C6C762
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:50:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso945367otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=n8VETjucgkSeOgw4Z+kCG1eP9l2HUQ8Y2HmD1XceACY=;
        b=Jz8Ag9PP7tHzbMoCA5rX0mXf6nqmFgbD+FFKuSJb5AEC+fpxyChSh+/EKyWROJGaV9
         Zr7B2MCjnb1ZAimADunpFIHA0konLO4Alb9jZDYJ1wAJPeVWkXgVJ5oplNBxWRc4dsC1
         E3TjlDV1fk+of8wDiVghEqSocoVsyzcCrf8YgxnRwg+aHcWG9p+/pv198Jnqtgk4wH+D
         lX5uNjO8eeW5EFr3DaXM/w8puM/YgdAmG4p4oK8YUVpowC+EqgJw5RYZWVfHHpOPzhtB
         0yT0lcxXr1pR0KJebaix5fVzPdXQHPTodnqeQw6spmUGCyIQnKbyQnwBjYpMVoPXEB6R
         oGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=n8VETjucgkSeOgw4Z+kCG1eP9l2HUQ8Y2HmD1XceACY=;
        b=AKAvhcs+uMiReRc+FORZa1Al3h0n0MZy+j2EuDQzhE9517eTe0+gOUj+rYkLUv5M0J
         VBh2JCteemHYajBt8ut7FvFvXX/EfdkA/FRbwNY7tT90t4yPe2vcnVfj2tRi4mQqjWs2
         wdc7EFDtdgCcwyLeUxTbrhk3pQwNVZAgmihr43ThEk1CNosBMcZwpOk7CFKea7YAPW6E
         eUxNLYHQsJVEuhoKEiSqhzu3nV66xuhV31FJu58FfOuLZo0yR894V99N8rAXru8gk3zN
         OZB2yQ9MZ3Qnpy1Lp/cQtU0mkkTTPxaizndUjaRd7dYqEahFTHG1Bo4w90oFYYtxU4aU
         PUbQ==
X-Gm-Message-State: ACrzQf0RWLEI1EGFf9npQaQaGdqymfwGqyFM6N6xlw1otH+7sw54ture
        7zTQ8KG5y7NXZYZio+72yoXV4g==
X-Google-Smtp-Source: AMsMyM7NArCQS6Gdbf3GmdJkrxR8LEzyb0rmKAhbsnOEOl68tUtfGYgr18fOacfnKK4IbhNaoDdqLg==
X-Received: by 2002:a05:6830:349:b0:63a:cd5d:9014 with SMTP id h9-20020a056830034900b0063acd5d9014mr14762382ote.29.1664387415249;
        Wed, 28 Sep 2022 10:50:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u35-20020a4a8c26000000b00475db5c28f9sm2214543ooj.10.2022.09.28.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:50:14 -0700 (PDT)
Date:   Wed, 28 Sep 2022 10:50:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
In-Reply-To: <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
Message-ID: <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 28 Sep 2022, Vlastimil Babka wrote:
> On 9/28/22 15:48, Joel Fernandes wrote:
> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> >> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> >>> It's a bug in linux-next, but taking me too long to identify which
> >>> commit is "to blame", so let me throw it over to you without more
> >>> delay: I think __PageMovable() now needs to check !PageSlab().
> 
> When I tried that, the result wasn't really nice:
> 
> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> 
> And what if there's another conflicting page "type" later. Or the debugging
> variant of rcu_head in struct page itself. The __PageMovable() is just too
> fragile.

I don't disagree (and don't really know all the things you're thinking
of in there).  But if it's important to rescue this feature for 6.1, a
different approach may be the very simple patch below (I met a similar
issue with OPTIMIZE_FOR_SIZE in i915 a year ago, and just remembered).

But you be the judge of it: (a) I do not know whether rcu_free_slab
is the only risky address ever stuffed into that field; and (b) I'm
clueless when it comes to those architectures (powerpc etc) where the
the address of a function is something different from the address of
the function (have I conveyed my cluelessness adequately?).

Hugh

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1953,7 +1953,12 @@ static void __free_slab(struct kmem_cach
 	__free_pages(folio_page(folio, 0), order);
 }
 
-static void rcu_free_slab(struct rcu_head *h)
+/*
+ * rcu_free_slab() must be __aligned(4) because its address is saved
+ * in the rcu_head field, which coincides with page->mapping, which
+ * causes trouble if compaction mistakes it for PAGE_MAPPING_MOVABLE.
+ */
+__aligned(4) static void rcu_free_slab(struct rcu_head *h)
 {
 	struct slab *slab = container_of(h, struct slab, rcu_head);
 
