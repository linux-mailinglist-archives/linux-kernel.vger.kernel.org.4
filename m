Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5523E736744
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFTJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFTJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67B1988
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+0GtW6bkdqCBjUlS06id9SCgWtcNWaYm4T3cD/2Dtk=;
        b=TRQRW9XZg/v0ig+W00lRYKfWeJZ35XMZlngrgRCwTvf4n0MiYumhMFmRf6c7ftC7jhmXuF
        ujuEssRAU/5cjfsVvul2Y11huvAPSdprc4sb4sEIrOi/VREaNzF529jeO+CrmUK3VfKqQH
        w8Y4i9XNQrvQqaL4MsX7mU5KH+Ks1oI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-h6NCtdCdPZSnGd3wOLkPFA-1; Tue, 20 Jun 2023 05:11:21 -0400
X-MC-Unique: h6NCtdCdPZSnGd3wOLkPFA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25e8ef41a00so3579401a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252280; x=1689844280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+0GtW6bkdqCBjUlS06id9SCgWtcNWaYm4T3cD/2Dtk=;
        b=CMT8gDxhQMkG1w9tA/u/D4Cpw1sC4YrUPkeK4AnLWTF6gS/S8MagzIFI0LsUQ3SpVT
         nrvG5SZ1GKbJeLDGfsyRFLm2jHekrFenee68sLeZ+V8ZA8jux+l3BOibovk5/afmLI3K
         7cm4CKWgX1wcIlPX5p40d4OzpiGoofSARXXv1pkl29O83dpEkAwFCTD0OC9gTBfzsx2H
         oLrh/dqXqY/BiDzDUTRPHXW73XuCEDXQ4RAa00+1ZUK8f0MfZRgQiSFDBTLNAGMsqBkY
         hcbmTphFq7a+emlm+VzQ/zQ8LQtgJ0bu5lH88ASb47X7WccmNtGvJnLcNOMRl/+IqI9M
         9PgA==
X-Gm-Message-State: AC+VfDyU0FmHKlhCpnHOoOLnNV0hlu5Oy53iINIOh/uL11VtGWpTmZs0
        WxECsEAnclpe0V/SaQWpcBdX4HEGytrcipd4qRRn7LR/R48SOl9MdETD8d1TA2tO8QEOZQiYY83
        ZcGt0khqqZPR1++MNAl1lycGsIhSskjf1BepWRnA+
X-Received: by 2002:a17:90b:3881:b0:25e:f133:41cb with SMTP id mu1-20020a17090b388100b0025ef13341cbmr7009741pjb.21.1687252280306;
        Tue, 20 Jun 2023 02:11:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sTmxyYbOXmiA8R0BgDeuOvK102mmYMt5VKcJc9LRl61g7stUC75HbUqF8IzElkXAczAB7dW/d3gEY+4rctN0=
X-Received: by 2002:a17:90b:3881:b0:25e:f133:41cb with SMTP id
 mu1-20020a17090b388100b0025ef13341cbmr7009734pjb.21.1687252280079; Tue, 20
 Jun 2023 02:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-7-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-7-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 17:11:09 +0800
Message-ID: <CALTww28Ezy4NRvyYP7FOfcin7msGn8sr00HQFpfOEFsPyh8Asg@mail.gmail.com>
Subject: Re: [PATCH -next 6/8] md/md-multipath: enable io accounting
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
>  drivers/md/md-multipath.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index 92c45be203d7..d22276870283 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -107,6 +107,7 @@ static bool multipath_make_request(struct mddev *mdde=
v, struct bio * bio)
>             && md_flush_request(mddev, bio))
>                 return true;
>
> +       md_account_bio(mddev, &bio);
>         mp_bh =3D mempool_alloc(&conf->pool, GFP_NOIO);
>
>         mp_bh->master_bio =3D bio;
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

