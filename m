Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422DD6CB6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC1GNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjC1GM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7591995
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679983928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNYsS8oHSFCBVyHN2UTLJCCtfI7eARSYYdIRY7lOzMs=;
        b=C9vDs2g2CcO28QXTsV/sPeioZJIcRC/zmVyppA3u+rXANX724Rb9qGa78B4CkcYgDmWIeL
        LdVlLGdVuJzAs55r86VcDq7dXAs1UnI9k5zVqrHfZ3nPCANObvRQvpOoA7u8/TbVOdINLH
        lMYmM0ya1avsvWyHZjSuEYT3TrGvong=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-oa5GXXL7NZqBLlf5caZboA-1; Tue, 28 Mar 2023 02:12:07 -0400
X-MC-Unique: oa5GXXL7NZqBLlf5caZboA-1
Received: by mail-pf1-f197.google.com with SMTP id i192-20020a6287c9000000b0062a43acb7faso5236093pfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679983926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNYsS8oHSFCBVyHN2UTLJCCtfI7eARSYYdIRY7lOzMs=;
        b=uxz1h0gdBSI0guwI2Is9+fyDfTWr4+QeMnF3qbaeElKVI60pAvk/GPXKmj/Yek8ynN
         B+iDFgSPJdPsARbdpYFXiOiaRCWzGlRMHHfm1pCN6mP74VWoQLJGfdrTRV2AwfbSEpPX
         xIDFeZl5AAdTfYLvEK6nmFDkdeBi9PocMfeYhPP+lirAFjdtY1+p9TBag+PWbmo/wA6o
         NqcWmMN/XnbZZen5VWTyV6rHtP69GdyIeDOx8rlEv7U7JNRSbsdFq28fzDMCWpw1pKbD
         FtvqKmy/4xQySNeCgPKzziGN6dXULC3nqLevnvcNHu9hLk+caJbu3t3RZJb6Lg7q1FY7
         kxRQ==
X-Gm-Message-State: AO0yUKVXYqgeHdCShctACNQX79J/ckkQAlWOAT9cy6E/wC9E+HIIbHlV
        SQz7JmBEZeqwIaXdkeVab/gVc47l3OTMhGc1o2guOsG0iyQnw6WCcYdXP4Y5JcD6wDEhET41VaV
        K/OG1yHsE6yJO9B7U8IAXMZdG
X-Received: by 2002:a05:6a20:7a90:b0:d9:bf06:cd85 with SMTP id u16-20020a056a207a9000b000d9bf06cd85mr13027290pzh.25.1679983926207;
        Mon, 27 Mar 2023 23:12:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9b73dlMpd/8UZwVEk4ZbGlEc2YwAOKpta3/KFIcfRmaz1cHfe5wKsj8Lc0+L6lCJaJP4bu6A==
X-Received: by 2002:a05:6a20:7a90:b0:d9:bf06:cd85 with SMTP id u16-20020a056a207a9000b000d9bf06cd85mr13027276pzh.25.1679983925877;
        Mon, 27 Mar 2023 23:12:05 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k12-20020a6568cc000000b005136d5a2b26sm1436311pgt.60.2023.03.27.23.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:12:05 -0700 (PDT)
Message-ID: <de2efe1a-1868-2552-7a1a-4aed398dfb98@redhat.com>
Date:   Tue, 28 Mar 2023 14:12:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de,
        hch@lst.de, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <20230324051153-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230324051153-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/24 17:12, Michael S. Tsirkin 写道:
> On Fri, Mar 24, 2023 at 02:27:52PM +0800, Jason Wang wrote:
>> On Thu, Mar 23, 2023 at 1:31 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>>> To support interrupt affinity spreading mechanism,
>>> this makes use of group_cpus_evenly() to create
>>> an irq callback affinity mask for each virtqueue
>>> of vdpa device. Then we will unify set_vq_affinity
>>> callback to pass the affinity to the vdpa device driver.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>> Thinking hard of all the logics, I think I've found something interesting.
>>
>> Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
>> pass irq_affinity to transport specific find_vqs().  This seems a
>> layer violation since driver has no knowledge of
>>
>> 1) whether or not the callback is based on an IRQ
>> 2) whether or not the device is a PCI or not (the details are hided by
>> the transport driver)
>> 3) how many vectors could be used by a device
>>
>> This means the driver can't actually pass a real affinity masks so the
>> commit passes a zero irq affinity structure as a hint in fact, so the
>> PCI layer can build a default affinity based that groups cpus evenly
>> based on the number of MSI-X vectors (the core logic is the
>> group_cpus_evenly). I think we should fix this by replacing the
>> irq_affinity structure with
>>
>> 1) a boolean like auto_cb_spreading
>>
>> or
>>
>> 2) queue to cpu mapping
>>
>> So each transport can do its own logic based on that. Then virtio-vDPA
>> can pass that policy to VDUSE where we only need a group_cpus_evenly()
>> and avoid duplicating irq_create_affinity_masks()?
>>
>> Thanks
> I don't really understand what you propose. Care to post a patch?


