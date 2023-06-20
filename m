Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33FE73676B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFTJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFTJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E0D1FDE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+DstClbbuIYoLgiuHR0ngP8+VmdOxHjqeCjdjYlEa0=;
        b=YX9MDgCOIsE7cMjKzIwx4EUV/E+VmSf0IdlAiR1OcDNCLbx9f0NLEJEkc+3azOk/NsB6Td
        W+1/i8NXgkaK8SnyA/kp0PBbnCwTfHGbM7SQZQymWb2lYinsa5s5Pi2dd4Np3spQyAfVC0
        3uxAhoPy078ReGbzkSL3YEm1/n9aZ74=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-7amf2Pi_OLqUNYbrrM7uXw-1; Tue, 20 Jun 2023 05:12:26 -0400
X-MC-Unique: 7amf2Pi_OLqUNYbrrM7uXw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-25f02317e40so1679634a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252345; x=1689844345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+DstClbbuIYoLgiuHR0ngP8+VmdOxHjqeCjdjYlEa0=;
        b=Cro8g/D5A9+c0jRp3DnpIjzNXDh6k9gbWUGpgLrjIZXeA+k6sKxv5MdZ8bTIDGDEqY
         EGi5dHkOV+zPmxsodlyXLPDTIBJJGmcA2wSuBGmBdEuph4ds9fivjU4yp5/9n+m+wRzJ
         D0geIwfVF9RpsMhSmTK4ABdNIM4aj7CiT5hjt3qdQxNOrT2cDVQHorgSpM2p3rCU1tbZ
         IaNORGfbhzd9LLpWoHzdQNsb6kEjTqg53DRStL/14OkkRFa/yu7ghnv+lgWEgNeJLoxu
         +9glxW7hx8sNW1y69nnjXLIYHtfCgyReaAOnf8obpa890M1o3hyD1DAKr8UJ8Hr9twA8
         n+Iw==
X-Gm-Message-State: AC+VfDz1lrjAzV+pqoLlPj3XRDmhglinfcKMi1dnira7yzq1FMAYk1Do
        4oBfQMntnwrmHi74/viuwUBuJKLjnD1hy/3CFnlX4cBuMifkyS8aL3cGqikllnFhDOrIWSfG/O9
        pSaSK8CbFB/hxM4WngcZdx1j16t7CmLCaE9Bb/HwV
X-Received: by 2002:a17:90a:38a1:b0:25e:886b:c6b with SMTP id x30-20020a17090a38a100b0025e886b0c6bmr10183567pjb.48.1687252345441;
        Tue, 20 Jun 2023 02:12:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yf4FPi/w3rtXTM9KFhnWJaEmjdafqvs3GuqucUyaXBBPbxjvZ8esvPhO3pQcCESORqo2VmW2rh9OP3FsbCMQ=
X-Received: by 2002:a17:90a:38a1:b0:25e:886b:c6b with SMTP id
 x30-20020a17090a38a100b0025e886b0c6bmr10183561pjb.48.1687252345241; Tue, 20
 Jun 2023 02:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-8-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-8-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 17:12:14 +0800
Message-ID: <CALTww2-_CTY3b9L1OYz0yJUBtNJPmANmw1-RWpDhEQgKCbhewQ@mail.gmail.com>
Subject: Re: [PATCH -next 7/8] md/md-linear: enable io accounting
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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
>  drivers/md/md-linear.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 4eb72b9dd933..71ac99646827 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -238,6 +238,7 @@ static bool linear_make_request(struct mddev *mddev, =
struct bio *bio)
>                 bio =3D split;
>         }
>
> +       md_account_bio(mddev, &bio);
>         bio_set_dev(bio, tmp_dev->rdev->bdev);
>         bio->bi_iter.bi_sector =3D bio->bi_iter.bi_sector -
>                 start_sector + data_offset;
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

