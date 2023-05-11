Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15226FF567
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjEKPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEKPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:05:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921AE7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:05:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6262721D9A;
        Thu, 11 May 2023 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683817554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNWze48V6JBTc+Hd2zEHP1xFisIRIn+nKrZWWVUxuYM=;
        b=NMFmJVzuyE7uLEcxwRMv3NkqS9gNs9ykrysnIVK4bhceKDV91FcmSKnbOeGbrf9TXgGdj0
        85Bk+it2j38zsoMIe737vRUpWWCBnYACF7ZyBpd1r4oNPQ+ws4xCylYRTg1k+WMr5iKz9C
        FAVPL0UH2gOpsV7bTfEQ4yiC4UzCD4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF164138FA;
        Thu, 11 May 2023 15:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YZX4KVEEXWRIYQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 May 2023 15:05:53 +0000
Date:   Thu, 11 May 2023 17:05:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Message-ID: <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
References: <20230511065607.37407-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511065607.37407-1-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-05-23 14:56:01, Huang Ying wrote:
> The patchset is based on upstream v6.3.
> 
> More and more cores are put in one physical CPU (usually one NUMA node
> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
> Even more cores per physical CPU are planned for future CPUs.  While
> all cores in one physical CPU will contend for the page allocation on
> one zone in most cases.  This causes heavy zone lock contention in
> some workloads.  And the situation will become worse and worse in the
> future.
> 
> For example, on an 2-socket Intel server machine with 224 logical
> CPUs, if the kernel is built with `make -j224`, the zone lock
> contention cycles% can reach up to about 12.7%.
> 
> To improve the scalability of the page allocation, in this series, we
> will create one zone instance for each about 256 GB memory of a zone
> type generally.  That is, one large zone type will be split into
> multiple zone instances.  Then, different logical CPUs will prefer
> different zone instances based on the logical CPU No.  So the total
> number of logical CPUs contend on one zone will be reduced.  Thus the
> scalability is improved.

It is not really clear to me why you need a new zone for all this rather
than partition free lists internally within the zone? Essentially to
increase the current two level system to 3: per cpu caches, per cpu
arenas and global fallback.

I am also missing some information why pcp caches tunning is not
sufficient.
-- 
Michal Hocko
SUSE Labs
