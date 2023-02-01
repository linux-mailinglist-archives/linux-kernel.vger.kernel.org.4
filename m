Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C646686C70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBARIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjBARIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:08:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C840E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B93BB82204
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8840DC433D2;
        Wed,  1 Feb 2023 17:07:58 +0000 (UTC)
Date:   Wed, 1 Feb 2023 17:07:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9qca12Y/oCxcaFW@arm.com>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
 <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:57:17PM +0800, Baoquan He wrote:
> On 01/24/23 at 05:36pm, Catalin Marinas wrote:
> > On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > > suitable memory region up down. If the 'xM' of crashkernel high memory
> > > is reserved from high memory successfully, it will try to reserve
> > > crashkernel low memory later accoringly. Otherwise, it will try to search
> > > low memory area for the 'xM' suitable region.
> > > 
> > > While we observed an unexpected case where a reserved region crosses the
> > > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > > This looks very strange because we have two low memory regions
> > > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > > why that happened.
> > > 
> > > Here, for crashkernel=xM,high, search the high memory for the suitable
> > > region above the high and low memory boundary. If failed, try reserving
> > > the suitable region below the boundary. Like this, the crashkernel high
> > > region will only exist in high memory, and crashkernel low region only
> > > exists in low memory. The reservation behaviour for crashkernel=,high is
> > > clearer and simpler.
> > 
> > Well, I guess it depends on how you look at the 'high' option: is it
> > permitting to go into high addresses or forcing high addresses only?
> > IIUC the x86 implementation has a similar behaviour to the arm64 one, it
> > allows allocation across boundary.
> 
> Hmm, x86 has no chance to allocate a memory region across 4G boundary
> because it reserves many small regions to map firmware, pci bus, etc
> near 4G. E.g one x86 system has /proc/iomem as below. I haven't seen a
> x86 system which doesn't look like this.
> 
> [root@ ~]# cat /proc/iomem 
[...]
> fffc0000-ffffffff : Reserved
> 100000000-13fffffff : System RAM

Ah, that's why we don't see this problem on x86.

Alright, for consistency I'm fine with having the same logic on arm64. I
guess we don't need the additional check on whether the 'high'
allocation reserved at least 128MB in the 'low' range. If it succeeded
and the start is below 4GB, it's guaranteed that it got the full
allocation in the 'low' range. I haven't checked whether your patch
cleaned this up already, if not please do in the next version.

And as already asked, please fold the comments with the same patch, it's
easier to read.

-- 
Catalin
