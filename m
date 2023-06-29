Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B0742902
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjF2PAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjF2PAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:00:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF430C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688050846; x=1719586846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TaGZsvu3xmVN7axiPp+XOepxAwxY0VGq5pBeQB6e/Lk=;
  b=ZgqHTXWlSh1FDQb3FxJxbdDoWxHS99WyMTPvqpFTpA95cgCzcD1oAOVr
   irKTFNluT+w+dHlXFwBOWdgUI/HbN8JlZQMhhtHj63x45PLd7kM6pwfM1
   bXPE0N/KbsG09GU6mMoXyKVG+tzVjKVFTJ0w8lZ7ux7yiL67HQ7FTODyQ
   YPRrDMx7O2sadOIGanliahVccHCsBTBGp+yrhLj2DuB8Xw5DGgAWBcki3
   +SkIvxdYkB6ll2DhGiXl2gP/z8ubZmfg+R4L5Lhu4NRRC06C6caG3JRqh
   JGld4PwOPFrKI5FI/+G1Ioc8OuAOLll+Ymu5TAsuT1C2/bM74OQnbIJqa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364699012"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="364699012"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="667558908"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="667558908"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2023 08:00:30 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEt8H-000EDF-20;
        Thu, 29 Jun 2023 15:00:29 +0000
Date:   Thu, 29 Jun 2023 23:00:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/2] mm: make show_free_areas() static
Message-ID: <202306292240.Rj0DlHfI-lkp@intel.com>
References: <20230629104357.35455-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629104357.35455-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-make-show_free_areas-static/20230629-182958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230629104357.35455-2-wangkefeng.wang%40huawei.com
patch subject: [PATCH 2/2] mm: make show_free_areas() static
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230629/202306292240.Rj0DlHfI-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292240.Rj0DlHfI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306292240.Rj0DlHfI-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/nommu.c: In function 'do_mmap':
>> mm/nommu.c:1239:9: error: implicit declaration of function 'show_free_areas' [-Werror=implicit-function-declaration]
    1239 |         show_free_areas(0, NULL);
         |         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/show_free_areas +1239 mm/nommu.c

