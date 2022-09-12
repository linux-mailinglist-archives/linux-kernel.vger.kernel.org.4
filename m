Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D85B61D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiILTqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B5C47B8B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A456B80D8B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742D5C433C1;
        Mon, 12 Sep 2022 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663011960;
        bh=htxr92E1RnmJ8ugZTVZs+mTLMDTYDJ5hbF5R6VSrAX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TMPdY9IStJBssLKeDMviuOwyv8zfHnUp8z/pm+d2f4MS1nJfqEAOJCXCeMggl2tnk
         iIR59TXFcSROOcvucsw9/+hKlgYqB3dgePKlzm/Z5cNCfVRnf/d51C4ZK8L43TB3u1
         /3PPpoE7L4hnsfzUe/FhP1j1K04Sfrb5jMdJaKa0=
Date:   Mon, 12 Sep 2022 12:45:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of
 vm_next
Message-Id: <20220912124559.f1f5c26b882325fe5e5c5cce@linux-foundation.org>
In-Reply-To: <Yx7XzNBMbcdgTxa9@google.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
        <20220906194824.2110408-68-Liam.Howlett@oracle.com>
        <Yx7XzNBMbcdgTxa9@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 00:55:08 -0600 Yu Zhao <yuzhao@google.com> wrote:

> 
> The following should work properly. Please take a look. Thanks!
> 
> ---
>  mm/vmscan.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 11a86d47e85e..b22d3efe3031 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3776,23 +3776,17 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
>  {
>  	unsigned long start = round_up(*vm_end, size);
>  	unsigned long end = (start | ~mask) + 1;
> +	VMA_ITERATOR(vmi, args->mm, start);
>  
>  	VM_WARN_ON_ONCE(mask & size);
>  	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
>  
> -	while (args->vma) {
> -		if (start >= args->vma->vm_end) {
> -			args->vma = args->vma->vm_next;
> -			continue;
> -		}
> -
> +	for_each_vma(vmi, args->vma) {
>  		if (end && end <= args->vma->vm_start)
>  			return false;
>  
> -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> -			args->vma = args->vma->vm_next;
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;
> -		}
>  
>  		*vm_start = max(start, args->vma->vm_start);
>  		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;

What does this apply to?  It's almost what is in mm-unstable/linux-next
at present?

static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk *args,
			 unsigned long *vm_start, unsigned long *vm_end)
{
	unsigned long start = round_up(*vm_end, size);
	unsigned long end = (start | ~mask) + 1;
	VMA_ITERATOR(vmi, args->mm, start);

	VM_WARN_ON_ONCE(mask & size);
	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));

	for_each_vma_range(vmi, args->vma, end) {
		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
			continue;

		*vm_start = max(start, args->vma->vm_start);
		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;

		return true;
	}

	return false;
}

for_each_vma_range versus for_each_vma.
