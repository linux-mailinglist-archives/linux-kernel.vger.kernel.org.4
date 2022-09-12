Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F05B54D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiILGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:55:14 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB614017
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:55:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l6so4056323ilk.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4pMPwNvVevZNhk27lR3p0xv0y18JXq8wa62PlMo+hPM=;
        b=ddKn14bst9cnIk856qHZXlimuRbkFGg/EvwNVnIoC8zLO8iqkEeZAyna4l2XGkCSgJ
         PVCdtslj9Evj07UC11FaWWYz6ME7PcPCFxedWHBx7OSpoBJNua/qCTen9tmPvNByRW0K
         CjvZijnvY9gAkHuGES6IOei6PebgiUmW3dZBWn7VKfputiRDb14CeY80QaNn/CJ7niFU
         YIbyRXryf6Ux/1cClJoDxFiJixEK06BEqNl8zHjFa867LpyLD4SKuM072JJI7Xwt7xRG
         /tjP1815xvqFpkEmPrQp9bRv6nXJrvKpuDLdZsGSCZ9idiPdsMoPT3Sqwrmpb4a4ZV2u
         554g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4pMPwNvVevZNhk27lR3p0xv0y18JXq8wa62PlMo+hPM=;
        b=5HemeIN2pi3YmaK4GXK8T5d1XR6lkO7pnVHchzizdlTCDwyLE+RPHCl7nPnjpsKsb7
         2l922Xrfz7e6tXBx0gZKXDWBT3toysJYW3cF6NrqDAReuTcp14g7xFjICM3fohdK80Si
         LLVSOKSyj79qxdcDDP/GmjEMYiqZQQVmsMWrQ5ByRmSxkcpinFzeoKR5By3LWuD9vYk/
         y0nmtHnh5Me1Arnt1J4PGXWwV5hw+p9YrdSdV4g0OCSBQYA9pN+sYtkYuJ0SlaPiVdC7
         9U5786PtfFpo/NE/aRMQXSGLvhsbANASIpPBTuA0mSTF6jePt7byjxge1HUeroVqHNm3
         QhFQ==
X-Gm-Message-State: ACgBeo2wTpPEjwkMj+ToLMZczzXV0VAdiIGICAIquzwKPwa6HV6dBJBA
        FQMjPNrRr/UAqSbchxJKVZABpw==
X-Google-Smtp-Source: AA6agR4BWjFkXAuzYlzFTwGho9Xk2t55e+hc64mIiQLG6aYr+Zwqb21o/ieUKlghos9JiQvvi1hzGA==
X-Received: by 2002:a92:d387:0:b0:2f1:7a20:6097 with SMTP id o7-20020a92d387000000b002f17a206097mr9680231ilo.281.1662965712435;
        Sun, 11 Sep 2022 23:55:12 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:50c7:aba9:8225:aea8])
        by smtp.gmail.com with ESMTPSA id 184-20020a021dc1000000b00349ccc2db88sm3299332jaj.101.2022.09.11.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:55:12 -0700 (PDT)
Date:   Mon, 12 Sep 2022 00:55:08 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Message-ID: <Yx7XzNBMbcdgTxa9@google.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-68-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906194824.2110408-68-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 07:49:05PM +0000, Liam Howlett wrote:
> Use the vma iterator in in get_next_vma() instead of the linked list.
> 
> Suggested-by: Yu Zhao <yuzhao@google.com>

Apologies for the bad suggestion.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3776,23 +3776,14 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
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
> +	for_each_vma_range(vmi, args->vma, end) {
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;
> -		}
> -
> -		if (end && end <= args->vma->vm_start)
> -			return false;

Here the original code leaves args->vma pointing the first vma out of
the range [start, end). This allows the caller (page table walker) to
resume at that vma, if it chooses to.

With for_each_vma_range(), under the same condition, args->vma is set to
NULL. And the page table walker may terminate prematurely. Apparently I
overlooked until I was told MGLRU in mm-unstable is slower than itself
on 6.0-rc4 yesterday.

> -
> -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> -			args->vma = args->vma->vm_next;
> -			continue;
> -		}
>  
>  		*vm_start = max(start, args->vma->vm_start);
>  		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;

The following should work properly. Please take a look. Thanks!

---
 mm/vmscan.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 11a86d47e85e..b22d3efe3031 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3776,23 +3776,17 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
 {
 	unsigned long start = round_up(*vm_end, size);
 	unsigned long end = (start | ~mask) + 1;
+	VMA_ITERATOR(vmi, args->mm, start);
 
 	VM_WARN_ON_ONCE(mask & size);
 	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
 
-	while (args->vma) {
-		if (start >= args->vma->vm_end) {
-			args->vma = args->vma->vm_next;
-			continue;
-		}
-
+	for_each_vma(vmi, args->vma) {
 		if (end && end <= args->vma->vm_start)
 			return false;
 
-		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
-			args->vma = args->vma->vm_next;
+		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
 			continue;
-		}
 
 		*vm_start = max(start, args->vma->vm_start);
 		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
-- 
2.37.2.789.g6183377224-goog
