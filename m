Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBE64D7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:22:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A92D1F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:22:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so2215224wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9/7t+tat4EemCr//boC7wbCJ7YhkoD/mqd5kzz+IFs=;
        b=oHf8JRexe86kqz1atzpIPnL/2pUtvk4jhtDCAgaRAUrGWKixHyeVVUQxPXzCSDHGGt
         XkuKOuKXIq7ryB2bjb7jzTtvH1z29vQ6Rq9znUw3LWxUG4a7ZLZG/zTmi095SAEq7ooG
         TtDoU/NKMDMWnhnJzJguKQSl4GaTPkH3+M/J96Y+XPjv2d5rkuKQbyGDPGTl7SR5EVee
         9MYdz9q5EgZMnvNAU2rsNNAOhu6+CiaUQU8Sn/YqzHzdVqCZfUe8iakKhLCs/F9cwakb
         DeI4ZUjOKtsIvWLGRsk3ivSzLLduGA7P2+dPB/tODrIpu2Uf+Q391O6WEVcOgM40hPmc
         N3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9/7t+tat4EemCr//boC7wbCJ7YhkoD/mqd5kzz+IFs=;
        b=YYnC60iDk/23S3xKMxd3yRX3YDUbJEHHpaywfLdhOGUrbmsyaSIidxJpO479Fs0mmt
         ZZUd4nFRHi4oBtksK4CRMSkec3ffpH5fXxavlOugkSbujkc034BKZkM1ulfeDl//jUth
         ScFHIfAxU8RFEWMqsA9t63r9Y2zueWH9EerXMexcnwf9HaHx3PgFrUApnTdWsuzfvKKr
         n8Q92c9sPD5Q2F6lzhVRsTarjooRHfonxZbLgV7xn3r+17cPwc7Ne0ajXA33bsApqRRj
         2OR9d/eFYOpqpcXQZaPSJ7Mxu/SpeSCP7tQBXiKM7au7M3f+s9hY5b82GPEEB7VAfkiM
         7c2g==
X-Gm-Message-State: ANoB5pkonqLapSWKsIO7QFL4t7apT9QbVpfauavNwcIMjVg+mldblvRB
        GE3OlwzMaH02qANhu+Pk4FVfuw==
X-Google-Smtp-Source: AA0mqf4a90zrVSQ9gSsZg5oNVHYqQGV57b1QY3NSapHU26qgkrqjbJodGKu5joLMQDrvnHSvFD7C5g==
X-Received: by 2002:a05:6000:5c5:b0:242:63a3:2f20 with SMTP id bh5-20020a05600005c500b0024263a32f20mr24767004wrb.11.1671092555206;
        Thu, 15 Dec 2022 00:22:35 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4bd2000000b00236488f62d6sm5162332wrt.79.2022.12.15.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:22:34 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:22:33 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5rZSRxcgQzQQVbS@cmpxchg.org>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <Y5ik+CCmvapf87Mb@cmpxchg.org>
 <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
 <87edt1dwd2.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edt1dwd2.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 02:17:13PM +0800, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Tue 13-12-22 17:14:48, Johannes Weiner wrote:
> >> On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
> >> > Hi,
> >> > I have just noticed that that pages allocated for demotion targets
> >> > includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
> >> > since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
> >> > pages during reclaim"). I suspect the intention is to trigger the aging
> >> > on the fallback node and either drop or further demote oldest pages.
> >> > 
> >> > This makes sense but I suspect that this wasn't intended also for
> >> > memcg triggered reclaim. This would mean that a memory pressure in one
> >> > hierarchy could trigger paging out pages of a different hierarchy if the
> >> > demotion target is close to full.
> >> 
> >> This is also true if you don't do demotion. If a cgroup tries to
> >> allocate memory on a full node (i.e. mbind()), it may wake kswapd or
> >> enter global reclaim directly which may push out the memory of other
> >> cgroups, regardless of the respective cgroup limits.
> >
> > You are right on this. But this is describing a slightly different
> > situaton IMO. 
> >
> >> The demotion allocations don't strike me as any different. They're
> >> just allocations on behalf of a cgroup. I would expect them to wake
> >> kswapd and reclaim physical memory as needed.
> >
> > I am not sure this is an expected behavior. Consider the currently
> > discussed memory.demote interface when the userspace can trigger
> > (almost) arbitrary demotions. This can deplete fallback nodes without
> > over-committing the memory overall yet push out demoted memory from
> > other workloads. From the user POV it would look like a reclaim while
> > the overall memory is far from depleted so it would be considered as
> > premature and a warrant a bug report.
> >
> > The reclaim behavior would make more sense to me if it was constrained
> > to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
> > disrupted.
> 
> When we reclaim/demote some pages from a memcg proactively, what is our
> goal?  To free up some memory in this memcg for other memcgs to use?  If
> so, it sounds reasonable to keep the pages of other memcgs as many as
> possible.

The goal of proactive aging is to free up any resources that aren't
needed to meet the SLAs (e.g. end-to-end response time of webserver).
Meaning, to run things as leanly as possible within spec. Into that
free space, another container can then be co-located.

This means that the goal is to free up as many resources as possible,
starting with the coveted hightier. If a container has been using
all-hightier memory but is able demote to lowtier, there are 3 options
for existing memory in the lower tier:

1) Colder/stale memory - should be displaced

2) Memory that can be promoted once the hightier is free -
   reclaim/demotion of the coldest pages needs to happen at least
   temporarily, or the tierswap is in stale mate.

3) Equally hot memory - if this exceeds capacity of the lower tier,
   the hottest overall pages should stay, the excess demoted/reclaimed.

You can't know what scenario you're in until you put the demoted pages
in direct LRU competition with what's already there. And in all three
scenarios, direct LRU competition also produces the optimal outcome.
