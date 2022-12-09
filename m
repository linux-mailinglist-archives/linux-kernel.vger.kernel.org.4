Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417B6489ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLIVQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:16:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9423E8B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:16:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4644205A2;
        Fri,  9 Dec 2022 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670620568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5KOnG0U3PKiJqceJhvbuDIcDatEOFXG6UTl/UXN4Oc=;
        b=cv06Go4lGtBq+ZOboQVPHKaqQt5NmZ3MiRJuSvs5xEM9egf/+87cT+53lST1PE7YXkvLhf
        wxsz3yanRR2P5fKPt+79LscZF8NgT8oNwhAklxwLa5hYPTUbqhReIP7tLxWh0z9cJFm6nM
        9/cdLD2iTkmRb1LbqTjbYT7fDJqCToo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2AAC138E0;
        Fri,  9 Dec 2022 21:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HBbDLJilk2PZPAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 09 Dec 2022 21:16:08 +0000
Date:   Fri, 9 Dec 2022 22:16:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
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
Message-ID: <Y5OlmLeDen1c/Nly@dhcp22.suse.cz>
References: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
 <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
 <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
 <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz>
 <CAHS8izMhRXMB5QJab5AvuHiWiQUAzUf81-7Y71ueEEnz71dwiQ@mail.gmail.com>
 <Y5HQgpRvPQWteNvz@dhcp22.suse.cz>
 <CAAPL-u_bEhCCCnepmCuNe7q7qJY3G3wckGvG-QsF2SYpAVXhEA@mail.gmail.com>
 <Y5LtEMYOXtUxsuqs@dhcp22.suse.cz>
 <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u8J_sgnAn1ev-cfZh428UOySxh1aYZUFKq1=dr-KrdTsw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-12-22 08:41:47, Wei Xu wrote:
> On Fri, Dec 9, 2022 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 08-12-22 16:59:36, Wei Xu wrote:
> > [...]
> > > > What I really mean is to add demotion nodes to the nodemask along with
> > > > the set of nodes you want to reclaim from. To me that sounds like a
> > > > more natural interface allowing for all sorts of usecases:
> > > > - free up demotion targets (only specify demotion nodes in the mask)
> > > > - control where to demote (e.g. select specific demotion target(s))
> > > > - do not demote at all (skip demotion nodes from the node mask)
> > >
> > > For clarification, do you mean to add another argument (e.g.
> > > demotion_nodes) in addition to the "nodes" argument?
> >
> > No, nodes=mask argument should control the domain where the memory
> > reclaim should happen. That includes both aging and the reclaim. If the
> > mask doesn't contain any lower tier node then no demotion will happen.
> > If only a subset of lower tiers are specified then only those could be
> > used for the demotion process. Or put it otherwise, the nodemask is not
> > only used to filter out zonelists during reclaim it also restricts
> > migration targets.
> >
> > Is this more clear now?
> 
> In that case, how can we request demotion only from toptier nodes
> (without counting any reclaimed bytes from other nodes),  which is our
> memory tiering use case?

I am not sure I follow. Could you be more specific please?

> Besides, when both toptier and demotion nodes are specified, the
> demoted pages should only be counted as aging and not be counted
> towards the requested bytes of try_to_free_mem_cgroup_pages(), which
> is what this patch tries to address.

This should be addressed by
http://lkml.kernel.org/r/Y5B1K5zAE0PkjFZx@dhcp22.suse.cz, no?
-- 
Michal Hocko
SUSE Labs
