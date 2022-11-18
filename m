Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BF62FEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKRUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKRUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:44:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8751C2C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668804250; x=1700340250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2wlE3zU5bD9HwcBM5c6083StxxxWTi7YCd0GcQz3Xwc=;
  b=Tw9SFR267FhzMYh8o0brFxxkjyO7/GvmIcYtpAbtSDUD+ikjUkLXaEbQ
   Qkm28YgXmtQS6CR6j03wJtZ64NcjcPC0vEQkLsxA3Cj+WtjTHN+Ai+eAo
   BmUmxTqA+PG0hyTuUszA8+GspgaA15Qz0e+B9B5JmVZNgCGj3pWiE7FFv
   +A/UjBIL+2BkyGG7EkL6zPxj6l1MF7ApB0ChOuYnCuYbBNA80e1Uga9rR
   WdU+yJRbqCQWDLLRkY+AoMlh4jf8BE4zgUnLcdv3UyfyKVP+Y0hlb3fBQ
   TnnSICK8IwQgj1exakeEmvEtyGMgmhYzgkyK9GM8BmWhv8OV0chGRiRyy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296592227"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296592227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="885435070"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="885435070"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2022 12:44:08 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ow8DX-0001mP-39;
        Fri, 18 Nov 2022 20:44:07 +0000
Date:   Sat, 19 Nov 2022 04:43:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/nvme/host/pci.c:2078:10: warning: Local variable 'size'
 shadows outer variable [shadowVariable]
Message-ID: <202211190402.Jc6Lukm8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   84368d882b9688bfac77ce48d33b1e20a4e4a787
commit: 2f0dad1719cbbd690e916a42d937b7605ee63964 nvme: add bug report info for global duplicate id
date:   5 months ago
compiler: mips64-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 2f0dad1719cbbd690e916a42d937b7605ee63964
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> drivers/nvme/host/pci.c:2078:10: warning: Local variable 'size' shadows outer variable [shadowVariable]
     size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
            ^
   drivers/nvme/host/pci.c:2034:6: note: Shadowed declaration
    u64 size, tmp;
        ^
   drivers/nvme/host/pci.c:2078:10: note: Shadow variable
     size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
            ^
>> drivers/nvme/host/pci.c:2299:27: warning: Local variable 'poll_queues' shadows outer variable [shadowVariable]
    unsigned int irq_queues, poll_queues;
                             ^
   drivers/nvme/host/pci.c:99:21: note: Shadowed declaration
   static unsigned int poll_queues;
                       ^
   drivers/nvme/host/pci.c:2299:27: note: Shadow variable
    unsigned int irq_queues, poll_queues;
                             ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/nvme/target/configfs.c:143:6: warning: sscanf() without field width limits can crash with huge input data. [invalidscanf]
    if (sscanf(page, "%sn", port->disc_addr.traddr) != 1)
        ^
   drivers/nvme/target/configfs.c:217:6: warning: sscanf() without field width limits can crash with huge input data. [invalidscanf]
    if (sscanf(page, "%sn", port->disc_addr.trsvcid) != 1)
        ^
>> drivers/nvme/target/configfs.c:857:10: warning: Uninitialized variable: p->subsys [uninitvar]
     if (p->subsys == subsys)
            ^
>> drivers/nvme/target/configfs.c:935:34: warning: Uninitialized variable: p->host [uninitvar]
     if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
                                    ^
