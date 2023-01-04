Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06065CBE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjADC3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADC3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:29:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3B17E3F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6746F6157D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3A9C433EF;
        Wed,  4 Jan 2023 02:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672799376;
        bh=+9kf5hnEZ64xx3CtPeLN3FbBv3YuDqJKdh7IsiXm7JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOXRL+IDbcMyGxtKtJG+RB+Id7fd/6sOcQcr0oRCA9QpTfnJDnRpqVwajQCwB4hnQ
         gFD5WSiErDUygNR8kXWaEwAfYK/XldSZ0N96RpIYqOdxpQ+GzZ8tvKIMYYwXI/3NE/
         Y6R60ggCKwKNQsWOhfyi0QYnuxcjnZpZIZ/i1KoKjHL6Zcv2QjZ6a1PaaZrxlT442i
         WPX97auO71/RL3qTmpljgCWalM0vm9FIcruMsNEEW/CX7UxbeztRKZD18OWlT5h5b7
         Jk+xjJ3F+laXoFNRrutw1HLzmmwJqWkU+OCnJEr6se5HKo7Q2QvATjc0qp2PCzOkzN
         jyGIH53fPMyOw==
Date:   Tue, 3 Jan 2023 18:29:34 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     zhou dan <zhuqiandann@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8@xiaomi.com
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Message-ID: <Y7TkjnSbHnDj76qd@google.com>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K>
 <Y5ezpOwd8sOTTaW5@google.com>
 <20221213022100.GA841758@mi-ThinkStation-K>
 <CAHDnOD7W0eo-ZMU8nXsPhXrxbpR3U+kooTVaTU8VL67QHbYH3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHDnOD7W0eo-ZMU8nXsPhXrxbpR3U+kooTVaTU8VL67QHbYH3A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, zhou dan wrote:
> Hi, about this patch, I haven't received any reply recently.
> Maybe you have some new ideas to solve this problem?

Could you please describe the exact flow that you're suffering from?

> 
> 
> zhoudan <zhuqiandann@gmail.com> 于2022年12月13日周二 10:21写道：
> >
> > However, 'f2fs_compressed_file()' only determines whether the file can
> > be compressed, not whether the file has been compressed. As far as I
> > know, when compress_mode is user, files marked FI_COMPRESSED_FILE
> > will be compressed only after 'f2fs_ioc_compress_file()' is called.
> > On Mon, Dec 12, 2022 at 03:05:08PM -0800, Jaegeuk Kim wrote:
> > > On 12/12, zhoudan wrote:
> > > > Maybe I'm not describing it clearly enough, but I think there is
> > > > something wrong with the logic here.The 'f2fs_release_compress_blocks'
> > > > method does not determine if the file is compressed, but simply adds
> > > > the FI_COMPRESS_RELEASED flag.
> > >
> > > I firstly lost your point since f2fs_release_compress_blocks() checked
> > > f2fs_compressed_file().
> > >
> > > > In particular, in the current Android system, when the application is
> > > > installed, the release interface is called by default to release the
> > > > storage marked as compressed,  without checking whether the file is
> > > > actually compressed. In this case, when compress_mode is set to user,
> > > > calling the compress interface returns ENVAL and the file cannot be
> > > > compressed.
> > > > So I think the implementation of release needs to be modified, and
> > > > only set FI_COMPRESS_RELEASED when it's really compressed and the
> > > > storage is released.
> > > >
> > > > On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > > > > On 12/08, zhoudan8 wrote:
> > > > > > In compress_mode=user, f2fs_release_compress_blocks()
> > > > > >  does not verify whether it has been compressed and
> > > > > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > > > > return -EINVAL after calling compress.
> > > > > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > > > > is not compressed.
> > > > >
> > > > > Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> > > > > with zero i_compr_blokcs?
> > > > >
> > > > > I think the current logic is giving the error on a released file already.
> > > > >
> > > > > >
> > > > > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > > > > ---
> > > > > >  fs/f2fs/file.c | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > index 82cda1258227..f32910077df6 100644
> > > > > > --- a/fs/f2fs/file.c
> > > > > > +++ b/fs/f2fs/file.c
> > > > > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> > > > > >         ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > > > > >         if (ret)
> > > > > >                 goto out;
> > > > > > -
> > > > > > -       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > > >         inode->i_ctime = current_time(inode);
> > > > > >         f2fs_mark_inode_dirty_sync(inode, true);
> > > > > >
> > > > > >         if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > > > > >                 goto out;
> > > > > >
> > > > > > +       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > > >         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > > > >         filemap_invalidate_lock(inode->i_mapping);
> > > > > >
> > > > > > --
> > > > > > 2.38.1
