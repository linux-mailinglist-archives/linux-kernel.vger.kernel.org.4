Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD73D71FA36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjFBGij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjFBGih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:38:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E72F184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:38:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bacfcc7d1b2so1741720276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685687915; x=1688279915;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpZOczBsR4xfXgaOr7JAksIfJeH0zAVR4HOmdqn2WnM=;
        b=MQbltgtZnpxjctQr+uFVsewY5VE5NXUP+fgzpdshkW8VMDLi/jmX8Tm6cJEVN75KO5
         eMzQQeVHyaOg5im7MqrpVvZmNtbY70bJPquEYjFZnpqOQiwh3ggGEuUZOqPQRJyrYh/W
         i+iggUJfR2oZ0kl76ZzZLWFVADgUlsLiALbp15wr01z/YGZ4gs3TU2SO+DR0aQhnSTOT
         dtI6TRsVuo4JEZoVSXAGY14e1RV+60jnzQrNU20RmPK7rqniXU/2wk1vKjSgTxR1Jys6
         GAfhWX9n0uNxF5CP8nHZ8MEGqQL56HNKZn101HF3ximV36n96JF/CdcYDCKEOlrhAPpq
         +j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685687915; x=1688279915;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpZOczBsR4xfXgaOr7JAksIfJeH0zAVR4HOmdqn2WnM=;
        b=Q9MfYV1FMWLNB4dq0I3jkQxx+QpsfiSVdRlOEig/L89l7lSP00nVcxuejhnachX0mG
         +dWptiDy00H4rwlMZ5arEIQ8Ot/pT9lzK7r762bDRpj5LdKanIRMDI1BGgFRB+kJ8Eve
         lEL/zROO4hF8aM5P47SXt6ldAOYkpgFyS2viqHzy4JDRqtp4va9vwHfjzxkwyE/g9AWa
         8rpk0MDn6omt4IWzbkW8loSkwUavrqz+km7swkMr+LgK/ofw+jHAYE2f3+KNk8WJ7xqN
         180XDGRRTO/Ap7dIX8fsSFrdgH5zDqPvAIaJEji905BgnL9VKN0kkCSJVAHr97M+kPLh
         s/Sg==
X-Gm-Message-State: AC+VfDzSI4vhkxNr66q+z6eiCqcgK85amEvPVKzEhx1NqoYdsnCIFU/e
        i73zA/mp3ISDCINgG6aQqNPqiQ==
X-Google-Smtp-Source: ACHHUZ6P8SSTMurOYYj/ALnVvhi3BuZn/ynwQtygsqQ/alJ03V+5vTPE5OsmNbOnOcV3aojCWBT3dw==
X-Received: by 2002:a81:a50c:0:b0:55d:afe6:ebcf with SMTP id u12-20020a81a50c000000b0055dafe6ebcfmr10875964ywg.46.1685687915164;
        Thu, 01 Jun 2023 23:38:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v16-20020a814810000000b005688deeefc2sm199574ywa.20.2023.06.01.23.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:38:34 -0700 (PDT)
Date:   Thu, 1 Jun 2023 23:38:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <20230601155751.7c949ca4@thinkpad-T15>
Message-ID: <d6af2345-40b0-e6fc-56d2-bce778632da9@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com> <ZHSwWgLWaEd+zi/g@casper.infradead.org> <a8df11d-55ae-64bc-edcb-d383a7a941ea@google.com> <20230601155751.7c949ca4@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023, Gerald Schaefer wrote:
> On Mon, 29 May 2023 07:36:40 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> > On Mon, 29 May 2023, Matthew Wilcox wrote:
> > > On Sun, May 28, 2023 at 11:20:21PM -0700, Hugh Dickins wrote:  
> > > > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > > > +{
> > > > +	struct page *page;
> > > > +
> > > > +	page = virt_to_page(pgtable);
> > > > +	call_rcu(&page->rcu_head, pte_free_now);
> > > > +}  
> > > 
> > > This can't be safe (on ppc).  IIRC you might have up to 16x4k page
> > > tables sharing one 64kB page.  So if you have two page tables from the
> > > same page being defer-freed simultaneously, you'll reuse the rcu_head
> > > and I cannot imagine things go well from that point.  
> > 
> > Oh yes, of course, thanks for catching that so quickly.
> > So my s390 and sparc implementations will be equally broken.
> > 
> > > 
> > > I have no idea how to solve this problem.  
> > 
> > I do: I'll have to go back to the more complicated implementation we
> > actually ran with on powerpc - I was thinking those complications just
> > related to deposit/withdraw matters, forgetting the one-rcu_head issue.
> > 
> > It uses large (0x10000) increments of the page refcount, avoiding
> > call_rcu() when already active.
> > 
> > It's not a complication I had wanted to explain or test for now,
> > but we shall have to.  Should apply equally well to sparc, but s390
> > more of a problem, since s390 already has its own refcount cleverness.
> 
> Yes, we have 2 pagetables in one 4K page, which could result in same
> rcu_head reuse. It might be possible to use the cleverness from our
> page_table_free() function, e.g. to only do the call_rcu() once, for
> the case where both 2K pagetable fragments become unused, similar to
> how we decide when to actually call __free_page().

Yes, I expect that it will be possible to mesh in with s390's cleverness
there; but I may not be clever enough to do so myself - it was easier to
get right by going my own way - except that the multiply-used rcu_head
soon showed that I'd not got it right at all :-(

> 
> However, it might be much worse, and page->rcu_head from a pagetable
> page cannot be used at all for s390, because we also use page->lru
> to keep our list of free 2K pagetable fragments. I always get confused
> by struct page unions, so not completely sure, but it seems to me that
> page->rcu_head would overlay with page->lru, right?

However, I believe you are right that it's worse.  I'm glad to hear
that you get confused by the struct page unions, me too, I preferred the
old pre-union days when we could see at a glance which fields overlaid.
(Perhaps I'm nostalgically exaggerating that "see at a glance" ease.)

But I think I remember the discussions when rcu_head, and compound_head
at lru.next, came in: with the agreement that rcu_head.next would at
least be 2-aligned to avoid PageTail - ah, it's even commented in the
fundamental include/linux/types.h.

Sigh.  I don't at this moment know what to do for s390:
it is frustrating to be held up by just the one architecture.
But big thanks to you, Gerald, for bringing this to light.

Hugh
