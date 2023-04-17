Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D16E429F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDQIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDQIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:33:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0C172C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:33:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F24931F381;
        Mon, 17 Apr 2023 08:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681720394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y0fjpZ5XRmYR+zO82mvm5zAGJNMXJSJ1dcym+RMFYZw=;
        b=Fuof4IHzw3TWY7DR5DnUhjOmZiJawMeieuXo2zpxFhp3cL5PeTphrwEV1spL3lZEO/DbSi
        NgqL8daXoijmRRb2K0uRQIwie1TiNhErW3jNBnKboT6gopoand0pOe18M3pKtscxIyRxu+
        yvXG6oq9vsci/8g895gXwX+VXmp1tUc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D274B1390E;
        Mon, 17 Apr 2023 08:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /xz5MEkEPWRZRQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 17 Apr 2023 08:33:13 +0000
Date:   Mon, 17 Apr 2023 10:33:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <ZD0ESXd1mGW7BAZ+@dhcp22.suse.cz>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
 <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
 <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
 <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
 <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com>
 <ZDhGADdnbIAqdlrg@dhcp22.suse.cz>
 <e7171928-61aa-2897-b3d1-e5f826a4592c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7171928-61aa-2897-b3d1-e5f826a4592c@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-04-23 17:47:28, David Rientjes wrote:
> On Thu, 13 Apr 2023, Michal Hocko wrote:
> 
> > [...]
> > > > > This is a theoretical concern. Freeing a 1G page requires 16M of free
> > > > > memory. A machine might need to be reconfigured from one task to
> > > > > another, and release a large number of 1G pages back to the system if
> > > > > allocating 16M fails, the release won't work.
> > > >
> > > > This is really an important "detail" changelog should mention. While I
> > > > am not really against that change I would much rather see that as a
> > > > result of a real world fix rather than a theoretical concern. Mostly
> > > > because a real life scenario would allow us to test the
> > > > __GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
> > > > just end up with a theoretical fix for a theoretical problem. Something
> > > > that is easy to introduce but much harder to get rid of should we ever
> > > > need to change __GFP_RETRY_MAYFAIL implementation for example.
> > > 
> > > I will add this to changelog in v3. If  __GFP_RETRY_MAYFAIL is
> > > ineffective we will receive feedback once someone hits this problem.
> > 
> > I do not remember anybody hitting this with the current __GFP_NORETRY.
> > So arguably there is nothing to be fixed ATM.
> > 
> 
> I think we should still at least clear __GFP_NORETRY in this allocation: 
> to be able to free 1GB hugepages back to the system we'd like the page 
> allocator to at least exercise its normal order-0 allocation logic rather 
> than exempting it from retrying reclaim by opting into __GFP_NORETRY.
> 
> I'd agree with the analysis in 
> https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/ that 
> either a cleared __GFP_NORETRY or a __GFP_RETRY_MAYFAIL makes logical 
> sense.
> 
> We really *do* want to free these hugepages back to the system and the 
> amount of memory freeing will always be more than the allocation for 
> struct page.  The net result is more free memory.
> 
> If the allocation fails, we can't free 1GB back to the system on a 
> saturated node if our first reclaim attempt didn't allow these struct 
> pages to be allocated.  Stranding 1GB in the hugetlb pool that no 
> userspace on the system can make use of at the time isn't very useful.

I do not think there is any dispute in the theoretical concern. The question is
whether this is something that really needs a fix in practice. Have we
ever seen workloads which rely on GB pages to fail freeing them?

-- 
Michal Hocko
SUSE Labs
