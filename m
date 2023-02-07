Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F068D1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBGIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:48:48 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04062118
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:48:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vb6bMhL_1675759723;
Received: from 30.221.130.169(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vb6bMhL_1675759723)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 16:48:44 +0800
Message-ID: <ce4731db-8ee6-c2e1-23d7-24778b5b8c63@linux.alibaba.com>
Date:   Tue, 7 Feb 2023 16:48:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] erofs: tidy up internal.h
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/23 5:30 PM, Gao Xiang wrote:
> Reorder internal.h code so that removing unneeded macros and more.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/internal.h | 84 +++++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index c18af21ba9c4..48a2f33de15a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -377,12 +377,6 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
>  			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
>  }
>  
> -extern const struct super_operations erofs_sops;
> -extern struct file_system_type erofs_fs_type;
> -
> -extern const struct address_space_operations erofs_raw_access_aops;
> -extern const struct address_space_operations z_erofs_aops;
> -
>  /* Has a disk mapping */
>  #define EROFS_MAP_MAPPED	0x0001
>  /* Located in metadata (could be copied from bd_inode) */
> @@ -407,7 +401,6 @@ struct erofs_map_blocks {
>  	unsigned int m_flags;
>  };
>  
> -/* Flags used by erofs_map_blocks_flatmode() */
>  #define EROFS_GET_BLOCKS_RAW    0x0001
>  /*
>   * Used to get the exact decompressed length, e.g. fiemap (consider lookback
> @@ -425,24 +418,6 @@ enum {
>  	Z_EROFS_COMPRESSION_RUNTIME_MAX
>  };
>  
> -/* zmap.c */
> -extern const struct iomap_ops z_erofs_iomap_report_ops;
> -
> -#ifdef CONFIG_EROFS_FS_ZIP
> -int z_erofs_fill_inode(struct inode *inode);
> -int z_erofs_map_blocks_iter(struct inode *inode,
> -			    struct erofs_map_blocks *map,
> -			    int flags);
> -#else
> -static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
> -static inline int z_erofs_map_blocks_iter(struct inode *inode,
> -					  struct erofs_map_blocks *map,
> -					  int flags)
> -{
> -	return -EOPNOTSUPP;
> -}
> -#endif	/* !CONFIG_EROFS_FS_ZIP */
> -
>  struct erofs_map_dev {
>  	struct erofs_fscache *m_fscache;
>  	struct block_device *m_bdev;
> @@ -453,8 +428,27 @@ struct erofs_map_dev {
>  	unsigned int m_deviceid;
>  };
>  
> -/* data.c */
> +extern struct file_system_type erofs_fs_type;
> +extern const struct super_operations erofs_sops;
> +
> +extern const struct address_space_operations erofs_raw_access_aops;
> +extern const struct address_space_operations z_erofs_aops;
> +extern const struct address_space_operations erofs_fscache_access_aops;
> +
> +extern const struct inode_operations erofs_generic_iops;
> +extern const struct inode_operations erofs_symlink_iops;
> +extern const struct inode_operations erofs_fast_symlink_iops;
> +extern const struct inode_operations erofs_dir_iops;
> +
>  extern const struct file_operations erofs_file_fops;
> +extern const struct file_operations erofs_dir_fops;
> +
> +extern const struct iomap_ops z_erofs_iomap_report_ops;
> +
> +/* flags for erofs_fscache_register_cookie() */
> +#define EROFS_REG_COOKIE_NEED_INODE	1
> +#define EROFS_REG_COOKIE_NEED_NOEXIST	2
> +
>  void erofs_unmap_metabuf(struct erofs_buf *buf);
>  void erofs_put_metabuf(struct erofs_buf *buf);
>  void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
> @@ -466,26 +460,13 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 start, u64 len);
>  int erofs_map_blocks(struct inode *inode,
>  		     struct erofs_map_blocks *map, int flags);
> -
> -/* inode.c */
> -extern const struct inode_operations erofs_generic_iops;
> -extern const struct inode_operations erofs_symlink_iops;
> -extern const struct inode_operations erofs_fast_symlink_iops;
> -
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		  struct kstat *stat, u32 request_mask,
>  		  unsigned int query_flags);
> -
> -/* namei.c */
> -extern const struct inode_operations erofs_dir_iops;
> -
>  int erofs_namei(struct inode *dir, const struct qstr *name,
>  		erofs_nid_t *nid, unsigned int *d_type);
>  
> -/* dir.c */
> -extern const struct file_operations erofs_dir_fops;
> -
>  static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  {
>  	int retried = 0;
> @@ -501,23 +482,19 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  	return NULL;
>  }
>  
> -/* pcpubuf.c */
>  void *erofs_get_pcpubuf(unsigned int requiredpages);
>  void erofs_put_pcpubuf(void *ptr);
>  int erofs_pcpubuf_growsize(unsigned int nrpages);
>  void erofs_pcpubuf_init(void);
>  void erofs_pcpubuf_exit(void);
>  
> -/* sysfs.c */
>  int erofs_register_sysfs(struct super_block *sb);
>  void erofs_unregister_sysfs(struct super_block *sb);
>  int __init erofs_init_sysfs(void);
>  void erofs_exit_sysfs(void);
>  
> -/* utils.c / zdata.c */
>  struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
> -static inline void erofs_pagepool_add(struct page **pagepool,
> -		struct page *page)
> +static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>  {
>  	set_page_private(page, (unsigned long)*pagepool);
>  	*pagepool = page;
> @@ -543,6 +520,9 @@ int erofs_try_to_free_cached_page(struct page *page);
>  int z_erofs_load_lz4_config(struct super_block *sb,
>  			    struct erofs_super_block *dsb,
>  			    struct z_erofs_lz4_cfgs *lz4, int len);
> +int z_erofs_fill_inode(struct inode *inode);
> +int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
> +			    int flags);
>  #else
>  static inline void erofs_shrinker_register(struct super_block *sb) {}
>  static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -560,6 +540,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
>  	}
>  	return 0;
>  }
> +static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> @@ -580,23 +561,15 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  	}
>  	return 0;
>  }
> -#endif	/* !CONFIG_EROFS_FS_ZIP */
> +#endif	/* !CONFIG_EROFS_FS_ZIP_LZMA */
>  
> -/* flags for erofs_fscache_register_cookie() */
> -#define EROFS_REG_COOKIE_NEED_INODE	1
> -#define EROFS_REG_COOKIE_NEED_NOEXIST	2
> -
> -/* fscache.c */
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  int erofs_fscache_register_fs(struct super_block *sb);
>  void erofs_fscache_unregister_fs(struct super_block *sb);
>  
>  struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						    char *name,
> -						    unsigned int flags);
> +					char *name, unsigned int flags);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
> -
> -extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb)
>  {
> @@ -606,8 +579,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>  
>  static inline
>  struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						     char *name,
> -						     unsigned int flags)
> +					char *name, unsigned int flags)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }

-- 
Thanks,
Jingbo
