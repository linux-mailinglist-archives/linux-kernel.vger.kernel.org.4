Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4C714165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 02:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjE2AcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2AcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 20:32:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309E9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 17:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oPq+aPazMa0RW6CoOUWsQ8ZgZfRmLufbWHh8kTVH4tk=; b=JoONvPpux0XMSl3QUMbjmEZJTV
        cIpIIDiWtZgjaLPMnw9Du1/urlvdvLMVvinUl/nef3kE1y89kW+/Fz49ITG4JVg3y2UYz5UEQ+wjH
        QlFQXH3IkF0J8XY4JZ3pIlvuXBTDUUwNVrTIXAtwlFk1Ikc6bSpYMqTHWD0chY38uZPryFsnT8kZe
        +jvIXKPaCZSp4xeZuTI54o+tHpV843DY8c7PdI4xsHSG80UVNBMkQnvku7sesRu3c5y/Z8EMHoCYQ
        huR+XA4sey0UJoRKYupm3HY+NtA52l0wyU1FFRBW43a1sPkYtoFJq1MX5w3JansfdqNx3aBHFzJNQ
        oTEryqLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3Qnd-004ube-2L; Mon, 29 May 2023 00:31:49 +0000
Date:   Mon, 29 May 2023 01:31:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-ID: <ZHPydXSAfRq8sh0u@casper.infradead.org>
References: <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
 <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
 <ZHF2byaRlaX3W6Md@casper.infradead.org>
 <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 04:49:52PM -0700, John Hubbard wrote:
> On 5/26/23 20:18, Matthew Wilcox wrote:
> > On Fri, May 26, 2023 at 07:11:05PM -0700, John Hubbard wrote:
> > > > So any user with 1024 processes can fragment physical memory? :/
> > > > 
> > > > Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
> > > 
> > > I was actually thinking that we should minimize any more cases of
> > > fragile mapcount and refcount comparison, which then leads to
> > > Matthew's approach here!
> > 
> > I was wondering if we shouldn't make folio_maybe_dma_pinned() a little
> > more accurate.  eg:
> > 
> >          if (folio_test_large(folio))
> >                  return atomic_read(&folio->_pincount) > 0;
> > 	return (unsigned)(folio_ref_count(folio) - folio_mapcount(folio)) >=
> > 			GUP_PIN_COUNTING_BIAS;
> 
> I'm trying to figure out what might be wrong with that, but it seems
> OK. We must have talked about this earlier, but I recall vaguely that
> there was not a lot of concern about the case of a page being mapped
> > 1024 times. Because pinned or not, it's likely to be effectively
> locked into memory due to LRU effects. As mentioned here, too.

That was my point of view, but David convinced me that a hostile process
can effectively lock its own memory into place.

> Anyway, sure.
> 
> A detail:
> 
> The unsigned cast, I'm not sure that helps or solves anything, right?
> That is, other than bugs, is it possible to get refcount < mapcount?
> 
> And if it's only due to bugs, then the casting, again, isn't likely to
> going to mitigate the fallout from whatever mess the bug caused.

I wasn't thinking too hard about the cast.  If the caller has the folio
lock, I don't think it's possible for refcount < mapcount.  This caller
has a refcount, but doesn't hold the lock, so it is possible for them
to read mapcount first, then have both mapcount and refcount decremented
and see refcount < mapcount.

I don't think it matters too much.  We don't hold the folio lock, so
it might transition from pinned to unpinned as much as a refcount might
be decremented or a mapcount incremented.  What's important is that a
hostile process can't prevent memory from being moved indefinitely.

David, have I missed something else?
