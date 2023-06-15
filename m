Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916D4731CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbjFOPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbjFOPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:44:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C0273E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:44:31 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a4ffe97a88so5141491fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686843870; x=1689435870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4StmFmRajOimzwQuxAIm4oA1Qq+pBLBdDXasM5CJ9r0=;
        b=X9ur/1kQVScMujlfFfp3RRguZGxLCtamV4Mzp2jhXW69XuqY70QQFqj0rNBmgLCsao
         YezKD56/IDNwS0TvAu+X+bUeyOKHcNbo5hcSRIIDiQQNyCaVmT0uSxyHhW15PYIizP0m
         aFyjKgl/6bkcVvtG5PUV5GOXL1+F9NzTfdDE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686843870; x=1689435870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4StmFmRajOimzwQuxAIm4oA1Qq+pBLBdDXasM5CJ9r0=;
        b=AEKSo2HkV5J6tDuSzn3as7OhJRtyUOht96mr0ap6P1s2i/EZUeXiz1z827zdCCLifn
         qrybm5oPtvy2ne9eaZzHGivBKj7rDXgEn05XafS4F1qsgrcstTebd+eGvXYYJcv15p5Q
         9wRqup+XCInxQnnx7c02/qX3aV2TUkxbOU1TnZQDg9NC/OL+DdUBtKb+om0FaeTG3gB2
         +jY3sVLxZ00GfeV51HT5IGFA8lLpgN6mA2S1eDjq1fDNbaGMECNh6kHhnOkaxsnE6QxH
         rPyzuqGy4q6qrvYsD/x6JzYlaiRhhq0v3RC7ynBSdaotktR0E0toBEiGdCFljqZMQPcK
         SWhA==
X-Gm-Message-State: AC+VfDxsZeiIwdTBtCSUDba5pp+FvvoPmpZsziQvH/6SslbD5kT3Zlhn
        4WQ3vfyrFMK6ZpxmsgxRVo9CkH9K2qplnO6UJBrClQ==
X-Google-Smtp-Source: ACHHUZ4XzMRy765MiqkYZk2EQDL/FAz6ib58uJzpHUeyESFt2Ss5dqWqW1EtsOL4TZFKrIHxwhGFu6PjB0MFUoR5V30=
X-Received: by 2002:a05:6870:d450:b0:180:857:d47d with SMTP id
 j16-20020a056870d45000b001800857d47dmr13034116oag.57.1686843870070; Thu, 15
 Jun 2023 08:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org>
In-Reply-To: <20230615145607.3469985-1-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Jun 2023 17:44:18 +0200
Message-ID: <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 4:56=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=3Dy, =
LLVM
> leaves DWARF tags for the "asan.module_ctor" & co symbols.

To be fair I can't tell if this is an LLVM bug. It's sort of curious
that with LLVM_IAS=3D1, these debugging symbols are not kept and they
are with LLVM_IAS=3D0 but I don't know what the expected behavior should
be and how BTF should deal with it. I'll let people with more context
comment on this! :)

An easy reproducer is:

$ touch pwet.c

$ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
$ llvm-dwarfdump pwet.o | grep module_ctor

$ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.o pwet=
.c
$ llvm-dwarfdump pwet.o | grep module_ctor
                DW_AT_name      ("asan.module_ctor")

> In a dramatic turn of event, this BTF verification failure can cause
> the netfilter_bpf initialization to fail, causing netfilter_core to
> free the netfilter_helper hashmap and netfilter_ftp to trigger a
> use-after-free. The risk of u-a-f in netfilter will be addressed
> separately

To be precise, I meant "netfilter conntrack".

I sent the following patch as a more targeted mitigation for the uaf
https://lore.kernel.org/netfilter-devel/20230615152918.3484699-1-revest@chr=
omium.org/T/#u
