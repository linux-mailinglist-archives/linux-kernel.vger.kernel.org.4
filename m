Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564526DD195
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKFZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDKFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EE1BF7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681190656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DVhWWieG2vkXVLOuG6DQVebw7i6yeNydJngBNWHNr0=;
        b=CF4UVRXHBroEImfiZREFbiV1endoOGBFoX7LBH1sFg5zZB6t5YQ+Qvqkyy9jZb9qx5Kd+u
        i9fbK4dGoFjIvL6m0/vsuSS5RIdDNVEZsViNAW4aTWg+2W9bEvQUFRKM7N44WVZXs7LlQF
        ICKuOf3QGemmCzl3yf+oHwhSKILJF34=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-J9fRyN0iM0W9BX2rvVz_Tg-1; Tue, 11 Apr 2023 01:24:15 -0400
X-MC-Unique: J9fRyN0iM0W9BX2rvVz_Tg-1
Received: by mail-oo1-f70.google.com with SMTP id y145-20020a4a4597000000b00541bc33b8efso2222274ooa.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190654; x=1683782654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DVhWWieG2vkXVLOuG6DQVebw7i6yeNydJngBNWHNr0=;
        b=tOUmieoBZCjq4ViLCfcEb+cJ1YzHuDI3/ISHOFTVhDpp5YhufjBW/Nk3djIBdEHTP9
         FzgCPAtNkd+YQZC7IifuugIucBEWlocadtCq/CMmGRdC6CLPGdWgJ5mw7MIc5tgkVBqK
         9wJQ3M35e3A+5270hflWAB6q/K6+9WGLUylZ4xiTWLabx9bL/X1XV0ZjoVrk3cJEshiQ
         Imx0TbtRpGIr63zxsPqs621YdQ00B3GVclBPhFUT5Zn0rUIyZFuZdpQPVexXeU02EFrV
         YTWyrKAyyConagrdiPZT9l/fEea5v153tb1Ezv8uJu9w6qwd2+7Ve4L2TJ+//CVrOnbX
         KVGA==
X-Gm-Message-State: AAQBX9eWM4jxaPj+hIhWJGIXLkgBkOvKwrJvtG+751toP4llbtrulNRG
        mp+S5pobdqLfMAg+CUjRZE/qiEKVDyBYHvaADqBX/9iBbi9182X69dFpcczfi6WDh22ZY1VCAKE
        1NYQieTC9inLTvaQA3l11V+km/p9jKQQFW/GwVhpGWR2PHZmA3r64Gw==
X-Received: by 2002:a05:6830:1d9:b0:698:f988:7c30 with SMTP id r25-20020a05683001d900b00698f9887c30mr3156638ota.2.1681190654568;
        Mon, 10 Apr 2023 22:24:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1ZyD/uTYCVLx4tYIF7obhSms66g3rjlqu9z003DbPezPPYRqzgDKer1skAg+fkXm6Q8CFSeHsXJF4/vGHx/I=
X-Received: by 2002:a05:6830:1d9:b0:698:f988:7c30 with SMTP id
 r25-20020a05683001d900b00698f9887c30mr3156634ota.2.1681190654349; Mon, 10 Apr
 2023 22:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 11 Apr 2023 13:24:03 +0800
Message-ID: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 9:39=E2=80=AFAM Angus Chen <angus.chen@jaguarmicro.=
com> wrote:
>
> We read the status of device after reset,
> It is not guaranteed that the device be reseted successfully.
> We can use a while loop to make sure that,like the modern device did.
> The spec is not request it ,but it work.

The only concern is if it's too late to do this.

Btw, any reason you want to have a legacy hardware implementation. It
will be very tricky to work correctly.

Thanks

>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/virtio/virtio_pci_legacy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_p=
ci_legacy.c
> index 2257f1b3d8ae..f2d241563e4f 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>   *  Michael S. Tsirkin <mst@redhat.com>
>   */
>
> +#include <linux/delay.h>
>  #include "linux/virtio_pci_legacy.h"
>  #include "virtio_pci_common.h"
>
> @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
>         vp_legacy_set_status(&vp_dev->ldev, 0);
>         /* Flush out the status write, and flush in device writes,
>          * including MSi-X interrupts, if any. */
> -       vp_legacy_get_status(&vp_dev->ldev);
> +       while (vp_legacy_get_status(&vp_dev->ldev))
> +               msleep(1);
>         /* Flush pending VQ/configuration callbacks. */
>         vp_synchronize_vectors(vdev);
>  }
> --
> 2.25.1
>

