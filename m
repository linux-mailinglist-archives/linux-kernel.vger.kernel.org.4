Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65DE68C87F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBFVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:20:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302C24132
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675718418; x=1707254418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=383fGobxKNSFmxYP5/QXybLIpX9L6oHqdyQRfEBUQgQ=;
  b=JCZ8Hd4ZONWalclOcJDqm0LsRNdJK95aVsFhragRl/ywJLoPBMml9FTZ
   5LBvJN8fpn6pRv0I5PozNtJD9LE+MqrxlO4clKrkWHdWTzcq1qP96ZapU
   tltGkoEx++CeAFKtP/osZ/hHKgYkScSsU8lZGCD2Nm1ojCSdjOMFCmn5U
   AfI8NosreKIJ/tDR2CFTDAnjBW+xZ956riQ0rDt+r2QK6kXtRiOzdt4Ya
   bYGyKXVoxvt8uOvQT7TTfkB+j9VkTdbjQ3YiLQxE7JpKYRMQIVvmmDIYb
   pCsvsgpNhpoWDKPSkSnpnn7B+go0DlOenCcTsWtHBqmcgALOgpyFMJSoV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309651861"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309651861"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668537133"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668537133"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 13:20:14 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP8uL-0002nY-1B;
        Mon, 06 Feb 2023 21:20:13 +0000
Date:   Tue, 7 Feb 2023 05:19:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 2/2] shmem: Add shmem_read_folio() and
 shmem_read_folio_gfp()
Message-ID: <202302070525.Ho0cFITJ-lkp@intel.com>
References: <20230206162520.4029022-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206162520.4029022-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/shmem-Add-shmem_read_folio-and-shmem_read_folio_gfp/20230207-002746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230206162520.4029022-2-willy%40infradead.org
patch subject: [PATCH 2/2] shmem: Add shmem_read_folio() and shmem_read_folio_gfp()
config: riscv-randconfig-r023-20230205 (https://download.01.org/0day-ci/archive/20230207/202302070525.Ho0cFITJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ceb56c1ceea709ec0b10ed07e327bb4ae566bba5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/shmem-Add-shmem_read_folio-and-shmem_read_folio_gfp/20230207-002746
        git checkout ceb56c1ceea709ec0b10ed07e327bb4ae566bba5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/shmem.c:4164:13: warning: no previous prototype for function 'shmem_init' [-Wmissing-prototypes]
   void __init shmem_init(void)
               ^
   mm/shmem.c:4164:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init shmem_init(void)
   ^
   static 
   mm/shmem.c:4172:5: warning: no previous prototype for function 'shmem_unuse' [-Wmissing-prototypes]
   int shmem_unuse(unsigned int type)
       ^
   mm/shmem.c:4172:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int shmem_unuse(unsigned int type)
   ^
   static 
   mm/shmem.c:4177:5: warning: no previous prototype for function 'shmem_lock' [-Wmissing-prototypes]
   int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
       ^
   mm/shmem.c:4177:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
   ^
   static 
   mm/shmem.c:4182:6: warning: no previous prototype for function 'shmem_unlock_mapping' [-Wmissing-prototypes]
   void shmem_unlock_mapping(struct address_space *mapping)
        ^
   mm/shmem.c:4182:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void shmem_unlock_mapping(struct address_space *mapping)
   ^
   static 
   mm/shmem.c:4187:15: warning: no previous prototype for function 'shmem_get_unmapped_area' [-Wmissing-prototypes]
   unsigned long shmem_get_unmapped_area(struct file *file,
                 ^
   mm/shmem.c:4187:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long shmem_get_unmapped_area(struct file *file,
   ^
   static 
   mm/shmem.c:4195:6: warning: no previous prototype for function 'shmem_truncate_range' [-Wmissing-prototypes]
   void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
        ^
   mm/shmem.c:4195:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
   ^
   static 
   mm/shmem.c:4255:14: warning: no previous prototype for function 'shmem_kernel_file_setup' [-Wmissing-prototypes]
   struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
                ^
   mm/shmem.c:4255:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
   ^
   static 
   mm/shmem.c:4266:14: warning: no previous prototype for function 'shmem_file_setup' [-Wmissing-prototypes]
   struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
                ^
   mm/shmem.c:4266:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
   ^
   static 
   mm/shmem.c:4279:14: warning: no previous prototype for function 'shmem_file_setup_with_mnt' [-Wmissing-prototypes]
   struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
                ^
   mm/shmem.c:4279:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
   ^
   static 
   mm/shmem.c:4290:5: warning: no previous prototype for function 'shmem_zero_setup' [-Wmissing-prototypes]
   int shmem_zero_setup(struct vm_area_struct *vma)
       ^
   mm/shmem.c:4290:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int shmem_zero_setup(struct vm_area_struct *vma)
   ^
   static 
>> mm/shmem.c:4328:15: warning: no previous prototype for function 'shmem_read_folio_gfp' [-Wmissing-prototypes]
   struct folio *shmem_read_folio_gfp(struct address_space *mapping,
                 ^
   mm/shmem.c:4328:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct folio *shmem_read_folio_gfp(struct address_space *mapping,
   ^
   static 
   mm/shmem.c:4353:14: warning: no previous prototype for function 'shmem_read_mapping_page_gfp' [-Wmissing-prototypes]
   struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
                ^
   mm/shmem.c:4353:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
   ^
   static 
   12 warnings generated.


vim +/shmem_read_folio_gfp +4328 mm/shmem.c

  4312	
  4313	/**
  4314	 * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
  4315	 * @mapping:	the folio's address_space
  4316	 * @index:	the folio index
  4317	 * @gfp:	the page allocator flags to use if allocating
  4318	 *
  4319	 * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
  4320	 * with any new page allocations done using the specified allocation flags.
  4321	 * But read_cache_page_gfp() uses the ->read_folio() method: which does not
  4322	 * suit tmpfs, since it may have pages in swapcache, and needs to find those
  4323	 * for itself; although drivers/gpu/drm i915 and ttm rely upon this support.
  4324	 *
  4325	 * i915_gem_object_get_pages_gtt() mixes __GFP_NORETRY | __GFP_NOWARN in
  4326	 * with the mapping_gfp_mask(), to avoid OOMing the machine unnecessarily.
  4327	 */
> 4328	struct folio *shmem_read_folio_gfp(struct address_space *mapping,
  4329			pgoff_t index, gfp_t gfp)
  4330	{
  4331	#ifdef CONFIG_SHMEM
  4332		struct inode *inode = mapping->host;
  4333		struct folio *folio;
  4334		int error;
  4335	
  4336		BUG_ON(!shmem_mapping(mapping));
  4337		error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
  4338					  gfp, NULL, NULL, NULL);
  4339		if (error)
  4340			return ERR_PTR(error);
  4341	
  4342		folio_unlock(folio);
  4343		return folio;
  4344	#else
  4345		/*
  4346		 * The tiny !SHMEM case uses ramfs without swap
  4347		 */
  4348		return mapping_read_folio_gfp(mapping, index, gfp);
  4349	#endif
  4350	}
  4351	EXPORT_SYMBOL_GPL(shmem_read_folio_gfp);
  4352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
