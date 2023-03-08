Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D916B0545
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCHLC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCHLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:02:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF69B9C88
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:02:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A10016172E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34824C433D2;
        Wed,  8 Mar 2023 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678273327;
        bh=tNV9mMm1s/MjSaospZytlO4O6OsHOlv2qlO7ZKYN3RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lla01DBTq3zBtebe7SpLPs9XCRg496tXLV/4d2rw/2R2bvj2j1sZvniAfD25S+yIw
         upDXja2CFlZF0emaMv1CXeA3ohuzDP1IZVEZ3orG037daIYW9x7w+DYaqpEomlhmpD
         OVn5ZzEjaUjuim44aZ6vQ+BbMoAy8/8rDNrthchX5D6UAVt4rjdUMuAK4wrPtO0RMv
         8HHLUt48Jzff2AScGeIvPA2zUcecAlxULxLY3XetBxYzF13xuo2EMO+q74uKn6cSTb
         r/R60nBJhCv774mmSBrOLR7ul9YXEJNeVBM43+GTOZnARb/5IGu7ZkMoDGAB5XzAXC
         qg7wh6hQZFVyQ==
Date:   Wed, 8 Mar 2023 12:02:02 +0100
From:   Simon Horman <horms@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZAhrKkld4oo2EhVz@kernel.org>
References: <20230306084124.300584-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306084124.300584-1-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
> >From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> system, or 4G if other normal systems.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

