Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2A74239A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjF2KBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjF2J7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F73AA1;
        Thu, 29 Jun 2023 02:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24886150B;
        Thu, 29 Jun 2023 09:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38882C433C8;
        Thu, 29 Jun 2023 09:57:17 +0000 (UTC)
Date:   Thu, 29 Jun 2023 10:57:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
Message-ID: <ZJ1VersqnJcMXMyi@arm.com>
References: <20230523004312.1807357-1-pcc@google.com>
 <20230523004312.1807357-2-pcc@google.com>
 <20230605140554.GC21212@willie-the-truck>
 <CAMn1gO4k=rg96GVsPW6Aaz12c7hS0TYcgVR7y38x7pUsbfwg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO4k=rg96GVsPW6Aaz12c7hS0TYcgVR7y38x7pUsbfwg5A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:41:12AM -0700, Peter Collingbourne wrote:
> On Mon, Jun 5, 2023 at 7:06 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, May 22, 2023 at 05:43:08PM -0700, Peter Collingbourne wrote:
> > > Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> > > the call to swap_free() before the call to set_pte_at(), which meant that
> > > the MTE tags could end up being freed before set_pte_at() had a chance
> > > to restore them. Fix it by adding a call to the arch_swap_restore() hook
> > > before the call to swap_free().
> > >
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> > > Cc: <stable@vger.kernel.org> # 6.1
> > > Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> > > Reported-by: Qun-wei Lin (林群崴) <Qun-wei.Lin@mediatek.com>
> > > Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: "Huang, Ying" <ying.huang@intel.com>
> > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > > v2:
> > > - Call arch_swap_restore() directly instead of via arch_do_swap_page()
> > >
> > >  mm/memory.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f69fbc251198..fc25764016b3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3932,6 +3932,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >               }
> > >       }
> > >
> > > +     /*
> > > +      * Some architectures may have to restore extra metadata to the page
> > > +      * when reading from swap. This metadata may be indexed by swap entry
> > > +      * so this must be called before swap_free().
> > > +      */
> > > +     arch_swap_restore(entry, folio);
> > > +
> > >       /*
> > >        * Remove the swap entry and conditionally try to free up the swapcache.
> > >        * We're already holding a reference on the page but haven't mapped it
> >
> > It looks like the intention is for this patch to land in 6.4, whereas the
> > other two in the series could go in later, right? If so, I was expecting
> > Andrew to pick this one up but he's not actually on CC. I've added him now,
> > but you may want to send this as a separate fix so it's obvious what needs
> > picking up for this cycle.
> 
> I was expecting that this whole series could be picked up in mm. There
> was a previous attempt to apply v3 of this series to mm, but that
> failed because a dependent patch (commit c4c597f1b367 ("arm64: mte: Do
> not set PG_mte_tagged if tags were not initialized")) hadn't been
> merged into Linus's master branch yet. The series should be good to go
> in now that that patch has been merged.

Did this series fall through the cracks? I can't see it in linux-next
(or maybe my grep'ing failed). The commit mentioned above is in 6.4-rc3
AFAICT. Unfortunately Andrew was not cc'ed on the initial post, Will
added him later, so he likely missed it. For reference, the series is
here:

https://lore.kernel.org/r/20230523004312.1807357-1-pcc@google.com/

Andrew, what's your preference for this series? I'd like at least the
first patch to go into 6.5 as a fix. The second patch seems to be fairly
low risk and I'm happy for the third arm64 patch/cleanup to go in
6.5-rc1 (but it depends on the second patch). If you prefer, I can pick
them up and send a pull request to Linus next week before -rc1.
Otherwise you (or I) can queue the first patch and leave the other two
for 6.6.

Thanks.

-- 
Catalin
