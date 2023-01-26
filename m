Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B667CC42
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjAZNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:33:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4342366B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:33:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96391B81DBA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F89C4339B;
        Thu, 26 Jan 2023 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674740007;
        bh=FGSIFVU34jKnm+toA0TeJxF3iSkMG5aKx0f/X0mWguc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ri9Id6y6AHGxT+k7wUmUrBk0Eu5hkv2CgE7cKuCvopNFCNkixe+9yBS+Dh1QvRh/N
         XWGrQJaJHHBN4qWV77R7Q5Nwnv+BkqqqJfHTogsBpfYP+dH76iGe6ERgPIZjjyZJMm
         1cIVyuwRi4qlucyIfN40v3F5FbuQLN6a50XBNXa5DmifaL7sL8Y1padxYOvxgNWG4y
         NthEB/B0EOtgD6uDmftqGjh6Rx5oQtXLulXRJ2ytSqSJyD4SgHT3qONyWndiG4jlok
         5Rg4J0SN8GHd7nTvFOuEcWr+vx78MuBcOFQTdg2jyD5WU41CUQsjDt5mTVTSkMmW+G
         /pzUgcVUKCVUg==
Date:   Thu, 26 Jan 2023 13:33:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robin.murphy@arm.com
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <20230126133321.GB29148@willie-the-truck>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
> On 1/9/23 10:58, Anshuman Khandual wrote:
> > Changing pfn on a user page table mapped entry, without first going through
> > break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> > to intercept such changes, via an updated pgattr_change_is_safe(). This new
> > check happens via __check_racy_pte_update(), which has now been renamed as
> > __check_safe_pte_update().
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v6.2-rc3. This patch had some test time on an internal CI
> > system without any issues being reported.
> 
> Gentle ping, any updates on this patch ? Still any concerns ?

I don't think we really got to the bottom of Mark's concerns with
unreachable ptes on the stack, did we? I also have vague recollections
of somebody (Robin?) running into issues with the vmap code not honouring
BBM.

So I think we should confirm/fix the vmap issue before we enable this check
and also try to get some testing coverage to address Mark's worries. I think
he has a syzkaller instance set up, so that sound like a good place to
start.

Will