^1da177e4c3f41 Linus Torvalds          2005-04-16   996  
^1da177e4c3f41 Linus Torvalds          2005-04-16   997  /*
^1da177e4c3f41 Linus Torvalds          2005-04-16   998   * handle mapping creation for uClinux
^1da177e4c3f41 Linus Torvalds          2005-04-16   999   */
1fcfd8db7f82fa Oleg Nesterov           2015-09-09  1000  unsigned long do_mmap(struct file *file,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1001  			unsigned long addr,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1002  			unsigned long len,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1003  			unsigned long prot,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1004  			unsigned long flags,
bebeb3d68b24bb Michel Lespinasse       2013-02-22  1005  			unsigned long pgoff,
897ab3e0c49e24 Mike Rapoport           2017-02-24  1006  			unsigned long *populate,
897ab3e0c49e24 Mike Rapoport           2017-02-24  1007  			struct list_head *uf)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1008  {
8feae13110d60c David Howells           2009-01-08  1009  	struct vm_area_struct *vma;
8feae13110d60c David Howells           2009-01-08  1010  	struct vm_region *region;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1011  	struct rb_node *rb;
45e55300f11495 Peter Collingbourne     2020-08-06  1012  	vm_flags_t vm_flags;
1fcfd8db7f82fa Oleg Nesterov           2015-09-09  1013  	unsigned long capabilities, result;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1014  	int ret;
47d9644de92c1a Liam R. Howlett         2023-01-20  1015  	VMA_ITERATOR(vmi, current->mm, 0);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1016  
41badc15cbad03 Michel Lespinasse       2013-02-22  1017  	*populate = 0;
bebeb3d68b24bb Michel Lespinasse       2013-02-22  1018  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1019  	/* decide whether we should attempt the mapping, and if so what sort of
^1da177e4c3f41 Linus Torvalds          2005-04-16  1020  	 * mapping */
^1da177e4c3f41 Linus Torvalds          2005-04-16  1021  	ret = validate_mmap_request(file, addr, len, prot, flags, pgoff,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1022  				    &capabilities);
22cc877b32202b Leon Romanovsky         2015-06-24  1023  	if (ret < 0)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1024  		return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1025  
06aab5a3084e1d David Howells           2009-09-24  1026  	/* we ignore the address hint */
06aab5a3084e1d David Howells           2009-09-24  1027  	addr = 0;
f67d9b1576c1c6 Bob Liu                 2011-05-24  1028  	len = PAGE_ALIGN(len);
06aab5a3084e1d David Howells           2009-09-24  1029  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1030  	/* we've determined that we can make the mapping, now translate what we
^1da177e4c3f41 Linus Torvalds          2005-04-16  1031  	 * now know into VMA flags */
45e55300f11495 Peter Collingbourne     2020-08-06  1032  	vm_flags = determine_vm_flags(file, prot, flags, capabilities);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1033  
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1034) 
8feae13110d60c David Howells           2009-01-08  1035  	/* we're going to need to record the mapping */
8feae13110d60c David Howells           2009-01-08  1036  	region = kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
8feae13110d60c David Howells           2009-01-08  1037  	if (!region)
8feae13110d60c David Howells           2009-01-08  1038  		goto error_getting_region;
8feae13110d60c David Howells           2009-01-08  1039  
490fc053865c9c Linus Torvalds          2018-07-21  1040  	vma = vm_area_alloc(current->mm);
8feae13110d60c David Howells           2009-01-08  1041  	if (!vma)
8feae13110d60c David Howells           2009-01-08  1042  		goto error_getting_vma;
8feae13110d60c David Howells           2009-01-08  1043  
47d9644de92c1a Liam R. Howlett         2023-01-20  1044  	if (vma_iter_prealloc(&vmi))
47d9644de92c1a Liam R. Howlett         2023-01-20  1045  		goto error_vma_iter_prealloc;
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1046) 
1e2ae599d37e60 David Howells           2010-01-15  1047  	region->vm_usage = 1;
8feae13110d60c David Howells           2009-01-08  1048  	region->vm_flags = vm_flags;
8feae13110d60c David Howells           2009-01-08  1049  	region->vm_pgoff = pgoff;
8feae13110d60c David Howells           2009-01-08  1050  
1c71222e5f2393 Suren Baghdasaryan      2023-01-26  1051  	vm_flags_init(vma, vm_flags);
8feae13110d60c David Howells           2009-01-08  1052  	vma->vm_pgoff = pgoff;
8feae13110d60c David Howells           2009-01-08  1053  
8feae13110d60c David Howells           2009-01-08  1054  	if (file) {
cb0942b8124979 Al Viro                 2012-08-27  1055  		region->vm_file = get_file(file);
cb0942b8124979 Al Viro                 2012-08-27  1056  		vma->vm_file = get_file(file);
8feae13110d60c David Howells           2009-01-08  1057  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1058  
8feae13110d60c David Howells           2009-01-08  1059  	down_write(&nommu_region_sem);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1060  
8feae13110d60c David Howells           2009-01-08  1061  	/* if we want to share, we need to check for regions created by other
^1da177e4c3f41 Linus Torvalds          2005-04-16  1062  	 * mmap() calls that overlap with our proposed mapping
8feae13110d60c David Howells           2009-01-08  1063  	 * - we can only share with a superset match on most regular files
^1da177e4c3f41 Linus Torvalds          2005-04-16  1064  	 * - shared mappings on character devices and memory backed files are
^1da177e4c3f41 Linus Torvalds          2005-04-16  1065  	 *   permitted to overlap inexactly as far as we are concerned for in
^1da177e4c3f41 Linus Torvalds          2005-04-16  1066  	 *   these cases, sharing is handled in the driver or filesystem rather
^1da177e4c3f41 Linus Torvalds          2005-04-16  1067  	 *   than here
^1da177e4c3f41 Linus Torvalds          2005-04-16  1068  	 */
fc4f4be9b5271e David Hildenbrand       2023-01-02  1069  	if (is_nommu_shared_mapping(vm_flags)) {
8feae13110d60c David Howells           2009-01-08  1070  		struct vm_region *pregion;
8feae13110d60c David Howells           2009-01-08  1071  		unsigned long pglen, rpglen, pgend, rpgend, start;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1072  
8feae13110d60c David Howells           2009-01-08  1073  		pglen = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
8feae13110d60c David Howells           2009-01-08  1074  		pgend = pgoff + pglen;
165b239270be61 David Howells           2007-03-22  1075  
8feae13110d60c David Howells           2009-01-08  1076  		for (rb = rb_first(&nommu_region_tree); rb; rb = rb_next(rb)) {
8feae13110d60c David Howells           2009-01-08  1077  			pregion = rb_entry(rb, struct vm_region, vm_rb);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1078  
fc4f4be9b5271e David Hildenbrand       2023-01-02  1079  			if (!is_nommu_shared_mapping(pregion->vm_flags))
^1da177e4c3f41 Linus Torvalds          2005-04-16  1080  				continue;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1081  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1082  			/* search for overlapping mappings on the same file */
496ad9aa8ef448 Al Viro                 2013-01-23  1083  			if (file_inode(pregion->vm_file) !=
496ad9aa8ef448 Al Viro                 2013-01-23  1084  			    file_inode(file))
^1da177e4c3f41 Linus Torvalds          2005-04-16  1085  				continue;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1086  
8feae13110d60c David Howells           2009-01-08  1087  			if (pregion->vm_pgoff >= pgend)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1088  				continue;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1089  
8feae13110d60c David Howells           2009-01-08  1090  			rpglen = pregion->vm_end - pregion->vm_start;
8feae13110d60c David Howells           2009-01-08  1091  			rpglen = (rpglen + PAGE_SIZE - 1) >> PAGE_SHIFT;
8feae13110d60c David Howells           2009-01-08  1092  			rpgend = pregion->vm_pgoff + rpglen;
8feae13110d60c David Howells           2009-01-08  1093  			if (pgoff >= rpgend)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1094  				continue;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1095  
8feae13110d60c David Howells           2009-01-08  1096  			/* handle inexactly overlapping matches between
8feae13110d60c David Howells           2009-01-08  1097  			 * mappings */
8feae13110d60c David Howells           2009-01-08  1098  			if ((pregion->vm_pgoff != pgoff || rpglen != pglen) &&
8feae13110d60c David Howells           2009-01-08  1099  			    !(pgoff >= pregion->vm_pgoff && pgend <= rpgend)) {
8feae13110d60c David Howells           2009-01-08  1100  				/* new mapping is not a subset of the region */
b4caecd48005fb Christoph Hellwig       2015-01-14  1101  				if (!(capabilities & NOMMU_MAP_DIRECT))
^1da177e4c3f41 Linus Torvalds          2005-04-16  1102  					goto sharing_violation;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1103  				continue;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1104  			}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1105  
8feae13110d60c David Howells           2009-01-08  1106  			/* we've found a region we can share */
1e2ae599d37e60 David Howells           2010-01-15  1107  			pregion->vm_usage++;
8feae13110d60c David Howells           2009-01-08  1108  			vma->vm_region = pregion;
8feae13110d60c David Howells           2009-01-08  1109  			start = pregion->vm_start;
8feae13110d60c David Howells           2009-01-08  1110  			start += (pgoff - pregion->vm_pgoff) << PAGE_SHIFT;
8feae13110d60c David Howells           2009-01-08  1111  			vma->vm_start = start;
8feae13110d60c David Howells           2009-01-08  1112  			vma->vm_end = start + len;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1113  
22cc877b32202b Leon Romanovsky         2015-06-24  1114  			if (pregion->vm_flags & VM_MAPPED_COPY)
1c71222e5f2393 Suren Baghdasaryan      2023-01-26  1115  				vm_flags_set(vma, VM_MAPPED_COPY);
22cc877b32202b Leon Romanovsky         2015-06-24  1116  			else {
8feae13110d60c David Howells           2009-01-08  1117  				ret = do_mmap_shared_file(vma);
8feae13110d60c David Howells           2009-01-08  1118  				if (ret < 0) {
8feae13110d60c David Howells           2009-01-08  1119  					vma->vm_region = NULL;
8feae13110d60c David Howells           2009-01-08  1120  					vma->vm_start = 0;
8feae13110d60c David Howells           2009-01-08  1121  					vma->vm_end = 0;
1e2ae599d37e60 David Howells           2010-01-15  1122  					pregion->vm_usage--;
8feae13110d60c David Howells           2009-01-08  1123  					pregion = NULL;
8feae13110d60c David Howells           2009-01-08  1124  					goto error_just_free;
8feae13110d60c David Howells           2009-01-08  1125  				}
8feae13110d60c David Howells           2009-01-08  1126  			}
8feae13110d60c David Howells           2009-01-08  1127  			fput(region->vm_file);
8feae13110d60c David Howells           2009-01-08  1128  			kmem_cache_free(vm_region_jar, region);
8feae13110d60c David Howells           2009-01-08  1129  			region = pregion;
8feae13110d60c David Howells           2009-01-08  1130  			result = start;
8feae13110d60c David Howells           2009-01-08  1131  			goto share;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1132  		}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1133  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1134  		/* obtain the address at which to make a shared mapping
^1da177e4c3f41 Linus Torvalds          2005-04-16  1135  		 * - this is the hook for quasi-memory character devices to
^1da177e4c3f41 Linus Torvalds          2005-04-16  1136  		 *   tell us the location of a shared mapping
^1da177e4c3f41 Linus Torvalds          2005-04-16  1137  		 */
b4caecd48005fb Christoph Hellwig       2015-01-14  1138  		if (capabilities & NOMMU_MAP_DIRECT) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  1139  			addr = file->f_op->get_unmapped_area(file, addr, len,
^1da177e4c3f41 Linus Torvalds          2005-04-16  1140  							     pgoff, flags);
bb005a59e08733 Namhyung Kim            2011-05-24  1141  			if (IS_ERR_VALUE(addr)) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  1142  				ret = addr;
bb005a59e08733 Namhyung Kim            2011-05-24  1143  				if (ret != -ENOSYS)
8feae13110d60c David Howells           2009-01-08  1144  					goto error_just_free;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1145  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1146  				/* the driver refused to tell us where to site
^1da177e4c3f41 Linus Torvalds          2005-04-16  1147  				 * the mapping so we'll have to attempt to copy
^1da177e4c3f41 Linus Torvalds          2005-04-16  1148  				 * it */
bb005a59e08733 Namhyung Kim            2011-05-24  1149  				ret = -ENODEV;
b4caecd48005fb Christoph Hellwig       2015-01-14  1150  				if (!(capabilities & NOMMU_MAP_COPY))
8feae13110d60c David Howells           2009-01-08  1151  					goto error_just_free;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1152  
b4caecd48005fb Christoph Hellwig       2015-01-14  1153  				capabilities &= ~NOMMU_MAP_DIRECT;
8feae13110d60c David Howells           2009-01-08  1154  			} else {
8feae13110d60c David Howells           2009-01-08  1155  				vma->vm_start = region->vm_start = addr;
8feae13110d60c David Howells           2009-01-08  1156  				vma->vm_end = region->vm_end = addr + len;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1157  			}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1158  		}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1159  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1160  
8feae13110d60c David Howells           2009-01-08  1161  	vma->vm_region = region;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1162  
645d83c5db970a David Howells           2009-09-24  1163  	/* set up the mapping
b4caecd48005fb Christoph Hellwig       2015-01-14  1164  	 * - the region is filled in if NOMMU_MAP_DIRECT is still set
645d83c5db970a David Howells           2009-09-24  1165  	 */
^1da177e4c3f41 Linus Torvalds          2005-04-16  1166  	if (file && vma->vm_flags & VM_SHARED)
8feae13110d60c David Howells           2009-01-08  1167  		ret = do_mmap_shared_file(vma);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1168  	else
645d83c5db970a David Howells           2009-09-24  1169  		ret = do_mmap_private(vma, region, len, capabilities);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1170  	if (ret < 0)
645d83c5db970a David Howells           2009-09-24  1171  		goto error_just_free;
645d83c5db970a David Howells           2009-09-24  1172  	add_nommu_region(region);
8feae13110d60c David Howells           2009-01-08  1173  
ea637639591def Jie Zhang               2009-12-14  1174  	/* clear anonymous mappings that don't ask for uninitialized data */
0bf5f9492389aa Christoph Hellwig       2019-07-16  1175  	if (!vma->vm_file &&
0bf5f9492389aa Christoph Hellwig       2019-07-16  1176  	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
0bf5f9492389aa Christoph Hellwig       2019-07-16  1177  	     !(flags & MAP_UNINITIALIZED)))
ea637639591def Jie Zhang               2009-12-14  1178  		memset((void *)region->vm_start, 0,
ea637639591def Jie Zhang               2009-12-14  1179  		       region->vm_end - region->vm_start);
ea637639591def Jie Zhang               2009-12-14  1180  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1181  	/* okay... we have a mapping; now we have to register it */
8feae13110d60c David Howells           2009-01-08  1182  	result = vma->vm_start;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1183  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1184  	current->mm->total_vm += len >> PAGE_SHIFT;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1185  
8feae13110d60c David Howells           2009-01-08  1186  share:
07f1bc5ad79833 Liam R. Howlett         2023-01-20  1187  	BUG_ON(!vma->vm_region);
07f1bc5ad79833 Liam R. Howlett         2023-01-20  1188  	setup_vma_to_mm(vma, current->mm);
07f1bc5ad79833 Liam R. Howlett         2023-01-20  1189  	current->mm->map_count++;
07f1bc5ad79833 Liam R. Howlett         2023-01-20  1190  	/* add the VMA to the tree */
07f1bc5ad79833 Liam R. Howlett         2023-01-20  1191  	vma_iter_store(&vmi, vma);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1192  
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1193  	/* we flush the region from the icache only when the first executable
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1194  	 * mapping of it is made  */
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1195  	if (vma->vm_flags & VM_EXEC && !region->vm_icache_flushed) {
a75a2df68f87c4 Christoph Hellwig       2020-06-07  1196  		flush_icache_user_range(region->vm_start, region->vm_end);
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1197  		region->vm_icache_flushed = true;
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1198  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1199  
cfe79c00a2f4f6 Mike Frysinger          2010-01-06  1200  	up_write(&nommu_region_sem);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1201  
8feae13110d60c David Howells           2009-01-08  1202  	return result;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1203  
8feae13110d60c David Howells           2009-01-08  1204  error_just_free:
8feae13110d60c David Howells           2009-01-08  1205  	up_write(&nommu_region_sem);
8feae13110d60c David Howells           2009-01-08  1206  error:
47d9644de92c1a Liam R. Howlett         2023-01-20  1207  	vma_iter_free(&vmi);
89a8640279f8bb David Howells           2009-10-30  1208  	if (region->vm_file)
8feae13110d60c David Howells           2009-01-08  1209  		fput(region->vm_file);
8feae13110d60c David Howells           2009-01-08  1210  	kmem_cache_free(vm_region_jar, region);
89a8640279f8bb David Howells           2009-10-30  1211  	if (vma->vm_file)
8feae13110d60c David Howells           2009-01-08  1212  		fput(vma->vm_file);
3928d4f5ee37cd Linus Torvalds          2018-07-21  1213  	vm_area_free(vma);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1214  	return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1215  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1216  sharing_violation:
8feae13110d60c David Howells           2009-01-08  1217  	up_write(&nommu_region_sem);
22cc877b32202b Leon Romanovsky         2015-06-24  1218  	pr_warn("Attempt to share mismatched mappings\n");
8feae13110d60c David Howells           2009-01-08  1219  	ret = -EINVAL;
8feae13110d60c David Howells           2009-01-08  1220  	goto error;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1221  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1222  error_getting_vma:
8feae13110d60c David Howells           2009-01-08  1223  	kmem_cache_free(vm_region_jar, region);
22cc877b32202b Leon Romanovsky         2015-06-24  1224  	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
^1da177e4c3f41 Linus Torvalds          2005-04-16  1225  			len, current->pid);
7c669cfbec1271 Kefeng Wang             2023-06-29  1226  	show_mem();
^1da177e4c3f41 Linus Torvalds          2005-04-16  1227  	return -ENOMEM;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1228  
8feae13110d60c David Howells           2009-01-08  1229  error_getting_region:
22cc877b32202b Leon Romanovsky         2015-06-24  1230  	pr_warn("Allocation of vm region for %lu byte allocation from process %d failed\n",
^1da177e4c3f41 Linus Torvalds          2005-04-16  1231  			len, current->pid);
7c669cfbec1271 Kefeng Wang             2023-06-29  1232  	show_mem();
^1da177e4c3f41 Linus Torvalds          2005-04-16  1233  	return -ENOMEM;
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1234) 
47d9644de92c1a Liam R. Howlett         2023-01-20  1235  error_vma_iter_prealloc:
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1236) 	kmem_cache_free(vm_region_jar, region);
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1237) 	vm_area_free(vma);
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1238) 	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
8220543df1489e Matthew Wilcox (Oracle  2022-09-06 @1239) 	show_free_areas(0, NULL);
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1240) 	return -ENOMEM;
8220543df1489e Matthew Wilcox (Oracle  2022-09-06  1241) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
