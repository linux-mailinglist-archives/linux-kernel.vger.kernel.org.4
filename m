Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC919740CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjF1J0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjF1IIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C663AA6;
        Wed, 28 Jun 2023 01:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72FD26125F;
        Wed, 28 Jun 2023 08:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72539C433C8;
        Wed, 28 Jun 2023 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687939636;
        bh=IOSxMIm++J/AtvG+30u6yhS8IDwIG/Uc3jBJXaL2v1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJeqKGgVWg5IBQHSCInLraK5jpK5xXuP6otl/gct3F4+5nWR4zd2ROPP+cAILOXCs
         LIhaNN/35LDYehBBBm6cL2ZTEW6e4H0hp9egR1zSqoqeFmGxNKQX8T6lRAIAs/Z8vI
         iUV1Gft01eER0aYZYL01KgzOev0M36fSykrcU95DrvbMxIyJcWzEJ8QBvf9JWrlLuu
         LJcycs+ldlaQNuFuvG+c8aM0EkqM0ZNF24/wYnxeRVukMTwAwf7OtxLmJ1uHDJkzlI
         sV2XASFW8pWhoe30lJYXuLUjKnX8iqxVWP+YlzWQT8nnLpAMghv8tluO1lHZMTwui8
         VsnVAIMgGl3tw==
Date:   Wed, 28 Jun 2023 01:07:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove i_xattr_sem to avoid deadlock
 and fix the original issue
Message-ID: <ZJvqMpWiit24BnXL@google.com>
References: <20230613233940.3643362-1-jaegeuk@kernel.org>
 <e5788348-b547-8e10-21af-90544f3aa75c@kernel.org>
 <d0ec4a04-ab81-7e71-ad56-5b22e1815919@kernel.org>
 <ZJmOgRADvLP/4rMJ@google.com>
 <8a370c8e-3b5f-5ea7-5839-76896d1ec69e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a370c8e-3b5f-5ea7-5839-76896d1ec69e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Chao Yu wrote:
> On 2023/6/26 21:11, Jaegeuk Kim wrote:
> > On 06/25, Chao Yu wrote:
> > > On 2023/6/25 15:26, Chao Yu wrote:
> > > > One concern below:
> > > > 
> > > > Thread A:                    Thread B:
> > > > - f2fs_getxattr
> > > >    - lookup_all_xattrs
> > > >     - read_inline_xattr
> > > >      - f2fs_get_node_page(ino)
> > > >      - memcpy inline xattr
> > > >      - f2fs_put_page
> > > >                           - f2fs_setxattr
> > > >                            - __f2fs_setxattr
> > > >                             - __f2fs_setxattr
> > > >                              - write_all_xattrs
> > > >                               - write xnode and inode
> > > >     ---> inline xattr may out of update here.
> > > >     - read_xattr_block
> > > >      - f2fs_get_node_page(xnid)
> > > >      - memcpy xnode xattr
> > > >      - f2fs_put_page
> > > > 
> > > > Do we need to keep xattr_{get,set} being atomical operation?
> > > 
> > > It seems xfstest starts to complain w/ below message...
> > 
> > I don't see any failure. Which test do you see?
> 
> 051, 083, ... 467, 642
> 
> Testcase doesn't fail, but kernel log shows inode has corrupted xattr.

