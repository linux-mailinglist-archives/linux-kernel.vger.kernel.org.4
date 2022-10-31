Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0861406E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJaWIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJaWIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:08:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B97D46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:08:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A41E21E96;
        Mon, 31 Oct 2022 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667254129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmBSXW3Nr6eF5gprMDxeS0kpY70axpecH+1jkM0zg9Q=;
        b=tN/0awz4edDVWZyby+vR2QExQ1zAP79I59n9LABHamlvNWPii7WO5p7CEgSz3No34ovpPH
        2mlPmrL6Lwy117CrbPeMhgbdwjDLjeHAl/XtOvIR541w5shnB2JW3nDY6mERQl9LkT5F1X
        VO6Wma9vm5EKBBlgJFmupXd2+zz0hpo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD00113AAD;
        Mon, 31 Oct 2022 22:08:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ip7AM3BHYGMnSgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 31 Oct 2022 22:08:48 +0000
Date:   Mon, 31 Oct 2022 23:08:48 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
References: <20221031183122.470962-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031183122.470962-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-10-22 11:31:22, Yang Shi wrote:
> Syzbot reported the below splat:
> 
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Modules linked in:
> CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715

This is quite weird, isn't it? alloc_charge_hpage is selecting the most
busy node (as per collapse_control). How come this can be an offline
node? Is a parallel memory hotplug happening?

[...]

> It is because khugepaged allocates pages with __GFP_THISNODE, but the
> preferred node is offlined.  The warning was even stronger before commit
> 8addc2d00fe17 ("mm: do not warn on offline nodes unless the specific node
> is explicitly requested").  The commit softened the warning for
> __GFP_THISNODE.
> 
> But this warning seems not quite useful because:
>   * There is no guarantee the node is online for __GFP_THISNODE context
>     for all the callsites.

The original idea IIRC was to catch a buggy code which mishandled node
assignment. But this looks like a perfectly valid code. There is no
synchronization with the memory hotplug so it is possible that memory
gets offline during a longer taking scanning.

I do agree that the warning is not really helpful in this case. It is
actually even harmful for those running in panic-on-warn mode.

>   * Kernel just fails the allocation regardless the warning, and it looks
>     all callsites handle the allocation failure gracefully.
> 
> So, removing the warning seems like the good move.
> 
> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Michal Hocko <mhocko@suse.com>

Unless I am wrong in my above statement I would appreciate extending the
changelog to describe the actual code is correct so the warning is
harmful.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/gfp.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ef4aea3b356e..594d6dee5646 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -218,7 +218,6 @@ static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
>  
>  	return __alloc_pages(gfp_mask, order, nid, NULL);
>  }
> @@ -227,7 +226,6 @@ static inline
>  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
>  {
>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
>  
>  	return __folio_alloc(gfp, order, nid, NULL);
>  }
> -- 
> 2.26.3

-- 
Michal Hocko
SUSE Labs
