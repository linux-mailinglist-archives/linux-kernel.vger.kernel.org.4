Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2239736773
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjFTJPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFTJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CD1FE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAVkAXb8ZdoRS9PdEG1Q3OrXjJSIDKD/SmD3bUVe+po=;
        b=PA5jh2zvf5Dc4UgWRoscDwY92Wqgi34mhgaUXTfyhWilSXhwdCV4VawRAuBJm4mRWd7IEn
        HFq6HSHoZYWgLLHz92WIeCSj0ZBf+aWoYILI9Lod2xeMd604gA+pBbHnhWjH5854Qk0CU1
        KamezKyhnXZmklZFVAgRPKqf/UQubpE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Kd1QOt4vPRay7Cbs8U4lOQ-1; Tue, 20 Jun 2023 05:13:26 -0400
X-MC-Unique: Kd1QOt4vPRay7Cbs8U4lOQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25e8ef41a00so3580634a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252405; x=1689844405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAVkAXb8ZdoRS9PdEG1Q3OrXjJSIDKD/SmD3bUVe+po=;
        b=gxKDkswNKCTNqcJUBpZbAjcLhroIRw9+VeiEv2OgGk6sh2BR5v59wQMMIM4abagz1S
         itMxNCMaWg/oJ+tFnqHRemTMIiogablG0KQEUNTntKRDZ7gIsiHxK8v4Ulv9CeGlsV7N
         U2N7yTqMIIyZnq5v1CRdCAgslNmlSDYRFZD6sAHWAHgiQ8hb6iDVgaXsqFL61cgKgb1T
         yQUCqdOLeFwluBI2H7mu5ZcRgsVuX602Dn5sjFT9ZyJ9IFtnal12ctQx4FNfITlb+I1+
         mT3Uyo3RnrudUjUskTlePZDvhtSmV5UtGk4fEqTn5Qp2rUUB1Qfj//fwmzbBwIeeg7Ce
         rskw==
X-Gm-Message-State: AC+VfDzWXSkMQ/nsdkKn0FZY074GQtx9Zx1/iTbXranNhFjPCi+JCVxZ
        Nsch86AFQNA2/xuN2OSjB9Q3qSAOx1XI1Zxb7KCZaNft6NYlVzR6XxKMUOhnmGPAT9lD/JuA86H
        adwW65yBlWLvBPk7Qh5nJLelJ7pjjt94uR8KPirOs
X-Received: by 2002:a17:90a:7064:b0:25e:2db8:cc5f with SMTP id f91-20020a17090a706400b0025e2db8cc5fmr12181222pjk.40.1687252405670;
        Tue, 20 Jun 2023 02:13:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zyp0Fo1BsQtG2HUOps6dAU73J5PL1i+1AcHvwya2p2QUZiJlzTP9D9QVWsqaLxZx1/g1L9jfFZpQbmAUpLBo=
X-Received: by 2002:a17:90a:7064:b0:25e:2db8:cc5f with SMTP id
 f91-20020a17090a706400b0025e2db8cc5fmr12181209pjk.40.1687252405456; Tue, 20
 Jun 2023 02:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-9-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-9-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 17:13:14 +0800
Message-ID: <CALTww28zutAQp_fv-H5aFRH2Jtv7+WTiedtjTO1NpmfGnVg1YA@mail.gmail.com>
Subject: Re: [PATCH -next 8/8] md/md-faulty: enable io accounting
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 8:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> use md_account_bio() to enable io accounting, also make sure
> mddev_suspend() will wait for all io to be done.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-faulty.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/md/md-faulty.c b/drivers/md/md-faulty.c
> index 50ad818978a4..a039e8e20f55 100644
> --- a/drivers/md/md-faulty.c
> +++ b/drivers/md/md-faulty.c
> @@ -204,6 +204,8 @@ static bool faulty_make_request(struct mddev *mddev, =
struct bio *bio)
>                         failit =3D 1;
>                 }
>         }
> +
> +       md_account_bio(mddev, &bio);
>         if (failit) {
>                 struct bio *b =3D bio_alloc_clone(conf->rdev->bdev, bio, =
GFP_NOIO,
>                                                 &mddev->bio_set);
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

