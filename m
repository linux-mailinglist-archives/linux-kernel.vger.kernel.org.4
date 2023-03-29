Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14486CF5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC2Vxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Vx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643E59F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E654061E1A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E790C433EF;
        Wed, 29 Mar 2023 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680126785;
        bh=K6T/IUGj1Ip/Ty8DVHp0rPk4TkR7iO4ih/+pi3zhJr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A3yz2lkGPRZU49PZGaqeYtfe9HCc4NoysxY7NDUOLf+/PuUUj+ZUi5aK3V4FpnweQ
         js+tEfEZg0UPhJBfWbvPsYpE6JA/G4PaOkSnytvbSdl8QN+HUo9WOo2HoUMqtO6p2w
         RU/XO7vveNmgZKiO2aKzzL1nZyx68F5EBFA8Gtdk=
Date:   Wed, 29 Mar 2023 14:53:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Message-Id: <20230329145304.66add47ba9b9fafb71b1e13d@linux-foundation.org>
In-Reply-To: <20230329145330.23191-1-ivan.orlov0322@gmail.com>
References: <20230329145330.23191-1-ivan.orlov0322@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 18:53:30 +0400 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:

> Syzkaller reported the following issue:
> 
> ...
> 
> The 'xas_store' call during page cache scanning can potentially
> translate 'xas' into the error state (with the reproducer provided
> by the syzkaller the error code is -ENOMEM). However, there are no
> further checks after the 'xas_store', and the next call of 'xas_next'
> at the start of the scanning cycle doesn't increase the xa_index,
> and the issue occurs.
> 
> This patch will add the xarray state error checking after the
> 'xas_store' and the corresponding result error code.
> 
> Tested via syzbot.
> 
> Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  mm/khugepaged.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 92e6f56a932d..4d9850d9ea7f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -55,6 +55,7 @@ enum scan_result {
>  	SCAN_CGROUP_CHARGE_FAIL,
>  	SCAN_TRUNCATED,
>  	SCAN_PAGE_HAS_PRIVATE,
> +	SCAN_STORE_FAILED,
>  };
>  
>  #define CREATE_TRACE_POINTS
> @@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  					goto xa_locked;
>  				}
>  				xas_store(&xas, hpage);
> +				if (xas_error(&xas)) {
> +					/* revert shmem_charge performed
> +					 * in the previous condition
> +					 */
> +					mapping->nrpages--;
> +					shmem_uncharge(mapping->host, 1);
> +					result = SCAN_STORE_FAILED;
> +					goto xa_locked;
> +				}
>  				nr_none++;
>  				continue;
>  			}

Needs this, I assume.

--- a/include/trace/events/huge_memory.h~mm-khugepaged-fix-kernel-bug-in-hpage_collapse_scan_file-fix
+++ a/include/trace/events/huge_memory.h
@@ -36,7 +36,8 @@
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
 	EM( SCAN_TRUNCATED,		"truncated")			\
-	EMe(SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
+	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
+	EMe(SCAN_STORE_FAILED,		"store_failed")
 
 #undef EM
 #undef EMe
_

