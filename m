Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9D7234E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjFFB5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFFB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:57:43 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E9ED;
        Mon,  5 Jun 2023 18:57:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VkU4BR6_1686016655;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VkU4BR6_1686016655)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 09:57:36 +0800
Message-ID: <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with VIRTIO_NET_F_NOTF_COAL support
Date:   Tue, 6 Jun 2023 09:52:54 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     <brett.creeley@amd.com>, <shannon.nelson@amd.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <alvaro.karsz@solid-run.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <xuanzhuo@linux.alibaba.com>, <jasowang@redhat.com>,
        <mst@redhat.com>
References: <20230605210237.60988-1-brett.creeley@amd.com>
In-Reply-To: <20230605210237.60988-1-brett.creeley@amd.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 14:02:36 -0700, Brett Creeley <brett.creeley@amd.com> wrote:
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added support for VIRTIO_NET_F_NOTF_COAL. The get_coalesce
> call made changes to report "1" in tx_max_coalesced_frames if
> VIRTIO_NET_F_NOTF_COAL is not supported and napi.weight is non-zero.
> However, the napi_weight value could still be changed by the
> set_coalesce call regardless of whether or not the device supports
> VIRTIO_NET_F_NOTF_COAL.
>
> It seems like the tx_max_coalesced_frames value should not control more
> than 1 thing (i.e. napi_weight and the device's tx_max_packets). So, fix
> this by only allowing the napi_weight change if VIRTIO_NET_F_NOTF_COAL
> is not supported by the virtio device.


@Jason I wonder should we keep this function to change the napi weight by the
coalesec command.

Thanks.

>
> It wasn't clear to me if this was the intended behavior, so that's why
> I'm sending this as an RFC patch initially. Based on the feedback, I
> will resubmit as an official patch.
>
> Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 486b5849033d..e28387866909 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2990,19 +2990,21 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  	int ret, i, napi_weight;
>  	bool update_napi = false;
>
> -	/* Can't change NAPI weight if the link is up */
> -	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> -			update_napi = true;
> -	}
> -
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>  		ret = virtnet_send_notf_coal_cmds(vi, ec);
> -	else
> +	} else {
> +		/* Can't change NAPI weight if the link is up */
> +		napi_weight = ec->tx_max_coalesced_frames ?
> +			NAPI_POLL_WEIGHT : 0;
> +		if (napi_weight ^ vi->sq[0].napi.weight) {
> +			if (dev->flags & IFF_UP)
> +				return -EBUSY;
> +			else
> +				update_napi = true;
> +		}
> +
>  		ret = virtnet_coal_params_supported(ec);
> +	}
>
>  	if (ret)
>  		return ret;
> --
> 2.17.1
>
