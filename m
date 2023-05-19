Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9B709EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjESSDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjESSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:03:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD7F107;
        Fri, 19 May 2023 11:03:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so3934914e87.1;
        Fri, 19 May 2023 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519397; x=1687111397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khFg+a2ReqaiRTxpoq6SkxqkDB49wgafJiFpqI5YKbQ=;
        b=PeoHFGMqx/4ake57D2CCDDH+d94OtdA/5oF9fjO3V0hsfCJu32yUHrMCcZ4y4KwKwg
         oNkpMOoOmUw0Hun067YjyZM2WAgdP7+OTdw/U26KOuoUSv51KCJrYIoiGVaHJRP/NZwT
         bRNt6adNtfwgtoFZEjlk8VeOPJLo7EuGrnldrRSEJogdAvzzL+qWs1QCzdsmQT4qRIt6
         PwIrE+1dqqDLwfj9UNRAFiKeGDO8DbuNGsqVSxaxEHpKJoG+Q02Cvjhhu0PfS30Rq/Gh
         OAa1QURm3yEGqA6SkZ6LdszMWgTrJce9oEj3bKMb+Cew4SPUWdgQ4w/Tt6cncRdC2bqs
         +jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519397; x=1687111397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khFg+a2ReqaiRTxpoq6SkxqkDB49wgafJiFpqI5YKbQ=;
        b=N6TSwTU6eK9SL9duksAEpm75Fi+7uvk/wx4PQ5GkRuh/wihpfu88SJhwgbFAomr9U8
         i3GRH9XKmpt4Uhz7bcdd53rzC04b6YDU0YiFAmnz7rP9XDa7aFntXetWLrwmaiHLc3Qx
         HCMGmNlCiHGCwZqqoFA7+AUdEqyQ5tr8+fmR8HTanPP6nzLEFn002ZTYYs9R5xvnKZ5u
         lAnHgrmenqhGMqZWBZLl7K0xuGyG4k+0FVacQX1dqL+Bb3alcIxLfxirEEtOhppF4t64
         J9VyonJ2mMTiRz/uVPHI6kHo+QJ2ksVIGfYwYhH6OTx4A82yTvWWu9gvQH2WcKtdmise
         4QcA==
X-Gm-Message-State: AC+VfDzLZZv4SEg79ee8Q5NCMy4D8uGx1A6Vun+p11QnItwd8092smql
        9jUCKtH161p7T99oBeft2j5Ph1CcjYlnDAxrLFjkuEiL
X-Google-Smtp-Source: ACHHUZ5c2K26pp+aHKpDrTfilVtVngVk3N5Rssi8pdIxz/72es30cg9wfp+NaLDsgvIZSZOxCwQRkGa8HO6Jtn5tvQ4=
X-Received: by 2002:a05:6512:510:b0:4f3:8196:80c8 with SMTP id
 o16-20020a056512051000b004f3819680c8mr1047319lfb.1.1684519396705; Fri, 19 May
 2023 11:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230518102528.1341-1-will@kernel.org>
In-Reply-To: <20230518102528.1341-1-will@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 19 May 2023 11:03:05 -0700
Message-ID: <CAADnVQKh7GYfbvZ1vyY93DcpyKzoUHozmYTV360_0LFrNYUiog@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix mask generation for 32-bit narrow loads of
 64-bit fields
To:     Will Deacon <will@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Andrey Ignatov <rdna@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 3:25=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> A narrow load from a 64-bit context field results in a 64-bit load
> followed potentially by a 64-bit right-shift and then a bitwise AND
> operation to extract the relevant data.
>
> In the case of a 32-bit access, an immediate mask of 0xffffffff is used
> to construct a 64-bit BPP_AND operation which then sign-extends the mask
> value and effectively acts as a glorified no-op. For example:
>
> 0:      61 10 00 00 00 00 00 00 r0 =3D *(u32 *)(r1 + 0)
>
> results in the following code generation for a 64-bit field:
>
>         ldr     x7, [x7]        // 64-bit load
>         mov     x10, #0xffffffffffffffff
>         and     x7, x7, x10
>
> Fix the mask generation so that narrow loads always perform a 32-bit AND
> operation:
>
>         ldr     x7, [x7]        // 64-bit load
>         mov     w10, #0xffffffff
>         and     w7, w7, w10
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
> Cc: Andrey Ignatov <rdna@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context=
 fields")
> Signed-off-by: Will Deacon <will@kernel.org>

Thanks for the fix! Applied to bpf tree.
