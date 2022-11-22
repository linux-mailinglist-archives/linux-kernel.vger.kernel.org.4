Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6E633932
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiKVJ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiKVJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:57:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255611580C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:57:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CEA6160D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8435C433C1;
        Tue, 22 Nov 2022 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669111074;
        bh=sHy129/fTPTMr30ytMQ+Mv9Fw9nOip00sz2ioeenqe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRip4teqKgeKP+0ivwczuYPgAJsQCkKxSnO6hdzTi3VzSD+KuBuNqdeHE7yqi6SXN
         +FsKYRE6BwO/U8R2Gyqb37Txcn0Y0EROO4vEh7a+ikRvBvq70vSdUzvWeF+p8rHKJG
         tZ9wC/KQyyAohjkcXErUASOIjFzmKrTYPnxEpwissxK8dx4skQva5OHdMupe+rZ4kq
         S2QbP3u7wfMockFVFWmkaJtv/EK9QCkbc8eWajKych2+7mI8mVfCJjbfz04KQHIJj3
         Ytc2LVq3YRNQ7rn2RgvSKBZiaHdhxRSBWtva4IXrLRkUNQq0ae7h6PhpJ1X0TzVR7O
         6pXLSY33E9yKw==
Date:   Tue, 22 Nov 2022 09:57:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <20221122095748.GA19471@willie-the-truck>
References: <20221116031001.292236-1-anshuman.khandual@arm.com>
 <20221118141317.GF4046@willie-the-truck>
 <879e561c-e834-196c-b9c5-6e44ac2c0296@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879e561c-e834-196c-b9c5-6e44ac2c0296@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 01:43:17PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/18/22 19:43, Will Deacon wrote:
> > On Wed, Nov 16, 2022 at 08:40:01AM +0530, Anshuman Khandual wrote:
> >> Changing pfn on a user page table mapped entry, without first going through
> >> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> >> to intercept such changes, via an updated pgattr_change_is_safe(). This new
> >> check happens via __check_racy_pte_update(), which has now been renamed as
> >> __check_safe_pte_update().
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com> 
> >> Cc: Andrew Morton <akpm@linux-foundation.org> 
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This applies on v6.1-rc4
> >>
> >>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
> >>  arch/arm64/mm/mmu.c              | 8 +++++++-
> >>  2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > I remember Mark saying that BBM is sometimes violated by the core code in
> > cases where the pte isn't actually part of a live pgtable (e.g. if it's on
> > the stack or part of a newly allocated table). Won't that cause false
> > positives here?
> 
> Could you please elaborate ? If the pte is not on a live page table, then
> pte_valid() will return negative on such entries. So any update there will
> be safe. I am wondering, how this change will cause false positives which
> would not have been possible earlier.

I don't think pte_valid() will always return false for these entries.
Consider, for example, ptes which are valid but which live in a table that
is not reachable by the MMU. I think this is what Mark had in mind, but it
would be helpful if he could chime in with the specific example he ran into.

Will
