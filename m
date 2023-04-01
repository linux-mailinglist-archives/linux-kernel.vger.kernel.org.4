Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392726D3133
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDAOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDAOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:06:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95263B462;
        Sat,  1 Apr 2023 07:06:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h14so15043288pgj.7;
        Sat, 01 Apr 2023 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680357962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuazLWFC/WWE2drNijqhScFxpCqHXp9v8rGhMiQ1nyU=;
        b=PIZqIu0Hrw2dbPp2SaC4fTc4HLMJ/lvz7nLtFWnqzNg++hrFAVtshZHlkwcFZ7PFHP
         jUfFA3ckiumlnvOpPq6iDM2JfhA9LlhGaG5JH4CN/+4fmV9K/RvvjVK1mTiq3T6bgIHD
         PkGcC6ebieefx3LbJ4lbOyzkVW6/tOV8XEK1b6c6ytpBshei0nbq72uirIylFv+8VltB
         Mb1euRkyGdiOeWqBOMAjHihhJmUweeH/TjYaGUiyYK8lQOsq/P3exSYZ9/nxdssIMqMW
         CQoPYFrvARIsxBeg5eM8njoo8AMfjJ8LZJCzQ8iSsBFerz8nTJUULraNCUDrm9lBzqxe
         LC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680357962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuazLWFC/WWE2drNijqhScFxpCqHXp9v8rGhMiQ1nyU=;
        b=emyEbZLJKrRvfS/ks9LYpTtwrD89BH7MEqgWtjzrJMqxup918f3ncXZ54ytyM8Yu8g
         EVC4lU2FHjqV/bYScN6Ge96InMA93N0z1He3dTeQSYNKI8blsyJiLw/GoX4+CJrJvJt4
         hGCgPIlMnSe1jKHTnEiicorXZdxV1FH7Enba+jJSdAkA8WlZ5jFy8YNhWRXwi6tztASC
         i8C4Grp38p5Z6EFrRlzChpQsXnAgGpgg3TyzJzfa3ebfzPjhNlLK8hKX4RDkMBUKw9M7
         usCof3aAKzam97YecSrWOFOJldcj+cWtc4bAmRVsJBIBvJChKdINV6lGSyKrnvlrK4Uo
         nqPQ==
X-Gm-Message-State: AAQBX9fwceVfU5u3gwr7J0aEl9E4Wk1GPLPy1pkc5UEH0Ab8FsUou+cR
        Mn7MS3w7H292ShmAD3vwo549gHM7clg8joBWR6w=
X-Google-Smtp-Source: AKy350aadZd4FdZnJTUY9A87DID3XrcnoP8bQW/WSUSt20d6X2kII62qqw3vUQNC2wU/t/XzivNWghob/M8IBNTPKSg=
X-Received: by 2002:a05:6a00:14cc:b0:62d:b08a:8e13 with SMTP id
 w12-20020a056a0014cc00b0062db08a8e13mr6968302pfu.2.1680357961824; Sat, 01 Apr
 2023 07:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230331101943.831347-1-mmyangfl@gmail.com> <ZCfmCmxobIKaBdT4@gondor.apana.org.au>
In-Reply-To: <ZCfmCmxobIKaBdT4@gondor.apana.org.au>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Sat, 1 Apr 2023 22:05:25 +0800
Message-ID: <CAAXyoMN+eVLNeiDtkwSZC2gFUDsBwn8SFST1=Nrw-qNr-u3-5w@mail.gmail.com>
Subject: Re: [PATCH v4] crypto: hisilicon/trng - add support for HiSTB TRNG
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
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

Herbert Xu <herbert@gondor.apana.org.au> =E4=BA=8E2023=E5=B9=B44=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=85=AD 16:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 31, 2023 at 06:19:34PM +0800, David Yang wrote:
> >
> > +     struct histb_trng_priv *priv =3D (struct histb_trng_priv *) rng->=
priv;
>
> Plesae don't use rng->priv at all.  We're trying to phase it
> out because it encourages horrible casting like this.
>
> Please follow the model used in the meson driver.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Which meson driver? I didn't find any rng module under amlogic/ dir.
