Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785306192C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKDIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:32:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27727915
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:32:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDBE6218B2;
        Fri,  4 Nov 2022 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667550722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZ+AJnS5Wd7kZiiJM43zXsTBEgv40GaWX+NJJRDqlNk=;
        b=tN8BHzy2HXktvjE/0kcZnPd+35vD21Gp6n7vUGzn9tk70t2KEnSQoFZv/Ae8zIJs1X5Ma0
        P16CW0ci/kW3JkrzkZOgmZzG7hVd/gSW1d5U0OuLsTIRDb+u3GjZpWLd87OVMPBKRwY+nI
        6+6p9MCcHPXDDXrVFkj/n3AiCpNVHDg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC20D13216;
        Fri,  4 Nov 2022 08:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DMAxKwLOZGM5YQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Nov 2022 08:32:02 +0000
Date:   Fri, 4 Nov 2022 09:32:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] mm: khugepaged: allow page allocation fallback to
 eligible nodes
Message-ID: <Y2TOAdHk97pPYwJY@dhcp22.suse.cz>
References: <20221103213641.7296-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103213641.7296-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-11-22 14:36:40, Yang Shi wrote:
[...]
> So use nodemask to record the nodes which have the same hit record, the
> hugepage allocation could fallback to those nodes.  And remove
> __GFP_THISNODE since it does disallow fallback.  And if nodemask is
> empty (no node is set), it means there is one single node has the most
> hist record, the nodemask approach actually behaves like __GFP_THISNODE.
> 
> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ea0d186bc9d4..572ce7dbf4b0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -97,8 +97,8 @@ struct collapse_control {
>  	/* Num pages scanned per node */
>  	u32 node_load[MAX_NUMNODES];
>  
> -	/* Last target selected in hpage_collapse_find_target_node() */
> -	int last_target_node;
> +	/* nodemask for allocation fallback */
> +	nodemask_t alloc_nmask;

This will eat another 1k on the stack on most configurations
(NODE_SHIFT=10). Along with 4k of node_load this is quite a lot even
on shallow call chains like madvise resp. khugepaged.  I would just
add a follow up patch which changes both node_load and alloc_nmask to
dynamically allocated objects.

Other than that LGTM. I thought we want to keep __GFP_THISNODE but after
a closer look it seems that this flag is not really compatible with
nodemask after all. node_zonelist() will simply return a trivial zone
list for a single (preferred node) so no fallback to other nodes is
possible. My bad to not realize it earlier.
-- 
Michal Hocko
SUSE Labs
