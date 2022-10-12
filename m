Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038455FBF68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJLDIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJLDIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336A4E42F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665544082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgOum/UDHehE92DZqDcEw12xZnODZkBr1fs6UDB1a+M=;
        b=AWdkE3uW79tbTItKP1QAuSKE5Y9dAler3GwEuzPkx++1A0Ja2eRJlqK4sssV4jjUygRYba
        Diy2mIBnWUBII8q/XqX9zpwm07k+8BGTf7kJdSfmfVcYBbjPPiW8nMRbiDN3/3taz13ZR7
        5kecsv1QHKUwAr97OgvuQJhHeGuO3TE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-ygcMdfh1NEa4gLyU8wGFag-1; Tue, 11 Oct 2022 23:08:01 -0400
X-MC-Unique: ygcMdfh1NEa4gLyU8wGFag-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1321b118ba0so7786011fac.19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgOum/UDHehE92DZqDcEw12xZnODZkBr1fs6UDB1a+M=;
        b=hWkI2qEncKxCqC/r6hGYT9fBXO+dUKxCuBIqO8RDb/z4NkslEbFtw2TdlAnPngTSme
         zPqTQg6+zPHgI6Ub3H4K8TWZkn+Kigr11/4YsO/K821f0FTRJHgjqf80oz7wFxAD/wJ6
         T5qXWWDfJxEg7z1kpbWSuTJ39ZfgpFudtv7ttHvAp20EoLEGBqIWJ6kueXtVWF6MROa9
         trRo1ysXkR7IE/yaSoRGJVJe1SJIlX0Vy8OSv0Zr/nBBfm5XycVKZqsfxxGsLXn4meU9
         H7QPL13v2tzDqV9UQcLzeRngh66DCYPTncb0ceBJTpf5XkQKibNPb2/lcKMpUAKBId3f
         1rkA==
X-Gm-Message-State: ACrzQf0k6Mhi/WlwCXz9+fBJc/465kFzxb1v2L0UictmUpMryudMZPcM
        REQ1gG1cjczIxQPNAm4xskhmnipcj0pULLhZq7aQeCp8yG09NesXdMXOzmeU1N57XIanPJFSFp7
        eXNz3FyiN2qLJsdVlzR1pMiLabHnxD0/xfbQ/yWGt
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id eo40-20020a056870eca800b00132df465c66mr1228133oab.280.1665544079553;
        Tue, 11 Oct 2022 20:07:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5dq66SvAlxf7mu4Q2w0EN+PHpuAQh+ivBrOwjxijz5lSw6LuA0SVDb5dfCsMPUvQ3ntliZotjYUlqEkWxvsXY=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr1228128oab.280.1665544079369; Tue, 11
 Oct 2022 20:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 Oct 2022 11:07:48 +0800
Message-ID: <CACGkMEvpApmF6TFVi8jD-YTYTcYN=zUyvrsxHL8Rts6vQC9EAQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: merge functionally duplicated dev_features attributes
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 2:32 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> We can merge VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES with
> VDPA_ATTR_DEV_FEATURES which is functionally equivalent.
> While at it, tweak the comment in header file to make
> user provioned device features distinguished from those
> supported by the parent mgmtdev device: the former of
> which can be inherited as a whole from the latter, or
> can be a subset of the latter if explicitly specified.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c       | 2 +-
>  include/uapi/linux/vdpa.h | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index febdc99..41ed563 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -855,7 +855,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>
>         features_device = vdev->config->get_device_features(vdev);
>
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 9bd7923..54b649a 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -53,11 +53,9 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>         VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>
> +       /* virtio features that are provisioned to the vDPA device */
>         VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>
> -       /* virtio features that are supported by the vDPA device */
> -       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
> -
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 1.8.3.1
>

