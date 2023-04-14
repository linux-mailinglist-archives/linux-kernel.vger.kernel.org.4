Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC56E2397
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDNMqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D311C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696226479C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59DBC433D2;
        Fri, 14 Apr 2023 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681476399;
        bh=CMcPhT/rQ0m4SLI1eptbK4c10a7J4O3y1MSMML07rMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSf3fPp0Zk2zx4zTo7fiZL4mTNG0sC+EFYqr0MYd6PyYedNAQu1RFPn8gRDpQ3dex
         uuFexazvcT7ynPh5i1UCWexoaG+qAPNuwsDIbB4V3/RQWaP7N1kbtHcx90UaCcZqtK
         e8c3xz8WJxe7VuGVNZuyOT9/Gk2k+qKf1rb4Dz9zCDuPS57hvzNt5WwRJHFj45iiVS
         6WjJam0kpRi6weAo9i/LJUl6zw52xpjxOB3a8CIlVYnP1TH4Z+TZDhVrxwS8TcDc6/
         v3t0ufqr1F6kIJaUUtIk/303Mvvv8u1ubEoPGOsyD+dmX4S4ZhQcYJYKLBK0+MWF6z
         wW7tIAKxiWnHw==
Date:   Fri, 14 Apr 2023 13:46:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] cacheinfo: Add arm64 early level initializer
 implementation
Message-ID: <20230414124633.GB27611@willie-the-truck>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-3-rrendec@redhat.com>
 <20230413102226.yzzd6iccqeamheas@bogus>
 <20230413144519.GA26421@willie-the-truck>
 <20230413150505.75g2dp6ra2ytfvpu@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413150505.75g2dp6ra2ytfvpu@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:05:05PM +0100, Sudeep Holla wrote:
> On Thu, Apr 13, 2023 at 03:45:22PM +0100, Will Deacon wrote:
> > On Thu, Apr 13, 2023 at 11:22:26AM +0100, Sudeep Holla wrote:
> > > Hi Will,
> > > 
> > > On Wed, Apr 12, 2023 at 02:57:58PM -0400, Radu Rendec wrote:
> > > > This patch adds an architecture specific early cache level detection
> > > > handler for arm64. This is basically the CLIDR_EL1 based detection that
> > > > was previously done (only) in init_cache_level().
> > > > 
> > > > This is part of a patch series that attempts to further the work in
> > > > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> > > > Previously, in the absence of any DT/ACPI cache info, architecture
> > > > specific cache detection and info allocation for secondary CPUs would
> > > > happen in non-preemptible context during early CPU initialization and
> > > > trigger a "BUG: sleeping function called from invalid context" splat on
> > > > an RT kernel.
> > > > 
> > > > This patch does not solve the problem completely for RT kernels. It
> > > > relies on the assumption that on most systems, the CPUs are symmetrical
> > > > and therefore have the same number of cache leaves. The cacheinfo memory
> > > > is allocated early (on the primary CPU), relying on the new handler. If
> > > > later (when CLIDR_EL1 based detection runs again on the secondary CPU)
> > > > the initial assumption proves to be wrong and the CPU has in fact more
> > > > leaves, the cacheinfo memory is reallocated, and that still triggers a
> > > > splat on an RT kernel.
> > > > 
> > > > In other words, asymmetrical CPU systems *must* still provide cacheinfo
> > > > data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
> > > > happen to have less leaves than the primary CPU). But symmetrical CPU
> > > > systems (the majority) can now get away without the additional DT/ACPI
> > > > data and rely on CLIDR_EL1 based detection.
> > > > 
> > > 
> > > If you are okay with the change, can I have your Acked-by, so that I can
> > > route this via Greg's tree ?
> > 
> > I really dislike the profileration of __weak functions in this file,
> 
> You mean in the generic cacheinfo.c right ? Coz arm64 version must not have
> any and that is the file in this patch.

Right, but we're providing implementations of both early_cache_level() and
init_cache_level(), which are weak symbols in the core code.

Will
