Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B468350B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAaSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAaSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:19:33 -0500
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 10:19:22 PST
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [IPv6:2001:41d0:203:375::bf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169343B0E3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:19:21 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:10:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675188659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hw7RiQTVcA+BYuGPkYm03KZ1UUjvdwwinv6Or2lFo2Q=;
        b=o//e0VSsxl3FvJhusZSmKJQCUTa+TY6jePLCLBd91G6/UWzBx+tf3SG7yfMYK3jbGvyHM5
        LfRL+mZGdqJZXp7EExIdq8UvyT897kM80w9xfpxmC4O4wkwELl9a0qOKwIHrBhMC6RClbM
        PSS76lHbnYrs4CKiZZ84XDub/33S7u4=
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
Message-ID: <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:10:52PM -0800, Sukadev Bhattiprolu wrote:
> 
> Commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma pageblocks for movable allocations")
> added support to use CMA pages when more than 50% of total free pages in
> the zone are free CMA pages.
> 
> However, with multiplatform kernels a single binary is used across different
> targets of varying memory sizes. A low memory target using one such kernel
> would incur allocation failures even when sufficient memory is available in
> the CMA region. On these targets we would want to utilize a higher percentage
> of the CMA region and reduce the allocation failures, even if it means that a
> subsequent cma_alloc() would take longer.
> 
> Make the percentage of CMA utilization a configurable parameter to allow
> for such usecases.
> 
> Signed-off-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
> ---
> Note:	There was a mention about it being the last resort to making this
> 	percentage configurable (https://lkml.org/lkml/2020/3/12/751). But
> 	as explained above, multi-platform kernels for varying memory size
> 	targets would need this to be configurable.

Hi Sukadev!

Can you, please, share a bit more details about your setup? E.g. what is
the zone size, the cma area size and the value you want to set your sysctl to?

Roman