I got it. It seems I had to fix the above issue only while keeping the sem. :(

> 
> > 
> > > 
> > > [ 3400.856443] F2FS-fs (vdc): inode (2187) has invalid last xattr entry, entry_size: 21468
> > > [ 3400.864042] F2FS-fs (vdc): inode (1595) has invalid last xattr entry, entry_size: 26580
> > > [ 3400.865764] F2FS-fs (vdc): inode (2187) has invalid last xattr entry, entry_size: 21468
> > > [ 3400.880067] F2FS-fs (vdc): inode (9839) has corrupted xattr
> > > [ 3400.880714] F2FS-fs (vdc): inode (10855) has corrupted xattr
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > I think we don't need to truncate xattr pages eagerly which introduces lots of
> > > > > data races without big benefits.
> > > > > 
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/f2fs.h  |  1 -
> > > > >    fs/f2fs/super.c |  1 -
> > > > >    fs/f2fs/xattr.c | 31 ++++++++-----------------------
> > > > >    3 files changed, 8 insertions(+), 25 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > > index 3f5b161dd743..7b9af2d51656 100644
> > > > > --- a/fs/f2fs/f2fs.h
> > > > > +++ b/fs/f2fs/f2fs.h
> > > > > @@ -838,7 +838,6 @@ struct f2fs_inode_info {
> > > > >        /* avoid racing between foreground op and gc */
> > > > >        struct f2fs_rwsem i_gc_rwsem[2];
> > > > > -    struct f2fs_rwsem i_xattr_sem; /* avoid racing between reading and changing EAs */
> > > > >        int i_extra_isize;        /* size of extra space located in i_addr */
> > > > >        kprojid_t i_projid;        /* id for project quota */
> > > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > > index 1b2c788ed80d..c917fa771f0e 100644
> > > > > --- a/fs/f2fs/super.c
> > > > > +++ b/fs/f2fs/super.c
> > > > > @@ -1418,7 +1418,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
> > > > >        INIT_LIST_HEAD(&fi->gdirty_list);
> > > > >        init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
> > > > >        init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
> > > > > -    init_f2fs_rwsem(&fi->i_xattr_sem);
> > > > >        /* Will be used by directory only */
> > > > >        fi->i_dir_level = F2FS_SB(sb)->dir_level;
> > > > > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > > > > index 213805d3592c..bdc8a55085a2 100644
> > > > > --- a/fs/f2fs/xattr.c
> > > > > +++ b/fs/f2fs/xattr.c
> > > > > @@ -433,7 +433,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> > > > >    {
> > > > >        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > > >        size_t inline_size = inline_xattr_size(inode);
> > > > > -    struct page *in_page = NULL;
> > > > > +    struct page *in_page = ipage;
> > > > >        void *xattr_addr;
> > > > >        void *inline_addr = NULL;
> > > > >        struct page *xpage;
> > > > > @@ -446,29 +446,19 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> > > > >        /* write to inline xattr */
> > > > >        if (inline_size) {
> > > > > -        if (ipage) {
> > > > > -            inline_addr = inline_xattr_addr(inode, ipage);
> > > > > -        } else {
> > > > > +        if (!in_page) {
> > > > >                in_page = f2fs_get_node_page(sbi, inode->i_ino);
> > > > >                if (IS_ERR(in_page)) {
> > > > >                    f2fs_alloc_nid_failed(sbi, new_nid);
> > > > >                    return PTR_ERR(in_page);
> > > > >                }
> > > > > -            inline_addr = inline_xattr_addr(inode, in_page);
> > > > >            }
> > > > > +        inline_addr = inline_xattr_addr(inode, in_page);
> > > > > -        f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
> > > > > -                            NODE, true, true);
> > > > > -        /* no need to use xattr node block */
> > > > > +        f2fs_wait_on_page_writeback(in_page, NODE, true, true);
> > > > >            if (hsize <= inline_size) {
> > > > > -            err = f2fs_truncate_xattr_node(inode);
> > > > > -            f2fs_alloc_nid_failed(sbi, new_nid);
> > > > > -            if (err) {
> > > > > -                f2fs_put_page(in_page, 1);
> > > > > -                return err;
> > > > > -            }
> > > > >                memcpy(inline_addr, txattr_addr, inline_size);
> > > > > -            set_page_dirty(ipage ? ipage : in_page);
> > > > > +            set_page_dirty(in_page);
> > > > >                goto in_page_out;
> > > > >            }
> > > > >        }
> > > > > @@ -502,12 +492,13 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> > > > >        memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
> > > > >        if (inline_size)
> > > > > -        set_page_dirty(ipage ? ipage : in_page);
> > > > > +        set_page_dirty(in_page);
> > > > >        set_page_dirty(xpage);
> > > > >        f2fs_put_page(xpage, 1);
> > > > >    in_page_out:
> > > > > -    f2fs_put_page(in_page, 1);
> > > > > +    if (in_page != ipage)
> > > > > +        f2fs_put_page(in_page, 1);
> > > > >        return err;
> > > > >    }
> > > > > @@ -528,10 +519,8 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
> > > > >        if (len > F2FS_NAME_LEN)
> > > > >            return -ERANGE;
> > > > > -    f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
> > > > >        error = lookup_all_xattrs(inode, ipage, index, len, name,
> > > > >                    &entry, &base_addr, &base_size, &is_inline);
> > > > > -    f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
> > > > >        if (error)
> > > > >            return error;
> > > > > @@ -565,9 +554,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
> > > > >        int error;
> > > > >        size_t rest = buffer_size;
> > > > > -    f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
> > > > >        error = read_all_xattrs(inode, NULL, &base_addr);
> > > > > -    f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
> > > > >        if (error)
> > > > >            return error;
> > > > > @@ -794,9 +781,7 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
> > > > >        f2fs_balance_fs(sbi, true);
> > > > >        f2fs_lock_op(sbi);
> > > > > -    f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);
> > > > >        err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
> > > > > -    f2fs_up_write(&F2FS_I(inode)->i_xattr_sem);
> > > > >        f2fs_unlock_op(sbi);
> > > > >        f2fs_update_time(sbi, REQ_TIME);
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
