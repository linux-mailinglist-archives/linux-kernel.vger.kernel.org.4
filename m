Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB767C236
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjAZBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAZBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:12:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A5305D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D99E616F6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205D9C433D2;
        Thu, 26 Jan 2023 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674695520;
        bh=1tJKpxAhIejZkUCqagAyMqyekFlm2a9vKsTefDdUQko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SEHIvHlUl8jnqGBhCsBW+SE1kz/1D1fJ1LsUuAyFOiZ/9sVQGKEG/36iKHXexxgXL
         tloDqkTeZpLikItZFTRx30NAkkXWAzVGULr+kXkAWrMvIDvRCCatQ1QUvCZyBXGBUT
         XmcU7I5EDqxIBUD9CzgaS7RkC1qdqdYSUEusMuwk=
Date:   Wed, 25 Jan 2023 17:11:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Fix excessive CPU usage during compaction
Message-Id: <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
In-Reply-To: <20230125134434.18017-1-mgorman@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 13:44:30 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:

> Commit 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
> fixed a problem where pageblocks found by fast_find_migrateblock() were
> ignored. Unfortunately there were numerous bug reports complaining about high
> CPU usage and massive stalls once 6.1 was released. Due to the severity,
> the patch was reverted by Vlastimil as a short-term fix[1] to -stable and
> is currently sitting in the Andrew's git branch mm/mm-hotfixes-unstable.
> 
> The underlying problem for each of the bugs is suspected to be the
> repeated scanning of the same pageblocks. This series should guarantee
> forward progress even with commit 7efc3b726103. More information is in
> the changelog for patch 4.
> 
> If this series is accepted and merged after the revert of 7efc3b726103
> then a "revert of the revert" will be needed.

If we drop Vlastimil's reversion and apply this, the whole series
should be cc:stable and it isn't really designed for that.

So I think either

a) drop Vlastimil's reversion and persuade Mel to send us a minimal
   version of patch #4 for -stable consumption.  Patches 1-3 of this
   series come later.

b) go ahead with Vlastimil's revert for -stable, queue up this
   series for 6.3-rc1 and redo the original "fix set skip in
   fast_find_migrateblock" some time in the future.

If we go with b) then the Fixes: tag in "[PATCH 4/4] mm, compaction:
Finish pageblocks on complete migration failure" is inappropriate -
fixing a reverted commit which Vlastimil's revert already fixed.

I'll plan on b) for now.
