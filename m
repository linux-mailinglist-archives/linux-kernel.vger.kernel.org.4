Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5075F0A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiI3LaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiI3L3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:29:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E54481F4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:20:10 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220930112007euoutp026b5a1135e0fe2b3fed36148ed64dc028~Zn2hVCmkg0263402634euoutp025
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:20:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220930112007euoutp026b5a1135e0fe2b3fed36148ed64dc028~Zn2hVCmkg0263402634euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664536807;
        bh=vCrzo8P9keMm3G0QBwRfrNhW7bhBa+AlT/JTjBLV8bc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=eTZgaFLXRCj3wgmzYyy15zTWkz0rDMJ0GkKAhrT5MO+ivcICqSa22ySiwupF+fgqa
         BelV5ggx5nof5XykairrGiuAFKYO1g2dmu/OMXkgTEIMGYCyKWFaIaJ++9jOyDoKKT
         7KRje1GAixA9j/DWZfzIReUBLFlteWvYgtOSaBAY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220930112007eucas1p29eb01e06444090457ecae5c2e810ad76~Zn2hAsJlZ0927009270eucas1p2A;
        Fri, 30 Sep 2022 11:20:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.AD.07817.7E0D6336; Fri, 30
        Sep 2022 12:20:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220930112006eucas1p1fbf679878740649d29e3ba0e86db6893~Zn2ghO9Hs0289202892eucas1p1Z;
        Fri, 30 Sep 2022 11:20:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220930112006eusmtrp1518050882164f7f5d084cce49c795b15~Zn2ggYgfe2486424864eusmtrp1G;
        Fri, 30 Sep 2022 11:20:06 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-b1-6336d0e78ae4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.05.07473.6E0D6336; Fri, 30
        Sep 2022 12:20:06 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220930112006eusmtip25d825ce23e88937bd0d9f1a2c9821c30~Zn2f0Qdvt2749327493eusmtip2G;
        Fri, 30 Sep 2022 11:20:06 +0000 (GMT)
Message-ID: <a4be6670-832a-ffac-4d68-e4a079eb2eed@samsung.com>
Date:   Fri, 30 Sep 2022 13:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/4] spi: Fix cache corruption due to DMA/PIO overlap
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        andi@etezian.org, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kernel@axis.com, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220927112117.77599-3-vincent.whitchurch@axis.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87rPL5glG/Tu5bd4MG8bm8XiH8+Z
        LKY+fMJmsXL1USaLBfutLT61qFrsfb2V3WLT42usFpd3zWGzmHF+H5NF48eb7BYHPzxhtTi/
        zd+B12PNvDWMHtfXBXhcX/KJ2WPTqk42jzvX9rB5bF5S7zH5xnJGj903G9g8+rasYvT4vEku
        gCuKyyYlNSezLLVI3y6BK+Nf/162gltSFZP7JjM2MO4U62Lk4JAQMJG49Sq+i5GLQ0hgBaPE
        6pPHWSGcL4wSl1bvgnI+M0ocvnUZyOEE6+jduYcNIrGcUWLzzXlQVR8ZJY5u7mYBqeIVsJNo
        f/WJEcRmEVCV6Jv7mhUiLihxcuYTsBpRgWSJn10H2EBsYQEfiSuXpzOD2MwC4hK3nsxnAhkq
        InCYUWLNvzVQid+MEksWSILYbAKGEl1vu8CaOQUcJfpXb2KCqJGXaN46mxmkWUJgOafE477z
        LBB3u0jsOHKXGcIWlnh1fAs7hC0jcXpyDwtEQzujxILf95kgnAmMEg3PbzFCVFlL3Dn3iw0U
        ZswCmhLrd+lDhB0lpr16wQgJSj6JG28FIY7gk5i0DeQbkDCvREebEES1msSs4+vg1h68cIl5
        AqPSLKRwmYXk/1lI3pmFsHcBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwFR3+t/x
        LzsYl7/6qHeIkYmD8RCjBAezkgiveIFpshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFethlayUIC
        6YklqdmpqQWpRTBZJg5OqQamuV/SzrQ0ZTPcc+/nYtzFfXxFKeu16/EuRXP8360/9Kwy79zy
        gkMvzGY4PHbpfTChlEVoe9TxpYx/Nv1ZFXlJKua0QofJjImX58j/89XOy5h0wuaNypZvfdkO
        wf5//ddqfVqaaF8cNe22ypJ/KwS2P/YVNFBxWHLo9MOdamtPdEgtcLcs3X/dL+3ZzKq94ubm
        /lHG995tPzKx8j7rTUmv5dtWaM5le5DS+677Ru/06zmffliEVd88ucXCq/pQF9dC9qg8GdPv
        83cGPWfQeii8q/9jmfnX9xyO2ZkFhesd1/3MuePisKzwoxSvl/gRsVNNi/IuyURlrfW+yx+T
        seLl9dC4nwusHEqZRbbPXNmUpMRSnJFoqMVcVJwIAN6XyDzkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rPLpglG/zar23xYN42NovFP54z
        WUx9+ITNYuXqo0wWC/ZbW3xqUbXY+3oru8Wmx9dYLS7vmsNmMeP8PiaLxo832S0OfnjCanF+
        m78Dr8eaeWsYPa6vC/C4vuQTs8emVZ1sHneu7WHz2Lyk3mPyjeWMHrtvNrB59G1ZxejxeZNc
        AFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsa/
        /r1sBbekKib3TWZsYNwp1sXIySEhYCLRu3MPWxcjF4eQwFJGidMdU1kgEjISJ6c1sELYwhJ/
        rnVBFb1nlDi05B0TSIJXwE6i/dUnRhCbRUBVom/ua1aIuKDEyZlPwAaJCiRLvPwzkR3EFhbw
        kbhyeToziM0sIC5x68l8sDkiAocZJfadLgVZwCzwm1HiwcNpUNtOM0rcOnCfDaSKTcBQoutt
        F5jNKeAo0b96ExPEJDOJrq1djBC2vETz1tnMExiFZiE5ZBaShbOQtMxC0rKAkWUVo0hqaXFu
        em6xoV5xYm5xaV66XnJ+7iZGYHRvO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIrXmCaLMSbklhZ
        lVqUH19UmpNafIjRFBgaE5mlRJPzgeklryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
        NbUgtQimj4mDU6qBScrymPP2Vb7mK24tOqPl8W/NfzZt5cMnjiyO28DZfH/93vyFLT0Z9//x
        C9XemWf8+VrqfKbE1zXBAbvc2e/pss/Z/Nl572+z2Dfrbzxrkd77rNR5+nP7vQ7v15zeZKkq
        IHxp7Y4L75iZE48dvvOBc9ee3A/3Jhsmsm9Q0T+w/7jBI9XLPAzFYXYdYTO/6nsZs7Wv/vR5
        x+Z58Rc/iqU91PWe4XtDbovSXotAU/7ER/e0+QJ42b/3zXdUYW76lqrcFPSk7/SUdZsfOqzg
        PP1IodL6jLgDf/y2XqbGRUGfGCY0OlRpSHjnMFf9kG4N1pIL2qlb0Fv8xGtjjkD6x///7EKO
        cUw+WFCuct8jLrrHVYmlOCPRUIu5qDgRAOh2uel3AwAA
