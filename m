Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB27241AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjFFMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:08:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9510D0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:08:07 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb8J46FtwzqTTr;
        Tue,  6 Jun 2023 20:03:16 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 20:08:03 +0800
Subject: Re: [PATCH v6 2/2] Documentation: add kdump.rst to present
 crashkernel reservation on arm64
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <kexec@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230515060259.830662-1-bhe@redhat.com>
 <20230515060259.830662-3-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1f61248c-c137-708f-5e3f-d035742aed6f@huawei.com>
Date:   Tue, 6 Jun 2023 20:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230515060259.830662-3-bhe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/15 14:02, Baoquan He wrote:
> People complained the crashkernel reservation code flow is hard to
> follow, so add this document to explain the background, concepts and
> implementation of crashkernel reservation on arm64. Hope this can help
> people to understand it more easily.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/arm64/kdump.rst
> 
> diff --git a/Documentation/arm64/kdump.rst b/Documentation/arm64/kdump.rst
> new file mode 100644
> index 000000000000..78b22017c490
> --- /dev/null
> +++ b/Documentation/arm64/kdump.rst
> @@ -0,0 +1,103 @@
> +=======================================
> +crashkernel memory reservation on arm64
> +=======================================
> +
> +Author: Baoquan He <bhe@redhat.com>
> +
> +Kdump mechanism is utilized to capture corrupted kernel's vmcore so
> +that people can analyze it to get the root cause of corruption. In
> +order to do that, a preliminarily reserved memory is needed to load
> +in kdump kernel, and switch to kdump kernel to boot up and run if
> +corruption happened.
> +
> +That reserved memory for kdump is adapted to be able to minimally
> +accommodate kdump kernel to boot and run, and user space programs
> +running to do the vmcore collecting.
> +
> +Kernel parameter
> +================
> +Through kernel parameter like below, memory can be reserved
> +accordingly during early stage of 1st kernel's bootup so that
> +continuous large chunk of memomy can be found and reserved. Meanwhile,
> +the need of low memory need be considered if crashkernel is reserved
> +in high memory area.
> +
> +- crashkernel=size@offset
> +- crashkernel=size
> +- crashkernel=size,high crashkernel=size,low
> +
> +Low memory and high memory
> +===============
> +What is low memory and high memory? In kdump reservation, low memory
> +means the memory area under a specific limitation, and it's usually
> +decided by the lowest addressing bits of PCI devices which kdump kernel
> +need rely on to boot up and collect vmcore successfully. Those devices
> +not related to vmcore dumping can be ignored, e.g on x86, those i2c may
> +only be able to access 24bits addressing area, but kdump kernel still
> +take 4G as the limitation because all known devices that kdump kernel
> +cares about have 32bits addressing ability. On arm64, the low memory
> +upper boundary is not fixed, it's 1G on RPi4 platform, while 4G on normal
> +arm64 system. On the special system with CONFIG_ZONE_DMA|DMA32 disabled,
> +the whole system RAM is low memory. Except of low memory, all the rest
> +of system RAM is high memory which kernel and user space programs can
> +require to allocate and use.
> +
> +Implementation
> +==============
> +1)crashkernel=size@offset
> +-------------------------
> +crashkernel memory must be reserved at the user specified region, otherwise
> +fail if already occupied.
> +
> +
> +2) crashkernel=size
> +-------------------
> +crashkernel memory region will be reserved in any available position
> +according to searching order.
> +
> +Firstly, it searches the low memory area for an available region with specified
> +size.
> +
> +Secondly, if searching low memory failed, fallback to search the high memory
> +area with the specified size. Meanwhile, if the reservation in high memory
> +succeeds, a default reservation in low memory will be done, the current default
> +value is 128M which is satisfying the low memory needs, e.g pci device driver
> +initialization.
> +
> +If both the above searching failed, the reservation will fail finally.
> +
> +Note: crashkernel=size is recommended option among crashkernel kernel
> +parameters. With it, user doesn't need to know much about system memory
> +information, just need to specify whatever memory kdump kernel needs to
> +make vmcore dumping succeed.
> +
> +3) crashkernel=size,high crashkernel=size,low
> +--------------------------------------------
> +crashkernel=size,high is an important supplement to crashkernel=size. It
> +allows user to precisely specify how much memory need be allocated from
> +high memory, and how much memory is needed from low memory. On system
> +with large memory, low memory is small and precious since some kernel
> +feature and many devices can only request memory from the area, while
> +requiring a large chunk of continuous memory from high memory area doesn't
> +matter much and can satisfy most of kernel and almost all user space
> +programs' requirement. In such case, only a small part of necessary memory
> +from low memory area can satisfy needs. With it, the 1st kernel's normal
> +running won't be impacted because of limited low memory resource.
> +
> +To reserve memory for crashkernel=size,high, firstly, searching is tried in
> +high memory region. If reservation succeeds, low memory reservaton will be
> +done subsequently.
> +
> +Secondly, if reservation in high memory failed, fallback to search the
> +low memory with the specified size in crsahkernel=,high. If succeeds,
> +everything is fine since no low memory is needed.
> +
> +Notes:
> +- If crashkernel=,low is not specified, the default low memory reservation
> +  will be done automically.
> +
> +- if crashkernel=0,low is specified, means that low memory reservation is
> +  ommited intentionally.

ommited --> omitted

> +
> +3)

This line seems to be deleted.

> +
> 

-- 
Regards,
  Zhen Lei
