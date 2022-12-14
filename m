Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78E464C403
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiLNGrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbiLNGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4128724
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671000368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/uGgWeyPpUkK7Ij8q3Mfl77hPjQRLagdr15VkXWvMU=;
        b=Q2cQLlnCc9A+uFYdubIEEf5CG1WaIz8PsCfc3IwlN3g1vAKsXZ1Cy83zkS6wBBiEuk71uS
        KxtL38dIpO8y9adTzpOtOEMQUP2aCAVyYANFiE3CM4weF2WVfLnmigSqYlZyXUxAhlZg2T
        LKmhJtBNfpOpMNlK+IJGg7b6KIAI1jk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-m-h_mqPoOo-R1iWy6ufBVg-1; Wed, 14 Dec 2022 01:46:07 -0500
X-MC-Unique: m-h_mqPoOo-R1iWy6ufBVg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1441544a0e5so4909497fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/uGgWeyPpUkK7Ij8q3Mfl77hPjQRLagdr15VkXWvMU=;
        b=tUHpKf0evI034SPhxegdSWTLslEhzcKZZQHmwGWnBLuGXScFDU9GjzZ/9qX7pFb8ME
         /VZ8GZi9wPP/eSXnuwpG0YEvOnxE0CK/A4hEOQLM0PxJYNF0HEpzI+em1X/D+2saTgsE
         G0I9k8cHIyvHh4VEVfNqTc5mBuknkkCKYVsclZOzVpopCfGgcDYHBg/GxolTtZ3RYLd3
         KemBH92cTOtaVedUXWilG1kdf//48R4D/EZprbiNmJrqAEP0ASoAGh1eJLief3hrYRqw
         hyaAcf7Ri9rxc5tSMmJnao43qI3OZF7galUdt9peagI3w/+MAs9lxyZMRfd3Rme6mjqU
         23QQ==
X-Gm-Message-State: AFqh2kqENRW+MHT0D3Wg63Gix787uh2v07uX3/XLfqFkPUMM6ARFS4OR
        b+BWqbKwqshWdGwYrQQI6k/O7Mx5pdCiRnN+N0YN9iYM0PC8K5LxhP1QFg+9HnGpJcvMsO6llzh
        AMb3qGmR6VOMBOAtI+91wCRXwuCpL1/D3duVKdbI5
X-Received: by 2002:a05:6870:41c7:b0:144:a97b:1ae2 with SMTP id z7-20020a05687041c700b00144a97b1ae2mr107909oac.35.1671000366426;
        Tue, 13 Dec 2022 22:46:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtcRZ22jl8YXWE+Ou5mo3nHgzRE0JO54AgFrrqC8Ly52HjwSUKGCden9upEeqPXBdroLUSLQS6K+mq6Or1SYYA=
X-Received: by 2002:a05:6870:41c7:b0:144:a97b:1ae2 with SMTP id
 z7-20020a05687041c700b00144a97b1ae2mr107900oac.35.1671000366177; Tue, 13 Dec
 2022 22:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20221207145428.31544-1-gautam.dawar@amd.com> <20221207145428.31544-9-gautam.dawar@amd.com>
In-Reply-To: <20221207145428.31544-9-gautam.dawar@amd.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 14 Dec 2022 14:45:55 +0800
Message-ID: <CACGkMEtGCbUBZRFh7EUJyymuWZ9uxiAOeJHA6h-dGa9Y3pDZGw@mail.gmail.com>
Subject: Re: [PATCH net-next 08/11] sfc: implement device status related vdpa
 config operations
To:     Gautam Dawar <gautam.dawar@amd.com>
Cc:     linux-net-drivers@amd.com, netdev@vger.kernel.org,
        eperezma@redhat.com, tanuj.kamde@amd.com, Koushik.Dutta@amd.com,
        harpreet.anand@amd.com, Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 10:57 PM Gautam Dawar <gautam.dawar@amd.com> wrote:
