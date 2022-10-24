Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067D60BE29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJXXGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJXXFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:05:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704928E07C;
        Mon, 24 Oct 2022 14:26:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id be13so18776412lfb.4;
        Mon, 24 Oct 2022 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lpmvn6r7dh60+tXCwg9HVv88NIhkpPaXAz7PN44Ep2g=;
        b=oa5GbDJ8fcj7npsls3OssMNUVigy+PTewvlQmBBoDoi3MrZ0aMwPLyxD1uf8fqcLZ0
         MCi6fqWraBirLQPpYixafFBpK2g1WUoP2WdN22To+uCTHC1vAS/YgEMed90lHKp/9il5
         bVRFf3AVaeYJ41tZ59RxKw9W8Fqx2PVQd74JNxkvseXvdIt2kArF2ENlU+wwKl2TnvP3
         dqqsLzJF/WYEhjOQgs6+3CHSnzYzifpc4+MQtJkNeYPj5uzU7M3R5+UCaQV2luYlwSl3
         gWn37ygBR6JXvLYPWcuCBPtUmVgXklWh3qUvimaFuhw0skGPxdBcSCIICJVlNBgT5o59
         mjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpmvn6r7dh60+tXCwg9HVv88NIhkpPaXAz7PN44Ep2g=;
        b=l7wTndwJg3QyqM6hPlKfvCsai9iriCOYdWc9HoxIBeghJTsil5iB7Ph7aquZ1D6Di4
         dfRbhELvp7h9mgcb27NYVzC33f+OgbO6sHGlTFVNY5OKBR/PULoHuLgyX7eJd/jDPHzA
         Mr2dcMOx/9QTWbaPwZ5GRZMeHIumy/XmrVOVVPg/rTXGeJbCBkBqpUynyDPzEoKXOjCk
         HOpQ6utDqyoCSEfM+IRVdvXxCfWnhNiO3IG4d3Hw6ZItXUY8fOnin2q5X34gEAaMeKAx
         yncoMegI/lYnxspAJ8bFy2JyIA6JbwpX0n5sL0MJQPa+LM7nxxaNLHL5slQgJzcWDkSY
         vMOg==
X-Gm-Message-State: ACrzQf2B2eI4EYdnOkAHP54GQIFUAersrxXF6oo7grrgCgdKFXhVgrSJ
        iHKJVrmIbc/fH0hDb3E4F9VC1SZ4uD7wxlPtL/qYOuGlOAM=
X-Google-Smtp-Source: AMsMyM58SleO86M78mwwRfccBo3+XaYYC7DNfdxs/Vb9MLcUfY0/LU7yG3PKMRSSyl8hmd8G8av3g0pFIat3soaaW8c=
X-Received: by 2002:a05:651c:4ce:b0:26f:e2fd:57ed with SMTP id
 e14-20020a05651c04ce00b0026fe2fd57edmr13810523lji.161.1666644876485; Mon, 24
 Oct 2022 13:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com> <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
In-Reply-To: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Oct 2022 13:54:24 -0700
Message-ID: <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org, mst@redhat.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Mon, Oct 24, 2022 at 6:41 AM Igor Skalkin
<Igor.Skalkin@opensynergy.com> wrote:
>
> The current version of the configuration structure has unaligned
> 16-bit fields, but according to the specification [1], access to
> the configuration space must be aligned.
>
> Add a second, aligned  version of the configuration structure
> and a new feature bit indicating that this version is being used.
>
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> ---
>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
>  include/uapi/linux/virtio_bt.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 67c21263f9e0..35f8041722c8 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
>                 __u16 vendor;
>
> -               virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
> +                                    vendor, &vendor);
> +               else
> +                       virtio_cread(vdev, struct virtio_bt_config,
> +                                    vendor, &vendor);
>
>                 switch (vendor) {
>                 case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
> @@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
>                 __u16 msft_opcode;
>
> -               virtio_cread(vdev, struct virtio_bt_config,
> -                            msft_opcode, &msft_opcode);
> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
> +                                    msft_opcode, &msft_opcode);
> +               else
> +                       virtio_cread(vdev, struct virtio_bt_config,
> +                                    msft_opcode, &msft_opcode);
>
>                 hci_set_msft_opcode(hdev, msft_opcode);
>         }
> @@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] = {
>         VIRTIO_BT_F_VND_HCI,
>         VIRTIO_BT_F_MSFT_EXT,
>         VIRTIO_BT_F_AOSP_EXT,
> +       VIRTIO_BT_F_CONFIG_V2,
>  };

So this introduces a new flag which must be checked when attempting to
config, right? But is this backward compatible? What happens if for
some reason the userspace doesn't use the new struct are we able to
detect that?

>  static struct virtio_driver virtbt_driver = {
> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
> index a7bd48daa9a9..af798f4c9680 100644
> --- a/include/uapi/linux/virtio_bt.h
> +++ b/include/uapi/linux/virtio_bt.h
> @@ -9,6 +9,7 @@
>  #define VIRTIO_BT_F_VND_HCI    0       /* Indicates vendor command support */
>  #define VIRTIO_BT_F_MSFT_EXT   1       /* Indicates MSFT vendor support */
>  #define VIRTIO_BT_F_AOSP_EXT   2       /* Indicates AOSP vendor support */
> +#define VIRTIO_BT_F_CONFIG_V2  3       /* Use second version configuration */
>
>  enum virtio_bt_config_type {
>         VIRTIO_BT_CONFIG_TYPE_PRIMARY   = 0,
> @@ -28,4 +29,11 @@ struct virtio_bt_config {
>         __u16 msft_opcode;
>  } __attribute__((packed));
>
> +struct virtio_bt_config_v2 {
> +       __u8  type;
> +       __u8  alignment;
> +       __u16 vendor;
> +       __u16 msft_opcode;
> +};
> +
>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
