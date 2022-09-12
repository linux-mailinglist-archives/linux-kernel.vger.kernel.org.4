Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E35B626F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiILVDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiILVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2711F37F8E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72E561298
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1F1C433C1;
        Mon, 12 Sep 2022 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663016618;
        bh=QxeY48qWmriggvsOyHNPWAgUKEIV8SqgZoGQWtuS5Us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZtSG5aBaVkC2Akw+OB723wIAYcK9/Hf4iA7iHPCpxz5j95EcbMMWlifVyJNWhjzVk
         3/6eAK+s/LNSLbjPHF4gu7ZJH1LN+Du4UMKYgkavS3QZaeGmoyPtLJdHCc2irrJNjM
         O2nmlvB2qHGGINNX8jHL4dt9FDcsYAbxp5UhPA3E=
Date:   Mon, 12 Sep 2022 14:03:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of
 vm_next
Message-Id: <20220912140337.cccdea4cf67e4c4126ae158d@linux-foundation.org>
In-Reply-To: <Yx+QGOgHg1Wk8tGK@google.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
        <20220906194824.2110408-68-Liam.Howlett@oracle.com>
        <Yx7XzNBMbcdgTxa9@google.com>
        <20220912124559.f1f5c26b882325fe5e5c5cce@linux-foundation.org>
        <Yx+QGOgHg1Wk8tGK@google.com>
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

On Mon, 12 Sep 2022 14:01:28 -0600 Yu Zhao <yuzhao@google.com> wrote:

> The diff between the original patch and this one, in case you prefer to
> fix it atop rather than amend.

Always...

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a7c5d15c1618..cadcc3290918 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3776,7 +3776,10 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
>  	VM_WARN_ON_ONCE(mask & size);
>  	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
>  
> -	for_each_vma_range(vmi, args->vma, end) {
> +	for_each_vma(vmi, args->vma) {
> +		if (end && end <= args->vma->vm_start)
> +			return false;
> +
>  		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;

Thanks.

I added your signoff so I don't get a nastygram from Stephen in the
morning.  Please send along a suitable brief changelog?

