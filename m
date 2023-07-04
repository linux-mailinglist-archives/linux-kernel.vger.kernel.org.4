Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8374776D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjGDRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C509E70
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A143612F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C828C433C7;
        Tue,  4 Jul 2023 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688490349;
        bh=EHnWzHDuJUTw0Pw5eMhRe3eZnnHetbaAkd4tQqIIqaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HtVKqhxeFf3El0FfxmkM7WWfBMeOQttBDhPoYNWjA2NkE4Bo/5vKYr054IPH3boNU
         aedPlBeJKNhKqDuCZ6gAzMBSZffvzFVpuyb6s7dQb0QInF85P7o2j5GYu2gFScnNmL
         Hnj9Tsr0Ns751rAiEuz5Df1QmxzkLihvlVx6pRbU=
Date:   Tue, 4 Jul 2023 10:05:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: remove redundant check in page_vma_mapped_walk
Message-Id: <20230704100548.11bce56bb79be4a7d1d8482c@linux-foundation.org>
In-Reply-To: <20230704213932.1339204-2-shikemeng@huaweicloud.com>
References: <20230704213932.1339204-1-shikemeng@huaweicloud.com>
        <20230704213932.1339204-2-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jul 2023 05:39:31 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> For PVMW_SYNC case, we always take pte lock when get first pte of
> PTE-mapped THP in map_pte and hold it until:
> 1. scan of pmd range finished or
> 2. scan of user input range finished or
> 3. user stop walk with page_vma_mapped_walk_done.
> In each case. pte lock will not be freed during middle scan of PTE-mapped
> THP.
> 
> ...
>
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -275,10 +275,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -			if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
> -				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
> -				spin_lock(pvmw->ptl);
> -			}
>  		} while (pte_none(*pvmw->pte));
>  
>  		if (!pvmw->ptl) {

This code has changed significantly since 6.4.  Please develop against
the mm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm, thanks.

