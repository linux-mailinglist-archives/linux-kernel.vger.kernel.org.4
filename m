Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAF725841
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjFGIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbjFGIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD8170E;
        Wed,  7 Jun 2023 01:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D8D614F8;
        Wed,  7 Jun 2023 08:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5AFC433EF;
        Wed,  7 Jun 2023 08:45:43 +0000 (UTC)
Date:   Wed, 7 Jun 2023 09:45:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZIBDtHHrXg1kDpM3@arm.com>
References: <20230606114927.227a66a5@canb.auug.org.au>
 <20230607110521.442280f9@canb.auug.org.au>
 <ZIAWwXp4IQUIlCzq@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIAWwXp4IQUIlCzq@linux.dev>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:33:53AM +0000, Oliver Upton wrote:
> On Wed, Jun 07, 2023 at 11:05:21AM +1000, Stephen Rothwell wrote:
> > On Tue, 6 Jun 2023 11:49:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Today's linux-next merge of the kvm-arm tree got a conflict in:
> > > 
> > >   arch/arm64/kernel/cpufeature.c
> > > 
> > > between commits:
> > > 
> > >   b7564127ffcb ("arm64: mops: detect and enable FEAT_MOPS")
> > >   c1fa32c8f189 ("arm64: cpufeature: add TCR2 cpucap")
> > >   b5a8e35236ee ("arm64: cpufeature: add Permission Indirection Extension cpucap")
> > > 
> > > from the arm64 tree and commit:
> > > 
> > >   c876c3f182a5 ("KVM: arm64: Relax trapping of CTR_EL0 when FEAT_EVT is available")
> > > 
> > > from the kvm-arm tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > 
> > Commit b5a8e35236ee changed a bit, so the new resolution is below.

Thanks Stephen. I regenerated the arm64 for-next/feat_s1pie branch since
the old one was not archived on lore. While doing that, there were some
minor fixups.

> Catalin, I'm  only planning on dragging in the MOPS branch as needed
> due to some more involved conflicts that'll arise from KVM ID register
> changes. Otherwise the resolution seems trivial enough and doesn't need
> to be explicitly dealt with. Still learning the ropes, so all ears if
> anyone disagrees :)

If there are trivial conflicts, we usually leave them in (Linus doesn't
mind). For anything non-obvious, feel free to pull the relevant branches
from the arm64 tree into the KVM one. I don't plan to rebase any of them
now.

-- 
Catalin
