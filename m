Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559E674C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjATFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjATFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:33:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F6743B4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891EBB82333
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A2C433EF;
        Thu, 19 Jan 2023 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674133263;
        bh=rXkl/DGFD1+8+kXI2HLkjSe5GI6vKmolaKZBDMc5QeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg+W9kuAJ96cAS2RtMcNSKOMRpsfX14XEnLclcRcxOc5N8GpxD+8F0QK2BQw0YLGi
         NtyNhaBZreK0SpMH7dHuH/K29G/jKMgJX3NYyuDe5ClmtwhVgEcpktOa70ImQFXV7+
         R7hQZpI4MGZweZ/KDpdqpVJdS7r5jbmEhwRcXM946RudRUDjHqyjHO8nyCeaPERSOL
         yorCjsK2cTjR/w3gRhpThsl3kGJBpWO4fJusE3/rnxxfqbr3JWpNm7rxYLCfDeUBxd
         ZD3XkQcoUwoT7YOVZIqQElFA5AIEez+Y109aLqrCiF/rhtBPDp1sSeiauJWkiFD35c
         qpZwbc4gtmBpw==
Date:   Thu, 19 Jan 2023 15:00:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] memblock: Make finding index faster when modify
 regions.
Message-ID: <Y8k/AxLAu2sXcacc@kernel.org>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-3-zhangpeng.00@bytedance.com>
 <Y8QHehG1L+kuyqoR@kernel.org>
 <acbfecf4-e3ee-4df2-6685-6cefca38bde6@bytedance.com>
 <Y8T+qWlUT1KTeFNI@kernel.org>
 <49b867c1-2b68-c034-9f60-b26a77ff326a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b867c1-2b68-c034-9f60-b26a77ff326a@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:40:47PM +0800, Peng Zhang wrote:
> 
> 
> 在 2023/1/16 15:37, Mike Rapoport 写道:
> > On Mon, Jan 16, 2023 at 11:17:40AM +0800, Peng Zhang wrote:
> > > 
> > > 
> > > 在 2023/1/15 22:02, Mike Rapoport 写道:
> > > > Hi,
> > > > 
> > > > On Fri, Jan 13, 2023 at 04:26:58PM +0800, Peng Zhang wrote:
> > > > > We can use binary search to find the index to modify regions in
> > > > > memblock_add_range() and memblock_isolate_range(). Because the
> > > > > arrangement of regions is ordered. It may be faster when there are
> > > > > many regions. So implemented a binary search and a new macro to walk
> > > > > regions.
> > > > 
> > > > Did you see a measurable speedup with this optimization?
> > > > I'm not in favor of micro-optimizations that complicate code.
> > > > 
> > > Thank you for your reply. I haven't measured this patch yet, theoretically
> > > this small optimization might be difficult to observe.
> > > If you think this patch complicates the code, you can ignore this patch.
> > > 
> > > These three patches are independent and they can be applied independently.
> > > The logic of the third patch is very simple. It will not complicate the
> > > code. It is tested by the default configuration of qemu. The total number of
> > > iterations of memblock_merge_regions() in the third patch is reduced from
> > > more than one thousand to more than one hundred, this is only in the case of
> > > a small number of regions. Can you consider the third patch?
> > 
> > Can you please send the numbers and show how did you obtained them?
> > 
> > > Sincerely yours,
> > > Peng.
> > 
> I obtained the numbers like this:
> 
> void memblock_merge_regions(struct memblock_type *type) {
> 	static int iteration_count = 0;
> 	static int max_nr_regions = 0;
> 
> 	max_nr_regions = max(max_nr_regions, (int)type->cnt);
> 	...
> 	while () {
> 		iteration_count++;
> 		...
> 	}
> 	pr_info("iteration_count: %d max_nr_regions %d", iteration_count,
> max_nr_regions);
> }
> 
> Boot the kernel by qemu.
> The folowing numbers is the last output.
> 
> master branch:
> iteration_count: 1762 max_nr_regions 41
> 
> patched:
> iteration_count: 182 max_nr_regions 41

The numbers that indicate what speed up your patch achieves should be a
part of the changelog. It would be great if you could test it on a real
machine and measure the actual time saved by your changes.

> If max_nr_regions is larger, the difference will be more.
> 
> Thanks.
> 
> Sincerely yours,
> Peng

-- 
Sincerely yours,
Mike.
