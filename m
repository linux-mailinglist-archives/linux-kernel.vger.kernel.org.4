Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725F075031E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGLJbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGLJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:31:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 867FB12F;
        Wed, 12 Jul 2023 02:31:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97302F4;
        Wed, 12 Jul 2023 02:32:04 -0700 (PDT)
Received: from [10.57.78.6] (unknown [10.57.78.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B5353F73F;
        Wed, 12 Jul 2023 02:31:21 -0700 (PDT)
Message-ID: <67f68464-cc1f-dea3-6850-a1cad190073a@arm.com>
Date:   Wed, 12 Jul 2023 10:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mlock: Fix vma iterator conversion of
 apply_vma_lock_flags()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     stable@vger.kernel.org
References: <20230711175020.4091336-1-Liam.Howlett@oracle.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230711175020.4091336-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 18:50, Liam R. Howlett wrote:
> apply_vma_lock_flags() calls mlock_fixup(), which could merge the VMA
> after where the vma iterator is located.  Although this is not an issue,
> the next iteration of the loop will check the start of the vma to be
> equal to the locally saved 'tmp' variable and cause an incorrect failure
> scenario.  Fix the error by setting tmp to the end of the vma iterator
> value before restarting the loop.
> 
> There is also a potential of the error code being overwritten when the
> loop terminates early.  Fix the return issue by directly returning when
> an error is encountered since there is nothing to undo after the loop.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Link: https://lore.kernel.org/linux-mm/50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com/
> Cc: <stable@vger.kernel.org>
> Fixes: 37598f5a9d8b ("mlock: convert mlock to vma iterator")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Wow; thanks for the quick fix! I've tested this on arm64/v6.4 with the failing
mm selftests that I reported: they are now passing.

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/mlock.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index d7db94519884..0a0c996c5c21 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -477,7 +477,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  {
>  	unsigned long nstart, end, tmp;
>  	struct vm_area_struct *vma, *prev;
> -	int error;
>  	VMA_ITERATOR(vmi, current->mm, start);
>  
>  	VM_BUG_ON(offset_in_page(start));
> @@ -498,6 +497,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  	nstart = start;
>  	tmp = vma->vm_start;
>  	for_each_vma_range(vmi, vma, end) {
> +		int error;
>  		vm_flags_t newflags;
>  
>  		if (vma->vm_start != tmp)
> @@ -511,14 +511,15 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  			tmp = end;
>  		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
>  		if (error)
> -			break;
> +			return error;
> +		tmp = vma_iter_end(&vmi);
>  		nstart = tmp;
>  	}
>  
> -	if (vma_iter_end(&vmi) < end)
> +	if (tmp < end)
>  		return -ENOMEM;
>  
> -	return error;
> +	return 0;
>  }
>  
>  /*

