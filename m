Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2F6E1106
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDMPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDMPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:25:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9441B458
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:25:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78C10218EC;
        Thu, 13 Apr 2023 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681399546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8qWv6lbQrmiYVPxlfAYsRxNyuhBzv0qM6z/DYPvLY8=;
        b=nIUV0xHFYLmN/NjQ6MlbvuHk2NlfIglNqJSc8i+EZ7qROM0EATg8BrNQCfnckWBPcBFTk+
        dR5tvdO1lQMOsPltm2Xs06ZhfqpXKfwr+M/TmGGBNL6EfwuM3OniPCwe4M1kKPzpZ/GUy3
        x3dJG3tVQbA3gADt9pJCnk+mwRg1fU4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 517381390E;
        Thu, 13 Apr 2023 15:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6qcFEfoeOGSDWQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Apr 2023 15:25:46 +0000
Date:   Thu, 13 Apr 2023 17:25:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
 <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
 <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 11:05:20, Pavel Tatashin wrote:
> On Wed, Apr 12, 2023 at 4:18 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 12-04-23 13:13:02, Andrew Morton wrote:
> > > Lots of questions (ie, missing information!)
> > >
> > > On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > >
> > > > HugeTLB pages have a struct page optimizations where struct pages for tail
> > > > pages are freed. However, when HugeTLB pages are destroyed, the memory for
> > > > struct pages (vmemmap) need to be allocated again.
> > > >
> > > > Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> > > > but given that this flag makes very little effort to actually reclaim
> > > > memory the returning of huge pages back to the system can be problem.
> > >
> > > Are there any reports of this happening in the real world?
> > >
> > > > Lets
> > > > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > > > reclaim without causing ooms, but at least it may perform a few retries,
> > > > and will fail only when there is genuinely little amount of unused memory
> > > > in the system.
> > >
> > > If so, does this change help?
> > >
> > > If the allocation attempt fails, what are the consequences?
> > >
> > > What are the potential downsides to this change?  Why did we choose
> > > __GFP_NORETRY in the first place?
> > >
> > > What happens if we try harder (eg, GFP_KERNEL)?
> >
> > Mike was generous enough to make me remember
> > https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/.
> > GFP_KERNEL wouldn't make much difference becauset this is
> > __GFP_THISNODE. But I do agree that the changelog should go into more
> > details about why do we want to try harder now. I can imagine that
> > shrinking hugetlb pool by a large amount of hugetlb pages might become a
> > problem but is this really happening or is this a theoretical concern?
> 
> This is a theoretical concern. Freeing a 1G page requires 16M of free
> memory. A machine might need to be reconfigured from one task to
> another, and release a large number of 1G pages back to the system if
> allocating 16M fails, the release won't work.

This is really an important "detail" changelog should mention. While I
am not really against that change I would much rather see that as a
result of a real world fix rather than a theoretical concern. Mostly
because a real life scenario would allow us to test the
__GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
just end up with a theoretical fix for a theoretical problem. Something
that is easy to introduce but much harder to get rid of should we ever
need to change __GFP_RETRY_MAYFAIL implementation for example.

> In an ideal scenario we should guarantee that this never fails: that
> we always can free HugeTLB pages back to the system. At the very least
> we could steal the memory for vmemmap from the page that is being
> released.

Yes, this really bothered me when the concept was introduced initially.
I am always concerned when you need to allocate in order to free memory.
Practically speaking we haven't heard about bug reports so maybe this is
not such a big deal as I thought.
-- 
Michal Hocko
SUSE Labs
