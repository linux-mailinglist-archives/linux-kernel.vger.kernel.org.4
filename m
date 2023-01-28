Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD62F67F7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjA1Mzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjA1Mzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:55:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046E23DBE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674910533; x=1706446533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yCSmWskfWwstmtUECi0Ec3AU/KX75cj9BgYJcLcePps=;
  b=a+WJ1O8qDthNzhR0ixAjJtBnwtDgptQBOx/KSrncwcEsL/ItzzKWGAA3
   KbkF191n32+D3R/jRkgCUVEMLAw1V50rRzLDxEZ4ABCbyUkbTF3tEUkRX
   D6wT9+gew3WGKWO6F72rxDkaS7UH/ty7vh7g1nNHnxZNRjHuVLA8e/ZIl
   2veNZ7ynD+tnlt7TUW3SftPjwOh2OE2ewQesT2WT+le3GaESshXg4C5IX
   iN7VneABof7xWWAjeaNWq0gYhndalCBSlKGo73GgArEDJB1uLllw0T37e
   hQ6SeVpGAeOtv6EcqkQT+tHFvG3CuJMSD1pkKLyOaJNozZIiVzpo3j+fZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="328574898"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="328574898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:55:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="992375551"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="992375551"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2023 04:55:29 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLkjw-0000eq-2T;
        Sat, 28 Jan 2023 12:55:28 +0000
Date:   Sat, 28 Jan 2023 20:55:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] iommu: Retire bus ops
Message-ID: <202301282015.hjj2YFYy-lkp@intel.com>
References: <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.2-rc5]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommu-Decouple-iommu_present-from-bus-ops/20230128-141510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy%40arm.com
patch subject: [PATCH v2 7/8] iommu: Retire bus ops
config: s390-randconfig-r012-20230123 (https://download.01.org/0day-ci/archive/20230128/202301282015.hjj2YFYy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/399f4b37d8065bffafeec12de1344a7ff6098e64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robin-Murphy/iommu-Decouple-iommu_present-from-bus-ops/20230128-141510
        git checkout 399f4b37d8065bffafeec12de1344a7ff6098e64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/iommufd/selftest.c:7:
   In file included from include/linux/iommu.h:10:
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
   In file included from drivers/iommu/iommufd/selftest.c:7:
   In file included from include/linux/iommu.h:10:
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
   In file included from drivers/iommu/iommufd/selftest.c:7:
   In file included from include/linux/iommu.h:10:
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
>> drivers/iommu/iommufd/selftest.c:276:39: error: field designator 'iommu_ops' does not refer to any field in type 'struct bus_type'
           static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
                                                ^
   12 warnings and 1 error generated.


vim +276 drivers/iommu/iommufd/selftest.c

f4b20bb34c83dc Jason Gunthorpe 2022-11-29  271  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  272  /* Create an hw_pagetable with the mock domain so we can test the domain ops */
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  273  static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  274  				    struct iommu_test_cmd *cmd)
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  275  {
f4b20bb34c83dc Jason Gunthorpe 2022-11-29 @276  	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  277  	struct iommufd_hw_pagetable *hwpt;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  278  	struct selftest_obj *sobj;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  279  	struct iommufd_ioas *ioas;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  280  	int rc;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  281  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  282  	ioas = iommufd_get_ioas(ucmd, cmd->id);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  283  	if (IS_ERR(ioas))
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  284  		return PTR_ERR(ioas);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  285  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  286  	sobj = iommufd_object_alloc(ucmd->ictx, sobj, IOMMUFD_OBJ_SELFTEST);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  287  	if (IS_ERR(sobj)) {
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  288  		rc = PTR_ERR(sobj);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  289  		goto out_ioas;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  290  	}
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  291  	sobj->idev.ictx = ucmd->ictx;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  292  	sobj->type = TYPE_IDEV;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  293  	sobj->idev.mock_dev.bus = &mock_bus;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  294  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  295  	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  296  					      &sobj->idev.mock_dev);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  297  	if (IS_ERR(hwpt)) {
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  298  		rc = PTR_ERR(hwpt);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  299  		goto out_sobj;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  300  	}
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  301  	sobj->idev.hwpt = hwpt;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  302  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  303  	/* Userspace must destroy both of these IDs to destroy the object */
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  304  	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  305  	cmd->mock_domain.out_device_id = sobj->obj.id;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  306  	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  307  	iommufd_put_object(&ioas->obj);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  308  	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  309  
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  310  out_sobj:
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  311  	iommufd_object_abort(ucmd->ictx, &sobj->obj);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  312  out_ioas:
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  313  	iommufd_put_object(&ioas->obj);
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  314  	return rc;
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  315  }
f4b20bb34c83dc Jason Gunthorpe 2022-11-29  316  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
