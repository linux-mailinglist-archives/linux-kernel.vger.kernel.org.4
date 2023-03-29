Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357EE6CCEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC2AW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjC2AWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654A1737;
        Tue, 28 Mar 2023 17:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3492DB81F81;
        Wed, 29 Mar 2023 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C522CC433A7;
        Wed, 29 Mar 2023 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680049369;
        bh=LsCNXXpY1cFgoqXqOINeaOkusUqANiRdFYpk75Ep5Ko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kohoHxDpAa2IveHTr7jy9tKAbRaVBIuF6zCV3lP6pauXbsIULM4TR8vENRdV+sRxi
         s5iplqD8Kf9yZuUxFVFKtOP+MzK3P6mQ+plHNV3Pc1W+xW2+wDzKj3kn/InfhxPQsK
         qHF5hwPbzf6hYqCZkQ1qNCr6cCtoRhmaEbfCKecP408IxUMGZsGvYWXzz4Y1r4iFB1
         9Xot0ltF4q/FhMB1xgQpe0vZApT+GQgGWH02F44s7TDcmGm8Vjo3ijDdx58KOHKl/9
         OEFaINyEJDyfWI7phFuz82Mzxc6RoYHFMGbRoekUSjlXIBwyHNiIM0UvnH7TNu3E80
         Jn7U1RHYAKRxg==
Received: by mail-ed1-f46.google.com with SMTP id y4so56755915edo.2;
        Tue, 28 Mar 2023 17:22:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9eKHwss+occXoM9xv8EadPQtW26OeIzVN2XY2zjcsPsLwHPg0eK
        y/G3ub58DrCYd8a5V6KmxFzjsFUJHiznFPsRpnQ=
X-Google-Smtp-Source: AKy350YShqqhafJiKivPvV3UEwHbIXvSZz7vIGbGfm68OD1wOOOEvCMQ8EQ72tLPfqXEpoJkur924JeuV1TKMI9pjxw=
X-Received: by 2002:a50:a444:0:b0:4fc:6494:81c3 with SMTP id
 v4-20020a50a444000000b004fc649481c3mr8371871edb.1.1680049367907; Tue, 28 Mar
 2023 17:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230328111714.2056-1-zhangqing@loongson.cn> <9817aaa043e9f0ed964bd523773447bd64f6e2c0.camel@xry111.site>
 <1c231587-3b70-22ab-d554-ebe3de407909@loongson.cn>
In-Reply-To: <1c231587-3b70-22ab-d554-ebe3de407909@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 29 Mar 2023 08:22:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5APsBxC8nNa81t3HXum1EU1hOj4S6UC7xLHD7_BCJd7g@mail.gmail.com>
Message-ID: <CAAhV-H5APsBxC8nNa81t3HXum1EU1hOj4S6UC7xLHD7_BCJd7g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 8:15=E2=80=AFPM Qing Zhang <zhangqing@loongson.cn> =
wrote:
>
> Hi, Ruoyao
>
> On 2023/3/28 =E4=B8=8B=E5=8D=887:39, Xi Ruoyao wrote:
> > On Tue, 2023-03-28 at 19:17 +0800, Qing Zhang wrote:
> >
> > /* snip */
> >
> >
> >> -void * __init relocate_kernel(void)
> >> +unsigned long __init relocate_kernel(void)
> >
> > Why we must modify relocate_kernel for KASAN?
>
> When the CONFIG_RANDOMIZE_BASE is enabled, the kernel will be updated to
> a random new address.
> Kasan needs to call kasan_early_init before start_kernel.
> There are two situations:
> 1> After enabling CONFIG_RELOCATABLE, call kasan_early_init.
> 2> After CONFIG_RELOCATABLE is not enabled, call kasan_early_init.
>
> In order to prevent code redundancy and semantic problems caused by
> calling kasan_early_init (before jr a0) at the old PC.
In my opinion, you can call kasan_early_init before relocate_kernel in
head.S, then no redundancy.

Huacai
>
> Thanks,
> -Qing
> >
> >>   {
> >>          unsigned long kernel_length;
> >>          unsigned long random_offset =3D 0;
> >>          void *location_new =3D _text; /* Default to original kernel s=
tart */
> >> -       void *kernel_entry =3D start_kernel; /* Default to original ke=
rnel entry point */
> >>          char *cmdline =3D early_ioremap(fw_arg1, COMMAND_LINE_SIZE); =
/* Boot command line is passed in fw_arg1 */
> >>
> >>          strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
> >> @@ -190,9 +189,6 @@ void * __init relocate_kernel(void)
> >>
> >>                  reloc_offset +=3D random_offset;
> >>
> >> -               /* Return the new kernel's entry point */
> >> -               kernel_entry =3D RELOCATED_KASLR(start_kernel);
> >> -
> >>                  /* The current thread is now within the relocated ker=
nel */
> >>                  __current_thread_info =3D RELOCATED_KASLR(__current_t=
hread_info);
> >>
> >> @@ -204,7 +200,7 @@ void * __init relocate_kernel(void)
> >>
> >>          relocate_absolute(random_offset);
> >>
> >> -       return kernel_entry;
> >> +       return random_offset;
> >
>