--
>> drivers/scsi/scsi_transport_sas.c:255:55: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_host_match(struct attribute_container *cont,
                                                         ^
   drivers/scsi/scsi_transport_sas.c:636:54: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_phy_match(struct attribute_container *cont, struct device *dev)
                                                        ^
   drivers/scsi/scsi_transport_sas.c:802:55: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_port_match(struct attribute_container *cont, struct device *dev)
                                                         ^
   drivers/scsi/scsi_transport_sas.c:1322:55: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_rphy_match(struct attribute_container *cont, struct device *dev)
                                                         ^
   drivers/scsi/scsi_transport_sas.c:1341:58: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_end_dev_match(struct attribute_container *cont,
                                                            ^
   drivers/scsi/scsi_transport_sas.c:1364:59: warning: Parameter 'cont' can be declared as pointer to const [constParameter]
   static int sas_expander_match(struct attribute_container *cont,
                                                             ^
>> drivers/nvme/host/nvme.h:555:37: warning: Parameter 's' can be declared as pointer to const [constParameter]
   static inline int nvme_strlen(char *s, int len)
                                       ^
>> drivers/scsi/scsi_debug.c:912:8: warning: Uninitialized variable: hpnt [uninitvar]
     if ((hpnt->this_id >= 0) &&
          ^
   drivers/scsi/scsi_debug.c:911:19: note: Assignment 'hpnt=sdbg_host->shost', assigned value is <Uninit>
     hpnt = sdbg_host->shost;
                     ^
   drivers/scsi/scsi_debug.c:912:8: note: Uninitialized variable: hpnt
     if ((hpnt->this_id >= 0) &&
          ^
>> drivers/scsi/scsi_debug.c:1070:33: warning: Uninitialized variable: dp->sdbg_host [uninitvar]
      if ((devip->sdbg_host == dp->sdbg_host) &&
                                   ^
>> drivers/scsi/scsi_debug.c:5153:15: warning: Uninitialized variable: devip->used [uninitvar]
     if ((devip->used) && (devip->channel == sdev->channel) &&
                 ^
   drivers/scsi/scsi_debug.c:5147:6: note: Assuming condition is false
    if (!sdbg_host) {
        ^
   drivers/scsi/scsi_debug.c:5153:15: note: Uninitialized variable: devip->used
     if ((devip->used) && (devip->channel == sdev->channel) &&
                 ^
>> drivers/scsi/scsi_debug.c:6233:15: warning: Uninitialized variable: sdhp->si_idx [uninitvar]
       if (sdhp->si_idx != idx) {
                 ^
   drivers/scsi/scsi_debug.c:6217:22: note: Assuming condition is false
     if (sdebug_fake_rw == n)
                        ^
   drivers/scsi/scsi_debug.c:6233:15: note: Uninitialized variable: sdhp->si_idx
       if (sdhp->si_idx != idx) {
                 ^
>> drivers/scsi/scsi_debug.c:7347:8: warning: Uninitialized variables: sdbg_host2.host_list, sdbg_host2.si_idx, sdbg_host2.shost, sdbg_host2.dev, sdbg_host2.dev_info_list [uninitvar]
      if (sdbg_host2 == sdbg_host)
          ^

vim +/size +2078 drivers/nvme/host/pci.c

87ad72a59a38d1 Christoph Hellwig  2017-05-12  2025  
92dc689563170b Christoph Hellwig  2017-09-11  2026  static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
92dc689563170b Christoph Hellwig  2017-09-11  2027  		u32 chunk_size)
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2028  {
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2029  	struct nvme_host_mem_buf_desc *descs;
92dc689563170b Christoph Hellwig  2017-09-11  2030  	u32 max_entries, len;
4033f35d174af4 Christoph Hellwig  2017-08-28  2031  	dma_addr_t descs_dma;
2ee0e4ed5ca24c Dan Carpenter      2017-07-06  2032  	int i = 0;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2033  	void **bufs;
6fbcde6691b514 Minwoo Im          2017-12-05  2034  	u64 size, tmp;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2035  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2036  	tmp = (preferred + chunk_size - 1);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2037  	do_div(tmp, chunk_size);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2038  	max_entries = tmp;
044a9df1a7cbb8 Christoph Hellwig  2017-09-11  2039  
044a9df1a7cbb8 Christoph Hellwig  2017-09-11  2040  	if (dev->ctrl.hmmaxd && dev->ctrl.hmmaxd < max_entries)
044a9df1a7cbb8 Christoph Hellwig  2017-09-11  2041  		max_entries = dev->ctrl.hmmaxd;
044a9df1a7cbb8 Christoph Hellwig  2017-09-11  2042  
750afb08ca7131 Luis Chamberlain   2019-01-04  2043  	descs = dma_alloc_coherent(dev->dev, max_entries * sizeof(*descs),
4033f35d174af4 Christoph Hellwig  2017-08-28  2044  				   &descs_dma, GFP_KERNEL);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2045  	if (!descs)
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2046  		goto out;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2047  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2048  	bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2049  	if (!bufs)
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2050  		goto out_free_descs;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2051  
244a8fe40a09c2 Minwoo Im          2017-11-17  2052  	for (size = 0; size < preferred && i < max_entries; size += len) {
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2053  		dma_addr_t dma_addr;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2054  
50cdb7c61b019a Christoph Hellwig  2017-07-25  2055  		len = min_t(u64, chunk_size, preferred - size);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2056  		bufs[i] = dma_alloc_attrs(dev->dev, len, &dma_addr, GFP_KERNEL,
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2057  				DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2058  		if (!bufs[i])
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2059  			break;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2060  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2061  		descs[i].addr = cpu_to_le64(dma_addr);
6c3c05b087ada8 Chaitanya Kulkarni 2020-07-16  2062  		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2063  		i++;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2064  	}
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2065  
92dc689563170b Christoph Hellwig  2017-09-11  2066  	if (!size)
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2067  		goto out_free_bufs;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2068  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2069  	dev->nr_host_mem_descs = i;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2070  	dev->host_mem_size = size;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2071  	dev->host_mem_descs = descs;
4033f35d174af4 Christoph Hellwig  2017-08-28  2072  	dev->host_mem_descs_dma = descs_dma;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2073  	dev->host_mem_desc_bufs = bufs;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2074  	return 0;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2075  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2076  out_free_bufs:
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2077  	while (--i >= 0) {
6c3c05b087ada8 Chaitanya Kulkarni 2020-07-16 @2078  		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2079  
cc667f6d5de023 Liviu Dudau        2018-12-29  2080  		dma_free_attrs(dev->dev, size, bufs[i],
cc667f6d5de023 Liviu Dudau        2018-12-29  2081  			       le64_to_cpu(descs[i].addr),
cc667f6d5de023 Liviu Dudau        2018-12-29  2082  			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2083  	}
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2084  
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2085  	kfree(bufs);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2086  out_free_descs:
4033f35d174af4 Christoph Hellwig  2017-08-28  2087  	dma_free_coherent(dev->dev, max_entries * sizeof(*descs), descs,
4033f35d174af4 Christoph Hellwig  2017-08-28  2088  			descs_dma);
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2089  out:
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2090  	dev->host_mem_descs = NULL;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2091  	return -ENOMEM;
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2092  }
87ad72a59a38d1 Christoph Hellwig  2017-05-12  2093  

:::::: The code at line 2078 was first introduced by commit
:::::: 6c3c05b087ada8947cd31895f67e433070446234 nvme-core: replace ctrl page size with a macro

:::::: TO: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
