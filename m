Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737136F0369
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbjD0JaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbjD0J34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:29:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6419A5;
        Thu, 27 Apr 2023 02:29:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8ba23a2abso79717031fa.2;
        Thu, 27 Apr 2023 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682587793; x=1685179793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtD7IiWzzBaXMSHlZSv0jhO4Rxpgph8daQMT7xR7Jbs=;
        b=bqrrw75wgRIQ8NTrsdCsR+UK1qmNnlQR8s1tDWFKAsEQxYMWytbVGl+dcn90HX71h/
         6p6dlDMyYn+fBziBdOtbfMILYoJdal7AFy3R0aD+umZJYIYrdcKO+1S/jJ/B05fv5yUy
         8sx5OY3A1Kau8kgH7S4+k4w7mNbaLOrIkI+D3AvdT+75sXjc7VXofoBxZi0Q1Be1OHoo
         0JaHrKQU0jDj5RLi/PFi4RDaMcBdjcLf1oOhOHTsAAFYL2zFwv9jboZsEyxr6Syc2BH8
         mdLhUvWM2wu2n/OI9ByR6/2ArM7dR11rpm5I93IDjsZWQ70xQi3jj8hmhvjEEzi3wmMF
         CK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587793; x=1685179793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtD7IiWzzBaXMSHlZSv0jhO4Rxpgph8daQMT7xR7Jbs=;
        b=KTyEiUneYtopvN2RYxAqCB3s6GR1eDarOdcPPaiJh/kw0o2vYGg/HRkkXa6//zg8gK
         pxDaggI5RDOdBDkukHaAWwWiOfMRO+vJXc0kOrnn9SiERCc2ynAEus8/L5UGMJa3J47t
         SODAomjk/SHB7iBRMHZKGlgNDJQJ16p4WOoqjPpKFdUGQfSEGD8qARFAQXcgfAYdIAJ1
         abZqdyFznsHmWXzI9uEfcGlr2oshvePStVFf0J2u5901wc23TBr4SuRBB8/r+AG4car8
         rB1RydCFPaSGZ5iLveThTWNAkXVzTDaKcV9tbP/6IjbYj0BUT65UQfkaAc3UqZY++i77
         Ep7Q==
X-Gm-Message-State: AC+VfDyKb/EXX9MKN/fsWvm0SQaZx+irOvFDhe8arhX86Li4/t/TN+tt
        vlGZ8UInrwnxjW9gjHWhKycNQfIz4aypek6V4w0=
X-Google-Smtp-Source: ACHHUZ7R9LwU69d0Cw5S9lVWiOG8whrxQWdlWZXE8ZXA2S/YMzHSkgtDGuX/puDwa/j+qs59y9ju0mDl65qKV1Gp0yQ=
X-Received: by 2002:ac2:51c3:0:b0:4ef:fddf:d5fa with SMTP id
 u3-20020ac251c3000000b004effddfd5famr391280lfm.27.1682587792950; Thu, 27 Apr
 2023 02:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230323013655.366-1-k1rh4.lee@gmail.com>
In-Reply-To: <20230323013655.366-1-k1rh4.lee@gmail.com>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Thu, 27 Apr 2023 18:29:16 +0900
Message-ID: <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: Fix a Use after-free-bug by race condition
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any comment for this issue?
(reference: https://www.spinics.net/lists/kernel/msg4731408.html)


2023=EB=85=84 3=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:37, =
Sangsup Lee <k1rh4.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Sangsup lee <k1rh4.lee@gmail.com>
>
> This patch adds mutex_lock for fixing an Use-after-free bug.
> fastrpc_req_munmap_impl can be called concurrently in multi-threded envir=
onments.
> The buf which is allocated by list_for_each_safe can be used after anothe=
r thread frees it.
>
> Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
> ---
>  V1 -> V2: moving the locking to ioctl.
>
>  drivers/misc/fastrpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..aa1cf0e9f4ed 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file *file,=
 unsigned int cmd,
>                 err =3D fastrpc_req_mmap(fl, argp);
>                 break;
>         case FASTRPC_IOCTL_MUNMAP:
> +               mutex_lock(&fl->mutex);
>                 err =3D fastrpc_req_munmap(fl, argp);
> +               mutex_unlock(&fl->mutex);
>                 break;
>         case FASTRPC_IOCTL_MEM_MAP:
>                 err =3D fastrpc_req_mem_map(fl, argp);
> --
> 2.25.1
>
