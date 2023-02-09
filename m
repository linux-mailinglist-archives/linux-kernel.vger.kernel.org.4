Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580D68FF6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBIEiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjBIEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:38:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DA59E75
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917335; x=1707453335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OTIJ4/JbDHSiaWz3de3PNwSFXGGlh4n8IJQjcB35lmM=;
  b=frApuhixQQ4cHG6PlS/QhGpRVW15piM9KvIoAptXdIayzPGG0tyD+K/L
   Mjut/Julnh3ccW9GvsPCaulT4xAC0LPUiRD4LOJUsjRKoc3aicyhok5EB
   yCApbThdrpi9P7UMR+3BHJJv+qBcI3S8uDm2KAymE23q28CZ2Ki4QRmkN
   zkLQwVFdonXN9GaLfAsCFTxzvHB3sxM7DtGWWKIjaTpda25E9Wrf9XW1V
   Ck7RSi9ACrQtE8nDDf37V9tHX7US8/Q0ARCm84QMLo47Nk+qK9bEGaAX3
   +7SYQ8sR5olaK34/attwbPD8/ewenkpnxw5FFrpyume7m7+X4HneRgHZ0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327702976"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="327702976"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841453892"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841453892"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 20:34:23 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPyda-0004ow-2f;
        Thu, 09 Feb 2023 04:34:22 +0000
Date:   Thu, 9 Feb 2023 12:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/ntfs/aops.c:378:12: warning: stack frame size (2208) exceeds
 limit (1024) in 'ntfs_read_folio'
