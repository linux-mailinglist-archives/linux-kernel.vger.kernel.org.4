Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8A569CF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBTO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjBTO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:27:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290C1F909;
        Mon, 20 Feb 2023 06:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q1jdBb9x0UC/lDiAiZWoZ9+qPuTkTKRRoKMvz0a85cQ=; b=tKUGXttRE4o/02IFOlFvDHz2D/
        /WX1V7Vi0XGRRVQHIyedSnRkwZ+BozrsKfjtP1DmFA/Om3CdIBlNgFojjEPONT5XuRl//g0RLWXdQ
        hYjMiMwynpZfK0riHkTaiJF5hAQixeZHwQqOvtH1tXd9VN2C8llD1lLsM+oe1ag/vi+4P0QvF1I+Q
        STF0zSiWd5IRvfZ0tKlCEhFsEhVormKgC+Uw5oJO7jv1ypAnXUtXFepo9MV3fCDimGZvJp7tU12NP
        EYIWzTGDQPivr9O/Q1i5OxyRza3LU5qu7GeWPPHuI6BiAQkhfiOgXznvLnnwKiYNBFqoh1sxubw2l
        9qZmkPAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU789-00Bn1A-15; Mon, 20 Feb 2023 14:27:01 +0000
Date:   Mon, 20 Feb 2023 14:27:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4 tree
Message-ID: <Y/ODNJ3MfoD6dUru@casper.infradead.org>
References: <20230220152938.45f62d5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220152938.45f62d5a@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 03:29:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mm-stable tree got a conflict in:
> 
>   fs/ext4/inode.c
> 
> between commits:
> 
>   726432969963 ("ext4: use nr_to_write directly in mpage_prepare_extent_to_map()")
>   9ff6a9153c8f ("ext4: move page unlocking out of mpage_submit_page()")
>   b4d26e70a755 ("ext4: move mpage_page_done() calls after error handling")
>   9b18c23c131a ("ext4: convert data=journal writeback to use ext4_writepages()")
> 
> from the ext4 tree and commits:
> 
>   50ead2537441 ("ext4: convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()")
>   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> 
> from the mm-stable tree.
> 
> I have no idea how to fix this up, so I have used the ext4 tree from
> next-20230217 for today.

Yeah, this one's a mess.  Probably the easiest solution is for Ted to
pull in 247f9e1feef4 and 50ead2537441 and then redo Jan's patches on
top of them.

