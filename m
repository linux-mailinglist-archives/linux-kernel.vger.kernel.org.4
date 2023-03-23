Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641FF6C5CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCWC7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCWC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D2AE18C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679540299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0VvJoT/In9zXsTG4Y/WHrDmIvI8+3uyMcN0Vni7Bkk=;
        b=MR3wS8FkkIgsoZBelJcZaUDuJkwcw4vhyLNFZvBUYWVrq2PPaqOc9+lJbPbFdHRCUXNqOi
        sQqPogTTI4b+B99Ug8TZGNnBxjDm3N7S5dbtmZm1Z1fNxvFrnEpCI4Yc2mi6SDNL2wLUh3
        4/1GWbJj+D1ivhgFdgoaU5QzUUpd/Ik=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-fFEv3554P4iTN7DXJAWBKQ-1; Wed, 22 Mar 2023 22:58:17 -0400
X-MC-Unique: fFEv3554P4iTN7DXJAWBKQ-1
Received: by mail-oo1-f69.google.com with SMTP id d2-20020a4a5202000000b0053b5874f94aso2641640oob.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679540297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0VvJoT/In9zXsTG4Y/WHrDmIvI8+3uyMcN0Vni7Bkk=;
        b=nxabUZ68G9i3ADUC3b6l8Ugy0S86l5ngVULTWPOvlU5k7xkA08CaRD4gyYIgXPkelz
         zPQcCELAGgz6+h6mTTlDTuUvRljsAlGRVvNT2o/HU/e5Beg23KvnOBTVKmdOsgs/vH05
         fDPDtUWv1Gr+ZFqKhdwcLi3feA8IlSvSWVmrY0vmm7WNXRceCOK/TVbYQ+IhhMdZMDpv
         yHDoB2lIcxaOvK65pLzrP90BFhdl8cErotrSDGMUfvaBzjvlerGMcY6Zr70mMNebW9Zi
         UYAOmSWMv3Q6825C2PXl7wsn+xdV8kge3gXJrvXQpnJ589tDpq7eGAhcbovGvdN8iAED
         WLlg==
X-Gm-Message-State: AO0yUKU+IAzj5Eyl78rGCR44Yfr+IRJ0m3knsaPVmR36Tk3A2rYV8XmF
        oKQJTAO8E9264avnadG3f2lMEooeVTfYlxmiDlLpSj1lHOCa77HLDMqZ4UEpKPyIo+B5GVISnh0
        ioybty9yzoQQelzMe3589/0YelxH01Fj1Lgk12McGpaKA7yrT88nZjw==
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id t17-20020a9d66d1000000b0069f0bacaa8amr1815473otm.2.1679540296912;
        Wed, 22 Mar 2023 19:58:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set/BWrafeE27f5b5IZId0P5hAaqy+ikMd7Pl7UM4zZNHvprQ9rbOtFWqSmX8VPoPdPkZ143ngQ4DrCO+EBX4+4A=
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id
 t17-20020a9d66d1000000b0069f0bacaa8amr1815470otm.2.1679540296705; Wed, 22 Mar
 2023 19:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154228.182769-1-sgarzare@redhat.com> <20230321154228.182769-2-sgarzare@redhat.com>
In-Reply-To: <20230321154228.182769-2-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Mar 2023 10:58:05 +0800
Message-ID: <CACGkMEsZog+-CHDjc5gM-3FKZySvN_6xBK10dHD3ahoxB8S+yQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] vdpa: add bind_mm/unbind_mm callbacks
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        eperezma@redhat.com, netdev@vger.kernel.org, kvm@vger.kernel.org,
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

On Tue, Mar 21, 2023 at 11:42=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> These new optional callbacks is used to bind/unbind the device to
> a specific address space so the vDPA framework can use VA when
> these callbacks are implemented.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>
> Notes:
>     v2:
>     - removed `struct task_struct *owner` param (unused for now, maybe
>       useful to support cgroups) [Jason]
>     - add unbind_mm callback [Jason]
>
>  include/linux/vdpa.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 43f59ef10cc9..369c21394284 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -290,6 +290,14 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns pointer to structure device or er=
ror (NULL)
> + * @bind_mm:                   Bind the device to a specific address spa=
ce
> + *                             so the vDPA framework can use VA when thi=
s
> + *                             callback is implemented. (optional)
> + *                             @vdev: vdpa device
> + *                             @mm: address space to bind
> + * @unbind_mm:                 Unbind the device from the address space
> + *                             bound using the bind_mm callback. (option=
al)
> + *                             @vdev: vdpa device
>   * @free:                      Free resources that belongs to vDPA (opti=
onal)
>   *                             @vdev: vdpa device
>   */
> @@ -351,6 +359,8 @@ struct vdpa_config_ops {
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
>         struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 id=
x);
> +       int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
> +       void (*unbind_mm)(struct vdpa_device *vdev);
>
>         /* Free device resources */
>         void (*free)(struct vdpa_device *vdev);
> --
> 2.39.2
>

