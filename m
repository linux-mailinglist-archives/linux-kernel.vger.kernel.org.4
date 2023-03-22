Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301F6C4DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCVOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCVOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:34:00 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D923C6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhW1L6pQ5z9xHvc
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:23:50 +0800 (CST)
Received: from [10.48.154.5] (unknown [10.48.154.5])
        by APP1 (Coremail) with SMTP id LxC2BwDnbwuBERtkBea9AQ--.53096S2;
        Wed, 22 Mar 2023 15:32:41 +0100 (CET)
Message-ID: <972d7b71-d126-0a00-2772-030c12f35e0e@huaweicloud.com>
Date:   Wed, 22 Mar 2023 15:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark
 in debugfs
Content-Language: en-US
To:     Michael Kelley <mikelley@microsoft.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDnbwuBERtkBea9AQ--.53096S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF47CF48CF4fCrykJry3CFg_yoWDAFg_ur
        Z2gwsrJw47Ar42qr4xtF4rCrsIg3y7Wry8X34fJ3yftw4DX398Gas7Kry09FyUGayfGrn5
        JwnxtryakFy7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/2023 5:41 PM, Michael Kelley wrote:
> swiotlb currently reports the total number of slabs and the instantaneous
> in-use slabs in debugfs. But with increased usage of swiotlb for all I/O
> in Confidential Computing (coco) VMs, it has become difficult to know
> how much memory to allocate for swiotlb bounce buffers, either via the
> automatic algorithm in the kernel or by specifying a value on the
> kernel boot line. The current automatic algorithm generously allocates
> swiotlb bounce buffer memory, and may be wasting significant memory in
> many use cases.

I like the idea. Tracking and exposing the high watermark is definitely a step in the right direction. I would also appreciate an indicator of fragmentation, but that can be implemented later.

However, you apparently have a scenario where swiotlb is used intensely. Are you able to measure swiotlb performance? If yes, can you suggest a suitable method? I'm asking for my work on making swiotlb more flexible (able to grow and shrink).

Petr T

