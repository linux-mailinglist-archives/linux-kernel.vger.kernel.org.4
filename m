Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAC6D500A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDCSK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB9271B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00A662570
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247DFC433D2;
        Mon,  3 Apr 2023 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545426;
        bh=daLpp3WUpqjgWJJmWb1z5abAtZoFEkpvYCCCUtguGOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXlEabf8s3RtJX/cE9d4gWt9IF/qXLe6MUDaK7IqBn2wtC1LlnwuwRfq+GWcNRwYp
         EalbBiuo40fb5kjEEpdcjbVbJUkFX2lGDEDhir90TldsyA0Ja9w3kRD+Hc6KaElqOa
         nsJVRbimhCkzQgJO93eb4F9W76miiC0GprQG1hlNHyNGHZvodosuuaCCGdGDd6ytt6
         /t8qeDuwPn8j4TsaFg7aleVY2ru69LEhxQ4103BdDpPzmtfFbwFTtJQ5qPFwACyftZ
         3JUn8hAFXvhmjNtF9xtFniXugal5BpdhcIs3NUp8ENG/yOgM5A4EFCII6svSeC2YzR
         Ua0xutcIOw4mg==
Date:   Mon, 3 Apr 2023 11:10:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove struct victim_selection default_v_ops
Message-ID: <ZCsWkOFbn/x4tLp5@google.com>
References: <20230403084055.21482-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084055.21482-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03, Yangtao Li wrote:
> There is only single instance of these ops, so remove the indirection
> and call get_victim_by_default directly.

Originally this was intended to give a chance to provide other allocation
option. Anyway, it seems quit hard to do it anymore.
Minor tip is it'd be better to rename it to f2fs_get_victim().

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/f2fs.h    |  5 ++++-
>  fs/f2fs/gc.c      | 12 +++---------
>  fs/f2fs/segment.c |  7 ++++---
>  fs/f2fs/segment.h |  7 -------
>  4 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8d5124569a03..9a1ec5515121 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3871,7 +3871,10 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
>  int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
>  int __init f2fs_create_garbage_collection_cache(void);
>  void f2fs_destroy_garbage_collection_cache(void);
> -
> +/* victim selection function for cleaning and SSR */
> +int get_victim_by_default(struct f2fs_sb_info *sbi, unsigned int *result,
> +				int gc_type, int type,
> +				char alloc_mode, unsigned long long age);
>  /*
>   * recovery.c
>   */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index f1e0e01a5dd1..f3f0020633ad 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -741,7 +741,7 @@ static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
>   * When it is called from SSR segment selection, it finds a segment
>   * which has minimum valid blocks and removes it from dirty seglist.
>   */
> -static int get_victim_by_default(struct f2fs_sb_info *sbi,
> +int get_victim_by_default(struct f2fs_sb_info *sbi,
>  			unsigned int *result, int gc_type, int type,
>  			char alloc_mode, unsigned long long age)
>  {
> @@ -937,10 +937,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	return ret;
>  }
>  
> -static const struct victim_selection default_v_ops = {
> -	.get_victim = get_victim_by_default,
> -};
> -
>  static struct inode *find_gc_inode(struct gc_inode_list *gc_list, nid_t ino)
>  {
>  	struct inode_entry *ie;
> @@ -1671,8 +1667,8 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
>  	int ret;
>  
>  	down_write(&sit_i->sentry_lock);
> -	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type,
> -					      NO_CHECK_TYPE, LFS, 0);
> +	ret = get_victim_by_default(sbi, victim, gc_type,
> +					NO_CHECK_TYPE, LFS, 0);
>  	up_write(&sit_i->sentry_lock);
>  	return ret;
>  }
> @@ -1969,8 +1965,6 @@ static void init_atgc_management(struct f2fs_sb_info *sbi)
>  
>  void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>  {
> -	DIRTY_I(sbi)->v_ops = &default_v_ops;
> -
>  	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
>  
>  	/* give warm/cold data area from slower device */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cb8aacbc5df6..c9e674fe477b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2881,7 +2881,6 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
>  				int alloc_mode, unsigned long long age)
>  {
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
> -	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
>  	unsigned segno = NULL_SEGNO;
>  	unsigned short seg_type = curseg->seg_type;
>  	int i, cnt;
> @@ -2890,7 +2889,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
>  	sanity_check_seg_type(sbi, seg_type);
>  
>  	/* f2fs_need_SSR() already forces to do this */
> -	if (!v_ops->get_victim(sbi, &segno, BG_GC, seg_type, alloc_mode, age)) {
> +	if (!get_victim_by_default(sbi, &segno, BG_GC,
> +			seg_type, alloc_mode, age)) {
>  		curseg->next_segno = segno;
>  		return 1;
>  	}
> @@ -2917,7 +2917,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
>  	for (; cnt-- > 0; reversed ? i-- : i++) {
>  		if (i == seg_type)
>  			continue;
> -		if (!v_ops->get_victim(sbi, &segno, BG_GC, i, alloc_mode, age)) {
> +		if (!get_victim_by_default(sbi, &segno, BG_GC,
> +				i, alloc_mode, age)) {
>  			curseg->next_segno = segno;
>  			return 1;
>  		}
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index d66c9b636708..89619969ec85 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -289,7 +289,6 @@ enum dirty_type {
>  };
>  
>  struct dirty_seglist_info {
> -	const struct victim_selection *v_ops;	/* victim selction operation */
>  	unsigned long *dirty_segmap[NR_DIRTY_TYPE];
>  	unsigned long *dirty_secmap;
>  	struct mutex seglist_lock;		/* lock for segment bitmaps */
> @@ -300,12 +299,6 @@ struct dirty_seglist_info {
>  	bool enable_pin_section;		/* enable pinning section */
>  };
>  
> -/* victim selection function for cleaning and SSR */
> -struct victim_selection {
> -	int (*get_victim)(struct f2fs_sb_info *, unsigned int *,
> -					int, int, char, unsigned long long);
> -};
> -
>  /* for active log information */
>  struct curseg_info {
>  	struct mutex curseg_mutex;		/* lock for consistency */
> -- 
> 2.35.1
