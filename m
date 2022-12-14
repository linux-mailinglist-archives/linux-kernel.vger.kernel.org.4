Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723A64CD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiLNP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiLNP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:29:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F501CF4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:29:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A2741FFB7;
        Wed, 14 Dec 2022 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671031747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LG6ZHgFYvH90THRUlEz2EYrd8tP4kMTH11ZSn8JkFY=;
        b=DtvP92dYRt6MN8BFZc/r30voZzeBvWaYParpA22Tgk3+IqVrEYkQkGysuRd1/9kkkwYEoN
        gKAuW/wyurfZ3C55toC9/x+YobgixgAvDmKeWIKmNUMJL2insHddkfZXFP9VCgNBz2xj4+
        PrwsOkLyvm3wGgdGwLBl79NJhhziuZU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C46A1333E;
        Wed, 14 Dec 2022 15:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fVtlEMPrmWOtSQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 14 Dec 2022 15:29:07 +0000
Date:   Wed, 14 Dec 2022 16:29:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5nrwrP0twm9IIDl@dhcp22.suse.cz>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <Y5ik+CCmvapf87Mb@cmpxchg.org>
 <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
 <Y5nEQeXj6HQBEHEY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5nEQeXj6HQBEHEY@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-12-22 13:40:33, Johannes Weiner wrote:
> On Wed, Dec 14, 2022 at 10:42:56AM +0100, Michal Hocko wrote:
[...]
> > The reclaim behavior would make more sense to me if it was constrained
> > to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
> > disrupted.
> 
> What if the second tier is full, and the memcg you're trying to demote
> doesn't have any pages to vacate on that tier yet? Will it fail to
> demote?
> 
> Does that mean that a shared second tier node is only usable for the
> cgroup that demotes to it first? And demotion stops for everybody else
> until that cgroup vacates the node voluntarily?
> 
> As you can see, these would be unprecedented and quite surprising
> first-come-first-serve memory protection semantics.

This is a very good example!

> The only way to prevent cgroups from disrupting each other on NUMA
> nodes is NUMA constraints. Cgroup per-node limits. That shields not
> only from demotion, but also from DoS-mbinding, or aggressive
> promotion. All of these can result in some form of premature
> reclaim/demotion, proactive demotion isn't special in that way.

Any numa based balancing is a real challenge with memcg semantic. I do
not see per numa node memcg limits without a major overhaul of how we do
charging though. I am not sure this is on the table even long term.
Unless I am really missing something here we have to live with the
existing semantic for a foreseeable future.
 
> The default behavior for cgroups is that without limits or
> protections, resource access is unconstrained and competitive. Without
> NUMA constraints, it's very much expected that cgroups compete over
> nodes, and that the hottest pages win out. Per aging rules, freshly
> demoted pages are hotter than anything else on the target node, so it
> should displace accordingly.

That is certainly a way to look at it but I would really emphasise
that this competition depends quite significantly on a higher level
balancing on top. Memory allocations fall back to different nodes so the
resource distribution should be roughly even in this case. If there is a
competition then it most likely means our resources are overcommitted.

The picture is slightly different with the demotion for memory tiering
IMHO because that spills an internal resource contention or explicit
user space balancing (via pro-active reclaim/demotion) outside because
it creates pressure on the demotion target that is a shared resource as
you have mentioned above.
 
> Consider the case where you have two lower tier nodes and there are
> cpuset isolation for the main workloads, but some maintenance thing
> runs and pollutes one of the lower tier nodes.

Well, this is not really much different from regular NUMA system where
node aware and constrained workloads compete with NUMA unconstrained
workloads. This has never worked.

> Or consider the case
> where a shared lower tier node is divvied up between two cgroups using
> protection settings to allow overcommit, i.e. per-node memory.low.
 
> Demotions, proactive or not, MUST do global reclaim on a full node.

OK, but my concern is how to implement any usersoace policy around that
behavior. If you see demotion failures then you can trigger some
rebalancing explicitly. If those are silent then your only option left
is to check the capacity of the demotion target regularly and play a
catch up game. Is this sufficient?

All that being said, I can see that both approaches result in some
corner cases. I do agree that a starvation is likely easier scenario
than an actively evil container disrupting another container by pushing
its demoted pages out. 

So scratch the patch.

Thanks
-- 
Michal Hocko
SUSE Labs
