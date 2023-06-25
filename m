Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AE73D2F8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFYSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjFYSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF6EE5B;
        Sun, 25 Jun 2023 11:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7F760C05;
        Sun, 25 Jun 2023 18:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF24C433CC;
        Sun, 25 Jun 2023 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687717510;
        bh=lptCDt96ilGC/OpMciopJy0C4Ydb0tBjW5sqv48x0yI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CeMe1IYvKi0//tHqDJz4UNqUgfOPgj7AYbqJvgjPCN3rAyYeLDIgfgkRHg692DUxO
         ro4TJRdCtCTTN4yh3DAogZlpn6V5lgmjrIxyllncClGuFYjHolKpJoHa+7OOo9fWBJ
         DAj4zIRHcc2Ean4pFspdOQug/ybALtUqSQtlfusjgVsGAC6gqOdx+erxxsMGIJYwCn
         d/mi0m/YvnKSTxbpjSnmpeqSjz9h0G9gtll4PvqldYYPD2iMBZytZUXuCUWuFGsEiC
         m46ZpkOzYjC2BK8ePYqiBupZAnFC4DpZgmQspiYcJq9nQ9EJgurXllS0eU0gH5Jax2
         nt2JZ7Eqs/3sg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-39cc64e4a44so1264031b6e.0;
        Sun, 25 Jun 2023 11:25:10 -0700 (PDT)
X-Gm-Message-State: AC+VfDwKy23XMyOkJ4+3zB3+tQ0ak05sjVUHe1CfteOZ/hYjV9fJxQWb
        vWVGJZLm42pZyIpHHOe6ZG6fxUgVay6yzF4WMek=
X-Google-Smtp-Source: ACHHUZ7ExvMJ0YdgLqIGnfb3fbsDX2rWow9AjMUqHU0+MJx/o9Et46IPBdZvVw/dSRRx08ycUEfVtMrSDl1Gm9EeOnk=
X-Received: by 2002:a05:6808:191f:b0:3a1:dc0d:f31f with SMTP id
 bf31-20020a056808191f00b003a1dc0df31fmr719402oib.3.1687717509553; Sun, 25 Jun
 2023 11:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230615111743.883891-1-masahiroy@kernel.org> <f7e9220aad3d98bd174f7dcbd68031e1e15ea968.1687461492.git.josh@joshtriplett.org>
In-Reply-To: <f7e9220aad3d98bd174f7dcbd68031e1e15ea968.1687461492.git.josh@joshtriplett.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Jun 2023 03:24:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARLti=Cp1WRAzMufXpXLvM=X1WHLN1RT=-ZAc1q06pPcw@mail.gmail.com>
Message-ID: <CAK7LNARLti=Cp1WRAzMufXpXLvM=X1WHLN1RT=-ZAc1q06pPcw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: builddeb: always make modules_install, to install modules.builtin*
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 4:20=E2=80=AFAM Josh Triplett <josh@joshtriplett.or=
g> wrote:
>
> Even for a non-modular kernel, the kernel builds modules.builtin and
> modules.builtin.modinfo, with information about the built-in modules.
> Tools such as initramfs-tools need these files to build a working
> initramfs on some systems, such as those requiring firmware.
>
> Now that `make modules_install` works even in non-modular kernels and
> installs these files, unconditionally invoke it when building a Debian
> package.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---


Applied to linux-kbuild. Thanks.

What I meant in my previous reply was
to remove "if is_enabled CONFIG_MODULES; then"

Anyway, I did it by myself in a follow-up patch.

https://lore.kernel.org/linux-kbuild/20230625181623.2473308-1-masahiroy@ker=
nel.org/T/#u





--=20
Best Regards
Masahiro Yamada
