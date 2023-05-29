Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFC7147A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjE2KEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjE2KEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5EC2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685354597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCKJ+LORkH28xGpVG5mVoc2W6fW5Bl/AF+V7DekZRg8=;
        b=Dj4+yy8G0Key09X4YCp8C9fDq+EploZJwxTLVKsfaHoX4FECBCTSimcS4tCq6TOBzmRv21
        Lh8dZCmfvaOQXnyrOE2RH2g/2UbMnvzRzLvLIfXNxjzcDbhiAA3xAVULbNoY8brPZvckD7
        KJWTkDBnvtjiNFVGB+5HCvhxdEnoA7U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-oaQ_dw5DM-qXi8WxxR18yg-1; Mon, 29 May 2023 06:03:16 -0400
X-MC-Unique: oaQ_dw5DM-qXi8WxxR18yg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30ac5fb0920so1700452f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685354595; x=1687946595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCKJ+LORkH28xGpVG5mVoc2W6fW5Bl/AF+V7DekZRg8=;
        b=c8lQ0piKPM4RzA+mqGD62TvYVMOx8GG+hMYx+7cbsVz327ZEX/y+Au/FRb445unDXN
         43HGpTgOunc7zCqf01n/iUY//QP/v7YWwgcReBG+ZhAzELPocC4zqaCOg7Hkbg2zMr0t
         r7cVLVAr3tua3t1zDyMXhRTw1BRxJwmbv23oyewrBYdSvqqnv2UKBOnj41YVw8QiD62G
         fj5vMtgenBFRRaSt37S6AcWU17TYJzcSB3D+H7+4tPCTHyauhVhH9/Ey3fgmeFLVSOkI
         yrMFoVVVbkH98Bf3x2dZtOsbgh6ETV5wDCyBENSz+yPI6p1OOZsr1dpo2h0e2V311P86
         ijow==
X-Gm-Message-State: AC+VfDwRifnwsF1oQhEd7ojwW74qcd9HLnK/GmB19Gc/n4ONPKP+8z6X
        LknfVln2IggE77EyZzG/ELXDyKDNAMOtIJeRs6TLBTApEO4lFmOHdanY3OOWhObRF1herVzBm3O
        p2n7IwSvHbvMOsPFq6mKdvpN5
X-Received: by 2002:adf:ed47:0:b0:309:48b3:3ad6 with SMTP id u7-20020adfed47000000b0030948b33ad6mr8564735wro.47.1685354595146;
        Mon, 29 May 2023 03:03:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CIkD5iZwxcJFtgiuOhN4DmR5d/SQeYjZ9asE/orbdZtNM3JdU5/U4SV6jnkco6EYZnhFp0w==
X-Received: by 2002:adf:ed47:0:b0:309:48b3:3ad6 with SMTP id u7-20020adfed47000000b0030948b33ad6mr8564715wro.47.1685354594779;
        Mon, 29 May 2023 03:03:14 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b003063a1cdaf2sm13067576wri.48.2023.05.29.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:03:14 -0700 (PDT)
Date:   Mon, 29 May 2023 06:03:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: validate used buffer length
Message-ID: <20230529055729-mutt-send-email-mst@kernel.org>
References: <20230526063041.18359-1-jasowang@redhat.com>
 <20230528033037-mutt-send-email-mst@kernel.org>
 <CACGkMEs9Ztavn2JyuUAb47Sk1fYHiXLLkQQPQR5Czhb2yu_R3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs9Ztavn2JyuUAb47Sk1fYHiXLLkQQPQR5Czhb2yu_R3w@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:18:10AM +0800, Jason Wang wrote:
