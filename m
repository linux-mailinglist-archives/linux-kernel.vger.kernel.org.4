Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6C72EA63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbjFMR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjFMR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:59:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EF19B1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:59:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c72b116fso873973466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679146; x=1689271146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=gJfuJuWGwzTahQhP6SWhrbswhYanOSZIHfq8cGSpgZBaO3kwizWtUG5ctcp9nrBJYL
         xkgK4N6g8yoRvrNVhtZd9AF79QMqvnE4eDaxStQTYgr8cZm3ryZpQw5jeNjiD4n3tWy/
         /Bsh516rx13mY7nrp+yZP0XiCksnfRlj067+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679146; x=1689271146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=KDloVojdLwc3ZQuqi9742YqOLly0nmIa1wghIgJO5r1MR1Q5XIq6+1QmvsnOqP1QjV
         /ezUAb7ua7LhATqUpQncNGkQPgr5hBF2jO6uFwuosw8muzfCUrw/Vq177+EBAYV1LGBs
         KOhumF3+1tzRac09ywZxA9ITsLzXKQrAobAB/J0mB+kmKFDLrev5X/qIRUP8DzoZi3dk
         NfPF5y+fRFDXGow1PRp1hTcLOIeSFH83AJbc8LaO/Xglijv6b0rXERzM0eKAyaMPhWM9
         wUQ9WNEOK/gyIbJhWd0LRL1z/hYQb/nqiTnM6h0pTX57z5sRA5xhvIYM17+7+iOHAkry
         JscA==
X-Gm-Message-State: AC+VfDwbjdi+nSTw/3RGL4kry+8bWxJcD9Y+4qcsTwTa8pm/GrOSEkV1
        m5UNDwrcPXTLooMJfxed8R48UE8pkbGqoAZ7QjaC3FnC
X-Google-Smtp-Source: ACHHUZ6qmlpT5ZQC/k7LFlV0lV3sY2/CMPCHGHuNM5J0bvOKMEwqSE6iq0WuaVQ241IbedsPLDrJ+g==
X-Received: by 2002:a17:906:fe0c:b0:976:b93f:26db with SMTP id wy12-20020a170906fe0c00b00976b93f26dbmr12101991ejb.53.1686679146048;
        Tue, 13 Jun 2023 10:59:06 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id o26-20020a17090637da00b009745e1b6226sm6842441ejc.125.2023.06.13.10.59.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:59:04 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so5766056f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:59:03 -0700 (PDT)
X-Received: by 2002:adf:e546:0:b0:306:41d3:fcb9 with SMTP id
 z6-20020adfe546000000b0030641d3fcb9mr8013110wrm.27.1686679143465; Tue, 13 Jun
 2023 10:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Subject: Re: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        broonie@kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small nit.

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +static inline unsigned long mksaveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !(v & (1 << _PAGE_BIT_RW));
> +
> +       v |=3D ((v >> _PAGE_BIT_DIRTY) & cond) << _PAGE_BIT_SAVED_DIRTY;
> +       v &=3D ~(cond << _PAGE_BIT_DIRTY);

I assume you checked that the compiler does the right thing here?

Because the above is kind of an odd way to do things, I feel.

You use boolean operators and then work with an "unsigned long" and
then shift things by hand. So you're kind of mixing two different
mental models.

To me, it would be more natural to do that 'cond' calculation as

        unsigned long cond =3D (~v >> _PAGE_BIT_RW) & 1;

and keep everything in the "bitops" domain.

I suspect - and hope - that the compiler is smart enough to turn that
boolean test into just the shift, but if that's the intent, why not
just write it with that in mind and not have that "both ways" model?

> +static inline unsigned long clear_saveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !!(v & (1 << _PAGE_BIT_RW));

Same comment here.

             Linus
