Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46D6FC28C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjEIJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjEIJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:19:29 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651019A3;
        Tue,  9 May 2023 02:19:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QFsl72m3gz9xFrw;
        Tue,  9 May 2023 17:08:19 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.212.219])
        by APP2 (Coremail) with SMTP id GxC2BwDHdz7lD1pksN2OAg--.5S2;
        Tue, 09 May 2023 10:18:45 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v2 RESEND 0/7] Allow dynamic allocation of software IO TLB bounce buffers
Date:   Tue,  9 May 2023 11:18:12 +0200
Message-Id: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHdz7lD1pksN2OAg--.5S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw18WF1rGrW5WFyrWF1xKrg_yoW5GrWfpF
        WYk34jvrn8tryxu3yxCr4xWa4rGan5Zay3Ga9Yvrn5ZFW5Gr9FvwnrtrW5J3s8Cr4xXF4F
        qr1qvr15CFyfuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAK
        zI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWr
        XVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU86BT5UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The goal of my work is to provide more flexibility in the sizing of
SWIOTLB.

The software IO TLB was designed with these assumptions:

1. It would not be used much, especially on 64-bit systems.
2. A small fixed memory area (64 MiB by default) is sufficient to
   handle the few cases which require a bounce buffer.
3. 64 MiB is little enough that it has no impact on the rest of the
   system.

First, if SEV is active, all DMA must be done through shared
unencrypted pages, and SWIOTLB is used to make this happen without
changing device drivers. The software IO TLB size is increased to
6% of total memory in sev_setup_arch(), but that is more of an
approximation. The actual requirements may vary depending on the
amount of I/O and which drivers are used. These factors may not be
know at boot time, i.e. when SWIOTLB is allocated.

Second, other colleagues have noticed that they can reliably get
rid of occasional OOM kills on an Arm embedded device by reducing
the SWIOTLB size. This can be achieved with a kernel parameter, but
determining the right value puts additional burden on pre-release
testing, which could be avoided if SWIOTLB is allocated small and
grows only when necessary.

Changes from RFC:
- Track dynamic buffers per device instead of per swiotlb
- Use a linked list instead of a maple tree
- Move initialization of swiotlb fields of struct device to a
  helper function
- Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
- Introduce per-device flag if dynamic buffers are in use
- Add one more user of DMA_ATTR_MAY_SLEEP
- Add kernel-doc comments for new (and some old) code
- Properly escape '*' in dma-attributes.rst

Petr Tesarik (7):
  swiotlb: Use a helper to initialize swiotlb fields in struct device
  swiotlb: Move code around in preparation for dynamic bounce buffers
  dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
  swiotlb: Dynamically allocated bounce buffers
  swiotlb: Add a boot option to enable dynamic bounce buffers
  drm: Use DMA_ATTR_MAY_SLEEP from process context
  swiotlb: per-device flag if there are dynamically allocated buffers

 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/dma-attributes.rst     |  10 +
 drivers/base/core.c                           |   4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
 drivers/gpu/drm/drm_prime.c                   |   2 +-
 include/linux/device.h                        |  12 +
 include/linux/dma-mapping.h                   |   6 +
 include/linux/swiotlb.h                       |  54 ++-
 kernel/dma/swiotlb.c                          | 382 ++++++++++++++++--
 9 files changed, 443 insertions(+), 35 deletions(-)

-- 
2.25.1

