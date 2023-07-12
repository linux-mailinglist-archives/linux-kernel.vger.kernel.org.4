Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9B7501B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGLIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjGLIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:36:38 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B12721;
        Wed, 12 Jul 2023 01:34:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VnCGuy7_1689150844;
Received: from 30.221.150.170(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VnCGuy7_1689150844)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 16:34:06 +0800
Message-ID: <e77232b9-a290-545b-cb02-ae1fbc2cd5cb@linux.alibaba.com>
Date:   Wed, 12 Jul 2023 16:34:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
To:     Gavin Li <gavinl@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, jiri@nvidia.com,
        dtatulea@nvidia.com
References: <20230710092005.5062-1-gavinl@nvidia.com>
From:   Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/10 下午5:20, Gavin Li 写道:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
>
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.


We definitely did the same thing, and I'm waiting for our hardware 
implementation to be ready to
push the ethtool + netdim implementation.

Since this commit log is completely copied from the implementation of 
the virtio spec, consulting
each other's scheduling plan in advance can be friendly to avoid us 
doing the same thing and consuming an extra effort.

Thanks.

>
> Example command:
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> Would set max_packets=10 to VQ 1.
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> Would set max_packets=10 to VQ 0.
> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>   Queue: 0
>   Adaptive RX: off  TX: off
>   stats-block-usecs: 0
>   sample-interval: 0
>   pkt-rate-low: 0
>   pkt-rate-high: 0
>
>   rx-usecs: 222
>   rx-frames: 0
>   rx-usecs-irq: 0
>   rx-frames-irq: 256
>
>   tx-usecs: 222
>   tx-frames: 0
>   tx-usecs-irq: 0
>   tx-frames-irq: 256
>
>   rx-usecs-low: 0
>   rx-frame-low: 0
>   tx-usecs-low: 0
>   tx-frame-low: 0
>
>   rx-usecs-high: 0
>   rx-frame-high: 0
>   tx-usecs-high: 0
>   tx-frame-high: 0
>
> In this patch series:
> Patch-1: Extract interrupt coalescing settings to a structure.
> Patch-2: Extract get/set interrupt coalesce to a function.
> Patch-3: Support per queue interrupt coalesce command.
> Patch-4: Enable per queue interrupt coalesce feature.
>
> Gavin Li (4):
>    virtio_net: extract interrupt coalescing settings to a structure
>    virtio_net: extract get/set interrupt coalesce to a function
>    virtio_net: support per queue interrupt coalesce command
>    virtio_net: enable per queue interrupt coalesce feature
>
>   drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>   include/uapi/linux/virtio_net.h |  14 +++
>   2 files changed, 154 insertions(+), 29 deletions(-)
>

