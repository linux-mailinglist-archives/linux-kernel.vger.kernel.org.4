Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298F6B2FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCIVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCIVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:42:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B7F8A71;
        Thu,  9 Mar 2023 13:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678398168; x=1709934168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+W5mXRlASR1f5Mca9nZTtyECB+l2HEDka/TiDsd7FV4=;
  b=GrY5Wt2hqMKEgxxdcFXfrbbiqzOw7ve4lEdvGuRoJLT58Nrhg6LGQOam
   L813vVSQ1GN0QM0mK7EnePtT2T/PxHy+xDSv6UGNxdr4w7iTL4r0Erpb3
   57xtZQENoUG8APT09WcPcbrCo86XhnrhRyvy0nfc0o663NOpNiGTBOTtj
   ePt2p6zvkogV6770EFt7raDHuJ90Q9CZYi4oVypFQsPLeSsuXVzmIaJOW
   QBVWfjok43TzmiLQqEd19LEKHsi8dWjiB3r80R49NqRTU7Tiump4EEwuS
   rHgxjUUKukiOS+CsGWXCsLNWoIRkp6qMrVeFUDcHGgBeLDIGj61SJ7S8f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="324926977"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="324926977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 13:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="746478750"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="746478750"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2023 13:42:41 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paO24-0003FF-1U;
        Thu, 09 Mar 2023 21:42:40 +0000
Date:   Fri, 10 Mar 2023 05:41:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH] scsi: qla4xxx: Fix use after free bug in
 da9150_charger_remove due to race condition
Message-ID: <202303100523.6OSGFoVE-lkp@intel.com>
References: <20230309183812.299349-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309183812.299349-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/scsi-qla4xxx-Fix-use-after-free-bug-in-da9150_charger_remove-due-to-race-condition/20230310-024016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230309183812.299349-1-zyytlz.wz%40163.com
patch subject: [PATCH] scsi: qla4xxx: Fix use after free bug in da9150_charger_remove due to race condition
config: s390-randconfig-r044-20230308 (https://download.01.org/0day-ci/archive/20230310/202303100523.6OSGFoVE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f5410be5e51edb79365b3e0be8c80e4ff34e7e50
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zheng-Wang/scsi-qla4xxx-Fix-use-after-free-bug-in-da9150_charger_remove-due-to-race-condition/20230310-024016
        git checkout f5410be5e51edb79365b3e0be8c80e4ff34e7e50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/scsi/qla4xxx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303100523.6OSGFoVE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/qla4xxx/ql4_os.c:10:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/scsi/qla4xxx/ql4_os.c:10:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/scsi/qla4xxx/ql4_os.c:10:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/scsi/qla4xxx/ql4_os.c:9004:20: warning: variable 'ha' is uninitialized when used here [-Wuninitialized]
           cancel_work_sync(&ha->dpc_work);
                             ^~
   drivers/scsi/qla4xxx/ql4_os.c:8995:26: note: initialize the variable 'ha' to silence this warning
           struct scsi_qla_host *ha;
                                   ^
                                    = NULL
   13 warnings generated.


vim +/ha +9004 drivers/scsi/qla4xxx/ql4_os.c

  8963	
  8964	static void qla4xxx_destroy_fw_ddb_session(struct scsi_qla_host *ha)
  8965	{
  8966		struct ddb_entry *ddb_entry;
  8967		int idx;
  8968	
  8969		for (idx = 0; idx < MAX_DDB_ENTRIES; idx++) {
  8970	
  8971			ddb_entry = qla4xxx_lookup_ddb_by_fw_index(ha, idx);
  8972			if ((ddb_entry != NULL) &&
  8973			    (ddb_entry->ddb_type == FLASH_DDB)) {
  8974	
  8975				qla4xxx_destroy_ddb(ha, ddb_entry);
  8976				/*
  8977				 * we have decremented the reference count of the driver
  8978				 * when we setup the session to have the driver unload
  8979				 * to be seamless without actually destroying the
  8980				 * session
  8981				 **/
  8982				try_module_get(qla4xxx_iscsi_transport.owner);
  8983				iscsi_destroy_endpoint(ddb_entry->conn->ep);
  8984				qla4xxx_free_ddb(ha, ddb_entry);
  8985				iscsi_session_teardown(ddb_entry->sess);
  8986			}
  8987		}
  8988	}
  8989	/**
  8990	 * qla4xxx_remove_adapter - callback function to remove adapter.
  8991	 * @pdev: PCI device pointer
  8992	 **/
  8993	static void qla4xxx_remove_adapter(struct pci_dev *pdev)
  8994	{
  8995		struct scsi_qla_host *ha;
  8996	
  8997		/*
  8998		 * If the PCI device is disabled then it means probe_adapter had
  8999		 * failed and resources already cleaned up on probe_adapter exit.
  9000		 */
  9001		if (!pci_is_enabled(pdev))
  9002			return;
  9003	
> 9004		cancel_work_sync(&ha->dpc_work);
  9005		ha = pci_get_drvdata(pdev);
  9006	
  9007		if (is_qla40XX(ha))
  9008			qla4xxx_prevent_other_port_reinit(ha);
  9009	
  9010		/* destroy iface from sysfs */
  9011		qla4xxx_destroy_ifaces(ha);
  9012	
  9013		if ((!ql4xdisablesysfsboot) && ha->boot_kset)
  9014			iscsi_boot_destroy_kset(ha->boot_kset);
  9015	
  9016		qla4xxx_destroy_fw_ddb_session(ha);
  9017		qla4_8xxx_free_sysfs_attr(ha);
  9018	
  9019		qla4xxx_sysfs_ddb_remove(ha);
  9020		scsi_remove_host(ha->host);
  9021	
  9022		qla4xxx_free_adapter(ha);
  9023	
  9024		scsi_host_put(ha->host);
  9025	
  9026		pci_disable_pcie_error_reporting(pdev);
  9027		pci_disable_device(pdev);
  9028	}
  9029	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
