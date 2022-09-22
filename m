Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CE5E6A72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiIVSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIVSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:11:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF654F685C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1978DCE1D9A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44466C433D6;
        Thu, 22 Sep 2022 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663870302;
        bh=qqEhrzEMHMuwKfPqoDEHNAeIHePY6satB6tP61stR18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irPy6i+FAzabvCDnime1nOYTYFtzdZun9SnzHmQtZ/mfdD6MC3mYJM2dJBlLdyWXa
         1inDw33YQoTM1tVBwb56FTtdUndZvXItNziESWbcVhI1uammkrfV7DuY55cAuwZPgZ
         pBe9yHGabn26IpnOwdCJ7DRDIwjXewlfveQVY5oRzqlIwthnBKqB9o1jv4tSTYmeMS
         Eg1WLnnwqFUMI406C0djMwph4w+6F22vfmKZXfh34K7A9gBvvCPmeZxs5TzBRdmoGL
         GpCuAV3Iu+UNd/8EDKBWlXNAU0R9vAsqVUm2W/7KjyBNzAKFYJRHkmBmej6//0xHA9
         kiFTcexazCscw==
Date:   Thu, 22 Sep 2022 11:11:40 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix to detect corrupted meta ino
Message-ID: <YyylXIEhaearlfEf@google.com>
References: <20220913074812.2300528-1-chao@kernel.org>
 <44a1eca6-568b-a752-ef01-06de489eb466@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a1eca6-568b-a752-ef01-06de489eb466@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I modified a bit.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=a9a1592fa175baaaae43f54f175a972757c47919

Thanks,

On 09/22, Chao Yu wrote:
> Ping,
> 
> On 2022/9/13 15:48, Chao Yu wrote:
> > It is possible that ino of dirent or orphan inode is corrupted in a
> > fuzzed image, occasionally, if corrupted ino is equal to meta ino:
> > meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
> > call paths will get meta inode directly, it's not allowed, let's
> > add sanity check to detect such cases.
> > 
> > case #1
> > - recover_dentry
> >   - __f2fs_find_entry
> >   - f2fs_iget_retry
> > 
> > case #2
> > - recover_orphan_inode
> >   - f2fs_iget_retry
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v3:
> > - update commit title/message
> > - change logic inside f2fs_iget() rather than its caller
> >   fs/f2fs/inode.c | 25 ++++++++++++++++++-------
> >   1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index cde0a3dc80c3..1baac6056733 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -487,6 +487,12 @@ static int do_read_inode(struct inode *inode)
> >   	return 0;
> >   }
> > +static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
> > +{
> > +	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
> > +		ino == F2FS_COMPRESS_INO(sbi);
> > +}
> > +
> >   struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > @@ -497,17 +503,22 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >   	if (!inode)
> >   		return ERR_PTR(-ENOMEM);
> > +	if (is_meta_ino(sbi, ino)) {
> > +		if (!(inode->i_state & I_NEW)) {
> > +			f2fs_err(sbi, "detect corrupted inode no:%lu, run fsck to repair", ino);
> > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +			ret = -EFSCORRUPTED;
> > +			trace_f2fs_iget_exit(inode, ret);
> > +			iput(inode);
> > +			return ERR_PTR(ret);
> > +		}
> > +		goto make_now;
> > +	}
> > +
> >   	if (!(inode->i_state & I_NEW)) {
> >   		trace_f2fs_iget(inode);
> >   		return inode;
> >   	}
> > -	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
> > -		goto make_now;
> > -
> > -#ifdef CONFIG_F2FS_FS_COMPRESSION
> > -	if (ino == F2FS_COMPRESS_INO(sbi))
> > -		goto make_now;
> > -#endif
> >   	ret = do_read_inode(inode);
> >   	if (ret)