Message-ID: <202302091252.YaMb7MJe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: 933906f8e8e4110c56db9bddd1281e4e4983a2bb ntfs: Convert ntfs to read_folio
date:   9 months ago
config: hexagon-buildonly-randconfig-r003-20230209 (https://download.01.org/0day-ci/archive/20230209/202302091252.YaMb7MJe-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=933906f8e8e4110c56db9bddd1281e4e4983a2bb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 933906f8e8e4110c56db9bddd1281e4e4983a2bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ntfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302091252.YaMb7MJe-lkp@intel.com

All warnings (new ones prefixed by >>):

>> fs/ntfs/aops.c:378:12: warning: stack frame size (2208) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
   static int ntfs_read_folio(struct file *file, struct folio *folio)
              ^
   119/2208 (5.39%) spills, 2089/2208 (94.61%) variables
   1 warning generated.


vim +/ntfs_read_folio +378 fs/ntfs/aops.c

   359	
   360	/**
   361	 * ntfs_read_folio - fill a @folio of a @file with data from the device
   362	 * @file:	open file to which the folio @folio belongs or NULL
   363	 * @folio:	page cache folio to fill with data
   364	 *
   365	 * For non-resident attributes, ntfs_read_folio() fills the @folio of the open
   366	 * file @file by calling the ntfs version of the generic block_read_full_folio()
   367	 * function, ntfs_read_block(), which in turn creates and reads in the buffers
   368	 * associated with the folio asynchronously.
   369	 *
   370	 * For resident attributes, OTOH, ntfs_read_folio() fills @folio by copying the
   371	 * data from the mft record (which at this stage is most likely in memory) and
   372	 * fills the remainder with zeroes. Thus, in this case, I/O is synchronous, as
   373	 * even if the mft record is not cached at this point in time, we need to wait
   374	 * for it to be read in before we can do the copy.
   375	 *
   376	 * Return 0 on success and -errno on error.
   377	 */
 > 378	static int ntfs_read_folio(struct file *file, struct folio *folio)
   379	{
   380		struct page *page = &folio->page;
   381		loff_t i_size;
   382		struct inode *vi;
   383		ntfs_inode *ni, *base_ni;
   384		u8 *addr;
   385		ntfs_attr_search_ctx *ctx;
   386		MFT_RECORD *mrec;
   387		unsigned long flags;
   388		u32 attr_len;
   389		int err = 0;
   390	
   391	retry_readpage:
   392		BUG_ON(!PageLocked(page));
   393		vi = page->mapping->host;
   394		i_size = i_size_read(vi);
   395		/* Is the page fully outside i_size? (truncate in progress) */
   396		if (unlikely(page->index >= (i_size + PAGE_SIZE - 1) >>
   397				PAGE_SHIFT)) {
   398			zero_user(page, 0, PAGE_SIZE);
   399			ntfs_debug("Read outside i_size - truncated?");
   400			goto done;
   401		}
   402		/*
   403		 * This can potentially happen because we clear PageUptodate() during
   404		 * ntfs_writepage() of MstProtected() attributes.
   405		 */
   406		if (PageUptodate(page)) {
   407			unlock_page(page);
   408			return 0;
   409		}
   410		ni = NTFS_I(vi);
   411		/*
   412		 * Only $DATA attributes can be encrypted and only unnamed $DATA
   413		 * attributes can be compressed.  Index root can have the flags set but
   414		 * this means to create compressed/encrypted files, not that the
   415		 * attribute is compressed/encrypted.  Note we need to check for
   416		 * AT_INDEX_ALLOCATION since this is the type of both directory and
   417		 * index inodes.
   418		 */
   419		if (ni->type != AT_INDEX_ALLOCATION) {
   420			/* If attribute is encrypted, deny access, just like NT4. */
   421			if (NInoEncrypted(ni)) {
   422				BUG_ON(ni->type != AT_DATA);
   423				err = -EACCES;
   424				goto err_out;
   425			}
   426			/* Compressed data streams are handled in compress.c. */
   427			if (NInoNonResident(ni) && NInoCompressed(ni)) {
   428				BUG_ON(ni->type != AT_DATA);
   429				BUG_ON(ni->name_len);
   430				return ntfs_read_compressed_block(page);
   431			}
   432		}
   433		/* NInoNonResident() == NInoIndexAllocPresent() */
   434		if (NInoNonResident(ni)) {
   435			/* Normal, non-resident data stream. */
   436			return ntfs_read_block(page);
   437		}
   438		/*
   439		 * Attribute is resident, implying it is not compressed or encrypted.
   440		 * This also means the attribute is smaller than an mft record and
   441		 * hence smaller than a page, so can simply zero out any pages with
   442		 * index above 0.  Note the attribute can actually be marked compressed
   443		 * but if it is resident the actual data is not compressed so we are
   444		 * ok to ignore the compressed flag here.
   445		 */
   446		if (unlikely(page->index > 0)) {
   447			zero_user(page, 0, PAGE_SIZE);
   448			goto done;
   449		}
   450		if (!NInoAttr(ni))
   451			base_ni = ni;
   452		else
   453			base_ni = ni->ext.base_ntfs_ino;
   454		/* Map, pin, and lock the mft record. */
   455		mrec = map_mft_record(base_ni);
   456		if (IS_ERR(mrec)) {
   457			err = PTR_ERR(mrec);
   458			goto err_out;
   459		}
   460		/*
   461		 * If a parallel write made the attribute non-resident, drop the mft
   462		 * record and retry the read_folio.
   463		 */
   464		if (unlikely(NInoNonResident(ni))) {
   465			unmap_mft_record(base_ni);
   466			goto retry_readpage;
   467		}
   468		ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
   469		if (unlikely(!ctx)) {
   470			err = -ENOMEM;
   471			goto unm_err_out;
   472		}
   473		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
   474				CASE_SENSITIVE, 0, NULL, 0, ctx);
   475		if (unlikely(err))
   476			goto put_unm_err_out;
   477		attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
   478		read_lock_irqsave(&ni->size_lock, flags);
   479		if (unlikely(attr_len > ni->initialized_size))
   480			attr_len = ni->initialized_size;
   481		i_size = i_size_read(vi);
   482		read_unlock_irqrestore(&ni->size_lock, flags);
   483		if (unlikely(attr_len > i_size)) {
   484			/* Race with shrinking truncate. */
   485			attr_len = i_size;
   486		}
   487		addr = kmap_atomic(page);
   488		/* Copy the data to the page. */
   489		memcpy(addr, (u8*)ctx->attr +
   490				le16_to_cpu(ctx->attr->data.resident.value_offset),
   491				attr_len);
   492		/* Zero the remainder of the page. */
   493		memset(addr + attr_len, 0, PAGE_SIZE - attr_len);
   494		flush_dcache_page(page);
   495		kunmap_atomic(addr);
   496	put_unm_err_out:
   497		ntfs_attr_put_search_ctx(ctx);
   498	unm_err_out:
   499		unmap_mft_record(base_ni);
   500	done:
   501		SetPageUptodate(page);
   502	err_out:
   503		unlock_page(page);
   504		return err;
   505	}
   506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
