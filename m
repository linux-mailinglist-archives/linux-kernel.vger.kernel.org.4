Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB12740875
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjF1Cfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjF1Cfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B211D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687919693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
        b=FyJRXVld5I5+uXYoEtLfG6DQORu8CrVXHXoB57U0/drYN7uKv6surbh7pTMZRnhndGmf57
        qTQQbhJX2UUia0Pcr7SfpnRX0Y57gK+64arj90ztI2DczQIvLulNpgR6cYTfs+hSpF8BZg
        BhakAyWVSoSKiabZucWPIu5o01EKkPQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-b_T6q1koOx2oQGg7YpDlHQ-1; Tue, 27 Jun 2023 22:34:51 -0400
X-MC-Unique: b_T6q1koOx2oQGg7YpDlHQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb7d06a7e6so2165230e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687919690; x=1690511690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
        b=J2IAzwBvd8cu0UMG30VPQkWXBdPqBOMWqDpn8f1L5ISgRWexXgK3L3tKC1SaZM0MBv
         qpgEY3uvH4EJTchWHWq5XSLy5DU2gJj+B7YWDxKk1SIHFqCWwMgizHXc0OhVb6Cl+mk1
         S+bMkP0vWSwwDITNodpEt0aXJJksQVeCuQ1r0A25a+fVPiqN0Co5lN4QE0EBiwSkqFVy
         Li+qwjYfo7pq4naRf5lXr9bhc3mK6ww9+H/6N8U9V8WoUQUvQPBnZwBhhozvXJPjjldA
         +eopGj34V81x5TwEc4ifpmygGgPP0acEjw2ilD0XAv0eSYDiOi7EPtZf77GDOt1eH9oA
         u8yA==
X-Gm-Message-State: AC+VfDyUmoqW4BVs0vwKeExNbteCVR52hTvWwusq5Y0QxuUomfH9IAih
        kg1qQ17Y/HQ6M1hiWiZCN72AcPF0n+qhNl/LIbwYzrT1rTujP7we0hAEGO1D3bXXJn+Ng/8SZrK
        JTESC8qBFEbTLL9zWLA8BWERVBn9nGs9ijwpTX/xIcmpS+y9X9a4pbg==
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id t20-20020a192d54000000b004f85e5fb368mr17437563lft.21.1687919689997;
        Tue, 27 Jun 2023 19:34:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TOdyFneufgIE6Aita5S8TSfhtJ7h2l/bao4uqZmEfdB72MMgC1AzLUSdBVAFlaWW6dl2nrE5KtoGWh4spOKE=
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr17437556lft.21.1687919689714; Tue, 27
 Jun 2023 19:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-2-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 10:34:38 +0800
Message-ID: <CACGkMEveEcB5LsQBSc7kf7JEwDfX3-dc38+6sh7tu_wryROpRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vduse: validate block features only with block devices
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com,
        lulu@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 5f5c21674fdc..c1c2f4c711ae 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1658,13 +1658,14 @@ static bool device_is_allowed(u32 device_id)
>         return false;
>  }
>
> -static bool features_is_valid(u64 features)
> +static bool features_is_valid(struct vduse_dev_config *config)
>  {
> -       if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> +       if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>                 return false;
>
>         /* Now we only support read-only configuration space */
> -       if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
> +       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> +                       (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
>
>         return true;
> @@ -1691,7 +1692,7 @@ static bool vduse_validate_config(struct vduse_dev_=
config *config)
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> -       if (!features_is_valid(config->features))
> +       if (!features_is_valid(config))
>                 return false;
>
>         return true;
> --
> 2.41.0
>