> On Sun, May 28, 2023 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, May 26, 2023 at 02:30:41PM +0800, Jason Wang wrote:
> > > This patch validate
> >
> > validates
> >
> > > the used buffer length provided by the device
> > > before trying to use it.
> >
> > before returning it to caller
> >
> > > This is done by remembering the in buffer
> > > length in a dedicated array during virtqueue_add(), then we can fail
> > > the virtqueue_get_buf() when we find the device is trying to give us a
> > > used buffer length which is greater than we stored before.
> >
> > than what we stored
> >
> > >
> > > This validation is disable
> >
> > disabled
> >
> > > by default via module parameter to unbreak
> > > some existing devices since some legacy devices are known to report
> > > buggy used length.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > First I'm not merging this without more data about
> > what is known to be broken and what is known to work well
> > in the commit log. And how exactly do things work if used length
> > is wrong?
> 
> Assuming the device is malicious, it would be very hard to answer.
> Auditing and fuzzing won't cover every case. Instead of trying to seek
> the answer, we can simply make sure the used in buffer length is
> validated then we know we're fine or not.

To restate the question, you said above "some legacy devices are known
to report buggy used length". If they report buggy length then how
can things work?

> > Second what's wrong with dma_desc_extra that we already maintain?
> > Third motivation - it's part and parcel of the hardening effort yes?
> 
> They are different. dma_desc_extra is for a descriptor ring, but this
> is for a used ring. Technically we can go back to iterate on the
> descriptor ring for a legal used in buffer length. But it will have
> worse performance.

I don't really understand. We already iterate when we unmap -
all that is necessary is to subtract it from used length, if at
the end of the process it is >0 then we know used length is too
large.


