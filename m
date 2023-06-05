Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1718721D34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjFEErT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFEErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:47:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42298
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 21:47:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso6739360a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 21:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1685940431; x=1688532431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06zA5PJSQMmfDhZEXKzzRsPi8utG/lf0ef8eRLldERQ=;
        b=IUPRmK7evATjPNi2UfnBgjO1Usqx8u0vWoUyDmaUlgNq/2vNUgg6w/9uMNACQ/1pUf
         MAEGe1fCTVwyKWD74Of8PR4c81l/QsB3XOJXAFfcE4wrZ4s8DfSo5mTK2wmVDBI+YPQs
         +7Xb+56PL2dYM69mqhXr75iqjvPPHf0hq4CixL9ahoekFdjh7ysB91K0GZdYroC4xfB/
         3HvuB8JFoQaid6CWzi0FqgYPUL9//8TSy36kwDuK2z2UxWwOnijxfiNchAAbiuQtuLHK
         //GQtt1p869ynOvOK2p1SC62Xq2Ap9+DBnbDfgbSXHL7ouG/gRrhA1idn+xTuU2qAdCc
         Nipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685940431; x=1688532431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06zA5PJSQMmfDhZEXKzzRsPi8utG/lf0ef8eRLldERQ=;
        b=TnoLYnkq5s5hBD7lsIRPlPCvWVYLKXAlGhpTCSzdR0jrnLBa2de0aLqx1U5HUmSooU
         g03c1BNANXRC254uZ6v5OUBkvHdXCmagwyXfYmYDzlU3GPVJGU/SPwd8d2SFPKUq/482
         //cT7N/Gr9TRzSXfeQ4ueHGmGufe2pU+uLDmON607xTrDEHmoyvn+JAmP2S3QIwDR45c
         tTLlLJZXaX0an92asRbPA4z2CGroo9OaTOINZw34tGPYHJYGcHEAIUbxbbIVd/z05ANX
         BvwYWPUTKic+whCapUN112uJg/XP+YdWNVEtf+Japp3uB9WZjfFZsllX0hW4FEbZluQ9
         yPug==
X-Gm-Message-State: AC+VfDymYvrsjJ5qQyCPbarAbfz+z61yYh2ab42wXkvsnvkZB4GLRfKW
        AX/LzWldH+dqIuEMfTn5myVIAb/uG7j00PQT5dSEqVuPf5UbJ21713g=
X-Google-Smtp-Source: ACHHUZ6N4v6FQLcrCOJffj9h0dxU3alusm+0YqU9TdCoLt2rL7Ac0kU4vQ7jTydhl7YWoiAEp1SGfZmRL3Urzr8S2no=
X-Received: by 2002:aa7:d608:0:b0:50b:d5e5:519d with SMTP id
 c8-20020aa7d608000000b0050bd5e5519dmr6590276edr.4.1685940431627; Sun, 04 Jun
 2023 21:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230603165949.1753326-1-masahiroy@kernel.org>
In-Reply-To: <20230603165949.1753326-1-masahiroy@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 5 Jun 2023 06:47:02 +0200
Message-ID: <CAMGffEk-_dGmciH7ggsATVAHyCwLemkR_UX4ikRJmuC7w1ePrg@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: fix mixed module-builtin object
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,


On Sat, Jun 3, 2023 at 6:59=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> With CONFIG_BLK_DEV_RNBD_CLIENT=3Dm and CONFIG_BLK_DEV_RNBD_SERVER=3Dy
> (or vice versa), rnbd-common.o is linked to a module and also to
> vmlinux even though CFLAGS are different between builtins and modules.
>
> This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> Fixing mixed module-builtin objects").
>
> Turn rnbd_access_mode_str() into an inline function.
Thx for you fix, but Guoqing has a slightly different patch in the queue:

https://lore.kernel.org/linux-block/CAMGffEnDjAP3zqytmsYxacvUROLKZj+KhH6LOX=
icOoPhS9FJJQ@mail.gmail.com/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>
>  drivers/block/rnbd/Makefile      |  6 ++----
>  drivers/block/rnbd/rnbd-common.c | 23 -----------------------
>  drivers/block/rnbd/rnbd-proto.h  | 14 +++++++++++++-
>  3 files changed, 15 insertions(+), 28 deletions(-)
>  delete mode 100644 drivers/block/rnbd/rnbd-common.c
>
> diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
> index 40b31630822c..208e5f865497 100644
> --- a/drivers/block/rnbd/Makefile
> +++ b/drivers/block/rnbd/Makefile
> @@ -3,13 +3,11 @@
>  ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
>
>  rnbd-client-y :=3D rnbd-clt.o \
> -                 rnbd-clt-sysfs.o \
> -                 rnbd-common.o
> +                 rnbd-clt-sysfs.o
>
>  CFLAGS_rnbd-srv-trace.o =3D -I$(src)
>
> -rnbd-server-y :=3D rnbd-common.o \
> -                 rnbd-srv.o \
> +rnbd-server-y :=3D rnbd-srv.o \
>                   rnbd-srv-sysfs.o \
>                   rnbd-srv-trace.o
>
> diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-c=
ommon.c
> deleted file mode 100644
> index 596c3f732403..000000000000
> --- a/drivers/block/rnbd/rnbd-common.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * RDMA Network Block Driver
> - *
> - * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> - * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> - * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> - */
> -#include "rnbd-proto.h"
> -
> -const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
> -{
> -       switch (mode) {
> -       case RNBD_ACCESS_RO:
> -               return "ro";
> -       case RNBD_ACCESS_RW:
> -               return "rw";
> -       case RNBD_ACCESS_MIGRATION:
> -               return "migration";
> -       default:
> -               return "unknown";
> -       }
> -}
> diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-pr=
oto.h
> index da1d0542d7e2..57afe9b07fda 100644
> --- a/drivers/block/rnbd/rnbd-proto.h
> +++ b/drivers/block/rnbd/rnbd-proto.h
> @@ -300,6 +300,18 @@ static inline u32 rq_to_rnbd_flags(struct request *r=
q)
>         return rnbd_opf;
>  }
>
> -const char *rnbd_access_mode_str(enum rnbd_access_mode mode);
> +static inline const char *rnbd_access_mode_str(enum rnbd_access_mode mod=
e)
> +{
> +       switch (mode) {
> +       case RNBD_ACCESS_RO:
> +               return "ro";
> +       case RNBD_ACCESS_RW:
> +               return "rw";
> +       case RNBD_ACCESS_MIGRATION:
> +               return "migration";
> +       default:
> +               return "unknown";
> +       }
> +}
>
>  #endif /* RNBD_PROTO_H */
> --
> 2.39.2
>
