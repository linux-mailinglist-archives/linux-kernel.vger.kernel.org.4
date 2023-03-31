Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA436D1BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCaJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCaJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696840CF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680254150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpBwJNhntZe6FD93wLKDtIdc8Lkqkr2A8dw0SyVmm8A=;
        b=cKBL36liGchPHqomUFxLYtGIP/nybcP7cP2iF1GSC9prCPzKzHdQ2pn06QtlCWIYk6+ENh
        q8SqGYXw3ooqvR/Y2KEBCY4xb2seiWGzqOMz8zN48bHxzBiCMOLJ3+I2cyy9X1ax7p7yaz
        YNBoCvf3tLygKVsaVvU0cUtSm361114=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ONUtGfeDOD2XCJNYEjvJXQ-1; Fri, 31 Mar 2023 05:15:49 -0400
X-MC-Unique: ONUtGfeDOD2XCJNYEjvJXQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-177c2fb86b7so11241559fac.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680254148; x=1682846148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpBwJNhntZe6FD93wLKDtIdc8Lkqkr2A8dw0SyVmm8A=;
        b=jLi3TBs4SZxYBoNRg2MwIIMRuPLge8mM/Zzxau+I+V4fREwFetyCjvWetR4n1h+enF
         n1+j9iEuKMFZAd/mtnIAWUjrJfMZu88XTlBfMYg9cvTducpBg+S3j+jCblUpI8cZ3Rka
         ZPhANmMFCKQQVAteEeTBmZJwtmS7E07Rb3GZWGPhoytPR+K8y+UFPtc1pB2OxhH2jdHr
         IygKGYNi2ZwFQsjQCPzmz6BVl51+Do1kZTf6e8Vju0GpaeMfuCeZ54oXu0OpiAD351W4
         LEiDd/cmZZbw8kbf7VDsasJqiKuJ/k9+iqeNmGG+2HZVupIDo0F2zO6UjF2gT7yuP2Ef
         w1+g==
X-Gm-Message-State: AAQBX9f3psZdK5iMal+a8ZLY8LWN7pugitln94Jc814fJlVZDIMzNLEk
        FfStVc+nVhJN69hlkroCy5EzNk4OLXRdK1ww73NzB/vWzye6JfgLMg201JkkmSyzfvIs7sXmGz/
        sm1boeH1A+u7ZZ46jbfZ3l+FOQMIdukYTaJn9rFuC
X-Received: by 2002:a05:6830:119:b0:69f:15f4:aa8 with SMTP id i25-20020a056830011900b0069f15f40aa8mr2912057otp.0.1680254148655;
        Fri, 31 Mar 2023 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350au0t5wmkRH4+94dmbo4lZGEFFNChh74aKhB9ea6YK9dFKBXZt8OcEd3YmdzM4pRCxTfdprrA7hujgUD9BK6aI=
X-Received: by 2002:a05:6830:119:b0:69f:15f4:aa8 with SMTP id
 i25-20020a056830011900b0069f15f40aa8mr2912054otp.0.1680254148451; Fri, 31 Mar
 2023 02:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080208.17002-1-sgarzare@redhat.com>
In-Reply-To: <20230331080208.17002-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 31 Mar 2023 17:15:37 +0800
Message-ID: <CACGkMEvjLWY39jb4LR_nMaB9cBoPYOKmtpuuN8XwB6pA+zBL7w@mail.gmail.com>
Subject: Re: [PATCH] vringh: fix typos in the vringh_init_* documentation
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
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

On Fri, Mar 31, 2023 at 4:02=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Replace `userpace` with `userspace`.
>
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vringh.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index a1e27da54481..694462ba3242 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -636,9 +636,9 @@ static inline int xfer_to_user(const struct vringh *v=
rh,
>   * @features: the feature bits for this ring.
>   * @num: the number of elements.
>   * @weak_barriers: true if we only need memory barriers, not I/O.
> - * @desc: the userpace descriptor pointer.
> - * @avail: the userpace avail pointer.
> - * @used: the userpace used pointer.
> + * @desc: the userspace descriptor pointer.
> + * @avail: the userspace avail pointer.
> + * @used: the userspace used pointer.
>   *
>   * Returns an error if num is invalid: you should check pointers
>   * yourself!
> @@ -911,9 +911,9 @@ static inline int kern_xfer(const struct vringh *vrh,=
 void *dst,
>   * @features: the feature bits for this ring.
>   * @num: the number of elements.
>   * @weak_barriers: true if we only need memory barriers, not I/O.
> - * @desc: the userpace descriptor pointer.
> - * @avail: the userpace avail pointer.
> - * @used: the userpace used pointer.
> + * @desc: the userspace descriptor pointer.
> + * @avail: the userspace avail pointer.
> + * @used: the userspace used pointer.
>   *
>   * Returns an error if num is invalid.
>   */
> @@ -1306,9 +1306,9 @@ static inline int putused_iotlb(const struct vringh=
 *vrh,
>   * @features: the feature bits for this ring.
>   * @num: the number of elements.
>   * @weak_barriers: true if we only need memory barriers, not I/O.
> - * @desc: the userpace descriptor pointer.
> - * @avail: the userpace avail pointer.
> - * @used: the userpace used pointer.
> + * @desc: the userspace descriptor pointer.
> + * @avail: the userspace avail pointer.
> + * @used: the userspace used pointer.
>   *
>   * Returns an error if num is invalid.
>   */
> --
> 2.39.2
>

