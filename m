Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE0736816
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjFTJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFTJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01629F4;
        Tue, 20 Jun 2023 02:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FFD9610A4;
        Tue, 20 Jun 2023 09:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9221CC433C0;
        Tue, 20 Jun 2023 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687254200;
        bh=6oeF6a+qDZQKIjfNYqErcjrR99tDz0LU1eFA0vcSj2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DntMnlmr05Q4Af/qskNpRrqTRUVPpvU/rCT1orGUnSxUsRcfEE5YfV02/SYqU0EJD
         9IPqbg060++JbTdnszcYiO18a1cbgTj6VTKdKBCOGR8liUs3c8OWUnkj5ZfDWRRNSs
         OONacyHuGhZmKsFjpzKaKP02AiZsW3uPtXWS6uXbF71ZCmsqP2CxpaPQJ8DC7rnDFv
         HqAz3mzM3ebEu9orrpVxyZFwRLj69mrdVQwscfdsG8tb00q1uwIE672GmvXl3Ad2oY
         3cqhgFJThMG7Sx66K4h1rPgBseFRTRck/SeWFADVt0ASZR77uHdAcgwNEcioTNIu2B
         Dz570pfG4JWag==
Date:   Tue, 20 Jun 2023 10:43:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        catalin.marinas@arm.com
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230620094314.GA14607@willie-the-truck>
References: <20230619092355.133c5cdb@canb.auug.org.au>
 <20230619204309.GA13937@willie-the-truck>
 <20230619143944.fb445cb3f28bb839942ed4ae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619143944.fb445cb3f28bb839942ed4ae@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 02:39:44PM -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2023 21:43:11 +0100 Will Deacon <will@kernel.org> wrote:
> 
> > >   	/*
> > >   	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
> > >   	 * VM_GROWSUP VMA. Such VMAs can change their size under
> > 
> > This resolution seems to be causing horrible problems on arm64 with 16k
> > pages. I see things like the crash below, but the two branches being merged
> > are fine on their own.
> 
> I've dropped the mm.git side of this conflict so next -next should
> be better.

Thanks, Andrew. next-20230620 is still broken, so I came up with the diff
below in the meantime which seems to resolve the crashes. I don't pretend
to understand the VMA iterator stuff well enough though, so I may have
missed something else.

Will

--->8

diff --git a/mm/mmap.c b/mm/mmap.c
index 9a93b054148a..4c82e9b36fb3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2396,6 +2396,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
                        if (error)
                                goto end_split_failed;
                }
+               mas_set(&mas_detach, count);
                vma_start_write(next);
                if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
                        goto munmap_gather_failed;
