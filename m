Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30061EC5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKGHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKGHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D6D2DE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667807048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOakKuOc5QKaCrlWc07vXO968J4uiDQ2dBwbOnh8eLM=;
        b=giJIPddU9tGdIUZwvyby/vcEHaZ7AjCTeoiOcC6LgaPkhyZVZ3nnVgMpLMPQ7QmMB5Cbrc
        NkcdErDd78562WcIzRc0GrfOKKwW2NJf+D6Od4zSAFrd7hiSsfKLgTJdFudoUKyJAEVR9E
        YDqtzkWnCFN+bMwz1hvMFxa/eY5vGxY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-0Nbr9sceMBG_fxGcZ_DIKA-1; Mon, 07 Nov 2022 02:44:07 -0500
X-MC-Unique: 0Nbr9sceMBG_fxGcZ_DIKA-1
Received: by mail-oo1-f70.google.com with SMTP id x18-20020a4a9b92000000b004805dc803c3so2552490ooj.16
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOakKuOc5QKaCrlWc07vXO968J4uiDQ2dBwbOnh8eLM=;
        b=YiPSnEE8iMoFp6mMgUIwa8E2jYVj83Hpwf8EZrRKd+dsO9YU8Sv/mSlYsjWNr60ukQ
         UGHqjQz4tjOWvnOqqPIBqg8CE/zTkcl6tb/i9WF+YBA2xyB9B+r9E33nUAXSzeuhsgoT
         h6xJazcV0nfv6G1yHn0UXUzoRHjJxQEqV5xB63Hlmd8NVhkxyjEzvFSCGbKQWssRCR9c
         KHzK54RgV3tk6FrxUS88G9J1bR3zGhjLD2GtIpu3pm6eMlilklXE6w9qaCR8OL3uMoGO
         Hkt7wBaTOUqopUKiBDvUL/HoUIPDq459VQaFwW4TVSPsdxsh9wPcz8BxzHWRMAFj7gLR
         IBvg==
X-Gm-Message-State: ACrzQf3vF3e9W/snThhRxmj2PwAkXoO/dSxs8+WGorttJn0tWlvS3PHm
        BwA0SgzlTdjgclrR0yYUtdSMw64qxAnzC71jcUk4It73SIzLCPQCxmKjpLW2xZiiGjbo9OXbcK8
        YwGXMOLqG0WgK1Rr4sJZzF4V2cRtODf76cpXmzoVR
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id bh30-20020a056808181e00b0035a59595909mr9461205oib.35.1667807046577;
        Sun, 06 Nov 2022 23:44:06 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4N4jUfu9pMYeA80Eddf3Hun8DW8URGbJXrQnAHwv6j7MUq23+WDOdMNbHNlB6W/+EqKmTNSP64CeIhwDv3++Q=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr9461192oib.35.1667807046341; Sun, 06
 Nov 2022 23:44:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1666796792.git.sebastien.boeuf@intel.com> <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
In-Reply-To: <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 7 Nov 2022 15:43:54 +0800
Message-ID: <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
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

On Wed, Oct 26, 2022 at 11:09 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..84fee8bb2929 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> +       if (!vdpasim->running) {
> +               vdpasim->pending_kick = true;
> +               return;

I think we may hit here when the driver kicks vq before DRIVER_OK. Do
we need to check device status in this case and resume?

Thanks

> +       }
> +
>         if (vq->ready)
>                 schedule_work(&vdpasim->work);
>  }
> @@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
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
> @@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
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
> 2.34.1
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

