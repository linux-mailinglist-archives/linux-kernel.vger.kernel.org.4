Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F755BD8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiITAvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITAu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709A3A4A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6144061C15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D37C433D6;
        Tue, 20 Sep 2022 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663635054;
        bh=yOberSEUqwdenP4n+exju7j3AQ6fgojCHFFpQfJqfKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je46AiyUGmzY04wq9Golwz6HFn+OrAQtxFRzSKNyTFGArWtb7ykqgHE7oIGhNFS2G
         4Unv8apLY8M+VxzCmLlw8sT0TVljgLcZ5NQG6JuzUGeOwh8cgazsinaxP7jiFKnNOP
         ACh2b6ffK2p1tVTVqn8zhyKkPIHIS78EyaQxVkQdV3eDZ0u3RZBH4yCKHoknUg7z1x
         sh679JxGCwq+blNutBoUwu8svYvi68eZbhhqVuL3fBlmDALkUCHQSu/2G/ipxUKLPD
         0vcW3bYsUrhKrwpOaRrGnDUGfnm23p+P3sgLbwIxMylQCs9e9TVRQdaDoOZ2wC23J3
         qWmwYh5sUdc8w==
Date:   Mon, 19 Sep 2022 17:50:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Philippe De Muyter <phdm@macq.eu>
Subject: Re: [PATCH 1/1] f2fs: fix to check space of current segment journal
Message-ID: <YykObKyz+XT1QCyh@google.com>
References: <20220914040423.539-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914040423.539-1-bo.wu@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14, Wu Bo wrote:
> As Philippe De Muyter reported:
> https://lore.kernel.org/linux-f2fs-devel/20220913224908.GA25100@172.21.0.10/T/#u
> 
> The warning log showed that when finding a new space for nat the journal
> space turned out to be full. This because the journal_rwsem is not
> locked before the journal space checking. The journal space may become
> full just after we check it.
> 
> Reported-by: Philippe De Muyter <phdm@macq.eu>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/node.c    |  6 +++---
>  fs/f2fs/segment.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e06a0c478b39..971d8b9ccdf1 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2995,13 +2995,13 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  	 * #1, flush nat entries to journal in current hot data summary block.
>  	 * #2, flush nat entries to nat page.
>  	 */
> +	down_write(&curseg->journal_rwsem);
>  	if ((cpc->reason & CP_UMOUNT) ||
>  		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))

I think this is for NAT which was covered by nat_tree_lock. So, we don't need
this under journal_rwsem.

>  		to_journal = false;
>  
> -	if (to_journal) {
> -		down_write(&curseg->journal_rwsem);
> -	} else {
> +	if (!to_journal) {
> +		up_write(&curseg->journal_rwsem);
>  		page = get_next_nat_page(sbi, start_nid);
>  		if (IS_ERR(page))
>  			return PTR_ERR(page);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0de21f82d7bc..d545032d2f6f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3914,13 +3914,13 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>  			if (le32_to_cpu(nid_in_journal(journal, i)) == val)
>  				return i;
>  		}
> -		if (alloc && __has_cursum_space(journal, 1, NAT_JOURNAL))
> +		if (alloc)
>  			return update_nats_in_cursum(journal, 1);
>  	} else if (type == SIT_JOURNAL) {
>  		for (i = 0; i < sits_in_cursum(journal); i++)
>  			if (le32_to_cpu(segno_in_journal(journal, i)) == val)
>  				return i;
> -		if (alloc && __has_cursum_space(journal, 1, SIT_JOURNAL))
> +		if (alloc)
>  			return update_sits_in_cursum(journal, 1);
>  	}
>  	return -1;
> @@ -4085,13 +4085,13 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  						(unsigned long)MAIN_SEGS(sbi));
>  		unsigned int segno = start_segno;
>  
> +		down_write(&curseg->journal_rwsem);
>  		if (to_journal &&
>  			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
>  			to_journal = false;
>  
> -		if (to_journal) {
> -			down_write(&curseg->journal_rwsem);
> -		} else {
> +		if (!to_journal) {
> +			up_write(&curseg->journal_rwsem);
>  			page = get_next_sit_page(sbi, start_segno);
>  			raw_sit = page_address(page);
>  		}
> -- 
> 2.36.1
