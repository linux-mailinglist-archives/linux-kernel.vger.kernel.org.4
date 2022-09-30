Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B885F0B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiI3MLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiI3MLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:11:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08CFAB5159;
        Fri, 30 Sep 2022 05:10:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A8FA1474;
        Fri, 30 Sep 2022 05:10:57 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9328B3F73B;
        Fri, 30 Sep 2022 05:10:48 -0700 (PDT)
Message-ID: <461a5187-fc7a-b7f6-84da-0e947f764a0a@arm.com>
Date:   Fri, 30 Sep 2022 13:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/4] spi: Fix cache corruption due to DMA/PIO overlap
Content-Language: en-GB
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        andi@etezian.org, Christoph Hellwig <hch@lst.de>
Cc:     kernel@axis.com, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <CGME20220927112359eucas1p15bee651dfbe727701ad732f6ce9a7f13@eucas1p1.samsung.com>
 <20220927112117.77599-3-vincent.whitchurch@axis.com>
 <a4be6670-832a-ffac-4d68-e4a079eb2eed@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a4be6670-832a-ffac-4d68-e4a079eb2eed@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 12:20, Marek Szyprowski wrote:
> Hi,
> 
> CCed: Christoph and Robin, as the issue is partially dma-mapping related.
> 
> On 27.09.2022 13:21, Vincent Whitchurch wrote:
>> The SPI core DMA mapping support performs cache management once for the
>> entire message and not between transfers, and this leads to cache
>> corruption if a message has two or more RX transfers with both
>> transfers targeting the same cache line, and the controller driver
>> decides to handle one using DMA and the other using PIO (for example,
>> because one is much larger than the other).
>>
>> Fix it by syncing before/after the actual transfers.  This also means
>> that we can skip the sync during the map/unmap of the message.
>>
>> Fixes: 99adef310f68 ("spi: Provide core support for DMA mapping transfers")
>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>> ---
> 
> This patch landed in linux next-20220929 as commit 0c17ba73c08f ("spi:
> Fix cache corruption due to DMA/PIO overlap"). Unfortunately it causes
> kernel oops on one of my test systems:
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> [0000000c] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in: cmac bnep btsdio hci_uart btbcm s5p_mfc btintel
> brcmfmac bluetooth videobuf2_dma_contig videobuf2_memops videobuf2_v4l2
> videobuf2_common videodev cfg80211 mc ecdh_generic ecc brcmutil
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted
> 6.0.0-rc7-next-20220929-dirty #12903
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events ax88796c_work
> PC is at dma_direct_sync_sg_for_device+0x24/0xb8
> LR is at spi_transfer_one_message+0x4c4/0xabc
> pc : [<c01cbcf0>]    lr : [<c0739fcc>]    psr: 20000013
> ...
> Process kworker/0:1 (pid: 12, stack limit = 0xca429928)
> Stack: (0xe0071d38 to 0xe0072000)
> ...
>    dma_direct_sync_sg_for_device from spi_transfer_one_message+0x4c4/0xabc
>    spi_transfer_one_message from __spi_pump_transfer_message+0x300/0x770
>    __spi_pump_transfer_message from __spi_sync+0x304/0x3f4
>    __spi_sync from spi_sync+0x28/0x40
>    spi_sync from axspi_read_rxq+0x98/0xc8
>    axspi_read_rxq from ax88796c_work+0x7a8/0xf6c
>    ax88796c_work from process_one_work+0x288/0x774
>    process_one_work from worker_thread+0x44/0x504
>    worker_thread from kthread+0xf0/0x124
>    kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xe0071fb0 to 0xe0071ff8)
> ...
> ---[ end trace 0000000000000000 ]---
> 
> This happens because sg_free_table() doesn't clear table->orig_nents nor
> table->nents. If the given spi xfer object is reused without dma-mapped
> buffer, then a NULL pointer de-reference happens at table->sgl
> spi_dma_sync_for_device()/spi_dma_sync_for_cpu(). A possible fix would
> be to zero table->orig_nents in spi_unmap_buf_attrs(). I will send a
> patch for this soon.
> 
> However, I think that clearing table->orig_nents and table->nents should
> be added to __sg_free_table() in lib/scatterlist.c to avoid this kind of
> issue in the future. This however will be a significant change that
> might break code somewhere, if it relies on the nents/orig_nents value
> after calling sg_free_table(). Christoph, Robin - what is your opinion?

Yes, that makes sense to me: the table->nents etc. fields logically 
describe the list that table->sgl points to, so when it sets that to 
NULL it seems right to also update the corresponding fields accordingly. 
I don't see much good reason for code to poking into an sg_table after 
it's been freed, other that to reinitialise it with sg_alloc_table() 
which would overwrite those fields anyway, so I can't imagine it's a 
particularly risky change.

That said, maybe this is something that's better to catch than to paper 
over? Arguably the real bug here is that spi_unmap_buf() and the new 
sync functions should use the same "{tx,rx}_buf != NULL" condition that 
spi_map_buf() used for the DMA mapping decision in the first place.

Thanks,
Robin.

> 
> 
>>    drivers/spi/spi.c | 109 +++++++++++++++++++++++++++++++++++++---------
>>    1 file changed, 88 insertions(+), 21 deletions(-)
>>
>> ...
> 
> Best regards
