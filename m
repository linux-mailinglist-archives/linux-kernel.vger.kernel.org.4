Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1FC72282C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjFEOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjFEOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EEB122;
        Mon,  5 Jun 2023 07:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1377261671;
        Mon,  5 Jun 2023 14:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F84C433D2;
        Mon,  5 Jun 2023 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685973961;
        bh=owgJ2JpHb0soEawFXmtTH142XPFNTNcm+kX8RwdJzrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8rvPmfMPFhkA/+lwOFdVC7Dj9vKBHQCUCXWNlRg6AGoa0sWtr23aAYTfZ0dO7QXO
         8wyrfhiG3fzyG0GE2T+vqkK+fk0TYzo2EJTd/6Vp6SC95GdqAwx7c0WuWH/BvqcPRU
         jRYGNKaYaOzPuo2mdMYiLrd61NFpdya35mhm4Eekt7TIEObXLc5Jvu9RIrvgLjCmNf
         YJLO3z3vOXI3Ft78f4n1ydPpUFv8r8jdoDz/TqDJxB7B0xv9xCVISxNn+2rWv4Ck6W
         3mhwWc35qxqJlJK5NhVpOiWtvkBEP/YGHKvgPNzRhZTuXZIElg8qL1+egPddVLcZLY
         fwyA0nVldOaYQ==
Date:   Mon, 5 Jun 2023 15:05:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Collingbourne <pcc@google.com>, akpm@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
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
        Alexandru Elisei <alexandru.elisei@arm.com>,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
Message-ID: <20230605140554.GC21212@willie-the-truck>
References: <20230523004312.1807357-1-pcc@google.com>
 <20230523004312.1807357-2-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523004312.1807357-2-pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, May 22, 2023 at 05:43:08PM -0700, Peter Collingbourne wrote:
> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> the call to swap_free() before the call to set_pte_at(), which meant that
> the MTE tags could end up being freed before set_pte_at() had a chance
> to restore them. Fix it by adding a call to the arch_swap_restore() hook
> before the call to swap_free().
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> Cc: <stable@vger.kernel.org> # 6.1
> Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> Reported-by: Qun-wei Lin (林群崴) <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v2:
> - Call arch_swap_restore() directly instead of via arch_do_swap_page()
> 
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f69fbc251198..fc25764016b3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3932,6 +3932,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		}
>  	}
>  
> +	/*
> +	 * Some architectures may have to restore extra metadata to the page
> +	 * when reading from swap. This metadata may be indexed by swap entry
> +	 * so this must be called before swap_free().
> +	 */
> +	arch_swap_restore(entry, folio);
> +
>  	/*
>  	 * Remove the swap entry and conditionally try to free up the swapcache.
>  	 * We're already holding a reference on the page but haven't mapped it

It looks like the intention is for this patch to land in 6.4, whereas the
other two in the series could go in later, right? If so, I was expecting
Andrew to pick this one up but he's not actually on CC. I've added him now,
but you may want to send this as a separate fix so it's obvious what needs
picking up for this cycle.

Cheers,

Will
