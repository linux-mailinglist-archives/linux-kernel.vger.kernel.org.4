Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26375651DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiLTJsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLTJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:48:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3182B46;
        Tue, 20 Dec 2022 01:48:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 682A66602CA4;
        Tue, 20 Dec 2022 09:48:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671529710;
        bh=+UeG/t8P+OtU1McVRjaNAutZvdie8zzl6FllAp34G0I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mSzvmpUKp6IPOVDQbTVALqil8LoCSJeOkeNxrlV1o46X3tXNtbUgafurypeqRxgCU
         LrVWIKiMjNs2N5pZ1RRM2YGRhSQf+FvhRmxACS42HRhlSpYfOP/YdItGC35zi2/x4w
         qB3DuMABQ9triLkO7jYbgO2Qi6Ot7L2clBaxiQLP/IayiGwQ+mGaB4EDs0xM0zFURT
         wGfilln7bSuXVQ+Z2La+YPr+xAZ1ObOjJYmzwHZp2sBOqny6mYD19QQ4muAGDpaWcP
         mA4h+qogAW72SJzP5GBQnoTIM55x2f7RBK6pFOISo2pz45fvN2fE9qLghCrEKLnhaS
         F5zaT7iYS/4nA==
Message-ID: <c0540d38-090a-abb8-654d-db61ce356349@collabora.com>
Date:   Tue, 20 Dec 2022 10:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/12/22 08:37, Ricardo Cañuelo ha scritto:
> Fixes two warning messages when building htmldocs:
> 
>      warning: duplicate section name 'Note'
>      warning: expecting prototype for virtio_config_ops().
>               Prototype was for vq_callback_t() instead
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---
>   include/linux/virtio_config.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4b517649cfe8..f9a33062c089 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -16,8 +16,10 @@ struct virtio_shm_region {
>   	u64 len;
>   };
>   
> +typedef void vq_callback_t(struct virtqueue *);
> +
>   /**
> - * virtio_config_ops - operations for configuring a virtio device
> + * struct virtio_config_ops - operations for configuring a virtio device
>    * Note: Do not assume that a transport implements all of the operations
>    *       getting/setting a value as a simple read/write! Generally speaking,
>    *       any of @get/@set, @get_status/@set_status, or @get_features/
> @@ -68,8 +70,8 @@ struct virtio_shm_region {
>    * @finalize_features: confirm what device features we'll be using.
>    *	vdev: the virtio_device
>    *	This sends the driver feature bits to the device: it can change
> - *	the dev->feature bits if it wants.
> - * Note: despite the name this can be called any number of times.
> + *	the dev->feature bits if it wants. Note: despite the name this
> + *	can be called any number of times.

To avoid getting the same warning in the future (developer mistake and/or other
reasons), what about dropping this instance of "Note:" entirely?

I think that something like...

the dev->feature bits if it wants. Note that despite the name....

Cheers,
Angelo

