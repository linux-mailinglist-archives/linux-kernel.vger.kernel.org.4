Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167F67F659
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjA1IdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjA1IdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:33:11 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049B32529
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:33:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaH.9z4_1674894785;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaH.9z4_1674894785)
          by smtp.aliyun-inc.com;
          Sat, 28 Jan 2023 16:33:05 +0800
From:   "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     GuoRui.Yu@linux.alibaba.com, robin.murphy@arm.com
Subject: [RFC] swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
Date:   Sat, 28 Jan 2023 16:32:50 +0800
Message-Id: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new swiotlb implementation, cc-swiotlb, for
Confidential VMs (such as TDX and SEV-SNP). The new cc-swiotlb allocates
the DMA TLB buffer dynamically in runtime instead of allocating at boot
with a fixed size. Furthermore, future optimization and security
enhancement could be applied on cc-swiotlb without "infecting" the
legacy swiotlb.

Background
==========
Under COnfidential COmputing (CoCo) scenarios, the VMM cannot access
guest memory directly but requires the guest to explicitly mark the
memory as shared (decrypted). To make the streaming DMA mappings work,
the current implementation relays on legacy SWIOTLB to bounce the DMA
buffer between private (encrypted) and shared (decrypted) memory.

However, the legacy swiotlb is designed for compatibility rather than
efficiency and CoCo purpose, which will inevitably introduce some
unnecessary restrictions.  

1. Fixed immutable swiotlb size cannot accommodate to requirements of
multiple devices. And 1GiB (current maximum size) of swiotlb in our
testbed cannot afford multiple disks reads/writes simultaneously.  

2. Fixed immutable IO_TLB_SIZE (2KiB) cannot satisfy various kinds of
devices. At the moment, the minimal size of a swiotlb buffer is 2KiB,
which will waste memory on small network packets (under 256 bytes) and
decrease efficiency on a large block (up to 256KiB) size reads/writes of
disks. And it is hard to have a trade-off on legacy swiotlb to rule them
all.  

3. The legacy swiotlb cannot efficiently support larger swiotlb buffers.
In the worst case, the current implementation requires a full scan of
the entire swiotlb buffer, which can cause severe performance hits.

Changes in this patch set
=========================
Instead of keeping "infecting" the legacy swiotlb code with CoCo logic,
this patch tries to introduce a new cc-swiotlb for Confidential VMs.

Confidential VMs usually have reasonable modern devices (virtio devices,
NVME, etc.), which can access memory above 4GiB, cc-swiotlb could
allocate TLB buffers at any position dynamically. Since
set_memory_{decrypted,encrypted} is time-consuming and cannot be used in
interrupt context, a new kernel thread "kccd" has been added to populate
new TLB buffers on-demand, which solved the problem 1.

In addition, the cc-swiotlb manages TLB buffers by different sizes
(512B, 2KiB, 4KiB, 16KiB, and 512KiB). The above values come from the
following observations (boot with 8core, 32 GiB, 1 nvme disk, and 1
virtio-net): 
- Allocations of 512 bytes and below account for 3.5% of the total DMA
  cache allocations;
- Allocations of 2 KiB and below account for 57.7%;
- Allocations of 4 KiB and below account for 91.3%;
- Allocations of 16 KiB and below account for 96.0%;
- Allocations of 512 KiB and below accounted for 100%;
- At the end of booting, cc-swiotlb uses 288 MiB in total. 

For comparison, legacy swiotlb reserves memory at 6%, which requires
min(1GiB, 32GiB * 0.06) = 1GiB, and will hang when operating multiple
disks simultaneously due to no memory for the swiotlb buffer.

These patches were tested with fio (using different iodepth and block
size) on a platform with 96 cores, 384 GiB, and 20 NVME disks, and no IO
hang or error was observed.

For simplicity, the current RFC version cannot switch between legacy
implementation with cmdline but through compile options. I am open to
discussing how to integrate the cc-swiotlb into the legacy one.

Patch Organization
==================
- swiotlb: Split common code from swiotlb.{c,h}
- swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
- swiotlb: Add tracepoint swiotlb_unbounced
- cc-swiotlb: Allow set swiotlb watermark from cmdline

Thanks for your time!

Have a nice day,
Guorui


