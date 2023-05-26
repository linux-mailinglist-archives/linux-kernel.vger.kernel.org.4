Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA47129F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbjEZPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbjEZPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:53:44 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B993F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:53:43 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565c3aa9e82so2837217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685116422; x=1687708422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHNWypglFrBaHAONb4GVk+RZ2+BY9gUdSLp4oK/sat4=;
        b=ZuIgibDdUs14wP270YPEh/p/HsR40HMlhA/Q4Qb0SZ1zAbAFSxdlveb/A5My/b4B/H
         DnKOdSCSSVGBq2EvxVaNHFaN8dq/26a0nHVa5RLMRjYmhZ3GWjpSMF+Upil84s7PaRb/
         C4Fm8zqOq5i921jdxYkR6EiR9d/lU2I/LSj0ezkhn2iUFoLj71sVslVa4yIubZh8MFhC
         z8JZXTaVj9MMGGK7XfnrH6Eu0Jcw4eruZ+3NEw+rTgtaCr72OhdpLmM3y8wMblP1lggr
         x6PSdhfKc9E0AAtyh1rTV08+Vq/ojdGkTRPhOcP0vaPJT9NU4YC8yBLI4Jt8oU/GL2wJ
         qZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116422; x=1687708422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHNWypglFrBaHAONb4GVk+RZ2+BY9gUdSLp4oK/sat4=;
        b=e10685tIMMv9LM4BxmQhc0LlTzdt52iOemvSsCkY84Q+JfbGa67Eb99+92DTrou4AQ
         G0J1FzaWq0yDjPa2/peV7R+EdouWf1f8S33s+RJmlxX0Ev4St1yPzDAM68YorCWUDoU0
         vcFjyrOX//vCCPgAnPWPOdmWnGGSMtpHk7kAyQJ5ONbZsWu8AXeQ2jvBfB71aaHAmpOU
         W8aoQljxavCWTP0lsjkKQJWz1IkWs1jCTBogZQqZGCforAwM+Qeuo5SMAwPN2ookIonX
         U1uj1S86JKyi7lTGxV6iGh1cFrkSx8Dym/wuLEYvRd6cu+1KWkaWmqt9gAagbwTDzy2P
         aN8w==
X-Gm-Message-State: AC+VfDxxKPbOPj6pOjJannLL+P0Y3jzaFPSy9zcq4gtBIlhfzhZu7sSn
        SNngp8GYVvYQ4VqsZuVMljaIMw2E4hc5wNjhE+debNc=
X-Google-Smtp-Source: ACHHUZ5vL4aAB6sdiCQ4vvQAFPqXSYWYAZjOcZjMWQrMj/WNH0MSK1XLOIe004JJUNkQ+gQy6tSpr/RsDwxFYCUo0js=
X-Received: by 2002:a81:6255:0:b0:561:e944:a559 with SMTP id
 w82-20020a816255000000b00561e944a559mr2784468ywb.31.1685116422519; Fri, 26
 May 2023 08:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230526132806.1475900-1-nik.borisov@suse.com>
In-Reply-To: <20230526132806.1475900-1-nik.borisov@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 26 May 2023 11:53:31 -0400
Message-ID: <CAMzpN2hpzkjPsP8GChmm=LVoM-_f5qjxE6jc-yWUX=qO8o0TNA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry: Disable ia32 syscalls and introduce a boot
 time toggle
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.cz
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

On Fri, May 26, 2023 at 9:50=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
>
> Distributions would like to reduce their attack surface as much as
> possible but at the same time they have to cater to a wide variety of
> legacy software. One such avenue where distros have to strike a balance
> is the support for 32bit syscalls on a 64bit kernel. Ideally the compat
> support should be disabled for the majority of the time, yet in the few
> cases where it might be needed it'd be good if there is some toggle
> which would allow users to turn on back compat support.
>
> This patch aims to cater for this use case by disabling ia32 syscalls
> and introducing a boot time parameter 'ia32_enabled' which if set to
> 'true' brings backs 32bit syscall support.
>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>
> Rather than being a final implementation I'd like this to serve as a conv=
ersation
> starter and agree on a final solution that's acceptable to everyone.
>
>  arch/x86/entry/common.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6c2826417b33..6063727a75fe 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -19,6 +19,7 @@
>  #include <linux/nospec.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
> +#include <linux/init.h>
>
>  #ifdef CONFIG_XEN_PV
>  #include <xen/xen-ops.h>
> @@ -96,6 +97,20 @@ static __always_inline int syscall_32_enter(struct pt_=
regs *regs)
>         return (int)regs->orig_ax;
>  }
>
> +int ia32_enabled =3D 0;
> +
> +static int __init ia32_enabled_parsecmdline(char *arg)
> +{
> +       if (!strcmp(arg, "true"))
> +               ia32_enabled =3D 1;
> +       else
> +               pr_crit("Unsupported ia32_enabled=3D%s, ia32 syscalls dis=
abled\n",
> +                       arg);
> +
> +       return 0;
> +}
> +early_param("ia32_enabled", ia32_enabled_parsecmdline);
> +
>  /*
>   * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
>   */
> @@ -107,7 +122,7 @@ static __always_inline void do_syscall_32_irqs_on(str=
uct pt_regs *regs, int nr)
>          */
>         unsigned int unr =3D nr;
>
> -       if (likely(unr < IA32_NR_syscalls)) {
> +       if (likely(unr < IA32_NR_syscalls) && ia32_enabled) {
>                 unr =3D array_index_nospec(unr, IA32_NR_syscalls);
>                 regs->ax =3D ia32_sys_call_table[unr](regs);
>         } else if (nr !=3D -1) {
> --
> 2.34.1
>

Compat syscalls should be enabled by default (opt-out).  You can't
break a user's working setup by just upgrading the kernel.  Also, it
needs to work for 32-bit kernels, since this code is used by both
native and compat.