X-CMS-MailID: 20220930112006eucas1p1fbf679878740649d29e3ba0e86db6893
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220927112359eucas1p15bee651dfbe727701ad732f6ce9a7f13
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220927112359eucas1p15bee651dfbe727701ad732f6ce9a7f13
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
        <CGME20220927112359eucas1p15bee651dfbe727701ad732f6ce9a7f13@eucas1p1.samsung.com>
        <20220927112117.77599-3-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

CCed: Christoph and Robin, as the issue is partially dma-mapping related.

On 27.09.2022 13:21, Vincent Whitchurch wrote:
> The SPI core DMA mapping support performs cache management once for the
> entire message and not between transfers, and this leads to cache
> corruption if a message has two or more RX transfers with both
> transfers targeting the same cache line, and the controller driver
> decides to handle one using DMA and the other using PIO (for example,
> because one is much larger than the other).
>
> Fix it by syncing before/after the actual transfers.  This also means
> that we can skip the sync during the map/unmap of the message.
>
> Fixes: 99adef310f68 ("spi: Provide core support for DMA mapping transfers")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

This patch landed in linux next-20220929 as commit 0c17ba73c08f ("spi: 
Fix cache corruption due to DMA/PIO overlap"). Unfortunately it causes 
kernel oops on one of my test systems:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in: cmac bnep btsdio hci_uart btbcm s5p_mfc btintel 
brcmfmac bluetooth videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 
videobuf2_common videodev cfg80211 mc ecdh_generic ecc brcmutil
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 
6.0.0-rc7-next-20220929-dirty #12903
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events ax88796c_work
PC is at dma_direct_sync_sg_for_device+0x24/0xb8
LR is at spi_transfer_one_message+0x4c4/0xabc
pc : [<c01cbcf0>]    lr : [<c0739fcc>]    psr: 20000013
...
Process kworker/0:1 (pid: 12, stack limit = 0xca429928)
Stack: (0xe0071d38 to 0xe0072000)
...
  dma_direct_sync_sg_for_device from spi_transfer_one_message+0x4c4/0xabc
  spi_transfer_one_message from __spi_pump_transfer_message+0x300/0x770
  __spi_pump_transfer_message from __spi_sync+0x304/0x3f4
  __spi_sync from spi_sync+0x28/0x40
  spi_sync from axspi_read_rxq+0x98/0xc8
  axspi_read_rxq from ax88796c_work+0x7a8/0xf6c
  ax88796c_work from process_one_work+0x288/0x774
  process_one_work from worker_thread+0x44/0x504
  worker_thread from kthread+0xf0/0x124
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xe0071fb0 to 0xe0071ff8)
...
---[ end trace 0000000000000000 ]---

This happens because sg_free_table() doesn't clear table->orig_nents nor 
table->nents. If the given spi xfer object is reused without dma-mapped 
buffer, then a NULL pointer de-reference happens at table->sgl 
spi_dma_sync_for_device()/spi_dma_sync_for_cpu(). A possible fix would 
be to zero table->orig_nents in spi_unmap_buf_attrs(). I will send a 
patch for this soon.

However, I think that clearing table->orig_nents and table->nents should 
be added to __sg_free_table() in lib/scatterlist.c to avoid this kind of 
issue in the future. This however will be a significant change that 
might break code somewhere, if it relies on the nents/orig_nents value 
after calling sg_free_table(). Christoph, Robin - what is your opinion?


>   drivers/spi/spi.c | 109 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 88 insertions(+), 21 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

