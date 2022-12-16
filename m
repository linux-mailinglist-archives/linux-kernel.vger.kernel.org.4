Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6C64E687
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLPD7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLPD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2157B68
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671163108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZDZbw5KBbPfiS0aQTncakmGLck0pebaODb2v7fHtSkU=;
        b=K5FGe97IkNjfXBTxF0LGNcaYuRAQXLRE2YGPtaytDeklxN0OjL/Eg97aGBLesHMsClLcYU
        mEsqk0VIma13L3cMXeSmNeOecdg96LnFFbEckTrFK8R6tlkKFEiONYgMXuyxlmgfjlh58E
        1ZMQ4dcRsWgsTS52NBX3ceQTQTxOy3s=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-gqvu7vqgOAaqwOVQr5SF0Q-1; Thu, 15 Dec 2022 22:58:26 -0500
X-MC-Unique: gqvu7vqgOAaqwOVQr5SF0Q-1
Received: by mail-oi1-f199.google.com with SMTP id bi37-20020a05680818a500b0035ea4ea8db5so369305oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDZbw5KBbPfiS0aQTncakmGLck0pebaODb2v7fHtSkU=;
        b=rlW4IR6q4H/AJ9jRj8j6wX8cgiIz++qaSW6Sh/Cx6ndgFCkzAp8f7zOjtoDU2JULRj
         HlZXEPfgIw8M2mQd+h8fpVjvETShlA8xmHdmpyW4dmPqUm3ZBjGclwtX/xGWOxpcIBxe
         sHM6dePXk9usDdNva8ylH3VV3H9f9xfFObku9471+1hcWzj6bLp1EsPb2sJFCTskQnvY
         Gbx4e15FM9oWalm09cgyXMyVlEQ2q7jrx0Mhrn1GcegFR425bpTIZxORfDuZbLtgGShj
         aU/qeD8JWfmZwTL6+vJN8MTVmUr3pTQYdGKyrff31Z0Ts9/Nrt5qpzGug32VTcAEFBn2
         6dhw==
X-Gm-Message-State: ANoB5pmL3E4VuBwRTUkInNRcqCcmM1G4AkrFNbGrOJAenhUtU+rmtsTL
        Ve9k1CRRzOK+70uMeRRbtWaq4FfHfGzqI0eQpXFW2W4j8Faw78/aw/bw4p/iHYATGS6tlKveEUs
        YsfKcCX1z+4KcrmL71vVtUiJW3Xj8FNIzz3s0tHs4
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr321068oab.35.1671163106199;
        Thu, 15 Dec 2022 19:58:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7cNko4F3UygPQf9wPv8PFtFKeyAZAHrVVoEXi20rnQdjjtfEEnI4fzMXo4e3lRKZM1aSUXRIBpmnGfmOssvfY=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321067oab.35.1671163106015; Thu, 15
 Dec 2022 19:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 11:58:15 +0800
Message-ID: <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces set_irq_affinity callback in
> vdpa_config_ops so that vdpa device driver can
> get the interrupt affinity hint from the virtio
> device driver. The interrupt affinity hint would
> be needed by the interrupt affinity spreading
> mechanism.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 4 ++++
>  include/linux/vdpa.h         | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 08084b49e5a1..4731e4616ee0 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
>         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops = vdpa->config;
> +       struct irq_affinity default_affd = { 0 };
>         struct vdpa_callback cb;
>         int i, err, queue_idx = 0;
>
> +       if (ops->set_irq_affinity)
> +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);

I wonder if we need to do this in vhost-vDPA. Or it's better to have a
default affinity by the vDPA parent itself.

(Looking at virtio-pci, it doesn't do something like this).

Thanks

> +
>         for (i = 0; i < nvqs; ++i) {
>                 if (!names[i]) {
>                         vqs[i] = NULL;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0ff6c9363356..482ff7d0206f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -256,6 +256,12 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the irq affinity mask
> + * @set_irq_affinity:          Pass the irq affinity hint from the virtio
> + *                             device driver to vdpa driver (optional).
> + *                             Needed by the interrupt affinity spreading
> + *                             mechanism.
> + *                             @vdev: vdpa device
> + *                             @desc: irq affinity hint
>   * @set_group_asid:            Set address space identifier for a
>   *                             virtqueue group (optional)
>   *                             @vdev: vdpa device
> @@ -344,6 +350,8 @@ struct vdpa_config_ops {
>                                const struct cpumask *cpu_mask);
>         const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
>                                                  u16 idx);
> +       void (*set_irq_affinity)(struct vdpa_device *vdev,
> +                                struct irq_affinity *desc);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
> --
> 2.20.1
>

