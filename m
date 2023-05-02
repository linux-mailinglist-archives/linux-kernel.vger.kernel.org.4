Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77E6F4817
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjEBQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjEBQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAB211F
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780BA61B63
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61AC433EF;
        Tue,  2 May 2023 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683043947;
        bh=BKP/NRP6Jh2ClPAIw8fJECtIwuk/nPYRuHSqf4IHEuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdUjNmOEWwlm2BPRV79WT1RROSt7DfOEcQK8/Fey6LK53l81rF9woUPh0Me7zzjMi
         IUcAzr9ylOXq6+JP/ZQygb76BVxnvZfP/TEEGRSBXkJ7RWssUNokajuPQbNFqAVUde
         ixLa7jx3mUB2vzAiOPTZn3/HkFxdrmqY3Y0Rl34S3561hnCTI8FoOTbsA5oRmQ1z9T
         7PXzCXpEpC85Z/On9c3Zb60+PrmlJZ1r/+DGuiOJPBsJ7G24vMq+aZHxR14hepRtJW
         KyXEAywQ/Yya7tCEdBBYXn+eKf7roJ76jazgBtqSn9FdgfBnQ+p7hIaUjNa3NBwc6p
         a5JHgLBZACQvQ==
Date:   Tue, 2 May 2023 19:12:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZFE2Xu3yTsk2e2BZ@kernel.org>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
 <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
 <ZFEZLZHBosQK9xaH@arm.com>
 <86pm7ihl0i.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86pm7ihl0i.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 03:21:17PM +0100, Marc Zyngier wrote:
> On Tue, 02 May 2023 15:07:41 +0100,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Mon, May 01, 2023 at 04:24:38PM -0500, Justin Forbes wrote:
> > > On Sat, Apr 29, 2023 at 11:02 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > Why the default MAX_ORDER was not acceptable on arm64 server machines but
> > > > it is fine on, say, x86 and s390?
> > > > I'm not asking how you made it possible in Fedora and RHEL, I'm asking why
> > > > did you switch from the default order at all.
> > > 
> > > Because the MAX_ORDER on aarch64 with 4K pages is more tuned to the
> > > needs of the average edge client, not so much those of a server class
> > > machine.  And I get it, I would say well over 90% of the Fedora users
> > > running aarch64 are indeed running on a rPi or similar with a small
> > > memory footprint, and workloads which match that.  But we do support
> > > and run a 4K page size aarch64 kernel on proper server class hardware,
> > > running typical server workloads, and RHEL has a lot more users in the
> > > server class than edge clients.   RHEL could probably default to 64K
> > > pages, and most users would be happy with that. Fedora certainly could
> > > not. 

The memory size of the machine or how heavy the workloads it runs have
nothing to do with MAX_ORDER. Again, x86 and s390 are perfectly fine with
MAX_ORDER == 10 ...

> > I was talking to Marc Zyngier earlier and he reckons the need for a
> > higher MAX_ORDER is the GIC driver ITS allocation for Thunder-X.

... but this indeed could be the reason to increase MAX_ORDER.

> > I'm happy to make ARCH_MAX_ORDER higher in defconfig (12, 13?) if
> > CONFIG_ARCH_THUNDER. Mobile vendors won't enable this platform.
> 
> In any case, I'd like to know exactly *what* requires it. The only
> platform I know would benefit from this is the old TX1, but this
> machine is more a boat anchor than a real server.

Yeah, if we'd knew what exactly requires such huge contiguous allocation,
we probably could fix that and leave Kconfig alone.
 
-- 
Sincerely yours,
Mike.
