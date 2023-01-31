Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353A682F36
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAaO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAaO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEEC40CA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:26:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E31961426
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA54C433D2;
        Tue, 31 Jan 2023 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175171;
        bh=YgwryXO/WjU7qeBo+PfmZ5YImF9RsONUHj2VOYTQaLw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HqKKuHdWWsetbObe+TJDLV7+/QOme9pRaZ4WnEZKgvpkSuCPam3bphp+UTceJN4nR
         uHqdAjCcB0JXZsEVxw+7X8vf5iFZggZBtIjIzu/Gq8PSjwBobBl/AY/tJzv/smjV/w
         wPn+zQviwMGzkf/jvRnwPzGvZlEXOIS5+K9NiniF1NgTbJJVSXKYwfVb6ek9hwP8Fp
         KiBkTJ/bgz+Tu54mX9uR7UICp9kIyaAc/qJ1pt5PmGh/p+LhFc+xlaAcblntK9PJuy
         XgI1PsqOG65uDWy85a9ORJrJS/mQlYJ3jiC6gPgpxBHnlBVDMgas/AGKqOzDW5xbyr
         +yAH6QW3uD5Hg==
Message-ID: <d436ee82-4e3f-67a3-e825-a57d5f096e83@kernel.org>
Date:   Tue, 31 Jan 2023 16:26:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Content-Language: en-US
To:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sukadev,

On 31.01.23 9:10, Sukadev Bhattiprolu wrote:
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
>  > Make the percentage of CMA utilization a configurable parameter to allow
> for such usecases.

The above makes sense to me. But it also needs to documented like the other
sysctl files in Documentation/admin-guide/sysctl/vm.rst

Thanks,
Georgi

> 
> Signed-off-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
> ---
> Note:	There was a mention about it being the last resort to making this
> 	percentage configurable (https://lkml.org/lkml/2020/3/12/751). But
> 	as explained above, multi-platform kernels for varying memory size
> 	targets would need this to be configurable.
> ---
>   include/linux/mm.h |  1 +
>   kernel/sysctl.c    |  8 ++++++++
>   mm/page_alloc.c    | 18 +++++++++++++++---
>   mm/util.c          |  2 ++
>   4 files changed, 26 insertions(+), 3 deletions(-)
> 
