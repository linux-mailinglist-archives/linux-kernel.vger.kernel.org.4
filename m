Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E668F9FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjBHWA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjBHWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:00:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337B298CC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:00:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id f6so558675pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fx0i8cxtjtRwzsSINFE91pP/WWK899fcc6eF3oZCP2A=;
        b=XFi5JdbhXqFD0z6v3p9TBIezSPPMnBzq+IpKkQ1PCztw001AQ6EMTF/zmdKiD1Oktn
         b/v6Vf1lclAMPE5dh55At030Ic9tso3/Y4e8VI2jbSvx6uV1rj2pz3OELwEe9R1dUD8q
         HqWJgNKVQxmDtzbTUq8VRHJmr3fZRz2QJBSti0Xt6BmBoy9SvbtQjoT30UakEP1gHH8L
         eMcAIkhdQx4KXZusdt/FQ8birkKqru4MvUZAb/7raiJcAxWIRjp+OuBVw/QNz2lfa93F
         JtAttgNGO8WjVKYuSSGB6qfqFNbZvcfqnV3yh4vsUoRi9919TOhPeLlmq0Re9f93M8h3
         6lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx0i8cxtjtRwzsSINFE91pP/WWK899fcc6eF3oZCP2A=;
        b=0USwxhCbfdJLcO7hK0eY5Rrs0Gxeu3vPRcy7qwMFnAcm4H+G1QKcChvfRypsHczjsU
         9rVA37KcdkDwOQ/Tb6OAiSpXU853wFEGkCLdIwb+35YJO9nkWvF73fnTLORz7z5yywSr
         RwLA/l+WdMa4wIRoFLfkb44fN/SMeCsI60N13DGpytt9oLIB+NCy559QXKHt4hnwE+kn
         RUIAcquBY57faIyHeZI5uoQ3YDVz7AWJtFzCnX834JbfHEDFV+8QYWP2Zc4WkS6fmXf/
         GlXB2l3CeBWz0W8oaBiZgmUxRZalJz6sIqYyeZeCRuxgGU0wcCEcM1Sxhyn+3cPb3/bF
         xO/A==
X-Gm-Message-State: AO0yUKWI8VbAaXt6FVfysHPiKRo+Rdmn2KjvXpIpbg9Rba2hwHtkVBtM
        FweZCCFnsCFnGO1vdFtmPPc=
X-Google-Smtp-Source: AK7set86TYpVcITgJXJm4s/OX9vpmb5LfCz010PfmJd7Uh/wCgxDc/XDm5BFHxmnF0Wn8wX5b+e00A==
X-Received: by 2002:a17:902:e30a:b0:198:d8a4:1ece with SMTP id q10-20020a170902e30a00b00198d8a41ecemr6346283plc.8.1675893653517;
        Wed, 08 Feb 2023 14:00:53 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d4e2:8ad2:b455:fc1b])
        by smtp.gmail.com with ESMTPSA id io23-20020a17090312d700b00198a845fbbasm1754051plb.84.2023.02.08.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 14:00:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 8 Feb 2023 14:00:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <Y+QbkmHM22hr5ExI@google.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
 <20230206052139.GA21897@hu-cgoldswo-sd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206052139.GA21897@hu-cgoldswo-sd.qualcomm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 09:22:28PM -0800, Chris Goldsworthy wrote:
> On Wed, Feb 01, 2023 at 03:47:58PM -0800, Minchan Kim wrote:
> > Hi Chris,
> > 
> > On Tue, Jan 31, 2023 at 08:06:28PM -0800, Chris Goldsworthy wrote:
> > > We're operating in a resource constrained environment, and we want to maximize
> > > the amount of memory free / headroom for GFP_KERNEL allocations on our SoCs,
> > > which are especially important for DMA allocations that use an IOMMU. We need a
> > > large amount of CMA on our SoCs for various reasons (e.g. for devices not
> > > upstream of an IOMMU), but whilst that CMA memory is not in use, we want to
> > > route all GFP_MOVABLE allocations to the CMA regions, which will free up memory
> > > for GFP_KERNEL allocations. 
> > 
> > I like this patch for different reason but for the specific problem you
> > mentioned, How about making reclaimer/compaction aware of the problem:
> > 
> > IOW, when the GFP_KERNEL/DMA allocation happens but not enough memory
> > in the zones, let's migrates movable pages in those zones into CMA
> > area/movable zone if they are plenty of free memory.
> > 
> > I guess you considered but did you observe some problems?
> 
> Hi Minchan,
> 
> This is not an approach we've considered. If you have a high-level idea of the
> key parts of vmscan.c you'd need to touch to implement this, could you point me
> to them?

I think the problem is not specific with CMA but also movable zone.
If movable pages are charged into non-movable zones, the problem wil
happen. So what I suggested was if reclaimers(e.g., background/direct
reclaimers) found the request was GFP_KERNEL but there are not enough
free pages in the zone and lower zones but has movable pages in there,
migrate them into the CMA area and/or movable zones to make room for
the GFP_KERNEL allocation before the final failure.

It needs touch wakeup_kswapd/kcompactd to trigger the migration and
reclaim/compaction needs to deal with the commmand. I couldn't say
where are good places to change until I look at further details but
I thought it's more general solution.

> 
> I guess one drawback with this approach is that as soon as kswapd starts,
> psi_memstall_enter() is called, which can eventually lead to LMKD running in
> user space, which we want to minimize. One aim of what we're doing this is to
> delay the calling of psi_memstall_enter().

LMKD running would be not a problem, I think but you are worry about
LMKD decide killing apps due to wrong signal? I think it's orthgonal
issue. Actually, it's long time problem for userspace memory manager
since they don't know where the memory pressure comes from with what
constrains. This is the GFP_KERNEL constraint but LMKD can kill apps
which consumes much memory for movable zones or CMA area so cannot
help the memory pressure. Furthermore, LMKD has bunch of knobs to
affect decision to kill apps. PSI is just event to wake up LMKD,
not decision policy.

> 
> It would be beneficial though on top of our change: if someone called
> cma_alloc() and migrated out of the CMA regions, changing kswapd to behave like
> this would move things back into the CMA regions after cma_release() is called
> (instead of having to kill a user space process to have the CMA re-utilized upon
> further user space actions).
> 
> Thanks,
> 
> Chris.
