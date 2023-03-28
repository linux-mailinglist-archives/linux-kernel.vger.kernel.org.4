Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457E6CCDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1Wyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC1Wym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:54:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B642110
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:54:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a11so14207629lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680044079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQYGlpoRo1xAwVZPEjjkyX2GN+AkTkrmM4VsIqlC63Q=;
        b=hEDALw7vFU3va/s2tPcKbQO9CLwqO9q5v5uWuTq2vrfjEek2ZVqY0WYm5we6BTZEIl
         1agBVKGbeWNEETZHhj05FgIedv7+iusFiVTkHSUHaujrImhB9ViRVSASouqDwy+IsuZR
         0NPdygmgdleGaozVT4yfMj2G25oqFbxEv8FJohz7LOq8GIwpsYbMHcCiOERaRD3hiRp/
         VgMUoAqoieYWDxwaU0wzWiWVqNosIqmfgxxZldKhotidSP4I324OqFeByF5viJnKz2ym
         XGXUmMZoDKzYIwPYqMoNTvgjaoCC5916l5n2N/ZeXdi5S4HSNm+8dnTTfpzhxrSpaOvA
         7HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680044079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQYGlpoRo1xAwVZPEjjkyX2GN+AkTkrmM4VsIqlC63Q=;
        b=5qBboKtWEpKqLAceKOujMY/JT0Ue9LnuKiE0/buvg7gJg0GGoafYU7F0idfXovm5fE
         ErTH3pe2hEksdGLO35N7Wa/ur+kPtdG9ibJy8EsbQiuWR2O/wxLqDW7lSmCcNUU3I4Uq
         JkoL3kCvmz6WyjcwGuqUoGGdsmBMDtYq90LxuPgJIP3IpS/3obwqqw8qFqOq7PJcBdKp
         SaJpHJo1/YIyL7MBP7et53ecqYMQOWtYVpdHMQvH4C298Sh8DusZAuASM8nh9WMsams2
         eMnTMs7ucwwflnTjudo480U8mzFIw4xWixAFYBTuGIqiEX2IPd3q6RkuabKc54Ylfuy/
         jBVg==
X-Gm-Message-State: AAQBX9exx44Xz0+15eXbkk67dntFtGqOksGjsIX31h9KqD6gM2vEZp8J
        gs+ayijLo0lO2QcOMbWCzMHl8za4ufmCEA/AgkKkaQ==
X-Google-Smtp-Source: AKy350Y5TFzrIJsXARd1vQbyj0sEWRDRlKxH3oCr7ze3JctueqdMfYeUkP6IeAd3Df0QKFBZ10sfWV0EEU6xl+gW+I4=
X-Received: by 2002:a2e:6a17:0:b0:298:b375:ace9 with SMTP id
 f23-20020a2e6a17000000b00298b375ace9mr5186560ljc.9.1680044079673; Tue, 28 Mar
 2023 15:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230327163203.2918455-1-evan@rivosinc.com> <d47020f9-e5a8-4ef3-94bc-6aa6f6b2465c@spud>
In-Reply-To: <d47020f9-e5a8-4ef3-94bc-6aa6f6b2465c@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 28 Mar 2023 15:54:03 -0700
Message-ID: <CALs-HsvvKSCKzPZ8e9xst=vKOZHuByDHm5WHaE8mz66_WFMKkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] RISC-V Hardware Probing User Interface
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:34=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Mon, Mar 27, 2023 at 09:31:57AM -0700, Evan Green wrote:
>
> Hey Evan,
>
> Patchwork has a rake of complaints about the series unfortunately:
> https://patchwork.kernel.org/project/linux-riscv/list/?series=3D734234
>
> Some of the checkpatch whinging may be spurious, but there's some
> definitely valid stuff in there!
>
> > Evan Green (6):
> >   RISC-V: Move struct riscv_cpuinfo to new header
> >   RISC-V: Add a syscall for HW probing
> >   RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
> >   RISC-V: hwprobe: Support probing of misaligned access performance
> >   selftests: Test the new RISC-V hwprobe interface
>
> >   RISC-V: Add hwprobe vDSO function and data
>
> And this one breaks the build for !MMU kernels unfortunately.

Drat! Ok, thanks for the heads up. I'll go track these down.
-Evan
