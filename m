Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DC68C63A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBFS4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:56:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE7E13D50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675709775; x=1707245775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TB/AUxY+vxvQxWZa7Z5xcZ8qNGVzi5zVocDFkI1MniQ=;
  b=ddgDn+SOsbksfUJOdSUI4yk38L/7aGFgHKGfTphPDUoeDroXL4oqpfR5
   DrQ2k5oUO1mpopF9IDzTALT7WfMJ0xlarTayJTEhv4eencpRK+dp7/hpY
   EhRhyZrGmiEj2IZFgY7YoNe/9V2Xe31ObZan2mit+JDiO5+xZYap5JSWW
   QNB9MpO5zJ3Fko2BclF8p8K0KsF/yFcVDAk4Nbry2f6yOMK0Ze3T0Gx1X
   q+h1HCg6T3byK+nrDnzKlzsADKlEoL1CH0l7ETtxb5S7aZe7PYPc/IbXQ
   uxN569hSjgbeqlieY3QpXtRrGdfKs9Zht+PwqsNVoAKwaNcHJt0dqGscG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327920801"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327920801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666572608"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666572608"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 10:56:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP6ew-0002jc-0C;
        Mon, 06 Feb 2023 18:56:10 +0000
Date:   Tue, 7 Feb 2023 02:56:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 2/2] shmem: Add shmem_read_folio() and
 shmem_read_folio_gfp()
Message-ID: <202302070249.AUvSISRY-lkp@intel.com>
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
[also build test WARNING on linus/master v6.2-rc7 next-20230206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/shmem-Add-shmem_read_folio-and-shmem_read_folio_gfp/20230207-002746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230206162520.4029022-2-willy%40infradead.org
patch subject: [PATCH 2/2] shmem: Add shmem_read_folio() and shmem_read_folio_gfp()
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230207/202302070249.AUvSISRY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ceb56c1ceea709ec0b10ed07e327bb4ae566bba5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/shmem-Add-shmem_read_folio-and-shmem_read_folio_gfp/20230207-002746
        git checkout ceb56c1ceea709ec0b10ed07e327bb4ae566bba5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/shmem.c:4164:13: warning: no previous prototype for 'shmem_init' [-Wmissing-prototypes]
    4164 | void __init shmem_init(void)
         |             ^~~~~~~~~~
   mm/shmem.c:4172:5: warning: no previous prototype for 'shmem_unuse' [-Wmissing-prototypes]
    4172 | int shmem_unuse(unsigned int type)
         |     ^~~~~~~~~~~
   mm/shmem.c:4177:5: warning: no previous prototype for 'shmem_lock' [-Wmissing-prototypes]
    4177 | int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
         |     ^~~~~~~~~~
   mm/shmem.c:4182:6: warning: no previous prototype for 'shmem_unlock_mapping' [-Wmissing-prototypes]
    4182 | void shmem_unlock_mapping(struct address_space *mapping)
         |      ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4187:15: warning: no previous prototype for 'shmem_get_unmapped_area' [-Wmissing-prototypes]
    4187 | unsigned long shmem_get_unmapped_area(struct file *file,
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4195:6: warning: no previous prototype for 'shmem_truncate_range' [-Wmissing-prototypes]
    4195 | void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
         |      ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4255:14: warning: no previous prototype for 'shmem_kernel_file_setup' [-Wmissing-prototypes]
    4255 | struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4266:14: warning: no previous prototype for 'shmem_file_setup' [-Wmissing-prototypes]
    4266 | struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
         |              ^~~~~~~~~~~~~~~~
   mm/shmem.c:4279:14: warning: no previous prototype for 'shmem_file_setup_with_mnt' [-Wmissing-prototypes]
    4279 | struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4290:5: warning: no previous prototype for 'shmem_zero_setup' [-Wmissing-prototypes]
    4290 | int shmem_zero_setup(struct vm_area_struct *vma)
         |     ^~~~~~~~~~~~~~~~
>> mm/shmem.c:4328:15: warning: no previous prototype for 'shmem_read_folio_gfp' [-Wmissing-prototypes]
    4328 | struct folio *shmem_read_folio_gfp(struct address_space *mapping,
         |               ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4353:14: warning: no previous prototype for 'shmem_read_mapping_page_gfp' [-Wmissing-prototypes]
    4353 | struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/shmem_read_folio_gfp +4328 mm/shmem.c

  4259	
  4260	/**
  4261	 * shmem_file_setup - get an unlinked file living in tmpfs
  4262	 * @name: name for dentry (to be seen in /proc/<pid>/maps
  4263	 * @size: size to be set for the file
  4264	 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  4265	 */
> 4266	struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
  4267	{
  4268		return __shmem_file_setup(shm_mnt, name, size, flags, 0);
  4269	}
  4270	EXPORT_SYMBOL_GPL(shmem_file_setup);
  4271	
  4272	/**
  4273	 * shmem_file_setup_with_mnt - get an unlinked file living in tmpfs
  4274	 * @mnt: the tmpfs mount where the file will be created
  4275	 * @name: name for dentry (to be seen in /proc/<pid>/maps
  4276	 * @size: size to be set for the file
  4277	 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  4278	 */
  4279	struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
  4280					       loff_t size, unsigned long flags)
  4281	{
  4282		return __shmem_file_setup(mnt, name, size, flags, 0);
  4283	}
  4284	EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
  4285	
  4286	/**
  4287	 * shmem_zero_setup - setup a shared anonymous mapping
  4288	 * @vma: the vma to be mmapped is prepared by do_mmap
  4289	 */
  4290	int shmem_zero_setup(struct vm_area_struct *vma)
  4291	{
  4292		struct file *file;
  4293		loff_t size = vma->vm_end - vma->vm_start;
  4294	
  4295		/*
  4296		 * Cloning a new file under mmap_lock leads to a lock ordering conflict
  4297		 * between XFS directory reading and selinux: since this file is only
  4298		 * accessible to the user through its mapping, use S_PRIVATE flag to
  4299		 * bypass file security, in the same way as shmem_kernel_file_setup().
  4300		 */
  4301		file = shmem_kernel_file_setup("dev/zero", size, vma->vm_flags);
  4302		if (IS_ERR(file))
  4303			return PTR_ERR(file);
  4304	
  4305		if (vma->vm_file)
  4306			fput(vma->vm_file);
  4307		vma->vm_file = file;
  4308		vma->vm_ops = &shmem_anon_vm_ops;
  4309	
  4310		return 0;
  4311	}
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
