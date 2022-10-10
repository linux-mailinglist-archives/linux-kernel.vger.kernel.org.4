Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356405F9CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiJJKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiJJKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546565B06E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665398309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK9Fcz441oIKG5a7FgR5S+4f/f2VUnED47PafWI5itI=;
        b=gZyldS+qlP+NqRfwOm2/Bf2SoeNrTl/Eza9OX7Xh0mA2jRKLl+gIcieZaBXpo19QGyjngt
        qAyDvMg8ppJWRUfKVMVv8pdKfHGXR3+PQL9OU26YadVQt5Z4EP7eCv3oQ/SoMTHz8NOo/D
        OciMBwgQWb0oLGx/txBUAkJ8sI3pNig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-hB7w2ShsPN64vv_SH-7tsw-1; Mon, 10 Oct 2022 06:38:26 -0400
X-MC-Unique: hB7w2ShsPN64vv_SH-7tsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D04D85A5A6;
        Mon, 10 Oct 2022 10:38:25 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DBA9215CDC3;
        Mon, 10 Oct 2022 10:38:24 +0000 (UTC)
Date:   Mon, 10 Oct 2022 18:38:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0P2HEa4q5/XDj0Z@MiWiFi-R3L-srv>
References: <20221009103114.149036-10-bhe@redhat.com>
 <202210092100.mfRPyPqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210092100.mfRPyPqR-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/22 at 09:54pm, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20221007]
> [cannot apply to akpm-mm/mm-everything openrisc/for-next deller-parisc/for-next s390/features v6.0]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a6afa4199d3d038fbfdff5511f7523b0e30cb774
> config: s390-buildonly-randconfig-r006-20221009
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/69f65149d2e87de076edbb2b4dd9532f8f57dd8b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
>         git checkout 69f65149d2e87de076edbb2b4dd9532f8f57dd8b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: mm/ioremap.o: in function `ioremap_prot':
> >> ioremap.c:(.text+0x9a): undefined reference to `arch_ioremap'
>    s390-linux-ld: mm/ioremap.o: in function `iounmap':
> >> ioremap.c:(.text+0x234): undefined reference to `arch_iounmap'
>    s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
>    hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
>    s390-linux-ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'

The above compiling errors are caused by unsetting CONFIG_PCI in
s390-buildonly-randconfig-r006-20221009 attached. I keep the items for
reference. Because s390 puts io mem functions in arch/s390/pci/pci.c.
While building arch/s390/pci/pci.c in needs CONFIG_PCI enabled. I don't
think disabling CONFIG_PCI in s390x makes sense in reality, except of
the randconfig testing.

Hi Niklas, lkp

What do you think about this? We can just ignore this building error
with randconfig in lkp?

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/s390 6.0.0 Kernel Configuration
> #
...... 
> # end of General setup
> 
> CONFIG_MMU=y
......
> # Device Drivers
> #
> CONFIG_HAVE_PCI=y
> # CONFIG_PCI is not set
......

