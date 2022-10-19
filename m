Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE4604083
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiJSKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiJSJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B811A96E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666172106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+TyF7PNH8EB0gGdWhZWNT7enwe2PDt7WQr2gXMuwD0=;
        b=HKnwd2ph/8LfRn+HWhbiPil2tVt0om+Kdwt/jLk4xc2XYY4eTQ3qav9ARiB9el0zyNs/L/
        pRRJXaUzLWLRh1TOPn60bAZ9DJSu6xRShh09ZjT65nDgoKc2b9R0Tw+tpzrjeyIqYiZEZ5
        hJt2repC0VjISVLKgDjH9RiNd59vCJo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-V_PiXrY6PUa8tu8nuLP9ew-1; Wed, 19 Oct 2022 05:31:52 -0400
X-MC-Unique: V_PiXrY6PUa8tu8nuLP9ew-1
Received: by mail-pl1-f198.google.com with SMTP id b14-20020a170902d50e00b001854f631c4eso6127057plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+TyF7PNH8EB0gGdWhZWNT7enwe2PDt7WQr2gXMuwD0=;
        b=M8qAjigAB26LP19QNukjCdpQ2xjWzzUny8KR9/QhljMNNMosMuOfyYc8NVKC9hXTOw
         HxbfDRna8JOAH8CKbCx0uTJpZlWn6jX3WNmQAl9Mdva/uj6vSS6AA3/M8pf6zHrEBT5q
         4k9LV/xs4XCRBS1Q4nJMbrfDy7eNI0e4rCo6p/4qzKdQ9Xo57t9lPErq9zPGz1c+43N7
         n73yw7vGuR7P4kINo76fmLs9Do4HeEpSXjLDT4wpZZusv1lpXnRqOOgJZ9cIzZlqObQw
         IoNZKmRQ8Nfza7z3uplmdzmnt4+/U4y3yDVnQT4MEf36uHw3hEh9qiKMzEHKBmENTtlv
         TO9w==
X-Gm-Message-State: ACrzQf3bxs+CHF/sXxxR2TnLvmA/3/R+nBKKKgo4bPa1fIOvQb2y4lPG
        o5E+9VME8as1IZXYtZLT0XeoG+iOAxQAwyht6pSdZfR+iyOnE7TE0PReBGnNtan9gRQHYBDhyF3
        SsXqwFc2sJZtDaLiIqzVLJGQhz7cBw6jAlVGnjS9Z
X-Received: by 2002:a17:903:2585:b0:185:483e:e4ce with SMTP id jb5-20020a170903258500b00185483ee4cemr7360967plb.17.1666171911537;
        Wed, 19 Oct 2022 02:31:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56luafnwZQEi9GpQyPokUf92iOHlSzmSs19PT41u8H0lTV8lCiXBqpGPGXONjNZIUMJkPvXMwV0WzMOWYxVbA=
X-Received: by 2002:a17:903:2585:b0:185:483e:e4ce with SMTP id
 jb5-20020a170903258500b00185483ee4cemr7360946plb.17.1666171911232; Wed, 19
 Oct 2022 02:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666082013.git.sebastien.boeuf@intel.com> <56c045ac70e44e7d80f3f9e901deae3d7485b2a1.1666082013.git.sebastien.boeuf@intel.com>
In-Reply-To: <56c045ac70e44e7d80f3f9e901deae3d7485b2a1.1666082013.git.sebastien.boeuf@intel.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 19 Oct 2022 11:31:14 +0200
Message-ID: <CAJaqyWdePmapASK060=k+LvqHJHWppMApcQ65N2=THfuCmbjkw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vdpa_sim: Implement resume vdpa op
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:38 AM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..05e3802fb746 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -527,6 +527,18 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
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
> +       spin_unlock(&vdpasim->lock);
> +
> +       return 0;
> +}
> +

To never kick at resuming is not the right thing to do :).

Maybe to store in the vdpasim_virtqueue if it was kicked during the
suspend window?

Thanks!



>  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -717,6 +729,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +763,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
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

