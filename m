Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511857340FE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjFQM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjFQM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:28:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39419F;
        Sat, 17 Jun 2023 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687004916; x=1718540916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BS+7g9s6vwhiPsZpjXoLp2psNJroOghxiRnYu0+h3Qo=;
  b=EC+Zdxwn+qCOoCWs3Wg/h9JBxGPhtbZAeBadI6JCOI0WGSamHOKe+fzY
   ePEZBCqN7haISiFuWr2MwbwXCQMSIgiEBP+AlKvb4Cn3SyD8PGcQkHILf
   OCC8R4fVT2vL4CpxBNf7C9UM6Iu2jUno+QdvniDdS+8KakKUly9AqaGsZ
   GID8aAfWDoOuf4hv6Ja+rtYc104T1KqLUQpY4vV71fC89DYK8p1M8/V4M
   iwAwxVGM3BNvuq8g/A9Yfid3sgieL9dR8MUngDy9rayuUaCSVuQKtlIBf
   Uv4F/3lBOAYPMofpSR5XVn2qbADuu5jp6bLvoo8N1HLkq8fVtM52T+ei9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358257308"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="358257308"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 05:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959933040"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="959933040"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2023 05:28:33 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAV2e-0002kM-26;
        Sat, 17 Jun 2023 12:28:32 +0000
Date:   Sat, 17 Jun 2023 20:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
        brauner@kernel.org, hare@suse.de, dsterba@suse.com,
        jinpu.wang@ionos.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] block: fix wrong mode for blkdev_get_by_dev() from
 disk_scan_partitions()
Message-ID: <202306172025.taiLXERW-lkp@intel.com>
References: <20230617103813.3708374-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617103813.3708374-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230616]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/block-fix-wrong-mode-for-blkdev_get_by_dev-from-disk_scan_partitions/20230617-184451
base:   next-20230616
patch link:    https://lore.kernel.org/r/20230617103813.3708374-1-yukuai1%40huaweicloud.com
patch subject: [PATCH -next] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230617/202306172025.taiLXERW-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306172025.taiLXERW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306172025.taiLXERW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/genhd.c:13:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from block/genhd.c:13:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from block/genhd.c:13:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> block/genhd.c:369:52: error: use of undeclared identifier 'FMODE_EXCL'
     369 |         bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
         |                                                           ^
   12 warnings and 1 error generated.


vim +/FMODE_EXCL +369 block/genhd.c

   342	
   343	int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
   344	{
   345		struct block_device *bdev;
   346		int ret = 0;
   347	
   348		if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
   349			return -EINVAL;
   350		if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
   351			return -EINVAL;
   352		if (disk->open_partitions)
   353			return -EBUSY;
   354	
   355		/*
   356		 * If the device is opened exclusively by current thread already, it's
   357		 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
   358		 * synchronize with other exclusive openers and other partition
   359		 * scanners.
   360		 */
   361		if (!(mode & BLK_OPEN_EXCL)) {
   362			ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions,
   363						  NULL);
   364			if (ret)
   365				return ret;
   366		}
   367	
   368		set_bit(GD_NEED_PART_SCAN, &disk->state);
 > 369		bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
   370					 NULL);
   371		if (IS_ERR(bdev))
   372			ret =  PTR_ERR(bdev);
   373		else
   374			blkdev_put(bdev, NULL);
   375	
   376		/*
   377		 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
   378		 * and this will cause that re-assemble partitioned raid device will
   379		 * creat partition for underlying disk.
   380		 */
   381		clear_bit(GD_NEED_PART_SCAN, &disk->state);
   382		if (!(mode & BLK_OPEN_EXCL))
   383			bd_abort_claiming(disk->part0, disk_scan_partitions);
   384		return ret;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
