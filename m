Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683546D8CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjDFBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjDFBU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:20:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF47281;
        Wed,  5 Apr 2023 18:20:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so145544441edb.11;
        Wed, 05 Apr 2023 18:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680744055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH3Rs9fqZKGlnFqxOfslFshD4wZrOqzKzZhmDdLwBNI=;
        b=Mkgv6CUTV+rqw8YTj3f6WQAnjgu7NIJkGEqJtQbSqrs5nV1SamdJYDE2QPisCIsewN
         hFh8P/x9lIToOnkBA/nZKbw7/YmvAiZZH7QkI9HHQhzJ1y4X+s+njm7RHfRJFdDe8/1h
         UahLLkWFR2W91Tx2lsEPym34HYNnSsr8tWZPIWWZVu1XyHrCXubsNdtDEiNxHlxY0df6
         h9VweBKXwqVMxFAdD38Y2grgQEi2r9kBNnRU2PUSBSnrtHmHJbkPA1eXtfh/apbZ5CDy
         mZCIFVp6LWFnzsf0tHruna/Dl8UT0Q8myC347PuviZKXqJfYvnzWHqlaBesT5zOeNeZk
         ZIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680744055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH3Rs9fqZKGlnFqxOfslFshD4wZrOqzKzZhmDdLwBNI=;
        b=gnDf1Y/AHwP/a567yTA5P5zV8Kgk7uPNqcqhFbpvC7rzyts+idh9Y5WZhhxgIGp6tL
         Jsklm46ywT8UFhLkTjmmJ9WtKT2iUAX+i1bsgLyHcL59vLF3n5mPcvjxP4vpHNlDJrno
         hV7guVA2GaHz/QY6TPXA52rOEgZ1vuDxfntml5LjajJsmjq3crQHkYCi6TEwpeDp02CC
         KHL7tV9d+Jqh/ZfkBP5fAAqYWL0riuAQ90ZLfR/39UnSqcJkGFD0TjP+YuVfii6p4TjP
         fkFFojbGnzXxMK7YF7ixSst4Yfjo9y86o/doludaLeAUOX9hrrHHpplFf8vsVrlF7TkC
         WuZg==
X-Gm-Message-State: AAQBX9cYZOSJg4hd4mp8r425pag0MI2m8UgGvHp7sr0vfQvrYFrnbqzk
        rinQj350DblDasQ+FyEuaA9wzjEM/cxdy9PSGMU=
X-Google-Smtp-Source: AKy350biM468gXNgp+wGWYC9Oa5uV811exUaTO/3HjlgFDhfRzYv9U4zkk80IU7oihDdd/FimHfB35UoxVh0/Fp2I/s=
X-Received: by 2002:a17:907:2112:b0:8ab:b606:9728 with SMTP id
 qn18-20020a170907211200b008abb6069728mr2567760ejb.5.1680744055323; Wed, 05
 Apr 2023 18:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230330110512.549704-1-keguang.zhang@gmail.com> <20230330132404.GA1865737-robh@kernel.org>
In-Reply-To: <20230330132404.GA1865737-robh@kernel.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Thu, 6 Apr 2023 09:20:39 +0800
Message-ID: <CAJhJPsXoB3=G8OapM0SwAxGmNC6fb-kG-M4iYR=Pb3UXfcKwEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Move Loongson1 PWM timer to clocksource framework
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Mar 30, 2023 at 07:05:09PM +0800, Keguang Zhang wrote:
> > Move Loongson1 PWM timer to clocksource framework
> > and update the Kconfig/Makefile options accordingly.
>
> Why?
>
Sorry for the late reply.
The clocksource driver should go to the clocksource framework, right?
The current implementation is outdated.

> What does this have to do with the binding? Did the h/w change? No.
>
No h/w change.
The clocksource driver needs DT support.
Maybe my description is not clear enough.

> >
> > Changelog
> > V2 -> V3: Remove the reference to regs-pwm.h
> > V1 -> V2: Delete the obsolete header file regs-pwm.h
> >
> > Keguang Zhang (3):
> >   MIPS: Loongson32: Remove deprecated PWM timer clocksource
> >   dt-bindings: timer: Add Loongson-1 clocksource
> >   clocksource: loongson1: Move PWM timer to clocksource framework
> >
> >  .../timer/loongson,ls1x-pwmtimer.yaml         |  48 ++++
> >  .../include/asm/mach-loongson32/loongson1.h   |   1 -
> >  .../include/asm/mach-loongson32/regs-pwm.h    |  25 --
> >  arch/mips/loongson32/Kconfig                  |  37 ---
> >  arch/mips/loongson32/common/time.c            | 210 ----------------
> >  drivers/clocksource/Kconfig                   |   9 +
> >  drivers/clocksource/Makefile                  |   1 +
> >  drivers/clocksource/timer-loongson1-pwm.c     | 236 ++++++++++++++++++
> >  8 files changed, 294 insertions(+), 273 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls=
1x-pwmtimer.yaml
> >  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h
> >  create mode 100644 drivers/clocksource/timer-loongson1-pwm.c
> >
> >
> > base-commit: f7b5a248213f0976c7944925f3f3ab7ff199e581
> > --
> > 2.34.1
> >



--=20
Best regards,

Keguang Zhang
