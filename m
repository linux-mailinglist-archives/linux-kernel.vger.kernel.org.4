Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D5D675516
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjATM5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjATM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDB5FD4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674219414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67RdguR+gl433cYi2o595AZGinbUWlEV2GdMEq9B1vY=;
        b=ibQqfBf8xUOFAxxwa4tqgFK0ce5TPafx662OosOtKb4tNWNJBzwOwtFntWvx9pBir1Fldh
        itzotDIfnTHNDiMjrGRW9FJPP28QCHru3ZPhM2a5QQITvb1jm003cdioccI52SBN5U5x7w
        zaqBRAYkjVtRpnIF+SnlElEqI+Me5gE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-byBuMZM6Oiy41gtnO0OnJQ-1; Fri, 20 Jan 2023 07:56:53 -0500
X-MC-Unique: byBuMZM6Oiy41gtnO0OnJQ-1
Received: by mail-wr1-f71.google.com with SMTP id v3-20020adfa1c3000000b002bdd6ce1358so938127wrv.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67RdguR+gl433cYi2o595AZGinbUWlEV2GdMEq9B1vY=;
        b=foAwfe18YeX738F1TTAsjJE2Him31JPFIn0sG39shPf1zFgmqbnbshumuWoWIYQjaE
         39S3W/JzSip964I5ii0TL754/4tDiF6KwsiUxg+IR3k4DZl3ppt3IRZjCoLrd0tWRIlt
         RatUzJmWP5BYMuO8YFbY75/dzM/L7gGHac5f12Y3xnYhwnZty2uk6DcmwCI+rL3hhv8y
         2SizPJRTVqRylSqkTFw7AZ7BUR0ZllZW/XAwJZ8SjuKfm8keHLWUH4TcIBnlGf7ssNFh
         XmpmNC18IvuTgOMar6tiJxx9rxYy54TG8blDVMYeOjp27LIHD2XOYKpo0PIXWIV5ReaN
         quUA==
X-Gm-Message-State: AFqh2ko8X8Rg89EYfdeDPxq/+Uef9KXT7LqiAVkL6Tk8J47iptIIKBz2
        m/j2p2c55YQw0d7qty5ipwRccpLCRe2AbVYO3G3fHfpfdEiDEABd6M8FOwqzX7zkI2uGWNH7Q5E
        PKNcJJxcwJ6J0w4Pp8lY8hv+G
X-Received: by 2002:a05:6000:1f0f:b0:2b4:e5e:c0a3 with SMTP id bv15-20020a0560001f0f00b002b40e5ec0a3mr8416450wrb.21.1674219412145;
        Fri, 20 Jan 2023 04:56:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvHro5tgAiDLoDeTFfBaz3IKVoGeRkuTWgSPP1YSFThQ9Daguu1quBRSdBhhT+3s5SsO7kQQ==
X-Received: by 2002:a05:6000:1f0f:b0:2b4:e5e:c0a3 with SMTP id bv15-20020a0560001f0f00b002b40e5ec0a3mr8416440wrb.21.1674219411869;
        Fri, 20 Jan 2023 04:56:51 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm35571506wrn.111.2023.01.20.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:56:51 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:56:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v1 6/6] virtio_ring: Prevent bounds check bypass on
 descriptor index
Message-ID: <20230120075448-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-7-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-7-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:21PM +0200, Alexander Shishkin wrote:
> The descriptor index in virtqueue_get_buf_ctx_split() comes from the
> device/VMM.a Use array_index_nospec() to prevent the CPU from speculating
> beyond the descriptor array bounds and providing a primitive for building
> a side channel.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..c42d070ab68d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/kmsan.h>
> @@ -819,6 +820,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u out of range\n", i);
>  		return NULL;
>  	}
> +
> +	i = array_index_nospec(i, vq->split.vring.num);

I suspect plain
	 i &= split.vring.num - 1
is more efficient.

We know num is a power of two but compiler doesn't.
And pls add a comment explaining what's going on.

>  	if (unlikely(!vq->split.desc_state[i].data)) {
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
> -- 
> 2.39.0

