Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589D6ECBCA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjDXMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjDXMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:08:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E73210FC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:08:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C6A121AA0;
        Mon, 24 Apr 2023 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682338089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6MuiGpgDdKrjv2jc/KsdjFM0sntjlFejrlPqmIDhPw=;
        b=ab8J8imU9wUIxTP7Hl18LQsYRwbxsv+OLBQbvLKKKaB49DhoFuvOQ/ZG6Nk88KYL5/I7ai
        HlsIXylBo3qBN9UZiMrLCHPl6SdM5KvAEIovwIG3rZCEfoXo72L19pTR5xIjVSy7DNMVOn
        RBDLUNX2HQ4j+zYGPjfH/wJeoPpUgZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E4901390E;
        Mon, 24 Apr 2023 12:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y8seHClxRmQYagAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 24 Apr 2023 12:08:09 +0000
Date:   Mon, 24 Apr 2023 14:08:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
Message-ID: <ZEZxKJA/5aOfbZdX@dhcp22.suse.cz>
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
 <0733a4cf57109a4136de5ae46fac83fb15bdd528.1682229876.git.baolin.wang@linux.alibaba.com>
 <ZEZRv0ycAI0Ated1@dhcp22.suse.cz>
 <9a20c0b5-9d8a-2b1d-570a-61c17a4ce5e8@linux.alibaba.com>
 <ZEZpP/ab+zk7GgX7@dhcp22.suse.cz>
 <8d4059e3-2e6d-3f0c-2881-13b9bd07aa6c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4059e3-2e6d-3f0c-2881-13b9bd07aa6c@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-04-23 19:40:30, Baolin Wang wrote:
> 
> 
> On 4/24/2023 7:34 PM, Michal Hocko wrote:
> > On Mon 24-04-23 19:20:43, Baolin Wang wrote:
> > > 
> > > 
> > > On 4/24/2023 5:54 PM, Michal Hocko wrote:
> > > > On Sun 23-04-23 18:59:11, Baolin Wang wrote:
> > > > > Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
> > > > > checks whether the given zone contains holes, and uses pfn_to_online_page()
> > > > > to validate if the start pfn is online and valid, as well as using pfn_valid()
> > > > > to validate the end pfn.
> > > > > 
> > > > > However, the __pageblock_pfn_to_page() function may return non-NULL even
> > > > > if the end pfn of a pageblock is in a memory hole in some situations. For
> > > > > example, if the pageblock order is MAX_ORDER, which will fall into 2
> > > > > sub-sections, and the end pfn of the pageblock may be hole even though
> > > > > the start pfn is online and valid.
> > > > > 
> > > > > This did not break anything until now, but the zone continuous is fragile
> > > > > in this possible scenario. So as previous discussion[1], it is better to
> > > > > add some comments to explain this possible issue in case there are some
> > > > > future pfn walkers that rely on this.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
> > > > 
> > > > Do I remember correctly you've had a specific configuration that would
> > > > trigger this case?
> > > 
> > > Yes, I provided an example in previous thread [2] so show the
> > > __pageblock_pfn_to_page() is fragile in some cases.
> > > 
> > > [2] https://lore.kernel.org/all/52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com/
> > 
> > Please make it a part of the changelog.
> 
> Sure.
> 
> > > > 
> > > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > > ---
> > > > > Changes from v1:
> > > > >    - Update the comments per Ying and Mike, thanks.
> > > > > ---
> > > > >    mm/page_alloc.c | 7 +++++++
> > > > >    1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index 6457b64fe562..9756d66f471c 100644
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -1502,6 +1502,13 @@ void __free_pages_core(struct page *page, unsigned int order)
> > > > >     * interleaving within a single pageblock. It is therefore sufficient to check
> > > > >     * the first and last page of a pageblock and avoid checking each individual
> > > > >     * page in a pageblock.
> > > > > + *
> > > > > + * Note: the function may return non-NULL even if the end pfn of a pageblock
> > > > > + * is in a memory hole in some situations. For example, if the pageblock
> > > > > + * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
> > > > > + * of the pageblock may be hole even though the start pfn is online and valid.
> > > > > + * This did not break anything until now, but be careful about this possible
> > > > > + * issue when checking whether all pfns of a pageblock are valid.
> > > > 
> > > > It is not really clear what you should be doing (other than to be
> > > > careful which is not helpful much TBH) when you encounter this
> > > > situation. If the reality changes and this would break in the future
> > > > what would breakage look like? What should be done about that?
> > > 
> > > That depends on what the future pfn walkers do, which may access some hole
> > > memory with zero-init page frame. For example, if checking the
> > > __PageMovable() for a zero-init page frame, that will crash the system. But
> > > I can not list all the possible cases.
> > > 
> > > So how about below words?
> > > 
> > >   * Note: the function may return non-NULL even if the end pfn of a pageblock
> > >   * is in a memory hole in some situations. For example, if the pageblock
> > >   * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
> > >   * of the pageblock may be hole even though the start pfn is online and
> > > valid.
> > >   * This did not break anything until now, but be careful about this possible
> > >   * issue when checking whether all pfns of a pageblock are valid, that may
> > >   * lead to accessing empty page frame, and the worst case can crash the
> > > system.
> > >   * So you should use pfn_to_onlie_page() instead of pfn_valid() to valid the
> > >   * pfns in a pageblock if such case happens.
> > 
> > Does that mean that struct page is not initialized and PagePoisoned will
> > trigger or it is just zero-prefilled?
> 
> In the example I provided[2], these page frames of the hole memory are
> zero-prefilled.

OK, so make _that_ explicit in the comment. Essentially you want to say
that there are cases where we have zero-initialized struct pages for
memory holes. In general no pfn walker should touch a physical memory
range for pfn where the struct page doesn't contain any metadata it
recognizes. Zero fill struct pages do not contain any distinguishable
state so that makes it less of a problem.

All that being said I would reformulate the comment as follows:

	* Note: the function may return non-NULL struct page even for a
	* page block which contains a memory hole (i.e. there is no
	* physical memory for a subset of the pfn range). This should be
	* safe most of the time because struct pages are still zero
	* pre-filled and pfn walkers shouldn't touch any physical memory
	* range for which they do not recognize any specific metadata in
	* struct pages.


> [2] https://lore.kernel.org/all/52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com/

-- 
Michal Hocko
SUSE Labs
