Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D87064F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjEQKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEQKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1EE64
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684318405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2wx/HsJhUUdqsz7R5qMuiWwVG1FuENAd62XK76/qS8=;
        b=jBHB2kr7ujd9dBQWoXyd2YhhgsbPfmqs9Pb7NX+x/l+NNCmCxKTtX7OIGeWhfWdmJik4Ar
        +PaPptjSyNPmpTLdmxj5p3OFsTms80oKpJhE9mcB6+uf/0IsapvvzTiA7SnIt4y4W8dTA5
        obywxjkXHvAmYYFXIfjsUdDyGKdBfnk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-x9WnlNGyPuGVaJaQ7e4ZXA-1; Wed, 17 May 2023 06:13:24 -0400
X-MC-Unique: x9WnlNGyPuGVaJaQ7e4ZXA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f426d4944fso2223215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684318403; x=1686910403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2wx/HsJhUUdqsz7R5qMuiWwVG1FuENAd62XK76/qS8=;
        b=DqUOiSxV03YyEo87VH8c9xvdIziBcRrOuVmRAIsEH9l/FkVm2N+Fdb9qC9l24lgsNO
         QQ9XhVw2sfm2HqrUkt4my/LzBMyAAl5gvRTuHc3jgpR/HHcF5g7afDEofDqM5kyr7Lby
         wWJGMbiPSKTymZqFab7KUI4I++1Jzz7MCsdQpKUy1gfQssiEYFRAhwq0owDl/RhwGQ3q
         C7TqFyp003uWVRk96v/qSH1Rps3qLsLY3oiNEmSCASh8m5O2QIjO2+pWf1JerUcrB0MC
         uetHbCpLQBFPeB/X3tL4MmqFoc0ilZ/QT4t+zbtLRy79T9HcdWa9fv7H4mg4iOHKkzJJ
         neaw==
X-Gm-Message-State: AC+VfDz9lEi9QzRESjfNNWdsme+rWghUtiaUGTIq5aXgC0Hfv97ESdi9
        galIgr2ogKogIjdTuDwseQR0jOkguoGoXfu0irjlZZO5aYh+mjYA7kSC68Eyntb7zCASRV+MK32
        9s3DMUl5qcl7FAvnqd8xcUxqIOtu9P5dI
X-Received: by 2002:a7b:c846:0:b0:3f5:1980:ad43 with SMTP id c6-20020a7bc846000000b003f51980ad43mr2663450wml.31.1684318403016;
        Wed, 17 May 2023 03:13:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73+Ow9A8iGZ2I7XMdEwZHisBEr3+oOaglzf/0hAGadudfZm+Nhadvv93jmpnbpOJYRyatYsA==
X-Received: by 2002:a7b:c846:0:b0:3f5:1980:ad43 with SMTP id c6-20020a7bc846000000b003f51980ad43mr2663436wml.31.1684318402615;
        Wed, 17 May 2023 03:13:22 -0700 (PDT)
Received: from redhat.com ([2.52.6.43])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003f31d44f0cbsm1765534wmh.29.2023.05.17.03.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:13:21 -0700 (PDT)
Date:   Wed, 17 May 2023 06:13:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related
 methods
Message-ID: <20230517061152-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
 <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
 <20230517020947-mutt-send-email-mst@kernel.org>
 <b0b69e9d-da8a-791b-545f-c521dc752b88@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b69e9d-da8a-791b-545f-c521dc752b88@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:21:09PM +0800, zhenwei pi wrote:
