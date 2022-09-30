Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694FE5F1261
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiI3T1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3T07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:26:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501DBF1CE;
        Fri, 30 Sep 2022 12:26:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p202so4043272iod.6;
        Fri, 30 Sep 2022 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CyFCz/PtxiRojOro3Tz6mAJs1BnBuc5nNL9d7R4p0VM=;
        b=Ol34SH8f6LSSLIoWabQ2NpBwBBP5p5lAyhUs9K12JJbo2ENGWC6drB0y/He03EdGs9
         l/eif+wWKjSIp+xlbVw8oab1YRGXwXYcS334ER9DA/NMOHSoIGg4xsK89nbf5f6uTT/T
         ZhXKlT0nB/1PL5IO8DOr6YrPcPeAZ2OhlP+tVcb1E5WrJth7mpjEhOQrUEYbinjD0PCe
         5NOv2hC9Qtt+WLpdW4z29/P5sd/ley1mXZ0mB6HfpLga/+h7ir41zte82Ln8iEerSt6K
         0ms1CbL7RLHg+W5XW2MhTZ28dKAoPcBoB/Qf7wrvoiYLG7+CyyiT/mZYldF9UTvqEm5Q
         QIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CyFCz/PtxiRojOro3Tz6mAJs1BnBuc5nNL9d7R4p0VM=;
        b=GW3xHsktXbp/UG6FDkfA051WbJDuOYkYsmeK6pcnKqvXvuXjKW9/znCLLNd9KckKDX
         +YAZVVymznAddkWyCk7h3F1T2rj3vUWh/AXYBlmV98N/cw9tthbSZoOXkdVwPfsiV5sm
         Mvvi+fGgiH17VElMS1CDPXO4+g+ctLvjc3oPPzS61PLMjzUvQ6Cryd7AAKzeF8OgxfnJ
         zPk0yg3KjejR2supRcmf+b9slmRqsp2SYudYcPZJ/M1IX8y0zhCjfE3Bc0dW1OjT1YJx
         GNm2lHE/DHVhDD5C9zcacQBLd2Pvo6ArnsovA1H8FqzE8eABjXyfjq3kAx8eF5GhGRHu
         pdoQ==
X-Gm-Message-State: ACrzQf2UGUJkkZQ/wsRXSkOtOwYdBP3P0Bglsf/1zMHvmRX7E8yvym0g
        8x1FwukAU4C7cTtG2a+1P6pkm2QGDnUzUsqpvSg=
X-Google-Smtp-Source: AMsMyM7GnmJ4BsLjWakf62ggAye8LVDlOXcW9ycAf2aRyun7/LwPPppKdGkXdOZ/3YWo7oNEUxGvCjtbpcySHaz6+9k=
X-Received: by 2002:a05:6602:1509:b0:69b:35ba:4720 with SMTP id
 g9-20020a056602150900b0069b35ba4720mr4601029iow.155.1664566018344; Fri, 30
 Sep 2022 12:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220930085351.2648034-1-masahiroy@kernel.org>
In-Reply-To: <20220930085351.2648034-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 30 Sep 2022 21:26:47 +0200
Message-ID: <CANiq72krEBRL5DGHJuaeruBnJ_GeZKVjwZPLJ9iy0ogbHcH-Dg@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.debug: split debug-level and DWARF-version into
 separate choices
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:55 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>   Rustc Codegen manual:
>
>     debuginfo
>
>       This flag controls the generation of debug information. It takes
>       one of the following values:
>
>       0: no debug info at all (the default).
>       1: line tables only.
>       2: full debug info.

Thanks for including Rust here! :)

Acked-by: Miguel Ojeda <ojeda@kernel.org>

> +         Only works with newer gcc versions.

Unrelated, but in a future patch it would be useful for users to say
which versions.

Cheers,
Miguel
