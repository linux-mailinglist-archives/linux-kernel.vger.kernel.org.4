Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA26FE224
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjEJQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:08:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D35BAA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:08:22 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so11036418276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683734901; x=1686326901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/UqHIj3pp0KBOJJJHffNhpQw/fXZC/Mr36vwvvthqY=;
        b=ObkmmUWr5r8cmbxBerpXZp30yVBkGxn1zIcP3dnTUisY+szfhb7bSiS0wiR64O7Lir
         BZH/Iie5BMVrgS382MTN4qg9tx17ZqCOqzF/eOk0R8a3GyfXte32abaXTH5LeUujjYL2
         xtMQHqOj0Pq9jnV3Enpqe02MLPW/6yJmY/3+cJeb98Fv5q3jVtuvA3PhdQBn8IDzRhxz
         UyvQT/uEmBEkaoL51GHcWEyHROlpqpyLmaF3XPs55iqXd3DGo/jWaEWJxx49boaA9hQz
         rwa7NxsP1JxrMzFPnsESCbMhyihw+PkCNoGj74dtsRcX8n+cGVHrh9pArNe6Phbwnykc
         ENhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734901; x=1686326901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/UqHIj3pp0KBOJJJHffNhpQw/fXZC/Mr36vwvvthqY=;
        b=XBLdQzbs4Bqi+FRU4tZ/4IzLBVBkMcLgchEMaIRIQV4DxLqcXtIuxscTK5ffhukI1a
         tdLVn3MPMTXh7bFm5MR3bB36niVn8xl9O7PbTaBu+Yse/8PkldqMxU8LWUfNXFZ3uVYH
         YkFWVC9Knzpgi2z1qM5gZm0GbUeVgKAjiKTBN64yXzpLVNXG/nscgWOK+Gn6GqoA5zO8
         ZtUh33QZ00JS0/XUThrU5dDDrkUMdscWJlL6WP7svtNiJAmtTqh0uay7IvBF2VdzIRAK
         sf47w6QKI+FVu5DgipFz5SL0M60yGr+L6jsKFxjqjDCr2k3hktGf5MeA74ObA2S/6gY1
         9RnA==
X-Gm-Message-State: AC+VfDzvAWV9uI4w/skrWsXSGOzDZPA0dY/xFX7iZi7QUdikZbBGWMnG
        g1AGuCQnxQwoNnMYxgahgxOKmWSAKyhgTp6qxVZAmA==
X-Google-Smtp-Source: ACHHUZ4Ap9p6mkYIcI6e4F8SpR9DNDQB68qeHqrnorBE56x+zI/FsSX4462fcKV4mArEOzvsgmclv3Mwt+DC/T/Ccf4=
X-Received: by 2002:a25:d2ca:0:b0:b8f:469a:cb9b with SMTP id
 j193-20020a25d2ca000000b00b8f469acb9bmr18089016ybg.52.1683734901243; Wed, 10
 May 2023 09:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230424112313.3408363-1-glider@google.com> <6446ad55.170a0220.c82cd.cedc@mx.google.com>
 <CAG_fn=UzQ-jnQrxzvLE6EV37zSVCOGPmsVTxyfp1wXzBir4vAg@mail.gmail.com> <CAG_fn=XmSbaMQQAwCWVmZ8UYDrsmeQWiqi92Vi4CQqy4GK+0ug@mail.gmail.com>
In-Reply-To: <CAG_fn=XmSbaMQQAwCWVmZ8UYDrsmeQWiqi92Vi4CQqy4GK+0ug@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 10 May 2023 18:07:44 +0200
Message-ID: <CAG_fn=VgkA0OdjqJg1FCBX5FcXtm96h9PTTTwAt3qWa0n0oNyw@mail.gmail.com>
Subject: Re: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
To:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 9:48=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
>
>
> On Fri, Apr 28, 2023 at 3:48=E2=80=AFPM Alexander Potapenko <glider@googl=
e.com> wrote:
>>

>> > I *think* this isn't a problem for CONFIG_FORTIFY, since these will be
>> > replaced and checked separately -- but it still seems strange that you
>> > need to explicitly use __builtin_memcpy.
>>
>
> Or did you mean we'd better use __underlying_memcpy() here instead? I am =
a bit puzzled.

Kees told me offline that the patch in question is fine.
@Andrew, would it be possible to queue it for 6.4?

--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
