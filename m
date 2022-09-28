Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535EA5ED3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiI1EFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1EE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F172862
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664337893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZCmVV4/17mv21GMTdNuSAm0jpU/hXvj1/osgjLA5Mc=;
        b=SomChjsRfpy+FwfIX1LQSDhY+i9ag38is4XYxAUHCPxndh+UTTMeCMFhFaat+bg0JOEjrt
        SwyTmlwCO+2TuBkPBWjkGaTRWLOVz/Hj5SD+T+DiS5kqEPOYgkudKnGTwIbVhWYmrX4xja
        0hHhksDzJcEWDRoSZTYMtHU4nUp8gLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-QtD80JEMNm6LNUPDjCM4TQ-1; Wed, 28 Sep 2022 00:04:50 -0400
X-MC-Unique: QtD80JEMNm6LNUPDjCM4TQ-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a1c3502000000b003b535aacc0bso469673wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IZCmVV4/17mv21GMTdNuSAm0jpU/hXvj1/osgjLA5Mc=;
        b=S4RNuhXNZL75Ui52P+OLRvSdUC3r0/C4MbyoM6leCRTsaKIbhdexD3Sr+sYsLYh76K
         4QXNBvXCz+Gc2/TeXa2CG9s0wFf0d9ltRpgV+vQvoy1pReQGxNGfylcDfj9iDPxZcyAv
         3BleMy4/QpkYqxAW+mqNmc7zcMukYch9UPyAYEDrlI3JDyC4zXyUmA1WGwqeGmGhILpt
         bgTnzizS/h9O3GCHjb6QzmWBLp/PdCDlJ+9ufffWIfBduFJST5sBZBA4bjUl22dEkz40
         Ze+1p+yJp0zEcXBoO/grPsz7Vfwddq2cNKOEjN+URLUWD2b9/i2VvybLZBEf1QmudetK
         CWPg==
X-Gm-Message-State: ACrzQf0r9xysVZVUz3txmcph4a+IRM6LzL2xWYfejV6BRUJ/U+b4J0y9
        2nQU1GypYwQtqFFOpzN2RmkuQYQdO6kslCch6QvGd4v2zbY0GJHWH7oDtd2spkma5A/qQNWtEvA
        NMcDjnIahDjzYmp+iaTlqDkVJ
X-Received: by 2002:a05:6000:156b:b0:22a:a83a:d349 with SMTP id 11-20020a056000156b00b0022aa83ad349mr19384862wrz.277.1664337889048;
        Tue, 27 Sep 2022 21:04:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6j10sncy6xaso+VwGsPpFDZwxVXN5J/5wQwepc7moFHObh2SfrjMHSOsx5i3wneOkOpeVlkQ==
X-Received: by 2002:a05:6000:156b:b0:22a:a83a:d349 with SMTP id 11-20020a056000156b00b0022aa83ad349mr19384849wrz.277.1664337888795;
        Tue, 27 Sep 2022 21:04:48 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6289000000b00226dfac0149sm3017721wru.114.2022.09.27.21.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:04:48 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:04:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= 
        <liubo03@inspur.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
Message-ID: <20220928000342-mutt-send-email-mst@kernel.org>
References: <4366e621c74e46bfa642d6802187ad44@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4366e621c74e46bfa642d6802187ad44@inspur.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:26:16AM +0000, Bo Liu (刘波)-浪潮信息 wrote:
> >On Mon, Sep 26, 2022 at 05:11:30AM -0400, Bo Liu wrote:
> >> It passes '_vq' to vring_free(), which still calls to_vvq() to get
> >> 'vq', let's directly pass 'vq'. It can avoid unnecessary call of
> >> to_vvq() in hot path.
> >>
> >> Signed-off-by: Bo Liu <liubo03@inspur.com>
> >
> >What is the point of this change?
> >
> >__vring_new_virtqueue returns struct virtqueue *, so vring_free matches
> that.
> >No?
> >
> 
> Hi
> In function vring_free(), to_vvq() js unnecessary, we can directly pass
> struct vring_virtqueue * to avoid this and remove the unnecessary code.

And so? Is the resulting binary smaller?

> >> ---
> >>  drivers/virtio/virtio_ring.c | 12 +++++-------
> >>  1 file changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c
> >> b/drivers/virtio/virtio_ring.c index 8974c34b40fd..d6d77bf58802 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -221,7 +221,7 @@ static struct virtqueue
> >*__vring_new_virtqueue(unsigned int index,
> >>  					       void (*callback)(struct
> virtqueue *),
> >>  					       const char *name);
> >>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int
> >> num); -static void vring_free(struct virtqueue *_vq);
> >> +static void vring_free(struct vring_virtqueue *vq);
> >>
> >>  /*
> >>   * Helpers.
> >> @@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue
> >*_vq, u32 num)
> >>  	if (err)
> >>  		goto err_state_extra;
> >>
> >> -	vring_free(&vq->vq);
> >> +	vring_free(vq);
> >>
> >>  	virtqueue_vring_init_split(&vring_split, vq);
> >>
> >> @@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue
> >*_vq, u32 num)
> >>  	if (err)
> >>  		goto err_state_extra;
> >>
> >> -	vring_free(&vq->vq);
> >> +	vring_free(vq);
> >>
> >>  	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
> >>
> >> @@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned
> >> int index,  }  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> >>
> >> -static void vring_free(struct virtqueue *_vq)
> >> +static void vring_free(struct vring_virtqueue *vq)
> >>  {
> >> -	struct vring_virtqueue *vq = to_vvq(_vq);
> >> -
> >>  	if (vq->we_own_ring) {
> >>  		if (vq->packed_ring) {
> >>  			vring_free_queue(vq->vq.vdev,
> >> @@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >>  	list_del(&_vq->list);
> >>  	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> >>
> >> -	vring_free(_vq);
> >> +	vring_free(vq);
> >>
> >>  	kfree(vq);
> >>  }
> >> --
> >> 2.27.0
> 


