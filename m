Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79199680E66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3NDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjA3NDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:03:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D1267EEF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:03:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2F01758;
        Mon, 30 Jan 2023 05:04:10 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6402C3F885;
        Mon, 30 Jan 2023 05:03:27 -0800 (PST)
Message-ID: <0ee204fa-091d-43d9-9c2c-0c64cf0c1fdd@arm.com>
Date:   Mon, 30 Jan 2023 13:03:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
Content-Language: en-GB
To:     "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-28 08:32, GuoRui.Yu wrote:
> This patch series adds a new swiotlb implementation, cc-swiotlb, for
> Confidential VMs (such as TDX and SEV-SNP). The new cc-swiotlb allocates
> the DMA TLB buffer dynamically in runtime instead of allocating at boot
> with a fixed size. Furthermore, future optimization and security
> enhancement could be applied on cc-swiotlb without "infecting" the
> legacy swiotlb.
> 
> Background
> ==========
> Under COnfidential COmputing (CoCo) scenarios, the VMM cannot access
> guest memory directly but requires the guest to explicitly mark the
> memory as shared (decrypted). To make the streaming DMA mappings work,
> the current implementation relays on legacy SWIOTLB to bounce the DMA
> buffer between private (encrypted) and shared (decrypted) memory.
> 
> However, the legacy swiotlb is designed for compatibility rather than
> efficiency and CoCo purpose, which will inevitably introduce some
> unnecessary restrictions.
> 
> 1. Fixed immutable swiotlb size cannot accommodate to requirements of
> multiple devices. And 1GiB (current maximum size) of swiotlb in our
> testbed cannot afford multiple disks reads/writes simultaneously.

That's not a very logical argument - if a particular use-case needs a 
particular total amount of SWIOTLB capacity, then that's how much it 
needs. Whether that capacity is allocated up-front or allocated 
gradually over time doesn't affect that. The obvious solution to this 
issue as presented is "make the maximum size bigger", not "add a whole 
other SWIOTLB implementation".

> 2. Fixed immutable IO_TLB_SIZE (2KiB) cannot satisfy various kinds of
> devices. At the moment, the minimal size of a swiotlb buffer is 2KiB,
> which will waste memory on small network packets (under 256 bytes) and
> decrease efficiency on a large block (up to 256KiB) size reads/writes of
> disks. And it is hard to have a trade-off on legacy swiotlb to rule them
> all.

That's clearly a general argument, so why should any improvement be 
arbitrarily restricted to Confidential Compute scenarios?

> 3. The legacy swiotlb cannot efficiently support larger swiotlb buffers.
> In the worst case, the current implementation requires a full scan of
> the entire swiotlb buffer, which can cause severe performance hits.

Isn't that the main reason we just recently introduced the multiple area 
stuff?

Robin.

> Changes in this patch set
> =========================
> Instead of keeping "infecting" the legacy swiotlb code with CoCo logic,
> this patch tries to introduce a new cc-swiotlb for Confidential VMs.
> 
> Confidential VMs usually have reasonable modern devices (virtio devices,
> NVME, etc.), which can access memory above 4GiB, cc-swiotlb could
> allocate TLB buffers at any position dynamically. Since
> set_memory_{decrypted,encrypted} is time-consuming and cannot be used in
> interrupt context, a new kernel thread "kccd" has been added to populate
> new TLB buffers on-demand, which solved the problem 1.
> 
> In addition, the cc-swiotlb manages TLB buffers by different sizes
> (512B, 2KiB, 4KiB, 16KiB, and 512KiB). The above values come from the
> following observations (boot with 8core, 32 GiB, 1 nvme disk, and 1
> virtio-net):
> - Allocations of 512 bytes and below account for 3.5% of the total DMA
>    cache allocations;
> - Allocations of 2 KiB and below account for 57.7%;
> - Allocations of 4 KiB and below account for 91.3%;
> - Allocations of 16 KiB and below account for 96.0%;
> - Allocations of 512 KiB and below accounted for 100%;
> - At the end of booting, cc-swiotlb uses 288 MiB in total.
> 
> For comparison, legacy swiotlb reserves memory at 6%, which requires
> min(1GiB, 32GiB * 0.06) = 1GiB, and will hang when operating multiple
> disks simultaneously due to no memory for the swiotlb buffer.
> 
> These patches were tested with fio (using different iodepth and block
> size) on a platform with 96 cores, 384 GiB, and 20 NVME disks, and no IO
> hang or error was observed.
> 
> For simplicity, the current RFC version cannot switch between legacy
> implementation with cmdline but through compile options. I am open to
> discussing how to integrate the cc-swiotlb into the legacy one.
> 
> Patch Organization
> ==================
> - swiotlb: Split common code from swiotlb.{c,h}
> - swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
> - swiotlb: Add tracepoint swiotlb_unbounced
> - cc-swiotlb: Allow set swiotlb watermark from cmdline
> 
> Thanks for your time!
> 
> Have a nice day,
> Guorui
> 
> 
