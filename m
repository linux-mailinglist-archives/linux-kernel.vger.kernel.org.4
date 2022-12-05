Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1906430FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiLETEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLETEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:04:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0664F017
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:04:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73018B811E6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 19:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A66C433D6;
        Mon,  5 Dec 2022 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670267048;
        bh=Yb0dClbFV8k9lVOuLWFdRLqaOmW9bC5EhWjjokQe8Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us2EILCevfFxMVwmhFzbrtHf/fSeKlO6QmazjpUAvGcgVJ8otip6DVtOZDthkMayu
         MBvMwjWVzM3Fw0ivm78UFH6Cy9+fD1H5usMVI9/vdJ78cagpK2AN63Wmh8TDVddp+2
         EcMw8XoUBFf1L367xWWBMHSsT4oXNe9p1DQ55thMk3JuJ7OSjl8nSzwifDvEIRUddl
         57Pr4JpvLfIosYhJgiCr8redeqbYovhKH4E0kyybkpkkJkvJ1yRp3WxQPRNT8nRboC
         DJ1JVeSd2OBAdksImkla1IOyC3VbZjedwawN6Nrl6aSrie30EGqJpUX8dtuoUqZQNb
         VVeTNjFqnXoQA==
Date:   Mon, 5 Dec 2022 11:04:06 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     qixiaoyu1 <qxy65535@gmail.com>
Cc:     xiongping1 <xiongping1@xiaomi.com>,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: record total data blocks allocated
 since mount
Message-ID: <Y45ApqnHXf1ierdg@google.com>
References: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
 <20221128085859.5295-2-qixiaoyu1@xiaomi.com>
 <Y4VzmiShMvp87z3p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4VzmiShMvp87z3p@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Jaegeuk Kim wrote:
> On 11/28, qixiaoyu1 wrote:
> > From: xiongping1 <xiongping1@xiaomi.com>
> > 
> > Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> > Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> > ---
> >  fs/f2fs/Kconfig     |  7 +++++++
> >  fs/f2fs/Makefile    |  1 +
> >  fs/f2fs/block_age.c | 28 ++++++++++++++++++++++++++++
> >  fs/f2fs/debug.c     |  7 +++++++
> >  fs/f2fs/f2fs.h      | 15 +++++++++++++++
> >  fs/f2fs/segment.c   |  4 ++++
> >  fs/f2fs/super.c     |  4 ++++
> >  7 files changed, 66 insertions(+)
> >  create mode 100644 fs/f2fs/block_age.c
> > 
> > diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> > index 03ef087537c7..84915f9c6bc8 100644
> > --- a/fs/f2fs/Kconfig
> > +++ b/fs/f2fs/Kconfig
> > @@ -150,3 +150,10 @@ config F2FS_UNFAIR_RWSEM
> >  	help
> >  	  Use unfair rw_semaphore, if system configured IO priority by block
> >  	  cgroup.
> > +
> > +config F2FS_FS_DATA_SEPARATION
> > +	bool "F2FS hot/cold data separation feature"
> > +	depends on F2FS_FS
> > +	help
> > +	  Enable data blocks separation according to block update frequency.
> > +
> > diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
> > index 8a7322d229e4..70d8f0e23b46 100644
> > --- a/fs/f2fs/Makefile
> > +++ b/fs/f2fs/Makefile
> > @@ -10,3 +10,4 @@ f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
> >  f2fs-$(CONFIG_FS_VERITY) += verity.o
> >  f2fs-$(CONFIG_F2FS_FS_COMPRESSION) += compress.o
> >  f2fs-$(CONFIG_F2FS_IOSTAT) += iostat.o
> > +f2fs-$(CONFIG_F2FS_FS_DATA_SEPARATION) += block_age.o
> > diff --git a/fs/f2fs/block_age.c b/fs/f2fs/block_age.c
> > new file mode 100644
> > index 000000000000..1e8711a03959
> > --- /dev/null
> > +++ b/fs/f2fs/block_age.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * fs/f2fs/block_age.c
> > + *
> > + * Copyright (c) 2022 xiaomi Co., Ltd.
> > + *             http://www.xiaomi.com/
> 
> I don't think this is a right way, since it seems you copied lots of codes
> from extent_cache.c which has another copyrights.
> 
> I'm thinking to integrate your extent_cache code into the original path in
> order to keep the single code path for easy debugging. Stay tuned.

