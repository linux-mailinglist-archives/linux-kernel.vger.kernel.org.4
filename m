Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596AB68F635
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjBHR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBHR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:56:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB2886A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:56:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 393DA1477;
        Wed,  8 Feb 2023 09:28:14 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF383F8C6;
        Wed,  8 Feb 2023 09:27:30 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:27:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <Y+PbfGow2q0Oud3M@FVFF77S0Q05N.cambridge.arm.com>
References: <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck>
 <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
 <Y9uUO9AadE+8ik/0@arm.com>
 <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
 <20230203101023.GA5597@willie-the-truck>
 <93461768-791A-45BE-BEF2-344CC5228C92@linux.dev>
 <20230207143131.GA12475@willie-the-truck>
 <FB3AE2F1-2EF8-4960-884E-DABA7E64CE59@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB3AE2F1-2EF8-4960-884E-DABA7E64CE59@linux.dev>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:13:46AM +0800, Muchun Song wrote:
> > On Feb 7, 2023, at 22:31, Will Deacon <will@kernel.org> wrote:
> > On Mon, Feb 06, 2023 at 11:28:12AM +0800, Muchun Song wrote:
> >> I am not familiar with ARM64, what's the user-visible effect if this
> >> "amalgamation" occurs?
> > 
> > The user-visible effects would probably be data corruption and instability,
> > since the amalgamated TLB entry could result in a bogus physical address and
> > bogus permissions.
> 
> You mean the output address of amalgamated TLB entry is neither the old
> address (before updated) nor the new address (after updated)?

Yes, that is one possible result.

> So it is a bogus physical address?

Yes, that is one possible result.

> Is there any specifications to describe the rules of how to create a
> amalgamated TLB entry? Thanks.

Unfortunately, this is not clearly specified in the ARM ARM, and we have to
take a pessimistic reading here. We assume that amalgamation is some arbitrary
function of the TLB entries which are hit (e.g. they might be OR'd together).
This is something that I'd like to have clarified further by Arm's architects.

The important thing to note is that amalgamation applies to *TLB entries*, not
the translation table entries that they were derived from. Since the TLB format
is micro-architecture dependent, and since the manner in which they might be
combined is arbitrary, the results of combining could be arbitrary (and
consequently, this is difficult to specify).

The architecture *does* provide a few restrictions (e.g. Stage-1 entries within
a VM can't escape Stage-2, NS entries can't create a secure physical address),
but beyond that we cannot make any assumptions.

So e.g. if you have 2 read-only entries for addresses A and B, amalgamation
could result in read-write-execute for a distinct address C.

It's not clear to me whether that could also affect hits for unrelated VAs.

So the short answer is that we have to treat this as CONSTRAINED UNPREDICTABLE,
and must avoid potential amalgamation by using Break-Before-Make.

Thanks,
Mark.
