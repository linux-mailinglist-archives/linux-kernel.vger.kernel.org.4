Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC667E93A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjA0PRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjA0PRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:17:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DD77C177
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:16:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 319972B;
        Fri, 27 Jan 2023 07:17:38 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79113F64C;
        Fri, 27 Jan 2023 07:16:54 -0800 (PST)
Date:   Fri, 27 Jan 2023 15:16:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robin.murphy@arm.com
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <Y9Pq5JAhfsdIwRsr@FVFF77S0Q05N>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126133321.GB29148@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:33:22PM +0000, Will Deacon wrote:
> On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
> > On 1/9/23 10:58, Anshuman Khandual wrote:
> > > Changing pfn on a user page table mapped entry, without first going through
> > > break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> > > to intercept such changes, via an updated pgattr_change_is_safe(). This new
> > > check happens via __check_racy_pte_update(), which has now been renamed as
> > > __check_safe_pte_update().
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > > This applies on v6.2-rc3. This patch had some test time on an internal CI
> > > system without any issues being reported.
> > 
> > Gentle ping, any updates on this patch ? Still any concerns ?
> 
> I don't think we really got to the bottom of Mark's concerns with
> unreachable ptes on the stack, did we? I also have vague recollections
> of somebody (Robin?) running into issues with the vmap code not honouring
> BBM.
> 
> So I think we should confirm/fix the vmap issue before we enable this check
> and also try to get some testing coverage to address Mark's worries. I think
> he has a syzkaller instance set up, so that sound like a good place to
> start.

I've thrown my Syzkaller instance at this patch; if it doesn't find anything by
Monday I reckon we should pick this up.

That said, I had some minor nits on the patch; I'm not sure if you'd be happy
to apply the suggested changes when applying or if you'd prefer that Anshuman
applies those locally and sense a v3.

Thanks,
Mark.
