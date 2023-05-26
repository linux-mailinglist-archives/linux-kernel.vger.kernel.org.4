Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDE712DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjEZTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjEZTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:48:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8FF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:48:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso101a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685130528; x=1687722528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf4RRkiPUcNUs6sAKxHRjbAkQ4OPhmS/ejzXep+9w6w=;
        b=CKJONIHYBHoJ36pk3behUlnsORLM/bdJ0rKRwmtMPp0jrr/61zx3jD87TcrsYqy7zg
         k3biIDnQctHE5hJlWcQwUoZNxiDhYsAjQw9EkmEs47vBwpPKETPNuW5TQY/kHezVhRG5
         +AEfGjsfL0QOFBMYQqDqo/12R+BmNy9QDg1/Ks8RYLufZoToWmyDVjZ9zNaJoOQ6tSbD
         mkgN8Z+SQU/8xDSa7AfpFhM5yJiD0fDLr2W5b6q2WasXfoN5IHW3BEgVmKiSxiK3ELxR
         G27OzqOCQh2nquF0d43d717kdH0nfRAkmnqFWwOZNIE5Ka6tq4XteFx/StgpU26cggge
         QN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130528; x=1687722528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf4RRkiPUcNUs6sAKxHRjbAkQ4OPhmS/ejzXep+9w6w=;
        b=PKmmRCtepplsLkDzqbApP2jnZGgchdCF/q6xXHR3pJwyY1eNGdc5Ej+mzJM9tErk98
         69btRoiNjJ1MpDzKGkX+YSLdEO1fUcYRI+vkItVJtcU8MCAy15GPpJC9NnNRpkH+mTsF
         m9h7smiK+cqOguITo9900hqgve8XujAg2gN0fePmaT23DTf3L1HOqgPSZTF91zegT/gt
         /JfvBJcIGOKqPzyOOqm3dhFb5TEvWyvx7kg7YzjWuXTIw8XSus4OrzYPH8/giZok68XB
         afzuE/zF0WE2y8a6kegPoNpJnpV86nyzifO00f1s0ozFdFswQ0jsi42rYc2nQ7x2qNAE
         cIZg==
X-Gm-Message-State: AC+VfDwYq7rh9do5/WCM5lNen/E83KESSi9rX7USE8e8s86hzurW1OCe
        edNPlhztODS29A7itrZRWsdBZEKlohI6aaWHgwmofw==
X-Google-Smtp-Source: ACHHUZ6CxetlS1s0rTKhE7K29Vp+fVoMB7NYpov6+cDO8gK7BapHTfvlv5vmr5u3w5Oi3ADVrOxX4qb1dXamvqZdzWs=
X-Received: by 2002:a50:aa93:0:b0:50b:c48c:8a25 with SMTP id
 q19-20020a50aa93000000b0050bc48c8a25mr19788edc.6.1685130528276; Fri, 26 May
 2023 12:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230517190841.gonna.796-kees@kernel.org> <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
 <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com> <202305261156.67CDEE933D@keescook>
In-Reply-To: <202305261156.67CDEE933D@keescook>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 26 May 2023 12:48:26 -0700
Message-ID: <CAFP8O3JO42CD2EXk+DJ5pci8ieHvRifAZpKg4iR_NiqTaYfLdA@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org,
        qing.zhao@oracle.com, morbo@google.com, llvm@lists.linux.dev,
        trix@redhat.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:56=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, May 26, 2023 at 07:47:03PM +0200, Miguel Ojeda wrote:
> > On Fri, May 26, 2023 at 7:16=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > FYI, applied to for-next/hardening:
> > >
> > > [1/1] Compiler Attributes: Add __counted_by macro
> > >       https://git.kernel.org/kees/c/86a76e91cbab
> >
> > Sorry, I was going to apply it soon -- in case you want it:
> >
> >     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Thanks!
>
> > And thanks Nathan for resubmitting the `Reviewed-by` from v1!
>
> Yes, apologies for missing this in my v2 submission!
>
> --
> Kees Cook
>

https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safet=
y/70854
proposes a macro __counted_by as well.
This patch uses the same name:

> # define __counted_by(member)          __attribute__((__element_count__(m=
ember)))

I wonder whether the two use cases are compatible so that using the
same macro name will be fine.

#if defined(__has_feature) && __has_feature(bounds_safety)
#define __counted_by(T) __attribute__((__counted_by__(T)))
// ... other bounds annotations
#else
#define __counted_by(T) // defined as nothing // ... other bounds annotatio=
ns
#endif


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
