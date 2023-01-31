Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9536831D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjAaPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAaPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:49:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302318B0E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2D96151C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEF1C433EF;
        Tue, 31 Jan 2023 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675180197;
        bh=iJeEzqU61ETudd/26H20CF7VwrLvGyVEhOVWjRGFTFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRObx3cYosVBArRUGx3H86cpVC8vSJ88AKJf7qpGsFar4QPYj2zEWiL59YiLVtPeh
         QBrSv+6qrVJuOahGGjW0G5uhavZBkFxdpDoaUxjaRKM6dcsH8BkESPTSw82cSy9UjF
         tdSU1APONzmHeJkYlW5tvlxXrczJkwhMEzwj+0XrMddx11nqAjmt+tOZ4EORcYyAh0
         uPW6NoxZEpF/YB9nOHJXgFLEnY2ZQCt+g+P3Q8/rzDrNsyg0SZj+DYmuD+PQ6Tmail
         al4COReC6Ky16Q76+nd/1rRflOKYGCdxX1oGzhttt8OEiwy6/OnW2KADOdhulo6ZFK
         9GZ6ZVy6WwvaQ==
Date:   Tue, 31 Jan 2023 15:49:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <20230131154950.GB2646@willie-the-truck>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:43:17PM +0000, Robin Murphy wrote:
> On 2023-01-26 13:33, Will Deacon wrote:
> > On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
> > > On 1/9/23 10:58, Anshuman Khandual wrote:
> > > > Changing pfn on a user page table mapped entry, without first going through
> > > > break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> > > > to intercept such changes, via an updated pgattr_change_is_safe(). This new
> > > > check happens via __check_racy_pte_update(), which has now been renamed as
> > > > __check_safe_pte_update().
> > > > 
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > ---
> > > > This applies on v6.2-rc3. This patch had some test time on an internal CI
> > > > system without any issues being reported.
> > > 
> > > Gentle ping, any updates on this patch ? Still any concerns ?
> > 
> > I don't think we really got to the bottom of Mark's concerns with
> > unreachable ptes on the stack, did we? I also have vague recollections
> > of somebody (Robin?) running into issues with the vmap code not honouring
> > BBM.
> 
> Doesn't ring a bell, so either it wasn't me, or it was many years ago and
> about 5 levels deep into trying to fix something else :/

Bah, sorry! Catalin reckons it may have been him talking about the vmemmap.
Catalin -- any clues?

Will
