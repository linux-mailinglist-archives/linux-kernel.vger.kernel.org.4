Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619D870C548
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjEVShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEVShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:37:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B023FE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:37:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f389c21fe8so29540431cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684780657; x=1687372657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE1YGTh9d+XFdvUdt9kLMAcbrISnJqMCKvDPYim3xk0=;
        b=n2/HPeqVEZWy94HrQrqzpMVvrl8ot28r4dGOugqG0lH3NmFZPilmgiPUXx/ZmabsCE
         pZZO+fv+LxjFa/JcmhLZrxIVO9tlxxyNJmppY8JIpZduWebGSB9u/e6ByyFEPx0eJXk9
         e9fzE7yTHOyOeqBrK2VCPLjmlU/sV5fC+7pgN18LadnrXNr5+ehBkOhf+4f2R5wYNVkr
         0+NwRHlKqDuN+rTSBvMWsG97KbmkoTistkEe4sBHKJ7PQqzSINJiwobu3NUBqGPBvYTV
         qOrsPSRCciGjoYRy/jvs7UKjSEdacvD2yV+nPEg6kOsEZTc4XoJ7zOG+5F8pI0XAaz6/
         sV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780657; x=1687372657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE1YGTh9d+XFdvUdt9kLMAcbrISnJqMCKvDPYim3xk0=;
        b=YT3CY6zvpaeVaJs1acQM8w7OeaptMRL8OHffrSU7DQfUrV6GjMdfZwkSLTdUFFRbKq
         tsP7w70sGxuVC317ICyt8scN1yU+3EpVgaHVzyK/Grg2kondI2G0vuGvEtujnQjbDMO7
         xhSKkle2ymtbqeWqARP3c4xPkg3TeNTTUm4vbWAZPf7k4TcX7HDgKfI/UsWZeA/G8mqG
         +bgJxl45MpFq8tOi+E+tgnRBe90lEGeV1lIKAK2w3altoO1mLKj2o51YStfxD7L6Pcqp
         UgwIdr+b/atFA8lt/sIqL6LrLySpuiWhb+2jXhHR/VDEfWQCKMG3QWX43GhoNnpgkhvT
         FGGw==
X-Gm-Message-State: AC+VfDwZ+T+pn/LSDLMfL5M96ILP4d4vZJ+MXl4M8ZlgNATnEFx7eqCL
        5EP0l7bSmXw6/+Hu6LP2+iAN3yq+fmNRN17w+Aq0lQ==
X-Google-Smtp-Source: ACHHUZ6Rk6oINXBumC91jfi1Bk3n+Xl0Ur5oT2V+khLVw4FLlQUt8KN9UKD2SJZMHH4eDVe+WuyTAUs9CW6+i0jXomU=
X-Received: by 2002:a05:622a:85:b0:3f5:3659:4901 with SMTP id
 o5-20020a05622a008500b003f536594901mr19532832qtw.20.1684780657335; Mon, 22
 May 2023 11:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUSe78ip=wkHUSz3mBFMcd-LjQAnByuJm1Oids5GSRm-J-dzA@mail.gmail.com>
In-Reply-To: <CAEUSe78ip=wkHUSz3mBFMcd-LjQAnByuJm1Oids5GSRm-J-dzA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 11:37:26 -0700
Message-ID: <CAKwvOdn3ngS101Y8DiBQgmw4K8kEX+ibGeXYBwTRVLT59q6wsw@mail.gmail.com>
Subject: Re: Stable backport request: skbuff: Proactively round up to kmalloc
 bucket size
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        rientjes@google.com, vbabka@suse.cz,
        Sumit Semwal <sumit.semwal@linaro.org>,
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

On Mon, May 22, 2023 at 11:24=E2=80=AFAM Daniel D=C3=ADaz <daniel.diaz@lina=
ro.org> wrote:
>
> Hello!
>
> Would the stable maintainers please consider backporting the following
> commit to the 6.1? We are trying to build gki_defconfig (plus a few

Does android's gki_defconfig fail to boot on the `android14-6.1`
branch of https://android.googlesource.com/kernel/common?

(i.e. downstream branch from linux stable's linux-6.1.y)?

We just ran CI successfully on that branch 10 hours ago.
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/504=
2504560/jobs/9045030265

Do you have more information on the observed boot failure? (panic splat?)

> extras) on Arm64 and test it under Qemu-arm64, but it fails to boot.
> Bisection has pointed here.
>
> We have verified that cherry-picking this patch on top of v6.1.29
> applies cleanly and allows the kernel to boot.
>
> commit 12d6c1d3a2ad0c199ec57c201cdc71e8e157a232
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Oct 25 15:39:35 2022 -0700
>
>     skbuff: Proactively round up to kmalloc bucket size
>
>     Instead of discovering the kmalloc bucket size _after_ allocation, ro=
und
>     up proactively so the allocation is explicitly made for the full size=
,
>     allowing the compiler to correctly reason about the resulting size of
>     the buffer through the existing __alloc_size() hint.
>
>     This will allow for kernels built with CONFIG_UBSAN_BOUNDS or the
>     coming dynamic bounds checking under CONFIG_FORTIFY_SOURCE to gain
>     back the __alloc_size() hints that were temporarily reverted in commi=
t
>     93dd04ab0b2b ("slab: remove __alloc_size attribute from
> __kmalloc_track_caller")
>
>     Cc: "David S. Miller" <davem@davemloft.net>
>     Cc: Eric Dumazet <edumazet@google.com>
>     Cc: Jakub Kicinski <kuba@kernel.org>
>     Cc: Paolo Abeni <pabeni@redhat.com>
>     Cc: netdev@vger.kernel.org
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: David Rientjes <rientjes@google.com>
>     Acked-by: Vlastimil Babka <vbabka@suse.cz>
>     Link: https://patchwork.kernel.org/project/netdevbpf/patch/2022102123=
4713.you.031-kees@kernel.org/
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>     Link: https://lore.kernel.org/r/20221025223811.up.360-kees@kernel.org
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
>
> Thanks and greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org



--=20
Thanks,
~Nick Desaulniers
