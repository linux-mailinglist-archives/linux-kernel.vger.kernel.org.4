Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADC5FAAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJKDBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJKDBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603E8708F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665457267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1wC3d9uWwwwOQQ9RsBaU/4vr5gGvAr5FF2s6eiKLO4=;
        b=aXBLm0/RL6s/lCKxz9wggW3og6RZFHpxDchC3IZXl2+DU3eK0EYZ4uvUi/BESCPF7eJGKh
        qxZg65F4n01aIkRxdN/cD/vgM7JG3EeDV4mKfXjI/++vNK8JQrOp8E8GU79YRWX4dRZ6/V
        sA8KfcuKSP6+xvQGK7RxcBo57V6wrZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-uhWtAbYfOlytb-pGcdnMsQ-1; Mon, 10 Oct 2022 23:01:04 -0400
X-MC-Unique: uhWtAbYfOlytb-pGcdnMsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51FEE185A7A4;
        Tue, 11 Oct 2022 03:01:03 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 281B7140EBF5;
        Tue, 11 Oct 2022 03:01:00 +0000 (UTC)
Date:   Tue, 11 Oct 2022 11:00:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, David.Laight@aculab.com,
        shorne@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0TcaZD4nB1w+mAQ@MiWiFi-R3L-srv>
References: <20221009103114.149036-10-bhe@redhat.com>
 <202210092100.mfRPyPqR-lkp@intel.com>
 <Y0P2HEa4q5/XDj0Z@MiWiFi-R3L-srv>
 <2fdf9cb63c0e738082fe9874a5ed7f508d55a36f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fdf9cb63c0e738082fe9874a5ed7f508d55a36f.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 at 01:53pm, Niklas Schnelle wrote:
> On Mon, 2022-10-10 at 18:38 +0800, Baoquan He wrote:
> > On 10/09/22 at 09:54pm, kernel test robot wrote:
> > > Hi Baoquan,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on linus/master]
> > > [also build test ERROR on next-20221007]
> > > [cannot apply to akpm-mm/mm-everything openrisc/for-next deller-parisc/for-next s390/features v6.0]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a6afa4199d3d038fbfdff5511f7523b0e30cb774
> > > config: s390-buildonly-randconfig-r006-20221009
> > > compiler: s390-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/intel-lab-lkp/linux/commit/69f65149d2e87de076edbb2b4dd9532f8f57dd8b
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> > >         git checkout 69f65149d2e87de076edbb2b4dd9532f8f57dd8b
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    s390-linux-ld: mm/ioremap.o: in function `ioremap_prot':
> > > > > ioremap.c:(.text+0x9a): undefined reference to `arch_ioremap'
> > >    s390-linux-ld: mm/ioremap.o: in function `iounmap':
> > > > > ioremap.c:(.text+0x234): undefined reference to `arch_iounmap'
> > >    s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> > >    hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> > >    s390-linux-ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> > 
> > The above compiling errors are caused by unsetting CONFIG_PCI in
> > s390-buildonly-randconfig-r006-20221009 attached. I keep the items for
> > reference. Because s390 puts io mem functions in arch/s390/pci/pci.c.
> > While building arch/s390/pci/pci.c in needs CONFIG_PCI enabled. I don't
> > think disabling CONFIG_PCI in s390x makes sense in reality, except of
> > the randconfig testing.
> > 
> > Hi Niklas, lkp
> > 
> > What do you think about this? We can just ignore this building error
> > with randconfig in lkp?
> 
> Hmm, that's a bummer. As s390 systems (aka mainframes) do have classic
> channel devices for networking and permanent storage that are currently
> even more common than PCI devices you can definitely have a fully
> functional system with CONFIG_PCI=n. Also the drivers for these channel
> devices do not use ioremap() which is only used for PCI, so in theory
> it should be fine not to have ioremap() for CONFIG_PCI=n.

Thanks for detailed explanation.

I built the latest upstream kernel with the randconfig, it has the issue
either, please see below build log snippet. Means if CONFIG_PCI is unset,
it has problem with the current s390 code.

ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
cistpl.c:(.text+0x1202): undefined reference to `ioremap'
ld: cistpl.c:(.text+0x13b0): undefined reference to `iounmap'
ld: cistpl.c:(.text+0x14a6): undefined reference to `iounmap'
ld: cistpl.c:(.text+0x1544): undefined reference to `ioremap'
ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
cistpl.c:(.text+0x3f14): undefined reference to `iounmap'
make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make: *** [Makefile:1235: vmlinux] Error 2

> 
> I think the reason for this concrete failure to compile is a missing
> HAS_IOMEM dependency for CONFIG_QCOM_HIDMA. I'm not sure how many other
> cases there are though as I think we might be the only ones where
> HAS_IOMEM is only sometimes available (it depends on CONFIG_PCI for
> us). Ideally I think we would have the driver dependencies. I'm a bit
> confused though since in the current code it looks to me like
> ioremap_prot() will be declared but not defined for CONFIG_PCI=n too as
> far as I can tell at least.

Yeah, depending on HAS_IOMEM for QCOM_HIDMA can fix it. And in
drivers/pcmcia/cistpl.c, there are ioremap()/iounmap() calling too.
Make PCMCIA depend on HAS_IOMEM can fix it. 

ioremap_prot() will called outside if CONFIG_HAVE_IOREMAP_PROT is
enabled. With this patchset, it will only be declared and defined when
CONFIG_GENERIC_IOREMAP is enabled. Please correct me if I'm wrong.

Below draft change can fix the compiling errors with the randconfig on
s390 as you suggested. We may need post the driver code change in
another patch since it's not related to this patchset?

From 1e169ce8e825d3a33be891ad06e14008582c7011 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 11 Oct 2022 09:30:49 +0800
Subject: [PATCH] s390, ioremap: fix
Content-type: text/plain

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it's likely to have a fully functional s390
kernel with CONFIG_PCI=n.

So let GENERIC_IOREMAP depend on PCI in s390 arch since the drivers for
those channel devices do not use ioremap() which is only used for PCI,
in theory it should be fine not to have ioremap() for CONFIG_PCI=n.

And let QCOM_HIDMA and PCMCIA PCMCIA depend on HAS_IOMEM so that they
won't be built if PCI is unset.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/Kconfig        | 2 +-
 drivers/dma/qcom/Kconfig | 1 +
 drivers/pcmcia/Kconfig   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c59e1b25f59d..f6a7f1752f0f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -135,7 +135,7 @@ config S390
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
-	select GENERIC_IOREMAP
+	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index 3f926a653bd8..ace75d7b835a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
 
 config QCOM_HIDMA
 	tristate "Qualcomm Technologies HIDMA Channel support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for the Qualcomm Technologies HIDMA controller.
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 1525023e49b6..7c412bbe8bbe 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -20,6 +20,7 @@ if PCCARD
 
 config PCMCIA
 	tristate "16-bit PCMCIA support"
+	depends on HAS_IOMEM
 	select CRC32
 	default y
 	help
-- 
2.34.1



