Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC672BC53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjFLJ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjFLJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:28:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DE4C09
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9a81da5d7so315391cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=7wUiTG0MmA7y+2lEinSm8giFjQJ6k0IDdL+is2Qw8cH14kEFKpZyKzAPPtwqLt/xBz
         eR4ss+OnelXP6bltOJo8JCbhScmYimFC53jjp2maM6atl4VhalAajHvqTz+c7vJnSkjL
         ZSvBC5coCX+q2tryUXmvGRMTvCUkcQc1xppJ7C9bof++HL2Hty/nrzozzodMtDO8MYtz
         9MBnl6xyZU4UTYrj+jDfey6Z5LMldODvWpWAlA0ArvaY0A/T1oI8EbSFV9L52cd8BjV2
         cS+pUKjhRNV2OEqhIF3UmmbjHIG1qJB1ZwbuKK0Q47sdcaOY8yiYSTWe/P0EqOoRneah
         eazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=iRqdjOutM2HUW0vu6MvAwQIc5vl7joNBbudgGx/Sqm6gLi/ewyHxmAnPIhoZi8K6Eu
         /Grbuki3R9dvyQ304gjzv6ITlA6IFlPWQdwyRoBM4CJdKlRentUL3uiHrT+u2a/riee9
         FHwt0eNP42XODiQPpOkv49lfWH7JaVL2qdynv7W8LxU808hLSKG/y7PEJGupE8xei2R0
         BTRkBL8qE7I6vZQWSZWT/KjFakndX59NZj2ii4+a6WX7S1N3TFBBew1uHuxjc7ZCQpv+
         ud/7mccHn8B+BqARljDd8JMxeqm5dQD9M93ZrxIYttXp/Vb+B0qU8OuZ4AE2v/RJtzen
         yzxA==
X-Gm-Message-State: AC+VfDyCbykeVbEqnZ3T4MQNQUufoVqsjAbOkdrwuGhEiA1ZBgWtWX5i
        sFPTzeEC8wiLGQPA3FtiuCAVx7wc+uT/mA1UAYEeUg==
X-Google-Smtp-Source: ACHHUZ51q8jd03XKL1NPqfVUpJ4pFcDkHkIvsYbMu+HQ8MbVxEfdIQG/UU8zuNvgxNJ/w6TPxfMn2uZ9T0lxjQ4932M=
X-Received: by 2002:a05:622a:1899:b0:3f9:a770:7279 with SMTP id
 v25-20020a05622a189900b003f9a7707279mr235109qtc.9.1686561743953; Mon, 12 Jun
 2023 02:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com> <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 12 Jun 2023 11:22:12 +0200
Message-ID: <CANn89iLT0SFf_2BVFhODYFWmr1rPu1o-AOaOhbGeLvAwuq5XbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/4] net: core: add getsockopt SO_PEERPIDFD
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 10:26=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> This thing is direct analog of SO_PEERCRED which allows to get plain PID.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
