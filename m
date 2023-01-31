Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566F683AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBAAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBAAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:00:04 -0500
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3412BB9E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:00:00 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:59:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675209598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWCqjufY/61qPvR9HEojMrY/WvLmHVsep3q1ZpubUAY=;
        b=oi8yOtoKcYvdhbl73d25YHMRPp+cfOecqwwPHL2Qxw2ODm0tt+D8eKqciGw2XDuntzxrs6
        zl/VUUGVfyMPMDKmSjVZ9oAXimeqSY5ovyJn2lEwetzw9eny/LLZyt+XIFtab9XD1WmPG+
        W1LuOc7XOMQx286qg9dES/uA9XlWO/s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:10:01PM -0800, Sukadev Bhattiprolu wrote:
> On Tue, Jan 31, 2023 at 10:10:40AM -0800, Roman Gushchin wrote:
> > Hi Sukadev!
> > 
> > Can you, please, share a bit more details about your setup? E.g. what is
> > the zone size, the cma area size and the value you want to set your sysctl to?
> 
> Hi Roman,
> 
> I currently have a device with 8GB Zone normal and 600MB of CMA. We have a
> slightly different implementation and use up all the available CMA region.
> i.e. going forward, we intend to set the ratio to 100 or even higher.

It means you want allocations be always served from a cma region first?
What's the point of it?

The idea behind the current formula is to keep cma regions free if there is
a plenty of other free memory, otherwise treat it on par with other memory.

To justify a new sysctl you really need a solid use case, which is not limited
to your custom implementation.

Also, if decide to go with a new sysctl, we probably want to define it differently,
e.g. as a [0-1000)/1000 of the zone size. But, honestly, I'm not sold yet.

Thanks!