Hi,

Could you please check this patch series?

https://lore.kernel.org/linux-f2fs-devel/20221205185433.3479699-1-jaegeuk@kernel.org/T/#t


Thanks,

> 
> > + */
> > +#include <linux/fs.h>
> > +#include <linux/f2fs_fs.h>
> > +
> > +#include "f2fs.h"
> > +#include "segment.h"
> > +
> > +static inline void f2fs_inc_data_block_alloc(struct f2fs_sb_info *sbi)
> > +{
> > +	atomic64_inc(&sbi->total_data_alloc);
> > +}
> > +
> > +void f2fs_init_block_age_info(struct f2fs_sb_info *sbi)
> > +{
> > +	atomic64_set(&sbi->total_data_alloc, 0);
> > +}
> > +
> > +void f2fs_inc_block_alloc_count(struct f2fs_sb_info *sbi, int type)
> > +{
> > +	if (IS_DATASEG(type))
> > +		f2fs_inc_data_block_alloc(sbi);
> > +}
> > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > index a216dcdf6941..d24abdac20bb 100644
> > --- a/fs/f2fs/debug.c
> > +++ b/fs/f2fs/debug.c
> > @@ -81,6 +81,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> >  	si->ext_tree = atomic_read(&sbi->total_ext_tree);
> >  	si->zombie_tree = atomic_read(&sbi->total_zombie_tree);
> >  	si->ext_node = atomic_read(&sbi->total_ext_node);
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +	si->total_data_blocks_alloc = atomic64_read(&sbi->total_data_alloc);
> > +#endif
> >  	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
> >  	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
> >  	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
> > @@ -373,6 +376,10 @@ static int stat_show(struct seq_file *s, void *v)
> >  			seq_printf(s, "Utilization: %u%% (%u valid blocks)\n",
> >  				si->utilization, si->valid_count);
> >  
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +		seq_printf(s, "  - Data Block Allocated: %llu\n",
> > +			   si->total_data_blocks_alloc);
> > +#endif
> >  		seq_printf(s, "  - Node: %u (Inode: %u, ",
> >  			   si->valid_node_count, si->valid_inode_count);
> >  		seq_printf(s, "Other: %u)\n  - Data: %u\n",
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e6355a5683b7..686f09846de4 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1807,6 +1807,10 @@ struct f2fs_sb_info {
> >  	u64 sectors_written_start;
> >  	u64 kbytes_written;
> >  
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +	atomic64_t total_data_alloc;
> > +#endif
> > +
> >  	/* Reference to checksum algorithm driver via cryptoapi */
> >  	struct crypto_shash *s_chksum_driver;
> >  
> > @@ -3858,6 +3862,9 @@ struct f2fs_stat_info {
> >  	int main_area_segs, main_area_sections, main_area_zones;
> >  	unsigned long long hit_largest, hit_cached, hit_rbtree;
> >  	unsigned long long hit_total, total_ext;
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +	unsigned long long total_data_blocks_alloc;
> > +#endif
> >  	int ext_tree, zombie_tree, ext_node;
> >  	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
> >  	int ndirty_data, ndirty_qdata;
> > @@ -4166,6 +4173,14 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
> >  int __init f2fs_create_extent_cache(void);
> >  void f2fs_destroy_extent_cache(void);
> >  
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +/*
> > + * block_age.c
> > + */
> > +void f2fs_init_block_age_info(struct f2fs_sb_info *sbi);
> > +void f2fs_inc_block_alloc_count(struct f2fs_sb_info *sbi, int type);
> > +#endif
> > +
> >  /*
> >   * sysfs.c
> >   */
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index acf3d3fa4363..0cf022fd3560 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3280,6 +3280,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >  	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
> >  	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
> >  
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +	f2fs_inc_block_alloc_count(sbi, type);
> > +#endif
> > +
> >  	up_write(&sit_i->sentry_lock);
> >  
> >  	if (page && IS_NODESEG(type)) {
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 3834ead04620..bf799d92282a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4475,6 +4475,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  
> >  	f2fs_join_shrinker(sbi);
> >  
> > +#ifdef CONFIG_F2FS_FS_DATA_SEPARATION
> > +	f2fs_init_block_age_info(sbi);
> > +#endif
> > +
> >  	f2fs_tuning_parameters(sbi);
> >  
> >  	f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
> > -- 
> > 2.36.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
