Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889173E661
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFZRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjFZRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:25:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480E8F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:25:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401e0ceb4e6so4233031cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687800306; x=1690392306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb+RURvt6A+w8dCv8RL1qzl/KMJ6kd7FHQTDIWYf1EQ=;
        b=rRzsrh1Tg4LulotQaD7JFdbsAHvoTRNFiEheI4LxAHrGVu0ptoLrfg4xkYIhzBYbvL
         u/gPrHP9J88IBVImHfSpoxB3838Lr94LMdAbjVPOqOBrVhVg5gJ3lv41uixwqIvpZgmc
         zjT9wVjzREkcHLusii/9hHDTARwVGOiZ3STfL1ikbVl8YGkoiH++7032DKciCnHZ3EoC
         wHkvY82XpH1RxB03WAK6fAZTu9IZ/xVLKqvp19+ZHdGsRx9M0i9Q1PDwNcSC8Rp9oKNi
         5j3FLW+ppcGEpfT9bYeKP18zpHmhQcS72qq5CQLDmgx/OPGJ3oFy7zb/Xla9zA72Md9c
         72uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800306; x=1690392306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb+RURvt6A+w8dCv8RL1qzl/KMJ6kd7FHQTDIWYf1EQ=;
        b=iv7w5bmZxEC8kzA22CUWOIAgtjvCU0ZNcEUKjAVbLAGdcus1BbK9ZdRm0NEZ7B3KqV
         onqgo3uiAjJHxWXt99SL+Xe+7yZ/wQoI/Q/ej8Vwqw3m4aiEh67OVbDAIot67IFJgugn
         CqHkjh/XAMeNlIYyb9wWT1c/LEtba9rHobCQhk6/37ctYhShyRAMwgsf+4EvVsYrALEd
         xj9v8jYInsFBUtQZ7g0HpXqiP59vD4XhORRyGQbdPK9wUk+E33ROlmfVqZtETck30kfA
         Aej6/vq08WBz/ZBAjQ+8m0s/IB6CrZzLDLAOK4IWrJdzQrEERlHSQS34RsBwa4KDYuSq
         Xd3g==
X-Gm-Message-State: AC+VfDw2cJMVIxuH5BN272O3nkiu+vNGQlLDqcGS9Kc8uf5uTgaqiL4a
        kwqG3vtZY9TChtdryYK3JPJIxcS7fbzjruafCLuqM050Cz+y9iPVf2I=
X-Google-Smtp-Source: ACHHUZ77A1WX0MZUcXsPi4e417afV2ZHEIHW9mgY1e1RMVfek8RN/ob9XO9palzLMz74IYY8tNstk1kr4pHhPrpxFL8=
X-Received: by 2002:a05:6214:f2b:b0:62d:f68a:ee2d with SMTP id
 iw11-20020a0562140f2b00b0062df68aee2dmr5834042qvb.29.1687800306154; Mon, 26
 Jun 2023 10:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bif9Wek-g10F5y0aLbH=JbCcqryi2nOUAFxGFo0O2B9A@mail.gmail.com>
In-Reply-To: <CACT4Y+bif9Wek-g10F5y0aLbH=JbCcqryi2nOUAFxGFo0O2B9A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Jun 2023 10:24:55 -0700
Message-ID: <CAKwvOdnTzcG0DY9SScu1JuV4Q0Ka60qm9jdK2TjA1Cav8En-mQ@mail.gmail.com>
Subject: Re: Thread-safety annotations for irq/rcu/atomic contexts
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
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

(minus old ML, plus new ML)

On Mon, Jun 26, 2023 at 10:21=E2=80=AFAM 'Dmitry Vyukov' via Clang Built Li=
nux
<clang-built-linux@googlegroups.com> wrote:
>
> Hi,
>
> Previous Lukas' attempt to apply clang thread-safety annotations to the k=
ernel:
> https://clangbuiltlinux.github.io/CBL-meetup-2020-slides/lukas/tsa.pdf
>
> I am thinking if the annotations can be used to check for functions
> that must/must not be called from irq/atomic/rcu_read/etc contexts.
> Namely, we create global fake locks that denote these contexts, then
> annotate spin_lock_irqsave/irqrestore/etc as taking releasing these
> locks, and finally annotate functions are requiring/excluding these
> contexts:
>
> void foo() require(irq_context);
> void bar() exclude(irq_context);
> void baz() require(rcu_read_context);
>
> This may help to catch "suspicious RCU usage", "scheduling while
> atomic" and similar bug types statically. I suspect it may also be
> simpler (?) to do rather than annotating all normal locks.
>
> Does it make any sense?
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/CACT4Y%2Bbif9Wek-g10F5y0aLbH%3DJbCcqryi2nOUAFxGFo0O2B9A=
%40mail.gmail.com.



--=20
Thanks,
~Nick Desaulniers
