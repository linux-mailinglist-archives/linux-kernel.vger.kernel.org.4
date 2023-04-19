Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F26E7A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjDSNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjDSNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:00:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3FBC17B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:00:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dx24so37414153ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681909241; x=1684501241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwi6q3cu45MnE4kyT4HYhg8YlJb8XVnKZHENVBx9cJw=;
        b=q9bUXYfNIZcsLe55ILrvb+lgpf2Vt3HQWODdgf0HwXP7ruIx5aJKLDRpZMAoNyq2xl
         U2eVXI9moVOcl6M5H7JRZet9WaKzH0hO+Tj42DpFmXmgFhmtz8YBCBdDfJCe54JokDgG
         wyRSar3MYwUSuh6tViOBxFXCKKVqWNv3dyppoCxVS3jIOPiIV+9yKFUV9ck60YZ3uJcq
         3Wu106SGWBD+iAAIAXjJSyPPr8U+xJPEnfvVq78SP8j1CzZg8aRiVfDMtK7rHbhlvJBY
         lxdowrUZ8QV5WqOIvj+2RG4BlGpm4KrXoIe6Yu06Kc71nPndkK7dteYEDLPeQhAPhS3S
         KmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681909241; x=1684501241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwi6q3cu45MnE4kyT4HYhg8YlJb8XVnKZHENVBx9cJw=;
        b=Q/V6yV3dfX+eohVgdLt0Tn9J0pwZCToUxkXwX/BY+B25CujdKINsmVsD/Hsc3/3H+3
         qvb0sUTu8Rh/46cHgVMDChPjeqiD+Hxha6FiXZ0u9WzBp/eKXpeRle9xGN6vLJKqDupv
         nj4ig0pfqBh6IOPEVHOZIK2pPhraUS++kEYFs6M+dJ3Yp9v4tt2PkdSETFuX8YfyVR4q
         SGkLWIOUETOATjrA3KMpH3iLNv56qA/RYB1sJsGOwiCFRQwyLberO165E3PdgaGf5KgV
         V1PBAbA00YxcJ0Sl6yt8e+S7Jy0AkXWgFJacoRYGgJ07WBR2aaa768t9UklZ1SQWKJpp
         2vBg==
X-Gm-Message-State: AAQBX9cafZDfsudZpcLyhGEmyiVEK+HudbVPGvsmRrmDq2IAWeo29svr
        FJXaarsxxwoeH6LI0YL0YpXbuWEC5ArQila7PXVfog==
X-Google-Smtp-Source: AKy350YU7NS8auXb9psE2UrHtL99IMokCu0HrsOfTYc1jzaflfxqtjw+b8TWe/R+fYzLaCBTEQnr/BHby6rHDFe5Pfg=
X-Received: by 2002:a17:907:8a21:b0:94f:3521:396 with SMTP id
 sc33-20020a1709078a2100b0094f35210396mr13023290ejc.23.1681909241003; Wed, 19
 Apr 2023 06:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com>
In-Reply-To: <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com>
From:   Florent Revest <revest@google.com>
Date:   Wed, 19 Apr 2023 15:00:30 +0200
Message-ID: <CALGbS4V+x1JkiPL2o59LgtbSQhzg_RKM5TYE7i7qZx0qz23y-g@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        nathan@kernel.org, trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        "revest@chromium.org" <revest@chromium.org>
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

On Tue, Apr 18, 2023 at 6:28=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Florent

Hi there!

> Joel, Florent is doing some cool stuff with clangd and kernels (check
> out the demo at go/linux-kernel-vscode).  I'm pushing Florent to

Apologies for folks outside Google, this is an internal link to a
kernel dev setup I originally created for myself, then for my team and
apparently more and more people are starting to use it internally. :)
If there's enough appetite for it externally too, I'll try to
open-source it someday. Anyway, in the context of this conversation,
it's just something that uses clangd. :)

> publish some of the cool stuff he's been working on externally because
> it is awesome. ;)
>
> Florent, have you seen any such issues such as what Joel reported below?

Yes, I've seen this problem a bunch of times. Afaiu, Clangd operates
under the assumption that every source file is a valid compilation
unit. My understanding is that it's generally a good practice to keep
things that way and I wouldn't be surprised if the userspace Chrome
code-base Joel saw enforces this (iirc, it's a rule for
Google-internal C++ too, all headers must be interpretable
independently).

However, from the perspective of the C spec, anything can be included
anywhere and a C file can only make sense if it's included
after/before certain other things are defined/included. Spontaneously,
I would call these ".inc" rather than ".h" or ".c" because I would
expect a source file to be always valid and this suffix makes it
clearer they depend on their context, but as a matter of fact source
files that don't compile when interpreted individually are quite
common in the kernel tree. Other examples that have been reported to
me include a lot of kernel/sched/*, since many of these files
(including .c files) are included from kernel/sched/build_policy.c in
a specific order to form one big compilation unit.

Unfortunately, I don't know of any solution. :( This feels like a
limit of C or compile_commands.json to me. "compile commands" can not
be enough to interpret any file, clangd would need a way to express
"interpret this file as if it were included in that spot of that
compilation unit" and maybe even need a bunch of heuristics to choose
one such include spot.

I don't know if clangd has any plan to address this and so far I've
just lived with these error squiggles.
