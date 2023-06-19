Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A529735EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFSUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSUnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCA128;
        Mon, 19 Jun 2023 13:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A2C60EF8;
        Mon, 19 Jun 2023 20:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0282C433C0;
        Mon, 19 Jun 2023 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687207396;
        bh=0Um0HsgUBK5KbSF7mk/Cw2z163gOV5GsbOdaUkWRdas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDtgplCEFY5wppuORRrvbiclJcHFU7fkmU5rL+28u1onKj8YCXj9yrrqBzQzUVr/a
         KL9Cy5qS3V+P00+LYYDWYYi0SZKyBZImKvnt9kCyXuPeAWv0xmmQBeuNkaWN/zLCTu
         cLwEU/LXmu9MpB5u2cKIe38B05ufpZfNLpmaJYsWu+E+GA6uyApz6rV8koa2PjqtfE
         YZ9BLb9FQ89JnQkAjR50rmrmMbQhBAv9+mpvXRZmSoycKEmYzcBglGbni19QTHRQ4M
         VXHL3A2k4udHeT1S5nupxkCF8jnYnJPH1/yaa7tJdbwznUxlbseeOztCfbl0DN2TxQ
         n1YySABlEejlw==
Date:   Mon, 19 Jun 2023 21:43:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        catalin.marinas@arm.com
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230619204309.GA13937@willie-the-truck>
References: <20230619092355.133c5cdb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619092355.133c5cdb@canb.auug.org.au>
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

Hi Stephen,

