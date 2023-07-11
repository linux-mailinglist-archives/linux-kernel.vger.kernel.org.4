Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72874EC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGKLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:19:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F911D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:19:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1160D1FE81;
        Tue, 11 Jul 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689074387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGMYxsXzKbG1bvPGCq5W+EjH0inuuCTmPCtfSounG5c=;
        b=ifBDuDlyABFVdELO5yxYSfjgZ01Dcbl6cnUClS7O0OEnWo0wZdgqkmnkVUpqfs/ec4Pflt
        nMS8J3nsSPANHIwe9Q1Uguv2zCRiibkYhW17TzXVtJLuHusfprOztkIrnemvP5ER4igTUE
        CVyLaQpqAHsFLdgrrfAdqLYdqRY2JwA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2A471390F;
        Tue, 11 Jul 2023 11:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cghzNNI6rWRGGAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Jul 2023 11:19:46 +0000
Date:   Tue, 11 Jul 2023 13:19:46 +0200
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
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Message-ID: <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710065325.290366-3-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-07-23 14:53:25, Huang Ying wrote:
> To auto-tune PCP high for each CPU automatically, an
> allocation/freeing depth based PCP high auto-tuning algorithm is
> implemented in this patch.
> 
> The basic idea behind the algorithm is to detect the repetitive
> allocation and freeing pattern with short enough period (about 1
> second).  The period needs to be short to respond to allocation and
> freeing pattern changes quickly and control the memory wasted by
> unnecessary caching.

1s is an ethernity from the allocation POV. Is a time based sampling
really a good choice? I would have expected a natural allocation/freeing
feedback mechanism. I.e. double the batch size when the batch is
consumed and it requires to be refilled and shrink it under memory
pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
high over batch (e.g. twice as much).  Have you considered something as
simple as that?
Quite honestly I am not sure time based approach is a good choice
because memory consumptions tends to be quite bulky (e.g. application
starts or workload transitions based on requests).
 
> To detect the repetitive allocation and freeing pattern, the
> alloc/free depth is calculated for each tuning period (1 second) on
> each CPU.  To calculate the alloc/free depth, we track the alloc
> count.  Which increases for page allocation from PCP and decreases for
> page freeing to PCP.  The alloc depth is the maximum alloc count
> difference between the later large value and former small value.
> While, the free depth is the maximum alloc count difference between
> the former large value and the later small value.
> 
> Then, the average alloc/free depth in multiple tuning periods is
> calculated, with the old alloc/free depth decay in the average
> gradually.
> 
> Finally, the PCP high is set to be the smaller value of average alloc
> depth and average free depth, after clamped between the default and
> the max PCP high.  In this way, pure allocation or freeing will not
> enlarge the PCP high because PCP doesn't help.
> 
> We have tested the algorithm with several workloads on Intel's
> 2-socket server machines.

How does this scheme deal with memory pressure?

-- 
Michal Hocko
SUSE Labs
