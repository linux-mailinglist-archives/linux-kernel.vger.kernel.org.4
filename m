Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA926EAF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjDUQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDUQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:32:39 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA6D1702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:32:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef588dcf7aso16542761cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682094755; x=1684686755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yla/4p2oOldTOYUR/tBNrxjFRWDCxFy5rsjLcKDZm0=;
        b=IIgMXIAsLX6acEerwuEG1+MjsTqE3bx1KI0BxQfpjUAmK3E6dBjQ0RccgOa2SFlESk
         jMabF1fjcn8hswczr7Qmr1M5ZMln1zLje4A+Zi4oc4mcaLlGdvf+BM1WelSpNQCCx3i6
         MpPfs+g5ViS6y1PZ/Z22tw2a+1h1tQVuiZ7Za4ovAwVlPbNQcKUF1xczcdKtGDvoXMiF
         JuNzCwCDr9vP2zwkLYCJxorm3dprSxwSg38Cr6rrcj4woDTHeyv6FKg2nPQ23D1uGqcT
         pSrDcQnMvpwrZvEommOhMCGRGPaXVz+MYgON0XhPllfJxYeTBUlNDq9ZwohH/H/huVom
         dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094755; x=1684686755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yla/4p2oOldTOYUR/tBNrxjFRWDCxFy5rsjLcKDZm0=;
        b=DE0+UpqZArBSjD/uIxXcl7FGc6h7kKGLQ6xzS0VWeQvOr/VqeH5+d1PPOr2ut7ggLB
         5mebpZ3DCwvhK4kEpwy1Db5rNb+UXKCZkfg36MI5OQPEglrVqe7r+WjECkQMc/zoDTKd
         wcef8sighp/PLpAj23Fmg12QJDmhOVNd2hXVRd51eCdnuY+1wJxDGgeNwW1dgFA1pDPG
         Eg7AVRkHcGIgnE/wUg1l/B24+/HfegAEuxIH2FnwFqZqHVDs58IPPNGLmR/wp2Niicif
         Ri4TPn2zH+d+QaQzBRAMhmQj5S/4tHYPTK3dQNGOYJPV7mvKIXwy+ZVwehTf3mltR1c/
         gaJw==
X-Gm-Message-State: AAQBX9fKyA6MN8KQtGUxq7RNMMV6gAhBJXo++s98MUq9q60/nSumwjQM
        MBYn8y2F2oR0+h9CnfARKCT07g==
X-Google-Smtp-Source: AKy350bj3/K/tk2k4WizRt2yPrEl47IiwR4WqXmA0klRcGVpUS135pGT1DB1cqHqXdDI0Exxp3B+5w==
X-Received: by 2002:ac8:5f0d:0:b0:3ef:2fbd:90c3 with SMTP id x13-20020ac85f0d000000b003ef2fbd90c3mr8748270qta.37.1682094755652;
        Fri, 21 Apr 2023 09:32:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id b142-20020ae9eb94000000b0074cd846d215sm1447569qkg.64.2023.04.21.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:32:35 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:32:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 12/26] mm: page_alloc: per-migratetype free counts
Message-ID: <20230421163234.GF320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-13-hannes@cmpxchg.org>
 <20230421142841.parju3gmqmpefigq@techsingularity.net>
 <20230421153501.GE320347@cmpxchg.org>
 <20230421160320.zz2he2iprq37vnl3@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421160320.zz2he2iprq37vnl3@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:03:20PM +0100, Mel Gorman wrote:
> On Fri, Apr 21, 2023 at 11:35:01AM -0400, Johannes Weiner wrote:
> > On Fri, Apr 21, 2023 at 03:28:41PM +0100, Mel Gorman wrote:
> > > On Tue, Apr 18, 2023 at 03:12:59PM -0400, Johannes Weiner wrote:
> > > > Increase visibility into the defragmentation behavior by tracking and
> > > > reporting per-migratetype free counters.
> > > > 
> > > > Subsequent patches will also use those counters to make more targeted
> > > > reclaim/compaction decisions.
> > > > 
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > Visibility into fragmentation behaviour is information that is
> > > almost certainly only useful to a developer and even then, there is
> > > /proc/pagetypeinfo. At minimum, move this patch to later in the series
> > > but I'm skeptical about its benefit.
> > 
> > Having them available in the memory dump (OOM, sysrq) was essential
> > while debugging problems in later patches. For OOMs or lockups,
> > pagetypeinfo isn't available. It would be useful to have them included
> > in user reports if any issues pop up.
> > 
> 
> OOM+sysrq could optionally take the very expensive step of traversing the
> lists to get the count so yes, it helps debugging, but not necessarily
> critical.
> 
> > They're used internally in several places later on, too.
> > 
> 
> I did see that for deciding the suitability for compaction. Minimally, put
> the patches adjacent in the series and later if possible so that the series
> can be taken in parts. There are a lot of patches that should be relatively
> uncontroversial so maybe make "mm: page_alloc: introduce MIGRATE_FREE" the
> pivot point between incremental improvements and "everything on and after
> this patch is relatively high risk, could excessively compact/reclaim,
> could livelock etc".

Okay, I see now where you're coming from. That's good feedback.

Actually most of the patches work toward the final goal of managing
free memory in whole blocks. The only exception are the block pages,
the nofs deadlock, the page_isolation kernel doc, and *maybe* the
should_[compact|reclaim]_retry cleanups. I tried to find the
standalone value in each of the prep patches as well to avoid
forward-referencing in the series too much. But obviously these
standalone reasons tend to be on the weak side.

I'll rework the changelogs (and patch ordering) where applicable to
try to make the dependencies clearer.
