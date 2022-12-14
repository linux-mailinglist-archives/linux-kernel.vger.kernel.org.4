Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219DF64C62D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiLNJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiLNJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:43:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422362DF5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:42:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2D51FE02;
        Wed, 14 Dec 2022 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671010977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JnGr6T5PzN4rqLE7A7I6Y8MT8u+Eib8ilOJAxivRgLo=;
        b=fB8E77QfidvkfB9OguZfZuOlxxS0DRG0or8DxVTOWL9KJDA0ab/7eRBHC+q0blP0F0Iozi
        rKeowTne1CI4Gss+GSgZHMZVEYGU5f2mT7qwkqUj9Xk9EE4TqCa4mxrNIqDqQQnYF0/F/9
        0vZgkPx4bE4a+ihpWkmaCynrsqtc9kE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB4AD138F6;
        Wed, 14 Dec 2022 09:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ptpBNKCamWMOCAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 14 Dec 2022 09:42:56 +0000
Date:   Wed, 14 Dec 2022 10:42:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <Y5ik+CCmvapf87Mb@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ik+CCmvapf87Mb@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-12-22 17:14:48, Johannes Weiner wrote:
> On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
> > Hi,
> > I have just noticed that that pages allocated for demotion targets
> > includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
> > since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
> > pages during reclaim"). I suspect the intention is to trigger the aging
> > on the fallback node and either drop or further demote oldest pages.
> > 
> > This makes sense but I suspect that this wasn't intended also for
> > memcg triggered reclaim. This would mean that a memory pressure in one
> > hierarchy could trigger paging out pages of a different hierarchy if the
> > demotion target is close to full.
> 
> This is also true if you don't do demotion. If a cgroup tries to
> allocate memory on a full node (i.e. mbind()), it may wake kswapd or
> enter global reclaim directly which may push out the memory of other
> cgroups, regardless of the respective cgroup limits.

You are right on this. But this is describing a slightly different
situaton IMO. 

> The demotion allocations don't strike me as any different. They're
> just allocations on behalf of a cgroup. I would expect them to wake
> kswapd and reclaim physical memory as needed.

I am not sure this is an expected behavior. Consider the currently
discussed memory.demote interface when the userspace can trigger
(almost) arbitrary demotions. This can deplete fallback nodes without
over-committing the memory overall yet push out demoted memory from
other workloads. From the user POV it would look like a reclaim while
the overall memory is far from depleted so it would be considered as
premature and a warrant a bug report.

The reclaim behavior would make more sense to me if it was constrained
to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
disrupted.

-- 
Michal Hocko
SUSE Labs
