Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0967A04B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjAXRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjAXRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:36:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D44DE29
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:36:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6458B81269
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5DEC433EF;
        Tue, 24 Jan 2023 17:36:45 +0000 (UTC)
Date:   Tue, 24 Jan 2023 17:36:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9AXKgJvUuilsWUX@arm.com>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-2-bhe@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region up down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> This looks very strange because we have two low memory regions
> [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> why that happened.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region above the high and low memory boundary. If failed, try reserving
> the suitable region below the boundary. Like this, the crashkernel high
> region will only exist in high memory, and crashkernel low region only
> exists in low memory. The reservation behaviour for crashkernel=,high is
> clearer and simpler.

Well, I guess it depends on how you look at the 'high' option: is it
permitting to go into high addresses or forcing high addresses only?
IIUC the x86 implementation has a similar behaviour to the arm64 one, it
allows allocation across boundary.

What x86 seems to do though is that if crash_base of the high allocation
is below 4G, it gives up on further low allocation. On arm64 we had this
initially but improved it slightly to check whether the low allocation
is of sufficient size. In your example above, it is 126MB instead of
128MB, hence an explicit low allocation.

Is the only problem that some users get confused? I don't see this as a
significant issue. However, with your patch, there is a potential
failure if there isn't sufficient memory to accommodate the request in
either high or low ranges.

-- 
Catalin
