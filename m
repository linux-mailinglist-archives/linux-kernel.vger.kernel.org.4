Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D17156B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjE3H2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjE3H2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:28:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5F10E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:28:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67AB71F8B9;
        Tue, 30 May 2023 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685431679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iuaXZNwiLN+ZHN3JBMLHew3TV1lht46Dhhj/rIIHak=;
        b=KwROOZXUqtwOxh+02Q9km5zdl57HiclQ2Xf1++iSWTNzgwzJBs0D9kNktitRFxRtvpwbiH
        pfy5d/CXuN4XxYZH0rhEiVKEH0xpIZaZgQeHdVXqjHcKMcTcSZApoYytLxAUk4uf/Sem+J
        KHd46xdWk5DbrDlhCOyRx0np9wJLyxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685431679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iuaXZNwiLN+ZHN3JBMLHew3TV1lht46Dhhj/rIIHak=;
        b=hpbCRhUjBkvJIrGPaWFWcZrwLDEcl0YY8hvzBeUL+AScG1Hh5JBp9PiS1enRC9GK4cCWUP
        YnLITC3PM/sfyQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48E3213478;
        Tue, 30 May 2023 07:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M8ubEH+ldWSdGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 May 2023 07:27:59 +0000
Message-ID: <6feab6b0-ec49-8651-bc8e-14ec40249017@suse.cz>
Date:   Tue, 30 May 2023 09:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/6] mm: compaction: drop the redundant page validation in
 update_pageblock_skip()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <5142e15b9295fe8c447dbb39b7907a20177a1413.1685018752.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5142e15b9295fe8c447dbb39b7907a20177a1413.1685018752.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 14:53, Baolin Wang wrote:
> The caller has validated the page before calling pdate_pageblock_skip(),
                                                   ^ u

> thus drop the redundant page validation in update_pageblock_skip().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 163e2ec70aff..426bb6ce070b 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -436,9 +436,6 @@ static void update_pageblock_skip(struct compact_control *cc,
>  	if (cc->no_set_skip_hint)
>  		return;
>  
> -	if (!page)
> -		return;
> -
>  	set_pageblock_skip(page);
>  
>  	/* Update where async and sync compaction should restart */

