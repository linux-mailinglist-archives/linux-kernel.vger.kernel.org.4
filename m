Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E3705FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjEQGLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjEQGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253F4493
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684303825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7k7pF0B18nkLr+NjCb47Ij0PMr/KmJbhEjNycbRjuVg=;
        b=ONcWDIdIwTvjX/gGnHHHmQ3ik5DBeEnFDnMVjUJi/LCaBoEe1t12jtp/ksgK4JInB3O2h9
        J/dhGayK82iB6LUMDX8knqdycboe4PnUjpEweePBjpo3Mbv9wEQ7tzQQTz1q1VXfhSCmCh
        ipx89wXNGbL7jtLjNgjt3hcmESrWbEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-6-0PE9V4Oy-yyc5PLc1BDQ-1; Wed, 17 May 2023 02:10:24 -0400
X-MC-Unique: 6-0PE9V4Oy-yyc5PLc1BDQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42b36733aso1283795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684303823; x=1686895823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k7pF0B18nkLr+NjCb47Ij0PMr/KmJbhEjNycbRjuVg=;
        b=f+b45NeS8qgDrI2lOucljkI7Hj9+i5hqoVLKU06y3LLDU94XoVi0wUeSgS+iwkMPP4
         LfKdVItaQ/j1gobcfR6zyLQa0zbl63FhvKLsJyGmfyn5wDRsW6pE+5Lwku6j1AtvCk/s
         5wNFsHez47J24QGAFuIj2vbVSB0Dg636m5A/BXVbdNjfLbvDapYhZlKyrzHXQxPyd7bE
         quJNAc3OyyQy5uponwlK6uPkb+Q2BTJUPWxOvL7zCTe9i1cMZJmLHTeJwlorIA1rQ1wn
         yP3ZpciwPDifuF2qMTxtj+sVEQv6QuWSZTlNuAKr49smoVRG84uGpEOxJdR9ZcilJqZI
         i2hg==
X-Gm-Message-State: AC+VfDy2dWXxo6KF3DKiKARyqTbB6XMZe6HxhQ86AGaXDRXEdn44I/ER
        nH8JzWSDhCHjLIdJy27bBUJvYeFmZIBf7JKeavkib3xKRvWt7BwaGRmB0kGmgkosF1OcehYcCFB
        /K7q922Qu0vVPhYhH/xQHJmNw
X-Received: by 2002:a5d:58da:0:b0:307:7d1a:2100 with SMTP id o26-20020a5d58da000000b003077d1a2100mr29946140wrf.22.1684303823012;
        Tue, 16 May 2023 23:10:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bkIb2CjCg5ouxlAmzd4JzhURgicC1Ja4DMt3QZaJJ7w/7hrm1Do1sRnRF24r+3WNhaqvboQ==
X-Received: by 2002:a5d:58da:0:b0:307:7d1a:2100 with SMTP id o26-20020a5d58da000000b003077d1a2100mr29946126wrf.22.1684303822707;
        Tue, 16 May 2023 23:10:22 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b003012030a0c6sm1708138wrs.18.2023.05.16.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:10:21 -0700 (PDT)
Date:   Wed, 17 May 2023 02:10:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Message-ID: <20230517020947-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
 <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:58:10PM +0800, zhenwei pi wrote:
> On 5/17/23 11:57, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
> > > 
> > > 
> > > On 5/17/23 11:46, Michael S. Tsirkin wrote:
> > > > On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> > > > > v1 -> v2:
> > > > > - Suggested by MST, use fast path for vring based performance
> > > > > sensitive API.
> > > > > - Reduce changes in tools/virtio.
> > > > > 
> > > > > Add test result(no obvious change):
> > > > > Before:
> > > > > time ./vringh_test --parallel
> > > > > Using CPUS 0 and 191
> > > > > Guest: notified 10036893, pinged 68278
> > > > > Host: notified 68278, pinged 3093532
> > > > > 
> > > > > real	0m14.463s
> > > > > user	0m6.437s
> > > > > sys	0m8.010s
> > > > > 
> > > > > After:
> > > > > time ./vringh_test --parallel
> > > > > Using CPUS 0 and 191
> > > > > Guest: notified 10036709, pinged 68347
> > > > > Host: notified 68347, pinged 3085292
> > > > > 
> > > > > real	0m14.196s
> > > > > user	0m6.289s
> > > > > sys	0m7.885s
> > > > > 
> > > > > v1:
> > > > > Hi,
> > > > > 
> > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > > 
> > > > > Jason and Stefan pointed out that a non-vring based virtqueue has a
> > > > > chance to overwrite virtqueue instead of using vring virtqueue.
> > > > > 
> > > > > Then I try to abstract virtqueue related methods in this series, the
> > > > > details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> > > > > 
> > > > > Something is still remained:
> > > > > - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
> > > > >     virtio core, I'd like to rename them to vring_virtqueue_break
> > > > >     /vring_virtqueue_unbreak. Is this reasonable?
> > > > 
> > > > Why? These just set a flag?
> > > > 
> > > 
> > > Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
> > > exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> > 
> > I just do not see why you need these callbacks at all.
> > 
> 
> I use these callbacks for break/unbreak device like:
> static inline void virtio_break_device(struct virtio_device *dev)
> {
> 	struct virtqueue *vq;
> 
> 	spin_lock(&dev->vqs_list_lock);
> 	list_for_each_entry(vq, &dev->vqs, list) {
> 		vq->__break(vq);
> 	}
> 	spin_unlock(&dev->vqs_list_lock);
> }

why do this? backend knows they are broken.

> > > > > - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
> > > > >     /virtqueue_get_vring is vring specific, I'd like to rename them like
> > > > >     vring_virtqueue_get_desc_addr. Is this reasonable?
> > > > > - there are still some functions in virtio_ring.c with prefix *virtqueue*,
> > > > >     for example 'virtqueue_add_split', just keep it or rename it to
> > > > >     'vring_virtqueue_add_split'?
> > > > > zhenwei pi (2):
> > > > >     virtio: abstract virtqueue related methods
> > > > >     tools/virtio: implement virtqueue in test
> > > > > 
> > > > >    drivers/virtio/virtio_ring.c | 285 +++++-----------------
> > > > >    include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
> > > > >    include/linux/virtio_ring.h  |  26 +++
> > > > >    tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
> > > > >    4 files changed, 807 insertions(+), 300 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.20.1
> > > > 
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

