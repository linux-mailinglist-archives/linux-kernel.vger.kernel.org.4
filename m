Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754716DFB11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjDLQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDLQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84638619B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDB66108B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A308C433D2;
        Wed, 12 Apr 2023 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316190;
        bh=IEkH/ynJCXIAwn5YhmCClWHXwjym7LfLQzhX+bYkHdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXcrXlHST5Dx5SF0gScJarNkfcQbZvibjbPapL9lte46EYckhHWe55DyELsChtVXC
         w/gPU04e9udKubVl72EKAENZCh8sToPwCVL8457zPq6bLxNOLzRap/GyHh+1nfEvGk
         Th1yvxLQlWKW7iZC6+6leWcmBLTrPp2CrXXs90jNsPJHlVx6s2OdphIz7MSN/vp9lD
         bfDK3ElKjHc9rh0us9Cav1hyIQHvIbpcW2ypHFT2cAK7c5V5kspIQT5dQLF6/dBccK
         feqHaw/MVDtklbfScX7KVg/X8lx3nxnEcxn2DjB0epaE4PokeLB2Gni+NK6cJAlMwk
         2E/Bn+rn4lg0Q==
Date:   Wed, 12 Apr 2023 09:16:28 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove folio_detach_private() in
 .invalidate_folio and .release_folio
Message-ID: <ZDbZXG8pix/AG6/y@google.com>
References: <20230410022418.1843178-1-chao@kernel.org>
 <ZDRWdJxP6QzcIU7G@google.com>
 <b05d7ce8-ef98-a7ef-9873-4403ec0858c1@kernel.org>
 <ZDWRqRgwuLpkR7qO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWRqRgwuLpkR7qO@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Jaegeuk Kim wrote:
> On 04/11, Chao Yu wrote:
> > On 2023/4/11 2:33, Jaegeuk Kim wrote:
> > > On 04/10, Chao Yu wrote:
> > > > We have maintain PagePrivate and page_private and page reference
> > > > w/ {set,clear}_page_private_*, it doesn't need to call
> > > > folio_detach_private() in the end of .invalidate_folio and
> > > > .release_folio, remove it and use f2fs_bug_on instead.
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > >   fs/f2fs/data.c | 7 +++++--
> > > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > index 4946df6dd253..8b179b4bdc03 100644
> > > > --- a/fs/f2fs/data.c
> > > > +++ b/fs/f2fs/data.c
> > > > @@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
> > > >   			inode->i_ino == F2FS_COMPRESS_INO(sbi))
> > > >   		clear_page_private_data(&folio->page);
> > > > -	folio_detach_private(folio);
> > > > +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> > > > +	f2fs_bug_on(sbi, page_private(&folio->page));
> > > 
> > > I think we can just check page_private() only.
> > 
> > Why? how about the case PagePrivate was set, but page_private was't? It must
> > be a bug as well?
> 
> Given the code, I think both are set all the time. My concern is someone is
> not doing set/get properly. Actually, I got a panic on page_private() when
> running fsstress overnight. I'm trying to reproduce it to find which bit was
> set.

It turned out that inline bit is somehow set, guessing the bit was not cleared
when the first dirty page was truncated or somewhere else.

Anyway, tooking a look at the usecase of flushing inline_data to inode page
aggressively, I feel it's kinda hack and may increase the checkpoint latency.
Hence, I'd like to remove it simply.

https://lore.kernel.org/linux-f2fs-devel/20230412160810.1534632-1-jaegeuk@kernel.org/T/#t

> 
> > 
> > Thanks,
> > 
> > > 
> > > >   }
> > > >   bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> > > > @@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> > > >   	clear_page_private_reference(&folio->page);
> > > >   	clear_page_private_gcing(&folio->page);
> > > > -	folio_detach_private(folio);
> > > > +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> > > > +	f2fs_bug_on(sbi, page_private(&folio->page));
> > > > +
> > > >   	return true;
> > > >   }
> > > > -- 
> > > > 2.25.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
