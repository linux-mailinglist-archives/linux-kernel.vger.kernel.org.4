Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE61747727
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGDQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGDQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5B10D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688489006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++31QNnFpybX5MmpnsU7eZDLUx30FaViiXqi2htj32Q=;
        b=FrZp3K32652/0Rqx+Px7R2+/81/3RUb7GGTS2tGHC6Nndew3JhJ3vHIwJMZcun2AyBzu7l
        dFJ24DORkLylwAgZJsPIybzVckna+lzdchW45HZ9p1M+VBpiSTC8PJihgYZwiZenGv9kcI
        tYvJ8RWpYtMNBvmdy7hbSfkw0vk3Luw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Oeevy7mhNnCSx92pyoCaNQ-1; Tue, 04 Jul 2023 12:43:25 -0400
X-MC-Unique: Oeevy7mhNnCSx92pyoCaNQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31400956ce8so3259919f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489004; x=1691081004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++31QNnFpybX5MmpnsU7eZDLUx30FaViiXqi2htj32Q=;
        b=Q310zTCsTUgsN8NlRZjHRdmdIiKs0Z8L90Oup5YhK2tNdFJcopvSs1ZT6JHbWMvA+A
         4V6KTE47Dy918hLkjUK3GuyJqCuD0P2L0z4yLAOYRjoULkv6EYZ+xDw1lp+2Nd9Ua9Yx
         y6trTVVyPfdl+woGNLTVEycFwCIK9ISu8WzEsw7z1QzffNnqxbtXOt6ZX60S6koGqom8
         KQl9M5bi/q8K09WFgEr1oSKHhOAH6cHHuZaHZn3pxyLoKokzYJWhBdnfJAIiOE9Sn69E
         dV5McvDAws0qcW0DvHK+41a6ESwZppS71acqfWtzU6Tq4xdxg5UUvcJL7XZyx+PeoexZ
         eYIA==
X-Gm-Message-State: ABy/qLZowwhN62MhuQ41pYH+bcPavB+rKIFchzWdmqWwpPLmjCQPCMsi
        U8MPxWJ8M1KrXgH2lkX2mDpV66q0Xnwf5glv3KqVIEgrJN/hjrVVGC5mJ2aX2iddQQlHIZ7fs6V
        44YDjeh/szBulD3+jxYp6cTEx
X-Received: by 2002:a5d:4fc4:0:b0:313:ebf3:f817 with SMTP id h4-20020a5d4fc4000000b00313ebf3f817mr11139666wrw.22.1688489004439;
        Tue, 04 Jul 2023 09:43:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLwTkm7jWgBjGyISZ+jMBiAdz5/mJ7POTeZPg0ZURSljLDG/kIWES+tk18V/kyaa6T4rWemQ==
X-Received: by 2002:a5d:4fc4:0:b0:313:ebf3:f817 with SMTP id h4-20020a5d4fc4000000b00313ebf3f817mr11139646wrw.22.1688489004093;
        Tue, 04 Jul 2023 09:43:24 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id a16-20020adfeed0000000b0031431fb40fasm7742592wrp.89.2023.07.04.09.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:43:23 -0700 (PDT)
Date:   Tue, 4 Jul 2023 12:43:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Message-ID: <20230704124245-mutt-send-email-mst@kernel.org>
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
 <20230704164045.39119-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704164045.39119-4-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 06:40:45PM +0200, Maxime Coquelin wrote:
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
> 
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's disable control virtqueue and features that depend on
> it.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 1271c9796517..04367a53802b 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(vduse_dev);
>  
> +static void vduse_dev_features_fixup(struct vduse_dev_config *config)
> +{
> +	if (config->device_id == VIRTIO_ID_NET) {
> +		/*
> +		 * Temporarily disable control virtqueue and features that
> +		 * depend on it while CVQ is being made more robust for VDUSE.
> +		 */
> +		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
> +				(1ULL << VIRTIO_NET_F_CTRL_RX) |
> +				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
> +				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
> +				(1ULL << VIRTIO_NET_F_MQ) |
> +				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
> +				(1ULL << VIRTIO_NET_F_RSS) |
> +				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
> +				(1ULL << VIRTIO_NET_F_NOTF_COAL));
> +	}
> +}
> +


This will never be exhaustive, we are adding new features.
Please add an allowlist with just legal ones instead.


>  static int vduse_create_dev(struct vduse_dev_config *config,
>  			    void *config_buf, u64 api_version)
>  {
> @@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	if (!dev)
>  		goto err;
>  
> +	vduse_dev_features_fixup(config);
> +
>  	dev->api_version = api_version;
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
> -- 
> 2.41.0