I meant to avoid passing irq_affinity structure in find_vqs but an array 
of boolean telling us whether or not the vq requires a automatic 
spreading of callbacks. But it seems less flexible.


> Also does it have to block this patchset or can it be done on top?


We can leave it in the future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
>>> ---
>>>   drivers/virtio/virtio_vdpa.c | 68 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 68 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index f72696b4c1c2..f3826f42b704 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/kernel.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/uuid.h>
>>> +#include <linux/group_cpus.h>
>>>   #include <linux/virtio.h>
>>>   #include <linux/vdpa.h>
>>>   #include <linux/virtio_config.h>
>>> @@ -272,6 +273,66 @@ static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
>>>                  virtio_vdpa_del_vq(vq);
>>>   }
>>>
>>> +static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
>>> +{
>>> +       affd->nr_sets = 1;
>>> +       affd->set_size[0] = affvecs;
>>> +}
>>> +
>>> +static struct cpumask *
>>> +create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>>> +{
>>> +       unsigned int affvecs = 0, curvec, usedvecs, i;
>>> +       struct cpumask *masks = NULL;
>>> +
>>> +       if (nvecs > affd->pre_vectors + affd->post_vectors)
>>> +               affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>>> +
>>> +       if (!affd->calc_sets)
>>> +               affd->calc_sets = default_calc_sets;
>>> +
>>> +       affd->calc_sets(affd, affvecs);
>>> +
>>> +       if (!affvecs)
>>> +               return NULL;
>>> +
>>> +       masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
>>> +       if (!masks)
>>> +               return NULL;
>>> +
>>> +       /* Fill out vectors at the beginning that don't need affinity */
>>> +       for (curvec = 0; curvec < affd->pre_vectors; curvec++)
>>> +               cpumask_setall(&masks[curvec]);
>>> +
>>> +       for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>>> +               unsigned int this_vecs = affd->set_size[i];
>>> +               int j;
>>> +               struct cpumask *result = group_cpus_evenly(this_vecs);
>>> +
>>> +               if (!result) {
>>> +                       kfree(masks);
>>> +                       return NULL;
>>> +               }
>>> +
>>> +               for (j = 0; j < this_vecs; j++)
>>> +                       cpumask_copy(&masks[curvec + j], &result[j]);
>>> +               kfree(result);
>>> +
>>> +               curvec += this_vecs;
>>> +               usedvecs += this_vecs;
>>> +       }
>>> +
>>> +       /* Fill out vectors at the end that don't need affinity */
>>> +       if (usedvecs >= affvecs)
>>> +               curvec = affd->pre_vectors + affvecs;
>>> +       else
>>> +               curvec = affd->pre_vectors + usedvecs;
>>> +       for (; curvec < nvecs; curvec++)
>>> +               cpumask_setall(&masks[curvec]);
>>> +
>>> +       return masks;
>>> +}
>>> +
>>>   static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>>                                  struct virtqueue *vqs[],
>>>                                  vq_callback_t *callbacks[],
>>> @@ -282,9 +343,15 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>>          struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
>>>          struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>>          const struct vdpa_config_ops *ops = vdpa->config;
>>> +       struct irq_affinity default_affd = { 0 };
>>> +       struct cpumask *masks;
>>>          struct vdpa_callback cb;
>>>          int i, err, queue_idx = 0;
>>>
>>> +       masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
>>> +       if (!masks)
>>> +               return -ENOMEM;
>>> +
>>>          for (i = 0; i < nvqs; ++i) {
>>>                  if (!names[i]) {
>>>                          vqs[i] = NULL;
>>> @@ -298,6 +365,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>>                          err = PTR_ERR(vqs[i]);
>>>                          goto err_setup_vq;
>>>                  }
>>> +               ops->set_vq_affinity(vdpa, i, &masks[i]);
>>>          }
>>>
>>>          cb.callback = virtio_vdpa_config_cb;
>>> --
>>> 2.20.1
>>>

