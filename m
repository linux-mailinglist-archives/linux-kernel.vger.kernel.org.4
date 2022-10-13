Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B895A5FE399
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJMU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJMU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:57:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CC183E28
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:57:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so2893764pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYaziEJ7Yp9qYJtgvX45VBWyIc4HpzXkckmVSYMctDg=;
        b=aJk3zaDZBm8/UfgByPmkSLx0Vn2au4SnrDGkqEZx678j8ppPLR63VNqItjjiNuCpg9
         fkYAXsQbLzJ/56eRN468M6UdAHgbhtmjhEj+Oqlr9V4dwPwbdP8VU7oWHHSssSWHQ2H7
         INNNgJO/hpggwLtPMbDLUSCW4l207dMLzHvbt7KwNKkoOg3C7juBuuK6OGjzqYWFJkFz
         s2r6Bl1TNIMs9iZOAfJapAZXcSVTzqsk3pLQDS9VsPHz51J6m8CAoNUToNUXiNgqMq1A
         mapi5McJR4DRt7MHYGyDbBjKIEnwJZ/OQeuvddUb66cveEUBszpMqxefjN9vvEQbx82v
         MInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYaziEJ7Yp9qYJtgvX45VBWyIc4HpzXkckmVSYMctDg=;
        b=0RJS+h5jpkUfYCj8B8RCdkKdwkabqXEW9neiRX+YF/XY2hctaRNYfkoaUjZbHK8V69
         8q2dz4tSQ1iuJ3eWfwmBkOxkaTe1TWavKWrKzGfHSY7R0xNROd75GRZzsA7yV6ZzYLSh
         D1sYfa7iZqH5FD0byTuk3mhUbbr1kMc6JzNnbyC4DTYQj9P3fGQhudzWIZwqwUM8GrRE
         dawiyXytauoTnlwfEj0kL5il1nyHRYigwdMxdCkchU5p9tsXdUouBAsTGgbC0aJGlI6D
         /uYnIbTLqyhcoC3R+kVcFQaGAbtlnSP43TuiXY1StqZaoCi3JvSCrbsvqgB4oxHwAvdP
         +vdw==
X-Gm-Message-State: ACrzQf1Ye90mWrrus4/471BJwjr7gh0cxjnZGi3L5+g5kAYmJk+LdpYy
        g8ZKWrIXadNwTKZPdo2xuF3jcU1WGwtiB48ynT8HMQ==
X-Google-Smtp-Source: AMsMyM6MOeEKW0yihGodYRFpUfcMXSeOibakzhbNseqUJSB45y2DUEHx6M2yKYsQfl67TCq68IsL8c94sjwX/8LX6Qo=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr13382600pjb.102.1665694620565; Thu, 13
 Oct 2022 13:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221012174622.45006-1-cgzones@googlemail.com>
In-Reply-To: <20221012174622.45006-1-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Oct 2022 13:56:49 -0700
Message-ID: <CAKwvOdk+dLP+0iZmKVNdgi7425DLZpMH+9dHnASzKZeXUnkiiA@mail.gmail.com>
Subject: Re: [PATCH] of: declare string literals const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:46 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> of_overlay_action_name() returns a string literal from a function local
> array.  Modifying string literals is undefined behavior which usage of
> const pointer can avoid.  of_overlay_action_name() is currently only
> used once in overlay_notify() to print the returned value.
>
> While on it declare the data array const as well.
>
> Reported by Clang:
>
>     In file included from arch/x86/kernel/asm-offsets.c:22:
>     In file included from arch/x86/kernel/../kvm/vmx/vmx.h:5:
>     In file included from ./include/linux/kvm_host.h:19:
>     In file included from ./include/linux/msi.h:23:
>     In file included from ./arch/x86/include/asm/msi.h:5:
>     In file included from ./arch/x86/include/asm/irqdomain.h:5:
>     In file included from ./include/linux/irqdomain.h:35:
>     ./include/linux/of.h:1555:3: error: initializing 'char *' with an exp=
ression of type 'const char[5]' discards qualifiers [-Werror,-Wincompatible=
-pointer-types-discards-qualifiers]
>                     "init",
>                     ^~~~~~
>     ./include/linux/of.h:1556:3: error: initializing 'char *' with an exp=
ression of type 'const char[10]' discards qualifiers [-Werror,-Wincompatibl=
e-pointer-types-discards-qualifiers]
>                     "pre-apply",
>                     ^~~~~~~~~~~
>     ./include/linux/of.h:1557:3: error: initializing 'char *' with an exp=
ression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatibl=
e-pointer-types-discards-qualifiers]
>                     "post-apply",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1558:3: error: initializing 'char *' with an exp=
ression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatibl=
e-pointer-types-discards-qualifiers]
>                     "pre-remove",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1559:3: error: initializing 'char *' with an exp=
ression of type 'const char[12]' discards qualifiers [-Werror,-Wincompatibl=
e-pointer-types-discards-qualifiers]
>                     "post-remove",
>                     ^~~~~~~~~~~~~
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 6b79ef9a6541..8b9f94386dc3 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1549,9 +1549,9 @@ enum of_overlay_notify_action {
>         OF_OVERLAY_POST_REMOVE,
>  };
>
> -static inline char *of_overlay_action_name(enum of_overlay_notify_action=
 action)
> +static inline const char *of_overlay_action_name(enum of_overlay_notify_=
action action)
>  {
> -       static char *of_overlay_action_name[] =3D {
> +       static const char *const of_overlay_action_name[] =3D {
>                 "init",
>                 "pre-apply",
>                 "post-apply",
> --
> 2.37.2
>


--=20
Thanks,
~Nick Desaulniers
