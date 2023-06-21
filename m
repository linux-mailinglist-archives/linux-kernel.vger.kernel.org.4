Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC3738474
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFUNIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjFUNIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:08:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D951739;
        Wed, 21 Jun 2023 06:08:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmP2R0Rwzz4wj7;
        Wed, 21 Jun 2023 23:08:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1687352912;
        bh=zMmz8eNhn1LuA/bMCpwWPyDta4A4p5omDG9jWVnrIhA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IELwl0a2CcWKtHQYpyrr7sFEKemIZwDa+P3WaQzNRjWOBtKHns7YRnhc4zJ61CtTe
         VtiNmWT/MSjxIcsMk0GFLElYIRQShuSOZETFrGgT4P/ghqCTLzPcLsUEq+LB9bTV+G
         ezXrX5eHiHuzHhgKJjcPGV4IhZoXJpyYiZGALWIB3CtTTFesoWwLyio6BWgifN4m/A
         Hc70Kn6muoGgmoZg4dh2jIQMqgSmiTjtGgniOT6wnQEbMbSiAeTGQxJDLRveCIyS/p
         RshmiYJ+tckcsHareuzZsBA7Thn4UtJZrdFKcOpxw0gcOY9CUtwyNJDvio492P5yOT
         3xClQ4DFwCJvg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define
 HARDLOCKUP_DETECTOR_ARCH
In-Reply-To: <20230616150618.6073-7-pmladek@suse.com>
References: <20230616150618.6073-1-pmladek@suse.com>
 <20230616150618.6073-7-pmladek@suse.com>
Date:   Wed, 21 Jun 2023 23:08:26 +1000
Message-ID: <871qi5otdh.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:
> The HAVE_ prefix means that the code could be enabled. Add another
> variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> It will be set when it should be built. It will make it compatible
> with the other hardlockup detectors.
>
> The change allows to clean up dependencies of PPC_WATCHDOG
> and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
>
> As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> on arm, x86, powerpc architectures.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/powerpc/Kconfig | 5 ++---
>  include/linux/nmi.h  | 2 +-
>  lib/Kconfig.debug    | 9 +++++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)

Something in this patch is breaking the powerpc g5_defconfig, I don't
immediately see what though.

../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98handle_backtrace_=
ipi=E2=80=99:
../arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of f=
unction =E2=80=98nmi_cpu_backtrace=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
  171 |         nmi_cpu_backtrace(regs);
      |         ^~~~~~~~~~~~~~~~~
../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98arch_trigger_cpum=
ask_backtrace=E2=80=99:
../arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of f=
unction =E2=80=98nmi_trigger_cpumask_backtrace=E2=80=99; did you mean =E2=
=80=98arch_trigger_cpumask_backtrace=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
  226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_bac=
ktrace_ipi);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         arch_trigger_cpumask_backtrace
cc1: all warnings being treated as errors


cheers
