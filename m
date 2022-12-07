Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C3646341
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLGVbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLGVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:31:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F035C76A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:31:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35C90B8216E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94117C433D6;
        Wed,  7 Dec 2022 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670448691;
        bh=LPL3OejPVlN3jUCkn4XnkSB7/HgPNJ+y0UjZbAqGIvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=duWk3uSoQ/+JDRWzo84+OmS7DGEUMZRHi7U//pmOq5m4Dma3pmLNIjwTjVBl2qJLU
         XFP01cC4ByAlLh34xBFOpI6vVLL3jZL0W3VXpqSOQL8j78BAzDot0df4Qekz4bp5Qe
         /4/aWgC4ceI9TsMC6TxDP4WJDivghC8C6RHV7MTw=
Date:   Wed, 7 Dec 2022 13:31:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, yuzhao@google.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jostarks@microsoft.com
Subject: Re: [PATCH v2] mm/gup: fix gup_pud_range() for dax
Message-Id: <20221207133130.f4894372d295f99fd4954255@linux-foundation.org>
In-Reply-To: <1670392853-28252-1-git-send-email-ssengar@linux.microsoft.com>
References: <1670392853-28252-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Dec 2022 22:00:53 -0800 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:

> From: John Starks <jostarks@microsoft.com>
> 
> For dax pud, pud_huge() returns true on x86. So the function works as long
> as hugetlb is configured. However, dax doesn't depend on hugetlb.
> Commit 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax") fixed
> devmap-backed huge PMDs, but missed devmap-backed huge PUDs. Fix this as
> well.
> 
> This fixes the below kernel panic:
> 
> ...
>
> Fixes: 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax")

Feb 2019.

> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c2c2c6d..e776540 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2765,7 +2765,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
>  		next = pud_addr_end(addr, end);
>  		if (unlikely(!pud_present(pud)))
>  			return 0;
> -		if (unlikely(pud_huge(pud))) {
> +		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
>  			if (!gup_huge_pud(pud, pudp, addr, next, flags,
>  					  pages, nr))
>  				return 0;

I assume this should be backported into -stable kernels?
