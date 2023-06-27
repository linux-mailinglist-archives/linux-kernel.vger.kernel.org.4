Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF873FF67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjF0PO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF0POY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:14:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F0926AB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:14:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 372552188A;
        Tue, 27 Jun 2023 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687878861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+D0xhAl6bCP8w4Ev6dkVwB38CzSCevMrsveKQ90aLY=;
        b=HNdgg5a0G7+6HiDl5KyxLX0wrgSDAiYzCIlkI9EAqxSI+pCAwVpQ12whuebX5nXV8uXt3s
        u50x/bMzzJBPKP/j3fRw8VBZ+GNYaItLYsoiygmHQXAIhTwfpgZU/bKdS6VcEMuwSsBVUM
        gWJwKULODMlTs634Ad/ljD6V92ZN7TA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A56713276;
        Tue, 27 Jun 2023 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M3OWA838mmQzJQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 27 Jun 2023 15:14:21 +0000
Date:   Tue, 27 Jun 2023 17:14:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
Message-ID: <ZJr8zM/Van7UaUif@dhcp22.suse.cz>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-4-david@redhat.com>
 <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
 <74cbbdd3-5a05-25b1-3f81-2fd47e089ac3@redhat.com>
 <ZJrvhACxmaQmmwYP@dhcp22.suse.cz>
 <0929f4b9-bdad-bcb4-4192-44e88378016b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0929f4b9-bdad-bcb4-4192-44e88378016b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-06-23 16:57:53, David Hildenbrand wrote:
> On 27.06.23 16:17, Michal Hocko wrote:
> > On Tue 27-06-23 15:14:11, David Hildenbrand wrote:
> > > On 27.06.23 14:40, Michal Hocko wrote:
> > > > On Tue 27-06-23 13:22:18, David Hildenbrand wrote:
> > > > > John Hubbard writes [1]:
> > > > > 
> > > > >           Some device drivers add memory to the system via memory hotplug.
> > > > >           When the driver is unloaded, that memory is hot-unplugged.
> > > > > 
> > > > >           However, memory hot unplug can fail. And these days, it fails a
> > > > >           little too easily, with respect to the above case. Specifically, if
> > > > >           a signal is pending on the process, hot unplug fails.
> > > > > 
> > > > >           [...]
> > > > > 
> > > > >           So in this case, other things (unmovable pages, un-splittable huge
> > > > >           pages) can also cause the above problem. However, those are
> > > > >           demonstrably less common than simply having a pending signal. I've
> > > > >           got bug reports from users who can trivially reproduce this by
> > > > >           killing their process with a "kill -9", for example.
> > > > 
> > > > This looks like a bug of the said driver no? If the tear down process is
> > > > killed it could very well happen right before offlining so you end up in
> > > > the very same state. Or what am I missing?
> > > 
> > > IIUC (John can correct me if I am wrong):
> > > 
> > > 1) The process holds the device node open
> > > 2) The process gets killed or quits
> > > 3) As the process gets torn down, it closes the device node
> > > 4) Closing the device node results in the driver removing the device and
> > >     calling offline_and_remove_memory()
> > > 
> > > So it's not a "tear down process" that triggers that offlining_removal
> > > somehow explicitly, it's just a side-product of it letting go of the device
> > > node as the process gets torn down.
> > 
> > Isn't that just fragile? The operation might fail for other reasons. Why
> > cannot there be a hold on the resource to control the tear down
> > explicitly?
> 
> I'll let John comment on that. But from what I understood, in most setups
> where ZONE_MOVABLE gets used for hotplugged memory
> offline_and_remove_memory() succeeds and allows for reusing the device later
> without a reboot.
> 
> For the cases where it doesn't work, a reboot is required.

Then the solution should be really robust and means to handle the
failure - e.g. by retrying or alerting the admin.

> > > > > Especially with ZONE_MOVABLE, offlining is supposed to work in most
> > > > > cases when offlining actually hotplugged (not boot) memory, and only fail
> > > > > in rare corner cases (e.g., some driver holds a reference to a page in
> > > > > ZONE_MOVABLE, turning it unmovable).
> > > > > 
> > > > > In these corner cases we really don't want to be stuck forever in
> > > > > offline_and_remove_memory(). But in the general cases, we really want to
> > > > > do our best to make memory offlining succeed -- in a reasonable
> > > > > timeframe.
> > > > > 
> > > > > Reliably failing in the described case when there is a fatal signal pending
> > > > > is sub-optimal. The pending signal check is mostly only relevant when user
> > > > > space explicitly triggers offlining of memory using sysfs device attributes
> > > > > ("state" or "online" attribute), but not when coming via
> > > > > offline_and_remove_memory().
> > > > > 
> > > > > So let's use a timer instead and ignore fatal signals, because they are
> > > > > not really expressive for offline_and_remove_memory() users. Let's default
> > > > > to 30 seconds if no timeout was specified, and limit the timeout to 120
> > > > > seconds.
> > > > 
> > > > I really hate having timeouts back. They just proven to be hard to get
> > > > right and it is essentially a policy implemented in the kernel. They
> > > > simply do not belong to the kernel space IMHO.
> > > 
> > > As much as I agree with you in terms of offlining triggered from user space
> > > (e.g., write "state" or "online" attribute) where user-space is actually in
> > > charge  and can do something reasonable (timeout, retry, whatever), in these
> > > the offline_and_remove_memory() case it's the driver that wants a
> > > best-effort memory offlining+removal.
> > > 
> > > If it times out, virtio-mem will simply try another block or retry later.
> > > Right now, it could get stuck forever in offline_and_remove_memory(), which
> > > is obviously "not great". Fortunately, for virtio-mem it's configurable and
> > > we use the alloc_contig_range()-method for now as default.
> > 
> > It seems that offline_and_remove_memory is using a wrong operation then.
> > If it wants an opportunistic offlining with some sort of policy. Timeout
> > might be just one policy to use but failure mode or a retry count might
> > be a better fit for some users. So rather than (ab)using offline_pages,
> > would be make more sense to extract basic offlining steps and allow
> > drivers like virtio-mem to reuse them and define their own policy?
> 
> virtio-mem, in default operation, does that: use alloc_contig_range() to
> logically unplug ("fake offline") that memory and then just trigger
> offline_and_remove_memory() to make it "officially offline".
> 
> In that mode, offline_and_remove_memory() cannot really timeout and is
> almost always going to succeed (except memory notifiers and some hugetlb
> dissolving).
> 
> Right now we also allow the admin to configure ordinary offlining directly
> (without prior fake offlining) when bigger memory blocks are used:
> offline_pages() is more reliable than alloc_contig_range(), for example,
> because it disables the PCP and the LRU cache, and retries more often (well,
> unfortunately then also forever). It has a higher chance of succeeding
> especially when bigger blocks of memory are offlined+removed.
> 
> Maybe we should make the alloc_contig_range()-based mechanism more
> configurable and make it the only mode in virtio-mem, such that we don't
> have to mess with offline_and_remove_memory() endless loops -- at least for
> virtio-mem.

Yes, that sounds better than hooking up into offline_pages the way this
patch is doing.
-- 
Michal Hocko
SUSE Labs
