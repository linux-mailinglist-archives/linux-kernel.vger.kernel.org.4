Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1A6C11E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCTM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCTM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:29:07 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F793F0;
        Mon, 20 Mar 2023 05:29:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PgDMN1tlqz9y4Sk;
        Mon, 20 Mar 2023 20:20:00 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.148.162])
        by APP2 (Coremail) with SMTP id GxC2BwBnOF9kURhkkqGyAQ--.46782S2;
        Mon, 20 Mar 2023 13:28:33 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [RFC v1 0/4] Allow dynamic allocation of software IO TLB bounce buffers
Date:   Mon, 20 Mar 2023 13:28:12 +0100
Message-Id: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnOF9kURhkkqGyAQ--.46782S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw18WF1rGrW5XF4kXryxZrb_yoWrXr1DpF
        Wakw15Zr1DtryxA3yxCw4xXas5Gws5Aay5GFZaqr1UZrW5GFnFvrnrtay5Xa9rGws7Xw1j
        qryYvrn8CFyvvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
        w4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU8gyCJUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The goal of my work is to provide more flexibility in the sizing of
SWIOTLB. This patch series is a request for comments from the wider
community. The code is more of a crude hack than final solution.

I would appreciate suggestions for measuring the performance impact
of changes in SWIOTLB. More info at the end of this cover letter.

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

Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
moved from the rendering GPU (v3d driver), which can access all
memory, to the display output (vc4 driver), which is connected to a
bus with an address limit of 1 GiB and no IOMMU. These buffers can
be large (8 MiB with a FullHD monitor, 34 MiB with a 4K monitor)
and cannot be even handled by current SWIOTLB, because they exceed
the maximum segment size of 256 KiB.  Mapping failures can be
easily reproduced with GNOME remote desktop on a Raspberry Pi 4.

Third, other colleagues have noticed that they can reliably get rid
of occasional OOM kills on an Arm embedded device by reducing the
SWIOTLB size. This can be achieved with a kernel parameter, but
determining the right value puts additional burden on pre-release
testing, which could be avoided if SWIOTLB is allocated small and
grows only when necessary.

I have tried to measure the expected performance degradation so
that I could reduce it and/or compare it to alternative approaches.
I have performed all tests on an otherwise idle Raspberry Pi 4 with
swiotlb=force (which, addmittedly, is a bit artificial). I quickly
ran into trouble.

I ran fio against an ext3 filesystem mounted from a UAS drive. To
my surprise, forcing swiotlb (without my patches) *improved* IOPS
and bandwidth for 4K and 64K blocks by 3 to 7 percent, and made no
visible difference for 1M blocks. I also observed smaller minimum
and average completion latencies, and even smaller maximum
latencies for 4K blocks. However, when I ran the tests again later
to verify some oddities, there was a performance drop. It appears
that I/O, bandwidth and latencies reported by two consecutive fio
runs may differ by as much as 10%, so the results are invalid.

I tried to make a micro-benchmark on dma_map_page_attrs() using the
bcc tool funclatency, but just loading the eBPF program was enough
to change the behaviour of the system wildly.

I wonder if anyone can give me advice on measuring SWIOTLB
performance. I can see that AMD, IBM and Microsoft people have
mentioned performance in their patches, but AFAICS without
explaining how it was measured. Knowing a bit more would be much
appreciated.

Petr Tesarik (4):
  dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
  swiotlb: Move code around in preparation for dynamic bounce buffers
  swiotlb: Allow dynamic allocation of bounce buffers
  swiotlb: Add an option to allow dynamic bounce buffers

 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/dma-attributes.rst     |  10 +
 include/linux/dma-mapping.h                   |   6 +
 include/linux/swiotlb.h                       |  17 +-
 kernel/dma/swiotlb.c                          | 233 +++++++++++++++---
 5 files changed, 241 insertions(+), 31 deletions(-)

-- 
2.25.1

