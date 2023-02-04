Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA868A71B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjBDAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBDAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:05:05 -0500
Received: from out-231.mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5397640B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 16:05:03 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:04:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675469101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Cn1wg2IEFeCvZChRDejmKpY32y8tFA+ncBQa7Me598=;
        b=Fo6dbikXvf84ADwrd7AGZu3wpU0j0ihxcWDh5BtlqLLSUGFifg/ptI/Fvtj+6MI9D8Uhu6
        OTsre3lphkVObOFZmlle+rdgvcvpr1jo3nlF0Rb7VTga7IlkKLUITpBfQRTzXZQAmGxoVx
        BiVlKJbKom4WlYAp+YhusepVoGW8Z1Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
Cc:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <Y92hJjFfIuQufkGT@P9FQF9L96D.corp.robot.car>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9q2yUZmCiNd7iYC@P9FQF9L96D.corp.robot.car>
 <20230202201302.GB22373@hu-sbhattip-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202201302.GB22373@hu-sbhattip-lv.qualcomm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:13:02PM -0800, Sukadev Bhattiprolu wrote:
> 
> Hi Roman,
> 
> On Wed, Feb 01, 2023 at 11:00:25AM -0800, Roman Gushchin wrote:
> > Then _maybe_ a new knob is justified, at least I don't have better ideas.
> > Rik, do you have any input here?
> > 
> > Let's then define it in a more generic way and _maybe_ move to the cma
> > sysfs/debugfs (not 100% sure about this part, but probably worth exploring).
> 
> We should be able to use a sysfs parameter too. Will try that out.

Thanks. The reason I think it might be preferable is that new sysctls are hated
by everyone and this use case looks a very niche.

> But could you elaborate on what is more generic way?

I mean in the proposed patch it's only possible to shift the ratio towards cma:
a larger sysctl value will make allocations from the cma area happening earlier.
The value 1 will turn it off completely.

Probably better to define the new knob in % or 1/1000's with the default value
50% or 500. 0 will mean never use cma from this path, 999 - always.
Something along these lines.

Thanks!
