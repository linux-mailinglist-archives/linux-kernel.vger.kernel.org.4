Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B287712C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjEZSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbjEZSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:40:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4C419A;
        Fri, 26 May 2023 11:39:49 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba8374001abso1671386276.2;
        Fri, 26 May 2023 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126389; x=1687718389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vXVFqinU6hzYnJzyDvbSZcYgJ5OqQ5DqecwY5gTlbg=;
        b=HBQJRVJGyo3cNegzmb7A89vvpwtajKpgCCG1jwMw0h4iBrxokqyNyXSPLZKqA4zIM0
         lJH3v0Kg/u+W53msoxAScInSZiDx7UZVwiHFy0OL3v1gzHECujVsSa6Pi56e8OAQo5R4
         /Df7PQ4Za72nPd61UT0ITLwUcch0lRQBiaKlHkfJtontOiHwMmYV7pA8usdmfKSmMdw4
         6rdkzEA1+0IKhF3x3GQrZMkJUPnm9yYaqrUcsiLtX9bhI/bENEpcCx5Mtg0lGiQxBBIL
         pgD4XExpVcpQQCn4DII5fzPD5twq7zAb0Fms15UuSTIbV8wQdDZHNkcvYWkEAovdaWH4
         vwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126389; x=1687718389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vXVFqinU6hzYnJzyDvbSZcYgJ5OqQ5DqecwY5gTlbg=;
        b=fjbW3AKEBellIC1IQC2reDSzBOwFb9SxuEQVJ0FkRma2BZS3560IV+gyqbfVDruAR5
         bHW2QEAIl9X9JgRXWjejQ5wg6CJpB2/vm1Fx6UaMJlI4zhi90NdIk9yjVRbe1uANXXLj
         GG3a72J+IrzEYL/lZrxyTJ46xBf2Jef5lwTX704W6ZSTBATvJUgehKSp7LIlm06z9VNW
         F9u199WKZxclxMgAVRbEyWD/I+IUb3Vfm5KS4KGLtAMsiFsSUtRE/oYZAMMQSc3BR2cP
         cs+YKSCLjmp6bOpRUcUDm8PX5I5tH7T8vDaK7W31YVLUlvLLPzj1XxurTycNTSpc/gKH
         q0lQ==
X-Gm-Message-State: AC+VfDyfiOBtPGedqfY858WUTkaUMfLg/3bOm8G8SYykiNwudv1TUxfT
        YKihlt41eP9XEXEZjxpk6IbybKvNW5dnrJe8+LQ=
X-Google-Smtp-Source: ACHHUZ7gLNQJgSotIhJUKmtzUw6xQtsaJ9l9DCQLZ+Y+sLq9tLToRad7iXU2813y3Es/G/yl7Dwl0rElXuPDP+KkufE=
X-Received: by 2002:a25:28f:0:b0:ba7:7664:916b with SMTP id
 137-20020a25028f000000b00ba77664916bmr2397009ybc.20.1685126388774; Fri, 26
 May 2023 11:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150549.250372621@infradead.org> <20230526151946.960406324@infradead.org>
 <202305260939.D33FE435D2@keescook>
In-Reply-To: <202305260939.D33FE435D2@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 May 2023 20:39:37 +0200
Message-ID: <CANiq72k7vzTLqFuMLr0cL63xreGe2guvcYyKCkzaPh37xEFZRg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 7:05=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -366,4 +366,6 @@
> >   */
> >  #define __fix_address noinline __noclone
> >
> > +#define __cleanup(func)                      __attribute__((__cleanup_=
_(func)))
> > +
> >  #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
>
> nitpick: sorting. This needs to be moved up alphabetically; the comment
> at the start of the file says:
>
>  ...
>  * This file is meant to be sorted (by actual attribute name,
>  * not by #define identifier). ...

+1, also please add:

    /*
     *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes=
.html#index-cleanup-variable-attribute
     * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
     */

Cheers,
Miguel