> On 5/17/23 14:10, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 12:58:10PM +0800, zhenwei pi wrote:
> > > On 5/17/23 11:57, Michael S. Tsirkin wrote:
> > > > On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
> > > > > 
> > > > > 
> > > > > On 5/17/23 11:46, Michael S. Tsirkin wrote:
> > > > > > On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> > > > > > > v1 -> v2:
> > > > > > > - Suggested by MST, use fast path for vring based performance
> > > > > > > sensitive API.
> > > > > > > - Reduce changes in tools/virtio.
> > > > > > > 
> > > > > > > Add test result(no obvious change):
> > > > > > > Before:
> > > > > > > time ./vringh_test --parallel
> > > > > > > Using CPUS 0 and 191
> > > > > > > Guest: notified 10036893, pinged 68278
> > > > > > > Host: notified 68278, pinged 3093532
> > > > > > > 
> > > > > > > real	0m14.463s
> > > > > > > user	0m6.437s
> > > > > > > sys	0m8.010s
> > > > > > > 
> > > > > > > After:
> > > > > > > time ./vringh_test --parallel
> > > > > > > Using CPUS 0 and 191
> > > > > > > Guest: notified 10036709, pinged 68347
> > > > > > > Host: notified 68347, pinged 3085292
> > > > > > > 
> > > > > > > real	0m14.196s
> > > > > > > user	0m6.289s
> > > > > > > sys	0m7.885s
> > > > > > > 
> > > > > > > v1:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > > > > 
> > > > > > > Jason and Stefan pointed out that a non-vring based virtqueue has a
> > > > > > > chance to overwrite virtqueue instead of using vring virtqueue.
> > > > > > > 
> > > > > > > Then I try to abstract virtqueue related methods in this series, the
> > > > > > > details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> > > > > > > 
> > > > > > > Something is still remained:
> > > > > > > - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
> > > > > > >      virtio core, I'd like to rename them to vring_virtqueue_break
> > > > > > >      /vring_virtqueue_unbreak. Is this reasonable?
> > > > > > 
> > > > > > Why? These just set a flag?
> > > > > > 
> > > > > 
> > > > > Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
> > > > > exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> > > > 
> > > > I just do not see why you need these callbacks at all.
> > > > 
> > > 
> > > I use these callbacks for break/unbreak device like:
> > > static inline void virtio_break_device(struct virtio_device *dev)
> > > {
> > > 	struct virtqueue *vq;
> > > 
> > > 	spin_lock(&dev->vqs_list_lock);
> > > 	list_for_each_entry(vq, &dev->vqs, list) {
> > > 		vq->__break(vq);
> > > 	}
> > > 	spin_unlock(&dev->vqs_list_lock);
> > > }
> > 
> > why do this? backend knows they are broken.
> > 
> 
> I grep 'virtio_break_device' in the latest code:
> arch/um/drivers/virtio_uml.c:1147:	virtio_break_device(&vu_dev->vdev);
> arch/um/drivers/virtio_uml.c:1285:	virtio_break_device(&vu_dev->vdev);
> drivers/crypto/virtio/virtio_crypto_core.c:269:	
> virtio_break_device(vcrypto->vdev);
> drivers/s390/virtio/virtio_ccw.c:1251:			virtio_break_device(&vcdev->vdev);
> drivers/s390/virtio/virtio_ccw.c:1268:		virtio_break_device(&vcdev->vdev);
> drivers/firmware/arm_scmi/virtio.c:489:
> virtio_break_device(vioch->vqueue->vdev);
> drivers/char/virtio_console.c:1956:	virtio_break_device(vdev);
> 
> Some virtio drivers use 'virtio_break_device'...

You should read the code and understand what it does,
not just grep things and make assumptions.
What virtio_break_device does is stop linux from sending
new requests.


> > > > > > > - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
> > > > > > >      /virtqueue_get_vring is vring specific, I'd like to rename them like
> > > > > > >      vring_virtqueue_get_desc_addr. Is this reasonable?
> > > > > > > - there are still some functions in virtio_ring.c with prefix *virtqueue*,
> > > > > > >      for example 'virtqueue_add_split', just keep it or rename it to
> > > > > > >      'vring_virtqueue_add_split'?
> > > > > > > zhenwei pi (2):
> > > > > > >      virtio: abstract virtqueue related methods
> > > > > > >      tools/virtio: implement virtqueue in test
> > > > > > > 
> > > > > > >     drivers/virtio/virtio_ring.c | 285 +++++-----------------
> > > > > > >     include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
> > > > > > >     include/linux/virtio_ring.h  |  26 +++
> > > > > > >     tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
> > > > > > >     4 files changed, 807 insertions(+), 300 deletions(-)
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > zhenwei pi
> > > > 
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

