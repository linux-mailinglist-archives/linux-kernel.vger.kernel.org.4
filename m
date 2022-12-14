Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206764C933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiLNMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiLNMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:42:24 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE31EA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:40:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so44192510ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1xhBzpDoBPavmG4HUeBFEFL1GXCLdg20tEeRb+nhZE=;
        b=hPdCW45Imw+etSsnMztT0eq0wgnMv1RHYJPFB3G3fTMGsVF/RjcwDuJJlO2Rg1+iVY
         SmfwUEQAoxqJ4/G6OV+1V4ZjkvJADA1slFCIw7WahEiUEHRtfEWtZpVL3CkTSWw6Ey3y
         hZUHcNJymx+J3cZvnfnWmHdLLlXsKA9Sf6Ns3QzFnwufSLBDj+VJZiqAhQxdfIy2HoFA
         J3/Qr5U4mjB2f11TKpyoGVTg6SJg/lfiaS6nb8DbITTgt4frVYW1/cVxwNaRWzBAsv8n
         sD9Oc5SlxghQXqHdME/65WZLp852Z4cd1V9/9MxypUZs9vMu4Vlz94pVyPYnWLTvsvzA
         ujZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1xhBzpDoBPavmG4HUeBFEFL1GXCLdg20tEeRb+nhZE=;
        b=Q8CfqSM4CAYIlNBH5ffnGKcMqaBe3UNsH9euDW8balL5UHOUGFg3ZXABCsrP9vISJx
         glTBos6st2Xv+9+aRAHwls2W4IHVcLgNPiRRyc/0V6GjUJFt9p1QmwAbF0SF3hWnXrEJ
         Bz4rM83shKGK62ln1abtJwOtccSGemaUlzRIGy/rE4S71XWBAtGsjpjHU+AMedicPCc1
         +E0CKNP0XlhuN7lZdjXCVLjqm/RhBmyq9ISOrjRzcVryr20PEauCEWf3n0LyWwyQiGbP
         il0S1QI3/+KJwB8uyv3oovaYE32KeeUKTP0CaFlgJhiPIIfzVpbd3sq6toOLBvjbsva5
         9bJw==
X-Gm-Message-State: ANoB5pntwJzWAD5FTk7TlCuOLYVEmqPVTki35mktGtFV4ACtfDMaD/oP
        7o1L4V4vvccdLfZ9DatcaZFg8A==
X-Google-Smtp-Source: AA0mqf6BSY63Rg2Sgvtvd1MMLbdz7V4US4tlxmtn3trGpirP5EV4S/iHOmyfp6egzbvk7BQ6DIT5cA==
X-Received: by 2002:a17:906:4b53:b0:7c1:4d21:abb9 with SMTP id j19-20020a1709064b5300b007c14d21abb9mr15468514ejv.14.1671021634452;
        Wed, 14 Dec 2022 04:40:34 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id la1-20020a170907780100b007c073be0127sm5653253ejc.202.2022.12.14.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:40:34 -0800 (PST)
Date:   Wed, 14 Dec 2022 13:40:33 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5nEQeXj6HQBEHEY@cmpxchg.org>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <Y5ik+CCmvapf87Mb@cmpxchg.org>
 <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:42:56AM +0100, Michal Hocko wrote:
> On Tue 13-12-22 17:14:48, Johannes Weiner wrote:
> > On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
> > > Hi,
> > > I have just noticed that that pages allocated for demotion targets
> > > includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
> > > since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
> > > pages during reclaim"). I suspect the intention is to trigger the aging
> > > on the fallback node and either drop or further demote oldest pages.
> > > 
> > > This makes sense but I suspect that this wasn't intended also for
> > > memcg triggered reclaim. This would mean that a memory pressure in one
> > > hierarchy could trigger paging out pages of a different hierarchy if the
> > > demotion target is close to full.
> > 
> > This is also true if you don't do demotion. If a cgroup tries to
> > allocate memory on a full node (i.e. mbind()), it may wake kswapd or
> > enter global reclaim directly which may push out the memory of other
> > cgroups, regardless of the respective cgroup limits.
> 
> You are right on this. But this is describing a slightly different
> situaton IMO. 
> 
> > The demotion allocations don't strike me as any different. They're
> > just allocations on behalf of a cgroup. I would expect them to wake
> > kswapd and reclaim physical memory as needed.
> 
> I am not sure this is an expected behavior. Consider the currently
> discussed memory.demote interface when the userspace can trigger
> (almost) arbitrary demotions. This can deplete fallback nodes without
> over-committing the memory overall yet push out demoted memory from
> other workloads. From the user POV it would look like a reclaim while
> the overall memory is far from depleted so it would be considered as
> premature and a warrant a bug report.
> 
> The reclaim behavior would make more sense to me if it was constrained
> to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
> disrupted.

What if the second tier is full, and the memcg you're trying to demote
doesn't have any pages to vacate on that tier yet? Will it fail to
demote?

Does that mean that a shared second tier node is only usable for the
cgroup that demotes to it first? And demotion stops for everybody else
until that cgroup vacates the node voluntarily?

As you can see, these would be unprecedented and quite surprising
first-come-first-serve memory protection semantics.

The only way to prevent cgroups from disrupting each other on NUMA
nodes is NUMA constraints. Cgroup per-node limits. That shields not
only from demotion, but also from DoS-mbinding, or aggressive
promotion. All of these can result in some form of premature
reclaim/demotion, proactive demotion isn't special in that way.

The default behavior for cgroups is that without limits or
protections, resource access is unconstrained and competitive. Without
NUMA constraints, it's very much expected that cgroups compete over
nodes, and that the hottest pages win out. Per aging rules, freshly
demoted pages are hotter than anything else on the target node, so it
should displace accordingly.

Consider the case where you have two lower tier nodes and there are
cpuset isolation for the main workloads, but some maintenance thing
runs and pollutes one of the lower tier nodes. Or consider the case
where a shared lower tier node is divvied up between two cgroups using
protection settings to allow overcommit, i.e. per-node memory.low.

Demotions, proactive or not, MUST do global reclaim on a full node.
