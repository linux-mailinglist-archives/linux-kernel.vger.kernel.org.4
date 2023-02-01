Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDA686E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBATAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBATAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:00:39 -0500
Received: from out-148.mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9026A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:00:38 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:00:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675278035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYaJBwWv04VyrNu+X4EgPv0Xb15I2c3WvPYD3xQxlig=;
        b=dgUfIgYxZt9wZbnGKSDK2uiNaZZ/5zUS5bhvJ5luv/cRV8MxqT28jSeyHUkeRbs/VPvSZT
        QvWHYE9Dj1WHn0PdlnWgWFBx1C7x/fVWfKqcuVcq5es654OVipyrBV1RVeVOn51zpxvWv4
        o22/GhZRvsJkMFHf6ifH2R6v4EqvoJA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Rik van Riel <riel@surriel.com>
Cc:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <Y9q2yUZmCiNd7iYC@P9FQF9L96D.corp.robot.car>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:06:28PM -0800, Chris Goldsworthy wrote:
> On Tue, Jan 31, 2023 at 03:59:36PM -0800, Roman Gushchin wrote:
> > On Tue, Jan 31, 2023 at 12:10:01PM -0800, Sukadev Bhattiprolu wrote:
> > > On Tue, Jan 31, 2023 at 10:10:40AM -0800, Roman Gushchin wrote:
> > > > Hi Sukadev!
> > > > 
> > > > Can you, please, share a bit more details about your setup? E.g. what is
> > > > the zone size, the cma area size and the value you want to set your sysctl to?
> > > 
> > > Hi Roman,
> > > 
> > > I currently have a device with 8GB Zone normal and 600MB of CMA. We have a
> > > slightly different implementation and use up all the available CMA region.
> > > i.e. going forward, we intend to set the ratio to 100 or even higher.
> 
> 
> Hi Roman,
> 
> > It means you want allocations be always served from a cma region first?
> 
> Exactly.
> 
> > What's the point of it?
> 
> We're operating in a resource constrained environment, and we want to maximize
> the amount of memory free / headroom for GFP_KERNEL allocations on our SoCs,
> which are especially important for DMA allocations that use an IOMMU. We need a
> large amount of CMA on our SoCs for various reasons (e.g. for devices not
> upstream of an IOMMU), but whilst that CMA memory is not in use, we want to
> route all GFP_MOVABLE allocations to the CMA regions, which will free up memory
> for GFP_KERNEL allocations. 
> 
> > The idea behind the current formula is to keep cma regions free if there is
> > a plenty of other free memory, otherwise treat it on par with other memory.
> 
> With the current approach, if we have a large amount of movable memory allocated
> that has not gone into the CMA regions yet, and a DMA use case starts that
> causes the above condition to be met, we would head towards OOM conditions when
> we otherwise could have delayed this with this change.
> Note that since we're
> working on Android, there is a daemon built on top of PSI called LMKD that will
> start killing things under memory pressure (before an OOM is actually reached)
> in order to free up memory. This patch should then reduce kills accordingly for
> a better user experience by keeping a larger set of background apps alive. When
> a CMA allocation does occur and pages get migrated out, there is a similar
> reduction in headroom (you probably already know this and know of the FB
> equivalent made by Johannes Weiner).

I see... Thank you for the explanation!

So the problem is that movable allocations are spread between cma and non-cma
evenly, so that non-movable allocations might fail. And the idea is to use
the cma area more actively for movable allocations to keep a headroom for
non-movable allocations. Is it correct?

Then _maybe_ a new knob is justified, at least I don't have better ideas.
Rik, do you have any input here?

Let's then define it in a more generic way and _maybe_ move to the cma
sysfs/debugfs (not 100% sure about this part, but probably worth exploring).

Thanks!
