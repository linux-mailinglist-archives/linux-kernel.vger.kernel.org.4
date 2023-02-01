Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F84687208
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBAXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBAXsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:48:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8711162
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:48:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so210193pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qONq/AhmclCCK7mKauzEac52VGve8IOohgS94o773p8=;
        b=IAPv2JXkez3tw3c5eqcIiuNepppxNz8R2Mra2NjPSCAkkuGYQQ/FoQMUxp86wepszE
         jNG7okLoYIcyo9iVNLrzvmG8La/VvG4O9MBt4TYQNQCs0EuZPZavwfxIov2N1O7hN13o
         Om9ZNwEue5xHE6CMWpAWfnKZjq4J19jIj7gCGy42Wn3AlVML5D6+OuX5k8hwCrvyOJBA
         lM/D6YMQ6zkrKEi7FPXCgPTSY6PeUUOughd6ZIDCUp56xFqQh/VK6YAY6FXxGMTGZoLn
         AAAPNr1VclfuI4FwLSbYO8DO1d7Q1Yye5hUk9ETETtEKXZptFfd1ibIbsVe/Z30htZ+h
         4o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qONq/AhmclCCK7mKauzEac52VGve8IOohgS94o773p8=;
        b=upl2tSa1IeRw+BI1Zd7n3Li/lKynGiIxvUhBIulN9WEL1fDfs9L7UZwhjB9p1tHlOa
         d+itMtvFJ2KjljUS1x5d/op/0C0CIAxUGvtF7PlXeGfa2hlCqOz2L4l036SQU6C3UlkU
         3RpDk/7BqZnfzqB40oj30jHKtyqxQFt1RoAdHbF0+7QumEzLT26BbvlcL/eGKGNwPmCD
         MHsFf4xBz8p/Q29mLReeoUKoa7RQ401rDuDTFd6eqzcIm2Wuwd0/VQ4Y5oMrP6hy/aUs
         6ohMkshqSjpAW+2FyUbU5zkKt1ZbwR+4NzJLdEwYvYKgQKj/ohIysiYCBEbGDOflNJ6N
         /KyA==
X-Gm-Message-State: AO0yUKV8aIgsW/nzE1amog2gYiS7p99hE2QfJATQr8TFw+ewLHqq3VEH
        Fj6eYq1z/PP2H0/+SQaFCNY=
X-Google-Smtp-Source: AK7set82yy1P3qNgPucA+e/yxxzq7s64ng3Kgdc7ME8kRxyqYaIHFyCj4We60GWRUlN3gN70EsA4nA==
X-Received: by 2002:a17:903:4053:b0:196:7eb6:8b21 with SMTP id n19-20020a170903405300b001967eb68b21mr3726989pla.23.1675295281331;
        Wed, 01 Feb 2023 15:48:01 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d784:e914:b18:b429])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b00194caf3ccc4sm1287197plr.285.2023.02.01.15.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:48:00 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 1 Feb 2023 15:47:58 -0800
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
Message-ID: <Y9r6LtMOPHfxr7UL@google.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

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

I like this patch for different reason but for the specific problem you
mentioned, How about making reclaimer/compaction aware of the problem:

IOW, when the GFP_KERNEL/DMA allocation happens but not enough memory
in the zones, let's migrates movable pages in those zones into CMA
area/movable zone if they are plenty of free memory.

I guess you considered but did you observe some problems?

> 
> > The idea behind the current formula is to keep cma regions free if there is
> > a plenty of other free memory, otherwise treat it on par with other memory.
> 
> With the current approach, if we have a large amount of movable memory allocated
> that has not gone into the CMA regions yet, and a DMA use case starts that
> causes the above condition to be met, we would head towards OOM conditions when
> we otherwise could have delayed this with this change.  Note that since we're
> working on Android, there is a daemon built on top of PSI called LMKD that will
> start killing things under memory pressure (before an OOM is actually reached)
> in order to free up memory. This patch should then reduce kills accordingly for
> a better user experience by keeping a larger set of background apps alive. When
> a CMA allocation does occur and pages get migrated out, there is a similar
> reduction in headroom (you probably already know this and know of the FB
> equivalent made by Johannes Weiner). 
> 
> Thanks,
> 
> Chris.
