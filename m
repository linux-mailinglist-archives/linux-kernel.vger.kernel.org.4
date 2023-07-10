Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E74D16A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGJJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGJJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:51 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A678DE;
        Mon, 10 Jul 2023 02:27:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vn0blpX_1688981263;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vn0blpX_1688981263)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 17:27:44 +0800
Message-ID: <1688981109.6377137-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt coalescing support
Date:   Mon, 10 Jul 2023 17:25:09 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Gavin Li <gavinl@nvidia.com>
Cc:     <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <jiri@nvidia.com>,
        <dtatulea@nvidia.com>, "Heng Qi" <hengqi@linux.alibaba.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 12:20:01 +0300, Gavin Li <gavinl@nvidia.com> wrote:

As far as I know, Heng Qi does that. I'm not sure, it's the same piece.

cc @Heng Qi

Thanks.


> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
>
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
>
> Example command:
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> Would set max_packets=10 to VQ 1.
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> Would set max_packets=10 to VQ 0.
> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>  Queue: 0
>  Adaptive RX: off  TX: off
>  stats-block-usecs: 0
>  sample-interval: 0
>  pkt-rate-low: 0
>  pkt-rate-high: 0
>
>  rx-usecs: 222
>  rx-frames: 0
>  rx-usecs-irq: 0
>  rx-frames-irq: 256
>
>  tx-usecs: 222
>  tx-frames: 0
>  tx-usecs-irq: 0
>  tx-frames-irq: 256
>
>  rx-usecs-low: 0
>  rx-frame-low: 0
>  tx-usecs-low: 0
>  tx-frame-low: 0
>
>  rx-usecs-high: 0
>  rx-frame-high: 0
>  tx-usecs-high: 0
>  tx-frame-high: 0
>
> In this patch series:
> Patch-1: Extract interrupt coalescing settings to a structure.
> Patch-2: Extract get/set interrupt coalesce to a function.
> Patch-3: Support per queue interrupt coalesce command.
> Patch-4: Enable per queue interrupt coalesce feature.
>
> Gavin Li (4):
>   virtio_net: extract interrupt coalescing settings to a structure
>   virtio_net: extract get/set interrupt coalesce to a function
>   virtio_net: support per queue interrupt coalesce command
>   virtio_net: enable per queue interrupt coalesce feature
>
>  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_net.h |  14 +++
>  2 files changed, 154 insertions(+), 29 deletions(-)
>
> --
> 2.39.1
>
