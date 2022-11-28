Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A363AE44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiK1RA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiK1RAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:00:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756AE13DCE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:00:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37547B80E51
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9379C433C1;
        Mon, 28 Nov 2022 17:00:34 +0000 (UTC)
Date:   Mon, 28 Nov 2022 17:00:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 4/5] arm64: mm: Support ASID isolation feature
Message-ID: <Y4TpL5IIHUSRtSQo@arm.com>
References: <20221017083203.3690346-1-yeyunfeng@huawei.com>
 <20221017083203.3690346-5-yeyunfeng@huawei.com>
 <Y2ughyNLh9EFw3HT@arm.com>
 <3607b658-304a-ecc8-b07a-530f4a6365e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3607b658-304a-ecc8-b07a-530f4a6365e8@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:07:53PM +0800, Yunfeng Ye wrote:
> On 2022/11/9 20:43, Catalin Marinas wrote:
> > On Mon, Oct 17, 2022 at 04:32:02PM +0800, Yunfeng Ye wrote:
> >> After a rollover, the global generation will be flushed, which will
> >> cause the process mm->context.id on all CPUs do not match the
> >> generation. Thus, the process will compete for the global spinlock lock
> >> to reallocate a new ASID and refresh the TLBs of all CPUs on context
> >> switch. This will lead to the increase of scheduling delay and TLB miss.
> >>
> >> In some delay-sensitive scenarios, for example, part of CPUs are
> >> isolated, only a limited number of processes are deployed to run on the
> >> isolated CPUs. In this case, we do not want these key processes to be
> >> affected by the rollover of ASID.
> > 
> > Part of this commit log should also go in the cover letter and it would> help to back this up by some numbers, e.g. what percentage improvement
> > you get with this patchset by running hackbench on an isolated CPU.
> > 
> > In theory it looks like CPU isolation would benefit from this patchset
> > but we try not to touch this code often, so any modification should come
> > with proper justification, backed by numbers.
> > 
> Yes, CPU isolation will benefit from this patchset. We use cyclictest tool
> to test the maximum scheduling and interrupt delays, found that the
> sched_switch process takes several microseconds sometimes, The analysis
> result shows that the delay is caused by the ASID refresh.

Do you know whether it's predominantly the spinlock or the TLBI that's
causing this (or just a combination of the two)?

I was talking to Will and concluded we should try to reuse the ASID
pinning code that's already in that file rather than adding a new
bitmap. At a high level, a thread migrating to an isolated CPU can have
its ASID pinned. If context switching only happens between pinned ASIDs
on an isolated CPU, we may be able to avoid the lock even if the
generation rolled over on another CPU.

I think the tricky problem is when a pinned ASID task eventually dies,
possibly after migrating to another CPU. If we avoided the TLBI on
generation roll-over for the isolated CPU, it will have stale entries.
One option would be to broadcast a TLBI for the pinned ASID when the
task dies, though this would introduce some jitter. An alternative may
be to track whether a pinned ASID ever run on a CPU and do a local TLBI
for that ASID when a pinned thread is migrated.

All these need a lot more thinking and (formal) modelling. I have a TLA+
model but I haven't updated it to cover the pinned ASIDs. Or,
alternatively, make the current code stand-alone and get it through CBMC
(faking the spinlock as pthread mutexes and implementing some of the
atomics in plain C with __CPROVER_atomic_begin/end).

-- 
Catalin
