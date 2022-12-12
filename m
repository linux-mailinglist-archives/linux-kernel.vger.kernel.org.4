Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C59649A09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiLLIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLLIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:33:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1596151
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:33:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D743D1F74B;
        Mon, 12 Dec 2022 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670833990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymKZqP1c6WxsFQS5L8oDn8Yq7hgbymKbzYBfiypA42A=;
        b=Baig3r76sbYdj38a1CQsrobnwZmdYo2IEGoOrYYtsmkK5ywcdqKs/YLUHAs5YdJp+cpLj0
        UnLHfdQkp7OYKUQl2ePDJpmJ0/vS1AHsLIrfbI8XwND4bbeQdb4u703cDPCgShhciiZGUO
        do1KrDMD5VfhyzmPUIIEpEbqRHsbJIE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9865138F3;
        Mon, 12 Dec 2022 08:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 79jyKkbnlmN6DAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 12 Dec 2022 08:33:10 +0000
Date:   Mon, 12 Dec 2022 09:33:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
Message-ID: <Y5bnRtJ6sojtjgVD@dhcp22.suse.cz>
References: <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
 <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz>
 <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz>
 <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
 <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz>
 <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
 <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
 <CAHS8izPxMJzy_Axixkydvsw0ODHz9R7XU6WAtGJKZuMH0i=ANA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPxMJzy_Axixkydvsw0ODHz9R7XU6WAtGJKZuMH0i=ANA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-12-22 13:39:44, Mina Almasry wrote:
> On Fri, Dec 9, 2022 at 1:16 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 09-12-22 08:41:47, Wei Xu wrote:
> > > On Fri, Dec 9, 2022 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 08-12-22 16:59:36, Wei Xu wrote:
> > > > [...]
> > > > > > What I really mean is to add demotion nodes to the nodemask along with
> > > > > > the set of nodes you want to reclaim from. To me that sounds like a
> > > > > > more natural interface allowing for all sorts of usecases:
> > > > > > - free up demotion targets (only specify demotion nodes in the mask)
> > > > > > - control where to demote (e.g. select specific demotion target(s))
> > > > > > - do not demote at all (skip demotion nodes from the node mask)
> > > > >
> > > > > For clarification, do you mean to add another argument (e.g.
> > > > > demotion_nodes) in addition to the "nodes" argument?
> > > >
> > > > No, nodes=mask argument should control the domain where the memory
> > > > reclaim should happen. That includes both aging and the reclaim. If the
> > > > mask doesn't contain any lower tier node then no demotion will happen.
> > > > If only a subset of lower tiers are specified then only those could be
> > > > used for the demotion process. Or put it otherwise, the nodemask is not
> > > > only used to filter out zonelists during reclaim it also restricts
> > > > migration targets.
> > > >
> > > > Is this more clear now?
> > >
> 
> I think putting the demotion sources and demotion targets in the same
> nodemask is a bit confusing, and prone to error. IIUC the user puts
> both the demotion source and the demotion target in the nodemaks, and
> the kernel infers which is which depending on whether the node is a
> top-tier node, or a bottom tier node.

The level of the tier is not really all that important. All you request
from the userspace is to free up some charges based on aging (it is a
reclaim interface). The specified nodemask doesn't and cannot really
tell anything about how that is achieved because that is an internal
implementation detail. The nodemask extension defines a domain where
that aging and reclaim should happen. Treating demotion special and
assuming a certain behavior is a free ticket to future headaches.

> I think in the future this will
> become ambiguous. What happens in the future when the user when the
> machine has N memory tiers and the user specifies a node in a middle
> tier in the nodemask? Does that mean the user wants demotion from or
> to this node? Middle memory tiers can act as both...

It's really very simple. The memory reclaim (both aging and actual
eviction) is bound to the given nodemask. Full stop. See how that
doesn't say anything about demotion? It simply is not important.

Say you have a multi-layer system with nodes 0-3 with RAM, 4, 5 with
tier 1 and nodes 6, 7 as a second tier with the following topology.
RAM nodes can demote to any lower tiers. Node 4 can demote to 6 and node
5 to node 7. Now say you want to release some memory from node 2 and 3
to release some memory from there also globally yet node 5 should be
avoided for whatever reason. If you reclaim with nodemask=2,3,4,6 will
achieve exactly that without any ambiguity. Each node in the node mask
will get aged and demotion targets will be filtered based on the
nodemask as well so you cannot really end up aging (and demoting from)
nodes 5, 7 even if they are part of the demotion path. This is simply
impossible if the demotion target is implicit and it can live outside of
the provided nodemask. Are you on the same page that this would be
problematic?

> I think if your goal is to constrain demotion targets then a much more
> clear and future proof way is to simply add a second arg to
> memory.reclaim "allowed_demotion_targets=".\

That would be an option as well but what is the exact semantic? Do you
control the demotion path as well?

> > > In that case, how can we request demotion only from toptier nodes
> > > (without counting any reclaimed bytes from other nodes),  which is our
> > > memory tiering use case?
> >
> > I am not sure I follow. Could you be more specific please?
> >
> > > Besides, when both toptier and demotion nodes are specified, the
> > > demoted pages should only be counted as aging and not be counted
> > > towards the requested bytes of try_to_free_mem_cgroup_pages(), which
> > > is what this patch tries to address.
> >
> > This should be addressed by
> > http://lkml.kernel.org/r/Y5B1K5zAE0PkjFZx@dhcp22.suse.cz, no?
> 
> I think I provided a test case in [1] showing very clearly that this
> breaks one of our use cases, i.e. the use case where the user is
> asking to demote X bytes from the top tier nodes to the lower tier
> nodes.

Are you referring to EAGAIN situation as a result of the nr_reclaimed
patch? Please note that the patch was untested and likely incomplete.
Also really slightly independent on the actual nodemask reclaim
extension. Btw. based on these discussions I have to retract my ack and
reopen the discussion (will follow up on the original email thread). The
current semantic is really concerning.

-- 
Michal Hocko
SUSE Labs
