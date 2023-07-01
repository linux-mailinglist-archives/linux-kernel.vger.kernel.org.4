Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9A744618
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjGACYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGACX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 22:23:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65D3C07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688178234; x=1719714234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E0z1pEePXHFinK5gPdDIszCHNxDCc7wnYm0Wukhqvpk=;
  b=L+3K2Vh2BDDSiPVHKiJU0y8LQhmvZ/JvSrJdtl3ErBv8gg32V1hLb9Y2
   2Ces37ygpFk+vvjTTZClYqzSOnluJkDcuOLD3BCP+FhGMwO43K1G/mArF
   GLekVB1FHt+BHdmFUxSgjYnyAgWjfsuUz6XcPNDmCAGO+6E7wDLRZjpy9
   ODp+phbBYzGYrZGIzQ6so4sESVmWDbzMxnrygdsM/6HASWOWWh3t157/n
   BSKmzShEA31w+lBzycRXs30qWaQUuxLyqFh7poIiLAj6PBhp57w0j6t4/
   8/SyI0cj+X7z07m5f4d7wiPgQ1vfpH2dUlQQfSEhg5fagScKuxDugEZPc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="360014413"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="360014413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 19:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="711980948"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="711980948"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2023 19:23:51 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFQH8-000FZN-2O;
        Sat, 01 Jul 2023 02:23:50 +0000
Date:   Sat, 1 Jul 2023 10:22:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>
Subject: drivers/ufs/core/ufshcd.c:6164:13: warning: stack frame size (2720)
 exceeds limit (2048) in 'ufshcd_err_handler'
