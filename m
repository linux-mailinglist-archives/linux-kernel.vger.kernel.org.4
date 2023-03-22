Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414696C4013
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCVCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCVCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:00:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234574DBCE;
        Tue, 21 Mar 2023 19:00:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g17so21540104lfv.4;
        Tue, 21 Mar 2023 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679450409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie5E22uk0w9QlkDqcEPCeQ07zHlCQwhf3VA/3a+3Jkk=;
        b=UDh7QcadOjbbUNHwDtGEHKr/pp/feNlDjUVoY2E+wZdt/w5CRLlkz5Y5fle1BLtZCk
         xdFkjBDCY8HtrhZUDLr/D7HSpz3/hyFD2+DUzsKc0mGSk6p18MYQF2j9av4gP2nFgDr/
         CmgFfY6YnXzWK2yWptkncFlp99GXXe61uqUPBjdJvvaY0rRKGa7b7VrFEp/dC6J+WKpP
         7L3K3kHd+Gg7IzUMBg00653rBut1H9bdjb1BIuI8gTDRH50/lvDRX/TRWRiLClWQ4yrG
         jrScyO3Y2Um75mwQb2/0djS8LP5Eo9r44o2A0sP4eNTprjuVr2mUUtXcx1nOJb8XF0C8
         MC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679450409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie5E22uk0w9QlkDqcEPCeQ07zHlCQwhf3VA/3a+3Jkk=;
        b=L17jmKLh7DYirT+44acdBRNT8rulrwKOh4urDGIC8KCZOWJmSzKRMlLj2kCjsITixO
         HC0qh92u7mTHuYQn2eh0thwqfDdM/964afirRC1kVNJgmlU81eiyAoIjV1guCEAgSOfr
         ltTQ3xSdTIlaN/rRaR0Qyq5uvBkZTmZLv22/3wZEO5gLh3YOLZWYHS645XPO2DZq+r17
         LfZioYW7ZgHP9KDbVnSOr+DuPxaaiEMgl47y0aUDaKAk8Cw1wMNF3B4jXDEGKCJrVbO2
         gX4QG5NLpUoTQF3XyqmDnvfIjQVa3vUwtZyRJdGiR7/GznPDa0Ml0kiRVaLKaywnKtZJ
         mz/g==
X-Gm-Message-State: AO0yUKWAb7PYZm21nhysjFtA67nEXO8JMmHrLqGOghs6GmwAxqVeD5mf
        jJRqkhoQPT67R1R7pr1XdHm1HIrXqV2f3wC/2Z8=
X-Google-Smtp-Source: AK7set8j/uN5VQ2o5R7ii7zHSwGtrYpzt7eNS1FPlyYHId/A01NaD2piRg05FtSJuq9TkMvV4ckZv0lPDggbsTkOMxY=
X-Received: by 2002:ac2:528c:0:b0:4e8:4b7a:6b72 with SMTP id
 q12-20020ac2528c000000b004e84b7a6b72mr1469020lfm.2.1679450409204; Tue, 21 Mar
 2023 19:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230216014120.3110-1-k1rh4.lee@gmail.com> <9bfef283-e2ac-b2ba-386c-6833e9cb1283@linaro.org>
In-Reply-To: <9bfef283-e2ac-b2ba-386c-6833e9cb1283@linaro.org>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Wed, 22 Mar 2023 10:59:32 +0900
Message-ID: <CAJkuJRjKszq75M_QttFSO+zVixqfNjHBeajZFa8r0x+wnE6xiA@mail.gmail.com>
Subject: Re: [PATCH] misc: fastrpc: Fix a Use after-free-bug by race condition
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds great.

Thank you for your recommendation.
The patch code that you recommend is clear and simple.
Please patch this.

Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 93ebd174d848..aa1cf0e9f4ed 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file
*file, unsigned int cmd,
                err =3D fastrpc_req_mmap(fl, argp);
                break;
        case FASTRPC_IOCTL_MUNMAP:
+               mutex_lock(&fl->mutex);
                err =3D fastrpc_req_munmap(fl, argp);
+               mutex_unlock(&fl->mutex);
                break;
        case FASTRPC_IOCTL_MEM_MAP:
                err =3D fastrpc_req_mem_map(fl, argp);
--
2.25.1


2023=EB=85=84 3=EC=9B=94 21=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:27, S=
rinivas Kandagatla
<srinivas.kandagatla@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thanks Sangsup for reporting the issue and sharing the patch,
>
> Sorry, for some reason I missed this patch.
>
> On 16/02/2023 01:41, Sangsup Lee wrote:
> > This patch adds mutex_lock for fixing an Use-after-free bug.
> > fastrpc_req_munmap_impl can be called concurrently in multi-threded env=
ironments.
> > The buf which is allocated by list_for_each_safe can be used after anot=
her thread frees it.
> >
> Commit log can be improved here to something like:
>
> fastrcp_munmap takes two steps to unmap the memory, first to find a
> matching fastrpc buf in the list and second is to send request to DSP to
> unmap it.
> There is a potentially window of race between these two operations,
> which can lead to user-after-free.
>
> Fix this by adding locking around this two operations.
>
> > Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> > ---
> >   drivers/misc/fastrpc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 5310606113fe..c4b5fa4a50a6 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1806,10 +1806,12 @@ static int fastrpc_req_munmap(struct fastrpc_us=
er *fl, char __user *argp)
> >       struct fastrpc_buf *buf =3D NULL, *iter, *b;
> >       struct fastrpc_req_munmap req;
> >       struct device *dev =3D fl->sctx->dev;
> > +     int err;
> >
> >       if (copy_from_user(&req, argp, sizeof(req)))
> >               return -EFAULT;
> >
> > +     mutex_lock(&fl->mutex);
> >       spin_lock(&fl->lock);
> >       list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
> >               if ((iter->raddr =3D=3D req.vaddrout) && (iter->size =3D=
=3D req.size)) {
> > @@ -1822,10 +1824,13 @@ static int fastrpc_req_munmap(struct fastrpc_us=
er *fl, char __user *argp)
> >       if (!buf) {
> >               dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in l=
ist\n",
> >                       req.vaddrout, req.size);
> > +             mutex_unlock(&fl->mutex);
> >               return -EINVAL;
> >       }
> >
> > -     return fastrpc_req_munmap_impl(fl, buf);
> > +     err =3D fastrpc_req_munmap_impl(fl, buf);
> > +     mutex_unlock(&fl->mutex);
> > +     return err;
>
> How about moving the locking to ioctl:
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a701132638cf..2f217071a6c3 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2087,7 +2087,9 @@ static long fastrpc_device_ioctl(struct file
> *file, unsigned int cmd,
>                  err =3D fastrpc_req_mmap(fl, argp);
>                  break;
>          case FASTRPC_IOCTL_MUNMAP:
> +               mutex_lock(&fl->mutex);
>                  err =3D fastrpc_req_munmap(fl, argp);
> +               mutex_unlock(&fl->mutex);
>                  break;
>          case FASTRPC_IOCTL_MEM_MAP:
>                  err =3D fastrpc_req_mem_map(fl, argp);
>
>
> thanks,
> srini
> >   }
> >
> >   static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *arg=
p)
