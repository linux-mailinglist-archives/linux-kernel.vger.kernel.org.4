Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74F17072EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEQUX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA87ABB;
        Wed, 17 May 2023 13:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C6A64B03;
        Wed, 17 May 2023 20:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88929C433D2;
        Wed, 17 May 2023 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684355002;
        bh=AjsQOG0MykYnMxLHdltKAUap2Wv/krluksbvS6JbP6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z1HgqTYWcr5kftNDrCqxuvLuR40gWmjvgEUFp3xU+PeDg6O6vg2bCYxeQW292QEzd
         8wwRCC3aQu12x8lde6UJszuGLHkqI+tb19NUU43qFoD6iQ/Pl7IBRcX69VS2cPYdm5
         ohLq8y5Mv3OhHUi2uRx7QJe5gcEPHE1WVI5Y2BO8=
Date:   Wed, 17 May 2023 13:23:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-Id: <20230517132321.2466ef1ccde9e8d05436e3f2@linux-foundation.org>
In-Reply-To: <20230517190916.3429499-2-peterx@redhat.com>
References: <20230517190916.3429499-1-peterx@redhat.com>
        <20230517190916.3429499-2-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 15:09:15 -0400 Peter Xu <peterx@redhat.com> wrote:

> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge() by Lorenzo Stoakes:
> 
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> 
> It's possible that "start" is contained within vma but not clamped to its
> start.  We need to convert this into either "cannot merge" case or "can
> merge" case 4 which permits subdivision of prev by assigning vma to
> prev. As we loop, each subsequent VMA will be clamped to the start.
> 
> This patch will eliminate the report and make sure vma_merge() calls will
> become legal again.
> 
> One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> to help explain where the warning can start to trigger, the real commit to
> fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> issue, but unfortunately we may want to keep it in Fixes too just to ease
> kernel backporters for easier tracking.
> 
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")

I don't know how -stable maintainers are to handle more than a single
Fixes: target, given that Fixes: means "kernels which have that patch
need this one".  Can we narrow this down to a single commit for this
purpose?


