Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3C67B9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjAYS5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjAYS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:57:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F31043F;
        Wed, 25 Jan 2023 10:57:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54C99B81B95;
        Wed, 25 Jan 2023 18:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E73DC433D2;
        Wed, 25 Jan 2023 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674673027;
        bh=st13cJxsleWr9ZGQyG0CvLVid1afNTC/Q/aI29/yE6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9iUhDWO1LkoWKK/9tMkgE1+y4bqcZmtnTF2kwqoyHRRJB02vVuEGGoxSCC4+ZKqY
         Yb/BjsMfTj/u41pueMR4JiSu0tKNTwSP8UwjGeXXoQSTZ/UE9sx4p0/WjxWWAA0+8j
         IXCQ3AqaYAPdJh6uPgMB/k2C/h4POGHNbHiMCmlBLt2KDPUtnl8DUhqNiBb2vpG9TM
         AHFv1tUQ6XKPugM4oU/NLD97zuBEF5i9Vx4LvPI1m2Ee4ugxf1Em7sdU24srXkx07V
         9d+UVqvfGamHn6Q0RUj3e+tEBfJiNWBlwdTVm3T9d7/bitY6eNKfON/UykP2SDNqC3
         pEXnw9IMTctnA==
Date:   Wed, 25 Jan 2023 20:56:52 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v4 1/1] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y9F7dOuvX3rBfcvr@kernel.org>
References: <20230115184212.996298-1-rppt@kernel.org>
 <20230115184212.996298-2-rppt@kernel.org>
 <bea284c3-fe7c-f55a-449d-07f47a364c1c@suse.cz>
 <Y8++BJcHgfzuoURl@kernel.org>
 <AC10188D-6728-478F-A95D-1A460958533A@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC10188D-6728-478F-A95D-1A460958533A@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:40:54PM +0100, Vlastimil Babka wrote:
> 
> 
> On January 24, 2023 12:16:20 PM GMT+01:00, Mike Rapoport <rppt@kernel.org> wrote:
> >On Tue, Jan 24, 2023 at 12:00:07PM +0100, Vlastimil Babka wrote:
> >> On 1/15/23 19:42, Mike Rapoport wrote:
> >> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >> > 
> >> > Add structure, introduction and Nodes section to Physical Memory
> >> > chapter.
> >> > 
> >> > As the new documentation references core-api/dma-api and mm/page_reclaim,
> >> > add page labels to those documents.
> >> > 
> >> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> >> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >> > Acked-by: Michal Hocko <mhocko@suse.com>
> >> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> >> 
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >> 
> >> A small bug to fix below?
> >> 
> >> <snip>
> >> 
> >> > +
> >> > +Along with the node structures, kernel maintains an array of ``nodemask_t``
> >> > +bitmasks called ``node_states``. Each bitmask in this array represents a set of
> >> > +nodes with particular properties as defined by ``enum node_states``:
> >> > +
> >> > +``N_POSSIBLE``
> >> > +  The node could become online at some point.
> >> > +``N_ONLINE``
> >> > +  The node is online.
> >> > +``N_NORMAL_MEMORY``
> >> > +  The node has regular memory.
> >> > +``N_HIGH_MEMORY``
> >> > +  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
> >> > +  aliased to ``N_NORMAL_MEMORY``.
> >> 
> >> Noted.
> >> 
> >> > +``N_MEMORY``
> >> > +  The node has memory(regular, high, movable)
> >> > +``N_CPU``
> >> > +  The node has one or more CPUs
> >> > +
> >> > +For each node that has a property described above, the bit corresponding to the
> >> > +node ID in the ``node_states[<property>]`` bitmask is set.
> >> > +
> >> > +For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
> >> > +
> >> > +  node_states[N_POSSIBLE]
> >> > +  node_states[N_ONLINE]
> >> > +  node_states[N_NORMAL_MEMORY]
> >> > +  node_states[N_MEMORY]
> >> > +  node_states[N_CPU]
> >> 
> >> Should it be set also in node_states[N_HIGH_MEMORY]?
> > 
> >You mean because of the aliasing of N_NORMAL_MEMORY and N_HIGH_MEMORY?
> 
> No I meant due to "The node has regular or high memory." Or do I misunderstand?

I checked the code, node_states[N_HIGH_MEMORY] will be set indeed.
Will send v5 soon.
