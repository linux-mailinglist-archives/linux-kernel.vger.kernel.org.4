Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FF6BBFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCOWUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:20:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC211E96
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:20:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m35so3990329wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678918848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy2xay+QSUr4LgGqR0bhvHEFtaFjUeaP9/Kp4kYC9Bo=;
        b=VK2E0LRRwXPvr2BrU58q54QsjK/IXgxcnzSYcW3VRPEBLaf54GioNZ05oSTd/ucR2t
         rQhg7TEAd4eFqrVoliQ2odDOKXJi1lBxfmMMwvPtX1ozJ9ia28d0RIO2piNfpssTm6wi
         6sUn4xQ3vqT4WXgqDY/eeT4HvB1UYtDs+k1Y4N53aF58yks2SeZxQnykVS91L3W0zdXS
         S1e/rt4z4fTHdgS3UPw8wFKgcdGGITR33ubTe/OGm87rcfUk+RAhJRTQU6Qds6yHc+RT
         9NknRhvy2ou9cEh8IkYTNmtVqrtaEsgIvbBoTexX/Q5jhSsuRmvE1tpRndSC5HLo/4cz
         wbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy2xay+QSUr4LgGqR0bhvHEFtaFjUeaP9/Kp4kYC9Bo=;
        b=VAEln5LIDJV7VWUGuDC7YuXLZjqIqVak9GwTzJLAbtDglBH1Sykh8lYJS7gK8m3FFR
         EfSUZq1jVaaLmQ2ssq/BaSwnjY10CxWowDHnXNlv2UFUDiOpa38WbVyi4W0a5Gw5suWG
         DJXb+xd/Pnfm8PqufxdbU1RSb4GAaHmHFpQZztHsMoLW6pIMXhRud0mA1iNgT/jmG7B9
         1Ir8ktlxQL7uPe6lw1cehg+uNaDH9RfWzeP2SOM20nv5DTK+bekrMhHZAOXmRsV726hk
         PqyBSUruZicTcsqbyUqthAqAiTtJMW/xCdEoMWdR+lPqHbI7200FwNiZ05UvTsA83cn2
         Y6Lw==
X-Gm-Message-State: AO0yUKU/MpZ2VHs3NcGqh8vT/ycjbV0yI9jEwSIHFW2CcM8KBnJ9oABU
        b2kxnM5U/YUjF/vO5X2aYIA=
X-Google-Smtp-Source: AK7set+NT9e2NIMUlIy8tS9ZTx0pBweJ9iVltZKFNL5/Duj3rL8QABA5ZO6mvjxWUXtFQ/KfR9truw==
X-Received: by 2002:a05:600c:354f:b0:3eb:395b:19dc with SMTP id i15-20020a05600c354f00b003eb395b19dcmr19390422wmq.9.1678918848183;
        Wed, 15 Mar 2023 15:20:48 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id t8-20020a1c7708000000b003ed2276cd0dsm3057428wmi.38.2023.03.15.15.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:20:47 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:20:46 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 10/10] mm/mremap: simplify vma expansion again
Message-ID: <7a9ca4a6-9713-4e31-9c0f-11ec31817c7a@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-11-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-11-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:58PM +0100, Vlastimil Babka wrote:
> This effectively reverts d014cd7c1c35 ("mm, mremap: fix mremap()
> expanding for vma's with vm_ops->close()"). After the recent changes,
> vma_merge() is able to handle the expansion properly even when the vma
> being expanded has a vm_ops->close operation, so we don't need to
> special case it anymore.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mremap.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 411a85682b58..65f5b545601e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1040,23 +1040,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  			 * vma (expand operation itself) and possibly also with
>  			 * the next vma if it becomes adjacent to the expanded
>  			 * vma and  otherwise compatible.
> -			 *
> -			 * However, vma_merge() can currently fail due to
> -			 * is_mergeable_vma() check for vm_ops->close (see the
> -			 * comment there). Yet this should not prevent vma
> -			 * expanding, so perform a simple expand for such vma.
> -			 * Ideally the check for close op should be only done
> -			 * when a vma would be actually removed due to a merge.
>  			 */
> -			if (!vma->vm_ops || !vma->vm_ops->close) {
> -				vma = vma_merge(&vmi, mm, vma, extension_start,
> -					extension_end, vma->vm_flags, vma->anon_vma,
> -					vma->vm_file, extension_pgoff, vma_policy(vma),
> -					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -			} else if (vma_expand(&vmi, vma, vma->vm_start,
> -					addr + new_len, vma->vm_pgoff, NULL)) {
> -				vma = NULL;
> -			}
> +			vma = vma_merge(&vmi, mm, vma, extension_start,
> +				extension_end, vma->vm_flags, vma->anon_vma,
> +				vma->vm_file, extension_pgoff, vma_policy(vma),
> +				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  			if (!vma) {
>  				vm_unacct_memory(pages);
>  				ret = -ENOMEM;
> --
> 2.39.2
>

Good to eliminate this edge case! Do we have a self-test for this case to assert
that the issue is fixed by this? I guess a little tricky due to the need for the
the owning VMA to have ->close() specified.

In any case, the changes you have made in the previous patch should ensure the
edge case is no longer required, hence:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
