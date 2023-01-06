Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F342966059C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjAFRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjAFRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689517D9C3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C3861EBA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D60C433D2;
        Fri,  6 Jan 2023 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025827;
        bh=AwyUBMt2K+2WekTeSn6jMv9BpnWBDC8Aaa/wrQ3tyK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aADRfMLQVEdU+XpDI4eDbnxHsiw+h9BZU9DKWnob3lhB8dRHQfQxlHP0RNw49yl6S
         tdhvKJvtT5NoSqUSbjFFY9TeFLb341BM2pEZliR9H+WzbSZ3E1mbBILjKDXWB0lKCg
         vsUY9K1my06hUR70qsABNLlv7/3h4duZyhRtMA1srXjh8V+kRMSG0W9vtNt6et3Zd/
         RI2aQdsLz5/acP8vXACyB3Xw1q5dDE3NhGwLULXRPUEdE69GcGa5Rq5h+N2tJdilYj
         ujDsq7W3fMj2OypO+qk6aYrNjZaUCnGzJ8Foz3wWlPxPH69gZHsTJFrrLWvt3yh9fk
         abuwGEO6FiZrA==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 25/44] mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
Date:   Fri,  6 Jan 2023 17:23:45 +0000
Message-Id: <20230106172345.149991-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105191517.3099082-26-Liam.Howlett@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On Thu, 5 Jan 2023 19:15:59 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Drop the vmi_* functions and transition all users to use the vma
> iterator directly.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  fs/userfaultfd.c   | 14 ++++----
>  include/linux/mm.h | 16 +++-------
>  mm/madvise.c       |  6 ++--
>  mm/mempolicy.c     |  6 ++--
>  mm/mlock.c         |  6 ++--
>  mm/mmap.c          | 79 +++++++++++++---------------------------------
>  mm/mprotect.c      |  6 ++--
>  mm/mremap.c        |  2 +-
>  8 files changed, 47 insertions(+), 88 deletions(-)
[...]
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2830,22 +2830,16 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
[...]
> -extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
> -	struct vm_area_struct *, unsigned long addr, int new_below);
> -extern int split_vma(struct mm_struct *, struct vm_area_struct *,
> -	unsigned long addr, int new_below);
> -extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
> -		struct vm_area_struct *, unsigned long addr, int new_below);
> +extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
> +		       unsigned long addr, int new_below);
> +extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
> +			 unsigned long addr, int new_below);

I just found this change for split_vma() is applied to !CONFIG_MMU, which the
definition of split_vma() is not changed, so cause a build error.  I posted a
simple fix for that:
https://lore.kernel.org/linux-mm/20230106171857.149918-1-sj@kernel.org/


Thanks,
SJ

[...]
