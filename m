Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A381681E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjA3W3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3W3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:29:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0064ED1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9973E612C3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D452DC433D2;
        Mon, 30 Jan 2023 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675117761;
        bh=gR/OXNTMfFpxIjawgCPdUVe1vXsJ1pYOzxfGcgjOsPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPW3rrKn4b2tNtRME907UNOLde6sghcRBLMcQh1djad8Cw4A+fQgF6AZkP1sHdaFF
         0HHuGpxDH2hQyCgBxTU+Ag6sfi/KBd2HcJ/Iaw4sLjQwf8+3DSYhBnRxPx9c56DOvE
         uWZxHgztri1HcfA+ES0SunQJyoqaNtWpXDsba/gXRyxF0UsXsdMdBHEQTHTp7Zw6hC
         2qqUBg3kxITWUjDUK4K71TnoiIdxRoeNMwspyLQ8zMGyPkJ5OmCtuZJpourACQrviN
         oIM1z/rHC9L4vVvyEpDJ1eyDK5W2TdVIIEuYDwD44VmKJAew5d19FQniWCck8auvlI
         iufPnb1xsJphw==
Date:   Mon, 30 Jan 2023 14:29:19 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: fix to set ipu policy
Message-ID: <Y9hEv09nyVAYCcNK@google.com>
References: <20230120134029.69200-1-frank.li@vivo.com>
 <b1f8ba44-dd87-b3c1-c249-10d424c6ccd0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f8ba44-dd87-b3c1-c249-10d424c6ccd0@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please adjust the comments based on v2.

On 01/28, Chao Yu wrote:
> On 2023/1/20 21:40, Yangtao Li wrote:
> > For LFS mode, it should update outplace and no need inplace update.
> > When using LFS mode for small-volume devices, IPU will not be used,
> > and the OPU writing method is actually used, but F2FS_IPU_FORCE can
> > be read from the ipu_policy node, which is different from the actual
> > situation. And after remount, ipu should be disabled when convert to
> > lfs mode, let's fix it.
> > 
> > commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> > warning") increased the limit to 100 columns. BTW modify some unnecessary
> > newlines.
> > 
> > Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   fs/f2fs/segment.h |  2 ++
> >   fs/f2fs/super.c   | 20 +++++++++-----------
> >   2 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index ad6a9c19f46a..0b0eb8f03cba 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -670,6 +670,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
> >   #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
> > +#define F2FS_IPU_DISABLE	0
> > +
> >   enum {
> >   	F2FS_IPU_FORCE,
> >   	F2FS_IPU_SSR,
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index d8a65645ee48..ebc76683f05d 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2272,6 +2272,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >   	if (err)
> >   		goto restore_opts;
> > +	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
> 
> if (f2fs_lfs_mode())
> 
> > +		SM_I(sbi)->ipu_policy = F2FS_IPU_DISABLE;
> 
> How about adding such restriction to f2fs_tuning_parameters()? For
> f2fs_remount() and __sbi_store() cases, how about returning -EINVAL if
> there is a conflict?
> 
> Thanks,
> 
> > +
> >   	/*
> >   	 * Previous and new state of filesystem is RO,
> >   	 * so skip checking GC and FLUSH_MERGE conditions.
> > @@ -4080,10 +4083,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
> >   	/* adjust parameters according to the volume size */
> >   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
> >   		if (f2fs_block_unit_discard(sbi))
> > -			SM_I(sbi)->dcc_info->discard_granularity =
> > -						MIN_DISCARD_GRANULARITY;
> > -		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
> > -					BIT(F2FS_IPU_HONOR_OPU_WRITE);
> > +			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
> > +		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS)
> > +			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
> >   	}
> >   	sbi->readdir_ra = true;
> > @@ -4310,9 +4312,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >   			test_opt(sbi, MERGE_CHECKPOINT)) {
> >   		err = f2fs_start_ckpt_thread(sbi);
> >   		if (err) {
> > -			f2fs_err(sbi,
> > -			    "Failed to start F2FS issue_checkpoint_thread (%d)",
> > -			    err);
> > +			f2fs_err(sbi, "Failed to start F2FS issue_checkpoint_thread (%d)", err);
> >   			goto stop_ckpt_thread;
> >   		}
> >   	}
> > @@ -4320,14 +4320,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >   	/* setup f2fs internal modules */
> >   	err = f2fs_build_segment_manager(sbi);
> >   	if (err) {
> > -		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> > -			 err);
> > +		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)", err);
> >   		goto free_sm;
> >   	}
> >   	err = f2fs_build_node_manager(sbi);
> >   	if (err) {
> > -		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
> > -			 err);
> > +		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)", err);
> >   		goto free_nm;
> >   	}
