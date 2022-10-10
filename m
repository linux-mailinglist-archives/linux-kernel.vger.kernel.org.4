Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4F5F9E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiJJLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiJJLyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:54:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B5719BA;
        Mon, 10 Oct 2022 04:54:08 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A9tZmG028344;
        Mon, 10 Oct 2022 11:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JgCMB2lYeCdYfsBToh4LyTNnyXf4ujwkdyn0W/9PW+k=;
 b=P/cfbKYrI7BKko7fvNcEKrolJ+1vIKgqfFzNuDNsuP426XGABwziG8Rtf53zxnj4ZfK4
 Jkp72VUfBJ3KCC6KABrcErx602Kb4oOqfCsLE/hVe4KMvlxYeHDRBeiwshyKwUyK6bu8
 g7zYMdUC5ZFbfzGa/urCUdOgE8imus55vNS0P1u9x0ivl70P8jQGiqj0lfNUojx2adTp
 Fpgy9Zu79XlSE370LHcKD8VaWwlTIMAwwEXg39l6uTxxrTYT4BsmTBgQ46bwrg7kk47K
 IYJTzJDXz6jf+BzZUYCkD0RkhLOXCYoPTJPCLa3kklJJjVeg+/9zuxG2jchdF+Ltp02k yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3jhbau7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:53:42 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29AB9boi001301;
        Mon, 10 Oct 2022 11:53:41 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3jhbau68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:53:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29ABpmxs016312;
        Mon, 10 Oct 2022 11:53:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3k30u920m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:53:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29ABmt6V24314170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 11:48:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0308252054;
        Mon, 10 Oct 2022 11:53:36 +0000 (GMT)
Received: from sig-9-145-29-39.uk.ibm.com (unknown [9.145.29.39])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2628A5204F;
        Mon, 10 Oct 2022 11:53:35 +0000 (GMT)
Message-ID: <2fdf9cb63c0e738082fe9874a5ed7f508d55a36f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, David.Laight@aculab.com,
        shorne@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Mon, 10 Oct 2022 13:53:34 +0200
In-Reply-To: <Y0P2HEa4q5/XDj0Z@MiWiFi-R3L-srv>
References: <20221009103114.149036-10-bhe@redhat.com>
         <202210092100.mfRPyPqR-lkp@intel.com> <Y0P2HEa4q5/XDj0Z@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BUmxA8Bs8n3O_B7IP_G079Bvd2dFPzbl
X-Proofpoint-ORIG-GUID: 78bfFtJbsdkTzcQYLkvlsIcam83FjpqU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_06,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 18:38 +0800, Baoquan He wrote:
> On 10/09/22 at 09:54pm, kernel test robot wrote:
> > Hi Baoquan,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on next-20221007]
> > [cannot apply to akpm-mm/mm-everything openrisc/for-next deller-parisc/for-next s390/features v6.0]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a6afa4199d3d038fbfdff5511f7523b0e30cb774
> > config: s390-buildonly-randconfig-r006-20221009
> > compiler: s390-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/69f65149d2e87de076edbb2b4dd9532f8f57dd8b
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20221009-183524
> >         git checkout 69f65149d2e87de076edbb2b4dd9532f8f57dd8b
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    s390-linux-ld: mm/ioremap.o: in function `ioremap_prot':
> > > > ioremap.c:(.text+0x9a): undefined reference to `arch_ioremap'
> >    s390-linux-ld: mm/ioremap.o: in function `iounmap':
> > > > ioremap.c:(.text+0x234): undefined reference to `arch_iounmap'
> >    s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> >    hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> >    s390-linux-ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> 
> The above compiling errors are caused by unsetting CONFIG_PCI in
> s390-buildonly-randconfig-r006-20221009 attached. I keep the items for
> reference. Because s390 puts io mem functions in arch/s390/pci/pci.c.
> While building arch/s390/pci/pci.c in needs CONFIG_PCI enabled. I don't
> think disabling CONFIG_PCI in s390x makes sense in reality, except of
> the randconfig testing.
> 
> Hi Niklas, lkp
> 
> What do you think about this? We can just ignore this building error
> with randconfig in lkp?

Hmm, that's a bummer. As s390 systems (aka mainframes) do have classic
channel devices for networking and permanent storage that are currently
even more common than PCI devices you can definitely have a fully
functional system with CONFIG_PCI=n. Also the drivers for these channel
devices do not use ioremap() which is only used for PCI, so in theory
it should be fine not to have ioremap() for CONFIG_PCI=n.

I think the reason for this concrete failure to compile is a missing
HAS_IOMEM dependency for CONFIG_QCOM_HIDMA. I'm not sure how many other
cases there are though as I think we might be the only ones where
HAS_IOMEM is only sometimes available (it depends on CONFIG_PCI for
us). Ideally I think we would have the driver dependencies. I'm a bit
confused though since in the current code it looks to me like
ioremap_prot() will be declared but not defined for CONFIG_PCI=n too as
far as I can tell at least.

> 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/s390 6.0.0 Kernel Configuration
> > #
> ...... 
> > # end of General setup
> > 
> > CONFIG_MMU=y
> ......
> > # Device Drivers
> > #
> > CONFIG_HAVE_PCI=y
> > # CONFIG_PCI is not set
> ......
> 


