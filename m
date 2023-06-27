Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A573FD62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjF0OIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjF0OIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:08:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A92D74
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:07:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A640D21879;
        Tue, 27 Jun 2023 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687874877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBC5UUGh3VEiZboYTQt2cf9WM4R2vDB6pRbxEBOAkwA=;
        b=dDkMUZkCGy/tTbNnMaQCTLt+sZvlsUVJivYrdBTv2kH1L1m8gzVQUJGAyn3vtH26t4lAST
        IiAHkfBqor2V6eRq4HsSvAnJqrSBCMO+m4JKc386iab1tW/0T2TFlzDkkJVNzH8lSLc7+M
        L7SaICltqU2kLhjmlMEOQ5Yj7FwgFSA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8623C13462;
        Tue, 27 Jun 2023 14:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PprMCD3tmmT3AQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 27 Jun 2023 14:07:57 +0000
Date:   Tue, 27 Jun 2023 16:07:55 +0200
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
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only
 in offline_pages()
Message-ID: <ZJrtO105xKpzbR9g@dhcp22.suse.cz>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-2-david@redhat.com>
 <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
 <d44b7a42-f89d-5bd5-9f29-e8643f6ee17d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44b7a42-f89d-5bd5-9f29-e8643f6ee17d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-06-23 15:28:29, David Hildenbrand wrote:
> On 27.06.23 14:34, Michal Hocko wrote:
> > On Tue 27-06-23 13:22:16, David Hildenbrand wrote:
> > > Let's check for fatal signals only. That looks cleaner and still keeps
> > > the documented use case for manual user-space triggered memory offlining
> > > working. From Documentation/admin-guide/mm/memory-hotplug.rst:
> > > 
> > > 	% timeout $TIMEOUT offline_block | failure_handling
> > > 
> > > In fact, we even document there: "the offlining context can be terminated
> > > by sending a fatal signal".
> > 
> > We should be fixing documentation instead. This could break users who do
> > have a SIGALRM signal hander installed.
> 
> You mean because timeout will send a SIGALRM, which is not considered fatal
> in case a signal handler is installed?

Correct.

> At least the "traditional" tools I am aware of don't set a timeout at all
> (crossing fingers that they never end up stuck):
> * chmem
> * QEMU guest agent
> * powerpc-utils
> 
> libdaxctl also doesn't seem to implement an easy-to-spot timeout for memory
> offlining, but it also doesn't configure SIGALRM.
> 
> 
> Of course, that doesn't mean that there isn't somewhere a program that does
> that; I merely assume that it would be pretty unlikely to find such a
> program.
> 
> But no strong opinion: we can also keep it like that, update the doc and add
> a comment why this one here is different than most other signal backoff
> checks.

Well, the existing signal handling approach is there for way too long to
be sure. I personally would prefer fatal_signal_pending as that reflects
more what we do elsewhere but here we are. Historical baggage...
-- 
Michal Hocko
SUSE Labs
