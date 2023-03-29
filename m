Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB366CD0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjC2DxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2DxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:53:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928D30F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:52:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so14277013wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680061952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxGaqLyKO1TN0pSBe4xZ3Bl0DqqI6clzZtcK/yjTF7U=;
        b=Bg6O58r7hoxolYUP1MmFER3k3jKGZGxL4khw0OL6OElNmfbPi6G/IugpY79p8r2NQC
         Ix0IOyILyuOfKT8r1+tse0+BW5VOKD3SofIWK50yyjF1ywrvY8OcMsjZ8LXGGn2AQuKh
         7PgD69LIPjUrG1SS98FPfbhCpqqodi2fWRwda0BvQ70uKepeVqvqSxDUOdSTc49Qt0mf
         sQYFY1V+gHsec7OuksjC6rBWNtM0Yv89y6wXTFkKW/X31UHnJOHoi95A7mFLwjmzBhWp
         EoMUvqJGe8dyTgmuAi9r3TxKdWq7eW85N2jRTDGnaqKvkfD+Fw1fofX8OYvMvh3I5WvZ
         ME4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxGaqLyKO1TN0pSBe4xZ3Bl0DqqI6clzZtcK/yjTF7U=;
        b=L1okUIUTelEwRpR9X6RDAW1Y2/CVMWok1M3dfrFEqewpEwIST1wmmFFGOBHCR58kIv
         ho1ejJuFwQ8Elvfta3SWxEW1+RbDfHRe5HQvJf7cQb1cBKtTeLdcPFYl87WMzoE7kHpe
         flgS83MLklZFmo3DdWnTqqxbllAqCxJY14jepdosunU5EYJZu3oMUHm6We618c60rZ/7
         X6fNiqF3ZuhjqbS66/oeU8/0La1I99Nyyu+MeCuOb/4oXTf5AKo6r6zMJRbW/18KBBeh
         Ve9VDt9yUB26psMqvoCgZiDyeyv5xZ01saACwog3NkL6jvBLHBzWxTo5SDn9hSq53WFs
         NATA==
X-Gm-Message-State: AAQBX9fUoVRur7cn+MxYrfg03Q4j8y3ohzfPoRlHU8LreTMV31FDhvss
        kOdjuRlxulGrVSyNsvaS9K9BcZT5a4NAJcxIVLK0XLzbLLImTjbc2a0=
X-Google-Smtp-Source: AKy350ZJEKNgAfeLl8iFYh0WtB68/u80mVXbwZzO4ynTLgaC60l429Z+cbqfWCRLLGb09urTuZTRPLBtBV3NpOHVPk8=
X-Received: by 2002:adf:db4b:0:b0:2ce:ac97:6f51 with SMTP id
 f11-20020adfdb4b000000b002ceac976f51mr2959523wrj.13.1680061952265; Tue, 28
 Mar 2023 20:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230327115642.1610-1-cuiyunhui@bytedance.com> <d7111158-7e17-4c88-a8c1-a568db5891fa@spud>
In-Reply-To: <d7111158-7e17-4c88-a8c1-a568db5891fa@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 29 Mar 2023 11:52:21 +0800
Message-ID: <CAEEQ3wkKr9NhKwo0O3D=pfi80j7-cup3VgaWuk8vdk87=ryy6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv/fault: Dump user opcode bytes on
 fatal faults
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Mar 29, 2023 at 1:03=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:

> riscv/fault: Dump user opcode bytes on fatal faults
>
> I think you can drop the /fault, we don't usually use prefixes that like
> for RISC-V.
>
ok, i'll update it on v2


> > In this way, we found the problem: in the system bringup , it is
> > precisely that we have not enabled the floating point function.
>
> What do you mean by that "have not enabled the floating point function"?

The related cpu feature(COMPAT_HWCAP_ISA_F) is not enabled in the
riscv_fill_hwcap function interface.


> > So when an exception occurs, it is necessary to dump the instruction
> > that caused the exception, like x86/fault (ba54d856a9d8).
>
> That's not the usual format for referring to commits, checkpatch should
> complain about that.

ok, i'll update it on v2.

> >
> > Logs:
> > [    0.822481] Run /init as init process
> > [    0.837569] init[1]: unhandled signal 4 code 0x1 at 0x000000000005e0=
28 in bb[10000+5fe000]
> > [    0.932292] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00048-g4=
a843c9043e8-dirty #138
>
> 5.14-rc4?, oof! Need to get yourself onto a released, LTS kernel I
> think!

Just a print,v6.3-rc1 also has this problem.

>
> Anyway, this patch doesn't apply to either riscv/for-next, riscv/fixes
> or v6.3-rc1. What is the appropriate base to apply this patch?

ok, i'll update it on v2.


> > [    0.936073]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000000=
0000000000
> > [    0.936495]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000000=
0000000000
> > [    0.936947]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000000=
0000000000
> > [    0.937487]  s11: 0000000000d14980 t3 : 0000000000000000 t4 : 000000=
0000000000
> > [    0.937954]  t5 : 0000000000000000 t6 : 0000000000000000
> > [    0.938510] status: 0000000200000020 badaddr: 00000000f0028053 cause=
: 0000000000000002
>
> I have no idea what the significance of this particular backtrace is,
> could you elaborate on what this is demonstrating? (and drop the leading
> [###] too as it doesn't exactly add anything!

The current call trace does not show the instruction that caused the
exception. ok, I'll remove it on v2.
