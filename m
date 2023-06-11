Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11DC72B27E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFKPe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38799E46;
        Sun, 11 Jun 2023 08:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F07615BF;
        Sun, 11 Jun 2023 15:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157FDC433EF;
        Sun, 11 Jun 2023 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686497663;
        bh=ULeZJLU/GmS4WRNfZNRP8NWRGEEQQ/Vq8F7kRZzoTqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LqU8c0izwphg14GwQgarPpG5rZvPDbEmZ+lT8aIev8kiD7a1PCWsKhd7j+peBH7is
         EPx0s5tw0tGb1rGfwumBZxU8GWE0Dkb1LsTfSSiTiAHrH6zyNIuKb86/PBDHjWw9QJ
         La3+uoM5j2/OCxbiU6Gf4WTCH/qsfLJ3jHHgCsh7omFDtTEtEo0JWVO/ynzIAZ1R7n
         Z3FMKybudGOWAgfOOZ1NzFJPoTCuVXuvYk3vIVBOfqol9vnxM7jVAY/elYzt+Y8XGz
         QEIuA+dvQhUMjFIBJpuQN7OURwUUBE7j2hvSUanocFecD/lN4UWr/Bxy6R245fTf/U
         ZmPxs1rboxsJQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-55ab0f777acso1858778eaf.1;
        Sun, 11 Jun 2023 08:34:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwfBN6NdkiMettveOI/J5pCjYJaosuVNexiZEVWeWQsnaka4tN
        Vwa7z6qUEGWr7yXJB3caK3r3WuGbKdD8wEqur6w=
X-Google-Smtp-Source: ACHHUZ53qqeXZwwksu5kVuEQj8L61X5M9M2wpkBjXB6IrtTiV3Y2mbUh+j/IjJVc3CvPNx7bWb0abmPc986K40goUKg=
X-Received: by 2002:a05:6808:59:b0:38e:eaf:cf16 with SMTP id
 v25-20020a056808005900b0038e0eafcf16mr2020632oic.54.1686497662298; Sun, 11
 Jun 2023 08:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230610091320.1054554-1-masahiroy@kernel.org>
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 12 Jun 2023 00:33:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBVqdWgsPOwGJu87AKNVZvnWjL-bBJ3xJ-2w+fpidZZA@mail.gmail.com>
Message-ID: <CAK7LNARBVqdWgsPOwGJu87AKNVZvnWjL-bBJ3xJ-2w+fpidZZA@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Unify <linux/export.h> and <asm/export.h>,
 remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 6:13=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
>
> This patch set refactors modpost first to make it easier to
> add new code.



Only the first patch was applied.
(https://patchwork.kernel.org/project/linux-kbuild/patch/20230610091320.105=
4554-2-masahiroy@kernel.org/)


I will send v9 for the rest because
the 0day bot reported a couple of issues.









--=20
Best Regards
Masahiro Yamada