> > I'd like to know the fate of VIRTIO_HARDEN_NOTIFICATION before
> > we do more hardening. If it's irrevocably broken let's rip it out?
> 
> So the plan is
> 
> 1) finish used ring validation (this had been proposed, merged and
> reverted before notification hardening)
> 2) do notification hardening on top.
> 
> So let's leave it as is and I will do a rework after we finalize the
> used ring validation.
> 
> Thanks
> 
> >
> >
> > > ---
> > > Changes since V4:
> > > - drop the flat for driver to suppress the check
> > > - validation is disabled by default
> > > - don't do validation for legacy device
> > > - rebase and support virtqueue resize
> > > ---
> > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 75 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 143f380baa1c..5b151605aaf8 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -15,6 +15,9 @@
> > >  #include <linux/spinlock.h>
> > >  #include <xen/xen.h>
> > >
> > > +static bool force_used_validation = false;
> > > +module_param(force_used_validation, bool, 0444);
> > > +
> > >  #ifdef DEBUG
> > >  /* For development, we want to crash whenever the ring is screwed. */
> > >  #define BAD_RING(_vq, fmt, args...)                          \
> > > @@ -105,6 +108,9 @@ struct vring_virtqueue_split {
> > >       struct vring_desc_state_split *desc_state;
> > >       struct vring_desc_extra *desc_extra;
> > >
> > > +     /* Maximum in buffer length, NULL means no used validation */
> > > +     u32 *buflen;
> > > +
> > >       /* DMA address and size information */
> > >       dma_addr_t queue_dma_addr;
> > >       size_t queue_size_in_bytes;
> > > @@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
> > >       struct vring_desc_state_packed *desc_state;
> > >       struct vring_desc_extra *desc_extra;
> > >
> > > +     /* Maximum in buffer length, NULL means no used validation */
> > > +     u32 *buflen;
> > > +
> > >       /* DMA address and size information */
> > >       dma_addr_t ring_dma_addr;
> > >       dma_addr_t driver_event_dma_addr;
> > > @@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > >       int head;
> > >       bool indirect;
> > > +     u32 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >                                                    VRING_DESC_F_NEXT |
> > >                                                    VRING_DESC_F_WRITE,
> > >                                                    indirect);
> > > +                     buflen += sg->length;
> > >               }
> > >       }
> > >       /* Last one doesn't continue. */
> > > @@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >       else
> > >               vq->split.desc_state[head].indir_desc = ctx;
> > >
> > > +     /* Store in buffer length if necessary */
> > > +     if (vq->split.buflen)
> > > +             vq->split.buflen[head] = buflen;
> > > +
> > >       /* Put entry in available array (but don't update avail->idx until they
> > >        * do sync). */
> > >       avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > @@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > >               return NULL;
> > >       }
> > > +     if (vq->split.buflen && unlikely(*len > vq->split.buflen[i])) {
> > > +             BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> > > +                     *len, vq->split.buflen[i]);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_split clears data, so grab it now. */
> > >       ret = vq->split.desc_state[i].data;
> > > @@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
> > >                        vring_split->queue_dma_addr,
> > >                        dma_dev);
> > >
> > > +     kfree(vring_split->buflen);
> > >       kfree(vring_split->desc_state);
> > >       kfree(vring_split->desc_extra);
> > >  }
> > >
> > > +static bool vring_needs_used_validation(const struct virtio_device *vdev)
> > > +{
> > > +     /*
> > > +      * Several legacy devices are known to produce buggy used
> > > +      * length. In order to let driver work, we won't validate used
> > > +      * buffer length in this case.
> > > +      */
> > > +     if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > > +             return false;
> > > +     if (force_used_validation)
> > > +             return true;
> > > +     return false;
> > > +}
> > > +
> > >  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> > >                                  struct virtio_device *vdev,
> > >                                  u32 num,
> > > @@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> > >       vring_split->vring_align = vring_align;
> > >       vring_split->may_reduce_num = may_reduce_num;
> > >
> > > +     if (vring_needs_used_validation(vdev)) {
> > > +             vring_split->buflen =
> > > +                     kmalloc_array(num, sizeof(*vring_split->buflen),
> > > +                                   GFP_KERNEL);
> > > +             if (!vring_split->buflen)
> > > +                     goto err_buflen;
> > > +     }
> > > +
> > >       return 0;
> > > +
> > > +err_buflen:
> > > +     vring_free_split(vring_split, vdev, dma_dev);
> > > +     return -ENOMEM;
> > >  }
> > >
> > >  static struct virtqueue *vring_create_virtqueue_split(
> > > @@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       unsigned int i, n, err_idx;
> > >       u16 head, id;
> > >       dma_addr_t addr;
> > > +     u32 buflen = 0;
> > >
> > >       head = vq->packed.next_avail_idx;
> > >       desc = alloc_indirect_packed(total_sg, gfp);
> > > @@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                       desc[i].addr = cpu_to_le64(addr);
> > >                       desc[i].len = cpu_to_le32(sg->length);
> > >                       i++;
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       vq->packed.desc_state[id].last = id;
> > >       vq->packed.desc_state[id].premapped = premapped;
> > >
> > > +     /* Store in buffer length if necessary */
> > > +     if (vq->packed.buflen)
> > > +             vq->packed.buflen[id] = buflen;
> > > +
> > >       vq->num_added += 1;
> > >
> > >       pr_debug("Added buffer head %i to %p\n", head, vq);
> > > @@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       __le16 head_flags, flags;
> > >       u16 head, id, prev, curr, avail_used_flags;
> > >       int err;
> > > +     u32 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> > >                                       1 << VRING_PACKED_DESC_F_USED;
> > >                       }
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       vq->packed.desc_state[id].last = prev;
> > >       vq->packed.desc_state[id].premapped = premapped;
> > >
> > > +     /* Store in buffer length if necessary */
> > > +     if (vq->packed.buflen)
> > > +             vq->packed.buflen[id] = buflen;
> > > +
> > >       /*
> > >        * A driver MUST NOT make the first descriptor in the list
> > >        * available before all subsequent descriptors comprising
> > > @@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > >               return NULL;
> > >       }
> > > +     if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id])) {
> > > +             BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> > > +                     *len, vq->packed.buflen[id]);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_packed clears data, so grab it now. */
> > >       ret = vq->packed.desc_state[id].data;
> > > @@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
> > >                                vring_packed->device_event_dma_addr,
> > >                                dma_dev);
> > >
> > > +     kfree(vring_packed->buflen);
> > >       kfree(vring_packed->desc_state);
> > >       kfree(vring_packed->desc_extra);
> > >  }
> > > @@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
> > >
> > >       vring_packed->vring.num = num;
> > >
> > > +     if (vring_needs_used_validation(vdev)) {
> > > +             vring_packed->buflen =
> > > +                     kmalloc_array(num, sizeof(*vring_packed->buflen),
> > > +                                   GFP_KERNEL);
> > > +             if (!vring_packed->buflen)
> > > +                     goto err;
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err:
> > > --
> > > 2.25.1
> >

