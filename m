Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D406E1047
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDMOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDMOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48BB75F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A01E060F3C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA5EC433EF;
        Thu, 13 Apr 2023 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397127;
        bh=xrdv4Z7PA0F+WTeFeKIaPEng4KjDHdC2Dt/i176IcB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPM2nFoFiNNXItqdew/HTsNfivJl5f79eXUDzgdTldb6se9vsz4u1gh59Fdm4k5Hg
         Xizy9eZJOmzJERDdtBDAM4mWUo0UAeFuFZe+1uw5/AaMZRxoR+1HQDqVYuVHzRjgmD
         SHc/gVfZqs43RxNrm15jvGqGGqzfVPtxRcRYRe/goJHTZRsRUjXxfCSvNzFaH7M6bt
         yvvTcp4IpGWRDW1NiirrROj731r3X7EfnbhzMr2fnSotD/SKyqr2kMiPaFHOFAEdMP
         Xpu05z37iYesguUL+RLEt4oN3tSDJmeUKXZH3gprSrLcaSAQtIFF8ZsTJ1+dE641N4
         fYuAz8PrgiHQQ==
Date:   Thu, 13 Apr 2023 15:45:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] cacheinfo: Add arm64 early level initializer
 implementation
Message-ID: <20230413144519.GA26421@willie-the-truck>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-3-rrendec@redhat.com>
 <20230413102226.yzzd6iccqeamheas@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413102226.yzzd6iccqeamheas@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:22:26AM +0100, Sudeep Holla wrote:
> Hi Will,
> 
> On Wed, Apr 12, 2023 at 02:57:58PM -0400, Radu Rendec wrote:
> > This patch adds an architecture specific early cache level detection
> > handler for arm64. This is basically the CLIDR_EL1 based detection that
> > was previously done (only) in init_cache_level().
> > 
> > This is part of a patch series that attempts to further the work in
> > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> > Previously, in the absence of any DT/ACPI cache info, architecture
> > specific cache detection and info allocation for secondary CPUs would
> > happen in non-preemptible context during early CPU initialization and
> > trigger a "BUG: sleeping function called from invalid context" splat on
> > an RT kernel.
> > 
> > This patch does not solve the problem completely for RT kernels. It
> > relies on the assumption that on most systems, the CPUs are symmetrical
> > and therefore have the same number of cache leaves. The cacheinfo memory
> > is allocated early (on the primary CPU), relying on the new handler. If
> > later (when CLIDR_EL1 based detection runs again on the secondary CPU)
> > the initial assumption proves to be wrong and the CPU has in fact more
> > leaves, the cacheinfo memory is reallocated, and that still triggers a
> > splat on an RT kernel.
> > 
> > In other words, asymmetrical CPU systems *must* still provide cacheinfo
> > data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
> > happen to have less leaves than the primary CPU). But symmetrical CPU
> > systems (the majority) can now get away without the additional DT/ACPI
> > data and rely on CLIDR_EL1 based detection.
> > 
> 
> If you are okay with the change, can I have your Acked-by, so that I can
> route this via Greg's tree ?

I really dislike the profileration of __weak functions in this file,
rather than the usual approach of having arch-specific static inlines in
a header file but it seems that nobody has the appetite to clean that up :(

So I'm fine for Greg to queue this if he wants to, but I'd be a lot more
excited if somebody tidied things up a bit first.

Will