>
> vDPA config opertions to handle get/set device status and device
> reset have been implemented.
>
> Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef100_vdpa.c     |   7 +-
>  drivers/net/ethernet/sfc/ef100_vdpa.h     |   1 +
>  drivers/net/ethernet/sfc/ef100_vdpa_ops.c | 133 ++++++++++++++++++++++
>  3 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/sfc/ef100_vdpa.c b/drivers/net/ethernet/sfc/ef100_vdpa.c
> index 04d64bfe3c93..80bca281a748 100644
> --- a/drivers/net/ethernet/sfc/ef100_vdpa.c
> +++ b/drivers/net/ethernet/sfc/ef100_vdpa.c
> @@ -225,9 +225,14 @@ static int vdpa_allocate_vis(struct efx_nic *efx, unsigned int *allocated_vis)
>
>  static void ef100_vdpa_delete(struct efx_nic *efx)
>  {
> +       struct vdpa_device *vdpa_dev;
> +
>         if (efx->vdpa_nic) {
> +               vdpa_dev = &efx->vdpa_nic->vdpa_dev;
> +               ef100_vdpa_reset(vdpa_dev);

Any reason we need to reset during delete?

> +
>                 /* replace with _vdpa_unregister_device later */
> -               put_device(&efx->vdpa_nic->vdpa_dev.dev);
> +               put_device(&vdpa_dev->dev);
>                 efx->vdpa_nic = NULL;
>         }
>         efx_mcdi_free_vis(efx);
> diff --git a/drivers/net/ethernet/sfc/ef100_vdpa.h b/drivers/net/ethernet/sfc/ef100_vdpa.h
> index a33edd6dda12..1b0bbba88154 100644
> --- a/drivers/net/ethernet/sfc/ef100_vdpa.h
> +++ b/drivers/net/ethernet/sfc/ef100_vdpa.h
> @@ -186,6 +186,7 @@ int ef100_vdpa_add_filter(struct ef100_vdpa_nic *vdpa_nic,
>                           enum ef100_vdpa_mac_filter_type type);
>  int ef100_vdpa_irq_vectors_alloc(struct pci_dev *pci_dev, u16 nvqs);
>  void ef100_vdpa_irq_vectors_free(void *data);
> +int ef100_vdpa_reset(struct vdpa_device *vdev);
>
>  static inline bool efx_vdpa_is_little_endian(struct ef100_vdpa_nic *vdpa_nic)
>  {
> diff --git a/drivers/net/ethernet/sfc/ef100_vdpa_ops.c b/drivers/net/ethernet/sfc/ef100_vdpa_ops.c
> index 132ddb4a647b..718b67f6da90 100644
> --- a/drivers/net/ethernet/sfc/ef100_vdpa_ops.c
> +++ b/drivers/net/ethernet/sfc/ef100_vdpa_ops.c
> @@ -251,6 +251,62 @@ static bool is_qid_invalid(struct ef100_vdpa_nic *vdpa_nic, u16 idx,
>         return false;
>  }
>
> +static void ef100_reset_vdpa_device(struct ef100_vdpa_nic *vdpa_nic)
> +{
> +       int i;
> +
> +       WARN_ON(!mutex_is_locked(&vdpa_nic->lock));
> +
> +       if (!vdpa_nic->status)
> +               return;
> +
> +       vdpa_nic->vdpa_state = EF100_VDPA_STATE_INITIALIZED;
> +       vdpa_nic->status = 0;
> +       vdpa_nic->features = 0;
> +       for (i = 0; i < (vdpa_nic->max_queue_pairs * 2); i++)
> +               reset_vring(vdpa_nic, i);
> +}
> +
> +/* May be called under the rtnl lock */
> +int ef100_vdpa_reset(struct vdpa_device *vdev)
> +{
> +       struct ef100_vdpa_nic *vdpa_nic = get_vdpa_nic(vdev);
> +
> +       /* vdpa device can be deleted anytime but the bar_config
> +        * could still be vdpa and hence efx->state would be STATE_VDPA.
> +        * Accordingly, ensure vdpa device exists before reset handling
> +        */
> +       if (!vdpa_nic)
> +               return -ENODEV;
> +
> +       mutex_lock(&vdpa_nic->lock);
> +       ef100_reset_vdpa_device(vdpa_nic);
> +       mutex_unlock(&vdpa_nic->lock);
> +       return 0;
> +}
> +
> +static int start_vdpa_device(struct ef100_vdpa_nic *vdpa_nic)
> +{
> +       int rc = 0;
> +       int i, j;
> +
> +       for (i = 0; i < (vdpa_nic->max_queue_pairs * 2); i++) {
> +               if (can_create_vring(vdpa_nic, i)) {
> +                       rc = create_vring(vdpa_nic, i);

So I think we can safely remove the create_vring() in set_vq_ready()
since it's undefined behaviour if set_vq_ready() is called after
DRIVER_OK.

> +                       if (rc)
> +                               goto clear_vring;
> +               }
> +       }
> +       vdpa_nic->vdpa_state = EF100_VDPA_STATE_STARTED;
> +       return rc;
> +
> +clear_vring:
> +       for (j = 0; j < i; j++)
> +               if (vdpa_nic->vring[j].vring_created)
> +                       delete_vring(vdpa_nic, j);
> +       return rc;
> +}
> +
>  static int ef100_vdpa_set_vq_address(struct vdpa_device *vdev,
>                                      u16 idx, u64 desc_area, u64 driver_area,
>                                      u64 device_area)
> @@ -568,6 +624,80 @@ static u32 ef100_vdpa_get_vendor_id(struct vdpa_device *vdev)
>         return EF100_VDPA_VENDOR_ID;
>  }
>
> +static u8 ef100_vdpa_get_status(struct vdpa_device *vdev)
> +{
> +       struct ef100_vdpa_nic *vdpa_nic = get_vdpa_nic(vdev);
> +       u8 status;
> +
> +       mutex_lock(&vdpa_nic->lock);
> +       status = vdpa_nic->status;
> +       mutex_unlock(&vdpa_nic->lock);
> +       return status;
> +}
> +
> +static void ef100_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> +{
> +       struct ef100_vdpa_nic *vdpa_nic = get_vdpa_nic(vdev);
> +       u8 new_status;
> +       int rc;
> +
> +       mutex_lock(&vdpa_nic->lock);
> +       if (!status) {
> +               dev_info(&vdev->dev,
> +                        "%s: Status received is 0. Device reset being done\n",
> +                        __func__);
> +               ef100_reset_vdpa_device(vdpa_nic);
> +               goto unlock_return;
> +       }
> +       new_status = status & ~vdpa_nic->status;
> +       if (new_status == 0) {
> +               dev_info(&vdev->dev,
> +                        "%s: New status same as current status\n", __func__);
> +               goto unlock_return;
> +       }
> +       if (new_status & VIRTIO_CONFIG_S_FAILED) {
> +               ef100_reset_vdpa_device(vdpa_nic);
> +               goto unlock_return;
> +       }
> +
> +       if (new_status & VIRTIO_CONFIG_S_ACKNOWLEDGE &&
> +           vdpa_nic->vdpa_state == EF100_VDPA_STATE_INITIALIZED) {

As replied before, I think there's no need to check
EF100_VDPA_STATE_INITIALIZED, otherwise it could be a bug somewhere.

> +               vdpa_nic->status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
> +               new_status &= ~VIRTIO_CONFIG_S_ACKNOWLEDGE;
> +       }
> +       if (new_status & VIRTIO_CONFIG_S_DRIVER &&
> +           vdpa_nic->vdpa_state == EF100_VDPA_STATE_INITIALIZED) {
> +               vdpa_nic->status |= VIRTIO_CONFIG_S_DRIVER;
> +               new_status &= ~VIRTIO_CONFIG_S_DRIVER;
> +       }
> +       if (new_status & VIRTIO_CONFIG_S_FEATURES_OK &&
> +           vdpa_nic->vdpa_state == EF100_VDPA_STATE_INITIALIZED) {
> +               vdpa_nic->status |= VIRTIO_CONFIG_S_FEATURES_OK;
> +               vdpa_nic->vdpa_state = EF100_VDPA_STATE_NEGOTIATED;

I think we can simply map EF100_VDPA_STATE_NEGOTIATED to
VIRTIO_CONFIG_S_FEATURES_OK.

E.g the code doesn't fail the feature negotiation by clearing the
VIRTIO_CONFIG_S_FEATURES_OK when ef100_vdpa_set_driver_feature fails?

Thanks

