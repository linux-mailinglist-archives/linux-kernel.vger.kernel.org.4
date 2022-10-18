Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8E6034A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJRVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJRVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:12:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06970C4C3E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:12:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b2so24839627lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD2BTqihXvfz7aTbg976FCevofGwmPphGebJQ+sKXGE=;
        b=TB0xLsYvoabtqY1vKbm+7zWnmfa41IPHwd47ga5v4b4I1+vjUeSvCWw7klyPLd9b1D
         fuKwEKLuzSHmZRBhD7I1+8YUh1VYbOFfOi6L7as98cUC2OEJ5HCkD9MbZMOQur+MTen+
         eCSiUI1HKID7oui0y2Fbn1CwUGJGKhv9X3wBO4fVomc8vW1jsArlqtk5wkW0VHvn8d4e
         jULgW2wVLhy4Nf6wWMjDbaJx19ur/ySIlFgW63+cUIov5d8sfZs2yiMz94FYSGHqaC4i
         QfCnkSZu+MfMJJZRwD3hB4uwNHRGqhffyk8PF8jdc9du8qOlSVNyz2ej+7J0QynLMbKi
         2mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD2BTqihXvfz7aTbg976FCevofGwmPphGebJQ+sKXGE=;
        b=7vvYIoHh4CHsXY5TWwt8KJSxsnG5R3cVrb3nc+HzOyd3Mz4vZyQgbAHIvcx7b7a5Im
         4oRNaS5jwonK/fts67sXHOsIi+vksanBq8H2bYpNc2J4o4Jv2i/AbYMKle+HmCrYGcRD
         n7Juj+RileeOryUPUQF4ItKVZJixUHHSSEj6GTDMz6+DGyzN/GU2JghVqmpwbD2300dV
         C5oG3yNy+kthZma1Z5sp56psOHFDr6XQfYA8wPVznlNwaxqgogErNPjSg59eQhi7/Amj
         +HAugnprhyj9Wq9k4FlH1COxorXwD8CRfedk2U7IDUuwaeAKBe79VVaGfRkeQCg/4Pze
         cI/w==
X-Gm-Message-State: ACrzQf3LBBOh89984HVG4dc9LnBa/sYxqOY3mtKSN/VPfHF7jP1a8rBe
        pCQEKA/U9Z/aIg7RkRvQgUcTRKjvlHZkBJv+495Jxw==
X-Google-Smtp-Source: AMsMyM4UL25QoFVg9dQfjqt0myycTERHrdZt8yChGwMTnpE5paUFviT+AU2Q2Oc6yXFnDYzcFFCEdfHJqnIeHPR9CgY=
X-Received: by 2002:a05:6512:4003:b0:4a2:3dc3:89b5 with SMTP id
 br3-20020a056512400300b004a23dc389b5mr1777708lfb.394.1666127564213; Tue, 18
 Oct 2022 14:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221018190541.189780-1-mairacanal@riseup.net> <20221018190541.189780-2-mairacanal@riseup.net>
In-Reply-To: <20221018190541.189780-2-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 Oct 2022 14:12:32 -0700
Message-ID: <CAGS_qxof66Lbthg+bJHGWK2UQzovc4FLYVAHTdHP=QyfBBo6=w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] kunit: Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@gmail.com, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:06 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b1ab6b32216d..cde97dc4eed5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -658,6 +658,39 @@ do {                                                =
                              \
>                       ##__VA_ARGS__);                                    =
      \
>  } while (0)
>
> +#define KUNIT_MEM_ASSERTION(test,                                       =
      \
> +                           assert_type,                                 =
      \
> +                           left,                                        =
      \
> +                           op,                                          =
      \
> +                           right,                                       =
      \
> +                           size,                                        =
      \
> +                           fmt,                                         =
      \
> +                           ...)                                         =
      \
> +do {                                                                    =
      \
> +       const void *__left =3D (left);                                   =
        \
> +       const void *__right =3D (right);                                 =
        \
> +       const size_t __size =3D (size);                                  =
        \
> +       static const struct kunit_binary_assert_text __text =3D {        =
        \
> +               .operation =3D #op,                                      =
        \
> +               .left_text =3D #left,                                    =
        \
> +               .right_text =3D #right,                                  =
        \
> +       };                                                               =
      \
> +                                                                        =
      \
> +       if (likely(memcmp(__left, __right, __size) op 0))                =
      \
> +               break;                                                   =
      \
> +                                                                        =
      \
> +       _KUNIT_FAILED(test,                                              =
      \
> +                     assert_type,                                       =
      \
> +                     kunit_mem_assert,                                  =
      \
> +                     kunit_mem_assert_format,                           =
      \
> +                     KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,              =
      \
> +                                                  __left,               =
      \
> +                                                  __right,              =
      \
> +                                                  __size),              =
      \
> +                     fmt,                                               =
      \
> +                     ##__VA_ARGS__);                                    =
      \
> +} while (0)
> +

I think this should have been the only real change we needed to make
(to resolve the merge conflict I created).
Looks good to me. I think this series is still good to go.

Sorry for changing the assertion internals out from under you!

Daniel