Message-ID: <202307011038.VfSD8leL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b25f62ccb490680a8cee755ac4528909395e0711
commit: dd11376b9f1b73aca3f8c6eb541486bbb6996f05 scsi: ufs: Split the drivers/scsi/ufs directory
date:   1 year, 1 month ago
config: riscv-randconfig-r016-20230701 (https://download.01.org/0day-ci/archive/20230701/202307011038.VfSD8leL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307011038.VfSD8leL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307011038.VfSD8leL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     464 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     477 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     490 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     501 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     511 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     521 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1024 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/ufs/core/ufshcd.c:6164:13: warning: stack frame size (2720) exceeds limit (2048) in 'ufshcd_err_handler' [-Wframe-larger-than]
    6164 | static void ufshcd_err_handler(struct work_struct *work)
         |             ^
   8 warnings generated.
--
   In file included from drivers/ufs/core/ufshpb.c:16:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     464 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     477 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshpb.c:16:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     490 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshpb.c:16:
   In file included from include/scsi/scsi_cmnd.h:5:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     501 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     511 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     521 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1024 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/ufs/core/ufshpb.c:1414:13: warning: stack frame size (2560) exceeds limit (2048) in 'ufshpb_run_active_subregion_list' [-Wframe-larger-than]
    1414 | static void ufshpb_run_active_subregion_list(struct ufshpb_lu *hpb)
         |             ^
   8 warnings generated.


vim +/ufshcd_err_handler +6164 drivers/ufs/core/ufshcd.c

2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6159  
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  6160  /**
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6161   * ufshcd_err_handler - handle UFS errors that require s/w attention
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  6162   * @work: pointer to work structure
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  6163   */
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17 @6164  static void ufshcd_err_handler(struct work_struct *work)
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  6165  {
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6166  	int retries = MAX_ERR_HANDLER_RETRIES;
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  6167  	struct ufs_hba *hba;
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6168  	unsigned long flags;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6169  	bool needs_restore;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6170  	bool needs_reset;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6171  	bool err_xfer;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6172  	bool err_tm;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6173  	int pmc_err;
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6174  	int tag;
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6175  
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  6176  	hba = container_of(work, struct ufs_hba, eh_work);
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  6177  
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6178  	dev_info(hba->dev,
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6179  		 "%s started; HBA state %s; powered %d; shutting down %d; saved_err = %d; saved_uic_err = %d; force_reset = %d%s\n",
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6180  		 __func__, ufshcd_state_name[hba->ufshcd_state],
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6181  		 hba->is_powered, hba->shutting_down, hba->saved_err,
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6182  		 hba->saved_uic_err, hba->force_reset,
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6183  		 ufshcd_is_link_broken(hba) ? "; link is broken" : "");
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6184  
9cd20d3f473619 drivers/scsi/ufs/ufshcd.c Can Guo            2021-01-13  6185  	down(&hba->host_sem);
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6186  	spin_lock_irqsave(hba->host->host_lock, flags);
c72e79c0ad2bd7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6187  	if (ufshcd_err_handling_should_stop(hba)) {
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6188  		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6189  			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6190  		spin_unlock_irqrestore(hba->host->host_lock, flags);
9cd20d3f473619 drivers/scsi/ufs/ufshcd.c Can Guo            2021-01-13  6191  		up(&hba->host_sem);
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6192  		return;
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6193  	}
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6194  	ufshcd_set_eh_in_progress(hba);
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6195  	spin_unlock_irqrestore(hba->host->host_lock, flags);
c72e79c0ad2bd7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6196  	ufshcd_err_handling_prepare(hba);
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  6197  	/* Complete requests that have door-bell cleared by h/w */
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  6198  	ufshcd_complete_requests(hba);
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6199  	spin_lock_irqsave(hba->host->host_lock, flags);
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6200  again:
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6201  	needs_restore = false;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6202  	needs_reset = false;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6203  	err_xfer = false;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6204  	err_tm = false;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6205  
aa53f580e67b49 drivers/scsi/ufs/ufshcd.c Can Guo            2021-02-23  6206  	if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6207  		hba->ufshcd_state = UFSHCD_STATE_RESET;
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6208  	/*
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6209  	 * A full reset and restore might have happened after preparation
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6210  	 * is finished, double check whether we should stop.
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6211  	 */
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6212  	if (ufshcd_err_handling_should_stop(hba))
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6213  		goto skip_err_handling;
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6214  
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6215  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6216  		bool ret;
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6217  
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6218  		spin_unlock_irqrestore(hba->host->host_lock, flags);
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6219  		/* release the lock as ufshcd_quirk_dl_nac_errors() may sleep */
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6220  		ret = ufshcd_quirk_dl_nac_errors(hba);
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6221  		spin_lock_irqsave(hba->host->host_lock, flags);
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6222  		if (!ret && ufshcd_err_handling_should_stop(hba))
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6223  			goto skip_err_handling;
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6224  	}
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6225  
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6226  	if ((hba->saved_err & (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK)) ||
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6227  	    (hba->saved_uic_err &&
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6228  	     (hba->saved_uic_err != UFSHCD_UIC_PA_GENERIC_ERROR))) {
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6229  		bool pr_prdt = !!(hba->saved_err & SYSTEM_BUS_FATAL_ERROR);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6230  
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6231  		spin_unlock_irqrestore(hba->host->host_lock, flags);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6232  		ufshcd_print_host_state(hba);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6233  		ufshcd_print_pwr_info(hba);
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu        2020-12-05  6234  		ufshcd_print_evt_hist(hba);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6235  		ufshcd_print_tmrs(hba, hba->outstanding_tasks);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6236  		ufshcd_print_trs(hba, hba->outstanding_reqs, pr_prdt);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6237  		spin_lock_irqsave(hba->host->host_lock, flags);
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6238  	}
c3be8d1ee1bff7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6239  
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6240  	/*
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6241  	 * if host reset is required then skip clearing the pending
2df74b6985b51e drivers/scsi/ufs/ufshcd.c Can Guo            2019-11-25  6242  	 * transfers forcefully because they will get cleared during
2df74b6985b51e drivers/scsi/ufs/ufshcd.c Can Guo            2019-11-25  6243  	 * host reset and restore
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6244  	 */
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6245  	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6246  	    ufshcd_is_saved_err_fatal(hba) ||
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6247  	    ((hba->saved_err & UIC_ERROR) &&
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6248  	     (hba->saved_uic_err & (UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6249  				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR)))) {
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6250  		needs_reset = true;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6251  		goto do_reset;
88a92d6ae4fe09 drivers/scsi/ufs/ufshcd.c Can Guo            2020-12-02  6252  	}
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6253  
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6254  	/*
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6255  	 * If LINERESET was caught, UFS might have been put to PWM mode,
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6256  	 * check if power mode restore is needed.
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6257  	 */
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6258  	if (hba->saved_uic_err & UFSHCD_UIC_PA_GENERIC_ERROR) {
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6259  		hba->saved_uic_err &= ~UFSHCD_UIC_PA_GENERIC_ERROR;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6260  		if (!hba->saved_uic_err)
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6261  			hba->saved_err &= ~UIC_ERROR;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6262  		spin_unlock_irqrestore(hba->host->host_lock, flags);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6263  		if (ufshcd_is_pwr_mode_restore_needed(hba))
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6264  			needs_restore = true;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6265  		spin_lock_irqsave(hba->host->host_lock, flags);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6266  		if (!hba->saved_err && !needs_restore)
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6267  			goto skip_err_handling;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6268  	}
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6269  
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6270  	hba->silence_err_logs = true;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6271  	/* release lock as clear command might sleep */
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6272  	spin_unlock_irqrestore(hba->host->host_lock, flags);
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6273  	/* Clear pending transfer requests */
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6274  	for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
307348f6ab144b drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6275  		if (ufshcd_try_to_abort_task(hba, tag)) {
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6276  			err_xfer = true;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6277  			goto lock_skip_pending_xfer_clear;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6278  		}
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6279  		dev_err(hba->dev, "Aborted tag %d / CDB %#02x\n", tag,
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6280  			hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1);
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6281  	}
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6282  
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6283  	/* Clear pending task management requests */
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6284  	for_each_set_bit(tag, &hba->outstanding_tasks, hba->nutmrs) {
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6285  		if (ufshcd_clear_tm_cmd(hba, tag)) {
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6286  			err_tm = true;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6287  			goto lock_skip_pending_xfer_clear;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6288  		}
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6289  	}
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6290  
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6291  lock_skip_pending_xfer_clear:
11682523573c1c drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6292  	/* Complete the requests that are cleared by s/w */
11682523573c1c drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6293  	ufshcd_complete_requests(hba);
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6294  
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  6295  	spin_lock_irqsave(hba->host->host_lock, flags);
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  6296  	hba->silence_err_logs = false;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6297  	if (err_xfer || err_tm) {
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6298  		needs_reset = true;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6299  		goto do_reset;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6300  	}
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6301  
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6302  	/*
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6303  	 * After all reqs and tasks are cleared from doorbell,
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6304  	 * now it is safe to retore power mode.
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6305  	 */
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6306  	if (needs_restore) {
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6307  		spin_unlock_irqrestore(hba->host->host_lock, flags);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6308  		/*
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6309  		 * Hold the scaling lock just in case dev cmds
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6310  		 * are sent via bsg and/or sysfs.
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6311  		 */
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6312  		down_write(&hba->clk_scaling_lock);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6313  		hba->force_pmc = true;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6314  		pmc_err = ufshcd_config_pwr_mode(hba, &(hba->pwr_info));
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6315  		if (pmc_err) {
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6316  			needs_reset = true;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6317  			dev_err(hba->dev, "%s: Failed to restore power mode, err = %d\n",
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6318  					__func__, pmc_err);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6319  		}
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6320  		hba->force_pmc = false;
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6321  		ufshcd_print_pwr_info(hba);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6322  		up_write(&hba->clk_scaling_lock);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6323  		spin_lock_irqsave(hba->host->host_lock, flags);
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6324  	}
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6325  
2355b66ed20ce4 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-24  6326  do_reset:
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6327  	/* Fatal errors need reset */
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6328  	if (needs_reset) {
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6329  		int err;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6330  
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6331  		hba->force_reset = false;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6332  		spin_unlock_irqrestore(hba->host->host_lock, flags);
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6333  		err = ufshcd_reset_and_restore(hba);
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6334  		if (err)
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6335  			dev_err(hba->dev, "%s: reset and restore failed with err %d\n",
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6336  					__func__, err);
c72e79c0ad2bd7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6337  		else
c72e79c0ad2bd7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6338  			ufshcd_recover_pm_error(hba);
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6339  		spin_lock_irqsave(hba->host->host_lock, flags);
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6340  	}
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6341  
583fa62d082483 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6342  skip_err_handling:
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6343  	if (!needs_reset) {
4db7a23605973a drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6344  		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6345  			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6346  		if (hba->saved_err || hba->saved_uic_err)
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6347  			dev_err_ratelimited(hba->dev, "%s: exit: saved_err 0x%x saved_uic_err 0x%x",
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6348  			    __func__, hba->saved_err, hba->saved_uic_err);
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6349  	}
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6350  	/* Exit in an operational state or dead */
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6351  	if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL &&
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6352  	    hba->ufshcd_state != UFSHCD_STATE_ERROR) {
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6353  		if (--retries)
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6354  			goto again;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6355  		hba->ufshcd_state = UFSHCD_STATE_ERROR;
87bf6a6bbe8bd6 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-02  6356  	}
e8e7f27139d5ba drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2014-05-26  6357  	ufshcd_clear_eh_in_progress(hba);
9a47ec7c390e81 drivers/scsi/ufs/ufshcd.c Yaniv Gardi        2016-03-10  6358  	spin_unlock_irqrestore(hba->host->host_lock, flags);
c72e79c0ad2bd7 drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  6359  	ufshcd_err_handling_unprepare(hba);
9cd20d3f473619 drivers/scsi/ufs/ufshcd.c Can Guo            2021-01-13  6360  	up(&hba->host_sem);
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6361  
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6362  	dev_info(hba->dev, "%s finished; HBA state %s\n", __func__,
4693fad7d6d4c2 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-20  6363  		 ufshcd_state_name[hba->ufshcd_state]);
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  6364  }
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  6365  

:::::: The code at line 6164 was first introduced by commit
:::::: 88b099006d83b0bf452379cad4ce494329084726 scsi: ufs: core: Revert "scsi: ufs: Synchronize SCSI and UFS error handling"

:::::: TO: Adrian Hunter <adrian.hunter@intel.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
