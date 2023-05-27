Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2C714388
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjE2FB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjE2FBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:01:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62B1FFD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:59:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so29541015e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685336273; x=1687928273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohsJJX90VuWM0uKjPqV8ba1igb9kMnE6eX395WBJCYg=;
        b=D6xBjdjnHYL9WFhVmW/94s3HupbwgdUZBxIh6bdLIuRBjHh6BSOgy2CRBP+lreEr0q
         Faov/9fyXKLRmMn4lppF/N8XUSdJS6A7AiPUWC6d5Ha0zQJZdtd18kTvjQTUWU4LZ+TE
         pwxY0YICAOiE6ZEB7ph8fwltnrSmZSyrzJKddgQ9xz8E6yYu8kGHMpj6tFJdKparg/Al
         +0Sg7iYNWsk6TKyzSJ5BVHlaA9sMXaOrFO4kXRuNFCSY2il903VnlWo9UlQB0ZoBo9Nr
         3JgDTqPAg93XWAN3I4CNs7edlWiCX6qGw68KDwwdQM2LNvkO/xS/ofZDTTDUVrLMBBgK
         chSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336273; x=1687928273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohsJJX90VuWM0uKjPqV8ba1igb9kMnE6eX395WBJCYg=;
        b=arCxYzdULxBnPz5Y/cgq/eMlIDc6lrLVb5YI+EAx0IGt19oQvbUYwSScgOyr22eexN
         ipsfCflz2dWm88N7WcStprFSQ71ZRMsxp5B7iToABWW9z5/ZRHEiD1fI5pkDgrfatdrC
         BLB6pLYj9GNgYXR7XLYeJmFVAYqqwN1bm8ns3aWCcNX98cE17wVM/DOdhnYnFz8Tk1NO
         SjtFykddhiD0p0fMgUfG3oB1yeULU2Zp4+hw9TCo9Iy3mMWAu0WWQ3MtrNIcbuMJiR/Y
         WZWxyK2PCb+BdXmHv1vJN4HrrTRu3jS6YQtYTR6d4DuHXJ/mBBdKCpmwWRxFB22+CQc1
         kNxQ==
X-Gm-Message-State: AC+VfDxlistKERG0ir2b74YJcSIObJ7hskPe9q/nFfJwNWIiJSal4KHi
        Hk4+rI//gVMwvEOHJ/QN57XPUrRbo0FWfNNFIgc=
X-Google-Smtp-Source: ACHHUZ7PU2vIgE95SfRHql3Pd8dsB9URq9xGqjmKNIGH9ZttXte+4gUZFr4NVKyu7N2IQmzzMr+83g==
X-Received: by 2002:a05:600c:21c6:b0:3f6:89a:94c8 with SMTP id x6-20020a05600c21c600b003f6089a94c8mr8143021wmj.24.1685334551243;
        Sun, 28 May 2023 21:29:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bcc10000000b003f60fb2addbsm16705585wmh.44.2023.05.28.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 21:29:09 -0700 (PDT)
Date:   Sat, 27 May 2023 12:50:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: drivers/pci/controller/vmd.c:876 vmd_enable_domain() error:
 uninitialized symbol 'ret'.
