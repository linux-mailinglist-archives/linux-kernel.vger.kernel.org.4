Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8574C1D7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGIKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGIKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 06:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190297;
        Sun,  9 Jul 2023 03:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D651F60BB1;
        Sun,  9 Jul 2023 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44FEC433C7;
        Sun,  9 Jul 2023 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688897817;
        bh=yNhKNholsm3yNohLZid2uZuc5K4NRQyeyAY0OEKmeo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vh16lnBSfX/s72Imtyfpe0q78Iuak4kdbAW+DuRU3i9Hq4QaYekb5FOLv0wERLeYu
         9IdMLxmqPEWyQno34o46dtIb/8KyMJo0MkjEsemBbY+/2GoeaMDImVps/CwPzpHXbx
         s/j8dplo1T9zqNYbpOgl5Iv9s33JQhecCJs6JNQM=
Date:   Sun, 9 Jul 2023 12:16:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com,
        Qun-wei.Lin@mediatek.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, david@redhat.com, pcc@google.com,
        steven.price@arm.com, ying.huang@intel.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "mm: call arch_swap_restore() from do_swap_page()" has
 been added to the 5.10-stable tree
Message-ID: <2023070941-throbbing-renter-f6ef@gregkh>
References: <2023070900-bounce-slider-afab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070900-bounce-slider-afab@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:44:01AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mm: call arch_swap_restore() from do_swap_page()
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-call-arch_swap_restore-from-do_swap_page.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 6dca4ac6fc91fd41ea4d6c4511838d37f4e0eab2 Mon Sep 17 00:00:00 2001
> From: Peter Collingbourne <pcc@google.com>
> Date: Mon, 22 May 2023 17:43:08 -0700
> Subject: mm: call arch_swap_restore() from do_swap_page()
> 
> From: Peter Collingbourne <pcc@google.com>
> 
> commit 6dca4ac6fc91fd41ea4d6c4511838d37f4e0eab2 upstream.
> 
> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> the call to swap_free() before the call to set_pte_at(), which meant that
> the MTE tags could end up being freed before set_pte_at() had a chance to
> restore them.  Fix it by adding a call to the arch_swap_restore() hook
> before the call to swap_free().
> 
> Link: https://lkml.kernel.org/r/20230523004312.1807357-2-pcc@google.com
> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: <stable@vger.kernel.org>	[6.1+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ae594703021..01f39e8144ef 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3950,6 +3950,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> -- 
> 2.41.0
> 
> 
> 
> Patches currently in stable-queue which might be from pcc@google.com are
> 
> queue-5.10/mm-call-arch_swap_restore-from-do_swap_page.patch

Oops, my fault, does not belong in 5.10, now dropped.
