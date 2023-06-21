Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34C73933A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFUXub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFUXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:50:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C6171C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:50:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311099fac92so7537719f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687391425; x=1689983425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=HZDteg5s2Vpl4Dj3x2y2xDB5nI/Qbe7Mj8TIWbglj/Afe2Df8ThS6myu4ctAr7BySI
         lN6IEuMEfPC2jekn2PiCOzacJ5o3hhPY0TVfjYc90WW++TO4fcWk3jVeIIqDxZW+Ag+v
         3gWB4WdyMMmHkHwc3FuCxBT4mKHgXUkDjtvgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391425; x=1689983425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=aHVhknSbSPbq6OOT4fBGWqC5WdmtYCihivJP7q/6uL2KOc0AK5MOpE++46mg8eMAKt
         vuuHf0fwUqEspYOCk2z4Unt8ME8lKqg2f5Zrmihi2EjQh7PjNWleEroMMNlGDbZEwMqz
         B0pv1PtEnqDe0MSzD6LfLNAG7hHmaxRFuDuGKfaG7/6Hv0I89gPi+4IBme7UR9uBq5lN
         8f0uY36Bf7elGIlrSoLTZdJMWH1fvilWkl4Rq+chrC+xakOIsE53a5e4pbU4rgIkU6ki
         MhZN/DcBwqAFB5jtpmWAisjgsJIfIp5oiP2CYNfEKnVfON7W2WCRkqcRxUaXLRNtt7gf
         hKJA==
X-Gm-Message-State: AC+VfDx/6SG2+6151VWEMBI5Af5QENkzFHe3eXAQcryms74yNj3dQLrn
        pb3ICqt0oHSlSV/aEPgvgpClYew/925vJZZAA7MLA8SR
X-Google-Smtp-Source: ACHHUZ6V7NGmleJ/6OBlGvqXbnNIV7YLoXv18uFifh149UB2TVe1VucB0pdYRtI6AXivpUfNw51zag==
X-Received: by 2002:adf:ee51:0:b0:311:12b0:4b36 with SMTP id w17-20020adfee51000000b0031112b04b36mr14084910wro.58.1687391425375;
        Wed, 21 Jun 2023 16:50:25 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id i9-20020a056402054900b0051873c201a0sm3166068edx.26.2023.06.21.16.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 16:50:25 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so732a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:50:24 -0700 (PDT)
X-Received: by 2002:a50:c35e:0:b0:519:7d2:e256 with SMTP id
 q30-20020a50c35e000000b0051907d2e256mr4978edb.0.1687391424164; Wed, 21 Jun
 2023 16:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-7-pmladek@suse.com>
 <871qi5otdh.fsf@mail.lhotse>
In-Reply-To: <871qi5otdh.fsf@mail.lhotse>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Jun 2023 16:50:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 21, 2023 at 6:08=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Petr Mladek <pmladek@suse.com> writes:
> > The HAVE_ prefix means that the code could be enabled. Add another
> > variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> > It will be set when it should be built. It will make it compatible
> > with the other hardlockup detectors.
> >
> > The change allows to clean up dependencies of PPC_WATCHDOG
> > and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> >
> > As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> > on arm, x86, powerpc architectures.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/powerpc/Kconfig | 5 ++---
> >  include/linux/nmi.h  | 2 +-
> >  lib/Kconfig.debug    | 9 +++++++++
> >  3 files changed, 12 insertions(+), 4 deletions(-)
>
> Something in this patch is breaking the powerpc g5_defconfig, I don't
> immediately see what though.
>
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98handle_backtrac=
e_ipi=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of=
 function =E2=80=98nmi_cpu_backtrace=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>   171 |         nmi_cpu_backtrace(regs);
>       |         ^~~~~~~~~~~~~~~~~
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98arch_trigger_cp=
umask_backtrace=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of=
 function =E2=80=98nmi_trigger_cpumask_backtrace=E2=80=99; did you mean =E2=
=80=98arch_trigger_cpumask_backtrace=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
>   226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_b=
acktrace_ipi);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         arch_trigger_cpumask_backtrace
> cc1: all warnings being treated as errors

Yeah, I can reproduce that.

The problem is that before ${SUBJECT} patch "include/linux/nmi.h"
would include <asm/nmi.h>. Now it won't.

There are a ton of different ways to fix this, but I think the one
that makes sense is to be consistent with other architectures and move
the "arch_trigger_cpumask_backtrace" definitions to asm/irq.h.

https://lore.kernel.org/r/20230621164809.1.Ice67126857506712559078e7de26d32=
d26e64631@changeid

-Doug
