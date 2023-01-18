Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589B672AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjARVrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjARVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:47:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A462D10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:47:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so487596plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffnkh4zmysw3vaXwpundCOoVmU47s9oaVyFRyCfZsPw=;
        b=Wvx839aSwuI8Akay3jFqTCUbMYQXrzZ0twFxcZq5OZMmj9QiJAOPRVAVOMjWKKm35l
         kYQwsTUdFRiyHa34M5GGH8p2Es5sWJkSb/YJ+zFs2d9xhPOw70ad6rhDPgA/0x27fJAy
         prg4jDTGDVpXsve/C416mYRvkZ0CBdgiy7BVkhTpXCWiCR2dd3sBCQCxpYIBEiClc6Ro
         lCic12AY4qkwZPcdfnJjJGfsjsF51eLXjp3OdIqGYC1ytCXM7G+ol4z2jDQI1SNCKGyn
         i3axNccfjuqK7hg9EC/kswxTbaW8WSiXY9Qa6MSmb4zCj0mmVWY0tN8SM4hl8/C5cgCt
         Xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffnkh4zmysw3vaXwpundCOoVmU47s9oaVyFRyCfZsPw=;
        b=j9RIM+HuJf5QBY2MO6htwDO8lo0O5AoikAHHymmsIIdInxqQlawgIAC+VXBdv+y/Kp
         oOi3jCAz/9IjdLLGe8u7nSUJnDF2VR5rx6Zk+G85nC0cCt6UWvwj+PQ2ePhOZlP10Ury
         n1k70bCtEMZ+xHvEbl5cuzNSK/7sInoyTRzUW6lPugK2VLkbKH+vzuh0On7rRloeytXO
         5Nw6QqPWFdoDKwbiXn/umK9Q+45vZaaJ18Nh1cJ17W3M0bFx7sPln+ex0ET/eAbWG/Kn
         SsT2yphOuXVgepaEUD9n0yh3ZF4mfoJJtvABdzcge7Ag0z5DdXsR4f+ncqq8FFXs1YR2
         dNEg==
X-Gm-Message-State: AFqh2kqnCUvzJzsdojrAv6jMS0uM90/EI8XqnTBuXnyEW+3l7A8Ui3Kf
        3XhmNgA1DlKUHAlRvN0c43I=
X-Google-Smtp-Source: AMrXdXtbammpm8G0MvFB4bDBkTD3IA1R85bI8AL2fRbXYU1sqOZuJn++nf29G1qR78M/rvPU6SGtBA==
X-Received: by 2002:a17:902:b091:b0:194:8261:8018 with SMTP id p17-20020a170902b09100b0019482618018mr8556580plr.64.1674078447265;
        Wed, 18 Jan 2023 13:47:27 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902a51300b001949b92f8a8sm5626063plq.279.2023.01.18.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:47:26 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 13:47:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8ho7PUOTyMe8ryX@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
 <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
 <Y8gpNgkwMqVPN7dm@google.com>
 <Y8gr5haAMtQJJSR6@dhcp22.suse.cz>
 <Y8gympFAnomQePGD@google.com>
 <Y8hhAslIzgNH3hzv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hhAslIzgNH3hzv@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:13:38PM +0100, Michal Hocko wrote:
> On Wed 18-01-23 09:55:38, Minchan Kim wrote:
> > On Wed, Jan 18, 2023 at 06:27:02PM +0100, Michal Hocko wrote:
> > > On Wed 18-01-23 09:15:34, Minchan Kim wrote:
> > > > On Wed, Jan 18, 2023 at 10:11:46AM +0100, Michal Hocko wrote:
> > > > > On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> > > > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > > > present pages at page table and provides advice hints for them.
> > > > > > 
> > > > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > > > shows the proactive reclaim efficiency so this patch addes those
> > > > > > two statistics in vmstat.
> > > > > 
> > > > > Please describe the usecase for those new counters.
> > > > 
> > > > I wanted to know the proactive reclaim efficieny using MADV_COLD/MDDV_PAGEOUT.
> > > > Userspace has several policy which when/which vmas need to be hinted by the call
> > > > and they are evolving. I needed to know how effectively their policy works since
> > > > the vma ranges are huge(i.e., nr_hinted/nr_scanned).
> > > 
> > > I can see how that can be an interesting information but is there
> > > anything actionable about that beyond debugging purposes? In other words
> > > isn't this something that could be done by tracing instead?
> > 
> > That's the statictis for telemetry. With those stat, we are collecting
> > various vmstat fields(i.e., pgsteal/pgscan) from real field devices
> > and thought those two stats would be good fit along with other reclaim
> > statistics in vmstat since we can know how much proactive madvise policy
> > could make system healthier(e.g., less kswapd scan, less allocstall
> > and so on).
> > 
> > > 
> > > Also how are you going to identify specific madvise calls when they can
> > > interleave arbitrarily?
> > 
> > I guess you are talking about how we could separate MADV_PAGEOUT and
> > MADV_COLD from vmstat. That's valid question. I thought for the start,
> > adds just umbrella stat like this and if we want to break down, we need
> > to introudce sysfs likewise slab. 
> 
> No, not really. MADV_COLD is about aging. There is no actual reclaim
> going on so pgscan/steal metrics do not make any sense. I am asking
> about potential different concurrent MADV_PAGEOUT happening. From what
> you've said earlier (how effectively policy works) I have understood you
> want to find out how a specific MADV_PAGEOUT effective is. But there

No, it 's not a specific MADV_PAGEOUT but system global policy.
Android has used the ActivityManagerService to control proactive
memory compaction from apps since it could control life of apps.
You can think it as userspace kswapd.

> maybe different callers of this applied to all sorts of different memory
> mappings and therefore the efficiency might be really different. As
> there is no clear way to tell one from the other I am really questioning
> whether this global stat is actually useful.

The purpose is global stat.