Message-ID: <556247a2-aa6b-4aa6-9ffa-1066f9de86e9@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d85b27b0cc6b5cf54567c5ad913a247a71583ce
commit: 0a584655ef89541dae4d48d2c523b1480ae80284 PCI: vmd: Fix secondary bus reset for Intel bridges
config: x86_64-randconfig-m001-20230526 (https://download.01.org/0day-ci/archive/20230527/202305270219.B96IiIfv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305270219.B96IiIfv-lkp@intel.com/

smatch warnings:
drivers/pci/controller/vmd.c:876 vmd_enable_domain() error: uninitialized symbol 'ret'.

vim +/ret +876 drivers/pci/controller/vmd.c

6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  712  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  713  {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  714  	struct pci_sysdata *sd = &vmd->sysdata;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  715  	struct resource *res;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  716  	u32 upper_bits;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  717  	unsigned long flags;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  718  	LIST_HEAD(resources);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  719  	resource_size_t offset[2] = {0};
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  720  	resource_size_t membar2_offset = 0x2000;
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  721  	struct pci_bus *child;
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  722  	struct pci_dev *dev;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  723  	int ret;
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  724  
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  725  	/*
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  726  	 * Shadow registers may exist in certain VMD device ids which allow
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  727  	 * guests to correctly assign host physical addresses to the root ports
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  728  	 * and child devices. These registers will either return the host value
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  729  	 * or 0, depending on an enable bit in the VMD device.
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  730  	 */
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  731  	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
a1a30170138c9c drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  732  		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  733  		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  734  		if (ret)
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  735  			return ret;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  736  	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  737  		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  738  		if (ret)
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  739  			return ret;
51f939b11cb1c4 drivers/pci/controller/vmd.c Jon Derrick       2020-05-27  740  	}
51f939b11cb1c4 drivers/pci/controller/vmd.c Jon Derrick       2020-05-27  741  
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  742  	/*
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  743  	 * Certain VMD devices may have a root port configuration option which
08bcdd22ecdb01 drivers/pci/controller/vmd.c Jon Derrick       2019-11-12  744  	 * limits the bus range to between 0-127, 128-255, or 224-255
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  745  	 */
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  746  	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  747  		ret = vmd_get_bus_number_start(vmd);
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  748  		if (ret)
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  749  			return ret;
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  750  	}
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  751  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  752  	res = &vmd->dev->resource[VMD_CFGBAR];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  753  	vmd->resources[0] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  754  		.name  = "VMD CFGBAR",
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  755  		.start = vmd->busn_start,
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  756  		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  757  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  758  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  759  
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  760  	/*
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  761  	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  762  	 * put 32-bit resources in the window.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  763  	 *
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  764  	 * There's no hardware reason why a 64-bit window *couldn't*
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  765  	 * contain a 32-bit resource, but pbus_size_mem() computes the
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  766  	 * bridge window size assuming a 64-bit window will contain no
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  767  	 * 32-bit resources.  __pci_assign_resource() enforces that
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  768  	 * artificial restriction to make sure everything will fit.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  769  	 *
f6b6aefee70aa5 drivers/pci/controller/vmd.c Bjorn Helgaas     2019-05-30  770  	 * The only way we could use a 64-bit non-prefetchable MEMBAR is
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  771  	 * if its address is <4GB so that we can convert it to a 32-bit
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  772  	 * resource.  To be visible to the host OS, all VMD endpoints must
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  773  	 * be initially configured by platform BIOS, which includes setting
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  774  	 * up these resources.  We can assume the device is configured
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  775  	 * according to the platform needs.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  776  	 */
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  777  	res = &vmd->dev->resource[VMD_MEMBAR1];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  778  	upper_bits = upper_32_bits(res->end);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  779  	flags = res->flags & ~IORESOURCE_SIZEALIGN;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  780  	if (!upper_bits)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  781  		flags &= ~IORESOURCE_MEM_64;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  782  	vmd->resources[1] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  783  		.name  = "VMD MEMBAR1",
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  784  		.start = res->start,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  785  		.end   = res->end,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  786  		.flags = flags,
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  787  		.parent = res,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  788  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  789  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  790  	res = &vmd->dev->resource[VMD_MEMBAR2];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  791  	upper_bits = upper_32_bits(res->end);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  792  	flags = res->flags & ~IORESOURCE_SIZEALIGN;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  793  	if (!upper_bits)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  794  		flags &= ~IORESOURCE_MEM_64;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  795  	vmd->resources[2] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  796  		.name  = "VMD MEMBAR2",
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  797  		.start = res->start + membar2_offset,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  798  		.end   = res->end,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  799  		.flags = flags,
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  800  		.parent = res,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  801  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  802  
34067c56fa177d drivers/pci/controller/vmd.c Jon Derrick       2020-01-21  803  	sd->vmd_dev = vmd->dev;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  804  	sd->domain = vmd_find_free_domain();
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  805  	if (sd->domain < 0)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  806  		return sd->domain;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  807  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  808  	sd->node = pcibus_to_node(vmd->dev->bus);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  809  
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  810  	/*
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  811  	 * Currently MSI remapping must be enabled in guest passthrough mode
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  812  	 * due to some missing interrupt remapping plumbing. This is probably
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  813  	 * acceptable because the guest is usually CPU-limited and MSI
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  814  	 * remapping doesn't become a performance bottleneck.
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  815  	 */
c94f732e8001a8 drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  816  	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  817  	    offset[0] || offset[1]) {
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  818  		ret = vmd_alloc_irqs(vmd);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  819  		if (ret)
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  820  			return ret;
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  821  
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  822  		vmd_set_msi_remapping(vmd, true);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  823  
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  824  		ret = vmd_create_irq_domain(vmd);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  825  		if (ret)
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  826  			return ret;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  827  
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  828  		/*
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  829  		 * Override the IRQ domain bus token so the domain can be
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  830  		 * distinguished from a regular PCI/MSI domain.
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  831  		 */
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  832  		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  833  	} else {
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  834  		vmd_set_msi_remapping(vmd, false);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  835  	}
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  836  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  837  	pci_add_resource(&resources, &vmd->resources[0]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  838  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  839  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  840  
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  841  	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  842  				       &vmd_ops, sd, &resources);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  843  	if (!vmd->bus) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  844  		pci_free_resource_list(&resources);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  845  		vmd_remove_irq_domain(vmd);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  846  		return -ENODEV;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  847  	}
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  848  
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  849  	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  850  				   to_pci_host_bridge(vmd->bus->bridge));
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  851  
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  852  	vmd_attach_resources(vmd);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  853  	if (vmd->irq_domain)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  854  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  855  	else
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  856  		dev_set_msi_domain(&vmd->bus->dev,
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  857  				   dev_get_msi_domain(&vmd->dev->dev));
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  858  
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  859  	vmd_acpi_begin();
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  860  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  861  	pci_scan_child_bus(vmd->bus);
6aab5622296b99 drivers/pci/controller/vmd.c Nirmal Patel      2021-11-16  862  	vmd_domain_reset(vmd);
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  863  
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  864  	/* When Intel VMD is enabled, the OS does not discover the Root Ports
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  865  	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  866  	 * a reset to the parent of the PCI device supplied as argument. This
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  867  	 * is why we pass a child device, so the reset can be triggered at
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  868  	 * the Intel bridge level and propagated to all the children in the
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  869  	 * hierarchy.
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  870  	 */
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  871  	list_for_each_entry(child, &vmd->bus->children, node) {
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  872  		if (!list_empty(&child->devices)) {
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  873  			dev = list_first_entry(&child->devices,
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  874  					       struct pci_dev, bus_list);
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  875  			if (pci_reset_bus(dev))
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05 @876  				pci_warn(dev, "can't reset device: %d\n", ret);

"ret" is not set here.  No use printing it.

0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  877  
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  878  			break;
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  879  		}
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  880  	}
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  881  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  882  	pci_assign_unassigned_bus_resources(vmd->bus);
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  883  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  884  	/*
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  885  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  886  	 * and will fail pcie_bus_configure_settings() early. It can instead be
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  887  	 * run on each of the real root ports.
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  888  	 */
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  889  	list_for_each_entry(child, &vmd->bus->children, node)
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  890  		pcie_bus_configure_settings(child);
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  891  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  892  	pci_bus_add_devices(vmd->bus);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  893  
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  894  	vmd_acpi_end();
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  895  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  896  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  897  			       "domain"), "Can't create symlink to domain\n");
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  898  	return 0;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  899  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