On Mon, Jun 19, 2023 at 09:23:55AM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   mm/mmap.c
> 
> between commit:
> 
>   606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
> 
> from the origin tree and commits:
> 
>   66106c364147 ("mm: change do_vmi_align_munmap() side tree index")
>   47b1d8de18f5 ("mm/mmap: change vma iteration order in do_vmi_align_munmap()")
> 
> from the mm tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc mm/mmap.c
> index 98cda6f72605,474a0d856622..000000000000
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@@ -2398,15 -2409,27 +2396,29 @@@ do_vmi_align_munmap(struct vma_iterato
>   			if (error)
>   				goto end_split_failed;
>   		}
>  -		mas_set(&mas_detach, count);
>  -		error = munmap_sidetree(next, &mas_detach);
>  -		if (error)
>  -			goto munmap_sidetree_failed;
>  +		vma_start_write(next);
> - 		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
>  +		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
>  +			goto munmap_gather_failed;
>  +		vma_mark_detached(next, true);
>  +		if (next->vm_flags & VM_LOCKED)
>  +			locked_vm += vma_pages(next);
>   
>   		count++;
> + 		if (unlikely(uf)) {
> + 			/*
> + 			 * If userfaultfd_unmap_prep returns an error the vmas
> + 			 * will remain split, but userland will get a
> + 			 * highly unexpected error anyway. This is no
> + 			 * different than the case where the first of the two
> + 			 * __split_vma fails, but we don't undo the first
> + 			 * split, despite we could. This is unlikely enough
> + 			 * failure that it's not worth optimizing it for.
> + 			 */
> + 			error = userfaultfd_unmap_prep(next, start, end, uf);
> + 
> + 			if (error)
> + 				goto userfaultfd_error;
> + 		}
>   #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
>   		BUG_ON(next->vm_start < start);
>   		BUG_ON(next->vm_start > end);
> @@@ -2454,14 -2455,18 +2444,20 @@@
>   		BUG_ON(count != test_count);
>   	}
>   #endif
> - 	/* Point of no return */
>  +	error = -ENOMEM;
> - 	vma_iter_set(vmi, start);
> + 	while (vma_iter_addr(vmi) > start)
> + 		vma_iter_prev_range(vmi);
> + 
>   	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
>  -		return -ENOMEM;
>  +		goto clear_tree_failed;
>   
>  +	mm->locked_vm -= locked_vm;
>   	mm->map_count -= count;
> + 	prev = vma_iter_prev_range(vmi);
> + 	next = vma_next(vmi);
> + 	if (next)
> + 		vma_iter_prev_range(vmi);
> + 
>   	/*
>   	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
>   	 * VM_GROWSUP VMA. Such VMAs can change their size under

This resolution seems to be causing horrible problems on arm64 with 16k
pages. I see things like the crash below, but the two branches being merged
are fine on their own.

Will

--->8

[ 1353.914809] BUG: Bad rss-counter state mm:fffffff001065580 type:MM_ANONPAGES val:4
[ 1354.145486] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 1354.146465] Mem abort info:
[ 1354.146894]   ESR = 0x0000000096000006
[ 1354.148049]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1354.148754]   SET = 0, FnV = 0
[ 1354.149030]   EA = 0, S1PTW = 0
[ 1354.149429]   FSC = 0x06: level 2 translation fault
[ 1354.149948] Data abort info:
[ 1354.150278]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[ 1354.150822]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1354.151725]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1354.152293] user pgtable: 16k pages, 36-bit VAs, pgdp=0000000045928000
[ 1354.152882] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000, pmd=0000000000000000
[ 1354.155005] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[ 1354.156871] Modules linked in:
[ 1354.158072] CPU: 3 PID: 289 Comm: (sd-pam) Not tainted 6.4.0-rc7-next-20230619 #1
[ 1354.160463] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[ 1354.161566] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 1354.162179] pc : __rb_erase_color+0xb8/0x24c
[ 1354.164370] lr : vma_interval_tree_remove+0x2b4/0x2c8
[ 1354.165267] sp : fffffff880b13940
[ 1354.165648] x29: fffffff880b13940 x28: fffffff001b81c30 x27: 0000000000000001
[ 1354.166570] x26: fffffff001b81760 x25: 0000000f9c000000 x24: ffffffffffffffff
[ 1354.167722] x23: fffffff880b13a98 x22: 0000000000000000 x21: fffffff002d57068
[ 1354.168422] x20: fffffff00450fc10 x19: fffffffe1c02f098 x18: fffffff000705f41
[ 1354.170661] x17: fffffff001947600 x16: 0000000000000003 x15: 0000000000000001
[ 1354.171717] x14: fffffffe1d7de5d8 x13: fffffff00450fc18 x12: 0000000000000000
[ 1354.172636] x11: 000000000000000a x10: 000000000000000a x9 : 000000000000000a
[ 1354.173118] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[ 1354.173555] x5 : 00000000810000dd x4 : fffffffff004ede0 x3 : 00000000810000dd
[ 1354.174061] x2 : fffffffe1c02f098 x1 : fffffff002d57068 x0 : fffffff00450fc10
[ 1354.174684] Call trace:
[ 1354.175325]  __rb_erase_color+0xb8/0x24c
[ 1354.176114]  vma_interval_tree_remove+0x2b4/0x2c8
[ 1354.176558]  unlink_file_vma+0x54/0x94
[ 1354.176822]  free_pgtables+0xe4/0x1ac
[ 1354.177181]  exit_mmap+0x164/0x288
[ 1354.177473]  __mmput+0x40/0x140
[ 1354.177667]  mmput+0x28/0x60
[ 1354.177977]  exit_mm+0x94/0xd4
[ 1354.178362]  do_exit+0x238/0x83c
[ 1354.179301]  do_group_exit+0x70/0x98
[ 1354.179773]  get_signal+0x67c/0x708
[ 1354.180092]  do_notify_resume+0x150/0x1350
[ 1354.180597]  el0_interrupt+0x80/0x150
[ 1354.181068]  __el0_irq_handler_common+0x18/0x24
[ 1354.181438]  el0t_64_irq_handler+0x10/0x1c
[ 1354.181788]  el0t_64_irq+0x190/0x194
[ 1354.182908] Code: 394002e8 37000428 1400002c f9400a96 (394002c8) 
[ 1354.184629] ---[ end trace 0000000000000000 ]---

