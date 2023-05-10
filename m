Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4A6FD483
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEJDmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjEJDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C861B5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683689970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wlZl2fAPuTd3JqB/fZvLboX3nUwjokftAJ3jxxwO4YM=;
        b=V/d9WASo72iorzkPVscZnVE8Ile0vWrd5YCrZ/EmgjjqNZw6kNpYECPiXUKoPkqgPq6/s2
        WeKMkm7UyjOyioeDsPtj7YOymG3A1XnJvmZfL9lHraxpannarb/WCpsjmiVpOJVby3Ju92
        ssiyVvmvQvBzLyL13AIqeLMyr/dy5kI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-cABnGyjWOka1rl_hA1vvIA-1; Tue, 09 May 2023 23:39:26 -0400
X-MC-Unique: cABnGyjWOka1rl_hA1vvIA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bc6c6b9dbso10298146a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683689965; x=1686281965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlZl2fAPuTd3JqB/fZvLboX3nUwjokftAJ3jxxwO4YM=;
        b=UOa2ETY8q9feQ302lgzNjq0GOGuCO5v70BuztuijHqFJMec2GtyRcO7myBBkbQiESq
         ALgoA/0TC0QafztRIQxd+zvQ438ex13fTICxCIW7hHgPYxiNK5x9DrvHtPI3F/lfgKsR
         o3i9rXLZDuK5NLcPthrI0iTDfdwDS5aWz6IKksyEv5rQBjxoN/CNCYy/dPkmUOrTLZgr
         KwHSEybHY2fgPg6DtfoLikGawc7FKw1TweehelXy3ZM4dOUGN7g9MlHJV9p/5G2kynqt
         2Eda8I8qpUIJAY9VxStdHuMze3f1dBK2wtL2SZxOnq7ZChOMIDmfuH1zFZZCs+5ylpeo
         /Liw==
X-Gm-Message-State: AC+VfDwtNSEBUtowD9Af2/Mmg87ifUXnfgIY0TaIglge1Makj6Qwj/iU
        ZHU2QP4zEmwNBe6A89bf/F+g2Etk89GLGSADwqnkqwTuQZY4IEO2bzkQrc/V/miVf0/V1LOCYIu
        ygqkGGw8fJbRYhFHmK+4WnK7Q
X-Received: by 2002:a17:907:a429:b0:94a:8e19:6aba with SMTP id sg41-20020a170907a42900b0094a8e196abamr12998181ejc.21.1683689965215;
        Tue, 09 May 2023 20:39:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sYk9M1+ioaOc46/jtM0pADUa1SIsRL3bgJIdk7tzU+GlllerCbudekFfug0+600+8xihsEw==
X-Received: by 2002:a17:907:a429:b0:94a:8e19:6aba with SMTP id sg41-20020a170907a42900b0094a8e196abamr12998174ejc.21.1683689964809;
        Tue, 09 May 2023 20:39:24 -0700 (PDT)
Received: from redhat.com ([176.119.195.36])
        by smtp.gmail.com with ESMTPSA id bn13-20020a170906c0cd00b0096599bf7029sm2129152ejb.145.2023.05.09.20.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:39:24 -0700 (PDT)
Date:   Tue, 9 May 2023 23:39:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        jasowang@redhat.com
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230509233907-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:26:54AM +0800, Xuan Zhuo wrote:
> On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
> > Both split ring and packed ring use 32bits to describe the length of
> > a descriptor: see struct vring_desc and struct vring_packed_desc.
> > This means the max segment size supported by virtio is U32_MAX.
> >
> > An example of virtio_max_dma_size in virtio_blk.c:
> >   u32 v, max_size;
> >
> >   max_size = virtio_max_dma_size(vdev);  -> implicit convert
> >   err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> >                              struct virtio_blk_config, size_max, &v);
> >   max_size = min(max_size, v);
> >
> > There is a risk during implicit convert here, once virtio_max_dma_size
> > returns 4G, max_size becomes 0.
> >
> > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 ++++++++----
> >  include/linux/virtio.h       |  2 +-
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c5310eaf8b46..55cfecf030a1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
> >  	return false;
> >  }
> >
> > -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> 
> 
> LGTM
> 
> But, should we change the parameter to vq, then use the dma_dev?
> 
> @Jason
> 
> Thanks.
> 


that would be an unrelated rework.

> >  {
> > -	size_t max_segment_size = SIZE_MAX;
> > +	u32 max_segment_size = U32_MAX;
> >
> > -	if (vring_use_dma_api(vdev))
> > -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> > +	if (vring_use_dma_api(vdev)) {
> > +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
> > +
> > +		if (max_dma_size < max_segment_size)
> > +			max_segment_size = max_dma_size;
> > +	}
> >
> >  	return max_segment_size;
> >  }
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b93238db94e3..1a605f408329 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
> >  #endif
> >  void virtio_reset_device(struct virtio_device *dev);
> >
> > -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > +u32 virtio_max_dma_size(const struct virtio_device *vdev);
> >
> >  #define virtio_device_for_each_vq(vdev, vq) \
> >  	list_for_each_entry(vq, &vdev->vqs, list)
> > --
> > 2.20.1
> >

