Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33E5698A44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBPByW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:54:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48434F6A;
        Wed, 15 Feb 2023 17:54:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x40so949245lfu.12;
        Wed, 15 Feb 2023 17:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vNze0hSqMTOulzkDW+AgcocuJ1CwcBX4I3aIV+xtPE=;
        b=LoEjeutcoNuKHsVyF4i5Nae/iccAKk8ghnrWwVUmfL1oE5jDiGJw9JiX9ogg1OxfSf
         CriWHAXbI2zO32rpvVUJIqCYjK9bh32C+4iyOHRSpw42JaQBtHX0pZ2EBResYbbk1tuk
         29sPdq59KCVG2KYypJFN05FSyfTusYyUzsuoV1Im1UmZGpZ2ZYN6jGvzYAlNbucZZaBp
         YBW3/elLe8XV4F7dlLhnrdhL5MsvUAPPONFbaCBNmPCii43ALMdpFxTWJW1E7I1YVDBb
         5/QpQZ2JxIyOUvpb8yu49e7s+2WHkW4Iq5tE7GDuMWwAkfshid+DvftuMuMMjTLCvvGo
         cIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vNze0hSqMTOulzkDW+AgcocuJ1CwcBX4I3aIV+xtPE=;
        b=JqF1h+eFlJsQg9IwSATIh0qDIPtYeuj6pJ/dC3ZyD2NmegD6FIqc3gwBsoSECWbzqJ
         eQJtq8aqFsNCyf/oUzLwht728FmU6Q2UY3tl94BikHDFjeGUS0XUMwGFX33WK0RcHqk1
         pHNuY/REm7nZxX0QxfQV+5jTmwbM6nNt6HbgxoqPHyuA3dUPCdC0vvgTW/oLvhoDoZwp
         Ghw/HoXjO7xxPAwQQ9UD7Z0nIuRa61Qfp1SH5At4B/ib0wHKwkIEkVsdxz7KSL/5LBEq
         w7MM3NN1aIBa6jEVmj5XCWtUQV+xQ+f2Do15zZ5a7Xf3TxNf4tjkA/q2/Mx6fyXEJGh+
         qxHw==
X-Gm-Message-State: AO0yUKWZJhPNewhNMU+vpvaJKtx+S1FqcHG49c7JkL7eUXmCeUKLdL0x
        gs2SluHY740jBshz24oS2i815HkW8s7PNBIxFfY=
X-Google-Smtp-Source: AK7set/fQG1YN8qMvG/DwKXdEdqFq3wrCWzUnwHF6bC2UpZR0k5p212q0U3U+umy8tuux693yLJI+Fn+frBN8JnIvPE=
X-Received: by 2002:a19:c210:0:b0:4db:1aa4:fe02 with SMTP id
 l16-20020a19c210000000b004db1aa4fe02mr1193870lfc.1.1676512457571; Wed, 15 Feb
 2023 17:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20230216014120.3110-1-k1rh4.lee@gmail.com>
In-Reply-To: <20230216014120.3110-1-k1rh4.lee@gmail.com>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Thu, 16 Feb 2023 10:53:41 +0900
Message-ID: <CAJkuJRjzS6LnsvxO2mhmLVje51YEJhC0r-T6NxsuL9BaiW1hSQ@mail.gmail.com>
Subject: Re: [PATCH] misc: fastrpc: Fix a Use after-free-bug by race condition
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I'm not an expert for the fastrpc driver, I'm not sure about the patch c=
ode.
But I think the bug should be patched.
Please suggest a proper patch.

Best regards,

2023=EB=85=84 2=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:41, =
Sangsup Lee <k1rh4.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> This patch adds mutex_lock for fixing an Use-after-free bug.
> fastrpc_req_munmap_impl can be called concurrently in multi-threded envir=
onments.
> The buf which is allocated by list_for_each_safe can be used after anothe=
r thread frees it.
>
> Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5310606113fe..c4b5fa4a50a6 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1806,10 +1806,12 @@ static int fastrpc_req_munmap(struct fastrpc_user=
 *fl, char __user *argp)
>         struct fastrpc_buf *buf =3D NULL, *iter, *b;
>         struct fastrpc_req_munmap req;
>         struct device *dev =3D fl->sctx->dev;
> +       int err;
>
>         if (copy_from_user(&req, argp, sizeof(req)))
>                 return -EFAULT;
>
> +       mutex_lock(&fl->mutex);
>         spin_lock(&fl->lock);
>         list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>                 if ((iter->raddr =3D=3D req.vaddrout) && (iter->size =3D=
=3D req.size)) {
> @@ -1822,10 +1824,13 @@ static int fastrpc_req_munmap(struct fastrpc_user=
 *fl, char __user *argp)
>         if (!buf) {
>                 dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in l=
ist\n",
>                         req.vaddrout, req.size);
> +               mutex_unlock(&fl->mutex);
>                 return -EINVAL;
>         }
>
> -       return fastrpc_req_munmap_impl(fl, buf);
> +       err =3D fastrpc_req_munmap_impl(fl, buf);
> +       mutex_unlock(&fl->mutex);
> +       return err;
>  }
>
>  static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
> --
> 2.25.1
>
