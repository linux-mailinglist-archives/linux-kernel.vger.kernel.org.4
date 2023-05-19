Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86BB709CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjESQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjESQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB5114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6D765961
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBFC433EF;
        Fri, 19 May 2023 16:54:11 +0000 (UTC)
Date:   Fri, 19 May 2023 17:54:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 3/3] arm64: mte: Simplify swap tag restoration logic
Message-ID: <ZGepsWDEfG+gk/t3@arm.com>
References: <20230517022115.3033604-1-pcc@google.com>
 <20230517022115.3033604-4-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517022115.3033604-4-pcc@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 07:21:13PM -0700, Peter Collingbourne wrote:
> As a result of the previous two patches, there are no circumstances
> in which a swapped-in page is installed in a page table without first
> having arch_swap_restore() called on it. Therefore, we no longer need
> the logic in set_pte_at() that restores the tags, so remove it.
> 
> Because we can now rely on the page being locked, we no longer need to
> handle the case where a page is having its tags restored by multiple tasks
> concurrently, so we can slightly simplify the logic in mte_restore_tags().
[...]
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index cd508ba80ab1..3a78bf1b1364 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -53,10 +53,9 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
>  	if (!tags)
>  		return;
>  
> -	if (try_page_mte_tagging(page)) {
> -		mte_restore_page_tags(page_address(page), tags);
> -		set_page_mte_tagged(page);
> -	}
> +	WARN_ON_ONCE(!try_page_mte_tagging(page));
> +	mte_restore_page_tags(page_address(page), tags);
> +	set_page_mte_tagged(page);
>  }

Can we have a situation where two processes share the same swap pte
(CoW) and they both enter the do_swap_page() or the unuse_pte() paths
triggering this warning?

Other than that, the looks nice, it simplifies the logic and probably
saves a few cycles as well on the set_pte_at() path.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
