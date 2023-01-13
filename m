Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FC668A50
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjAMDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAMDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36157926
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673581267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQ8wi4Br7uO3KhWWeSVPWRGqxXRNQdNc7vx+DzPAcvk=;
        b=cLsloOEdpLHULXtk/dBWM9SktYBhgByrxa/0/bNXSNbQJb3yIMgv9uBXAU5qCIB13B7jEf
        LG4mAAA30ERVqAIFlXvrmq/Q5LX4UNOd2Cu850BVM5xSfegrmZNDIkvRetC1MxXAxpbXlX
        GvVv2kr25o9o0NXmRvUD+QNvWv+/VUI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-DaX944MFOMGbNOujqZE3BQ-1; Thu, 12 Jan 2023 22:41:06 -0500
X-MC-Unique: DaX944MFOMGbNOujqZE3BQ-1
Received: by mail-ot1-f69.google.com with SMTP id e15-20020a0568301e4f00b006783b3a27c3so9942006otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ8wi4Br7uO3KhWWeSVPWRGqxXRNQdNc7vx+DzPAcvk=;
        b=Qd6W7cGfrEF6Qux86x5Z9W2N8SvuSnO02IEmrMzjTGtYRtyzZ7a1sgh0Pglz3RwNwt
         vyj1xSs2R69+pqLrAPru8HK352xerObF5WI/TqDdnsH1gZseLstvqEifbRzMYoYzSpi8
         boh6asjp2987hYTvgZTZoiiaE5E2YEcGiA/lUZ9XHm0dWslsizwuS6LxOi4eLsdXoODK
         XUiuQJEphkwn+Al3iGeJQi9GJpIe5QPx/2DSI23i8iy1aiTlgcR8HbJGzCBherfE2+j2
         BedYVO6iOxJaV4+ieq94pCFHN2wU8ito3Z1unJEBbj9VGHf0Se1TW6QSW10Ut+/1Mvfw
         AcYQ==
X-Gm-Message-State: AFqh2kqOTZroFHejuH3OUbor+4r1w0qklX/1sIZgFDF97GeQX+RE5IDw
        7KC3eVI5Zyhpc5I0YDtyYhZynef8LM5SUOFOTB/SA53MGtv6nmj27TJGVVmQEPtwdnvYUqVlMNa
        37ASinw24tfBlhI6eeUgkEzi2G53elQf6j4kWkBYc
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id u19-20020a056870441300b00144a97b1ae2mr4410757oah.35.1673581265454;
        Thu, 12 Jan 2023 19:41:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsF+gJUbjz/TTiPs9CWR0x7xWMlld1YGa7Vm9251XsEtRPdbMJjqMpS4KIad2giINIz1682V0KhtLR/ewFMee4=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr4410753oah.35.1673581265229; Thu, 12
 Jan 2023 19:41:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672742878.git.sebastien.boeuf@intel.com> <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
In-Reply-To: <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 13 Jan 2023 11:40:54 +0800
Message-ID: <CACGkMEueTbLbxtZCBXC3jyqn40nqU4ODgAfzG=GzOLeMjnNwPg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] vdpa_sim: Implement resume vdpa op
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 6:51 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..756a5db0109c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,6 +357,12 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> +       if (!vdpasim->running &&
> +           (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               vdpasim->pending_kick = true;
> +               return;
> +       }
> +
>         if (vq->ready)
>                 schedule_work(&vdpasim->work);
>  }
> @@ -527,6 +533,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         return 0;
>  }
>
> +static int vdpasim_resume(struct vdpa_device *vdpa)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       int i;
> +
> +       spin_lock(&vdpasim->lock);
> +       vdpasim->running = true;
> +
> +       if (vdpasim->pending_kick) {
> +               /* Process pending descriptors */
> +               for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
> +                       vdpasim_kick_vq(vdpa, i);
> +
> +               vdpasim->pending_kick = false;
> +       }
> +
> +       spin_unlock(&vdpasim->lock);
> +
> +       return 0;
> +}
> +
>  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -717,6 +744,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +778,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..a745605589e2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -67,6 +67,7 @@ struct vdpasim {
>         u64 features;
>         u32 groups;
>         bool running;
> +       bool pending_kick;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
>  };
> --
> 2.37.2
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

